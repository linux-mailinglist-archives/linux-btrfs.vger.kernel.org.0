Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65222590A73
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Aug 2022 04:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbiHLC6p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Aug 2022 22:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbiHLC6o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Aug 2022 22:58:44 -0400
Received: from out20-207.mail.aliyun.com (out20-207.mail.aliyun.com [115.124.20.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0279DA2863
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Aug 2022 19:58:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.050687|-1;BR=01201311R211S00rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0288547-0.0327435-0.938402;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.OrePIgh_1660273090;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.OrePIgh_1660273090)
          by smtp.aliyun-inc.com;
          Fri, 12 Aug 2022 10:58:10 +0800
Date:   Fri, 12 Aug 2022 10:58:15 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: Re: misc-next and for-next: kernel BUG at fs/btrfs/extent_io.c:2350! during raid5 recovery
Cc:     Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org
In-Reply-To: <YvK0WPtEVzXwv3p1@hungrycats.org>
References: <YvIbB5l4gtG4f/S9@infradead.org> <YvK0WPtEVzXwv3p1@hungrycats.org>
Message-Id: <20220812105814.0B6B.409509F4@e16-tech.com>
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

With a modified script based on this reproducer,
'uncorrectable errors' is easy to reproduce

kernel:
	5.20.0(2022/08/09) + some patches in misc-next
	0*-btrfs-scrub-properly-report-super-block-errors-in-sy.patch
	0*-btrfs-scrub-try-to-fix-super-block-errors.patch
	0*-btrfs-fix-lost-error-handling-when-looking-up-extend.patch

script:
	source ~/xfstests/local.config

	SCRATCH_DEV_ARRAY=($SCRATCH_DEV_POOL)
	umount $SCRATCH_MNT
	set -e
	uname -a

	mkfs.btrfs -f -draid5 -mraid1 ${SCRATCH_DEV_ARRAY[@]}
	mount ${SCRATCH_DEV_ARRAY[0]} $SCRATCH_MNT # -o
	compress=zstd,noatime
	mkdir -p $SCRATCH_MNT/dir1

	/bin/cp -a /usr/hpc-bio $SCRATCH_MNT/dir1/
	sync
	du -sh $SCRATCH_MNT
	cd $SCRATCH_MNT
	while true; do
		find -type f -exec cat {} + > /dev/null
	done &

	for((i=0;i>=0;++i)); do

		sync; sleep 2; sync; sleep 4; sync; sleep 20; # change the
	device to discard in every loop
		j=$(( i % ${#SCRATCH_DEV_ARRAY[@]} ))
		/usr/sbin/blkdiscard -f ${SCRATCH_DEV_ARRAY[$j]} >/dev/null 2>&1

		btrfs scrub start -Bd $SCRATCH_MNT | grep
'summary\|Uncorrectable'
done &
wait

Result:
	'uncorrectable errors' is reported in 2nd loop.

Is this a problem of this test script or btrfs kernel?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/08/12


> > Any chance you could share a script for your reproducer?
> 
> The simplest reproducer is some variant of:
> 
> 	mkfs.btrfs -draid5 -mraid1 /dev/vdb /dev/vdc /dev/vdd
> 	mount /dev/vdb /mnt -ocompress=zstd,noatime
> 	cd /mnt
> 	cp -a /40gb-test-data .
> 	sync
> 	while true; do
> 		find -type f -exec cat {} + > /dev/null
> 	done &
> 	while true; do
> 		cat /dev/zero > /dev/vdb
> 	done &
> 	while true; do
> 		btrfs scrub start -Bd /mnt
> 	done &
> 	wait
> 
> but it can take a long time to hit a failure with something that gentle.
> I throw on some extra test workload (e.g. lots of rsyncs) to keep the
> page cache full and under memory pressure, which seems to speed up the
> failure rate to once every few hours.




