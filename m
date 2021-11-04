Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BA2445343
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 13:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhKDMsy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 08:48:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48146 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhKDMsx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 08:48:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3F9501FD35;
        Thu,  4 Nov 2021 12:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636029975;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jjdyj2vo1bdbAUmr0Fzq4N1Tq82Yi2KTqB9XfaQTP+4=;
        b=WLrkjtPdHaT1XwBrmOvDIGWYO4zzvziC2h/gsZjyu/C13RdbJC2tnq1EKltVoN6IX9JbSS
        NpKSPdp0PreaC/R6E+ATYLWwRXUppsr4jzCO9Wyo0f3bYu5CRVAipB5RF20y/xCcwd0nIn
        Os71WU/r1ItFhlSF0p5PJD+tj9oCJRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636029975;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jjdyj2vo1bdbAUmr0Fzq4N1Tq82Yi2KTqB9XfaQTP+4=;
        b=qNrzy17D5UrVfNfytNAfOeAZwbPu7xXwq1a2aJt3GpNc3gJneKY/DPZsMP8dJRfjiFoPKA
        2yXYOciLb/J9i2Ag==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 383E72C157;
        Thu,  4 Nov 2021 12:46:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E0388DA7A9; Thu,  4 Nov 2021 13:45:38 +0100 (CET)
Date:   Thu, 4 Nov 2021 13:45:38 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: Make "btrfs filesystem df" command to
 show upper case profile
Message-ID: <20211104124538.GV20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211104015807.35774-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104015807.35774-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 04, 2021 at 09:58:07AM +0800, Qu Wenruo wrote:
> @@ -120,7 +126,8 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
>  		.devs_increment	= 1,
>  		.ncopies	= 1,
>  		.nparity        = 0,
> -		.raid_name	= "single",
> +		.lower_name	= "single",
> +		.upper_name	= "SINGLE",

This would print SINGLE in upper case in 'fi df':

Data, SINGLE: total=745.00GiB, used=456.22GiB
System, SINGLE: total=32.00MiB, used=112.00KiB
Metadata, SINGLE: total=23.00GiB, used=5.50GiB
GlobalReserve, SINGLE: total=512.00MiB, used=0.00B

I think we should keep the output same as before.
