Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4804711AE67
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 15:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfLKOxV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 09:53:21 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43902 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbfLKOxV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 09:53:21 -0500
Received: by mail-qk1-f194.google.com with SMTP id t129so14838839qke.10
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2019 06:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZyYji93rIaV1cslRVYaWHo0HvtdPD42Ypjb5hLGqUhs=;
        b=xywL0WkknfNb723Kf1xX0sU4H99/001+vhtiKq1kIOx5ZOq+Cp2wJYde3dcMSaeKUt
         VR9hwJvAtax2mc0Cr+fBUc8PiN0RxIOskw5Rhhe28CZl+Z4TNSQiOkKgJFQvD8wudylX
         u//1ageqivto5/rCR0Ix6M6CqNteDLu7ecPSa3v1FJXWz23WFoG6wnU/VH9pY2mWU33C
         UboCBJkmT0rphRpImy0Mq2UBuxqLtVoSs3ASqQDMFalG8m+Qztm9/aYe0GUwLLhfS/J0
         R2WHoyBoXobsga/AwHZbCr1vmlNmC2EMuEeZ32O8xLxMs2EacNrH7wLUIaCbr+EX+Tue
         HBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZyYji93rIaV1cslRVYaWHo0HvtdPD42Ypjb5hLGqUhs=;
        b=WJkGOhAkUOCe+DweRd1IOO2K4bVTMywGnDlAcMb2Oj5KOYeK4fJAJku2fvqfcWA9nf
         A5rGbWbb90pApIzqtgDwldqNRGjAVlmi/KWRLl/hJ2iGcipABg5bxEXJX2NVs8aqovRp
         HtUm+CwOK/z5ziOPdIDJO+BfpqyLo4cXjAJflY+RnwMrGppDcrEAkxPFGyF8xmO5MkBg
         +xzByoINZ73tMgObRBEmYbqC6JOzcBjXyjCBEfjs3WIFPiScCcmW9bBJ2279qOsJJrkC
         uPnNsoplfOyp9us7rR6TAdxjwsxj1ryH54XjfDlklx34x1cjotgriS9Zgui9AF8lNhgi
         yGgw==
X-Gm-Message-State: APjAAAWHT/gg8avyrsDpv5Kk4VhC6VCPtIMory3MypgLpmb6+VBz7cOd
        syG0M9/RzKPk+OsgePQIwI63zg==
X-Google-Smtp-Source: APXvYqwxZ1rjUGvslDIrscnWDoUF+EUNICkPjXl1Tnj2lYwfH9daQts6FrMs7YZv7T0Qm3kmxrgSsQ==
X-Received: by 2002:a05:620a:1663:: with SMTP id d3mr3343776qko.204.1576076000697;
        Wed, 11 Dec 2019 06:53:20 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4149])
        by smtp.gmail.com with ESMTPSA id l37sm989182qtl.53.2019.12.11.06.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 06:53:19 -0800 (PST)
Subject: Re: [PATCH 1/3] btrfs: relocation: Fix a KASAN use-after-free bug due
 to extended reloc tree lifespan
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <20191211050004.18414-1-wqu@suse.com>
 <20191211050004.18414-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6f18b194-4df5-4e74-d4e2-f9e9643dba02@toxicpanda.com>
Date:   Wed, 11 Dec 2019 09:53:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191211050004.18414-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/11/19 12:00 AM, Qu Wenruo wrote:
> [BUG]
> When running a workload with balance start/cancel, snapshot creation and
> deletion, and fsstress, we can get the following KASAN report:
> 
>    ==================================================================
>    BUG: KASAN: use-after-free in should_ignore_root+0x54/0xb0 [btrfs]
>    Read of size 8 at addr ffff888146e340f0 by task btrfs/1216
> 
>    CPU: 6 PID: 1216 Comm: btrfs Tainted: G           O      5.5.0-rc1-custom+ #40
>    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>    Call Trace:
>     dump_stack+0xc2/0x11a
>     print_address_description.constprop.0+0x20/0x210
>     __kasan_report.cold+0x1b/0x41
>     kasan_report+0x12/0x20
>     check_memory_region+0x13c/0x1b0
>     __asan_loadN+0xf/0x20
>     should_ignore_root+0x54/0xb0 [btrfs]
>     build_backref_tree+0x11af/0x2280 [btrfs]
>     relocate_tree_blocks+0x391/0xb80 [btrfs]
>     relocate_block_group+0x3e5/0xa00 [btrfs]
>     btrfs_relocate_block_group+0x240/0x4d0 [btrfs]
>     btrfs_relocate_chunk+0x53/0xf0 [btrfs]
>     btrfs_balance+0xc91/0x1840 [btrfs]
>     btrfs_ioctl_balance+0x416/0x4e0 [btrfs]
>     btrfs_ioctl+0x8af/0x3e60 [btrfs]
>     do_vfs_ioctl+0x831/0xb10
>     ksys_ioctl+0x67/0x90
>     __x64_sys_ioctl+0x43/0x50
>     do_syscall_64+0x79/0xe0
>     entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> [CAUSE]
> When should_ignore_root() accessing root->reloc_root, the reloc_root can
> be being dropped, thus root->reloc_root can be unreliable.
> 
> [FIX]
> Check DEAD_RELOC_ROOT bit before accessing root->reloc_root.
> 
> Furthermore in the context of should_ignore_root(), if the root has
> already gone through tree merge, we don't need to trace that root
> anymore.
> Thus we need to return 1, for root with dead reloc root.
> 
> Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after merge_reloc_roots")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
