Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E97E918128D
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 09:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgCKIDd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 04:03:33 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35701 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgCKIDc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 04:03:32 -0400
Received: by mail-pj1-f65.google.com with SMTP id mq3so612078pjb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 01:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eHJRZCbs3KxAbriAlAN4jQIXHiK5ut/Ovc2Zx5fh6A8=;
        b=YHs0tJifO54ah4+a9RCJo9/CktMcwe5ITU0LbQDLjTkkHqWwvFcI68lPM0MO14H6FM
         y9Ee3Op56yWeE1YjPf+1474yRRSIvuMbp9BYa4fHrloDxJvKdsCE9BeVnLy6vKup5261
         I2mvU7MdHuWwVOpqJTbzXfggCipyrFGih1jZZilaNBUsuR51LChY86EOuLgrw/V/5IW3
         ukSk2EaVbAR25AT6fZOHYHc6osX+D5hTAEMPXnHxVlevagziBt8Ws0tnXedct41brVbS
         3qcoLhMV8zDsojUXITDzsE6HUljHWyFhTZfzwn94WE0EL5OBoyYuxTIyiDRPpPRe7u0Y
         SLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eHJRZCbs3KxAbriAlAN4jQIXHiK5ut/Ovc2Zx5fh6A8=;
        b=NKI6EjXKUeN9aozKwSbySSF+otXvX2zd2/iaCKRmvpQ4mqcV3j7U283yCiUWfODtLV
         +qj63VjR35z3JmQSVBk0lo/pw2JL/VyFn7C/sdvp6r9Tcdi6OMOF+vIYCAQQWhK+HHS1
         xrKNp2b2RbX7YtGomH0SA2wjbC3vtePyv/QaM0KQe9f/9qmkQPS9fatpPSoWO/i7dk52
         NDUCVDpPeZgeJcC+a1L5LEn8i2HVm1GuEgEhub6Y0ZMTFbSnrLGbF62LzRETnBBz1Lh+
         HT0w7y6rCqQD4ZVuNKVglZNUV+FEoTPM0r+kJ6QCSwFO0ZHvSmuFn1Y9tdXKEtIGhOOS
         9BSw==
X-Gm-Message-State: ANhLgQ3S4tmKAfN7XxHeUc1daIgr6JUGo4uH//DHGr0hcrVZmEPUci1U
        cFsJR+8NjGeT1tNB/eaegZLfMA==
X-Google-Smtp-Source: ADFU+vs3P9d4STMyuobamomwVlX//6gsi1tNVsUjj/eWDBr/DcSMomlEfTD7tiCbX2PoLFDKrkx2gw==
X-Received: by 2002:a17:90a:8d86:: with SMTP id d6mr2150204pjo.119.1583913809896;
        Wed, 11 Mar 2020 01:03:29 -0700 (PDT)
Received: from vader ([2601:602:8b80:8e0::14a2])
        by smtp.gmail.com with ESMTPSA id z3sm50507590pfz.155.2020.03.11.01.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 01:03:28 -0700 (PDT)
Date:   Wed, 11 Mar 2020 01:03:27 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH v2 3/4] btrfs-progs: receive: don't lookup clone root for
 received subvolume
Message-ID: <20200311080327.GA252106@vader>
References: <cover.1563822638.git.osandov@fb.com>
 <66ec0a6323c64aec74336e99696b6ad6576e091e.1563822638.git.osandov@fb.com>
 <CAL3q7H6sDTbMrjQqu_6Q6fy=Do0pgayHM-EGLXnG47BoitCScA@mail.gmail.com>
 <CAL3q7H7Yv+OjcJ4cDxwZ7x+k2z10s7yin0FTkNxaZvZ7AkVJ3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7Yv+OjcJ4cDxwZ7x+k2z10s7yin0FTkNxaZvZ7AkVJ3A@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 24, 2020 at 02:53:51PM +0000, Filipe Manana wrote:
> On Tue, Jul 23, 2019 at 12:19 PM Filipe Manana <fdmanana@gmail.com> wrote:
> >
> > On Tue, Jul 23, 2019 at 3:25 AM Omar Sandoval <osandov@osandov.com> wrote:
> > >
> > > From: Omar Sandoval <osandov@fb.com>
> > >
> > > When we process a clone request, we look up the source subvolume by
> > > UUID, even if the source is the subvolume that we're currently
> > > receiving. Usually, this is fine. However, if for some reason we
> > > previously received the same subvolume, then this will use paths
> > > relative to the previously received subvolume instead of the current
> > > one. This is incorrect, since the send stream may use temporary names
> > > for the clone source. This can be reproduced as follows:
> > >
> > > btrfs subvolume create subvol
> > > dd if=/dev/urandom of=subvol/foo bs=1M count=1
> > > cp --reflink subvol/foo subvol/bar
> > > mkdir subvol/dir
> > > mv subvol/foo subvol/dir/
> > > btrfs property set subvol ro true
> > > btrfs send -f send.data subvol
> > > mkdir first second
> > > btrfs receive -f send.data first
> > > btrfs receive -f send.data second
> > >
> > > The second receive results in this error:
> > >
> > > ERROR: cannot open first/subvol/o259-7-0/foo: No such file or directory
> > >
> > > Fix it by always cloning from the current subvolume if its UUID matches.
> > > This has the nice side effect of avoiding unnecessary UUID tree lookups
> > > in that case.
> > >
> > > Fixes: f1c24cd80dfd ("Btrfs-progs: add btrfs send/receive commands")
> > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> >
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> I can't find this patch in btrfs-progs. Any reason why it was never applied?
> 
> thanks

It must have gotten lost at some point. I'll resend it.
