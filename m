Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F01D4997BF
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 17:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389428AbfHVPIL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 11:08:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:35960 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732611AbfHVPIL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 11:08:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 21919AD7C
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 15:08:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 90C5ADA791; Thu, 22 Aug 2019 17:08:35 +0200 (CEST)
Date:   Thu, 22 Aug 2019 17:08:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v1.2 0/3] btrfs: tree-checker: Add extent items check
Message-ID: <20190822150835.GJ2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190809012424.11420-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809012424.11420-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 09, 2019 at 09:24:21AM +0800, Qu Wenruo wrote:
> Finally, we are going to add tree-checker support for extent items,
> which includes:
> - EXTENT_ITEM/METADATA_ITEM
>   Which futher contains inline backrefs of:
>   * TREE_BLOCK_REF
>   * SHARED_BLOCK_REF
>   * EXETNT_DATA_REF
>   * SHARED_DATA_REF
> 
> - TREE_BLOCK_REF
> - SHARED_BLOCK_REF
> - EXTENT_DATA_REF
> - SHARED_DATA_REF
>   Keyed version of the above types

Great, thanks.

> v1.2:
  ^^^^

Please use integers for patchsets, ie. this is v3 for me.

> - Use "unsigned long" for pointer convertion
> 
> - Use "%zu" format for sizeof() in the 3rd patch
> 
> Qu Wenruo (3):
>   btrfs: tree-checker: Add EXTENT_ITEM and METADATA_ITEM check
>   btrfs: tree-checker: Add simple keyed refs check
>   btrfs: tree-checker: Add EXTENT_DATA_REF check

I'll update patch 1 with the goto -> return and fix the comments, no
need to resend. V2 has been in for-next, there were no significant
changes since so I'll add v3 to misc-next. Thanks.
