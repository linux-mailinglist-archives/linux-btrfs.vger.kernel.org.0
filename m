Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAED229EBD4
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 13:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgJ2M0D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 08:26:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:33310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgJ2M0B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 08:26:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6ED41AD31;
        Thu, 29 Oct 2020 12:26:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7BB8ADA7D9; Thu, 29 Oct 2020 13:24:25 +0100 (CET)
Date:   Thu, 29 Oct 2020 13:24:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: do not start and wait for delalloc on snapshot
 roots on transaction commit
Message-ID: <20201029122425.GJ6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <bb2b1573dc60b8e743e8675fab5a13c15e7dcc85.1603802247.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb2b1573dc60b8e743e8675fab5a13c15e7dcc85.1603802247.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 27, 2020 at 12:40:06PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We do not need anymore to start writeback for delalloc of roots that are
> being snapshoted and wait for it to complete. This was done in commit
> 609e804d771f59 ("Btrfs: fix file corruption after snapshotting due to mix
> of buffered/DIO writes") to fix a type of file corruption where files in a
> snapshot end up having their i_size updated in a non-ordered way, leaving
> implicit file holes, when buffered IO writes that increase a file's size
> are followed by direct IO writes that also increase the file's size.
> 
> This is not needed anymore because we now have a more generic mechanism
> to prevent a non-ordered i_size update since commit 9ddc959e802bf7
> ("btrfs: use the file extent tree infrastructure"), which addresses this
> scenario involving snapshots as well.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
