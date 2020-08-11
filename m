Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C61E241FE7
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 20:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgHKSsR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 14:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgHKSsR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 14:48:17 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA14FC06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 11:48:16 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id r19so6462976qvw.11
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 11:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GryncnPce8IhMw4EZmBKE9SlcdmJZwqSdRc/hcXty0A=;
        b=nFjzuKby502Y9O3K7XqZLiRsAfecPKIPCmE0yng6S4hLgYd3acxBt0j3GkEeaFpe9l
         ZfwePuDbEX0D739oob8QwNrKFx1NXKIR3zcheaqzTkzzN/v5BIQ6OOov1WbAe1p48kyc
         LPHrSEmGO7dbO9wbj57jGc1LKt47538y8jhKCsawSTdl+LEJgLrMEfOix4ImBv1sGeNR
         rzDto1bYbTelGISpjYl8CvpK2lCG7HA+dPOUj4tUhTvt/Fq4W2oAMTpMpNTM7bsEZw+0
         qB7TL/lmgV9MrF4FjikXhOAwYftvHTWuukkm2AfojZv8nVsrvALGJmdYJhA+ybM6pdw5
         7Sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GryncnPce8IhMw4EZmBKE9SlcdmJZwqSdRc/hcXty0A=;
        b=pmyq5I3bSvvPfw6f68GLQjcepe49pxzMq/pSc/m5Q3y9VTaTdlEyZQTH2dURGAWxhl
         /BM2rGuCzIVMdbzKbGfpfrmWcdDZ+wXvnq0wvCL0ad1l+ZLl2WjpVFp2Y5p0FKOqgXrC
         1JemTP0R45XgcHjBDXbhwWLOwvvEDU5X9PBnK3aLShcsZyvPBoMJD1cAYe5d2OXBJepy
         JXXpAVHhyC1Ve1x38/Aar5Ps1g7B/gy/8dcFaykT8sAIeFvdmb/BMjoTzPpOe0XiZG8Y
         hVa1Dv01vxEWY70xN7FUXqfGi2s/Lq1hXEZZ7DgoDrfPi9GzYUaKC8g7eQwLU0OMJovF
         xKGQ==
X-Gm-Message-State: AOAM531gz4Gy6bfzqEnjEdX66E6hBx3KHfywAkJIx+oyi+yP34Y8P5vt
        mC3AHyRBO4XP+65S7Gwur/fwTCOGesdLeA==
X-Google-Smtp-Source: ABdhPJzfu1XyWcZ+9v1OrPi945ztr+4eXyOJ5pfy9Pd52Y8kgPN9OO5Vo+By8OWSNJb5R/DM5Atafw==
X-Received: by 2002:a0c:cd02:: with SMTP id b2mr2689003qvm.150.1597171695693;
        Tue, 11 Aug 2020 11:48:15 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d26sm21000615qtc.51.2020.08.11.11.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 11:48:15 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] btrfs: Detect unbalanced tree with empty leaf
 before crashing btree operations
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200809120919.85271-1-wqu@suse.com>
 <20200809120919.85271-4-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8d21ba85-52a5-5419-dc16-ceece8b0c3a8@toxicpanda.com>
