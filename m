Return-Path: <linux-btrfs+bounces-17742-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 803EDBD6514
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 23:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0ECD84F41F4
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 21:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF8D281508;
	Mon, 13 Oct 2025 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="KE2ocOhE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215AEEADC
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 21:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760389296; cv=none; b=vEuCBjcgSa+8RxHtpJAXQh+BPOz/O1+DvMeSYfC72YBB8BrkHfy/PsUHy/7JB5u5gDoQPpx0e+orcgIo0YX3A4DHx33w+0YpeR0saRQB8Anxp1x5H9p8esuTUIHysUICc/888QKU2Jg2/tp+uNh0oC8WKWcT9zcbt2C0lc4stf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760389296; c=relaxed/simple;
	bh=eFbNG3ag1vyJvb5FF0fzF8FWulSv8/Q88D312/oquf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UZRAUqa56r8MMZsmDoJeRaj3jyOJW5c2HJCZqL8Nv9BgHNUkzYvi2hQsySOr3XbMCS30eOfBchsLQ/nOO9IpttOtlfhry42frHu7qCu0m7cYMPkJUV24ZD7VRhH2i++rUfbb3ArvBq9Quo57uZEKbI5vC0JAnZUvvC+oDbl9zcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=KE2ocOhE; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760389288; x=1760994088; i=quwenruo.btrfs@gmx.com;
	bh=Vb8C7noBg1j8EaQgFlZRrsIsuExnWo08jsTamg4cm6E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KE2ocOhEvrL3X0QNZkliO8WvlwUVrkbShaAH7YnUyVzQ5qcYZQ6BAI4ydSjvMdRB
	 cEIfa9dqx1GdGtdLTjOD/VAJHoWpqtG7GzXB4aTdEhOONBKm2Ts3kDSs+eU+uvu78
	 f7WHmiFFDg8Qa8dtMEuDFZVB/ohfPxauihF/IoBVX+p+00kDrBLxqYkdN0o4g9dTm
	 t9ewvS3IeN+A6FHQIsMc1GYF96EHqZv9cHDr9mJTyd+qURI61q/bV23YUXyntrD2P
	 sI1gKn8Am+C+0sNhHVAFa2dqFtC9le6Stzhff8mPi2lSLtmoiYbulA6qgETDnWCOL
	 gmfIWM4tZWB/kgnK6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mg6dy-1ub18D3EAI-00gqO6; Mon, 13
 Oct 2025 23:01:28 +0200
Message-ID: <622ef5ee-f94e-4c2e-8d70-8af73021146e@gmx.com>
Date: Tue, 14 Oct 2025 07:31:25 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] btrfs: fix a bug with truncation and writeback and
 cleanups
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1760356778.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1760356778.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2ehPVPr8nEOOtnc4VgkzSaEQp3817OXmdm9SHWIGK5LamLsFDup
 TT7N81RvsvyLqHzOiY/r+MWwNMuOSevxyAA8/ZsJuEZjl+/O5dwDOQff53iAhzdbrSDMjK3
 HEzHl2K7KmCKrIq3VEj9Hufa7af56HLxszZRsR7k+CY0p8WKQfxbIWC1s6Wkn3KIbp12K+Z
 QlJNcoYEe69FIP5Zc09LA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YUNd9Pe+E3k=;L29WhAsC/8j3PNg9b5EsHm8areH
 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



=E5=9C=A8 2025/10/13 22:35, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> The first patch fixes a bug where we can up persisting a file extent ite=
m
> that crosses the i_size boundary, making btrfs check complain because it
> won't find checksum items beyond the i_size boundary. Details in the cha=
nge
> log. The rest are several cleanups in related code that popped up while
> debugging the issue.

The series looks good to me.

Just notice one small inconsistency during review and it's not related=20
to the series itself.


Most callsites searching ordered extents are holding ordered_tree_lock=20
with irq spinlock.

However in btrfs_split_ordered_extent() there is a non-irq version=20
spinlock of ordered_tree_lock.

Looks like an inconsistency at least.

Thanks,
Qu

>=20
> Filipe Manana (7):
>    btrfs: truncate ordered extent when skipping writeback past i_size
>    btrfs: use variable for end offset in extent_writepage_io()
>    btrfs: split assertion into two in extent_writepage_io()
>    btrfs: add unlikely to unexpected error case in extent_writepages()
>    btrfs: consistently round up or down i_size in btrfs_truncate()
>    btrfs: avoid multiple i_size rounding in btrfs_truncate()
>    btrfs: avoid repeated computations in btrfs_mark_ordered_io_finished(=
)
>=20
>   fs/btrfs/extent_io.c    | 33 ++++++++++++++++++++++++++-------
>   fs/btrfs/inode.c        | 18 ++++++++----------
>   fs/btrfs/ordered-data.c | 23 +++++++++++------------
>   3 files changed, 45 insertions(+), 29 deletions(-)
>=20


