Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6D5153393
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 16:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgBEPA3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 10:00:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:41742 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbgBEPA2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Feb 2020 10:00:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BD530AE3D;
        Wed,  5 Feb 2020 15:00:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2ED82DA7E6; Wed,  5 Feb 2020 16:00:15 +0100 (CET)
Date:   Wed, 5 Feb 2020 16:00:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 27/44] btrfs: hold a ref on the root in
 btrfs_recover_relocation
Message-ID: <20200205150015.GP2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <20200124143301.2186319-1-josef@toxicpanda.com>
 <20200124143301.2186319-28-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124143301.2186319-28-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 24, 2020 at 09:32:44AM -0500, Josef Bacik wrote:
> We look up the fs root in various places in here when recovering from a
> crashed relcoation.  Make sure we hold a ref on the root whenever we
> look them up.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/relocation.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 9531739b5a8c..81f383df8f63 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4593,6 +4593,10 @@ int btrfs_recover_relocation(struct btrfs_root *root)
>  		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
>  			fs_root = read_fs_root(fs_info,
>  					       reloc_root->root_key.offset);
> +			if (!btrfs_grab_fs_root(fs_root)) {
> +				err = -ENOENT;
> +				goto out;
> +			}
>  			if (IS_ERR(fs_root)) {

Also in the wrong order.

>  				ret = PTR_ERR(fs_root);
>  				if (ret != -ENOENT) {
