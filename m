Return-Path: <linux-btrfs+bounces-15569-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDCDB0AD02
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Jul 2025 02:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBA11C43B33
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Jul 2025 00:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7916743147;
	Sat, 19 Jul 2025 00:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="qCp/WSl3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D17F442C
	for <linux-btrfs@vger.kernel.org>; Sat, 19 Jul 2025 00:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752886021; cv=none; b=RpISwDojquiz1o5gbIXKSN/xLnKwpuaqSdoNO/XDVeamq25geb3LFBAlpONQDDNUvB/4RKJI+27cJdFSVA1MXQqjk6mSFX5VMqu7VRwxF6JQpLd4EZ2AgwIXJwmBC0NJ5937vpmtrX5x2E7rKZBBEI0sV4TMWmdVqAjpzcl5t00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752886021; c=relaxed/simple;
	bh=z53SF2ckyBiNxso9B3m/2qcehjxTdNlFWWO3+KJVyeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hx8nFjl+/yYlz1li3tFzRZoSJe0MrT8M5/VFdLr6PjWxXcbA2wtg//tfemLPJ2hTFaR+L1gLTRaTp/2EeFFc/xcwXb0HdFsM/Rx5/nk+Yn1iitcbnGyzwmPxjVlqLqk5+8YJv0B/PYyBYap7g5AUWR+b0wb/dCzvMnk4aDg5ktw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=qCp/WSl3; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752885988; x=1753490788; i=quwenruo.btrfs@gmx.com;
	bh=V49jE+fr05pLPDNKKrFC0NAqfZvGvO1QI13IaYs2rIU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qCp/WSl3csL/OuasKvkokWI5lbNRCe1oLwKJJxBte/LTlMzkxEon5Rz2zxsSf1ED
	 hDg3zq1h18rUdBWqlEquZIzooguTMHFaF7jOQ8VwJki9FQOd3bN6R60jUB1bQ2ywK
	 H0dRsBxikxGyJ3qYmBhatvaESHNzYTpX+SKuolR7iQwc1jRtBIAoeEClEU5SfGuXj
	 SQTwck4bsIC2E04AVA9D/5frv3RbhzcUXeYYMmBtC7frAeU/1oflo6GK9H0z3/Oda
	 1VuDuVVfinTh1MhdfUEDBEJbnDhLnIi8V0ck321yus7ZzA5KMdpMO8o74/hxfgHq7
	 LNrdse08nC8Hx61izw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7sHy-1uXzm53T74-004MZB; Sat, 19
 Jul 2025 02:46:28 +0200
Message-ID: <c2609fa6-9e78-4530-8acd-07fd7652bf04@gmx.com>
Date: Sat, 19 Jul 2025 10:16:23 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: fix subpage deadlock
To: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <5df8399c15d9265fae8b069dc481ca077810a609.1752882493.git.loemra.dev@gmail.com>
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
In-Reply-To: <5df8399c15d9265fae8b069dc481ca077810a609.1752882493.git.loemra.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mYbxTY7O+zE2xHRHxiWmGRqQf80ve/EfawApPXB/mWrqSisG0fs
 RZ46nST+ejENoFLLTo8AVqpKRCmiGvT8mfkLIrAVmHcvy56stXhfvBlOQ7Vj53K7TETFLzG
 KpYmi+GqMj06ADs5kTUqLbv2+wJufTPtKZGiQIKgOzL+a+6FqgznTBLkhazrOkQ5vX2twFS
 tRn+O6YAR31CoKWCP7fXg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Wl8Z5tXLbc4=;phEMnZH/XSYJS9Fs0F/6QIjX2Xb
 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
 0xKAycR01MZ1F2/4ERMqJuWtnd



