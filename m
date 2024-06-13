Return-Path: <linux-btrfs+bounces-5724-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51354907E3E
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 23:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2079B21A86
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 21:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3121143743;
	Thu, 13 Jun 2024 21:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Xxdv8nW6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2C813A260
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 21:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314678; cv=none; b=fP3sscJfHvk5DB26Zs9N67hFT7JWrvwMo+m0G0Hg00NTDT4QXrhEwrH9dURSl7Ck6Uq21/qj0txLi/8J6FcjkRdEuBVtSf2bCYTbU/o3SWnRgzvgXJzFBH7GCPMcoTyfZpNhJpmjRmyLFPPVGAn4KdncS88foqhDKMgYnQwPT+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314678; c=relaxed/simple;
	bh=dt9QOHWPwWzzpWjZOKtwSFuAHGoJanOUGP0BXpqWrnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EEgpSecrntps1bEQgnFLn8pwEUF9nfXeIZ9ihq6jEVD0VMXBPhRpG8EKCJenvKQHIV2kxHeRtwBsOucKROeNPX/YqtDx43PDgng2PuSqB29e33C5ofAeNDqsQdwAMbDNZYjyn8oc0buHVT6pZxL7EUy5nWuUGRvN8wKW4mLliCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Xxdv8nW6; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718314671; x=1718919471; i=quwenruo.btrfs@gmx.com;
	bh=maQSfylibzrqXDxPtInFLRRfrKvbdEWx/tDzGUOAF+E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Xxdv8nW6N8o8z6YXExY5TBaOf79JeUwJqoiSsHjP6VPCIyAsA83OaMGIGL68bWos
	 GG5Zc8pzb8nfJGw2fA/6MG40gDuNyisyjqtZfxx9hIp4Y5au/dDBmxOpPM1597MDv
	 +nMO/r4QwJEbcC3hF8hwQXaPZU7UK0mQKirzcZ2gyOBCdEl/QpXIrJa1IjfcHJwE8
	 p6g4AqpDKGnbDxCx6BkEGWebeaYkYMhw4omBCde1nPYUAq3lPxIVphMsgqMAx5ox9
	 LOCSFSBKaBYTaBNvC8RO/w1LY8cS9W0mY6zcFV7Sbixx0vi5LU6gG8LM1VDb/+qto
	 y+0RDnczZBqCST3VXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N95iR-1sVONV15C3-017M0N; Thu, 13
 Jun 2024 23:37:50 +0200
Message-ID: <5083cc62-4983-4e60-8dae-cb5f3a204f16@gmx.com>
Date: Fri, 14 Jun 2024 07:07:46 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] btrfs: fix a deadlock with reclaim during logging/log
 replay
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1718276261.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1718276261.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jBnRQ/tzMvucneX8yyL9TBg33KcnFsTbH/c+XGXfN+fl2Dfsbj4
 tiHJD5jo/+in/C9ac8BKm2dMbPo/qqfuBMplSue4D4A2OGsLmHXb10W8VQbrtx/ITLIEIv0
 34t08jSHeTZko21IoWVYop2kh+O+LdnXLmnYqdexiyADmVGGcasSLXF7zxBA+I3Mh1PP7ot
 XoQrUDNdSbTpJjNtsubwg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BRevLb0ykL0=;bhhkoq/KEJnN/jLaXK+DPrSJuri
 Wc4GZC6Q/KUe+6zFAE4oyGZ1muDIeybQ+TV/K7Cf81jh93arY5e9vv0ZkItqTWlqmzhyKBHzf
 UrmbHLDHsxzflS4479dBgZ9ZiRkHxo0ybX64Sv7UlPynBNnBrRIw/jtuNaP6GfXwTzueIYlJH
 XInldgq1Sr3mrRASaDQ3PhE7fVoy+SFO1bJuMO5khaBgF+mMVJvpYEBgrHKUUYyNzY7oi9nEt
 w80gmXOV3CVbCfd+rdrEQtZvySmhsHPd8NBDV89YWkWIcrhJ1YHYVRhg2qd22M3RlIRU/gGiB
 7b9QUbkTgshJDmyXswVc/dHnhfW9FMDqTfIpX3QJ5DNVr2CJwABRhGh24oe1B3q45AUwSq1Of
 9VmnlIhK4/uxN9qmOM2NH7tNwfkf/43twsI9rfxdKa5J9XKzn0PhviYxGM86wv6l8Zxk0jdtP
 7ArcFE2BGyE/RdC+dXuqkJGZl8au9BEVDdgqPGLu4LRRIYsWT5r/ldLEns+4C5DZdlDAQEI16
 MOZLms1qeFeenVk1M8+216FjEzcC7Dho4XD6MX66mUDLYjS2XcUIUrY7WBCiBsnajd7uQ6mIM
 hQFr2wHkdBz0uGOpgQmdTEZCUwPsWCeZGYzbUpDyuR716pgTzmCWSoyDeCMmHKBa2dsX1Bkd0
 ZLZ6DIUVO8yaKcik93uvMu1k+TrNH90WtXNjJ6JzKCsga/D5Q/Zwtd1jMNZW6xwqzdgMCXpMq
 27rfKfdJbDypEk3iSWCB5+/WWrs4M+yxWOY0QqKdiZrefPXpuwVYEgG1VKz0o5/QFVKOkP8/t
 jKdimb75+siPFV256g6VCqrIY/rxCOiNKyWoSzcJEgvSA=



=E5=9C=A8 2024/6/13 20:35, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Fix a deadlock when opening an inode during inode logging and log replay
> due to a GFP_KERNEL allocation, reported by syzbot. The rest is just som=
e
> trivial cleanups. Details in the change logs.
>
> Filipe Manana (4):
>    btrfs: use NOFS context when getting inodes during logging and log re=
play
>    btrfs: remove super block argument from btrfs_iget()
>    btrfs: remove super block argument from btrfs_iget_path()
>    btrfs: remove super block argument from btrfs_iget_locked()

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just one question relied to the first patch.

Thanks,
Qu
>
>   fs/btrfs/btrfs_inode.h      |  6 +++---
>   fs/btrfs/defrag.c           |  2 +-
>   fs/btrfs/export.c           |  4 ++--
>   fs/btrfs/free-space-cache.c |  3 +--
>   fs/btrfs/inode.c            | 24 ++++++++++-----------
>   fs/btrfs/ioctl.c            |  3 +--
>   fs/btrfs/relocation.c       |  4 ++--
>   fs/btrfs/send.c             |  9 ++++----
>   fs/btrfs/super.c            |  2 +-
>   fs/btrfs/tree-log.c         | 43 ++++++++++++++++++++++++-------------
>   10 files changed, 54 insertions(+), 46 deletions(-)
>

