Return-Path: <linux-btrfs+bounces-12816-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 900CBA7CBE4
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Apr 2025 23:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA44189542B
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Apr 2025 21:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D36B1C84A3;
	Sat,  5 Apr 2025 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QTFkZA7t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F541A5B8E
	for <linux-btrfs@vger.kernel.org>; Sat,  5 Apr 2025 21:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743889279; cv=none; b=W5ZMbb+kgD188+1CfC3LisUdH0wD8tlwj5h/b85pyjm2WmZFC2edgFRH5/4pB6ZhB2AO5PEHUgcom8/pG4z++vegXAkTdb0xlKDMhUSZmaHGJsfQTBxcDn3UBnSQ9vRy3tvSjCnT0U3Cg5oj2fuEXFEK8/hM2/DfADsqteZbJmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743889279; c=relaxed/simple;
	bh=VCSDca2lAYeiKZcLzL6Icp5BWoAPUddVPWZOK96b5CY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q2MiTzD59NQ4ZV0nvBr4NsXHmmfw8szVlO7ZH9eJ+/KIZC7pub6o0mJr//EUYrZYC5ca+pNEa0Qk+MCAU3GlcdsljqXjArCeyijNUxSp8Kt9mfKiJtwHkPZu6RngGGmrWslzBE9T7m7bLgzQ7cBwiFfDQWe88n4YceF6IpcYa+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QTFkZA7t; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-391342fc0b5so2510209f8f.3
        for <linux-btrfs@vger.kernel.org>; Sat, 05 Apr 2025 14:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743889274; x=1744494074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hHKBYbvtkxRxNDs05iniVSxSujFeGIZ5ZYYE41NfMjc=;
        b=QTFkZA7tjBR1MScrxS7PpWA9RD1KkNgJwh1LSGbUkwwfqo/rVJNZPVoIA7IT2tbWPj
         Mc10NG47YyfN12742H9VeXRxQ5XdouqteoIkXXxsYOw6u7VNdaRnLVL2VesldyWzBr8I
         NjbiX6wDImvap06Ebb4k1s7rZNXJFA97SKEYW051jGrUnecG/fYYTTHoN4oQCZ1GkjI5
         I3WDy7e1Ad8GJ+sXB8uLE8sBoQ2eCKduscIHl5NFfst+7yzLiFRX2xqXxA2krcHlEyCd
         T2s+888G/hUrt2DxysrGmBvKY1MmelLgJF0Yud3RruKsGV+BZ7sPcQbNK4hr+u3Yy0oK
         TkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743889274; x=1744494074;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHKBYbvtkxRxNDs05iniVSxSujFeGIZ5ZYYE41NfMjc=;
        b=QfC/gcqr36sMOSeYkgZlJpTLSiGa88hL/tQMlOUzFH4FfPoqAy3z8VHQ/WnDby2Fno
         gpYHc3p6vv/APSFzkthGJVwWCiEN3xL+Ov9yhTMm94j1lvQXR3FeBagrIRPTGiYovzF1
         CVq0GbX2vUqOFtM9uibtn3I+eQbdMeFSNXLLzmlx2GsBGp8l+5vfSnVFTIZ4IRftTfOf
         J73WCHW9A9r0l4Oc6Q49dFSw/8DVFLQZyy+MFp87s+r+ppOlZGtTXpYIlu3cylMEVOKG
         3KeztFif28wDwK3mBXMsB54qsjM+h997v0ZbcrqbiSmd3n0fVv7xc0hdKuarHSkk7fEN
         E7Hw==
X-Forwarded-Encrypted: i=1; AJvYcCV6aW0o0Z1jvVndqiWTJ93D15+yXIu1UerbImfQXrMRGCuxusJhPEH/iepb5jrLVvwu2uAh8rLyIh0BbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YymvxreCu80zUQoEsonIpo6pU0ZzKDLu3c5VeptCOSe776eKOJD
	uWsOzDqSa3wITQKCfVScM16omU3JWh/sw9XdFOUpC42XXeMh+8mcvz2kM1DIT8bceNCXpAugHTK
	0
