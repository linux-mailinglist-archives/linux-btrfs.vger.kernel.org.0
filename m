Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1C4C2E6D
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 09:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbfJAHwp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 03:52:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45084 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfJAHwp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Oct 2019 03:52:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x917iQTr137721;
        Tue, 1 Oct 2019 07:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : cc : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=CQ55M5HTqFbrw1kPDkaahy3idshNt7UvwDcBbWq/qVU=;
 b=JXTn2aPPCXZRfWBnrNo1CbdX60dZCp7BNLz7dbShUvuL5SaCmGbaCHAdg34eYZiSra99
 ZMVFtqOSqHWDiyNlhz4GLmJFbVTexjXrCLPCdWVNNHUNHj6iDj0VH5X6ADtmhCULeVlQ
 2Akpt9vLFPaODIu7RgFa+YY1EaY7fBzLF/eTIcDGJmoU3+qJclwcqheg72NZGIJk+uUv
 tS9oZAfbqJzRHgPJ/ZvmAZ5+fM6pPv7iS0HauhPxT3qTU6HXFD9FHknEnIUFztA1eB0Q
 DcZ/klsXq2E8LHmzlRP2vTM41Yxt0Z48DNYWMZHsJDdtkhl0NxGkMNK92YKHY1WjB2y5 vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2va05rkvrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 07:52:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x917n3q2069689;
        Tue, 1 Oct 2019 07:52:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vbmpy0he2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 07:52:40 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x917qdMQ018743;
        Tue, 1 Oct 2019 07:52:39 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Oct 2019 00:52:39 -0700
Subject: Re: [PATCH v2 RESEND] btrfs-progs: add verbose option to btrfs device
 scan
From:   Anand Jain <anand.jain@oracle.com>
To:     David Sterba <dsterba@suse.com>
References: <1569398832-16277-1-git-send-email-anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <1db59f87-9abc-c0ca-a086-3c65eaa5e629@oracle.com>
Date:   Tue, 1 Oct 2019 15:52:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1569398832-16277-1-git-send-email-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010075
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ping?


On 9/25/19 4:07 PM, Anand Jain wrote:
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
> index 48dbd9e19715..a500edf0f7d7 100644
> --- a/common/device-scan.c
> +++ b/common/device-scan.c
> @@ -360,7 +360,7 @@ void free_seen_fsid(struct seen_fsid *seen_fsid_hash[])
>   	}
>   }
>   
> -int btrfs_scan_devices(void)
> +int btrfs_scan_devices(bool verbose)
>   {
>   	int fd = -1;
>   	int ret;
> @@ -389,6 +389,8 @@ int btrfs_scan_devices(void)
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
> index f2a10cccca86..9a02a80492cb 100644
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
> index 01314504a50a..d5b3e4f793e4 100644
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

