Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D5476C154
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 02:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjHBAFC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 20:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHBAFB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 20:05:01 -0400
Received: from out28-82.mail.aliyun.com (out28-82.mail.aliyun.com [115.124.28.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79D91BF1
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 17:04:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05791021|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.226583-0.00271313-0.770704;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.U6FjzhK_1690934692;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.U6FjzhK_1690934692)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 08:04:56 +0800
Date:   Wed, 02 Aug 2023 08:04:57 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Christoph Hellwig <hch@lst.de>
Subject: Re: btrfs write-bandwidth performance regression of 6.5-rc4/rc3
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <20230801155649.GA13009@lst.de>
References: <20230801235123.B665.409509F4@e16-tech.com> <20230801155649.GA13009@lst.de>
Message-Id: <20230802080451.F0C2.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On Tue, Aug 01, 2023 at 11:51:28PM +0800, Wang Yugui wrote:
> > > Can you try a git-revert of 140fb1f734736a on the latest tree (which
> > > should work cleanly) for an additional data point?
> > 
> > GOOD performance  when btrfs 6.5-rc4 with
> > 	Revert "btrfs: determine synchronous writers from bio or writeback control"
> > 	Revert "btrfs: submit IO synchronously for fast checksum implementations"
> 
> And with only a revert of
> 
> "btrfs: submit IO synchronously for fast checksum implementations"?

GOOD performance when only (Revert "btrfs: submit IO synchronously for fast
checksum implementations") 

> > 
> > GOOD performance  when btrfs 6.5-rc4 with this fix too.
> > diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> > index 1f3e06ec6924..1b7344e673db 100644
> > --- a/fs/btrfs/bio.c
> > +++ b/fs/btrfs/bio.c
> > @@ -598,7 +598,7 @@ static void run_one_async_free(struct btrfs_work *work)
> >  static bool should_async_write(struct btrfs_bio *bbio)
> >  {
> >         /* Submit synchronously if the checksum implementation is fast. */
> > -       if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
> > +       if ((bbio->bio.bi_opf & REQ_META) && test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
> >                 return false;
> 
> This disables synchronous checksum calculation entirely for data I/O.

without this fix, data I/O checksum is always synchronous?
this is a feature change of "btrfs: submit IO synchronously for fast checksum implementations"?


> Also I'm curious if you see any differents for a non-RAID0 (i.e.
> single profile) workload.

'-m single -d single' is about 10% slow that '-m raid1 -d raid0' in this test
case.


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/08/02

