Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1201F381769
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 May 2021 11:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhEOKA3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 May 2021 06:00:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20502 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229524AbhEOKA2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 May 2021 06:00:28 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14F9X8bx029440;
        Sat, 15 May 2021 05:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=mxoj47qlsj059XgLO1HShsB0sxQcLH/+c+0sWx9b3d8=;
 b=O58onRffur2PcN7RcYyoafVESgHXGF/BPH8Ci973q4Z11VOSlxR8pjDm5ChBvpGK9TZq
 ZqbWzowFu0CdvT4RvGJzfh8qMldbRN6ndFM4p1hg38FOiApM3z8W5jvcHNYiRJLmlEgq
 Gl8VSlDhfr8I+/tzzB1wc+HlYKt/ql7K8sbny26iycZ/hQgAEjDlFMjDiFULJiHUsqjP
 SShfqVIwJgVccWiFQJJZuwwWfGMFvR7cdQkOfkb5YhN2sbQeziyoBR5NVjqe7bRrOGKC
 ASQf7joDYuWiI0FKqSR6KhveA8cYQVJMs8vvYSSH3fno0UuQtUI8LGNfPWBY6JOZ+20t FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38jakthb8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 May 2021 05:59:12 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14F9X9vg029478;
        Sat, 15 May 2021 05:59:12 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38jakthb8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 May 2021 05:59:12 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14F9wZqK011037;
        Sat, 15 May 2021 09:59:09 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 38j5x882r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 May 2021 09:59:09 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14F9x7wx41026032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 09:59:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66E9D42041;
        Sat, 15 May 2021 09:59:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 094564203F;
        Sat, 15 May 2021 09:59:07 +0000 (GMT)
Received: from localhost (unknown [9.77.193.23])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 15 May 2021 09:59:06 +0000 (GMT)
Date:   Sat, 15 May 2021 15:29:06 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
Message-ID: <20210515095906.ifmqf36t2jup7tzw@riteshh-domain>
References: <20210511104809.evndsdckwhmonyyl@riteshh-domain>
 <334a5fdd-28ee-4163-456c-adc4b2276d08@gmx.com>
 <fae358ed-8d14-8e14-2dc3-173637ec5e87@gmx.com>
 <20210512070931.p5hipe3ov45vqzjt@riteshh-domain>
 <20210513163316.ypvh3ppsrmxg7dit@riteshh-domain>
 <20210513213656.2poyhssr4wzq65s4@riteshh-domain>
 <5f1d41d2-c7bc-ceb7-be4c-714d6731a296@gmx.com>
 <20210514150831.trfaihcy2ryp35uh@riteshh-domain>
 <20210514175343.v32k2rmsfl5l2qfa@riteshh-domain>
 <80735b91-ad23-1b49-20bb-fd3a09957793@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80735b91-ad23-1b49-20bb-fd3a09957793@gmx.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H2or3XpL3u2vbdJ6SCy66NiciikW4bOf
X-Proofpoint-ORIG-GUID: V27TJUhy-54kSuwq3ylzkXOXKnPLe1AI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-15_06:2021-05-12,2021-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0
 mlxlogscore=875 mlxscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105150067
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/05/15 06:22AM, Qu Wenruo wrote:
>
>
> >
> > Hi Qu,
> >
> > Thanks for pointing this out. I could see that w/o your new fix I could
> > reproduce the BUG_ON() crash. But with your patch the test btrfs/195 still
> > fails.  I guess that is expected right, since
> > "RAID5/6 is not supported yet for sectorsize 4096 with page size 65536"?
> >
> > Is my understanding correct?
>
> Yep, the test is still going to fail, as we reject such convert.
>
> There are tons of other btrfs tests that fails due to the same reason.
>
> Some of them can be avoided using "BTRFS_PROFILE_CONFIGS" environment
> variant to avoid raid5/6, but not all.
>
> Thus I'm going to update those tests to use that variant to make it
> easier to rule out certain profiles.

Hello Qu,

