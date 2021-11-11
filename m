Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBCF44D029
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 03:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbhKKC6o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 21:58:44 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:59676 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230314AbhKKC6n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 21:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1636599354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GiurFp/QwPzQHks934IuhjQHtXFbek0DQvc+l9QCRqI=;
        b=eJYKWfuVHPnB/Dm6rTIWIUQAJgRfKhd4OCIJCXUDBCIv2Yg8hGZxI/OgYzSQnuVRDbMyEg
        ikF6+9FzaWBi4/LIiykHsCOQ8axJ7AWhrOyood3xNqADmA8RWsZujiC1MNeQ++/uOxYI4E
        kdv0eddSQ/SCEbRAqstDwJJonHIkUBY=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2105.outbound.protection.outlook.com [104.47.17.105])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-31-gZv2EcnqNU2cCSoV813tLA-1; Thu, 11 Nov 2021 03:55:53 +0100
X-MC-Unique: gZv2EcnqNU2cCSoV813tLA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVWjFYUzhjwpsXkce/YEWnLWRs7kll5CUPj6JV0V6dJ/5L3YbTm5QCLTpWRTQc+pu5IaTmQVRlSlCBvDCyA0sg5v5xchyQwuYnHdyg0lfu4higU39TDm6pexF9NN1aijCnfZxu5nMTbhspKMQUqYnk678i1lmptXfgKO2DIbpxF4JzH4toKiMwrTdbheElEIFKFo9Hj9PTClPHJWA71nzoCWSDsA1trOYC0ipgfQ0CdR5fGPdS0BLYYDF+8f8Mp/+wa8KTIRHIhU/rvaLlrj5ofdKdiQtk5jaFzd60fCyk+Wawn3HYNqJ3CHbs9c6+xHR7Y07nle19ulP7NXKqImiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiurFp/QwPzQHks934IuhjQHtXFbek0DQvc+l9QCRqI=;
 b=ihoOLU5nSB7M0Zd2yiIYLa8KeBdxpv2LAW+ILBfjsXUH1m1rkn/1ZlWs0mFIooCB5gt/sGWrPfz4F2pAAaF2C96NoJF0NG2d8A8v6sSuDMrosCf4OjLNsMR4NbjIBzwKQx6yAfJk5kYEsWv7OlmvJrodHppzQadroc/uwUrtHTq6GkR6ojPsX6+srFeRzxnLv6z175zppCwm6U9zKV5vYgU+dgX2X2s40UWkEGIg07msv7Tr3X9/yf8SUAbHqx/n0qrzBtJTgUIyu88KYKVZQF2yCxfaWeU18Z15FzQNN2/XO7DzwXgrEiH+/DyhxSg6p32/1l1Q4FgeJuk517zlwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DU2PR04MB8853.eurprd04.prod.outlook.com (2603:10a6:10:2e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Thu, 11 Nov
 2021 02:55:52 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::ed16:bc50:4079:9286]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::ed16:bc50:4079:9286%9]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 02:55:52 +0000
