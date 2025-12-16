Return-Path: <linux-btrfs+bounces-19806-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 680F8CC5572
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 23:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CF1E3016CEB
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 22:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463B233F36D;
	Tue, 16 Dec 2025 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="VJ504DIl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB9E32C337
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765923841; cv=none; b=iDM2U+udiQio+obrJLZUuTigIMDfhw0J8tJZ0w/EloiTomg/vLAhtGSEYC27ENLD6WgTUxckitk+AVtXq58TzGPHPVge1bwnNCQAfjso+SyYIYwqU19ovExzGPqoG4uNivvrr5OAyk4qEUp5JqXsIAI0+mUF0Bx6Y/Po9CcJadw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765923841; c=relaxed/simple;
	bh=HXP68mP7cLTr8owzyNGOTMteCE6ke2HI/GKon1jN5Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BjdvCJgjsGPWGcRWMp42VEiJo+wA2t+mGI6kqHnVJoisR0L0PPftBjNZqlzL2gDtBH+O+2Tf9Jm5nRgVvslHZ0oxJAlv9KMqNO/RqSpNohQEvG34Vw5bxEiOZ/wNvhyDtM/BuRByJM47KGmfCW89XqMAYtxqcscTX8EWo8KWmao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=VJ504DIl; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1765923837; x=1766528637; i=quwenruo.btrfs@gmx.com;
	bh=bjFJ+3w+xfOukJkV8Xgjy5+f8v3p+2SvZgwRJNdmgmg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VJ504DIlvuCj3xON8ux9hyfl29fb/qtUCWpflakaN39fRAB0hDK9nOOD2dCWOmSu
	 VblDJcMJ0oWKX9N66+iys6IqC62CztIziZ3iT0TFD2k+W4XqT1IJi7Nr7gaOOcKaZ
	 qUTLyu9PXBrgPwSm37DWGwtvT5qNubc9Avh9xmyi7oWCBYllBUDI/r6FTNdqlG38z
	 d2DF15Z1uuuEoy2hb3dGdTqjP48CRzY0STaSACTR+x3uVb+peB+ozsZWc37wt10jf
	 juZHgdwa8YA8KNB4hwFOW9C9YnFIGzTX63+IhgoPpjcwEqyDNw16f+J+Y7FWFVYT4
	 MsjtRs3JO91BzC9HQw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N63RQ-1w2R0e1ORM-015pwB; Tue, 16
 Dec 2025 23:23:57 +0100
Message-ID: <5ff7277e-91e9-435f-8a30-a41e0037a56b@gmx.com>
Date: Wed, 17 Dec 2025 08:53:53 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] btrfs: some cleanups in btrfs_find_orphan_roots()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1765899509.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1765899509.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lUFyGz3v3TYDj8QDPnW2c3k7/LJ4hoDDTAiP0IIhxGbNzyY5J3V
 ym413lg+VCa3t3m7UidF5Uchjh4uSu72jSjMCcNPzF3dvgPm8VD8DQdFjqGoCIDPinFrxMk
 N/1aBu79V3bk40KTGfqFytDMMtXKSY3tvR9w5vnHVMwkhvN7JaAUaui/JADsf9SkfH1f9Cg
 OZP+5gh62P/GGnAhyeCTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VC2yO4FkQLc=;NVQ2nkToLHFc7cc+9VGMId/FmYD
 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



=E5=9C=A8 2025/12/17 03:03, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Some cleanups in btrfs_find_orphan_roots(). Details in the changelogs.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Except the tailing "\n" is unnecessary in the 3rd patch.

Thanks,
Qu

>=20
> Filipe Manana (4):
>    btrfs: use single return variable in btrfs_find_orphan_roots()
>    btrfs: remove redundant path release in btrfs_find_orphan_roots()
>    btrfs: don't call btrfs_handle_fs_error() after failure to join trans=
action
>    btrfs: don't call btrfs_handle_fs_error() after failure to delete orp=
han item
>=20
>   fs/btrfs/root-tree.c | 47 ++++++++++++++++++++------------------------
>   1 file changed, 21 insertions(+), 26 deletions(-)
>=20


