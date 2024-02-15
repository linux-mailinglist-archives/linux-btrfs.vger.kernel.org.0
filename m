Return-Path: <linux-btrfs+bounces-2445-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED62857183
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 00:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EFBEB22F4C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 23:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F00145347;
	Thu, 15 Feb 2024 23:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="oDOzJ5WI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3730C13475C
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Feb 2024 23:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708039415; cv=none; b=RniUxTNft+AjytRfiFX0UUBr+i29kGH05tj1L4kgZSs6SauTE2XpTS9SttNePdKJNrOHjwU9LlnZaihpe0KRvcrfxa42I71GyuYW8UDvPd8LBa38uX58xXwGaAx6ll3/d9U4Jsc/r6S+8UVhCoIxHwJrHqqgQtWVXyKHr3XK9DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708039415; c=relaxed/simple;
	bh=2WNm+cUBeihAjOTuO/aq15Z4+drp9w6MNbmLG3yfWSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nUe5TmXW3OwXrsqB2FGr7K6vpeoe2DzXWGBXw136ulb76n9SiN2tLn04tlnsHfYLvnBEJn4QxVMXoV+WlnPhmvTJ7R9bvIBykfVWDxGMOSG9dP0cm+ABw7nfV05apbbo5oOMwPyDVi2ewKhqjNeO/iR9/WI/2QUaCYX0Hv3bUj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=oDOzJ5WI; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1708039409; x=1708644209; i=quwenruo.btrfs@gmx.com;
	bh=2WNm+cUBeihAjOTuO/aq15Z4+drp9w6MNbmLG3yfWSk=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=oDOzJ5WIYBt5zOh6TaFime1WtHnd2+hWptcok1QWD+oq1Eh80AcwerO+epDLUKvM
	 Pgpd12lwmZh34L5T4IXxvVr+8cm2u3Qlq/EjH+c6khtjBo+9t2dB+tPBxnoUXnQIq
	 TxUtNB8EvAo3OXM7HVHRAiUFrzhVFGKwyXZflPO52AoBlr7z5jr49K6mybtzNcuLv
	 kthr2VXrMY339CV7YLYPCK5QEqR6NcXMdcXcl4Zl6xlxSQM/FCmD+b2ACUUTgFRjs
	 xE/mqumCc67zSow6z0th7ofmhqcCiKN+X9Dd3XjGZK8qkbXwvWc4UwdzK2bNBHm0P
	 KxAdVZKMekK7bv2O/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M1Ycr-1rYHIx3ntD-0034g3; Fri, 16
 Feb 2024 00:23:29 +0100
Message-ID: <d66eab3e-d6b7-466a-82e5-c153ed49ce9a@gmx.com>
Date: Fri, 16 Feb 2024 09:53:25 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mounting causes errors after power loss
Content-Language: en-US
To: Kyle Smith <mr.kyle.smith@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAKb79g0cM38YmV7rqeoC1EpO9vU856Y8LH2Kh7zxT5frDFfZDA@mail.gmail.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <CAKb79g0cM38YmV7rqeoC1EpO9vU856Y8LH2Kh7zxT5frDFfZDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zla+L5+6GLLm9wSOEEpK7KrVQK20pQkfV5RbENKPyZGuQrwu22H
 zeWhawIAuz1yfZpOiA15TKJUq0vKQRu5EZVkx7hl51R3F68cmETPOF8oi2rr0pf2mOpm766
 EorWf35ptJIfauhac3cuf3VKUGcEPUZV0zMAuiYLfJSwZ/YWr4veXcB8ZZ1K/yC5w8JwkZY
 55hxfELxmfa+J4ybvHYIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XUdPrWWBxjg=;t9SH1fNJFpLciMAbPCoRmnD0nhO
 iWXYiKAmhs+VgGW0d58UJjM6YnyGxKRdmTWz9CsPeh7oqdkIrVwwuJky5oToDB7kDEycUleOH
 sOCc4Z4UYMDIJnblSN4HynjDhEmmw09e6f56JItIAC0CcFfQD7L+b5tSHOX0MnAkCsqAFNtnc
 YCqv+gCWVMSRlRf2HJkHkSpmRYitV0NaKHaVcDq3qiavLVtO89ftssudjJuw3Qd04TElGhrbz
 qsQ+3tMpPjYM346v8AO9wCJESaa507NBa/4fuYriPV6cHqsb94BZZPIg+DE+VlZTSwPQE9VF9
 Auz2GhFxktPcIT1WJn89yiYBzPqWNEBXmmQ8VVzY6ixudTwiM2aJkt/uUETXcH+JuOoZreydK
 h+JlFG/ee6U5QYQZZDSoLL0ZKm70fFploCvEHhgKzD4SNbKUSI9sqwfGaOLaZ62atd2TARUMg
 TN3PqbD2aHwqaFQ0XbTUx7okprLjRUU1HeW3NqECO4u8Mt1fNMGaW+Ba2aLBDq/Pi0PzUyGBc
 Wtl64xNnqLkiyY22D6dqR5VLcNz3+22hscJ/Eb207vx+24jtBZTTgF/gkEN2NRs92l/dqKZIa
 LmsFvf8bjuOxPZ1o7dmG2eM5LYrHnZCMWG4mWGdKsH/wgzrzBRl4QDZzXNCoBqBG5eFHAkVkj
 w6z050xqixqLAy/uGqbfuRl8SL+XKp+mWMuEP+/OvKqyincgkbcMCH2Rob5ApVhSQSxlkpta0
 LfU0QSXHVd/u6GQXrU5IksOup4E+kLzEhlth1/CZriBCIdCXQ7uHtrdx5QzyO64qgI2xWt+mU
 n82POtCxlaQZzeVEEpYQxeSYzAmIaGv8HBtnWe3imJLRs=



