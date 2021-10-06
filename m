Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFCC4246A6
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 21:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239176AbhJFT0G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 15:26:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60794 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbhJFT0F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Oct 2021 15:26:05 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F3D491FEF9;
        Wed,  6 Oct 2021 19:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633548252;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qEqw+KyMO/J9LysDUj0/kUJoBcSbtpzeOS6grNQ9loM=;
        b=hSVIXvIvdr+D7SqN/HO6GhnaDwF+K71XgwSwU3wMYmnpHOWQDLv2EGcxgFxyaatDXK2P6D
        lgmbmg+eYcMAK00TqQq/qt6UYz5N9amgB0TRF7Ekk/MRg+U1DHBRNy0LD27baG0iDn1n+O
        Jbif3klFYx9krwvdiH0gG9gNzICr1xk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633548252;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qEqw+KyMO/J9LysDUj0/kUJoBcSbtpzeOS6grNQ9loM=;
        b=EFsYSFEfVRxDMcKi9bLwKzvESzGU5S4+8yimaHHpTFhzJAukn3SGn/3UQTd6V6yzNcXewg
        ns0NrLzdmjqDqBCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E2542A3B81;
        Wed,  6 Oct 2021 19:24:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 88BE3DA7F3; Wed,  6 Oct 2021 21:23:51 +0200 (CEST)
Date:   Wed, 6 Oct 2021 21:23:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4 0/5] Miscellaneous error handling patches
Message-ID: <20211006192351.GW9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1633465964.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1633465964.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 05, 2021 at 04:35:22PM -0400, Josef Bacik wrote:
> v3->v4:
> - Added another abort() call that I missed in btrfs_recover_log_trees.
> - Updated the commit message for 'btrfs: change error handling for
>   btrfs_delete_*_in_log' as it pre-dated me figuring out there was a corruption
>   problem in sync log.
> - Fixed commit message for 'btrfs: add a BTRFS_FS_ERROR helper'.
> - Made it so 'btrfs: do not infinite loop in data reclaim if we aborted'
>   actually compiled, I guess my compile after rebase git hook didn't quite work
>   as expected.
> - Updated the comment in 'btrfs: fix abort logic in btrfs_replace_file_extents'.
> - Rebased onto misc-next.
> 
> --- Original email ---
> Hello,
> 
> This series is left overs from a few different series.  The error handling
> patches look like they just got missed somehow.  The FS_ERROR helper has been
> updated based on the comments from Dave.  I'm attaching this to the open GH
> thing that I was looking at to update, but really just has the FS_ERROR helper
> patch from that series.  Thanks,
> 
> Josef
> 
> Josef Bacik (5):
>   btrfs: change handle_fs_error in recover_log_trees to aborts
>   btrfs: change error handling for btrfs_delete_*_in_log
>   btrfs: add a BTRFS_FS_ERROR helper
>   btrfs: do not infinite loop in data reclaim if we aborted
>   btrfs: fix abort logic in btrfs_replace_file_extents

Added to misc-next, thanks.
