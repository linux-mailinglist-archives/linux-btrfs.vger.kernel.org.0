Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DAE33C018
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 16:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhCOPgc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 11:36:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:53770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233980AbhCOPg2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 11:36:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4C605AC17;
        Mon, 15 Mar 2021 15:36:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2857CDA6E2; Mon, 15 Mar 2021 16:34:26 +0100 (CET)
Date:   Mon, 15 Mar 2021 16:34:26 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: fix linked list corruption after log root
 tree allocation failure
Message-ID: <20210315153426.GW7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <b4746dac89274ef11314a6abacc58a27c5935a1f.1615475093.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4746dac89274ef11314a6abacc58a27c5935a1f.1615475093.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 11, 2021 at 03:13:30PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When using a zoned filesystem, while syncing the log, if we fail to
> allocate the root node for the log root tree, we are not removing the
> log context we allocated on stack from the list of log contextes of the
> log root tree. This means after the return from btrfs_sync_log() we get
> a corrupted linked list.
> 
> Fix this by allocating the node before adding our stack allocated context
> to the list of log contextes of the log root tree.
> 
> Fixes: 3ddebf27fcd3a9 ("btrfs: zoned: reorder log node allocation on zoned filesystem")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
