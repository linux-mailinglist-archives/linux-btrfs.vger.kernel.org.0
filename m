Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A661629F6BF
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 22:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgJ2VXp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 17:23:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:48048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgJ2VXo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 17:23:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 49615AB5C;
        Thu, 29 Oct 2020 21:04:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0F099DA7CE; Thu, 29 Oct 2020 22:02:42 +0100 (CET)
Date:   Thu, 29 Oct 2020 22:02:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RESEND 0/2] fix verify_one_dev_extent and
 btrfs_find_device
Message-ID: <20201029210242.GX6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1600940809.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1600940809.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 21, 2020 at 12:16:07PM +0800, Anand Jain wrote:
> btrfs_find_device()'s last arg %seed is unused, which the commit
> 343694eee8d8 (btrfs: switch seed device to list api) ignored purposely
> or missed.
> 
> But there isn't any regression due to that. And this series makes
> it official that btrfs_find_device() doesn't need the last arg.
> 
> To achieve that patch 1/2 critically reviews the need for the check
> disk_total_bytes == 0 in the function verify_one_dev_extent() and finds
> that, the condition is never met and so deletes the same. Which also
> drops one of the parents of btrfs_find_device() with the last arg false.
> 
> So only device_list_add() is using btrfs_find_device() with the last arg as
> false, which the patch 2/2 finds is not required as well. So
> this patch drops the last arg in btrfs_find_device() altogether.
> 
> Anand Jain (2):
>   btrfs: drop never met condition of disk_total_bytes == 0
>   btrfs: fix btrfs_find_device unused arg seed

I missed this update because you replied to the original mail and this
threads under the replies and is so easy to miss that it will inevitably
lead to delayed reviews. This is not supposed to be hard, if you have
another iteration, send it as a new mail thread where the 0/N mail has
other patches as replies. You can also use the workflow scripts to
create or update the issue so we'll notice that. Right now there's stale
https://github.com/btrfs/linux/issues/65 that is labeled with comments
so nobody will probably lookd at it again until the next iteration
arrives.
