Return-Path: <linux-btrfs+bounces-7714-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B82967C82
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 00:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0BBF1F214A9
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Sep 2024 22:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACF2185B4A;
	Sun,  1 Sep 2024 22:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="CNth6cRR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7791304B0
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Sep 2024 22:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725228880; cv=none; b=BvBFqiA5aBDzOmbap96oHGMDWDOXa65TMuxwb4OJ1tbXMShSy/WrlVU5FY07w0qlAJUjvtjrTyg1T8gxPuw/nfi3w1SgLepJLGuTErbAiRshSzIjKy0GyA+WdOlyTznryLjuOJHGy9zRZt2j/bsAYy3cMR2jwrHRcI2mb5zsI14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725228880; c=relaxed/simple;
	bh=T1Z2f4yYC7tf3y4SHJYsnSVfbsaBUdr07UVy24uKGG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FrnSxwj9eL2R1W2iFNDd8DVcsmY36v2VTi3ylZm/WzVsb44qIvJwLFb9Z90cij335m6XsO2emHaGLmZ/4h4u7jDxZ5/HEbNH59/7INNVTPGkW1BLRcthY3cDLfjokS1JxvXdkgVtF9CnxV/5IMRcf5ZjPNXU8VdhEM1LuXsn0r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=CNth6cRR; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1725228813; x=1725833613; i=quwenruo.btrfs@gmx.com;
	bh=MK+OvhyUpwqVr50mcEEE/NJAHhId6VnawCx2zEl9IEs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CNth6cRRuCyBfFKSV0cRer8fjPk6RLs1jQInFn8m68m8KjARd2TXTcVnlDY/afN8
	 KkPHruF5rllOnfba73gLH3BIz3WmaeaIOEQuImw2kW7Or4chf66FuotlFCnNEePjj
	 rcTKW+KjFNRERQzzD+Zpp0jSuS5UalkLyXMTOWY4aoj5NgNKoZUD2Vh3XBxxVlTMW
	 EgTfMtRZi5gDJHIdssYJJlPiir0Pks4AukrxWZ9DU5yXyyN6iIGLasQ5IaPk2TGny
	 ESKOVdoS6oQrc2EFwZlMv0ExlNMu4DV7fu1KobGVZyvOwBVWdojS4X9TLCYI5WU1/
	 W6GsrU534K9YDwCl1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MwQXN-1rt3DV3dcD-00vBgO; Mon, 02
 Sep 2024 00:13:33 +0200
