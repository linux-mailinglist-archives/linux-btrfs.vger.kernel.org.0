Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E5A4B7BD8
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Feb 2022 01:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242069AbiBPAXb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Feb 2022 19:23:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbiBPAXa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Feb 2022 19:23:30 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A091F70DB
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Feb 2022 16:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644970982;
        bh=EO/Mzu74BcaQ9g0ZBgVEYvTXYGQrd2MIwJPein9VVlQ=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=Nnet8d6Skv9Bsn819sTSQyiZRua172mklGhZS4mhXUjSCjlOSs+Wa/ejpaenObE5o
         nKSR2skWPqi3QO+NIDXi6NgXhcDz+A4iZxILmnzatsOlYrIwzAFTLKs5QD1uYNFqxh
         OcMi+2FH2s/MdIY+tXykTLzpcLPcgyk9+ELr++o4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N5G9n-1oJ0RE21Sf-011B5l; Wed, 16
 Feb 2022 01:23:02 +0100
Message-ID: <c43c5945-3c3a-0dee-a998-9e76c3eb0289@gmx.com>
Date:   Wed, 16 Feb 2022 08:22:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Content-Language: en-US
To:     kreijack@inwind.it, Josef Bacik <josef@toxicpanda.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        linux-btrfs@vger.kernel.org
References: <cover.1643228177.git.kreijack@inwind.it>
 <7e5e75ed-86b4-a629-09c9-29202f93b4b6@inwind.it>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 0/7][V11] btrfs: allocation_hint
In-Reply-To: <7e5e75ed-86b4-a629-09c9-29202f93b4b6@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fLkQoYkbc18svfpAj06KZ5jSYEfViNmKjrJ4/XwzQtvY4Zo1n6z
 JtCUE6dPlPtAFjUSpmrtYFoy8h837JjfOCGmpme98shbafhyB1Blf/UMjqPtgmKrtwQDJKh
 YHwGg1G3IxeaKwfg02lS47A65oNeqwFNqG7S/VcTOHGgJmyycr/EEyybVlGX8RvMVRZkTJM
 wH2zZWqnpcZnAJwPv2a2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UOsPWuVRaN0=:plQyFG/B6/MQ/kvgc8Iu2m
 67ycyyGWEAHa1QsQTClAKdrLuqJeoq6RIfMpkp0ikOBNuEJL4xePVaAlyliiY03X76/uMIJo3
 IX4jcJnT9Ns9aExZKCzbLFvO34VpmaRemPw5PBSIP7DrOOD9kSmLgr67kTBR6Lytvx2M+9XqK
 w8KI4rcBIKg2WUklXlEgDT/byKN1ITfp5TRGMqQicgGGY1HVYnJyC5syOe/I2KphCXg3btX8k
 z/DLZTyAy1gpnXRkqrO4/9Bcer8xizta7OLtUfMy/Ly0ITIuAmfKJwU6CHO6TDXJPXJQUuCHT
 T8vsouf7WQVBI5l2BiZsG+kW3puARdqaDZNayAbkYs/H03tCMm/V/7nAepWqnJ/RVRj/J37n6
 pgpnw8LmD54cXmQnPGAl61oE5AbG0XmjjrutDKTPyXSLM/YZKOVuxvLTdzny44gvSECWzGkYg
 SxblBZUkxKB7rI1G5tRPp/8Bud4FyZDbc9SwuiCb1/HARO0mlMenqr7B/I2yJoywtvxzJXqBM
 7ysYVQTIYsKQ1GChy2zR72PiIwoonvRjgog6KiyPYm0lyV2r1YzyoEgGPgF7s47SAViodtFnG
 5ou7VZX2Gd+RXDZCdhTvyxNdPN2/jIqNe82k2YrEAllnlALg0Q7sSkJJNtfTemeDC5FqyqhY1
 9WESeC7AYeUtiGhkRwmKgJYgQ+1Kepr9+vgRTPtRkeYHqfjYxFp1TqF05CIZKl6NHYKP5Z3zC
 q0itIz2ukSkL6ut0bliLc20CezFa+6hSQU0bKsex9jmvg2wQOwxi/Ufh0mLc+1iVzsWqqwXl1
 uvZF2joz8E63hUyNhEzOsFk7qWsE0UUU1/ukeOaB6td4nEwPVZ4MIwv+hRoyT6frRQSWE4J3B
 h9EIw4zHYxkDU7Z5Jo64bEDH/0/E0sqd7c656AR2D3oHTXZXHD7so5BLcU8YGJh+KG+tkJsF5
 luzhNzo2dQdi5POW7WRrW0gh13jzQFefaMjpuPpbchKbffa7vFcMQTX3mgy1GYOnzNUSJtKq+
 b84ktW/nNnU7hAJZ3XAHWkpGfcXUZsGJwGugQKjpxu6fjJO1UBcG767OgcneNinsvqNNiPJrd
 2PBdiTxetLrQqw=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/16 02:49, Goffredo Baroncelli wrote:
> Hi Josef,
>
> gentle ping...
>
> few months ago you showed some interest in this patches set. Few of the
> cc-ed person use this patch set.
>
> I know that David showed some interest in the Anand approach (i.e. no
> knobs, but an automatic behavior looking at the speed of the devices).
>
> At the time when I tried this approach in the first attempts, I got the
> complain that the kernel may not know the performance differences of the
> disk (HDD vs SSD vs NVME vs ZONED disk...).

Sorry I didn't check the patches in details.

But I'm a little concerned about how to accurately determine the
performance of a device.

If doing it automatically, there must be some (commonly very short) time
spent to do the test.

In the very short time, I doubt we can even accurately got a full
picture of a device (from sequential read/write speed to IOPS values)

For spinning disks, the sequential read/write speed even change based on
their LBA address (as their physical location inside the plate can
change their linear velocity, since the angular velocity is fixed).

And even for SSD, IOPS can var dramatically due to cache/controller
difference.


For a proper performance aware setup, I guess the only correct way to
fetch performance characteristics is from the (advanced) user.

Or we may need to spent at least tens of minutes to do proper tests to
get the result.

For regular end users, the difference between SSD and HDD is huge enough
and simply preferring SSD for metadata is good enough.

But for more complex setup, like btrfs over LUKS over LVM (even crosses
several physical devices), I doubt if it's even possible to fetch the
correct performance characteristics automatically.

