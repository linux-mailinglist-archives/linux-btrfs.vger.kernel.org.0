Return-Path: <linux-btrfs+bounces-3081-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57456875B8A
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 01:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA8D282A1D
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 00:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7D4810;
	Fri,  8 Mar 2024 00:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="tFaoynk6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1228E363
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 00:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709857603; cv=none; b=kRUN9godbVIHMXifuzZm8OfP5gmEBK+SDuYhXgbTjnr8kptOoWFcCAxf9VEw02tDI3AHlgOBjfJOycoOSyCI+VGH3oS+rNtfhVp9lMNBgjOSEUGPGsHwKtjHluIMlo+WjkO6Wl8kfkLJWaN4BWmSo8HR5LudYfWUzOcMpL2fYQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709857603; c=relaxed/simple;
	bh=e1z6tAC3fqHHtap/drTl5XlUDj12+FQVwGFl4RkbhbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LlK8IyfERt7iAeqBLiUyCLHc4YfZFJdJii5FG608JCmO2nID/kvuGEcQOwakTWyDcDAaiLqQm+fjjd1VPJV3Auw5SQbaGAZbSLsPcngpADy31dK4MTFJ963qIcr4XFi5NKF/3UExPsXu30OcMF5A1B7Zg5Vvj8FaQfQKZvvjcqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=tFaoynk6; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1709857598; x=1710462398; i=quwenruo.btrfs@gmx.com;
	bh=e1z6tAC3fqHHtap/drTl5XlUDj12+FQVwGFl4RkbhbI=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=tFaoynk6yEVpOtEbkpJutRDGE3dloXQ/WYuViw3CwEINRzUMNJTR13I1jjiswHZH
	 AZhohGw9Bffmse0lMx0ob97uzDd914dELh/7EoXbpq3igDq5ZTPSdjhfhxHRQZvVR
	 aOGiS8aBOriykqhL5c/WiVz2rSfuo4M9Hj5yek01O0GyD6Dt2xgfLAUTC9w20Ze3C
	 eoGMaWlt0O/oNUi3UgBNcM9X7p94vl7r5o3Coam2hU6Y2Lbh++QuW8YuEGOfOTFxN
	 KOBVeE1SkOW3QDUcwK/wm7uj+q/RD10YKQ16OrSAJQYB8MzczQxByhWSjQM/z2l03
	 nHvRjqPjzeXTuzsHeQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0G1n-1qwrus3eUB-00xIu0; Fri, 08
 Mar 2024 01:26:38 +0100
Message-ID: <ba3a8690-1604-429e-9e8a-7c381e6592f8@gmx.com>
Date: Fri, 8 Mar 2024 10:56:34 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: scrub: last_physical not always updated when scrub is cancelled
Content-Language: en-US
To: Michel Palleau <michel.palleau@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAMFk-+igFTv2E8svg=cQ6o3e6CrR5QwgQ3Ok9EyRaEvvthpqCQ@mail.gmail.com>
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
In-Reply-To: <CAMFk-+igFTv2E8svg=cQ6o3e6CrR5QwgQ3Ok9EyRaEvvthpqCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:esmkM3NGT+VHZ/dyHnCtJHjdaO0TPVCLZfyEynfIW9qx4Pk8BdD
 Q5ONxNpZh1uNNgWF+kzRazoGsXed3MsoA/MbzXazaPzsmBqoruhVU9U/ZQ8j7eZFcU7tVWB
 NG3rISS0mEhvFqzyirF+cdiPHfUW7xatZyB3E9BnYlFgUPq7rxsn0qpfQChv1LY/2S7nPsu
 I3IO9FMWpCNwZsAqrj6Cw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zhM57ytk1Yg=;P0fZPGKavqB+0G6cmwVrLn82G0R
 L58QauftaPsm1+FUCIthMZcpXncL9NnECb/RPGfZgB6ioHx8frGAuhqrjfB4YitnGImqKgLgn
 ZBOf1JLPsPTKljQw8BYjNB+8xarnAiBO4v8DGVSnGvXrLtWUYUd3hK2a7SAs5IfUloIvLHBS7
 Y/zzNxn8IX/xCxd+5TqEWlQLS+EN3D8YyDFbyRJjkdbNws9a4w6Msjn1MrxEWHDoJhVhMIFD7
 v91ZHb72tGq+n+onnIIkZVNG2VUMWDiSr2gkOZ5Xokv3TXwS67eYanSFB4ekf4330iuomm3cO
 ar193e+m9halueD1WJfEiQhWf8557Dg11zGeHkEGYHJZ+18PXdoKhfQqF4vnmGIFklyXDqhNA
 z4uM/1ZL4q0tNuPM0mWUzgOQoWFJz2FaNwQwSRHPWmYKbKYns8ipgQq4eBXv7trK+11jfLbsz
 FPb0HC1XABsvpQAWCf5YKN/8ibAs86gqZn5Uus2+hHsRprKPiOObvf6E3cUa6JFmFzmdbQx9+
 DpNemKhRGnGYGkwVt8aYf8VrJ0l23F3UHva4oLgP/kaTZM2ZGTWNS499tpZxS6zGdayxCVYrd
 KuXnyYZQmohh0O2qITgnZzo70tY25ojKVRi7TYl3wgQ9nT0E4qKHTR3o0qqOT+nnhFXnTlznE
 3zqA1MEplvK4HYwk2mVnP5o4ZGhA9zjW7Xivdmo+wZ1VkDWnPaD/+t8MG4lnzLcwipnqOiurw
 QuPVNk1fw22ALAtsQ9XLn8MwrLXyYIHkNWigaothXRek1qKSiUdLRDA8r7Zwz6qpZ4jTFsZJl
 cFZQTy+YCopk39gzO+LJ2NrdZm3l1gk2OQ/+Bw26hx9mw=



