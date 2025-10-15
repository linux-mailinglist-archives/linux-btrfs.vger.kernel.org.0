Return-Path: <linux-btrfs+bounces-17854-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE16BE0C2A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 23:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1536B4EBCB4
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 21:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739CE2D542A;
	Wed, 15 Oct 2025 21:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="IDrDccKs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11352D320B
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 21:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760562658; cv=none; b=Eet1X2KXLp3K3CcBMJX36ko/l53mzvIQWvCMOGFfXAyaP904dR5gUXCbOfulgfNXLOrQ51gNhDGMPqnpZ7UZqWJNYgaz+PxHGXKt1nedT8Cd4txaXyRa8r7T2OuoQIouwf56moiIPQvgxQmkD1d3xgGq6WuQO9VCHiV4aN3/HIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760562658; c=relaxed/simple;
	bh=fHj1cn5tXoKQGmwP2zb5WfNgZUpnmRsT0R3FQLt1Jwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=meSWaJU14hTqITH1wTWnSOly+zsNZc3Gq3RaYZQCud4dkTCx7f4fmPQQJYIIIkQOc2A3CpPSd4ns/MydYF546qfjk92yMuCegiBesGNcBtQmd54gsu/6+NdyTIxb2RMl/l5W4VqzOLoVVjR3lw/i9COG8rS568HbRzbp83N/7mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=IDrDccKs; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760562649; x=1761167449; i=quwenruo.btrfs@gmx.com;
	bh=65uvY1XvWgITBrkN2VSK+L5u3JcQHXwG4GmUnjAFptM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IDrDccKsIcxOizB4/4tmybK7XQJxlJLexAeJO60llqix0rsKyPFnPklQA9AX9xiy
	 wtkM2ye+/bI4Mu4FI4EucsPw+PYrVctmp94x3yrJdn1J0arfxjJKmy2lyzhCVy3oz
	 iPVkD4Tg54AbilJgxroqcUdDdcG5opZKRLWnFYvbVk5x3xcIwkOIunN19Y3O+vT0A
	 3vE/peu//xeq8LPjSlGi2O2ZR8AuzHcjH0Q4oR7hzPteHKQzIfDgdT1vuqV7/42AT
	 Ig2sYHJ4PZAVYEa0mqVsR3z1yyNi0osHQTQLhJi289Dwice6MNZdCI2lEqmQ9JDsD
	 5tMVYcKHqpQDjW4tOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxUrx-1uGdEW0Mxt-011JdC; Wed, 15
 Oct 2025 23:10:49 +0200
Message-ID: <84dabbbd-1b7b-4d51-b585-d3dcad3fd88f@gmx.com>
Date: Thu, 16 Oct 2025 07:40:45 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] btrfs-progs: fscrypt updates
To: Daniel Vacek <neelx@suse.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
References: <20251015121157.1348124-1-neelx@suse.com>
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
In-Reply-To: <20251015121157.1348124-1-neelx@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sLati+cTtnjLuNG2A6jezSFaes9R9YuDfxmCSEjg1e+VyJ8nyrE
 Kxy4H76uLE7RFrUP3nRGMZ0LYalFRQpWydVAF3oCDtT03jJ7CyKaRjwwNt/3d89cPAFJRWv
 xVNCzXfK3kZVhRdpad/YPHRxukL/iLTxqd+chwyFp/DV/IMNXcN4LE/mUa8grQ/Mn8IjJvw
 TjXxyniIviLUqKQwqZ06w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wDsZouov5CI=;U08jLYbmGvMnshHiV+1EUlw8Xsq
 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
 fG+uuR36NrBrlA==



=E5=9C=A8 2025/10/15 22:41, Daniel Vacek =E5=86=99=E9=81=93:
> This series is a rebase of an older set of fscrypt related changes from
> Sweet Tea Dorminy and Josef Bacik found here:
> https://github.com/josefbacik/btrfs-progs/tree/fscrypt

I'm wondering if encryption (fscrypt) for btrfs is still being pushed.
IIRC meta has given up the effort to push for this feature.

Thanks,
Qu

>=20
> The only difference is dropping of commit 56b7131 ("btrfs-progs: escape
> unprintable characters in names") and a bit of code style changes.
>=20
> The mentioned commit is no longer needed as a similar change was already
> merged with commit ef7319362 ("btrfs-progs: dump-tree: escape special
> characters in paths or xattrs").
>=20
> I just had to add one trivial fixup so that the fstests could parse the
> output correctly.
>=20
> Daniel Vacek (1):
>    btrfs-progs: string-utils: do not escape space while printing
>=20
> Josef Bacik (1):
>    btrfs-progs: check: fix max inline extent size
>=20
> Sweet Tea Dorminy (6):
>    btrfs-progs: add new FEATURE_INCOMPAT_ENCRYPT flag
>    btrfs-progs: start tracking extent encryption context info
>    btrfs-progs: add inode encryption contexts
>    btrfs-progs: interpret encrypted file extents.
>    btrfs-progs: handle fscrypt context items
>    btrfs-progs: check: update inline extent length checking
>=20
>   check/main.c                    | 36 ++++++++++--------
>   common/string-utils.c           |  1 -
>   kernel-shared/accessors.h       | 43 ++++++++++++++++++++++
>   kernel-shared/ctree.h           |  3 +-
>   kernel-shared/print-tree.c      | 41 +++++++++++++++++++++
>   kernel-shared/tree-checker.c    | 65 +++++++++++++++++++++++++++------
>   kernel-shared/uapi/btrfs.h      |  1 +
>   kernel-shared/uapi/btrfs_tree.h | 27 +++++++++++++-
>   8 files changed, 186 insertions(+), 31 deletions(-)
>=20


