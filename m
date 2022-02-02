Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEA84A690A
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 01:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243313AbiBBAGC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 19:06:02 -0500
Received: from mout.gmx.net ([212.227.15.19]:53173 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243437AbiBBAFR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Feb 2022 19:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643760314;
        bh=0R6z4AK+/y0hxAeOLZsD/N+Sdg3msmU6ETctovrba9Y=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=FvLGOc/FRz/1m7TWxsvd+JAknAbUy7eYIMiKq+PxVA9yGByZjy34JsLrqajyzWkrO
         piwsuygNzRrGC8JJc5A2aAupLVYI0zkcQW6IA5QXECFSMtzs9M2S4pc4vJdjROMRBC
         erx1NgbF4gsXu0QzWmId6FBiKCbSwjyCkX6Uj1zU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MFKGZ-1mzQ4e2jEn-00Fhus; Wed, 02
 Feb 2022 01:05:14 +0100
Message-ID: <f5300711-4bf5-5807-6d0e-bcc6ecca3fed@gmx.com>
Date:   Wed, 2 Feb 2022 08:05:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 2/3] btrfs: defrag: don't defrag extents which is
 already at its max capacity
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1643354254.git.wqu@suse.com>
 <6da08401ba111e490c45c64fba3f9f60538d0fb8.1643354254.git.wqu@suse.com>
 <20220201150305.GQ14046@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220201150305.GQ14046@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OL/wSaA3T7At3tL8N9MsitAj0XTs9bAobv180XxIV7GI6rETS5O
 R7y+DIl8LhLPe6FpQsNO/fTShTniHfjYb5uk1NMfHGWHacvYWlVcO/vTPcUNq0bs3SVppJq
 BMR0ZxjOJ6MRb8Xoqk7kpmM1ZHElGXroV+DUiTl2khPUDllElcZC6uH2Sh8LvWiHolHjycR
 nREkAo1/0Ia8PbO1DzDPQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1Q0/uEGOxD8=:hAYsyH3TubmL8R6hQt6Yny
 99e69qd7GuLU7ArtJq40GyIfTQHmZqNt2khIfcZ3CIDnaMAWEVxTrHc1Ri6864F3CPBo3Wo7Y
 CxIm+8G0Lvq2fEiKRa0GAlQco3V+lnKDXHrJTkPSIJcaP5s8G99eCDxHdWUtQJVno7Ttq0FHO
 jb3Fltb0Wyb+deptrmIkcLRvI5tN6PdDczL2/Q0y/YbscvjJFs2hBcgA6l+msC8Wbj6Gs7IHf
 71ZH/Av9Mtmeg86kvI/6j3+QTKjWxZuULxQ/ynvXzLSQ6I85/7OHVAMogJqDq8Wk7aqgFUO58
 Y57f1AExk8mukTHTEtLDuzrSUqMF0V8hcxxgj/I8SIXfuD8SysnRkW7i29myjGUb7B2YDrb0u
 TcLfRzZeQ269993+zcM3XsU1TTWDv5PJYnzwTdTs6ZP7DWKHJZHRGsvi0KEL1gB9t7YTtFFg6
 +qOZwtt+xZRxl3svVJX3Rn4CBtrR5eepWATkqa1y/nMA8XB03efPW5JwmS6HMRONIOFouzlVp
 Es/TEAwry4qrSKbC+s8O2MORsGonOoE1noLhxObo7Ecbeo9bJqTFSd6286VSbKoqPP6i5kMBO
 6oeS3r9fWI1JH0Yd1GQIAIgjrc69yvA5JcV6h/1plL+8K2RC6zkDzK7xu/q7x9Jo0r8tvOhfW
 S7MLGMU6lc1HHTyjz3OgegYXyFXyFl0qhv55/DTX5mZQCE7/LGBY0TQglN+LgbZPErGSXbOJh
 XC/8hO44Xvm5aLVWqVV4ScSiIbJf6BgDm/sDgAXFDvub2AzxwPEn6ekCykXM04KluRyQ5Pdun
 u5XrDwD8WI2muxB2UwvvbALhzqQ7cBkpv6PaQmURziiahtDS7kvMxzfvRtpCCh9kzbpVM/IHW
 X3sXcVQZa47GlEtqom4C1S2+9sMlBogF1mfEF8v+++IovUM1Dt3R7A8XGMYQOZVq9nkMI7s+6
 qKLzr/MMdeTeS+W4CMb00RQHz0dIsqle17uGRe5xHoXXQM69afyAD2nhODrYEeBDo9dRAVnsm
 7wp5VPmqaekauPZz9McqsU/YX/QqoPWNm4xH+E4sTq72+fzWZe5fkv23u7nRzkNf5v45VG2Jp
 FzqmmHsuQslLKM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/1 23:03, David Sterba wrote:
> On Fri, Jan 28, 2022 at 03:21:21PM +0800, Qu Wenruo wrote:
>> [BUG]
>> For compressed extents, defrag ioctl will always try to defrag any
>> compressed extents, wasting not only IO but also CPU time to
>> compress/decompress:
>>
>>     mkfs.btrfs -f $DEV
>>     mount -o compress $DEV $MNT
>>     xfs_io -f -c "pwrite -S 0xab 0 128K" $MNT/foobar
>>     sync
>>     xfs_io -f -c "pwrite -S 0xcd 128K 128K" $MNT/foobar
>>     sync
>>     echo "=3D=3D=3D before =3D=3D=3D"
>>     xfs_io -c "fiemap -v" $MNT/foobar
>>     btrfs filesystem defrag $MNT/foobar
>>     sync
>>     echo "=3D=3D=3D after =3D=3D=3D"
>>     xfs_io -c "fiemap -v" $MNT/foobar
>>
>> Then it shows the 2 128K extents just get CoW for no extra benefit, wit=
h
>> extra IO/CPU spent:
>>
>>      =3D=3D=3D before =3D=3D=3D
>>      /mnt/btrfs/file1:
>>       EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>>         0: [0..255]:        26624..26879       256   0x8
>>         1: [256..511]:      26632..26887       256   0x9
>>      =3D=3D=3D after =3D=3D=3D
>>      /mnt/btrfs/file1:
>>       EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>>         0: [0..255]:        26640..26895       256   0x8
>>         1: [256..511]:      26648..26903       256   0x9
>>
>> This affects not only v5.16 (after the defrag rework), but also v5.15
>> (before the defrag rework).
>>
>> [CAUSE]
>> >From the very beginning, btrfs defrag never checks if one extent is
>> already at its max capacity (128K for compressed extents, 128M
>> otherwise).
>>
>> And the default extent size threshold is 256K, which is already beyond
>> the compressed extent max size.
>>
>> This means, by default btrfs defrag ioctl will mark all compressed
>> extent which is not adjacent to a hole/preallocated range for defrag.
>
> Is this wrong for all cases though? With your change compressed extents
> would never get defragmented, while the defragmentation ioctl allows to
> change the compression algorithm, so that's a loss of functionality.

Nope, firstly only 128K compressed extents will get skipped.
Smaller compressed extents will still be defragged.

Secondly, in defrag_collect_targets(), the check against max capacity is
after the check for compression conversion.
Meaning for the compression algo change, it will not take max capacity
into consideration anyway.

>
> And I think we can't do that even conditionally if the algorithm is
> different, because what if we want to recompress a file with higher
> level of the same algorithm? As the level not stored anywhere the defrag
> ioctl can't decide which extents to skip to save work.

The check is not based on compression algorithm, it's a flag in the
defrag ioctl parameter.
If that DEFRAG_RANGE_COMPRESS parameter is set, we won't bother a lot of
things (including max capacity, next mergeable, etc) but directly mark
the range for defrag.

Thanks,
Qu
