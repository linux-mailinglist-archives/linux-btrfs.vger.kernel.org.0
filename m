Return-Path: <linux-btrfs+bounces-15297-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AB6AFBE41
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 00:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97AFB4A6FB8
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 22:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5A727F01C;
	Mon,  7 Jul 2025 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="cpeJ/ZR5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA94217DFE7
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 22:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751927444; cv=none; b=QFY80o/nsixRMj9ggt4BUrcXuUOK7OK1I2kbajLzZysA+0re7F+WhwX2Zzg/IbC91jBYar9F29tzdbS1XOhPyh2MQQuhJBbq02N9k1iq7tLioCvWCfUptOJZh6JYu4iUVN74kVpx3vDgd2v0GNjbM3kSp9BKUsMilB/OqWxu7Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751927444; c=relaxed/simple;
	bh=+MHAuHXoyGP7kkBhCuH+cIlZlEddmrhc/wVDSvYeQ4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KECRQPG5BFzS2TEU89mcG+yxrw9y/9apT9Kt+cZPFre35NkJrAR05vDLfAkNc+QwCOguTMc57JA1ccdpllG5IuISjK5qPvWBXjCoDbTrQ6zTdWHLY1AzDaahuI7lGTUSjylU0B+27hbF5l7XW/jppafQSHjMcIK49+iUSIaqI38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=cpeJ/ZR5; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1751927439; x=1752532239; i=quwenruo.btrfs@gmx.com;
	bh=FE54OX5n3y1At0D7E0jCXL0JSwfoY40ZUO4QESnnFmc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cpeJ/ZR5ov9lOyxWJKij0ucqvmA3G+vEwPr625af57S/sY9eFPiKjJuse87c0IrE
	 7Nj4Ce8IPOA2QsixQv87cIZcrtCxt1zh4m+CQ4vud5UaZtTMpMa2Xttv6z9Mq+hbe
	 XWorqRnu1FAM/xiDYT8vyIGGCKuMyp/kj4zMAkVEYTkLLChrcssJ3RXBQ82Yy6kGX
	 ENYe4e1h7WcEl/ZrPv2ksd6XIXxf4Ef59rHmk7Z8aqlKCme2v8Fbvtjw4ZUN2qOMv
	 zrHd1WFbqGGpnuc1cUTIZQnXA1/WTZN29NtQQOBAzs9KJ7xBdTlx2ypMLgyGJp1z0
	 YFmIChoYjuSTTuRK0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAONX-1uOl5I0B47-004Gd4; Tue, 08
 Jul 2025 00:30:39 +0200
Message-ID: <5defd3da-16df-4ffb-907b-7bbec0bf9a41@gmx.com>
Date: Tue, 8 Jul 2025 08:00:35 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Scrub problem with Debian kernel 6.12.33+deb13-amd64
To: Russell Coker <russell@coker.com.au>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <3036994.e9J7NaK4W3@dojacat>
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
In-Reply-To: <3036994.e9J7NaK4W3@dojacat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yobdSC0NG/4/fGQ3QbQwJHc7auNt/rJXr+aKhhKqMa5qvtq1/P0
 8E7z/3aN7yyH3vMB5emu/UXMiuLwPOcs77i0riI+LcxeZqhUhHYFHfBoozqdqp6Ykkwpxw3
 LAihK1bH+CdAIL38Tjsa2xWYtl/DUOkl3MkouXmR8Kdeq6g4+dUIpRlDRlm8HShiYuLMwmR
 kHKpfNIY7MFyBiIgj8APg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Cl0O5N6OCaU=;wc6NnosLICtS6hKsFBPByjb1T6R
 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



=E5=9C=A8 2025/7/7 20:25, Russell Coker =E5=86=99=E9=81=93:
> I ran a scrub on my laptop running the latest Debian/Testing setup.  It'=
s a
> Thinkpad X1 Carbon Gen6 that has just been updated to the latest firmwar=
e
> (Thinkpad BIOS, management engine, and some 3rd thing on the motherboard=
).  It
> had crashed a few times before which I think has been fixed by the firmw=
are
> update, it is plausible that the crashes caused some corruption.

You miss the most important thing, kernel version.

>=20
> The system is running LUKS encryption.  After the monthly btrfs scrub I =
got
> the following in the cron output:
>=20
> ERROR: there are 1 uncorrectable errors
> Starting scrub on devid 1
> scrub done for d90583c8-9284-48b4-9444-abd00924002a
> Scrub started:    Mon Jul  7 02:30:01 2025
> Status:           finished
> Duration:         0:02:46
> Total to scrub:   226.35GiB
> Rate:             1.36GiB/s
> Error summary:    csum=3D110693
>    Corrected:      0
>    Uncorrectable:  110693
>    Unverified:     0
>=20
> I ran the following commands to get more data and got the below output. =
 It
