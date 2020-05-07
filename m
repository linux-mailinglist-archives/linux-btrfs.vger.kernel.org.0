Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30F01C9CAC
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 22:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgEGUv7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 16:51:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:38380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbgEGUv6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 16:51:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C5B5DB13D;
        Thu,  7 May 2020 20:52:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5DE41DA732; Thu,  7 May 2020 22:51:10 +0200 (CEST)
Date:   Thu, 7 May 2020 22:51:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: Mark qgroup inconsistent if we're
 inherting snapshot to a new qgroup
Message-ID: <20200507205110.GM18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200402063735.32808-1-wqu@suse.com>
 <288d0020-380f-717e-ab05-3fe6dbc64cd5@suse.com>
 <20200506150448.GH18421@twin.jikos.cz>
 <c3c68cb4-4d7e-33ae-54fd-b4202148689a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3c68cb4-4d7e-33ae-54fd-b4202148689a@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 07, 2020 at 06:48:24AM +0800, Qu Wenruo wrote:
> >>> @@ -2809,6 +2821,8 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
> >>>  out:
> >>>  	if (!committing)
> >>>  		mutex_unlock(&fs_info->qgroup_ioctl_lock);
> >>> +	if (need_rescan)
> >>> +		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> > 
> > This got me curious, a non-atomic change to qgroup_flags and without
> > any protection. The function is not running in a safe context (like
> > quota enable or disable) so lack of synchronization seems suspicious. I
> > grepped for other changes to the qgroup_flags and it's very
> > inconsistent. Sometimes it's the fs_info::qgroup_lock, no lokcing at all
> > or no obvious lock but likely fs_info::qgroup_ioctl_lock or
> > qgroup_rescan_lock.
> > 
> > I was considering using atomic bit updates but that would be another
> > patch.
> > 
> Isn't the context safe because we're at the commit transaction critical
> section?

I don't see why, the qgroup_flags could be changed from ioctls, eg.
adding a group relation and other places. Without protection the update
can race and some of the changes lost.
