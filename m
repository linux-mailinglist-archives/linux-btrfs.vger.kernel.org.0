Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E9541130B
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 12:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbhITKp0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 06:45:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48792 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbhITKpY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 06:45:24 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 42D0E1FD39;
        Mon, 20 Sep 2021 10:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632134637;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ewt92k+C9rUBp7+sFqRmukWyDGX2v65GgDG9S54zTSY=;
        b=k/ozumAoBBEfUSZ1pHJlnpaoU8eWjB16lS1QcxQHIU/PKOiuS1hKE26KgYUUQdC/CDOY1n
        B+gRUCPqs0vlIm/cj52id7FGR5qDQtrzOhVCL+91S14sQnYr3+M0KVE1cfJ/A1h+2tJTu7
        Ay7Dkp7nwbEMWltTEy5aQdH3be1tbvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632134637;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ewt92k+C9rUBp7+sFqRmukWyDGX2v65GgDG9S54zTSY=;
        b=U/HlIfDL0MbBzq3jA+Z1d64Ld2UD83FNi8/M8j7p1bvm0zmOXha6uyz7BSW9rGC4B48FBQ
        8K+pI2ELo3fSNXCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 39C4EA3B98;
        Mon, 20 Sep 2021 10:43:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C458EDA7FB; Mon, 20 Sep 2021 12:43:45 +0200 (CEST)
Date:   Mon, 20 Sep 2021 12:43:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: only allow certain commands to ignore
 transid errors
Message-ID: <20210920104343.GD9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210908020543.54087-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908020543.54087-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 08, 2021 at 10:05:41AM +0800, Qu Wenruo wrote:
> There is a bug in reddit (well, really the last place I expect to see
> bug reports)

Why? People discuss things where they're used to, reddit is one of them
and from what I've seen there are good questions or usage recommendations.
Some of that goes to documentation or helps to tune usability.

> that btrfstune -u fails due to transid error, but it also
> leaves CHANGING_FSID flag to the super block, prevent btrfs-check to
> properly check the fs.
> 
> The problem is, all commands in btrfs-progs can ignore transid error,
> but there are only very limited usage of such ability.
> 
> Btrfstune definitely should not utilize this feature.
> 
> This patchset will introduce a new open ctree flag to explicitly
> indicate we want to ignore transid errors.
> 
> Currently only there are only 3 tools using this feature:
> 
> - btrfs-check
>   It may fix transid error (at least for the specific test case)
> 
> - btrfs-restore
>   It wants to ignore all errors.
> 
> - btrfs-image
>   To make fsck/002 happy.
> 
> Also add a test case for btrfstune, to make sure btrfstune can rejects
> the fs when an obvious transid mismatch is detected during open_ctree().
> 
> Qu Wenruo (2):
>   btrfs-progs: introduce OPEN_CTREE_ALLOW_TRANSID_MISMATCH flag
>   btrfs-progs: misc-tests: add new test case to make sure btrfstune
>     rejects corrupted fs

Added to devel, thanks.
