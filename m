Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A635637FBC5
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 May 2021 18:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhEMQti (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 May 2021 12:49:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:48222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232140AbhEMQtf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 May 2021 12:49:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 137EBB016;
        Thu, 13 May 2021 16:48:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A845ADAEB9; Thu, 13 May 2021 18:45:54 +0200 (CEST)
Date:   Thu, 13 May 2021 18:45:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 0/3] btrfs: make read time repair to be only submitted
 for each corrupted sector
Message-ID: <20210513164554.GI7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210512045330.40329-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512045330.40329-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 12, 2021 at 12:53:27PM +0800, Qu Wenruo wrote:
> v5:
> - Fix a bug where we grab wrong fs_info from DIO page
>   Exposed by btrfs/215.
>   And for DIO case we don't need end_page_read() and extent unrelease
>   call at all.
> 
> - Unexport btrfs_submit_read_repair(), export btrfs_repair_one_sector()
>   Since DIO only needs to repair one sector, unexport
>   btrfs_submit_read_repair() and just export btrfs_repair_one_sector().

Seems to work so I'm moving it to misc-next. If you have any fixups
please send them as incremetal changes, I'll fold it in. Thanks.
