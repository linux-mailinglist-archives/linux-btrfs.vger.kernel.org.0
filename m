Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80F22E63A5
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Oct 2019 16:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfJ0PTN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Oct 2019 11:19:13 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:46441 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfJ0PTN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Oct 2019 11:19:13 -0400
Received: by mail-wr1-f54.google.com with SMTP id n15so7244325wrw.13
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Oct 2019 08:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2QvCkHsdBxyseKDfP+yV+j7V97rqns1SdcevM9uinWY=;
        b=l/I4W64Lhw2KE1q87h7ptTo7oX9y0ZdIR+gVlfiu5P9Ivgaf/pgN501XJcA9A5xhgx
         Ys2NGA9oVV3dEwLMXipv9zOR+DQPTuP0NFEyhoVbec6w3qaw33Wv+TMDmI5Q3zsbD32g
         /vtch8S52WLvHLZ1O6qHHfg6AVLOoDFNPlxf5E62DxL/0uQms/qjXoAI72Gc/Gv/wW0/
         KhOtDYSZmTFWqZ4gvgPdXE6KYZ2dM4AcsMF1G4VLv4bBCJWOOvh+sPdJFNrnONsGZ4/y
         O8tm6S231BnLzclSZUJMYnubE2lolNG9MNKnEhLPfdaF6DBTNLxj1+0xIhPtD4QCf81Y
         qFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QvCkHsdBxyseKDfP+yV+j7V97rqns1SdcevM9uinWY=;
        b=rXPfMwwU6srujw8W/uAQh2XjisghOMz3LUBB+tYgJF1Gp1PF0DwAw1MxXXHDEgbssD
         94uxeTAgiVaaibH5re97O4OHdaX4/5Q7WrC2c8OdnHHSH1ZSRva7/zLComPrRWzgRq2/
         XnXbPA0IB77HoLl8M7uAzm7C+guMvK8bNgGkw5/w/cBWNwj9U1jFFzc050hdlt9WnPxC
         5ihrdw3bp23CjEUZoWGaAHaTtnIdUhWzUyiVz+M6ZjDZDDN+xR/yBKK7UDpSFqkM6ffi
         Jp3pASN78CyDeAwNWq+A0vG/sjZ4FEyO3qxYbwRnpRLkiPVmTdEQMRe7YRRdefHKAPer
         JY0w==
X-Gm-Message-State: APjAAAXzNmOtkp8wpqyrBg34FARnbKkSS1Q58heAj+SzFWkP9nXEtg6g
        NyYTBYGuk8FBf3wFjIMyu4SC19O9PGqDcwaBPRc=
X-Google-Smtp-Source: APXvYqwEZo7Kli0fcWRB2/M3FIs1wUgmgB36an982dTiV1jpFbVpeKBGKbJj/N/YM3g1M3RBmVG5HnZvFeF29jbGByo=
X-Received: by 2002:adf:ea11:: with SMTP id q17mr11307459wrm.83.1572189551289;
 Sun, 27 Oct 2019 08:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAE4GHg=W+a319=Ra_PNh3LV0hdD-Y12k-0N5ej72FSt=Fq520Q@mail.gmail.com>
 <cb5f9048-919f-0ff9-0765-d5a33e58afa7@gmx.com> <CAE4GHgmW2A-2SUUw8FzgafRhQ2BoViBx2DsLigwBrrbbp=oOsw@mail.gmail.com>
 <b4673e3b-b9b2-e8e5-2783-4b5eac7f656d@gmx.com> <CAE4GHg=-K3JdhvQpTC8fPGBm1sVLDOUW+UkBCSZJwz27fkW90A@mail.gmail.com>
 <944da320-f5ff-9290-27a1-e39aed7d6d21@gmx.com>
In-Reply-To: <944da320-f5ff-9290-27a1-e39aed7d6d21@gmx.com>
From:   Atemu <atemu.main@gmail.com>
Date:   Sun, 27 Oct 2019 16:19:00 +0100
Message-ID: <CAE4GHg=SvCH-S9XiSJQ-gjSE5qFay3cssh+md5e7uOTNq9BWfA@mail.gmail.com>
Subject: Re: BUG: btrfs send: Kernel's memory usage rises until OOM kernel
 panic after sending ~37GiB
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Backref walk is quite tricky in btrfs, we don't really have a good way
> to detect whether it's a good idea or not, until we crash...

I see...

>
> But at least, we have some plan to fix it, hopefully sooner than later.

That's good to hear

> That's correctly, that will punch holes for *unused* space.
> But still, all 0 extents are still considered used, thus won't really work.

Ahh that's what you mean, yeah it won't get those.
But the thing is, most all-0 pages should occur in unused space of
disk images, there shouldn't be much else that stores so many zeros.

> Since deduperemover has already skipped all 0 extents, it should be a
> big problem I guess?

As I said, I might've ran it once or twice without the flag but I
don't fully remember anymore.

-Atemu
