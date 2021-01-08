Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DDE2EEF52
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jan 2021 10:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbhAHJST (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jan 2021 04:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbhAHJSS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jan 2021 04:18:18 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC8BC0612F5
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jan 2021 01:17:38 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id v126so7885410qkd.11
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Jan 2021 01:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xJnl+FZ1gpOcd35fdEFuMTp9+v183tYb0UiM+fOy7cU=;
        b=di5xAHbQJBIzcIWF3bZji77qGMchbDheH0ljp9OeVzxTJsTkb1EEh34uHGhcXd+m8m
         5iqambvjFTe572A7AoC16IwDHfrRhZxHxhlJzWPmrO1wJUB205Y1INzACZRzIQbU9YXZ
         /ypBV5AK+hR/1EyVAzOpzWPZOenaDnRLgHgUW80KsjG1DpqABnI+g6n/LxGbUjGS2lHg
         6E6v8FlKp76BiO+yl2ER5CEkut0OvIkrLvOUmf3a7890RChpZNYop62WodONPAA2yvZM
         RGZOXFC2C1OwJlfrLDF60NCJEYq5gN5LAhZAnaTix/0HE5uGhgns7qZ8nbufaKH37Nix
         SIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xJnl+FZ1gpOcd35fdEFuMTp9+v183tYb0UiM+fOy7cU=;
        b=TfiJ64BWXfxMP00oqHHA4eDTBC88alSi2xreAEX81clukqL+AZRUqCNDbJuirxiq46
         iGG9IZZc3ybwLR7NyKDWj7UaCF8ES+OlZMCp4ygtukM/5D2kp38Rz17kHzALFOBLlk9E
         nj3tRLzclkrPYGd6VVo69i9FMpOxtsLrfHBqfTQg/NtDv4Z/ah9s/1LSUuUUwawbd0ru
         7jF9C7lfjry2o23bq68k+/5VmC5oBITNZg36N3HJyQOqC6zP/RPPPR1D+yhkUzt/wz6F
         ErE+EFrkRof8f9ohJgNxcoepprqpflnboJkhD15IPH+8wcfMudOANNnL/KPkks7kNDOW
         Kadg==
X-Gm-Message-State: AOAM530qLcyCynUqxz8povCrNX9sT4SltlDsD995sGhRUZyBwfKD8NMB
        VLFbeIJpzGsUjMCMpBS/s6IjQVtNdLtyq0L7IT27cw==
X-Google-Smtp-Source: ABdhPJwgedTY862qpgm479A9m2UJWEKg7jtCcvc3RXMc3hBBjnqJesYi2jlShDdx8J8kJGzFlV2lK/PbOOI2sqRem/k=
X-Received: by 2002:a37:4285:: with SMTP id p127mr2790403qka.501.1610097456944;
 Fri, 08 Jan 2021 01:17:36 -0800 (PST)
MIME-Version: 1.0
References: <00000000000053e36405b3c538fc@google.com> <0000000000008f60c505b84f2cd0@google.com>
In-Reply-To: <0000000000008f60c505b84f2cd0@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 8 Jan 2021 10:17:25 +0100
Message-ID: <CACT4Y+YJCMyTDrUFWXEnZ-raQMos0+1F1O8k5eX998pqNUWKSw@mail.gmail.com>
Subject: Re: KASAN: null-ptr-deref Write in start_transaction
To:     syzbot <syzbot+6700bca07dff187809c4@syzkaller.appspotmail.com>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 7, 2021 at 2:11 PM syzbot
<syzbot+6700bca07dff187809c4@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit f30bed83426c5cb9fce6cabb3f7cc5a9d5428fcc
> Author: Filipe Manana <fdmanana@suse.com>
> Date:   Fri Nov 13 11:24:17 2020 +0000
>
>     btrfs: remove unnecessary attempt to drop extent maps after adding inline extent
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ddc30b500000
> start commit:   521b619a Merge tag 'linux-kselftest-kunit-fixes-5.10-rc3' ..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=61033507391c77ff
> dashboard link: https://syzkaller.appspot.com/bug?extid=6700bca07dff187809c4
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a07ab2500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10fe69c6500000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: btrfs: remove unnecessary attempt to drop extent maps after adding inline extent
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: btrfs: remove unnecessary attempt to drop extent maps after
adding inline extent
