Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68AAA10DE65
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Nov 2019 18:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfK3RPF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Nov 2019 12:15:05 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:34460 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfK3RPF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Nov 2019 12:15:05 -0500
Received: by mail-wr1-f46.google.com with SMTP id t2so38695265wrr.1
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Nov 2019 09:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sHZd9v4sJbiv+Xitc5Hve6PzvpTBZ7zdoUJg7QkR2BU=;
        b=Is2QVUYZhW1ujIN8yvoNpFBd9pUjgbuBDA5VKDgm6bNOOBNvITLzokToN1PGvWZHp2
         NK3YFzJqcQnfzwvyrPDUgPbY4timEeABCQdmkkZgAW1KpKWSdIYF1xIvhOezCCn1PBnH
         YSLf9P4gV1nbPA9crNu6s42wA2nMI7AztuntBJGYfgcdzJy2IRaU44wheBAFZcQ8Y5BU
         f2h79FzKV4Ww0nIMA01ynEO7lSMz7Jyc5AC0IKzEEhN5wBM1NCaZwIezXCrufNrYv7oD
         ayV+fcKTPHvzV8PRPnqMN2hqWQOv6LPSlD+oiUxacG9AceN0y9TOfnbR+mIgX6p53CLp
         e6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sHZd9v4sJbiv+Xitc5Hve6PzvpTBZ7zdoUJg7QkR2BU=;
        b=ADKVUUBmxODFYITlGby4pl66ccpuwEVmbadzSImr9H+RM1WN0lHsn2/acP2yechfHn
         CgZU1qEr5m6nPXMKPTI+7w1QHq7VHT4m1hvL/N01KQi11qjPT8to8RcfzDqBDZkq76Pd
         ADFCqmCarP3w89jnkhvSVGOjGUfY+q6iXn31SigLh9hEUH0TfyXNcnYEwntNT+jSPT1b
         isVrWKISu/rz2o9qrPN0uXLC4hNyHtqONUTjwpx5z8ZPu3mWCt/bkxkEj02EsTv+On0N
         vkwqJ4MZJwv6Hg/e65hMjT5H3XyPVOYCWAE/aICl3jbrg9He75UEn9pfLTt7rFRVOe0v
         1vYQ==
X-Gm-Message-State: APjAAAXh0SxE332JbmjSaoudMb48y6uZLXczkZQNf9JJUrycxeJqQPIP
        5AKgSlwEO2ePJVLyurLhDqsLXPYEfddMikVmLdyYxw==
X-Google-Smtp-Source: APXvYqxWH14sNGOITqC6VfOydnQCH4nJ/47mY9Jy5OB5UV4LoUQttZZdbn5YrXHBUZBfV9mRVg2lq/973PuhHIgvrTg=
X-Received: by 2002:adf:ea4e:: with SMTP id j14mr11992084wrn.101.1575134103080;
 Sat, 30 Nov 2019 09:15:03 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeZu8fRzjABXh3wxvBDEajGutAU4LWu0RcJv-6pd+RGQ@mail.gmail.com>
 <a48a6c50-3a03-0420-ad8c-f589fafe6035@libero.it> <CAJCQCtR6zMNKnhL7OZ8ZGCDwPfjC9a1cBOg+wt2VqoJTA_NbCQ@mail.gmail.com>
 <be389a15-4659-2cc8-ffe3-f2305f6f4775@gmail.com> <CAJCQCtTuu=k3FsKYmon4zP2b7c9D3zYzJwGZ3pLzFXMoJTepYA@mail.gmail.com>
 <6bc5b69e-188e-a7b2-e695-bd1bcb6a9ba3@gmail.com> <CAJCQCtQxR4Xnikz7vVxOX-gzU6aWzu5eHeG95HOKsx40ziTGLg@mail.gmail.com>
 <8a86c7ef-39ab-7c35-f39b-e05ab7543a11@gmail.com>
In-Reply-To: <8a86c7ef-39ab-7c35-f39b-e05ab7543a11@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 30 Nov 2019 10:14:47 -0700
Message-ID: <CAJCQCtRsjA=TTY8XY3QLO_uJVsGD1-E7k3OvnOdTnOJ76pezVw@mail.gmail.com>
Subject: Re: GRUB bug with Btrfs multiple devices
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Goffredo Baroncelli <kreijack@inwind.it>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 30, 2019 at 10:02 AM Andrei Borzenkov <arvidjaar@gmail.com> wrote:
>
> GRUB is normally using hints - grub-install (and grub-mkconfig) tries to
> guess firmware device name. At boot time grub tries to access hinted
> device first, if it succeeds, it does not try anything else. With second
> btrfs partition grub needs to find second device at boot time so it now
> probes everything and hits those vendor media devices.
>
> At least this explains what you see as well as ...
>
> > Last time this
> > happened, all I did was remove the 2nd device and the problem went
> > away.
>
> ... this.

Ahhh, that makes complete sense. So it is Btrfs multiple device
related, but not a bug in btrfs.c per se.

>
> If you go in grub shell in this state (without errors), do you see those
> ghost devices?

Uncertain. My vague memory recall is that yes they are there, because
I found their existence strange and different compared to pre-GRUB
2.02 where on this same system I'd see only either hd0 or hd1 (one
without the other), along with cd0. But something changed either with
a firmware update from Apple, or GRUB, that resulted in additional
GRUB devices, hd2, hd3, hd4, hd5.

> > I'm ready to try that again (remove the 2nd device) and see if
> > the problem goes away, but has enough information been collected about
> > the present state?
> >
> >
>
> If you are reasonably sure that all errors are related to those phantom
> devices - I would say yes, the reason for these phantom devices to exist
> is already clear.

I'll give it a shot in a bit.


-- 
Chris Murphy
