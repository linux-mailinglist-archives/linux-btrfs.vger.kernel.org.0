Return-Path: <linux-btrfs+bounces-6669-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C34893A995
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2024 01:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB583283FF2
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2024 23:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936A4145B09;
	Tue, 23 Jul 2024 23:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gD9duC2a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FAA149012
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Jul 2024 23:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721775920; cv=none; b=cSlmjGA7IJkby4e4RKvRI2BnYtRWU7yjg048mQLqF3t9UPjciYSBjhSx50jQmkzeGY4+aofQkOCuHh16xgzMF0zXIDJwfcAe9L27RhSB63ashEiXkguFt/M7D2CP/nxTi6kUwaBikrUNL8v/OFac9Q0xGgA67cKjy1iPlq/bdMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721775920; c=relaxed/simple;
	bh=2gkiqNZ9qEtRwFlj+JhXFu8imBYjGMKzdPTSMO7TFC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LIxNcXPvUNxe1C1FqI2hOYLDJK1tQFdr5ucL2985vRFB5e46/QNyxtMRz3LwRSdXPtZqeCQlwBHW4j+awwfJ+jNj9illgq8yK6CNWVYkMtqc1FtCz/Pat16M6H+GaylX5vxNy8byHCH1tS0PQlWHyZWHSqj8vxZixhp537NwyAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gD9duC2a; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721775906; x=1722380706; i=quwenruo.btrfs@gmx.com;
	bh=tQ0u3OjJtuvcJmI7ao293pDyjfR+uvi2VrK5hvldvMA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gD9duC2aLcQyonfwGqZvsdNeOusZChMgUKYzTAbLLScSfh0+kl+gfPORYRcVIp34
	 1CFAb3fKkccjobQryCIhXoosgGrY7JOQb3z9aExf/7vqyc/El4PA3c8PWJ1SVc/JE
	 5pF3VXjgj1R1cwDOn4NJxDgfW4vmbmds0LZpkPBTR1A/1ufgj2NXt4fWstxwSx84q
	 PbKnbrEWDpD+jDLOrmYcJkLqiVL+Xb1PQjUtP3dJhtWIboFi41SSB2dsh5doe3oqD
	 5Hwpfy6c2KVSwtL/9Uge0CMdcZ+EvvNfVBOjm+DOcIls1I0Skh7RoDBT3YoiI15mY
	 L9N7FFwuAO5Nv4JRIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mxm3K-1sNEoZ1qCk-017evo; Wed, 24
 Jul 2024 01:05:05 +0200
Message-ID: <c62d48f9-55d2-4f4a-af7e-31ad08dbdd29@gmx.com>
Date: Wed, 24 Jul 2024 08:35:02 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: make cow_file_range_inline honor locked_page on
 error
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <4830592782d102b8f15cb753824caee669e5d8a9.1721774105.git.boris@bur.io>
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
In-Reply-To: <4830592782d102b8f15cb753824caee669e5d8a9.1721774105.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/PHpebgSLxAHVpHk3sBLkM479ETXF4oVQqscAZpfzRmH8g8TltG
 XFP78ECRKtDr2bZvS9edSxe2CHqylzamKsYoj1HKTzXGK0eccthInxzUtDMgNbefyvXlFGq
 CH9stsAh/db3khnLII35gNZMfjMk2T3uUPf/64LxFeETu7jyx+9HxA7sk1YwUovzcoiG9gR
 52dPSTS/vNS2FzFrlt8Dg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nPfFimeXeFc=;RyRwBHH7NXZLPS6kganriEiTqSo
 I1iYZ5kanvLaFjxXHOKB5g8WVm3mZMN1Fc8HODH2+5A8vioMkSzYfpMvrWjz8kODd8kmYE3Du
 GwftDMtJiHrqZZj7Vz1rNeUuA4mLo+AseC1IWo7SN0zXmWetwGQtBpsSnNgUD2BH3rdhPAbyX
 etWa5smV3T3w5wRxKEBa3b7hycwnJLcPOaik1VEp3qrp6KGEqlQDAjzsrW7QpTYfdKbbUWZXX
 S10S6G5e5b57n7Ve9py7y3fJxbbF4XSQNnaVsdhZRfSZdd2reCSue2708S378PpakwfUUX6vd
 PIpTd1FLP8LpJ2wyKFFDYWaHsS/NIFLYcjGMrPGsx0OaWoj18K4/QJ8e6klW9hEMpNuod3nRJ
 u9zdDFPP6He9467IxOwtPzwkV4M3+urm+Jj3hJpmMFsiYfc73mwoHBZ/48Wdy1qqSdDOqSDC/
 jK7dSn7oaCLewzFKZ27082Q8+Uy+y2UKg6ByJUvYWhZck3Gb6zZDXrsnfE0g2BycUT6ED76GP
 3eVFFDG6KzW9zW3rixFqosbqmRUb1nf9lg4C68G+BpzyDdZTiLkdaBY9QR2N5+VHvtOPSfXsn
 JuXUhVkdW8aQ4oI2oAAiPYugJDq77xU6R0ZGW2+pYnvQaheVQmyOUfFiF6x+OsSSFl7HIR4Sg
 UnHnPP9yAn152QwJ07ozabvzOKMFE6vXyZpn0cvZjdvcgacHMulXdFm3zITpymBs5+rKd8ozg
 Adz1oXYIAFM24pSojyyYTZVkTVIsshulkbVAcmilVnYkbk+MrbaLpna2noyg1s1hGh2jAVeq1
 FA1CVWnjpjZgkxCoZhnkq8XQ==



