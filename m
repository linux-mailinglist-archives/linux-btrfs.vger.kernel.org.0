Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DED4B94AB9
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2019 18:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfHSQq0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Aug 2019 12:46:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:59926 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726553AbfHSQq0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Aug 2019 12:46:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3A324AE96;
        Mon, 19 Aug 2019 16:46:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 243B9DA7DA; Mon, 19 Aug 2019 18:46:51 +0200 (CEST)
Date:   Mon, 19 Aug 2019 18:46:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: replace: BTRFS_DEV_REPLACE_ITEM_STATE_x defines
 should go
Message-ID: <20190819164651.GI24086@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20190808043244.1256-1-anand.jain@oracle.com>
 <20190808043244.1256-2-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808043244.1256-2-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 08, 2019 at 12:32:44PM +0800, Anand Jain wrote:
> The BTRFS_DEV_REPLACE_ITEM_STATE_x defines, as shown in [1], are
> unused in both kernel and btrfs-progs (except for one instance of
> BTRFS_DEV_REPLACE_ITEM_STATE_NEVER_STARTED in kernel).
> 
> [1]
> btrfs.h:#define BTRFS_IOCTL_DEV_REPLACE_STATE_FINISHED        2
> btrfs.h:#define BTRFS_IOCTL_DEV_REPLACE_STATE_CANCELED        3
> btrfs.h:#define BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED       4
> 
> Further these define-values are different form its counterpart
> BTRFS_IOCTL_DEV_REPLACE_STATE_x series as shown in [2].
> 
> [2]
> btrfs_tree.h:#define BTRFS_DEV_REPLACE_ITEM_STATE_SUSPENDED   2
> btrfs_tree.h:#define BTRFS_DEV_REPLACE_ITEM_STATE_FINISHED    3
> btrfs_tree.h:#define BTRFS_DEV_REPLACE_ITEM_STATE_CANCELED    4
> 
> So this patch deletes the BTRFS_DEV_REPLACE_ITEM_STATE_x altogether, and
> one instance of BTRFS_DEV_REPLACE_ITEM_STATE_NEVER_STARTED is replaced
> with BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED in the kernel.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to misc-next, thanks.
