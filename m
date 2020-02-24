Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A736F16B22E
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 22:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgBXV1h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 16:27:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:42268 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgBXV1h (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 16:27:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1B7FBAEA7;
        Mon, 24 Feb 2020 21:27:36 +0000 (UTC)
Message-ID: <795cb7cc9d36eb84c1ed03efdbb8702ef9282774.camel@suse.de>
Subject: Re: [PATCH misc-next] btrfs: fix compilation error in
 btree_write_cache_pages()
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Date:   Mon, 24 Feb 2020 18:30:38 -0300
In-Reply-To: <20200224202251.37787-1-johannes.thumshirn@wdc.com>
References: <20200224202251.37787-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 2020-02-25 at 05:22 +0900, Johannes Thumshirn wrote:
> CC [M]  fs/btrfs/extent_io.o
> fs/btrfs/extent_io.c: In function ‘btree_write_cache_pages’:
> fs/btrfs/extent_io.c:3959:34: error: ‘tree’ undeclared (first use in
> this function); did you mean ‘true’?
>  3959 |  struct btrfs_fs_info *fs_info = tree->fs_info;
>       |                                  ^~~~
>       |                                  true
> fs/btrfs/extent_io.c:3959:34: note: each undeclared identifier is
> reported only once for each function it appears in
> make[2]: *** [scripts/Makefile.build:268: fs/btrfs/extent_io.o] Error
> 1
> make[1]: *** [scripts/Makefile.build:505: fs/btrfs] Error 2
> make: *** [Makefile:1681: fs] Error 2
> 
> Fixes: 75c39607eb0a ("btrfs: Don't submit any btree write bio if the
> fs has errors")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Indeed, it fixes the build of misc-next.
Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com>

> ---
>  fs/btrfs/extent_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 903a85d8fbe3..837262d54e28 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3956,7 +3956,7 @@ int btree_write_cache_pages(struct
> address_space *mapping,
>  		.extent_locked = 0,
>  		.sync_io = wbc->sync_mode == WB_SYNC_ALL,
>  	};
> -	struct btrfs_fs_info *fs_info = tree->fs_info;
> +	struct btrfs_fs_info *fs_info = BTRFS_I(mapping->host)->root-
> >fs_info;
>  	int ret = 0;
>  	int done = 0;
>  	int nr_to_write_done = 0;

