Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA2E37250F
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 May 2021 06:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhEDE3t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 May 2021 00:29:49 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:48907 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229715AbhEDE3s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 May 2021 00:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1620102532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3CCXawVs3Yhq0neYsFf5hVFSJZS6KvoAIKIv9nDUK/Q=;
        b=CqGgPb2LJOmQphMJaK0JwtUR8ZtJ8oXHTy2As5d4XIrICLWkK6QGLqUoIHpKvG3zTSib/L
        rapjZvsx0MCc4XfsretN24Ozp2TQv5fAsprq6gawjqSN4IwuOIawstBtmPr1OllSsNa3OO
        XhfB1WM58XDPxq23nslj9Onknc66GUA=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2110.outbound.protection.outlook.com [104.47.17.110])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-38-eUWVHUuFPoCNYR3xU91Rbg-1; Tue, 04 May 2021 06:28:52 +0200
X-MC-Unique: eUWVHUuFPoCNYR3xU91Rbg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ef/XslrNq9xXaLxk3mEQYxsLUW2N1iTsQsu+oztoqr0XCtx35GPB+D1E/VkueU02Sn8W1Pj8tvtYs1z4Ysgkg1nRGECu0r4Nxym6QEeDEGC6st7SKUXkyWjbRulgBQMB7ZrnyF8evh8aFxFP9+Z7yzE2CtVANko6KqfhxGN1zxsxcSE4aU0py5Mg/ABkFLos1o7clDxCvec9vA54ax2lq4TUW6Jb6WRZl2597BSnjvt6Vjfzt4US2tv+k5DkwzX46iYZE7ScPsL59qTh9lC8Xw+9D5odjLS3WTfzVyi8xjawAsDGboXqAg7jnSwbjVrDvs5fKI5YlrLOqskQ6jKNvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6Z7tq3vXd2DY5BU3YlgsUD9Ib+xcxyBc+RhN4QkOzE=;
 b=AfoOfDlguaENpqOf5B8euWXxmD8nwPtvfE9U/uomWfhUIg9V8NWrZUlPKU7W7EaLuAd/Hof2Zwy+W4/H81CYVS+vXOM7Me2W0CYSiE8U2ibqpJGq7J3k2uZ0/z7I8v8EwtCdVMMKsAUQtLR9d69vfR10k4ZkCDITYYxarXRDm2laKyDYHcClHzJibQVCbcNo1ROXtBMHmLwGPvl03KM2vBTo4Lt5dn4jx5ZN/UTCqTfaq3ywS8ULQjebwygF8rkSdd8xrNM066YpnAgKnECSUxgL7szp8gI31fmMfDdTb7qL4qVrF5zOOeOQ+xb7LVGOpJZt+IzFNB3xfSJSw8ieOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB8312.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.43; Tue, 4 May
 2021 04:28:50 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7%7]) with mapi id 15.20.4087.041; Tue, 4 May 2021
 04:28:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-37-wqu@suse.com>
Subject: Re: [Patch v2 36/42] btrfs: disable inline extent creation for
 subpage
