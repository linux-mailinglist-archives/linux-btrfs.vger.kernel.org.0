Return-Path: <linux-btrfs+bounces-9982-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DD69DEF2A
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Nov 2024 07:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616FC2818D4
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Nov 2024 06:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059061487C8;
	Sat, 30 Nov 2024 06:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SlSm4s0g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CD5130E4A
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Nov 2024 06:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732948624; cv=none; b=bRlXRChk4CAycRPBld3esG4nt2dNleBA5Qru3QaiSD/KBafsITKswtPlxGV4B+ryx1aIUNd1lXcdFTnlwLJ2Si9MllbChBAE9mHU689hhDdZwOYT4/fLDI6xqJknyI4h5Bc4f8OdXlye1qLEjpRmbR7rNholo7+mJlMr9cy+Tb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732948624; c=relaxed/simple;
	bh=qq9AwRXG9Y0MKpI/uuID0yHTuLcUuXdr+9+Cxu/cWlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iSyvZbHLEFAJik42Izp4y1SgdVOivi+E6C1pYw9vradtMfZz99rZf3nX/bsm4iPe7Qbc4VDUW/RkQhyexP5IF28drD1zMTDXxrq+4Chs/J8OZ07F/BP+wDXefaZsrIZhNXU4Cyh6D7rrpQ2Q9Gv7WIpkSRiqIIejcj6BpTKz9Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SlSm4s0g; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385e27c75f4so338836f8f.2
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2024 22:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732948619; x=1733553419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P+ctTfoeCCp7NyB71Xn2LcHzgljZipVMdjQU3ruAJ8Y=;
        b=SlSm4s0gG0mgw/+JGsHmWre7b88rNgfQq/icESkghrp5t0lNT2qdboWETxQaPPYZKM
         4T1QNcEeZ/MDkuZgPtuGx6RQXg3koeP6FbMG4Q6t6lwJG5Kr2DkmAXTrgwS6kj/1orv7
         yqH0z+guLyRXqd3joPmn2niNIuXA79W8iqs5Q8DFhDiO4Vt2Kt5BOdjhjAJYhgoA6r50
         AMTXHWosV9pW7Sxhln9voWZgnM46dBfDhZTX9joS2fwbmzx2blKiB9rR7s5RVmqsasm6
         pubT8YMSTdtdA7+56fpeF/RDhznTm0yJQHT32xZ6m9+g1fe6rJejFePccN8/c6q92mKF
         nnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732948619; x=1733553419;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+ctTfoeCCp7NyB71Xn2LcHzgljZipVMdjQU3ruAJ8Y=;
        b=cm5kGLitVGGZGWJrDleQxUXLGiOx+SwJ6BmwBf8tsCbbAoeeLCIXbP2ZbAlFaKLzIB
         tFQxkIyQSsO6cY/AtU1SNSMge2zobRL2V8x7/qQHEfpiYIcXxkhWu9HKiMlKVWeNT1w9
         XghpcKc9ztCeQUhdrHLpcarQ+Y8YGp1r9AXarhC5kAmKHVAful4oeewHQ50wmhtF5G83
         DKMGqk2bppwYyg7ss04N45JYcAYe+ty1sFm4bLuJQWYjxbzuzi5pv6Mj6ybx+SAmvTCz
         c05zNe65aBITzCwhuosMF+CMwczV4Nbi4wOiXe4h8DkMESn1L+XPq5gaiZEMMGGdLJIY
         xXtg==
X-Forwarded-Encrypted: i=1; AJvYcCXG/kSqETgVi6/rEo1nMF7KQyAm4MN8ULtG+G1vEhRAG3cco0e3SHT3h/4msOtzdaMKrVkEx9e/YOPPOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPbapzEUyelXmehE/i8q+mgGnMr1aPpQJxsELjIfDsVJYrN01T
	PHe/+639E6MVC9R616NE5iJhIvMHyagiulP3CmKKXNmzSx6bWD9YkNQAA3DZRPc=
X-Gm-Gg: ASbGncul4Bk9+wNHRYy9VeSNa3VjQYnYrffOcJiHbsLqAxcpZ/2V3kH0MTt6dCqxI9P
	isuC32p9AlYJRfChYOL4NJOCK3jAUwRG/6rbnxlYh8EXsT8sZshY9l1Zo5eb1pCxvSxWHmXsfZl
	SuXu/w3N2zMOBRodDRsUo40OGncajUMHvMOL78yN810acgmjVrV5zPpWFJz2T1/kTTtbkylD984
	rFogrj2nPX65gd+KhD5ZlzMwhzqgA5X2yF/34XCZRKRv+PUJz1dZEVXMdp/3NtpLsuWcmH2GFxC
	aw==
