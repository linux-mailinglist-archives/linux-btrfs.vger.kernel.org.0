Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CDA52F27B
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 20:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352707AbiETSSA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 May 2022 14:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352635AbiETSR4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 May 2022 14:17:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26FE69B4D
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 11:16:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 01F2521B28;
        Fri, 20 May 2022 18:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653070601;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GhwClLlzshrF3Pp6Ph86SXPaNIhM071sLpne8IgR6M4=;
        b=TO/LKLO2y7WWLKCrHsOjlmv1i+VOjWDW5xG5uUl2Cze7WJkn2Twdp8E8za1WYXE8COVtAF
        5roe8DUwol88lmNAzCv5A/wSmcWG9aQhA6r7TFHO7MELRbvzHgjHw3zrAy/h6mFtxZ2v0A
        NRgpodPemwY10uZYDpfMZuYkJSXxWSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653070601;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GhwClLlzshrF3Pp6Ph86SXPaNIhM071sLpne8IgR6M4=;
        b=iXc1mrwZ2Klz/ffysc9pqv4V1L+RhAwHcN9MI/eySA0Fqn8Sf/DpXL3AwWrCGJAYB3+0FB
        V9RrhFOQq1hsgzAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBEC413A5F;
        Fri, 20 May 2022 18:16:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mY2/MAjbh2LmTgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 20 May 2022 18:16:40 +0000
Date:   Fri, 20 May 2022 20:12:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: introduce inspect-internal map-logical
 command
Message-ID: <20220520181220.GS18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <ff62eb10cbf38e53ac26f458644257f82daba47c.1653031397.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff62eb10cbf38e53ac26f458644257f82daba47c.1653031397.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 20, 2022 at 03:23:26PM +0800, Qu Wenruo wrote:
> This is a simpler version compared to btrfs-map-logical.
> 
> The differences are:
> 
> - No extent check
>   Thus any bytenr which has chunk mapping can be mapped.
> 
> - No length specification
>   Now it's fixed to sectorsize.
>   Previously we use nodesize in btrfs-map-logical, which would only
>   make the output more complex due as it may cross stripe boundary
>   for data extent.
> 
>   Considering the main users of this functionality is data corruption,
>   thus we really just want to resolve a single sector.
> 
> - No data write support nor mirror specification
>   We always output all mirrors and call it a day.
> 
> - Ignore RAID56 parity manually
> 
> We still keep the old btrfs-map-logical, just in case there are some
> usage of certain parameters.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  Documentation/btrfs-inspect-internal.rst |  7 +++
>  cmds/inspect.c                           | 78 ++++++++++++++++++++++++
>  2 files changed, 85 insertions(+)
> 
> diff --git a/Documentation/btrfs-inspect-internal.rst b/Documentation/btrfs-inspect-internal.rst
> index 710a34fb0cb9..8a9264d3dc5b 100644
> --- a/Documentation/btrfs-inspect-internal.rst
> +++ b/Documentation/btrfs-inspect-internal.rst
> @@ -169,6 +169,13 @@ logical-resolve [-Pvo] [-s <bufsize>] <logical> <path>
>          -v
>                  (deprecated) alias for global *-v* option
>  
> +map-logical <logical> <device>
> +        map the sector at given *logical* address in the linear filesystem space into
> +        physical address.
> +
> +        .. note::
> +                For RAID56, this will only map the data stripe.
> +
>  min-dev-size [options] <path>
>          (needs root privileges)
>  
> diff --git a/cmds/inspect.c b/cmds/inspect.c
> index 1534f2040f4e..271adf8c6fd4 100644
> --- a/cmds/inspect.c
> +++ b/cmds/inspect.c
> @@ -29,6 +29,7 @@
>  #include "kernel-shared/ctree.h"
>  #include "common/send-utils.h"
>  #include "kernel-shared/disk-io.h"
> +#include "kernel-shared/volumes.h"
>  #include "cmds/commands.h"
>  #include "common/help.h"
>  #include "common/open-utils.h"
> @@ -125,6 +126,7 @@ static int cmd_inspect_inode_resolve(const struct cmd_struct *cmd,
>  }
>  static DEFINE_SIMPLE_COMMAND(inspect_inode_resolve, "inode-resolve");
>  
> +
>  static const char * const cmd_inspect_logical_resolve_usage[] = {
>  	"btrfs inspect-internal logical-resolve [-Pvo] [-s bufsize] <logical> <path>",
>  	"Get file system paths for the given logical address",
> @@ -348,6 +350,81 @@ out:
>  }
>  static DEFINE_SIMPLE_COMMAND(inspect_subvolid_resolve, "subvolid-resolve");
>  
> +static const char * const cmd_inspect_map_logical_usage[] = {
> +	"btrfs inspect-internal map-logical <logical> <device>",
> +	"Get the physical offset of a sector.",
> +	NULL
> +};
> +
> +static int print_mapping_info(struct btrfs_fs_info *fs_info, u64 logical)
> +{
> +	struct cache_extent *ce;
> +	struct map_lookup *map;
> +	int num_copies;
> +	int cur_mirror;
> +	int ret;
> +
> +	ce = search_cache_extent(&fs_info->mapping_tree.cache_tree, logical);
> +	if (!ce) {
> +		error("no chunk mapping found for logical %llu", logical);
> +		return -ENOENT;
> +	}
> +	map = container_of(ce, struct map_lookup, ce);
> +	/* For RAID56, we only return the data stripe. */
> +	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
> +		num_copies = 1;
> +	else
> +		num_copies = btrfs_num_copies(fs_info, logical,
> +					      fs_info->sectorsize);
> +
> +	for (cur_mirror = 1; cur_mirror <= num_copies; cur_mirror++) {
> +		struct btrfs_multi_bio *multi = NULL;
> +		u64 len = fs_info->sectorsize;
> +
> +		ret = btrfs_map_block(fs_info, READ, logical, &len, &multi,
> +				      cur_mirror, NULL);
> +		if (ret < 0) {
> +			errno = -ret;
> +			error("failed to map logical %llu: %m", logical);
> +			return ret;
> +		}
> +		/* We're using READ, which should only return one mirror. */
> +		ASSERT(multi && multi->num_stripes == 1);
> +		printf("mirror %d logical %llu phyiscal %llu device %s\n",
> +			cur_mirror, logical, multi->stripes[0].physical,
> +			multi->stripes[0].dev->name);
> +		free(multi);
> +	}
> +	return 0;
> +}
> +
> +static int cmd_inspect_map_logical(const struct cmd_struct *cmd, int argc,
> +				   char **argv)
> +{
> +	struct open_ctree_flags ocf = {0};
> +	struct btrfs_fs_info *fs_info;
> +	u64 logical;
> +	int ret;
> +
> +	clean_args_no_options(cmd, argc, argv);
> +
> +	if (check_argc_exact(argc - optind, 2))
> +		return 1;
> +
> +	ocf.filename = argv[optind + 1];
> +	ocf.flags = OPEN_CTREE_CHUNK_ROOT_ONLY;
> +	logical = arg_strtou64(argv[optind]);
> +
> +	fs_info = open_ctree_fs_info(&ocf);

So this is for images, not for mounted filesystem. The inspect-internal
group has both but for the map-logical we could do both.

I'd expect the primary use to be for the mounted fs.  The question is
what for am I supposed to use map-logical for? See where a file is
located, ok, that I'd like to see on a mounted filesystem. Running that
on the block device while still mounted is unreliable.
