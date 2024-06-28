Return-Path: <linux-btrfs+bounces-6033-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ADE91B62C
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 07:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B7F6B22869
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 05:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2338B3DB89;
	Fri, 28 Jun 2024 05:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="XARoiXtX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF3B28DBC
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 05:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719553035; cv=none; b=Nc9HcJ9J7dMTvjvkklYOsgy9NAPFQ0tw+8JLB9HUZnMMRs3LkIpzGWfIVdx5AN97GTST1SQQapJlKWeH90iubMugrB5Wj4i/Gi7s5dzH/2GEZgIHaAoShcFDyBYOa5oRFxNnVVTeu+J0SL4YQm3ePlGYmMzpyyPsbJ4BqZ6dPuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719553035; c=relaxed/simple;
	bh=x+i+xeV/nMfK/mlF+4mKLx1YkQ/5PZtntnwSwLtEURw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGYldqiOyofCPc1NhEj4RQf5ZP3zOFSLFukZ7CuCe6WtZE7IRrYQmnhnRB2dp27lbMCdGVIAkTpzYtNlsHRfl82Tso54NyaG000g2hG78mcymceMzzPIiGS5LFIlq+3kwxbHN0OCRJZSVaImCxd70EG+4OTS8q1p9n+T3uEyIzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=XARoiXtX; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1719553028; x=1720157828; i=quwenruo.btrfs@gmx.com;
	bh=WJ9k5TuQqUZi/1C1HNmIBmEN+P19jASQfe7NuXFI/ts=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XARoiXtX6sfLSWzjWqNWEf3q6z2mUYhTP7tvpairWC08JKQUi/1bLITtE4fhXiOs
	 zjHHrAcJb99+WAtfj9ofQ4ird4jIChX7+XuL2A+MLdHe9t1YvKXmk5jh7X3O5Gkkj
	 2thBYt+Tl1kMvTHBQ0yXydcPUoeit2OXUMp7v7s7wGNydTo8K8tDISXkxbT5l8TlW
	 EAFCoyVXCsfXaIVOqs2xCjI0aXl1mwqBxfTHttgr4YKRbxXsipsAYwOY0DN+s6rl/
	 H9DMafi3AkM6NSZJqWVGOvgTjRLZsqprYoTkwOb/9NzPMoOxQckjNQl680tTWOJEI
	 D3tiydP0wQH7YIKpqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mk0NU-1slQlP2AR6-00fJGP; Fri, 28
 Jun 2024 07:37:08 +0200
