Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26D0A4FB0F
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jun 2019 12:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfFWKPQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jun 2019 06:15:16 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:44078 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfFWKPP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jun 2019 06:15:15 -0400
Received: by mail-lj1-f181.google.com with SMTP id k18so9800476ljc.11
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jun 2019 03:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=zlZidK5UMRFlvtzVO9bLb0ZsXs2VaxEhO3N8FBoTJTQ=;
        b=s3BZtFiPEuAEjuUrHkyfae0Vey6wuQDA+Jn0SER2O6SAjsGQGmUucn6ReG7YflCFSM
         jCJQIMr2L5CSTxM2hhVUQdo2JStHxPwKdP5Zlp8cQ2rp2E3aNps3aYjknSuLiFArcaLw
         vIjCtUddsA3NOJ1WiY0t8wqTOQGKbEh5gLnA2RjRZUzuvCyldgZXvAsk8fxaCCONu1Yg
         onR2d/0LF0m01s9l+2Rsp2D0gSWN+RhkEeeCRnnakT+wdvnCYqLSkDccNvzaX+G78W4l
         sW0yHyFYHaEy8yHoh3ipL8qXoCNbwlRjbLb6tBj916T3imLtVmVrf4WfMut95qhsxWg/
         gVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=zlZidK5UMRFlvtzVO9bLb0ZsXs2VaxEhO3N8FBoTJTQ=;
        b=X7rH6Inm0j7pHFqmTFVpCvFY5KlnSsqZJsLVWmOGymqGOAbS6q62ub+/i58qpDAGMp
         sHc+OZv9PYMhrSZ7Htq747t0gCMLJGE+NE/0FETgcsNETslozYY5HrIdVsWca5xHK6dq
         1MMr7Zek1iRlkaIS7CE1EVsV3unMgXJmOMiAn2tRK8h2AokAdKlJZbhRDL14mgR1OYCy
         ZZvEa+5cVbtvXJrMBB7ZC52z6fGbdm1VllZqF8kL3bbNhAdnDGYGU3WtkuNr6UUWTz3G
         wO2dYh3wVwEw5hLEUuPJjMEzf2dlbZi4Gj7In2z0mhroLdMLDbG70kh09GYooQSHJOAE
         tm8g==
X-Gm-Message-State: APjAAAXKkoD/87mUxdwqjxuPXAm02WqjCbdeDOGcoBvxbiQS4Gn2Z1BN
        wSQFgF4nYsDGHhJZXHkN0MGToW5e
X-Google-Smtp-Source: APXvYqzcnkGRDWW84r7tNTkWvIfqmS4I0ogPStW4KV3cU71vFKRiNHhfMkEuv4mLAZS/zQv/wMo8Ag==
X-Received: by 2002:a2e:9b10:: with SMTP id u16mr31150296lji.231.1561284911041;
        Sun, 23 Jun 2019 03:15:11 -0700 (PDT)
Received: from [192.168.1.5] (109-252-90-211.nat.spd-mgts.ru. [109.252.90.211])
        by smtp.gmail.com with ESMTPSA id d10sm1221427ljc.15.2019.06.23.03.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 03:15:09 -0700 (PDT)
