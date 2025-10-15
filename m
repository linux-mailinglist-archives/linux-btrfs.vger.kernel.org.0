Return-Path: <linux-btrfs+bounces-17822-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F165BDD602
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 10:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14B3B3548C2
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 08:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989622DA77E;
	Wed, 15 Oct 2025 08:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hDdelv8a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A75226560B;
	Wed, 15 Oct 2025 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760516686; cv=none; b=OvZNrCIyG5fZ+aKh8iOyN36K25Qfj9PrRweunN+BGixsf8o/jP8kbMAnKMRYAzKFxn42zjbIjDqClsOoQvuFP8InllH84kPPEJ3hS+hF/WOL5yxdNGEMoBEt/Uqia5RLLGD73xHxZQ0vAGv0R+AzuR70WmP2MbM2QbyjRs6yVrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760516686; c=relaxed/simple;
	bh=bQJpVEk4KCrZbNIOqXxi51sswfZpBI3gJ+crdgjYRqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJaldzEE0u7TvSUbs761wSc6T6q14HMhJPueHk1cJNAQyGOKHLxeL6X9AsqtPaVK+8XHBGKVuNIhVdrd8HXPUqjHnIou1MZDJzO3DlHcFjnHTahjIHkG23Ytxw8lEoQ8XGE4xhvhVAuobkrdMJSksrPb2i+A+SC3cz3T1khAymk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hDdelv8a; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760516682; x=1761121482; i=quwenruo.btrfs@gmx.com;
	bh=ypwe6tBiFLjxqugj9jMa2jtQyG7DwjzKSzfY044RtWM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hDdelv8aZxDGt71IQciXUOvHxPZdeZM0veogb9EiL7DfHFCRDQD9rfhm8P/eB8ho
	 cxVGdcBsE9z/1mppcVX5RY9q1yjPae0IVY+RNzEoaSXa7xwQ5TupBOp2ZXH4+0vU/
	 HsPD8uK76/dGWCzbGJWy9PkXevCnJeit5JLYTq/LkpUzrjjqjXYuc6dxcgy2SXTMi
	 uH7bFisjnGT3DWzw7d3BEqVlgeP6+iu2JlKOYwCdSZ5Zm2lWcUR6UN3GR0te4gMnh
	 HoxZFpK1/aSSYkOczU99CfobIxrQMcNRnV2nGzOC3gRuFbKuLgoCY20ic3QGuSW6B
	 7UsW2jRM8q6ql4J3Kw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mnaof-1uPklw3bD3-00gPc9; Wed, 15
 Oct 2025 10:24:42 +0200
Message-ID: <6a2bb5c7-0aab-4662-938f-38b8e2372338@gmx.com>
Date: Wed, 15 Oct 2025 18:54:37 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Fix NULL pointer access in
 btrfs_check_leaked_roots()
To: Dewei Meng <mengdewei@cqsoftware.com.cn>, clm@fb.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 josef@toxicpanda.com
References: <20251015072421.4538-1-mengdewei@cqsoftware.com.cn>
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
In-Reply-To: <20251015072421.4538-1-mengdewei@cqsoftware.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i/6q6wRyFymjf90Cr0S3snjo0NAzmT3mrKlNXKqYK6txgCHRDIR
 SzGnbMAAQdq6VJzCyTfViWB5hhuZYUAwtDCB0gNox/KjqB9geq/HvnmgKVpQxXnYBNi+cKD
 VRc7S7syW+WBj5EWDrgsLAEkJIAWPe7VZHLkc/sp6Fw5itN68qcWcHlHPs5yo/1+AqiOVRO
 EkiFm4ngUUgFIE1aGrMcQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y4g1hFTslyE=;OqvOh4gblmIlARYpqPET1DlHO/7
 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
 N2uzg==



=E5=9C=A8 2025/10/15 17:54, Dewei Meng =E5=86=99=E9=81=93:
> If fs_info->super_copy or fs_info->super_for_commit is NULL in
> btrfs_get_tree_subvol(),

Please reorganize this sentence. It would be way more easier to read by=20
just saying something like "If memory allocation failed for=20
fs_info->super_copy or fs_info->super_for_commit in=20
btrfs_get_tree_subvol()".

> the btrfs_check_leaked_roots() will get the
> btrfs_root list entry using the fs_info->allocated_roots->next
> which is NULL.
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
> This should check if the fs_info->allocated_roots->next is NULL before
> accessing it.
>=20
> Fixes: 3bb17a25bcb0 ("btrfs: add get_tree callback for new mount API")
> Signed-off-by: Dewei Meng <mengdewei@cqsoftware.com.cn>
> ---
>   fs/btrfs/disk-io.c | 3 +++
>   1 file changed, 3 insertions(+)
>=20
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 0aa7e5d1b05f..76db7f98187a 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1213,6 +1213,9 @@ void btrfs_check_leaked_roots(const struct btrfs_f=
s_info *fs_info)
>   #ifdef CONFIG_BTRFS_DEBUG
>   	struct btrfs_root *root;
>  =20
> +	if (!fs_info->allocated_roots.next)
> +		return;
> +

The check looks too adhoc to me.

It would be much easier to just call kvfree() in the error handling of=20
super_copy/super_for_commit allocation, we do not and should not call=20
btrfs_free_fs_info() before calling btrfs_init_fs_info().

Thanks,
Qu
>   	while (!list_empty(&fs_info->allocated_roots)) {
>   		char buf[BTRFS_ROOT_NAME_BUF_LEN];
>  =20