Message-ID: <c06d4a06-589a-428d-a50f-93e29254976e@gmx.com>
Date: Mon, 2 Sep 2024 07:43:30 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Corrupt BTRFS can't be get into a consistent state
To: Gerhard Wiesinger <lists@wiesinger.com>, linux-btrfs@vger.kernel.org
References: <63f8866f-ceda-4228-b595-e37b016e7b1f@wiesinger.com>
Content-Language: en-US
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
In-Reply-To: <63f8866f-ceda-4228-b595-e37b016e7b1f@wiesinger.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tmfS5tG24N5NaYEIu0O2XhK8nzWNqzHWz5jZqG40g1+ddbv0umG
 6IxvHgoovaMBjOavZRIhRF4Mtk8fRyEWhWGDwO6Mo7PaBgkyWDJ02RiyjdpKE+5th2M2ICS
 6/5VwEAW2nwaS1FiZAH5Di/1lFdm1uEhA3j9yi8gJ2Cpc1oIbSNZiXa/BQ6lSrP3UIJDpRK
 op9ssMJfkihycRu0HuwHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZWlP1ktOWdM=;p4U/cVuGfborhUHLh+2tqPHPp5y
 FSzCqfWCr6S4nvThfhHoXXtRjcps/BsWfq3ji3ETL8igK7+ovYaumXLdACNMG72tc+DboQF3a
 qto02XqrLtfPzZORcz+yKbKiTSBiLZjvvmeD3Cg6OUQeuYaRgmWi9i7TsikeuvjV5G73GEGEm
 9NnO0HBKKTaDv/lzdudiesdnMYZ1qj0Jx0WKVVEhmv8tDHmaGu3N9prv+HDRs2pjjdm11zixb
 is+67U0TifOYlvcDy3p0FZOYfNhREJRI/zYOUi0TeRhBfLQ1OKiBGdrGbLULZ7YEU6araz80u
 rdaFszxvD/AyFKKkGsFESBbo/8feoaf8cO9mGfuTStB5J2cX//a/Ki3O2xVFqzUsTrhOFcpYP
 or4WpxtDF2sbOFOSSV6wkYKgV1Wk0Cfy+mI/JNXdx8I622BPN0EDCyQzrZ7L9Dc0vZRrZ1mr9
 c2oHkkQnRvotN0/esWcXbUnXlvlhj1pWFiXu6V7sGJFmRTk9UCr9gwkCyBC4Z6qBUzBrH5sZu
 I/TNCF9oHCbkBiNCaJgHIbjkvckjNHfp/o1OW3JuSTyWCAVlQwhN4mMqmtf4szcdORwfiEX0U
 j62skj4QgQ0/h636BQ2onjQLNiWFktq/+pAYXE2OEU24628AD1xXpEd7dEwfub3EgqUwneD3x
 jYOEAVdPckMo9DtK9SZxbN9l/EpmG0FU0Oq5sqU3u32UdMcxz4Fjba/vyOsTJsSlIDMvb2kHu
 ZHz5et0FLE6BKW/WXc+QHmKswvFyTW1VWdic1eCAwAFhD0UAtWYKfJKS+46kAiThrTw45IuXV
 mZqylBZMl8Fs4qOV0Wt4+I3A==



