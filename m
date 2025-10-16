Return-Path: <linux-btrfs+bounces-17869-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBF0BE1AED
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 08:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D26819C71C8
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 06:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC452D3A94;
	Thu, 16 Oct 2025 06:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="KF48PYRs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592572D2389;
	Thu, 16 Oct 2025 06:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760595478; cv=none; b=MmYVwmYDoHAJ1oV1TV0BpPIrBG9R0sda01Tln5ytKl43E1dvW3Hkl6Va8MaFRR24uoAJHzVybhkhlrGE/CcrbxmpfbZQQpE1UXgmUVW1GImK3RVtK+jI8IgqP9JDrxkWGAJYlAkWi0weWdaISvmjA3Y+/oUyN4TlMVDsz4xBjfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760595478; c=relaxed/simple;
	bh=DQnDRzpgb1p6tcOhDewZOz+VtGP6+JfXmW7wlbdTUIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPbZpnGDNy/SHjHR3xdUmnd15oBZo8pLbDHo47gJE4E6tFNsZR4eLPm3ljXWT7tbJJ5PJoBYEib6L++roySUy31rGioofqgLcc453fZVX6rWA4vt+XqXQiFw5ODihm3j0jVZOBy2GYIlwAXgToIsljUE1UCwCIWP8whu8TD8ZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=KF48PYRs; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760595466; x=1761200266; i=quwenruo.btrfs@gmx.com;
	bh=S3XASd9XbXvrZPGza4Jw1o33TfECgSSTlBsNziyLLao=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KF48PYRs80Mak8KH5zZIcsmCP2INkZNiMkSPRUAN0hfjU7wkyo7mT1hV8oGfhZDm
	 5ZhHqdLzjrQxjfScYyVs+LWMaPzA25oY2d3Et02TF7ZPCSupyZlRxKWixWhU9oWAV
	 UK+KPzCLAey43I5vTOks6eTl1pDF1EKwCOB5Enunc9+xmBR99EzvUCo/zW8C3KPlm
	 oTcubevkU/KRGsyvRYFvidE3PZUYtPDZYd7cZogBp1a24BWLV/ZiN+fkpeK0LjJZo
	 Xez+YTLbm8Kgltj48WYt5Dx3jG1JfGcx3cEHPEYLLPHPHZNZ5d5mmJeaFPKdoFSoP
	 51KsiXguVIcbKxYoXw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ma24y-1ufhFN34Uu-00V6fQ; Thu, 16
 Oct 2025 08:17:46 +0200
Message-ID: <f5c6f862-2d57-459c-a7c9-ca37ab44ee99@gmx.com>
Date: Thu, 16 Oct 2025 16:47:41 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: Fix NULL pointer access in
 btrfs_check_leaked_roots()
To: Dewei Meng <mengdewei@cqsoftware.com.cn>, clm@fb.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Vacek <neelx@suse.com>
References: <20251016061011.22946-1-mengdewei@cqsoftware.com.cn>
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
In-Reply-To: <20251016061011.22946-1-mengdewei@cqsoftware.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dvvN5us4l40s6qICZmgfe77a+bFZasazrgk6SPaZSAiuBmaxU65
 CH90aODGPx/gbLQSo3YTO2TvobjlVZU3CY9VGDwbMHEdhEwRkhVFsBHASqDL6iI2C2kTb7d
 XyiVKuSOvdyHABZ0NxbEwuRgwRMXHd5GSCUn9z2McWLyC1RJakzrzCFdLhxvbJZDyIrvVK6
 lRzlQCPcprLRjbMqvwrug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k140YuW0dog=;14pUdG1G1ggC8WeuTbDhsl/pyLo
 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
 eXV5A==



=E5=9C=A8 2025/10/16 16:40, Dewei Meng =E5=86=99=E9=81=93:
> If fs_info->super_copy or fs_info->super_for_commit allocated failed in
> btrfs_get_tree_subvol(), then no need to call btrfs_free_fs_info().
> Otherwise btrfs_check_leaked_roots() would access NULL pointer because
> fs_info->allocated_roots had not been initialised.
>=20
> syzkaller reported the following information:
>    ------------[ cut here ]------------
>    BUG: unable to handle page fault for address: fffffffffffffbb0
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    PGD 64c9067 P4D 64c9067 PUD 64cb067 PMD 0
>    Oops: Oops: 0000 [#1] SMP KASAN PTI
>    CPU: 0 UID: 0 PID: 1402 Comm: syz.1.35 Not tainted 6.15.8 #4 PREEMPT(=
lazy)
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), (...)
>    RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
>    RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arch-fallback.h=
:457 [inline]
>    RIP: 0010:atomic_read include/linux/atomic/atomic-instrumented.h:33 [=
inline]
>    RIP: 0010:refcount_read include/linux/refcount.h:170 [inline]
>    RIP: 0010:btrfs_check_leaked_roots+0x18f/0x2c0 fs/btrfs/disk-io.c:123=
0
>    [...]
>    Call Trace:
>     <TASK>
>     btrfs_free_fs_info+0x310/0x410 fs/btrfs/disk-io.c:1280
>     btrfs_get_tree_subvol+0x592/0x6b0 fs/btrfs/super.c:2029
>     btrfs_get_tree+0x63/0x80 fs/btrfs/super.c:2097
>     vfs_get_tree+0x98/0x320 fs/super.c:1759
>     do_new_mount+0x357/0x660 fs/namespace.c:3899
>     path_mount+0x716/0x19c0 fs/namespace.c:4226
>     do_mount fs/namespace.c:4239 [inline]
>     __do_sys_mount fs/namespace.c:4450 [inline]
>     __se_sys_mount fs/namespace.c:4427 [inline]
>     __x64_sys_mount+0x28c/0x310 fs/namespace.c:4427
>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>     do_syscall_64+0x92/0x180 arch/x86/entry/syscall_64.c:94
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    RIP: 0033:0x7f032eaffa8d
>    [...]
>=20
> Fixes: 3bb17a25bcb0 ("btrfs: add get_tree callback for new mount API")
> Signed-off-by: Dewei Meng <mengdewei@cqsoftware.com.cn>
> Reviewed-by: Daniel Vacek <neelx@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
> V1 -> V2:
> - Revise the patch description to make it easier to read
> - Delete btrfs_free_fs_info() when super_copy/super_for_commit allocated
>    failed, instead of NULL pointer check in btrfs_check_leaked_roots()
>=20
>   fs/btrfs/super.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index d6e496436539..dc95e697b22b 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2069,7 +2069,9 @@ static int btrfs_get_tree_subvol(struct fs_context=
 *fc)
>   	fs_info->super_copy =3D kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
>   	fs_info->super_for_commit =3D kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERN=
EL);
>   	if (!fs_info->super_copy || !fs_info->super_for_commit) {
> -		btrfs_free_fs_info(fs_info);
> +		kfree(fs_info->super_copy);
> +		kfree(fs_info->super_for_commit);
> +		kvfree(fs_info);
>   		return -ENOMEM;
>   	}
>   	btrfs_init_fs_info(fs_info);


