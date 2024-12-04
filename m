Return-Path: <linux-btrfs+bounces-10047-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D3B9E319A
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 03:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886572869F7
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 02:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E45644C94;
	Wed,  4 Dec 2024 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="VKt/XJaC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D3F4A1A
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Dec 2024 02:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733280626; cv=none; b=uZxwFNNu2y4qau56LZfr+3X8+SnPw6tOomgpBPDdC5X+wniq55Cc8WV57MTJxWP1g1D1PFPEG4ZCzL1s0dhMqjDaYlp8vMqzYwGUWg7KOKVS63Bi/4oKGSN5lxK/qPppo53pFoZ2UdIa8gA4Z0Hi1iQeKxjrsaoR8VH0pNRNVtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733280626; c=relaxed/simple;
	bh=csrrY3fdlnWx8yjBhKeUA5myuILws1emBlk0MfhSKEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Bw53QRiWYqW7vkXr+fw9+2UxcwJK1RLHjyDr6vqI8vpTfI47CyFSADoc8V73tecP8rU+PDo0wjuQiGDlin3X6SLEDLdlc9UZfacYtTTPRx3vwhC59t8rRJSLANNW0HOBDXEEM47jZcTwiUfa4/ad+PM1RNvFqqqnNmvaKz13Kek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=VKt/XJaC; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1733280621; x=1733885421; i=quwenruo.btrfs@gmx.com;
	bh=bEsnrC5O6rtamLDQyiY5nomfArSk7V/AgeAu/DamCko=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VKt/XJaCMbq4f8aoOTRSZHDfeldo2gDydaNVv8uIP/gj93A54q/kGrRAxaj/RJyh
	 Eou02OZByTDVz/rcXJb2J2/VHuyjEan50nYkZvnSPFxqfJsLGOIrqVr96YdNhQfz4
	 I+RhpYKTHfvTy6FfDy8XygPC4z8Q55oEC2rbQ3eKQcLEfr18k/RFiTKMjKy2ZXuI9
	 qzDElJesfgBIzBRZkq++MBd9zCBq7Oo3+1nF31EIhK/Ps9lhDZ5nexVJPddxE6EnF
	 ODvbyKiUi/LiBPidb48m8IBCMOq4YPHJTpNMIi1i4iUNENHKau8cgzKyTGq/h+E5G
	 a4L+l00b3yCH6nCPDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUXpK-1t9pkK3K8u-00Iotp; Wed, 04
 Dec 2024 03:50:21 +0100
