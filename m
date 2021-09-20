Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067194119EB
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 18:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbhITQiz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 12:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhITQiy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 12:38:54 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66484C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Sep 2021 09:37:27 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id ay33so44517707qkb.10
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Sep 2021 09:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=UBMN6/0DXy+tw/XO2C+esn6cfWr+gC9Xx5B81rD7k3Y=;
        b=oG0VsVe7ddHQE+dygySuttedT/T7qRnpIn1vBFYFp197FKWM3mXjjukyRPFM0rEa6f
         kzNSh4sOE3LLSnnl4sHToz0llZLtSw8s18C92/2FmIjEMaxwxmvxemDm2NYtwAX92naO
         KPbjoBPIH9lQHZdKOQ7K2lgpKeJe3A9yRLjr67YN+hlM/qBv6iBtfHB4YVujncge2Wio
         gm5AoYqRTOxFzwZZNyCky6yp/2AuHJhgVsW1YFqzu1IEheqrJdFJJzWZc7LkVX4H5gpW
         KGRjFUTp3LWzrbC2NP5a5drQo2Hq7SHTz8Yw6mCBM4KGgPSj5XzsIcAKk1oft4txwfuL
         xHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=UBMN6/0DXy+tw/XO2C+esn6cfWr+gC9Xx5B81rD7k3Y=;
        b=WnkWx1DuXm/7Whzp9k59jCr9nkXvhmJtZiLQ7rbaUddQxRvN2tsYbmb5YWs8hsWDWe
         mFpiq1gaiiwRr1hZ8/eRDPKTzWZxgx/GO+88c71C1A+tyf3cxwktf4jN0TgEJunxWTtZ
         kCDyMe/+WHL8ZdGC2MTUejRwH3BzuWmvNcF5EkUT7OK+lnLzbtmpeiUIpGkTiiutbzNM
         6RgnI5u4WXEoETastx6SpqaXZZbuZysZ7253tx4bqrUbxQKxphG7vIFsG8oC1fw/hAcU
         3/U3s9FZqcZN8n+9zcz1ss0D8WB8YVBtb0Jq15jhzsXkqhnCZMtr0bfijhXsD/Q1c7tE
         iGzQ==
X-Gm-Message-State: AOAM530dudZlrfoqkBoLlwZ4lnPPasrE4+nl8pF+sIwd7WtlQH+0weFF
        bSnX04kknfD1kU6xLuL/RQs56Lopqm8zbKKHKzC0Ii2bdH/Bj2Sr
X-Google-Smtp-Source: ABdhPJx+3GUez1MxTiJa9VF1/OQmlCUyXXh1YIIrgW/jfUZf5WcPZWzOKwpWDqffQFmjtEhftRbmFWR9YrmMBA62IaE=
X-Received: by 2002:a25:840d:: with SMTP id u13mr18780014ybk.455.1632155846383;
 Mon, 20 Sep 2021 09:37:26 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 20 Sep 2021 10:37:10 -0600
Message-ID: <CAJCQCtRbktnZ5NxRTZL9UKvTr1TaFtkCbeCS2pVnf2SPg8O3-w@mail.gmail.com>
Subject: bug: btrfs device stats not showing raid1 errors
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

https://bugzilla.redhat.com/show_bug.cgi?id=2005987

Various kernel messages like this:

[2634355.709564] BTRFS info (device sda3): read error corrected: ino
27902168 off 8773632 (dev /dev/sda3 sector 52960104)
[2634355.733898] BTRFS info (device sda3): read error corrected: ino
27902168 off 8749056 (dev /dev/sda3 sector 52960056)

And yet 'btrfs dev stats' does not show an increment in tracked
statistics, in particular read_io_errs

This does seem like suboptimal behavior.  Discussed a bit on IRC today
and Zygo found the behavior is introduced with commit 0cc068e6ee59
btrfs: don't report readahead errors and don't update statistics

Zygo on IRC writes:
readahead errors are things like "out of memory" or device-mapper nonsense
so the best is 'don't correct and don't count'
since there's probably nothing wrong with the underlying media
but if there is something wrong with the underlying media, we want a
proper read, correct, and count to happen
which means we can safely do nothing during readahead
so the right answer is don't correct and don't count
---

I'm not sure how noisy it could be to always report such read errors
discovered during read ahead, but my gut instinct is that anytime
there's a read error whether physical or virtual, we probably want to
know about this? If these are bogus errors then that suggests (a) do
not increment the dev stats counter, and also (b) do not fix up.




-- 
Chris Murphy
