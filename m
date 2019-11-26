Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0227410A18E
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 16:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfKZPx6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 10:53:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:49570 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727191AbfKZPx6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 10:53:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 21984BB0F;
        Tue, 26 Nov 2019 15:53:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 770D8DA898; Tue, 26 Nov 2019 16:53:54 +0100 (CET)
Date:   Tue, 26 Nov 2019 16:53:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/6] btrfs: Move and unexport btrfs_rmap_block
Message-ID: <20191126155354.GH2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191119120555.6465-1-nborisov@suse.com>
 <20191119120555.6465-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119120555.6465-2-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 19, 2019 at 02:05:50PM +0200, Nikolay Borisov wrote:
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -417,8 +417,6 @@ int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>  		     struct btrfs_bio **bbio_ret);
>  int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>  		u64 logical, u64 len, struct btrfs_io_geometry *io_geom);
> -int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
> -		     u64 physical, u64 **logical, int *naddrs, int *stripe_len);

Other functions that are exported for tests have the declaration in .h
under #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS, so this should follow the
pattern and not declare the function inside the tests.
