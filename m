Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D05C24AC5A
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 02:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHTAmp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 20:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgHTAmo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 20:42:44 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654F8C061757
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 17:42:44 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id v2so354343ilq.4
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 17:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vdZkSvcDqdWh9sRyJiNdgesypDlTr6yc2i6LRJwSrp8=;
        b=aoMLNKSG9HFWaQLm/gN89TRTr/ZLGv/1JHQ3HoKGNnXOZWmrZ9+QZWlkisYxBgZpT9
         IOtvYQxdcukA0fFWvoxIjntZ65PLBdeLSP1osUN8u3SQhLCrGgiu6U8ozJCIjImeiT/x
         eFRsFyVVQCEQRW4Bmo/OR3NU25ajQ6KA2dFN01eUkzpbL5qrUsG0G6uUbHV+zZNkm2cY
         A9E+hw2gXeEZZxjRLunZQm9RZh9/HAx6D3AXEfOTzNku9q6T8rvWoBcv4CqtAhtdEBwp
         Fs7vGW6wQlalyZEVBKXIhJdG63MqnH24Z/TXnWerJYWXM+QFpFCf+eZH7QqDGW99pq8J
         aGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vdZkSvcDqdWh9sRyJiNdgesypDlTr6yc2i6LRJwSrp8=;
        b=SkDGnvhobnjtea20GAh1RDx7jTKkjaFhnZ/a7a8kW2T6tV+GpldkoMQ0pMZNFidmW0
         /1K3YOjhjegQZDZWgFogU9E8X2f5SVsFxtRZwueJUoN/d7fEJVftJSQQ/icHjqVK3DfZ
         1O9eOPg2K4SPFYvwVIy/pjZOEA4PFrqxIYvQaTt4l6pqSb7+XjSBO5YmAA0G4hCS9KRl
         D/lI7bYjroNAQViwOMZiilP/Y4u4UT1OF3JUb3h/ZChLK9WDex8AGXa3XcOybxeJghb6
         Tx1Lz+sKNZE2KLHSanu5/Kc59rj6SHajV+uYhdAyF9SC11jg1mlPw62+2ugw9Si4byNe
         I4aw==
X-Gm-Message-State: AOAM533cZ2XGAOBHLijAdXqCU/r+J8Ax+qBN6VHhrryPexK/Dvxr+07Z
        FWVBIGwqDG78hzryO58sGyF1LGqujDaLe9F4EBIybtyKepU=
X-Google-Smtp-Source: ABdhPJyORoIC0oSO2/jQsqivgJ5Q6Mz8PLIUOoHLpaZMneBcxkSfR8RtGvxjop6HdKew1E2azxTIm4HsM+gvYSMOq0Q=
X-Received: by 2002:a92:418b:: with SMTP id o133mr578122ila.10.1597884163247;
 Wed, 19 Aug 2020 17:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <33c25613-1cd4-ffdb-0b79-5058cf5e2ced@toxicpanda.com>
In-Reply-To: <33c25613-1cd4-ffdb-0b79-5058cf5e2ced@toxicpanda.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 19 Aug 2020 20:42:07 -0400
Message-ID: <CAEg-Je87or5MNL0Ttea+Hh5Bp=oMFEtt01JVJooyXQycscsMAg@mail.gmail.com>
Subject: Re: [RFC] Tying in github issues into our workflow
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 19, 2020 at 4:37 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Hello,
>
> As we discussed last week, we'd really like to have a way to better track=
 the
