Return-Path: <linux-btrfs+bounces-15040-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E606AEB5DA
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 13:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02FD560975
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 11:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C62E2BDC37;
	Fri, 27 Jun 2025 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sZbiBCXJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19716299AAB
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022285; cv=none; b=lQYV7LZc5fsh03OSfGheOAivY4PwTJXsDKfcXBui9f/gGF+VFCpSNQ1uZ6tWQk//5fw1Jnro6fQSambRSXfObWB2wC0Bg9W8zu0KEoNqTJJSGgY8B34KcI56wWzQch9D/7O3NOcafKdTKZiwWuMBv7TUdd03mYj2OJmBMnAGInY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022285; c=relaxed/simple;
	bh=1PSxH+8GKYGFVEf9rvoCj65wQPboNo86KOtl/f1t80A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YqZN6e7PhS3+aslvw/qf2t9WUxcKKyPzfVRi8w0CIadXj5zlmEEDHiLKUPy4QP3/yxDXm0JCaWHlW5cY5fRE/iOV7hT/UStK43ULrcddicO1EoSnaspKm57A9JIg01lmHbJUWTHwaxgKTes+g1urTszhYjOOUgJ8jmN4jOR+F1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sZbiBCXJ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1751022277; x=1751627077; i=quwenruo.btrfs@gmx.com;
	bh=IfL/GiJE0obVeoRqiTS9WVM5AzcMPt6t6iBS7k4XSpg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sZbiBCXJXZcD4UTlwEQrU1puk/2ZQVVvaHdcrtoS56bvISTwS5F0JPSW4ILq+Ijb
	 V3JBgmpiA7gEi457dI+QStDeVKUm0vnLLiBtuenbGt06qloCWDtSo4TE0Z5bPe/Jy
	 bVnGyxdslkcViOlvvY4hsWfq6jEJ+abPIVqKa+z5oe7hfoRdSmwWzUjaKUCJbemIP
	 LH0avQpkVmOB3Eu0C5UezKKavK3CaZLSRYeg2T1Xf+mnNuA0zjLeFXWAAxVIIMLQJ
	 wQ19pjHQpRMFx7R4sWZDMH4srzOvenAKa00COLSgHE1FVD4oqP56VWTrXOpo0zu9D
	 8NWwpd2aSaQZ8MmqgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McH9Y-1v18mW02AO-00jv8N; Fri, 27
 Jun 2025 13:04:36 +0200
Message-ID: <6f38c4f5-454f-4be0-8f43-b9b93f6e77ef@gmx.com>
Date: Fri, 27 Jun 2025 20:34:33 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] btrfs: log tree fixes and cleanups
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1750709410.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1750709410.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NewMwT2thrOjG5oJy7ZltytJSN1LgXbNNvqr7yTPyfhKh89kW8v
 nYrqtwy/r5NQQmkgKsJuB+0qfECYT2fGeJ+8e6EVoOl3N4fWsUEheQzblsLNsTI5Urk/BvJ
 BPDqketFfrlFE8+qqaVcQR6VsEtmIHtp5E8R/gmLI0X3pUZADM7ocgt+5fCnCA1GkOMOt7k
 ZrHSWcro4Z1fBgwD5u9sg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SBN/G/AfbZE=;HznPTY5bMXI6BUBqw67Ay+7hzzM
 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



=E5=9C=A8 2025/6/25 00:12, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Several bug fixes for logging and log replay, plus some cleanups.
> Details in the changelogs.
>=20
> Filipe Manana (12):
>    btrfs: fix missing error handling when searching for inode refs durin=
g log replay
>    btrfs: fix iteration of extrefs during log replay
>    btrfs: fix inode lookup error handling during log replay

Patch 1~3 look good to me.


>    btrfs: record new subvolume in parent dir earlier to avoid dir loggin=
g races
>    btrfs: propagate last_unlink_trans earlier when doing a rmdir
>    btrfs: use btrfs_record_snapshot_destroy() during rmdir

However I'm not confident enough for log-tree code, thus can not help much=
.

>    btrfs: use inode already stored in local variable at btrfs_rmdir()
>    btrfs: use btrfs inodes in btrfs_rmdir() to avoid so much usage of BT=
RFS_I()
>    btrfs: split inode ref processing from __add_inode_ref() into a helpe=
r
>    btrfs: split inode rextef processing from __add_inode_ref() into a he=
lper
>    btrfs: add btrfs prefix to is_fsstree() and make it return bool
>    btrfs: split btrfs_is_fsstree() into multiple if statements for reada=
bility

The rest also look good to me.
So for patch 1~3 and 7~12:

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>=20
>   fs/btrfs/ctree.h        |  17 +-
>   fs/btrfs/delayed-ref.c  |  10 +-
>   fs/btrfs/disk-io.c      |   8 +-
>   fs/btrfs/extent-tree.c  |   6 +-
>   fs/btrfs/extent_map.c   |   6 +-
>   fs/btrfs/inode.c        |  64 +++----
>   fs/btrfs/ioctl.c        |   8 +-
>   fs/btrfs/qgroup.c       |  25 +--
>   fs/btrfs/relocation.c   |   2 +-
>   fs/btrfs/tree-checker.c |  12 +-
>   fs/btrfs/tree-log.c     | 362 ++++++++++++++++++++++------------------
>   11 files changed, 281 insertions(+), 239 deletions(-)
>=20


