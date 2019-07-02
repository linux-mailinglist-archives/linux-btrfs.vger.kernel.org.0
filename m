Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E32915CB4A
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 10:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfGBIJH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jul 2019 04:09:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59720 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbfGBIJH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Jul 2019 04:09:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x62890Jk062246
        for <linux-btrfs@vger.kernel.org>; Tue, 2 Jul 2019 08:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2018-07-02;
 bh=JRIWFGHUit7hEdlB3aCv4Mpt1vIl9Cicg6eH0c3doTo=;
 b=raq9utfdGKQ0MjpiuujlB4frNEt9ytFJdWO/obSqPJrQmGCGU1B5tQ5jtjMjkCWeMFoH
 h6uY/eZD7WJ9TQwR5ypstEfgCCN5v3JDb+bHmYokvtuzPW2dcMbeQl2U9x2o6QAftgfb
 6UQ+11GWjdeF5AWvLxNNpNb7I0rsDF+0IktwCkHEpN1NC2x9aGysdmUCokl4q3DBr3DR
 2wsbMbcdryNRNMnsuIuGh80lKPjIEphmh2NrnAT5XqX6p00Ybkv3MbeGYfEKYIhq2bZT
 39haM/u175saVY/6k4vo5umFW4YpF6BQiE89ZxexGSlGVr6sNU/r+0juTG1mr/s2rpgZ hg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2te61e1udx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Jul 2019 08:09:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6287T7J024594
        for <linux-btrfs@vger.kernel.org>; Tue, 2 Jul 2019 08:09:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tebbjm64u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Jul 2019 08:09:05 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x62894ZK027055
        for <linux-btrfs@vger.kernel.org>; Tue, 2 Jul 2019 08:09:04 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jul 2019 01:09:04 -0700
Subject: Re: [PATCH v7 RESEND Rebased] btrfs-progs: dump-tree: add noscan
 option
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
References: <20190626083017.1833-1-anand.jain@oracle.com>
Message-ID: <93dbcda3-fe9a-035c-59fc-b39448d1c867@oracle.com>
Date:   Tue, 2 Jul 2019 16:09:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190626083017.1833-1-anand.jain@oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907020095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907020095
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ping?