X-Gm-Gg: ASbGncth3qteMPyHBIX/XqLxYI2pqn1xQN0kChpaYpaBZaDzXN9skiWVeBUGlzp/1r8
	VIEJ+CKCGGLMfnLwLoHfGTkL8XZ3p1jjgW9kgXz/7FHpvY0CSVkmiqGahUhk/C/sXCLBK3a3yDG
	JGNQM0nSzqH6u3AsDLnWIJ9nRpayK2J8VD15lwAqRzasBgvVhkmYbWj96RXPt02yPMX3iNj0guK
	qWHifv9HNSbhHYQTgjIs3rd5Hp3SoJAgQkCP9H+z4VMhg62Vq/ErG06e+9P66zeZmJJnGp9NhaI
	E8UnEBPTNSWCZOWhvW0da/npUV9t4qE39gGNp79ngWaW1kHRz7MRXQ7TQC5J353NIBcDTlLl
X-Google-Smtp-Source: AGHT+IH7HlFLi7HUsu/AFRz2dc4mW1oJX8MlSaUTmF28pZSHm5ro+GngY3ZY7r33ZKc83ZNOKMLNNA==
X-Received: by 2002:a05:6000:40c7:b0:391:40bd:621e with SMTP id ffacd0b85a97d-39cba9827c6mr6906460f8f.44.1743889274295;
        Sat, 05 Apr 2025 14:41:14 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22978771190sm54275765ad.211.2025.04.05.14.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Apr 2025 14:41:13 -0700 (PDT)
