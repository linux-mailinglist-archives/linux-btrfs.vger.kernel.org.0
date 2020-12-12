Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20872D8869
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Dec 2020 18:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387936AbgLLQpz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Dec 2020 11:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgLLQpq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Dec 2020 11:45:46 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D63FC0613D3
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Dec 2020 08:45:06 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id t8so9172670pfg.8
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Dec 2020 08:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rn93Uax6H3x5yi3xVxNf6wg9zo1zELmrjjFR1iXBhzU=;
        b=dKvg5lHxyOMeL2TlDn4nxtV0oFzItp1i8MMxoSoRtErC9pjhlnYe0+t8XhTRSy44sP
         WCF8UTO8Li5FsiXLb6X8OCNIOvJ65E+yJ8FMffenNt3wPGLyubdbFfc0gahgkuWacNAl
         mdhYZ8NpEQj72PVXGDUTgER7Qo8o8/PHIxR0Gop8qNVa3RHTAI8nB+p6aT7vj8o0ermr
         JFMUbn7x3tlMibf6umo17vuqPGzyCnEy2YyPdeviUd3D7LcAHAkRLo8E5kLa2sGXqjFX
         z9VRS2OW8kS4jaAAW882y+qbwHDrP5nfkpI/Dw4TkHwJCipIj1TPPmy85O8ox2ulJlmi
         XdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rn93Uax6H3x5yi3xVxNf6wg9zo1zELmrjjFR1iXBhzU=;
        b=HmlPXgOeJFya+IVmWpZv75uHAI0H8hJ9fzc5OJIQUo+OEBOxihWmCrq1o7Dhk9H0rz
         B5FhMoXv2p5LdFWt3A1I83LoIj29KEG48Yvthv1i6yIIPdEdLzsWmwWGlyi1eFIz3Alh
         oiXFTjeU9c/6EinZAe+jXPDCk3T4+yNArayNYSO1HE+VR88AN3+Fj2o8q4KZ4DYjlPts
         cd2KvxF/loWn50t2YnSuzL5y4dfA9sGFsHj7yRI5D24kuo1QFIKUfiGYNF6zEDgIsILy
         dMr4rs1rPxBwj6THTVcDOhflNRH3T8OcBQUkNSzPVLar/B60rWmmEr1NF/PUWab418A7
         Jl5w==
X-Gm-Message-State: AOAM531qw9drTeXqqjhQhNr6qwuimX/QB5Ehv5as8yEqHytNXyMIhIPj
        6WilWOQhn81uPddHXiQp4xk=
X-Google-Smtp-Source: ABdhPJw2cV+5aJws260kysuMUA9mUcA/q20QnHGCiNkoczkTPs7QbsgEDDhyTrobE6pcfRszwlj5kw==
X-Received: by 2002:a63:7cd:: with SMTP id 196mr7353086pgh.168.1607791505781;
        Sat, 12 Dec 2020 08:45:05 -0800 (PST)
Received: from realwakka ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id g33sm15111237pgm.74.2020.12.12.08.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 08:45:05 -0800 (PST)
Date:   Sat, 12 Dec 2020 16:44:55 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "g.btrfs@cobb.uk.net" <g.btrfs@cobb.uk.net>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: scrub: warn if scrub started on a device
 has mq-deadline
Message-ID: <20201212164455.GA1080@realwakka>
References: <20201205184929.22412-1-realwakka@gmail.com>
 <SN4PR0401MB35981F791C9508429506EDA09BCE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201210202020.GH6430@twin.jikos.cz>
 <SN4PR0401MB359892AE5C0771A8209A4A559BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201211155348.GK6430@suse.cz>
 <SN4PR0401MB3598ECDD1EE787041F3C328C9BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <SN4PR0401MB3598DA1476FDAB86BD9EE4559BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <7d14b742-feef-58b4-97da-45d05132b02e@cobb.uk.net>
 <SN4PR0401MB3598EA952D5F942C165422819BC90@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <d3afc9edd13c47b33cf3152e27f10b701a97b77a.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3afc9edd13c47b33cf3152e27f10b701a97b77a.camel@wdc.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Dec 12, 2020 at 11:05:04AM +0000, Damien Le Moal wrote:
> On Sat, 2020-12-12 at 10:34 +0000, Johannes Thumshirn wrote:
> > On 11/12/2020 18:05, Graham Cobb wrote:
> > > On 11/12/2020 16:42, Johannes Thumshirn wrote:
> > > > On 11/12/2020 17:02, Johannes Thumshirn wrote:
> > > > > [+Cc Damien ]
> > > > > On 11/12/2020 16:55, David Sterba wrote:
> > > > > > On Fri, Dec 11, 2020 at 06:50:23AM +0000, Johannes Thumshirn wrote:
> > > > > > > On 10/12/2020 21:22, David Sterba wrote:
> > > > > > > > On Mon, Dec 07, 2020 at 07:23:03AM +0000, Johannes Thumshirn wrote:
> > > > > > > > > On 05/12/2020 19:51, Sidong Yang wrote:
> > > > > > > > > > Warn if scurb stared on a device that has mq-deadline as io-scheduler
> > > > > > > > > > and point documentation. mq-deadline doesn't work with ionice value and
> > > > > > > > > > it results performance loss. This warning helps users figure out the
> > > > > > > > > > situation. This patch implements the function that gets io-scheduler
> > > > > > > > > > from sysfs and check when scrub stars with the function.
> > > > > > > > > 
> > > > > > > > > From a quick grep it seems to me that only bfq is supporting ioprio settings.
> > > > > > > > 
> > > > > > > > Yeah it's only BFQ.
> > > > > > > > 
> > > > > > > > > Also there's some features like write ordering guarantees that currently 
> > > > > > > > > only mq-deadline provides.
> > > > > > > > > 
> > > > > > > > > This warning will trigger a lot once the zoned patchset for btrfs is merged,
> > > > > > > > > as for example SMR drives need this ordering guarantees and therefore select
> > > > > > > > > mq-deadline (via the ELEVATOR_F_ZBD_SEQ_WRITE elevator feature).
> > > > > > > > 
> > > > > > > > This won't affect the default case and for zoned fs we can't simply use
> > > > > > > > BFQ and thus the ionice interface. Which should be IMHO acceptable.
> > > > > > > 
> > > > > > > But then the patch must check if bfq is set and otherwise warn. My only fear
> > > > > > > is though, people will blindly select bfq then and get all kinds of 
> > > > > > > penalties/problems.
> > > > > > 
> > > > > > Hm right, and we know that once such recommendations stick, it's very
> > > > > > hard to get rid of them even if there's a proper solution implemented.
> > > > > > 
> > > > > > > And it's not only mq-deadline and bfq here, there are also
> > > > > > > kyber and none. On a decent nvme I'd like to have none instead of bfq, otherwise
> > > > > > > performance goes down the drain. If my workload is sensitive to buffer bloat, I'd
> > > > > > > use kyber not bfq.
> > > > > > 
> > > > > > I'm not sure about high performance devices if the scrub io load on the
> > > > > > normal priority is the same problem as with spinning devices. Assuming
> > > > > > it is, we need some low priority/idle class for all schedulers at least.
> > > > > > 
> > > > > > > So IMHO this patch just makes things worse. But who am I to judge.
> > > > > > 
> > > > > > In this situation we need broader perspective, thanks for the input,
> > > > > > we'll hopefully come to some conclusion. We don't want to make things
> > > > > > worse, now we're left with workarounds or warnings until some brave soul
> > > > > > implements the missing io scheduler functionality.
> > > > > > 
> > > > > 
> > > > > I think that's all we can do now.
> > > > > 
> > > > > Damien (CCed) did some work on mq-deadline, maybe he has an idea if this is
> > > > > possible/doable.
> > > > > 
> > > > 
> > > > Ha I have a stop gap solution, we could temporarily change the io scheduler to bfq
> > > > while the scrub job is running and then back to whatever was configured.
> > > > 
> > > > Of cause only if bfq supports the elevator_features the block device requires.
> > > > 
> > > > Thoughts?
> > > > 
> > > 
> > > I would prefer you didn't mess with the scheduler I have chosen (or only
> > > if asked to with a new option). My suggestion:
> > > 
> > > 1. If -c or -n have been specified explicitly, check the scheduler and
> > > error if it is known that it is incompatible.
> 
> Elevator not compatible with zoned block devices will not even be shown in
> sysfs. E.g. bfq is not even listed for SMR drives. So the user/FS cannot select
> a wrong scheduler beside "none". For SMR, that currently means deadline only.
> 
> For ZNS, the ELEVATOR_F_ZBD_SEQ_WRITE feature is ignored, so any scheduler can
> be used. Using one would not be a good idea in any case, but if bfq is needed
> it can be used: we do not have the sequential write constraint thanks to the
> use of zone append writes only for sequential zones. 
> 
> > > 2. If -c/-n have not been specified, just warn (not fail) if the
> > > scheduler is known to be incompatible with the default idle class request.
> > > 
> > > 3. Provide a way to suppress the warning in step 2 (is -q enough, or
> > > does that also suppress other useful/important messages?).
> > > 
> > > 4. Expand the description in the man page which currently says "Note
> > > that not all IO schedulers honor the ionice settings." It could read
> > > something like:
> > > 
> > > "Note that not all IO schedulers honor the ionice settings. At time of
> > > writing, only bfq honors the ionice settings although newer kernels may
> > > change that. A warning will be shown if the currently selected IO
> > > scheduler is known to not support ionice."
> > > 
> > > 
> > 
> > 
> > Works for me as well. My only concern is, people will default to bfq and then 
> > complain for XY because of the change to bfq. Note, I'm not against bfq at all,
> > I'm just arguing it's not a one size fits all decision.
> > 
> > I'd also like to see if scrub on a nvme really is beneficial with bfq instead of
> > none. I have my doubt's but that's a gut feeling and I have no numbers to back up
> > this statement.
> > 
> > Nice weekend,
> > 	Johannes

Hello All, 
I tried to understand but I don't seem to understand all. All I know is
that some people said that the patch worried about forcing to use bfq
and so the patch should be dropped. I agree that user application should
be independent to scheduler. and someone commented that there is option
when user provide arguments for ionice.
IMHO, it's good to warn when user provide option for ionice explicit in
verbose mode. I don't think it will affect the users who used it the way
it was before.
I'm just a newbie and thanks to all who gave me their good comments.

Thanks,
Sidong
> > 
> 
> -- 
> Damien Le Moal
> Western Digital
