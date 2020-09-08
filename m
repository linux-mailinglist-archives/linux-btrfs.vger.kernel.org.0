Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE804261EF6
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 21:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgIHT5k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 15:57:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:36556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732122AbgIHT5V (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Sep 2020 15:57:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 10B13AC8B;
        Tue,  8 Sep 2020 19:57:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8200BDA781; Tue,  8 Sep 2020 21:56:00 +0200 (CEST)
Date:   Tue, 8 Sep 2020 21:55:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs-progs: support free space tree in mkfs
Message-ID: <20200908195559.GC18399@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200902204453.GN28318@twin.jikos.cz>
 <cf7462fe8c14448703d845d235dce7aca1faf795.1599157021.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf7462fe8c14448703d845d235dce7aca1faf795.1599157021.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 03, 2020 at 11:19:23AM -0700, Boris Burkov wrote:
> Add a runtime feature (-R) flag for the free space tree. A filesystem
> that is mkfs'd with -R free-space-tree then mounted with no options has
> the same contents as one mkfs'd without the option, then mounted with
> '-o space_cache=v2'.
> 
> The only tricky thing is in exactly how to call the tree creation code.
> Using btrfs_create_free_space_tree as is did not quite work, because an
> extra reference to the eb (root->commit_root) is leaked, which mkfs
> complains about with a warning. I opted to follow how the uuid tree is
> created by adding it to the dirty roots list for cleanup by
> commit_tree_roots in commit_transaction. As a result,
> btrfs_create_free_space_tree no longer exactly matches the version in
> the kernel sources.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> - add mkfs test
> - add documentation
> - add safe version and sysfs file to feature struct
> 
>  Documentation/mkfs.btrfs.asciidoc            |  6 ++++++
>  common/fsfeatures.c                          | 10 ++++++++--
>  common/fsfeatures.h                          |  3 ++-
>  kernel-shared/disk-io.c                      |  5 +++++
>  kernel-shared/free-space-tree.c              |  1 +
>  mkfs/main.c                                  |  8 ++++++++
>  tests/mkfs-tests/023-free-space-tree/test.sh | 21 ++++++++++++++++++++
>  7 files changed, 51 insertions(+), 3 deletions(-)
>  create mode 100755 tests/mkfs-tests/023-free-space-tree/test.sh
> 
> diff --git a/Documentation/mkfs.btrfs.asciidoc b/Documentation/mkfs.btrfs.asciidoc
> index 630f575c..8f1e1429 100644
> --- a/Documentation/mkfs.btrfs.asciidoc
> +++ b/Documentation/mkfs.btrfs.asciidoc
> @@ -257,6 +257,12 @@ permanent, this does not replace mount options.
>  Enable quota support (qgroups). The qgroup accounting will be consistent,
>  can be used together with '--rootdir'.  See also `btrfs-quota`(8).
>  
> +*free_space_tree*::
> +(kernel support since 3.4)
> ++
> +Enable the free space tree (mount option space_cache=v2) for persisting the
> +free space cache.
> +
>  BLOCK GROUPS, CHUNKS, RAID
>  --------------------------
>  
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> index 48ab37ca..6c391806 100644
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -104,9 +104,15 @@ static const struct btrfs_feature mkfs_features[] = {
>  };
>  
>  static const struct btrfs_feature runtime_features[] = {
> -	{ "quota", BTRFS_RUNTIME_FEATURE_QUOTA, NULL,
> -		VERSION_TO_STRING2(3, 4), NULL, 0, NULL, 0,
> +	{ "quota", BTRFS_RUNTIME_FEATURE_QUOTA,
> +		"free_space_tree",
> +		VERSION_TO_STRING2(3, 4),
> +		VERSION_TO_STRING2(4, 9),
> +		NULL, 0,

This looks mangled, the free_space_tree (sysfs file reference) is in the
quota entry and the 4.9 version for ->safe use should be in the free-space-tree
entry below. I'll fix it.

>  		"quota support (qgroups)" },
> +	{ "free-space-tree", BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE, NULL,
> +		VERSION_TO_STRING2(4, 5), NULL, 0, NULL, 0,
> +		"free space tree (space_cache=v2)" },

>  	/* Keep this one last */
>  	{ "list-all", BTRFS_FEATURE_LIST_ALL, NULL }
>  };
