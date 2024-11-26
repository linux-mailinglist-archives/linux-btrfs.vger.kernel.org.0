Return-Path: <linux-btrfs+bounces-9911-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C34C9D9381
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 09:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06DD3B2605B
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 08:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DC81B85CC;
	Tue, 26 Nov 2024 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SHwOsWIV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574EA195FEF
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732610630; cv=none; b=AZFWcRqxdCzsE+YikOv4MN/gN1TqXe0qfFMtFZCcES3ClVxOZNApkkpnq0RVxF1Pw4fu9SBmnFI5nkBdMcc6r+6DhMZAL/LM8dU7VyDAjYCm97cucCYi+3eyfq6GfLEkWO8+V/rZFiAhSMQDA8jMGpruBLDpYTVnltwYWFur9vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732610630; c=relaxed/simple;
	bh=m4SrXB4p4EPxcgn8iBtlNFYDIWoRqI0Yi+4+wyjyuBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BgDDJAGVlhsqjQ2WfxoFDJGrx/CNNCjlv6EgDXhsyP5i+oVKC7XWfnjNQsD0xmlr1KFc7m5AcmHd0q18mLqRn1ClKppyz/W7IbZCUsVDvFXe10IKvvQR6y3nNMdLL2bYktxavkjtLDJ/3rdIrDbO1R/bRpFe1/WbVCNbhHD2+Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SHwOsWIV; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53dde9acbb0so3064210e87.3
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 00:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732610624; x=1733215424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YwWSRx5u97W/Hl2pIyY6PV9jf5U88VgpobHkBfCMFnA=;
        b=SHwOsWIVR1X0dt4fP+1AbYVTwVkD9d2BT59HBKmAtM8wvFBoE+Kh1wlg71KiLYay6z
         TZsKKIoCBmSROh/9/2b8NXmrZBhDyZLA/TjBpvvcDWFWc0Q+I8ewiA49K3nopbRPLLGC
         ZigmZZR4k63XljmtiaK5UDWifEuZYptS0KKus3L6I4V/BO13klb10BE5MUTrU3suH62m
         gytG92gRqddxjVG5NC6xcHQii6O7ugkuiJeVKHZPcozUDVMARFsegd/mRR+GgLITfQX+
         01y2m1cyDMonGzQFVblzMpxYBHrSmgohpGzbYx1jTMn+Y6gLIHJhfKpbAXFvx2YzV0px
         simw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732610624; x=1733215424;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwWSRx5u97W/Hl2pIyY6PV9jf5U88VgpobHkBfCMFnA=;
        b=tIQQLo/PpEQA6lsHgMp8/lSgFONrQXr5ON0k6GUMrpsecZTmrWAhICc4+JlN6JL4Yt
         7JVEEjrllYFBRjeEQRzHPdtD7Vh0ztsqC/MbNETGQc3CXznktWh0DQybSrejZ7W7DhS7
         2aSD4jjqfGnpMRZK11G/LQ1YPd2xFbf3PD3MG6rU3c64291/qyBIVd11deruqmUP2+Ki
         unffRizquVSPjZL3EEDa33pMGQlt8xVPqGFMkY/DKJ49vysUKSV6nOcTqCgUGN6rNthe
         I8IEA6wbMBhuHAJQtKZBQnEa73soBzE6BPDjrQDy1Hffz/i9ot89hUkb6wi8Q3acK5y2
         kH1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfGyv7a5RAvZTDWB+BxNbEQgFgS7lqkDOgx8jHrGtlxp/HfDj0NFXkCghRlQhAvEPQ5Wxsv6TDcBHqUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfeZlNfGU4RAEuEWVf2mnic4aa8gPhNnKxeFUN4fGJt8r/bwUB
	bF///QDxssN8HbDwvvmmXYq8PzjDvvWgpQQCuOveqG8EtfzJPTFXA1FUm5F8eKY=
