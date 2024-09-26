Return-Path: <linux-btrfs+bounces-8251-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867059870D0
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 11:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98BF1C250B3
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 09:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B281AC439;
	Thu, 26 Sep 2024 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="f86W+LA6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C032745C
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344568; cv=none; b=Gj4CoTtZq0y73lraL6IGkHlzRImOHlUlZ9dxydCueEIiBHt0gYu/Q/lSa9MnLhiCYr61rc1XQvROqAMOPDP8UqOoF4Qz4IDawBiP1KhpitsgBv+fpF4M1fnK0/94BPHdQf9K2uuXohnxJhD5+k5G3iVFHywAdE0nn7QRJQ4HeAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344568; c=relaxed/simple;
	bh=gtg690KL40fsb0MIZISjukdi7JOr9LKPEsXxYp6FPbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PrxJk+HTQGA4yigfDZ0JcvJxU3kVwYUXupXGiiMkpgWdTSfYhC9HqVLSDJCi/Fi9wBL0ReXCKSkWkraax1noAiJNw5Fzfk0GopAzVZobRAajM+5e6kIzSH6guCzxN59h8U4lUFNMTS+fL/hmkMP7B0AaV4zmnparyaK8p0BbrXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=f86W+LA6; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727344559; x=1727949359; i=quwenruo.btrfs@gmx.com;
	bh=Zk90ag8D9ZCMOFGfTUWK9zz/x6aC/8aG8capRlgyK/s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=f86W+LA6q3PgBDhjdjeMj/EXFVSUhLaOxPoPdztJh14HvStTI3Uyr2SHPgwE5wqJ
	 IOv+1PNTW9Ao/8LvgMzSeP7SfWzXObVks5uz0MgTPaQ9FvgHZ69QabUyy2skzSKW3
	 3kXF9riLkugdFfPxBiqG5rxSCfk7KEcslB7o9GlpJ/iRukpqZkJWDCX2/nRBztWg2
	 xeQehDxF9sQ0ZgNOySBQrY/FeCHwS62OGQEcCmiDYKJ3ilL+h0pMqwMqLonh0lai9
	 nSQp+SsBHdsvLMz83NalQNz+Qm5Nj/YeF2NWpQLhQp6odlEH1qsj4krsEFz1qxqFf
	 fbJlkudmoQmcZ8Z4gw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4hvb-1rtVHs04WN-014BD4; Thu, 26
 Sep 2024 11:55:59 +0200
Message-ID: <ee7effa3-1cab-4607-a717-3df56ed091d6@gmx.com>
Date: Thu, 26 Sep 2024 19:25:56 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] btrfs: delayed refs and qgroups, fixes, cleanups,
 improvements
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1727261112.git.fdmanana@suse.com>
 <cover.1727342969.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1727342969.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wezxq0AKxL9bgSvPx3Iafk/+e6CgGddhZfCpkUbi9XmL7FVNDBk
 aTOW3d8PxJYfNsmGqcx8s3McOdYzBmXJLgpiy1qbewDYeIhJD5w3tlfTPbZER8nzs9GlW4d
 rPLYC5qQHQNAPHpErry820IEx0zU+ThLWot6UUkLOPZIhWII+dIoV3JWSgwUsjGaM8tJ5Uf
 hNEBQhXSFglA6S6NjEsiQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cjp0UFxiVXY=;sXnbD1VXG0l+c169To53cP/E0dX
 b7Aix0uD6gDDm6gHlHeLCfJ2Q8SRTAIvQ3dMRsykKmLJhxaPe0QPPeFNXXpAcv17yIq/f+Uam
 tsvxwuG2fCjQJBmtlbuvujnurGukqwgdoe4BDjMZhqrUD1hhnRfPze9JzbM311Xw5s8/i09+s
 ZDPw//5yJPeIFnFe4be3LpAZpGyo9fqBs/mggBACPPgD3gs1cuvup5EsYAcp584ygERlYKaBX
 KJKoV0Ch9QWnEs6YlA++PB/CAHZP3Lf6Q0MxdZFyBJD2EO63akHc9flb5AQxtpLh5HEJuaQhG
 cobyXRLN6GP0bAJBVyB0Ex7ZwX8kFYp0GS2CKnZOoGiDFm3StnRC6FKVxi9KB+9qYFXh+8FTK
 9n7IdlV4SRrpkaBsFwL06m+5Ooqx0f4BoikWXGqZBQf5KWUuUHF9ZyTiZul1B/R4NVVl6uBtM
 dKYQBukFnlw9fEnoibRm2Lb5thKny6bP7A2q9c8GgHPLzkXjH9kY/01zp8tEXtG14g5ahhcOa
 LuUredGmlzKP/swaThcs7PvOAk/+cJp7KMZQOuE6bMzzQNkB/LNCRSIE7zWyq5z3BQiyNF8z7
 fGwZ9vXr+n5K1f6efX7L+RD9ut5aR5DMcBrIjp95DJyH59Tz7aGZimTkeMqDuyd0QXIRXwZvS
 PeE0GPvz9aebPCwe/8N/0vyJh1KVAx2lrCkDNG7cYuFdNuwXETKkyo5emKkJS4gpZowEh6kwc
 TXK036DH7rw0rJ16fAq8jBE3iMcdwxbEqRgxGuPRI4Zo/76nQ32eDHAohwv1SvQ7GoDo6DmdX
 k7gJqCkpK3azoDd7C9bXTjfg==



=E5=9C=A8 2024/9/26 19:03, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Some fixes around delayed refs and qgroups after the conversion of a
> red black tree to xarray in this merge window, and some improvements
> and cleanups. Details in the changelogs.
>
> V2: Updated patch 2/8 to check for MAX_LFS_FILESIZE and error out.
>
> Filipe Manana (8):
>    btrfs: fix missing error handling when adding delayed ref with qgroup=
s enabled
>    btrfs: use sector numbers as keys for the dirty extents xarray
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

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>
>   fs/btrfs/delayed-ref.c       | 59 ++++++++++++++++++++++---------
>   fs/btrfs/delayed-ref.h       | 10 +++++-
>   fs/btrfs/qgroup.c            | 68 +++++++++++++++++++++---------------
>   fs/btrfs/qgroup.h            | 13 +++++--
>   include/trace/events/btrfs.h | 17 +++++----
>   5 files changed, 111 insertions(+), 56 deletions(-)
>


