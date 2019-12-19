Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B057126FAC
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2019 22:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfLSVWe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Dec 2019 16:22:34 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41894 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfLSVWe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Dec 2019 16:22:34 -0500
Received: by mail-qk1-f194.google.com with SMTP id x129so5870477qke.8
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2019 13:22:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nKnehGkHfFCFm2zeUUaUpvnHt/0WPHaKvO5CVb+OFBs=;
        b=enkqG1cNepvJ4XOsqexk4Qj+FEU9HKspRPDUMzZNd3azx0UzxZIgSLaJEH3R0XjbLJ
         IOdEgZzto7sWZm2APBwZJ7mRbveNDlEtSNjtjWoRkCXNCNDZhblWaQsSpfvDYbsSmuzA
         BdyRM/jlQrrp68HCh7AFaeDr8BuuDjK2+lkALfbfyzpt4eYYNq6Njs3F6NUfNG5Tk2e/
         gTUUdILEZ2PmSnUfrUEKw9m2UrwpzkMwsRQ3vSC+91LMEDxEA41nX4rAuMyv6E7k5toq
         4RI+MGd14LDhC+vrF7kjV6QfgKq8gcyIE5lWgZ793s6Uel3TVyEtusTGkpMK7sI6R7DW
         trdQ==
X-Gm-Message-State: APjAAAV+tdn/5+la8xCf1aA6BpQip+cYhTtuoNH/q93JBFZ++pTgvZNA
        /BZeefLJY6Tk5NJfIVz30cg=
X-Google-Smtp-Source: APXvYqxAqvN2URs5OPXYsCQDFepttf9NijJTBeb4iKlg7ewR1kzbe+GvFAewkbuBqsaZvuZDkwarmw==
X-Received: by 2002:ae9:ebd4:: with SMTP id b203mr10293027qkg.501.1576790552972;
        Thu, 19 Dec 2019 13:22:32 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:480::7ea5])
        by smtp.gmail.com with ESMTPSA id b191sm2159553qkg.43.2019.12.19.13.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 13:22:32 -0800 (PST)
Date:   Thu, 19 Dec 2019 15:22:28 -0600
From:   Dennis Zhou <dennis@kernel.org>
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 00/22] btrfs: async discard support
Message-ID: <20191219212228.GB38803@dennisz-mbp.dhcp.thefacebook.com>
References: <cover.1576195673.git.dennis@kernel.org>
 <20191217145541.GE3929@suse.cz>
 <20191218000600.GB2823@dennisz-mbp>
 <20191219020337.GA25072@dennisz-mbp.dhcp.thefacebook.com>
 <20191219200607.GQ3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219200607.GQ3929@twin.jikos.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 19, 2019 at 09:06:07PM +0100, David Sterba wrote:
> On Wed, Dec 18, 2019 at 08:03:37PM -0600, Dennis Zhou wrote:
> > > > This happened also when I deleted everything from the filesystem and ran
> > > > full balance.
> > 
> > Also were these both on fresh file systems so it seems reproducible for
> > you?
> 
> Yes the filesystem was freshly created before the test.
> 
> No luck reproducing it, I tried to repeat the steps as before but the
> timing must make a difference and the numbers always ended up as 0
> (bytes) 0 (extents).
> 
> > > I'll report back if I continue having trouble reproing it.
> > 
> > I spent the day trying to repro against ext/dzhou-async-discard-v6
> > without any luck... I've been running the following:
> > 
> > $ mkfs.btrfs -f /dev/nvme0n1
> > $ mount -t btrfs -o discard=async /dev/nvme0n1 mnt
> > $ cd mnt
> > $ bash ../age_btrfs.sh .
> > 
> > where age_btrfs.sh is from [1].
> > 
> > If I delete arbitrary subvolumes, sync, and then run balance:
> > $ btrfs balance start --full-balance .
> > It all seems to resolve to 0 after some time. I haven't seen a negative
> > case on either of my 2 boxes. I've also tried unmounting and then
> > remounting, deleting and removing more free space items.
> > 
> > I'm still considering how this can happen. Possibly bad load of free
> > space cache and then freeing of the block group? Because being off by
> > just 1 and it not accumulating seems to be a real corner case here.
> > 
> > Adding asserts in btrfs_discard_update_discardable() might give us
> > insight to which callsite is responsible for going below 0.
> 
> Yeah more asserts would be good.

I'll add a few assert patches and some code to ensure that life can
still move on properly if we do hit the -1 case. I think it probably has
something to do with free space cache removal as it can't be a simple
corner case, otherwise we'd see the -1 accumulating much more easily.
What does puzzle me is it's a single nodesize that I'm off by and not
some other random number.

Thanks,
Dennis
