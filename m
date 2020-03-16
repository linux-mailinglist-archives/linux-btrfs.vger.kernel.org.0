Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAD71870CD
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Mar 2020 18:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732208AbgCPRCC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Mar 2020 13:02:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:45280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732201AbgCPRCB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Mar 2020 13:02:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D7D66B3B2;
        Mon, 16 Mar 2020 17:02:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 86A31DA726; Mon, 16 Mar 2020 18:01:33 +0100 (CET)
Date:   Mon, 16 Mar 2020 18:01:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] Removal of BTRFS_SUBVOL_CREATE_ASYNC support
Message-ID: <20200316170133.GT12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200313152320.22723-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313152320.22723-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 13, 2020 at 05:23:17PM +0200, Nikolay Borisov wrote:
> Having deprecated this feature in 5.4 now it's time to actually delete it.
> 
> First patch removes the user-visible support. The other 2 remove unneeded
> arguments and code.
> 
> Nikolay Borisov (3):
>   btrfs: Remove BTRFS_SUBVOL_CREATE_ASYNC support
>   btrfs: Remove transid argument from btrfs_ioctl_snap_create_transid
>   btrfs: Remove async_transid
>     btrfs_mksubvol/create_subvol/create_snapshot

I've merged the patches to misc-next, with the comment added to patch 1
otherwise unchanged (not counting whitespace fixups). The rename
suggested for patch 2 can happen later.
