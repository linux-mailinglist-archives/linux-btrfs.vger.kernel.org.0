Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFED2F21E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 22:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbhAKVhy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 16:37:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:56246 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbhAKVhy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 16:37:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6929EAB7F;
        Mon, 11 Jan 2021 21:37:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 75C5ADA701; Mon, 11 Jan 2021 22:35:21 +0100 (CET)
Date:   Mon, 11 Jan 2021 22:35:21 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: send, remove stale code when checking for shared
 extents
Message-ID: <20210111213521.GF6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <8e6bcde253b959537168b420ef643424238bcc5a.1610363887.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e6bcde253b959537168b420ef643424238bcc5a.1610363887.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 11, 2021 at 11:42:32AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> After commit 040ee6120cb670 ("Btrfs: send, improve clone range") we do not
> use anymore the data_offset field of struct backref_ctx, as after that we
> do all the necessary checks for the data offset of file extent items at
> clone_range(). Since there are no more users of data_offset from that
> structure, remove it.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
