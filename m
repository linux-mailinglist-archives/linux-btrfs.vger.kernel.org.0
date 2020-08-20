Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580FA24AD0B
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 04:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHTChB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 22:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgHTCg7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 22:36:59 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987ABC061757
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 19:36:59 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id g13so815084ioo.9
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 19:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VWqPYNZgUbKv+janP5IdejbCBgWhXY6EAGyX2Oje8J0=;
        b=jfkF+jRDojNsuhEg5T0oklp1sy9Xm6PiPrU/6HSOMUdai167RJREn0wvXGmTzRJ5Ol
         ERwMvzAx9Y7Wou/A95dBAPTwzlmdq6JdLFhHXvL75tlWg/R8cTtS4ixAgjCj8DdNHrYq
         So2U4SyVKscxCUTRe59rrft/VKbP02sX2UWB7bu0TveVTwLC81BpJ2RGvxbf1lLWsJLV
         CwDIGvy0bpSIh4fQRjcyHu88G7UR74W1Kb0e3pihYItjvMnFt3F9jltltIw94XeSyX28
         Y884RpYWqb0LEHzVwCb3NmVClgYWekwKn/q9wGAcQhxIurSBD8OvR1z3KS8pWjhhphvO
         NY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VWqPYNZgUbKv+janP5IdejbCBgWhXY6EAGyX2Oje8J0=;
        b=hjXxqIS0n/9BdbyftLTU3KH95mxX4ZFmAbPjIOPSnQcR15ISObgSG2JFdsqGT8BEs7
         E/bFLA3e7AudB9fq2MLB6ZESb6ZrtcxWBUIon2zRfgJDigRP6plE8tiOd+Aly02uFGeC
         cMdMEE3kxL3hfrWMNCFpHQd54xHgJ7QSWltSHeE0i3UvXXoDFkvOgFOBq8KPmayWlI/A
         6HvIsalQkbsTbGhth2PMxaKc5sSfwXNvz4K4e58CcxefkTnwUivqgit09hGibqpTPCLu
         cothVeo/feePnFWXy5IL/1a6I+QUdwCDwN37DxkQREN2pXdVcc74POCBlMxs688DbxKc
         YWjQ==
X-Gm-Message-State: AOAM53189cHuCDw7b2/xxsycYBndkhM45dWKmivVaTEgTaw1cXzPYPNP
        gwM3uPzxseoI0RvCsNjjMGtgXvVbSebqSzNDAlEWaV/qwNZlgg==
X-Google-Smtp-Source: ABdhPJxNG3XylkYzf8PiQ9vGfSbjfNE1/w5mITxxwujkXqhacUOb89wv2xT3dO+GLBF576A9E8J4vhWeX/G9UFczGyk=
X-Received: by 2002:a05:6638:2692:: with SMTP id o18mr1272994jat.2.1597891018395;
 Wed, 19 Aug 2020 19:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <33c25613-1cd4-ffdb-0b79-5058cf5e2ced@toxicpanda.com> <CAEg-Je87or5MNL0Ttea+Hh5Bp=oMFEtt01JVJooyXQycscsMAg@mail.gmail.com>
In-Reply-To: <CAEg-Je87or5MNL0Ttea+Hh5Bp=oMFEtt01JVJooyXQycscsMAg@mail.gmail.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 19 Aug 2020 22:36:22 -0400
Message-ID: <CAEg-Je9g3FUzjUYvonDmEhOCaY3tVOgTTRLXGb58uYtjdrdj+A@mail.gmail.com>
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

On Wed, Aug 19, 2020 at 8:42 PM Neal Gompa <ngompa13@gmail.com> wrote:
>
> On Wed, Aug 19, 2020 at 4:37 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > Hello,
> >
> > As we discussed last week, we'd really like to have a way to better tra=
ck the
> > status of outstanding patches.  One of the suggestions Dave made was to=
 use the
> > "Projects" feature inside github, because we're not going to be able to=
 get away
> > from having patches on the mailinglist any time soon.
> >
> > I've mocked up a couple of helper scripts and some documentation on how=
 this