X-Gm-Gg: ASbGncsJqw5MGVluhIrXuobkzzV5XZMyWbNuTJ1GqCYop8Qs5FFiQwxJfHOV6OdbGwC
	juuXKt63YRNbUymzUmWh7j8BhZoASZAG4rRS+jSOIAIkxD4O5pnziWdnz2ISxK7oncMdnYjyzWR
	imqqDR1aw2zx2JAfEE2I/vyygPBedTLHmM7PcbbBhDmyvARAdC/WLjmhpv9ScOmc/y7ls8PDncG
	MVBBLXuluIyqXF1w0pZ06Drk7hiYwTfI6gNgBkjgdYcyjbNa9mif6qzwWbJjTc2mf92FrxbNJNW
	+g==
X-Google-Smtp-Source: AGHT+IGXID7oHO5S0gVKrM+lQoYHeK/Ra/9fruJb/FoWS5RxVJBRQowL6MI4jlYsMU160B/ko0pNQQ==
X-Received: by 2002:a05:6512:ac7:b0:53d:e8ed:21c1 with SMTP id 2adb3069b0e04-53de8ed2714mr977868e87.7.1732610623980;
        Tue, 26 Nov 2024 00:43:43 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc3de2c3sm6970904a12.62.2024.11.26.00.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 00:43:43 -0800 (PST)
Message-ID: <ac211a22-c93a-4443-9053-1d09d79fcb1c@suse.com>
Date: Tue, 26 Nov 2024 19:13:37 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] kernel BUG in __folio_start_writeback
To: Aleksandr Nogikh <nogikh@google.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 syzbot <syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
 josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