On 26/6/19 4:30 PM, Anand Jain wrote:
> From: Anand Jain <Anand.Jain@oracle.com>
> 
> The cli 'btrfs inspect dump-tree <dev>' will scan for the partner devices
> if any by default.
> 
> So as of now you can not inspect each mirrored device independently.
> 
> This patch adds noscan option, which when used won't scan the system for
> the partner devices, instead it just uses the devices provided in the
> argument.
> 
> For example:
>    btrfs inspect dump-tree --noscan <dev> [<dev>..]
> 
> This helps to debug degraded raid1 and raid10.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v6->v7: rebase on latest btrfs-progs::devel
> v5->v6: rebase on latest btrfs-progs::devel
> v4->v5: nit: use %m to print error string.
> 	changelog update.
> v3->v4: change the patch title.
> 	collapse scan_args() to its only parent cmd_inspect_dump_tree()
> 	(it was bit confusing).
> 	update the change log.
> 	update usage.
> 	update man page.
> v2->v3: make it scalable for more than two disks in noscan mode
> v1->v2: rename --degraded to --noscan
>   Documentation/btrfs-inspect-internal.asciidoc |  5 +-
>   cmds-inspect-dump-tree.c                      | 53 ++++++++++++++-----
>   2 files changed, 45 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/btrfs-inspect-internal.asciidoc b/Documentation/btrfs-inspect-internal.asciidoc
> index 210f18c30a40..c9962ab3b548 100644
> --- a/Documentation/btrfs-inspect-internal.asciidoc
> +++ b/Documentation/btrfs-inspect-internal.asciidoc
> @@ -61,7 +61,7 @@ specify which mirror to print, valid values are 0, 1 and 2 and the superblock
>   must be present on the device with a valid signature, can be used together with
>   '--force'
>   
> -*dump-tree* [options] <device>::
> +*dump-tree* [options] <device> [device...]::
>   (replaces the standalone tool *btrfs-debug-tree*)
>   +
>   Dump tree structures from a given device in textual form, expand keys to human
> @@ -95,6 +95,9 @@ intermixed in the output
>   --bfs::::
>   use breadth-first search to print trees. the nodes are printed before all
>   leaves
> +--device::::
> +do not scan the system for other partner device(s), only use the device(s)
> +provided in the argument
>   -t <tree_id>::::
>   print only the tree with the specified ID, where the ID can be numerical or
>   common name in a flexible human readable form
> diff --git a/cmds-inspect-dump-tree.c b/cmds-inspect-dump-tree.c
> index 1588a0b0774b..8e13b4335a5d 100644
> --- a/cmds-inspect-dump-tree.c
> +++ b/cmds-inspect-dump-tree.c
> @@ -21,6 +21,7 @@
>   #include <unistd.h>
>   #include <uuid/uuid.h>
>   #include <getopt.h>
> +#include <fcntl.h>
>   
>   #include "kerncompat.h"
>   #include "radix-tree.h"
> @@ -185,7 +186,7 @@ static u64 treeid_from_string(const char *str, const char **end)
>   }
>   
>   static const char * const cmd_inspect_dump_tree_usage[] = {
> -	"btrfs inspect-internal dump-tree [options] device",
> +	"btrfs inspect-internal dump-tree [options] <device> [<device> ..]",
>   	"Dump tree structures from a given device",
>   	"Dump tree structures from a given device in textual form, expand keys to human",
>   	"readable equivalents where possible.",
> @@ -201,6 +202,7 @@ static const char * const cmd_inspect_dump_tree_usage[] = {
>   	"                       can be specified multiple times",
>   	"-t|--tree <tree_id>    print only tree with the given id (string or number)",
>   	"--follow               use with -b, to show all children tree blocks of <block_num>",
> +	"--noscan               do not scan for the partner device(s)",
>   	NULL
>   };
>   
> @@ -297,7 +299,7 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
>   	struct btrfs_key found_key;
>   	struct cache_tree block_root;	/* for multiple --block parameters */
>   	char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
> -	int ret;
> +	int ret = 0;
>   	int slot;
>   	int extent_only = 0;
>   	int device_only = 0;
> @@ -305,6 +307,7 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
>   	int roots_only = 0;
>   	int root_backups = 0;
>   	int traverse = BTRFS_PRINT_TREE_DEFAULT;
> +	int dev_optind;
>   	unsigned open_ctree_flags;
>   	u64 block_bytenr;
>   	struct btrfs_root *tree_root_scan;
> @@ -323,8 +326,8 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
>   	optind = 0;
>   	while (1) {
>   		int c;
> -		enum { GETOPT_VAL_FOLLOW = 256, GETOPT_VAL_DFS,
> -		       GETOPT_VAL_BFS };
> +		enum { GETOPT_VAL_FOLLOW = 256, GETOPT_VAL_DFS, GETOPT_VAL_BFS,
> +		       GETOPT_VAL_NOSCAN};
>   		static const struct option long_options[] = {
>   			{ "extents", no_argument, NULL, 'e'},
>   			{ "device", no_argument, NULL, 'd'},
> @@ -336,6 +339,7 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
>   			{ "follow", no_argument, NULL, GETOPT_VAL_FOLLOW },
>   			{ "bfs", no_argument, NULL, GETOPT_VAL_BFS },
>   			{ "dfs", no_argument, NULL, GETOPT_VAL_DFS },
> +			{ "noscan", no_argument, NULL, GETOPT_VAL_NOSCAN },
>   			{ NULL, 0, NULL, 0 }
>   		};
>   
> @@ -400,24 +404,49 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
>   		case GETOPT_VAL_BFS:
>   			traverse = BTRFS_PRINT_TREE_BFS;
>   			break;
> +		case GETOPT_VAL_NOSCAN:
> +			open_ctree_flags |= OPEN_CTREE_NO_DEVICES;
> +			break;
>   		default:
>   			usage_unknown_option(cmd, argv);
>   		}
>   	}
>   
> -	if (check_argc_exact(argc - optind, 1))
> +	if (check_argc_min(argc - optind, 1))
>   		return 1;
>   
> -	ret = check_arg_type(argv[optind]);
> -	if (ret != BTRFS_ARG_BLKDEV && ret != BTRFS_ARG_REG) {
> +	dev_optind = optind;
> +	while (dev_optind < argc) {
> +		int fd;
> +		struct btrfs_fs_devices *fs_devices;
> +		u64 num_devices;
> +
> +		ret = check_arg_type(argv[optind]);
> +		if (ret != BTRFS_ARG_BLKDEV && ret != BTRFS_ARG_REG) {
> +			if (ret < 0) {
> +				errno = -ret;
> +				error("invalid argument %s: %m", argv[dev_optind]);
> +			} else {
> +				error("not a block device or regular file: %s",
> +				       argv[dev_optind]);
> +			}
> +		}
> +		fd = open(argv[dev_optind], O_RDONLY);
> +		if (fd < 0) {
> +			error("cannot open %s: %m", argv[dev_optind]);
> +			return -EINVAL;
> +		}
> +		ret = btrfs_scan_one_device(fd, argv[dev_optind], &fs_devices,
> +					    &num_devices,
> +					    BTRFS_SUPER_INFO_OFFSET,
> +					    SBREAD_DEFAULT);
> +		close(fd);
>   		if (ret < 0) {
>   			errno = -ret;
> -			error("invalid argument %s: %m", argv[optind]);
> -		} else {
> -			error("not a block device or regular file: %s",
> -			      argv[optind]);
> +			error("device scan %s: %m", argv[dev_optind]);
> +			return ret;
>   		}
> -		goto out;
> +		dev_optind++;
>   	}
>   
>   	printf("%s\n", PACKAGE_STRING);
> 

