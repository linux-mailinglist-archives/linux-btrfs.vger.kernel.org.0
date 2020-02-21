Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC4A1684A6
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 18:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgBURQh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 12:16:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:41244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgBURQh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 12:16:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8C528AED6;
        Fri, 21 Feb 2020 17:16:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 133A0DA70E; Fri, 21 Feb 2020 18:16:17 +0100 (CET)
Date:   Fri, 21 Feb 2020 18:16:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: set update the uuid generation as soon as possible
Message-ID: <20200221171617.GQ2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200214202206.1642-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214202206.1642-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 14, 2020 at 03:22:06PM -0500, Josef Bacik wrote:
> In my EIO stress testing I noticed I was getting forced to rescan the
> uuid tree pretty often, which was weird.  This is because my error
> injection stuff would sometimes inject an error after log replay but
> before we loaded the UUID tree.  If log replay committed the transaction
> it wouldn't have updated the uuid tree generation, but the tree was
> valid and didn't change, so there's no reason to not update the
> generation here.
> 
> Fix this by setting the BTRFS_FS_UPDATE_UUID_TREE_GEN bit immediately
> after reading all the fs roots if the uuid tree generation matches the
> fs generation.  Then any transaction commits that happen during mount
> won't screw up our uuid tree state, forcing us to do needless uuid
> rescans.
> 
> Fixes: 70f801754728 ("Btrfs: check UUID tree during mount if required")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