Subject: Re: Confused by btrfs quota group accounting
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <eeb418d8-13a1-39c3-c6d1-dd5a2127abc9@gmail.com>
 <669a0428-0517-a10e-c658-c8137463450a@gmx.com>
 <cec540b7-f1c1-93f2-adb0-5f0155215e73@gmx.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBDxiRwwRBAC3CN9wdwpVEqUGmSoqF8tWVIT4P/bLCSZLkinSZ2drsblKpdG7x+guxwts
 +LgI8qjf/q5Lah1TwOqzDvjHYJ1wbBauxZ03nDzSLUhD4Ms1IsqlIwyTLumQs4vcQdvLxjFs
 G70aDglgUSBogtaIEsiYZXl4X0j3L9fVstuz4/wXtwCg1cN/yv/eBC0tkcM1nsJXQrC5Ay8D
 /1aA5qPticLBpmEBxqkf0EMHuzyrFlqVw1tUjZ+Ep2LMlem8malPvfdZKEZ71W1a/XbRn8FE
 SOp0tUa5GwdoDXgEp1CJUn+WLurR0KPDf01E4j/PHHAoABgrqcOTcIVoNpv2gNiBySVsNGzF
 XTeY/Yd6vQclkqjBYONGN3r9R8bWA/0Y1j4XK61qjowRk3Iy8sBggM3PmmNRUJYgroerpcAr
 2byz6wTsb3U7OzUZ1Llgisk5Qum0RN77m3I37FXlIhCmSEY7KZVzGNW3blugLHcfw/HuCB7R
 1w5qiLWKK6eCQHL+BZwiU8hX3dtTq9d7WhRW5nsVPEaPqudQfMSi/Ux1kc0mQW5kcmVpIEJv
 cnplbmtvdiA8YXJ2aWRqYWFyQGdtYWlsLmNvbT7CZQQTEQIAJQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AFAliWAiQCGQEACgkQR6LMutpd94wFGwCeNuQnMDxve/Fo3EvYIkAOn+zE
 21cAnRCQTXd1hTgcRHfpArEd/Rcb5+SczsBNBDxiRyQQBACQtME33UHfFOCApLki4kLFrIw1
 5A5asua10jm5It+hxzI9jDR9/bNEKDTKSciHnM7aRUggLwTt+6CXkMy8an+tVqGL/MvDc4/R
 KKlZxj39xP7wVXdt8y1ciY4ZqqZf3tmmSN9DlLcZJIOT82DaJZuvr7UJ7rLzBFbAUh4yRKaN
 nwADBwQAjNvMr/KBcGsV/UvxZSm/mdpvUPtcw9qmbxCrqFQoB6TmoZ7F6wp/rL3TkQ5UElPR
 gsG12+Dk9GgRhnnxTHCFgN1qTiZNX4YIFpNrd0au3W/Xko79L0c4/49ten5OrFI/psx53fhY
 vLYfkJnc62h8hiNeM6kqYa/x0BEddu92ZG7CRgQYEQIABgUCPGJHJAAKCRBHosy62l33jMhd
 AJ48P7WDvKLQQ5MKnn2D/TI337uA/gCgn5mnvm4SBctbhaSBgckRmgSxfwQ=
Message-ID: <7ecc3db3-7af7-f3cb-e23f-04c20f47dd8c@gmail.com>
Date:   Sun, 23 Jun 2019 13:15:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <cec540b7-f1c1-93f2-adb0-5f0155215e73@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="P22tfS6FffGE7tNgX9vYphpputak2Si7Q"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P22tfS6FffGE7tNgX9vYphpputak2Si7Q
Content-Type: multipart/mixed; boundary="1nB6cPI4iluQoGJsWvOyBnzAxG5RERR2N";
 protected-headers="v1"
From: Andrei Borzenkov <arvidjaar@gmail.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <7ecc3db3-7af7-f3cb-e23f-04c20f47dd8c@gmail.com>
Subject: Re: Confused by btrfs quota group accounting
References: <eeb418d8-13a1-39c3-c6d1-dd5a2127abc9@gmail.com>
 <669a0428-0517-a10e-c658-c8137463450a@gmx.com>
 <cec540b7-f1c1-93f2-adb0-5f0155215e73@gmx.com>
In-Reply-To: <cec540b7-f1c1-93f2-adb0-5f0155215e73@gmx.com>

--1nB6cPI4iluQoGJsWvOyBnzAxG5RERR2N
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

