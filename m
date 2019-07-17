Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD506BEAD
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 16:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfGQO6Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 10:58:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:60230 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725936AbfGQO6Q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 10:58:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1CF96AB7D
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jul 2019 14:58:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5B595DA8E1; Wed, 17 Jul 2019 16:58:52 +0200 (CEST)
Date:   Wed, 17 Jul 2019 16:58:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: don't leak extent_map in btrfs_get_io_geometry()
Message-ID: <20190717145852.GH20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190715131612.14040-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715131612.14040-1-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 15, 2019 at 03:16:12PM +0200, Johannes Thumshirn wrote:
> btrfs_get_io_geometry() calls btrfs_get_chunk_map() to acquire a reference
> on a extent_map, but on normal operation it does not drop this reference
> anymore.
> 
> This leads to excessive kmemleak reports.
> 
> Always call free_extent_map(), not just in the error case.
> 
> Fixes: 5f1411265e16 ("btrfs: Introduce btrfs_io_geometry infrastructure")
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Added to 5.3 queue, thanks.
