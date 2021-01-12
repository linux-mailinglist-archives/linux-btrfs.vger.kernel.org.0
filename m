Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657472F2E9E
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 13:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbhALMEv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 07:04:51 -0500
Received: from mout.gmx.net ([212.227.15.15]:47061 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730436AbhALMEv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 07:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610452996;
        bh=EMgF7yLjb0eEVb3m5TqhdmKdqKSqBrzWTquS9IeLapI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=A9+2V1JXi8gwBdVrU/ltxzVV13hTePvMxStdYn85KlOx6lAqH8Th4bu080kIsGKuC
         QfRokDymp9IoTaPJ/fXoHnPF13DiACtsiUA4djB5+ebqDwsPRCLWG0YOXYVL/yE6bX
         QEMRswVX69yLYpMrkMIKdbPvFIDNskspxo9Zy//g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MStCe-1kWGYm29YU-00ULJA; Tue, 12
 Jan 2021 13:03:16 +0100
Subject: Re: [PATCH v2] fstests: btrfs: check qgroup doesn't crash when beyond
 limit
To:     Filipe Manana <fdmanana@suse.de>, Qu Wenruo <wqu@suse.com>,
        fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20210112074024.85020-1-wqu@suse.com>
 <e1633b76-6c66-ec76-d7ff-427d8c3cba92@suse.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <af7ebf4d-3564-6d60-67ff-04db6cb169b9@gmx.com>
Date:   Tue, 12 Jan 2021 20:03:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <e1633b76-6c66-ec76-d7ff-427d8c3cba92@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W8rKDa1ZC8+QRHXTezKlBx8xTYGQu9/eeZa10vdDxTxY2rNvoeM
 LNGFoIFMikAmWUt/eOyOw+lN54Y5dh6tbmWw0e/ZxyzBvdgeMKcNJaxEO5lFNK8znATcCaI
 kf31JQnGd+WreDoQNgpRlRFyiXHzqJEl//aOU53DoDNVwVCUMbV6dHzFDRQeg25Hho0EQNH
 qfR0eM6PiJbZbRR7agaNQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sog7rpdQCqE=:HeDVQAXFn+moRR4aeekfbJ
 Y8awJUbH/yTka58UN5q2EvHv4LYHbjVsMwolITNFA04eP5XNh4x56+rBK7f9ligQ+jy9xyQQs
 AwAVn9l+1FssXNMdpBlg+bX9PfL2GX+1SRskNwn+VrhzSjy61oetoE0tsSspTbZy9ozxNZrJH
 Je3jphoXhA3jbB+6nB7efYF1zPn3hOBaGdYVSme0CEUZQb9Pd417gyDzY1hq6rhSBE2xnP4hJ
 79rXw6vgdz58T9Vwx/zhYUZnoYN3elT6rblPfYbU/wOk4464JZf+UPsiH9ekye0pzj0DINORx
 PpiIanVt74yr1f5PIMIRJHjNDtNhe0S4BMGrW7inR9pNsm+voHUUGhLBHKHV4wy1KVCE/lh+Z
 BaRRrGD2Dm99KbLyFzNuhB//Gze/KYAhMP/v/JmovxWsrBlX7SJ763zzEZ5t9GTZXC57zcccH
 9LE3Y5S6i6S8ccK9jxiENc6GTCdBwCSNz7yi8Zjgazml7+A9gMIZ7rEBhAMFR0CheiZ6eHcE4
 uTnxzstG/7RxJzMBoQ6q4fHCQ7/fk8LsJ/fqcO9BCAMIVuS6iACZEWluVVMDZ60kTZIG7SqNC
 bW0n/4zPDYGu0oLOZSUGaO2KEqekuJo5Dlq5zaH4cbtxs4f8EPPHChWbbdHozqB8WWcizz3xr
 jQ2ER63RHH/lSWgQmdnYqzIWlpoqopmGR+b00/om98niDwSPMTqEdushRU+U+58buZ2jEq42r
 h2RpfpNc7N3sCtFZ9MrHO/xJ4wzVgdouDPodIdUIvLmAKLl0+LFEbjc4fSes/VYKdTxzg/rhg
 p1Gduj2FJli5G8y2i/ABCUePFNbRhMS2rgmFuq08ERiI4pD5f6zwD2yI+467k4vZSxO16IIaU
 C4CKcMSMrwnDOsIJMcvA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/12 =E4=B8=8B=E5=8D=887:36, Filipe Manana wrote:
>
>
> On 12/01/21 07:40, Qu Wenruo wrote:
>> There is a bug that, when btrfs is beyond qgroup limit, touching a file
>> could crash btrfs.
>>
>> Such beyond limit situation needs to be intentionally created, e.g.
>> writing 1GiB file, then limit the subvolume to 512 MiB.
>> As current qgroup works pretty well at preventing us from reaching the
>> limit.
>>
>> This makes existing qgroup test cases unable to detect it.
>>
>> The regression is introduced by commit c53e9653605d ("btrfs: qgroup: tr=
y
>> to flush qgroup space when we get -EDQUOT"), and the fix is titled
>> "btrfs: qgroup: don't commit transaction when we have already
>>   hold a transaction handler"
>
> By the way, the patch subject changed to
>
> "btrfs: qgroup: don't commit transaction when we already hold the handle=
"
>
> and it's already in Linus' tree, so its commit hash should be referenced=
.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D6f23277a49e68f8a9355385c846939ad0b1261e7

Yeah, forgot the fix is already merged.

Hopes Eryu can handle it so I don't need to send a v3 version.

Thanks,
Qu
>
> Thanks for refreshing it.
>
>
>
>>
>> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1178634
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Use "0/5" to replace the double "$SCRATCH_MNT" in btrfs qgroup comman=
d
>>    To reduce confusion.
>> ---
>>   tests/btrfs/228     | 59 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>   tests/btrfs/228.out |  2 ++
>>   tests/btrfs/group   |  1 +
>>   3 files changed, 62 insertions(+)
>>   create mode 100755 tests/btrfs/228
>>   create mode 100644 tests/btrfs/228.out
>>
>> diff --git a/tests/btrfs/228 b/tests/btrfs/228
>> new file mode 100755
>> index 00000000..ecca3181
>> --- /dev/null
>> +++ b/tests/btrfs/228
>> @@ -0,0 +1,59 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2020 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 228
>> +#
>> +# Test if btrfs qgroup would crash if we're modifying the fs
>> +# after exceeding the limit
>> +#
>> +seq=3D`basename $0`
>> +seqres=3D$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=3D`pwd`
>> +tmp=3D/tmp/$$
>> +status=3D1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +_supported_fs btrfs
>> +
>> +# Need at least 2GiB
>> +_require_scratch_size $((2 * 1024 * 1024))
>> +_scratch_mkfs > /dev/null 2>&1
>> +_scratch_mount
>> +
>> +_pwrite_byte 0xcd 0 1G $SCRATCH_MNT/file >> $seqres.full
>> +# Make sure the data reach disk so later qgroup scan can see it
>> +sync
>> +
>> +$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
>> +$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
>> +
>> +# Set the limit to just 512MiB, which is way below the existing usage
>> +$BTRFS_UTIL_PROG qgroup limit  512M 0/5 $SCRATCH_MNT
>> +
>> +# Touch above file, if kernel not patched, it will trigger an ASSERT()
>> +#
>> +# Even for patched kernel, we will still get EDQUOT error, but that
>> +# is expected behavior.
>> +touch $SCRATCH_MNT/file 2>&1 | _filter_scratch
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/228.out b/tests/btrfs/228.out
>> new file mode 100644
>> index 00000000..9c250148
>> --- /dev/null
>> +++ b/tests/btrfs/228.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 228
>> +touch: setting times of 'SCRATCH_MNT/file': Disk quota exceeded
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index 1868208e..9b0dc5ca 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -230,3 +230,4 @@
>>   225 auto quick volume seed
>>   226 auto quick rw snapshot clone prealloc punch
>>   227 auto quick send
>> +228 auto quick qgroup limit
>>