Sorry to bother you again. While running your latest full patch series, I found
below two failures, no crashes though :)
Could you please take a look at it.

1. btrfs/141 failure.
xfstests.global-btrfs/4k.btrfs/141
Error Details
- output mismatch (see /results/btrfs/results-4k/btrfs/141.out.bad)

Standard Output
step 1......mkfs.btrfs
step 2......corrupt file extent
Filesystem type is: 9123683e
File size of /vdc/foobar is 131072 (32 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..      31:      33632..     33663:     32:             last,eof
/vdc/foobar: 1 extent found
 corrupt stripe #1, devid 2 devpath /dev/vdi physical 116785152
step 3......repair the bad copy


Standard Error
--- tests/btrfs/141.out	2021-04-24 07:27:39.000000000 +0000
+++ /results/btrfs/results-4k/btrfs/141.out.bad	2021-05-14 18:46:23.720000000 +0000
@@ -1,37 +1,37 @@
 QA output created by 141
 wrote 131072/131072 bytes
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
 read 512/512 bytes
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)


2. btrfs/124 failure.

I guess below could be due to small size of the device?

xfstests.global-btrfs/4k.btrfs/124
Error Details
- output mismatch (see /results/btrfs/results-4k/btrfs/124.out.bad)
Standard Output
max_fs_sz=1200000000 count=1200
-----Initialize -----
# /usr/local/bin/btrfs filesystem show
Label: none  uuid: fbb48eb6-25c7-4800-8656-503c1e502d85
	Total devices 2 FS bytes used 32.00KiB
	devid    1 size 5.00GiB used 622.38MiB path /dev/vdc
	devid    2 size 2.00GiB used 622.38MiB path /dev/vdi

Label: none  uuid: d3c4fb09-eea2-4dea-8187-b13e97f4ad5c
	Total devices 4 FS bytes used 379.12MiB
	devid    1 size 5.00GiB used 8.00MiB path /dev/vdb
	devid    3 size 20.00GiB used 264.00MiB path /dev/vde
	devid    4 size 20.00GiB used 1.26GiB path /dev/vdf
	*** Some devices missing

Label: none  uuid: a05d487c-e808-456a-abb6-fc4c0b9bee35
	Total devices 1 FS bytes used 232.00KiB
	devid    1 size 5.00GiB used 1.02GiB path /dev/vdd

1+0 records in
1+0 records out
unmount
clean btrfs ko

-----Write degraded mount fill upto 1200000000 bytes-----
# /usr/local/bin/btrfs filesystem show
Label: none  uuid: fbb48eb6-25c7-4800-8656-503c1e502d85
	Total devices 2 FS bytes used 1.16MiB
	devid    1 size 5.00GiB used 622.38MiB path /dev/vdc
	*** Some devices missing

Label: none  uuid: d3c4fb09-eea2-4dea-8187-b13e97f4ad5c
	Total devices 4 FS bytes used 379.12MiB
	devid    1 size 5.00GiB used 8.00MiB path /dev/vdb
	devid    3 size 20.00GiB used 264.00MiB path /dev/vde
	devid    4 size 20.00GiB used 1.26GiB path /dev/vdf
	*** Some devices missing

Label: none  uuid: a05d487c-e808-456a-abb6-fc4c0b9bee35
	Total devices 1 FS bytes used 232.00KiB
	devid    1 size 5.00GiB used 1.02GiB path /dev/vdd

1200+0 records in
1200+0 records out
8c2297c9abaf3b724f6192f65efe9a89 /vdc/tf2
unmount

-----Mount normal-----
# /usr/local/bin/btrfs device scan
Scanning for Btrfs filesystems
# /usr/local/bin/btrfs filesystem show
Label: none  uuid: fbb48eb6-25c7-4800-8656-503c1e502d85
	Total devices 2 FS bytes used 1.17GiB
	devid    1 size 5.00GiB used 2.39GiB path /dev/vdc
	devid    2 size 2.00GiB used 622.38MiB path /dev/vdi

