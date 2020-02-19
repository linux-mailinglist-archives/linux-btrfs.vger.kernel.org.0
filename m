Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4B1164FA6
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 21:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgBSUNU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 15:13:20 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41059 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgBSUNU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 15:13:20 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so1728342ljc.8
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2020 12:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bgq6Y7b2zz3iA7vvFl1zD3iuBLDCnggP0uD/ReDPtoY=;
        b=L1xcjpv9tg4ovUYUrEvMleJYYGnxMSzUIGeTIEI8pb3Dp4HZy1mT2JTLUJYr+nQrPs
         RkPEHZFY1/xrXLf8wYx0g7zYXtc/srkM5eYLE0fb8urwD0Hu/6f09qRJUwi9vY+uxkbK
         MkE8Vg3sCpw9CxMHOqUIpxk4GiRP39hrEEF6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bgq6Y7b2zz3iA7vvFl1zD3iuBLDCnggP0uD/ReDPtoY=;
        b=ojFTiCUCTF072OwB/byQa8nLzohRjalgFQM0oJ99cX1sJo/j1UWDcQapmv0Uk8tdXM
         AKJmeEqRsrBibCMSCBwe2qYDeyy4D/ZUoRlgvnO0urnQnB2aVZ6zCBm/kIhYy6w6ZZEk
         XX9gYQdLcsj02Fi2EBvQc3OVHnQDNU9kbVHu0QRgt7qtDUH63U/3oOOm4XdB0jhffNfi
         E3qH9voLSfL4A5qKqRULOsyJjAxLnLx4PvaFqTPVTgk4HAoZTO0nmX2ihn96ZHB+pZb1
         zfO+j30II6nQzovfkrvWQSAf477DnfCyVKE+CtwaZAPqKcWMaPfJ8ZmOeblEWN6xuPo+
         dKHw==
X-Gm-Message-State: APjAAAXwBu4NyDdAVfkn5jfC5D0KDwldQ6kdOivgkORckcXkaxvaj3Ep
        7bL3H+f/3WXp3gPnxPkF2nV6o43IDz4=
X-Google-Smtp-Source: APXvYqxyUS/h5YIBs0r9tR/c0nsoMAxLi34s8ZNvmXbrm4OnsMEx3p16pvvMI1s21kvr4lPzTEPKfw==
X-Received: by 2002:a2e:9d0f:: with SMTP id t15mr16788804lji.171.1582143196613;
        Wed, 19 Feb 2020 12:13:16 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id q10sm405923ljj.60.2020.02.19.12.13.15
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 12:13:15 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id y6so1768014lji.0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2020 12:13:15 -0800 (PST)
X-Received: by 2002:a2e:9d92:: with SMTP id c18mr17708042ljj.265.1582143194731;
 Wed, 19 Feb 2020 12:13:14 -0800 (PST)
MIME-Version: 1.0
References: <158212290024.224464.862376690360037918.stgit@warthog.procyon.org.uk>
 <CAMuHMdV+H0p3qFV=gDz0dssXVhzd+L_eEn6s0jzrU5M79_50HQ@mail.gmail.com>
 <227117.1582124888@warthog.procyon.org.uk> <CAHk-=wjFwT-fRw0kH-dYS9M5eBz3Jg0FeUfhf6VnGrPMVDDCBg@mail.gmail.com>
 <241568.1582134931@warthog.procyon.org.uk> <CAHk-=wi=UbOwm8PMQUB1xaXRWEhhoVFdsKDSz=bX++rMQOUj0w@mail.gmail.com>
 <CAHk-=whfoWHvL29PPXncxV6iprC4e_m6CQWQJ1G4-JtR+uGVUA@mail.gmail.com> <252465.1582142281@warthog.procyon.org.uk>
In-Reply-To: <252465.1582142281@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Feb 2020 12:12:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgtAEvD6J_zVPKXHDjZ7rNe3piRzD_bX2HcVgY3AMGhjw@mail.gmail.com>
Message-ID: <CAHk-=wgtAEvD6J_zVPKXHDjZ7rNe3piRzD_bX2HcVgY3AMGhjw@mail.gmail.com>
Subject: Re: [RFC PATCH] vfs: syscalls: Add create_automount() and remove_automount()
To:     David Howells <dhowells@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>, coda@cs.cmu.edu,
        linux-afs@lists.infradead.org, CIFS <linux-cifs@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 19, 2020 at 11:58 AM David Howells <dhowells@redhat.com> wrote:
>
> Actually, in many ways, they're more akin to symlinks (and are implemented as
> symlinks with funny attributes).  It's a shame that symlinkat() doesn't have
> an at_flags parameter.

Interesting. Then you'd get the metadata as the symlink data. Is the
size of the available buffer (PATH_MAX) sufficient?

In fact, would PATH_MAX-2 be sufficient?

Because POSIX actually says that a double slash at the beginning of a
filename is special:

 "A pathname consisting of a single slash shall resolve to the root
directory of the process. A null pathname shall not be successfully
resolved. A pathname that begins with two successive slashes may be
interpreted in an implementation-defined manner, although more than
two leading slashes shall be treated as a single slash"

so you _could_ actually just make the rule be something simple like

   symlink(target, "//datagoeshere")

being the "create magic autolink directory using "datagoeshere".

The advantage of that interface is that now you can do things from
simple perl/shell scripts etc, instead of using any magic at all.

> mknod() isn't otherwise supported on AFS as there aren't any UNIX special
> files.

Well, arguably that's a feature. You _could_ decide that a S_IFCHR
mknod (with a special number pattern too, just as a special check)
becomes that special node that you can then write the data to to
create it.

So then you could again script things with

   mknod dirname c X Y
   echo "datagoeshere" > dirname

if that's what it takes.

But the symlink thing strikes me as not unreasonable. It's POSIXy,
even if Linux hasn't really traditionally treated two slashes
specially (we've discussed it, and there may be _tools_ that already
do, though)

         Linus
