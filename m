Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07FEC1A27B0
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Apr 2020 19:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgDHRHO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Apr 2020 13:07:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:50996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729558AbgDHRHO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Apr 2020 13:07:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 06662AC19;
        Wed,  8 Apr 2020 17:07:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BC4BFDA730; Wed,  8 Apr 2020 19:06:36 +0200 (CEST)
Date:   Wed, 8 Apr 2020 19:06:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: make full fsyncs always operate on the entire
 file again
Message-ID: <20200408170636.GY5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200407103744.5960-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407103744.5960-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 07, 2020 at 11:37:44AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>

I've put the note about revert at the beginning, fixed the comment
formatting in btrfs_sync_file, and updated the parameters of
copy_inode_items_to_log in btrfs_log_inode so the diff against
0a8068a3dd4294 minimal.

> Fix this by reverting commit 0a8068a3dd4294 ("btrfs: make ranged full fsyncs
> more efficient") since there is no easy way to work around it.

Oh well, you tried and that's appreciated, but the fsync matters are
undoubtedly complicated. Patch added to misc-next and will go to
upcoming rc, thanks.
