Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE61B252C5A
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 13:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgHZLUZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 07:20:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:35704 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728707AbgHZLSh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 07:18:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 36818B1BE;
        Wed, 26 Aug 2020 11:19:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 43CCCDA730; Wed, 26 Aug 2020 13:17:28 +0200 (CEST)
Date:   Wed, 26 Aug 2020 13:17:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Tyler Richmond <t.d.richmond@gmail.com>
Subject: Re: [PATCH] btrfs: tree-checker: fix the error message for transid
 error
Message-ID: <20200826111728.GE28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Tyler Richmond <t.d.richmond@gmail.com>
References: <20200825134251.31609-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825134251.31609-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 25, 2020 at 09:42:51PM +0800, Qu Wenruo wrote:
> The error message for inode transid is the same for inode generation,
> which makes us unable to detect the real problem.
> 
> Reported-by: Tyler Richmond <t.d.richmond@gmail.com>
> Fixes: 496245cac57e ("btrfs: tree-checker: Verify inode item")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
