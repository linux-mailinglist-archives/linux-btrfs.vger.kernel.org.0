Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26AAA2EBD3B
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 12:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbhAFLj0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jan 2021 06:39:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:36360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbhAFLj0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 Jan 2021 06:39:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DE279AE61;
        Wed,  6 Jan 2021 11:38:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8352DDA6E9; Wed,  6 Jan 2021 12:36:55 +0100 (CET)
Date:   Wed, 6 Jan 2021 12:36:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: print bytenr of child eb if mismatched
 level found in read_node_slot()
Message-ID: <20210106113655.GQ6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        linux-btrfs@vger.kernel.org
References: <20210106103550.1145-1-l@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106103550.1145-1-l@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 06, 2021 at 06:35:50PM +0800, Su Yue wrote:
> If btrfs check reported like "ERROR: child eb corrupted: parent bytenr
> =178081 item=246 parent level=1 child level=2". It's hard to find
> which eb is corrupted without bytenr in dump tree information:
> ===================================================================
> node 178081 level 1 items 424 free 69 generation 44495 owner EXTENT_TREE
> fs uuid 7d9dbe1b-dea6-4141-807b-026325123ad8
> chunk uuid 97a3e3aa-7105-4101-aaf7-50204a240e69
>         key (16613126144 EXTENT_ITEM 4096) block 177939087360 gen 44433
>         key (16632803328 EXTENT_ITEM 4096) block 177939120128 gen 44433
>         key (16654548992 EXTENT_ITEM 8192) block 177970380800 gen 44336
>         key (16697884672 EXTENT_ITEM 8192) block 177970397184 gen 44336
>         key (16714223616 EXTENT_ITEM 16384) block 177970413568 gen 44336
>         key (16721760256 EXTENT_ITEM 16384) block 177943855104 gen 44436
>         key (16857755648 EXTENT_ITEM 4096) block 177857544192 gen 44416
> ...
> 
> ===================================================================
> 
> For easier lookup, print bytenr of child eb if its level is not equal
> to parent's level - 1 in read_node_slot().
> 
> Signed-off-by: Su Yue <l@damenly.su>

Added to devel, thanks.
