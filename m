Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BB84008DE
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Sep 2021 03:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350649AbhIDA5k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 20:57:40 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:46306 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236127AbhIDA5h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Sep 2021 20:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1630716995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YuJOTx7k6l6PgOkVf4dNlBFD3OdeatFgIkiHMca6OSU=;
        b=D6v6BkBxPdSAmAZMkYrGrmiGEds9ex1UQhLsxrem9wyRmRCbY0ROV5k98nNlpAeg2DefuZ
        zaWh1ndv6vfe5mhKgUwJuMBNyQYHXpvL5CTznB/6oN9ke5DZ4FuoQ1tLH3AlRfycnUYpHl
        mlA4OIHfI3gOrKHFVHKH72Ab0iX3bZk=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2058.outbound.protection.outlook.com [104.47.10.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-16-DVuW9vPXMPaARgTL2KI8Kw-1; Sat, 04 Sep 2021 02:56:34 +0200
X-MC-Unique: DVuW9vPXMPaARgTL2KI8Kw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jL4nksn9xRSai0HFI/ZgtLFgReBtpamiUpL/qE56sS/Ieyyv43q5UQ6VkqZxhkr7q4cVOyRF0ZXphf3iksWb5IX9M3twLFfxxFsfURMSpWfUY32CLChJ6jZVx85LNUa63tItK1cViY2d7VfLJm8AvPSHa/mP9E6vVTnM6fUkIdI/Oxu7rDr953gCJqyRd/f7P1xbuZc1runqemzVVL4J8M4L/rEfAscZzGxzUYnHYqSRe+uTfWrj7ckIYipewWiQzDfVVYV49kTH5JSg3GxB6PqXtGmYidKjqDZgC3bCAK6fFezuyVSTvC1fY22qrYGEcTA0VIZoRj8IyFbMT7+mnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=K7UBuIQiVzNhoEKfpJhE1VBagDggxr2uDQFWvk18bos=;
 b=FDDrb3WgqjbBgkUKDL6hQeL7AQaJhPsaN0GHswHx2fhpsFFnA5m4HO6nz7e/ZbRIMyzXBTSwT+OOi04c5kUCgPP66vbunUIK9bUruh3TSZv7UoiYefCR9bhjrrt2ZPH40o95ZBli1v2QOda8eGN5Iih98lBjmgHZ7OCAL7XG+dSl6bWW54Lu8sQ+F2aMalcVnu6+9P41meMjrcRZohaiQiwG7sCrVrhsGLXFui5O5SnfMCMALFjjFG+oyg9eCAdUcS9MMuF+ma1GwDJcsPLkdNCiky6hMO4L3ct5pjKyQ4V3LsJmkVkwneEbba4keo6yR5SW+5bwFIK0pN1ZMFyDwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB6183.eurprd04.prod.outlook.com (2603:10a6:20b:bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Sat, 4 Sep
 2021 00:56:32 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%5]) with mapi id 15.20.4478.024; Sat, 4 Sep 2021
 00:56:32 +0000
Subject: Re: [PATCH 1/3] btrfs-progs: use btrfs_key for btrfs_check_node() and
 btrfs_check_leaf()
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210902130843.120176-1-wqu@suse.com>
 <20210902130843.120176-2-wqu@suse.com>
