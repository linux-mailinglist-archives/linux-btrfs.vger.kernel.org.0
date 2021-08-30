Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1F63FBD2A
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 21:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhH3Tuz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 15:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhH3Tuy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 15:50:54 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1627C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 12:50:00 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id n126so30392496ybf.6
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 12:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6VmiuSr7tFuiDv7Ztcal9YXliS9BB3d2FzSxR+M09uo=;
        b=yFjFVRb3FGhbHhkMlwWUGMpLwEXp/PuJLL5zcJ0znaUPd3UENns67xK8wpt6Nzic9o
         BNJ2iiHt9++77sDHFaF2OslDpmr//rPvRQAI8Lc3gjKRsv89U06gmZM+Yt7oZ/yby6R8
         WRZZdVY0212J2fLRiD6XVrXxmhEsRhyDDYa2MQBAAiAC66dj5KAieBPTN0CYjhy8pgeT
         Hb5+Vpw58pPR0U3iI6Pa1XWOxtdqatOvlk5WgWHjFYway3MXUdLweeYy3+/O/u6T1F9x
         yeI+qC+cfQIbRMqUQqUHfni7j/9vE4qjm8T+6URLmg541DfSfkW95N6W5Y3y96jDIRIi
         XFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6VmiuSr7tFuiDv7Ztcal9YXliS9BB3d2FzSxR+M09uo=;
        b=p3+mCLz3ChZ5xAu5xuln1zgHhToJOywjBJxpgU/jW0eu8osghERg4Y/DbHUQ0m0oyV
         xjxznb00B1xjbpFUIsXI1+o9kKNEQHeloJrUaGhl3bMyQ1JTwzl5U1WCurygOuh42jql
         E+94yP9W28rhWyF9ntvbArs9p6ZiWrK7OrjL3HX1CE/AwjYRLuUMW2McJ1oV56q6mx3f
         3XiwvOmrrjGI3FuPRdPCVvxG4JQb/7R1EvzGk+zgdaue2c9cf2iHgpkSpK/JUXhlFo7o
         VY448Q2q1Z1zOtHid9tTmYWgiWR2YeMUbrO+M6Wvl8zt8kUoYfY2trLyZLqF4SisR4Bo
         mTKQ==
X-Gm-Message-State: AOAM530ON7xkhhX74lWWpxE0sE3z1oY9y8UKNKtyT7GwzIRdJ417Qr/Q
        FzSHJ4FapInOMP68aAzMwL8VYdRwu8h41WsUxKv7LcZb4/DJWNAp
X-Google-Smtp-Source: ABdhPJx+VKZ7rCByeqCkj/ruK+DuAMBBYyo6T01mdmePmJXOxQbuoB9FQsbISUJOCGLET1msu7X7ul9Z9aKtT0Mkb4I=
X-Received: by 2002:a25:6cc1:: with SMTP id h184mr24564921ybc.240.1630352998869;
 Mon, 30 Aug 2021 12:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtSXKHSToLeOOconR_nKeuk8RjGjT7_z2QvV9=2zHfYB6g@mail.gmail.com>
In-Reply-To: <CAJCQCtSXKHSToLeOOconR_nKeuk8RjGjT7_z2QvV9=2zHfYB6g@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 30 Aug 2021 13:49:42 -0600
Message-ID: <CAJCQCtSjuEg8LAedxaqpRCOEq5BgegB7=QVJP8Sq3iZUFWn1rw@mail.gmail.com>
Subject: Re: 5.13.8, enospc with 6G unused
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

After remounting with enospc_debug and rerunning btrfs balance start
-dlimit=1 and there is a ton of output...

full dmesg
https://drive.google.com/file/d/1QjsWOCzzYckvXqDroKrAsuG80UGH1AlZ/view?usp=sharing

There are no snapshots. Three subvolumes. There's nothing unusual
about this file system.


Chris Murphy