Message-ID: <03f2bdbd-c2de-e492-84f9-19a78826ab9b@suse.com>
Date:   Thu, 11 Nov 2021 10:55:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] btrfs-progs: rescue: introduce clear-uuid-tree
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     "S ." <sb56637@gmail.com>
References: <20211111024138.41687-1-wqu@suse.com>
In-Reply-To: <20211111024138.41687-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0059.namprd07.prod.outlook.com
 (2603:10b6:510:e::34) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by PH0PR07CA0059.namprd07.prod.outlook.com (2603:10b6:510:e::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Thu, 11 Nov 2021 02:55:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a60f70a4-70f0-44af-0422-08d9a4bec5c2
X-MS-TrafficTypeDiagnostic: DU2PR04MB8853:
X-Microsoft-Antispam-PRVS: <DU2PR04MB885373236DD7528F8DC2638BD6949@DU2PR04MB8853.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y0bDSwFcgWSE4xHHNcnhq8FnmTwalFO+iCEoG3K9lr4ug68FNWhk3lVtPhmkwZdOuZuNKOtwcktkaujlwX7iwwOmCuggMy8JWk6NhooJjeuts7/CZD/ijar0YbUBQni/Y4/Eaeh+QqEDRXVZ51hPWG6l+cYrwwv6y8CLVgTpWbiH7A+b+zH/fHjKufycpfQ88gBw949EaGtp20+8MW8m8pfJOohPIysFKDcVmScve0JxIKfFsI5YKu0xeuPESzXUtUl9D8buUR16oIYYuQDMept2yt62o1S6bwXMOP2jbneEtZo3mYznoCZIZyF4XiUclfiwEn91A4zDYGVbIhc3fzODkPUoZI6DYaXyZ5bhJ0Cbpgf5KgU0CcLvzHz3RhTOSwJktveER7whId6P16J4URnyJq1Ep8NfpVUrajbRv/e8imBXisPMUyIrXbCFqnZQRijoieP9dPQ3Iwhkl/GaAisvOE4R38Z03Ugnn3N7AoCyHZqS1ftMaVtcOkswX8a0fYYWpAv15pCas2fs31CZ72z+YOmWqIlo3hv4lV0p8n/ifC37sqkPVMPbie7lr43z7hzAB9pos95tFfPs2LTgRf559lZVlmwNoZm+MS1dugdRTU0unVlj8x448v1rUtvdkjvH80icIWq6KCfPHYLWLEW75491j5ZfcQ2NDr4ri8ETf18i6V5q8xBeT0pxldh9iZunqIqDWsSeACWbRpSmaBH2vDbHOCjYvTa/CrOhhamKS+/iAXfJ6S8oy1THSmBHfdwM0wmDBfAvrHbUyAQUdlDnbx3ToB1Y7Rqg47azmo0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6706004)(53546011)(8676002)(5660300002)(508600001)(2616005)(6916009)(956004)(31696002)(83380400001)(66946007)(2906002)(36756003)(8936002)(66556008)(86362001)(31686004)(186003)(16576012)(316002)(6666004)(38100700002)(4326008)(26005)(6486002)(66476007)(78286007)(45980500001)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME9nUG9aOVBmZXBYK3B1NjQvNFM1NHl1emZ2Zm1JV2ZzSjQzMS9lZzNlYnJV?=
 =?utf-8?B?Rk5ydWczaHZodVIxNlFzUldkNnB4VjFOVERyUDVZUDc5Mzh1S3oySUVoS01x?=
 =?utf-8?B?enZiUGowZGRWZnBENmRFSE9UWUN5bTk3aDZrYVdlQlJNNVp5NFExMDBCWXox?=
 =?utf-8?B?UTI1bmRZRGdsUnhDWDVuc2JtRW1LditVRmpSZnNmOEhHa1RkWDRKUFJrU0hl?=
 =?utf-8?B?RWJLTmxqdEFLMGdncG5XVmN3OWtmYk1XQTRBS2VMVi9jN041cXYrTDEyd1NT?=
 =?utf-8?B?WkE3K29Wb1RxQkJlUFhqSVFCQUdwQnF5M3pTQ3FheVpPTmJsL2x1cDRhd2JY?=
 =?utf-8?B?UzNzR0wweWhFczJvdFFhNjBsekRmMlFWZG9pazdBMmpZOUtxRnFQaEs2Y2dK?=
 =?utf-8?B?bHJqczZqUEFWdVNkNkVieVQ0VlZBbGdHM0xWTW4reTZrOXF5ZklhQUhMMEJR?=
 =?utf-8?B?OWZkaDVPbmVkUzVmVHc5eE5pYWFFaXVpeUFGckp0d3hIbmU1bGk2UUVHb3l2?=
 =?utf-8?B?c0xrRy9lcndmdytPRWd6cjAza3Ira1Z4MnhTbmFWNWNFRmVsYjhISGl5aXls?=
 =?utf-8?B?YlpJVHFPSUZtMXc4OURDa0h2b0dOUzhUQVFqdVBkQ0RYK2tkU1poNnZMdXZm?=
 =?utf-8?B?VysvdXRkeDFLRVVjWjByQ3dUS1dUNVVkLzVRUko4ZS9XYjN0YkxocWYvc2RY?=
 =?utf-8?B?Z2dsYXNMRVhZOGdhSjFsYkY4WktpbkJVb1Z4L2hVVUx1QW9oNjQzRzNZZEMr?=
 =?utf-8?B?QnQxNWR1VStmRlgvN1d3Tk0xVi9taVhNTHAzLzNKaDcvem5BMTR2SEhvRlhu?=
 =?utf-8?B?U0JRVldSMitac0dSK0VxeGsrakZYblhmazBRWGd0WU5uT1ZyUDUwVWhodE90?=
 =?utf-8?B?TFZiZzgvM1RNRmorTENjTERVV0tLSTU1NzRJbmoxeFpRL0N5ZVE2NTRzN0ZW?=
 =?utf-8?B?UXhpSzNvSEExQXNzQ2R1eG9kbXpQMUNzbWRmWGxMZjNESFRmM1lRYnMvT09W?=
 =?utf-8?B?MHp5Z2NBN200Y0pHaVhiYktoQmRtSVB0YWw5VVppYW1yd3h2S1IvZlIyMTl6?=
 =?utf-8?B?SzVxRWRKZmRvMjhRRlNreXlGY2J3YjhmV25WeTdlQ3JLN0kzL2xSY0M1UE9i?=
 =?utf-8?B?eGhhLzVGdmpERU9WcFZXQ3lYcHJoUTVoZWxCeW01UnR4blNjbnQ4UU1wcFRB?=
 =?utf-8?B?Y1ZvR0ZTL29Zc252Sm1YNk42SnJtU0h0RmlGZUthejRxVHdCek13WGI0eVVL?=
 =?utf-8?B?c1Y0WHZ5KzF3VlR3RmFvam0raS9KTGZtMWV6VmdVeFR2VXpZSWFTeHExWCtv?=
 =?utf-8?B?b0k1V09KSkNmc2pOVWh0NmRBcEljMXY3SnBLTFVCRGpCUXlXWHVKUCtnQkM0?=
 =?utf-8?B?VGlBYUw3ZnJSblUyZFZtbG4ybFFDLzBQcmFTZWp5NFgyMWsySnc2bTdmTFlT?=
 =?utf-8?B?WkQzYWljcURZbWw5V29FSWx3ZXFrc04xR1BaWUtuM3BQSGVrdldkYWJXTXJp?=
 =?utf-8?B?RktOWkh2N2pSNmM4bGk5b1VVWnJNOU15dHlxclROaU5hY2M4bWdicE9PN3VN?=
 =?utf-8?B?eXhsNnpyM2JEVnVLVEhlRGdNOVkwL1kyZ0R1SVNzSkpGT0x0aGkrdkN4UGs0?=
 =?utf-8?B?WnVIeHFkKzNDMWloeUZtSFIwQVkrd0VncklnR3lQNEdyaDhITnhGS0NnUDdV?=
 =?utf-8?B?VW1qTUdCQ3VEMTE4R3diTnZ4ZjNuRm9IdjgyZE5GaWtFN2E2NndyNXFKMGJC?=
 =?utf-8?B?WndJc0phdzZQMVZidCt0M0ZyaFljZmNvNTNBNDR3YVcxMHBheEhMdFdHL2Zl?=
 =?utf-8?B?bXBVakQ3WFdnM2l4SGRhNGt3blJrS1NCcU16a216Nm1wS09maG9TZk1KU3JC?=
 =?utf-8?B?SGd5VklIVnZVa3hJaC94c3MwVjNpZ2t4eVBiYXdqMjdHZ3FkZ0dhT04vZWNT?=
 =?utf-8?B?V0MyTkZZemRHR3R5RHljUk5HVkMyMEZ1aDdsY0dtZUovVjNYMUtRMzJqS21T?=
 =?utf-8?B?QlZ3azRwRW9ObmtIbU9VM3puY0hlMTVLN1dOVjdNOGdseDVOZWpyWXhmZEpx?=
 =?utf-8?B?OXBvRXRNTzJoZExlbHZPeitBY2ZMeDhFcEIzTDlib1RBcm42Y1dQRnNoWjN1?=
 =?utf-8?Q?AeHY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a60f70a4-70f0-44af-0422-08d9a4bec5c2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 02:55:51.9378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsYSnGnttAytmNhyDo7n1GE+AbPb9m7kst7+EFBIfP07FBwsxfcbrEuspBOMk41K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8853
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/11 10:41, Qu Wenruo wrote:
> [BUG]
> There is a bug report that a corrupted key type (expected
> UUID_KEY_SUBVOL, has EXTENT_ITEM) causing newer kernel to reject a
> mount.
> 
> Although the root cause is not determined yet, with roll out of v5.11
> kernel to various distros, such problem should be prevented by
> tree-checker, no matter if it's hardware problem or not.
> 
> And older kernel with "-o uuid_rescan" mount option won't help, as
> uuid_rescan will only delete items with
> UUID_KEY_SUBVOL/UUID_KEY_RECEIVED_SUBVOL key types, not deleting such
> corrupted key.
> 
> [FIX]
> To fix such problem we have to rely on offline tool, thus there we
> introduce a new rescue tool, clear-uuid-tree, to empty and then remove
> uuid tree.
> 
> Kernel will re-generate the correct uuid tree at next mount.
> 
> Reported-by: S. <sb56637@gmail.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   cmds/rescue.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++