References: <67432dee.050a0220.1cc393.0041.GAE@google.com>
 <Z0OaHcMWcRtohZfz@casper.infradead.org>
 <b57b3d18-7a70-4efa-a356-809c6ab29c02@suse.com>
 <CANp29Y7KjqP9h1ONFG5LW=3Nc0RWgcdj4PmAszqze0azPpvdLg@mail.gmail.com>
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
In-Reply-To: <CANp29Y7KjqP9h1ONFG5LW=3Nc0RWgcdj4PmAszqze0azPpvdLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/25 21:14, Aleksandr Nogikh 写道:
> On Mon, Nov 25, 2024 at 1:30 AM 'Qu Wenruo' via syzkaller-bugs
> <syzkaller-bugs@googlegroups.com> wrote:
>>
>>
>>
>> 在 2024/11/25 07:56, Matthew Wilcox 写道:
>>> On Sun, Nov 24, 2024 at 05:45:18AM -0800, syzbot wrote:
>>>>
>>>>    __fput+0x5ba/0xa50 fs/file_table.c:458
>>>>    task_work_run+0x24f/0x310 kernel/task_work.c:239
>>>>    resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>>>>    exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>>>>    exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>>>>    __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>>>>    syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
>>>>    do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>>>>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>
>>> This is:
>>>
>>>           VM_BUG_ON_FOLIO(folio_test_writeback(folio), folio);
>>>
>>> ie we've called __folio_start_writeback() on a folio which is already
>>> under writeback.
>>>
>>> Higher up in the trace, we have the useful information:
>>>
>>>    page: refcount:6 mapcount:0 mapping:ffff888077139710 index:0x3 pfn:0x72ae5
>>>    memcg:ffff888140adc000
>>>    aops:btrfs_aops ino:105 dentry name(?):"file2"
>>>    flags: 0xfff000000040ab(locked|waiters|uptodate|lru|private|writeback|node=0|zone=1|lastcpupid=0x7ff)
>>>    raw: 00fff000000040ab ffffea0001c8f408 ffffea0000939708 ffff888077139710
>>>    raw: 0000000000000003 0000000000000001 00000006ffffffff ffff888140adc000
>>>    page dumped because: VM_BUG_ON_FOLIO(folio_test_writeback(folio))
>>>    page_owner tracks the page as allocated
>>>
>>> The interesting part of the page_owner stacktrace is:
>>>
>>>     filemap_alloc_folio_noprof+0xdf/0x500
>>>     __filemap_get_folio+0x446/0xbd0
>>>     prepare_one_folio+0xb6/0xa20
>>>     btrfs_buffered_write+0x6bd/0x1150
>>>     btrfs_direct_write+0x52d/0xa30
>>>     btrfs_do_write_iter+0x2a0/0x760
>>>     do_iter_readv_writev+0x600/0x880
>>>     vfs_writev+0x376/0xba0
>>>
>>> (ie not very interesting)
>>>
>>>> Workqueue: btrfs-delalloc btrfs_work_helper
>>>> RIP: 0010:__folio_start_writeback+0xc06/0x1050 mm/page-writeback.c:3119
>>>> Call Trace:
>>>>    <TASK>
>>>>    process_one_folio fs/btrfs/extent_io.c:187 [inline]
>>>>    __process_folios_contig+0x31c/0x540 fs/btrfs/extent_io.c:216
>>>>    submit_one_async_extent fs/btrfs/inode.c:1229 [inline]
>>>>    submit_compressed_extents+0xdb3/0x16e0 fs/btrfs/inode.c:1632
>>>>    run_ordered_work fs/btrfs/async-thread.c:245 [inline]
>>>>    btrfs_work_helper+0x56b/0xc50 fs/btrfs/async-thread.c:324
>>>>    process_one_work kernel/workqueue.c:3229 [inline]
>>>
>>> This looks like a race?
>>>
>>> process_one_folio() calls
>>> btrfs_folio_clamp_set_writeback calls
>>> btrfs_subpage_set_writeback:
>>>
>>>           spin_lock_irqsave(&subpage->lock, flags);
>>>           bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits)
>>> ;
>>>           if (!folio_test_writeback(folio))
>>>                   folio_start_writeback(folio);
>>>           spin_unlock_irqrestore(&subpage->lock, flags);
>>>
>>> so somebody else set writeback after we tested for writeback here.
>>
>> The test VM is using X86_64, thus we won't go into the subpage routine,
>> but directly call folio_start_writeback().
>>
>>>
>>> One thing that comes to mind is that _usually_ we take folio_lock()
>>> first, then start writeback, then call folio_unlock() and btrfs isn't
>>> doing that here (afaict).  Maybe that's not the source of the bug?
>>
>> We still hold the folio locked, do submission then unlock.
>>
>> You can check extent_writepage(), where at the entrance we check if the
>> folio is still locked.
>> Then inside extent_writepage_io() we do the submission, setting the
>> folio writeback inside submit_one_sector().
>> Eventually unlock the folio at the end of extent_writepage(), that's for
>> the uncompressed writes.
>>
>> There are a lot of special handling for async submission (compression),
>> but it  still holds the folio locked, do compression and submission, and
>> unlock, just all in another thread (this case).
>>
>> So it looks like something is wrong when transferring the ownership of
>> the page cache folios to the compression path, or some not properly
>> handled error path.
>>
>> Unfortunately I'm not really able to reproduce the case using the
>> reproducer...
> 
> I've just tried to reproduce locally using the downloadable assets and
> the kernel crashed ~ after 1 minute of running the attached C repro.
> 
> [   87.616440][ T9044] ------------[ cut here ]------------
> [   87.617126][ T9044] kernel BUG at mm/page-writeback.c:3119!
> [   87.619308][ T9044] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> [   87.620174][ T9044] CPU: 1 UID: 0 PID: 9044 Comm: kworker/u10:6 Not
> tainted 6.12.0-syzkaller-08446-g228a1157fb9f #0
> 
> Here are the instructions I followed:
> https://github.com/google/syzkaller/blob/master/docs/syzbot_assets.md#run-a-c-reproducer

Thanks for the confirmation.

I can reproduce it using the exact disk image (around 1min), but not 
inside my usual development VM (over 5min).

So it will a lot tricky to debug now...

Thanks,
Qu

