Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F0C474CB2
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 21:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbhLNUe2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 15:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbhLNUe2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 15:34:28 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D967EC061574
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Dec 2021 12:34:27 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id t11so19663570qtw.3
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Dec 2021 12:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xw9QPVyXx7UIV0bDxQffWaT6PSRcDKIOT4wyWFqkuRQ=;
        b=nNbg/xCciNXxIG0HI0rm20YFAA8SWs2GTX5GEyRhqa6pptwMqBvQsh5cS2kfuB+aKY
         a9IOcvyeMH63x+czFjiMFRH1E2oq/EOXvPo7r++WOW5cm4NQMHfn8m2aBNLrRAggF70K
         Dqo5QXAgm8b1X5C0o4BSXvAVISLSsVqyL32TWCICsG1+3Pa7ohj2xlEGAKVyF6trnbwD
         hjjrAsqk9LUIgXj5w3kIR+SNNAUVTrhiX6bvDeRuL3forv2r37pB7KafxI2QycOtbekY
         2XhGhEMK+k/N3vndJfv8UbAH4kQd4LbtJxlApLNZvXdrXvX7pEQAVMWEDkdpkct2J5Sv
         cBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xw9QPVyXx7UIV0bDxQffWaT6PSRcDKIOT4wyWFqkuRQ=;
        b=RLH/r7d68NN2OYmsq+g1solxHO/OY+EZR/9YlaP7jSFZKPeHHV5inpk9agwLBVK/xL
         qfNJtYFJVE0pB9tSqeC7IFtzREPRZzX9pgludfAC2uGrUeqd/6ZVebVAx0eS8X3CFBXi
         jNtabc4B2MLhamk/Z/gckJRnYfDKi5mTp/P1x6bg6wNp8PtgOC3K4IXU8A+YoEz76VLx
         KMn9iIo6Fr8cj3YrrXSn6QzqDbJJr5l4ko9gX+0X4UY+HugOSylmtekCHDhIIbpEiDfN
         OgvmywFekeuvKZnSlJ14TdI76W3if1vI+4yFsIcgijp6HpAi25bL+vaDqnD8gZFu+omc
         GzSA==
X-Gm-Message-State: AOAM532Hp01QHoLDhjN8hcyceTEbZU4S8B22d0lWKPH4+BL3F1NZsjgg
        hfDTzO8K90DI8WtrSeD1dZRMEQ==
X-Google-Smtp-Source: ABdhPJyMlGSDM5w7cW3GXshw5hlDVkqpl6lEJEzp+maJlh1SNjoxMq8+sqHxXLmjvxJblXp/wXVMpQ==
X-Received: by 2002:a05:622a:50d:: with SMTP id l13mr8649992qtx.649.1639514066648;
        Tue, 14 Dec 2021 12:34:26 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 14sm784347qtx.84.2021.12.14.12.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 12:34:25 -0800 (PST)
Date:   Tue, 14 Dec 2021 15:34:24 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     kreijack@inwind.it, David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode
Message-ID: <Ybj/0ITsCQTBLkQF@localhost.localdomain>
References: <cover.1635089352.git.kreijack@inwind.it>
 <SYXPR01MB1918689AF49BE6E6E031C8B69E749@SYXPR01MB1918.ausprd01.prod.outlook.com>
 <1d725df7-b435-4acf-4d17-26c2bd171c1a@libero.it>
 <Ybe34gfrxl8O89PZ@localhost.localdomain>
 <YbfN8gXHsZ6KZuil@hungrycats.org>
 <71e523dc-2854-ca9b-9eee-e36b0bd5c2cb@libero.it>
 <Ybj40IuxdaAy75Ue@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ybj40IuxdaAy75Ue@hungrycats.org>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 14, 2021 at 03:04:32PM -0500, Zygo Blaxell wrote:
> On Tue, Dec 14, 2021 at 08:03:45PM +0100, Goffredo Baroncelli wrote:
> > On 12/13/21 23:49, Zygo Blaxell wrote:
> > > On Mon, Dec 13, 2021 at 04:15:14PM -0500, Josef Bacik wrote:
> > > > On Mon, Dec 13, 2021 at 08:54:24PM +0100, Goffredo Baroncelli wrote:
> > > > > Gentle ping :-)
> > > > > 
> > > > > Are there anyone of the mains developer interested in supporting this patch ?
> > > > > 
> > > > > I am open to improve it if required.
> > > > > 
> > > > 
> > > > Sorry I missed this go by.  I like the interface, we don't have a use for
> > > > device->type yet, so this fits nicely.
> > > > 
> > > > I don't see the btrfs-progs patches in my inbox, and these don't apply, so
> > > > you'll definitely need to refresh for a proper review, but looking at these
> > > > patches they seem sane enough, and I like the interface.  I'd like to hear
> > > > Zygo's opinion as well.
> > > 
> > > I've been running earlier versions with modifications since summer 2020,
> > > and this version mostly unmodified (rebase changes only) since it was
> > > posted.  It seems to work, even in corner cases like converting balances,
> > > replacing drives, and running out of space.  The "running out of space"
> > > experience is on btrfs is weird at the best of times, and these patches
> > > add some more new special cases, but it doesn't behave in ways that
> > > would surprise a sysadmin familiar with how btrfs chunk allocation works.
> > > 
> > > One major piece that's missing is adjusting the statvfs (aka df)
> > > available blocks field so that it doesn't include unallocated space on
> > > any metadata-only devices.  Right now all the unallocated space on
> > > metadata-only devices is counted as free even though it's impossible to
> > > put a data block there, so anything that is triggered automatically
> > > on "f_bavail < some_threshold" will be confused.
> > > 
> > > I don't think that piece has to block the rest of the patch series--if
> > > you're not using the feature, df gives the right number (or at least the
> > > same number it gave before), and if you are using the feature, you can
> > > subtract the unavailable data space until a later patch comes along to
> > > fix it.
> > > 
> > > I like
> > > 
> > > 	echo data_only > /sys/fs/btrfs/$uuid/devinfo/3/type
> > 
> > Only to be clear, for now you can pass a numeric value to "type". Not a text
> > like your example.
> > 
> > However I want to put on the table another option: to not expose all the
> > "type" field, but only the "allocation policy"; we can add a new sysfs field
> > called "allocation policy" that internally change the dev_item->type field.
> > 
> > It is not only a "cosmetic" change. If we want to change the allocation
> > policy, now the correct way is:
> > - read the type field
> > - change the "allocation policy" bits
> > - write the type field
> > 
> > Which is race 'prone'
> 
> > For now it is not a problem, because type contains only the allocation bits.
> > But in future when the type field will contains further properties this could
> > be a problem.
> 
> Yeah, keep the interface very narrow, don't hand out access to random bits.
> 
> If the kernel supports additional bits, it should support additional
> sysfs filenames to go with them.  Or it could put all the supported
> options in the sysfs field, like block IO schedulers do, so you could
> find this in the file by reading it:
> 
> 	[prefer_data] prefer_metadata metadata_only data_only
> 
> > > more than patching btrfs-progs so I can use
> > > 
> > > 	btrfs prop set /dev/... allocation_hint data_only
> > > 
> > > but I admit that might be because I'm weird.
> > 
> > I prefer the echo approach too; however it is not very ergonomics in conjunction
> > to sudo....
> 
> For /proc/sys/* we have the 'sysctl' tool, so you can write 'sysctl
> vm.drop_caches=1' or 'sudo sysctl vm.drop_caches=1'.  For some reason
> we don't have this for sysfs (or maybe it's just Debian...?) so we have
> to write things like 'echo foo | sudo tee /sys/fs/...'.
> 
> Of course btrfs-progs could always open the
> /sys/fs/btrfs/.../allocation_policy file and write to it.  But if we're
> modifying btrfs-progs then we could use the ioctl interface anyway.
> 
> I don't have a strong preference for either sysfs or ioctl, nor am I
> opposed to simply implementing both.  I'll let someone who does have
> such a preference make their case.

I think echo'ing a name into sysfs is better than bits for sure.  However I want
the ability to set the device properties via a btrfs-progs command offline so I
can setup the storage and then mount the file system.  I want

1) The sysfs interface so you can change things on the fly.  This stays
   persistent of course, so the way it works is perfect.

2) The btrfs-progs command sets it on offline devices.  If you point it at a
   live mounted fs it can simply use the sysfs thing to do it live.

Does this seem reasonable?  Thanks,

Josef
