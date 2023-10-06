Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB1D7BC215
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Oct 2023 00:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbjJFWMl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 18:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJFWMj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 18:12:39 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B71C2
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Oct 2023 15:12:37 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-690f7d73a3aso2362729b3a.0
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Oct 2023 15:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696630357; x=1697235157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rew63+U8EYvK/OQFQ4wEQBz1HJbKEzzHxs+hVI2/vlI=;
        b=XqSaPjsQWTG/slD/6GsmagBE1giQNMTjJ/R0PbtBmBkGe1UKUNzxKQve5NlVv6izkE
         liz4hU+CozXFmZcf7foIHOqRYovOLPbkE7e6Fd8UU7ySe6JeKhQct9gqPOBRwQgQ27vk
         PITJw8CVOPrAuis8ROP/7eWAh1F5jtMD7P+3iS4rW4x6wkIeFmCWL7Xtl1H72BjTg4Yd
         UaY7eDDVrrnA/lUmEuU0cvzXTYa6oSKKl5ulJhqi0YU/OtWTm5nfoVqAQtTXfxajjYgG
         hHYVqiCab3WdcglJ4vvnFVJKBNyX0RbcRymi9HE+wfxJmGQwhlvUxVMsC40zhUwVoWbL
         mJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696630357; x=1697235157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rew63+U8EYvK/OQFQ4wEQBz1HJbKEzzHxs+hVI2/vlI=;
        b=lVsefPpu68T1kcr7Ve9roxr35zWrABqvK5c7RbeYQ+5v3ERn0HgrkkRR2h0j8WRqc2
         pUdHqJRlv5Olc2YTCWd7/6SCkHl9yYuK6UM0oq1J082NndzKfPsoijTjlFsz4v3M6Fx7
         w2kxuzpF3AbdLr+gwjV+bUOsUmftUCalGMSPo4ChuD0TgEklLo3PEMi9FWPz7uR+15jd
         W7aeUmjuQ8gWQTs1KCxRe8dP2Knf4vkbo3FnHowaY6ofV3n2xJQbOG9k+UEsM1XNIpld
         q6G7hm0fAxzQZH/yVHZMZyLazVYpRRi4kJTnCjJrD7Soo2I9izYAKJjiRtMJXtxSQC9/
         c5qQ==
X-Gm-Message-State: AOJu0Ywetg2tZ5TH8tHS/P28h13F2SRXjnw17ljEODDICRSKE/roFhsb
        5fyhIjv8tvaO3/hmgwRz5Eh7Qw==
X-Google-Smtp-Source: AGHT+IG0bjlhSRaH0a67atx8yn8B2HTBfRFU1miCBB5/HMp9qtJUPMrOhhivpDJU+Opd25PufzxMcg==
X-Received: by 2002:a05:6a20:12c6:b0:131:a21:9f96 with SMTP id v6-20020a056a2012c600b001310a219f96mr11346140pzg.6.1696630357194;
        Fri, 06 Oct 2023 15:12:37 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id t19-20020a1709028c9300b001b9d95945afsm4406729plo.155.2023.10.06.15.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 15:12:36 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qot3h-00AOQq-10;
        Sat, 07 Oct 2023 09:12:33 +1100
Date:   Sat, 7 Oct 2023 09:12:33 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] fstests: add configuration option for executing post
 mkfs commands
Message-ID: <ZSCGUUtCY5AsmWaO@dread.disaster.area>
References: <cover.1695543976.git.anand.jain@oracle.com>
 <eff4da60fe7a6ce56851d5fc706b5f2f2d772c56.1695543976.git.anand.jain@oracle.com>
 <dfc4cece-d809-4b5b-93f7-7251ba3a492a@gmx.com>
 <5485cd32-2308-c9c5-4c97-9ff6c74c64dd@oracle.com>
 <0a8d40fc-501e-4d85-903a-83d9b3508bf5@gmx.com>
 <20231006060932.GD21283@frogsfrogsfrogs>
 <1f23346d-ad61-412f-b59d-1f76e2d1df6c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f23346d-ad61-412f-b59d-1f76e2d1df6c@gmx.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 06, 2023 at 05:16:31PM +1030, Qu Wenruo wrote:
> However for the whole btrfs/fstests combination, we have several
> features which can not be easily integrated into fstests.
> 
> The biggest example is multi-device management.
> 
> For now, only some btrfs specific test cases are utilizing
> SCRATCH_DEV_POOL to cover multi-device functionality (including all the
> RAID and seed support).
> This means way less coverage for seed and btrfs RAID, all generic group
> would not utilize btrfs RAID/seed functionality at all.

IOWs, you are saying that the btrfs device setup code in fstests is
functionally deficient.

> 
> For a better coverage, or for more complex setup (maybe dm-dust for XFS
> log device?), I am not that convinced if the current plain mkfs options
> is good enough.

We already know mkfs alone isn't sufficent - that's why we have
filesystem specific mkfs fucntions for any filesystem that needs to
do something more complex than run mkfs....

