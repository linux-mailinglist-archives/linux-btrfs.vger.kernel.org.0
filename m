Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE27610DACF
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2019 22:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfK2VLi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Nov 2019 16:11:38 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:33525 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfK2VLi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Nov 2019 16:11:38 -0500
Received: by mail-wr1-f52.google.com with SMTP id b6so7063276wrq.0
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2019 13:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BttwyHbsI+YRI/4J0H/+iFpbwe1K8g5Sj3hj4ugS5BQ=;
        b=G8/xtO9BqtA39ixb92EuhBMOVG6zdDXMImc6tOwrn267ah3geBGFbXG8amLYUuzHJB
         yG86xNAfUaXNOtRaAuQzpM6JmA5jUsJnxX+4zk56MvZ2pxTiUtx4EuaXe9k6jX2ykyl0
         I2LnBGWyo2SHmMyyehXXQPgP7IG8Db/d3J04kLP+o/ptZxglo7BzeS500elVuDhAODZ/
         Fw41V2z58x3WdGe4Re5PxiJFyf/Btyj3oGr4UgephQ6bVLwIElHQJlQskE5Ab+oq86pO
         vJFI6ufqcK7gvH4FqKi80fM75EG9KOlmEA5JYcxfNUEyZdVfouM+bFHNTW6paeHmMj0V
         tWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BttwyHbsI+YRI/4J0H/+iFpbwe1K8g5Sj3hj4ugS5BQ=;
        b=Mpu5XaEI3QQUkWJiJ9kBeyUPMKrzeuUfeQ8xAV6MBgWkv+PERtseBO6vmJ27U7iN6B
         aUgERy8dCUhSbBrSEZWNSgNdt2TE0w0XNfOzaoLneJs5lfHcOsuBFM2lxB6qtQZ+yIja
         WCXQR8+NaG2laK/cfvUZlmFMWD0qmZkF7nE9cjqrQWW+gyjYX40ulVlTNHzVjN8WpssV
         cOI0ZCHopOsJGsZ4K8J5RiTfiAIxZ9EPJND/TScsdljCobm/km1kpIelEF5BeDrJ7S2x
         kLJdAjLr6u3TsFMCshT3HJj72fUqZ2blLYNZLuMdUDR7pYD5UFIrwvt0QqzQVSt7NI7f
         MmmA==
X-Gm-Message-State: APjAAAWPBfVrUKb10A0Mc5c3F5vf6H4UX4yVpC59ZGAkHikaYJvpgJKb
        ksArKHI3ynghUGXsG2Y1Qzwvn3uckg4Ir6LSekFA4w==
X-Google-Smtp-Source: APXvYqwU76xlgA6wCmiHVQHA/YMg7PgFCXjCh/GxhCAvXoPCT/VxBqp3ks7h1Zt81LbbPMKaUpWqUD7BHuvmJY1uXIc=
X-Received: by 2002:adf:82f3:: with SMTP id 106mr11467915wrc.69.1575061896817;
 Fri, 29 Nov 2019 13:11:36 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeZu8fRzjABXh3wxvBDEajGutAU4LWu0RcJv-6pd+RGQ@mail.gmail.com>
 <a48a6c50-3a03-0420-ad8c-f589fafe6035@libero.it> <CAJCQCtR6zMNKnhL7OZ8ZGCDwPfjC9a1cBOg+wt2VqoJTA_NbCQ@mail.gmail.com>
 <be389a15-4659-2cc8-ffe3-f2305f6f4775@gmail.com>
In-Reply-To: <be389a15-4659-2cc8-ffe3-f2305f6f4775@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 29 Nov 2019 14:11:20 -0700
Message-ID: <CAJCQCtTuu=k3FsKYmon4zP2b7c9D3zYzJwGZ3pLzFXMoJTepYA@mail.gmail.com>
Subject: Re: GRUB bug with Btrfs multiple devices
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Goffredo Baroncelli <kreijack@inwind.it>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 29, 2019 at 1:50 PM Andrei Borzenkov <arvidjaar@gmail.com> wrot=
e:
>
> 27.11.2019 02:53, Chris Murphy =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >
> > The storage is one CD-ROM drive and one SSD drive. That's it. So I
> > don't know why there's hd2 and hd3, it seems like GRUB is confused
> > about how many drives there are, but that pre-dates this problem.
> >
>
> grub enumerates what EFI provides. What "lsefi" in grub says?

https://photos.app.goo.gl/pBxLJNdbzz6J9Vo56

--=20
Chris Murphy
