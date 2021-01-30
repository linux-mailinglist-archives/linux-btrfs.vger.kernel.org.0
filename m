Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B32D30911B
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Jan 2021 01:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhA3Azc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jan 2021 19:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbhA3Avi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jan 2021 19:51:38 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5A3C06174A
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jan 2021 16:40:36 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m22so14940673lfg.5
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jan 2021 16:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L1JguF+y5YGproR0D5kVlNt1Iwk3FRQ2NGggMOEny80=;
        b=JFUbIimY8sBuKRiPa91g7hAs2SmjvsKwiBLs+UXdjp878f2/IpXclmfTRnngy/s8t9
         Bg1dajuLjsm54ccQXq1qAkh/k8fEGLTajOmJRiFiIQgSjUQrUzl5VtVNZH9hJflI+R0M
         Qn7pV5gdueKnKegM5qzSB+1Wy2uqGIdmzCPlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L1JguF+y5YGproR0D5kVlNt1Iwk3FRQ2NGggMOEny80=;
        b=WhsoQF6iOcAfkJLDOaIAyg7YZmw0p3ZLRM27H25JJKuG8tv5XKETCQjvegyChY8Z9D
         oqtmlGW9vuGS73EONX3JACbwwywuiGKPg2BYLPRwjD6u+B9qJloDJ/3D2of9N0sZEQ94
         R4gy+VResZkwzTgeY/fxAzM6IAntbQbrauJO78Fw92AZqT3jRGufeW96kEdpLCoUcxdC
         gSuDXp2tXSbyEctSb6+a8CqlmwDWnhYBQzkEpyVttrxRV9Drf/66qLwjaQItrsS724Fa
         KFxg/58hE5DFbxU1wAbsm6lwYu5rnkFX/8w4tEtJvNI8+uyxndFKPp7qMetXy2WqAsJq
         PSMQ==
X-Gm-Message-State: AOAM530JDHOABlN8P76xkb8H0/PspEOahLp4OA5NHiTmSqMJTuv0ZsGe
        Mog30o1n2+NcfHTuMz2B5/Hk/21jwJ1vcQ==
X-Google-Smtp-Source: ABdhPJzwOtv5mdRtnttEu8PmYGCjN+ZJVP/6mVEELj+flOQ5nCoJVUHQz4pNfvyJTNdJbx5JPc1KSg==
X-Received: by 2002:ac2:5bc1:: with SMTP id u1mr3333305lfn.27.1611967234181;
        Fri, 29 Jan 2021 16:40:34 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id p22sm2699839ljg.29.2021.01.29.16.40.33
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jan 2021 16:40:33 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id f2so12508776ljp.11
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jan 2021 16:40:33 -0800 (PST)
X-Received: by 2002:a2e:860f:: with SMTP id a15mr3748790lji.411.1611967232750;
 Fri, 29 Jan 2021 16:40:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611932305.git.dsterba@suse.com>
In-Reply-To: <cover.1611932305.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Jan 2021 16:40:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgOWo_i6Xv4JFMd+i3nKhhc4i-_zOeOO=dfTb523TpB+w@mail.gmail.com>
Message-ID: <CAHk-=wgOWo_i6Xv4JFMd+i3nKhhc4i-_zOeOO=dfTb523TpB+w@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 5.11-rc6
To:     David Sterba <dsterba@suse.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 29, 2021 at 4:37 PM David Sterba <dsterba@suse.com> wrote:
>
> I'm not sure the first post of this pull request made it through so
> sending again.

Already merged a few hours ago as commit c05d51c773fb.

But you may have fallen afoul of the "either lkml or lore is sick"
issue, so pr-tracker-bot isn't working.

We've had a few of those lately.

             Linus