i.e. we already have infrastructure that we use to solve this
problem - there are example implementations that you can look at to
follow.

> 
> Thus I'm more interested in exploring the possibility to "out-source"
> those basic functionality (from mkfs to check) to outside scripts, as
> we're not that far away to hit the limits of the existing framework. (At
> least for btrfs)

The whole idea that we set up devices for testing via magic,
undocumented, private external scripts is antithetical to the
purpose of fstests. The device model used in fstests is that you tell it
what configuration you want, and it does all the work to set them up
that way. This allows tests to override or skip incompatible
configurations based on known config variables, etc.

It also allows -everyone- to test complex configurations without
needing to share private, external scripts or knowing any of the
intricate details needed to set up that configuration. External
scripts are like proprietary code - it only works if you have some
magic secret sauce that nobody else knows about.

If it's hard to set something up in fstests, then *fix that
problem*. If you are adding code in environment variables and
hacking in environment varaibles to run that code, then the -code
itself- should be in fstests.

Having the code in fstests means that anyone can add
"BTRFS_SCRATCH_UUID='<uuid>' to their config file to change uuids
for the devices being tested. They don't need to know waht magic
command is needed to do this, when it needs to be set, what changes
elsewhere in fstests they need to watch out for, which tests is
might conflict with, etc.

Hiding this in some custom script means it can't be easily
documented, can't be easily or widely replicated, it can't be
discovered by reading the fstests code, and it isn't obvious to
-anyone- that it is part of the btrfs test matrix that needs to be
exercised.

IOWs, it's just really bad QA architecture to externalise random
parts of the test environment configuration.  If the configuration
needs to be tested, then the infrastructure should support that
directly and it should be easily discoverable and used by people
largely unfamiliar with btrfs volume management (i.e. typical distro
QA environment).

> > I suppose the problem there is that mkfs.btrfs won't itself create a
> > filesystem with the metadata_uuid field that doesn't match the other
> > uuid?
> 
> That's not a big deal, we (at least me) are very open to add this mkfs
> feature.
> 
> But there are other limits, like the fsck part.
> 
> For now, btrfs follows the behavior of other fses, just check the
> correctness of the metadata, and ignore the correctness of data.
>
> But remember btrfs has data checksum by default, thus it can easily
> verify the data too, and we have the extra switch ("--check-data-csum"
> option) to enable that for "btrfs check".

Which is yet another arguement for the code being in fstests and
controlled by an environment variable.

This is *exactly* the case for the LARGE_SCRATCH_DEV stuff that ext4
and XFS support in the mkfs routines. On the XFS side we have
LARGE_SCRATCH_DEV checks in -both- the XFS mkfs and check/repair
functions to handle this configuration correctly.

IOWs, what you want to do is add a config variable for
BTFS_SCRATCH_CHECK_DATA, and trigger off that in all btrfs specific
functions that need to add, modify or check data checksums.

> For now we're not going to enable the "--check-data-csum" option nor we
> have the ability to teach fstests how to change the behavior.

We most certainly do have the ability to do this in fstests, and
quite easily.

Another example is the USE_EXTERNAL variable that tells XFS and ext4
that external log devices (and rt devices for XFS) are to be used.
This has hooks all over mkfs, mount, check, repair, xfs_db, quota
and fs population functions so that they all specify devices
appropriately.

That is, this config variable directly modifies the command lines
used for these operations - it is an even better example of FS
specific device configuration driving by config variables than
LARGE_SCRATCH_DEV.  This model will work just fine for stuff like
the --check-data-csum btrfs specific check option being talked about
here, and the only thing that needs to change is the btrfs specific
check/repair functions...

> Thus I'm taking the chance to explore any way to "out-source" those
> mkfs/fsck functionality, even this means other fses may not even bother
> as the current framework just works good enough for them.

And as I said above, that's the wrong model for fstests - it means
that a typical QA environment is not going to be able to test
complex things because the people running the tests do not know how
to write these complex "out-sourced" scripts to configure the test
environment.

Having all the code in fstests and triggering it via a config
variable is the right way to do this sort of thing. It works for
everyone and it's easy to replicate the test environment and
configurations for reproduction of issues that are found.

If the test envirnoment is dependent on private scripts for
configuration and reproduction of issues, then how do other people
reproduce the problems you might find? Yeah, you have to share all
your scripts for everyone to run, and at that point the code
actually needs to be in fstests itself because it's proven to be a
useful test configuration that everyone should be running....

> But IIRC, even f2fs is gaining multi-device support, I believe this is
> not a btrfs specific thing, but a framework limitation.

The scratch dev pool was an easy extension to support multi-device
btrfs filesystems done in the really early days when there was
almost zero btrfs specific test coverage in fstests. I'm not
surprised that it has warts and may not do everything that btrfs
developers might need these days.

However, we don't need custom hooks to externalise scripts - we
already have a working model for config driven filesystem specific
device configuration. I don't see that there is any major common
infrastructure change needed, most of what I'm hearing is that the
btrfs specific device configuration needs to catch up with how other
filesystems have been testing complex device configurations....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
