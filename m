Return-Path: <linux-btrfs+bounces-8829-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503F39995E7
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 02:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C84284E53
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 00:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F141E6310;
	Thu, 10 Oct 2024 23:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="dCpF1CW2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA9326AC1
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 23:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728604797; cv=none; b=mo1/BvjZw3u7NGNF+speEi4dnnqKALXB2E9Tgah9FirFcLJj7NA2aYnCfNjkg8D2DU1QVQ6vxME5xzPsPBB12ZI5cB+Pd9D5hIlM11zxQnnpRQlszpEYlOqbubqPSBtunnENwVPHiEk9PXIddm9zWNeRdl02Ws4uaovtYBt8qis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728604797; c=relaxed/simple;
	bh=/pE67Rp1CRQNCLUm3e6fEwLdZgrkSRY3EVgV02wqJHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxFF2MjjMtBprefzyKaI1BBWX7dIB+IKiTy1pA5tQBBd/L6ehKcRB1NnRArW4h2WtAkF/5XAS0Xo203bX5pYgNZ+cp++yr5Sd9KlMPoZKZKav6tQ6escevkCHyfuusITvaL5xtKJl1rHVnkCzfbYQEuzPhoCcMIRJWzmiGJUT+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=dCpF1CW2; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728604788; x=1729209588; i=quwenruo.btrfs@gmx.com;
	bh=dP3L1LVeqT4SM1iEpfOuBtGXjdtgWSpCLEGTKY1czL0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dCpF1CW2AxGTEXc2I1c/Vm48QfIDziqbKDEiH3QSiBXWNqpBrGPvvTX0UN8Bf65T
	 54/9L1tMGu7pLY0X9bP8onCjZUvM2q1NL8WWL5UadME8VwllgXivf7/BDczUaz+bp
	 i6kErut6mlwkPgYuzQwuVBnjHeB2TeTM+pngmqw/tJdIwuq8nq8jo1661HO2KJ7TP
	 rL/dNCZuVKpQObAsrhResNqCDP2av02L4VmUsa4KqfYpmcFxa2nK5NCnYJdoKEWgB
	 0pK5tXf0UQwhgxcyQAYcUUNX2Z4RHU314cPB4x5UUWJ7xSpOLpLjy5GYIiCKCU66L
	 5KQW+ORb5r6ZZI4slw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBUqF-1t7X7E1tcd-00GdZ8; Fri, 11
 Oct 2024 01:59:48 +0200
Message-ID: <a4ccf3fe-535e-4eeb-a683-857d611ff718@gmx.com>
Date: Fri, 11 Oct 2024 10:29:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: fix error propagation of split bios
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc: wqu@suse.com, hch@lst.de
References: <1d4f72f7fee285b2ddf4bf62b0ac0fd89def5417.1728575379.git.naohiro.aota@wdc.com>
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
In-Reply-To: <1d4f72f7fee285b2ddf4bf62b0ac0fd89def5417.1728575379.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gcXuxW5Y1sitPLll+AZtDGMqu+kEv5hz2p3QQPinNT1OtPmft19
 v8gjblH5HzRuk46s1ieBjX59uPwNeBkIU6d3MZHPlssPOtL3R3iWYogKqhAozTdIbRpNLIj
 3bJrfn5SxHywOEWsAH9VZCfCL1xF6Ifgyx/7XeRoM0PkqM3MvcVln9i1AD1QAltg+PIoUg4
 0tNA83pbYXjnDagNBjKnA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kPgjVIsf/aI=;mXxpZYJyyagF7O5C2LMFEW0QqYN
 GRWmgvchl2BErd7kOLx1S/fdXe5cHxB0VHtmnEkBeBpFh+JWDEKl7TgB7xQkUNK6ZY8hpwEVj
 VR64+2m/UCAvI1H5qNlXoIYQMWMhRvyEJsfGHzm0PqCfM2dba/yVQDGNDYX/ViHoota5q6HBU
 MjaVotfkmwjBci788zlbZgcXJ7x16k0OBs+kHvsXm4L9YWCB8v+rcTrWCJuK0qE72lLPI2ewW
 rwQxTrP9g5w6tnVYPYQboETO3l2CfxJw7Pd+pZX/2HZLLuAVsR5mqN7REgnLzgVNtqj1wzBdI
 1nJ96I1vXhxtflF5qK7FJkyt4mtbGCvI77qeEFUMx+8RRr3HxK2t13mB6zHSY/UT/foU6ZTjl
 c2jTlEPK7aJhf+Luh20wRTmQR+RYXeQNTcasA5Kasda+wwn0WdfRJs3/kLE24xUeP4FJ/JyJ9
 5SftgehXmfXNYFQ4+4VxnkKldceGT5h990moSSkMx4+oJozdd1Cjbp5pp0NyNihng+JL9MVDp
 9o80/TwCPdJ4ho2mLznNA+q+iAxFN2KCaTl9B+0F3V+chW1k2JOCvcmFvO74UzWqhgvXJxY2k
 2PmNk0PKRCSBH2xYuk8gClrWoP6uzG7j0CZ3xbpjRa50QO87tpXZSPv19QNWQlQ839Ldv6BFB
 cecQvw7KkaqJf45BiwaoPVvSPnmVu8d6px5g3VMy1k5ji6qgkN/GJKlJ30kVwVKkmHWDhWFVR
 8Dtbz0y/XJfny+G49esp30+dgVR+KOxkhi33IEigrErDfJ+inNdbvsWHvTrjc2gIw23gKb9Qh
 3JCQCiI9S2qEm2kxStNxxbrw==