> seems that we have a clear problem of btrfs dev sta reporting 0 errors w=
hen
> there were apparently many errors!

Already fixed by upstream commit ec1f3a207cdf ("btrfs: scrub: update=20
device stats when an error is detected").

>=20
> root@dojacat:/var/log# btrfs dev sta /
> [/dev/mapper/root].write_io_errs    0
> [/dev/mapper/root].read_io_errs     0
> [/dev/mapper/root].flush_io_errs    0
> [/dev/mapper/root].corruption_errs  0
> [/dev/mapper/root].generation_errs  0
> root@dojacat:/var/log# btrfs scrub status /
> UUID:             d90583c8-9284-48b4-9444-abd00924002a
> Scrub started:    Mon Jul  7 02:30:01 2025
> Status:           finished
> Duration:         0:02:46
> Total to scrub:   226.34GiB
> Rate:             1.36GiB/s
> Error summary:    csum=3D110693
>    Corrected:      0
>    Uncorrectable:  110693
>    Unverified:     0
>=20
>=20
> [190966.907320] BTRFS info (device dm-0): scrub: started on devid 1
> [191057.409078] scrub_stripe_report_errors: 110553 callbacks suppressed
> [191057.409081] scrub_stripe_report_errors: 110576 callbacks suppressed
> [191057.409084] BTRFS error (device dm-0): unable to fixup (regular) err=
or at
> logical 327469629440 on dev /dev/mapper/root physical 147760480256
> [191057.409138] BTRFS error (device dm-0): unable to fixup (regular) err=
or at
> logical 327469563904 on dev /dev/mapper/root physical 147760414720
> [191057.409300] _btrfs_printk: 290 callbacks suppressed
> [191057.409303] BTRFS warning (device dm-0): checksum error at logical
> 327469629440 on dev /dev/mapper/root, physical 147760480256, root 540, i=
node
> 1826602, offset 2087845888, length 4096, links 1 (path: home.old/tv/Foo.
> 2024.S01E08.1080p.WEB.H264-SuccessfulCrab.mkv)
>=20
> [many more about similar files]
>=20
> [191057.410987] BTRFS warning (device dm-0): checksum error at logical
> 327469629440 on dev /dev/mapper/root, physical 147760480256, root 522, i=
node
> 174508, offset 2087845888, length 4096, links 1 (path: tv/Foo.
> 2024.S01E08.1080p.WEB.H264-SuccessfulCrab.mkv)
> [191057.411281] BTRFS error (device dm-0): unable to fixup (regular) err=
or at
> logical 327469629440 on dev /dev/mapper/root physical 147760480256
> [191057.411285] BTRFS error (device dm-0): unable to fixup (regular) err=
or at
> logical 327469563904 on dev /dev/mapper/root physical 147760414720
> [191057.411458] BTRFS error (device dm-0): unable to fixup (regular) err=
or at
> logical 327469432832 on dev /dev/mapper/root physical 147760283648
> [191057.411461] BTRFS error (device dm-0): unable to fixup (regular) err=
or at
> logical 327469367296 on dev /dev/mapper/root physical 147760218112
> [191057.411907] BTRFS error (device dm-0): unable to fixup (regular) err=
or at
> logical 327469498368 on dev /dev/mapper/root physical 147760349184
> [191057.413012] BTRFS error (device dm-0): unable to fixup (regular) err=
or at
> logical 327469629440 on dev /dev/mapper/root physical 147760480256
> [191131.353819] BTRFS info (device dm-0): scrub: finished on devid 1 wit=
h
> status: 0
>=20
> # md5sum Foo.2024.S01E08.1080p.WEB.H264-SuccessfulCrab.mkv
> md5sum: Foo.2024.S01E08.1080p.WEB.H264-SuccessfulCrab.mkv: Input/output =
error
>=20
> The files in question had been subject to "cp -a --reflink=3Dauto", acro=
ss
> subvols.  When I deleted them from one subvol and deleted the snapshots =
of
> that subvol I ran another scrub and now I see the following:
>=20
> # /bin/btrfs scrub start -B /
> Starting scrub on devid 1
> scrub done for d90583c8-9284-48b4-9444-abd00924002a
> Scrub started:    Mon Jul  7 20:33:18 2025
> Status:           finished
> Duration:         0:03:01
> Total to scrub:   220.04GiB
> Rate:             1.21GiB/s
> Error summary:    csum=3D110693
>    Corrected:      0
>    Uncorrectable:  110693
>    Unverified:     0
> ERROR: there are 1 uncorrectable errors
> # btrfs dev sta /
> [/dev/mapper/root].write_io_errs    0
> [/dev/mapper/root].read_io_errs     0
> [/dev/mapper/root].flush_io_errs    0
> [/dev/mapper/root].corruption_errs  689
> [/dev/mapper/root].generation_errs  0
>=20
> So it looks like the failure to report error counts in btrfs dev sta may=
 be
> related to cp --reflink=3Dauto across subvols.  The csum=3D110693 doesn'=
t match to
> the "corruption_errs  689" but at least it's not 0.
>=20
> I removed another file that was listed as having uncorrectable errors an=
d now
> I get the following:
>=20
> # /bin/btrfs scrub start -B /
> Starting scrub on devid 1
> scrub done for d90583c8-9284-48b4-9444-abd00924002a
> Scrub started:    Mon Jul  7 20:46:05 2025
> Status:           finished
> Duration:         0:02:17
> Total to scrub:   173.88GiB
> Rate:             1.27GiB/s
> Error summary:    csum=3D7137
>    Corrected:      0
>    Uncorrectable:  7137
>    Unverified:     0
> ERROR: there are 1 uncorrectable errors
>=20
> Below are the kernel messages.  No mentions of files or directories so t=
he
> scrub doesn't seem to be doing it's job well here.  It should either fix
> things or tell me what rm command I can use to replace things that can't=
 be
> fixed!


 > Jul 07 20:47:20 dojacat kernel: scrub_stripe_report_errors: 7117=20
callbacks suppressed

Thus the output of file path may be rate limited.

And dmesg is not the best way to tell end users where the corruption is,=
=20
furthermore there are a lot of valid reasons that a path can not be=20
resolved (already orphan, belongs to a tree block etc).


Although I believe you're right that btrfs should have a reliable way to=
=20
indicate which files are affected, but we do not want to populate the=20
dmesg without any limit either.

In the future we may have a better solution, but for now the best=20
solution would be using the logical bytenr e.g. 327893450752, and pass=20
it into `btrfs ins logical-resolve` to do the path resolve.

Another solution is to enable CONFIG_BTRFS_DEBUG=3Dy, which disables the=
=20
rate limit, but I do not believe any distro would enable that for=20
regular kernels.

Thanks,
Qu

>=20
> Jul 07 20:47:20 dojacat kernel: scrub_stripe_report_errors: 7116 callbac=
ks
> suppressed
> Jul 07 20:47:20 dojacat kernel: BTRFS error (device dm-0): unable to fix=
up
> (regular) error at logical 327893450752 on dev /dev/mapper/root physical
> 148184301568
> Jul 07 20:47:20 dojacat kernel: scrub_stripe_report_errors: 7117 callbac=
ks
> suppressed
> Jul 07 20:47:20 dojacat kernel: BTRFS error (device dm-0): unable to fix=
up
> (regular) error at logical 327893450752 on dev /dev/mapper/root physical
> 148184301568
> Jul 07 20:47:20 dojacat kernel: BTRFS error (device dm-0): unable to fix=
up
> (regular) error at logical 327893450752 on dev /dev/mapper/root physical
> 148184301568
> Jul 07 20:47:20 dojacat kernel: BTRFS error (device dm-0): unable to fix=
up
> (regular) error at logical 327893450752 on dev /dev/mapper/root physical
> 148184301568
> Jul 07 20:47:20 dojacat kernel: BTRFS error (device dm-0): unable to fix=
up
> (regular) error at logical 327893450752 on dev /dev/mapper/root physical
> 148184301568
> Jul 07 20:47:20 dojacat kernel: BTRFS error (device dm-0): unable to fix=
up
> (regular) error at logical 327893450752 on dev /dev/mapper/root physical
> 148184301568
> Jul 07 20:47:20 dojacat kernel: BTRFS error (device dm-0): unable to fix=
up
> (regular) error at logical 327893450752 on dev /dev/mapper/root physical
> 148184301568
> Jul 07 20:47:20 dojacat kernel: BTRFS error (device dm-0): unable to fix=
up
> (regular) error at logical 327893450752 on dev /dev/mapper/root physical
> 148184301568
> Jul 07 20:47:20 dojacat kernel: BTRFS error (device dm-0): unable to fix=
up
> (regular) error at logical 327893450752 on dev /dev/mapper/root physical
> 148184301568
> Jul 07 20:47:20 dojacat kernel: BTRFS error (device dm-0): unable to fix=
up
> (regular) error at logical 327893450752 on dev /dev/mapper/root physical
> 148184301568
>=20
> I don't think that BTRFS is responsible for the data loss here, I think =
that
> is entirely due to the system crashing.  But BTRFS really isn't handling=
 the
> recovery as well as I think it should and could.
>=20


