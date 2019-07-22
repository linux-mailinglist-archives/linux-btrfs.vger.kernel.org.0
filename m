Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B66C7008C
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2019 15:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbfGVNHA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jul 2019 09:07:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:35114 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727360AbfGVNG7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jul 2019 09:06:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3246AEE6;
        Mon, 22 Jul 2019 13:06:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B1038DA882; Mon, 22 Jul 2019 15:07:33 +0200 (CEST)
Date:   Mon, 22 Jul 2019 15:07:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: deal with drop_progress properly in fsck
Message-ID: <20190722130733.GR20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org
References: <20190206204924.6096-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206204924.6096-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 06, 2019 at 03:49:24PM -0500, Josef Bacik wrote:
> While testing snapshot deletion with dm-log-writes I saw that I was
> failing the fsck sometimes when the fs was actually in the correct
> state.  This is because we only skip blocks on the same level of
> root_item->drop_level.  If the drop_level < the root level then we could
> very well walk into nodes that we wouldn't actually walk into on fs
> mount, because the drop_progress is further ahead in the slot of the
> root.  Instead only process the slots of the nodes that are above the
> drop_progress key.  With this patch in place we no longer improperly
> fail to check fs'es that have a drop_progress set with a drop_level <
> root level.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Now applied to devel, thanks.