Message-ID: <4cebfa71-59cb-fa71-d9aa-a3707778cc0c@suse.com>
Date:   Sat, 4 Sep 2021 08:56:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210902130843.120176-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR02CA0042.namprd02.prod.outlook.com
 (2603:10b6:a03:54::19) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR02CA0042.namprd02.prod.outlook.com (2603:10b6:a03:54::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Sat, 4 Sep 2021 00:56:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d84de45f-8d52-442a-0734-08d96f3ed61e
X-MS-TrafficTypeDiagnostic: AM6PR04MB6183:
X-Microsoft-Antispam-PRVS: <AM6PR04MB6183A61A1AE5759A316F61DDD6D09@AM6PR04MB6183.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3az5hJkWVBIabXjzE+jeY2Qm4AjXBQ7Wqsi9GarDtS8+s6rNI3x4606IHiHOthR/wI4HPKMLYismFIIA5gUgcBXKR8I/p9oyTcwrP1yPM2SnA+1YKKjYmj/MbsGNAsHpUayttKPK5bihzB7t4uiR32ur7QJUAFLTSPCKHQYme7EblDVRKKzLTGjJqLM/RsDBxBXVRLvQPcqHe9wkf5p7WpgC+zkuN4sC0TP0sbjQHT2Kl9UpcGzYGUiZPjAxU/vTVb2Om77UOI80sT00f4LPlaYY81KjxI6R3YlQ/Q2SGVyhPypAtFO33bPYt2W+pErJrZUtuOxcRgKodK2DURAmlSuHGCg1tbFOhlKsvN8XOcWkSgcC/LZBd3BIEjEGZe66Lo3i9HRi/rAak7jAGIIetTGAvwzwGjsd3KcL8nk1WZALmH8NtZUbC5njCCtOL2GdDq8d9vtmCFBWItDfyF+FPwXuCbn6Pmc8BK0ca1ALMgrlqsWjlAx5qK/+Y1jy5dQawPbpH+FLQjWHnKpZVsv0obpNRxHJYs1Rul8v1fpKpNBDLIkQmYwF4BapdLn+m7RUuKNu0WMm+vXx3dZLFPKy47xdzqi8Z8OjBPeL9ugFW+SBsNxw36cL29YjRpukxEBRdWu6kos6pIVoTzVR05TnKVxJ5Vnt+G1i1I0lfQ/uQvv50XX9qnelE9Lp5HrIXfVhYWfqKWi0K4I+HYWAlGErdoVuiE4+Be8Dc917WeHHz3nrL2gI8Hh2RG5/amVwVLrA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(376002)(396003)(346002)(6486002)(83380400001)(6706004)(6916009)(38100700002)(478600001)(36756003)(26005)(8936002)(6666004)(186003)(31696002)(2906002)(5660300002)(316002)(16576012)(956004)(2616005)(66476007)(66556008)(66946007)(86362001)(8676002)(31686004)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3dF544HQhzz4bxDxtrGPWrCAR+DVTJmaB0Q2bzvC0KvjKdZEt0+LzoBQ/QKF?=
 =?us-ascii?Q?tG7b4Uc57C0vsvA7GG+tfRrmaB5W6OhEAyAfGLw2/3NC2I5ZIthZpm+Hl6UD?=
 =?us-ascii?Q?dfrpuc2vwJxRMIqvOy3ibvR95qBS2kot2zvpPZ1ZQ9tvV2OwkEffCLXOhknt?=
 =?us-ascii?Q?ZcLJaiqhwMSIDWgPivHE0u0hixUgPS3CXmPfonhM9w4mRWGWfSI7AWs4Cy+R?=
 =?us-ascii?Q?xubQPFnGLOh4aTWaD5nGuFmdsz2EDn5OEvWli4Hd95LKEupEJSGojJRrLY2D?=
 =?us-ascii?Q?sET15CKcQYUXr4rn9RshwtaOA9Zw53Fu89TWN59X1O62hVAVtmeN2aVHRJX5?=
 =?us-ascii?Q?bW7ndPbXn8arZdJQv64Ixq9qpfW+ZJiAO7RAdg611mgp63uzQ3EEEOoxJK7K?=
 =?us-ascii?Q?gxbZaNT3F9YvzNEuu3HklY8xQ7l0ZdqeNior3QYLKfBznF+aIOqxHeN2Hyrm?=
 =?us-ascii?Q?OKw1swahhOhrWq0s1otWO0scHHSfkih1UTDXFW2Pue2f4PJeNWN2RGjuBOY8?=
 =?us-ascii?Q?fgfKPRp0jpCKVvu+6Z2UU4CwzyHTJglwqvnyGo/9QjHnGEpYdZ82kHFPfAXj?=
 =?us-ascii?Q?V540IxMJ4C/vmSccijJrwm96dGKhlqFMuxyrGsuDJFXh9ZfCsvFB1rUy18cl?=
 =?us-ascii?Q?ubUqiR+tKCvNqUFejA/gI8ShbZh7D6Qt+zyint6ci9fse/2GSU6mr+Ch/7Ne?=
 =?us-ascii?Q?kZVebVS3MtZ7/vNwzD4KHFa3NSyGoa97OSPS116mxpqyadL1t/IIShyh6N+F?=
 =?us-ascii?Q?EDI4TcIcdILAeh54SGWhEg9U8xllB8PofushlQ97kHSYR1p1nDhyV7kQ3FzI?=
 =?us-ascii?Q?RS3s5aif/lnNLbH/v6gwmcTiqBDXdxpModLsZ6JL7VpdPFJzXXL9k8upGq+s?=
 =?us-ascii?Q?7Igd4nL7bHQi0HDaVjson8v0vGfngSI72EoCTK1AOn93dwPN26J6pgkgCWTO?=
 =?us-ascii?Q?+/1xKCYbvsEyyCEO+6udKTvHbLimpB984FMccbydc/5donjLpYbh1l8eFc4b?=
 =?us-ascii?Q?b59Cbi2dqRT4zi2+TIq60TWC1FrcFYmbO0IC3/yqkoDkG3+2Ixj4O8CDDd3m?=
 =?us-ascii?Q?XIhw2IuoLyuqB/dyQvJJ/KOsbS7LAD/jzVy3CxWCF9gwGG5DCt6ODzlzGisP?=
 =?us-ascii?Q?rpd9NGftrpXf+kr/raVfc0gD0bgjkpVc6ors92wMBhxUc2mOj1wGpO4FUiPA?=
 =?us-ascii?Q?V02A3yz0PREW9wz+OxnWxsKbrjW0UuWsmHTySuLfHTCD74ckZa/c81dlrVIz?=
 =?us-ascii?Q?se2TFNQqdWYsB15I3ltwRHRRkwYhQQkH3ox8W53ZufpBBNmm3Q0mXyUKWz8W?=
 =?us-ascii?Q?ETXVgOiQS3mq3S7/A7593HbL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84de45f-8d52-442a-0734-08d96f3ed61e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2021 00:56:32.2793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LESDQFmqd4kkXggRbVBnm13xh3Q6T2kAbA4R6wpMUpw7zeT/k6FyPOpv1Y+c4xCr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6183
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/2 =E4=B8=8B=E5=8D=889:08, Qu Wenruo wrote:
> In kernel space we hardly use btrfs_disk_key, unless for very lowlevel
> code.
>=20
> There is no need to intentionally use btrfs_disk_key in btrfs-progs
> either.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   check/main.c          |  9 +++---
>   check/mode-original.h |  2 +-
>   kernel-shared/ctree.c | 64 +++++++++++++++++++++++--------------------
>   kernel-shared/ctree.h |  4 +--
>   4 files changed, 42 insertions(+), 37 deletions(-)
>=20
> diff --git a/check/main.c b/check/main.c
> index a27efe56eec6..ff1ccade3967 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -4162,7 +4162,6 @@ static int record_bad_block_io(struct cache_tree *e=
xtent_cache,
>   {
>   	struct extent_record *rec;
>   	struct cache_extent *cache;
> -	struct btrfs_key key;
>  =20
>   	cache =3D lookup_cache_extent(extent_cache, start, len);
>   	if (!cache)
> @@ -4172,8 +4171,8 @@ static int record_bad_block_io(struct cache_tree *e=
xtent_cache,
>   	if (!is_extent_tree_record(rec))
>   		return 0;
>  =20
> -	btrfs_disk_key_to_cpu(&key, &rec->parent_key);
> -	return btrfs_add_corrupt_extent_record(gfs_info, &key, start, len, 0);
> +	return btrfs_add_corrupt_extent_record(gfs_info, &rec->parent_key,
> +					       start, len, 0);
>   }
>  =20
>   static int swap_values(struct btrfs_root *root, struct btrfs_path *path=
,
> @@ -6567,7 +6566,9 @@ static int run_next_block(struct btrfs_root *root,
>   			}
>  =20
>   			memset(&tmpl, 0, sizeof(tmpl));
> -			btrfs_cpu_key_to_disk(&tmpl.parent_key, &key);
> +			tmpl.parent_key.objectid =3D key.objectid;
> +			tmpl.parent_key.type =3D key.type;
> +			tmpl.parent_key.offset =3D key.offset;
>   			tmpl.parent_generation =3D
>   				btrfs_node_ptr_generation(buf, i);
>   			tmpl.start =3D ptr;
> diff --git a/check/mode-original.h b/check/mode-original.h
> index eed16d92d0db..cf06917c47dc 100644
> --- a/check/mode-original.h
> +++ b/check/mode-original.h
> @@ -79,7 +79,7 @@ struct extent_record {
>   	struct rb_root backref_tree;
>   	struct list_head list;
>   	struct cache_extent cache;
> -	struct btrfs_disk_key parent_key;
> +	struct btrfs_key parent_key;
>   	u64 start;
>   	u64 max_size;
>   	u64 nr;
> diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
> index 0845cc6091d4..c015c4f879c1 100644
> --- a/kernel-shared/ctree.c
> +++ b/kernel-shared/ctree.c
> @@ -568,11 +568,10 @@ static inline unsigned int leaf_data_end(const stru=
ct btrfs_fs_info *fs_info,
>  =20
>   enum btrfs_tree_block_status
>   btrfs_check_node(struct btrfs_fs_info *fs_info,
> -		 struct btrfs_disk_key *parent_key, struct extent_buffer *buf)
> +		 struct btrfs_key *parent_key, struct extent_buffer *buf)
>   {
>   	int i;
> -	struct btrfs_key cpukey;
> -	struct btrfs_disk_key key;
> +	struct btrfs_key key;
>   	u32 nritems =3D btrfs_header_nritems(buf);
>   	enum btrfs_tree_block_status ret =3D BTRFS_TREE_BLOCK_INVALID_NRITEMS;
>  =20
> @@ -581,25 +580,27 @@ btrfs_check_node(struct btrfs_fs_info *fs_info,
>  =20
>   	ret =3D BTRFS_TREE_BLOCK_INVALID_PARENT_KEY;
>   	if (parent_key && parent_key->type) {
> -		btrfs_node_key(buf, &key, 0);
> +		btrfs_node_key_to_cpu(buf, &key, 0);
>   		if (memcmp(parent_key, &key, sizeof(key)))
>   			goto fail;
>   	}
>   	ret =3D BTRFS_TREE_BLOCK_BAD_KEY_ORDER;
>   	for (i =3D 0; nritems > 1 && i < nritems - 2; i++) {
> -		btrfs_node_key(buf, &key, i);
> -		btrfs_node_key_to_cpu(buf, &cpukey, i + 1);
> -		if (btrfs_comp_keys(&key, &cpukey) >=3D 0)
> +		struct btrfs_key next_key;
> +
> +		btrfs_node_key_to_cpu(buf, &key, i);
> +		btrfs_node_key_to_cpu(buf, &next_key, i + 1);
> +		if (btrfs_comp_cpu_keys(&key, &next_key) >=3D 0)
>   			goto fail;
>   	}
>   	return BTRFS_TREE_BLOCK_CLEAN;
>   fail:
>   	if (btrfs_header_owner(buf) =3D=3D BTRFS_EXTENT_TREE_OBJECTID) {
>   		if (parent_key)
> -			btrfs_disk_key_to_cpu(&cpukey, parent_key);
> +			memcpy(&key, parent_key, sizeof(struct btrfs_key));
>   		else
> -			btrfs_node_key_to_cpu(buf, &cpukey, 0);
> -		btrfs_add_corrupt_extent_record(fs_info, &cpukey,
> +			btrfs_node_key_to_cpu(buf, &key, 0);
> +		btrfs_add_corrupt_extent_record(fs_info, &key,
>   						buf->start, buf->len,
>   						btrfs_header_level(buf));
>   	}
> @@ -608,11 +609,10 @@ fail:
>  =20
>   enum btrfs_tree_block_status
>   btrfs_check_leaf(struct btrfs_fs_info *fs_info,
> -		 struct btrfs_disk_key *parent_key, struct extent_buffer *buf)
> +		 struct btrfs_key *parent_key, struct extent_buffer *buf)
>   {
>   	int i;
> -	struct btrfs_key cpukey;
> -	struct btrfs_disk_key key;
> +	struct btrfs_key key;
>   	u32 nritems =3D btrfs_header_nritems(buf);
>   	enum btrfs_tree_block_status ret =3D BTRFS_TREE_BLOCK_INVALID_NRITEMS;
>  =20
> @@ -639,7 +639,7 @@ btrfs_check_leaf(struct btrfs_fs_info *fs_info,
>   	if (nritems =3D=3D 0)29368320
>   		return BTRFS_TREE_BLOCK_CLEAN;
>  =20
> -	btrfs_item_key(buf, &key, 0);
> +	btrfs_item_key_to_cpu(buf, &key, 0);
>   	if (parent_key && parent_key->type &&
>   	    memcmp(parent_key, &key, sizeof(key))) {
>   		ret =3D BTRFS_TREE_BLOCK_INVALID_PARENT_KEY;
> @@ -648,9 +648,12 @@ btrfs_check_leaf(struct btrfs_fs_info *fs_info,
>   		goto fail;29368320
>   	}
>   	for (i =3D 0; nritems > 1 && i < nritems - 1; i++) {
> -		btrfs_item_key(buf, &key, i);
> -		btrfs_item_key_to_cpu(buf, &cpukey, i + 1);
> -		if (btrfs_comp_keys(&key, &cpukey) >=3D 0) {
> +		struct btrfs_key next_key;
> +
> +		btrfs_item_key_to_cpu(buf, &key, i);
> +		btrfs_item_key_to_cpu(buf, &next_key, i + 1);
> +
> +		if (btrfs_comp_cpu_keys(&key, &next_key) >=3D 0) {
>   			ret =3D BTRFS_TREE_BLOCK_BAD_KEY_ORDER;
>   			fprintf(stderr, "bad key ordering %d %d\n", i, i+1);
>   			goto fail;
> @@ -676,8 +679,10 @@ btrfs_check_leaf(struct btrfs_fs_info *fs_info,
>   	for (i =3D 0; i < nritems; i++) {
>   		if (btrfs_item_end_nr(buf, i) >
>   				BTRFS_LEAF_DATA_SIZE(fs_info)) {
> -			btrfs_item_key(buf, &key, 0);
> -			btrfs_print_key(&key);
> +			struct btrfs_disk_key disk_key;
> +
> +			btrfs_item_key(buf, &disk_key, 0);
> +			btrfs_print_key(&disk_key);
>   			fflush(stdout);
>   			ret =3D BTRFS_TREE_BLOCK_INVALID_OFFSETS;
>   			fprintf(stderr, "slot end outside of leaf %llu > %llu\n",
> @@ -692,11 +697,11 @@ btrfs_check_leaf(struct btrfs_fs_info *fs_info,
>   fail:
>   	if (btrfs_header_owner(buf) =3D=3D BTRFS_EXTENT_TREE_OBJECTID) {
>   		if (parent_key)
> -			btrfs_disk_key_to_cpu(&cpukey, parent_key);
> +			memcpy(&key, parent_key, sizeof(struct btrfs_key));
>   		else
> -			btrfs_item_key_to_cpu(buf, &cpukey, 0);
> +			btrfs_item_key_to_cpu(buf, &key, 0);
>  =20
> -		btrfs_add_corrupt_extent_record(fs_info, &cpukey,
> +		btrfs_add_corrupt_extent_record(fs_info, &key,
>   						buf->start, buf->len, 0);
>   	}
>   	return ret;
> @@ -705,22 +710,21 @@ fail:
>   static int noinline check_block(struct btrfs_fs_info *fs_info,
>   				struct btrfs_path *path, int level)
>   {
> -	struct btrfs_disk_key key;
> -	struct btrfs_disk_key *key_ptr =3D NULL;
> -	struct extent_buffer *parent;
> +	struct btrfs_key key;
> +	struct btrfs_key *parent_key_ptr;

This is the cause of fsck tests failure.

@parent_key_ptr is not initialized, but I'm also wondering why compiler=20
is not slapping a big warning onto my face.

Will update the patchset and even try to figure out why compiler is not=20
helping me in this case.

Thanks,
Qu
>   	enum btrfs_tree_block_status ret;
>  =20
>   	if (path->skip_check_block)
>   		return 0;
>   	if (path->nodes[level + 1]) {
> -		parent =3D path->nodes[level + 1];
> -		btrfs_node_key(parent, &key, path->slots[level + 1]);
> -		key_ptr =3D &key;
> +		btrfs_node_key_to_cpu(path->nodes[level + 1], &key,
> +				     path->slots[level + 1]);
> +		parent_key_ptr =3D &key;
>   	}
>   	if (level =3D=3D 0)
> -		ret =3D btrfs_check_leaf(fs_info, key_ptr, path->nodes[0]);
> +		ret =3D btrfs_check_leaf(fs_info, parent_key_ptr, path->nodes[0]);
>   	else
> -		ret =3D btrfs_check_node(fs_info, key_ptr, path->nodes[level]);
> +		ret =3D btrfs_check_node(fs_info, parent_key_ptr, path->nodes[level]);
>   	if (ret =3D=3D BTRFS_TREE_BLOCK_CLEAN)
>   		return 0;
>   	return -EIO;
> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
> index 3cca60323e3d..5ed8e3e373fa 100644
> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -2637,10 +2637,10 @@ int btrfs_del_ptr(struct btrfs_root *root, struct=
 btrfs_path *path,
>   		int level, int slot);
>   enum btrfs_tree_block_status
>   btrfs_check_node(struct btrfs_fs_info *fs_info,
> -		 struct btrfs_disk_key *parent_key, struct extent_buffer *buf);
> +		 struct btrfs_key *parent_key, struct extent_buffer *buf);
>   enum btrfs_tree_block_status
>   btrfs_check_leaf(struct btrfs_fs_info *fs_info,
> -		 struct btrfs_disk_key *parent_key, struct extent_buffer *buf);
> +		 struct btrfs_key *parent_key, struct extent_buffer *buf);
>   void reada_for_search(struct btrfs_fs_info *fs_info, struct btrfs_path =
*path,
>   		      int level, int slot, u64 objectid);
>   struct extent_buffer *read_node_slot(struct btrfs_fs_info *fs_info,
>=20

