Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EA62E756D
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Dec 2020 02:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgL3A6F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Dec 2020 19:58:05 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:42613 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726335AbgL3A6E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Dec 2020 19:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1609289815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AxWwMpo1chUF3QolNJ2wMKQg++dUPu5x7ZuxKie9ee0=;
        b=hb3pODXGfFctmfbUbhxp/c8E4PGBpIfw9Psl2k6bnjNe8WqLxVeBCRQfkwAHEM+oyDcQ/H
        AIP0ktGZf9tpZkkd5M/xaP/xE/89Z9Gi9GRi/+4kiVTjKUDAr/iFgXIKwq1LfEN9a9bc9w
        KgDkW6a7gGIAhq8CUzteUOv9HSkXUDo=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2058.outbound.protection.outlook.com [104.47.8.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-40-iMmy_RXpOUSHzNux1cNouQ-1; Wed, 30 Dec 2020 01:56:53 +0100
X-MC-Unique: iMmy_RXpOUSHzNux1cNouQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ku11Rfz5Yh2MNUdIf3GYB5u2b8R//ZfGUd+GRMHDbzuhrKi0+SUGU23PdV2Rajno6u/At9c6TGfmCR5eW8Wr+eccxpGZRlnPY4fwo9WFPA/qUfO5jO4bBC9AVkCgwgO0tbGaxM404SxBiUDPueHO7V3go6L9C9Ruwgnlg3IGwxNPQGsPunbj680LAHCZEaccKiR9WTc0KkBV02CxpvARehsdGVPTvbKKcd9DLT4ZQeHNoKjK5qSmqaZYWLs5W8tQGvKJXe6pBDm7/rM5o/tPeFecyroq7vPSLccCXpF2W4FUWb9/VWIZwtCN1EA2GE7b5JaiFaVuqBXUlOvr64zfoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRLRwG3YUzYftWj6J1LjlEApogvEPV4grBWDlZ6/CSI=;
 b=L3LqY4MMSH5/Aw5Bl2fkZ/SY7sFXwZtfvx6p/i2fhVRCEFdk32RuYltaClfLvPQnqd4RaE3ORoIvaUTA/44n9lK++rmmI6xiTmK0qtzFtQlXVgHo5okof8VFkq16Uz4MHPzLInG3+tPVopSXpH5tOaaoGB65u22rluaIQz6F7U2WbQ1DZ58/9PnM9pCxqU/gwOlx9VnmPr5LNbvyjaWbB/SreXNz0G2QJu5ARaACh0U+/XB+J3QoztV/c4uqOSfWrZ1srm2JhsDtdZZUhS65OYDrTyBwv9JnQFAPEbXZ8HjKKlSKBD/elcp0muQQYLEbmWY0hMm1GaD3GbVNFgdGwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lesimple.fr; dkim=none (message not signed)
 header.d=none;lesimple.fr; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PA4PR04MB7758.eurprd04.prod.outlook.com (2603:10a6:102:c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Wed, 30 Dec
 2020 00:56:52 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::397a:950:d8c8:d709]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::397a:950:d8c8:d709%6]) with mapi id 15.20.3700.031; Wed, 30 Dec 2020
 00:56:52 +0000
