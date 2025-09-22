Return-Path: <linux-btrfs+bounces-17030-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C0EB8E9EB
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 02:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29C317A12F
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 00:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16513596D;
	Mon, 22 Sep 2025 00:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="K85KitqH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0171BC2A
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 00:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758500704; cv=none; b=nMts11UhS8XqmUSEDnsKaeekiIGHcvC4yRYd0nSA17I91YdZiaNk3uCTnllxFCohQKErG21ciUhaUueB4Z8OlHJlFX2hmSX5KhVeFnwAZ4OGFYlM66yW/7oovjGBqjCUGuujEkFDdPpJhthKNAESGbc5vID0YQgIl0Caq1eIdRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758500704; c=relaxed/simple;
	bh=wzTGK+OQfT/lr3hVex1EMxHNsdWLJmjiM+dmyJFA+9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WyHqL1HErAaNLAYT8EAsttWkhdQj4f2OnmRpr4HnG2L/CQQZy4oUHXkxehSa1xvFV4Sjz13zrjjn1beStaJeP4JYQFIsQYLj7IhvQKWXdXpEL6PVzOeHti/Z4PqkE49lTQ6wbThbpt7EmY5Cvla83C95WyZhtQpgT/9UdT24Z98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=K85KitqH; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1758500698; x=1759105498; i=quwenruo.btrfs@gmx.com;
	bh=CztHIHPK8ECGyE8T1gYOScvAJFB2xFzM8aheqJJCAAg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=K85KitqHg88TY64LmrlA7whqlqiFOxuwlv5rsYdMbklih1hTetnMgnuAj7XXngwg
	 kPIf2JbmQDQ9zY4QJ45Nxg8HcCLxYvkjcp1NSWZU9NR+DLPYgZUEHcX0a9IT91+UI
	 7W1BIi7y4FNOosdxwG7EoYoIrYVjdBYoPXEkVZBNEu8FmtJyIo9P8YY8QEGjbLp91
	 MjY0nh8jFYlSMgWIxGk75OlYy2cw4RhQAa0CM0q6n53MWihb76JAQxpueqsiFfcvn
	 I8wu5wKhE6oEJWUK6yHuCjSpHq4PDilHoptZbweKt7c2aVYDUK9g97MoxUWTjY4TG
	 VnadchXkiNX27zYbFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MS3il-1uup3C0mRX-00Sz1u; Mon, 22
 Sep 2025 02:24:58 +0200
Message-ID: <23d859bc-19f9-4cf5-9405-03792dbf2e7a@gmx.com>
Date: Mon, 22 Sep 2025 09:54:53 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Support] failed to read chunk root / open_ctree failed: -5
To: Justin Brown <Justin.Brown@fandingo.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAKZK7uzqNj1336MijN2De-R9+rdjw_Zm6=b-Q1jCCDQb5+fmXw@mail.gmail.com>
 <27b4ca8f-de3a-4b9f-b90d-c6260ba81f9c@suse.com>
 <CAKZK7uxiRmDxk-1goC4yj7QZPSmL-=GAoAuF=OdekbSNVrG8fg@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <CAKZK7uxiRmDxk-1goC4yj7QZPSmL-=GAoAuF=OdekbSNVrG8fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qiB6+f2I5bHjjZNynHavuZAK/TkuPi4hNS/m+2wG0TvQUYcbz/R
 zbQdYMDRdW2iJzl8+vCISDUsmaPMSHXbaeSVRcF76EKz7Vw560AUWwoPhq4pAE3XDsWT2NZ
 NHj4eADXCtu9VDou0xJib3jkTjuWaBHAsghm87fxQk6R9k/hNuFCLZIbbR4RdWWsOUKf8Ev
 QnU1n5M8qkP6ZX4j2lXnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rlknamU85co=;Y73t8uWffDzRpNUJr3ULV4bQG+H
 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



=E5=9C=A8 2025/9/22 09:44, Justin Brown =E5=86=99=E9=81=93:
> Hi Qu,
>=20
> I tried the command you suggested, but I'm not really sure what bytenr
> is in this context. Is that the block number or block number * sector
> size (i.e. 4096)? And when you say "verify which works best," what am
> I looking for?

