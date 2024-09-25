Return-Path: <linux-btrfs+bounces-8232-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 115CA986915
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 00:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6174286776
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 22:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA481547D5;
	Wed, 25 Sep 2024 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="b+RPHkBg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4162A1D5AD5
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 22:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727302324; cv=none; b=YEwP8yzdhdnhI3NCr/DLgzXKKPPyNOWh/dvQlbHyEtQl6t171PVkwyMdwzWVtEq+fus+uuVVKBuyKDdR/2l8tul0jZ7RP8tLddIxXTv0rVwGu4GE/fSCV+3TFkgUS8PXfyiQE8xArM679SMbCZ+8EYe6neqHYctAQ4+/L3Sjuqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727302324; c=relaxed/simple;
	bh=uUhfPwaQC2ErMXhWo2/66cADpdWxxnIVvJiAtuoEWlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sBKduyUL69VmzcJRXAaLkjkI7fmSptfGhAAgBmIz3CsxoWtKFb7TjAbl8vLX7b0jeSxUmZLdVFYm8rEFQyeAmxfJUUzZtoP36OJFIrP4xkYoTfudo9CkUmJ7PVFisiipr6gDkxO09aYkshNYPVTxYIdbcgIBp0Bev2eOSgf+wZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=b+RPHkBg; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727302316; x=1727907116; i=quwenruo.btrfs@gmx.com;
	bh=xWA81PcqOGGYQuzmXJ/0yj4qdIOk3BxPSQgU0hggoMw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=b+RPHkBgL+cAnviPeEgMNLCXpW6mGdaHSzxd2l4pr2ZFeyPh3MaB7y6GpKyJ7v0h
	 jt9YloCBJW+vAF2uhyuMVQmkrNe63z8mj0q5RmSSZHfkTW/VtU6xfYEIULG+AauNM
	 ckIHnnpipPsExcaA0aj1VP3/uk49C8YuFXC2Vap2RcmYrj3K4wnEj24zC2NuTEsUC
	 RQrV437WcPZ8afYq7F2akVPRl0wszi7nuFIDgUYBY+/qq/2ONCI4/BmYfBOOoVfJF
	 tOD8pRMPaE3mOvX3qP5H4VonYNsdTvUiSliZWiStEeME16yzp2kbPE5wGMoZGZl8x
	 EnWdnVb39lRnlDtE1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNbox-1sagbo1zA3-00K3n9; Thu, 26
 Sep 2024 00:11:55 +0200
Message-ID: <a27ac429-ef78-4cb6-819a-33e8e482029b@gmx.com>
Date: Thu, 26 Sep 2024 07:41:53 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] btrfs: make extent map shrinker more efficient and
 re-enable it
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1727174151.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1727174151.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u5d+Aiy0VEH5ju22GZS4XpfYP0MSHQ2EIPuCcAV75MGIi9o3GgX
 xct4QAPFFaOh5T6PJ/TMes6jzU40boAVJzV52sei54uhAsKaKEqt7xckoi6ZL/wc6d4AgZg
 46Fy5GL3apGceyuBIvW7f1X/h03lpzegoDXCDSpJA04ENinEB/jCoNKWn0jSwsQAPFc5Cof
 C5JfJZ0Wql+QCmTS6W2HA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WkvTGiZl95A=;OKexlNsi4xkgPX47KfT2Dz/9HfR
 S7gIe3Yak/C99lD9cdqSJDW7G8yvSwIWUnG/Sta0XgHI++cp8qOoR2gPxng0C5WFdWN9hskEJ
 KGq+6pEuhzYpwPJ+jr2S3Jm6coxC8fsoYIqsBSse606DUjioITfMW5UHejZKBUcNnu6eIfhyz
 NSA4azP3aVHniYrNWyfYyXZgjBxERHh/NyPc6bChQRm8gkxst4qdO+sTiNRB6SzzPCpBg5Hjh
 5EZxMu7DWttApPvsLU3OWMrnXZ2PJew7AGb9H3nponR8bpK3a8y69D6OaRt6umEeTneGPxhgV
 AO2BdPcrUacXDIge8C/srQdDp0LYVddT6xsRGjH2vZb2pyeINbENKdHkOTvS02OYCwY790+iD
 kKXym2tS8sOWnk5lcoV7M7dXagI+82CC8ahs2QXtVMcxQO6OAhdd+LHZu+TsobHJtVICjSIpc
 yWg/Pboji4sua8471SIlkBZMQEof7rYk76EW28LLiooZgNtKmoFske2TCV2yf4wZ0+5hPZMdO
 v1qP5lZF3C8YaQUt1x2bKWiMcBWND/00hK4OBBinNtcz6wyxcy/JshmondUkZUX6lBiOzlnCn
 vPoyYESHd8SvkpxDb+5cS9Bs+NrRf2GK48xyqCzKerCVL2Bb2bvtEMwMqIunRWA4QTvlhkozz
 0g3AG1KKlNmjRJ6rWTne8PluC1twO4irwvnwtp/kg/zESMvwB25VOM/cSwWCvh8fzqRspU3LC
 yntkkWgJgUoMFVkunIP8/msQ6U7uZR2aP3ZQIGm/byoR2Uj38TdhlMxU5rERMDLFSY7nJeIMQ
 QqBpiG2psPnJwq/B0YfYq3Cg==



=E5=9C=A8 2024/9/24 20:15, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> This makes the extent map shrinker run by a single task and asynchronous=
ly
> in a work queue, re-enables it by default and some cleanups. More detail=
s
> in the changelogs of each patch.
>
> Filipe Manana (5):
>    btrfs: add and use helper to remove extent map from its inode's tree
>    btrfs: make the extent map shrinker run asynchronously as a work queu=
e job

I only have a small concern on whether we should introduce a delay to
the reclaim work.

The remaining patches all look good to me.

Thanks,
Qu

>    btrfs: simplify tracking progress for the extent map shrinker
>    btrfs: rename extent map shrinker members from struct btrfs_fs_info
>    btrfs: re-enable the extent map shrinker
>
>   fs/btrfs/disk-io.c           |   4 +-
>   fs/btrfs/extent_map.c        | 122 +++++++++++++++++------------------
>   fs/btrfs/extent_map.h        |   3 +-
>   fs/btrfs/fs.h                |   7 +-
>   fs/btrfs/super.c             |  21 ++----
>   include/trace/events/btrfs.h |  21 +++---
>   6 files changed, 83 insertions(+), 95 deletions(-)
>


