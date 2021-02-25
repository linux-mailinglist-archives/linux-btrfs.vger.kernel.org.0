Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698BC324A43
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 06:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbhBYFxP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Feb 2021 00:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhBYFxN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Feb 2021 00:53:13 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB84C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Feb 2021 21:52:33 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id a11so256090wmd.5
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Feb 2021 21:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rJo5BAhhzzY5zuemXHbL5hJv4BM0Vs2Jz7+cjCUI56I=;
        b=ImftT48JjlXtulCKm1rS0md05broD2Na/xxnUzCx60OQuCKnSI5yYTH3WgHBfjOd9a
         m4L83GKJYBxSujnUjj5uNqrrpRcSuGswSa0pg9OjyFp6dmoiWGyqi1Zu0hgXQlNrSwkF
         AI7mUwHR+2zIkAx5rCEZrdN9EC6D/kJhdfWAeeIXD43iRSpNL6+POEvPAsTHh7logfAE
         5T78DlGuMsRzkNaStlMXj/65G3MWVcLmnFtymOrt5s+fkHrqHuBziiF1ZFf05YDiO6ci
         2tbUwyOlESLk9vbohpAbNXUyJKXg+LKlJWGVJ9fdDvLO+jNrDPh5Gmo7VsFbZVoHXPtc
         jhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJo5BAhhzzY5zuemXHbL5hJv4BM0Vs2Jz7+cjCUI56I=;
        b=UntFOZ7H2vi9Y5QLEea2nKm7cU+9r5AaIhCakeLBLFO2Nl91psCOgxHl5r1nKRizMn
         pP5+nulkmqHxBVNJ0hluL9e80rOYoaDXkHuNV6hURzS6QV+iJOq00sfF/m6Op6pL9JOV
         iuNptr0nYMCTIznwBS9Mr4CKDsjIVvc+f2gWSPIiX+VXwHh8YHcS5wyjfvfXRwgxDg3E
         nrL7jPNdX/j4YTMHZCD4bhQVQqrlNmngOS+MFNkaCBPvGNYs8Wp86Vk84yBCEyRa4rHZ
         GbzisyUOrwXTkBs4tffJe5r63wbG8yUlsPa4Gx+ZD5RYHoh6py/905LNpzPLkU+DIiEQ
         J26A==
X-Gm-Message-State: AOAM533j3vm0YVVbVOdL5ZMLHVNWwe0Nx+MhXWHrL3+ky5wM6a5a6uWy
        vBhndih9F8W+oPPfzfuEVFyi01KNV1wFVajM7vXR6g==
X-Google-Smtp-Source: ABdhPJxRvxq0t8f3cWesmANuSsoZN00XQpiCgF8hdwSK5p8JB06DE0SFZ9wVJAybtUsnkOYQNxEtTcuguBQeiwT1XaM=
X-Received: by 2002:a1c:bdc2:: with SMTP id n185mr1480976wmf.128.1614232351825;
 Wed, 24 Feb 2021 21:52:31 -0800 (PST)
MIME-Version: 1.0
References: <CALS+qHMo-XVzXKEfd44E6BG7TPnWKT+r2m7p1wFtFs5XjQApEA@mail.gmail.com>
 <CAJCQCtT38_0Uk7_V-EnfJ-qj4dheJnqVcWEZEKvVRsw6tY5VDg@mail.gmail.com>
In-Reply-To: <CAJCQCtT38_0Uk7_V-EnfJ-qj4dheJnqVcWEZEKvVRsw6tY5VDg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 24 Feb 2021 22:52:15 -0700
Message-ID: <CAJCQCtRkPa7GSjqOBs95ZsJL04o-FBXhgB6xH5KwP+TgupjCnw@mail.gmail.com>
Subject: Re: All files are damaged after btrfs restore
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Sebastian Roller <sebastian.roller@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 24, 2021 at 10:40 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> I think you best chance is to start out trying to restore from a
> recent snapshot. As long as the failed controller wasn't writing
> totally spurious data in random locations, that snapshot should be
> intact.

i.e. the strategy for this is btrfs restore -r option

That only takes subvolid. You can get a subvolid listing with -l
option but this doesn't show the subvolume names yet (patch is
pending)
https://github.com/kdave/btrfs-progs/issues/289

As an alternative to applying that and building yourself, you can
approximate it with:

sudo btrfs insp dump-t -t 1 /dev/sda6 | grep -A 1 ROOT_REF

e.g.
    item 9 key (FS_TREE ROOT_REF 631) itemoff 14799 itemsize 26
        root ref key dirid 256 sequence 54 name varlog34

The subvolume varlog34 is subvolid 631. It's the same for snapshots.
So the restore command will use -r 631 to restore only from that
subvolume.


-- 
Chris Murphy