=E5=9C=A8 2024/10/11 02:27, Naohiro Aota =E5=86=99=E9=81=93:
> The purpose of btrfs_bbio_propagate_error() shall be propagating an erro=
r
> of split bio to its original btrfs_bio, and tell the error to the upper
> layer. However, it's not working well on some cases.
>
> * Case 1. Immediate (or quick) end_bio with an error
>
> When btrfs sends btrfs_bio to mirrored devices, btrfs calls
> btrfs_bio_end_io() when all the mirroring bios are completed. If that
> btrfs_bio was split, it is from btrfs_clone_bioset and its end_io functi=
on
> is btrfs_orig_write_end_io. For this case, btrfs_bbio_propagate_error()
> accesses the orig_bbio's bio context to increase the error count.
>
> That works well in most cases. However, if the end_io is called enough
> fast, orig_bbio's (remaining part after split) bio context may not be
> properly set at that time. Since the bio context is set when the orig_bb=
io
> (the last btrfs_bio) is sent to devices, that might be too late for earl=
ier
> split btrfs_bio's completion.  That will result in NULL pointer
> dereference.
>
> That bug is easily reproducible by running btrfs/146 on zoned devices [1=
]
> and it shows the following trace.
>
> [1] You need raid-stripe-tree feature as it create "-d raid0 -m raid1" F=
S.
>
>      [   20.923980][   T13] BUG: kernel NULL pointer dereference, addres=
s: 0000000000000020
>      [   20.925234][   T13] #PF: supervisor read access in kernel mode
>      [   20.926122][   T13] #PF: error_code(0x0000) - not-present page
>      [   20.927118][   T13] PGD 0 P4D 0
>      [   20.927607][   T13] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
>      [   20.928424][   T13] CPU: 1 UID: 0 PID: 13 Comm: kworker/u32:1 No=
t tainted 6.11.0-rc7-BTRFS-ZNS+ #474
>      [   20.929740][   T13] Hardware name: Bochs Bochs, BIOS Bochs 01/01=
/2011
>      [   20.930697][   T13] Workqueue: writeback wb_workfn (flush-btrfs-=
5)
>      [   20.931643][   T13] RIP: 0010:btrfs_bio_end_io+0xae/0xc0 [btrfs]
>      [   20.932573][ T1415] BTRFS error (device dm-0): bdev /dev/mapper/=
error-test errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
>      [   20.932871][   T13] Code: ba e1 48 8b 7b 10 e8 f1 f5 f6 ff eb da=
 48 81 bf 10 01 00 00 40 0c 33 a0 74 09 40 88 b5 f1 00 00 00 eb b8 48 8b 8=
