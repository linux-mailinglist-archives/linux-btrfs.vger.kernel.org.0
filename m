Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1E3D13B36D
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 21:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgANUJa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 15:09:30 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50803 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgANUJ3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 15:09:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so15329277wmb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2020 12:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e/lIpR//+2bnwu8tJU9GveTOBFQENmKNTo70KEC1obs=;
        b=CR39wqiicIu3OEtxQYYOT0BdgswgOppq9X7cStMT1YsIY9QrrYEPiiEpwVUR9mHrP4
         Vo17+hVh+BJBhDM2fWSbORUE2tmudabTfmi64EBRSvJPknhG4e1lfSa7VBaj6etKAoVa
         k3DWjKLmwHMRPuFiP1ChkaL6GnPZxSPnbGVeF8s99JyAdMe20/sokePHE/H1VdLkq66s
         dFlC7sI+4LCfT+Bs4xTSrURB6l0YYrz+o7OBAPQHW0Foai7w+r1jFpu9/zHvyQneZyB1
         nvTo61dxiZMUrFTMHXlC5ZYl+0V6qG6bKEPaxx68bu5y6bs9W7vf0wRbQL+0CTjOpvCr
         YRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/lIpR//+2bnwu8tJU9GveTOBFQENmKNTo70KEC1obs=;
        b=gms4BhW2WCQVfKxlgBKCy6+yvYybZjaIx5rVItp+IXtdXQ3v0XzKuxybxzHUNXVkWG
         2H0sPBrwATu0k4lJNIcoI3fXBBBoj5VrO0OvJfZQbl92+iH12y0/PcS+4dRAdAC+RAB3
         AVqEn57v18GIAS2aJXP0E4R3CZ2I4hD131zBVfFbZMD0Ij6iRNBQCiBVgleKQkUCDxqa
         ezxZVpoUfSe2HucO1G4kQ+7VzL1YkydWCIq7Shgew7YsOV0AbnF0h1Mn4i4LyKSD0Z33
         WTXLhrjGWT3cvsd4jKwPsOTX+esAVWCH2hZQty60qBXBkWplA7+tvzbd3B6hQdQoLnqc
         ry3Q==
X-Gm-Message-State: APjAAAUwHHMJajj0pRCepznwWHTXxHLv7uq7nqL12PhNh29lhfWciKSc
        JYkOZ17qhkv2AG8snLCe9epVuuXw+M8ksYvJVkTJpA==
X-Google-Smtp-Source: APXvYqz3eP6qkhdLKVekPrw869eHIkE3BD8T95TQYTzU3XinapsSXC0HXdInfScRS/fGMfs9JGtVHadQuE6lneSwaiI=
X-Received: by 2002:a1c:770e:: with SMTP id t14mr31086512wmi.101.1579032567939;
 Tue, 14 Jan 2020 12:09:27 -0800 (PST)
MIME-Version: 1.0
References: <107f8e94-78bc-f891-0e1b-2db7903e8bde@forever.cz>
 <CAJCQCtSeq=nY7HTRjh0Y_0PRJt579HwromzS0NkdF4U6kn_wiA@mail.gmail.com> <2e55d20c-323f-e1a2-cdde-8ba0d50270e7@forever.cz>
