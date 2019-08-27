Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2898E9E88C
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 15:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfH0NDG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 09:03:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:41818 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726678AbfH0NDF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 09:03:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C51D6B669
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 13:03:02 +0000 (UTC)
Subject: Re: [PATCH v2 08/11] btrfs-progs: add option for checksum type to
 mkfs
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190826114853.14860-1-jthumshirn@suse.de>
 <20190826114853.14860-9-jthumshirn@suse.de>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <674a511b-9b39-b6d0-cf0a-8dac6e5894ce@suse.com>
Date:   Tue, 27 Aug 2019 16:03:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826114853.14860-9-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 26.08.19 г. 14:48 ч., Johannes Thumshirn wrote:
> Add an option to mkfs to specify which checksum algorithm will be used for
> the filesystem.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  convert/common.c |  2 +-
>  mkfs/common.c    |  2 +-
>  mkfs/common.h    |  2 ++
>  mkfs/main.c      | 21 ++++++++++++++++++++-
>  4 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/convert/common.c b/convert/common.c
> index 7936f8f10b29..8f5fdbf507a4 100644
> --- a/convert/common.c
> +++ b/convert/common.c
> @@ -135,7 +135,7 @@ static int setup_temp_super(int fd, struct btrfs_mkfs_config *cfg,
>  	super->__unused_leafsize = cpu_to_le32(cfg->nodesize);
>  	btrfs_set_super_nodesize(super, cfg->nodesize);
>  	btrfs_set_super_stripesize(super, cfg->stripesize);
> -	btrfs_set_super_csum_type(super, BTRFS_CSUM_TYPE_CRC32);
> +	btrfs_set_super_csum_type(super, cfg->csum_type);
>  	btrfs_set_super_chunk_root(super, chunk_bytenr);
>  	btrfs_set_super_cache_generation(super, -1);
>  	btrfs_set_super_incompat_flags(super, cfg->features);
> diff --git a/mkfs/common.c b/mkfs/common.c
> index 9762391a8d2b..4a417bd7a306 100644
> --- a/mkfs/common.c
> +++ b/mkfs/common.c
> @@ -202,7 +202,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
>  	super.__unused_leafsize = cpu_to_le32(cfg->nodesize);
>  	btrfs_set_super_nodesize(&super, cfg->nodesize);
>  	btrfs_set_super_stripesize(&super, cfg->stripesize);
> -	btrfs_set_super_csum_type(&super, BTRFS_CSUM_TYPE_CRC32);
> +	btrfs_set_super_csum_type(&super, cfg->csum_type);
>  	btrfs_set_super_chunk_root_generation(&super, 1);
>  	btrfs_set_super_cache_generation(&super, -1);
>  	btrfs_set_super_incompat_flags(&super, cfg->features);
> diff --git a/mkfs/common.h b/mkfs/common.h
> index 28912906d0a9..1ca71a4fcce5 100644
> --- a/mkfs/common.h
> +++ b/mkfs/common.h
> @@ -53,6 +53,8 @@ struct btrfs_mkfs_config {
>  	u64 features;
>  	/* Size of the filesystem in bytes */
>  	u64 num_bytes;
> +	/* checksum algorithm to use */
> +	enum btrfs_csum_type csum_type;
>  
>  	/* Output fields, set during creation */
>  
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 8dbec0717b89..075e7e331ab4 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -346,6 +346,7 @@ static void print_usage(int ret)
>  	printf("\t--shrink                (with --rootdir) shrink the filled filesystem to minimal size\n");
>  	printf("\t-K|--nodiscard          do not perform whole device TRIM\n");
>  	printf("\t-f|--force              force overwrite of existing filesystem\n");
> +	printf("\t-C|--checksum           checksum algorithm to use (default: crc32c)\n");
>  	printf("  general:\n");
>  	printf("\t-q|--quiet              no messages except errors\n");
>  	printf("\t-V|--version            print the mkfs.btrfs version and exit\n");
> @@ -380,6 +381,18 @@ static u64 parse_profile(const char *s)
>  	return 0;
>  }
>  
> +static enum btrfs_csum_type parse_csum_type(const char *s)
> +{
> +	if (strcasecmp(s, "crc32c") == 0) {
> +		return BTRFS_CSUM_TYPE_CRC32;
> +	} else {
> +		error("unknown csum type %s", s);
> +		exit(1);
> +	}
> +	/* not reached */
> +	return 0;
> +}
> +
>  static char *parse_label(const char *input)
>  {
>  	int len = strlen(input);
> @@ -826,6 +839,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  	u64 features = BTRFS_MKFS_DEFAULT_FEATURES;
>  	struct mkfs_allocation allocation = { 0 };
>  	struct btrfs_mkfs_config mkfs_cfg;
> +	enum btrfs_csum_type csum_type = BTRFS_CSUM_TYPE_CRC32;
>  
>  	crc32c_optimization_init();
>  
> @@ -835,6 +849,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  		static const struct option long_options[] = {
>  			{ "alloc-start", required_argument, NULL, 'A'},
>  			{ "byte-count", required_argument, NULL, 'b' },
> +			{ "checksum", required_argument, NULL, 'C' },
>  			{ "force", no_argument, NULL, 'f' },
>  			{ "leafsize", required_argument, NULL, 'l' },
>  			{ "label", required_argument, NULL, 'L'},
> @@ -854,7 +869,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  			{ NULL, 0, NULL, 0}
>  		};
>  
> -		c = getopt_long(argc, argv, "A:b:fl:n:s:m:d:L:O:r:U:VMKq",
> +		c = getopt_long(argc, argv, "A:b:C:fl:n:s:m:d:L:O:r:U:VMKq",
>  				long_options, NULL);
>  		if (c < 0)
>  			break;
> @@ -932,6 +947,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  			case GETOPT_VAL_SHRINK:
>  				shrink_rootdir = true;
>  				break;
> +			case 'C':
> +				csum_type = parse_csum_type(optarg);
> +				break;
>  			case GETOPT_VAL_HELP:
>  			default:
>  				print_usage(c != GETOPT_VAL_HELP);
> @@ -1170,6 +1188,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  	mkfs_cfg.sectorsize = sectorsize;
>  	mkfs_cfg.stripesize = stripesize;
>  	mkfs_cfg.features = features;
> +	mkfs_cfg.csum_type = csum_type;
>  
>  	ret = make_btrfs(fd, &mkfs_cfg);
>  	if (ret) {
> 
