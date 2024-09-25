Return-Path: <linux-btrfs+bounces-8235-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE99A986936
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 00:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D55A1F24874
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 22:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5B6154BF5;
	Wed, 25 Sep 2024 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="aE43GrJC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C253E56A
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727303732; cv=none; b=BPNfOBFX9F/tx3mkmEWUKs16kXcXUAYcJP4abWL0lngylEYS+zJwl8TFvvHRulSzyEaQFbV/zgGXCK2ncakuaiulOa6j+JKsPU6tpDRUR1OBr76/ILCJOghrZj8Pnvv33+KKR1KbjrGPG1m80Yr9I7atawZzevoCgB5cwc5IMes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727303732; c=relaxed/simple;
	bh=g2oNFj/EkXmDVIH+etz/dOlFVq2Bp+sredn8NBJPCe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HsJwC7UmD3DC/BUnV/T22ZZO2aipabA/vHLCiQX1RTEg7rwXPWz2X1NWhz/KMD4ZnSf2YrUzxCr7T8vkeL/T5mRigmBTBCCPKgjDIcY46bRhaKECP1gyCnRTyvGVrSqkvu/Slp8SPUhjz4HUb+ueOo2hvOr3iSJ3f7miGO2ZIto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=aE43GrJC; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727303720; x=1727908520; i=quwenruo.btrfs@gmx.com;
	bh=C7k6Hx11/fj8ZCxumJk9/uYTsrRzEgso47VD5l4yP3k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aE43GrJCsgrlBxClAs8rI7QKs7tErE/rxtS9XhAsdRlS9YTyZkEi+Y5FvJmMxQKc
	 Cl8kUuKlgWXqq/d8KTvTbq0bEqW/FJKDD2NaxSLCKhTi1avpHwfpCuW2++YMkaqtQ
	 tghoFhQUYP0O1k8Es8w+LWgQU1OlOaRI7iaydjkQTVxZZdVUbBUAvWJPQ+8sLDjSh
	 pU8ozzmRVLoxa5qPtZUucsqSSekFulqT7FVXA2qQLDtbWyz42nmq0HHMgaDOz5Kkb
	 UCnW9LVBlj6GEFO1cbuDZ0YCIlcZzuMP3QnPz/IgahHZra/8VToJJaQxrJZd1Xu80
	 /JG9ccEsc2rie2rShA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYvcG-1sOsSt2v6e-00SOHR; Thu, 26
 Sep 2024 00:35:20 +0200
Message-ID: <802b77a8-adaa-4ea2-adf2-05438aa36410@gmx.com>
Date: Thu, 26 Sep 2024 08:05:17 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] btrfs: delayed refs and qgroups, fixes, cleanups,
 improvements
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1727261112.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1727261112.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hzz9Mdii1EXpo7jxr/Mughnq+/UBqGPVY258lX0QyPRITys8o0E
 t6jnG2t/yQCU3tBz+Q0EV5rTUAZNvS/zPTa2qM4Sn9HretxKsFNnHOq7wunauCUQoVzsvM7
 KE5DVnNk0vT/4NH5buqzTSPy+Ocycwl32CrVRlWXPwbpcx/SrsbtN/yR4MnMUhbJWsViwAY
 Kodad4pc0tMNBBiF6jddg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cwQ1YeoN1x4=;/MHoDZK2brLlFkNt2zVMONJzess
 fRFgY/CO0zddALLRQZKPQowg28Y6dLhdIC/x0J59ru0+hkdEKFqYENYM9b3jy5VGArU7ub7Di
 nr+L9x2KyfIFNwL8/yo3rVY1g3CSG/t0FXP5xiPID1MKnguhxXp+hYTuHlwwWfRG+AT/uOa1M
 yansAlQi3Qn1JjPT9G3bQ/MyFIZok9Bf1gxcKwGNLHuh+e1qMVfAjBT1dGgPrj6tuk0jEOK1a
 SXXSiaxRbCBNCDydNLCIMN2mVQkLuGRD2x7KCEH5jtg29O0xPoT4ZDY1FA6h6ZkTs6Ow8zbqW
 PP5eIzBqPVBLYNNvbmJu1quOpnTDeifBCyTBX5V0rVFbAoet1t+az7hjE081KdOzOCX2tCQIg
 FTHCHXlDc2a7AhoWIwl/P5qDnSYf1wEJmJq6wdnAhKecB7GqzTVknQz3f+JV9VS2pv5AaaWiH
 XbyASKQIgKpIU/+MUeUmAk8+JuEvEZ6ItQRQLn15cb80Vz0RqBSK5lA3Zgqy6qbnF981WtfnZ
 mbu1sEqsVVPNp+LaZZsdN4FPO+AwgGyY/wt+HPjfjlljd3AbeS9ZyJfmA4i4wz5DHk38Agng7
 E8C2XBKQaHJznEekWQRgDqDN7PcZ13ek0koH8LB0sEpIZFpkR95HPY0ZTOS7WjH2JPGZgBbTy
 HgoQP4o+v/GMAlv06xYiERdFdscyNvcIYs7+kSiUR8YC7qqzDo5ATQh3/b4j1nVuucqDmzTYN
 ifcsw/lKt9GEhb598oSARwns/bE33m02QHc0jmxIO0SXWpDsDNjtTqDvC6fytua5TKxVFXpwD
 HvZPcZ7ZJQl5zV9IK+jYN78Q==



=E5=9C=A8 2024/9/25 20:20, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Some fixes around delayed refs and qgroups after the conversion of a
> red black tree to xarray in this merge window, and some improvements
> and cleanups. Details in the changelogs.
>
> Filipe Manana (8):
>    btrfs: fix missing error handling when adding delayed ref with qgroup=
s enabled
>    btrfs: use sector numbers as keys for the dirty extents xarray

I'd prefer an error out other than continuing if the record->bytenr goes
beyond MAX_LFS_FILESIZE to be extra safe on 32bit systems.

Otherwise the remaining patches look good to me.

Thanks for the cleanup, especially since the convert to xarray
introduces extra xa_lock for us, it means we do not need to re-use the
delayed refs lock.

Thanks,
Qu

>    btrfs: end assignment with semicolon at btrfs_qgroup_extent event cla=
ss
>    btrfs: qgroups: remove bytenr field from struct btrfs_qgroup_extent_r=
ecord
>    btrfs: store fs_info in a local variable at btrfs_qgroup_trace_extent=
_post()
>    btrfs: remove unnecessary delayed refs locking at btrfs_qgroup_trace_=
extent()
>    btrfs: always use delayed_refs local variable at btrfs_qgroup_trace_e=
xtent()
>    btrfs: remove pointless initialization at btrfs_qgroup_trace_extent()
>
>   fs/btrfs/delayed-ref.c       | 59 ++++++++++++++++++++++++++----------
>   fs/btrfs/delayed-ref.h       | 10 +++++-
>   fs/btrfs/qgroup.c            | 58 +++++++++++++++++------------------
>   fs/btrfs/qgroup.h            | 13 ++++++--
>   include/trace/events/btrfs.h | 17 ++++++-----
>   5 files changed, 101 insertions(+), 56 deletions(-)
>


