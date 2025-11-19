Return-Path: <linux-btrfs+bounces-19162-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0B7C71236
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 22:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3CE94E13BC
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 21:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C3A2FB624;
	Wed, 19 Nov 2025 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HLF+YdME"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5F92F617B
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763587306; cv=none; b=X9NpCG7PDZRUni6SQWW1eqCaGIp0BGtpjIUIxoV176wdhNFdp2W2Qq7bjdH48RwHX8qeEs3YXnKqvakgocJRwsJsXOkgUKXo4vo9K9xfRh+gdoHEjzRIf4OHQoID3QUHIdc6WaOGinJdDppqC0b7vsLD5xERlSTYoA8C55bGZ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763587306; c=relaxed/simple;
	bh=kjXk50tDOdg3T3z0h2Get3NDWvpGj0oyRziS9gly6hE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p+1eWdwKqZ9G1b20n32Zls1DMZkZd+f/nRsZ0lvSPo6Hfjx79SjQShSiaxuDBMHgpsLYvu8Gy3F7vFkodODieypzbsyHR3sCl6hviTmndYV7pFUk/Z7n0kHTK5JvRikHLNKgjm3GGU+RTIlieCD9HpYLqZQFSyZsT95WgIx9ewA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=HLF+YdME; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763587302; x=1764192102; i=quwenruo.btrfs@gmx.com;
	bh=/9vJ/Fe5vZ0lhTikI0ECBPieTjpL11CMqqI6Ur0LJbE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HLF+YdMEELNG5/F7KO5uZEywXm55y+EKovImn3HHIlSvlmidE3H35kC0DWBxSyqC
	 bkttoiF9E5NFw4+Z0RAq62wp+XEJjymXazAzriwQlgtf8F57uU9qL15riO+rJFYIa
	 WEq/7lgpF/SS1NG9AyI7tBPY6fnhZrQwz70YiIRd4HZGDx9R92TWVWO6BU4xhSazJ
	 KGShcNgkUnsEPAWKbIz2L9u73C6ZBgfCrjU6ETCBB/d7ILL/TqmAJvwSYLjdZ7avX
	 0Yud067NbFT+F7JkzvyoDWN4l/Zeg18OgzWqXB6Tjy8l/aYinJ3iKU61LX69qC/Sz
	 cwwW4lvYPH8ExoOfbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQ5rU-1vZ59R3EoK-00Ob0b; Wed, 19
 Nov 2025 22:21:42 +0100
Message-ID: <63886e59-ebaa-41c9-a8a3-070afd455a8f@gmx.com>
Date: Thu, 20 Nov 2025 07:51:39 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: cleanups for a couple log tree functions
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1763557872.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1763557872.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T/29Wdg1m5Kfqi2X0+FaMpCTZpq4lelHLOhHkGm2bCFylkYxjci
 oCIpntoPErltW/JEi6eu8tnxXHC293w17S9cjnFkcyVu7WmZlff09/OHrNKDZ1GrCUU2ACf
 TCN8TUDZ7strKhy+aOVGyyV8D3449O/3RV5A5kChA++Fsv+6gThwpuothPMRAWJa1LKW7P8
 RsrdRIDQEOBqN79S7mvAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GkRaFRBOdpw=;158Fm4BRc8MBIQs62wPZkuk1lYg
 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
 rmeBRJMtDH4/PGNjQ=



=E5=9C=A8 2025/11/19 23:49, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> A couple of trivial cleanups for the argument list of two log tree
> functions.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>=20
> Filipe Manana (2):
>    btrfs: remove root argument from btrfs_del_dir_entries_in_log()
>    btrfs: reduce arguments to btrfs_del_inode_ref_in_log()
>=20
>   fs/btrfs/inode.c    |  4 ++--
>   fs/btrfs/tree-log.c | 12 ++++++------
>   fs/btrfs/tree-log.h |  5 ++---
>   3 files changed, 10 insertions(+), 11 deletions(-)
>=20


