Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C448625B574
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 22:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIBUqL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 16:46:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:36910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgIBUqJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Sep 2020 16:46:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4B22DAD3C;
        Wed,  2 Sep 2020 20:46:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BBEEADA703; Wed,  2 Sep 2020 22:44:54 +0200 (CEST)
Date:   Wed, 2 Sep 2020 22:44:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: support free space tree in mkfs
Message-ID: <20200902204453.GN28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <0366b5e12a7e6f95d9f274df52f32231dcbe8b05.1599072541.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0366b5e12a7e6f95d9f274df52f32231dcbe8b05.1599072541.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 02, 2020 at 11:50:49AM -0700, Boris Burkov wrote:
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

Thanks.

> ---
>  common/fsfeatures.c             | 3 +++
>  common/fsfeatures.h             | 3 ++-
>  kernel-shared/disk-io.c         | 5 +++++
>  kernel-shared/free-space-tree.c | 1 +
>  mkfs/main.c                     | 8 ++++++++
>  5 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> index 48ab37ca..3bebc97f 100644
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -107,6 +107,9 @@ static const struct btrfs_feature runtime_features[] = {
>  	{ "quota", BTRFS_RUNTIME_FEATURE_QUOTA, NULL,
>  		VERSION_TO_STRING2(3, 4), NULL, 0, NULL, 0,
>  		"quota support (qgroups)" },
> +	{ "free-space-tree", BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE, NULL,
> +		VERSION_TO_STRING2(4, 5), NULL, 0, NULL, 0,
> +		"free space tree (space_cache=v2)" },

The unfilled items are: sysfs file (we have that, free_space_tree), the
safe version is 4.9 (that's where the FREE_SPACE_TREE_VALID bit comes
from).

I've run the mkfs tests with the -R flag and all passed, so I'll enable
it in the CI script, with the fixes mentioned above.

We should still have a separate test, similar to what
mkfs/021-rfeatures-quota-rootdir does but this time the presence of the
feature should be checked at least after mkfs (by inspect+dump-super)
and conditionally by mount in case the kernel supports it.

Last but not least the documentation should be updated for mkfs in the
section 'RUNTIME FEATURES'. Thanks.