Label: none  uuid: d3c4fb09-eea2-4dea-8187-b13e97f4ad5c
	Total devices 4 FS bytes used 379.12MiB
	devid    1 size 5.00GiB used 8.00MiB path /dev/vdb
	devid    3 size 20.00GiB used 264.00MiB path /dev/vde
	devid    4 size 20.00GiB used 1.26GiB path /dev/vdf
	*** Some devices missing

Label: none  uuid: a05d487c-e808-456a-abb6-fc4c0b9bee35
	Total devices 1 FS bytes used 232.00KiB
	devid    1 size 5.00GiB used 1.02GiB path /dev/vdd


8c2297c9abaf3b724f6192f65efe9a89 /vdc/tf2

-----Mount degraded with the other dev -----
# /usr/local/bin/btrfs filesystem show
Label: none  uuid: fbb48eb6-25c7-4800-8656-503c1e502d85
	Total devices 2 FS bytes used 1.17GiB
	devid    2 size 2.00GiB used 2.00GiB path /dev/vdi
	*** Some devices missing

Label: none  uuid: d3c4fb09-eea2-4dea-8187-b13e97f4ad5c
	Total devices 4 FS bytes used 379.12MiB
	devid    1 size 5.00GiB used 8.00MiB path /dev/vdb
	devid    3 size 20.00GiB used 264.00MiB path /dev/vde
	devid    4 size 20.00GiB used 1.26GiB path /dev/vdf
	*** Some devices missing

Label: none  uuid: a05d487c-e808-456a-abb6-fc4c0b9bee35
	Total devices 1 FS bytes used 232.00KiB
	devid    1 size 5.00GiB used 1.02GiB path /dev/vdd

8c2297c9abaf3b724f6192f65efe9a89 /vdc/tf2

