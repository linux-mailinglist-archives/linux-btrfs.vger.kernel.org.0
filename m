Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646F8693905
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Feb 2023 18:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjBLRQN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Feb 2023 12:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBLRQM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Feb 2023 12:16:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F370C5259;
        Sun, 12 Feb 2023 09:16:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 971C5B80D34;
        Sun, 12 Feb 2023 17:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2E0C433EF;
        Sun, 12 Feb 2023 17:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676222168;
        bh=735fq6UVE89/trKjizPOfVcLcw0+bDcTZGMkRlKOQhQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U/FkRg48g6hIo8dxfVXQF1lG1EAyxz9LLjYI16nohvKTHMEdeoPltsQRaIeXTsR59
         a82U2DlO6sKBMgjm5iOwAWYKcYt2k8+5gxNRgYPM6yIQKqxSlmyEZIv40uyMaNKg6a
         7rhABsOHWk8ev0Ptmc1uHB0Okq7DCdELvcFQcgk6rGyfh/d5KHqpkOolt5zKIZo3a9
         FoKkJWoxQnXqs8pDrdhmaMf8bt0Z2EveWoJWGwG5zJy6PPAePoKDNWgUpAyvvxBcKb
         S/VMAbaj7S1QzmNbtZ1flRtW2LLz/fNJ4mDBoOzov6yurI+SmBX4ZYs+71LV4wDsOY
         oo2SOSEfLQw+Q==
Received: by mail-oi1-f175.google.com with SMTP id bx13so8451120oib.13;
        Sun, 12 Feb 2023 09:16:08 -0800 (PST)
X-Gm-Message-State: AO0yUKVgSYeGwJ53yQ8ohAJ9Asvur4LtevRSnRl9KT96rYyn3n/k0ZDP
        yap7W6sUgav5H7QUYXXXHuLkuWdxDvGwCCbD3YE=
X-Google-Smtp-Source: AK7set8NlJ3Nz9R0blhc9ZKmuTmCfzqUpfr7bYxzopYW7P8pRL1HnVdlP+R5Cv8rJdKV9u/gJhsIY6F9Et2KO8usGoY=
X-Received: by 2002:a05:6808:547:b0:37d:8037:7456 with SMTP id
 i7-20020a056808054700b0037d80377456mr307846oig.92.1676222167193; Sun, 12 Feb
 2023 09:16:07 -0800 (PST)
