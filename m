Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5417DA48B
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 06:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfJQERh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 00:17:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38290 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfJQERh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 00:17:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9H4Dibx007904;
        Thu, 17 Oct 2019 04:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=fiIg7uoGY5RnwzcXTCdPI2hxjvZm3NARLjoCsRx0Xh8=;
 b=V+CGX67IVvE0+TG39PRal6EWLec/3e+Tyz0ZOH2D3qv6j7aiYPONCYYOYgaivpWdnYyh
 oJ+0fO0LxQChs6AjcdgiLL9GVs+Y3f6RviMn0GuKP+8jBFllY2do1gE2D/8MJaupW5OK
 cZNevkvPH0jAyfgsfAnaSONLaik3lN7i5D62bA8MZk7AK6L9ruzEE2qsoiyBMviMNLxi
 7C9zlChW9b+c5sWNz1f8ylNkE73VZHQlH3O3DgK+Pl5kCSV3sWZ6SoIaBMEzwQkmJL5W
 BeUhJR+EZ3ZaC1PFNr86sxVtr17OK3CsbtUQrUe3eMq2TS7jazAQSJzoLcm9g79x7+dW pA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vk7frk95g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 04:17:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9H4DGG1018291;
        Thu, 17 Oct 2019 04:17:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vp70p51ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 04:17:33 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9H4HVDV029579;
        Thu, 17 Oct 2019 04:17:31 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 04:17:31 +0000
Subject: Re: [PATCH v2 7/7] btrfs-progs: btrfstune: Allow to enable bg-tree
 feature offline
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191008044936.157873-1-wqu@suse.com>
 <20191008044936.157873-8-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <92f936ed-74eb-5c6e-2bf7-6226cdef14fd@oracle.com>
Date:   Thu, 17 Oct 2019 12:17:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008044936.157873-8-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170029
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


  Depending on the size of the FS the convert may take longer, further
  fatal error (power loss; pid kill) may leave the FS in a state where
  the bg items are in both extent-tree and bg-tree.

  The lessons which lead to the implementation of metadata_uuid fsid
  suggests, for conversions its better to use the btrfstune to only
  flag the bg convert requirement and let the kernel handle of migration
  of the bg items from the extent-tree to the bg-tree as and when the
  bg-items are written.

Thanks, Anand


On 10/8/19 12:49 PM, Qu Wenruo wrote:
> Add a new option '-b' for btrfstune, to enable bg-tree feature for a
> unmounted fs.
> 
> This feature will convert all BLOCK_GROUP_ITEMs in extent tree to bg
> tree, by reusing the existing btrfs_convert_to_bg_tree() function.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   Documentation/btrfstune.asciidoc |  6 +++++
>   btrfstune.c                      | 44 ++++++++++++++++++++++++++++++--
>   2 files changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/btrfstune.asciidoc b/Documentation/btrfstune.asciidoc
> index 1d6bc98deed8..ed54c2e1597f 100644
> --- a/Documentation/btrfstune.asciidoc
> +++ b/Documentation/btrfstune.asciidoc
> @@ -26,6 +26,12 @@ means.  Please refer to the 'FILESYSTEM FEATURES' in `btrfs`(5).
>   OPTIONS
>   -------
>   
> +-b::
> +(since kernel: 5.x)
> ++
> +enable bg-tree feature (faster mount time for large fs), enabled by mkfs
> +feature 'bg-tree'.
> +
>   -f::
>   Allow dangerous changes, e.g. clear the seeding flag or change fsid. Make sure
>   that you are aware of the dangers.
> diff --git a/btrfstune.c b/btrfstune.c
> index afa3aae35412..aa1ac568aef0 100644
> --- a/btrfstune.c
> +++ b/btrfstune.c
> @@ -476,11 +476,39 @@ static void print_usage(void)
>   	printf("\t-m          change fsid in metadata_uuid to a random UUID\n");
>   	printf("\t            (incompat change, more lightweight than -u|-U)\n");
>   	printf("\t-M UUID     change fsid in metadata_uuid to UUID\n");
> +	printf("\t-b          enable bg-tree feature (mkfs: bg-tree, for faster mount time)\n");
>   	printf("  general:\n");
>   	printf("\t-f          allow dangerous operations, make sure that you are aware of the dangers\n");
>   	printf("\t--help      print this help\n");
>   }
>   
> +static int convert_to_bg_tree(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_trans_handle *trans;
> +	int ret;
> +
> +	trans = btrfs_start_transaction(fs_info->tree_root, 1);
> +	if (IS_ERR(trans)) {
> +		ret = PTR_ERR(trans);
> +		errno = -ret;
> +		error("failed to start transaction: %m");
> +		return ret;
> +	}
> +	ret = btrfs_convert_to_bg_tree(trans);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error("failed to convert: %m");
> +		btrfs_abort_transaction(trans, ret);
> +		return ret;
> +	}
> +	ret = btrfs_commit_transaction(trans, fs_info->tree_root);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error("failed to commit transaction: %m");
> +	}
> +	return ret;
> +}
> +
>   int BOX_MAIN(btrfstune)(int argc, char *argv[])
>   {
>   	struct btrfs_root *root;
> @@ -491,6 +519,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>   	u64 seeding_value = 0;
>   	int random_fsid = 0;
>   	int change_metadata_uuid = 0;
> +	bool to_bg_tree = false;
>   	char *new_fsid_str = NULL;
>   	int ret;
>   	u64 super_flags = 0;
> @@ -501,7 +530,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>   			{ "help", no_argument, NULL, GETOPT_VAL_HELP},
>   			{ NULL, 0, NULL, 0 }
>   		};
> -		int c = getopt_long(argc, argv, "S:rxfuU:nmM:", long_options, NULL);
> +		int c = getopt_long(argc, argv, "S:rxfuU:nmM:b", long_options, NULL);
>   
>   		if (c < 0)
>   			break;
> @@ -539,6 +568,9 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>   			ctree_flags |= OPEN_CTREE_IGNORE_FSID_MISMATCH;
>   			change_metadata_uuid = 1;
>   			break;
> +		case 'b':
> +			to_bg_tree = true;
> +			break;
>   		case GETOPT_VAL_HELP:
>   		default:
>   			print_usage();
> @@ -556,7 +588,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>   		return 1;
>   	}
>   	if (!super_flags && !seeding_flag && !(random_fsid || new_fsid_str) &&
> -	    !change_metadata_uuid) {
> +	    !change_metadata_uuid && !to_bg_tree) {
>   		error("at least one option should be specified");
>   		print_usage();
>   		return 1;
> @@ -602,6 +634,14 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>   		return 1;
>   	}
>   
> +	if (to_bg_tree) {
> +		ret = convert_to_bg_tree(root->fs_info);
> +		if (ret < 0) {
> +			errno = -ret;
> +			error("failed to convert to bg-tree feature: %m");
> +			goto out;
> +		}
> +	}
>   	if (seeding_flag) {
>   		if (btrfs_fs_incompat(root->fs_info, METADATA_UUID)) {
>   			fprintf(stderr, "SEED flag cannot be changed on a metadata-uuid changed fs\n");
> 