Message-ID: <89357644-24e6-4894-86b6-fbe5d369dd0a@gmx.com>
Date: Fri, 28 Jun 2024 15:07:04 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: avoid possible parallel list adding
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <58e8574ccd70645c613e6bc7d328e34c2f52421a.1719549099.git.naohiro.aota@wdc.com>
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
In-Reply-To: <58e8574ccd70645c613e6bc7d328e34c2f52421a.1719549099.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:apZp9k+5vKxB3V/Eygk0BOeoOzns5GgW4i4UvEpBskOrW2mPbiy
 81Hr+AZdhDpksc1gsj6lx/ca+MQtd/FBrDysgyn6YcRwdzNwP8mfj6L8mBdnt307T99Hb1B
 EFSum/msdfImXavIM1dT16Z0hQHdHrIXsE0Q/3jRknT3tprnMWcFCb3MZ++zDhkut9+cI6D
 xYiQ/vTAEFwZUbKD2HKxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/I1wyeWTP0M=;OSmDTj0VTWn3o7kE97UI9Zk1fNx
 KJP0Gbk8LY7lx7hn4VmjTquC7yd1ZzgBvrJfEf017YrCQ3aVpCVPDGO9UsJWOdBX/gjgnvEbI
 zSzl9128nt7bxhfOjA10/t1gwq739S38nDDmrMN0/Pk0fnHDLbrZVeYAqKVqvVe9UeEnmVfDE
 n/3wHWykj8eqR+ZSe84HOA8VP03OvVwVn9PIIJiyeL7I+M8q/NlzOS8lPxgeH4BotAQN+Rlh/
 hUvJcIpvTsgVYZZDu5gpiuK+4oCeLtgBhH0IFPUkleHmn0hDJgOa0ND44zWcsDuNGs8NYWxut
 0hT4Xzksz9kdhgUs9qVkT2sePhSFNYJuatEb9PGy6eb8YtV880Oi3Ej+fWZWyZ2dMZQLVBFIC
 2szDzoHFlazsP554YBWugs4ibnE7nuXYDSRUK3a7L2w7tWmub2uWIBFBOuHpWZoQEd6CRFGXr
 DyCX0qvGJc1SJian8zcExVjOhCZtbsGgNGHkU3rfEb2SP/o5BNJXLgXXRrZWjIkAgm2C9MnXC
 JBtG2CaEsmTTqhZsPBcvDepSkm4CRFXb0AcWm9GifyHMRl05AxhcJnETOaZd6txVqHZE5rZzw
 I7uuVH+eORjYoNico+veHpi+5P0rfZPoj46W+njzT9MQ6zQVjGwDbFzB7xJMjZv8BfkuFDNob
 C2CktBnw66GX3qZ1vnY8l81V2NxaYFsaLo0Wj++iXHL73CSLjl/pLux+mRRMYH21p8b5sBSVF
 CngVphOae2Cr4lWQ0IstZb+EBgHVNaAYdPqgpbeKta1cSKq7vlsh2qlR2rqc4VVDRNOz8A8cH
 YHy4Bc4ubhr2SHdZplACyp6gBbxgNajbW9HyDflh/pCfA=