Subject: Re: [PATCH] btrfs: relocation: output warning message for leftover v1
 space cache before aborting current data balance
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
CC:     =?UTF-8?Q?St=c3=a9phane_Lesimple?= <stephane_btrfs2@lesimple.fr>
References: <20201229003837.16074-1-wqu@suse.com>
Message-ID: <8ccfddee-3de4-f3ae-bb18-eadecf9621b4@suse.com>
Date:   Wed, 30 Dec 2020 08:56:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20201229003837.16074-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::19) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:33a::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend Transport; Wed, 30 Dec 2020 00:56:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 564a25c8-d207-41a2-346f-08d8ac5dcbba
X-MS-TrafficTypeDiagnostic: PA4PR04MB7758:
X-Microsoft-Antispam-PRVS: <PA4PR04MB7758FA85A4B4724CC85D8715D6D70@PA4PR04MB7758.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xzUKf650hGNtIRR3s9UtMF+hC5O1MbGkNT9g8iaGUxy1FnuoptQPHfhHOq/MeTpus4wPaTEPWTtmJqAtjbcsMFkCL9FLMCzVkaEDq4VljhyADfQxabF0yj7EA9v6verAgHBuALsD9dXkkgesS3Q/JFVe7osJH+15wBPg4TqWtFNDHq3WTedc/ZIXjtr1bqDZFjp55WZiwO+uEOSOuOD8Kr6Ya1xNkAAk1Pp81qemZwplmROsuSS5YpEX52CR4GN1DebYkjc1pDuM7iivnzsnZtZwqvq+NOQ4Gs7JEz6wd14gVX7y7pSZIhKbFQ2W2/Dea/dxTdhc5RjhU20bKosg+hDl6RsKyn+Pe257zP6b1q1HAu1zWONJZEoxhx44o8A/6AGyksxWvnBPupo8Fs6KzjKDlvDSNKJfW87P6yJyjqppHGH6dfRkDn6lRyPIJSH29klXxMjp806ola5bTy9noIhphK5NZegl1F+bt/D14ZDDQHuxo/KiAveG0sYR9cZ/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39850400004)(31696002)(6666004)(5660300002)(2616005)(6486002)(4326008)(478600001)(66946007)(6706004)(86362001)(16526019)(83380400001)(15650500001)(66476007)(66556008)(316002)(26005)(2906002)(186003)(36756003)(16576012)(66574015)(8676002)(956004)(31686004)(8936002)(52116002)(6916009)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zwVkDrI++xsr17MWjeY40QpynwqkuHbF72q0vrJGddlzf5Tq1o/HaliE9Eqy?=
 =?us-ascii?Q?qTYGb+RaOJqkhV2NzCh5icosdKAkUeeWTwqdYbhemogYNeUN38ZdPnaBRxZs?=
 =?us-ascii?Q?l4HJWN4ron/6xyBNn+6UjXhgCxru1nkbMp0S2Cvbz9KNh+dp+NPXZIdzpygS?=
 =?us-ascii?Q?NFtu59BNMzCFmsF5asT5XzLdFVsb38fqfdDSoo5MtlvLe5P9yHO325oopoqi?=
 =?us-ascii?Q?Gpi64TxuY1YiPrOQ9leiOEvbN4VqwHXL6VRslC7qgTVcZiMHZrM6ZzLt6gIs?=
 =?us-ascii?Q?Z3HfxiA5M2imuRpZ/id/uc1ORLhwa/I4clPfFwQvemPHviIz0RllGpDVeBTB?=
 =?us-ascii?Q?7q5gJbkSAplQjcNSMOJAvYG+KQFs2VmDHK7LnDzi2gXSKX8SX2nvg5+6vKdZ?=
 =?us-ascii?Q?+k/a5ASEbMweGTQqaIgAQHF1byF+oXSHhJStZkrWkJZiDHSsS2mZrgvX5qij?=
 =?us-ascii?Q?waaZgvL/iWfMXNdH3B7oqwP6gUZkP6gFZS+2Ns6cvUBaYMVP10pDJ/WI/a11?=
 =?us-ascii?Q?qVsXup110ejr0AL/GgZQvqZENZSIpQxXoB0K718mr4FrBtMBzdYl2sWZ3jDT?=
 =?us-ascii?Q?asm1F5H1oJ3K3Qc8niScQ0bJ5r3MKG2ziwt8HggeTjL6P16nRfBg8pRv4ofw?=
 =?us-ascii?Q?rmvdKLaB7cGtfQa/fzqaQTX8BSQAMjtGIR+mjFop4iZn4K5mi60yay4saR2G?=
 =?us-ascii?Q?XDRbU9umt7NWQ5jvl/a9dD3FQRTrTlwvQ5LSxLTewiYkBW+R0+zEuD5HIKT9?=
 =?us-ascii?Q?eM/SVj50ewFZ6pD57KunC1FQnEuY0CrVPShmXsaVKyg+iovgFlZiJAD2rmdB?=
 =?us-ascii?Q?4Ru6sJz5NnbJYTC1i8mAhsvxd0Zx7DVUJQmxakt3T1Mp16xHfmifkfUiNIm3?=
 =?us-ascii?Q?3iCZcfFMuxvUYPsCa15YyERvOdCrPMS6j5CH0YvqFXnLTFBSm0QVZI+m384v?=
 =?us-ascii?Q?yq7rXCMvB/E4BMPdmVX+ZpL1QK58NRC5mkKDRywmLN848+EqMOLj2DNQwlo5?=
 =?us-ascii?Q?WtE2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2020 00:56:52.1505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-Network-Message-Id: 564a25c8-d207-41a2-346f-08d8ac5dcbba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFW+cd008lC+n5ebz8rW0Tv74nts59YvboQM0UYxpO99YOvzo6fwQoSc+zb+sY4/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7758
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/29 =E4=B8=8A=E5=8D=888:38, Qu Wenruo wrote:
> In delete_v1_space_cache(), if we find a leaf whose owner is tree root,
> and we can't grab the free space cache inode, then we return -ENOENT.
>=20
> However this would make the caller, add_data_references(), to consider
> this as a critical error, and abort current data balance.
>=20
> This happens for fs using free space cache v2, while still has v1 data
> left.
>=20
> For v2 free space cache, we no longer load v1 data, making btrfs_igrab()
> no longer work for root tree to grab v1 free space cache inodes.
>=20
> The proper fix for the problem is to delete v1 space cache completely
> during v2 convert.
>=20
> We can't just ignore the -ENOENT error, as for root tree we don't use
> reloc tree to replace its data references, but rely on COW.
> This means, we have no way to relocate the leftover v1 data, and block
> the relocation.
>=20
> This patch will just workaround it by outputting a warning message,
> showing the user how to manually solve it.
>=20
> Reported-by: St=C3=A9phane Lesimple <stephane_btrfs2@lesimple.fr>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Please discard this patch.

This didn't really solve the problem and may give the end user some=20
false impression.

Thanks,
Qu
> ---
>   fs/btrfs/relocation.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 19b7db8b2117..42746b59268d 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3027,6 +3027,25 @@ int add_data_references(struct reloc_control *rc,
>   		ret =3D delete_v1_space_cache(eb, rc->block_group,
>   					    extent_key->objectid);
>   		free_extent_buffer(eb);
> +		/*
> +		 * This happens when the fs is converted to use v2 space cache,
> +		 * but some v1 data is still left.
> +		 * In that case, we can't delete the v1 space cache data as we
> +		 * can't grab the free space cache inode anymore.
> +		 *
> +		 * And we can't ignore the error, as for root tree (where v1
> +		 * space cache is) we don't do reloc tree to replace the data
> +		 * to the new location, thus the old data will still be there,
> +		 * blocking the data chunk to be relocated.
> +		 *
> +		 * Here we just warn user about the problem, and provide a
> +		 * workaround.
> +		 * The proper fix is in the v2 convert mount, which should
> +		 * completely remove v1 data.
> +		 */
> +		if (ret =3D=3D -ENOENT)
> +			btrfs_warn(fs_info,
> +"leftover v1 space cache found, please use btrfs-check --clear-space-cac=
he v1 to clean it up");
>   		if (ret < 0)
>   			break;
>   		ret =3D __add_tree_block(rc, ref_node->val, blocksize, blocks);
>=20

