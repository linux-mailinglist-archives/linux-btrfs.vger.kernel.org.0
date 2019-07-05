Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33F4F601AD
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 09:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfGEHp4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 03:45:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:33562 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725863AbfGEHp4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Jul 2019 03:45:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 92787ABC4
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2019 07:45:54 +0000 (UTC)
Subject: Re: [PATCH 1/5] btrfs-progs: mkfs: Apply the sectorsize user
 specified on 64k page size system
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190705072651.25150-1-wqu@suse.com>
 <20190705072651.25150-2-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8b26ebd6-55d7-35ef-0f5e-9136c31db876@suse.com>
Date:   Fri, 5 Jul 2019 10:45:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190705072651.25150-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5.07.19 г. 10:26 ч., Qu Wenruo wrote:
> [BUG]
> On aarch64 with 64k page size, mkfs.btrfs -s option doesn't work:
>   $ mkfs.btrfs  -s 4096 ~/10G.img  -f
>   btrfs-progs v5.1.1
>   See http://btrfs.wiki.kernel.org for more information.
> 
>   Label:              (null)
>   UUID:               c2a09334-aaca-4980-aefa-4b3e27390658
>   Node size:          65536
>   Sector size:        65536		<< Still 64K, not 4K
>   Filesystem size:    10.00GiB
>   Block group profiles:
>     Data:             single            8.00MiB
>     Metadata:         DUP             256.00MiB
>     System:           DUP               8.00MiB
>   SSD detected:       no
>   Incompat features:  extref, skinny-metadata
>   Number of devices:  1
>   Devices:
>      ID        SIZE  PATH
>       1    10.00GiB  /home/adam/10G.img
> 
> [CAUSE]
> This is because we automatically detect sectorsize based on current
> system page size, then get the maxium number between user specified -s
> parameter and system page size.
> 
> It's fine for x86 as it has fixed page size 4K, also the minimium valid
> sector size.
> 
> But for system like aarch64 or ppc64le, where we can have 64K page size,
> and it makes us unable to create a 4k sector sized btrfs.
> 
> [FIX]
> Only do auto detect when no -s|--sectorsize option is specified.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  mkfs/main.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 8dbec0717b89..26d84e9dafc3 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -817,6 +817,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  	char *source_dir = NULL;
>  	bool source_dir_set = false;
>  	bool shrink_rootdir = false;
> +	bool sectorsize_set = false;
>  	u64 source_dir_size = 0;
>  	u64 min_dev_size;
>  	u64 shrink_size;
> @@ -906,6 +907,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  				}
>  			case 's':
>  				sectorsize = parse_size(optarg);
> +				sectorsize_set = true;
>  				break;
>  			case 'b':
>  				block_count = parse_size(optarg);
> @@ -943,7 +945,15 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  		printf("See %s for more information.\n\n", PACKAGE_URL);
>  	}
>  
> -	sectorsize = max(sectorsize, (u32)sysconf(_SC_PAGESIZE));
> +	if (!sectorsize_set)
> +		sectorsize = max(sectorsize, (u32)sysconf(_SC_PAGESIZE));

This means it's possible for the user to create a filesystem that is not
mountable on his current machine, due to the presence of the following
check in validate_super:

if (sectorsize != PAGE_SIZE) {
btrfs_err(..)
}

Perhaps the risk is not that big since if someone creates such a
filesystem they will almost instantly realize it won't work and
re-create it properly.



> +	if (!is_power_of_2(sectorsize) || sectorsize < 4096 ||
> +	    sectorsize > SZ_64K) {

nit: Perhaps this check should be modified so that it follows the kernel
style :
if (!is_power_of_2(sectorsize) || sectorsize < 4096 ||
              sectorsize > BTRFS_MAX_METADATA_BLOCKSIZE) {

MAX_METADATA_BLOCKSIZE is defined as 64k but using the same defines
seems more clear to me.


> +		error(
> +		"invalid sectorsize: %u, expect either 4k, 8k, 16k, 32k or 64k",
> +			sectorsize);
> +		goto error;
> +	}
>  	stripesize = sectorsize;
>  	saved_optind = optind;
>  	dev_cnt = argc - optind;
> 
