Return-Path: <linux-btrfs+bounces-16886-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E8CB7F54D
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 15:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47FC14E69D1
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 09:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BA731BC8E;
	Wed, 17 Sep 2025 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Mf/xl/S8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9725B20322
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100559; cv=none; b=njDWFHOdnaCm3sQfVEGxGvDHDYf6sergYc9ejKns+E8U+67hc9PGTY7sOvSieTcyYEF6dntBzqswqlArHOSzLXOZdZEi37pRa5ys9e7KTvZjfOKdVqlzwYYpz+HMQpsgVFPXnVE512aHpKHI40jr6LQPp3mw2cVT+RMZcpUFkRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100559; c=relaxed/simple;
	bh=5lTJVyoLqcUat8bcYo501jf3Aa42ngWEy35NIkEWvDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PHFj5gQC8uJnLySdysFFcq49Va/3kzZb9Ki5aSVAIT3JfOYpv0VDOkhrS25TzAmkJUqQXMcjGNoTGdGGKVoMj4/j3ncRwxALdXWTvjRcS+DMvwEPTZ4IYelsqvO1wsNzjhpzB8hZ57FXA7RLAQ1Ok6RQe6prv5J1h17nGxbfxFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Mf/xl/S8; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1758100551; x=1758705351; i=quwenruo.btrfs@gmx.com;
	bh=h0Kj1u/p5ge6X+qCPxcog6tzEY4F5U918Mm/ZzAge+o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Mf/xl/S8lmnb5aiG/zIe5m7MV99Bstn6pY4S6XIGODz+t6UO1VOl5ZDJM3WQxdMD
	 T27F4GbDn01oGtV8r7DeODhrFQGJd/LtPN/DDfFb2iB+luAfYKoEM0ahV5AMALnjv
	 jvFgKusdIFIfn6LI+avUBMddbwELOLyP3zLrIROH9wnVO/RCb5SwxqJHuPecWtEhU
	 +T5ajUMiVnPrTQcyHHrJ4eyjacpy2CLU7hseoQWddU/3pXfKBrWfMWOqpqy87oAmc
	 IuElVqY7Gd2k/Kqm4g0P2fvHn1XsTBJ76Sfc4nyKbjFps2wxBocc+xgI0kHZ/FsmU
	 gdcF19DN3P3/NDndkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McpJq-1uPCb61YX4-00ocU2; Wed, 17
 Sep 2025 11:15:51 +0200
Message-ID: <8844e6a2-7a34-441e-b63a-7f2fbaf8ff22@gmx.com>
Date: Wed, 17 Sep 2025 18:45:47 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] btrfs: tag as unlikely several unexpected critical
 errors
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1758095164.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1758095164.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VTcIX0LP8AJ84DSOr/sZqCZffS/LFvFg9JY/T2kYwtHIQ1km/hR
 n0BTQp8IdIY1i2b5h8xkVyW5PktVGcW7AxdSu0pmDilBRo17e+jkllrvRlEHyE0OGt/4UhL
 MoLzNdHtwulDwCMrw9aaMNks+CnD7ISzaI7SG6jwMuTuyN5VOsgUDUhg1Zpgf4g9ewrATBa
 E8X8dAPugshe0nGs/TIkg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/ofDan4WUwI=;dAd2ZkbcjRz1sIok37JU5xMY0DV
 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



=E5=9C=A8 2025/9/17 17:22, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Several critical error checks are never expected to be hit, so tag them
> as unlikely. Details in the changelogs.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>=20
> Filipe Manana (5):
>    btrfs: store and use node size in local variable in check_eb_alignmen=
t()
>    btrfs: mark extent buffer alignment checks as unlikely
>    btrfs: mark as unlikely not uptodate check in read_extent_buffer_page=
s()
>    btrfs: mark as unlikely not uptodate extent buffer checks when naviga=
ting btrees
>    btrfs: mark leaf space and overflow checks as unlikely on insert and =
extension
>=20
>   fs/btrfs/ctree.c     | 22 +++++++++++-----------
>   fs/btrfs/extent_io.c | 21 +++++++++++----------
>   2 files changed, 22 insertions(+), 21 deletions(-)
>=20


