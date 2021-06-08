Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FCA39EB91
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jun 2021 03:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhFHBmJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Jun 2021 21:42:09 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:42651 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231209AbhFHBmI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Jun 2021 21:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1623116415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=im4ePSwILsV2z3dXmhQ2aGecc1D8ibSKSYVIaBX4T/E=;
        b=PcfN4mjzD/4IC03VocRnvmEdmxVfdlefUvej3LqZ2baEGM5FpVrfmx1PvvUOxcG6YFe8PB
        ezzmbpSYmydr/WkYgMl+yFo+sI2iTyuToM9fSR3lZVB8Lswi58XD65DFMDlqBd5NGbeDMe
        40xCwWMK89MoaxB+k8VV7EQt1rD5xuI=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2058.outbound.protection.outlook.com [104.47.12.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-26-0USconT3OHaKqjPYVW2Ynw-1; Tue, 08 Jun 2021 03:40:14 +0200
X-MC-Unique: 0USconT3OHaKqjPYVW2Ynw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2ijIFopZ9P0QhGJ8XzHvW8fXHPV9aMYQYcx2J7SBKYWtBVLII5T6cY/q4Fcsk8H6V7ubhiLcjlOx22ryko8RtCxQwOOc5f2fJ/BCFei0VTdeiW8jqA5eLn+iR6JCUNu221T2SdNNZSENgpO/JVgp0RPKKmjPz7Xjzq987wWPXY+NCQzHyGN0LJTNF5F0zp5fNzp+Jfx+avxSSrBYVp7mSl0xdgKad5slhWKuCq1x/MNJ+jfyPT9OSBaybxLs0EGv5HvcactxMMMXtSBtZro8n98Xy7KOoG9pWMRRBUsk9h/rOprPretNAGmoGy4LF16H47CN+/Y9vihgc6XUDpEhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+J0+OTlIQfgz+/05lKgsn8cZT7KwlfZOOnOxY90gCg=;
 b=l00OAC3sOm2+aOf8LSjdZFPhiMFBsTVNnGYpwgNkztBFpSThI1uPxie/1wEVig8Kf3ULwpB95MU/fbAdvC0gmR0YF9gCtfCinrWqD4b5lz0SrGdroK4K7+6H8+pKh2quJRN4EIg5/Tyd3az6onjL99ncZMJHEe74KRa2pm8VyZ/D3KNq5n2PZyePh2W1kVQUCOXY24D62wBGOkix6BlJ6Xdtf0wO+c6q4eZCML4H3+pnIuZGRvkOcc+YnTk7ZewtkbqfYG8KD/QW2tifcCB8/Jkpu/Zob7/d+Hw2ZulzLrLORotYxPKYBcpfrR97KPYSUTrgXrypC44OuGJSNswnuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB4677.eurprd04.prod.outlook.com (2603:10a6:20b:25::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.29; Tue, 8 Jun
 2021 01:40:12 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb%7]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 01:40:12 +0000
Subject: Re: [PATCH v2 05/10] btrfs: defrag: introduce a helper to defrag a
 continuous prepared range
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210602021528.68617-1-wqu@suse.com>
 <20210602021528.68617-6-wqu@suse.com>
Message-ID: <2c837b61-5978-05cd-4731-5d40248c769b@suse.com>
Date:   Tue, 8 Jun 2021 09:40:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210602021528.68617-6-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:334::8) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR05CA0093.namprd05.prod.outlook.com (2603:10b6:a03:334::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Tue, 8 Jun 2021 01:40:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88130e4a-a7de-482b-5084-08d92a1e5b98
X-MS-TrafficTypeDiagnostic: AM6PR04MB4677:
X-Microsoft-Antispam-PRVS: <AM6PR04MB46773065599281FEED9A01E3D6379@AM6PR04MB4677.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OXldVZwdIaXO63cNPi9QLKZD/15hCxWKpIMUbo8NB7hw/RXT0w3Uch8JHYO1O7Gdp8p6JJ1FtrtYUtsb8GBTeq2CgyomU/5V72h8mhGuDwud9yqT/Joa0xB7ruwpAZ/dh0PzjOh2YkE2At4KFw3vaUNvphnITqTRQzB++FXkU4Ml+BT9vXWbUaE8GqCBY0kmyDbKOMjXFotgpz94Jcg+SRrrC35ppHSQeZlEnyeaaAALXvX+aoYrYGC4ZjpVNxKDTmesGhlHgig4IpZgLVm6XSFxJiWPluYnzoGnX9lrRvSV5+KCjOakDDOzzvniMbXIOk4gYkoBBkOW6hPMDGfdj5l9iSg4txEqQxgHrKHuIIsBSzFMg7miF7EJk+HITax6uZDgqRqN3fFLi9q2BwE5mjcH4kzGYMgT+kFF2di5yN/Lvccdado88g+BdcUn1ecguXiqg6zhz+dV3xEzH3TAVAJ2QYpUAkmoJ6NupXo/0NIO7AK8vBCwK13hnwEX6eU8xsjkEOlXz9AB3XL013tYXRJXDlrGf9BLF11aPjNKfokIfI8NlDEemvGXtjEvFMRXZJCZNJl2lNl+MsvhoYYWKlAgjcAAoH4hOBrN1ivUL9oC3w26fgHWo8zPhAFbG6SPUW25uLh/FdVleSCXP/vgIoC+y25m4Zl4FqfjTXsdQv1kgkeahCieO4J16pl9lcMIuYnNyvw0J24tiOzxYTUcxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(366004)(136003)(376002)(346002)(396003)(66946007)(6486002)(478600001)(66476007)(8676002)(66556008)(2906002)(16526019)(6666004)(6706004)(2616005)(956004)(26005)(6916009)(83380400001)(86362001)(31696002)(8936002)(31686004)(16576012)(316002)(186003)(38100700002)(5660300002)(36756003)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RLb9qVgBN4rI4ezGwVkZTOPSYcd+3KWc83IXZEI2/8PWAh/hBimu3ieJp0WE?=
 =?us-ascii?Q?LcqYXZg26pAH56ESXR20RqgGM/2yOThMxmUPab6wkCk3q/3HsRdXac+G40Vq?=
 =?us-ascii?Q?tDwFcY3fr8FCgE9qBcIJhOh1Yltav9kG6JezNW+MEGCvYumoRKL2jBjXO48b?=
 =?us-ascii?Q?qJ+3CeDfRI6gbG2IhAuhAwBTmzHIxDtXj5UwzV8ri/hcXI9tkLK5zCppDsKZ?=
 =?us-ascii?Q?7PwFhLvu/XjhRyHcCc8YTxMb4FU30nPy9GBPQf5q2WLlgI3hWi/3H+Ec04xv?=
 =?us-ascii?Q?mAHGhlQ08QdhEYXOxjAlPzRoEvAreXyySLtBKeOS6bwI+KHe0CjiBP8ONWhP?=
 =?us-ascii?Q?QAj17nEcztVtNP9nwuVhG923/RtEH4X4Y/Y3B+AWUqlsaLHf2N9wsHUtV07a?=
 =?us-ascii?Q?dLZwTZ5xONjXicSp0qD7aqslIVN4XTEXhjYca8/kjxKQm9B8q2EwLLJvPU1V?=
 =?us-ascii?Q?DrPbVCyNLPDq8Zls1FaxqSQ41sSs4I7BoYv1d9Urh2de/Sz2JEBjSd3bgaEH?=
 =?us-ascii?Q?+et55wyo8yI4gYkMCdEZfbUOG2eVSjpdkeUUyLJ9LldExQ+z6jzDCnJdMF3b?=
 =?us-ascii?Q?l5nE87MmYFN0ahQG/MK1iKiS3/AeV9FABVvA1AmPd9qdA6MWO/1HsiPhol23?=
 =?us-ascii?Q?z4B7WfYdrVP+Xg8AekAQuLz5tOJmIEeKm1oHSDNySstn1HPot8/0CiNERMrw?=
 =?us-ascii?Q?1QQzsv3gGsN48BAsP7gBTt23STI9q3A9mR1UM64cCufgUtMPnYLoKir26mm6?=
 =?us-ascii?Q?vd44yk97yXbcJq3W7g8l9Mh+rYD6RhSuumPLw99WuJe5zCU9IinozJBBcywH?=
 =?us-ascii?Q?T6jEtpeOx0T1Sh7cgjUZfRvCQoPBCzXacL08eUxRRJRE7kYZB45Mru3JJPu1?=
 =?us-ascii?Q?EFlESBI/rayHVzK6mVtOJWIBE9ygouZZOwwLd6kLKahq3rN7nIDVf4VgrCtR?=
 =?us-ascii?Q?6KloIv3NgCcKOHiFPLsORy3WczpMf8trN+lIQKXNRJoojKWTgtrtaynV+kuF?=
 =?us-ascii?Q?Kb8wsk27hFzpvE+n2TZRcZYKDCK6kb85pzFwR6Zj6X4E3eDdJXZ/pXuEjbBo?=
 =?us-ascii?Q?W6vAzUD6NAy5wWrcbgsmAePyHm3BCTigasXTEVPfkqx/BxsfX+LCZTG0omNr?=
 =?us-ascii?Q?VwwiOtQsMn2gawTnmWxSzRYfZQOhqpR7FqiKc/OjxYu9kWN4JFGyV+N4QEt+?=
 =?us-ascii?Q?9w09cNgRhAA7aTiHLM2TsT7XMl6r5m2Q3D9VRQPcv4aemXA/qeP2Qzlyed8R?=
 =?us-ascii?Q?mgHhB/AiR6qoI/UfMggs53UOIpOITO1tYV2w6C2NYq9qgAhUP4LrnZQ2EfB+?=
 =?us-ascii?Q?OsDkIpHJcQgzDPcEEGDSgee4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88130e4a-a7de-482b-5084-08d92a1e5b98
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 01:40:12.6836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIUul9JPQyRx6Pbz/oekzyhHnGjQV0kjjdITcsD596+SuuLPS8JPusDAtVpyh3B1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4677
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/2 =E4=B8=8A=E5=8D=8810:15, Qu Wenruo wrote:
> A new helper, defrag_one_locked_target(), introduced to do the real part
> of defrag.
>=20
> The caller needs to ensure both page and extents bits are locked, and no
> ordered extent for the range, and all writeback is finished.
>=20
> The core defrag part is pretty straight-forward:
>=20
> - Reserve space
> - Set extent bits to defrag
> - Update involved pages to be dirty
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/ioctl.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 56 insertions(+)
>=20
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 6af37a9e0738..26957cd91ea6 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -47,6 +47,7 @@
>   #include "space-info.h"
>   #include "delalloc-space.h"
>   #include "block-group.h"
> +#include "subpage.h"
>  =20
>   #ifdef CONFIG_64BIT
>   /* If we have a 32-bit userspace and 64-bit kernel, then the UAPI
> @@ -1492,6 +1493,61 @@ static int defrag_collect_targets(struct btrfs_ino=
de *inode,
>   	return ret;
>   }
>  =20
> +#define CLUSTER_SIZE	(SZ_256K)
> +
> +/*
> + * Defrag one continuous target range.
> + *
> + * @inode:	Target inode
> + * @target:	Target range to defrag
> + * @pages:	Locked pages covering the defrag range
> + * @nr_pages:	Number of locked pages
> + *
> + * Caller should ensure:
> + *
> + * - Pages are prepared
> + *   Pages should be locked, no ordered extent in the pages range,
> + *   no writeback.
> + *
> + * - Extent bits are locked
> + */
> +static int defrag_one_locked_target(struct btrfs_inode *inode,
> +				    struct defrag_target_range *target,
> +				    struct page **pages, int nr_pages)
> +{
> +	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> +	struct extent_changeset *data_reserved =3D NULL;
> +	struct extent_state *cached_state =3D NULL;
> +	const u64 start =3D target->start;
> +	const u64 len =3D target->len;
> +	unsigned long last_index =3D (start + len - 1) >> PAGE_SHIFT;
> +	unsigned long start_index =3D start >> PAGE_SHIFT;
> +	unsigned long first_index =3D page_index(pages[0]);
> +	int ret =3D 0;
> +	int i;
> +
> +	ASSERT(last_index - first_index + 1 <=3D nr_pages);
> +
> +	ret =3D btrfs_delalloc_reserve_space(inode, &data_reserved, start, len)=
;
> +	if (ret < 0)
> +		return ret;
> +	clear_extent_bit(&inode->io_tree, start, start + len - 1,
> +			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
> +			 EXTENT_DEFRAG, 0, 0, &cached_state);
> +	set_extent_defrag(&inode->io_tree, start, start + len - 1,
> +			  &cached_state);

Here we can allocate a new cache_state, and then no call sites to=20
release it.

This leaks the extent cache allocated.

I'll resend the whole branch with @cached_state passed from caller.

Thanks,
Qu

> +
> +	/* Update the page status */
> +	for (i =3D start_index - first_index; i <=3D last_index - first_index;
> +	     i++) {
> +		ClearPageChecked(pages[i]);
> +		btrfs_page_clamp_set_dirty(fs_info, pages[i], start, len);
> +	}
> +	btrfs_delalloc_release_extents(inode, len);
> +	extent_changeset_free(data_reserved);
> +	return ret;
> +}
> +
>   /*
>    * Btrfs entrace for defrag.
>    *
>=20

