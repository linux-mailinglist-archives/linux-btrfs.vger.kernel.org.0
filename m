Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0683818A61
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2019 15:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfEINNQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 May 2019 09:13:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:37084 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726054AbfEINNQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 May 2019 09:13:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D1A7AC38;
        Thu,  9 May 2019 13:13:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9F052DA8DC; Thu,  9 May 2019 15:14:12 +0200 (CEST)
Date:   Thu, 9 May 2019 15:14:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: extent-io: Remove the incorrect comment on RO fs
 when btrfs_run_delalloc_range() fails
Message-ID: <20190509131410.GR20156@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190509073150.13027-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509073150.13027-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 09, 2019 at 03:31:50PM +0800, Qu Wenruo wrote:
> At the context of btrfs_run_delalloc_range(), we haven't started/joined
> a transaction, thus even something went wrong, we can't and won't abort
> transaction, thus no way to make the fs RO.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to 5.3 queue, thanks.
