Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4867F12CB59
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 00:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfL2XZO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Dec 2019 18:25:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36852 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfL2XZO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Dec 2019 18:25:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so12968397wma.1
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Dec 2019 15:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=48Ce3LMQ/gjXjTsfUldapZuB5zEWEFK1qXmXosy0miU=;
        b=XMbzbqxp59B9EBEv3AyvuguddMzwXaP5/LE26Yads6Qd+5z9RUHV2bDGC18aH1Yd76
         u1UGTalD8JCcrJP3GhgIeZ0Ou7kqgh41MHa9Jg8qCyAJQByKT5t2D1DfYxnDSjl5Ug0Y
         yNlHA0l0Xs+MZGKkQdb4H2ie96Qq7m+g1WLgk2PzhOj4JhzXZmhQ4pqBXD0JIMePXBal
         xe9Ojlu9niATOjAiTyFr1m3zQy9tIe4CCwIRVYsNCF3lX7HhBTJ3J+UgJ5BZAaPuV7wG
         MmOrqejvQ6sVKsOT8E4NpMzZy8yHh95j7T0KZ+N3i9QaWEOsORa7iuid5so42y0Ksvqa
         vHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=48Ce3LMQ/gjXjTsfUldapZuB5zEWEFK1qXmXosy0miU=;
        b=dsvTebNO30pX75Nvkdziqk9liXMrl6KhLO6AWOoRhBRE4hCqfD4BzTLzB/QkpkUCE3
         KGMkUxwaf5ysE8p5AnyR9WX+vnkc0sXxRClBmKkjU7kM7FvVq3Xd4d6gzdTbAcdrjJzU
         tPou8D9tdyb01Aw4C8enrb+Ul4wVa5HJsZAgH3P2bSVS/uhHzVOQjncxLAn4iHbkEydt
         bnnquhzHpuNogoUOy0eZ/LP8Y46ptvhnknPK+pxiD7jbnw4sIFGZoDyRwp7HGCsHrMKJ
         UM1siiq9vKG2oECprdPgHnp0S6/gUQweOkTgsPAUd/7d+kmrrhpTvMx78I3y79SJHwqY
         gdQA==
X-Gm-Message-State: APjAAAXBlVlPneTD5JytATrQ/M4QHeEAA4gwCFz+vzxTfLijijwO/AyG
        R9v+lbfFDVrZeVjpd9iqdNLswNwZdeCIw6+0Ctk4rw==
X-Google-Smtp-Source: APXvYqy+RRmuJ7QMnScxKRbtEDw2vibCT34Z0B3Yxbjy8RluZ18IY879aeWsgEuxQuiGK0zMb63tMAP0eq7SlA/BEVA=
X-Received: by 2002:a1c:770e:: with SMTP id t14mr33350318wmi.101.1577661911961;
 Sun, 29 Dec 2019 15:25:11 -0800 (PST)
MIME-Version: 1.0
References: <CAOB=O_jxu5JOe=JiYVW_VZ1rgs9+mdHpAHkscXkc4MVRLrBKDw@mail.gmail.com>
 <CAJCQCtQwLrZxfc7xb8FpVcV9r9rpEpD0SRPebRtRpS5SPYM_3A@mail.gmail.com>
 <CAOB=O_hLvVaSdnvXwFeC5h6=AySnb4Fh9Fzx-zjFmw92odSLzQ@mail.gmail.com>
 <CAJCQCtQogopy56foRdqb6+3ejYL=gofVyYKwoAWFjYRgyaVZew@mail.gmail.com>
 <CAOB=O_jmoMJ=Tt7wRqv6btofDQCxefYC7LaNKye7MOiQ98Djbw@mail.gmail.com>
 <CAJCQCtTBFeBLA3DhwyHqXmkQ6KCSkZaj7e8KGY8q5TU7Fi1PAA@mail.gmail.com> <CAOB=O_j4e1RteXwDuKw_AAEdnW9cAxFg4HHb6L5oRr+B-FmThg@mail.gmail.com>
In-Reply-To: <CAOB=O_j4e1RteXwDuKw_AAEdnW9cAxFg4HHb6L5oRr+B-FmThg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 29 Dec 2019 16:24:56 -0700
Message-ID: <CAJCQCtTRsSHuR_mZc7L6wRh9nwGyP5q1aOO+KNXw=cGkCsfj7Q@mail.gmail.com>
Subject: Re: read time tree block corruption detected
To:     Patrick Erley <pat-lkml@erley.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 29, 2019 at 4:19 PM Patrick Erley <pat-lkml@erley.org> wrote:
>
> Nah, this 'corruption' hasn't affected anything other than not being
> able to go to a newer kernel.  The system doesn't do anything
> important.  I'll grab the logs, and clone an image of the drive so I
> don't need to go single user RO mode to get dumps for devs when follow
> up requests come in.

A clone of any rw file system is likewise unreliable, for the same
reasons that a forced btrfs check on a rw file system is unreliable.
So unreliable it's a waste of time for you and the developer, so I
wouldn't even bother with it.


-- 
Chris Murphy
