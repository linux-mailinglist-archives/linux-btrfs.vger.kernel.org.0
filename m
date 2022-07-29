Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D554A584AC7
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jul 2022 06:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbiG2EpF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jul 2022 00:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiG2EpE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jul 2022 00:45:04 -0400
Received: from out20-13.mail.aliyun.com (out20-13.mail.aliyun.com [115.124.20.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864FA7A500
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Jul 2022 21:44:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0443862|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.231973-8.21008e-05-0.767945;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.OgUe1gd_1659069891;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.OgUe1gd_1659069891)
          by smtp.aliyun-inc.com;
          Fri, 29 Jul 2022 12:44:52 +0800
Date:   Fri, 29 Jul 2022 12:44:53 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     dsterba@suse.cz, Stefan Roesch <shr@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v6 1/4] btrfs: store chunk size in space-info struct.
In-Reply-To: <20220729111400.658E.409509F4@e16-tech.com>
References: <20220729100530.32AB.409509F4@e16-tech.com> <20220729111400.658E.409509F4@e16-tech.com>
Message-Id: <20220729124452.A58B.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I'm sorry that this folded patch is wrong.

because init_alloc_chunk_ctl() is not called in btrfs mount stage.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/07/29

> Hi,
> 
> attachement file(folded-v3.patch):
> 
> changes since v2:
>    move the caller of btrfs_update_space_info_chunk_size() into init_alloc_chunk_ctl();
>    drop the added check of BTRFS_MAX_DEVS_SYS_CHUNK,  that check is already done
> 
> changes since v1:
>    move ASSERT(space_info) into btrfs_update_space_info_chunk_size();
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/07/29
> 
> > Hi,
> > 
> > attachement file(folded-v2.patch):
> > 
> > changes:
> >    move ASSERT(space_info) into btrfs_update_space_info_chunk_size();
> > 
> > Best Regards
> > Wang Yugui (wangyugui@e16-tech.com)
> > 2022/07/29
> > 
> > > Hi,
> > > 
> > > I tried to fold my fix/comment into the attachement file(folded.patch).
> > > 
> > > Just the following is new, others are just orig feature or refactor.
> > > 
> > > +	if(ctl->max_stripe_size > ctl->max_chunk_size)
> > > +		ctl->max_stripe_size = ctl->max_chunk_size;
> > > 
> > > Best Regards
> > > Wang Yugui (wangyugui@e16-tech.com)
> > > 2022/07/29
> > > 
> > > > On Tue, Jul 26, 2022 at 06:25:38AM +0800, Wang Yugui wrote:
> > > > > > On Sat, Jul 23, 2022 at 07:49:37AM +0800, Wang Yugui wrote:
> > > > > > > In this patch, the max chunk size is changed from 
> > > > > > > BTRFS_MAX_DATA_CHUNK_SIZE(10G) to SZ_1G without any comment ?
> > > > > > 
> > > > > > The patch hasn't been merged, the change from 1G to 10G without proper
> > > > > > evaluation won't happen. The sysfs knob is available for users who want
> > > > > > to test it or know that the non-default value works in their
> > > > > > environment.
> > > > > 
> > > > > this patch is in misc-next( 5.19.0-rc8 based, 5.19.0-rc7 based) now.
> > > > > 
> > > > > 5.19.0-rc8 based:
> > > > > f6fca3917b4d btrfs: store chunk size in space-info struct
> > > > >
> > > > > The sysfs knob show that current default chunk size is 1G, not 10G as
> > > > > older version.
> > > > 
> > > > So there are two things regarding chunk size, the default size and that
> > > > it's settable by user (with some limitations). I was replying to the
> > > > default size change while you are concerned about the max_chunk_size.
> > > > 
> > > > You're right that the value changed in the patch, but as I'm reading the
> > > > code it should not have any effect. When user sets a value in
> > > > btrfs_chunk_size_store() it's limited inside the sysfs handler to the
> > > > 10G. Also there are various adjustments when the chunk size is
> > > > initialized (init_alloc_chunk_ctl_policy_regular).
> > > > 
> > > > The only difference I can see comparing master and misc-next is in
> > > > decide_stripe_size_regular()
> > > > 
> > > > 5259         /*
> > > > 5260          * Use the number of data stripes to figure out how big this chunk is
> > > > 5261          * really going to be in terms of logical address space, and compare
> > > > 5262          * that answer with the max chunk size. If it's higher, we try to
> > > > 5263          * reduce stripe_size.
> > > > 5264          */
> > > > 5265         if (ctl->stripe_size * data_stripes > ctl->max_chunk_size) {
> > > > ^^^^
> > > > 5266                 /*
> > > > 5267                  * Reduce stripe_size, round it up to a 16MB boundary again and
> > > > 5268                  * then use it, unless it ends up being even bigger than the
> > > > 5269                  * previous value we had already.
> > > > 5270                  */
> > > > 5271                 ctl->stripe_size = min(round_up(div_u64(ctl->max_chunk_size,
> > > > 5272                                                         data_stripes), SZ_16M),
> > > > 5273                                        ctl->stripe_size);
> > > > 5274         }
> > > > 
> > > > Here it could lead to a different stripe_size when max_chunk_size would
> > > > be 1G vs 10G, though the other adjustments could change the upper value.
> > > 
> > 
> 


