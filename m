Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E803486675
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 16:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240348AbiAFPEG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 10:04:06 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41790 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240267AbiAFPEG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 10:04:06 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 286F11F37F;
        Thu,  6 Jan 2022 15:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641481445;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EMHhEN0Af1Rx3x4kjEMdTOm9guGCU59HVBplTL5XA3A=;
        b=arjsincYRrIK57WdUO909nv+M5xjwwXlgTV03nXWAg/SXWJH1KZtGJUwQ6spsSPJS9aFuv
        P/89UE0mTe4AYyNws4MD90hUwZi/JlX8gEVDN26medHOn3D8ab5fDPRkfhgF4l03nqL6Nd
        q3MeWafx6bs3E+SbRHA37yw8TrbHYqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641481445;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EMHhEN0Af1Rx3x4kjEMdTOm9guGCU59HVBplTL5XA3A=;
        b=u5eeLiFAFpC2Kk/wh0XFz3/Di5wYk99LIVJA0DplcFIGKsbNUh8ckPlxL1RnBqnlhoOKmz
        TRMvMH+Jbhw4i0Ag==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 218C8A3B81;
        Thu,  6 Jan 2022 15:04:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8D1A5DA799; Thu,  6 Jan 2022 16:03:34 +0100 (CET)
Date:   Thu, 6 Jan 2022 16:03:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Sahil Kang <sahil.kang@asilaycomputing.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/1] btrfs: reuse existing pointers from btrfs_ioctl
Message-ID: <20220106150334.GD14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Sahil Kang <sahil.kang@asilaycomputing.com>,
        linux-btrfs@vger.kernel.org
References: <20220105083006.2793559-1-sahil.kang@asilaycomputing.com>
 <20220105083006.2793559-2-sahil.kang@asilaycomputing.com>
 <486dd0a1-60a5-1554-26fb-69e1789a5dd4@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <486dd0a1-60a5-1554-26fb-69e1789a5dd4@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 05, 2022 at 05:53:20PM +0800, Qu Wenruo wrote:
> One suspicious ioctls, they should require write permission, but don't:
> 
> - btrfs_ioctl_start_sync()
>    If there is no running trans, it would bail out without doing
>    anything, but I'm wondering if we should call mnt_want_write_file().
> 
>    As this means, if we mount a subvolume read-only, but the fs still has
>    some part mounted RW, we can start a sync using the read-only mounted
>    part.

We can possibly do the mnt_want_write but it should not propagate the
errors, because calling sync on a fully read-only filesystem should not
error out.
