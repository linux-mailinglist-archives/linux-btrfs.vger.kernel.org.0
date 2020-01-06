Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAD2131620
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 17:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgAFQdz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 11:33:55 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:35205 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFQdz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jan 2020 11:33:55 -0500
Received: by mail-qk1-f175.google.com with SMTP id z76so40292623qka.2
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jan 2020 08:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tfgNSGuJYPkeoUCWFhT+SguK9UCsF19CAsnVYyqBGQo=;
        b=U/BP90bAcyeux2G3qYIy/EcnNDNdmFPi43Qorpcyq7AKhEIKY5Ybg1FHHD4X5/AuNK
         PVowYYB7iWZ3uU7MI8SstqssHaYJV2hHAycI5ktUJkCy6zfZLLuG2bo/r5qumlXT2icO
         4hkZ8qLx94d8C/IQT+fpTwyRikv/Q/Vs+qeDFXFKals3XJ19DpXHrtGsrEBdMsBw0kL5
         vAQlUSEMrch6es6Ydb1ERsR6K35B4f4Kc9B6zUMoaDW3w/h/arSToaM7MyonajsQnRIO
         h9091xsFWemkSseC9A3D0s5ntZmKZDHDZDBLU+G3pwwHS70F7AkwRq2STIoAhGWe4TDv
         mdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tfgNSGuJYPkeoUCWFhT+SguK9UCsF19CAsnVYyqBGQo=;
        b=gNx/hCGK4YORmml/kDCD2AOF6z0jK7cp4yKZnpHttTjm4ON4O8KN5CCPbHNU69u/Sa
         +kFd/5nCkuHJ170A7BJLXeIoprVZOdQZlWUyvnJXX3S86h3fr/cnfbBjEpE1sOMkaa2X
         q+ydElDn2DyjQaPuel+wCTim/in8LfrHw5D3DWGE2OxFVkIehbBzNcftLRzmN1EqzfsC
         JLHH3q/GYYyJ1kNR8ZzW9HjJtGs7azrFHZlmxx+LmKRZvb2rico40Uq2CpJjLwqSf9La
         +avMESPy+yQsbYxybbj9eQN8iP04qzQFJGY/XHNpSFFlMlbNIpWphV1xQ5BSFiaGjc8G
         DD6g==
X-Gm-Message-State: APjAAAVId74SCmpT4ctHeU34j6zgCSkoWV2DLWdEYeyQgJT2Cp5Il5Vm
        iyUjtACEz1P5g4XsFqQ1CjLr2g==
X-Google-Smtp-Source: APXvYqyyEuvZ+lnBB3JDzohj82gFzUpF2UdpkYLB+3XBCsre7dIXD/WOKWW1K3gNJNAmOE5yAmWalA==
X-Received: by 2002:a05:620a:a0b:: with SMTP id i11mr85537255qka.11.1578328433372;
        Mon, 06 Jan 2020 08:33:53 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::6941])
        by smtp.gmail.com with ESMTPSA id o16sm20891146qkj.91.2020.01.06.08.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 08:33:52 -0800 (PST)
