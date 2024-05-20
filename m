Return-Path: <linux-btrfs+bounces-5110-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80BA8C9B26
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 12:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF871F21A3F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 10:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3304F1F9;
	Mon, 20 May 2024 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Ht51+dQ1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CBD225AF
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716200613; cv=none; b=o5YFhmeh31OWcyJcForxCH1INTn+BASAlrf1fEBYABdVdnavT89HBxrgdX4iVQhHrLHuPVzzRIDd9p1rvkmD/LdnxrHMoqT/a2ES8FGIYMGIxfpnXtmNhkgYme1C/qPPh+O9EdfjRL9OsKPCvC7Vwdxzug0a3Ku7FxF5FB547dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716200613; c=relaxed/simple;
	bh=CnDlYKUsSc1Pn48rR9N0/TMUlxESY0nSTDqlau+B9WU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TIqVxLTzW5rMrnWty86hBp/ZH+vpYVeoF3xY0/Yv5+iD7350LOS37LS3aqx35SFP2KsXc6xPNyR7kgwBWy0MhSHd65L4vDnbEn+KC/IO0TxIj02tKilt3WVRRG+9K5ZoyBEft/hrDiJ6ZxavnaWZUHE7eR6S73zMxj3B/SXSjQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Ht51+dQ1; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1716200604; x=1716805404; i=quwenruo.btrfs@gmx.com;
	bh=TG3mVu0S+txaRxDMiy34D1/vTiX2nKL6o/Vvgj2Gw4M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ht51+dQ1hHsrMsDu/o9ow53LnUYeqskjD+1Kmk5T0qEYHE5vYSmkqQ0KyT823yBE
	 8WehexbcizucI9hNtMHh35T1uXXTTyNaapgXAws4vvJekmTOs/969jsl/4RYd26Sg
	 cadl0pRsiLrIhMy6dx8EQgeRu2Yq1jXdeXvGgYWrtQnteFHf3jxaGFTcgVjQ8jGgV
	 fyPudaqemVcbYGqjQlkX0reGTiNpBVpreJQGZiHGhrURCwfzDvfUZ735nriSjndbZ
	 zzBlm7c7wTxiRPdA9BI2ct9B5ONv6A2CxsQ0fonM66/qGDQZW16xHt/cSqQW7aWR1
	 1CaYJEe/Xj9Narza/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MsHnm-1sO4FV1RIA-00szeD; Mon, 20
 May 2024 12:23:24 +0200
Message-ID: <375277e1-f1db-4a23-965f-2f04638a2a83@gmx.com>
Date: Mon, 20 May 2024 19:53:19 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] btrfs: fix logging unwritten extents after failure
 in write paths
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1715964570.git.fdmanana@suse.com>
 <cover.1716053516.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1716053516.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x4jiv70G6IyHYs34W6cbMZ5iMnbWJ3AbQbOkO0PH2Ksn7wroRaJ
 7EaZXVZxcpLj2kP/615xJQt7+R26dG2hFk8qxGjCmzCj9iGB5Cr3rIsrujGREqqYG4vv4ax
 KFyPXWu3EwwTNdzhQbs2XddOJoDP3Tc6PimojrV/l4mNoIkVfN6pF6m0VYi77gtnnkxnQE7
 PPJEBIkjzoo4klxi6V/SQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gywdOkr6gnA=;8wHcZndhVPuBmRkrKIxLTwKLVkO
 s5luAtVAtL7j4dzksjZN3RuxbwPoznH2zKbPWAd8kT2aEKG/L4hWc2QtyF6u4vc0tqetIdisr
 zcNGc/1ZIJe70NIB7pI7kRmFQC7J0sNZh5Z9YN/T+7bia7eCvuptqMvmzCJzx5mVZi8I12ups
 9ylIOpkycyuxC6TViSst8rZqRVUzOExIlWEdSuWAI+oihrmawvw0HojBBZn+AIL0FJKhEILfi
 RYOPNuzEtNZeZyyPHBr5WcNd6PXaFDcUP/yjLQeiabqxDSPL2FqxD9sXDp7S5p24qgWX59uqq
 5MmJqGmV6bgJxVzXKd0YshKrDjOw0BeBAsuybajggzjf6sVcoEOj4EKw4qDzDZdCfDNIEfDs3
 BWoqJQPSqeHOVmdnduc9IF6OUUbzVtX+vC0h0ltu2/lVwIEMusml16AOtnAuABMhX11160TNR
 PN9s34eBfbGicf8N1SjLkJT35jN7a2AD7Jz+P1Xa9ERYlldDrLudllriXvT+uBtCq6B0pagS+
 0zNHTrBjXhQk8kwPEgEUfnydFglIpA2wZOYVFbfgmb49b+no4W+heEL2D+bQYsPZkZZbMeghN
 Yi0JWt0vqq63MaYe76Y8wQbnxMYzXge0YDeDEiVTdL0zlTxWpcdkE9Tx5d0REzC7+oaTfCJ7a
 ZdWhoLTiysJYSBr+BKfSXH7NMB33UlJGxCqWXKYMrODjc440Vglbm8q2/OWVQoeeJiZH0F5ZH
 O+QOfOJHF8o2FHRZZAiNK+ZI8uR9KTbBXCF7vtsllm6pMZkZ4Uwyel9dmIRoSiV3JtQ0FzB6x
 ztWcRzGUJ5Vo6ejDTO2NEprVcqHL2tYLRSr4qmJGflEB0=



