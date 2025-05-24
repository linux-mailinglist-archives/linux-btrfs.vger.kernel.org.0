Return-Path: <linux-btrfs+bounces-14215-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6961AAC2D99
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 07:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 455BF7A839D
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 05:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B09C1C32FF;
	Sat, 24 May 2025 05:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="EmwRwFUZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA471805B;
	Sat, 24 May 2025 05:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748065489; cv=none; b=fTVhLMzKnEQjzDjgu49mbFIzEjr/wlsptmYEI2MloIDys7D81fhbDSv0iM2TN63PwlqUj2WtvTdD8Wylm7Gr5/3IRcS0pMkLsxVvw362wqhLpmTgitP5YvUusnfeNP5mp2DDX0Bab11E/4/1FCTcBj1QorpBTnz2kQGXNdUBJxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748065489; c=relaxed/simple;
	bh=oU+90bn7LFXXwsBz85evZjTx/VJQ0PT32Ng4VSqXjN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gb5oblQvJfLVe8AnnsK8W6JIvZ/PvRGL1ldiKEVlY3TmM9gsrWcCMTwVCuQKrTj2+thrhy9EeWWKwAOqCYz7I1ehuhV99slSR9lM/Fb7u7cKBby06VQweaFvfhKVeuK14t6sITdeKep7TCNmB1vj3fYBKki+XCyMuRYDT3IOpPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=EmwRwFUZ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1748065481; x=1748670281; i=quwenruo.btrfs@gmx.com;
	bh=TVLqvSjd2voqDt8rzwAOnCDQxxKtO1Li/ZFharYjY0E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EmwRwFUZLqLOowo1M734IZrfE+QN4EyRSZUHME3xqcK9ZyJP4I3uNROOjP5wL42n
	 gg7+JRSJ9xswl8v+yXhm98t/RDQ4A6DBS08aofXdvl5izmvOJ/RJihHFh6GKM7TwM
	 cvrcquc9VDBgKHjWU7IOXrmdxad+O0uXQP4FTO2Pqp+RGK6GQlNCYXWUVvMDVB9wA
	 PeX/izTTRor+TwLnL17JA9cTHjmUvSJmkhyN5o4sAWFM1ZvZchYnt9hcXgeGqQ6me
	 qw0PuhqZQpOTmlaOPPmWEJGrRMqnVIEPKYF8oGiiY3B6qn/Gsm/cXw1n+EUby1WzB
	 a1oIedpH40aLPAl+Kw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.228] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTiPv-1uUTum0Tzp-00SIsD; Sat, 24
 May 2025 07:44:41 +0200
Message-ID: <26d4ea00-3ea0-469d-b6e1-a58f717f4013@gmx.com>
Date: Sat, 24 May 2025 15:14:37 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next staged-20250523
To: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
References: <20250524040850.832087-1-anand.jain@oracle.com>
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
In-Reply-To: <20250524040850.832087-1-anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1oecLDo4NCKzFiA3GQ7cyIH23tDtIDZERGqJ4tPhxO4MIvH6ggE
 pZntlIPrUeAIHZfNIpJm0Oq8uEZN96rx1xyOM18wPiomWDZvBcHMlXVveheK8UV+UyDgirY
 Ap3NtGI3/HhGbvt3Ned0DbylDMgd0R8IhNW54pSN2RRcu3A+QfF8t/QivynA5KDsV6+RplR
 iE40Yswuvl17Er9rgcwtg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cZ19ariftPg=;VXDMkP7TmVZfsc/zZWqTCdqk+BL
 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



=E5=9C=A8 2025/5/24 13:38, Anand Jain =E5=86=99=E9=81=93:
> Zorro,
>=20
> Please pull this branch containing fixes for btrfs testcases.
>=20
> Thank you.
>=20
> The following changes since commit e161fc34861a36838d03b6aad5e5b178f2a4e=
8e1:
>=20
>    f2fs/012: test red heart lookup (2025-05-11 22:30:30 +0800)
>=20
> are available in the Git repository at:
>=20
>    https://github.com/asj/fstests.git staged-20250523
>=20
> for you to fetch changes up to c4781d69797ce032e4c3e11c285732dc11a519e3:
>=20
>    fstests: btrfs/020: use device pool to avoid busy TEST_DEV (2025-05-1=
4 09:49:15 +0800)
>=20
> ----------------------------------------------------------------
> Johannes Thumshirn (1):
>        fstests: btrfs: add git commit ID to btrfs/335
>=20
> Qu Wenruo (2):
>        fstests: btrfs/220: do not use nologreplay when possible
>        fstests: btrfs/020: use device pool to avoid busy TEST_DEV

There is another patch that got reviewed but not yet included, and it's=20
again related to nologreplay (this time it's norecvoery):

https://lore.kernel.org/linux-btrfs/20250519052839.148623-1-wqu@suse.com/

Thanks,
Qu>
>   tests/btrfs/020     | 49 +++++++++++++++++----------------------------=
=2D---
>   tests/btrfs/020.out |  2 +-
>   tests/btrfs/220     |  7 ++-----
>   tests/btrfs/335     |  4 ++--
>   4 files changed, 22 insertions(+), 40 deletions(-)
>=20


