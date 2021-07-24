Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB6C3D4719
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 12:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbhGXJtw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 05:49:52 -0400
Received: from mout.gmx.net ([212.227.17.20]:44411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234333AbhGXJtw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 05:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627122622;
        bh=ac+28HIkKgUVDCWnkt6NhPhyQcr0qTGXxbWpsjLpBug=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=hPUCLeAbSIoJC9uCddHgU+rwb9mNr/jV9m9FnfmWKhxVLcnSjeTyaIFKoQSe2BclH
         eSnX8YV17D6w562KS1GHMl5ZZLsU/ny79TbIF+sjqaGfZc2bbCW+GXCSAOwbxgTKmX
         op3SJD4Ci87LkzHw4xXb+QT7bELnWD5/HI+kRWlk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5QJJ-1m84Gf1541-001Tcj; Sat, 24
 Jul 2021 12:30:22 +0200
Subject: Re: Help Dealing with BTRFS errors on a root partition in NVMe M2
 PCIe
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Fernando Peral <fperal@iesmariamoliner.com>,
        linux-btrfs@vger.kernel.org
References: <26346381-4981-0e95-9cf6-4bbfc6e9bf18@iesmariamoliner.com>
 <28d51753-d8ec-63c0-d4ac-a8fc7629ca6f@gmx.com>
Message-ID: <590db88e-b781-0785-5ace-d8d94b5da231@gmx.com>
Date:   Sat, 24 Jul 2021 18:30:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <28d51753-d8ec-63c0-d4ac-a8fc7629ca6f@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fe5U7gkTcDW6mqsuIGkwHPJ2BNkjF//QZhS+jfY1jTEvCCiU3k4
 dBk6P5mIR64j9M8JYhlmo9z/Fu41+9PcSjgHpROfuaSmqa/ogD5xFxHdsjC87YRlkO9xDWZ
 OiTWeJxxCK5baMN2WGCqUTSvLgslUEq5KXT+jQ0ZoIW72lpicDpoGZRcQV1TZlUsoyHjhUl
 cnTJmM6fTeQH040QEPvgw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kQZQFWtrPjg=:UcRI48Yrpahs/Pxan3aLyU
 yC9pXNT3hdO7vHIacp0SgtjnPxy0HNR28bFpqAj4pUqnRAkGpjta7I3qgk6r+enYh3FpxiTNw
 OYf1VTrHwOsXxG74kIpbKUMNmxN7SKHIDFIix/+cse1K5o6U7us+0mVi7Y5eCMph7R+bBVTm+
 UtSoIGljlr5EM6YcVV8V2RfSdgFIqqn1ai/bcLszqr+Jq8dtUlOCv136hk9L16JfF3/Dcueze
 uPUfq14RdCmicuTgIeqdzl5wtDARR/6/5MHMutWv85X3kLz896k80aUDmegNut7WAFsHM3R6u
 3Esf8QTkGEjnX2c3HAVeodMhNZuPkzJ8ViSAgoALtDtpHAf8snL0egz+xCsBslPC1RZKKwkPC
 PguHdp0xgHWKU2aSIgtXuOeUrbPZYENJgf4ALyBoC/8JV0OJ7QNaq0sk3E9xD4ljp46uPPAQU
 TiiIAmLt4xwE5LGR2a8igkv0BxIcpdevPhmXytuLDjHk84+uqEMLx6GopMNYfiSfADguV+L8B
 yiXRrOZveGHOwRg0r97khKFDARr0XMdsOFQs6xR+O11qQ5smbByIonWrIRKxsNlIc7gyEVJxt
 2Z+TCSfaI+ZU50WRpSmU+dBW3ZdzenjU1acR4A6euijmPM6TSjgFGo3SVvlMY3VDiqygi+tQ5
 6vt0W+lRlvrCAphNUV+/XoeiKLxXVAaGZ8OY76cKiyBm6VMj69uqQ4Qku5W51mjdFpJNm6BbP
 vx9ZtfcSNWXH78ue3zfIGtgPfnsW2tE7W7REACe0r5cJCKSjny0mK93LfkErcckHIqdhH2tQw
 eQzPVsDyOlupodlLp9QmjT/YhmB8gw9XBMgA1KHWTuXI7qcPdsTAfnA08jDsnYxCtjYYMT9MG
 R7C6ICKResMWegu3t8iqyprKaAodrAItdTEs4MJjQqDBJbZ5sKSXP2pnvTGhCIuhxoTuHZfPo
 6l0pKLKbTtVD67hYh1h4leDrEF56IK9mJE1AukOVmvJECBaD5Ozl6jie+Uc6kFVdg44YliVJD
 KchV5J2TJJYtn/QYM6Y+WsToAZIp1Lffzj7UKEjchXsNcUviLuqzMdjyRDB5oGt1vX2caWAPy
 lcK5147UqyFGooUJaFiVxz20uTTW71RS7gp5vNCcE6Kbhw1aqZd80vvjg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/24 =E4=B8=8B=E5=8D=885:47, Qu Wenruo wrote:
>
>
> On 2021/7/24 =E4=B8=8B=E5=8D=885:25, Fernando Peral wrote:
>> Hi.
>>
>> I'm having an error on the root partition of a opensuse leap 15.3 syste=
m.
>>
>> I have been asking for help in the opensuse forums
>>
>> The problem seems to have been caused by a faulty ram module wich has
>> been already replaced, but the error of the fs is still there.
>>
>> It has been suggested that it has been a bitflip and to ask here if a
>> btrfs check and repair should be done. >
>>
>>
>> #btrfs
>> check --readonly --force /dev/nvme0n1p1
>> [1/7] checking root items
>> [2/7] checking extents
>> data backref 227831808 root 263 owner 7983 offset 0 num_refs 0 not foun=
d
>> in extent tree
>> incorrect local backref count on 227831808 root 263 owner 7983 offset 0
>> found 1 wanted 0 back 0x5559e0ab7020
>> incorrect local backref count on 227831808 root 263 owner
>> 140737488363311offset 0 found 0 wanted 1 back 0x5559dde718d0
>
> The owner number 140737488363311 (0x800000001f2f) really looks like a
> bitflip in the high bit.
>
> Thus the faulty memory theory looks pretty solid.
>
> So far just two bad EXTENT_ITEM, I think btrfs check --repair is able to
> fix it.
>
> But before calling "btrfs check --repair", please backup all your
> important data, as there is still a low chance that "btrfs check
> --repair" may make things worse.
>
> Thanks,
> Qu
>
>> backref disk bytenr does not match extent record, bytenr=3D227831808, r=
ef
>> bytenr=3D0
>> backpointer mismatch on [227831808 4096]
>> ERROR: errors found in extent allocation tree or chunk allocation
>> [3/7]checking free space cache
>> [4/7]checking fs roots
>> [5/7]checking only csums items (without verifying data)
>> [6/7]checking root refs
>> [7/7]checking quota groups
>> Qgroup are marked as inconsistent.
>> Opening filesystem to check...
>> Checking filesystem on /dev/nvme0n1p1
>> UUID: 5b000355-3a1a-49f5-8005-f10668008aa7
>> Rescan hasn't been initialized, a difference in qgroup accounting is
>> expected
>> found 51878920192 bytes used, error(s) found
>> total csum bytes: 48135312
>> total tree bytes: 991313920
>> total fs tree bytes: 885358592
>> total extent tree bytes: 48414720
>> btree space waste bytes: 151592274
>> file data blocks allocated: 239972728832
>> referenced 85539778560
>>
>>
>> pruebas:~# uname -a
>> Linux pruebas 5.3.18-59.13-default #1 SMP Tue Jul 6
>> 07:33:56 UTC 2021 (23ab94f) x86_64 x86_64 x86_64 GNU/Linux
>>
>>
>> pruebas:~#btrfs --version
>> btrfs-progs v4.19.1 =C3=82 =C3=83=C2=A7

My bad, your btrfs-progs looks a little old.

It would be safer to use newer btrfs.

Since it's your root fs, you may want to use a liveUSB with newer
btrfs-progs to fix the fs.

Thanks,
Qu
>>
>> pruebas:~# btrfs fi show
>> Label: none=C2=A0 uuid: 5b000355-3a1a-49f5-8005-f10668008aa7
>> Totaldevices 1 FS bytes used 48.42GiB
>> devid=C2=A0 1 size 931.51GiB used 51.05GiB path /dev/nvme0n1p1
>>
>>
>> pruebas:~#btrfs fi df /
>> Data, single: total=3D49.01GiB, used=3D47.48GiB
>> System, single: total=3D32.00MiB, used=3D16.00KiB
>> Metadata, single: total=3D2.01GiB, used=3D962.69MiB
>> GlobalReserve, single: total=3D101.06MiB, used=3D0.00B
>>
>>
