Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A61009FC3A
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 09:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfH1HvW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Aug 2019 03:51:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38044 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfH1HvV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Aug 2019 03:51:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7S7nUWR137570
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 07:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2019-08-05;
 bh=cZpexP4MJHd09wh58zYRgh9RZy/ZIasGiWA/6GLJmKo=;
 b=VRU9Iu9tJvTm0N0XZDVb0pihZE0ox+4jY/VVR/VQdjiO+5yAbZ+6Q7LzGsPAPtl638ZF
 amv5PyxRwbXmjSH4e6H+yZNxkpwzizguO/aIybN5IB53Y75ybtFAOM+HnMFSM6TyBewr
 oezcaCSAIlCpKErxD1J0fPBNMlFRz/fadIUeBnOTP31UtO3U0NbNln7Ni7tFXOZGuVMI
 zBWTfjQC+kmHTIo9feAc9uhuS4z4n9E0VP6YUXFYFSZSh1fJudzqRgxjAyWFAKUTBqW3
 aPE8ufW7Cui13rUk+IYgYseP9qxVCBboOsGVpyQFqAipNdPNw9SkVYqET2XtCuZSLZIB XA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2unngag10c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 07:51:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7S7mInw183381
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 07:51:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2undupn14s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 07:51:19 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7S7pITE022178
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 07:51:19 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Aug 2019 00:51:18 -0700
Subject: Re: [PATCH v2] btrfs-progs: add verbose option to btrfs device scan
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
References: <20190715144241.1077-1-anand.jain@oracle.com>
 <20190716030514.1152-1-anand.jain@oracle.com>
Message-ID: <11e67be8-1fea-4a11-2e74-42a9928ade78@oracle.com>
Date:   Wed, 28 Aug 2019 15:51:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190716030514.1152-1-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908280082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908280082
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ping?

Thanks, Anand


On 16/7/19 11:05 AM, Anand Jain wrote:
> To help debug device scan issues, add verbose option to btrfs device scan.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: Use bool instead of int as a btrfs_scan_device() argument.
> 
>   cmds/device.c        | 8 ++++++--
>   cmds/filesystem.c    | 2 +-
>   common/device-scan.c | 4 +++-
>   common/device-scan.h | 3 ++-
>   common/utils.c       | 2 +-
>   disk-io.c            | 2 +-
>   6 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/cmds/device.c b/cmds/device.c
> index 24158308a41b..9b715ffc42a3 100644
> --- a/cmds/device.c
> +++ b/cmds/device.c
> @@ -313,6 +313,7 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
>   	int all = 0;
>   	int ret = 0;
>   	int forget = 0;
> +	bool verbose = false;
>   
>   	optind = 0;
>   	while (1) {
> @@ -323,7 +324,7 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
>   			{ NULL, 0, NULL, 0}
>   		};
>   
> -		c = getopt_long(argc, argv, "du", long_options, NULL);
> +		c = getopt_long(argc, argv, "duv", long_options, NULL);
>   		if (c < 0)
>   			break;
>   		switch (c) {
> @@ -333,6 +334,9 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
>   		case 'u':
>   			forget = 1;
>   			break;
> +		case 'v':
> +			verbose = true;
> +			break;
>   		default:
>   			usage_unknown_option(cmd, argv);
>   		}
> @@ -354,7 +358,7 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
>   			}
>   		} else {
>   			printf("Scanning for Btrfs filesystems\n");
> -			ret = btrfs_scan_devices();
> +			ret = btrfs_scan_devices(verbose);
>   			error_on(ret, "error %d while scanning", ret);
>   			ret = btrfs_register_all_devices();
>   			error_on(ret,
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index 4f22089abeaa..02d47a43a792 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -746,7 +746,7 @@ devs_only:
>   		else
>   			ret = 1;
>   	} else {
> -		ret = btrfs_scan_devices();
> +		ret = btrfs_scan_devices(false);
>   	}
>   
>   	if (ret) {
> diff --git a/common/device-scan.c b/common/device-scan.c
> index 2c5ae225f710..71c91dee6a86 100644
> --- a/common/device-scan.c
> +++ b/common/device-scan.c
> @@ -351,7 +351,7 @@ void free_seen_fsid(struct seen_fsid *seen_fsid_hash[])
>   	}
>   }
>   
> -int btrfs_scan_devices(void)
> +int btrfs_scan_devices(bool verbose)
>   {
>   	int fd = -1;
>   	int ret;
> @@ -380,6 +380,8 @@ int btrfs_scan_devices(void)
>   			continue;
>   		/* if we are here its definitely a btrfs disk*/
>   		strncpy_null(path, blkid_dev_devname(dev));
> +		if (verbose)
> +			printf("blkid: btrfs device: %s\n", path);
>   
>   		fd = open(path, O_RDONLY);
>   		if (fd < 0) {
> diff --git a/common/device-scan.h b/common/device-scan.h
> index eda2bae5c6c4..3e473c48d1af 100644
> --- a/common/device-scan.h
> +++ b/common/device-scan.h
> @@ -1,6 +1,7 @@
>   #ifndef __DEVICE_SCAN_H__
>   #define __DEVICE_SCAN_H__
>   
> +#include <stdbool.h>
>   #include "kerncompat.h"
>   #include "ioctl.h"
>   
> @@ -29,7 +30,7 @@ struct seen_fsid {
>   	int fd;
>   };
>   
> -int btrfs_scan_devices(void);
> +int btrfs_scan_devices(bool verbose);
>   int btrfs_register_one_device(const char *fname);
>   int btrfs_register_all_devices(void);
>   int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
> diff --git a/common/utils.c b/common/utils.c
> index ad938409a94f..07648f07fbd4 100644
> --- a/common/utils.c
> +++ b/common/utils.c
> @@ -277,7 +277,7 @@ int check_mounted_where(int fd, const char *file, char *where, int size,
>   
>   	/* scan other devices */
>   	if (is_btrfs && total_devs > 1) {
> -		ret = btrfs_scan_devices();
> +		ret = btrfs_scan_devices(false);
>   		if (ret)
>   			return ret;
>   	}
> diff --git a/disk-io.c b/disk-io.c
> index be44eead5cef..71ed78b671da 100644
> --- a/disk-io.c
> +++ b/disk-io.c
> @@ -1085,7 +1085,7 @@ int btrfs_scan_fs_devices(int fd, const char *path,
>   	}
>   
>   	if (!skip_devices && total_devs != 1) {
> -		ret = btrfs_scan_devices();
> +		ret = btrfs_scan_devices(false);
>   		if (ret)
>   			return ret;
>   	}
> 

