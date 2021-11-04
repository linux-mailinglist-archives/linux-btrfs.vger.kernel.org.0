Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3574544594D
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 19:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbhKDSKF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 14:10:05 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43964 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhKDSKC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 14:10:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AACC71FD43;
        Thu,  4 Nov 2021 18:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636049243;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xFoc2fTuGv/EbcXT3yVo3gz6h77/YOmtioILFb3AnQY=;
        b=tFYK/tDkuYOcGfhZohQworAvjf6HlGHL3jwkyZ/6xJtD3B7/bQyShyeXY+72Cp5fgOYJZ4
        I+h0BEJ/IEFCpP1B7WoLpAexICkZjTUrgLE+7MyDu6XBxuBKPVA06TXNnM9X4d1V0KpBBF
        LXR7navS68jGbekZ/fRWYuDmCWnRGIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636049243;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xFoc2fTuGv/EbcXT3yVo3gz6h77/YOmtioILFb3AnQY=;
        b=RE6FdvQqAb3F5xAAjzT3itijTxncH0twtqGiHOt1Xae+Fjz5AOpQcCjFdPypxUhjd5aaKP
        rpVDNP9NW3y2DAAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A119B2C157;
        Thu,  4 Nov 2021 18:07:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EBB65DA781; Thu,  4 Nov 2021 19:06:46 +0100 (CET)
Date:   Thu, 4 Nov 2021 19:06:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@gmail.com>
Subject: Re: [PATCH v3] btrfs: fix a check-integrity warning on write caching
 disabled disk
Message-ID: <20211104180646.GC28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@gmail.com>
References: <20211103080721.23DC.409509F4@e16-tech.com>
 <20211104150212.GZ20319@twin.jikos.cz>
 <20211104233458.1670.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104233458.1670.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 04, 2021 at 11:34:59PM +0800, Wang Yugui wrote:
> > On Wed, Nov 03, 2021 at 08:07:22AM +0800, Wang Yugui wrote:
> > > > On Thu, Oct 28, 2021 at 06:32:54AM +0800, Wang Yugui wrote:
> > > > > When a disk has write caching disabled, we skip submission of a bio
> > > > > with flush and sync requests before writing the superblock, since
> > > > > it's not needed. However when the integrity checker is enabled,
> > > > > this results in reports that there are metadata blocks referred
> > > > > by a superblock that were not properly flushed. So don't skip the
> > > > > bio submission only when the integrity checker is enabled
> > > > > for the sake of simplicity, since this is a debug tool and
> > > > > not meant for use in non-debug builds.
> > > > > 
> > > > > xfstest/btrfs/220 trigger a check-integrity warning like the following
> > > > > when CONFIG_BTRFS_FS_CHECK_INTEGRITY=y and the disk with WCE=0.
> > > > 
> > > > Does this need the integrity checker to be also enabled by mount
> > > > options? I don't think compile time (ie the #ifdef) is enough, the
> > > > message is printed only when it's enabled based on check in
> > > > __btrfsic_submit_bio "if (!btrfsic_is_initialized) return", where the
> > > > rest of the function does all the verification.
> > > 
> > > Yes.  We need mount option 'check_int' or 'check_int_data' to  trigger
> > > this check-integrity warning.
> > 
> > So the mount options need to be checked here as well.
> 
> We just need to add the mount option(check_int/check_int_data) to
> changelog
> 
> when CONFIG_BTRFS_FS_CHECK_INTEGRITY=y and the disk with WCE=0.
> =>
> when CONFIG_BTRFS_FS_CHECK_INTEGRITY=y , and mount
> option(check_int/check_int_data), and the disk with WCE=0.
> 
> 
> The check of mount option(check_int/check_int_data) is done later
> inside btrfsic_submit_bio. No necessary to check mount
> option(check_int/check_int_data) here, we just need to match
> submit_bio(linux/bio.h).

Ah right, I missed it.
