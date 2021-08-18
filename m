Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52463EF9EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 07:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbhHRFS3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 01:18:29 -0400
Received: from mout.gmx.net ([212.227.17.22]:45905 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhHRFS2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 01:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629263870;
        bh=kq8x7szJDMF5QDZ4FReFnrQLmrW0bwkiT7aBbw7GX2A=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZARGD2rSMzLWAACgYdFlr/noh9hEH4SZhOBecpGMzPR23c/90ebRusz/HJIIefgxu
         uMYvzEVbFsSdUj8bxsqTFSWIDCkop2A3UWsCZ7lksbFR4i/ZVtuuLTpUDSkhywswLV
         6yihmgD80cvbcfu7SohuGTlXoVh5yEBNqdbO9JqA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0X8u-1n1Qin3NMy-00wUmb; Wed, 18
 Aug 2021 07:17:50 +0200
Subject: Re: [PATCH] btrfs-progs: Drop the type check in
 init_alloc_chunk_ctl_policy_regular
To:     dsterba@suse.cz, Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
References: <20210809182613.4466-1-mpdesouza@suse.com>
 <20210817132419.GK5047@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <04abaf84-12e3-3983-dee4-a5073ec786f1@gmx.com>
Date:   Wed, 18 Aug 2021 13:17:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817132419.GK5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bTobMJ3kBB8ZUTMAyNjmLwydwUqdEeI16ltAx0LpPgK3E9qYmzZ
 4IcVSH+CZBQcsinkWaCBKSZIwOwk/Vdw+o+cG81ApxwVuFcu0lq5K/WO52Lzb1CipLQJSqZ
 GVEnlb8XO90Xxie9OdwL8YRtqToP7izB+LM910Lz3Tvmn3BkuZg04MrUNpqvDqDB+Eqawda
 y2isnY+nX11n+s/lfUuxQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kCg3+9tDzBI=:Tqw0We/hIm+vZ4Yf0xqLke
 wyM7ubQI+vyFMxZbBNfYNwhztfIiWj7dcCw7QzXGXHxX/en/NRM4EEjDaV58tkUfsVfN60mak
 1RgbdPFxr33Jg7B+i5+hkcgsv+I87/WFsHpEIVpGkYUkRCDHaUsEfJjrd9UMBrXuK3lbk9ry1
 2fZKSAkStPFHMFrkZ1AdUgqmEpEHsXyXEx6ylTJrLCaJqvXPNRnU96i4o3YpnhMER7Ow0Fms/
 ySkZqGH8WgUIWjzF4YwaUBwzjBVA7wWoURjFLKoxEpc7eJz/rTQs3agxoLh+dD8XjtCSyu7fh
 4DdtaXvt0JCzsm62ssnnkzBbYZ8FJp1ECUA4cZEiZi23vLJk0XHJDIjUL9YSCRWy/pFdCMAIR
 oHQXrjiIAhIAJ/+HusDWebog+TthkJGnxecNwbxLYRR5e+H5ePx1xUZKoRYN6bIGuk7I5TFpB
 KAmMNvfBdQwuKkfdCgEpMmLb32HBGB4cWvIPwteHGAGME185P53qb/Rcp15NVvEeznnwqX5af
 2ZYnNRtZT1uo9MpPOqKrHFJzOkRmZERZStAt0lBwtLn57yCJD05nG4hZC3t0q9M1kExs8MClv
 tlv40133chCDo6ij9dRsTU6cRshElsdFVLFLdS/ChC0pez63sFxc7WhgSxMB9DPgMwYbVYbB8
 up9pt9K6l946vxN/KdFQDJiRIP0mMF7mHukdlh/dtYG2K1kqknJJiyoGfTNl6lGwU/vxoUIdI
 AnZMIEzTHBZjZ90CRXeBDRvyNLQsGnQw56gk8qZHliuZBq/ok4RiXKp+87TgAaUuRIujwY8Xw
 BKvh7vIdB5mVrs9KlZXe1SrSGAwpjISz8FTO6L9HKN9/UaYihT//eMFJSnhsGWAIRmAxWKE11
 oR1q2LK2jOg0I13emjbZdGeyfeIG/f6TxaO/vX1jRDWHgfxOzEu4dDtmWKuAPYPIjKoA+Olj3
 x06V9B97GTjODSEKgS6nAzDSzb3x3eiqRp2mwULQRxeS9xYQCRLcFqMZklkRc6IAZwtyelER/
 FVjsz0edpA74j+63KwUe7Mc9atjKunVBZdYrzbNiSQ115B5+sbooHOs4yL9Cj9GJT16OMX5Rc
 rr04lVEjAtGtZ3/ZR+07B7LbILghbh33T6O5T0+u7XHfdIJlx4V2HDD/w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/17 =E4=B8=8B=E5=8D=889:24, David Sterba wrote:
> On Mon, Aug 09, 2021 at 03:26:13PM -0300, Marcos Paulo de Souza wrote:
>> [PROBLEM]
>> Our documentation says that a DATA block group can have up to 1G of
>> size, or the at most 10% of the filesystem size. Currently, by default,
>> mkfs.btrfs is creating an initial DATA block group of 8M of size,
>> regardless of the filesystem size. It happens because we check for the
>> ctl->type in init_alloc_chunk_ctl_policy_regular to be one of the
>> BTRFS_BLOCK_GROUP_PROFILE_MASK bits, which is not the case for SINGLE
>> (default) DATA block group:
>>
>> $ mkfs.btrfs -f /storage/btrfs.disk
>> btrfs-progs v4.19.1
>> See http://btrfs.wiki.kernel.org for more information.
>>
>> Label:              (null)
>> UUID:               39e3492f-41f2-4bd7-8c25-93032606b9fe
>> Node size:          16384
>> Sector size:        4096
>> Filesystem size:    55.00GiB
>> Block group profiles:
>>    Data:             single            8.00MiB
>>    Metadata:         DUP               1.00GiB
>>    System:           DUP               8.00MiB
>> SSD detected:       no
>> Incompat features:  extref, skinny-metadata
>> Number of devices:  1
>> Devices:
>>     ID        SIZE  PATH
>>      1    55.00GiB  /storage/btrfs.disk
>>
>> In this case, for single data profile, it should create a data block
>> group of 1G, since the filesystem if bigger than 50G.
>>
>> [FIX]
>> Remove the check for BTRFS_BLOCK_GROUP_PROFILE_MASK in
>> init_alloc_chunk_ctl_policy_regular function. The ctl->stripe_size is
>> later on assigned to ctl.num_bytes, which is used by
>> btrfs_make_block_group to create the block group.
>>
>> By removing the check we allow the code to always configure the correct
>> stripe_size regardless of the PROFILE, looking on the block group TYPE.
>>
>> With the fix applied, it now created the BG correctly:
>>
>> $ ./mkfs.btrfs -f /storage/btrfs.disk
>> btrfs-progs v5.10.1
>> See http://btrfs.wiki.kernel.org for more information.
>>
>> Label:              (null)
>> UUID:               5145e343-5639-462d-82ee-3eb75dc41c31
>> Node size:          16384
>> Sector size:        4096
>> Filesystem size:    55.00GiB
>> Block group profiles:
>>    Data:             single            1.00GiB
>>    Metadata:         DUP               1.00GiB
>>    System:           DUP               8.00MiB
>> SSD detected:       no
>> Zoned device:       no
>> Incompat features:  extref, skinny-metadata
>> Runtime features:
>> Checksum:           crc32c
>> Number of devices:  1
>> Devices:
>>     ID        SIZE  PATH
>>      1    55.00GiB  /storage/btrfs.disk
>>
>> Using a disk >50G it creates a 1G single data block group. Another
>> example:
>>
>> $ ./mkfs.btrfs -f /storage/btrfs2.disk
>> btrfs-progs v5.10.1
>> See http://btrfs.wiki.kernel.org for more information.
>>
>> Label:              (null)
>> UUID:               c0910857-e512-4e76-9efa-50a475aafc87
>> Node size:          16384
>> Sector size:        4096
>> Filesystem size:    5.00GiB
>> Block group profiles:
>>    Data:             single          512.00MiB
>>    Metadata:         DUP             256.00MiB
>>    System:           DUP               8.00MiB
>> SSD detected:       no
>> Zoned device:       no
>> Incompat features:  extref, skinny-metadata
>> Runtime features:
>> Checksum:           crc32c
>> Number of devices:  1
>> Devices:
>>     ID        SIZE  PATH
>>      1     5.00GiB  /storage/btrfs2.disk
>>
>> The code now created a single data block group of 512M, which is exactl=
y
>> 10% of the size of the filesystem, which is 5G in this case.
>>
>> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>> ---
>>
>>   This change mimics what the kernel currently does, which is set the s=
tripe_size
>>   regardless of the profile. Any thoughts on it? Thanks!
>
> Makes sense to unify that, it works well for the large sizes. Please
> write tests that verify that the chunk sizes are correct after mkfs on
> various device sizes. Patch added to devel, thanks.
>

It in fact makes fsck/025 to fail, bisection points to this patch
surprisingly.

Now "mkfs.btrfs -f" on a 128M file will just fail.

This looks like a big problem to me though...

Thanks,
Qu
