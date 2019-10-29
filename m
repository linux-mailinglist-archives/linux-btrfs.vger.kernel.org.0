Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96149E7E64
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2019 03:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbfJ2CGQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Oct 2019 22:06:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43788 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfJ2CGP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Oct 2019 22:06:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9T24dxc122670;
        Tue, 29 Oct 2019 02:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=2vEPDl7eBdldMoBtFXOQXUNPGJg8cBrnmVpnoNele2M=;
 b=KhBLZhVignB50mAvPDkA8oa+W8IHRfHxKdtGodoSO6sNw2OGocL8yXT6eqyTykqeuaSv
 U1b1a0R0mvJfouaxOGBSK0p28pICQ9TfoHEa6nth/+I0A5qh9B1BTPmcmUKWOi6e7o6P
 y6WQBb3+IxW/d0q5z9YlbVvqtexJtrK76+8bkQ7b9arcw9n5dim5Al+5/Cw/yr3USU+W
 8KnvU6Yr4mjXz2Gz2tZQBGNENdU/qPtNAR7o4lwM0UrUAXHMz6soz4rBjwsCqzcgcsMJ
 1XrP9wrlb6Z2tgIDUWff8AgKs9DWBkvST8N2bPqt/gAqOpdp+km8hHfEIBqnoZ/PJNX3 2g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2vvdju5tn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 02:06:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9T2343I067011;
        Tue, 29 Oct 2019 02:06:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vvyn0th9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 02:06:07 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9T267kH030460;
        Tue, 29 Oct 2019 02:06:07 GMT
Received: from [172.20.10.11] (/183.90.36.217)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Oct 2019 19:06:07 -0700
Subject: Re: [PATCH devel] btrfs-progs: subvolume: Implement delete --subvolid
 <path>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org, mpdesouza@suse.com
