Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14003A6E6D
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Jun 2021 20:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbhFNS4G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Jun 2021 14:56:06 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:34604 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbhFNS4F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Jun 2021 14:56:05 -0400
Received: by mail-qt1-f177.google.com with SMTP id u20so9385507qtx.1
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Jun 2021 11:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LsxxzhDAt0cyX21wSpSzW9B7eIE5gsFNuCODsfXCxLs=;
        b=BWv9nXi2eSS+briii2CN777aKBTjzeFVwNj9cOgcDo47cmkClDrJAOLp7bq0hoKw3K
         jFpvLwRFnmL0qPoWVOOzcIVltxV0ButJOgw6hBbYTwX9RyCBzIYCqlraNu/R0vh5vrEZ
         +UhRVqHmUTY5QyrA2xKDvcny35akhWEZ3SfCezR6ELNVZryYl4VfEU7xaheTtIqRAotg
         oX1l29ww0rOUpxFeQDDOKv2EUo4X8SPejdPPe8U9A8kvJ8XKiLmBmTUQ8IBdei1sxbnN
         2MmgHW/GiBa9yyoz5sm/78obAaVR14dzv5xeOXb9se08eUT6HemTKLV2ktYC3mUNU0rv
         DeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LsxxzhDAt0cyX21wSpSzW9B7eIE5gsFNuCODsfXCxLs=;
        b=BF395VC+xTXVp2b5d7i/cpfbJtvstUILa0HTQYO/7QK8LWTtVfHTjNX2o9H0nln4i2
         7pGTmvUi4XE6zQGZbM10FJz9BcifEAcNx1GhpFOilsVhGoZBs7Vj1pKGoXLppCsFnPea
         ky0fZy+MJ/lXLXNsStUAFTT+zoHO4DNGYDcFO0a0AHndS0xJbGvhzu/SFUNOjYA+QN+/
         Nog0JDgAjutBgaOD9IZX9y9yebvmt9NSuifq/HhEndZ2yyoAO48Cbd7qHYNmBA6tv3WL
         sldXedqjc3ADDK+Y7DmVA7IAlVQ8t4rfpEmmHT5LuBAD/ilqFnd3lPHK7RoDwbBxAGfz
         RzvQ==
X-Gm-Message-State: AOAM530fX/gBUeF0AC1I5/R0xahcUGHd9dnIGNplgOUBSH1fGFnThJYp
        I350Ix/81U9+YKEjNma87/mugw==
X-Google-Smtp-Source: ABdhPJxzcRKLaj9v0WCybLcKXJSdjgERUTuQy/oj4is1kn7qZ/gygWLfi/Co83JAj7esKo6VPWS/wA==
X-Received: by 2002:a05:622a:1751:: with SMTP id l17mr17887789qtk.35.1623696782026;
        Mon, 14 Jun 2021 11:53:02 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::1287? ([2620:10d:c091:480::1:a94c])
        by smtp.gmail.com with ESMTPSA id v16sm10593792qkj.10.2021.06.14.11.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 11:53:01 -0700 (PDT)
Subject: Re: [syzbot] KMSAN: uninit-value in generic_bin_search (2)
To:     syzbot <syzbot+8aa9678d1cda7a0432b7@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, glider@google.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000009c083105c4b34e70@google.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8ba465e6-f933-6224-ef74-c5aa898a1022@toxicpanda.com>
Date:   Mon, 14 Jun 2021 14:52:59 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0000000000009c083105c4b34e70@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/14/21 1:41 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    6099c9da x86: entry: speculatively unpoison pt_regs in do_..
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=12c7a057d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4e6842a91012889c
> dashboard link: https://syzkaller.appspot.com/bug?extid=8aa9678d1cda7a0432b7
> compiler:       Debian clang version 11.0.1-2
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8aa9678d1cda7a0432b7@syzkaller.appspotmail.com
> 
>   tracehook_notify_resume include/linux/tracehook.h:189 [inline]
>   exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
>   exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
>   __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
>   syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
>   __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
>   do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
>   do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
>   entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> =====================================================
> =====================================================
> BUG: KMSAN: uninit-value in btrfs_comp_cpu_keys fs/btrfs/ctree.c:1556 [inline]
> BUG: KMSAN: uninit-value in comp_keys fs/btrfs/ctree.c:1528 [inline]
> BUG: KMSAN: uninit-value in generic_bin_search+0x799/0xbc0 fs/btrfs/ctree.c:1702
> CPU: 1 PID: 9364 Comm: syz-executor.2 Tainted: G    B             5.12.0-rc6-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:79 [inline]
>   dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
>   kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
>   __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
>   btrfs_comp_cpu_keys fs/btrfs/ctree.c:1556 [inline]
>   comp_keys fs/btrfs/ctree.c:1528 [inline]
>   generic_bin_search+0x799/0xbc0 fs/btrfs/ctree.c:1702
>   btrfs_bin_search fs/btrfs/ctree.c:1724 [inline]

This appears to be a bug in KMSAN, the code is doing the correct thing and it 
appears to be complaining about tmp, which is initialized either in the if or 
else part.  The else part may be what's confusing KMSAM here as it's essentially

struct btrfs_disk_key tmp;
struct btrfs_disk_key unaligned;

else {
      memcpy(&unaligned, ptr, len); // read_extent_buffer is basically memcpy
      tmp = &unaligned;
}

Thanks,

Josef
