Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC77F30647A
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 20:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhA0Tx2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 14:53:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:51374 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231704AbhA0TxW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 14:53:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A4841ACF4;
        Wed, 27 Jan 2021 19:52:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3A047DA84C; Wed, 27 Jan 2021 20:50:53 +0100 (CET)
Date:   Wed, 27 Jan 2021 20:50:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove wrong comment for can_nocow_extent()
Message-ID: <20210127195053.GE1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <9017cffd318c09a5e6248ca904903938c691b450.1611759896.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9017cffd318c09a5e6248ca904903938c691b450.1611759896.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 27, 2021 at 03:05:41PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The comment for can_nocow_extent() says that the function will flush
> ordered extents, however that never happens and was never true before the
> comment was added in commit e4ecaf90bc13 ("btrfs: add comments for
> btrfs_check_can_nocow() and can_nocow_extent()"). This is true only for
> the function btrfs_check_can_nocow(), which after that commit was renamed
> to check_can_nocow(). So just remove that part of the comment.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
