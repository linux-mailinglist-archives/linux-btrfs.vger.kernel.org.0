Return-Path: <linux-btrfs+bounces-9976-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE1F9DECBD
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2024 21:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FAB8163F8D
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2024 20:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C40419DF47;
	Fri, 29 Nov 2024 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gdGe8OAL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6725F44C77
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2024 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732912767; cv=none; b=mTH8hnmrT1MXh2bdla5Zh1wlu5yy3a3tk99wPtyp4vEzKg0pH6P88z9wd1uXLEkGCZz4xJo88OUwofkJkc3O5d6/6OkTNqpIoY2ageJw10HMEr7xgEff94ZbAPKQ0B4eYrNgdS5FhzweaA64iw4KTNpoydiRZSJZGiIL5Y8CPac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732912767; c=relaxed/simple;
	bh=/G398bZ7HnU8StpZaAekiKQV4qcN/hc6t0WriCUAU+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A4P8m6J+sIdo4vmAeWVv41/zda9TH8vJlEcxyxtg/ChXAljc9BcSBf6n9Hhy/JfbpEgfXmX/IFmlC0TSvr0Vlb+8un0WuqjBPv9lEhFB2hfwy6lv4NMdiaZDTe/Ws5MzmkMuUQnhxxLCL2oILlPDRONilhEg9Ejk6hzlcUddno0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gdGe8OAL; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1732912759; x=1733517559; i=quwenruo.btrfs@gmx.com;
	bh=D8E8DyF/OS/zSIme0Cj4owS/B3DD1vfYAFI9SimNz6w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gdGe8OAL8GSipnZUubxvii2ZVrKMe7bra+lo9e+QLdtQCW06nHWfpedNb7KwY4SX
	 IUONzMueROW4ewTX4SZ2Vl2V1AcFGhS4Jjv6MdVZfFSq/3wxdtOJ44+DFcvxnfUoZ
	 Z8jWKmlwYVlrIiEfpQMx0yTcy/Fz9Si4+NASnMRSU7otMVtl+gY2ODhB56rDwIf75
	 BS7dlogBUShaZnLEGogYq5IMHT6ERsQnvbaFVlwK4zVzSN0qebnlt9XsLjrUU1OFJ
	 fePYXkJseX6fqMOqOPHFDa4vGk7nk/mlxfayAMYJ3L7GpzfjjqFxwv3SiyjPb3IzU
	 x2FPY0d6yMo6//5row==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McYCb-1tpdm72tmX-00ifxW; Fri, 29
 Nov 2024 21:39:19 +0100
Message-ID: <f84f7da0-4fc1-4549-8231-8462ae6dc2b3@gmx.com>
Date: Sat, 30 Nov 2024 07:09:16 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix missing snapshot drew unlock when root is dead
 during swap activation
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <76ef43063706a4ef1a4313ba03ca6225e7d7dbac.1732887615.git.fdmanana@suse.com>
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
In-Reply-To: <76ef43063706a4ef1a4313ba03ca6225e7d7dbac.1732887615.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cIJqUe9qWeF/ttkLAmtQcjdj45u2TRtSgNAiZ0TgS6yIzbMJLAK
 ++4Cd2+JO0rw7o+sC98tNVz2OBwPgJYjKvCV8sTCLTL0Q89gHpzimttQxMfcZn5fyoVpF6p
 2qCfWaNIyqtHPMl8G1t0oHCLAfWXzAodjDQaYL3RVZ0/rvglPQZ1bCHQaM+VOymrJL1mJZq
 ILw8uus3YZoGS0t46HBmg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BNt5cMNl35k=;NbAZ56j+KMlJmGQJv5tXuo8SouB
 zmzq5iOlICx0AX3HgH1nVCwMS/ppxadHDmpshGWwxOzw2DGnYE/tyL6CQSmHNIvhWVOG33umb
 zIj3NlAOYpv4dneuVV3xegQd02Do3F/5yK8BxUojH5FxmvS36lGUO32dSgVZh/bioPquA8bwy
 imZQ+949HmFkaUFiG1JSr7rdGYIKsVZkOrQJtvCnTJw+qsDZA+oi2lKboE9N1TG2DAkLLahvX
 8eGlvWMZq8FHmtepbpyrXC398xeu7WrPcuiU+HpegkpCvvfthmBHG2kVrg8x3txs1snYeC7DL
 h3aZr/8mwlSxV8AIhRaLeCvpC3xbgVOxg7dQ4Y1/0y09l9XHqSN/VB74yVow7NYTmcCH6Y6TY
 FWiXiSHn+TaqJWxqgoktjO08+FAayVeK8o8dYzvqnmkHOoLcpwIeMSK9BUYKXic4/InsOk5w0
 PmZ/WVv9cuL0DcRlByAnXUNXSTRjcqWHCAlmj4SVv3VcP1X2FO6/XHAx2JyDtju5TLLtlDo6C
 D/0An1EkkSXrrvePE8kayLTKtC9RVMONLlljMUdiyQwZemf8wed9CgCcy+ggrH1EIlHRb+bRm
 H0WGTfv0+f6kBZvGo+o4AsUv4qA0RzWmgVoYxohGwo++igiFcHeTvIKPD7B6vQlNhUAnpA7JS
 BzrwWJpAE5zqYlgeAz4pHkdMXNDJWFSDhwJBd+AyG4q0k8O4xFRgV6HqXahYtYeW8VRpEHIu4
 fTafDxOJijNNd2oYQW7xqNZtI3omMm4dAWTaQh6n8oD8l2q3GpWkhMubKvy3lgXNU8GVYYLBn
 c/eM5Oc9YhQjql73FsTE1dc+hh1KoIUL/sAL9yLMbTaJ+eEvgdYtxTO9dzw3O+1T4ly0k5cmx
 PAAYOq6NBdNGI70TjwxNNFPLsY2a0gSt1IHsnG2mhzowJU1ZI3sIXJ3ISasGVzWBwopRYJGyG
 ZouhCF5tQaBAHZH9dx0kET22zTY0mFScQK9vfLT1SXpKqAfyWy0ngi6bipFZkpZq66fMsRwfB
 XR+xOJOsw8YvQ3sdNhmdcGU+T1ZDWszEW47yGGbPwtvV4U22D3Qe07jKuPvtYoLXVvxM+XY5i
 h+rLDTJlojiA7EhEwWD6INFomUgDst



=E5=9C=A8 2024/11/30 00:11, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> When activating a swap file we acquire the root's snapshot drew lock and
> then check if the root is dead, failing and returning with -EPERM if it'=
s
> dead but without unlocking the root's snapshot lock. Fix this by adding
> the missing unlock.
>
> Fixes: 60021bd754c6 ("btrfs: prevent subvol with swapfile from being del=
eted")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/inode.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 9267861f8ab0..6baa0269a85b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9876,6 +9876,7 @@ static int btrfs_swap_activate(struct swap_info_st=
ruct *sis, struct file *file,
>   	if (btrfs_root_dead(root)) {
>   		spin_unlock(&root->root_item_lock);
>
> +		btrfs_drew_write_unlock(&root->snapshot_lock);
>   		btrfs_exclop_finish(fs_info);
>   		btrfs_warn(fs_info,
>   		"cannot activate swapfile because subvolume %llu is being deleted",