Standard Error
[ 2511.357169] run fstests btrfs/124 at 2021-05-14 18:39:19
[ 2511.961083] BTRFS info (device vdd): disk space caching is enabled
[ 2511.961232] BTRFS info (device vdd): has skinny extents
[ 2511.961270] BTRFS warning (device vdd): read-write for sector size 4096 with page size 65536 is experimental
[ 2512.809266] BTRFS: device fsid fbb48eb6-25c7-4800-8656-503c1e502d85 devid 1 transid 5 /dev/vdc scanned by mkfs.btrfs (25193)
[ 2512.814344] BTRFS: device fsid fbb48eb6-25c7-4800-8656-503c1e502d85 devid 2 transid 5 /dev/vdi scanned by mkfs.btrfs (25193)
[ 2512.838098] BTRFS info (device vdc): disk space caching is enabled
[ 2512.838201] BTRFS info (device vdc): has skinny extents
[ 2512.838244] BTRFS warning (device vdc): read-write for sector size 4096 with page size 65536 is experimental
[ 2512.844581] BTRFS info (device vdc): checking UUID tree
[ 2513.015279] BTRFS: device fsid d3c4fb09-eea2-4dea-8187-b13e97f4ad5c devid 1 transid 145 /dev/vdb scanned by systemd-udevd (24701)
[ 2513.034653] BTRFS: device fsid d3c4fb09-eea2-4dea-8187-b13e97f4ad5c devid 3 transid 145 /dev/vde scanned by systemd-udevd (24418)
[ 2513.138265] BTRFS: device fsid d3c4fb09-eea2-4dea-8187-b13e97f4ad5c devid 4 transid 145 /dev/vdf scanned by systemd-udevd (25222)
[ 2513.634205] BTRFS: device fsid fbb48eb6-25c7-4800-8656-503c1e502d85 devid 1 transid 7 /dev/vdc scanned by mount (25234)
[ 2513.637110] BTRFS info (device vdc): allowing degraded mounts
[ 2513.637241] BTRFS info (device vdc): disk space caching is enabled
[ 2513.637360] BTRFS info (device vdc): has skinny extents
[ 2513.637455] BTRFS warning (device vdc): read-write for sector size 4096 with page size 65536 is experimental
[ 2513.640760] BTRFS warning (device vdc): devid 2 uuid a03f9ebb-81fd-45be-9a17-f048d6954f1c is missing
[ 2513.644352] BTRFS warning (device vdc): devid 2 uuid a03f9ebb-81fd-45be-9a17-f048d6954f1c is missing
[ 2529.907020] BTRFS: device fsid a05d487c-e808-456a-abb6-fc4c0b9bee35 devid 1 transid 219 /dev/vdd scanned by btrfs (25262)
[ 2529.908870] BTRFS: device fsid d3c4fb09-eea2-4dea-8187-b13e97f4ad5c devid 4 transid 145 /dev/vdf scanned by btrfs (25262)
[ 2529.909925] BTRFS: device fsid d3c4fb09-eea2-4dea-8187-b13e97f4ad5c devid 3 transid 145 /dev/vde scanned by btrfs (25262)
[ 2529.910516] BTRFS: device fsid d3c4fb09-eea2-4dea-8187-b13e97f4ad5c devid 1 transid 145 /dev/vdb scanned by btrfs (25262)
[ 2529.937367] BTRFS info (device vdc): disk space caching is enabled
[ 2529.937523] BTRFS info (device vdc): has skinny extents
[ 2529.937599] BTRFS warning (device vdc): read-write for sector size 4096 with page size 65536 is experimental
[ 2530.185770] BTRFS info (device vdc): balance: start -d -m -s
[ 2530.186594] BTRFS info (device vdc): relocating block group 2050359296 flags data
[ 2535.649631] BTRFS info (device vdc): found 3 extents, stage: move data extents
[ 2535.891378] BTRFS info (device vdc): found 3 extents, stage: update data pointers
[ 2536.109722] BTRFS info (device vdc): relocating block group 1513488384 flags data
[ 2549.819115] BTRFS info (device vdc): found 4 extents, stage: move data extents
[ 2550.051966] BTRFS info (device vdc): found 4 extents, stage: update data pointers
[ 2550.335411] BTRFS info (device vdc): relocating block group 976617472 flags data
[ 2564.128269] BTRFS info (device vdc): found 6 extents, stage: move data extents
[ 2564.370940] BTRFS info (device vdc): found 6 extents, stage: update data pointers
[ 2564.630805] BTRFS info (device vdc): relocating block group 943063040 flags system
[ 2564.897480] BTRFS info (device vdc): relocating block group 674627584 flags metadata
[ 2565.152783] BTRFS info (device vdc): relocating block group 298844160 flags data|raid1
[ 2575.202247] BTRFS info (device vdc): found 4 extents, stage: move data extents
[ 2575.421479] BTRFS info (device vdc): found 3 extents, stage: update data pointers
[ 2575.653141] BTRFS info (device vdc): relocating block group 30408704 flags metadata|raid1
[ 2575.653340] ------------[ cut here ]------------
[ 2575.653426] BTRFS: Transaction aborted (error -28)
[ 2575.653575] WARNING: CPU: 6 PID: 25290 at fs/btrfs/extent-tree.c:3080 __btrfs_free_extent.isra.37+0x6c0/0x1210
[ 2575.653776] Modules linked in:
[ 2575.653837] CPU: 6 PID: 25290 Comm: btrfs Not tainted 5.12.0-rc8-00161-g2bf0f9c65743 #32
[ 2575.653957] NIP:  c0000000009e66f0 LR: c0000000009e66ec CTR: c000000000e516a0
[ 2575.654073] REGS: c00000000a407030 TRAP: 0700   Not tainted  (5.12.0-rc8-00161-g2bf0f9c65743)
[ 2575.654206] MSR:  800000000282b033 &lt;SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE&gt;  CR: 48002222  XER: 20000000
[ 2575.654364] CFAR: c0000000001d33c0 IRQMASK: 0
               GPR00: c0000000009e66ec c00000000a4072d0 c000000001c4ae00 0000000000000026
               GPR04: 0000000000000001 0000000000000000 0000000000000027 c0000000ff807e98
               GPR08: 0000000000000023 0000000000000000 c000000011fa3300 c000000001a03d78
               GPR12: 0000000000002200 c00000003ffe7800 c000000001c99158 5deadbeef0000122
               GPR16: 0000000000000001 ffffffffffffffe4 c0000000c0110558 c0000000261b2148
               GPR20: 0000000000000000 c00000000b844000 0000000000000000 c000000012594000
               GPR24: 0000000000000001 0000000000000001 0000000000001000 c000000094db6c50
               GPR28: 0000000000000003 0000000000000000 0000000001500000 0000000000000000
