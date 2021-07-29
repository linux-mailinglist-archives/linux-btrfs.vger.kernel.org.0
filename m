Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B0E3DAA3B
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jul 2021 19:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhG2RcG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jul 2021 13:32:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45670 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhG2RcG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jul 2021 13:32:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1AB231FD6C;
        Thu, 29 Jul 2021 17:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627579922;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jYkL+YlrI2xyUHjdhpuKhVoOQoRl7ojt0hp9hhXwq94=;
        b=fOnrZkV8972FraJF5y5frOQWekWbwhXCol7gIw5YbJi5ZcWevOZZJ66ilv87upjj9vi+Nb
        JF639KdhSq5ry97xzydjhtCsk20sxWn+eMsP8xbk8WTRNMMBnh+KQclxyGTplUjh4wa0IY
        si4xe4gudcgHkL3CfOda0EX6O6Z6jK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627579922;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jYkL+YlrI2xyUHjdhpuKhVoOQoRl7ojt0hp9hhXwq94=;
        b=PomqcCnLzNWR3bN+CnD4Gyx7xkheH8LR1mH8zZLucsFpN0v7p4ME7vQ5uuK3sHZR7RA0I/
        Mvyd2ru5pgE4odBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 18A8EA3B85;
        Thu, 29 Jul 2021 17:32:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 97818DA882; Thu, 29 Jul 2021 19:29:16 +0200 (CEST)
Date:   Thu, 29 Jul 2021 19:29:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: update comment at log_conflicting_inodes()
Message-ID: <20210729172916.GB5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <26f8585750e2eb8fc1f0bbaf975681277e93a1a8.1627568981.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26f8585750e2eb8fc1f0bbaf975681277e93a1a8.1627568981.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 29, 2021 at 03:30:21PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A comment at log_conflicting_inodes() mentions that we check the inode's
> logged_trans field instead of using btrfs_inode_in_log() because the field
> last_log_commit is not updated when we log that an inode exists and the
> inode has the full sync flag (BTRFS_INODE_NEEDS_FULL_SYNC) set. The part
> about the full sync flag is not true anymore since commit 9acc8103ab594f
> ("btrfs: fix unpersisted i_size on fsync after expanding truncate"), so
> update the comment to not mention that part anymore.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
