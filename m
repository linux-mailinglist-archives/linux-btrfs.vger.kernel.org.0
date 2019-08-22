Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4385C9979A
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 17:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbfHVPB7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 11:01:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:33484 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725886AbfHVPB7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 11:01:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3C988AF58
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 15:01:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B0E00DA791; Thu, 22 Aug 2019 17:02:23 +0200 (CEST)
Date:   Thu, 22 Aug 2019 17:02:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v1.2 2/3] btrfs: tree-checker: Add simple keyed refs check
Message-ID: <20190822150223.GI2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190809012424.11420-1-wqu@suse.com>
 <20190809012424.11420-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809012424.11420-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 09, 2019 at 09:24:23AM +0800, Qu Wenruo wrote:
> For TREE_BLOCK_REF, SHARED_DATA_REF and SHARED_BLOCK_REF we need to
> check:
>               | TREE_BLOCK_REF | SHARED_BLOCK_REF | SHARED_BLOCK_REF
> --------------+----------------+-----------------+------------------
> key->objectid |    Alignment   |     Alignment    |    Alignment
> key->offset   |    Any value   |     Alignment    |    Alignment
> item_size     |        0       |        0         |   sizeof(le32) (*)
> 
> *: sizeof(struct btrfs_shared_data_ref)
> 
> So introduce a check to check all these 3 key types together.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>
