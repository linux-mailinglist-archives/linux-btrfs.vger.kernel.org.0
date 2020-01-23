Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEBA146E90
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 17:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgAWQlB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 11:41:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:43482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgAWQlB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 11:41:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 903EFAD78;
        Thu, 23 Jan 2020 16:40:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4B8CADA730; Thu, 23 Jan 2020 17:40:43 +0100 (CET)
Date:   Thu, 23 Jan 2020 17:40:43 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: scrub: Require mandatory block group RO for
 dev-replace
Message-ID: <20200123164043.GE3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20200123073759.23535-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123073759.23535-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 23, 2020 at 03:37:59PM +0800, Qu Wenruo wrote:
> 
> Reported-by: Filipe Manana <fdmanana@suse.com>
> Fixes: 76a8efa171bf ("btrfs: Continue replace when set_block_ro failed")
> Fixes: b12de52896c0 ("btrfs: scrub: Don't check free space before marking a block group RO")

This one is in the 5.5-rc, so I'd like to get it to the final release. I
haven't read the discussion properly so please let me know if the patch
needs another round or fixups I can do. Time for the pull request is in
a day (2 at most as it's too close to the release) but given the type of
fix it's justified. Thanks.