Oh no, forgot doc again....

>   1 file changed, 104 insertions(+)
> 
> diff --git a/cmds/rescue.c b/cmds/rescue.c
> index a98b255ad328..8b5b619da4f6 100644
> --- a/cmds/rescue.c
> +++ b/cmds/rescue.c
> @@ -296,6 +296,109 @@ static int cmd_rescue_create_control_device(const struct cmd_struct *cmd,
>   }
>   static DEFINE_SIMPLE_COMMAND(rescue_create_control_device, "create-control-device");
>   
> +static int clear_uuid_tree(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_root *uuid_root = fs_info->uuid_root;
> +	struct btrfs_trans_handle *trans;
> +	struct btrfs_path path = {};
> +	struct btrfs_key key = {};
> +	int ret;
> +
> +	if (!uuid_root)
> +		return 0;
> +
> +	fs_info->uuid_root = NULL;
> +	trans = btrfs_start_transaction(fs_info->tree_root, 0);
> +	if (IS_ERR(trans))
> +		return PTR_ERR(trans);
> +
> +	while (1) {
> +		int nr;
> +
> +		ret = btrfs_search_slot(trans, uuid_root, &key, &path, -1, 1);
> +		if (ret < 0)
> +			goto out;
> +		ASSERT(ret > 0);
> +		ASSERT(path.slots[0] == 0);
> +
> +		nr = btrfs_header_nritems(path.nodes[0]);
> +		if (nr == 0) {
> +			btrfs_release_path(&path);
> +			break;
> +		}
> +
> +		ret = btrfs_del_items(trans, uuid_root, &path, 0, nr);
> +		btrfs_release_path(&path);
> +		if (ret < 0)
> +			goto out;
> +	}
> +	ret = btrfs_del_root(trans, fs_info->tree_root, &uuid_root->root_key);
> +	if (ret < 0)
> +		goto out;
> +	list_del(&uuid_root->dirty_list);
> +	ret = clean_tree_block(uuid_root->node);
> +	if (ret < 0)
> +		goto out;
> +	ret = btrfs_free_tree_block(trans, uuid_root, uuid_root->node, 0, 1);
> +	if (ret < 0)
> +		goto out;
> +	free_extent_buffer(uuid_root->node);
> +	free_extent_buffer(uuid_root->commit_root);
> +	kfree(uuid_root);
> +out:
> +	if (ret < 0)
> +		btrfs_abort_transaction(trans, ret);
> +	else
> +		ret = btrfs_commit_transaction(trans, fs_info->tree_root);
> +	return ret;
> +}
> +
> +static const char * const cmd_rescue_clear_uuid_tree_usage[] = {
> +	"btrfs rescue clear-uuid-tree",
> +	"Delete uuid tree so that kernel can rebuild it at mount time",
> +	NULL,
> +};
> +
> +static int cmd_rescue_clear_uuid_tree(const struct cmd_struct *cmd,
> +				      int argc, char **argv)
> +{
> +	struct btrfs_fs_info *fs_info;
> +	struct open_ctree_flags ocf = {};
> +	char *devname;
> +	int ret;
> +
> +	clean_args_no_options(cmd, argc, argv);
> +	if (check_argc_exact(argc, 2))
> +		return -EINVAL;
> +
> +	devname = argv[optind];
> +	ret = check_mounted(devname);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error("could not check mount status: %m");
> +		goto out;
> +	} else if (ret) {
> +		error("%s is currently mounted", devname);
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +	ocf.filename = devname;
> +	ocf.flags = OPEN_CTREE_WRITES | OPEN_CTREE_PARTIAL;
> +	fs_info = open_ctree_fs_info(&ocf);
> +	if (!fs_info) {
> +		error("could not open btrfs");
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	ret = clear_uuid_tree(fs_info);
> +	close_ctree(fs_info->tree_root);
> +out:
> +	return !!ret;
> +}
> +
> +static DEFINE_SIMPLE_COMMAND(rescue_clear_uuid_tree, "clear-uuid-tree");
> +
>   static const char rescue_cmd_group_info[] =
>   "toolbox for specific rescue operations";
>   
> @@ -306,6 +409,7 @@ static const struct cmd_group rescue_cmd_group = {
>   		&cmd_struct_rescue_zero_log,
>   		&cmd_struct_rescue_fix_device_size,
>   		&cmd_struct_rescue_create_control_device,
> +		&cmd_struct_rescue_clear_uuid_tree,
>   		NULL
>   	}
>   };
> 