=E5=9C=A8 2024/3/8 07:07, Michel Palleau =E5=86=99=E9=81=93:
> Hello everyone,
>
> While playing with the scrub operation, using cancel and resume (with
> btrfs-progs), I saw that my scrub operation was taking much more time
> than expected.
> Analyzing deeper, I think I found an issue on the kernel side, in the
> update of last_physical field.
>
> I am running a 6.7.5 kernel (ArchLinux: 6.7.5-arch1-1), with a basic
> btrfs (single device, 640 GiB used out of 922 GiB, SSD).
>
> Error scenario:
> - I start a scrub, monitor it with scrub status and when I see no
> progress in the last_physical field (likely because it is scrubbing a
> big chunk), I cancel the scrub,
> - then I resume the scrub operation: if I do a scrub status,
> last_physical is 0. If I do a scrub cancel, last_physical is still 0.
> The state file saves 0, and so next resume will start from the very
> beginning. Progress has been lost!
>
> Note that for my fs, if I do not cancel it, I can see the
> last_physical field remaining constant for more than 3 minutes, while
> the data_bytes_scrubbed is increasing fastly. The complete scrub needs
> less than 10 min.
>
> I have put at the bottom the outputs of the start/resume commands as
> well as the scrub.status file after each operation.
>
> Looking at kernel code, last_physical seems to be rarely updated. And
> in case of scrub cancel, the current position is not written into
> last_physical, so the value remains the last written value. Which can
> be 0 if it has not been written since the scrub has been resumed.
>
> I see 2 problems here:
> 1. when resuming a scrub, the returned last_physical shall be at least
> equal to the start position, so that the scrub operation is not doing
> a step backward,
> 2. on cancel, the returned last_physical shall be as near as possible
> to the current scrub position, so that the resume operation is not
> redoing the same operations again. Several minutes without an update
> is a waste.
>
> Pb 1 is pretty easy to fix: in btrfs_scrub_dev(), fill the
> last_physical field with the start parameter after initialization of
> the context.

Indeed, we're only updating last_physical way too infrequently.

> Pb 2 looks more difficult: updating last_physical more often implies
> the capability to resume from this position.

The truth is, every time we finished a stripe, we should update
last_physical, so that in resume case, we would waste at most a stripe
(64K), which should be minimal compared to the size of the fs.

This is not hard to do inside flush_scrub_stripes() for non-RAID56 profile=
s.

It may needs a slightly more handling for RAID56, but overall I believe
it can be done.

Let me craft a patch for you to test soon.

Thanks,
Qu


>
> Here are output of the different steps:
>
> # btrfs scrub start -BR /mnt/clonux_btrfs
> Starting scrub on devid 1
> scrub canceled for 4c61ff6d-a903-42f6-b490-a3ce3690604e
> Scrub started:    Thu Mar  7 17:11:17 2024
> Status:           aborted
> Duration:         0:00:22
>          data_extents_scrubbed: 1392059
>          tree_extents_scrubbed: 57626
>          data_bytes_scrubbed: 44623339520
>          tree_bytes_scrubbed: 944144384
>          read_errors: 0
>          csum_errors: 0
>          verify_errors: 0
>          no_csum: 1853
>          csum_discards: 0
>          super_errors: 0
>          malloc_errors: 0
>          uncorrectable_errors: 0
>          unverified_errors: 0
>          corrected_errors: 0
>          last_physical: 36529242112
>
> # cat scrub.status.4c61ff6d-a903-42f6-b490-a3ce3690604e
> scrub status:1
> 4c61ff6d-a903-42f6-b490-a3ce3690604e:1|data_extents_scrubbed:1392059|tre=
e_extents_scrubbed:57626|data_bytes_scrubbed:44623339520|tree_bytes_scrubb=
ed:944144384|read_errors:0|csum_errors:0|verify_errors:0|no_csum:1853|csum=
_discards:0|super_errors:0|malloc_errors:0|uncorrectable_errors:0|correcte=
d_errors:0|last_physical:36529242112|t_start:1709827877|t_resumed:0|durati=
on:22|canceled:1|finished:1
>
> # btrfs scrub resume -BR /mnt/clonux_btrfs
> Starting scrub on devid 1
> scrub canceled for 4c61ff6d-a903-42f6-b490-a3ce3690604e
> Scrub started:    Thu Mar  7 17:13:07 2024
> Status:           aborted
> Duration:         0:00:07
>          data_extents_scrubbed: 250206
>          tree_extents_scrubbed: 0
>          data_bytes_scrubbed: 14311002112
>          tree_bytes_scrubbed: 0
>          read_errors: 0
>          csum_errors: 0
>          verify_errors: 0
>          no_csum: 591
>          csum_discards: 0
>          super_errors: 0
>          malloc_errors: 0
>          uncorrectable_errors: 0
>          unverified_errors: 0
>          corrected_errors: 0
>          last_physical: 0
>
> # cat scrub.status.4c61ff6d-a903-42f6-b490-a3ce3690604e
> scrub status:1
> 4c61ff6d-a903-42f6-b490-a3ce3690604e:1|data_extents_scrubbed:1642265|tre=
e_extents_scrubbed:57626|data_bytes_scrubbed:58934341632|tree_bytes_scrubb=
ed:944144384|read_errors:0|csum_errors:0|verify_errors:0|no_csum:2444|csum=
_discards:0|super_errors:0|malloc_errors:0|uncorrectable_errors:0|correcte=
d_errors:0|last_physical:0|t_start:1709827877|t_resumed:1709827987|duratio=
n:29|canceled:1|finished:1
>
> Best Regards,
> Michel Palleau
>

