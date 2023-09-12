Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B63E79DA33
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 22:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbjILUmq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 16:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjILUmp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 16:42:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F89B1BE;
        Tue, 12 Sep 2023 13:42:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A5CF51F86A;
        Tue, 12 Sep 2023 20:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694551360;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0khQAnnLIXEVlQ8G98bMnKaJSTLI6tJaKjRi0GnrL3I=;
        b=j9L0QmMHWXdLRjKFtkySZ20cR4WZBgSf11e5qKRVM5LOtZgkMaXdgzvhgMSyXVZgThzIDk
        UuU9gMLySqAWfRxX6pPn7Nbt7PiaRrd8MDIsfmIE1VQkYOsENH2AtIDEwvDdIhzIjRnKyz
        pxmFbQmaedP1cuxBbCGwCfZswwbooSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694551360;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0khQAnnLIXEVlQ8G98bMnKaJSTLI6tJaKjRi0GnrL3I=;
        b=4ZlWKzx7Lzw8QQFHK3BeuO2hP/oC+Xih14sxcbdvakMrDieH1dxrQR0gnIHRqYBIn8URZQ
        zXp4ExmqV9LSGIAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6928C139DB;
        Tue, 12 Sep 2023 20:42:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id peXUGEDNAGX3AwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 12 Sep 2023 20:42:40 +0000
Date:   Tue, 12 Sep 2023 22:42:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 08/11] btrfs: add raid stripe tree pretty printer
Message-ID: <20230912204239.GF20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
 <20230911-raid-stripe-tree-v8-8-647676fa852c@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911-raid-stripe-tree-v8-8-647676fa852c@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 11, 2023 at 05:52:09AM -0700, Johannes Thumshirn wrote:
> Decode raid-stripe-tree entries on btrfs_print_tree().
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/print-tree.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
> index 0c93439e929f..f01919e4bb37 100644
> --- a/fs/btrfs/print-tree.c
> +++ b/fs/btrfs/print-tree.c
> @@ -9,6 +9,7 @@
>  #include "print-tree.h"
>  #include "accessors.h"
>  #include "tree-checker.h"
> +#include "raid-stripe-tree.h"
>  
>  struct root_name_map {
>  	u64 id;
> @@ -28,6 +29,7 @@ static const struct root_name_map root_map[] = {
>  	{ BTRFS_FREE_SPACE_TREE_OBJECTID,	"FREE_SPACE_TREE"	},
>  	{ BTRFS_BLOCK_GROUP_TREE_OBJECTID,	"BLOCK_GROUP_TREE"	},
>  	{ BTRFS_DATA_RELOC_TREE_OBJECTID,	"DATA_RELOC_TREE"	},
> +	{ BTRFS_RAID_STRIPE_TREE_OBJECTID,	"RAID_STRIPE_TREE"	},
>  };
>  
>  const char *btrfs_root_name(const struct btrfs_key *key, char *buf)
> @@ -189,6 +191,48 @@ static void print_uuid_item(const struct extent_buffer *l, unsigned long offset,
>  	}
>  }
>  
> +struct raid_encoding_map {
> +	u8 encoding;
> +	char name[16];
> +};
> +
> +static const struct raid_encoding_map raid_map[] = {
> +	{ BTRFS_STRIPE_DUP,	"DUP" },
> +	{ BTRFS_STRIPE_RAID0,	"RAID0" },
> +	{ BTRFS_STRIPE_RAID1,	"RAID1" },
> +	{ BTRFS_STRIPE_RAID1C3,	"RAID1C3" },
> +	{ BTRFS_STRIPE_RAID1C4, "RAID1C4" },
> +	{ BTRFS_STRIPE_RAID5,	"RAID5" },
> +	{ BTRFS_STRIPE_RAID6,	"RAID6" },
> +	{ BTRFS_STRIPE_RAID10,	"RAID10" }
> +};

Instead of another table tranlating constants to raid names, can you
somehow utilize the btrfs_raid_array table? If the STRIPE values match
the RAID (the indexes to the table) you could add a simple wrapper.

> +
> +static const char *stripe_encoding_name(u8 encoding)
> +{
> +	for (int i = 0; i < ARRAY_SIZE(raid_map); i++) {
> +		if (raid_map[i].encoding == encoding)
> +			return raid_map[i].name;
> +	}
> +
> +	return "UNKNOWN";
> +}
> +
> +static void print_raid_stripe_key(const struct extent_buffer *eb, u32 item_size,
> +				  struct btrfs_stripe_extent *stripe)
> +{
> +	int num_stripes = btrfs_num_raid_stripes(item_size);
> +	u8 encoding = btrfs_stripe_extent_encoding(eb, stripe);
> +	int i;
> +
> +	pr_info("\t\t\tencoding: %s\n", stripe_encoding_name(encoding));
> +
> +	for (i = 0; i < num_stripes; i++)
> +		pr_info("\t\t\tstride %d devid %llu physical %llu length %llu\n",
> +			i, btrfs_raid_stride_devid(eb, &stripe->strides[i]),
> +			btrfs_raid_stride_physical(eb, &stripe->strides[i]),
> +			btrfs_raid_stride_length(eb, &stripe->strides[i]));
> +}
> +
>  /*
>   * Helper to output refs and locking status of extent buffer.  Useful to debug
>   * race condition related problems.
> @@ -349,6 +393,11 @@ void btrfs_print_leaf(const struct extent_buffer *l)
>  			print_uuid_item(l, btrfs_item_ptr_offset(l, i),
>  					btrfs_item_size(l, i));
>  			break;
> +		case BTRFS_RAID_STRIPE_KEY:
> +			print_raid_stripe_key(l, btrfs_item_size(l, i),
> +					      btrfs_item_ptr(l, i,
> +							     struct btrfs_stripe_extent));
> +			break;
>  		}
>  	}
>  }
> 
> -- 
> 2.41.0
