Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFC27D7656
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Oct 2023 23:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjJYVHC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Oct 2023 17:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjJYVHA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Oct 2023 17:07:00 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D7F13D
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Oct 2023 14:06:58 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-66d17fd450aso11097236d6.1
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Oct 2023 14:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1698268017; x=1698872817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZytB5j+cqWISPSB2svmNjXmS7qMmv4D7nJ0QJibgwE=;
        b=STiV4Ih9HEytD8mlaTSn3AA9rjFRK7OVjNTvoylJdftAcJ7C/8MdvjhfWvNqiO2M3/
         bCENxkGJx6XsNZGxNu50U71RqoEHfNJuycxrx6BAAAtU4ntm5YnJz4ujSCWL6VuqhhpE
         ZVixUhex2nKKEztoJQUrgEE27VLRoRdwLiG+XHCgnemBAt64mqsIKg+xo60iLDK0yd6e
         b7KDy0awK3BY7vK1rWaRS+TuFion/cK20D8NgUcbAXfe9yDLMa4PaQSQEf2Bo57qOqBS
         z9R+ODqz8RCMmwT5wOyRHYqir4szEn7gys8MeGUSccKGofkOpB0l34fF3svxFYoaFOsj
         QFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698268017; x=1698872817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZytB5j+cqWISPSB2svmNjXmS7qMmv4D7nJ0QJibgwE=;
        b=Tvlc7khQX7IZPya2b/zW1kTXPMZsjR3wm8ucLv6wJsXxfMYgAAOsxdGw069uolUPKr
         nc8prz2oodch7HPx4/2uwo3e1yh1mXHLNeKk5oYO7bsSYe4QCXpIh9KyJRLFTq5DzPza
         3+1WW/4yf4EuhC1KursKMM7TooDeujHyaeZfKkG1GSpHoocyLL2yJH7tiNnolL1B0VaO
         NObPxKmEHto6eT0sKh1vkPt2qvJ3g5+B1wGq/snJ0jSvbY31YprSk4QwXSDn6aMEt/ZV
         xXg/5aI/pmWeRfnnwHKEEVxPV4VC7Xv9kr1hRCxDmCsA7AGffAoq+9Ynlu/rVF2SahRh
         tk+w==
X-Gm-Message-State: AOJu0Yy8p3Ew31/XbBB34TBMdZLKccpsoBOeFVZ8z8fFf7aUKA3gT9Bt
        Y1+9BV/Zk5u0ZbOXxiQzcNwU8w==
X-Google-Smtp-Source: AGHT+IGcBa0TRZ5uW5atJ7v3fMab4ZQ6EkgZwGLsRQCLj8vifJJB+HBcIj1pl9b1b/ZUv28xfQYwPg==
X-Received: by 2002:a05:6214:418a:b0:66d:327:bf8f with SMTP id ld10-20020a056214418a00b0066d0327bf8fmr1058030qvb.30.1698268017035;
        Wed, 25 Oct 2023 14:06:57 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id jy20-20020a0562142b5400b0065d051fc445sm4716902qvb.55.2023.10.25.14.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 14:06:56 -0700 (PDT)
Date:   Wed, 25 Oct 2023 17:06:54 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231025210654.GA2892534@perftesting>
References: <20231025135048.36153-1-amir73il@gmail.com>
 <ZTk1ffCMDe9GrJjC@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTk1ffCMDe9GrJjC@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 25, 2023 at 08:34:21AM -0700, Christoph Hellwig wrote:
> On Wed, Oct 25, 2023 at 04:50:45PM +0300, Amir Goldstein wrote:
> > Jan,
> > 
> > This patch set implements your suggestion [1] for handling fanotify
> > events for filesystems with non-uniform f_fsid.
> 
> File systems nust never report non-uniform fsids (or st_dev) for that
> matter.  btrfs is simply broken here and needs to be fixed.

We keep going around and around on this so I'd like to get a set of steps laid
out for us to work towards to resolve this once and for all.

HYSTERICAL RAISINS (why we do st_dev)
-------------------------------------

Chris made this decision forever ago because things like rsync would screw up
with snapshots and end up backing up the same thing over and over again.  We saw
it was using st_dev (as were a few other standard tools) to distinguish between
file systems, so we abused this to make userspace happy.

The other nice thing this provided was a solution for the fact that we re-use
inode numbers in the file system, as they're unique for the subvolume only.

PROBLEMS WE WANT TO SOLVE
-------------------------

1) Stop abusing st_dev.  We actually want this as btrfs developers because it's
   kind of annoying to figure out which device is mounted when st_dev doesn't
   map to any of the devices in /proc/mounts.

2) Give user space a way to tell it's on a subvolume, so it can not be confused
   by the repeating inode numbers.

POSSIBLE SOLUTIONS
------------------

1) A statx field for subvolume id.  The subvolume id's are unique to the file
   system, so subvolume id + inode number is unique to the file system.  This is
   a u64, so is nice and easy to export through statx.
2) A statx field for the uuid/fsid of the file system.  I'd like this because
   again, being able to easily stat a couple of files and tell they're on the
   same file system is a valuable thing.  We have a per-fs uuid that we can
   export here.
3) A statx field for the uuid of the subvolume.  Our subvolumes have their own
   unique uuid.  This could be an alternative for the subvolume id option, or an
   addition.

Either 1 or 3 are necessary to give userspace a way to tell they've wandered
into a different subvolume.  I'd like to have all 3, but I recognize that may be
wishful thinking.  2 isn't necessary, but if we're going to go about messing
with statx then I'd like to do it all at once, and I want this for the reasons
stated above.

SEQUENCE OF EVENTS
------------------

We do one of the statx changes, that rolls into a real kernel.  We run around
and submit patches for rsync and anything else we can think of to take advantage
of the statx feature.

Then we wait, call it 2 kernel releases after the initial release.  Then we go
and rip out the dev_t hack.

Does this sound like a reasonable path forward to resolve everybody's concerns?
I feel like I'm missing some other argument here, but I'm currently on vacation
and can't think of what it is nor have the energy to go look it up at the
moment.  Thanks,

Josef