=E5=9C=A8 2024/2/16 06:34, Kyle Smith =E5=86=99=E9=81=93:
> Hello,
>
> I have noticed the occasional btrfs error after a hard power cycle and
> wanted to get a better understanding of the issue. These errors only
> happen after the btrfs partition is mounted, and running "btrfs check"
> before mounting does not find any errors.
>
> I am using btrfs on Linux 5.10.176 on an encrypted LUKS2 partition on
> an eMMC device. The LUKS2 partition is configured to allow-discards
> and btrfs is mounted with  "-o acl,noatime,nodiratime,compress=3Dlzo".
>
> # uname -a
> Linux (none) 5.10.176 #0 SMP PREEMPT Thu Apr 27 20:28:15 2023 aarch64 GN=
U/Linux
>
> # btrfs --version
> btrfs-progs v6.0.1
>
> # btrfs fi show
> Label: none  uuid: d90b7698-7ef5-4c1e-8365-b7631a6eafba
>      Total devices 1 FS bytes used 92.16MiB
>      devid    1 size 2.53GiB used 808.00MiB path /dev/mapper/luks-part
>
> # mount -t btrfs -o acl,noatime,nodiratime,compress=3Dlzo
> /dev/mapper/luks-part /mnt/btrfs
> [  185.443505] BTRFS: device fsid d90b7698-7ef5-4c1e-8365-b7631a6eafba
> devid 1 transid 17201265 /dev/mapper/luks-part scanned by mount (2976)
> [  185.455314] BTRFS info (device dm-0): flagging fs with big metadata f=
eature
> [  185.461689] BTRFS info (device dm-0): use lzo compression, level 0
> [  185.467924] BTRFS info (device dm-0): using free space tree
> [  185.473563] BTRFS info (device dm-0): has skinny extents
> [  185.486490] BTRFS info (device dm-0): enabling ssd optimizations
>
> # btrfs fi df /mnt/btrfs
> Data, single: total=3D280.00MiB, used=3D91.46MiB
> System, DUP: total=3D8.00MiB, used=3D16.00KiB
> Metadata, DUP: total=3D256.00MiB, used=3D704.00KiB
> GlobalReserve, single: total=3D3.25MiB, used=3D0.00B
>
> Here is an example of the errors found by "btrfs check" after
> mounting. These errors don't happen often but they are reproducible
> and persistent.
>
> # btrfs check --mode=3Dlowmem --readonly -p /dev/mapper/luks-part
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/luks-part
> UUID: d90b7698-7ef5-4c1e-8365-b7631a6eafba
> [1/7] checking root items                      (0:00:00 elapsed, 1456
> items checked)
> [2/7] checking extents                         (0:00:01 elapsed, 42
> items checked)
> [3/7] checking free space tree                 (0:00:00 elapsed, 5
> items checked)
> ERROR: root 5 INODE_ITEM[27535265] index 55000957 name .sharedContents
> filetype 1 missing
> ERROR: root 5 INODE_ITEM[27535266] index 55000959 name .sharedContents
> filetype 1 missing
> ERROR: root 5 DIR INODE [256] size 668 not equal to 698