23.06.2019 11:08, Qu Wenruo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>=20
>=20
> On 2019/6/23 =E4=B8=8B=E5=8D=883:55, Qu Wenruo wrote:
>>
>>
>> On 2019/6/22 =E4=B8=8B=E5=8D=8811:11, Andrei Borzenkov wrote:
>> [snip]
>>>
>>> 10:/mnt # dd if=3D/dev/urandom of=3Dtest/file bs=3D1M count=3D100 see=
k=3D0
>>> conv=3Dnotrunc
>>> 100+0 records in
>>> 100+0 records out
>>> 104857600 bytes (105 MB, 100 MiB) copied, 0.685532 s, 153 MB/s
>>> 10:/mnt # sync
>>> 10:/mnt # btrfs qgroup show .
>>> qgroupid         rfer         excl
>>> --------         ----         ----
>>> 0/5          16.00KiB     16.00KiB
>>> 0/258         1.01GiB    100.02MiB
>>> 0/263         1.00GiB     85.02MiB
>>
>> Sorry, I can't really reproduce it.
>>
>> 5.1.12 kernel, using the following script:
>> ---
>> #!/bin/bash
>>
>> dev=3D"/dev/data/btrfs"
>> mnt=3D"/mnt/btrfs"
>>
>> umount $dev &> /dev/null
>> mkfs.btrfs -f $dev > /dev/null
>>
>> mount $dev $mnt
>> btrfs sub create $mnt/subv1
>> btrfs quota enable $mnt
>> btrfs quota rescan -w $mnt
>>
>> xfs_io -f -c "pwrite 0 1G" $mnt/subv1/file1
>> sync
>> btrfs sub snapshot $mnt/subv1 $mnt/subv2
>> sync
>> btrfs qgroup show -prce $mnt
>>
>> xfs_io -c "pwrite 0 100m" $mnt/subv1/file1
>> sync
>> btrfs qgroup show -prce $mnt
>> ---
>>
>> The result is:
>> ---
>> Create subvolume '/mnt/btrfs/subv1'
>> wrote 1073741824/1073741824 bytes at offset 0
>> 1 GiB, 262144 ops; 0.5902 sec (1.694 GiB/sec and 444134.2107 ops/sec)
>> Create a snapshot of '/mnt/btrfs/subv1' in '/mnt/btrfs/subv2'
>> qgroupid         rfer         excl     max_rfer     max_excl parent  c=
hild
>> --------         ----         ----     --------     -------- ------  -=
----
>> 0/5          16.00KiB     16.00KiB         none         none ---     -=
--
>> 0/256         1.00GiB     16.00KiB         none         none ---     -=
--
>> 0/259         1.00GiB     16.00KiB         none         none ---     -=
--
>> wrote 104857600/104857600 bytes at offset 0
>> 100 MiB, 25600 ops; 0.0694 sec (1.406 GiB/sec and 368652.9766 ops/sec)=

>> qgroupid         rfer         excl     max_rfer     max_excl parent  c=
hild
>> --------         ----         ----     --------     -------- ------  -=
----
>> 0/5          16.00KiB     16.00KiB         none         none ---     -=
--
>> 0/256         1.10GiB    100.02MiB         none         none ---     -=
--
>> 0/259         1.00GiB     16.00KiB         none         none ---     -=
--
>> ---
>>
>>> 10:/mnt # filefrag -v test/file
>>> Filesystem type is: 9123683e
>>> File size of test/file is 1073741824 (262144 blocks of 4096 bytes)
>=20
> My bad, I'm still using 512 bytes as blocksize.
> If using 4K blocksize, then the fiemap result matches.
>=20
> Then please discard my previous comment.
>=20
> Then we need to check data extents layout to make sure what's going on.=

>=20
> Would you please provide the following output?
> # btrfs ins dump-tree -t 258 /dev/vdb
> # btrfs ins dump-tree -t 263 /dev/vdb
> # btrfs check /dev/vdb
>=20
> If the last command reports qgroup mismatch, then it means qgroup is
> indeed incorrect.
>=20

