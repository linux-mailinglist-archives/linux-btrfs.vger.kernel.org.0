Return-Path: <linux-btrfs+bounces-15063-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DE4AECADE
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Jun 2025 03:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8DDE3B8CAF
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Jun 2025 01:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D8F1BC41;
	Sun, 29 Jun 2025 01:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="dxbXNHoI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4AC3C01
	for <linux-btrfs@vger.kernel.org>; Sun, 29 Jun 2025 01:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751159904; cv=none; b=n9YypvXwg0BJvWauXRfWW8r+RZMmvelNN29sPcIcysaoYywOgFlgnQ0vfJmpUaNdoS4KsaWekMf5ZI5j+ii/AzINiOV4tXaoAjeatPolipQaQxp27q7qAULifPXydf6z8JpJzKZqlK5oP/H8367r7L9Ns+aUwpKgcPqY4yKCXas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751159904; c=relaxed/simple;
	bh=EMmVTtV2H9/o0pbcMhf6F4dK90LrIKnPYM/N9D1GcGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HYVpogo+OatHT1GdFIOlUcND3IQd0svaw/XqaGGHTRc+pkanRd/usGYVGtQaFj2OIZYpuJpa/dBsnZOi8WM7W/4wLWSVOzZwvI6VKWgfg+RDzwPtZnSVkLSrYPT4G+Od1qBIPzZpwy7/h+L8B7+AlWeZmuRrSQkfE1ESwZha7HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=dxbXNHoI; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1751159900; x=1751764700; i=quwenruo.btrfs@gmx.com;
	bh=wJP7m8bn+a/Xd7y0z1Sh4lhOliaq+D/Pp0/95mktisI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dxbXNHoIsDMwoQVWkXacf532IuvNLhYI6DmGdz5U1CGgJb/JKYjC/n+zXPeZ5hvM
	 vQf906M31L09xRzhyHOJxG6Y3JJG+ohHK5TlPFoPvGPMiNl53GSqyWXNx/zBW1xN1
	 084baoeEHgLTg06AJX58ZyzZ9eA4SH2Hxpv8gE9lZj3vPhaYxb7FmzuSMxwfktrcQ
	 K/iaVnIzbEqvY8VYKexDQQJoy6rKJGRXfmQUUgL6/vdREiPnfaAJM1grf1eAKdT/P
	 Eok6cxSf8PVw7tClsOZqDx5yLSNnsyhLs9v/Qzof5DaZJgGeRWNW+p1gq3hOMI81n
	 zd7HD6Ul2XLRH6aImg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvsEx-1up8qU3c9P-013MT8; Sun, 29
 Jun 2025 03:18:20 +0200
Message-ID: <2055bb59-b10d-41be-b7f7-f891e4bcac00@gmx.com>
Date: Sun, 29 Jun 2025 10:48:15 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Set/get accessor cleanups
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1751032655.git.dsterba@suse.com>
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
In-Reply-To: <cover.1751032655.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EC/nVSp5AYCwCsVSpRT50uh7TDjoOtuyze6SnqNpLH4x8+gQVSu
 AHqU7Uzbm43iwyvI+aZDDOXc41NlRHlmt1rwmKv7UJsuFZ+Yql+5i1MA9FQWi0HDnS2a+fL
 U/yVg4ij+fVYc1BH+e8W0BqIRe8P6DviZRLP+WizuuhR5jQc7gKZxF5TWPnqyGHMPaFVBpz
 FXKHeOn5Gkq99hKxNi0Ug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VfxR5CY3kLU=;x0wolVpBYSaWwcdsBA7obFT2q8Y
 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



=E5=9C=A8 2025/6/27 23:33, David Sterba =E5=86=99=E9=81=93:
> This patchset is first in a series to cleanup and optimize the
> accessors, now removing code that's not needed anymore, explained with
> references in the last patch.
>=20
> Overall effects on .ko:
>=20
>     text    data     bss     dec     hex filename
> 1463615  115665   16088 1595368  1857e8 pre/btrfs.ko
> 1456601  115665   16088 1588354  183c82 post/btrfs.ko
>=20
> DELTA: -7014
>=20
> And stack consumption:
>=20
> __push_leaf_left                                   -32 (176 -> 144)
> copy_for_split                                     -32 (144 -> 112)
> fill_inode_item                                    -32 (80 -> 48)
> btrfs_truncate_item                                -24 (152 -> 128)
> btrfs_extend_item                                  -16 (104 -> 88)
> btrfs_del_items                                    -16 (144 -> 128)
> setup_items_for_insert                             -32 (144 -> 112)
> __push_leaf_right                                  -24 (168 -> 144)
>=20
> REMOVED (744):
>          btrfs_get_token_32                          88
>          btrfs_set_token_64                          96
>          btrfs_get_token_64                          88
>          btrfs_set_token_32                          96
>          btrfs_get_token_16                          88
>          btrfs_get_token_8                           88
>          btrfs_set_token_16                          96
>          btrfs_set_token_8                           96
>          btrfs_init_map_token                         8
>=20
> REMOVED/NEW DELTA:  -744
> PRE/POST DELTA:     -952
>=20
> David Sterba (4):
>    btrfs: don't use token set/get accessors for btrfs_item members
>    btrfs: don't use token set/get accessors in inode.c:fill_inode_item()
>    btrfs: tree-log: don't use token set/get accessors in
>      fill_inode_item()
>    btrfs: accessors: delete token versions of set/get helpers

Looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Although it also exposed that we have two different fill_inode_item()=20
functions.
I know the tree log code needs some special handling, the=20
fill_inode_item() in inode.c looks like can be implemented by the one in=
=20
tree-log.

It may be a good time to merge them into one in another patch.

Thanks,
Qu

>=20
>   fs/btrfs/accessors.c | 78 --------------------------------------------
>   fs/btrfs/accessors.h | 37 ---------------------
>   fs/btrfs/ctree.c     | 51 ++++++++++-------------------
>   fs/btrfs/inode.c     | 50 ++++++++++++----------------
>   fs/btrfs/tree-log.c  | 48 +++++++++++----------------
>   5 files changed, 57 insertions(+), 207 deletions(-)
>=20


