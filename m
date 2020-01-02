Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF2B12E8D0
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 17:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgABQk4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 11:40:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:56722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbgABQk4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jan 2020 11:40:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1F821AD3B;
        Thu,  2 Jan 2020 16:40:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 33FD5DA790; Thu,  2 Jan 2020 17:40:46 +0100 (CET)
Date:   Thu, 2 Jan 2020 17:40:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: ctree.h: Sync the comment for
 btrfs_file_extent_item
Message-ID: <20200102164046.GK3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191217065240.5919-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217065240.5919-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 17, 2019 at 02:52:40PM +0800, Qu Wenruo wrote:
> The comment about data checksum on disk_bytes is completely wrong.
> 
> Sync it with fixed kernel comment to avoid confusion.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Applied, thanks.