Thanks,
Qu
>
> Comments ?
>
> BR
> Goffredo
>
>
> On 26/01/2022 21.32, Goffredo Baroncelli wrote:
>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>
>> Hi all,
>>
>> This patches set was born after some discussion between me, Zygo and
>> Josef.
>> Some details can be found in
>> https://github.com/btrfs/btrfs-todo/issues/19.
>>
>> Some further information about a real use case can be found in
>> https://lore.kernel.org/linux-btrfs/20210116002533.GE31381@hungrycats.o=
rg/
>>
>>
>> Recently Shafeeq told me that he is interested too, due to the
>> performance gain.
>>
>> In V8, revision I switched away from an ioctl API in favor of a sysfs
>> API (
>> see patch #2 and #3).
>>
>> In V9, I renamed the sysfs interface from devinfo/type to
>> devinfo/allocation_hint.
>> Moreover I renamed dev_info->type to dev_info->flags.
>>
>> In V10, I renamed the tag 'PREFERRED' from PREFERRED_X to X_PREFERRED;
>> I added
>> another devinfo property, called major_minor. For now it is unused;
>> the plan is to use this in btrfs-progs to go from the block device to
>> the filesystem.
>> First client will be "btrfs prop get/set allocation_hint", but I see
>> others possible
>> clients.
>> Finally I made some cleanup, and remove the mount option
>> 'allocation_hint'
>>
>> In V11 I added a new 'feature' file
>> /sys/fs/btrfs/features/allocation_hint
>> to help the detection of the allocation_hint feature.
>>
>> The idea behind this patches set, is to dedicate some disks (the
>> fastest one)
>> to the metadata chunk. My initial idea was a "soft" hint. However Zygo
>> asked an option for a "strong" hint (=3D=3D mandatory). The result is t=
hat
>> each disk can be "tagged" by one of the following flags:
>> - BTRFS_DEV_ALLOCATION_METADATA_ONLY
>> - BTRFS_DEV_ALLOCATION_METADATA_PREFERRED
>> - BTRFS_DEV_ALLOCATION_DATA_PREFERRED
>> - BTRFS_DEV_ALLOCATION_DATA_ONLY
>>
>> When the chunk allocator search a disks to allocate a chunk, scans the
>> disks
>> in an order decided by these tags. For metadata, the order is:
>> *_METADATA_ONLY
>> *_METADATA_PREFERRED
>> *_DATA_PREFERRED
>>
>> The *_DATA_ONLY are not eligible from metadata chunk allocation.
>>
>> For the data chunk, the order is reversed, and the *_METADATA_ONLY are
>> excluded.
>>
>> The exact sort logic is to sort first for the "tag", and then for the
>> space
>> available. If there is no space available, the next "tag" disks set are
>> selected.
>>
>> To set these tags, a new property called "allocation_hint" was created.
>> There is a dedicated btrfs-prog patches set [[PATCH V11] btrfs-progs:
>> allocation_hint disk property].
>>
>> $ sudo mount /dev/loop0 /mnt/test-btrfs/
>> $ for i in /dev/loop[0-9]; do sudo ./btrfs prop get $i
>> allocation_hint; done
>> devid=3D1, path=3D/dev/loop0: allocation_hint=3DMETADATA_PREFERRED
>> devid=3D2, path=3D/dev/loop1: allocation_hint=3DMETADATA_PREFERRED
>> devid=3D3, path=3D/dev/loop2: allocation_hint=3DDATA_PREFERRED
>> devid=3D4, path=3D/dev/loop3: allocation_hint=3DDATA_PREFERRED
>> devid=3D5, path=3D/dev/loop4: allocation_hint=3DDATA_PREFERRED
>> devid=3D6, path=3D/dev/loop5: allocation_hint=3DDATA_ONLY
>> devid=3D7, path=3D/dev/loop6: allocation_hint=3DMETADATA_ONLY
>> devid=3D8, path=3D/dev/loop7: allocation_hint=3DMETADATA_ONLY
>>
>> $ sudo ./btrfs fi us /mnt/test-btrfs/
>> Overall:
>> =C2=A0=C2=A0=C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.75GiB
>> =C2=A0=C2=A0=C2=A0=C2=A0 Device allocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.34GiB
>> =C2=A0=C2=A0=C2=A0=C2=A0 Device unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.41GiB
>> =C2=A0=C2=A0=C2=A0=C2=A0 Device missing:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
>> =C2=A0=C2=A0=C2=A0=C2=A0 Used:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 400.89MiB
>> =C2=A0=C2=A0=C2=A0=C2=A0 Free (estimated):=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.04GiB=C2=A0=C2=A0=C2=A0 (min: 1.04GiB)
>> =C2=A0=C2=A0=C2=A0=C2=A0 Data ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.00
>> =C2=A0=C2=A0=C2=A0=C2=A0 Metadata ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.00
>> =C2=A0=C2=A0=C2=A0=C2=A0 Global reserve:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.25MiB=C2=A0=C2=A0=C2=A0 (used: 0.00B)
>> =C2=A0=C2=A0=C2=A0=C2=A0 Multiple profiles:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>>
>> Data,RAID1: Size:542.00MiB, Used:200.25MiB (36.95%)
>> =C2=A0=C2=A0=C2=A0 /dev/loop0=C2=A0=C2=A0=C2=A0=C2=A0 288.00MiB
>> =C2=A0=C2=A0=C2=A0 /dev/loop1=C2=A0=C2=A0=C2=A0=C2=A0 288.00MiB
>> =C2=A0=C2=A0=C2=A0 /dev/loop2=C2=A0=C2=A0=C2=A0=C2=A0 127.00MiB
>> =C2=A0=C2=A0=C2=A0 /dev/loop3=C2=A0=C2=A0=C2=A0=C2=A0 127.00MiB
>> =C2=A0=C2=A0=C2=A0 /dev/loop4=C2=A0=C2=A0=C2=A0=C2=A0 127.00MiB
>> =C2=A0=C2=A0=C2=A0 /dev/loop5=C2=A0=C2=A0=C2=A0=C2=A0 127.00MiB
>>
>> Metadata,single: Size:256.00MiB, Used:384.00KiB (0.15%)
>> =C2=A0=C2=A0=C2=A0 /dev/loop1=C2=A0=C2=A0=C2=A0=C2=A0 256.00MiB
>>
>> System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
>> =C2=A0=C2=A0=C2=A0 /dev/loop0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32.00MiB
>>
>> Unallocated:
>> =C2=A0=C2=A0=C2=A0 /dev/loop0=C2=A0=C2=A0=C2=A0=C2=A0 704.00MiB
>> =C2=A0=C2=A0=C2=A0 /dev/loop1=C2=A0=C2=A0=C2=A0=C2=A0 480.00MiB
>> =C2=A0=C2=A0=C2=A0 /dev/loop2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.00M=
iB
>> =C2=A0=C2=A0=C2=A0 /dev/loop3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.00M=
iB
>> =C2=A0=C2=A0=C2=A0 /dev/loop4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.00M=
iB
>> =C2=A0=C2=A0=C2=A0 /dev/loop5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.00M=
iB
>> =C2=A0=C2=A0=C2=A0 /dev/loop6=C2=A0=C2=A0=C2=A0=C2=A0 128.00MiB
>> =C2=A0=C2=A0=C2=A0 /dev/loop7=C2=A0=C2=A0=C2=A0=C2=A0 128.00MiB
>>
>> # change the tag of some disks
>>
>> $ sudo ./btrfs prop set /dev/loop0 allocation_hint DATA_ONLY
>> $ sudo ./btrfs prop set /dev/loop1 allocation_hint DATA_ONLY
>> $ sudo ./btrfs prop set /dev/loop5 allocation_hint METADATA_ONLY
>>
>> $ for i in /dev/loop[0-9]; do sudo ./btrfs prop get $i
>> allocation_hint; done
>> devid=3D1, path=3D/dev/loop0: allocation_hint=3DDATA_ONLY
>> devid=3D2, path=3D/dev/loop1: allocation_hint=3DDATA_ONLY
>> devid=3D3, path=3D/dev/loop2: allocation_hint=3DDATA_PREFERRED
>> devid=3D4, path=3D/dev/loop3: allocation_hint=3DDATA_PREFERRED
>> devid=3D5, path=3D/dev/loop4: allocation_hint=3DDATA_PREFERRED
>> devid=3D6, path=3D/dev/loop5: allocation_hint=3DMETADATA_ONLY
>> devid=3D7, path=3D/dev/loop6: allocation_hint=3DMETADATA_ONLY
>> devid=3D8, path=3D/dev/loop7: allocation_hint=3DMETADATA_ONLY
>>
>> $ sudo btrfs bal start --full-balance /mnt/test-btrfs/
>> $ sudo ./btrfs fi us /mnt/test-btrfs/
>> Overall:
>> =C2=A0=C2=A0=C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.75GiB
>> =C2=A0=C2=A0=C2=A0=C2=A0 Device allocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 735.00MiB
>> =C2=A0=C2=A0=C2=A0=C2=A0 Device unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.03GiB
>> =C2=A0=C2=A0=C2=A0=C2=A0 Device missing:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
>> =C2=A0=C2=A0=C2=A0=C2=A0 Used:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 400.72MiB
>> =C2=A0=C2=A0=C2=A0=C2=A0 Free (estimated):=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.10GiB=C2=A0=C2=A0=C2=A0 (min: 1.10GiB)
>> =C2=A0=C2=A0=C2=A0=C2=A0 Data ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.00
>> =C2=A0=C2=A0=C2=A0=C2=A0 Metadata ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.00
>> =C2=A0=C2=A0=C2=A0=C2=A0 Global reserve:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.25MiB=C2=A0=C2=A0=C2=A0 (used: 0.00B)
>> =C2=A0=C2=A0=C2=A0=C2=A0 Multiple profiles:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>>
>> Data,RAID1: Size:288.00MiB, Used:200.19MiB (69.51%)
>> =C2=A0=C2=A0=C2=A0 /dev/loop0=C2=A0=C2=A0=C2=A0=C2=A0 288.00MiB
>> =C2=A0=C2=A0=C2=A0 /dev/loop1=C2=A0=C2=A0=C2=A0=C2=A0 288.00MiB
>>
>> Metadata,single: Size:127.00MiB, Used:336.00KiB (0.26%)
>> =C2=A0=C2=A0=C2=A0 /dev/loop5=C2=A0=C2=A0=C2=A0=C2=A0 127.00MiB
>>
>> System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
>> =C2=A0=C2=A0=C2=A0 /dev/loop7=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32.00MiB
>>
>> Unallocated:
>> =C2=A0=C2=A0=C2=A0 /dev/loop0=C2=A0=C2=A0=C2=A0=C2=A0 736.00MiB
>> =C2=A0=C2=A0=C2=A0 /dev/loop1=C2=A0=C2=A0=C2=A0=C2=A0 736.00MiB
>> =C2=A0=C2=A0=C2=A0 /dev/loop2=C2=A0=C2=A0=C2=A0=C2=A0 128.00MiB
>> =C2=A0=C2=A0=C2=A0 /dev/loop3=C2=A0=C2=A0=C2=A0=C2=A0 128.00MiB
>> =C2=A0=C2=A0=C2=A0 /dev/loop4=C2=A0=C2=A0=C2=A0=C2=A0 128.00MiB
>> =C2=A0=C2=A0=C2=A0 /dev/loop5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.00M=
iB
>> =C2=A0=C2=A0=C2=A0 /dev/loop6=C2=A0=C2=A0=C2=A0=C2=A0 128.00MiB
>> =C2=A0=C2=A0=C2=A0 /dev/loop7=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 96.00MiB
>>
>>
>> #As you can see all the metadata were placed on the disk loop5/loop7
>> even if
>> #the most empty one are loop0 and loop1.
>>
>>
>>
>> Furher works:
>> - the tool which show the space available should consider the tagging (=
eg
>> =C2=A0=C2=A0 the disks tagged by _METADATA_ONLY should be excluded from=
 the data
>> =C2=A0=C2=A0 availability)
>> - allow btrfs-prog to change the allocation_hint even when the filesyst=
em
>> =C2=A0=C2=A0 is not mounted.
>>
>> In following emails, there will be the btrfs-progs patches set and the
>> xfstest
>> suite patches set.
>>
>>
>> Comments are welcome
>> BR
>> G.Baroncelli
>>
>> Revision:
>> V11:
>> - added the property /sys/fs/btrfs/features/allocation_hint
>>
>> V10:
>> - renamed two disk tags/constants:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - *_METADATA_PREFERRED=
 -> *_METADATA_PREFERRED
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - *_DATA_PREFERRED -> =
*_DATA_EFERRED
>> - add /sys/fs/btrfs/$UUID/devinfo/$DEVID/major_minor
>> - revise some commit description
>> - refactored the code of gather_device_info(): one portion of this code
>> =C2=A0=C2=A0 is moved in a separate function called sort_and_reduce_dev=
ice_info()
>> =C2=A0=C2=A0 for clarity.
>> - removed the 'allocation_hint' mount option
>>
>> V9:
>> - rename dev_item->type to dev_item->flags
>> - rename /sys/fs/btrfs/$UUID/devinfo/type -> allocation_hint
>>
>> V8:
>> - drop the ioctl API, instead use a sysfs one
>>
>> V7:
>> - make more room in the struct btrfs_ioctl_dev_properties up to 1K
>> - leave in btrfs_tree.h only the costants
>> - removed the mount option (sic)
>> - correct an 'use before check' in the while loop (signaled
>> =C2=A0=C2=A0 by Zygo)
>> - add a 2nd sort to be sure that the device_info array is in the
>> =C2=A0=C2=A0 expected order
>>
>> V6:
>> - add further values to the hints: add the possibility to
>> =C2=A0=C2=A0 exclude a disk for a chunk type
>>
>>
>>
>> Goffredo Baroncelli (7):
>> =C2=A0=C2=A0 btrfs: add flags to give an hint to the chunk allocator
>> =C2=A0=C2=A0 btrfs: export the device allocation_hint property in sysfs
>> =C2=A0=C2=A0 btrfs: change the device allocation_hint property via sysf=
s
>> =C2=A0=C2=A0 btrfs: add allocation_hint mode
>> =C2=A0=C2=A0 btrfs: rename dev_item->type to dev_item->flags
>> =C2=A0=C2=A0 btrfs: add major and minor to sysfs
>> =C2=A0=C2=A0 Add /sys/fs/btrfs/features/allocation_hint
>>
>> =C2=A0 fs/btrfs/ctree.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
>> =C2=A0 fs/btrfs/disk-io.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 fs/btrfs/sysfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 105 +++++++++++++++++++++++++=
++
>> =C2=A0 fs/btrfs/volumes.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 121 ++++++++++++++++++++++++++++++--
>> =C2=A0 fs/btrfs/volumes.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +-
>> =C2=A0 include/uapi/linux/btrfs_tree.h |=C2=A0 20 +++++-
>> =C2=A0 6 files changed, 245 insertions(+), 14 deletions(-)
>>
>
>