MIME-Version: 1.0
References: <550e4190-c487-51db-6213-838d32183cbf@gmx.de>
In-Reply-To: <550e4190-c487-51db-6213-838d32183cbf@gmx.de>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Sun, 12 Feb 2023 17:15:31 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6RY_6Di2HMbn+_nLXHNSpYcH+2hqQprTP_z-xjL8CjTA@mail.gmail.com>
Message-ID: <CAL3q7H6RY_6Di2HMbn+_nLXHNSpYcH+2hqQprTP_z-xjL8CjTA@mail.gmail.com>
Subject: Re: RIP in btrfs with kernel 6.1.4
To:     =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 12, 2023 at 2:13 PM Toralf F=C3=B6rster <toralf.foerster@gmx.de=
> wrote:
>
>
>
> At a stable hardened Gentoo Linux server I got a month ago the RIP seen
> below.
>
>
> Just FWIW few hours before that RIP the BTRFS at my desktop (same OS,
> but older stable kernel v5.15.86 IIRC) got big problems (100% full
> despite that just about the half of 250 GB was used) - and I made the
> mistake of the months and trusts the btrfs repair tool - after that the
> fs could not even be found/mounted by the kernel.
>
>
> The server is an SMP PREEMPT_DYNAMIC Thu Feb  9 17:45:03 UTC 2023 x86_64
> AMD Ryzen 9 5950X 16-Core Processor AuthenticAMD GNU/Linux
> The client was an ThinkPad T440s with an i5
>
>
> Here is the RIP:
>
> Jan 12 09:52:07 mr-fox kernel: BTRFS warning (device nvme0n1p4): bad eb
> member end: ptr 0x3fe9 start 5994348707840 member offset 16382 size 8
> Jan 12 09:52:07 mr-fox kernel: general protection fault, probably for
> non-canonical address 0x142f000000000: 0000 [#1] PREEMPT SMP NOPTI
> Jan 12 09:52:07 mr-fox kernel: CPU: 19 PID: 6458 Comm: tar Tainted: G
>              T  6.1.4 #10
> Jan 12 09:52:07 mr-fox kernel: Hardware name: ASUS System Product
> Name/Pro WS 565-ACE, BIOS 0502 01/15/2021
> Jan 12 09:52:07 mr-fox kernel: RIP: 0010:btrfs_get_64+0x11e/0x170
> Jan 12 09:52:07 mr-fox kernel: Code: 4a 8b 44 e5 70 48 2b 05 f0 cd c9 00
> 48 c1 f8 06 48 c1 e0 0c 48 03 05 f1 cd c9 00 81 eb f8 0f 00 00 74 13 31
> d2 89 d6 83 c2 01 <0f> b6 3c 30 40 88 3c 31 39 da 72 ef 48 8b 44 24 08
> e9 5b ff ff ff
> Jan 12 09:52:07 mr-fox kernel: RSP: 0018:ffff95c160b1fd48 EFLAGS: 0001020=
2
> Jan 12 09:52:07 mr-fox kernel: RAX: 000142f000000000 RBX:
> 0000000000000006 RCX: ffff95c160b1fd52
> Jan 12 09:52:07 mr-fox kernel: RDX: 0000000000000001 RSI:
> 0000000000000000 RDI: 000000000000000a
> Jan 12 09:52:07 mr-fox kernel: RBP: ffff95c13d2c6a00 R08:
> 0000000000000000 R09: 0000000000000000
> Jan 12 09:52:07 mr-fox kernel: R10: 0000000000000000 R11:
> 0000000000000000 R12: 0000000000000004
> Jan 12 09:52:07 mr-fox kernel: R13: 0000000000000002 R14:
> 00000573ab068000 R15: 0000000000003fe9
> Jan 12 09:52:07 mr-fox kernel: FS:  00007fe568d167c0(0000)
> GS:ffff95dfaecc0000(0000) knlGS:0000000000000000
> Jan 12 09:52:07 mr-fox kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Jan 12 09:52:07 mr-fox kernel: CR2: 000055d1eacc94a8 CR3:
> 00000001347a4000 CR4: 0000000000750ee0
> Jan 12 09:52:07 mr-fox kernel: PKRU: 55555554
> Jan 12 09:52:07 mr-fox kernel: Call Trace:
> Jan 12 09:52:07 mr-fox kernel:  <TASK>
> Jan 12 09:52:07 mr-fox kernel:  btrfs_file_llseek+0x25d/0x670
> Jan 12 09:52:07 mr-fox kernel:  ksys_lseek+0x73/0xc0
> Jan 12 09:52:07 mr-fox kernel:  do_syscall_64+0x68/0xa0
> Jan 12 09:52:07 mr-fox kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> Jan 12 09:52:07 mr-fox kernel: RIP: 0033:0x7fe56940a1f7
> Jan 12 09:52:07 mr-fox kernel: Code: 00 00 90 89 c3 48 8b 05 27 5c 0d 00
> f7 db 64 89 18 48 c7 c0 ff ff ff ff eb b1 66 0f 1f 84 00 00 00 00 00 b8
> 08 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 f9 5b 0d 00 f7
> d8 64 89 02 48
> Jan 12 09:52:07 mr-fox kernel: RSP: 002b:00007fffef1a8348 EFLAGS:
> 00000202 ORIG_RAX: 0000000000000008
> Jan 12 09:52:07 mr-fox kernel: RAX: ffffffffffffffda RBX:
> 0000000000000000 RCX: 00007fe56940a1f7
> Jan 12 09:52:07 mr-fox kernel: RDX: 0000000000000003 RSI:
> 0000000000000000 RDI: 000000000000000b
> Jan 12 09:52:07 mr-fox kernel: RBP: 0000000000000000 R08:
> 000000000000000b R09: 000055d1eacc7c00
> Jan 12 09:52:07 mr-fox kernel: R10: 0ddfa64af0d29e4e R11:
> 0000000000000202 R12: 0000000000000000
> Jan 12 09:52:07 mr-fox kernel: R13: 000055d1eacad020 R14:
> 000055d1eacac030 R15: 0000000000000002
> Jan 12 09:52:07 mr-fox kernel:  </TASK>
> Jan 12 09:52:07 mr-fox kernel: ---[ end trace 0000000000000000 ]---
> Jan 12 09:52:07 mr-fox kernel: RIP: 0010:btrfs_get_64+0x11e/0x170
> Jan 12 09:52:07 mr-fox kernel: Code: 4a 8b 44 e5 70 48 2b 05 f0 cd c9 00
> 48 c1 f8 06 48 c1 e0 0c 48 03 05 f1 cd c9 00 81 eb f8 0f 00 00 74 13 31
> d2 89 d6 83 c2 01 <0f> b6 3c 30 40 88 3c 31 39 da 72 ef 48 8b 44 24 08
> e9 5b ff ff ff
> Jan 12 09:52:07 mr-fox kernel: RSP: 0018:ffff95c160b1fd48 EFLAGS: 0001020=
2
> Jan 12 09:52:07 mr-fox kernel: RAX: 000142f000000000 RBX:
> 0000000000000006 RCX: ffff95c160b1fd52
> Jan 12 09:52:07 mr-fox kernel: RDX: 0000000000000001 RSI:
> 0000000000000000 RDI: 000000000000000a
> Jan 12 09:52:07 mr-fox kernel: RBP: ffff95c13d2c6a00 R08:
> 0000000000000000 R09: 0000000000000000
> Jan 12 09:52:07 mr-fox kernel: R10: 0000000000000000 R11:
> 0000000000000000 R12: 0000000000000004
> Jan 12 09:52:07 mr-fox kernel: R13: 0000000000000002 R14:
> 00000573ab068000 R15: 0000000000003fe9
> Jan 12 09:52:07 mr-fox kernel: FS:  00007fe568d167c0(0000)
> GS:ffff95dfaecc0000(0000) knlGS:0000000000000000
> Jan 12 09:52:07 mr-fox kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Jan 12 09:52:07 mr-fox kernel: CR2: 000055d1eacc94a8 CR3:
> 00000001347a4000 CR4: 0000000000750ee0
> Jan 12 09:52:07 mr-fox kernel: PKRU: 55555554

This is a bug that was already fixed by this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D2f2e84ca60660402bd81d0859703567c59556e6a

And it landed in 6.1.5, see:
https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.1.5

So just upgrade to a stable release > 6.1.4.


>
> --
> Toralf
