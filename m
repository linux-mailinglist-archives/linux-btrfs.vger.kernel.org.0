Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1098D1AC128
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 14:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503567AbgDPMZP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 08:25:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:48226 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503287AbgDPMZI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 08:25:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C8F44AC7B;
        Thu, 16 Apr 2020 12:25:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D4546DA727; Thu, 16 Apr 2020 14:24:26 +0200 (CEST)
Date:   Thu, 16 Apr 2020 14:24:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix setting last_trans for reloc roots
Message-ID: <20200416122426.GJ5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200410154248.2646406-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410154248.2646406-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 10, 2020 at 11:42:48AM -0400, Josef Bacik wrote:
> I made a mistake with my previous fix, I assumed that we didn't need to
> mess with the reloc roots once we were out of the part of relocation
> where we are actually moving the extents.
> 
> The subtle thing that I missed is that btrfs_init_reloc_root() also
> updates the last_trans for the reloc root when we do
> btrfs_record_root_in_trans() for the corresponding fs_root.  I've added
> a comment to make sure future me doesn't make this mistake again.
> 
> This showed up as a WARN_ON() in btrfs_copy_root() because our
> last_trans didn't == the current transid.  This could happen if we
> snapshotted a fs root with a reloc root after we set
> rc->create_reloc_tree = 0, but before we actually merge the reloc root.
> 
> Fixes: 2abc726ab4b8 ("btrfs: do not init a reloc root if we aren't relocating")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next with the stacktrace.
