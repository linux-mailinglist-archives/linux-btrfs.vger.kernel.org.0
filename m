Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7401A7791BE
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 16:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbjHKOXd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 10:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjHKOXc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 10:23:32 -0400
Received: from out28-84.mail.aliyun.com (out28-84.mail.aliyun.com [115.124.28.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700ED121
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 07:23:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1157637|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.096599-0.00299696-0.900404;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.UEB5mG0_1691763801;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.UEB5mG0_1691763801)
          by smtp.aliyun-inc.com;
          Fri, 11 Aug 2023 22:23:27 +0800
Date:   Fri, 11 Aug 2023 22:23:28 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Christoph Hellwig <hch@lst.de>
Subject: Re: btrfs write-bandwidth performance regression of 6.5-rc4/rc3
Cc:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>
In-Reply-To: <20230802092631.GA27963@lst.de>
References: <20230802080451.F0C2.409509F4@e16-tech.com> <20230802092631.GA27963@lst.de>
Message-Id: <20230811222321.2AD2.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,


> On Wed, Aug 02, 2023 at 08:04:57AM +0800, Wang Yugui wrote:
> > > And with only a revert of
> > > 
> > > "btrfs: submit IO synchronously for fast checksum implementations"?
> > 
> > GOOD performance when only (Revert "btrfs: submit IO synchronously for fast
> > checksum implementations") 
> 
> Ok, so you have a case where the offload for the checksumming generation
> actually helps (by a lot).  Adding Chris to the Cc list as he was
> involved with this.
> 
> > > > -       if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
> > > > +       if ((bbio->bio.bi_opf & REQ_META) && test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
> > > >                 return false;
> > > 
> > > This disables synchronous checksum calculation entirely for data I/O.
> > 
> > without this fix, data I/O checksum is always synchronous?
> > this is a feature change of "btrfs: submit IO synchronously for fast checksum implementations"?
> 
> It is never with the above patch.
> 
> > 
> > > Also I'm curious if you see any differents for a non-RAID0 (i.e.
> > > single profile) workload.
> > 
> > '-m single -d single' is about 10% slow that '-m raid1 -d raid0' in this test
> > case.
> 
> How does it compare with and without the revert?  Can you add the numbers?

the patch from wangyugui
diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 12b12443efaa..8ef968f0957d 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -598,7 +598,7 @@ static void run_one_async_free(struct btrfs_work *work)
 static bool should_async_write(struct btrfs_bio *bbio)
 {
 	/* Submit synchronously if the checksum implementation is fast. */
-	if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
+	if ((bbio->bio.bi_opf & REQ_META) && test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
 		return false;
 
 	/*

btrfs device: NVMe SSD PCIe3  x4

fio(-numjobs=4 ) on linux 6.5-rc5 with the patch, btrfs '-m raid1 -d raid0' 
  WRITE: bw=3858MiB/s (4045MB/s)
  WRITE: bw=3781MiB/s (3965MB/s)

fio(-numjobs=4 ) on linux 6.5-rc5 with the patch, btrfs '-m single -d single' 
  WRITE: bw=3004MiB/s (3149MB/s),
  WRITE: bw=2851MiB/s (2990MB/s)


fio(-numjobs=4 ) on linux 6.5-rc5 without the patch, btrfs '-m raid1 -d raid0' 
  WRITE: bw=1311MiB/s (1375MB/s)
  WRITE: bw=1435MiB/s (1504MB/s)

fio(-numjobs=4 ) on linux 6.5-rc5 without the patch, btrfs '-m single -d single' 
  WRITE: bw=1337MiB/s (1402MB/s)
  WRITE: bw=1413MiB/s (1481MB/s),


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/08/11



