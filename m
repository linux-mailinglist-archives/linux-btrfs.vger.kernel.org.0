Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F0A3F7EBF
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 00:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhHYWqs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Aug 2021 18:46:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:34423 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229642AbhHYWqr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Aug 2021 18:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629931558;
        bh=fOpoizv0OMXviuJPooC31IUQhxQOMKE1o4OgchiGGcI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GClca8fV5PPqVQbcx9ZCmOMEVDJcciIwnv41xTr9iIyikiIPJ2Fu0HmlTT6YS18dQ
         k5dyQ8CiyZX5FrmAugIZ3aX8Lkk4/z8fKaHy/s2u1AiCFW6KgbxqcX3xQo0i018GwF
         D109IqFGY0ZtMp1ssKJyAi88k5huEgJwZWEO8MOs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5wLT-1mPMWD024R-007REV; Thu, 26
 Aug 2021 00:45:58 +0200
Subject: Re: [PATCH] fstests: btrfs/246: add test case to make sure btrfs can
 create compressed inline extent
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210825061923.13770-1-wqu@suse.com>
 <CAL3q7H6eaGgL8e3OPQMOb-E9wKR5JQTV5pzEAsMvbaSCpZY1rA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <83400e51-4271-5140-bddf-ae8eb5cafc13@gmx.com>
Date:   Thu, 26 Aug 2021 06:45:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H6eaGgL8e3OPQMOb-E9wKR5JQTV5pzEAsMvbaSCpZY1rA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yG8N4qHJ1L4j3f05f60ZLhiIL0mwLodYVYxT6OO16epPsJ+9bzs
 zCWVaYfn48S4N7zfZ3xbJxw8yHZKo2tHvhRmwWYmVgZ8SxjQMthLbgutNXLpl7siK8OsxbB
 rRknGhuuBDljrNgIScYetQkMMclQSjs6AceBlmKVyPvuzwGKlyRSICP1AsuBfJ0HK0aYyz0
 ioN0axP2k8BavhDKLjKlA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HjnTdToMk4E=:o3hYwrpup63hsAw61hFD/s
 DZb9feRtuo1+0uQAAbygQ92DE3GLbaHMFxFKAX4l7tNf3c6CmNBb3pgPgaeRBhxmGIOBMHNsk
 7EcAPC/KyJO0Q64J4UmQNTL6ud5wKBpqEOVu1T1tRDiKyGXuWOaPbe7a8Ukz7rlS9qYB9hjLH
 64XLzTqWC3UvsU4KMRNqhdA48WBkN7RQfmnakvwf+UP/HFX3AZceqLjUYla9Bmnw67EglLzoK
 ZU3dkzMyDkwWjZYUHnIPFMTWgzoUGeYcdHOdZDd/fm4BSCDau4taBug0tDvJGal4eSsIDDNYc
 AmPQIcYNqWHmFmWRhBWfFAjK2/BrUkGNnQcnoARkQ3+Be2a5ldXkwiJ4RYBoyIatmI+2xbJ3s
 ufVOGIoHRKKQcDs4plbkFu9eGAB1GPyLUzpYbqsFLXH2Y5UnKbNyfpXRQ0d0wSAfokWjtkhk8
 6n6peJCceaEPnSJ/us9dbamflLtaDNom8qU/Mq7cyy6aNQ0MlEbxXKHaENYg5MFGhtVePp0ov
 EnT4GgZpraqWVJmsF+WOORKjcYDyt4fNoheXT7I7CPR3yM4VQTX6e5VQRy/W+Clw/MjauECKW
 Rplaktf3arrVB0wvyGdJeLNhDxiTuu8S1JCLkkAbJm0DZXMqod8K743hh9ZBIm3z/IidVOKgk
 74ON4YtcJZZQQ+7Iu3KLw21D55IRSlgTZob6Y7BSASlpRxI2xHvAhx/Cb1GPN+hGC/Nwhp/Dr
 CfJB6Uvyr76ozJwOe+7I0y4WxRRbX13UpO9XF5egvBtPUZBOyusGVRQ1D0d0SHnNJ4P3tPSV/
 yfA99bwpEtASuOgHrqRE9brjHVfRYlDC8YruvaFDfcJub63Yjik2vu2cKbOXp8tQd+GnFlQrh
 IHyQ+G8iBe8MJ7qLh0zrMQX3Q06LG6pUrFkYmHDtgPSXq3O8m7qnR3gTUhG0m9Cc4VL+S9Yuj
 eY4MojGCuxp5s6P7pq3K49miKVhb1tHrpwJMy2r2ahO7naYqwFhzUTd8V4AhUMB9Y0cN6Vb+O
 SE/EJsPB+jXh0Pusb5R0D5xuFntAoeaWyZG+ASxduY9boOVwzf3CMcntMw5cRhkxo3PIqwYAh
 SwIwFw/MALjwlZUu+8lbbe44OxsQou10kgbjYcvdHS73Kzwct6DgXaSKg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/25 =E4=B8=8B=E5=8D=8810:24, Filipe Manana wrote:
