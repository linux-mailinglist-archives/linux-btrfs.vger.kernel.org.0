Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B661569735
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2019 17:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbfGOPJQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jul 2019 11:09:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:49980 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730971AbfGOPJP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jul 2019 11:09:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E972CAD2B;
        Mon, 15 Jul 2019 15:09:13 +0000 (UTC)
Subject: Re: [PATCH] btrfs-progs: add verbose option to btrfs device scan
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20190715144241.1077-1-anand.jain@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4f150d66-0c4d-b0f2-4cf9-9bc1194d83e9@suse.com>
Date:   Mon, 15 Jul 2019 18:09:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715144241.1077-1-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15.07.19 г. 17:42 ч., Anand Jain wrote:
> To help debug device scan issues, add verbose option to btrfs device scan.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

I fail to see what this patch helps for. We get the path in case of
errors, in case of success what good could the path be ?


> ---
>  cmds/device.c        | 8 ++++++--
>  cmds/filesystem.c    | 2 +-
>  common/device-scan.c | 4 +++-
>  common/device-scan.h | 2 +-
>  common/utils.c       | 2 +-
>  disk-io.c            | 2 +-
>  6 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/cmds/device.c b/cmds/device.c
> index 24158308a41b..2fa13e61f806 100644
> --- a/cmds/device.c
> +++ b/cmds/device.c
> @@ -313,6 +313,7 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
>  	int all = 0;
>  	int ret = 0;
>  	int forget = 0;
> +	int verbose = 0;

nit: make it a bool.

>  
>  	optind = 0;
>  	while (1) {
> @@ -323,7 +324,7 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
>  			{ NULL, 0, NULL, 0}
>  		};
>  
> -		c = getopt_long(argc, argv, "du", long_options, NULL);
> +		c = getopt_long(argc, argv, "duv", long_options, NULL);
>  		if (c < 0)
>  			break;
>  		switch (c) {
> @@ -333,6 +334,9 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
>  		case 'u':
>  			forget = 1;
>  			break;
> +		case 'v':
> +			verbose = 1;
> +			break;
>  		default:
>  			usage_unknown_option(cmd, argv);
>  		}
> @@ -354,7 +358,7 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
>  			}
>  		} else {
>  			printf("Scanning for Btrfs filesystems\n");
> -			ret = btrfs_scan_devices();
> +			ret = btrfs_scan_devices(verbose);
>  			error_on(ret, "error %d while scanning", ret);
>  			ret = btrfs_register_all_devices();
>  			error_on(ret,
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index 4f22089abeaa..37b23af36847 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -746,7 +746,7 @@ devs_only:
>  		else
>  			ret = 1;
>  	} else {
> -		ret = btrfs_scan_devices();
> +		ret = btrfs_scan_devices(0);
>  	}
>  
>  	if (ret) {
> diff --git a/common/device-scan.c b/common/device-scan.c
> index 2c5ae225f710..bea201b351f0 100644
> --- a/common/device-scan.c
> +++ b/common/device-scan.c
> @@ -351,7 +351,7 @@ void free_seen_fsid(struct seen_fsid *seen_fsid_hash[])
>  	}
>  }
>  
> -int btrfs_scan_devices(void)
> +int btrfs_scan_devices(int verbose)
>  {
>  	int fd = -1;
>  	int ret;
> @@ -380,6 +380,8 @@ int btrfs_scan_devices(void)
>  			continue;
>  		/* if we are here its definitely a btrfs disk*/
>  		strncpy_null(path, blkid_dev_devname(dev));
> +		if (verbose)
> +			printf("blkid: btrfs device: %s\n", path);
>  
>  		fd = open(path, O_RDONLY);
>  		if (fd < 0) {
> diff --git a/common/device-scan.h b/common/device-scan.h
> index eda2bae5c6c4..8017a27511b9 100644
> --- a/common/device-scan.h
> +++ b/common/device-scan.h
> @@ -29,7 +29,7 @@ struct seen_fsid {
>  	int fd;
>  };
>  
> -int btrfs_scan_devices(void);
> +int btrfs_scan_devices(int verbose);
>  int btrfs_register_one_device(const char *fname);
>  int btrfs_register_all_devices(void);
>  int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
> diff --git a/common/utils.c b/common/utils.c
> index ad938409a94f..36ce89a025f1 100644
> --- a/common/utils.c
> +++ b/common/utils.c
> @@ -277,7 +277,7 @@ int check_mounted_where(int fd, const char *file, char *where, int size,
>  
>  	/* scan other devices */
>  	if (is_btrfs && total_devs > 1) {
> -		ret = btrfs_scan_devices();
> +		ret = btrfs_scan_devices(0);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/disk-io.c b/disk-io.c
> index be44eead5cef..4f52a29700ab 100644
> --- a/disk-io.c
> +++ b/disk-io.c
> @@ -1085,7 +1085,7 @@ int btrfs_scan_fs_devices(int fd, const char *path,
>  	}
>  
>  	if (!skip_devices && total_devs != 1) {
> -		ret = btrfs_scan_devices();
> +		ret = btrfs_scan_devices(0);
>  		if (ret)
>  			return ret;
>  	}
> 
