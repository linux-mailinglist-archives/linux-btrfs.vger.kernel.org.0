Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6EA912CB5A
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 00:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfL2X1H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Dec 2019 18:27:07 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40063 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfL2X1H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Dec 2019 18:27:07 -0500
Received: by mail-ot1-f68.google.com with SMTP id w21so36328902otj.7
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Dec 2019 15:27:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mIYTU0w9aFoNQaoMrAZZRo4OmmZuimETPWkHR/VrmFs=;
        b=PtM5m6q7qGJzk6gqKjAsZ39t5Ac6z1ZopZf/d9G9YZMggWy/wT1HSsicau2HPGq7qr
         q2M46Ua9mJyRtt2CGN8zTwipiKKgmhY/EmZG+yUMlYOCmTI0PEDUA/vks3rCr+Zma5ga
         S0f7RFrzQNJfmj1dRTStGoC1O3pJMhbZWPze60/BiqwiX5vtjcOeLTKUeGTyMNtYJZvK
         kV6iqB5uwACxYkTBxVqoAc3xCceofNuDojF2DxcavW+LQBbuG1b7ZMwHQb3ItflmwqcE
         ubtiG4CFmXz21+Y8OPumuBIMnnSLyp7C3eU5+CrlklfzwKq0ANxvtPIkstVnXGdJ0tZr
         J/Tw==
X-Gm-Message-State: APjAAAV4QaY10GHaQQm2SPY5R8SzxxQFbbxI+2XWfArai10sNtzOlgei
        1qvsjFdTyFG3orw0gMhg0te2t/dNgBqY+Ua9BCkDDlfk+IE=
X-Google-Smtp-Source: APXvYqxwrmeKSOntd4MVU4N4G4SAUs+b6yMkHN8fUJe0uzgIywWYbu0HcD/wePr5IFJ7itsaGzmRPasT+6hymXipVvQ=
X-Received: by 2002:a05:6830:1cd3:: with SMTP id p19mr67111494otg.118.1577662026955;
 Sun, 29 Dec 2019 15:27:06 -0800 (PST)
MIME-Version: 1.0
References: <CAOB=O_jxu5JOe=JiYVW_VZ1rgs9+mdHpAHkscXkc4MVRLrBKDw@mail.gmail.com>
 <CAJCQCtQwLrZxfc7xb8FpVcV9r9rpEpD0SRPebRtRpS5SPYM_3A@mail.gmail.com>
 <CAOB=O_hLvVaSdnvXwFeC5h6=AySnb4Fh9Fzx-zjFmw92odSLzQ@mail.gmail.com>
 <CAJCQCtQogopy56foRdqb6+3ejYL=gofVyYKwoAWFjYRgyaVZew@mail.gmail.com>
 <CAOB=O_jmoMJ=Tt7wRqv6btofDQCxefYC7LaNKye7MOiQ98Djbw@mail.gmail.com>
 <CAJCQCtTBFeBLA3DhwyHqXmkQ6KCSkZaj7e8KGY8q5TU7Fi1PAA@mail.gmail.com>
 <CAOB=O_j4e1RteXwDuKw_AAEdnW9cAxFg4HHb6L5oRr+B-FmThg@mail.gmail.com> <CAJCQCtTRsSHuR_mZc7L6wRh9nwGyP5q1aOO+KNXw=cGkCsfj7Q@mail.gmail.com>
In-Reply-To: <CAJCQCtTRsSHuR_mZc7L6wRh9nwGyP5q1aOO+KNXw=cGkCsfj7Q@mail.gmail.com>
From:   Patrick Erley <pat-lkml@erley.org>
Date:   Sun, 29 Dec 2019 15:26:54 -0800
Message-ID: <CAOB=O_hNOqEZSGd8oV0suo5aV658BntzSPma06R-kXqHbK2sPg@mail.gmail.com>
Subject: Re: read time tree block corruption detected
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

No, I mean, I'm going to reboot single user RO, run the btrfs checks,
catch the logs, and dump a copy of the partition, so follow ups don't
require RO reboots.

On Sun, Dec 29, 2019 at 3:25 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Sun, Dec 29, 2019 at 4:19 PM Patrick Erley <pat-lkml@erley.org> wrote:
> >
> > Nah, this 'corruption' hasn't affected anything other than not being
> > able to go to a newer kernel.  The system doesn't do anything
> > important.  I'll grab the logs, and clone an image of the drive so I
> > don't need to go single user RO mode to get dumps for devs when follow
> > up requests come in.
>
> A clone of any rw file system is likewise unreliable, for the same
> reasons that a forced btrfs check on a rw file system is unreliable.
> So unreliable it's a waste of time for you and the developer, so I
> wouldn't even bother with it.
>
>
> --
> Chris Murphy
