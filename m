Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D444CF26F
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 08:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbiCGHMn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 02:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiCGHMn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 02:12:43 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FE1541BD
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 23:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646637101;
        bh=FMrWhFyZ/3Np110fP+yfxBPz+5OPAD7NI3abxCJCSLM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Pughi1ZvMSuCNgbosNturfhZUAHRviBwGjiRINcwD8AtSm/VmvdZdCbsxF/2fV6/g
         MnV6BRtM0isVITYCK7pq1Z1gtVUJMlVFlQOf+FxsWGUKsz5y5/VYl9cJBjsoNJOUkS
         WH1+FfYMU33QRvEXpdajQLf8R7y6qE8yeeilUoX8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MNbkv-1npepb1nyN-00P9sw; Mon, 07
 Mar 2022 08:11:41 +0100
Message-ID: <5379ca8e-0384-b447-52c1-a41ef0ded7e7@gmx.com>
Date:   Mon, 7 Mar 2022 15:11:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: AW: How to (attempt to) repair these btrfs errors
Content-Language: en-US
To:     Carsten Grommel <c.grommel@profihost.ag>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <AM0PR08MB326504D6D0D7D3077A13C7DE8E019@AM0PR08MB3265.eurprd08.prod.outlook.com>
 <AM0PR08MB3265280A4F4EF8151DA289F58E029@AM0PR08MB3265.eurprd08.prod.outlook.com>
 <YiQQOFQO7G4NZTKS@hungrycats.org>
 <AM0PR08MB3265F930C35B1AFBA7E981B18E089@AM0PR08MB3265.eurprd08.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <AM0PR08MB3265F930C35B1AFBA7E981B18E089@AM0PR08MB3265.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FA2OvbWJJ3vMQdAvf4AfH6aUpmirnrgiYWkYqXJHiJfP881//iO
 7DukL87+je6SmI0OvcsHGnfjQrawN2e/eiObztpzKTn6eqPl3nnuasBJ3ZLAEeMELqDW4oW
 xKCCGnfyADJwHi8Trt1uUTsZHHAPZfKNQHJttRIbjxUDmAF/uqHcSl3acBtMgRhxLJM0pK3
 uYT4SV+q2+tRQF0BiIveg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:580o4tx9b0U=:6Bk4vtnCTpgM396YTai7ZB
 D8lgA+LS20sPuBl1A7Zz6FhurH7IcdTc2ODjPS+oHPEZKMKrK97GfRFAoaSi1CG2kgqoWwzp1
 9jnnsvTfbwQH9t0bmgU7wdqKMkkwE9l247Q4AEqVphB+2okfIiXBOkICiJquKm4G4MmN+Tak9
 Y/+XG/P8nYNwIRCE8OMrRrS9bh3wIW1OKn+MldKsy2NhEE+vdxveEpnBbZbKQC7mtMDoqhfP0
 BXiljjxEdY8//L2evelMyHXgZg8YX4EvEvEAvpQDf/dvljdZrjU668+vSpiGzB1amwsErmA3C
 oS4BOtVeVb77S/RsuswD25igwgS4bFajbN2MaZUolIq0W6tkyzQFotBYun0UeSLoAcWI5kF7U
 TDLA6ktiLeF1n4yZIlOm0+dznTSggHVcMbr0Ox1WqTfrF63l/6DBkw6j65ZjlWPLploV+BSc7
 qgFl5iT6hieDDMGkq7MpEjhAozHJE3YOU9JAfwrXxP553AEZx/g7CJW1U0jXpvnebJJxpnIvr
 CkRwsv6G6S9AfbiNqjbW/R9yeYxCnv5yKvJG9dlXMYEUeEVuhn9+eESQo8lgWtBxNZgpPqmv7
 MAWtxatdxiIRGhWxKbtW1fptJztt2XkkRHJzUd4Z8cDAETWDnKt+jHkB+1bLDjkwmdGTOHub/
 6dh9xAwZYqk03b7hkoLc/NJR8bFMFzqgL980LmjKnkZHICekyM+9uf5JubisCRoDX3VZQUgyI
 IJwwjDVJCIk/tnho+e2d0b8yaws0c06eiH4Cm4yBsxGscNeneh14z3e8HovmVh7keSUWTWaM/
 xy6+oL/u+WYajJXEfuw216b5cTkFMRxSEfoGOEak0D/wT4mahpC2WAbiKAtNMS8H1x584VwyG
 Kg36YKwzrzHGvKX9k/Qx0bOBfPKPd1RdqJo+REGKgifaaNYt2DUI9OWkbfM2dknXmZ0AoNfjw
 6rzowXaD+5P6VBSaPgsoqfyP99rWh55nFR14UFiFNKMSTpqHvx0vpizwRUEwIVZz7CyaBw8jm
 +3tA7RtSFpeUI3c0/GVHaQlEoCyMIGtcdf3oYuZ3RhsDE3t3xLjUJ0f87iUG7jCEiWn034pTp
 7SRqMny6cQRVvA=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/7 15:03, Carsten Grommel wrote:
> Thank you for the answer. We are using space_cache v2:
>
> /dev/sdc1 on /vmbackup type btrfs (rw,noatime,nobarrier,compress-force=
=3Dzlib:3,ssd_spread,noacl,space_cache=3Dv2,skip_balance,subvolid=3D5,subv=
ol=3D/,x-systemd.mount-timeout=3D4h)
>
>> Data is raid0, so data repair is not possible.  Delete all the files
>> that contain corrupt data.
>
> I tried but as soon as I access the broken blocks btrfs fails into reado=
nly so I am kind of in a deadlock there.