5 18 01 00 00 <48> 8b 40 20 0f b7 50 24 f0 01 50 20 eb a3 0f 1f 40 00 90 9=
0 90 90
>      [   20.936623][   T13] RSP: 0018:ffffc9000006f248 EFLAGS: 00010246
>      [   20.937543][   T13] RAX: 0000000000000000 RBX: ffff888005a7f080 =
RCX: ffffc9000006f1dc
>      [   20.938788][   T13] RDX: 0000000000000000 RSI: 000000000000000a =
RDI: ffff888005a7f080
>      [   20.940016][   T13] RBP: ffff888011dfc540 R08: 0000000000000000 =
R09: 0000000000000001
>      [   20.941227][   T13] R10: ffffffff82e508e0 R11: 0000000000000005 =
R12: ffff88800ddfbe58
>      [   20.942375][   T13] R13: ffff888005a7f080 R14: ffff888005a7f158 =
R15: ffff888005a7f158
>      [   20.943531][   T13] FS:  0000000000000000(0000) GS:ffff88803ea80=
000(0000) knlGS:0000000000000000
>      [   20.944838][   T13] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
>      [   20.945811][   T13] CR2: 0000000000000020 CR3: 0000000002e22006 =
CR4: 0000000000370ef0
>      [   20.946984][   T13] DR0: 0000000000000000 DR1: 0000000000000000 =
DR2: 0000000000000000
>      [   20.948150][   T13] DR3: 0000000000000000 DR6: 00000000fffe0ff0 =
DR7: 0000000000000400
>      [   20.949327][   T13] Call Trace:
>      [   20.949949][   T13]  <TASK>
>      [   20.950374][   T13]  ? __die_body.cold+0x19/0x26
>      [   20.951066][   T13]  ? page_fault_oops+0x13e/0x2b0
>      [   20.951766][   T13]  ? _printk+0x58/0x73
>      [   20.952358][   T13]  ? do_user_addr_fault+0x5f/0x750
>      [   20.953120][   T13]  ? exc_page_fault+0x76/0x240
>      [   20.953827][   T13]  ? asm_exc_page_fault+0x22/0x30
>      [   20.954606][   T13]  ? btrfs_bio_end_io+0xae/0xc0 [btrfs]
>      [   20.955616][   T13]  ? btrfs_log_dev_io_error+0x7f/0x90 [btrfs]
>      [   20.956682][   T13]  btrfs_orig_write_end_io+0x51/0x90 [btrfs]
>      [   20.957769][   T13]  dm_submit_bio+0x5c2/0xa50 [dm_mod]
>      [   20.958623][   T13]  ? find_held_lock+0x2b/0x80
>      [   20.959339][   T13]  ? blk_try_enter_queue+0x90/0x1e0
>      [   20.960228][   T13]  __submit_bio+0xe0/0x130
>      [   20.960879][   T13]  ? ktime_get+0x10a/0x160
>      [   20.961546][   T13]  ? lockdep_hardirqs_on+0x74/0x100
>      [   20.962310][   T13]  submit_bio_noacct_nocheck+0x199/0x410
>      [   20.963140][   T13]  btrfs_submit_bio+0x7d/0x150 [btrfs]
>      [   20.964089][   T13]  btrfs_submit_chunk+0x1a1/0x6d0 [btrfs]
>      [   20.965066][   T13]  ? lockdep_hardirqs_on+0x74/0x100
>      [   20.965824][   T13]  ? __folio_start_writeback+0x10/0x2c0
>      [   20.966659][   T13]  btrfs_submit_bbio+0x1c/0x40 [btrfs]
>      [   20.967617][   T13]  submit_one_bio+0x44/0x60 [btrfs]
>      [   20.968536][   T13]  submit_extent_folio+0x13f/0x330 [btrfs]
>      [   20.969552][   T13]  ? btrfs_set_range_writeback+0xa3/0xd0 [btrf=
s]
>      [   20.970625][   T13]  extent_writepage_io+0x18b/0x360 [btrfs]
>      [   20.971632][   T13]  extent_write_locked_range+0x17c/0x340 [btrf=
s]
>      [   20.972702][   T13]  ? __pfx_end_bbio_data_write+0x10/0x10 [btrf=
s]
>      [   20.973857][   T13]  run_delalloc_cow+0x71/0xd0 [btrfs]
>      [   20.974841][   T13]  btrfs_run_delalloc_range+0x176/0x500 [btrfs=
]
>      [   20.975870][   T13]  ? find_lock_delalloc_range+0x119/0x260 [btr=
fs]
>      [   20.976911][   T13]  writepage_delalloc+0x2ab/0x480 [btrfs]
>      [   20.977792][   T13]  extent_write_cache_pages+0x236/0x7d0 [btrfs=
]
>      [   20.978728][   T13]  btrfs_writepages+0x72/0x130 [btrfs]
>      [   20.979531][   T13]  do_writepages+0xd4/0x240
>      [   20.980111][   T13]  ? find_held_lock+0x2b/0x80
>      [   20.980695][   T13]  ? wbc_attach_and_unlock_inode+0x12c/0x290
>      [   20.981461][   T13]  ? wbc_attach_and_unlock_inode+0x12c/0x290
>      [   20.982213][   T13]  __writeback_single_inode+0x5c/0x4c0
>      [   20.982859][   T13]  ? do_raw_spin_unlock+0x49/0xb0
>      [   20.983439][   T13]  writeback_sb_inodes+0x22c/0x560
>      [   20.984079][   T13]  __writeback_inodes_wb+0x4c/0xe0
>      [   20.984886][   T13]  wb_writeback+0x1d6/0x3f0
>      [   20.985536][   T13]  wb_workfn+0x334/0x520
>      [   20.986044][   T13]  process_one_work+0x1ee/0x570
>      [   20.986580][   T13]  ? lock_is_held_type+0xc6/0x130
>      [   20.987142][   T13]  worker_thread+0x1d1/0x3b0
>      [   20.987918][   T13]  ? __pfx_worker_thread+0x10/0x10
>      [   20.988690][   T13]  kthread+0xee/0x120
>      [   20.989180][   T13]  ? __pfx_kthread+0x10/0x10
>      [   20.989915][   T13]  ret_from_fork+0x30/0x50
>      [   20.990615][   T13]  ? __pfx_kthread+0x10/0x10
>      [   20.991336][   T13]  ret_from_fork_asm+0x1a/0x30
>      [   20.992106][   T13]  </TASK>
>      [   20.992482][   T13] Modules linked in: dm_mod btrfs blake2b_gene=
ric xor raid6_pq rapl
>      [   20.993406][   T13] CR2: 0000000000000020
>      [   20.993884][   T13] ---[ end trace 0000000000000000 ]---
>      [   20.993954][ T1415] BUG: kernel NULL pointer dereference, addres=
s: 0000000000000020
>
> * Case 2. Earlier completion of orig_bbio for mirrored btrfs_bios
>
> btrfs_bbio_propagate_error() assumes the end_io function for orig_bbio i=
s
> called last among split bios. In that case, btrfs_orig_write_end_io() se=
ts
> the bio->bi_status to BLK_STS_IOERR by seeing the bioc->error [2].
> Otherwise, the increased orig_bio's bioc->error is not checked by anyone
> and return BLK_STS_OK to the upper layer.
>
> [2] Actually, this is not true. Because we only increases orig_bioc->err=
ors
> by max_errors, the condition "atomic_read(&bioc->error) > bioc->max_erro=
rs"
> is still not met if only one split btrfs_bio fails.
>
> * Case 3. Later completion of orig_bbio for un-mirrored btrfs_bios
>
> In contrast to the above case, btrfs_bbio_propagate_error() is not worki=
ng
> well if un-mirrored orig_bbio is completed last. It sets
> orig_bbio->bio.bi_status to the btrfs_bio's error. But, that is easily
> over-written by orig_bbio's completion status. If the status is BLK_STS_=
OK,
> the upper layer would not know the failure.
>
> * Solution
>
> Considering the above cases, we can only save the error status in the
> orig_bbio (remaining part after split) itself as it is always
> available. Also, the saved error status should be propagated when all th=
e
> split btrfs_bios are finished (i.e, bbio->pending_ios =3D=3D 0).
>
> This commit introduces "status" to btrfs_bbio and saves the first error =
of
> split bios to original btrfs_bio's "status" variable. When all the split
> bios are finished, the saved status is loaded into original btrfs_bio's
> status.
>
> With this commit, btrfs/146 on zoned devices does not hit the NULL point=
er
> dereference.
>
> Fixes: 852eee62d31a ("btrfs: allow btrfs_submit_bio to split bios")
> CC: stable@vger.kernel.org # 6.6+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
> - v1: https://lore.kernel.org/linux-btrfs/db5c272fc27c59ddded5c691373c26=
458698cb1a.1728489285.git.naohiro.aota@wdc.com/
> - v2
>    - Replace atomic_t usage to blk_status_t and cmpxchg()
> ---
>   fs/btrfs/bio.c | 36 ++++++++++++------------------------
>   fs/btrfs/bio.h |  3 +++
>   2 files changed, 15 insertions(+), 24 deletions(-)
>
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 056f8a171bba..af12b23c8531 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -49,6 +49,7 @@ void btrfs_bio_init(struct btrfs_bio *bbio, struct btr=
fs_fs_info *fs_info,
>   	bbio->end_io =3D end_io;
>   	bbio->private =3D private;
>   	atomic_set(&bbio->pending_ios, 1);
> +	WRITE_ONCE(bbio->status, BLK_STS_OK);
>   }
>
>   /*
> @@ -120,41 +121,28 @@ static void __btrfs_bio_end_io(struct btrfs_bio *b=
bio)
>   	}
>   }
>
> -static void btrfs_orig_write_end_io(struct bio *bio);
> -
> -static void btrfs_bbio_propagate_error(struct btrfs_bio *bbio,
> -				       struct btrfs_bio *orig_bbio)
> -{
> -	/*
> -	 * For writes we tolerate nr_mirrors - 1 write failures, so we can't
> -	 * just blindly propagate a write failure here.  Instead increment the
> -	 * error count in the original I/O context so that it is guaranteed to
> -	 * be larger than the error tolerance.
> -	 */
> -	if (bbio->bio.bi_end_io =3D=3D &btrfs_orig_write_end_io) {
> -		struct btrfs_io_stripe *orig_stripe =3D orig_bbio->bio.bi_private;
> -		struct btrfs_io_context *orig_bioc =3D orig_stripe->bioc;
> -
> -		atomic_add(orig_bioc->max_errors, &orig_bioc->error);
> -	} else {
> -		orig_bbio->bio.bi_status =3D bbio->bio.bi_status;
> -	}
> -}
> -
>   void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
>   {
>   	bbio->bio.bi_status =3D status;
>   	if (bbio->bio.bi_pool =3D=3D &btrfs_clone_bioset) {
>   		struct btrfs_bio *orig_bbio =3D bbio->private;
>
> -		if (bbio->bio.bi_status)
> -			btrfs_bbio_propagate_error(bbio, orig_bbio);
>   		btrfs_cleanup_bio(bbio);
>   		bbio =3D orig_bbio;
>   	}
>
> -	if (atomic_dec_and_test(&bbio->pending_ios))
> +	/* At this point, bbio always points to the original btrfs_bio. Save t=
he
> +	 * first error in it.
> +	 */
> +	if (status !=3D BLK_STS_OK)
> +		cmpxchg(&bbio->status, BLK_STS_OK, status);
> +
> +	if (atomic_dec_and_test(&bbio->pending_ios)) {
> +		/* Load split bio's error which might be set above. */
> +		if (status =3D=3D BLK_STS_OK)
> +			bbio->bio.bi_status =3D READ_ONCE(bbio->status);
>   		__btrfs_bio_end_io(bbio);
> +	}
>   }
>
>   static int next_repair_mirror(struct btrfs_failed_bio *fbio, int cur_m=
irror)
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index e48612340745..566c3e1d077b 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -79,6 +79,9 @@ struct btrfs_bio {
>   	/* File system that this I/O operates on. */
>   	struct btrfs_fs_info *fs_info;
>
> +	/* Set the error status of split bio. */
> +	blk_status_t status;
> +
>   	/*
>   	 * This member must come last, bio_alloc_bioset will allocate enough
>   	 * bytes for entire btrfs_bio but relies on bio being last.


