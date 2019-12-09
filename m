Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B012A11741E
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 19:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLISZy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 13:25:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:36084 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726642AbfLISZx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Dec 2019 13:25:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5212CAD2D;
        Mon,  9 Dec 2019 18:25:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EA416DA82A; Mon,  9 Dec 2019 19:25:43 +0100 (CET)
Date:   Mon, 9 Dec 2019 19:25:43 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: add missing check after link_free_space
Message-ID: <20191209182543.GQ2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dinghao Liu <dinghao.liu@zju.edu.cn>,
        kjlu@umn.edu, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191209034114.16212-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209034114.16212-1-dinghao.liu@zju.edu.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 09, 2019 at 11:41:14AM +0800, Dinghao Liu wrote:
> The return value of link_free_space is checked out-sync.
> One branch of an if statement uses an extra check after
> WARN_ON() but its peer branch does not. WARN_ON() does
> not change the control flow, thus only using this check
> might be insufficient.
> 
> Fix this by simply adding a check on ret.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> --
> Changes in v2:
>   - Add memory free for free space entry.
> ---
>  fs/btrfs/free-space-cache.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 3283da419200..ba2e6cea5233 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -2437,6 +2437,10 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
>  			if (info->bytes) {
>  				ret = link_free_space(ctl, info);
>  				WARN_ON(ret);
> +				if (ret) {
> +					kmem_cache_free(btrfs_free_space_cachep, info);
> +					goto out_lock;
> +				}
>  			} else {
>  				kmem_cache_free(btrfs_free_space_cachep, info);

There are two link_free_space followed by WARN_ON instances in the
function, please remove both.

In the above case, the branches can be merged together so there's not
repeated kmem_cache_free, like

	if (info->bytes)
		ret = link_free_space(...);
	kmem_cache_free(btrfs_free_space_cachep, info);
	if (ret)
		goto out_unlock;
