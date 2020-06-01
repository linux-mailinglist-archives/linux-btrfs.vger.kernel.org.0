Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1981EA878
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 19:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgFARj3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 13:39:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:46126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgFARj3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 13:39:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 55DC1B05D;
        Mon,  1 Jun 2020 17:39:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CA4C8DA79B; Mon,  1 Jun 2020 19:39:25 +0200 (CEST)
Date:   Mon, 1 Jun 2020 19:39:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Is SATA ALPM safe with btrfs now (no more corruption)?
Message-ID: <20200601173925.GB18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Marc MERLIN <marc@merlins.org>,
        linux-btrfs@vger.kernel.org
References: <20200529042615.GA32752@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529042615.GA32752@merlins.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 28, 2020 at 09:26:15PM -0700, Marc MERLIN wrote:
> TLP allows SATA power management: SATA_LINKPWR_ON_BAT=max_performance
> 
> There are some old posts that talk about corruption if you enable this
> with btrfs:
> https://wiki.archlinux.org/index.php/TLP#Btrfs
> says not to enable it
> 
> https://forum.manjaro.org/t/btrfs-corruption-with-tlp/25158
> 
> https://github.com/linrunner/TLP/issues/128
> says it may not be safe
> 
> https://www.reddit.com/r/archlinux/comments/5tm5uh/btrfs_and_tlp/
> also talks about corruption
> 
> https://www.reddit.com/r/archlinux/comments/4f5xvh/saving_power_is_the_btrfs_dataloss_warning_still/
> say it's probably ok
> 
> My feeling is that it's probably ok nowadays with a 5.6+ kernel.
> 
> Would anyone disagree?

I don't and reading the posts, it's a hardware problem leading to
filesystem corruption. It's affecting all filesystem but the detection
capabilities differ, so it stuck with btrfs.

At least the Arch wiki note can be removed, I don't see any value
keeping it there, the fixes to ATA subsystem have been merged to 4.15.
