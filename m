Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECF52A109C
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 22:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgJ3V4f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Oct 2020 17:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgJ3V4f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Oct 2020 17:56:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7BCC0613CF
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:56:35 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n18so7990565wrs.5
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ky23cij2GygMlzGAi6jP0iNrIOsGP4dXOu0Mo6CyBAU=;
        b=Dj3G/Fi9O6JlzFhLZl6s6oKjXGI9joaUCOrHyXWF3RxR6IHclUzEW7lP+1WQpvdNwL
         kFSgbGp9xtvnQKoPLz7hHdkD8PH6fo178yNv6uJ4mGX6/lpNeCcPojG/Mfj48vh6q/2y
         gv0yFmN+tj5MpRSSG60f3DXYMRsZP6g+eSqBZ+Nqui6V0rwr3C87WT5E6eQWWcJbtoPG
         QI6Lec4hn0Mn5+SdhpGtrS0npoSU2b/xjFtyw/igHfCtSAjpNLT9sudvun73OKFgpAep
         XFnKSdPg9O6AG045ElW109Bq7jZjBeSed8yOfuhoQchZqe4kOcJnbxUd99h6UiC/kgEW
         DIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ky23cij2GygMlzGAi6jP0iNrIOsGP4dXOu0Mo6CyBAU=;
        b=Y9g0HfUHVPAgRRHXrF9g4mg8cKgP6x6jko8lp+rphbq6pRJMXd2B8ZY7JlQrfhCfnv
         +V1vaoQhX+uVmchDgkVRxqdbZCQWgZgVxImFAQpD9oc37dPmJ7v3N9gEeW82YZ3OWkf1
         HyUvSSuB11c17FG03rr6YRLMRc5KDxJyudiDgLRbEJQOLkTfWNgePURxXdnLwyhAAAaG
         7EiAGmga07+P2iDzwRM5v32c1HUgeehkB2GGfmzgPOPNjNRQFytrmMs3yyAK+u9mYIgV
         KFPZmjkafNRXKDIaAk5JjJQt84OdyrLV25Ff0wZTpyN/14RFGnHEkALJ+dRXpJocDFt5
         p9Aw==
X-Gm-Message-State: AOAM531fSqkuHXYR0EogTwlx8AVQGIOWJoKsin5VGwG3r+feTrK1K8/R
        NuJBJTuEThCV81X2vgCGguRJ7o+L6dMtaDAJBb2w9omG0NUQWYufydo=
X-Google-Smtp-Source: ABdhPJzu0GOpJSH3FA2vc9c131bTJpiv2PBb8XEGPxjN3hELnRaUChcyFHVq7ECFrBGZK4HlOtyjfOu6SmJcFe4E9g8=
X-Received: by 2002:a05:6000:1185:: with SMTP id g5mr5715784wrx.42.1604094993851;
 Fri, 30 Oct 2020 14:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQqJY7vSVsQeRP82K1x9VtSYUHK1zmnpfXrtJKFbcYxJQ@mail.gmail.com>
In-Reply-To: <CAJCQCtQqJY7vSVsQeRP82K1x9VtSYUHK1zmnpfXrtJKFbcYxJQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 30 Oct 2020 15:56:17 -0600
Message-ID: <CAJCQCtSAGsL4paX8Aw1QTxEFGKXQW=6i=V4VbB9zd+4RVvLKGg@mail.gmail.com>
Subject: Re: btrfsck segfaults on root 5 missing its root dir, recreating
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Using

mount -o ro,usebackuproot,degraded /dev/

[69325.132326] BTRFS warning (device sdd4): suspicious: generation <
chunk_root_generation: 102169 < 102174
[69325.142106] BTRFS info (device sdd4): trying to use backup root at mount time
[69325.149454] BTRFS info (device sdd4): allowing degraded mounts
[69325.155451] BTRFS info (device sdd4): disk space caching is enabled
[69325.161895] BTRFS info (device sdd4): has skinny extents
[69325.169446] BTRFS warning (device sdd4): devid 6 uuid
6e6ea106-a6d9-4d66-a102-735495af9b2a is missing
[69325.191243] BTRFS warning (device sdd4): devid 6 uuid
6e6ea106-a6d9-4d66-a102-735495af9b2a is missing
[69325.537853] BTRFS error (device sdd4): chunk 7716140482560 has
missing dev extent, have 0 expect 2
[69325.547094] BTRFS error (device sdd4): failed to verify dev extents
against chunks: -117
[69325.571249] BTRFS error (device sdd4): open_ctree failed
[69344.514645] BTRFS warning (device sdd4): suspicious: generation <
chunk_root_generation: 102169 < 102174
[69344.524420] BTRFS info (device sdd4): trying to use backup root at mount time
[69344.531772] BTRFS info (device sdd4): allowing degraded mounts
[69344.537780] BTRFS info (device sdd4): disk space caching is enabled
[69344.544235] BTRFS info (device sdd4): has skinny extents
[69344.552502] BTRFS warning (device sdd4): devid 6 uuid
6e6ea106-a6d9-4d66-a102-735495af9b2a is missing
[69344.617427] BTRFS error (device sdd4): chunk 7716140482560 has
missing dev extent, have 0 expect 2
[69344.626651] BTRFS error (device sdd4): failed to verify dev extents
against chunks: -117
[69344.648565] BTRFS error (device sdd4): open_ctree failed


I'm not seeing anything in the list archives about "chunk has missing
dev extent, have 0 expect 2" that seems bad. There is one device
missing, but it's curious how both copies would come to be missing.

Anyway I'm having the user attach full versions of these outputs to
the downstream bug report. Maybe it's possible to ddrescue clone the
bad drive still, and if it has this missing dev extent, possible to
mount again, at least ro.


---
Chris Murphy