no error reported.
10:/home/bor # btrfs ins dump-tree -t 258 /dev/vdb
btrfs-progs v5.1
file tree key (258 ROOT_ITEM 0)
leaf 32505856 items 45 free space 12677 generation 11 owner 258
leaf 32505856 flags 0x1(WRITTEN) backref revision 1
fs uuid d10df0fa-25aa-4d80-89d9-16033ae3392d
chunk uuid 1bf7922a-9f98-4c76-8511-77e5605b8112
	item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
		generation 8 transid 9 size 8 nbytes 0
		block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
		sequence 13 flags 0x0(none)
		atime 1561214496.783636682 (2019-06-22 17:41:36)
		ctime 1561214504.7643132 (2019-06-22 17:41:44)
		mtime 1561214504.7643132 (2019-06-22 17:41:44)
		otime 1561214496.783636682 (2019-06-22 17:41:36)
	item 1 key (256 INODE_REF 256) itemoff 16111 itemsize 12
		index 0 namelen 2 name: ..
	item 2 key (256 DIR_ITEM 1847562484) itemoff 16077 itemsize 34
		location key (257 INODE_ITEM 0) type FILE
		transid 9 data_len 0 name_len 4
		name: file
	item 3 key (256 DIR_INDEX 2) itemoff 16043 itemsize 34
		location key (257 INODE_ITEM 0) type FILE
		transid 9 data_len 0 name_len 4
		name: file
	item 4 key (257 INODE_ITEM 0) itemoff 15883 itemsize 160
		generation 9 transid 11 size 1073741824 nbytes 1073741824
		block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
		sequence 1136 flags 0x0(none)
		atime 1561214504.7643132 (2019-06-22 17:41:44)
		ctime 1561214563.71728522 (2019-06-22 17:42:43)
		mtime 1561214563.71728522 (2019-06-22 17:42:43)
		otime 1561214504.7643132 (2019-06-22 17:41:44)
	item 5 key (257 INODE_REF 256) itemoff 15869 itemsize 14
		index 2 namelen 4 name: file
	item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
		generation 11 type 1 (regular)
		extent data disk byte 1291976704 nr 46137344
		extent data offset 0 nr 46137344 ram 46137344
		extent compression 0 (none)
	item 7 key (257 EXTENT_DATA 46137344) itemoff 15763 itemsize 53
		generation 11 type 1 (regular)
		extent data disk byte 1338114048 nr 45875200
		extent data offset 0 nr 45875200 ram 45875200
		extent compression 0 (none)
	item 8 key (257 EXTENT_DATA 92012544) itemoff 15710 itemsize 53
		generation 11 type 1 (regular)
		extent data disk byte 314966016 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 9 key (257 EXTENT_DATA 92274688) itemoff 15657 itemsize 53
		generation 11 type 1 (regular)
		extent data disk byte 315228160 nr 12582912
		extent data offset 0 nr 12582912 ram 12582912
		extent compression 0 (none)
	item 10 key (257 EXTENT_DATA 104857600) itemoff 15604 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 227016704 nr 43515904
		extent data offset 15728640 nr 27787264 ram 43515904
		extent compression 0 (none)
	item 11 key (257 EXTENT_DATA 132644864) itemoff 15551 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 270532608 nr 524288
		extent data offset 0 nr 524288 ram 524288
		extent compression 0 (none)
	item 12 key (257 EXTENT_DATA 133169152) itemoff 15498 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 271056896 nr 43515904
		extent data offset 0 nr 43515904 ram 43515904
		extent compression 0 (none)
	item 13 key (257 EXTENT_DATA 176685056) itemoff 15445 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 352452608 nr 43515904
		extent data offset 0 nr 43515904 ram 43515904
		extent compression 0 (none)
	item 14 key (257 EXTENT_DATA 220200960) itemoff 15392 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 395968512 nr 43515904
		extent data offset 0 nr 43515904 ram 43515904
		extent compression 0 (none)
	item 15 key (257 EXTENT_DATA 263716864) itemoff 15339 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 439484416 nr 43778048
		extent data offset 0 nr 43778048 ram 43778048
		extent compression 0 (none)
	item 16 key (257 EXTENT_DATA 307494912) itemoff 15286 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 483262464 nr 786432
		extent data offset 0 nr 786432 ram 786432
		extent compression 0 (none)
	item 17 key (257 EXTENT_DATA 308281344) itemoff 15233 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 484048896 nr 43515904
		extent data offset 0 nr 43515904 ram 43515904
		extent compression 0 (none)
	item 18 key (257 EXTENT_DATA 351797248) itemoff 15180 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 527564800 nr 524288
		extent data offset 0 nr 524288 ram 524288
		extent compression 0 (none)
	item 19 key (257 EXTENT_DATA 352321536) itemoff 15127 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 528089088 nr 44564480
		extent data offset 0 nr 44564480 ram 44564480
		extent compression 0 (none)
	item 20 key (257 EXTENT_DATA 396886016) itemoff 15074 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 572653568 nr 1572864
		extent data offset 0 nr 1572864 ram 1572864
		extent compression 0 (none)
	item 21 key (257 EXTENT_DATA 398458880) itemoff 15021 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 587333632 nr 43515904
		extent data offset 0 nr 43515904 ram 43515904
		extent compression 0 (none)
	item 22 key (257 EXTENT_DATA 441974784) itemoff 14968 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 630849536 nr 524288
		extent data offset 0 nr 524288 ram 524288
		extent compression 0 (none)
	item 23 key (257 EXTENT_DATA 442499072) itemoff 14915 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 631373824 nr 44564480
		extent data offset 0 nr 44564480 ram 44564480
		extent compression 0 (none)
	item 24 key (257 EXTENT_DATA 487063552) itemoff 14862 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 675938304 nr 524288
		extent data offset 0 nr 524288 ram 524288
		extent compression 0 (none)
	item 25 key (257 EXTENT_DATA 487587840) itemoff 14809 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 676462592 nr 43778048
		extent data offset 0 nr 43778048 ram 43778048
		extent compression 0 (none)
	item 26 key (257 EXTENT_DATA 531365888) itemoff 14756 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 720240640 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 27 key (257 EXTENT_DATA 531628032) itemoff 14703 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 720502784 nr 44040192
		extent data offset 0 nr 44040192 ram 44040192
		extent compression 0 (none)
	item 28 key (257 EXTENT_DATA 575668224) itemoff 14650 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 764542976 nr 44564480
		extent data offset 0 nr 44564480 ram 44564480
		extent compression 0 (none)
	item 29 key (257 EXTENT_DATA 620232704) itemoff 14597 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 809107456 nr 524288
		extent data offset 0 nr 524288 ram 524288
		extent compression 0 (none)
	item 30 key (257 EXTENT_DATA 620756992) itemoff 14544 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 822214656 nr 44302336
		extent data offset 0 nr 44302336 ram 44302336
		extent compression 0 (none)
	item 31 key (257 EXTENT_DATA 665059328) itemoff 14491 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 866516992 nr 44826624
		extent data offset 0 nr 44826624 ram 44826624
		extent compression 0 (none)
	item 32 key (257 EXTENT_DATA 709885952) itemoff 14438 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 911343616 nr 1572864
		extent data offset 0 nr 1572864 ram 1572864
		extent compression 0 (none)
	item 33 key (257 EXTENT_DATA 711458816) itemoff 14385 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 912916480 nr 45088768
		extent data offset 0 nr 45088768 ram 45088768
		extent compression 0 (none)
	item 34 key (257 EXTENT_DATA 756547584) itemoff 14332 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 958005248 nr 524288
		extent data offset 0 nr 524288 ram 524288
		extent compression 0 (none)
	item 35 key (257 EXTENT_DATA 757071872) itemoff 14279 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 958529536 nr 44564480
		extent data offset 0 nr 44564480 ram 44564480
		extent compression 0 (none)
	item 36 key (257 EXTENT_DATA 801636352) itemoff 14226 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 1003094016 nr 1572864
		extent data offset 0 nr 1572864 ram 1572864
		extent compression 0 (none)
	item 37 key (257 EXTENT_DATA 803209216) itemoff 14173 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 1004666880 nr 45088768
		extent data offset 0 nr 45088768 ram 45088768
		extent compression 0 (none)
	item 38 key (257 EXTENT_DATA 848297984) itemoff 14120 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 1049755648 nr 1048576
		extent data offset 0 nr 1048576 ram 1048576
		extent compression 0 (none)
	item 39 key (257 EXTENT_DATA 849346560) itemoff 14067 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 1057095680 nr 45350912
		extent data offset 0 nr 45350912 ram 45350912
		extent compression 0 (none)
	item 40 key (257 EXTENT_DATA 894697472) itemoff 14014 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 1102446592 nr 44826624
		extent data offset 0 nr 44826624 ram 44826624
		extent compression 0 (none)
	item 41 key (257 EXTENT_DATA 939524096) itemoff 13961 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 1147273216 nr 45613056
		extent data offset 0 nr 45613056 ram 45613056
		extent compression 0 (none)
	item 42 key (257 EXTENT_DATA 985137152) itemoff 13908 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 1192886272 nr 524288
		extent data offset 0 nr 524288 ram 524288
		extent compression 0 (none)
	item 43 key (257 EXTENT_DATA 985661440) itemoff 13855 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 1193410560 nr 45088768
		extent data offset 0 nr 45088768 ram 45088768
		extent compression 0 (none)
	item 44 key (257 EXTENT_DATA 1030750208) itemoff 13802 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 1238499328 nr 42991616
		extent data offset 0 nr 42991616 ram 42991616
		extent compression 0 (none)
