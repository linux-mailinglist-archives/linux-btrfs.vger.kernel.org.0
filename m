Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CEE20F72E
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 16:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbgF3O2M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 10:28:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:50270 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388945AbgF3O2L (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 10:28:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ED86CAC37;
        Tue, 30 Jun 2020 14:28:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C2A14DA790; Tue, 30 Jun 2020 16:27:54 +0200 (CEST)
Date:   Tue, 30 Jun 2020 16:27:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: qgroup: add sysfs interface for debug
Message-ID: <20200630142754.GY27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200628050715.60961-1-wqu@suse.com>
 <20200628050715.60961-3-wqu@suse.com>
 <20200629213008.GO27795@twin.jikos.cz>
 <9af22db7-42f0-00fd-1a34-33d6a8cffc2f@suse.com>
 <20200630080735.GQ27795@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630080735.GQ27795@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 30, 2020 at 10:07:35AM +0200, David Sterba wrote:
> We need to at lest have a solid idea how to extend it, not neccessarily
> to implement it right now. Adding the group membership to qgroup
> directories under the qgroup directory as symlinks between the kobjects
> sounds ok-ish to me but it's a new idea and I need to think about it.

So my current winner idea for the hierarchy representation is to keep
all child qgroups as symlinks in the parent group. This does not require
extra kojbect to keep, and the path in sysfs would reflect the
hierarchy, like:

/sys/fs/btrfs/UUID/qgroups/4_1/3_1/2_1/1234_0

This tracks only the parent -> child pointers, so to see all parent
qgroups one has to build the reverse graph or simply search which
1st level directories contain the group as child.

Implementation is one more sysfs_create_link, the leaf qgroups
representing subvolumes will contain only the files with stats.

One potential drawback is the maximum size of path that will not allow
to show deep qgroup hierarchies, but still about 200-400 in case of
average qgroup id 20 or 10 respectively.
