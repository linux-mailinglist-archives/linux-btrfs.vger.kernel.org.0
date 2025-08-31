Return-Path: <linux-btrfs+bounces-16543-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0F2B3D5A9
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 00:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB521892F95
	for <lists+linux-btrfs@lfdr.de>; Sun, 31 Aug 2025 22:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5461423F26A;
	Sun, 31 Aug 2025 22:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="geSsokMN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E184A79CD
	for <linux-btrfs@vger.kernel.org>; Sun, 31 Aug 2025 22:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756680726; cv=none; b=HOaj5gMyygVlgrLa9f16NNU+9rAbWg6zZdXyJK64XvXXiccQThK/Y49mRBW5vuHxhNH5ba28RsxW8Z4scOK4TO03oJzCI9fzzHxhMiN9ohQxjdzfrnvlMtmKeEEzo8RibZnGa1TBF0M7Gc7nNPVCOUNxzpRfuKfVD+QnRM7wxu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756680726; c=relaxed/simple;
	bh=KxyGMdFSF0vPjoAWdVKN+4FliVsAQ2kqWt1WPUXzGPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZgbWsut5VPjdZF1PqRJbRDTfvIW+U8YRhgqWUXcUJxoat7GbjHmsl8QMNXSWj1+dKBkuOS1mXAsXok+GXadcN/EXJILxTs+WdtE/xiDjTfPn3AObX5DEWyqp/Wij39saGKCD1Igwyn/qkEZbmODPV7C8txo5tCOtuokRM0QlnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=geSsokMN; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1756680722; x=1757285522; i=quwenruo.btrfs@gmx.com;
	bh=hdw6XisXqSKip6XUpEkFUuIdz0pSzy/TsSotazMsHs4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=geSsokMNkHAtK+D8QfsdfgKhA0KqcPS2W90NznTLa8WlhmwP9uiNZW0zDPkr6eqd
	 nA5XaDzcV+g1ef3X3TpLdCHL2LgilT7s0bYxze7mOWAjNAxexEMMndPQMEpdINcKt
	 P1ltzD3JCSbxCW/83HasEBGiG/5IgzZF7sQh3Q1sJn75MbXtlWRml0VagzlwXLSmB
	 Lr+bmjuJadVSeEGA4QxUUbyBGsdfHxx8FOu7M/hNJCbkONSoU+MYGivsPdi2CWY5l
	 DPYQPHh9kU+Hjp9+pi/UW9v19YT8zN6kZ8tc1gvwFtgJ7/fuRLdFKsBK/iUNjrsJ4
	 mni0JHn8ye8qHOMttQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MN5eX-1v9YyS26wn-00Vk5Q; Mon, 01
 Sep 2025 00:52:01 +0200
Message-ID: <8c6af9a9-e446-4a18-a31e-3bd924d329b6@gmx.com>
Date: Mon, 1 Sep 2025 08:21:58 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
To: dsterba@suse.cz, Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <20250829084533.17793-1-sunk67188@gmail.com>
 <20250830010802.GB5333@twin.jikos.cz>
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
In-Reply-To: <20250830010802.GB5333@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GQgG58F/tDEi6DXf01YIbbWs92crKz65X9TiSsM2hlvPox3jkOF
 Sg8jUwDYyka7gR1CWuJMUZszTBU/L7MJPUwwGcsWnKtrOU5DT1XiOB1xqqyGPSexvZNTqqx
 9AlLkrUYVYB7uVaWfQ/o1nNsqsJ/DnlcTNdN7BbDjewIhfC/Lk5vbCiRXXd91eTMWaP87sf
 6d3fiRVv2COEL738Em8+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v1r2HL+CpV4=;nkBPTKAPI1V9fk7YUPbIfGXaftY
 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
 mGHbQd/fNlonkGosp1E0+9wCSS5XYo0Q==



=E5=9C=A8 2025/8/30 10:38, David Sterba =E5=86=99=E9=81=93:
> On Fri, Aug 29, 2025 at 04:35:36PM +0800, Sun YangKai wrote:
>> Trival pattern for the auto freeing with goto -> return conversions
>> if possible. No other function cleanup.
>>
>> The following cases are considered trivial in this patch:
>> 1. Cases where there are no operations between btrfs_free_path and the
>> function return.
>> 2. Cases where only simple cleanup operations (such as kfree, kvfree,
>> clear_bit, and fs_path_free) are present between btrfs_free_path and th=
e
>> function return.
>>
>> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
>>
>> ---
>>
>> Changelog:
>> v1 -> v3:
>> * Directly return 0 if info is NULL in send.c:get_inode_info()
>> * Limit the scope of the conversion to only what is described
>>    in the commit message.
>=20
> Thanks, this looks good. If you find more cases for conversion, please
> send them. There were some minor conflicts with this patch so please
> use https://github.com/btrfs/linux branch for-next as base.
>=20

I guess no one has yet tried to run any test case with this seemingly=20
safe conversion.

It will easily hang the fs, with the following blocked processes:

