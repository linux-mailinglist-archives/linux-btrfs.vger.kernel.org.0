Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1D51164EDF
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 20:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgBST0j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 14:26:39 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43348 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgBST0i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 14:26:38 -0500
Received: by mail-lf1-f65.google.com with SMTP id 9so1021709lfq.10
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2020 11:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1fTub4GYfjONmIT82CPg1N7dCoXEnM2Sw2O8KqYucXw=;
        b=TTXA143+I9mRmEBx9/1NhLISHKMsH6waUZcmcpT1BguCNEKTR0hF7JmV5HoBZEGz3o
         db9fi0sUaay+pAz0CQoHWY2cCDHTPEMKkMTVnGzY174vOn3S+TeHtv27+wikNuljtZEX
         gzePqVGy4l+pJiMwf4qLcoz9ecA3N8Y267gYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1fTub4GYfjONmIT82CPg1N7dCoXEnM2Sw2O8KqYucXw=;
        b=Es5PGiOX91uwhBloZ4AL9HzJMUBFZ4uhWWoPIB781ULbP6uSONJ8TpgrVjoNtRbB+O
         Et6HXL/pIQxK9sr3OMRYEmgzMV+1RTIA4Nbse2rjFM9R8mqfCVMVO9W4u6SghDx8gFe/
         7nXFbILOuaDWj64Fbq93tzPVZskZL6p1c25TIUBDWfjGKzVYlr0fmXBvNOQi4iqzjQ41
         cB+P4xAXTngtPA/cFYinzWK7kYTXvSVcRMOXNYx5Mvgu1aJJYCVdsL7XoLF9AV6gjqAo
         n6+jyFWe+XryRuXhxtHnThrb1FxUei5HVNzbAP+O+pM/w6iVD2MDzd21hmKrjK133P73
         B+Xw==
X-Gm-Message-State: APjAAAWWxfnYOIFdDgRBiX8+j46MBBBK2cvwKwc/ExwbtO1lDmYLiIUB
        6jycFHWIPdb4LaViyhxdaVayum8c5Eo=
X-Google-Smtp-Source: APXvYqxUTg7d8XlAZ86q+Up6vBIlAhcrTpSv74AZ5idDL+MSML7lUPjWPn+akSFqsrUh2lju4LFhbw==
X-Received: by 2002:ac2:52a2:: with SMTP id r2mr14095463lfm.33.1582140396071;
        Wed, 19 Feb 2020 11:26:36 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id m24sm379122ljb.81.2020.02.19.11.26.34
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 11:26:35 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id h23so1583738ljc.8
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2020 11:26:34 -0800 (PST)
X-Received: by 2002:a2e:909a:: with SMTP id l26mr16050682ljg.209.1582140394436;
 Wed, 19 Feb 2020 11:26:34 -0800 (PST)
MIME-Version: 1.0
References: <158212290024.224464.862376690360037918.stgit@warthog.procyon.org.uk>
 <CAMuHMdV+H0p3qFV=gDz0dssXVhzd+L_eEn6s0jzrU5M79_50HQ@mail.gmail.com>
 <227117.1582124888@warthog.procyon.org.uk> <CAHk-=wjFwT-fRw0kH-dYS9M5eBz3Jg0FeUfhf6VnGrPMVDDCBg@mail.gmail.com>
 <241568.1582134931@warthog.procyon.org.uk> <CAHk-=wi=UbOwm8PMQUB1xaXRWEhhoVFdsKDSz=bX++rMQOUj0w@mail.gmail.com>
 <CAHk-=whfoWHvL29PPXncxV6iprC4e_m6CQWQJ1G4-JtR+uGVUA@mail.gmail.com>
In-Reply-To: <CAHk-=whfoWHvL29PPXncxV6iprC4e_m6CQWQJ1G4-JtR+uGVUA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Feb 2020 11:26:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=whE0uzJy1C5z-GB-s7YioW_yhiEaes4cNa6tLJwyx19gA@mail.gmail.com>
Message-ID: <CAHk-=whE0uzJy1C5z-GB-s7YioW_yhiEaes4cNa6tLJwyx19gA@mail.gmail.com>
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

On Wed, Feb 19, 2020 at 11:07 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Actually, since this is apparently a different filetype, the _logical_
> thing to do is to use "mknod()".

Btw, don't get me wrong. I realize that you want to send other
information too in order to fill in all the metadata for what the
mountpoint then _does_.

So the "mknod()" thing would be just to create a local placeholder
(and an exclusive name) on the client - and then you do the ioctl on
that (or whatever) that sends over the metadata to the server along
with the name.

Think of it as a way to get a place to hook into things, and a (local
only) reservation for the name.

               Linus
