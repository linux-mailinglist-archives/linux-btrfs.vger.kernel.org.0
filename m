Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8709821D2D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 11:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgGMJdA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 05:33:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:49658 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbgGMJdA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 05:33:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22FF4AC1D;
        Mon, 13 Jul 2020 09:33:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D0629DA809; Mon, 13 Jul 2020 11:32:37 +0200 (CEST)
Date:   Mon, 13 Jul 2020 11:32:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Ken D'Ambrosio <ken@jots.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Btrfs default on Fedora?
Message-ID: <20200713093237.GD3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ken D'Ambrosio <ken@jots.org>,
        linux-btrfs@vger.kernel.org
References: <933824829995390cef16f757cab1ddbc@jots.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <933824829995390cef16f757cab1ddbc@jots.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 11, 2020 at 02:38:26PM -0400, Ken D'Ambrosio wrote:
> Hi!  I just saw this mentioned on a BBS I'm on:
> https://fedoraproject.org/wiki/Changes/BtrfsByDefault
> 
> I'll admit, I'm incredibly surprised, and pleased, to see that this 
> might happen.  I do have three items of concern as Joe End User.  (Do 
> note that for home use (where I use btrfs) I'm usually on Ubuntu or a 
> variant and not RH, if that matters.)
> 
> * Swap files.  At least last time I checked, it was a PITA to take a 
> snapshot of a volume that had a swapfile on it -- I wound up writing a 
> wrapper that goes, does a swapoff, removes the file, creates the 
> snapshot, and then re-creates the file.   Is this still "a thing"?  Or 
> is there a way to work around that that isn't kludgey?

The workaround is to use separate subvolume for swapfile. Anything else
would cause only problems. Imagine you have a swapfile on root
partition, take frequent snapshots. As the swapfile contents change
during system use, the shared blocks get unshared and occupy more space.
In the end, each rootfs snapshot could have it's own swapfile with
useless data.

Requiring the separate subvolume was a compromise, it's not ideal but
IMHO at least makes things clear. Deleting a swapfile will release the
blocks, there's only one instance of the swapfile (for swapon/swapoff).