Btrfs alaywas use numbers in byte, never in block unit.

So in your case, the newest one found is 22233088.

Then you can try something like:

  btrfs check --chunk-root 22233088 <device>

This is still read-only, but it should allows the fsck to run.
You can try the first two or three blocks, to find out which one has the=
=20
minimal amount of errors.

But to be honest, if 22233088 doesn't work that well, the chance using=20
older chunk roots to recover should be pretty low...

Thanks,
Qu
>=20
> I uploaded the full output to pastebin
> (https://pastebin.com/LN2bHDGV), but here's an excerpt
>=20
>=20
> [fandingo:~] $ sudo btrfs-find-root -o 3 /dev/mapper/cm
> parent transid verify failed on 27656192 wanted 4945 found 2607
> parent transid verify failed on 27656192 wanted 4945 found 2607
> WARNING: cannot read chunk root, continue anyway
> Superblock thinks the generation is 4945
> Superblock thinks the level is 1
> Well block 22233088(gen: 4451 level: 1) seems good, but
> generation/level doesn't match, want gen: 4945 level: 1
> Well block 22183936(gen: 3195 level: 1) seems good, but
> generation/level doesn't match, want gen: 4945 level: 1
> Well block 29425664(gen: 3178 level: 1) seems good, but
> generation/level doesn't match, want gen: 4945 level: 1
> Well block 29376512(gen: 3178 level: 1) seems good, but
> generation/level doesn't match, want gen: 4945 level: 1
> Well block 22167552(gen: 2608 level: 0) seems good, but
> generation/level doesn't match, want gen: 4945 level: 1
> Well block 22020096(gen: 2608 level: 0) seems good, but
> generation/level doesn't match, want gen: 4945 level: 1
> Well block 27656192(gen: 2607 level: 0) seems good, but
> generation/level doesn't match, want gen: 4945 level: 1
> Well block 22102016(gen: 2582 level: 1) seems good, but
> generation/level doesn't match, want gen: 4945 level: 1
> Well block 22052864(gen: 2582 level: 1) seems good, but
> generation/level doesn't match, want gen: 4945 level: 1
> Well block 27557888(gen: 2335 level: 1) seems good, but
> generation/level doesn't match, want gen: 4945 level: 1
> Well block 27508736(gen: 2320 level: 1) seems good, but
> generation/level doesn't match, want gen: 4945 level: 1
> Well block 25329664(gen: 1363 level: 1) seems good, but
> generation/level doesn't match, want gen: 4945 level: 1
> [...]
> Well block 24002560(gen: 69 level: 1) seems good, but generation/level
> doesn't match, want gen: 4945 level: 1
> Well block 23953408(gen: 68 level: 1) seems good, but generation/level
> doesn't match, want gen: 4945 level: 1
> Well block 23904256(gen: 67 level: 1) seems good, but generation/level
> doesn't match, want gen: 4945 level: 1
> Well block 23887872(gen: 66 level: 0) seems good, but generation/level
> doesn't match, want gen: 4945 level: 1
> Well block 23871488(gen: 66 level: 0) seems good, but generation/level
> doesn't match, want gen: 4945 level: 1
>=20
>=20
> Thanks,
> fandingo
>=20
> On Sun, Sep 21, 2025 at 5:37=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> =E5=9C=A8 2025/9/22 06:45, Justin Brown =E5=86=99=E9=81=93:
>>> Hi,
>>>
>>> I had a pretty bad power outage that fried my server. I pulled a Btrfs
>>> HDD (1 drive, -d single, -m dup), and I'm trying to recover it. The
>>> HDD works fine -- the LUKS volume unlocks, and I can dd read from it,
>>> but the fs seems to be in bad shape. I've spent a few hours
>>> researching, but a lot of the information out there is really low
>>> quality. I've tried to stay away from the really dangerous stuff so
>>> far, but I did try some of the more benign troubleshooting.
>>>
>>> Kernel: 6.16.5-arch1-1
>>> btrfs-progs v6.16
>>>
>>> [fandingo:~] $ lsblk -o name,size,label,fstype,model /dev/sdc
>>> NAME  SIZE LABEL       FSTYPE      MODEL
>>> sdc   7.3T crypt_media crypto_LUKS ST8000VN004-2M2101
>>> =E2=94=94=E2=94=80cm  7.3T media       btrfs
>>>
>>> [fandingo:~] $ sudo btrfs fi showLabel: 'media'  uuid:
>>> e2dc4c13-e687-4829-8c24-fa822d9ba04a
>>>          Total devices 1 FS bytes used 6.10TiB
>>>          devid    1 size 7.28TiB used 6.24TiB path /dev/mapper/cm
>>>
>>>
>>> [fandingo:~] $ sudo mount -o ro /dev/mapper/cm /var/media/
>>> mount: /var/media: can't read superblock on /dev/mapper/cm.
>>>         dmesg(1) may have more information after failed mount system c=
all.
>>> [fandingo:~] 32 $ sudo dmesg
>>> [ 7546.813999] BTRFS: device label media devid 1 transid 4956
>>> /dev/mapper/cm (253:5) scanned by mount (6934)
>>> [ 7546.814345] BTRFS info (device dm-5): first mount of filesystem
>>> e2dc4c13-e687-4829-8c24-fa822d9ba04a
>>> [ 7546.814354] BTRFS info (device dm-5): using crc32c (crc32c-x86)
>>> checksum algorithm
>>> [ 7546.814743] BTRFS error (device dm-5): level verify failed on
>>> logical 27656192 mirror 1 wanted 1 found 0
>>> [ 7546.814831] BTRFS error (device dm-5): level verify failed on
>>> logical 27656192 mirror 2 wanted 1 found 0
>>> [ 7546.814837] BTRFS error (device dm-5): failed to read chunk root
>>> [ 7546.814933] BTRFS error (device dm-5): open_ctree failed: -5
>>>
>>>
>>> I've tried a few recovery options, tending towards the more safe side.
>>>
>>> ~$: sudo mount -o ro,rescue=3Dusebackuproot /dev/mapper/cm /var/media
>>> Same error and dmesg
>>
>> This means the corruption in not in the last transaction, but may be on=
e
>> generations earlier.
>>
>> This also indicates that some metadata write is lost, which is a huge
>> problem.
>> Not sure if LUKS or the HDD is involved in this case.
>>>
>>> =3D=3D=3D=3D=3D=3D
>>>
>>> [fandingo:~] 3s $ sudo btrfs-find-root /dev/mapper/cm
>>
>> Find root should help in this case, but not the default option.
>>
>> You need "-o 3" option to tell the program to find chunk root.
>>
>> Then use the bytenr it reported to pass into "btrfs check --chunk-root
>> <bytenr>" to verify which works the best.
>>
>> Thanks,
>> Qu
>>
>>> parent transid verify failed on 27656192 wanted 4945 found 2607
>>> parent transid verify failed on 27656192 wanted 4945 found 2607
>>> WARNING: cannot read chunk root, continue anyway
>>> Superblock thinks the generation is 4956
>>> Superblock thinks the level is 0
>>>
>>> =3D=3D=3D=3D=3D=3D
>>>
>>> [fandingo:~] 30s $ sudo btrfs rescue zero-log /dev/mapper/cm
>>> parent transid verify failed on 27656192 wanted 4945 found 2607
>>> parent transid verify failed on 27656192 wanted 4945 found 2607
>>> ERROR: cannot read chunk root
>>> ERROR: could not open ctree
>>>
>>> =3D=3D=3D=3D=3D=3D
>>>
>>> [fandingo:~] 1 $ sudo btrfs rescue super-recover /dev/mapper/cm
>>> All supers are valid, no need to recover
>>>
>>> =3D=3D=3D=3D=3D=3D
>>>
>>> [fandingo:~] 4s $ sudo btrfs restore /dev/mapper/cm /var/media/
>>> parent transid verify failed on 27656192 wanted 4945 found 2607
>>> parent transid verify failed on 27656192 wanted 4945 found 2607
>>> parent transid verify failed on 27656192 wanted 4945 found 2607
>>> Ignoring transid failure
>>> ERROR: root [3 0] level 0 does not match 1
>>>
>>> ERROR: cannot read chunk root
>>> Could not open root, trying backup super
>>> parent transid verify failed on 27656192 wanted 4945 found 2607
>>> parent transid verify failed on 27656192 wanted 4945 found 2607
>>> parent transid verify failed on 27656192 wanted 4945 found 2607
>>> Ignoring transid failure
>>> ERROR: root [3 0] level 0 does not match 1
>>>
>>> ERROR: cannot read chunk root
>>> Could not open root, trying backup super
>>> parent transid verify failed on 27656192 wanted 4945 found 2607
>>> parent transid verify failed on 27656192 wanted 4945 found 2607
>>> parent transid verify failed on 27656192 wanted 4945 found 2607
>>> Ignoring transid failure
>>> ERROR: root [3 0] level 0 does not match 1
>>>
>>> ERROR: cannot read chunk root
>>> Could not open root, trying backup super
>>>
>>> =3D=3D=3D=3D=3D=3D=3D
>>>
>>> [fandingo:~] 13s $ sudo btrfs inspect-internal dump-tree /dev/mapper/c=
m
>>> btrfs-progs v6.16.1
>>> parent transid verify failed on 27656192 wanted 4945 found 2607
>>> parent transid verify failed on 27656192 wanted 4945 found 2607
>>> ERROR: cannot read chunk root
>>> ERROR: unable to open /dev/mapper/cm
>>>
>>> Same error for `btrfs inspect-internal tree-stats`.
>>>
>>> =3D=3D=3D=3D=3D=3D=3D
>>>
>>> [fandingo:~] 4s $ sudo btrfs inspect-internal dump-super /dev/mapper/c=
m
>>> superblock: bytenr=3D65536, device=3D/dev/mapper/cm
>>> ---------------------------------------------------------
>>> csum_type               0 (crc32c)
>>> csum_size               4
>>> csum                    0x05e1f6bc [match]
>>> bytenr                  65536
>>> flags                   0x1
>>>                          ( WRITTEN )
>>> magic                   _BHRfS_M [match]
>>> fsid                    e2dc4c13-e687-4829-8c24-fa822d9ba04a
>>> metadata_uuid           00000000-0000-0000-0000-000000000000
>>> label                   media
>>> generation              4956
>>> root                    998506496
>>> sys_array_size          129
>>> chunk_root_generation   4945
>>> root_level              0
>>> chunk_root              27656192
>>> chunk_root_level        1
>>> log_root                0
>>> log_root_transid (deprecated)   0
>>> log_root_level          0
>>> total_bytes             8001546444800
>>> bytes_used              6708315303936
>>> sectorsize              4096
>>> nodesize                16384
>>> leafsize (deprecated)   16384
>>> stripesize              4096
>>> root_dir                6
>>> num_devices             1
>>> compat_flags            0x0
>>> compat_ro_flags         0x3
>>>                          ( FREE_SPACE_TREE |
>>>                            FREE_SPACE_TREE_VALID )
>>> incompat_flags          0x361
>>>                          ( MIXED_BACKREF |
>>>                            BIG_METADATA |
>>>                            EXTENDED_IREF |
>>>                            SKINNY_METADATA |
>>>                            NO_HOLES )
>>> cache_generation        0
>>> uuid_tree_generation    4956
>>> dev_item.uuid           529d3f9a-52be-4af5-a8e8-7bf6108c65e7
>>> dev_item.fsid           e2dc4c13-e687-4829-8c24-fa822d9ba04a [match]
>>> dev_item.type           0
>>> dev_item.total_bytes    8001546444800
>>> dev_item.bytes_used     6856940453888
>>> dev_item.io_align       4096
>>> dev_item.io_width       4096
>>> dev_item.sector_size    4096
>>> dev_item.devid          1
>>> dev_item.dev_group      0
>>> dev_item.seek_speed     0
>>> dev_item.bandwidth      0
>>> dev_item.generation     0
>>>
>>>
>>>
>>>
>>>
>>> This HDD is used for occasional archival, and it probably didn't see
>>> any data writes in the week prior to the power surge. If I could get
>>> access to any of the data, even old version (eg. that 2607 transid or
>>> whatever the proper terminology is), would be very useful. Any
>>> suggestions on what to do from here?
>>>
>>> Thanks,
>>> fandingo
>>>
>>
>=20


