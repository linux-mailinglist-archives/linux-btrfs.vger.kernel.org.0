Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5331F7B5686
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Oct 2023 17:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237928AbjJBP2P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 11:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237878AbjJBP2O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 11:28:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366C3A6
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 08:28:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EB84F210E6;
        Mon,  2 Oct 2023 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696260489;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0zhqQw4E1u8PmXumaVnFChodMP7nwWCwXKZ8oF9uMNY=;
        b=FiusLczYl8NjRjHN7SMSgqumQHtDPcrN7+rONBWEZxAdTKXm036bnR8I1+Px57EoiKQN1t
        UZ31JZULt/vVhUr34g3YCgxfYhbgaXmA1gHAJk/iU87r9Bf+Rg3g5+YC3VmgeYkbNAegi4
        Nfp6lpcOMxFRE9yYTw7wGYiXbF8G8rM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696260489;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0zhqQw4E1u8PmXumaVnFChodMP7nwWCwXKZ8oF9uMNY=;
        b=aZbvFDLdz3ng+t7c9EmowGPoJP3U4sbXz9Mhui6EqfwHtIkxaki5i1tt4S1PZvXnAyYp0S
        bUiogrzNAgPe3mDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B604213456;
        Mon,  2 Oct 2023 15:28:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id E4OdK4nhGmU8BAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Oct 2023 15:28:09 +0000
Date:   Mon, 2 Oct 2023 17:21:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, gpiccoli@igalia.com
Subject: Re: [PATCH 2/2] btrfs-progs: add mkfs -P option for dev_uuid
Message-ID: <20231002152128.GR13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695861950.git.anand.jain@oracle.com>
 <e1bca34459f2f61fc2cf40a930b930b6f33d69a7.1695861950.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1bca34459f2f61fc2cf40a930b930b6f33d69a7.1695861950.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 28, 2023 at 09:09:19AM +0800, Anand Jain wrote:
> Add an option to specify the device uuid for mkfs. This is useful
> for creating a filesystem with a specific device uuid. This is
> useful for testing.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  mkfs/common.c | 8 +++++++-
>  mkfs/common.h | 1 +
>  mkfs/main.c   | 9 ++++++++-
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/mkfs/common.c b/mkfs/common.c
> index d400413c7d41..e9a2fd5e4d3e 100644
> --- a/mkfs/common.c
> +++ b/mkfs/common.c
> @@ -340,6 +340,7 @@ static void mkfs_blocks_remove(enum btrfs_mkfs_block *blocks, int *blocks_nr,
>  
>  /*
>   * @fs_uuid - if NULL, generates a UUID, returns back the new filesystem UUID
> + * @dev_uuid - if NULL, generates a UUID, returns back the new device UUID
>   *
>   * The superblock signature is not valid, denotes a partially created
>   * filesystem, needs to be finalized.
> @@ -435,7 +436,12 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
>  	} else {
>  		uuid_parse(cfg->fs_uuid, super.fsid);
>  	}
> -	uuid_generate(super.dev_item.uuid);
> +	if (!*cfg->dev_uuid) {
> +		uuid_generate(super.dev_item.uuid);
> +		uuid_unparse(super.dev_item.uuid, cfg->dev_uuid);
> +	} else {
> +		uuid_parse(cfg->dev_uuid, super.dev_item.uuid);
> +	}
>  	uuid_generate(chunk_tree_uuid);
>  
>  	for (i = 0; i < blocks_nr; i++) {
> diff --git a/mkfs/common.h b/mkfs/common.h
> index 06ddc926390f..d512ed853987 100644
> --- a/mkfs/common.h
> +++ b/mkfs/common.h
> @@ -91,6 +91,7 @@ struct btrfs_mkfs_config {
>  	/* Logical addresses of superblock [0] and other tree roots */
>  	u64 blocks[MKFS_BLOCK_COUNT + 1];
>  	char fs_uuid[BTRFS_UUID_UNPARSED_SIZE];
> +	char dev_uuid[BTRFS_UUID_UNPARSED_SIZE];

Please add a comment what this uuid means.

>  	char chunk_uuid[BTRFS_UUID_UNPARSED_SIZE];
>  
>  	/* Superblock offset after make_btrfs */
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 68ff5d7785d3..f0ff1d6cc936 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1097,6 +1097,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  	struct btrfs_mkfs_features features = btrfs_mkfs_default_features;
>  	enum btrfs_csum_type csum_type = BTRFS_CSUM_TYPE_CRC32;
>  	char fs_uuid[BTRFS_UUID_UNPARSED_SIZE] = { 0 };
> +	char dev_uuid[BTRFS_UUID_UNPARSED_SIZE] = { 0 };
>  	u32 nodesize = 0;
>  	bool nodesize_forced = false;
>  	u32 sectorsize = 0;
> @@ -1144,6 +1145,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  			{ "features", required_argument, NULL, 'O' },
>  			{ "runtime-features", required_argument, NULL, 'R' },
>  			{ "uuid", required_argument, NULL, 'U' },
> +			{ "uuid", required_argument, NULL, 'P' },

You can't add 2 long optiosn with the same name, also, don't add the
short option for now. And the help text is also missing.

>  			{ "quiet", 0, NULL, 'q' },
>  			{ "verbose", 0, NULL, 'v' },
>  			{ "shrink", no_argument, NULL, GETOPT_VAL_SHRINK },
> @@ -1154,7 +1156,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  			{ NULL, 0, NULL, 0}
>  		};
>  
> -		c = getopt_long(argc, argv, "A:b:fl:n:s:m:d:L:R:O:r:U:VvMKq",
> +		c = getopt_long(argc, argv, "A:b:fl:n:s:m:d:L:R:O:r:U:P:VvMKq",
>  				long_options, NULL);
>  		if (c < 0)
>  			break;
> @@ -1262,6 +1264,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  				strncpy(fs_uuid, optarg,
>  					BTRFS_UUID_UNPARSED_SIZE - 1);
>  				break;
> +			case 'P':
> +				strncpy(dev_uuid, optarg,
> +					BTRFS_UUID_UNPARSED_SIZE - 1);
> +				break;
>  			case 'K':
>  				opt_discard = false;
>  				break;
> @@ -1667,6 +1673,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  
>  	mkfs_cfg.label = label;
>  	memcpy(mkfs_cfg.fs_uuid, fs_uuid, sizeof(mkfs_cfg.fs_uuid));
> +	memcpy(mkfs_cfg.dev_uuid, dev_uuid, sizeof(mkfs_cfg.dev_uuid));
>  	mkfs_cfg.num_bytes = dev_block_count;
>  	mkfs_cfg.nodesize = nodesize;
>  	mkfs_cfg.sectorsize = sectorsize;
> -- 
> 2.39.3
