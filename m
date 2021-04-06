Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8E5355BFE
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 21:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbhDFTIt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 15:08:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:44440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237663AbhDFTIs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Apr 2021 15:08:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E7F47B301;
        Tue,  6 Apr 2021 19:08:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EF9BEDA732; Tue,  6 Apr 2021 21:06:26 +0200 (CEST)
Date:   Tue, 6 Apr 2021 21:06:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v8 28/39] btrfs: handle btrfs_search_slot failure in
 replace_path
Message-ID: <20210406190626.GL7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Qu Wenruo <wqu@suse.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
 <1c88a3767122bd97acc2f6370cbd046bee05ff2c.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c88a3767122bd97acc2f6370cbd046bee05ff2c.1615580595.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 12, 2021 at 03:25:23PM -0500, Josef Bacik wrote:
> This can fail for any number of reasons, why bring the whole box down
> with it?

I've written something more relevant for the code change.

> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/relocation.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 592b2d156626..6e8d89e4733a 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1322,7 +1322,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
>  		path->lowest_level = level;
>  		ret = btrfs_search_slot(trans, src, &key, path, 0, 1);
>  		path->lowest_level = 0;
> -		BUG_ON(ret);
> +		if (ret)
> +			break;

As replace_path returns positive values, ie. the level, search failing
to find the key could return 1 which would be wrongly interpreted if
returned as-is. The usual pattern is to switch that to -ENOENT, like

--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1323,8 +1323,11 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
                path->lowest_level = level;
                ret = btrfs_search_slot(trans, src, &key, path, 0, 1);
                path->lowest_level = 0;
-               if (ret < 0)
+               if (ret) {
+                       if (ret > 0)
+                               ret = -ENOENT;
                        break;
+               }
 
                /*
                 * Info qgroup to trace both subtrees.
---
