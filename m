Return-Path: <linux-btrfs+bounces-18366-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 597DEC0C9F0
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 10:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE1D934C1AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 09:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8082F0C76;
	Mon, 27 Oct 2025 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UpRN0My4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3BF2F12A0
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Oct 2025 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556944; cv=none; b=HmANMWCvpH7cXD1vQpK2wZSHMqkJEWKbRHHu4F5WkNoOx+knBxklTdD0C/oLqh0/Wjxb5mEaB1cfGfqe7MeiFNqj327I3fnj600xcRlJ0JavHQ3uB63mjmjDppHKeDbcF/RaAo0JVcgQCkpjzYypKW5ixvKYpa+zw7dZcs1yMyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556944; c=relaxed/simple;
	bh=EygS2TtS9sjd9uhhTZR0iRRgToB3z2xpYU7/QJ7sfn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=go4lux0OYL6v/EuMNTKrROx3crre2EY5yCQpep4Bgbc1ehZT9dMqcJic+y+AudUdlL1rqY7Bib5LfCoy/ivxr//pj+ysjBLqWdZw17KSU6TWcRmf/LxMjaDFoA6oFP9y9f+khRE3h6XN9vbx4pbyq+H9Aw21IGBSkyEMlRA7sr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UpRN0My4; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-427084a641aso3170905f8f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Oct 2025 02:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761556940; x=1762161740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CN6+7jGqC7vygWHJ9ykCqM62GuGs6l4t2Imuua1CC2M=;
        b=UpRN0My4cGAblPwXwQtdkaPNp10EaNpxsTn4k9SykmuFXmeb5luLPLLehQg9OTteWE
         VRZ86e6eP2c2PGuLZrAPsStIL8XKr+TRFw4EbYXZpnYvs26BpUB08qnlwIUtxk7bEgkj
         SVwZD2GmIt2sG/DmWqmpQLCZM+Whr/YRvA9AcFzzhGbF/zpTWo20qU92hibo0uCaxvou
         R7xIe0+ky8INdvUjlMFGqzwY9/NwnEux1kwxAb0/kgQS6Fb04fqSl5kcnUVZ6PGXZdy5
         HW9Q7EFIQy2Eah18IKMdAR4ZEtdm/g9Sh3D54xi1BRDeUr4h24IyZNm2uYLHSpzIe0o2
         +dRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761556940; x=1762161740;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CN6+7jGqC7vygWHJ9ykCqM62GuGs6l4t2Imuua1CC2M=;
        b=s3WWgHi+YlP7K1ttmLG1fHxcmlAt3g9e2FG+vgAQkOBy8F1/t+mfPyqNbpn6ib0bFl
         S09D1z6wTUMjhWExyv6MgtTWJTBItnO40yKc/oQQq3MgKhes2nVEE0tR7ut0dKHWOC5N
         2cL5a1DQ7TVGLJelC5YeRragGSp6qrOEZd8xRBCPM12cgoX8g5MzUXPPuYwUoxZwQOFC
         dCqPDEJNdO32VAbOU3djTxM6Jc7HzTZAbZxI1H9Af2R6L/u9SXVOJ2j3EiknnPTqv9ZZ
         JPLm7CnjtUrzrevkPr7TlUjmsAgCSyRgaPPep7JRkbJCTULkhvRyqeZTwIjxJjcFldK+
         rZ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXi+BCL5ZqZJydbQtDxUHBDpgux7LsndQN5iJJoc2lEn2wEfEdbxkwaUz0vtG1i4Hdl5X4Bfp+2DdE+Ew==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAgSukGceie8sffz9kciZA8EHTirpxw1mseFaG+FDejO/nGJH1
	QDFPQGfgSZDdB9v6SyUmMvPXkSAYxPZEUGfBaBdRlYQsvhg/dJVlb8yBSah4iUmtOJ4q7aRGu+p
	VdfGX
X-Gm-Gg: ASbGnctG62Y31BqeJyTns/fAfyDakrM3sIxY+P8fxlSxpsUFGEqCNb1HGRAvxKh5C3q
	tlU5BvpA3obY59wJTxHMqJz8FDcl2jQ034VQUVsSMxkddFgO54l4fYLJ2z1pHxasFt7MWmDPrMC
	PhSja8MCeRHy+fnhAfyuoi40KzuvPdM5fJwNyK8QX5WhbtJ5NhgpOocJCVMmhvfKs+skhYPFBT8
	byx8Mciw8+RfVNR9pU1IG9MqF6Co2LXmf0FA+XE3nRjoSc24Rol3H5xl9q0DhPsT5vAiwbdNeXI
	EFu9VcFF6AQQ76wQHrWwUOJYNpU+RWk7f7xRFysNNC304AZHEyRQQc9CWdL8qiiyD4sER9mkVOG
	8+qetrVlrXvADdzMV7js1KR0Phg1PDdPTlCYJ4N4+o6ezJKuKgDk5Ikkp0so7qBDaZ0G3CTD369
	y8AbwxEg2lSz0DtRCq+PDADbi4O66h
