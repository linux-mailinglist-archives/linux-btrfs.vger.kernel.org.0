Return-Path: <linux-btrfs+bounces-4129-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA948A07AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 07:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B806528B5CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 05:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9201213C825;
	Thu, 11 Apr 2024 05:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="X1m2xesa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F15913C80B
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 05:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813160; cv=none; b=A0n1NmMmvajSpdkO+IkjQfJPKr5ZIy/zuulnj7nHzMfd2cgUqkMwn7Rz/mUdP+pCznhYGiQPDrU49mZ1bC0xm2fUf2wdKotZ7TlgpgGD5gmCBmlA8/bFLuNkM90BNklUiDwbphyEtMNriiW61NdAJ1HjTXRkaYhRqYHedqpDIpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813160; c=relaxed/simple;
	bh=9N3x6DV0XJmjPykt4pwE/DkvoYqIIKcH80PGGNu+ocY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fscGqd//8QQry32jTEKwsryJjMQJNOjIutP89r0jNSGzV5aVIvCw+NhG9Rvj9vEpsSHKdYaOUFYjUkYuZJyx/k4GMtwbR6kd3Pw92WBhKcpjiweMRSdcudnCEyklVL5CgIloJryExtuBIrV0nhBkXEdaoy/jDH6ddT57Oo3wK8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=X1m2xesa; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712813151; x=1713417951; i=quwenruo.btrfs@gmx.com;
	bh=IZtN9FdqO9AD7tr/iDWdaBxBgXxfWd38SWpWGCFr+so=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=X1m2xesagfw5Gr03fuOt1flCKS3GyHQcOcC8o9LrCCSYE6IygF5uHGhaSH8PtxKI
	 TcJUwTCEvxNbD+VkMjE+TsN3yGwa1vNiofbMcb+yItnB+8aP0zal5UBJjoVlzDRvG
	 8TIgPO+u0WSd3auDMvlPCENjeH6ElkkYJyHyoKnl73I/JVAiKopVIE4AU44iMNbty
	 0rKdh/JRK/YiX+/Z0xjBU/KV3yTXoCKEaLEDZU77z0P+rPexv/LbggKQ3Djqm0k56
	 SQ8E6h5eOrtARqJPyaQXIDdAtkkpJeySHYlUB95MOmDu9i/7tmNkSrDAYzCHtATCS
	 tT+B2Ge6rCin99Vb+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLR1f-1sBUqb3R3r-00ISWE; Thu, 11
 Apr 2024 07:25:51 +0200
Message-ID: <634658ca-4670-434d-8e86-163378e5992b@gmx.com>
Date: Thu, 11 Apr 2024 14:55:48 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] btrfs: add a shrinker for extent maps
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1712748143.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1712748143.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EmZr6GCRpw5G3YuqKHsSmon8kiKdB+OqL2i9jNlgXDt6NsbHoKP
 cMu1V8VSXjf6y+Up27lhkKPE4zjYN1EoW2eSQ1CaMpRmSmzikxIg5Ea6hIPEGXhTSRmJ4an
 a9f9SUouaUrP5z1ya562SDpoy2Fm4K5hT6nond33mU0zFZTOPxhgY57sIusMpTaTotA1j7n
 PHCRHBWocngRabDL1Ffmg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5EfA6pDj6sE=;iKwoHnhUt99v93qZ3RlCjBrxcrr
 PdNNdwy+2TT1/W3ECLtxApV9aLHpuACL99BprEZJT49abop2M9RXhVecKBKGkhH7iiUFd8Cu8
 vpa/fpehcpCcQe7E8LhXEMXHjPR+/ouQA+Bw3PDgiU/WG4F9AOJRNcn1b9d+ovq//U8jod46P
 Dwa5NtEMBLWXuVfAfHNy4yM5ICN1IDMYfeWkCU3tHjhbkIVcgR5jsplq8w8woMu5AK90hI4rb
 ZqbiO1Jdu8FeZx/VVBk1DwMUBrPH8ZdOkAF9Y1bNooZ1VVq4/9fI9WQWMG6/CNwmswqAsNlfm
 l6OSPR3EY4FHoca5VOIBEVjSSy6KfDyqyxqFoBYLH9lPze4b4Nawi7z2lw4XZ1+9OnwWzolBg
 usZcqtuhGAVXnzVs7fgcX2wTW+r9PhNbGzPyoJ5klUuBm4m8ucAZ3WA2VxG2ZnP2ZAvZbeOwn
 Jxw5eMakrbSHZAtAICv3FA5xSnaHJvA80EgnVuXCmg4dc/sEcpgSHUqRAufpTH1GIdFUl3tCY
 WWXiiCK64oisCwktDtfzpfgO2biqXYe5YOuXa3tw7manZI7C4+oTbd6ebQMHDQDWAljkp/nG2
 S7Qur+kv8UFM7PThyHkKJfP1Wd0CUqnWlik1L9hRIcfegyHcxhM0iESu7xsI5imJfYgowu3vs
 4LNUR1ZY/XdKpqu+g1/r4JhTE1MZALjsgJlF7b8IlypKLXApl46dbsimY2g2k8i7GktxT5f39
 RIumXuzWtBbG8QyuJ6Kb+BwgM6JmE4dzYrlBiWG1BScgFFVmOuSrvM0iaefTqCE+dhej+ceIW
 EKOYkFRkr/d4prSAVWL9Nb0UE7ksIaiGZsQ1RM6x8gzIo=



=E5=9C=A8 2024/4/10 20:58, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Currently we don't limit the amount of extent maps we can have for inode=
s
> from a subvolume tree, which can result in excessive use of memory and i=
n
> some cases in running into OOM situations. This was reported some time a=
go
> by a user and it's specially easier to trigger with direct IO.
>
> The shrinker itself is patch 9/11, what comes before is simple preparato=
ry
> work and the rest just trace events. More details in the change logs.
>
> Filipe Manana (11):
>    btrfs: pass an inode to btrfs_add_extent_mapping()
>    btrfs: tests: error out on unexpected extent map reference count
>    btrfs: simplify add_extent_mapping() by removing pointless label
>    btrfs: pass the extent map tree's inode to add_extent_mapping()
>    btrfs: pass the extent map tree's inode to clear_em_logging()
>    btrfs: pass the extent map tree's inode to remove_extent_mapping()
>    btrfs: pass the extent map tree's inode to replace_extent_mapping()

Those preparation are all fine even as independent patchset.

Reviewed-by: Qu Wenruo <wqu@suse.com>

>    btrfs: add a global per cpu counter to track number of used extent ma=
ps
>    btrfs: add a shrinker for extent maps

Unfortunately I'm not yet familiar enough on logged/pinned extent maps yet=
.
Thus no comprehensive review for the shrinker implementation yet.

Thanks,
Qu

>    btrfs: update comment for btrfs_set_inode_full_sync() about locking
>    btrfs: add tracepoints for extent map shrinker events
>
>   fs/btrfs/btrfs_inode.h            |   8 +-
>   fs/btrfs/disk-io.c                |   5 +
>   fs/btrfs/extent_io.c              |   2 +-
>   fs/btrfs/extent_map.c             | 340 +++++++++++++++++++++++++-----
>   fs/btrfs/extent_map.h             |   9 +-
>   fs/btrfs/fs.h                     |   4 +
>   fs/btrfs/inode.c                  |   2 +-
>   fs/btrfs/tests/extent-map-tests.c | 216 ++++++++++---------
>   fs/btrfs/tree-log.c               |   4 +-
>   include/trace/events/btrfs.h      |  92 ++++++++
>   10 files changed, 524 insertions(+), 158 deletions(-)
>