> status of outstanding patches.  One of the suggestions Dave made was to u=
se the
> "Projects" feature inside github, because we're not going to be able to g=
et away
> from having patches on the mailinglist any time soon.
>
> I've mocked up a couple of helper scripts and some documentation on how t=
his
> would work.  I've tested the workflow (not with real patches yet because =
my
> develbox is down for maintenance ATM) and it seems reasonable and pretty
> straightforward.  There are two scripts
>
> https://github.com/josefbacik/debug-scripts/blob/master/btrfs-send-patche=
s
> https://github.com/josefbacik/debug-scripts/blob/master/btrfs-create-issu=
e
>
> I'll explain my thought process and such here, but if you don't care and =
just
> want to look at the workflow then skip to the PREREQUISITES section at th=
e bottom.
>
> The project exists here
>
> https://github.com/orgs/btrfs/projects/1
>
> and has a few columns.  When we submit patches we'll create an issue and =
it'll
> go into "Needs review".  This is straightforward, we're waiting on review=
s for
> these patches.  From here it's a little manual unfortunately, but once th=
e
> patches are reviewed you can move the issue to "Ready to be merged", and =
from
> there Dave can decide if he's actually going to merge it.  If he does the=
n he
> can close the issue and it moves to the "Merged" state.  If he has commen=
ts he
> can make those and move it to "Needs work".  Likewise if any reviewer has
> comments then the issue can be moved to "Needs work" by the reviewer.
>
> To reiterate we're not getting away from mailinglist interactions (yet), =
so we
> should keep all patch related discussion on the list for now, we simply u=
se
> these issues so patch series don't get lost.  This will also help reviewe=
rs know
> what is left to be reviewed.
>
> Let me know what everybody (preferably just those of us who actually writ=
e
> kernel patches) thinks about this.  None of this is set in stone, trying =
to work
> out the easiest way to help track patch review status.  Thanks,
>
> Josef
>
> PREREQUISITES
>
> You need to have the github cli tools installed, you can find packages fo=
r them here
>
> https://github.com/cli/cli/releases
>
> YOU MUST INSTALL THIS ON A BOX THAT CAN OPEN A WEB BROWSER.  This is impo=
rtant
> because the first time you run the gh command it sets up the 0auth stuff,=
 so it
> must be able to open a browser.  The steps are
>
> 1) Install the gh package
> 2) run `gh repo view`.  This will launch the browser to do the 0auth stuf=
f,
>     follow the prompts.
> 3) [OPTIONAL] If you are like me and submit from a headless machine, you =
need to
>     copy the ~/.config/gh/hosts.yaml file to the machine you are going to=
 use,
>     and everything will work fine.
>
> WORKFLOW
>
> DEVELOPER
>
> 1) The --thread option with git format-patch is is required for this to w=
ork
>     with the tools I've written
>
>     For a patch series: mkdir patches; git format-patch --thread -o patch=
es -#
>     For a single patch: git format-patch --thread -1
>
> 2) ./btrfs-send-patches <patches|0001-<whatever.patch>
>
>     This does the git-send-email (which will ask you questions) and then =
creates
>     the issue with the Message-Id that was generated with the appropriate=
 links.
>
> 3) If you get feedback and your reviewer doesn't move the task to "Needs =
work"
>     please do that, and then address any feedback.  Once the feedback is
>     addressed you can change the issue to "Needs review" and update the
>     description with the new Message-id information.
>
> REVIEWER
>
> 1) Check the project page
>
>     https://github.com/orgs/btrfs/projects/1
>
>     for anything in the "Needs review column".  Review those patches on t=
he list.
>
> 2a) If you are satisfied, change the status of the issue to "Ready to be =
merged"
>      by dragging it into that column.  Alternatively, if you are in the i=
ssue
>      itself, you can click the drop-down menu under the "Projects" sectio=
n on the
>      right and assign it to "Ready to be merged".
>
> 2b) If you have feedback, move the issue to the "Needs work" column in th=
e same
>      way as described above.
>
> DAVE/MAINTAINER
>
> 1) Anything in the "Ready to be merged" is what you care about, do what y=
ou
>     want.  If you merge it, close the task and it'll be automatically mov=
ed to
>     "Merged", otherwise kick it back to whichever stage is appropriate.

I know you said that you principally wanted feedback from the btrfs
kernel hackers, but from someone who does the oddball thing here and
there and is trying to become increasingly active in btrfs upstream, I
have some thoughts here.

In general, I like the idea of moving to more contemporary workflows
for some parts of this stuff. I had actually been contemplating
setting up such a thing on pagure.io for tracking my own work on this
front (since I generally prefer to use FOSS platforms if I can).
Regardless of using GitHub.com or something else, I think it's a good
idea to have some generally usable way for tracking development and
allowing people to report issues to the project.

(It's a shame that kernel.org doesn't have a pagure instance. That
could be potentially more usable for a lot more people than the
oft-ignored and unloved bugzilla system, projects don't have to enable
pull requests with pagure projects, and all project metadata is stored
as git repositories, which I think would appeal to a lot of folks
here...)



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