[ 2575.655367] NIP [c0000000009e66f0] __btrfs_free_extent.isra.37+0x6c0/0x1210
[ 2575.655469] LR [c0000000009e66ec] __btrfs_free_extent.isra.37+0x6bc/0x1210
[ 2575.655562] Call Trace:
[ 2575.655601] [c00000000a4072d0] [c0000000009e66ec] __btrfs_free_extent.isra.37+0x6bc/0x1210 (unreliable)
[ 2575.655732] [c00000000a4073f0] [c0000000009e863c] __btrfs_run_delayed_refs+0x99c/0x16c0
[ 2575.655845] [c00000000a4075a0] [c0000000009e940c] btrfs_run_delayed_refs+0xac/0x330
[ 2575.655957] [c00000000a407660] [c000000000a04dc4] btrfs_commit_transaction+0xf4/0x1330
[ 2575.656069] [c00000000a407750] [c000000000a8f9e4] prepare_to_relocate+0x104/0x140
[ 2575.656190] [c00000000a407780] [c000000000a96074] relocate_block_group+0x74/0x5f0
[ 2575.656305] [c00000000a407840] [c000000000a96820] btrfs_relocate_block_group+0x230/0x4a0
[ 2575.656420] [c00000000a407900] [c000000000a4f180] btrfs_relocate_chunk+0x80/0x1c0
[ 2575.656532] [c00000000a407980] [c000000000a5045c] btrfs_balance+0x103c/0x1560
[ 2575.656644] [c00000000a407b10] [c000000000a632a8] btrfs_ioctl_balance+0x2d8/0x450
[ 2575.656756] [c00000000a407b70] [c000000000a67520] btrfs_ioctl+0x1d30/0x3df0
[ 2575.656849] [c00000000a407d10] [c00000000058a188] sys_ioctl+0xa8/0x120
[ 2575.656953] [c00000000a407d60] [c000000000039e64] system_call_exception+0x384/0x3d0
[ 2575.657074] [c00000000a407e10] [c00000000000d45c] system_call_common+0xec/0x278
[ 2575.657186] --- interrupt: c00 at 0x7ffff7bf2990
[ 2575.657268] NIP:  00007ffff7bf2990 LR: 000000010003d974 CTR: 0000000000000000
[ 2575.657377] REGS: c00000000a407e80 TRAP: 0c00   Not tainted  (5.12.0-rc8-00161-g2bf0f9c65743)
[ 2575.657504] MSR:  800000000000d033 &lt;SF,EE,PR,ME,IR,DR,RI,LE&gt;  CR: 24002824  XER: 00000000
[ 2575.657626] IRQMASK: 0
               GPR00: 0000000000000036 00007fffffffd430 00007ffff7ce7100 0000000000000003
               GPR04: 00000000c4009420 00007fffffffd560 0000000000000000 0000000000000000
               GPR08: 0000000000000003 0000000000000000 0000000000000000 0000000000000000
               GPR12: 0000000000000000 00007ffff7ffc930 0000000000000000 0000000000000000
               GPR16: 00000001000cdb48 00000001000cdb78 00000001000cdb98 0000000000000000
               GPR20: 00000001000cdb20 00000001000cda58 00000001000cda68 00000001000cdaa8
               GPR24: 0000000000000000 0000000000000000 00007fffffffd560 00007fffffffec7b
               GPR28: 0000000000000002 0000000000000000 0000000000000000 0000000000000003
