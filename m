Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD37A24C23C
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 17:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgHTPbm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 11:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgHTPbl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 11:31:41 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379F8C061385
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:31:41 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id h4so2607881ioe.5
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qTnWkDd7rpr2bZBrVYvU74OAE6XVRYSkURnZHPyG2O4=;
        b=S7N0jiYnYNpb+zQBbrHcmnrf8nbBWZatEugqOqdMDGU0aFDANXb7cjqS6Odx/TCrO7
         Alfn4ZGT3bXuw/pYF4Xy/9gC72m4SxJSZ+bS6oTfdXwjoMSNdqrhfaMJR0AU0eeIeN2A
         ZkmOxWHZfmPvAQT04hkCKo4m9BtvFKcGk0iHkFxd9VGXfnhqkqQiDf2qvteXPhabeuNN
         Ui32xYtHwAqH0MNUKJYNim4ZLkBaaL4LzbqU30o+g0KNtcwB3C6wNcE2N5+XeUVBFWne
         zfPOEej3TXHguXT5FYI1WL+x9Dgomdr9AwBrkcJZjqgq9sC5DH+6P29ReuhB+dQt45e0
         EA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qTnWkDd7rpr2bZBrVYvU74OAE6XVRYSkURnZHPyG2O4=;
        b=bdbIYudSAz2n6RfmDfr0XJbzJbSAx1qIpEycjxHe1rPwYuQq8V4CnzVz/a9yeKeovj
         iVO5BOXIvVSWLxH1MdcvRfmfj/DE/YvT6+pjZ4QNQG59t0lrO47hTsYY4Yy58OHrFUsk
         6vyqYPPtLf9izKfLqNwp/NJK3QywGCltsGRm7Zh6DkSbWL46mMHfp07dv+XbfJ0ipNOc
         ML1aLoZybGLO+G7FCpWSeaYsChtkldRulUe2pKv0ze4+nuill0iLzgdY91uBRYD2rtOA
         yFeN9o+87OW8zzQI3QagCFXmHr1GChYIJHmRCwbTu5wQgQoai6RjMcEOs9QLtQF6+6Nh
         CxsQ==
X-Gm-Message-State: AOAM533M7d9//ncQYRhfC7yVh53Zm1e6ZyHSvNsrByxjRz42sP5Jxi3G
        O5lcOA5hb1olowJW0sYCjuobINdjii6vz7YVnpovo6FegcM=
X-Google-Smtp-Source: ABdhPJy1D7DTe9jBK0ydrL7uMla+Fuoag3lFuONDNG2lU7+Qv/Xu9u+q0alPcE3EOCFTf6HS6rA+7EX2lprm2KDaCyw=
X-Received: by 2002:a05:6602:1495:: with SMTP id a21mr3023429iow.46.1597937498156;
 Thu, 20 Aug 2020 08:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <33c25613-1cd4-ffdb-0b79-5058cf5e2ced@toxicpanda.com>
 <CAEg-Je87or5MNL0Ttea+Hh5Bp=oMFEtt01JVJooyXQycscsMAg@mail.gmail.com> <e457e4d3-1b63-641f-f19d-7d818c46d16e@toxicpanda.com>
In-Reply-To: <e457e4d3-1b63-641f-f19d-7d818c46d16e@toxicpanda.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Thu, 20 Aug 2020 11:31:02 -0400
Message-ID: <CAEg-Je-s+rO1s3yYRH+7Ji5Wrxvf_u1VC=gj+NvZUVrQAYq3Ww@mail.gmail.com>
Subject: Re: [RFC] Tying in github issues into our workflow
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        Pierre-Yves Chibon <pingou@pingoured.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 20, 2020 at 9:27 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 8/19/20 8:42 PM, Neal Gompa wrote:
> > On Wed, Aug 19, 2020 at 4:37 PM Josef Bacik <josef@toxicpanda.com> wrot=
e:
> >>
> >> Hello,
> >>
> >> As we discussed last week, we'd really like to have a way to better tr=
ack the
> >> status of outstanding patches.  One of the suggestions Dave made was t=
o use the
> >> "Projects" feature inside github, because we're not going to be able t=
o get away
> >> from having patches on the mailinglist any time soon.
> >>
> >> I've mocked up a couple of helper scripts and some documentation on ho=
w this
> >> would work.  I've tested the workflow (not with real patches yet becau=
se my
> >> develbox is down for maintenance ATM) and it seems reasonable and pret=
ty
> >> straightforward.  There are two scripts
> >>
> >> https://github.com/josefbacik/debug-scripts/blob/master/btrfs-send-pat=
ches
> >> https://github.com/josefbacik/debug-scripts/blob/master/btrfs-create-i=
ssue
> >>
> >> I'll explain my thought process and such here, but if you don't care a=
nd just
> >> want to look at the workflow then skip to the PREREQUISITES section at=
 the bottom.
> >>
> >> The project exists here
> >>
> >> https://github.com/orgs/btrfs/projects/1
> >>
> >> and has a few columns.  When we submit patches we'll create an issue a=
nd it'll
> >> go into "Needs review".  This is straightforward, we're waiting on rev=
iews for
> >> these patches.  From here it's a little manual unfortunately, but once=
 the
