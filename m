Return-Path: <linux-btrfs+bounces-4508-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A928B0284
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 08:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A363C1F239B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 06:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEDB157A7C;
	Wed, 24 Apr 2024 06:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HvvsaSox"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEE8157E99
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 06:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941610; cv=none; b=fLSqcRmNZBz0zufP91oRLdWqKh2tSVBrHKTYlAFCrXUVWhERfW93/rR7udIRhT+je4hPeFrSzIp1L69G0UND2YmSiXEdc07htoRw4vwBQwkfZ0LndKaDY35lLDB3nEgzRAMKmWUUZydHdE1nk5GeBgK2YPTwi3/L7Fnm+4WZdJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941610; c=relaxed/simple;
	bh=fqPdzWezZ5Ga1pxH96/3xF3ZATOEjK6iP2ki4/L+0TU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VGAvAIfOWfApJIXOF9Uhyz6RnfjI3whz3RcfPsPdNvN+E1XYUas7aU/0i03yP9nzTSUD6B1+PghQLNmx1FaFDi73CF0cAIg39LfhhA4T9PC0z2vaQX/jzIDCYuhSdrlI38sBCwUMHATCtGf8hdzwT74wt6XFRmdxHkRIV8wzP5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=HvvsaSox; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1713941604; x=1714546404; i=quwenruo.btrfs@gmx.com;
	bh=WhBx5diqDBaQESQeQipVFVjT0ZHgPhB0bLWaxt3qJMU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HvvsaSoxu8wPKlj6H1gF6mR49zdxVjKLjzs7oGTX1PK+0/PoYs0ISWWVf2V/jdo2
	 81b07Ob5Dyzlm5SuobsoGl7iYm9Pt/GU1rF7d4cX3Be55eXaYvAmqTlF8xaE4FF50
	 Td8zzOi9+imYRm4jeVI8A88rqkeZkGafFf439J4JCAuVvyiV0knToI5rO/akuqZR7
	 xiIGX7zR2i4zIdUtNgff/jH7cn1puTzyBGc9mhvZdIH2gAiToXr9ZARXqlPIxP64M
	 rNgbUTywLt5L3/f4v25VCp8gYPoaNqyXGkKKWYoYMYJIRKjMORWPE/Y2uc3+h+wHN
	 XKrC2rGIKmGaemae8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9Wuk-1s52Hv1nYS-005Sj1; Wed, 24
 Apr 2024 08:53:24 +0200
Message-ID: <c15981d9-c37e-4b14-bc17-5f3b2f5a69e9@gmx.com>
Date: Wed, 24 Apr 2024 16:23:19 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: drop unused argument of calcu_metadata_size()
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <ff912bc5410aeb9f71a5b7ef5fd9376065dfeaf0.1713940243.git.naohiro.aota@wdc.com>
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
In-Reply-To: <ff912bc5410aeb9f71a5b7ef5fd9376065dfeaf0.1713940243.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XqQf8ql1d52j2bRApJX98eyu1WehnOjt7aAV4GPMgGr5tRHlDuL
 ZunKRLWH3brTldMcfT0B5MSgHtxVD6ABIqQsnnUqB2/fsLwwIz+l/kHULAAPfWIuWwMYrdW
 7MyAM7FNtSMpc6dnEUhPIA9RfkXl1IEALgXFmKkOqDXzc7Ba9GPnV1BMxKBNKAc/NqRXGvO
 6s1UxRdJk/A1LkhG12vMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cOch2ez6hRU=;tZ2YQmuRSdoRcqinoQWl/22onKT
 GA6408vuY08fGY88jC21AkMA54E++aS+GRWnCBcSe1GYnOTBe1VfvHfhgZ144SBlzY4s7q2n/
 UKViEWcYloX24zri9nEC6N8ZPin6idT8kpiI3OMALNMeK8KlezbUEV+tww9XNlZAl2Wbzc62+
 YXmjqG76EbayehTsl4EegNv3GdXCnuE3EpSSEDs0dUPKqFXnI1XW/ksDaeBUiF8a6GOEnFFYv
 /u6L6ItA7o48Yg3ALnA1Zb2IxhaXsdX9zEg6gMIDNCQDl4vEg9u+pDlYNRg/ALfGYfV+utPVV
 h5OFibi69nxBLhqBuuh+RB3+GhY2bhSHEk6TRbCPnvyzL6E/biQDq98zMc4aVzfvR18rnT2kj
 j1UFZ1GeiimiiCGFQ/9bzzdJtnzlhetjuNm5s8cD6aQGQG2ZBqLn0SwOexA02DSq3NwPC3ZP2
 EtIl7/krg/yACYqFTp3UPyMVPXVKSKU3FdI4Cn4H9du/2+2WsJnPxU4p4DOgMM7nesWYL7MT6
 8pAd12pqhzd+IDKg10znGbh3afREWXiF9I4LYWa2Md9GLnJF0drNObapNiEiCfPSiK7qOGwj0
 RJVCsJop8G5ue0iSMZkiDCzdThkIEBHneEKxNu8qC9CCLbZlzpI+8dqZJwx22tKItb8WMkfIw
 Qim3VIDzAaTfE0gifjZWJw/3Hlsll25KLnHbPtSqKZ+dcw4WZellm+1DkUBz+pWTC8FJfLtb2
 x8dGIXv9MAbNVGkT8/UAy4jnKUBbbXm/GoZO5PGr8EzU0Z6QtqfssYXOspSO8kbMcqHzMkEvp
 vBH8nICxdDMBmqgPPZNXKlCmA4Uk9+X9XJfoCOuvAQGhM=



=E5=9C=A8 2024/4/24 16:08, Naohiro Aota =E5=86=99=E9=81=93:
> calcu_metadata_size() has a "reserve" argument, but the only caller alwa=
ys
> set it to "1". The other usage (reserve =3D 0) is dropped by a commit
> 0647bf564f1e ("Btrfs: improve forever loop when doing balance relocation=
"),
> which is more than 10 years ago. Drop the argument and simplify the code=
.
>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/relocation.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index bd573a0ec270..22086e840801 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2281,8 +2281,7 @@ struct btrfs_root *select_one_root(struct btrfs_ba=
ckref_node *node)
>   }
>
>   static noinline_for_stack
> -u64 calcu_metadata_size(struct reloc_control *rc,
> -			struct btrfs_backref_node *node, int reserve)
> +u64 calcu_metadata_size(struct reloc_control *rc, struct btrfs_backref_=
node *node)
>   {
>   	struct btrfs_fs_info *fs_info =3D rc->extent_root->fs_info;
>   	struct btrfs_backref_node *next =3D node;
> @@ -2291,12 +2290,12 @@ u64 calcu_metadata_size(struct reloc_control *rc=
,
>   	u64 num_bytes =3D 0;
>   	int index =3D 0;
>
> -	BUG_ON(reserve && node->processed);
> +	BUG_ON(node->processed);
>
>   	while (next) {
>   		cond_resched();
>   		while (1) {
> -			if (next->processed && (reserve || next !=3D node))
> +			if (next->processed)
>   				break;
>
>   			num_bytes +=3D fs_info->nodesize;
> @@ -2324,7 +2323,7 @@ static int reserve_metadata_space(struct btrfs_tra=
ns_handle *trans,
>   	int ret;
>   	u64 tmp;
>
> -	num_bytes =3D calcu_metadata_size(rc, node, 1) * 2;
> +	num_bytes =3D calcu_metadata_size(rc, node) * 2;
>
>   	trans->block_rsv =3D rc->block_rsv;
>   	rc->reserved_bytes +=3D num_bytes;

