Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659254F8A06
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 00:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbiDGWML (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Apr 2022 18:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiDGWMH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Apr 2022 18:12:07 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0423CE03D
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Apr 2022 15:10:06 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id r2so8513678iod.9
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Apr 2022 15:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9WfN6um36RA9eFO0sro3EyzEuzCQoTbcTtKM3naZwd0=;
        b=s+nd7MIrRuf585s3SVID+dS9b4GvWL1ZuWnpr19wsANtpqmuU0PgNupx0xDaC2UFdh
         8q6Wpl0X/VzQf40CPm0f8w5+WM3gz6LvDWi+5zX3aTqnHrWm8B9ad34/Htl263RXgpc/
         +y/CI98VpOhGugmcQ+C3ZH1fTdgcZ1OSDRu31cc3uTnl6hJOJ5EScupncdY7IHv01niv
         BBPRjNOfAIN5stfYf3T1sYdTFEeztz97WzyGHA4Q7wSJSzObDXDTKEducAkpx+27IzJ6
         4h7gQgD3DMHHKTSorcQ3JEdyR7gsCJ5bWCZXFdZGjyCQ9J85tO/uz92Q52oq+iiYsQ35
         /pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9WfN6um36RA9eFO0sro3EyzEuzCQoTbcTtKM3naZwd0=;
        b=PJPBNkar/74nMFDK8mCwWJiUeAeNAJH8KfgFVt+u7PiF+nQoJmSrQvCbrwAQTwcWnl
         8U5W/Byuyoz4jSq63lP8+zmSttsCJllTQyILN/1zmu7oPORj6w3HAmsXh7wBbD5nCMYA
         s4JWE/l7xWZOyyfXFqYBB6RgYuZfsDPSVTgfW7r6IyKNgBChkRUSpXRLRgHOekAeKTCA
         /pgzHzzP5C4r3pF4O6kojR8B3jlVhtTIP8ZYikZn2TKOzMBJxxGmFXQb1zcMc2F82LTs
         xYtR7whHiWb8mWYX4zFPuUOE93wYhjSje4Jn8q+jwPyQJLswaW6gcrhZ2PObT5HkS7H4
         OeUg==
X-Gm-Message-State: AOAM53399Ipdh/XO+16b4q9Tw4DbZaVodm0GmUIiMEaKF5UXCw1n5F1V
        fIqNftOoWhuT/lwp0wGaYFl6G0A2ahYhAXGybgfiD7Y84OE=
X-Google-Smtp-Source: ABdhPJyf52GG3MGJyYNdRezAX1FU+5y7Wv+mIXqCugbbTRV9P8kORTSJhLCWeuZp/Bqni7RIreJZIjw1rSUZz3SBsms=
X-Received: by 2002:a05:6638:270b:b0:323:8ff0:a5e4 with SMTP id
 m11-20020a056638270b00b003238ff0a5e4mr7690196jav.102.1649369405129; Thu, 07
 Apr 2022 15:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <11970220.O9o76ZdvQC@ananda> <20220407052022.GC25669@merlins.org>
 <20220407162951.GD25669@merlins.org> <CAEzrpqdeph1AM74habMeOg_VURv5AFvZZ-9aUM9ZVEkM+-3Xkg@mail.gmail.com>
In-Reply-To: <CAEzrpqdeph1AM74habMeOg_VURv5AFvZZ-9aUM9ZVEkM+-3Xkg@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 7 Apr 2022 18:09:53 -0400
Message-ID: <CAEzrpqdjKE3ehKjEqWOuBHPuScpjDG+B7r81SP1Vd+G8RVK6rA@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 7, 2022 at 1:07 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Thu, Apr 7, 2022 at 12:29 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Thu, Apr 07, 2022 at 09:30:41AM +0200, Martin Steigerwald wrote:
> > > I did not keep statistics, but this might be one of the longest threads
> > > on BTRFS mailing list.
> > >
> > > Good luck with restoring your filesystem or at least recovering all data
> > > from it!
> >
> > Haha, thanks. All props go to Josef for not giving up :)
> > Even if I don't get my data back without going to the backup, this will
> > have been a useful exercise, however I managed to hose my FS, made for
> > an interesting recovery case.
> >
> > On Wed, Apr 06, 2022 at 10:20:22PM -0700, Marc MERLIN wrote:
> > > On Wed, Apr 06, 2022 at 09:37:17PM -0700, Marc MERLIN wrote:
> > > > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-find-root -o 1 /dev/mapper/dshelf1a 2>&1 |tee /tmp/outo
> > >
> > > there may have been something else that ate all my memory.
> > > I killed shinobi and re-ran your code overnight while dumping
> > > memory. I'll have a memory trace running this time while it re-runs
> > > overnight.
> >
> > Ok, good news is that it was actually shinobi that somehow managed to
> > take enough RAM to OOM hang the system, but in such a way that I had
> > never seen before (sysrq not even able to work anymore, which is
> > worrisome).
> > btrfs-find-root just took another 8G which was enough to tip the glass
> > over, but shinobi (and ultimately the kernel for being unable to kill
> > userspace that takes too much RAM), was at fault.
> >
> > Overnight, it ran stable at 8GB:
> >   PID USER      PR  NI  VIRT  RES  SHR S  %CPU %MEM    TIME+  COMMAND
> > 31873 root      20   0 8024m 7.8g    0 R  99.9 25.2 667:57.24 btrfs-find-root
> >
> > But the bad news is that it didn't complete, and it's not looking like it's
> > converging.
> >
>
> Ok let it keep going, I have an idea of how to make this less awful
> but also not use all the memory.  I'm going to start writing this up
> now, if I finish before your run finishes you can switch to the new
> shit and see how that goes.  I've got meetings until 4pm my time (it's
> 1pm my time), so you're not going to hear from me for a while.
> Thanks,
>

Just following up on this, I've got hungry kids, I'm about halfway
through the new shit.  Depending on how much help kids need with
homework I may have this done later tonight, or it'll be tomorrow
morning.  Thanks,

Josef
