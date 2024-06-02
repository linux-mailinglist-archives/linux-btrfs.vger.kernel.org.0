Return-Path: <linux-btrfs+bounces-5387-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D36638D733D
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jun 2024 05:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28A45B21299
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jun 2024 03:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF1E9445;
	Sun,  2 Jun 2024 03:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="WAkiqEyV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB0B79C2
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Jun 2024 03:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717298962; cv=none; b=PzCbHY7rgdg6+UBPZnyjKd75OKooLJYB99yEqogKobZYVT5v4EbCsktWHLN633gY+Ts2BYwzEoDHeY65jMV11ZBKJYGOfOlXOKT8e7jOt9/ydG2HkRTzRps+zO+bPQLDW8I4N0rAtV9wHz982hKz2iEuwTEhSNPvbjQbO7iBYq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717298962; c=relaxed/simple;
	bh=TlocIURQB+TlT5IFC+gyT6z7qW6fJCvXLI1sIIfkCQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GddMXOXL7xitSvXm6s2DQQPmPcE7CdErRNe26k4Mqx2GVATk6eoo4S4qs2aSux4fx51pR4mtSSIuy1N6KYh2SJpQvHs9U7mQSVswSSQE+6zqdVy5FNMJpzJg+h6w1VmyYLhs7+vVDbq0uKmO4JppE/SMWfGOKqcjLZFVWxO6cVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=WAkiqEyV; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717298957; x=1717903757; i=quwenruo.btrfs@gmx.com;
	bh=vQnInT/hGXmIryNswOTCjsufbEybBpJTQhFOokoDi9E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WAkiqEyVGlm4deRdqIlFfk0pdJAGMb3JJgQazR5KV/YsjV3wIeTy/YhWa2aaDfdh
	 44aB+Cep9oAPFPWvYoa1gctOtBmqyt1ZybGg5jpoKTa9e6HhpZ0puRUcKPO0y/IIf
	 +mtPstkOSU3EtfE3HK+VDmUgU+WurIaTYwgld3UDdN9vvKEOS6AW8UJsJQsw7msAE
	 7g1pu2i/aMfoArAHGSnOksXmLXO0WgKlKmEzbW8XcQVfpUobjKKMdcE2WY8a83UNL
	 /wMcNoAZULZW/xgXozO73i+M60MXB9YkQWacFX7cIScQCYwZPl7ui10r8qATNe1Lz
	 3u1Q/9z2TeCuaCSvFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mwwdf-1sNbNf0aHj-00x5XF; Sun, 02
 Jun 2024 05:29:16 +0200
