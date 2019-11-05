Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 181A7F035D
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2019 17:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390194AbfKEQrz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Nov 2019 11:47:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:42536 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390060AbfKEQrz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Nov 2019 11:47:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C2D1EABA0;
        Tue,  5 Nov 2019 16:47:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 35F59DA796; Tue,  5 Nov 2019 17:47:59 +0100 (CET)
Date:   Tue, 5 Nov 2019 17:47:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PATCH 0/2] btrfs: block-group: Bug fixes for "btrfs:
 block-group: Refactor btrfs_read_block_groups()"
Message-ID: <20191105164759.GL3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191105013535.14239-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105013535.14239-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 05, 2019 at 09:35:33AM +0800, Qu Wenruo wrote:
> David reported some strange error in that patch.
> 
> One bug is from rebasing, and another one is from me. The first patch
> will fix the bug.
> 
> The second patch will reduce stack usage for read_one_block_group().
> 
> Qu Wenruo (2):
>   btrfs: block-group: Fix two rebase errors where assignment for cache
>     is missing
>   btrfs: block-group: Reuse the item key from caller of
>     read_one_block_group()

Folded and merged, thanks.
