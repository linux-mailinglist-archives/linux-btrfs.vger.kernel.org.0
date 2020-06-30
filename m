Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC47F20F6EC
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 16:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388652AbgF3OO4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 10:14:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:42440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbgF3OO4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 10:14:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 40B22AC37;
        Tue, 30 Jun 2020 14:14:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 145EADA790; Tue, 30 Jun 2020 16:14:39 +0200 (CEST)
Date:   Tue, 30 Jun 2020 16:14:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: workaround exhausted anonymous block device
 pool
Message-ID: <20200630141439.GX27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200616021737.44617-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616021737.44617-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 16, 2020 at 10:17:33AM +0800, Qu Wenruo wrote:
> Qu Wenruo (4):
>   btrfs: disk-io: don't allocate anonymous block device for user
>     invisible roots
>   btrfs: detect uninitialized btrfs_root::anon_dev for user visible
>     subvolumes
>   btrfs: preallocate anon_dev for subvolume and snapshot creation
>   btrfs: free anon_dev earlier to prevent exhausting anonymous block
>     device pool

I haven't seen an update to this patchset and would really like to get
it fixed. Let me know if I missed an update or you need help, there
weren't any big issues left.
