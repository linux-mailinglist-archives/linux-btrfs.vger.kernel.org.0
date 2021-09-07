Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931C2402854
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 14:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhIGMS2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 08:18:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60442 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343867AbhIGMS1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 08:18:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E4C991FF7B;
        Tue,  7 Sep 2021 12:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631017040;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2whB5Pj271r2MhuaRQ0dL6hzhwmnxGPZjs0mY4UqRmE=;
        b=bOMIUWDS7ZokxPk3em80y04nprusy5/k7Y1iko62nGkkKECC8xJQTvzD9iwB1vJbz39YT/
        Q61icinz5L1qZkknQ3hnPpF5ZYBHwZ5UikxKgcFLvsU58OVYJY245YGDd68FtZ1uyVPw8p
        u3quiwzFynFTVCDhv0rHpDKqydzAyLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631017040;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2whB5Pj271r2MhuaRQ0dL6hzhwmnxGPZjs0mY4UqRmE=;
        b=ZO0gx9MVE+2ciXG2pQAlX48ZFiotwFnGRTwUnfrg2XjQAG1ikVARbC6ib3d4huEMBFCgPk
        Q1L1ksriTGhmbICg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DA6F5A3B89;
        Tue,  7 Sep 2021 12:17:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D7F54DA7E1; Tue,  7 Sep 2021 14:17:16 +0200 (CEST)
Date:   Tue, 7 Sep 2021 14:17:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs-progs: error messages enhancement for bad
 tree blocks
Message-ID: <20210907121716.GM3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210904013131.148061-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210904013131.148061-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 04, 2021 at 09:31:28AM +0800, Qu Wenruo wrote:
> When handling a corrupted btrfs image, there are tons of meaningless
> error messages from btrfs-check:
> 
>   incorrect offsets 8492 3707786077
> 
> Above error message is meaningless, it doesn't contain which tree block
> is causing the problem, just some random expected values with corrupted
> values.
> 
> On the other hand, btrfs kernel tree-checker has way better error
> messages, and even more checks than the counterpart in btrfs-progs.
> 
> So let's just backport the superior tree-checker code to btrfs-progs,
> with some btrfs-progs specific (but minor) modifications.
> 
> Now the error message would look more sane (although a little too long):
> 
>   corrupt leaf: root=2 block=72164753408 slot=109, unexpected item end, have 3707786077 expect 8492
> 
> Changelog:
> v2:
> - Fix an uninitialized pointer which leads to fsck test failure
> 
> Qu Wenruo (3):
>   btrfs-progs: use btrfs_key for btrfs_check_node() and
>     btrfs_check_leaf()
>   btrfs-progs: backport btrfs_check_leaf() from kernel
>   btrfs-progs: backport btrfs_check_node() from kernel

Added to devel, thanks.
