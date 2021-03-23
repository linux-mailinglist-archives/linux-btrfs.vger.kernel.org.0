Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EE4345802
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Mar 2021 07:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhCWGvH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Mar 2021 02:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhCWGuk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Mar 2021 02:50:40 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54CEC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Mar 2021 23:50:37 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id s11-20020a056830124bb029021bb3524ebeso1741232otp.0
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Mar 2021 23:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GHDp3C6n5j6KG7ySW+9gHJdCYJbK58TXVoubnd9SXFw=;
        b=M9Zot30ArKm07pt8A25NdKiJM1jx5iYUs7rnbXwbz79aV3eJNiEJCOCoXGnIvsfuHL
         1izYFeeJ6EkUuGAO7V6qxuL1wjXML5zbOa/v7w1mXr+jA96waKpJYGd3RNuXBP5+uFmQ
         3phnTuD6hoJ513+R3OafuqLudiRPzEUGPqAWztUXh/GR6y7/aOobacw/KZ+nGK5JfwNh
         tuy5v+QcKqGIBhprHexxUegKaPG1yex8FvhaRiOWhAn+SPaBupR4zmC3baIbLADgW02J
         Ndhaa/srOJzobcdUxDlu54vqgnwvlZ2zohGWu/rWwVo0OdL57518FGi8K7DFYh+4PP7O
         S77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GHDp3C6n5j6KG7ySW+9gHJdCYJbK58TXVoubnd9SXFw=;
        b=hjhFci+0jGB9mdjnJi6bWuuy2NKK47qqCI/mbBFMIXe/khLnwKavccJRatrSvecQ5Q
         lLwLo3OOF1iNrPiqYdSWfpb4FvLQZQ2dS3R0sb/dQ973pMbMMnBNwCFWAo66gaRYGbMG
         yqWBz8hqZk7bOWSKcAV4utE9XxKY/O8/jJqAiZXEIbYFWd2jkGRNER0v4+Y5hW0iFww8
         /y773gNwHO6dX6zeG3WJwaBmBMt6mLR//us1U872kuk1s8U/S2TOvnC+mAa+4Fr95GqI
         kFVgoHRJb7zTKj9PUj7Ej3dlzUuE9wmPb0Voe7yokL4LkJlaRKmKw+QsOiauahEESRID
         vDCQ==
X-Gm-Message-State: AOAM532WUO02glEhEZ0WXDUKZYRNNC2sOHfrHcTbS+wdBactGYHBSZTB
        aaokxsMKGLhivDJ4FQv4kwowGsKXhYeZr+LQHi0=
X-Google-Smtp-Source: ABdhPJwkofaHS4ojjYpoN+jdFw0Mq51HogN0HYZfBYTyzbfXjrD1Cm3ajaszYfMehkW0x35t4FQv3McZ4e5JCgvkA4Q=
X-Received: by 2002:a05:6830:15c5:: with SMTP id j5mr3160527otr.274.1616482237161;
 Mon, 22 Mar 2021 23:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB6JtU54uEOotj=H-DG_7oeUT5KZQG5uM-ibiC2YDbV5Nw@mail.gmail.com>
 <CAJCQCtSBc-Dmks2jdgr-Bcpdh_iLvVevtGOa4LdYgHc2eZE6Hg@mail.gmail.com>
 <CAGdWbB4dN45=4T_WbF7tXmm2UsmF0bh=Lb_z-H=QVQWaW=C=Bw@mail.gmail.com>
 <CAGdWbB61y3CXTbSxe9Rc7ijs9vsLg7qcX4JZ_WpW-73m_1-6_g@mail.gmail.com>
 <CAJCQCtRyhh6AY25+RwikJKk_HUW1xveVxYzGvPpFDdWq618KUg@mail.gmail.com>
 <CAGdWbB7kCM8DzbS5TzZg=DhsdjTE5nij1SuEnibi3B=OqPBRow@mail.gmail.com> <CAJCQCtSNsVkTaZb4Zbz7AeTVUNgxca5hOfaQGHQTUf8DsY-Nrg@mail.gmail.com>
