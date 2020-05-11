Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E141CE3CD
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 May 2020 21:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbgEKTUj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 15:20:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:38214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbgEKTUj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 15:20:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 15A11B0A5;
        Mon, 11 May 2020 19:20:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A8A95DA82A; Mon, 11 May 2020 21:19:47 +0200 (CEST)
Date:   Mon, 11 May 2020 21:19:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 5/7] btrfs: block-group: Rename write_one_cahce_group()
Message-ID: <20200511191947.GY18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200504235825.4199-1-wqu@suse.com>
 <20200504235825.4199-6-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504235825.4199-6-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 05, 2020 at 07:58:23AM +0800, Qu Wenruo wrote:
> The name of this function contains the word "cache", which is left from
> the era where btrfs_block_group is called btrfs_block_group_cache.
> 
> Now this "cache" doesn't match any thing, and we have better namings for
> functions like read/insert/remove_block_group_item().
> 
> So rename this function to update_block_group_item().
> 
> Since we're here, also rename the local variables to be more like a
> Chrismas tree, and rename @extent_root to @root for later reuse.

Please don't do that. The reverse chrismas tree is Somebody Else's
Coding Style and you introduce unrelated changes where only function
rename is expected. All reverted.
