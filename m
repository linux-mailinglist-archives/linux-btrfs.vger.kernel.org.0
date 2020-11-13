Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE022B1E79
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 16:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgKMPVd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 10:21:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:52838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbgKMPVb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 10:21:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D2F66AC91;
        Fri, 13 Nov 2020 15:21:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EC2B8DA87A; Fri, 13 Nov 2020 16:19:46 +0100 (CET)
Date:   Fri, 13 Nov 2020 16:19:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] fstests: btrfs: check qgroup doesn't crash when beyond
 limit
Message-ID: <20201113151946.GY6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
References: <20201111113152.136729-1-wqu@suse.com>
 <CAL3q7H5W6U4jYGBszQF59RLi-aehO9vBTNU_HMTi8hRfK7gjGg@mail.gmail.com>
 <d5cabe8e-37cb-42b7-9bd4-ba7ddca68b20@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5cabe8e-37cb-42b7-9bd4-ba7ddca68b20@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 12, 2020 at 07:50:22AM +0800, Qu Wenruo wrote:
> >> +$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
> >> +$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
> >> +
> >> +# Set the limit to just 512MiB, which is way below the existing usage
> >> +$BTRFS_UTIL_PROG qgroup limit  512M $SCRATCH_MNT $SCRATCH_MNT
> > 
> > $SCRATCH_MNT twice by mistake, though the command still works and the
> > test still reproduces the issue.
> 
> Nope, that's the expected behavior.
> 
> Btrfs qgroup limit <size> <path>|<qgroupid> <path>
> 
> The first path is to determine qgroupid, while the last path is to
> determine the fs.
> 
> In this particular case, since we're limit the 0/5 qgroup, it's also the
> as the mount point, thus we specific it twice.

So why didn't you specify 0/5 so it's clear?