In-Reply-To: <CAJCQCtSNsVkTaZb4Zbz7AeTVUNgxca5hOfaQGHQTUf8DsY-Nrg@mail.gmail.com>
From:   Dave T <davestechshop@gmail.com>
Date:   Tue, 23 Mar 2021 02:50:26 -0400
Message-ID: <CAGdWbB7K4d0xhKGTLni_stKStG-gTarWd08BUN9Mt-rpQktp8g@mail.gmail.com>
Subject: Re: parent transid verify failed / ERROR: could not setup extent tree
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 22, 2021 at 3:49 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Mon, Mar 22, 2021 at 12:32 AM Dave T <davestechshop@gmail.com> wrote:
> >
> > On Sun, Mar 21, 2021 at 2:03 PM Chris Murphy <lists@colorremedies.com> wrote:
> > >
> > > On Sat, Mar 20, 2021 at 11:54 PM Dave T <davestechshop@gmail.com> wrote:
> > > >
> > > > # btrfs check -r 2853787942912 /dev/mapper/xyz
> > > > Opening filesystem to check...
> > > > parent transid verify failed on 2853787942912 wanted 29436 found 29433
> > > > parent transid verify failed on 2853787942912 wanted 29436 found 29433
> > > > parent transid verify failed on 2853787942912 wanted 29436 found 29433
> > > > Ignoring transid failure
> > > > parent transid verify failed on 2853827723264 wanted 29433 found 29435
> > > > parent transid verify failed on 2853827723264 wanted 29433 found 29435
> > > > parent transid verify failed on 2853827723264 wanted 29433 found 29435
> > > > Ignoring transid failure
> > > > leaf parent key incorrect 2853827723264
> > > > ERROR: could not setup extent tree
> > > > ERROR: cannot open file system
> > >
> > > btrfs insp dump-t -t 2853827723264 /dev/
> >
> > # btrfs insp dump-t -t 2853827723264 /dev/mapper/xzy
> > btrfs-progs v5.11
> > parent transid verify failed on 2853827608576 wanted 29436 found 29433
> > parent transid verify failed on 2853827608576 wanted 29436 found 29433
> > parent transid verify failed on 2853827608576 wanted 29436 found 29433
> > Ignoring transid failure
> > leaf parent key incorrect 2853827608576
> > WARNING: could not setup extent tree, skipping it
> > parent transid verify failed on 2853827608576 wanted 29436 found 29433
> > Ignoring transid failure
> > leaf parent key incorrect 2853827608576
> > Couldn't setup device tree
> > ERROR: unable to open /dev/mapper/xzy
> >
> > # btrfs insp dump-t -t 2853787942912 /dev/mapper/xzy
> > btrfs-progs v5.11
> > parent transid verify failed on 2853827608576 wanted 29436 found 29433
> > parent transid verify failed on 2853827608576 wanted 29436 found 29433
> > parent transid verify failed on 2853827608576 wanted 29436 found 29433
> > Ignoring transid failure
> > leaf parent key incorrect 2853827608576
> > WARNING: could not setup extent tree, skipping it
> > parent transid verify failed on 2853827608576 wanted 29436 found 29433
> > Ignoring transid failure
> > leaf parent key incorrect 2853827608576
> > Couldn't setup device tree
> > ERROR: unable to open /dev/mapper/xzy
> >
> > # btrfs insp dump-t -t 2853827608576 /dev/mapper/xzy
> > btrfs-progs v5.11
> > parent transid verify failed on 2853827608576 wanted 29436 found 29433
> > parent transid verify failed on 2853827608576 wanted 29436 found 29433
> > parent transid verify failed on 2853827608576 wanted 29436 found 29433
> > Ignoring transid failure
> > leaf parent key incorrect 2853827608576
> > WARNING: could not setup extent tree, skipping it
> > parent transid verify failed on 2853827608576 wanted 29436 found 29433
> > Ignoring transid failure
> > leaf parent key incorrect 2853827608576
> > Couldn't setup device tree
> > ERROR: unable to open /dev/mapper/xzy
>
> That does not look promising. I don't know whether a read-write mount
> with usebackuproot will recover, or end up with problems.
>
> Options:
>
> a. btrfs check --repair
> This probably fails on the same problem, it can't setup the extent tree.
>
> b. btrfs check --init-extent-tree
> This is a heavy hammer, it might succeed, but takes a long time. On 5T
> it might take double digit hours or even single digit days. It's
> generally faster to just wipe the drive and restore from backups than
> use init-extent-tree (I understand this *is* your backup).
>
> c. Setup an overlay file on device mapper, to redirect the writes from
> a read-write mount with usebackup root. I think it's sufficient to
> just mount, optionally write some files (empty or not), and umount.
> Then do a btrfs check to see if the current tree is healthy.
> https://raid.wiki.kernel.org/index.php/Recovering_a_failed_software_RAID#Making_the_harddisks_read-only_using_an_overlay_file
>
> That guide is a bit complex to deal with many drives with mdadm raid,
> so you can simplify it for just one drive. The gist is no writes go to
> the drive itself, it's treated as read-only by device-mapper (in fact
> you can optionally add a pre-step with the blockdev command and
> --setro to make sure the entire drive is read-only; just make sure to
> make it rw once you're done testing). All the writes with this overlay
> go into a loop mounted file which you intentionally just throw away
> after testing.
>
> d. Just skip the testing and try usebackuproot with a read-write
> mount. It might make things worse, but at least it's fast to test. If
> it messes things up, you'll have to recreate this backup from scratch.

I took this approach. My command was simply:

    mount -o usebackuproot /dev/mapper/xzy /backup

It appears to have succeeded because it mounted without errors. I
completed a new incremental backup (with btrbk) and it finished
without errors.
I'll be pleased if my backup history is preserved, as appears to be the case.

I will run some checks on those backup subvolumes tomorrow. Are there
specific checks you would recommend?

>
> As for how to prevent this? I'm not sure. About the best we can do is
> disable the drive write cache with a udev rule,

That sounds like a suitable solution for me.

Thank you for this information. BTW, I have been using BTRFS for many
years. This is the first serious issue I have had, and as you said
there is a large element of user error and bad luck involved in this
case.

> and/or raid1 with
> another make/model drive, and let Btrfs detect occasional corruption
> and self heal from the good copy. Another obvious way to avoid the
> problem is, stop having power failures, crashes, and accidental USB
> cable disconnections :)
>
> It's not any one thing that's the problem. It's a sequence of problems
> happening in just the right (or wrong) order that causes the problem.
> Bugs + mistake + bad luck = problem.
>
> --
> Chris Murphy
