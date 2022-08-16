Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E452595D59
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 15:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiHPNaH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 09:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbiHPNaG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 09:30:06 -0400
Received: from out20-169.mail.aliyun.com (out20-169.mail.aliyun.com [115.124.20.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F837B7ED8
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 06:29:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04524814|-1;BR=01201311R201S52rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.123034-0.000164397-0.876801;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.Oum8r.I_1660656593;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Oum8r.I_1660656593)
          by smtp.aliyun-inc.com;
          Tue, 16 Aug 2022 21:29:54 +0800
Date:   Tue, 16 Aug 2022 21:29:56 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: round down stripe size and chunk size to pow of 2
In-Reply-To: <3f2bfdc4-9561-bee4-d2ef-98617c258b87@gmx.com>
References: <20220816014603.1247-1-wangyugui@e16-tech.com> <3f2bfdc4-9561-bee4-d2ef-98617c258b87@gmx.com>
Message-Id: <20220816212956.FF93.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On 2022/8/16 09:46, Wang Yugui wrote:
> > In decide_stripe_size_regular(), when new disk is added to RAID0/RAID10/RAID56,
> > it is better to alloc/reuse the free space if stripe size is kept or
> > changed to 1/2. so stripe size and chunk size of pow of 2 will be more
> > friendly.
> >
> > Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
> > ---
> >   fs/btrfs/volumes.c | 20 +++++++++-----------
> >   1 file changed, 9 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 6595755..fab9765 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -5083,9 +5083,9 @@ static void init_alloc_chunk_ctl_policy_regular(
> >   	if (ctl->type & BTRFS_BLOCK_GROUP_SYSTEM)
> >   		ctl->devs_max = min_t(int, ctl->devs_max, BTRFS_MAX_DEVS_SYS_CHUNK);
> >
> > -	/* We don't want a chunk larger than 10% of writable space */
> > -	ctl->max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
> > -				  ctl->max_chunk_size);
> > +	/* We don't want a chunk larger than 1/8 of writable space */
> 
> For the 1/8 change I'm completely fine.
> 
> > +	ctl->max_chunk_size = min_t(u64, ctl->max_chunk_size,
> > +			rounddown_pow_of_two(fs_devices->total_rw_bytes >> 3));
> 
> But I'm not sure if there is any benefit for the extra
> dounwdown_pow_of_two().
> 
> Our chunk size doesn't really need to be power of 2 at all.
> 
> Any extra explanation on why power of 2 chunk size has any benefit?

Becasue stripe_size is roundup_pow_of_two()/rounddown_pow_of_two() later,
so real chunk size is roundup_pow_of_two() * N /rounddown_pow_of_two()
* N.

Here we get max_chunk_size base on  pow of 2 too, so that in
single/RAID1 profile,  max_chunk_size and chunk size will be same.

> >   	ctl->dev_extent_min = BTRFS_STRIPE_LEN * ctl->dev_stripes;
> >   }
> >
> > @@ -5143,10 +5143,9 @@ static void init_alloc_chunk_ctl_policy_zoned(
> >   		BUG();
> >   	}
> >
> > -	/* We don't want a chunk larger than 10% of writable space */
> > -	limit = max(round_down(div_factor(fs_devices->total_rw_bytes, 1),
> > -			       zone_size),
> > -		    min_chunk_size);
> > +	/* We don't want a chunk larger than 1/8 of writable space */
> > +	limit = max_t(u64, min_chunk_size,
> > +		rounddown_pow_of_two(fs_devices->total_rw_bytes >> 3));
> >   	ctl->max_chunk_size = min(limit, ctl->max_chunk_size);
> >   	ctl->dev_extent_min = zone_size * ctl->dev_stripes;
> >   }
> > @@ -5284,13 +5283,12 @@ static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl,
> >   	 */
> >   	if (ctl->stripe_size * data_stripes > ctl->max_chunk_size) {
> >   		/*
> > -		 * Reduce stripe_size, round it up to a 16MB boundary again and
> > +		 * Reduce stripe_size, round down to pow of 2 boundary again and
> >   		 * then use it, unless it ends up being even bigger than the
> >   		 * previous value we had already.
> >   		 */
> > -		ctl->stripe_size = min(round_up(div_u64(ctl->max_chunk_size,
> > -							data_stripes), SZ_16M),
> > -				       ctl->stripe_size);
> > +		ctl->stripe_size = min_t(u64, ctl->stripe_size,
> > +			rounddown_pow_of_two(div_u64(ctl->max_chunk_size, data_stripes)));
> 
> I think this can even be problematic since now stripe_size can be much
> smaller than what we want.
> 
> Thanks,
> Qu

rounddown_pow_of_two() is at least > round_up(,SZ_16M) * 0.5,
so it is not too much smaller.

But  roundup_pow_of_two() match with orig round_up(,SZ_16M)
better than rounddown_pow_of_two().

It will be changed to roundup_pow_of_two() in v2.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/08/16


