Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74AB01F53BA
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 13:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgFJLoy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 07:44:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:59438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728584AbgFJLox (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 07:44:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 66973AE63;
        Wed, 10 Jun 2020 11:44:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8FD81DA6FD; Wed, 10 Jun 2020 13:44:45 +0200 (CEST)
Date:   Wed, 10 Jun 2020 13:44:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/46] btrfs: Make __btrfs_drop_extents take btrfs_inode
Message-ID: <20200610114445.GI27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200603055546.3889-1-nborisov@suse.com>
 <20200603055546.3889-9-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603055546.3889-9-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 03, 2020 at 08:55:08AM +0300, Nikolay Borisov wrote:
> It has only 4 uses of a vfs_inode for inode_sub_bytes but unifies
> the interface with the non  __ prefixed version. Will also makes
> converting its callers to btrfs_inode easier.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/ctree.h    |  2 +-
>  fs/btrfs/file.c     | 23 ++++++++++++-----------
>  fs/btrfs/inode.c    |  4 ++--
>  fs/btrfs/tree-log.c |  4 ++--

Weird, I got conflict while patching a function log_one_extent that's in
tree-log.c but there's no hunk for that file in your patch.