X-Google-Smtp-Source: AGHT+IGcLElPDk4aF16QViUhmHGp0ugDNRn8khESMWAYIIEkrD7KWvr6m9CIfQ/45+5sU4LYWA4PBQ==
X-Received: by 2002:a05:6000:18ac:b0:385:df6d:6fc7 with SMTP id ffacd0b85a97d-385df6d71b8mr4417022f8f.25.1732948618616;
        Fri, 29 Nov 2024 22:36:58 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21542d8d5e6sm21673685ad.206.2024.11.29.22.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 22:36:57 -0800 (PST)
Message-ID: <7a8955d4-4283-426f-8bbf-8f81787fb08e@suse.com>
Date: Sat, 30 Nov 2024 17:06:52 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] kernel BUG in __folio_start_writeback
To: syzbot <syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
 josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, willy@infradead.org
References: <67432dee.050a0220.1cc393.0041.GAE@google.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <67432dee.050a0220.1cc393.0041.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

#syz test: https://github.com/adam900710/linux.git writeback_fix

在 2024/11/25 00:15, syzbot 写道:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    228a1157fb9f Merge tag '6.13-rc-part1-SMB3-client-fixes' o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13820530580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=402159daa216c89d
> dashboard link: https://syzkaller.appspot.com/bug?extid=aac7bff85be224de5156
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13840778580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17840778580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/d32a8e8c5aae/disk-228a1157.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/28d5c070092e/vmlinux-228a1157.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/45af4bfd9e8e/bzImage-228a1157.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/69603aa12e8f/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com
> 
>   __fput+0x5ba/0xa50 fs/file_table.c:458
>   task_work_run+0x24f/0x310 kernel/task_work.c:239
>   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>   exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>   exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>   __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>   syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
>   do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> ------------[ cut here ]------------
> kernel BUG at mm/page-writeback.c:3119!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:1 Not tainted 6.12.0-syzkaller-08446-g228a1157fb9f #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Workqueue: btrfs-delalloc btrfs_work_helper
> RIP: 0010:__folio_start_writeback+0xc06/0x1050 mm/page-writeback.c:3119
> Code: 25 ff 0f 00 00 0f 84 d3 00 00 00 e8 14 ae c3 ff e9 ba f5 ff ff e8 0a ae c3 ff 4c 89 f7 48 c7 c6 00 2e 14 8c e8 8b 4f 0d 00 90 <0f> 0b e8 f3 ad c3 ff 4c 89 f7 48 c7 c6 60 34 14 8c e8 74 4f 0d 00
> RSP: 0018:ffffc90000117500 EFLAGS: 00010246
> RAX: ed413247a2060f00 RBX: 0000000000000002 RCX: 0000000000000001
> RDX: dffffc0000000000 RSI: ffffffff8c0ad620 RDI: 0000000000000001
> RBP: ffffc90000117670 R08: ffffffff942b2967 R09: 1ffffffff285652c
> R10: dffffc0000000000 R11: fffffbfff285652d R12: 0000000000000000
> R13: 1ffff92000022eac R14: ffffea0001cab940 R15: ffff888077139710
> FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f6661870000 CR3: 00000000792b2000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   process_one_folio fs/btrfs/extent_io.c:187 [inline]
>   __process_folios_contig+0x31c/0x540 fs/btrfs/extent_io.c:216
>   submit_one_async_extent fs/btrfs/inode.c:1229 [inline]
>   submit_compressed_extents+0xdb3/0x16e0 fs/btrfs/inode.c:1632
>   run_ordered_work fs/btrfs/async-thread.c:245 [inline]
>   btrfs_work_helper+0x56b/0xc50 fs/btrfs/async-thread.c:324
>   process_one_work kernel/workqueue.c:3229 [inline]
>   process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
>   worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>   kthread+0x2f0/0x390 kernel/kthread.c:389
>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__folio_start_writeback+0xc06/0x1050 mm/page-writeback.c:3119
> Code: 25 ff 0f 00 00 0f 84 d3 00 00 00 e8 14 ae c3 ff e9 ba f5 ff ff e8 0a ae c3 ff 4c 89 f7 48 c7 c6 00 2e 14 8c e8 8b 4f 0d 00 90 <0f> 0b e8 f3 ad c3 ff 4c 89 f7 48 c7 c6 60 34 14 8c e8 74 4f 0d 00
> RSP: 0018:ffffc90000117500 EFLAGS: 00010246
> RAX: ed413247a2060f00 RBX: 0000000000000002 RCX: 0000000000000001
> RDX: dffffc0000000000 RSI: ffffffff8c0ad620 RDI: 0000000000000001
> RBP: ffffc90000117670 R08: ffffffff942b2967 R09: 1ffffffff285652c
> R10: dffffc0000000000 R11: fffffbfff285652d R12: 0000000000000000
> R13: 1ffff92000022eac R14: ffffea0001cab940 R15: ffff888077139710
> FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055ec8463e668 CR3: 000000007ed5e000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 