Message-ID: <f404a687-cd6b-4014-b2fc-0f070f551820@gmx.com>
Date: Wed, 4 Dec 2024 13:20:18 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Errors found in extent allocation tree or chunk allocation
To: Nicolas Gnyra <nicolas.gnyra@gmail.com>, linux-btrfs@vger.kernel.org
References: <207033eb-6e59-45f1-9ec5-09e63eaa4c70@gmail.com>
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
In-Reply-To: <207033eb-6e59-45f1-9ec5-09e63eaa4c70@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EoME+SZmpSgudC7O2SCWa0VXT2d7/3Gf67wIN9a3rQfU19ppxNn
 wtITvUei/wqY4jHWPHm1A3XufozNWM3D2NkhwJahezS2kf86r1+YQF4mUuKk8zRf5AHlC1T
 YloP7UtKHHSqXUCZi70Y0rfKcs1tdAdtgKkns3LArOj4lxkjcZxK5B7jOxKU/ri3/L0DPzq
 XHYZ2M56eC+cTJZoITi1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mvQe/DfWwKg=;TmHkKWgIklUoqAg+5NY8btQwp5e
 zqKLg0f7aNjHHUc1Q1sRZyddEFn1py1fhj+z/MotU5OX7uRPRzDvgk4F3/583Jxnw0Qma8Xrs
 U7JtKeUgCThgD1XCGDeVSL/AqTak+CUETznB5zE46ugdEqW15veDplGvn9/NGZX6GbFdcs7bO
 fWFjAaIG8rPd387+s8J0fAkjiii7Q5NOk78evr1scLlkjbbLpCZdxf/FVXPvEeZ17htrpxuK+
 oVco5/hAsJdpZFoJX6F2VSPxOXOP+qX4hTti5x83Ll3IeVEfeccxTFV15yeH06pM3W7V4USup
 YpR4LCHlBfqKNgLkIJRQBYRAO8kHsxkfkRULA3lTcAFq/nTojKtedUIVyfWafTo6ScpVGBxrF
 rY0/pldTXS0eZbT0qzQ093K9ivUqJ22MCKY2n5oZCj5TEMFZXUB6vv/TzIvrbLiYB0A9Ef3YK
 QqYRTLuTVLXE+SczOoeJPtZw9/skrcBm1omycAxg26F66+fBw1JjWIjRMGUWJu0CVh9oENFAn
 VV++U1KuJNTwsqg4ufdVDZmVkb1sfWkLFoVNWJ0u/NqBZU5DhN4Zi54OxFf3ts020PWahFstw
 fDcZ0KEGMJl6qZ0gv+7XirIysNnAf9oPJZSA1idFmacSzjmKu2CQUjNIXQMV89ihMKA7OShuO
 wOFzhjrYKZhkQnDvYPmJwzGcASFktv8KB29FWW58YSshWFhKbeY7ll6BbsNCHJa8bw+kPYj0X
 uPvgDijCI45xxmUA1ZmYj2he41QQtjdLpW3PdZRFtSS5KYRBIIyVVrnHmqQYXOu54LM1hLT0R
 i8S9yzfguBO6DoesKVK0j02Y84JujPuktUuUohR/vGtK+7Y5HdnZo9YqccRhO158p3jjp5Jh6
 +t/KE91ON5EvfhJWk82kssE4oJ7TZtzJz86sTVxao2RlkhK6LkauOGl+4wX7gVveNDbe8V7pB
 2kafJ/of4s/gC8jNA7zptN30QzfusOiEvVBiIJKGqL5sSrx2uVEfOoM3pbziFQBRByCeYSl7h
 hZQIvIguMYde71tFrEKM33DbCmquZxFExknw5nABX+3lJf90XbWQ0M4WKW/1oLGK4D+7wt3BB
 HGlE3rcgIMd+VyDXdIV9BuKG9gOC6D



=E5=9C=A8 2024/12/4 10:32, Nicolas Gnyra =E5=86=99=E9=81=93:
> Hi all,
>
> I seem to have messed up my btrfs filesystem after adding a new (3rd)
> drive and running `btrfs balance start -dconvert=3Draid5 -
> mconvert=3Draid1c3 /path/to/mount`. It ran for a while and I thought it
> had finished successfully but after a reboot it's stuck mounting as
> read-only. I seemingly am able to mount it as read/write if I add `-o
> skip_balance` but if I try to write to it, it locks up again. I managed
> to run a scrub in this state but it found no errors.
>
> Kernel logs: https://pastebin.com/Cs06sNnr (drives sdb, sdc, and sdd,
> UUID dfa2779b-b7d1-4658-89f7-dabe494e67c8)

The dmesg shows the problem very straightforward:

   item 166 key (25870311358464 168 2113536) itemoff 10091 itemsize 50
     extent refs 1 gen 84178 flags 1
     ref#0: shared data backref parent 32399126528000 count 0 <<<
     ref#1: shared data backref parent 31808973717504 count 1

Notice the count number, it should never be 0, as if one ref goes zero
it should be removed from the extent item.

I believe the correct value should just be 1, and 0 -> 1 is also
possibly an indicator of hardware runtime bitflip.

This is a new corner case we have never seen, thus I'll send a new patch
to handle such case in tree-checker.

> `btrfs check`: https://pastebin.com/7SJZS3Yv
> `btrfs check --repair` (ran after a discussion in Libera Chat, failed):
> https://pastebin.com/BGLSx6GM

In theory, btrfs should be able to repair this particular error,
but the error message seems to indicate ENOSPC, meaning there is not
enough space for metadata at least.

>
> I'm currently running btrfs-progs v6.12 but the balance was originally
> run on v5.10.1. Is there any way to recover from this or should I just
> nuke the filesystem and restart from scratch? There's nothing super
> important on there, it's just going to be annoying to restore from a
> backup, and I thought it'd be interesting to try to figure out what
> happened here.

Recommended to run a full memtest before doing anything, just to verify
if it's really a hardware bitflip.

Thanks,
Qu

>
> Thanks!
>


