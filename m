Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC85333DDBB
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 20:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240505AbhCPTnT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 15:43:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:45200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240515AbhCPTnF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 15:43:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A461BAD3B;
        Tue, 16 Mar 2021 19:43:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E8C2FDA6E2; Tue, 16 Mar 2021 20:41:02 +0100 (CET)
Date:   Tue, 16 Mar 2021 20:41:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: update outdated comment at btrfs_orphan_cleanup()
Message-ID: <20210316194102.GL7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <deaf0ddafcd9327079b0af3130d398e8ec421e5a.1615912483.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deaf0ddafcd9327079b0af3130d398e8ec421e5a.1615912483.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 16, 2021 at 04:54:13PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> btrfs_orphan_cleanup() has a comment referring to find_dead_roots, but
> function does not exists since commit cb517eabba4f10 ("Btrfs: cleanup the
> similar code of the fs root read"). What we use now to find and load dead
> roots is btrfs_find_orphan_roots(). So update the comment and make it a
> bit more detailed about why we can not delete an orphan item for a root.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
