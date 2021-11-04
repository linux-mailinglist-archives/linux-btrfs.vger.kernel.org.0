Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0CB4455F8
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 16:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhKDPF2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 11:05:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58930 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhKDPF1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 11:05:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F223D212BB;
        Thu,  4 Nov 2021 15:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636038168;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j4CPfYsxRoYGLGW3MP76TM4WLfpPLlDgtt+0zUKZovQ=;
        b=GKM6D6M50xg1yYYcL95LjURTedyjQFglKuyiuMLvM92FS6dzeQuEJrkByQjzp17//0ijZ+
        4Kgdrto4RThw60b9Xchm7zJoFHsTv9uVlgjfWI3oE+EbXZ1pGyRHDB4cdgR32vNkHHZkXz
        dElhCDPR1sAoZS2RpP5boB0s/wHE3Pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636038168;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j4CPfYsxRoYGLGW3MP76TM4WLfpPLlDgtt+0zUKZovQ=;
        b=WMTnAWYdUbGulv2lIuO0tQa2+alIlpG68BJF0R2wsLbd0serGBpFxsUkx5XT/6PqsHvMhh
        XzoYIuxjFdQ/woBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E250C2C144;
        Thu,  4 Nov 2021 15:02:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6137EDA72B; Thu,  4 Nov 2021 16:02:12 +0100 (CET)
Date:   Thu, 4 Nov 2021 16:02:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@gmail.com>
Subject: Re: [PATCH v3] btrfs: fix a check-integrity warning on write caching
 disabled disk
Message-ID: <20211104150212.GZ20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@gmail.com>
References: <20211027223254.8095-1-wangyugui@e16-tech.com>
 <20211102164830.GO20319@twin.jikos.cz>
 <20211103080721.23DC.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103080721.23DC.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 03, 2021 at 08:07:22AM +0800, Wang Yugui wrote:
> Hi,
> 
> > On Thu, Oct 28, 2021 at 06:32:54AM +0800, Wang Yugui wrote:
> > > When a disk has write caching disabled, we skip submission of a bio
> > > with flush and sync requests before writing the superblock, since
> > > it's not needed. However when the integrity checker is enabled,
> > > this results in reports that there are metadata blocks referred
> > > by a superblock that were not properly flushed. So don't skip the
> > > bio submission only when the integrity checker is enabled
> > > for the sake of simplicity, since this is a debug tool and
> > > not meant for use in non-debug builds.
> > > 
> > > xfstest/btrfs/220 trigger a check-integrity warning like the following
> > > when CONFIG_BTRFS_FS_CHECK_INTEGRITY=y and the disk with WCE=0.
> > 
> > Does this need the integrity checker to be also enabled by mount
> > options? I don't think compile time (ie the #ifdef) is enough, the
> > message is printed only when it's enabled based on check in
> > __btrfsic_submit_bio "if (!btrfsic_is_initialized) return", where the
> > rest of the function does all the verification.
> 
> Yes.  We need mount option 'check_int' or 'check_int_data' to  trigger
> this check-integrity warning.

So the mount options need to be checked here as well.
