Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7224B58132E
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 14:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiGZMdI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 08:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiGZMdH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 08:33:07 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F1922BD4;
        Tue, 26 Jul 2022 05:33:07 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id bz13so10268638qtb.7;
        Tue, 26 Jul 2022 05:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Tm9UtoOpL7fycKdQ1Z1xCbjLNmfYhyUmhfrAD/ZaYMw=;
        b=aKTlp03szTuHhGFBmuQY96bTYBMRa8ZfPAVe7CeMhh+JmKY82tsAqEkEzTZBtoSD81
         xuGvJBGnpaf2ObJGdyuqR5mibsjrR9GvsaZWCR9nxRqeVsAtnukDtHkiYMn35k9zlNSN
         +ZyYy4/wxtEUtnu4CtRexXY6J5mwQ3vlWSjTgBRqa41bnkJEM+BbX7uM4KA/+AEn36fs
         8Nlnu+enCz6jVRbcmdZ4jFWk+q2GWA6Hfn73mXYWGPNuBY1nRBxNXIJGyGS1O9oVSwcE
         w8X2dn03QdfQm5VQeL7DghGdu6hELNqZccnYeHI27oaBS9NBamejIGW/Y+B+Ncjo56id
         UT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Tm9UtoOpL7fycKdQ1Z1xCbjLNmfYhyUmhfrAD/ZaYMw=;
        b=l2QJVHReP0sIPQtvf3oHxc8aMUDmZn/R7abVq3UzIjzPrOVMva1QhRTEgXFI5uwAAH
         ryTeAvTlMocxEuBxKROMK2lOv1d8zMO31HIc0+oAZY0GrDJcLMQhrgGg30S3kc0mLkgP
         urGys1jt/G0B96twLQO6fCCmjL3/IrKKGPEI3cluoNX1a8DYc3Cm+OptN8SPS417a0rH
         UQHWIQvN4XwAUQFywGTzx8vGVqQP6meh2UJZud1NkfuCjl/wPWwWja/59OazkFRcNxfw
         cCx7vVuZIvRQ6EBo1Pyy1hznAmtNJa/BqXkuqoo0a0+dFXOqOoHtm2aG0ULQsa2Icjvn
         rDfw==
X-Gm-Message-State: AJIora82jjZvxIcmDyN/9y2UpjD4zisIZ+mQPXxAP4XcL2bh7fO5R/y9
        4+AffOSba25aqVtmCTul8ff1kkMnUewukqI9orhoM/uh+1vmOzr09jg=
X-Google-Smtp-Source: AGRyM1uiPe3Cozg0GejgAUaDvaWFSpqHGJFxay4wyLkOrIzUxrmT8Zfd3ykkF5DNtacOEtKt4zFiewt71cAPJuOjxWY=
X-Received: by 2002:ac8:5fc1:0:b0:31e:f847:6c6f with SMTP id
 k1-20020ac85fc1000000b0031ef8476c6fmr14198608qta.616.1658838785657; Tue, 26
 Jul 2022 05:33:05 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 26 Jul 2022 17:32:54 +0500
Message-ID: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
Subject: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi guys.
Always with intensive writing on a btrfs volume, the message "BUG:
MAX_LOCKDEP_CHAIN_HLOCKS too low!" appears in the kernel logs.

[46729.134549] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
[46729.134557] turning off the locking correctness validator.
[46729.134559] Please attach the output of /proc/lock_stat to the bug report
[46729.134561] CPU: 22 PID: 166516 Comm: ThreadPoolForeg Tainted: G
    W    L   --------  ---
5.19.0-0.rc7.20220722git68e77ffbfd06.56.fc37.x86_64 #1
[46729.134566] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 4403 04/27/2022
[46729.134569] Call Trace:
[46729.134572]  <TASK>
[46729.134576]  dump_stack_lvl+0x5b/0x77
[46729.134583]  __lock_acquire.cold+0x167/0x29e
[46729.134594]  lock_acquire+0xce/0x2d0
[46729.134599]  ? btrfs_reserve_extent+0xbd/0x250
[46729.134606]  ? btrfs_get_alloc_profile+0x17e/0x240
[46729.134611]  btrfs_get_alloc_profile+0x19c/0x240
[46729.134614]  ? btrfs_reserve_extent+0xbd/0x250
[46729.134618]  btrfs_reserve_extent+0xbd/0x250
[46729.134629]  btrfs_alloc_tree_block+0xa3/0x510
[46729.134635]  ? release_extent_buffer+0xa7/0xe0
[46729.134643]  split_node+0x131/0x3d0
[46729.134652]  btrfs_search_slot+0x2f3/0xc30
[46729.134659]  ? btrfs_insert_inode_ref+0x50/0x3b0
[46729.134664]  btrfs_insert_empty_items+0x31/0x70
[46729.134669]  btrfs_insert_inode_ref+0x99/0x3b0
[46729.134678]  btrfs_rename2+0x317/0x1510
[46729.134690]  ? vfs_rename+0x49d/0xd20
[46729.134693]  ? btrfs_symlink+0x460/0x460
[46729.134696]  vfs_rename+0x49d/0xd20
[46729.134705]  ? do_renameat2+0x4a0/0x510
[46729.134709]  do_renameat2+0x4a0/0x510
[46729.134720]  __x64_sys_rename+0x3f/0x50
[46729.134724]  do_syscall_64+0x5b/0x80
[46729.134729]  ? memcg_slab_free_hook+0x1fd/0x2e0
[46729.134735]  ? do_faccessat+0x111/0x260
[46729.134739]  ? kmem_cache_free+0x379/0x3d0
[46729.134744]  ? lock_is_held_type+0xe8/0x140
[46729.134749]  ? do_syscall_64+0x67/0x80
[46729.134752]  ? lockdep_hardirqs_on+0x7d/0x100
[46729.134757]  ? do_syscall_64+0x67/0x80
[46729.134760]  ? asm_exc_page_fault+0x22/0x30
[46729.134764]  ? lockdep_hardirqs_on+0x7d/0x100
[46729.134768]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[46729.134773] RIP: 0033:0x7fd2a29b5afb
[46729.134798] Code: e8 7a 27 0a 00 f7 d8 19 c0 5b c3 0f 1f 40 00 b8
ff ff ff ff 5b c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 52 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 f1 82 17 00
f7 d8
[46729.134801] RSP: 002b:00007fd25b70a5a8 EFLAGS: 00000282 ORIG_RAX:
0000000000000052
[46729.134805] RAX: ffffffffffffffda RBX: 00007fd25b70a5e0 RCX: 00007fd2a29b5afb
[46729.134808] RDX: 0000000000000000 RSI: 00003ba01ef60820 RDI: 00003ba00e4b2da0
[46729.134810] RBP: 00007fd25b70a660 R08: 0000000000000000 R09: 00007fd25b70a570
[46729.134812] R10: 00007ffd36b1f080 R11: 0000000000000282 R12: 00007fd25b70a5b8
[46729.134815] R13: 00003ba00e4b2da0 R14: 00007fd25b70a6c4 R15: 00003ba01ef60820
[46729.134823]  </TASK>

In this regard, I want to ask, is this really a bug?
The kernel version is 5.19-rc7.

Here's the full kernel log: https://pastebin.com/hYWH7RHu
Here's /proc/lock_stat: https://pastebin.com/ex5w0QW9

-- 
Best Regards,
Mike Gavrilov.