[ 2575.658543] NIP [00007ffff7bf2990] 0x7ffff7bf2990
[ 2575.658617] LR [000000010003d974] 0x10003d974
[ 2575.658691] --- interrupt: c00
[ 2575.658748] Instruction dump:
[ 2575.658805] 7c0004ac 71490008 40820058 2f91fffb 419e0030 2f91ffe2 419e0028 3c62ff9f
[ 2575.658924] 7e248b78 38633028 4b7ecc71 60000000 &lt;0fe00000&gt; 4800002c 60000000 60000000
[ 2575.659043] irq event stamp: 0
[ 2575.659099] hardirqs last  enabled at (0): [&lt;0000000000000000&gt;] 0x0
[ 2575.659191] hardirqs last disabled at (0): [&lt;c0000000001cfb0c&gt;] copy_process+0x76c/0x1c00
[ 2575.659303] softirqs last  enabled at (0): [&lt;c0000000001cfb0c&gt;] copy_process+0x76c/0x1c00
[ 2575.659415] softirqs last disabled at (0): [&lt;0000000000000000&gt;] 0x0
[ 2575.659512] ---[ end trace ab9bdd82f0a5e6a5 ]---
[ 2575.659605] BTRFS: error (device vdc) in __btrfs_free_extent:3080: errno=-28 No space left
[ 2575.659718] BTRFS info (device vdc): forced readonly
[ 2575.659803] BTRFS: error (device vdc) in btrfs_run_delayed_refs:2159: errno=-28 No space left
[ 2575.659995] BTRFS info (device vdc): 1 enospc errors during balance
[ 2575.660092] BTRFS info (device vdc): balance: ended with status: -30
[ 2584.166689] BTRFS: device fsid fbb48eb6-25c7-4800-8656-503c1e502d85 devid 2 transid 52 /dev/vdi scanned by mount (25301)
[ 2584.168507] BTRFS info (device vdi): allowing degraded mounts
[ 2584.168662] BTRFS info (device vdi): disk space caching is enabled
[ 2584.168809] BTRFS info (device vdi): has skinny extents
[ 2584.168929] BTRFS warning (device vdi): read-write for sector size 4096 with page size 65536 is experimental
[ 2584.171231] BTRFS warning (device vdi): devid 1 uuid 20cac181-2412-406d-aaa1-a8c74aa3c3d9 is missing
[ 2584.171788] BTRFS warning (device vdi): devid 1 uuid 20cac181-2412-406d-aaa1-a8c74aa3c3d9 is missing
[ 2584.196998] BTRFS info (device vdi): checking UUID tree
[ 2584.227833] BTRFS info (device vdi): balance: resume -dusage=90 -musage=90 -susage=90
[ 2584.228687] BTRFS info (device vdi): relocating block group 3342204928 flags data|raid1
[ 2584.295787] BTRFS info (device vdi): relocating block group 298844160 flags data|raid1
[ 2584.335524] ------------[ cut here ]------------
[ 2584.335571] BTRFS: Transaction aborted (error -28)
[ 2584.335630] WARNING: CPU: 5 PID: 25320 at fs/btrfs/volumes.c:3067 btrfs_remove_chunk+0x534/0xb80
[ 2584.335709] Modules linked in:
[ 2584.335743] CPU: 5 PID: 25320 Comm: btrfs-balance Tainted: G        W         5.12.0-rc8-00161-g2bf0f9c65743 #32
[ 2584.335822] NIP:  c000000000a4eab4 LR: c000000000a4eab0 CTR: c000000000e516a0
[ 2584.335880] REGS: c00000000e2477a0 TRAP: 0700   Tainted: G        W          (5.12.0-rc8-00161-g2bf0f9c65743)
[ 2584.335960] MSR:  800000000282b033 &lt;SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE&gt;  CR: 48002222  XER: 20000000
[ 2584.336045] CFAR: c0000000001d33c0 IRQMASK: 0
               GPR00: c000000000a4eab0 c00000000e247a40 c000000001c4ae00 0000000000000026
               GPR04: 0000000000000001 0000000000000000 0000000000000027 c0000000ff707e98
               GPR08: 0000000000000023 0000000000000000 c0000000092a3300 c000000001a04300
               GPR12: 0000000000002200 c00000003ffe8a00 0000000000000001 c0000000261ce600
               GPR16: 0000000011d00000 c0000000261c8c78 c000000028bd9248 c00000000d814150
               GPR20: c00000000d814860 ffffffffffffffcc c00000000d814000 c00000000d814000
               GPR24: c000000013117628 0000000000000000 c000000009537000 c000000094db6c50
               GPR28: 0000000016660000 c000000027f41c00 ffffffffffffffe4 c000000029321888
