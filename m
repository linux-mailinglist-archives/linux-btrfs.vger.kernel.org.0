Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A780105E50
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Nov 2019 02:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfKVBhP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Nov 2019 20:37:15 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:38690 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfKVBhP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Nov 2019 20:37:15 -0500
Received: by mail-wm1-f49.google.com with SMTP id z19so5837643wmk.3
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 17:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WLoQKgwWNSn6Dn89aZe27ljnFA0hFV7RCQpkONY8jMU=;
        b=LQNi1AJoOY0T/X3Mwj/DiVMcq402bnDfSiB6gQVd4XsAjvaCd8RLgRn9Kjh4d3yi6n
         qVMKUsoPgMaq1Cf+j/3XtaD+ng54PaXaVfTwbDh5+X+sYF21PeswqTFVVsfQG27KoNRU
         sR7K0PpbcMBtsI1+JPyF6qqhEpwHiqBgM8hN1t7Sojw3EdLZAGO60tZsSkTWwxbm0fPi
         xtBcWcXhhPEIpg8rIEmefIIwmnA5XBCfKaRBGuUbBDJIJ8EUxi2HGHfoJ1Vpdp9NkvhT
         KO7vwDZHwtztJc9hn03G+fVA3IatevAow+asoI8JfyNl8d8hkVcppMsv8IZmzA5E7KFX
         6mBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLoQKgwWNSn6Dn89aZe27ljnFA0hFV7RCQpkONY8jMU=;
        b=lEtyQq242g+lpyBaDG6fcQQ1mzvuWRyBqFB9Ufc81FQ8F9aJjuNrNlpTjy2c2hnTcZ
         SyPKysb938zsiKTKWlhztvpw6cKfanB8kbAmTjMOi3MEkuMXIPlInSW9nRXgDg89VtKy
         bEnBWv6aF3h7lHBP9wmHyvQpMahwc5a+QYm5PJJkIo62lrQzCL063lBBzNuw2xD8ia5L
         pFAlzhNuIZWlBC3K0hu8XTI4biLi3U74a13LigUlBrHZ2XsO/b7M+gSa6wFf9uZupzot
         YBpeSa5QdHDFq2Fl33tTd5TGi0PPrMGGYBjqwF503Jc9pQo9yoasxMnEygVZaa4sQxkQ
         EW7g==
X-Gm-Message-State: APjAAAV25nERwodnYL+U18j2sycAstndtcnC7DhhZX/+r/uLwzVdAqSO
        E77RQVBoK8dx+BIiw2O38V84D7v6I3ALgy6F7W3pwjnmgcE=
X-Google-Smtp-Source: APXvYqwwbv2SuxdAdtTDJMhVCo/2biV/f/JZlH686gFFVZs6J/2bIJ12RCUXuCF6dDBUm73qqaX87nmUcQYNn365BxY=
X-Received: by 2002:a05:600c:23ce:: with SMTP id p14mr13697865wmb.176.1574386632838;
 Thu, 21 Nov 2019 17:37:12 -0800 (PST)
MIME-Version: 1.0
References: <20191112183425.GA1257@tik.uni-stuttgart.de> <CAKbQEqFELp0TWzM+K9TqAwywYBxX_3jXy0rz6tx9mNXyKEF02A@mail.gmail.com>
 <CAKbQEqFX8_oU=+KtDsXz-WeEUytgcXr-J-pw+jEmC3dwDAfJMQ@mail.gmail.com> <6893661.AATI4FVq6M@thetick>
In-Reply-To: <6893661.AATI4FVq6M@thetick>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 21 Nov 2019 18:36:56 -0700
Message-ID: <CAJCQCtQFw=ThyCQGdG4nXX2r9--Jv3W9KWdFKLv3Gy-sYw=Xrg@mail.gmail.com>
Subject: Re: freezes during snapshot creation/deletion -- to be expected?
 (Was: Re: btrfs based backup?)
To:     Marc Joliet <marcec@gmx.de>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 21, 2019 at 3:39 PM Marc Joliet <marcec@gmx.de> wrote:

> On a side note, I am also really annoyed by the lockups caused by qgroups.  On
> my Gentoo systems (which use btrbk) I have it disabled for that reason, but I
> left it on on my openSUSE laptop (a Dell XPS 13 9360), which locks up for
> about 15-30 minutes while cleaning up snapshots a few times a week (usually
> after reboots or after "zypper dup").

15 seconds is not at all acceptable on a desktop system, 15 minutes is
atrocious. A computer that appears to hang for 15 seconds, it is
completely reasonable for ordinary users to consider has totally
faceplanted, will not recover, and to force power off. The
distribution really needs to do something about that kind of negative
user experience.

And by the way, I've recently done some unprivileged compilations of
webkitgtk, with default options that cause n cores +2 to be used,
eating all available RAM and swap, and quickly totally hanging the
system while swap thrashing and basically acting like a fork bomb. I'm
using Btrfs for the rootfs as well as user home for this compile, and
have done hundreds of forced power offs during these events and have
seen exactly zero corruptions or Btrfs complaints. So at least there's
that, however unscientific a sample that is.


-- 
Chris Murphy