=E5=9C=A8 2024/5/20 19:16, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> There's a bug where a fast fsync can log extent maps that were not writt=
en
> due to an error in a write path or during writeback. This affects both
> direct IO writes and buffered writes, and besides the failure depends on
> a race due to the fact that ordered extent completion happens in a work
> queue and a fast fsync doesn't wait for ordered extent completion before
> logging. The details are in the change log of the first patch.
>
> V4: Use a slightly different approach to avoid a deadlock on the inode's
>      spinlock due to it being used both in irq and non-irq context, poin=
ted
>      out by Qu.
>      Added some cleanup patches (patches 3, 4, 5 and 6).

The whole series looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
> V3: Change the approach of patch 1/2 to not drop extent maps at
>      btrfs_finish_ordered_extent() since that runs in irq context and
>      dropping an extent map range triggers NOFS extent map allocations,
>      which can trigger a reclaim and that can't run in irq context.
>      Updated comments and changelog to distinguish differences between
>      failures for direct IO writes and buffered writes.
>
> V2: Rework solution since other error paths caused the same problem, mak=
e
>      it more generic.
>      Added more details to change log and comment about what's going on,
>      and why reads aren't affected.
>
>      https://lore.kernel.org/linux-btrfs/cover.1715798440.git.fdmanana@s=
use.com/
>
> V1: https://lore.kernel.org/linux-btrfs/cover.1715688057.git.fdmanana@su=
se.com/
>
> Filipe Manana (6):
>    btrfs: ensure fast fsync waits for ordered extents after a write fail=
ure
>    btrfs: make btrfs_finish_ordered_extent() return void
>    btrfs: use a btrfs_inode in the log context (struct btrfs_log_ctx)
>    btrfs: pass a btrfs_inode to btrfs_fdatawrite_range()
>    btrfs: pass a btrfs_inode to btrfs_wait_ordered_range()
>    btrfs: use a btrfs_inode local variable at btrfs_sync_file()
>
>   fs/btrfs/btrfs_inode.h      | 10 ++++++
>   fs/btrfs/file.c             | 63 ++++++++++++++++++++++---------------
>   fs/btrfs/file.h             |  2 +-
>   fs/btrfs/free-space-cache.c |  4 +--
>   fs/btrfs/inode.c            | 16 +++++-----
>   fs/btrfs/ordered-data.c     | 40 ++++++++++++++++++++---
>   fs/btrfs/ordered-data.h     |  4 +--
>   fs/btrfs/reflink.c          |  8 ++---
>   fs/btrfs/relocation.c       |  2 +-
>   fs/btrfs/tree-log.c         | 10 +++---
>   fs/btrfs/tree-log.h         |  4 +--
>   11 files changed, 108 insertions(+), 55 deletions(-)
>