Date:   Tue, 11 Aug 2020 14:48:14 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200809120919.85271-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/9/20 8:09 AM, Qu Wenruo wrote:
> [BUG]
> With crafted image, btrfs will panic at btree operations:
>    kernel BUG at fs/btrfs/ctree.c:3894!
>    invalid opcode: 0000 [#1] SMP PTI
>    CPU: 0 PID: 1138 Comm: btrfs-transacti Not tainted 5.0.0-rc8+ #9
>    RIP: 0010:__push_leaf_left+0x6b6/0x6e0
>    Code: 00 00 48 98 48 8d 04 80 48 8d 74 80 65 e8 42 5a 04 00 48 8b bd 78 ff ff ff 8b bf 90 d0 00 00 89 7d 98 83 ef 65 e9 06 ff ff ff <0f> 0b 0f 0b 48 8b 85 78 ff ff ff 8b 90 90 d0 00 00 e9 eb fe ff ff
>    RSP: 0018:ffffc0bd4128b990 EFLAGS: 00010246
>    RAX: 0000000000000000 RBX: ffffa0a4ab8f0e38 RCX: 0000000000000000
>    RDX: ffffa0a280000000 RSI: 0000000000000000 RDI: ffffa0a4b3814000
>    RBP: ffffc0bd4128ba38 R08: 0000000000001000 R09: ffffc0bd4128b948
>    R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000240
>    R13: ffffa0a4b556fb60 R14: ffffa0a4ab8f0af0 R15: ffffa0a4ab8f0af0
>    FS: 0000000000000000(0000) GS:ffffa0a4b7a00000(0000) knlGS:0000000000000000
>    CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 00007f2461c80020 CR3: 000000022b32a006 CR4: 00000000000206f0
>    Call Trace:
>    ? _cond_resched+0x1a/0x50
>    push_leaf_left+0x179/0x190
>    btrfs_del_items+0x316/0x470
>    btrfs_del_csums+0x215/0x3a0
>    __btrfs_free_extent.isra.72+0x5a7/0xbe0
>    __btrfs_run_delayed_refs+0x539/0x1120
>    btrfs_run_delayed_refs+0xdb/0x1b0
>    btrfs_commit_transaction+0x52/0x950
>    ? start_transaction+0x94/0x450
>    transaction_kthread+0x163/0x190
>    kthread+0x105/0x140
>    ? btrfs_cleanup_transaction+0x560/0x560
>    ? kthread_destroy_worker+0x50/0x50
>    ret_from_fork+0x35/0x40
>    Modules linked in:
>    ---[ end trace c2425e6e89b5558f ]---
> 
> [CAUSE]
> The offending csum tree looks like this:
> checksum tree key (CSUM_TREE ROOT_ITEM 0)
> node 29741056 level 1 items 14 free 107 generation 19 owner CSUM_TREE
>          ...
>          key (EXTENT_CSUM EXTENT_CSUM 85975040) block 29630464 gen 17
>          key (EXTENT_CSUM EXTENT_CSUM 89911296) block 29642752 gen 17 <<<
>          key (EXTENT_CSUM EXTENT_CSUM 92274688) block 29646848 gen 17
>          ...
> 
> leaf 29630464 items 6 free space 1 generation 17 owner CSUM_TREE
>          item 0 key (EXTENT_CSUM EXTENT_CSUM 85975040) itemoff 3987 itemsize 8
>                  range start 85975040 end 85983232 length 8192
>          ...
> leaf 29642752 items 0 free space 3995 generation 17 owner 0
>                      ^ empty leaf            invalid owner ^
> 
> leaf 29646848 items 1 free space 602 generation 17 owner CSUM_TREE
>          item 0 key (EXTENT_CSUM EXTENT_CSUM 92274688) itemoff 627 itemsize 3368
>                  range start 92274688 end 95723520 length 3448832
> 
> So we have a corrupted csum tree where one tree leaf is completely
> empty, causing unbalanced btree, thus leading to unexpected btree
> balance error.
> 
> [FIX]
> For this particular case, we handle it in two directions to catch it:
> - Check if the tree block is empty through btrfs_verify_level_key()
>    So that invalid tree blocks won't be read out through
>    btrfs_search_slot() and its variants.
> 
> - Check 0 tree owner in tree checker
>    NO tree is using 0 as its tree owner, detect it and reject at tree
>    block read time.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=202821
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This test is done further down, just after a

         if (btrfs_header_generation(eb) > fs_info->last_trans_committed)
                 return 0;

Which I assume is the problem?  The generation is 19, is that > 
last_trans_committed?  Seems like this check just needs to be moved lower, 
right?  Thanks,

Josef
