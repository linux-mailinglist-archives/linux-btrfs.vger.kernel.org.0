Return-Path: <linux-btrfs+bounces-19958-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12424CD704F
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Dec 2025 20:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 880D2301470B
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Dec 2025 19:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80DC33BBD6;
	Mon, 22 Dec 2025 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="CLrrx64W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972241FE45D
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Dec 2025 19:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766433447; cv=none; b=qoJ/8Y/X4BY0CHVdb+dUZhFGwVWCn2QUmveM+xfqSm7x8pystChtL6cCwr8tP+L2WUrFnr3tOTHtVzbTZrOmWXR9ZY8pfhkZW8Yx60Fdc206ptFPI/iffEW8MVL2t+N/qL/dqs5PBVNdvsGveDjMZv3wRHK/gX5xwXnU/kVo1Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766433447; c=relaxed/simple;
	bh=ByfwnKH8AHCTlILdGzFxSLY2HXIomIgeJdDVGqmP7Gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T/uSRaz77IsVZDogB+zwj7b+lGrD1ypBqH1nM6c+NiOVft9nCCVTW7jioliin82wREJqT5DxLlKxADi9DnG42Vhp7v5pqAI/QPpay5NKlt2wtp/qpCw+EXqnTVN7bDSGJ9cJOSsg7Bb2kLlYt7SjR/Ew8d2Y5mxVm9+RD7WoFmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=CLrrx64W; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1766433439; x=1767038239; i=quwenruo.btrfs@gmx.com;
	bh=UyYvzWxJ0HNfqRMIhSH9JCx0GRjuhwQC+yHMW+ZZJBQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CLrrx64W95lM+NGOwUk6U1X7ZcsxQ+ji+4wdNRzzFT9r0V70uN9vbmbARY5t/AtW
	 1dKBKjm+uYH0JVmyHt95laPcIgkkVzB9Mw6kU8ulBveWUfbAN0y0qwVAx2SeLZPcH
	 CWhHUAfEBhnpWWTiLkYA6MrCGPeb34hEOIkCCEnxO4rL5CtDu+L/P/OuaR8n5FgCd
	 YohcbEYTiHDwLcni4LXGXIjvIvOro4ab1Y4pBEQskS+zYGz+cCzLK92TXCZlnSxW7
	 dgB3nIuJVcJCfGCC2yNggenGZMYTf9O5uMbKQeghaaq7jTLAbn93DIq5R0JIaFnDh
	 zj9ZirU1t2zKr+2UGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N79u8-1w1Olf0uTM-014jn9; Mon, 22
 Dec 2025 20:57:19 +0100
Message-ID: <51c72eeb-cd33-423e-8e75-7f79034b9596@gmx.com>
Date: Tue, 23 Dec 2025 06:27:16 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs ASSERT() error when make C=1, but OK when make C=0
To: Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <20251222223701.F4A2.409509F4@e16-tech.com>
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
In-Reply-To: <20251222223701.F4A2.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dL62ZAd7tBVYZifaHMvi4DTebfHwRPyh5wKFEDKfJWu11JoaYZH
 KNWcvSgkVjcG37swMhVAlQz+5RN0BiCsdcI4JA4uskzJmu4xiYp95oooL/W1N9ZW0cR25Ta
 yjPPFlbsLhxDvFUflp1LzBd5UrfxcJVhzQ173+cZKfNZvg9jqo9PvxhOSq6cLuz4tKey4b1
 xNz/rVeTTWWFdjC8JLT9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tWvNJmPITMI=;nHiI+ovQi0zsKXTmG5LIHrxqm0K
 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
 eg/5tKFvrF9gUr+R+ch2WgAsZFDl+gDn9stRHG



=E5=9C=A8 2025/12/23 01:07, Wang Yugui =E5=86=99=E9=81=93:
> Hi,
>=20
> I noticed a lot of make C=3D1 error of btrfs ASSERT(),
> but make C=3D0 is OK.
>=20
> block-group.c: note: in included file:
> zoned.h:417:9: error: Expected ) in function call
> zoned.h:417:9: error: got __VA_OPT__

You know this is from sparse right?

And sparse is known to cause false positive.

>=20
> static inline bool btrfs_zoned_bg_is_full(const struct btrfs_block_group=
 *bg)
> {
> L417:    ASSERT(btrfs_is_zoned(bg->fs_info));
>      return (bg->alloc_offset =3D=3D bg->zone_capacity);
> }
>=20
> Any help to fix it?

Then why don't you dig it deeper?
You are an employed developer, not some newbie.

Do your work, not off load it to others.

>=20
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2025/12/22
>=20
>=20
>=20


