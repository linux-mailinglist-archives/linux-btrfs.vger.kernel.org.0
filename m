Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F899B111D
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 16:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbfILO2l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 10:28:41 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:40800 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732512AbfILO2l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 10:28:41 -0400
Received: by mail-vk1-f193.google.com with SMTP id d126so5190274vkf.7
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2019 07:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=vPwgXTPZWVXQfVUoEI+UFIj3p7kHq3WDb1TennEuj7M=;
        b=FyOrodPzUCd7LZSQdauCM7n5shfy+/AGv1vnlqZ1qOWMAAYa8SytRkexwqtlHm9Zke
         dKq/0wPtSCbX/xGv3Hetpy01qEJlUFCbr0J2Jb+R+GbGgmRIbGMTpXIhofsrmfQr4HSq
         Uy+74hm3YJ/q5xjVj4VTmJj8LRhzYruGbHaCiedZpN672lMZQnE0IRAy3YIJuexoaZHX
         cCIvemtCMW1JYlsgF+FVhbo+dOyYdGLCWs+AoyaZzQhjZbuiNxcShRN8dDM5cwdTbYy0
         lhS+Zsoi81VvCNIJav5PR7Phu6mH1nLmjnoWqCZ3zRZ9QGRUAF797x668AydZXfmkazz
         9CfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=vPwgXTPZWVXQfVUoEI+UFIj3p7kHq3WDb1TennEuj7M=;
        b=rNn6v8p05rMe1fMp5MSteu1JNXrPbqNpJuU6yLMwYODumS8w2niQCZxA9tO0cjxS4K
         cYdEuIYxfs5cg4Hm5h7L69eoTbBUoYWhYLFKtdxg04IhH5VXX9hzb8Bql9KEFMMWEMG+
         AsVdoeUo144czxy+6RR3kXk0MMJxL2GJZWV4OrDMuSmmoLh8iDePnV0uBTBZi/6CQS3D
         SnGCQlw/BhBXEDZznYUUJX4HSzAMO6sS0vRzQCQWNiLQwjSndgFWxbesA6+2UL4w3huD
         gYQVzn9Q7Vhre9+pNcdQQ/dpMV5NdFOh9ynP+ZgjUd4XNZKdepDjcgGTH4VfdhQ7/JBg
         zd7w==
X-Gm-Message-State: APjAAAUIDj9N0Jq4pmcArUj7I8LcEajpRZjpRby/7O3MC7tUmN61zJZo
        KKB4N4+wb5aSITPe4yy4W+Odh5Sd+8GR5lwFsjuqyZVOdhw=
X-Google-Smtp-Source: APXvYqw/OOh3MLlBF0LIwtyqt8yukU54CfgBLtlt/3BjY3PYyLeDAjNwuw5TKAl3/I74H55UpOGosgHwDGFpmXTqgYQ=
X-Received: by 2002:a1f:2b8c:: with SMTP id r134mr10829629vkr.23.1568298520283;
 Thu, 12 Sep 2019 07:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
 <CAL3q7H4peDv_bQa5vGJeOM=V--yq1a1=aHat5qcsXjbnDoSkDQ@mail.gmail.com> <ce6a9b8274f5af89d9378aa84e934ce3f3354acd.camel@scientia.net>
In-Reply-To: <ce6a9b8274f5af89d9378aa84e934ce3f3354acd.camel@scientia.net>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 12 Sep 2019 15:28:29 +0100
Message-ID: <CAL3q7H5qNE4rizN14qmgrAwtju9KRHspKxo3S-PoTcSUvXYuew@mail.gmail.com>
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     Christoph Anton Mitterer <calestyo@scientia.net>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 12, 2019 at 2:09 PM Christoph Anton Mitterer
<calestyo@scientia.net> wrote:
>
> Hi.
>
> First, thanks for finding&fixing this :-)
>
>
> On Thu, 2019-09-12 at 08:50 +0100, Filipe Manana wrote:
> > 1) either a hang when committing a transaction, reported by several
> > users recently and hit it myself too twice when running fstests (test
> > case generic/475 and generic/561) after I upgradaded my development
> > branch from a 5.1.x kernel to a 5.3-rcX kernel. If this happens you
> > risk no corruption, still the hang is very inconvenient of course, as
> > you have to reboot.
>
> Okay inconvenient, but not so bad if there is no corruption risk.
>
>
> > 2) writeback for some btree nodes may never be started and we end up
> > committing a transaction without noticing that. This is really
> > serious
> > and that will lead to the "parent transid verify failed on ..."
> > messages.
>
> As some people have already pointed out, it will be infeasible for many
> end users to downgrade (no security updates) or manually patch (well,
> end-users).

Yes, but I can't do anything about that. I'm not skilled to build a
time machine to go back in time :)

>
> Can you elaborate under which circumstances this problem occurs,
> whether there are any intermediate workarounds, and whether it's always
> noticed (i.e. no silence corruption)?

It can happen whenever a transaction is being committed (or committing
the fsync log).
Every fs is at risk, unless it's always mounted in read-only and with
-o nologreplay.

A btree node/leaf (extent buffer) is dirty in memory, needs to be
written to disk, this always happens at transaction commit time,
but can also happen before that, if for some reason writeback on the
btree inode happens (due to reclaim, system under memory pressure,
etc).

If the writeback happens only at the transaction commit time, and if
one the node's pages is locked (not necessarily by btrfs,
it can happen everywhere in the memory management subsystem, page
migration for example), we ended up skipping the
writeback (start the process of writing what's in memory to disk) of a
node. This is case 2), the corruption with the error messages
"parent transid verify failed ..." in dmesg/syslog after mounting the
filesystem again.
This is very likely (as we can never rule out other bugs, be it in
btrfs or some other layer, or even hardware/firmware) what
Sw=C3=A2mi ran into, since he never had problems with 5.1 and older kernel
versions and has been using the same hardware for a long time.

For case 1), the hang, it happens if writeback happened before the
transaction commit as well. At transaction commit we trigger
writeback again for the same node(s), and here we hang because of the
previous attempt.
Two people reported the hang yesterday here on the list, plus at least
one more some weeks ago.
I hit it myself once last week and once 2 evenings ago with test cases
from fstests after changing my development branch from 5.1 to 5.3-rcX.

To hit any of the problems, sure, you still need to have some bad
luck, but it's impossible to tell how likely to run into it.
It depends on so many things, from workloads, system configuration, etc.
No matter how likely (and how likely will not be the same for
everyone), it's serious because if it happens you can get a corrupt
filesystem.

>
>
> Thanks,
> Chris.
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
