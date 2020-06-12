Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E98B1F7CC5
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 20:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgFLSQr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 14:16:47 -0400
Received: from magic.merlins.org ([209.81.13.136]:46466 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLSQr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 14:16:47 -0400
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:39352 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92 #3)
        id 1jjoEQ-0003F8-Gm by authid <merlins.org> with srv_auth_plain; Fri, 12 Jun 2020 11:16:46 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1jjoEQ-0004dE-6G; Fri, 12 Jun 2020 11:16:46 -0700
Date:   Fri, 12 Jun 2020 11:16:46 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: Is SATA ALPM safe with btrfs now (no more corruption)?
Message-ID: <20200612181646.GB1128@merlins.org>
References: <20200529042615.GA32752@merlins.org>
 <20200601173925.GB18421@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601173925.GB18421@twin.jikos.cz>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 01, 2020 at 07:39:25PM +0200, David Sterba wrote:
> On Thu, May 28, 2020 at 09:26:15PM -0700, Marc MERLIN wrote:
> > TLP allows SATA power management: SATA_LINKPWR_ON_BAT=max_performance
> > 
> > There are some old posts that talk about corruption if you enable this
> > with btrfs:
> > https://wiki.archlinux.org/index.php/TLP#Btrfs
> > says not to enable it
> > 
> > https://forum.manjaro.org/t/btrfs-corruption-with-tlp/25158
> > 
> > https://github.com/linrunner/TLP/issues/128
> > says it may not be safe
> > 
> > https://www.reddit.com/r/archlinux/comments/5tm5uh/btrfs_and_tlp/
> > also talks about corruption
> > 
> > https://www.reddit.com/r/archlinux/comments/4f5xvh/saving_power_is_the_btrfs_dataloss_warning_still/
> > say it's probably ok
> > 
> > My feeling is that it's probably ok nowadays with a 5.6+ kernel.
> > 
> > Would anyone disagree?
> 
> I don't and reading the posts, it's a hardware problem leading to
> filesystem corruption. It's affecting all filesystem but the detection
> capabilities differ, so it stuck with btrfs.
> 
> At least the Arch wiki note can be removed, I don't see any value
> keeping it there, the fixes to ATA subsystem have been merged to 4.15.

Sorry, it looks like I never replied to you. Thanks for confirming my
guess.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