Message-ID: <45e9ea01-42ce-4c31-b7ba-833d54145a2e@suse.com>
Date: Sun, 6 Apr 2025 07:11:10 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix invalid inode pointer after failure to create
 reloc inode
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <9ac220a55a540ad22f7cb198856b689079f3e8c6.1743875430.git.fdmanana@suse.com>
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
In-Reply-To: <9ac220a55a540ad22f7cb198856b689079f3e8c6.1743875430.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/6 03:21, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we have a failure at create_reloc_inode(), under the 'out' label we
> assign an error pointer to the 'inode' variable and then return a weird
> pointer because we return the expression "&inode->vfs_inode":
> 
>     static noinline_for_stack struct inode *create_reloc_inode(
>                                      const struct btrfs_block_group *group)
>     {
>         (...)
>     out:
>         (...)
>         if (ret) {
>              if (inode)
>                    iput(&inode->vfs_inode);
>              inode = ERR_PTR(ret);
>         }
>         return &inode->vfs_inode;
> }
> 
> This can make us return a pointer that is not an error pointer and make
> the caller proceed as if an error didn't happen and later result in an
> invalid memory access when dereferencing the inode pointer. The syzbot
> reported such a case with the following stack trace:
> 
>     R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
>     R13: 0000000000000000 R14: 431bde82d7b634db R15: 00007ffc55de5790
>      </TASK>
>     BTRFS info (device loop0): relocating block group 6881280 flags data|metadata
>     Oops: general protection fault, probably for non-canonical address 0xdffffc0000000045: 0000 [#1] SMP KASAN NOPTI
>     KASAN: null-ptr-deref in range [0x0000000000000228-0x000000000000022f]
>     CPU: 0 UID: 0 PID: 5332 Comm: syz-executor215 Not tainted 6.14.0-syzkaller-13423-ga8662bcd2ff1 #0 PREEMPT(full)
>     Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>     RIP: 0010:relocate_file_extent_cluster+0xe7/0x1750 fs/btrfs/relocation.c:2971
>     Code: 00 74 08 48 89 df e8 f8 36 24 fe 48 89 9c 24 30 01 00 00 4c 89 74 24 28 4d 8b 76 10 49 8d 9e 98 fe ff ff 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 ca 36 24 fe 4c 8b 3b 48 8b 44 24
>     RSP: 0018:ffffc9000d3375e0 EFLAGS: 00010203
>     RAX: 0000000000000045 RBX: 000000000000022c RCX: ffff888000562440
>     RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8880452db000
>     RBP: ffffc9000d337870 R08: ffffffff84089251 R09: 0000000000000000
>     R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
>     R13: ffffffff9368a020 R14: 0000000000000394 R15: ffff8880452db000
>     FS:  000055558bc7b380(0000) GS:ffff88808c596000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 000055a7a192e740 CR3: 0000000036e2e000 CR4: 0000000000352ef0
>     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>     Call Trace:
>      <TASK>
>      relocate_block_group+0xa1e/0xd50 fs/btrfs/relocation.c:3657
>      btrfs_relocate_block_group+0x777/0xd80 fs/btrfs/relocation.c:4011
>      btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3511
>      __btrfs_balance+0x1a93/0x25e0 fs/btrfs/volumes.c:4292
>      btrfs_balance+0xbde/0x10c0 fs/btrfs/volumes.c:4669
>      btrfs_ioctl_balance+0x3f5/0x660 fs/btrfs/ioctl.c:3586
>      vfs_ioctl fs/ioctl.c:51 [inline]
>      __do_sys_ioctl fs/ioctl.c:906 [inline]
>      __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:892
>      do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>      do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
>     RIP: 0033:0x7fb4ef537dd9
>     Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1b 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>     RSP: 002b:00007ffc55de5728 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>     RAX: ffffffffffffffda RBX: 00007ffc55de5750 RCX: 00007fb4ef537dd9
>     RDX: 0000200000000440 RSI: 00000000c4009420 RDI: 0000000000000003
>     RBP: 0000000000000002 R08: 00007ffc55de54c6 R09: 00007ffc55de5770
>     R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
>     R13: 0000000000000000 R14: 431bde82d7b634db R15: 00007ffc55de5790
>      </TASK>
>     Modules linked in:
>     ---[ end trace 0000000000000000 ]---
>     RIP: 0010:relocate_file_extent_cluster+0xe7/0x1750 fs/btrfs/relocation.c:2971
>     Code: 00 74 08 48 89 df e8 f8 36 24 fe 48 89 9c 24 30 01 00 00 4c 89 74 24 28 4d 8b 76 10 49 8d 9e 98 fe ff ff 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 ca 36 24 fe 4c 8b 3b 48 8b 44 24
>     RSP: 0018:ffffc9000d3375e0 EFLAGS: 00010203
>     RAX: 0000000000000045 RBX: 000000000000022c RCX: ffff888000562440
>     RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8880452db000
>     RBP: ffffc9000d337870 R08: ffffffff84089251 R09: 0000000000000000
>     R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
>     R13: ffffffff9368a020 R14: 0000000000000394 R15: ffff8880452db000
>     FS:  000055558bc7b380(0000) GS:ffff88808c596000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 000055a7a192e740 CR3: 0000000036e2e000 CR4: 0000000000352ef0
>     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>     ----------------
>     Code disassembly (best guess):
>        0:	00 74 08 48          	add    %dh,0x48(%rax,%rcx,1)
>        4:	89 df                	mov    %ebx,%edi
>        6:	e8 f8 36 24 fe       	call   0xfe243703
>        b:	48 89 9c 24 30 01 00 	mov    %rbx,0x130(%rsp)
>       12:	00
>       13:	4c 89 74 24 28       	mov    %r14,0x28(%rsp)
>       18:	4d 8b 76 10          	mov    0x10(%r14),%r14
>       1c:	49 8d 9e 98 fe ff ff 	lea    -0x168(%r14),%rbx
>       23:	48 89 d8             	mov    %rbx,%rax
>       26:	48 c1 e8 03          	shr    $0x3,%rax
>     * 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
>       2f:	74 08                	je     0x39
>       31:	48 89 df             	mov    %rbx,%rdi
>       34:	e8 ca 36 24 fe       	call   0xfe243703
>       39:	4c 8b 3b             	mov    (%rbx),%r15
>       3c:	48                   	rex.W
>       3d:	8b                   	.byte 0x8b
>       3e:	44                   	rex.R
>       3f:	24                   	.byte 0x24
> 
> So fix this by returning the error immediately.
> 
> Fixes: 00aad5080c51 ("btrfs: make btrfs_iget() return a btrfs inode instead")
> Reported-by: syzbot+7481815bb47ef3e702e2@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/67f14ee9.050a0220.0a13.023e.GAE@google.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/relocation.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 62b69274ec03..4bfc5403cf17 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3801,7 +3801,7 @@ static noinline_for_stack struct inode *create_reloc_inode(
>   	if (ret) {
>   		if (inode)
>   			iput(&inode->vfs_inode);
> -		inode = ERR_PTR(ret);
> +		return ERR_PTR(ret);
>   	}
>   	return &inode->vfs_inode;
>   }