Subject: r
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.com>
References: <20200104135602.34601-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b58caea4-476b-bf83-292d-ea71052bbea7@toxicpanda.com>
Date:   Mon, 6 Jan 2020 11:33:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200104135602.34601-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/4/20 8:56 AM, Qu Wenruo wrote:
> [BUG]
> There are several different KASAN reports for balance + snapshot
> workloads.
> Involved call paths include:
> 
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
>     create_reloc_root+0x9f/0x460 [btrfs]
>     btrfs_reloc_post_snapshot+0xff/0x6c0 [btrfs]
>     create_pending_snapshot+0xa9b/0x15f0 [btrfs]
>     create_pending_snapshots+0x111/0x140 [btrfs]
>     btrfs_commit_transaction+0x7a6/0x1360 [btrfs]
>     btrfs_mksubvol+0x915/0x960 [btrfs]
>     btrfs_ioctl_snap_create_transid+0x1d5/0x1e0 [btrfs]
>     btrfs_ioctl_snap_create_v2+0x1d3/0x270 [btrfs]
>     btrfs_ioctl+0x241b/0x3e60 [btrfs]
>     do_vfs_ioctl+0x831/0xb10
>     ksys_ioctl+0x67/0x90
>     __x64_sys_ioctl+0x43/0x50
>     do_syscall_64+0x79/0xe0
>     entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>     btrfs_reloc_pre_snapshot+0x85/0xc0 [btrfs]
>     create_pending_snapshot+0x209/0x15f0 [btrfs]
>     create_pending_snapshots+0x111/0x140 [btrfs]
>     btrfs_commit_transaction+0x7a6/0x1360 [btrfs]
>     btrfs_mksubvol+0x915/0x960 [btrfs]
>     btrfs_ioctl_snap_create_transid+0x1d5/0x1e0 [btrfs]
>     btrfs_ioctl_snap_create_v2+0x1d3/0x270 [btrfs]
>     btrfs_ioctl+0x241b/0x3e60 [btrfs]
>     do_vfs_ioctl+0x831/0xb10
>     ksys_ioctl+0x67/0x90
>     __x64_sys_ioctl+0x43/0x50
>     do_syscall_64+0x79/0xe0
>     entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> [CAUSE]
> All these call sites are only relying on root->reloc_root, which can
> undergo btrfs_drop_snapshot(), and since we don't have real refcount
> based protection to reloc roots, we can reach already dropped reloc
> root, triggering KASAN.
> 
> [FIX]
> To avoid such access to unstable root->reloc_root, we should check
> BTRFS_ROOT_DEAD_RELOC_TREE bit first.
> 
> This patch introduces a new wrapper, have_reloc_root(), to do the proper
> check for most callers who don't distinguish merged reloc tree and no
> reloc tree.
> 
> The only exception is should_ignore_root(), as merged reloc tree can be
> ignored, while no reloc tree shouldn't.
> 
> Also, set_bit()/clear_bit()/test_bit() doesn't imply a memory barrier,
> and BTRFS_ROOT_DEAD_RELOC_TREE is the only indicator, also add extra
> memory barrier for that bit.
> 
> Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after merge_reloc_roots")
> Singed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Difference between this and David's diff:
> - Use proper smp_mb__after_atomic() for clear_bit()
> - Use test_bit() only check for should_ignore_root()
>    That call site is an except, can't go regular have_reloc_root() check
> - Add extra comment for have_reloc_root()
> ---

This took me a minute to figure out, but from what I can tell you are doing the 
mb's around the BTRFS_ROOT_DEAD_RELOC_TREE flag so that in clean_dirty_subvols() 
where we clear the bit and then set root->reloc_root = NULL we are sure to 
either see the bit or that reloc_root == NULL.

That's fine, but man all these random memory barriers around the bit messing 
make 0 sense and confuse the issue, what we really want is the 
smp_mb__after_atomic() in clean_dirty_subvols() and the smp_mb__before_atomic() 
in have_reloc_root().

But instead since we really want to know the right answer for root->reloc_root, 
and we clear that _before_ we clear the BTRFS_ROOT_DEAD_RELOC_TREE let's just do 
READ_ONCE/WRITE_ONCE everywhere we access the reloc_root.  In fact you could just do

static struct btrfs_root get_reloc_root(struct btrfs_root *root)
{
	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
		return NULL;
	return READ_ONCE(root->reloc_root);
}

then instead of the patter of

if (!have_reloc_root)
	return;
reloc_root = root->reloc_root;

do

reloc_root = get_reloc_root(root);
if (!reloc_root)
	return;

Then you only have the READ_ONCE/WRITE_ONCE in one place.  Thanks,

Josef