[ 2584.336561] NIP [c000000000a4eab4] btrfs_remove_chunk+0x534/0xb80
[ 2584.336611] LR [c000000000a4eab0] btrfs_remove_chunk+0x530/0xb80
[ 2584.336662] Call Trace:
[ 2584.336684] [c00000000e247a40] [c000000000a4eab0] btrfs_remove_chunk+0x530/0xb80 (unreliable)
[ 2584.336754] [c00000000e247b60] [c000000000a4f278] btrfs_relocate_chunk+0x178/0x1c0
[ 2584.336815] [c00000000e247be0] [c000000000a5045c] btrfs_balance+0x103c/0x1560
[ 2584.336878] [c00000000e247d70] [c000000000a509d4] balance_kthread+0x54/0x90
[ 2584.336931] [c00000000e247da0] [c0000000002173cc] kthread+0x1bc/0x1d0
[ 2584.336999] [c00000000e247e10] [c00000000000d6ec] ret_from_kernel_thread+0x5c/0x70
[ 2584.337059] Instruction dump:
[ 2584.337091] 7c0004ac 71490008 40820050 2f9efffb 419e0028 2f9effe2 419e0020 3c62ff9f
[ 2584.337158] 7fc4f378 38633028 4b7848ad 60000000 &lt;0fe00000&gt; 48000024 60000000 4800001c
[ 2584.337226] irq event stamp: 0
[ 2584.337256] hardirqs last  enabled at (0): [&lt;0000000000000000&gt;] 0x0
[ 2584.337306] hardirqs last disabled at (0): [&lt;c0000000001cfb0c&gt;] copy_process+0x76c/0x1c00
[ 2584.337366] softirqs last  enabled at (0): [&lt;c0000000001cfb0c&gt;] copy_process+0x76c/0x1c00
[ 2584.337426] softirqs last disabled at (0): [&lt;0000000000000000&gt;] 0x0
[ 2584.337475] ---[ end trace ab9bdd82f0a5e6a6 ]---
[ 2584.337516] BTRFS: error (device vdi) in btrfs_remove_chunk:3067: errno=-28 No space left
[ 2584.337574] BTRFS info (device vdi): forced readonly
[ 2584.337632] BTRFS info (device vdi): 2 enospc errors during balance
[ 2584.337683] BTRFS info (device vdi): balance: ended with status: -30
[ 2594.600530] BTRFS: device fsid a05d487c-e808-456a-abb6-fc4c0b9bee35 devid 1 transid 219 /dev/vdd scanned by btrfs (25326)
[ 2594.601875] BTRFS: device fsid d3c4fb09-eea2-4dea-8187-b13e97f4ad5c devid 4 transid 145 /dev/vdf scanned by btrfs (25326)
[ 2594.602354] BTRFS: device fsid d3c4fb09-eea2-4dea-8187-b13e97f4ad5c devid 3 transid 145 /dev/vde scanned by btrfs (25326)
[ 2594.602841] BTRFS: device fsid d3c4fb09-eea2-4dea-8187-b13e97f4ad5c devid 1 transid 145 /dev/vdb scanned by btrfs (25326)
[ 2594.623442] BTRFS info (device vdd): disk space caching is enabled
[ 2594.623521] BTRFS info (device vdd): has skinny extents
[ 2594.623567] BTRFS warning (device vdd): read-write for sector size 4096 with page size 65536 is experimental

-ritesh
