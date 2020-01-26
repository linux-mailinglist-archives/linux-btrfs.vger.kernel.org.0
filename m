Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62881149BF0
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jan 2020 17:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgAZQyL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Jan 2020 11:54:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:51874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgAZQyK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Jan 2020 11:54:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AB1B5AC7C;
        Sun, 26 Jan 2020 16:54:08 +0000 (UTC)
Subject: Re: fstrim segmentation fault and btrfs crash on vanilla 5.4.14
To:     Raviu <raviu@protonmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <izW2WNyvy1dEDweBICizKnd2KDwDiDyY2EYQr4YCwk7pkuIpthx-JRn65MPBde00ND6V0_Lh8mW0kZwzDiLDv25pUYWxkskWNJnVP0kgdMA=@protonmail.com>
 <7tcxgXvMR83f-yW7IN3dKq8NWJETNoAMGo_0GShBJMjR_p_N4vE3nDMPkECoqBiOFDCEFsBM4IZ08Lkk0yT5-H81FkHAV-xEThPkbey0Z40=@protonmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1a8462a7-c77b-ecc9-681f-3cecb6a51576@suse.com>
Date:   Sun, 26 Jan 2020 18:54:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7tcxgXvMR83f-yW7IN3dKq8NWJETNoAMGo_0GShBJMjR_p_N4vE3nDMPkECoqBiOFDCEFsBM4IZ08Lkk0yT5-H81FkHAV-xEThPkbey0Z40=@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 26.01.20 г. 18:09 ч., Raviu wrote:
> Here is dmesg output:
> 
> [  237.525947] assertion failed: prev, in ../fs/btrfs/extent_io.c:1595
> [  237.525984] ------------[ cut here ]------------
> [  237.525985] kernel BUG at ../fs/btrfs/ctree.h:3117!
> [  237.525992] invalid opcode: 0000 [#1] SMP PTI
> [  237.525998] CPU: 4 PID: 4423 Comm: fstrim Tainted: G     U     OE     5.4.14-8-vanilla #1
> [  237.526001] Hardware name: ASUSTeK COMPUTER INC.
> [  237.526044] RIP: 0010:assfail.constprop.58+0x18/0x1a [btrfs]
> [  237.526048] Code: 0b 0f 1f 44 00 00 48 8b 3d 15 9e 07 00 e9 70 20 ce e2 89 f1 48 c7 c2 ae 27 77 c0 48 89 fe 48 c7 c7 20 87 77 c0 e8 56 c5 ba e2 <0f> 0b 0f 1f 44 00 00 e8 9c 1b bc e2 48 8b 3d 7d 9f 07 00 e8 40 20
> [  237.526053] RSP: 0018:ffffae2cc2befc20 EFLAGS: 00010282
> [  237.526056] RAX: 0000000000000037 RBX: 0000000000000021 RCX: 0000000000000000
> [  237.526059] RDX: 0000000000000000 RSI: ffff94221eb19a18 RDI: ffff94221eb19a18
> [  237.526062] RBP: ffff942216ce6e00 R08: 0000000000000403 R09: 0000000000000001
> [  237.526064] R10: ffffae2cc2befc38 R11: 0000000000000001 R12: ffffae2cc2befca0
> [  237.526067] R13: ffff942216ce6e24 R14: ffffae2cc2befc98 R15: 0000000000100000
> [  237.526071] FS:  00007fa1b8087fc0(0000) GS:ffff94221eb00000(0000) knlGS:0000000000000000
> [  237.526074] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  237.526076] CR2: 000032eed3b5a000 CR3: 00000007c33bc002 CR4: 00000000003606e0
> [  237.526079] Call Trace:
> [  237.526120]  find_first_clear_extent_bit+0x13d/0x150 [btrfs]

So you are hitting the ASSERT(prev) in find_first_clear_extent_bit. The
good news is this is just an in-memory state and it's used to optimize
fstrim so that only non-trimmed regions are being trimmed. This state is
cleared on unmount so if you mount/remount then you shouldn't be hitting
it.

But then again, the ASSERT is there to catch an impossible case. To help
me debug this could you provide the output of:

btrfs fi show /home

And then the output of btrfs inspect-internal dump-tree -t3 /dev/XXX


where XXX should be the block device that contains the fs mounted on /home .




