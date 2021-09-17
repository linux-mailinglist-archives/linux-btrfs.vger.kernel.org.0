Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6CF40F631
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Sep 2021 12:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343855AbhIQKsG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Sep 2021 06:48:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52938 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343913AbhIQKsA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Sep 2021 06:48:00 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 846D81FE6D;
        Fri, 17 Sep 2021 10:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631875597;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WzZWzgwb/IK5VO7WjaTIC2V6HDQJVHmU6uBSh+C0z1o=;
        b=cIbTWSirDrZPXVpIylRjUBZrX3qUludQMybyOLgToqP7fP/LjGcGdodhQSSuh8KTVrZHci
        bmB+6LIXppW5y4p+yLKicTn7pAoaRx2IqFkN0cXCv4C9G0YlQwbD0TGeT12uJrrqJ0Izhk
        AYNL0y7a4za9w7rcT2eDaAzKbkQypcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631875597;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WzZWzgwb/IK5VO7WjaTIC2V6HDQJVHmU6uBSh+C0z1o=;
        b=Qjh9lDo3cSLdmJo6GdFQvTzoqx5nQ8EiuA7Iu5zF0Ne+1OCzml9GoDhAua7T3MoB3jRQ/B
        N8ewo974mN5zxoBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7E525A3B93;
        Fri, 17 Sep 2021 10:46:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B25C1DA781; Fri, 17 Sep 2021 12:46:27 +0200 (CEST)
Date:   Fri, 17 Sep 2021 12:46:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs: rework directory logging to make it more
 efficient
Message-ID: <20210917104627.GK9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1631787796.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1631787796.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 16, 2021 at 11:32:09AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> 
> This patchset changes directory logging to make it more efficient, by doing
> bulk inserts of directory items and avoiding tree searches on a item by item
> basis when they can be avoided. These decrease the amount of time we spend
> logging directory items and reduces lock contention on a log tree in case
> there are other tasks logging other inodes. The last patch mentions test
> results in its changelog, and the first 3 patches are just cleanups and
> preparatory work. This is also ground work for future changes to directory
> logging, but since these are already big enough, I'm sending these separately
> to get into integration/linux-next sooner rather than later.
> 
> 
> Filipe Manana (5):
>   btrfs: remove root argument from btrfs_log_inode() and its callees
>   btrfs: remove redundant log root assignment from log_dir_items()
>   btrfs: factor out the copying loop of dir items from log_dir_items()
>   btrfs: insert items in batches when logging a directory when possible
>   btrfs: keep track of the last logged keys when logging a directory

Added to misc-next, thanks.
