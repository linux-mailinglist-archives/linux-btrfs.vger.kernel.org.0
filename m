Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3AF59176B
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 00:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbiHLWsI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Aug 2022 18:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiHLWsH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Aug 2022 18:48:07 -0400
Received: from out20-205.mail.aliyun.com (out20-205.mail.aliyun.com [115.124.20.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0F783BD2
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 15:48:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04608124|-1;BR=01201311R151S31rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.186839-0.0457053-0.767456;FP=0|0|0|0|0|0|0|0;HT=ay29a033018047213;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.OsGCMpV_1660344452;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.OsGCMpV_1660344452)
          by smtp.aliyun-inc.com;
          Sat, 13 Aug 2022 06:47:33 +0800
Date:   Sat, 13 Aug 2022 06:47:39 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-btrfs@vger.kernel.org
Subject: Re: misc-next and for-next: kernel BUG at fs/btrfs/extent_io.c:2350! during raid5 recovery
In-Reply-To: <20220812105814.0B6B.409509F4@e16-tech.com>
References: <YvK0WPtEVzXwv3p1@hungrycats.org> <20220812105814.0B6B.409509F4@e16-tech.com>
Message-Id: <20220813064738.24AC.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------_62F6D7BF0000000024A7_MULTIPART_MIXED_"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--------_62F6D7BF0000000024A7_MULTIPART_MIXED_
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hi,

If we add 'echo 3 > /proc/sys/vm/drop_caches; free -h' before
'blkdiscard', 'uncorrectable errors'  will happen in 1st loop.

please see the attachment file for the v2 script.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/08/13

> Hi,
> 
> With a modified script based on this reproducer,
> 'uncorrectable errors' is easy to reproduce
> 
> kernel:
> 	5.20.0(2022/08/09) + some patches in misc-next
> 	0*-btrfs-scrub-properly-report-super-block-errors-in-sy.patch
> 	0*-btrfs-scrub-try-to-fix-super-block-errors.patch
> 	0*-btrfs-fix-lost-error-handling-when-looking-up-extend.patch
> 
> script:
> 	source ~/xfstests/local.config
> 
> 	SCRATCH_DEV_ARRAY=($SCRATCH_DEV_POOL)
> 	umount $SCRATCH_MNT
> 	set -e
> 	uname -a
> 
> 	mkfs.btrfs -f -draid5 -mraid1 ${SCRATCH_DEV_ARRAY[@]}
> 	mount ${SCRATCH_DEV_ARRAY[0]} $SCRATCH_MNT # -o
> 	compress=zstd,noatime
> 	mkdir -p $SCRATCH_MNT/dir1
> 
> 	/bin/cp -a /usr/hpc-bio $SCRATCH_MNT/dir1/
> 	sync
> 	du -sh $SCRATCH_MNT
> 	cd $SCRATCH_MNT
> 	while true; do
> 		find -type f -exec cat {} + > /dev/null
> 	done &
> 
> 	for((i=0;i>=0;++i)); do
> 
> 		sync; sleep 2; sync; sleep 4; sync; sleep 20; # change the
> 	device to discard in every loop
> 		j=$(( i % ${#SCRATCH_DEV_ARRAY[@]} ))
> 		/usr/sbin/blkdiscard -f ${SCRATCH_DEV_ARRAY[$j]} >/dev/null 2>&1
> 
> 		btrfs scrub start -Bd $SCRATCH_MNT | grep
> 'summary\|Uncorrectable'
> done &
> wait
> 
> Result:
> 	'uncorrectable errors' is reported in 2nd loop.
> 
> Is this a problem of this test script or btrfs kernel?
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/08/12
> 
> 
> > > Any chance you could share a script for your reproducer?
> > 
> > The simplest reproducer is some variant of:
> > 
> > 	mkfs.btrfs -draid5 -mraid1 /dev/vdb /dev/vdc /dev/vdd
> > 	mount /dev/vdb /mnt -ocompress=zstd,noatime
> > 	cd /mnt
> > 	cp -a /40gb-test-data .
> > 	sync
> > 	while true; do
> > 		find -type f -exec cat {} + > /dev/null
> > 	done &
> > 	while true; do
> > 		cat /dev/zero > /dev/vdb
> > 	done &
> > 	while true; do
> > 		btrfs scrub start -Bd /mnt
> > 	done &
> > 	wait
> > 
> > but it can take a long time to hit a failure with something that gentle.
> > I throw on some extra test workload (e.g. lots of rsyncs) to keep the
> > page cache full and under memory pressure, which seems to speed up the
> > failure rate to once every few hours.
> 
> 
> 


--------_62F6D7BF0000000024A7_MULTIPART_MIXED_
Content-Type: application/octet-stream;
 name="raid5.disk.fail-v2.sh"
Content-Disposition: attachment;
 filename="raid5.disk.fail-v2.sh"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKc2V0IC11eCAtbyBwaXBlZmFpbAoKc291cmNlIH4veGZzdGVzdHMvbG9jYWwu
Y29uZmlnCgpTQ1JBVENIX0RFVl9BUlJBWT0oJFNDUkFUQ0hfREVWX1BPT0wpCnVtb3VudCAkU0NS
QVRDSF9NTlQKc2V0IC1lCnVuYW1lIC1hCgpta2ZzLmJ0cmZzIC1mIC1kcmFpZDUgLW1yYWlkMSAk
e1NDUkFUQ0hfREVWX0FSUkFZW0BdfQptb3VudCAke1NDUkFUQ0hfREVWX0FSUkFZWzBdfSAkU0NS
QVRDSF9NTlQgIyAtbyBjb21wcmVzcz16c3RkLG5vYXRpbWUKbWtkaXIgLXAgJFNDUkFUQ0hfTU5U
L2RpcjEKCi9iaW4vY3AgLWEgL3Vzci9ocGMtYmlvICRTQ1JBVENIX01OVC9kaXIxLwpzeW5jCmR1
IC1zaCAkU0NSQVRDSF9NTlQKY2QgJFNDUkFUQ0hfTU5UCndoaWxlIHRydWU7IGRvCglmaW5kIC10
eXBlIGYgLWV4ZWMgY2F0IHt9ICsgPiAvZGV2L251bGwKZG9uZSAmCgpmb3IoKGk9MTtpPj0wOysr
aSkpOyBkbwoKCXN5bmM7IHNsZWVwIDI7IHN5bmM7IHNsZWVwIDQ7IHN5bmM7IHNsZWVwIDIwOyAj
IGNoYW5nZSB0aGUgZGV2aWNlIHRvIGRpc2NhcmQgaW4gZXZlcnkgbG9vcAoJZWNobyAzID4gL3By
b2Mvc3lzL3ZtL2Ryb3BfY2FjaGVzOyBmcmVlIC1oCglqPSQoKCBpICUgJHsjU0NSQVRDSF9ERVZf
QVJSQVlbQF19ICkpCgkvdXNyL3NiaW4vYmxrZGlzY2FyZCAtZiAke1NDUkFUQ0hfREVWX0FSUkFZ
WyRqXX0gPi9kZXYvbnVsbCAyPiYxCgoJYnRyZnMgc2NydWIgc3RhcnQgLUJkICRTQ1JBVENIX01O
VCB8IGdyZXAgJ3N1bW1hcnlcfFVuY29ycmVjdGFibGUnCmRvbmUgJgp3YWl0Cgo=
--------_62F6D7BF0000000024A7_MULTIPART_MIXED_--