> >> patches are reviewed you can move the issue to "Ready to be merged", a=
nd from
> >> there Dave can decide if he's actually going to merge it.  If he does =
then he
> >> can close the issue and it moves to the "Merged" state.  If he has com=
ments he
> >> can make those and move it to "Needs work".  Likewise if any reviewer =
has
> >> comments then the issue can be moved to "Needs work" by the reviewer.
> >>
> >> To reiterate we're not getting away from mailinglist interactions (yet=
), so we
> >> should keep all patch related discussion on the list for now, we simpl=
y use
> >> these issues so patch series don't get lost.  This will also help revi=
ewers know
> >> what is left to be reviewed.
> >>
> >> Let me know what everybody (preferably just those of us who actually w=
rite
> >> kernel patches) thinks about this.  None of this is set in stone, tryi=
ng to work
> >> out the easiest way to help track patch review status.  Thanks,
> >>
> >> Josef
> >>
> >> PREREQUISITES
> >>
> >> You need to have the github cli tools installed, you can find packages=
 for them here
> >>
> >> https://github.com/cli/cli/releases
> >>
> >> YOU MUST INSTALL THIS ON A BOX THAT CAN OPEN A WEB BROWSER.  This is i=
mportant
> >> because the first time you run the gh command it sets up the 0auth stu=
ff, so it
> >> must be able to open a browser.  The steps are
> >>
> >> 1) Install the gh package
> >> 2) run `gh repo view`.  This will launch the browser to do the 0auth s=
tuff,
> >>      follow the prompts.
> >> 3) [OPTIONAL] If you are like me and submit from a headless machine, y=
ou need to
> >>      copy the ~/.config/gh/hosts.yaml file to the machine you are goin=
g to use,
> >>      and everything will work fine.
> >>
> >> WORKFLOW
> >>
> >> DEVELOPER
> >>
> >> 1) The --thread option with git format-patch is is required for this t=
o work
> >>      with the tools I've written
> >>
> >>      For a patch series: mkdir patches; git format-patch --thread -o p=
atches -#
> >>      For a single patch: git format-patch --thread -1
> >>
> >> 2) ./btrfs-send-patches <patches|0001-<whatever.patch>
> >>
> >>      This does the git-send-email (which will ask you questions) and t=
hen creates
> >>      the issue with the Message-Id that was generated with the appropr=
iate links.
> >>
> >> 3) If you get feedback and your reviewer doesn't move the task to "Nee=
ds work"
> >>      please do that, and then address any feedback.  Once the feedback=
 is
> >>      addressed you can change the issue to "Needs review" and update t=
he
> >>      description with the new Message-id information.
> >>
> >> REVIEWER
> >>
> >> 1) Check the project page
> >>
> >>      https://github.com/orgs/btrfs/projects/1
> >>
> >>      for anything in the "Needs review column".  Review those patches =
on the list.
> >>
> >> 2a) If you are satisfied, change the status of the issue to "Ready to =
be merged"
> >>       by dragging it into that column.  Alternatively, if you are in t=
he issue
> >>       itself, you can click the drop-down menu under the "Projects" se=
ction on the
> >>       right and assign it to "Ready to be merged".
> >>
> >> 2b) If you have feedback, move the issue to the "Needs work" column in=
 the same
> >>       way as described above.
> >>
> >> DAVE/MAINTAINER
> >>
> >> 1) Anything in the "Ready to be merged" is what you care about, do wha=
t you
> >>      want.  If you merge it, close the task and it'll be automatically=
 moved to
> >>      "Merged", otherwise kick it back to whichever stage is appropriat=
e.
> >
> > I know you said that you principally wanted feedback from the btrfs
> > kernel hackers, but from someone who does the oddball thing here and
> > there and is trying to become increasingly active in btrfs upstream, I
> > have some thoughts here.
> >
> > In general, I like the idea of moving to more contemporary workflows
> > for some parts of this stuff. I had actually been contemplating
> > setting up such a thing on pagure.io for tracking my own work on this
> > front (since I generally prefer to use FOSS platforms if I can).
> > Regardless of using GitHub.com or something else, I think it's a good
> > idea to have some generally usable way for tracking development and
> > allowing people to report issues to the project.
> >
> > (It's a shame that kernel.org doesn't have a pagure instance. That
> > could be potentially more usable for a lot more people than the
> > oft-ignored and unloved bugzilla system, projects don't have to enable
> > pull requests with pagure projects, and all project metadata is stored
> > as git repositories, which I think would appeal to a lot of folks
> > here...)
> >
>
> I'm not strongly tied to github here, we just already have something in p=
lace
> for it and are familiar with how it works.  The biggest thing for myself =
(and
> the rest of us I assume) is ease of integration.  I basically only want t=
o use
> the web interface to check status, otherwise I want CLI tools to handle m=
ost of
> the paperwork shuffling.  Does pagure have a CLI for doing this?  I saw s=
ome
> haskell thing that's like 5 years old, but nothing newer.  Even a basic J=
SON
> interface would be ok, I have a curl script that interacts with a JSON th=
ing to
> text my phone for stuff, so I'm not opposed to rigging something like tha=
t up
> for our uses.  If Pagure can do exactly the same thing then I don't see a=
 reason
> not to use that instead.  Thanks,
>

There are a few CLI tools that exist:

pag: https://pagure.io/pag
pag-off: https://pagure.io/pag-off
pagure-cli: https://github.com/juhp/pagure-cli
cranc: https://pagure.io/cranc

There's a basic REST+JSON interface as well, the API documentation is
present on the /api endpoint of any pagure instance, like so:
http://pagure.io/api

I've written crappy curl+jq+shell things for interfacing with pagure
and that works perfectly fine. But there are a few wrapper libraries
if you want to use those:

Python: https://pagure.io/libpagure
Rust: https://pagure.io/ironthree/pagure-rs
Go: https://pagure.io/gopagure





--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