=E5=9C=A8 2024/9/1 21:13, Gerhard Wiesinger =E5=86=99=E9=81=93:
> Hello,
>
> I'm having some Fedora Linux VMs (actual versions, latest updates) in a
> virtual test infrastructure on Virtualbox. There I run different VMs
> with different filesystems (ext4, xfs, zfs, bcachefs and btrfs).
>
> I had a hardware problem on the underlying hardware where around 1000 4k
> blocks could not be read anymore. I migrated with ddrescure the whole
> disk which worked well.
>
> Of course I was expecting some data loss in the VMs but wanted to get
> them in a consistent state.
>
> The following file systems got very easy in a consistent state with the
> corresponding repair/scrub tools of the filesystems:
> - ext4
> - xfs
> - zfs
>
> Unfortunately 2 filesystem can't get into a state, where the filesystem
> repair tools report "everything fine" (of course with some loss data,
> but that's fine):
> - btrfs
> - bcachefs
>
> btrfs --version
> btrfs-progs v6.10.1
> -EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED
> CRYPTO=3Dlibgcrypt
>
> commands run with btrfs:
> btrfs check device

This is readonly operation, just to tell you what's going wrong.

> btrfs check --init-csum-tree device
> btrfs check --init-extent-tree device

These two are dangerous operations.

And why you didn't try "btrfs scrub"?

>
> But btrfs never got into a consistent state, also with newer versions
> (have copies of original virtual disk, around 6 month ago). Also btrfs
> check runs for hours for around 4GB of data.
>
> To reproduce the problem I created a new filesystem and copied some
> files there:
> # Copy around 4GB
> time cp -Rap /usr /mnt
>
> Afterwards I created a (quick&dirty) script "corrupt_device.sh" to
> corrupt the device in the same manner as the original failure (1000 4k
> blocks will be randomly overwritten).
> Script: see below
>
> Result: It can be reproduced, that btrfs can't be brought into a
> consistent state even after several runs of the repair.
> If the filesystem is modified in between (e.g. some further files are
> written) it gets even worser.
>
> You can also try to reproduce it and create a testcase out of it.

I created a 10GiB fs, filled with around 3.7G data using fsstress, run
your script.

And the result is the opposite as yours:

Opening filesystem to check...
Checking filesystem on /dev/test/scratch1
UUID: c2be653b-6b00-4ed9-925f-258cc7ca5391
[1/7] checking root items
checksum verify failed on 37896192 wanted 0x1e3b3b76 found 0xf6ba3f0c
[2/7] checking extents
checksum verify failed on 276135936 wanted 0x142c0f06 found 0xdcc4a8df
checksum verify failed on 66502656 wanted 0x6fff8502 found 0x333397eb
checksum verify failed on 107397120 wanted 0x52894737 found 0x56e3558b
checksum verify failed on 235864064 wanted 0x3a0b6ded found 0xe11cbb02
checksum verify failed on 72384512 wanted 0x9306ee79 found 0x62a123d8
checksum verify failed on 264683520 wanted 0x2cebc20f found 0x293c9426
checksum verify failed on 196001792 wanted 0xe3ec9b3f found 0x29d32fce
[3/7] checking free space tree
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 3776757760 bytes used, no error found <<<
total csum bytes: 1692008
total tree bytes: 82444288
total fs tree bytes: 71237632
total extent tree bytes: 6455296
btree space waste bytes: 43820357
file data blocks allocated: 29158084608
  referenced 4905811968

Btrfs properly detects the corruption in metadata, but since the default
profile is DUP, it's totally fine and can go with the other mirror.

And sure since your data is still SINGLE thus you will lose some data,
but your metadata is totally fine.

With proper btrfs scrub run:

scrub done for c2be653b-6b00-4ed9-925f-258cc7ca5391
Scrub started:    Mon Sep  2 06:08:23 2024
Status:           finished
Duration:         0:00:03
Total to scrub:   3.61GiB
Rate:             1.20GiB/s
Error summary:    verify=3D36 csum=3D169
   Corrected:      60
   Uncorrectable:  145
   Unverified:     0

So it means 60 metadata csum mismatch is fixed, only 145 bad data sectors.

And after the above scrub, btrfs check reports no more error (at least
for metadata):

Opening filesystem to check...
Checking filesystem on /dev/test/scratch1
UUID: c2be653b-6b00-4ed9-925f-258cc7ca5391
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space tree
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 3776757760 bytes used, no error found
total csum bytes: 1692008
total tree bytes: 82444288
total fs tree bytes: 71237632
total extent tree bytes: 6455296
btree space waste bytes: 43819992
file data blocks allocated: 29158084608
  referenced 4905811968

>
> Any ideas how to repair and what can be done to get it into a consistent
> state?

Please give the original "btrfs check" output.

I think your original fs is either using SINGLE metadata profile (then
very hard to do repair), AND you're using incorrect way to repair (scrub
first, then btrfs check to verify, never --init-extent-tree nor
=2D-init-csum-tree unless you know what you're really doing).

And your random corruption script is the best case scenario for btrfs,
it's pretty easy for btrfs just to use the good mirror to repair
metadata, without any need to extra repair inside metadata.

Thanks,
Qu
>
> Thnx.
>
> Ciao,
> Gerhard
>
> Script corrupt_device.sh:
> #!/usr/bin/env bash
>
> RANDOM_DEVICE=3D/dev/urandom
> OUTPUT_DEVICE=3D/dev/sdb
> COUNT=3D1000
> BLOCK_SIZE=3D4096
>
> MAX_BLOCK_SIZE=3D$(blockdev --getsize64 ${OUTPUT_DEVICE})
>
> echo "# Configured maximum size=3D${MAX_BLOCK_SIZE}"
> MAX_BLOCK_NUMBER=3D$((MAX_BLOCK_SIZE/BLOCK_SIZE))
> echo "# Maximum block number=3D${MAX_BLOCK_NUMBER}"
>
> for ((BLOCK_NUMBER=3D1; BLOCK_NUMBER<=3D${COUNT}; BLOCK_NUMBER++ )) do
>  =C2=A0 BLOCK=3D`shuf --input-range=3D0-${MAX_BLOCK_NUMBER} --head-count=
=3D1`
>  =C2=A0 dd if=3D${RANDOM_DEVICE} of=3D${OUTPUT_DEVICE} bs=3D${BLOCK_SIZE=
}
> seek=3D${BLOCK} count=3D1 > /dev/null 2>&1
> done
>
>

