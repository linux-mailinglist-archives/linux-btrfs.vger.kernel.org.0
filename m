Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 150B01C9CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2019 16:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfENOAM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 May 2019 10:00:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:53724 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbfENOAM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 May 2019 10:00:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8959AAFCB
        for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2019 14:00:10 +0000 (UTC)
Subject: Re: [PATCH v3.1 1/3] btrfs-progs: factor out super_block reading from
 load_and_dump_sb
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190514132532.16934-2-jthumshirn@suse.de>
 <20190514135804.18669-1-jthumshirn@suse.de>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <29fd946a-2e64-b6e6-bc9e-8c3506757a0f@suse.com>
Date:   Tue, 14 May 2019 17:00:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514135804.18669-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14.05.19 г. 16:58 ч., Johannes Thumshirn wrote:
> inspect-internal dump-superblock's load_and_dump_sb() already reads a
> super block from a file descriptor and places it into a 'struct
> btrfs_super_block'.
> 
> For inspect-internal dump-csum we need this super block as well but don't
> care about printing it.
> 
> Separate the read from the dump phase so we can re-use it elsewhere.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>


> ---
> - Fix double sizeof() @!$#$ (Nikolay)
> 
>  cmds-inspect-dump-super.c | 15 ++++++---------
>  utils.c                   | 15 +++++++++++++++
>  utils.h                   |  2 ++
>  3 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/cmds-inspect-dump-super.c b/cmds-inspect-dump-super.c
> index 7815c863f2ed..879f979f526a 100644
> --- a/cmds-inspect-dump-super.c
> +++ b/cmds-inspect-dump-super.c
> @@ -477,16 +477,13 @@ static void dump_superblock(struct btrfs_super_block *sb, int full)
>  static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
>  		int force)
>  {
> -	u8 super_block_data[BTRFS_SUPER_INFO_SIZE];
> -	struct btrfs_super_block *sb;
> +	struct btrfs_super_block sb;
>  	u64 ret;
>  
> -	sb = (struct btrfs_super_block *)super_block_data;
> -
> -	ret = pread64(fd, super_block_data, BTRFS_SUPER_INFO_SIZE, sb_bytenr);
> -	if (ret != BTRFS_SUPER_INFO_SIZE) {
> +	ret = load_sb(fd, sb_bytenr, &sb);
> +	if (ret) {
>  		/* check if the disk if too short for further superblock */
> -		if (ret == 0 && errno == 0)
> +		if (ret == -ENOSPC)
>  			return 0;
>  
>  		error("failed to read the superblock on %s at %llu",
> @@ -496,11 +493,11 @@ static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
>  	}
>  	printf("superblock: bytenr=%llu, device=%s\n", sb_bytenr, filename);
>  	printf("---------------------------------------------------------\n");
> -	if (btrfs_super_magic(sb) != BTRFS_MAGIC && !force) {
> +	if (btrfs_super_magic(&sb) != BTRFS_MAGIC && !force) {
>  		error("bad magic on superblock on %s at %llu",
>  				filename, (unsigned long long)sb_bytenr);
>  	} else {
> -		dump_superblock(sb, full);
> +		dump_superblock(&sb, full);
>  	}
>  	return 0;
>  }
> diff --git a/utils.c b/utils.c
> index 9e26c884cc6c..f0ae53ded315 100644
> --- a/utils.c
> +++ b/utils.c
> @@ -2593,3 +2593,18 @@ void print_all_devices(struct list_head *devices)
>  		print_device_info(dev, "\t");
>  	printf("\n");
>  }
> +
> +int load_sb(int fd, u64 bytenr, struct btrfs_super_block *sb)
> +{
> +	size_t size = sizeof(struct btrfs_super_block);
> +	int ret;
> +
> +	ret = pread64(fd, sb, size, bytenr);
> +	if (ret != size) {
> +		if (ret == 0 && errno == 0)
> +			return -EINVAL;
> +
> +		return -errno;
> +	}
> +	return 0;
> +}
> diff --git a/utils.h b/utils.h
> index 7c5eb798557d..f0b9ec372893 100644
> --- a/utils.h
> +++ b/utils.h
> @@ -171,6 +171,8 @@ unsigned long total_memory(void);
>  void print_device_info(struct btrfs_device *device, char *prefix);
>  void print_all_devices(struct list_head *devices);
>  
> +int load_sb(int fd, u64 bytenr, struct btrfs_super_block *sb);
> +
>  /*
>   * Global program state, configurable by command line and available to
>   * functions without extra context passing.
> 
