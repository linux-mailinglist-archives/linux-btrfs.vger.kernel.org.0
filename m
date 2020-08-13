Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43260243C30
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Aug 2020 17:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgHMPH5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 11:07:57 -0400
Received: from magic.merlins.org ([209.81.13.136]:45374 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgHMPH4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 11:07:56 -0400
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1k6Epb-0008AM-5p by authid <merlin>; Thu, 13 Aug 2020 08:07:51 -0700
Date:   Thu, 13 Aug 2020 08:07:51 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: 5.6 pretty massive unexplained btrfs corruption:  parent transid
 verify failed + open_ctree failed
Message-ID: <20200813150747.GF8863@merlins.org>
References: <20200707035530.GP30660@merlins.org>
 <20200708034407.GE10769@hungrycats.org>
 <20200812223433.GA533@merlins.org>
 <20200813123946.5841d146@natsu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813123946.5841d146@natsu>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 13, 2020 at 12:39:46PM +0500, Roman Mamedov wrote:
> Or should have been. If it's a copy-paste from a shell script (unless you do
> the whole process manually every time), it doesn't appear like you check the
> success status of each line before continuing to the next. Either add
> "|| exit 1" to each of these that can fail, or just use "#!/bin/bash -e" in
> the script's first line.
 
Sorry, yeah, it's a partial copy paste of a script, but the script has 
set -e
so if any command fails, the script stops.

> As is, imagine umount fails ("target busy"), then dmsetup fails ("device in
> use"), then mdadm fails to stop the array, but then you cut power to the
> entire thing anyways.

Correct, and set -e makes sure that does not happen.

I have been using this script for years, and it's been fine, but if the
drives have broken write caching and can fail to write data for more
than 5 seconds, then my script will have cut the power on them before
data was committed.
It feels far reaching a conclusion, but given that we already know that
I did get said corruption and I'm pretty darn confident that it happened
after the last time I shut down the array that way, it means that Zygo
is very likely right on the write caching problem.

Which also also why I'd like to check if I need to turn it off on any on
my other drives, since indeed I often bought cheaper versions of drives,
which maybe had firmware bugs.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