Those are all fixable by the latest btrfs-progs, so no big deal.

Furthermore, this is not caused by some powerloss, but more like some
older btrfs bugs.
Or sometimes even memory bitflips (this need extra debugging to confirm).

By all means, it's recommended to use kernel newer than v5.11 at least
(thus recommended to go at least 5.15).

> [4/7] checking fs roots                        (0:00:00 elapsed, 15
> items checked)
> ERROR: errors found in fs roots
> found 96636928 bytes used, error(s) found
> total csum bytes: 93652
> total tree bytes: 737280
> total fs tree bytes: 376832
> total extent tree bytes: 147456
> btree space waste bytes: 231395
> file data blocks allocated: 95899648
>   referenced 92807168
> Command exited with non-zero status 1
>
> # btrfs check --readonly -p /dev/mapper/luks-part
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/luks-part
> UUID: d90b7698-7ef5-4c1e-8365-b7631a6eafba
> [1/7] checking root items                      (0:00:00 elapsed, 1456
> items checked)
> [2/7] checking extents                         (0:00:00 elapsed, 54
> items checked)
> [3/7] checking free space tree                 (0:00:00 elapsed, 5
> items checked)
> root 5 inode 256 errors 200, dir isize wrong   (0:00:00 elapsed, 1
> items checked)
> root 5 inode 27535265 errors 1, no inode item
>      unresolved ref dir 256 index 55000957 namelen 15 name
> .sharedContents filetype 1 errors 5, no dir item, no inode ref
> root 5 inode 27535266 errors 1, no inode item
>      unresolved ref dir 256 index 55000959 namelen 15 name
> .sharedContents filetype 1 errors 5, no dir item, no inode ref
> [4/7] checking fs roots                        (0:00:00 elapsed, 22
> items checked)
> ERROR: errors found in fs roots
> found 96636928 bytes used, error(s) found
> total csum bytes: 93652
> total tree bytes: 737280
> total fs tree bytes: 376832
> total extent tree bytes: 147456
> btree space waste bytes: 231395
> file data blocks allocated: 95899648
>   referenced 92807168
> Command exited with non-zero status 1
>
> Here is the "btrfs ins dump-tree" output of the above inodes.
>
> # btrfs ins dump-tree -t 5 /dev/mapper/luks-part | grep -A5 "(27535265 "
>          location key (27535265 INODE_ITEM 0) type FILE
>          transid 17119099 data_len 0 name_len 15
>          name: .sharedContents
>      item 62 key (256 DIR_INDEX 55000959) itemoff 13593 itemsize 45
>          location key (27535266 INODE_ITEM 0) type FILE
>          transid 17119099 data_len 0 name_len 15
> # btrfs ins dump-tree -t 5 /dev/mapper/luks-part | grep -A5 "(27535266 "
>          location key (27535266 INODE_ITEM 0) type FILE
>          transid 17119099 data_len 0 name_len 15
>          name: .sharedContents
>      item 63 key (256 DIR_INDEX 55415388) itemoff 13545 itemsize 48
>          location key (27743503 INODE_ITEM 0) type FILE
>          transid 17188721 data_len 0 name_len 18

Unfortunately the dump is not enough to confirm anything.

Please try the following ones:

# btrfs ins dump-tree -t /dev/mapper/luks-part | grep -A5 "(27535265
DIR_INDEX 55000957)"

# btrfs ins dump-tree -t /dev/mapper/luks-part | grep -A5 "(27535266
DIR_INDEX 55000959)"

After the direct match, there would be a line like:

	location key (XXXX INODE_ITEM 0) type XXX

Use that key to do such search again.

>
> Is this a known issue with btrfs and power loss? Running "btrfs check
> --repair" can fix this issue but I would like to prevent it in the
> first place. This issue looks similar to the one in a previous message
> on this list, "Filesystem inconsistency on power cycle" [0].

The power loss is only going to cause problem if your disk are not
properly handling flush (VBox and VMware seems to do that).
And if your disks (from the lower LUKS layer, until the disk firmwares)
are not doing flushing correctly, it's going to cause transid mismatch,
not the same symptom.

For your case, it's completely unrelated, but I'd like more dump to make
sure it's not some weird memory bitflip.

Thanks,
Qu

>
>
> Thank you,
> Kyle
>
> [0]: https://lore.kernel.org/linux-btrfs/CA+XNQ=3DixcfB1_CXHf5azsB4gX87v=
vdmei+fxv5dj4K_4=3DH1=3Dag@mail.gmail.com/
>