=E5=9C=A8 2025/7/19 09:26, Leo Martins =E5=86=99=E9=81=93:
> There is a potential deadlock that can happen in
> try_release_subpage_extent_buffer because the irq-safe
> xarray spin lock fs_info->buffer_tree is being
> acquired before the irq-unsafe eb->refs_lock.
>=20
> This leads to the potential race:
>=20
> ```
> // T1                                   // T2
> xa_lock_irq(&fs_info->buffer_tree)
>                                          spin_lock(&eb->refs_lock)
>                                          // interrupt
>                                          xa_lock_irq(&fs_info->buffer_tr=
ee)
> spin_lock(&eb->refs_lock)
> ```
>=20
> https://www.kernel.org/doc/Documentation/locking/lockdep-design.rst#:~:t=
ext=3DMulti%2Dlock%20dependency%20rules%3A
>=20
> I believe that the spin lock can safely be replaced by an rcu_read_lock.
> The xa_for_each loop does not need the spin lock as it's already
> internally protected by the rcu_read_lock. The extent buffer
> is also protected by the rcu_read_lock so it won't be freed before we
> take the eb->refs_lock.
>=20
> The rcu_read_lock is taken and released every iteration, just like the
> spin lock, which means we're not protected against concurrent
> insertions into the xarray. This is fine because we rely on folio->priva=
te
> to detect if there are any eb's remaining in the folio.
>=20
> There is already some precedence for this with find_extent_buffer_nolock=
,
> which loads an extent buffer from the xarray with only rcu_read_lock.
>=20
> lockdep warning:
>=20
>              =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>              WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
>              6.16.0-0_fbk701_debug_rc0_123_g4c06e63b9203 #1 Tainted: G  =
          E    N
>              -----------------------------------------------------
>              kswapd0/66 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
>              ffff000011ffd600 (&eb->refs_lock){+.+.}-{3:3}, at: try_rele=
ase_extent_buffer+0x18c/0x560
>=20
> and this task is already holding:
>              ffff0000c1d91b88 (&buffer_xa_class){-.-.}-{3:3}, at: try_re=
lease_extent_buffer+0x13c/0x560
>              which would create a new lock dependency:
>               (&buffer_xa_class){-.-.}-{3:3} -> (&eb->refs_lock){+.+.}-{=
3:3}
>=20
> but this new dependency connects a HARDIRQ-irq-safe lock:
>               (&buffer_xa_class){-.-.}-{3:3}
>=20
> ... which became HARDIRQ-irq-safe at:
>                lock_acquire+0x178/0x358
>                _raw_spin_lock_irqsave+0x60/0x88
>                buffer_tree_clear_mark+0xc4/0x160
>                end_bbio_meta_write+0x238/0x398
>                btrfs_bio_end_io+0x1f8/0x330
>                btrfs_orig_write_end_io+0x1c4/0x2c0
>                bio_endio+0x63c/0x678
>                blk_update_request+0x1c4/0xa00
>                blk_mq_end_request+0x54/0x88
>                virtblk_request_done+0x124/0x1d0
>                blk_mq_complete_request+0x84/0xa0
>                virtblk_done+0x130/0x238
>                vring_interrupt+0x130/0x288
>                __handle_irq_event_percpu+0x1e8/0x708
>                handle_irq_event+0x98/0x1b0
>                handle_fasteoi_irq+0x264/0x7c0
>                generic_handle_domain_irq+0xa4/0x108
>                gic_handle_irq+0x7c/0x1a0
>                do_interrupt_handler+0xe4/0x148
>                el1_interrupt+0x30/0x50
>                el1h_64_irq_handler+0x14/0x20
>                el1h_64_irq+0x6c/0x70
>                _raw_spin_unlock_irq+0x38/0x70
>                __run_timer_base+0xdc/0x5e0
>                run_timer_softirq+0xa0/0x138
>                handle_softirqs.llvm.13542289750107964195+0x32c/0xbd0
>                ____do_softirq.llvm.17674514681856217165+0x18/0x28
>                call_on_irq_stack+0x24/0x30
>                __irq_exit_rcu+0x164/0x430
>                irq_exit_rcu+0x18/0x88
>                el1_interrupt+0x34/0x50
>                el1h_64_irq_handler+0x14/0x20
>                el1h_64_irq+0x6c/0x70
>                arch_local_irq_enable+0x4/0x8
>                do_idle+0x1a0/0x3b8
>                cpu_startup_entry+0x60/0x80
>                rest_init+0x204/0x228
>                start_kernel+0x394/0x3f0
>                __primary_switched+0x8c/0x8958
>=20
> to a HARDIRQ-irq-unsafe lock:
>               (&eb->refs_lock){+.+.}-{3:3}
>=20
> ... which became HARDIRQ-irq-unsafe at:
>              ...
>                lock_acquire+0x178/0x358
>                _raw_spin_lock+0x4c/0x68
>                free_extent_buffer_stale+0x2c/0x170
>                btrfs_read_sys_array+0x1b0/0x338
>                open_ctree+0xeb0/0x1df8
>                btrfs_get_tree+0xb60/0x1110
>                vfs_get_tree+0x8c/0x250
>                fc_mount+0x20/0x98
>                btrfs_get_tree+0x4a4/0x1110
>                vfs_get_tree+0x8c/0x250
>                do_new_mount+0x1e0/0x6c0
>                path_mount+0x4ec/0xa58
>                __arm64_sys_mount+0x370/0x490
>                invoke_syscall+0x6c/0x208
>                el0_svc_common+0x14c/0x1b8
>                do_el0_svc+0x4c/0x60
>                el0_svc+0x4c/0x160
>                el0t_64_sync_handler+0x70/0x100
>                el0t_64_sync+0x168/0x170
>=20
> other info that might help us debug this:
>               Possible interrupt unsafe locking scenario:
>                     CPU0                    CPU1
>                     ----                    ----
>                lock(&eb->refs_lock);
>                                             local_irq_disable();
>                                             lock(&buffer_xa_class);
>                                             lock(&eb->refs_lock);
>                <Interrupt>
>                  lock(&buffer_xa_class);
>=20
>    *** DEADLOCK ***
>              2 locks held by kswapd0/66:
>               #0: ffff800085506e40 (fs_reclaim){+.+.}-{0:0}, at: balance=
_pgdat+0xe8/0xe50
>               #1: ffff0000c1d91b88 (&buffer_xa_class){-.-.}-{3:3}, at: t=
ry_release_extent_buffer+0x13c/0x560
>=20
> Fixes: 19d7f65f032f ("btrfs: convert the buffer_radix to an xarray")
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> ---
>   fs/btrfs/extent_io.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6192e1f58860..060e509cfb18 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>  =20
> +#include <linux/rcupdate.h>