=E5=9C=A8 2024/6/28 14:02, Naohiro Aota =E5=86=99=E9=81=93:
> There is a potential parallel list adding for retrying in
> btrfs_reclaim_bgs_work and adding to the unused list. Since the block
> group is removed from the reclaim list and it is on a relocation work,
> it can be added into the unused list in parallel. When that happens,
> adding it to the reclaim list will corrupt the list head and trigger
> list corruption like below.
>
> Fix it by taking fs_info->unused_bgs_lock.
>
> [27177.504101][T2585409] BTRFS error (device nullb1): error relocating c=
h=3D unk 2415919104
> [27177.514722][T2585409] list_del corruption. next->prev should be ff110=
0=3D 0344b119c0, but was ff11000377e87c70. (next=3D3Dff110002390cd9c0)
> [27177.529789][T2585409] ------------[ cut here ]------------
> [27177.537690][T2585409] kernel BUG at lib/list_debug.c:65!
> [27177.545548][T2585409] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KAS=
AN NOPTI
> [27177.555466][T2585409] CPU: 9 PID: 2585409 Comm: kworker/u128:2 Tainte=
d: G        W          6.10.0-rc5-kts #1
> [27177.568502][T2585409] Hardware name: Supermicro SYS-520P-WTR/X12SPW-T=
F, BIOS 1.2 02/14/2022
> [27177.579784][T2585409] Workqueue: events_unbound btrfs_reclaim_bgs_wor=
k[btrfs]
> [27177.589946][T2585409] RIP: 0010:__list_del_entry_valid_or_report.cold=
+0x70/0x72
> [27177.600088][T2585409] Code: fa ff 0f 0b 4c 89 e2 48 89 de 48 c7 c7 c0
> 8c 3b 93 e8 ab 8e fa ff 0f 0b 4c 89 e1 48 89 de 48 c7 c7 00 8e 3b 93 e8
> 97 8e fa ff <0f> 0b 48 63 d1 4c 89 f6 48 c7 c7 e0 56 67 94 89 4c 24 04
> e8 ff f2
> [27177.624173][T2585409] RSP: 0018:ff11000377e87a70 EFLAGS: 00010286
> [27177.633052][T2585409] RAX: 000000000000006d RBX: ff11000344b119c0 RCX=
:0000000000000000
> [27177.644059][T2585409] RDX: 000000000000006d RSI: 0000000000000008 RDI=
:ffe21c006efd0f40
> [27177.655030][T2585409] RBP: ff110002e0509f78 R08: 0000000000000001 R09=
:ffe21c006efd0f08
> [27177.665992][T2585409] R10: ff11000377e87847 R11: 0000000000000000 R12=
:ff110002390cd9c0
> [27177.676964][T2585409] R13: ff11000344b119c0 R14: ff110002e0508000 R15=
:dffffc0000000000
> [27177.687938][T2585409] FS:  0000000000000000(0000) GS:ff11000fec880000=
(0000) knlGS:0000000000000000
> [27177.700006][T2585409] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
> [27177.709431][T2585409] CR2: 00007f06bc7b1978 CR3: 0000001021e86005 CR4=
:0000000000771ef0
> [27177.720402][T2585409] DR0: 0000000000000000 DR1: 0000000000000000 DR2=
:0000000000000000
> [27177.731337][T2585409] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7=
:0000000000000400
> [27177.742252][T2585409] PKRU: 55555554
> [27177.748207][T2585409] Call Trace:
> [27177.753850][T2585409]  <TASK>
> [27177.759103][T2585409]  ? __die_body.cold+0x19/0x27
> [27177.766405][T2585409]  ? die+0x2e/0x50
> [27177.772498][T2585409]  ? do_trap+0x1ea/0x2d0
> [27177.779139][T2585409]  ? __list_del_entry_valid_or_report.cold+0x70/0=
x72
> [27177.788518][T2585409]  ? do_error_trap+0xa3/0x160
> [27177.795649][T2585409]  ? __list_del_entry_valid_or_report.cold+0x70/0=
x72
> [27177.805045][T2585409]  ? handle_invalid_op+0x2c/0x40
> [27177.812022][T2585409]  ? __list_del_entry_valid_or_report.cold+0x70/0=
x72
> [27177.820947][T2585409]  ? exc_invalid_op+0x2d/0x40
> [27177.827608][T2585409]  ? asm_exc_invalid_op+0x1a/0x20
> [27177.834637][T2585409]  ? __list_del_entry_valid_or_report.cold+0x70/0=
x72
> [27177.843519][T2585409]  btrfs_delete_unused_bgs+0x3d9/0x14c0 [btrfs]
>
> There is a similar retry_list code in btrfs_delete_unused_bgs(), but it =
is
> safe, AFAIC. Since the block group was in the unused list, the used byte=
s
> should be 0 when it was added to the unused list. Then, it checks
> block_group->{used,resereved,pinned} are still 0 under the
> block_group->lock. So, they should be still eligible for the unused list=
,
> not the reclaim list.
>
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Suggested-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> Fixes: 4eb4e85c4f81 ("btrfs: retry block group reclaim without infinite =
loop")
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just to mention, I find another location which may cause problems:

- btrfs_make_block_group()
   We call list_add_tail() to add the current bg to trans->new_bgs,
   without any extra locking.

   Not sure if it's racy, as it doesn't look that possible to call
   btrfs_make_block_group() on the same trans handler, but maybe we want
   to make sure it's safe.

Thanks,
Qu
> ---
>   fs/btrfs/block-group.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 7cde40fe6a50..498442d0c216 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1945,8 +1945,17 @@ void btrfs_reclaim_bgs_work(struct work_struct *w=
ork)
>   next:
>   		if (ret && !READ_ONCE(space_info->periodic_reclaim)) {
>   			/* Refcount held by the reclaim_bgs list after splice. */
> -			btrfs_get_block_group(bg);
> -			list_add_tail(&bg->bg_list, &retry_list);
> +			spin_lock(&fs_info->unused_bgs_lock);
> +			/*
> +			 * This block group might be added to the unused list
> +			 * during the above process. Move it back to the
> +			 * reclaim list otherwise.
> +			 */
> +			if (list_empty(&bg->bg_list)) {
> +				btrfs_get_block_group(bg);
> +				list_add_tail(&bg->bg_list, &retry_list);
> +			}
> +			spin_unlock(&fs_info->unused_bgs_lock);
>   		}
>   		btrfs_put_block_group(bg);
>