total bytes 2147483648
bytes used 1180483584
uuid d10df0fa-25aa-4d80-89d9-16033ae3392d
10:/home/bor # btrfs ins dump-tree -t 263 /dev/vdb
btrfs-progs v5.1
file tree key (263 ROOT_ITEM 10)
leaf 32112640 items 45 free space 12677 generation 10 owner 263
leaf 32112640 flags 0x1(WRITTEN) backref revision 1
fs uuid d10df0fa-25aa-4d80-89d9-16033ae3392d
chunk uuid 1bf7922a-9f98-4c76-8511-77e5605b8112
	item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
		generation 8 transid 9 size 8 nbytes 0
		block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
		sequence 13 flags 0x0(none)
		atime 1561214496.783636682 (2019-06-22 17:41:36)
		ctime 1561214504.7643132 (2019-06-22 17:41:44)
		mtime 1561214504.7643132 (2019-06-22 17:41:44)
		otime 1561214496.783636682 (2019-06-22 17:41:36)
	item 1 key (256 INODE_REF 256) itemoff 16111 itemsize 12
		index 0 namelen 2 name: ..
	item 2 key (256 DIR_ITEM 1847562484) itemoff 16077 itemsize 34
		location key (257 INODE_ITEM 0) type FILE
		transid 9 data_len 0 name_len 4
		name: file
	item 3 key (256 DIR_INDEX 2) itemoff 16043 itemsize 34
		location key (257 INODE_ITEM 0) type FILE
		transid 9 data_len 0 name_len 4
		name: file
	item 4 key (257 INODE_ITEM 0) itemoff 15883 itemsize 160
		generation 9 transid 9 size 1073741824 nbytes 1073741824
		block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
		sequence 1036 flags 0x0(none)
		atime 1561214504.7643132 (2019-06-22 17:41:44)
		ctime 1561214510.719648638 (2019-06-22 17:41:50)
		mtime 1561214510.719648638 (2019-06-22 17:41:50)
		otime 1561214504.7643132 (2019-06-22 17:41:44)
	item 5 key (257 INODE_REF 256) itemoff 15869 itemsize 14
		index 2 namelen 4 name: file
	item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 137887744 nr 43778048
		extent data offset 0 nr 43778048 ram 43778048
		extent compression 0 (none)
	item 7 key (257 EXTENT_DATA 43778048) itemoff 15763 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 181665792 nr 1310720
		extent data offset 0 nr 1310720 ram 1310720
		extent compression 0 (none)
	item 8 key (257 EXTENT_DATA 45088768) itemoff 15710 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 182976512 nr 43778048
		extent data offset 0 nr 43778048 ram 43778048
		extent compression 0 (none)
	item 9 key (257 EXTENT_DATA 88866816) itemoff 15657 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 226754560 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 10 key (257 EXTENT_DATA 89128960) itemoff 15604 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 227016704 nr 43515904
		extent data offset 0 nr 43515904 ram 43515904
		extent compression 0 (none)
	item 11 key (257 EXTENT_DATA 132644864) itemoff 15551 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 270532608 nr 524288
		extent data offset 0 nr 524288 ram 524288
		extent compression 0 (none)
	item 12 key (257 EXTENT_DATA 133169152) itemoff 15498 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 271056896 nr 43515904
		extent data offset 0 nr 43515904 ram 43515904
		extent compression 0 (none)
	item 13 key (257 EXTENT_DATA 176685056) itemoff 15445 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 352452608 nr 43515904
		extent data offset 0 nr 43515904 ram 43515904
		extent compression 0 (none)
	item 14 key (257 EXTENT_DATA 220200960) itemoff 15392 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 395968512 nr 43515904
		extent data offset 0 nr 43515904 ram 43515904
		extent compression 0 (none)
	item 15 key (257 EXTENT_DATA 263716864) itemoff 15339 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 439484416 nr 43778048
		extent data offset 0 nr 43778048 ram 43778048
		extent compression 0 (none)
	item 16 key (257 EXTENT_DATA 307494912) itemoff 15286 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 483262464 nr 786432
		extent data offset 0 nr 786432 ram 786432
		extent compression 0 (none)
	item 17 key (257 EXTENT_DATA 308281344) itemoff 15233 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 484048896 nr 43515904
		extent data offset 0 nr 43515904 ram 43515904
		extent compression 0 (none)
	item 18 key (257 EXTENT_DATA 351797248) itemoff 15180 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 527564800 nr 524288
		extent data offset 0 nr 524288 ram 524288
		extent compression 0 (none)
	item 19 key (257 EXTENT_DATA 352321536) itemoff 15127 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 528089088 nr 44564480
		extent data offset 0 nr 44564480 ram 44564480
		extent compression 0 (none)
	item 20 key (257 EXTENT_DATA 396886016) itemoff 15074 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 572653568 nr 1572864
		extent data offset 0 nr 1572864 ram 1572864
		extent compression 0 (none)
	item 21 key (257 EXTENT_DATA 398458880) itemoff 15021 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 587333632 nr 43515904
		extent data offset 0 nr 43515904 ram 43515904
		extent compression 0 (none)
	item 22 key (257 EXTENT_DATA 441974784) itemoff 14968 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 630849536 nr 524288
		extent data offset 0 nr 524288 ram 524288
		extent compression 0 (none)
	item 23 key (257 EXTENT_DATA 442499072) itemoff 14915 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 631373824 nr 44564480
		extent data offset 0 nr 44564480 ram 44564480
		extent compression 0 (none)
	item 24 key (257 EXTENT_DATA 487063552) itemoff 14862 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 675938304 nr 524288
		extent data offset 0 nr 524288 ram 524288
		extent compression 0 (none)
	item 25 key (257 EXTENT_DATA 487587840) itemoff 14809 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 676462592 nr 43778048
		extent data offset 0 nr 43778048 ram 43778048
		extent compression 0 (none)
	item 26 key (257 EXTENT_DATA 531365888) itemoff 14756 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 720240640 nr 262144
		extent data offset 0 nr 262144 ram 262144
		extent compression 0 (none)
	item 27 key (257 EXTENT_DATA 531628032) itemoff 14703 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 720502784 nr 44040192
		extent data offset 0 nr 44040192 ram 44040192
		extent compression 0 (none)
	item 28 key (257 EXTENT_DATA 575668224) itemoff 14650 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 764542976 nr 44564480
		extent data offset 0 nr 44564480 ram 44564480
		extent compression 0 (none)
	item 29 key (257 EXTENT_DATA 620232704) itemoff 14597 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 809107456 nr 524288
		extent data offset 0 nr 524288 ram 524288
		extent compression 0 (none)
	item 30 key (257 EXTENT_DATA 620756992) itemoff 14544 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 822214656 nr 44302336
		extent data offset 0 nr 44302336 ram 44302336
		extent compression 0 (none)
	item 31 key (257 EXTENT_DATA 665059328) itemoff 14491 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 866516992 nr 44826624
		extent data offset 0 nr 44826624 ram 44826624
		extent compression 0 (none)
	item 32 key (257 EXTENT_DATA 709885952) itemoff 14438 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 911343616 nr 1572864
		extent data offset 0 nr 1572864 ram 1572864
		extent compression 0 (none)
	item 33 key (257 EXTENT_DATA 711458816) itemoff 14385 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 912916480 nr 45088768
		extent data offset 0 nr 45088768 ram 45088768
		extent compression 0 (none)
	item 34 key (257 EXTENT_DATA 756547584) itemoff 14332 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 958005248 nr 524288
		extent data offset 0 nr 524288 ram 524288
		extent compression 0 (none)
	item 35 key (257 EXTENT_DATA 757071872) itemoff 14279 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 958529536 nr 44564480
		extent data offset 0 nr 44564480 ram 44564480
		extent compression 0 (none)
	item 36 key (257 EXTENT_DATA 801636352) itemoff 14226 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 1003094016 nr 1572864
		extent data offset 0 nr 1572864 ram 1572864
		extent compression 0 (none)
	item 37 key (257 EXTENT_DATA 803209216) itemoff 14173 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 1004666880 nr 45088768
		extent data offset 0 nr 45088768 ram 45088768
		extent compression 0 (none)
	item 38 key (257 EXTENT_DATA 848297984) itemoff 14120 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 1049755648 nr 1048576
		extent data offset 0 nr 1048576 ram 1048576
		extent compression 0 (none)
	item 39 key (257 EXTENT_DATA 849346560) itemoff 14067 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 1057095680 nr 45350912
		extent data offset 0 nr 45350912 ram 45350912
		extent compression 0 (none)
	item 40 key (257 EXTENT_DATA 894697472) itemoff 14014 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 1102446592 nr 44826624
		extent data offset 0 nr 44826624 ram 44826624
		extent compression 0 (none)
	item 41 key (257 EXTENT_DATA 939524096) itemoff 13961 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 1147273216 nr 45613056
		extent data offset 0 nr 45613056 ram 45613056
		extent compression 0 (none)
	item 42 key (257 EXTENT_DATA 985137152) itemoff 13908 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 1192886272 nr 524288
		extent data offset 0 nr 524288 ram 524288
		extent compression 0 (none)
	item 43 key (257 EXTENT_DATA 985661440) itemoff 13855 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 1193410560 nr 45088768
		extent data offset 0 nr 45088768 ram 45088768
		extent compression 0 (none)
	item 44 key (257 EXTENT_DATA 1030750208) itemoff 13802 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 1238499328 nr 42991616
		extent data offset 0 nr 42991616 ram 42991616
		extent compression 0 (none)
