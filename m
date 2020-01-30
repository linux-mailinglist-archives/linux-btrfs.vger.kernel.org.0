Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4983B14DC62
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 15:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgA3ODT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 09:03:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:49884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgA3ODS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 09:03:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BAB73AD39;
        Thu, 30 Jan 2020 14:03:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AC7CADA84C; Thu, 30 Jan 2020 15:02:58 +0100 (CET)
Date:   Thu, 30 Jan 2020 15:02:58 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: Use btrfs_transaction::pinned_extents
Message-ID: <20200130140258.GS3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200124103541.6415-1-nborisov@suse.com>
 <20200124151830.25984-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124151830.25984-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 24, 2020 at 05:18:30PM +0200, Nikolay Borisov wrote:
> This commit flips the switch to start tracking/processing pinned
> extents on a per-transaction basis. It mostly replaces all references
> from btrfs_fs_info::(pinned_extents|freed_extents[]) to
> btrfs_transaction::pinned_extents. Two notable modifications that
> warrant explicit mention are changing clean_pinned_extents to get a
> reference to the previously running transaction. The other one is
> removal of call to btrfs_destroy_pinned_extent since transactions are
> going to be cleaned in btrfs_cleanup_one_transaction.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

The subject could tell me what's the summmary of the change, I can see
in the code that btrfs_transaction::pinned_extents is used but for
what? If this is the main change of the patchset after cleanups, then
the subject is close to the cover letter, so something like "switch to
per-transaction pinned extents".