> On Wed, Aug 25, 2021 at 7:19 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Btrfs has the ability to inline small file extents into its metadata,
>> and such inlined extents can be further compressed if needed.
>>
>> The new test case is for a regression caused by commit f2165627319f
>> ("btrfs: compression: don't try to compress if we don't have enough
>> pages").
>>
>> That commit prevents btrfs from creating compressed inline extents, eve=
n
>> "-o compress,max_inline=3D2048" is specified, only uncompressed inline
>> extents can be created.
>>
>> The test case will use "btrfs inspect dump-tree" to verify the created
>> extent is both inlined and compressed.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/btrfs/246     | 50 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>   tests/btrfs/246.out |  2 ++
>>   2 files changed, 52 insertions(+)
>>   create mode 100755 tests/btrfs/246
>>   create mode 100644 tests/btrfs/246.out
>>
>> diff --git a/tests/btrfs/246 b/tests/btrfs/246
>> new file mode 100755
>> index 00000000..15bb064d
>> --- /dev/null
>> +++ b/tests/btrfs/246
>> @@ -0,0 +1,50 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
>> +#
>> +# FS QA Test 246
>> +#
>> +# Make sure btrfs can create compressed inline extents
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick compress
>> +
>> +# Override the default cleanup function.
>> +_cleanup()
>> +{
>> +       cd /
>> +       rm -r -f $tmp.*
>> +}
>> +
>> +# Import common functions.
>> +. ./common/filter
>> +# For __populate_find_inode()
>> +. ./common/populate
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_require_scratch
>> +
>> +_scratch_mkfs > /dev/null
>> +_scratch_mount -o compress,max_inline=3D2048
>> +
>> +# This should create compressed inline extent
>> +$XFS_IO_PROG -f -c "pwrite 0 2048" $SCRATCH_MNT/foobar > /dev/null
>> +ino=3D$(__populate_find_inode $SCRATCH_MNT/foobar)
>> +_scratch_unmount
>> +
>> +$BTRFS_UTIL_PROG inspect dump-tree -t 5 $SCRATCH_DEV | \
>> +       grep "($ino EXTENT_DATA 0" -A2 > $tmp.dump-tree
>> +echo "dump tree result for ino $ino:" >> $seqres.full
>> +cat $tmp.dump-tree >> $seqres.full
>> +
>> +grep -q "inline extent" $tmp.dump-tree || echo "no inline extent found=
"
>> +grep -q "compression 1" $tmp.dump-tree || echo "no compressed extent f=
ound"
>> +
>> +echo "Silence is golden"
>
> While here, we could also check that we are able to read exactly what
> we wrote before, after evicting the page (e.g. after a call to
> _scratch_cycle_mount).

Nice idea.

Will update the test case soon.

Thanks,
Qu
> Other than that, it looks ok.
>
> Thanks.
>
>
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/246.out b/tests/btrfs/246.out
>> new file mode 100644
>> index 00000000..287f7983
>> --- /dev/null
>> +++ b/tests/btrfs/246.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 246
>> +Silence is golden
>> --
>> 2.31.1
>>
>
>