In-Reply-To: <2e55d20c-323f-e1a2-cdde-8ba0d50270e7@forever.cz>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 14 Jan 2020 13:09:11 -0700
Message-ID: <CAJCQCtQhVQrnq7QnTd6ryDSg4SAGv55ceJ+H8LTM6MEYzQX4jQ@mail.gmail.com>
Subject: Re: slow single -> raid1 conversion (heavy write to original LVM volume)
To:     jakub nantl <jn@forever.cz>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 14, 2020 at 10:41 AM jakub nantl <jn@forever.cz> wrote:
>
> hello,
>
> thank for reply, here is the call trace, no need to reboot it, so I am
> waiting :)
>
> [538847.101197] sysrq: Show Blocked State
> [538847.101206]   task                        PC stack   pid father
> [538847.101321] btrfs           D    0 16014      1 0x00004004
> [538847.101324] Call Trace:
> [538847.101335]  __schedule+0x2e3/0x740
> [538847.101339]  ? __switch_to_asm+0x40/0x70
> [538847.101342]  ? __switch_to_asm+0x34/0x70
> [538847.101345]  schedule+0x42/0xb0
> [538847.101348]  schedule_timeout+0x203/0x2f0
> [538847.101351]  ? __schedule+0x2eb/0x740
> [538847.101355]  io_schedule_timeout+0x1e/0x50
> [538847.101358]  wait_for_completion_io+0xb1/0x120
> [538847.101363]  ? wake_up_q+0x70/0x70
> [538847.101401]  write_all_supers+0x896/0x960 [btrfs]
> [538847.101426]  btrfs_commit_transaction+0x6ea/0x960 [btrfs]
> [538847.101456]  prepare_to_merge+0x210/0x250 [btrfs]
> [538847.101484]  relocate_block_group+0x36b/0x5f0 [btrfs]
> [538847.101512]  btrfs_relocate_block_group+0x15e/0x300 [btrfs]
> [538847.101539]  btrfs_relocate_chunk+0x2a/0x90 [btrfs]
> [538847.101566]  __btrfs_balance+0x409/0xa50 [btrfs]
> [538847.101593]  btrfs_balance+0x3ae/0x530 [btrfs]
> [538847.101621]  btrfs_ioctl_balance+0x2c1/0x380 [btrfs]
> [538847.101648]  btrfs_ioctl+0x836/0x20d0 [btrfs]
> [538847.101652]  ? do_anonymous_page+0x2e6/0x650
> [538847.101656]  ? __handle_mm_fault+0x760/0x7a0
> [538847.101662]  do_vfs_ioctl+0x407/0x670
> [538847.101664]  ? do_vfs_ioctl+0x407/0x670
> [538847.101669]  ? do_user_addr_fault+0x216/0x450
> [538847.101672]  ksys_ioctl+0x67/0x90
> [538847.101675]  __x64_sys_ioctl+0x1a/0x20
> [538847.101680]  do_syscall_64+0x57/0x190
> [538847.101683]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [538847.101687] RIP: 0033:0x7f3cb04c85d7
> [538847.101695] Code: Bad RIP value.
> [538847.101697] RSP: 002b:00007ffcd4e5fe88 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [538847.101701] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
> 00007f3cb04c85d7
> [538847.101704] RDX: 00007ffcd4e5ff18 RSI: 00000000c4009420 RDI:
> 0000000000000003
> [538847.101707] RBP: 00007ffcd4e5ff18 R08: 0000000000000078 R09:
> 0000000000000000
> [538847.101710] R10: 0000559f27675010 R11: 0000000000000246 R12:
> 0000000000000003
> [538847.101713] R13: 00007ffcd4e62734 R14: 0000000000000001 R15:
> 0000000000000000
> [538847.101718] btrfs           D    0 30196      1 0x00000004
> [538847.101720] Call Trace:
> [538847.101724]  __schedule+0x2e3/0x740
> [538847.101727]  schedule+0x42/0xb0
> [538847.101753]  btrfs_cancel_balance+0xf8/0x170 [btrfs]
> [538847.101759]  ? wait_woken+0x80/0x80
> [538847.101786]  btrfs_ioctl+0x13af/0x20d0 [btrfs]
> [538847.101789]  ? do_anonymous_page+0x2e6/0x650
> [538847.101793]  ? __handle_mm_fault+0x760/0x7a0
> [538847.101797]  do_vfs_ioctl+0x407/0x670
> [538847.101800]  ? do_vfs_ioctl+0x407/0x670
> [538847.101803]  ? do_user_addr_fault+0x216/0x450
> [538847.101806]  ksys_ioctl+0x67/0x90
> [538847.101809]  __x64_sys_ioctl+0x1a/0x20
> [538847.101813]  do_syscall_64+0x57/0x190
> [538847.101856]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [538847.101859] RIP: 0033:0x7fa33680c5d7
> [538847.101864] Code: Bad RIP value.
> [538847.101873] RSP: 002b:00007ffdbe2b9c58 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [538847.101888] RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
> 00007fa33680c5d7
> [538847.101897] RDX: 0000000000000002 RSI: 0000000040049421 RDI:
> 0000000000000003
> [538847.101908] RBP: 00007ffdbe2ba1d8 R08: 0000000000000078 R09:
> 0000000000000000
> [538847.101918] R10: 00005604500f4010 R11: 0000000000000246 R12:
> 00007ffdbe2ba735
> [538847.101928] R13: 00007ffdbe2ba1c0 R14: 0000000000000000 R15:
> 0000000000000000
>

I think it got clipped. And also the MUA is wrapping it and making it
hard to read. I suggest 'journalctl -k -o short-monotonic' because
what started the problem might actually be much earlier and there's no
way to know that without the entire thing. Put that up in a dropbox or
pastebin or google drive or equivalent. And hopefully a dev will be
able to figure out why it's hung up. All I can tell from the above is
that it's hung up on cancelling, which doesn't say much.

_handle_mm_fault is suspicious. On second thought, I suggest doing
sysrq+t. And then output journalctl -k, and post that. It'll have the
complete dmesg, the sysrq+w, and +t. That for sure won't post to the
list, it'll be too long, and the way MUA's wrap it, it's hard to read.

-- 
Chris Murphy