Btrfs only falls back to RO for very critical errors (which could affect
on-disk metadata consistency).

Thus plain data corruption should not cause the RO.

Mind to share a dmesg just after the RO fallback?

Thanks,
Qu

>
>> I don't see any errors in these logs that would indicate a metadata iss=
ue,
>> but huge numbers of messages are suppressed.  Perhaps a log closer
>> to the moment when the filesystem goes read-only will be more useful.
>
>> I would expect that if there are no problems on sda1 or sdb1 then it
>> should be possible to repair the metadata errors on sdd1 by scrubbing
> that device.
>
> I ran a number of scrubs now, at some point it always fails and btrfs re=
mounts into readonly.
> I did not yet try to scrub specifically on sdd though, gonna try that.
>
> Should it remount again i will provide the most recent dmesg's right bef=
ore it crashes.
>
> ________________________________________
> Von: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> Gesendet: Sonntag, 6. M=C3=A4rz 2022 02:36
> An: Carsten Grommel
> Cc: linux-btrfs@vger.kernel.org
> Betreff: Re: How to (attempt to) repair these btrfs errors
>
> On Tue, Mar 01, 2022 at 10:55:50AM +0000, Carsten Grommel wrote:
>> Follow-up pastebin with the most recent errors in dmesg:
>>
>> https://pastebin.com/4yJJdQPJ
>
> This seems to have expired.
>
>> ________________________________________
>> Von: Carsten Grommel
>> Gesendet: Montag, 28. Februar 2022 19:41
>> An: linux-btrfs@vger.kernel.org
>> Betreff: How to (attempt to) repair these btrfs errors
>>
>> Hi,
>>
>> short buildup: btrfs filesystem used for storing ceph rbd backups withi=
n subvolumes got corrupted.
>> Underlying 3 RAID 6es, btrfs is mounted on Top as RAID 0 over these Rai=
ds for performance ( we have to store massive Data)
>>
>> Linux cloud8-1550 5.10.93+2-ph #1 SMP Fri Jan 21 07:52:51 UTC 2022 x86_=
64 GNU/Linux
>>
>> But it was Kernel 5.4.121 before
>>
>> btrfs --version
>> btrfs-progs v4.20.1
>>
>> btrfs fi show
>> Label: none  uuid: b634a011-28fa-41d7-8d6e-3f68ccb131d0
>>                  Total devices 3 FS bytes used 56.74TiB
>>                  devid    1 size 25.46TiB used 22.70TiB path /dev/sda1
>>                  devid    2 size 25.46TiB used 22.69TiB path /dev/sdb1
>>                  devid    3 size 25.46TiB used 22.70TiB path /dev/sdd1
>>
>> btrfs fi df /vmbackup/
>> Data, RAID0: total=3D66.62TiB, used=3D56.45TiB
>> System, RAID1: total=3D8.00MiB, used=3D4.36MiB
>> Metadata, RAID1: total=3D750.00GiB, used=3D294.90GiB
>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>
>> Attached the dmesg.log, a few dmesg messages following regarding the di=
fferent errors (some informations redacted):
>>
>> [Mon Feb 28 18:53:57 2022] BTRFS error (device sda1): bdev /dev/sdd1 er=
rs: wr 0, rd 0, flush 0, corrupt 69074516, gen 184286
>>
>> [Mon Feb 28 18:53:57 2022] BTRFS error (device sda1): bdev /dev/sdd1 er=
rs: wr 0, rd 0, flush 0, corrupt 69074517, gen 184286
>>
>> [Mon Feb 28 18:54:23 2022] BTRFS error (device sda1): unable to fixup (=
regular) error at logical 776693776384 on dev /dev/sdd1
>>
>> [Mon Feb 28 18:54:25 2022] scrub_handle_errored_block: 21812 callbacks =
suppressed
>>
>> [Mon Feb 28 18:54:31 2022] BTRFS warning (device sda1): checksum error =
at logical 777752285184 on dev /dev/sdd1, physical 259607957504, root 1087=
47, inode 257, offset 59804737536, length 4096, links 1 (path: cephstorX_v=
m-XXX-disk-X-base.img_1645337735)
>>
>> I am able to mount the filesystem in read-write mode but accessing spec=
ific blocks seems to crash btrfs to remount into read-only
>> I am currently running a scrub over the filesystem.
>>
>> The system got rebooted and the fs got remounted 2-3 times. I made the =
experience that usually btrfs would and could fix these kinds of errors af=
ter a remount, not this time though.
>>
>> Before I ran =E2=80=9Cbtrfs check =E2=80=93repair=E2=80=9D I would like=
 some advice at how to tackle theses errors.
>
> The corruption and generation event counts indicate sdd1 (or one of its
> component devices) was offline for a long time or suffered corruption
> on a large scale.
>
> Data is raid0, so data repair is not possible.  Delete all the files
> that contain corrupt data.
>
> If you are using space_cache=3Dv1, now is a good time to upgrade to
> space_cache=3Dv2.  v1 space cache is stored in the data profile, and it =
has
> likely been corrupted.  btrfs will usually detect and repair corruption
> in space_cache=3Dv1, but there is no need to take any such risk here
> when you can easily use v2 instead (or at least clear the v1 cache).
>
> I don't see any errors in these logs that would indicate a metadata issu=
e,
> but huge numbers of messages are suppressed.  Perhaps a log closer
> to the moment when the filesystem goes read-only will be more useful.
>
> I would expect that if there are no problems on sda1 or sdb1 then it
> should be possible to repair the metadata errors on sdd1 by scrubbing
> that device.
>
>> Kind regards
>> Carsten Grommel
>>