References: <20191028160506.22245-1-marcos.souza.org@gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <cb24c0bb-121e-08bc-9138-16abb1f2727a@oracle.com>
Date:   Tue, 29 Oct 2019 10:05:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191028160506.22245-1-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9424 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910290020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9424 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910290021
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/10/19 12:05 AM, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> With this patch a user can delete a subvolume from a btrfs using only
> the subvolume id in the format
> 
> btrfs subvolume delete --subvolid <volid> <path>
> 
> Fixes: #152
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>   Documentation/btrfs-subvolume.asciidoc        | 10 ++++-
>   cmds/subvolume.c                              | 39 +++++++++++++++++--
>   tests/misc-tests/038-delete-subvolume/test.sh | 30 ++++++++++++++
>   3 files changed, 75 insertions(+), 4 deletions(-)
>   create mode 100755 tests/misc-tests/038-delete-subvolume/test.sh
> 
> diff --git a/Documentation/btrfs-subvolume.asciidoc b/Documentation/btrfs-subvolume.asciidoc
> index 49c72e89..9492fc19 100644
> --- a/Documentation/btrfs-subvolume.asciidoc
> +++ b/Documentation/btrfs-subvolume.asciidoc
> @@ -59,12 +59,17 @@ directory.
>   Add the newly created subvolume to a qgroup. This option can be given multiple
>   times.
>   
> -*delete* [options] <subvolume> [<subvolume>...]::
> +*delete* [options] <subvolume> [<subvolume>...]
> +
> +*delete* [options] [--subvolid <subvolid> <path>]::
>   Delete the subvolume(s) from the filesystem.
>   +
>   If <subvolume> is not a subvolume, btrfs returns an error but continues if
>   there are more arguments to process.
>   +
> +If --subvolid if used, <path> must point to a btrfs filesystem. See `btrfs
> +subvolume list` how to get the subvolume id.
> ++
>   The corresponding directory is removed instantly but the data blocks are
>   removed later in the background. The command returns immediately. See `btrfs
>   subvolume sync` how to wait until the subvolume gets completely removed.
> @@ -84,6 +89,9 @@ wait for transaction commit after deleting each subvolume.
>   +
>   -v|--verbose::::
>   verbose output of operations.
> ++
> +-s|--subvolid::::
> +subvolume id of the to be removed subvolume from <path>
>   
>   *find-new* <subvolume> <last_gen>::
>   List the recently modified files in a subvolume, after <last_gen> generation.
> diff --git a/cmds/subvolume.c b/cmds/subvolume.c
> index 7a5fd79b..df75f82d 100644
> --- a/cmds/subvolume.c
> +++ b/cmds/subvolume.c
> @@ -223,6 +223,7 @@ static int wait_for_commit(int fd)
>   
>   static const char * const cmd_subvol_delete_usage[] = {
>   	"btrfs subvolume delete [options] <subvolume> [<subvolume>...]",
> +	"btrfs subvolume delete [options] [--subvolid <subvolid> <path>]",


It should rather be..

+ "btrfs subvolume delete [options] <[-s|--subvolid <subvolid> <path>] | 
[<subvolume>...]>"

Which means..
  either -s|--subvolid <subvolid> OR the <subvolume> is mandatory option.


>   	"Delete subvolume(s)",
>   	"Delete subvolumes from the filesystem. The corresponding directory",
>   	"is removed instantly but the data blocks are removed later.",
> @@ -234,6 +235,7 @@ static const char * const cmd_subvol_delete_usage[] = {
>   	"-c|--commit-after      wait for transaction commit at the end of the operation",
>   	"-C|--commit-each       wait for transaction commit after deleting each subvolume",
>   	"-v|--verbose           verbose output of operations",
> +	"-s|--subvolid          subvolume id of the to be removed subvolume",
>   	NULL
>   };
>   
> @@ -246,11 +248,12 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
>   	char	*dname, *vname, *cpath;
>   	char	*dupdname = NULL;
>   	char	*dupvname = NULL;
> -	char	*path;
> +	char	*path = NULL;
>   	DIR	*dirstream = NULL;
>   	int verbose = 0;
>   	int commit_mode = 0;
>   	u8 fsid[BTRFS_FSID_SIZE];
> +	u64 objectid = 0;
>   	char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
>   	struct seen_fsid *seen_fsid_hash[SEEN_FSID_HASH_SIZE] = { NULL, };
>   	enum { COMMIT_AFTER = 1, COMMIT_EACH = 2 };
> @@ -262,11 +265,12 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
>   		static const struct option long_options[] = {
>   			{"commit-after", no_argument, NULL, 'c'},
>   			{"commit-each", no_argument, NULL, 'C'},
> +			{"subvolid", required_argument, NULL, 's'},
>   			{"verbose", no_argument, NULL, 'v'},
>   			{NULL, 0, NULL, 0}
>   		};
>   
> -		c = getopt_long(argc, argv, "cCv", long_options, NULL);
> +		c = getopt_long(argc, argv, "cCvs:", long_options, NULL);
>   		if (c < 0)
>   			break;
>   
> @@ -280,6 +284,9 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
>   		case 'v':
>   			verbose++;
>   			break;
> +		case 's':
> +			objectid = arg_strtou64(optarg);
> +			break;
>   		default:
>   			usage_unknown_option(cmd, argv);
>   		}
> @@ -288,6 +295,10 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
>   	if (check_argc_min(argc - optind, 1))
>   		return 1;
>   
> +	/* when using --subvolid, ensure that we have only one argument */
> +	if (objectid > 0 && check_argc_exact(argc - optind, 1))
> +		return 1;
> +
>   	if (verbose > 0) {
>   		printf("Transaction commit: %s\n",
>   			!commit_mode ? "none (default)" :
> @@ -296,8 +307,30 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
>   
>   	cnt = optind;
>   
> +	/* check the following syntax: subvolume delete --subvolid <volid> <path> */
                                                                    ^sub

Thanks, Anand


> +	if (objectid > 0) {
> +		char *subvol, full_volpath[BTRFS_SUBVOL_NAME_MAX];
> +
> +		path = argv[cnt];
> +		err = btrfs_util_subvolume_path(path, objectid, &subvol);
> +		if (err) {
> +			error_btrfs_util(err);
> +			ret = 1;
> +			goto out;
> +		}
> +
> +		/* build new volpath using the volume name found */
> +		sprintf(full_volpath, "%s/%s", path, subvol);
> +		free(subvol);
> +
> +		/* update path to the built path from the subvol id */
> +		path = full_volpath;
> +	}
> +
>   again:
> -	path = argv[cnt];
> +	/* if subvolid is used, path will already be populated */
> +	if (objectid == 0)
> +		path = argv[cnt];
>   
>   	err = btrfs_util_is_subvolume(path);
>   	if (err) {
> diff --git a/tests/misc-tests/038-delete-subvolume/test.sh b/tests/misc-tests/038-delete-subvolume/test.sh
> new file mode 100755
> index 00000000..9137e0d3
> --- /dev/null
> +++ b/tests/misc-tests/038-delete-subvolume/test.sh
> @@ -0,0 +1,30 @@
> +#!/bin/bash
> +# test btrfs subvolume delete --subvolid <volid> <path>
> +
> +source "$TEST_TOP/common"
> +
> +check_prereq mkfs.btrfs
> +check_prereq btrfs
> +
> +setup_root_helper
> +prepare_test_dev
> +
> +run_check_mkfs_test_dev
> +run_check_mount_test_dev
> +
> +run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT"/mysubvol1
> +
> +# subvolid expected failures
> +run_mustfail "subvolume delete --subvolid expects an integer" \
> +	$SUDO_HELPER "$TOP/btrfs" subvolume delete --subvolid aaa "$TEST_MNT"
> +
> +run_mustfail "subvolume delete --subvolid with invalid unexisting subvolume" \
> +	$SUDO_HELPER "$TOP/btrfs" subvolume delete --subvolid 999 "$TEST_MNT"
> +
> +run_mustfail "subvolume delete --subvolid expects only one extra argument: the mountpoint" \
> +	$SUDO_HELPER "$TOP/btrfs" subvolume delete --subvolid 256 "$TEST_MNT" "$TEST_MNT"
> +
> +# delete the recently created subvol using the subvolid
> +run_check $SUDO_HELPER "$TOP/btrfs" subvolume delete --subvolid 256 "$TEST_MNT"
> +
> +run_check_umount_test_dev
> 

