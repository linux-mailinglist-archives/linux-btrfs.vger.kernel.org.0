Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970743DAA3D
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jul 2021 19:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhG2RdC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jul 2021 13:33:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58174 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhG2RdB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jul 2021 13:33:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D6F0222290;
        Thu, 29 Jul 2021 17:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627579977;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2b2wtvium4EzBpukBx0KTrLCQzS0W/rNjlIyWX9/Hr8=;
        b=sb5M0JUla5jycVDlR4A7hmtAGEKMdz/mkT8Ea1TC6HJoVthjUSxALkDziHPk0VOTtEMkvt
        jLq2IpHdm2jLE0jsEljxJqyeoe92PgqWNfpSp7RhRHU9Kq/o6ELIyMMc0tGQ83JpsdlKYP
        dRwfW42ACaksOB7bTj7OLL4QppAwt9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627579977;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2b2wtvium4EzBpukBx0KTrLCQzS0W/rNjlIyWX9/Hr8=;
        b=QB5mAwNskabkuvdmIMJZr2TcHtp5HjS/TMUkrexZaTfQTqmF/bQKwCkEIi/fYRtIPPr6z5
        MMSs6MsVRiGkhCDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D3B54A3B83;
        Thu, 29 Jul 2021 17:32:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5E566DA882; Thu, 29 Jul 2021 19:30:12 +0200 (CEST)
Date:   Thu, 29 Jul 2021 19:30:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove no longer needed full sync flag check at
 inode_logged()
Message-ID: <20210729173012.GC5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <be665ad9dd952a442dbb8448539c87d2593e081a.1627568480.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be665ad9dd952a442dbb8448539c87d2593e081a.1627568480.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 29, 2021 at 03:29:01PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Now that we are checking if the inode's logged_trans is 0 to detect the
> possibility of the inode having been evicted and reloaded, the test for
> the full sync flag (BTRFS_INODE_NEEDS_FULL_SYNC) is no longer needed at
> tree-log.c:inode_logged(). Its purpose was to detect the possibility
> of a previous eviction as well, since when an inode is loaded the full
> sync flag is always set on it (and only cleared after the inode is
> logged).
> 
> So just remove the check and update the comment. The check for the inode's
> logged_trans being 0 was added recently by the patch with the subject
> "btrfs: eliminate some false positives when checking if inode was logged".
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
