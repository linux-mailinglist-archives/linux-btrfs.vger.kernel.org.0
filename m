Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E563B2442F6
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 04:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHNCTO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 22:19:14 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36586 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgHNCTO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 22:19:14 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 1659D7B246D; Thu, 13 Aug 2020 22:19:13 -0400 (EDT)
Date:   Thu, 13 Aug 2020 22:19:12 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Marc MERLIN <marc@merlins.org>
Cc:     Roman Mamedov <rm@romanrm.net>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: 5.6 pretty massive unexplained btrfs corruption:  parent transid
 verify failed + open_ctree failed
Message-ID: <20200814021912.GR5890@hungrycats.org>
References: <20200707035530.GP30660@merlins.org>
 <20200708034407.GE10769@hungrycats.org>
 <20200812223433.GA533@merlins.org>
 <20200813123946.5841d146@natsu>
 <20200813150747.GF8863@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813150747.GF8863@merlins.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 13, 2020 at 08:07:51AM -0700, Marc MERLIN wrote:
> On Thu, Aug 13, 2020 at 12:39:46PM +0500, Roman Mamedov wrote:
> > Or should have been. If it's a copy-paste from a shell script (unless you do
> > the whole process manually every time), it doesn't appear like you check the
> > success status of each line before continuing to the next. Either add
> > "|| exit 1" to each of these that can fail, or just use "#!/bin/bash -e" in
> > the script's first line.
>  
> Sorry, yeah, it's a partial copy paste of a script, but the script has 
> set -e
> so if any command fails, the script stops.
> 
> > As is, imagine umount fails ("target busy"), then dmsetup fails ("device in
> > use"), then mdadm fails to stop the array, but then you cut power to the
> > entire thing anyways.
> 
> Correct, and set -e makes sure that does not happen.
> 
> I have been using this script for years, and it's been fine, but if the
> drives have broken write caching and can fail to write data for more
> than 5 seconds, then my script will have cut the power on them before
> data was committed.
> It feels far reaching a conclusion, but given that we already know that
> I did get said corruption and I'm pretty darn confident that it happened
> after the last time I shut down the array that way, it means that Zygo
> is very likely right on the write caching problem.
> 
> Which also also why I'd like to check if I need to turn it off on any on
> my other drives, since indeed I often bought cheaper versions of drives,
> which maybe had firmware bugs.

It would be nice if price correlated to firmware quality, but that's
not how disk vendors make drives.  There's a firmware team that produces
firmware for a disk controller SoC family.  It's a lot of expensive work,
so it only happens once unless a major defect is found.  That firmware
ends up in all the drive models built around that SoC family.  So you
end up with White Label, WD Green, and WD Red drive models that all
run the same handful of firmware builds even though there are dozens of
distinct model numbers sold to different market segments (i.e. prices)
over a period of many years.

WD didn't think it was important to avoid SMR in NAS drives--a
requirement that was so obvious that customers ultimately sued them
over it.  WD certainly wouldn't think it was important for their NAS
drives to have more correct firmware than the low-end discount model,
and nobody sued them over it, so they all got shipped with the same bugs.

> Marc
> -- 
> "A mouse is a device used to point at the xterm you want to type in" - A.S.R.
>  
> Home page: http://marc.merlins.org/  
