Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6706E164E31
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 19:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgBSS4M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 13:56:12 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35066 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgBSS4M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 13:56:12 -0500
Received: by mail-lj1-f195.google.com with SMTP id q8so1516198ljb.2
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2020 10:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4/btNie2yJSHTlvtkEMVrzLJ5p+2iau4ZxcsT8Kh+V8=;
        b=OANlOLlls14aKMkL1WjVjo8f/tVbYdtb8Nt9MCvon8MWsZkBp2wf0M4h4HkivP25SY
         Lor+Pn5WeqeFiam04EJmGY4IF6tW7qKCzkRZwxbdgjj0f2w6R9Z2iIpFLl/G1lsUeweh
         z+TQEaepT45ebjzQ5n9r3U+GEMxGXZG+BGf8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4/btNie2yJSHTlvtkEMVrzLJ5p+2iau4ZxcsT8Kh+V8=;
        b=p9vX8DGpss1u+FSZ6XgaNEeMC12uDTNe6UEmp3VrslCJiC9jnLBBu+awqW7DjigTsw
         /pYuaEXRLA2j8ZEOBs+16D3b3OAXpdC+Qb2vR7ve7EIQjZIOnr49tuZ8eNgtCxifiMDe
         GUIJVVvikAB9kppuRlTuOUW8UYYn15sxAxMnX8N+XIbiAqvktj/h50F5Hony/nOghacm
         WJjmCM++2uYiqrK7KHT6zaujkb7AzAI3xMELw051foJd5uURCtIO2BZeB+h97TwO99uV
         4mOjo6Iel6XfbGGgeOV84RNmiISbtk95vWjvXfr8cMOBxjbtwJMTdidLZOEtx5BUC1OK
         Cg7g==
X-Gm-Message-State: APjAAAWABtC2JwZTEuw5pM9K0ZeMxTpvpx0zedfMXAnQhZ9aJbKtnlIT
        7iPymfnQSOZPUfpew0EbsR9yKL+5gB8=
X-Google-Smtp-Source: APXvYqxX8fT4nZxTXdmpm6sUAaw7v6OX5SSQkLlqNMVAHKWA6Jiy3kzkK6qUSfLBsjAnMrIkXgUbkg==
X-Received: by 2002:a2e:89d4:: with SMTP id c20mr16199741ljk.228.1582138568893;
        Wed, 19 Feb 2020 10:56:08 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id v26sm330910ljh.90.2020.02.19.10.56.07
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 10:56:08 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id x7so1525663ljc.1
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2020 10:56:07 -0800 (PST)
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr16927004ljk.201.1582138567368;
 Wed, 19 Feb 2020 10:56:07 -0800 (PST)
MIME-Version: 1.0
References: <158212290024.224464.862376690360037918.stgit@warthog.procyon.org.uk>
 <CAMuHMdV+H0p3qFV=gDz0dssXVhzd+L_eEn6s0jzrU5M79_50HQ@mail.gmail.com>
 <227117.1582124888@warthog.procyon.org.uk> <CAHk-=wjFwT-fRw0kH-dYS9M5eBz3Jg0FeUfhf6VnGrPMVDDCBg@mail.gmail.com>
 <241568.1582134931@warthog.procyon.org.uk>
In-Reply-To: <241568.1582134931@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Feb 2020 10:55:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi=UbOwm8PMQUB1xaXRWEhhoVFdsKDSz=bX++rMQOUj0w@mail.gmail.com>
Message-ID: <CAHk-=wi=UbOwm8PMQUB1xaXRWEhhoVFdsKDSz=bX++rMQOUj0w@mail.gmail.com>
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

On Wed, Feb 19, 2020 at 9:55 AM David Howells <dhowells@redhat.com> wrote:
>
> There's a file type beyond file, dir and symlink that AFS supports:
> mountpoint.  It appears as a directory with no lookup op in Linux - though it
> does support readlink.  When a client walks over it, it causes an automount of
> the volume named by the content of the mountpoint "file" on that point.  NFS
> and CIFS have similar things.

Honestly, AFS isn't common or relevant enough to make this worth a new
special system call etc.

Why don't you just use mkdir with S_ISVTX set, or something like that?
Maybe we can even add a new mode bit and allow you to set that one.

And why would removal be any different from rmdir()?

Or just do a perfectly regular mkdir(), followed by a ioctl().

> Directory, not file.  You can do mkdir (requiring write and execute), for
> example, in a directory you cannot open (which would require read).  If you
> cannot open it, you cannot do ioctl on it.

Honestly, who cares?

Seriously. Just make the rule be that you need read permission on the
directory too in order to do that ioctl() that is your magical "make
special node".

What makes this all *SO* special, and *SO* important that you need to
follow somebody elses rules that absolutely nobody cares about?

              Linus
