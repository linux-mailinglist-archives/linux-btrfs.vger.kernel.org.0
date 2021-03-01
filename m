Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D49532836F
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Mar 2021 17:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbhCAQSn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Mar 2021 11:18:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:49036 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237744AbhCAQSK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Mar 2021 11:18:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 363F8AE07;
        Mon,  1 Mar 2021 16:17:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 846E5DA7AA; Mon,  1 Mar 2021 17:15:32 +0100 (CET)
Date:   Mon, 1 Mar 2021 17:15:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 6/6] btrfs: Simplify code flow in
 btrfs_delayed_inode_reserve_metadata
Message-ID: <20210301161532.GV7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210222164047.978768-1-nborisov@suse.com>
 <20210222164047.978768-7-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222164047.978768-7-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 22, 2021 at 06:40:47PM +0200, Nikolay Borisov wrote:
> btrfs_block_rsv_add can return only ENOSPC since it's called with
> NO_FLUSH modifier. This so simplify the logic in
> btrfs_delayed_inode_reserve_metadata to exploit this invariant.

This seems quite fragile, it's not straightforward to see from the
context that the NO_FLUSH code will always return ENOSPC. I followed a
few calls down from btrfs_block_rsv_add and it's well hidden inside
__reserve_bytes. So in case it's an invariant I'd rather add an
assertion, ie. ASSERT(ret == 0 || ret == -ENOSPC) so at least we know
when this gets broken. Otherwise looks ok.