Message-ID: <66fafc1b-3339-4336-a715-eb744d93155c@gmx.com>
Date: Sun, 2 Jun 2024 12:59:12 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: file system failure after hard reboot support request
To: William Rotach <wrotach1@binghamton.edu>, linux-btrfs@vger.kernel.org
References: <51b057bf-ce55-4649-a70d-a7b4c7b8981d@binghamton.edu>
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
In-Reply-To: <51b057bf-ce55-4649-a70d-a7b4c7b8981d@binghamton.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nVsHjGWbHAbu6wmv9bqkOvpiFzYgWjt0hCUZ504F+vuebnV3c7e
 FQphqBmxYBvNB8dZFPtKlfQ0mfiFiXjzPdD8YHJIH+xi+Bk2p1IHJVjpNRrMY+PsbHxnf+j
 rkvzYhIXE+eqzrn3evL2ZymMNvGSWH55yWcIKpw/pHWKxBQmTr3Cfh9HT/MAUNt/qvs5FkY
 7fUVeRbLT5zkR8l+eToww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6F+0O10okt0=;ZnsvVbmMDInkRoWkAIr/2YAvSNc
 BwHpGUPD6TRRoeajgHQw12s17JV9Huz/tk200jw0Vo2oyT0jwJCubxRMZtw6lsowXkKqgTHuz
 rhOln1qyYsywxCzaHO2+31PPa/oTU3jmt4wFvS6HG6Iv1ceHcx6OiXBNKWFdjTau2EeEByEkO
 P9YzWI+w2qJxLb1ZqK+bP1F8OSMlwy5k0iyHNyO1m3uQY0qC7TosSqsNOaeJbF+7TcikW/U0x
 h+vohFzw6WSEPiDhR4VaZDT6AtiZXUZPS5EN3wJWf3/9J4LIOkLDEz/ZTHmdCHaU5dWFKbOkX
 0aVhOYvj7vlGdsW3MGud6pxkvpK1nfbtpMyMpkUHcaXUjNNYSheJGQ2CxqtPTltGIEFO/jKlF
 684Twh6QLQPPCi0uUAGsbAl3i8lVAe1eB8KX8Cq8UvpynQnAPHkFKKunNfjewdkEduPk0GaFg
 HY2nrnr09YNqstakC1bmAPSoySRq7MiS6jLAsEhFwdteVMl6MxmIGKb6+lAvug5FqQJXu4uMK
 acCnO4NaRQTGlkDPTzc7Dh9IDAgyxp/eJZSJYBLlU/ALKzGKVJ5miI95AdCRdO9zoLGLKMp8J
 F9jn28sIE00QLRZr56+mYGQIyUsHjsBoWH9/xgk3CiPQvJY3yEjpVSX95Y0R6oE/pwHheJX9T
 nSd/KnxL9hcuLmw0aVmM7nCVXjL2MJe7CVUiz5w70vwXArBo52uFyjSqAJlchbg3zOMbz9z9N
 gxitYpU1OQQk+vLINxyjSNVDSesfgrSx842pBWeGJWdEONaVT8wiz+W9zfKtWt1o/UHxmbpTJ
 2DWerOgia5hPGr3Q3E4C5PIantwKnLgYuiEFMe+T1xyz0=



=E5=9C=A8 2024/6/2 11:30, William Rotach =E5=86=99=E9=81=93:
>
>  =C2=A0 I have reached out to a couple different locations for help with
> BTRFS, and I have reached a dead end at my google-foo, and my
> distributions discussion boards.=C2=A0 If there is a better place to ask=
 for
> help with respect to a hard file system crash, please let me know.
>  =C2=A0 I have a corrupted BTRFS file system, with a quick summary in bu=
llet
> points:
> -=C2=A0=C2=A0=C2=A0 single new NVME, 6 months old, 2Tb size, 1Tb used, 2=
00Mb of really
> needed stuff
> -=C2=A0=C2=A0=C2=A0 one backup exists, 6 months old, still need the new =
copies of above
> needed files
> -=C2=A0=C2=A0=C2=A0 Fedora 39
> -=C2=A0=C2=A0=C2=A0 chromium, high tab count, apparent culprit
> -=C2=A0=C2=A0=C2=A0 hard system lock (no ssh response, no console switch=
ing)
> -=C2=A0=C2=A0=C2=A0 repeated hard system restarts, last one crashed btrf=
s file system
> -=C2=A0=C2=A0=C2=A0 btrfs hard failures:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parent transid;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checksum;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bytenr;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 search for next directory;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 can't read tree root;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bad tree block start;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 212 found roots, none seem t=
o have a "good match", as noted above

Full "btrfs check --readonly" output please, not some truncated output.

Meanwhile you can try "-o rescue=3Dall,ro mount" option to see if it can
mount, and the dmesg for such attempt.

But according to the "can't read tree root" line, rescue mount may not hel=
p.

Thanks,
Qu
>
>  =C2=A0 I started looking into the kernel driver source code to help my
> understanding of the physical layout, and may build a more forensic
> method of retrieving the binary/text data that I need.=C2=A0 I hope ther=
e is
> something that is already included in the btrfs-progs packaging,
> available through the source code, or by the developer team itself.
>