=E5=9C=A8 2024/7/24 08:05, Boris Burkov =E5=86=99=E9=81=93:
> The btrfs buffered write path runs through __extent_writepage which has
> some tricky return value handling for writepage_delalloc. Specifically,
> when that returns 1, we exit, but for other return values we continue
> and end up calling btrfs_folio_end_all_writers. If the folio has been
> unlocked (note that we check the PageLocked bit at the start of
> __extent_writepage), this results in an assert panic like this one from
> syzbot:
>
> BTRFS: error (device loop0 state EAL) in free_log_tree:3267: errno=3D-5 =
IO
> failure
> BTRFS warning (device loop0 state EAL): Skipping commit of aborted
> transaction.
> BTRFS: error (device loop0 state EAL) in cleanup_transaction:2018:
> errno=3D-5 IO failure
> assertion failed: folio_test_locked(folio), in fs/btrfs/subpage.c:871
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/subpage.c:871!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 1 PID: 5090 Comm: syz-executor225 Not tainted
> 6.10.0-syzkaller-05505-gb1bc554e009e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 06/27/2024
> RIP: 0010:btrfs_folio_end_all_writers+0x55b/0x610 fs/btrfs/subpage.c:871
> Code: e9 d3 fb ff ff e8 25 22 c2 fd 48 c7 c7 c0 3c 0e 8c 48 c7 c6 80 3d
> 0e 8c 48 c7 c2 60 3c 0e 8c b9 67 03 00 00 e8 66 47 ad 07 90 <0f> 0b e8
> 6e 45 b0 07 4c 89 ff be 08 00 00 00 e8 21 12 25 fe 4c 89
> RSP: 0018:ffffc900033d72e0 EFLAGS: 00010246
> RAX: 0000000000000045 RBX: 00fff0000000402c RCX: 663b7a08c50a0a00
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: ffffc900033d73b0 R08: ffffffff8176b98c R09: 1ffff9200067adfc
> R10: dffffc0000000000 R11: fffff5200067adfd R12: 0000000000000001
> R13: dffffc0000000000 R14: 0000000000000000 R15: ffffea0001cbee80
> FS:  0000000000000000(0000) GS:ffff8880b9500000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f5f076012f8 CR3: 000000000e134000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> __extent_writepage fs/btrfs/extent_io.c:1597 [inline]
> extent_write_cache_pages fs/btrfs/extent_io.c:2251 [inline]
> btrfs_writepages+0x14d7/0x2760 fs/btrfs/extent_io.c:2373
> do_writepages+0x359/0x870 mm/page-writeback.c:2656
> filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:397
> __filemap_fdatawrite_range mm/filemap.c:430 [inline]
> __filemap_fdatawrite mm/filemap.c:436 [inline]
> filemap_flush+0xdf/0x130 mm/filemap.c:463
> btrfs_release_file+0x117/0x130 fs/btrfs/file.c:1547
> __fput+0x24a/0x8a0 fs/file_table.c:422
> task_work_run+0x24f/0x310 kernel/task_work.c:222
> exit_task_work include/linux/task_work.h:40 [inline]
> do_exit+0xa2f/0x27f0 kernel/exit.c:877
> do_group_exit+0x207/0x2c0 kernel/exit.c:1026
> __do_sys_exit_group kernel/exit.c:1037 [inline]
> __se_sys_exit_group kernel/exit.c:1035 [inline]
> __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1035
> x64_sys_call+0x2634/0x2640
> arch/x86/include/generated/asm/syscalls_64.h:232
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f5f075b70c9
> Code: Unable to access opcode bytes at
> 0x7f5f075b709f.
> RSP: 002b:00007ffd1c3f9a58 EFLAGS: 00000246
> ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
> 00007f5f075b70c9
> RDX: 000000000000003c RSI: 00000000000000e7 RDI:
> 0000000000000000
> RBP: 00007f5f07638390 R08: ffffffffffffffb8 R09:
> 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12:
> 00007f5f07638390
> R13: 0000000000000000 R14: 00007f5f07639100 R15:
> 00007f5f07585050
> </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
>
> I was hitting the same issue by doing hundreds of accelerated runs of
> generic/475, which also hits IO errors by design.
>
> I instrumented that reproducer with bpftrace and found that the
> undesirable folio_unlock was coming from the following callstack:
>
> folio_unlock+5
> __process_pages_contig+475
> cow_file_range_inline.constprop.0+230
> cow_file_range+803
> btrfs_run_delalloc_range+566
> writepage_delalloc+332
> __extent_writepage # inlined in my stacktrace, but I added it here
> extent_write_cache_pages+622
>
> Looking at the bisected-to patch in the syzbot report, Josef realized
> that the logic of the cow_file_range_inline error path subtly changing.
> In the past, on error, it jumped to out_unlock in cow_file_range, which
> honors the locked_page, so when we ultimately call
> folio_end_all_writers, the folio of interest is still locked. After the
> change, we always unlocked ignoring the locked_page, on both success and
> error. On the success path, this all results in returning 1 to
> __extent_writepage, which skips the folio_end_all_writers call, which
> makes it OK to have unlocked.
>
> Fix the bug by wiring the locked_page into cow_file_range_inline and
> only setting locked_page to NULL on success.
>
> Reported-by: syzbot+a14d8ac9af3a2a4fd0c8@syzkaller.appspotmail.com
> Fixes: 0586d0a89e77 ("btrfs: move extent bit and page cleanup into cow_f=
ile_range_inline")
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

> ---
>   fs/btrfs/inode.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8f38eefc8acd..8ca3878348ff 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -714,8 +714,9 @@ static noinline int __cow_file_range_inline(struct b=
trfs_inode *inode, u64 offse
>   	return ret;
>   }
>
> -static noinline int cow_file_range_inline(struct btrfs_inode *inode, u6=
4 offset,
> -					  u64 end,
> +static noinline int cow_file_range_inline(struct btrfs_inode *inode,
> +					  struct page *locked_page,
> +					  u64 offset, u64 end,
>   					  size_t compressed_size,
>   					  int compress_type,
>   					  struct folio *compressed_folio,
> @@ -739,7 +740,10 @@ static noinline int cow_file_range_inline(struct bt=
rfs_inode *inode, u64 offset,
>   		return ret;
>   	}
>
> -	extent_clear_unlock_delalloc(inode, offset, end, NULL, &cached,

Better adding one comment explaining that the locked page will be
unlocked by the caller on error.

Thanks,
Qu
> +	if (ret =3D=3D 0)
> +		locked_page =3D NULL;
> +
> +	extent_clear_unlock_delalloc(inode, offset, end, locked_page, &cached,
>   				     clear_flags,
>   				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
>   				     PAGE_END_WRITEBACK);
> @@ -1043,10 +1047,10 @@ static void compress_file_range(struct btrfs_wor=
k *work)
>   	 * extent for the subpage case.
>   	 */
>   	if (total_in < actual_end)
> -		ret =3D cow_file_range_inline(inode, start, end, 0,
> +		ret =3D cow_file_range_inline(inode, NULL, start, end, 0,
>   					    BTRFS_COMPRESS_NONE, NULL, false);
>   	else
> -		ret =3D cow_file_range_inline(inode, start, end, total_compressed,
> +		ret =3D cow_file_range_inline(inode, NULL, start, end, total_compress=
ed,
>   					    compress_type, folios[0], false);
>   	if (ret <=3D 0) {
>   		if (ret < 0)
> @@ -1359,7 +1363,7 @@ static noinline int cow_file_range(struct btrfs_in=
ode *inode,
>
>   	if (!no_inline) {
>   		/* lets try to make an inline extent */
> -		ret =3D cow_file_range_inline(inode, start, end, 0,
> +		ret =3D cow_file_range_inline(inode, locked_page, start, end, 0,
>   					    BTRFS_COMPRESS_NONE, NULL, false);
>   		if (ret <=3D 0) {
>   			/*