X-Google-Smtp-Source: AGHT+IFjv8/SvEFPTeRukOsaZIbDYdgPb3YMOFJjFA/Dtcnsoa0LNl9W2Ve/oJm4UDBTW8UQQZRszw==
X-Received: by 2002:a05:6000:2c0e:b0:429:94c3:77f with SMTP id ffacd0b85a97d-42994c30ab6mr5090975f8f.37.1761556939948;
        Mon, 27 Oct 2025 02:22:19 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0acecsm74108445ad.38.2025.10.27.02.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 02:22:19 -0700 (PDT)
Message-ID: <d955a21d-762f-4686-b099-7f7939798b13@suse.com>
Date: Mon, 27 Oct 2025 19:52:14 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] WARNING in lookup_inline_extent_backref (2)
To: syzbot <syzbot+b0e66d3779134f468156@syzkaller.appspotmail.com>,
 clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68ff35d4.050a0220.32483.0015.GAE@google.com>
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
In-Reply-To: <68ff35d4.050a0220.32483.0015.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/27 19:35, syzbot 写道:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    dbfc6422a34d Merge tag 'x86_urgent_for_v6.18_rc3' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11d993cd980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=25811b07889c90db
> dashboard link: https://syzkaller.appspot.com/bug?extid=b0e66d3779134f468156
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-dbfc6422.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/73c799811c6a/vmlinux-dbfc6422.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e1bb4619e00f/bzImage-dbfc6422.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b0e66d3779134f468156@syzkaller.appspotmail.com

This one is injecting an -ENOMEM at a critical path, which makes btrfs 
to abort the current transaction.

To be honest, syzbot should not expect a completely quite system for 
such injected error.

Thanks,
Qu
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5319 at fs/btrfs/extent-tree.c:836 lookup_inline_extent_backref+0x12c7/0x17f0 fs/btrfs/extent-tree.c:836
> Modules linked in:
> CPU: 0 UID: 0 PID: 5319 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:lookup_inline_extent_backref+0x12c7/0x17f0 fs/btrfs/extent-tree.c:836
> Code: 05 fe 26 a5 0e 48 3b 84 24 e0 01 00 00 0f 85 8e 04 00 00 89 d8 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 5b 4b 81 07 cc 90 <0f> 0b 90 48 8b 44 24 78 42 80 3c 30 00 74 0a 48 8b 7c 24 20 e8 90
> RSP: 0000:ffffc9000d23e820 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000000
> RDX: ffff888000784900 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: ffffc9000d23ea48 R08: 0000000000000000 R09: 1ffffd40002891c8
> R10: dffffc0000000000 R11: fffff940002891c9 R12: 1ffff1100a23a242
> R13: 00000000000000b2 R14: dffffc0000000000 R15: ffff8880110e2000
> FS:  00007f1616ed56c0(0000) GS:ffff88808d733000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7e2ed37000 CR3: 000000003f2e0000 CR4: 0000000000352ef0
> Call Trace:
>   <TASK>
>   insert_inline_extent_backref+0xa8/0x2f0 fs/btrfs/extent-tree.c:1205
>   __btrfs_inc_extent_ref+0x263/0x9e0 fs/btrfs/extent-tree.c:1503
>   run_one_delayed_ref fs/btrfs/extent-tree.c:-1 [inline]
>   btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1972 [inline]
>   __btrfs_run_delayed_refs+0xebd/0x4130 fs/btrfs/extent-tree.c:2047
>   btrfs_run_delayed_refs+0xe6/0x3b0 fs/btrfs/extent-tree.c:2159
>   btrfs_start_dirty_block_groups+0xd3d/0x10a0 fs/btrfs/block-group.c:3534
>   btrfs_commit_transaction+0x674/0x3950 fs/btrfs/transaction.c:2241
>   btrfs_sync_file+0xd30/0x1160 fs/btrfs/file.c:1818
>   generic_write_sync include/linux/fs.h:3046 [inline]
>   btrfs_do_write_iter+0x59a/0x710 fs/btrfs/file.c:1469
>   iter_file_splice_write+0x975/0x10e0 fs/splice.c:738
>   do_splice_from fs/splice.c:938 [inline]
>   direct_splice_actor+0x101/0x160 fs/splice.c:1161
>   splice_direct_to_actor+0x5a8/0xcc0 fs/splice.c:1105
>   do_splice_direct_actor fs/splice.c:1204 [inline]
>   do_splice_direct+0x181/0x270 fs/splice.c:1230
>   do_sendfile+0x4da/0x7e0 fs/read_write.c:1370
>   __do_sys_sendfile64 fs/read_write.c:1431 [inline]
>   __se_sys_sendfile64+0x13e/0x190 fs/read_write.c:1417
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f1615f8efc9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f1616ed5038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 00007f16161e6090 RCX: 00007f1615f8efc9
> RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000008
> RBP: 00007f1616011f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 000000007ffff000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f16161e6128 R14: 00007f16161e6090 R15: 00007fff32122a28
>   </TASK>
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