Still the unnecessary header.

I guess you're using clangd and it adds the header automatically?

Otherwise looks good to me, with the extra comments from Boris addressed:

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>   #include <linux/bitops.h>
>   #include <linux/slab.h>
>   #include <linux/bio.h>
> @@ -4332,15 +4333,18 @@ static int try_release_subpage_extent_buffer(str=
uct folio *folio)
>   	unsigned long end =3D index + (PAGE_SIZE >> fs_info->nodesize_bits) -=
 1;
>   	int ret;
>  =20
> -	xa_lock_irq(&fs_info->buffer_tree);
> +	rcu_read_lock();
>   	xa_for_each_range(&fs_info->buffer_tree, index, eb, start, end) {
>   		/*
>   		 * The same as try_release_extent_buffer(), to ensure the eb
>   		 * won't disappear out from under us.
>   		 */
>   		spin_lock(&eb->refs_lock);
> +		rcu_read_unlock();
> +
>   		if (refcount_read(&eb->refs) !=3D 1 || extent_buffer_under_io(eb)) {
>   			spin_unlock(&eb->refs_lock);
> +			rcu_read_lock();
>   			continue;
>   		}
>  =20
> @@ -4359,11 +4363,10 @@ static int try_release_subpage_extent_buffer(str=
uct folio *folio)
>   		 * check the folio private at the end.  And
>   		 * release_extent_buffer() will release the refs_lock.
>   		 */
> -		xa_unlock_irq(&fs_info->buffer_tree);
>   		release_extent_buffer(eb);
> -		xa_lock_irq(&fs_info->buffer_tree);
> +		rcu_read_lock();
>   	}
> -	xa_unlock_irq(&fs_info->buffer_tree);
> +	rcu_read_unlock();
>  =20
>   	/*
>   	 * Finally to check if we have cleared folio private, as if we have
> @@ -4376,7 +4379,6 @@ static int try_release_subpage_extent_buffer(struc=
t folio *folio)
>   		ret =3D 0;
>   	spin_unlock(&folio->mapping->i_private_lock);
>   	return ret;
> -
>   }
>  =20
>   int try_release_extent_buffer(struct folio *folio)


