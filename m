Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72F8D189400
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 03:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgCRC1M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Mar 2020 22:27:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44445 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgCRC1M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Mar 2020 22:27:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id y2so12855077wrn.11
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Mar 2020 19:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WyyAAZSoqE93XQjzR18Ci81GcIdz7/nFuPvWlpOX5CU=;
        b=fSAhAfQgiPcwYhCwQONEfEea3WdPqFiv3iB4apTXlDxIhEUJH3kal+FLdtRSKtvxVN
         DGFhicuPDoJ+zfDXA4vCu3TXDjAdDk06Yz5DUUbivvAxdReANmPmFZIYuXDhD2SqL0zY
         pXW7X6oDBEasQWvOEmWto2CZQA2AvbOxuSbWIuIlre0BxSkks8I9rbquwVvmJxp8LLlQ
         W2Pl5VKJ/TyqLPpvl5rwILh1qQ5usR2wk6YLxJ2oPiQg5UydB43EBASwlUPdA1+toaXu
         Mk+Ucf8WDzJ7MIvsBfTtpMk08YVLcKPsZzKyIluDv9oYfsA8E7eE2AUJ/8XjXPIMeQYD
         nD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WyyAAZSoqE93XQjzR18Ci81GcIdz7/nFuPvWlpOX5CU=;
        b=V5oNKVLinXnKdEL6H2aBxTlewJBt2agMHNkJBgmMXWOsF/MApEL9Ax2ul38JlJrNTK
         sL0UN2XI8gH5byu11RvIVpJWY+0T5MMBM48TKYYk+0a9i3b79CqecOLoY4WdnuiAqvBG
         zJlrA1SEzR57PRNVzPyXAzJmO1vnbNAt+QlquJtRX6FO4d4Q426m73JnkNW65g97UXoB
         J0JrTgDBzUkLIK7gIHP9fWhoAlGECCHLTO1nlykqUbmueJ2aV5ijxlVekuUjYdIEMKUv
         Ha+FUSl9nB3gbUZ17tqIhuGR56h3vLpDnsWLgaQcBf6kkefNV9ZogVaEICWIxNc2zjvo
         0sRQ==
X-Gm-Message-State: ANhLgQ21GZuAxavIKa8IxCoMqju6fxCsQBggdAYXssTHheg1j228NT6c
        msd7PXUCspxXRllsTkeH51F+xU2TIo0lqNZM85GwNrhkEp4=
X-Google-Smtp-Source: ADFU+vtavPGWtlw/5KnXHbVVKeCkY0zR6NurXv8qqg422JY8FVFdhKFU2rcsma9FNXsiPn9wx+xqdlxcv56Tz45z/mQ=
X-Received: by 2002:adf:fc81:: with SMTP id g1mr2386632wrr.410.1584498429893;
 Tue, 17 Mar 2020 19:27:09 -0700 (PDT)
MIME-Version: 1.0
From:   Liwei <xieliwei@gmail.com>
Date:   Wed, 18 Mar 2020 10:26:58 +0800
Message-ID: <CAPE0SYyr3sSmPn+f+ZnZuPTTSQdR=vC3JA33B9ctc2o19hHnTQ@mail.gmail.com>
Subject: failed to read block groups: -5; open_ctree failed
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi list,
I'm getting the following log while trying to mount my filesystem:
[   23.403026] BTRFS: device label dstore devid 1 transid 1288839 /dev/dm-8
[   23.491459] BTRFS info (device dm-8): enabling auto defrag
[   23.491461] BTRFS info (device dm-8): disk space caching is enabled
[   23.717506] BTRFS info (device dm-8): bdev /dev/mapper/vg- dstore
errs: wr 0, rd 728, flush 0, corrupt 16, gen 0
[   32.108724] BTRFS error (device dm-8): bad tree block start, want
39854304329728 have 0
[   32.110570] BTRFS error (device dm-8): bad tree block start, want
39854304329728 have 0
[   32.112030] BTRFS error (device dm-8): failed to read block groups: -5
[   32.273712] BTRFS error (device dm-8): open_ctree failed

A check gives me:
#btrfs check /dev/mapper/recovery
Opening filesystem to check...
checksum verify failed on 39854304329728 found E4E3BDB6 wanted 00000000
checksum verify failed on 39854304329728 found E4E3BDB6 wanted 00000000
checksum verify failed on 39854304329728 found E4E3BDB6 wanted 00000000
checksum verify failed on 39854304329728 found E4E3BDB6 wanted 00000000
bad tree block 39854304329728, bytenr mismatch, want=39854304329728, have=0
ERROR: cannot open file system

The same thing happens with the other superblocks, all superblocks are
not corrupted.

The reason this happened is a controller failure occurred while trying
to expand the underlying raid6 causing some pretty nasty drive
dropouts. Looking through older generations of tree roots, I'm getting
the same zeroed node at 39854304329728.

It seems like at some point md messed up recovering from the
controller failure (or rather I did) and it seems like I am getting a
lot of zeroed-out/corrupted areas? Can someone confirm if that is the
case or if it is just some weird state the filesystem is in?

I'm not hung up about hosing the filesystem as we have a complete
backup before doing the raid expansion, but it'd be great if I can
avoid restoring as that will take a very long time.

Other obligatory information:
# uname -a
Linux dstore-1 4.19.0-4-amd64 #1 SMP Debian 4.19.28-2 (2019-03-15)
x86_64 GNU/Linux
# btrfs --version
btrfs-progs v4.20.1

Thank you very much!
Liwei