total bytes 2147483648
bytes used 1180483584
uuid d10df0fa-25aa-4d80-89d9-16033ae3392d
10:/home/bor # btrfs check /dev/vdb
Opening filesystem to check...
Checking filesystem on /dev/vdb
UUID: d10df0fa-25aa-4d80-89d9-16033ae3392d
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups
found 1180483584 bytes used, no error found
total csum bytes: 1150976
total tree bytes: 1425408
total fs tree bytes: 65536
total extent tree bytes: 16384
btree space waste bytes: 231695
file data blocks allocated: 2163671040
 referenced 2147942400
10:/home/bor #




> Also, I see your subvolume id is not continuous, did you created/remove=
d
> some other subvolumes during your test?
>=20

No. At least on this filesystem. I have recreated it several times, but
since the last mkfs these were the only two subvolumes I created myself.

> Thanks,
> Qu
>=20
>>> Oops. Where 85MiB exclusive usage in snapshot comes from? I would exp=
ect
>>> one of
>>>
>>> - 0 exclusive, because original first extent is still referenced by t=
est
>>> (even though partially), so if qgroup counts physical space usage, sn=
ap1
>>> effectively refers to the same physical extents as test.
>>>
>>> - 100MiB exclusive if qgroup counts logical space consumption, becaus=
e
>>> snapshot now has 100MiB different data.
>>>
>>> But 85MiB? It does not match any observed value. Judging by 1.01GiB o=
f
>>> referenced space for subvolume test, qrgoup counts physical usage, at=


Actually 100MiB is 0.1GiB, not 0.01GiB, so this conclusion is wrong. At
which point I'm even more confused what qgroup really counts :)

>>> which point snapshot exclusive space consumption remains 0.
>>>
>>
>=20



--1nB6cPI4iluQoGJsWvOyBnzAxG5RERR2N--

--P22tfS6FffGE7tNgX9vYphpputak2Si7Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTsPDUXSW5c6iqbJulHosy62l33jAUCXQ9RLAAKCRBHosy62l33
jFkVAKCb17ZUpyFbstakTktrqB8AmyhvKQCgsQ9puoOuBGuJrwK2vK6MP+56/oE=
=4idP
-----END PGP SIGNATURE-----

--P22tfS6FffGE7tNgX9vYphpputak2Si7Q--