[   85.124607] sysrq: Show Blocked State
[   85.125981] task:btrfs-transacti state:D stack:0     pid:1302=20
tgid:1302  ppid:2      task_flags:0x208040 flags:0x00004000
[   85.129163] Call Trace:
[   85.130115]  <TASK>
[   85.130813]  __schedule+0x40d/0x12c0
[   85.131883]  ? psi_task_switch+0x113/0x290
[   85.133119]  ? finish_task_switch.isra.0+0x92/0x290
[   85.134584]  schedule+0x27/0xd0
[   85.135567]  wait_current_trans+0x107/0x170 [btrfs=20
72a0a5602f44912ca5c15cad9f44c855141eb851]
[   85.138128]  ? __sched_core_set+0x1e0/0x1e0
[   85.139375]  start_transaction+0x383/0x830 [btrfs=20
72a0a5602f44912ca5c15cad9f44c855141eb851]
[   85.141872]  transaction_kthread+0xb8/0x1b0 [btrfs=20
72a0a5602f44912ca5c15cad9f44c855141eb851]
[   85.144361]  ? btrfs_cleanup_transaction.isra.0+0x5d0/0x5d0 [btrfs=20
72a0a5602f44912ca5c15cad9f44c855141eb851]
[   85.147191]  kthread+0xf9/0x240
[   85.148207]  ? kthreads_online_cpu+0x130/0x130
[   85.149517]  ret_from_fork+0x17b/0x1a0
[   85.150580]  ? kthreads_online_cpu+0x130/0x130
[   85.151828]  ret_from_fork_asm+0x11/0x20
[   85.153028]  </TASK>
[   85.153682] task:sync            state:D stack:0     pid:1311=20
tgid:1311  ppid:1310   task_flags:0x400100 flags:0x00004002
[   85.156609] Call Trace:
[   85.157388]  <TASK>
[   85.158041]  __schedule+0x40d/0x12c0
[   85.159143]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   85.160732]  schedule+0x27/0xd0
[   85.161728]  schedule_preempt_disabled+0x15/0x20
[   85.163141]  rwsem_down_write_slowpath+0x1fe/0x760
[   85.164563]  ? xas_load+0x9/0xc0
[   85.165531]  ? xas_find+0x136/0x180
[   85.166625]  down_write+0x52/0x60
[   85.167713]  btrfs_tree_lock_nested+0x1d/0x90 [btrfs=20
72a0a5602f44912ca5c15cad9f44c855141eb851]
[   85.170405]  btrfs_lock_root_node+0x35/0x50 [btrfs=20
72a0a5602f44912ca5c15cad9f44c855141eb851]
[   85.172992]  commit_cowonly_roots+0x49/0x260 [btrfs=20
72a0a5602f44912ca5c15cad9f44c855141eb851]
[   85.175405]  btrfs_commit_transaction+0x326/0xd70 [btrfs=20
72a0a5602f44912ca5c15cad9f44c855141eb851]
[   85.178077]  ? vfs_fsync_range+0x90/0x90
[   85.179206]  ? btrfs_attach_transaction_barrier+0x25/0x60 [btrfs=20
72a0a5602f44912ca5c15cad9f44c855141eb851]
[   85.182205]  ? vfs_fsync_range+0x90/0x90
[   85.183431]  __iterate_supers+0xd6/0x160
[   85.184616]  ksys_sync+0x63/0xa0
[   85.185608]  __do_sys_sync+0xe/0x20
[   85.186719]  do_syscall_64+0x82/0xae0
[   85.187858]  ? obj_cgroup_charge_account+0x145/0x410
[   85.189343]  ? ___pte_offset_map+0x1b/0x150
[   85.190601]  ? set_pte_range+0xf2/0x290
[   85.191775]  ? next_uptodate_folio+0x89/0x2a0
[   85.193094]  ? filemap_map_pages+0x413/0x680
[   85.194383]  ? __alloc_frozen_pages_noprof+0x19c/0x370
[   85.195903]  ? do_fault+0x342/0x5a0
[   85.196968]  ? __handle_mm_fault+0x8c4/0xf00
[   85.198265]  ? count_memcg_events+0xba/0x180
[   85.199570]  ? handle_mm_fault+0x1d3/0x2d0
[   85.200865]  ? do_user_addr_fault+0x216/0x690
[   85.202156]  ? exc_page_fault+0x7e/0x1a0
[   85.203308]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   85.204739] RIP: 0033:0x7f4e4634ce7b
[   85.205813] RSP: 002b:00007ffd7485f3c8 EFLAGS: 00000246 ORIG_RAX:=20
00000000000000a2
[   85.208142] RAX: ffffffffffffffda RBX: 00007ffd7485f5c8 RCX:=20
00007f4e4634ce7b
[   85.210268] RDX: 00007f4e4641c201 RSI: 00007f4e4641c248 RDI:=20
00007f4e463e65c9
[   85.212549] RBP: 00007ffd7485f4a0 R08: 0000000000000000 R09:=20
0000000000000000
[   85.214726] R10: 0000000000000004 R11: 0000000000000246 R12:=20
00007f4e4641c248
[   85.216901] R13: 0000000000000001 R14: 0000559279cf61d0 R15:=20
0000559279cf7b60
[   85.218907]  </TASK>

I believe it's some path not properly released.

So I have removed it from for-next for now.

Thanks,
Qu

