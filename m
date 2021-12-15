Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608C8475A22
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 14:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243063AbhLON6M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 08:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243112AbhLON6K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 08:58:10 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41E2C061784
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 05:58:06 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id m186so20031878qkb.4
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 05:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qXroraj52ct2YaRmID2JvaLQG+4F2y1h0JVmD2fZ/4k=;
        b=BV+FEZ5fU8VXUY4YnHmVq8SI0j6mUQsc7450x1IkvF+yHfo44U6Ijq1infisZuEYz/
         sc+oQbpLnCE/gfSOz1DCanW8O8m2ghkHOXOMxEj5ciJ+tFpp0m1qoxw6gcR8CJ9BvSmo
         Q2ADfGs02CQVHwcaVzTVtQd3o8ZfKZQXfrxnO3PxyWWkgQXGXUUcUA+nlvF9Wndz12rf
         fzdKpNL9Ora4ugBR7x9Dbr/WbSHWdN8XqE3UCQuDwH1tPDfVW3JQeRXY3H956G0fkMcb
         wmD9qRqw4t1x/pAV+f1XkPJoMt4kPqOSG+1hWG6n0vmel9gX+MRMqzQEGygTHKUcqcYz
         Tstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qXroraj52ct2YaRmID2JvaLQG+4F2y1h0JVmD2fZ/4k=;
        b=dXWCc+lPIbnJvFmI65NXcd7GIx2MjdFgcYV1T2jhZ+N1rOXcvBb7rTsA3H/aG5AdqB
         omm0v+sAowQdrSHXei731fcR88TFnUT8hX7SpcCx2YciARvki66Y13HxWjDvsFdkzwrs
         Av/gvYI5Mu+JUDREZJdCHaMmlLHdpeKs4z/FmTfLMW4NnX712tCxE35ZaOpqW/Cg6dhb
         M3Y7ur74qJ2KV8kLUV+5B1vAhVYC3GqouaX4f4getdp+vMpqAdy1oHPQ2YcHNB8cVNwJ
         IAghAqgMQ288zvvfvqq6HXt/VEVdmSLnJfvdE0AUdj4mqt+rzkVeOCbMP7j5O5EKJtLa
         zi9w==
X-Gm-Message-State: AOAM533E+jVbxKySxY1XBefCJjZ3E2qM1cwzY0CitIND2xIDMRkKKqbI
        QFMawUvvvt6WxU9yDWOJnxCTDA==
X-Google-Smtp-Source: ABdhPJyvYn/WYWDxi8q3xpx+0waGH80H1phXl3/vFMQj4NgtzG5BOmwvsLfBJ2vdlp5cBybydz3Zyw==
X-Received: by 2002:a37:a4b:: with SMTP id 72mr8374069qkk.725.1639576685853;
        Wed, 15 Dec 2021 05:58:05 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h2sm1049105qkn.136.2021.12.15.05.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 05:58:04 -0800 (PST)
Date:   Wed, 15 Dec 2021 08:58:02 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     kreijack@inwind.it
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode
Message-ID: <Ybn0aq548kQsQu+z@localhost.localdomain>
References: <cover.1635089352.git.kreijack@inwind.it>
 <SYXPR01MB1918689AF49BE6E6E031C8B69E749@SYXPR01MB1918.ausprd01.prod.outlook.com>
 <1d725df7-b435-4acf-4d17-26c2bd171c1a@libero.it>
 <Ybe34gfrxl8O89PZ@localhost.localdomain>
 <YbfN8gXHsZ6KZuil@hungrycats.org>
 <71e523dc-2854-ca9b-9eee-e36b0bd5c2cb@libero.it>
 <Ybj40IuxdaAy75Ue@hungrycats.org>
 <Ybj/0ITsCQTBLkQF@localhost.localdomain>
 <be4e6028-7d1d-6ba9-d16f-f5f38a79866f@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be4e6028-7d1d-6ba9-d16f-f5f38a79866f@libero.it>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 14, 2021 at 09:41:21PM +0100, Goffredo Baroncelli wrote:
> On 12/14/21 21:34, Josef Bacik wrote:
> > On Tue, Dec 14, 2021 at 03:04:32PM -0500, Zygo Blaxell wrote:
> > > On Tue, Dec 14, 2021 at 08:03:45PM +0100, Goffredo Baroncelli wrote:
> 
> > > 
> > > I don't have a strong preference for either sysfs or ioctl, nor am I
> > > opposed to simply implementing both.  I'll let someone who does have
> > > such a preference make their case.
> > 
> > I think echo'ing a name into sysfs is better than bits for sure.  However I want
> > the ability to set the device properties via a btrfs-progs command offline so I
> > can setup the storage and then mount the file system.  I want
> > 
> > 1) The sysfs interface so you can change things on the fly.  This stays
> >     persistent of course, so the way it works is perfect.
> > 
> > 2) The btrfs-progs command sets it on offline devices.  If you point it at a
> >     live mounted fs it can simply use the sysfs thing to do it live.
> 
> #2 is currently not implemented. However I think that we should do.
> 
> The problem is that we need to update both:
> 
> - the superblock		(simple)
> - the dev_item item		(not so simple...)
> 
> What about using only bits from the superblock to store this property ?

I'm looking at the patches and you only are updating the dev_item, am I missing
something for the super block?

For offline all you would need to do is do the normal open_ctree,
btrfs_search_slot to the item and update the device item type, that's
straightforward.

For online if you use btrfs prop you can see if the fs is mounted and just find
the sysfs file to modify and do it that way.

But this also brings up another point, we're going to want a compat bit for
this.  It doesn't make the fs unusable for old kernels, so just a normal
BTRFS_FS_COMPAT_<whatever> flag is fine.  If the setting gets set you set the
compat flag.

You'll also need to modify the tree checker to check the dev item allocation
hints to make sure they're valid, via check_dev_item.  Thanks,

Josef