> > would work.  I've tested the workflow (not with real patches yet becaus=
e my
> > develbox is down for maintenance ATM) and it seems reasonable and prett=
y
> > straightforward.  There are two scripts
> >
> > https://github.com/josefbacik/debug-scripts/blob/master/btrfs-send-patc=
hes
> > https://github.com/josefbacik/debug-scripts/blob/master/btrfs-create-is=
sue
> >
> > I'll explain my thought process and such here, but if you don't care an=
d just
> > want to look at the workflow then skip to the PREREQUISITES section at =
the bottom.
> >
> > The project exists here
> >
> > https://github.com/orgs/btrfs/projects/1
> >
> > and has a few columns.  When we submit patches we'll create an issue an=
d it'll
> > go into "Needs review".  This is straightforward, we're waiting on revi=
ews for
> > these patches.  From here it's a little manual unfortunately, but once =
the
> > patches are reviewed you can move the issue to "Ready to be merged", an=
d from
> > there Dave can decide if he's actually going to merge it.  If he does t=
hen he
> > can close the issue and it moves to the "Merged" state.  If he has comm=
ents he
> > can make those and move it to "Needs work".  Likewise if any reviewer h=
as
> > comments then the issue can be moved to "Needs work" by the reviewer.
> >
> > To reiterate we're not getting away from mailinglist interactions (yet)=
, so we
> > should keep all patch related discussion on the list for now, we simply=
 use
> > these issues so patch series don't get lost.  This will also help revie=
wers know
> > what is left to be reviewed.
> >
> > Let me know what everybody (preferably just those of us who actually wr=
ite
> > kernel patches) thinks about this.  None of this is set in stone, tryin=
g to work
> > out the easiest way to help track patch review status.  Thanks,
> >
> > Josef
> >
> > PREREQUISITES
> >
> > You need to have the github cli tools installed, you can find packages =
for them here
> >
> > https://github.com/cli/cli/releases
> >
> > YOU MUST INSTALL THIS ON A BOX THAT CAN OPEN A WEB BROWSER.  This is im=
portant
> > because the first time you run the gh command it sets up the 0auth stuf=
f, so it
> > must be able to open a browser.  The steps are
> >
> > 1) Install the gh package
> > 2) run `gh repo view`.  This will launch the browser to do the 0auth st=
uff,
> >     follow the prompts.
> > 3) [OPTIONAL] If you are like me and submit from a headless machine, yo=
u need to
> >     copy the ~/.config/gh/hosts.yaml file to the machine you are going =
to use,
> >     and everything will work fine.
> >
> > WORKFLOW
> >
> > DEVELOPER
> >
> > 1) The --thread option with git format-patch is is required for this to=
 work
> >     with the tools I've written
> >
> >     For a patch series: mkdir patches; git format-patch --thread -o pat=
ches -#
> >     For a single patch: git format-patch --thread -1
> >
> > 2) ./btrfs-send-patches <patches|0001-<whatever.patch>
> >
> >     This does the git-send-email (which will ask you questions) and the=
n creates
> >     the issue with the Message-Id that was generated with the appropria=
te links.
> >
> > 3) If you get feedback and your reviewer doesn't move the task to "Need=
s work"
> >     please do that, and then address any feedback.  Once the feedback i=
s
> >     addressed you can change the issue to "Needs review" and update the
> >     description with the new Message-id information.
> >
> > REVIEWER
> >
> > 1) Check the project page
> >
> >     https://github.com/orgs/btrfs/projects/1
> >
> >     for anything in the "Needs review column".  Review those patches on=
 the list.
> >
> > 2a) If you are satisfied, change the status of the issue to "Ready to b=
e merged"
> >      by dragging it into that column.  Alternatively, if you are in the=
 issue
> >      itself, you can click the drop-down menu under the "Projects" sect=
ion on the
> >      right and assign it to "Ready to be merged".
> >
> > 2b) If you have feedback, move the issue to the "Needs work" column in =
the same
> >      way as described above.
> >
> > DAVE/MAINTAINER
> >
> > 1) Anything in the "Ready to be merged" is what you care about, do what=
 you
> >     want.  If you merge it, close the task and it'll be automatically m=
oved to
> >     "Merged", otherwise kick it back to whichever stage is appropriate.
>
> I know you said that you principally wanted feedback from the btrfs
> kernel hackers, but from someone who does the oddball thing here and
> there and is trying to become increasingly active in btrfs upstream, I
> have some thoughts here.
>
> In general, I like the idea of moving to more contemporary workflows
> for some parts of this stuff. I had actually been contemplating
> setting up such a thing on pagure.io for tracking my own work on this
> front (since I generally prefer to use FOSS platforms if I can).
> Regardless of using GitHub.com or something else, I think it's a good
> idea to have some generally usable way for tracking development and
> allowing people to report issues to the project.
>
> (It's a shame that kernel.org doesn't have a pagure instance. That
> could be potentially more usable for a lot more people than the
> oft-ignored and unloved bugzilla system, projects don't have to enable
> pull requests with pagure projects, and all project metadata is stored
> as git repositories, which I think would appeal to a lot of folks
> here...)
>

By the way, in case anyone is interested in seeing my setup as I
populate it, here it is: https://pagure.io/fedora-btrfs/project

The project board is here:
https://pagure.io/fedora-btrfs/project/boards/Development

It maps to issues tagged with "Dev":
https://pagure.io/fedora-btrfs/project/issues?tags=3DDev



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