Message-ID: <e512a263-ae5b-2d96-2141-d8221eaa4e8d@suse.com>
Date:   Tue, 4 May 2021 12:28:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <20210427230349.369603-37-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR05CA0121.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::6) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR05CA0121.namprd05.prod.outlook.com (2603:10b6:a03:33d::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend Transport; Tue, 4 May 2021 04:28:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8369f503-0992-42f0-2c46-08d90eb51df9
X-MS-TrafficTypeDiagnostic: AS8PR04MB8312:
X-Microsoft-Antispam-PRVS: <AS8PR04MB8312ADB0C7415531A84E9E6DD65A9@AS8PR04MB8312.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9PIZaklo8uC0RKSQS7QLUgNlWeFLVCMtmpVQed3nJ/XcGgiDTgCINCmvBzo7JuUP50mV3OSYp1W6nQzObXUXG5PUR0zq6gMhQ5znND7wXlVupLH2n7ybSJn/gLwnjKaFOp6pX2OExQbUo6sUoCgz7Z64fiCXhjaBgVzFGaHuaVRvVikgdM4ZZVM09iT76nFFdQ7e3sBBdXLHOCCXSM8fz3DXppzw1bFhJfazhyg19s/CKO49+g8LpxrM0BUvxEbw25/mo7uvT3nsoWoUXSxk9m/VB0V7M6LTDnsqtE+5zhbYP8Q/Zx/bOZ9u5iN2wCWyA1e3RQ4F4c04vYZ8xienWWQ0iqBYnQFGNZ/v7B8nz0IqkkMZdIpIH+wqiDiEzPV3hrRSrYNLDGgRhMDRC3gExih1LFfUxkAMECysB2oOUpDUZhyrVcQTteLZ97eRFVDytnaf+CrjlU2/m/O1t0xj6cyJR2ubB9dmMbVCjYsM4hYiRZgih2Jsb4J7Aw5LaUYrx4oQtzz9YK6+g4Zai8LCq+QrjRYBSpDjEiNFYyRDAF5fkSiNRLlmZ3dM80TXhYb73uuK35mc3U0ulb3p1EqSG5tsGeCFnu7tbaqlwalnRb6l4y2IFPcCuJNnsIcEB71q1gFlaO4jKTYJc181V12qeKyRESZ284iGc4aAAzwB1+7HVyAnt/V6OdC5hlUY/TQYKs1lzPcgpWTe1vBqXhnPZT1n78Dw3kQGtfRbwmv+FYQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(376002)(366004)(396003)(66946007)(66476007)(66556008)(5660300002)(8676002)(26005)(2906002)(38350700002)(6706004)(38100700002)(6916009)(6486002)(6666004)(31686004)(186003)(36756003)(956004)(52116002)(8936002)(478600001)(316002)(16576012)(2616005)(86362001)(83380400001)(16526019)(31696002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Vz2Gi/FbpbGoMRKmJghHmXZm704Fctcq5xZByv0ICamJDAa7R7W8AyBkU9Zz?=
 =?us-ascii?Q?td8f20V3x+w2HTB/5YtxWdYpEWO6AwXtD82ObquZanIfm2joR4Tqv8IOtFad?=
 =?us-ascii?Q?odnjs3AvHSCD9qJrOfs6xBZuNyErQx54BLFYPbN6IXNtZbnGWTRCOBMY73+a?=
 =?us-ascii?Q?woOJi4NOaUNW6CUgRzTVXvhgIzTHNdPJ30/1cfh+0jYlu3to5CHY4VQyuw9q?=
 =?us-ascii?Q?jI5PMqkTWlWpjhhtYS4tYnLk8P647qo8+lJcOOwhQcMhOcANtJhj9jnonHtq?=
 =?us-ascii?Q?Ms9Q3TB2wyl0AQzb3a1NRI9EyKhPfvauWtpIwCCyXUDguyCN5A/XDhJ/e6/z?=
 =?us-ascii?Q?K8mPHYjz7i84zGVSXxtuqxaUYsO7XM9LQqkoMsu0WzkX62RxOGcIK6J9G6Zw?=
 =?us-ascii?Q?W9Z5vv4rNjhJOhnF0s8ddcXwNGnTcGO7j8jfRWs7z4C4TnBlEkE0yL7jrOTo?=
 =?us-ascii?Q?1u7GPFxqFeDHRWH37wkXNtdKpJ5Yq2OJDXKJ96pliGNA47x2l93kKK65As4t?=
 =?us-ascii?Q?DOu2IVLiIhf2yb6wnPu9bV8gz5htD1G1pavcYofd77eznRxe8V3pvpFaYhPQ?=
 =?us-ascii?Q?q807CMMNoapuHK+W6P7nLlna90fPQ14LGjbh1vovm41R9SEUGK0nzfChFwBY?=
 =?us-ascii?Q?svfl7GUCbYPUncf3Ct007mhpCHzD2wQmJta5IYfETZcCTw3gPQA/LsXmWWxI?=
 =?us-ascii?Q?MyYO2QBdI+cxcrieFeIspsHhlczUFhXBr1JqUFeLojDlsai4uDeeugRcZx+Y?=
 =?us-ascii?Q?L9pYcMmf6yAUAdkYeTW3RlBk2MWgY4FUMOpnjWI2wDH1KmxaT9cpr48VHz2+?=
 =?us-ascii?Q?QcCphErMTQ4LQDav2AXtq7pZboEjDE4Pnix7SEZk93u9YAq/ttoeTUmGkqRy?=
 =?us-ascii?Q?ErOOVAcorSNc0VKJ//Z7QztPgE69ZX9Co3PMd1HTDdoZXiJ6O2zMGuEyXsks?=
 =?us-ascii?Q?nMWyakvGyHBtGD7nmFyiihtGYSurAjOa29eJ785zk1VkRFm+l1l/Iq2CZ9MJ?=
 =?us-ascii?Q?2/dB0LAlf608YK2fescAuYzN7LUIbh8yvXhhhJMhnAR+SExFWNkBMOwFyaI1?=
 =?us-ascii?Q?M0+gc8+xiQTzKNsdedOur/Hs3gJApOijVIbPyQIXBSwduV6CCYqOuYRkwdgf?=
 =?us-ascii?Q?0NScwI9JStYRDajmx6sWNAhlhPUo0gjoLx6gNKNMJxRuq/SAHP/X4674bjAX?=
 =?us-ascii?Q?pz5Fm65xBqn9sStv8gazF/qUWLFf74ZBEdjnvtxb/D/cBYCzhqx1VvSjan8j?=
 =?us-ascii?Q?fbwiWGrMcjWrJjsqmZfI+v70VNb0OjWowwDu9Kunfy+92JlInliJKU83I019?=
 =?us-ascii?Q?7uEgWpnyPpePdeLMRh2kffVt?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8369f503-0992-42f0-2c46-08d90eb51df9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 04:28:50.6405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3fXMseIqfkgY8fmKSYYtlR95Rc4zUbbRL5k3dPh11qeqe3rW19XrqI/oBsw8ZMW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8312
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/28 =E4=B8=8A=E5=8D=887:03, Qu Wenruo wrote:
> [BUG]
> When running the following fsx command (extracted from generic/127) on
> subpage btrfs, it can create inline extent with regular extents:
>=20
> 	fsx -q -l 262144 -o 65536 -S 191110531 -N 9057 -R -W $mnt/file > /tmp/fs=
x
>=20
> The offending extent would look like:
>=20
>          item 9 key (257 INODE_REF 256) itemoff 15703 itemsize 14
>                  index 2 namelen 4 name: file
>          item 10 key (257 EXTENT_DATA 0) itemoff 14975 itemsize 728
>                  generation 7 type 0 (inline)
>                  inline extent data size 707 ram_bytes 707 compression 0 =
(none)
>          item 11 key (257 EXTENT_DATA 4096) itemoff 14922 itemsize 53
>                  generation 7 type 2 (prealloc)
>                  prealloc data disk byte 102346752 nr 4096
>                  prealloc data offset 0 nr 4096
>=20
> [CAUSE]
> For subpage btrfs, the writeback is triggered in page unit, which means,
> even if we just want to writeback range [16K, 20K) for 64K page system,
> we will still try to writeback any dirty sector of range [0, 64K).
>=20
> This is never a problem if sectorsize =3D=3D PAGE_SIZE, but for subpage,
> this can cause unexpected problems.
>=20
> For above test case, the last several operations from fsx are:
>=20
>   9055 trunc      from 0x40000 to 0x2c3
>   9057 falloc     from 0x164c to 0x19d2 (0x386 bytes)

With more investigation into this specific problem, it turns out it's=20
really something specific to falloc() (and maybe reflink)

>=20
> In operation 9055, we dirtied sector [0, 4096), then in falloc, we call
> btrfs_wait_ordered_range(inode, start=3D4096, len=3D4096), only expecting=
 to
> writeback any dirty data in [4096, 8192), but nothing else.

This part still stands.

>=20
> Unfortunately, in subpage case, above btrfs_wait_ordered_range() will
> trigger writeback of the range [0, 64K), which includes the data at [0,
> 4096).

But the problem is really in the sequence of btrfs_wait_ordered_range()=20
and btrfs_cont_expand().

Currently, we call btrfs_cont_expand() first, then=20
btrfs_wait_ordered_range(), which leads to the inline extent then=20
regular extent.

But the truth is, if we just call btrfs_wait_ordered_range() then=20
btrfs_cont_expand() we will no longer got the problem.
As btrfs_wait_ordered_range() will writeback the first sector as inline,=20
then btrfs_cont_expand() re-dirty the first sector, so that it will be=20
re-written as regular extent, after we enlarge the isize.

I also checked reflink, which is doing the same cont_expand() then=20
wait_ordered_extent().

AFAIK we could just change the sequence so we don't need to disable=20
inline extent completely.

But I'm not yet 100% sure, thus I'd prefer to make btrfs-check to report=20
such inline + regular layout as an error, then do more tests to make=20
sure it will work as expected.

Thanks,
Qu

>=20
> And since at the call site, we haven't yet increased i_size, which is
> still 707, this means cow_file_range() can insert an inline extent.
>=20
> Resulting above inline + regular extent.
>=20
> [WORKAROUND]
> I don't really have any good short-term solution yet, as this means all
> operations that would trigger writeback need to be reviewed for any
> isize change.
>=20
> So here I choose to disable inline extent creation for subpage case as a
> workaround.
> We have done tons of work just to avoid such extent, so I don't to
> create an exception just for subpage.
>=20
> This only affects inline extent creation, btrfs subpage support has no
> problem reading existing inline extents at all.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/inode.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index fd648f2c0242..a2ac8d6eeba5 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -663,7 +663,11 @@ static noinline int compress_file_range(struct async=
_chunk *async_chunk)
>   		}
>   	}
>   cont:
> -	if (start =3D=3D 0) {
> +	/*
> +	 * Check cow_file_range() for why we don't even try to create
> +	 * inline extent for subpage case.
> +	 */
> +	if (start =3D=3D 0 && fs_info->sectorsize =3D=3D PAGE_SIZE) {
>   		/* lets try to make an inline extent */
>   		if (ret || total_in < actual_end) {
>   			/* we didn't compress the entire range, try
> @@ -1061,7 +1065,17 @@ static noinline int cow_file_range(struct btrfs_in=
ode *inode,
>  =20
>   	inode_should_defrag(inode, start, end, num_bytes, SZ_64K);
>  =20
> -	if (start =3D=3D 0) {
> +	/*
> +	 * Due to the page size limit, for subpage we can only trigger the
> +	 * writeback for the dirty sectors of page, that means data writeback
> +	 * is doing more writeback than what we want.
> +	 *
> +	 * This is especially unexpected for some call sites like fallocate,
> +	 * where we only increase isize after everything is done.
> +	 * This means we can trigger inline extent even we didn't want.
> +	 * So here we skip inline extent creation completely.
> +	 */
> +	if (start =3D=3D 0 && fs_info->sectorsize =3D=3D PAGE_SIZE) {
>   		/* lets try to make an inline extent */
>   		ret =3D cow_file_range_inline(inode, start, end, 0,
>   					    BTRFS_COMPRESS_NONE, NULL);
>=20

