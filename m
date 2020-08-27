Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D1C25475D
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Aug 2020 16:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgH0OtZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Aug 2020 10:49:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:59976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728161AbgH0OtB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Aug 2020 10:49:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AFB4AAC23;
        Thu, 27 Aug 2020 14:49:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0DDBFDA703; Thu, 27 Aug 2020 16:47:50 +0200 (CEST)
Date:   Thu, 27 Aug 2020 16:47:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Jungyeon Yoon <jungyeon.yoon@gmail.com>
Subject: Re: [PATCH v5 0/4] btrfs: Enhanced runtime defence against fuzzed
 images
Message-ID: <20200827144750.GN28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Jungyeon Yoon <jungyeon.yoon@gmail.com>
References: <20200819063550.62832-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819063550.62832-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 19, 2020 at 02:35:46PM +0800, Qu Wenruo wrote:
> v5:
> - Properly inline the check while make the report code into another
>   function for the 1st patch
> 
> - Keep btrfs_abort_transaction() call where it is for the 2nd patch
>   To make the line number correct and abort transaction asap.
> 
> - Function naming update for the 4th patch
> 
> Qu Wenruo (4):
>   btrfs: extent_io: do extra check for extent buffer read write
>     functions
>   btrfs: extent-tree: kill BUG_ON() in __btrfs_free_extent() and do
>     better comment
>   btrfs: extent-tree: kill the BUG_ON() in
>     insert_inline_extent_backref()
>   btrfs: ctree: checking key orders before merged tree blocks

With several fixups and updates added to misc-next. Thanks.
