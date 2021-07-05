Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E303BBCFA
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 14:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhGEMq0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jul 2021 08:46:26 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:43578 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230188AbhGEMq0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Jul 2021 08:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1625489028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZGpyZF/KLKkbWaKRafXLO2VMyZISVO/C+uwuwfD5XJQ=;
        b=jpauKKWXhY4mmAg60r93wZb6cdehd9xEZ+Ql3nVlWpSTtkrDuxr0soSM6KF5wFcQLrE2Mf
        9cZYU+4iuPenPaaHVdIWlFeBlLogNSyrs2Md8WRBLoBtIAuWG/H1CdYhTv/auQAmONHTbX
        nQXt/WSrGiby6Mq6BkWZ1yAakMBszUc=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2056.outbound.protection.outlook.com [104.47.8.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-9-K4uQ5-GRPGSrrlmfdrkUJA-1;
 Mon, 05 Jul 2021 14:43:47 +0200
X-MC-Unique: K4uQ5-GRPGSrrlmfdrkUJA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMAeHWvbPHu5+plXlmaLB1pCqDURDPcOgMbJLbLnuixBiBar3NVOH8uriymmnoonAg9jvdafrAESPMgYL4SffNCMYD1CTaKpcC5PGQpmcl/gityvNXr+AgGMAjm+kepwfKR818xiTiW0wakVyiGTSJQiXaNXHDh7l2I6xFk+MW7aDRjGczePldSwrhLr6PG5yLyoF4fdeDlTzW7ZSPBLudzUWd1cnGQY4EDBln0yZ4Z0I4HF7wR04luqzMrdK+DTOSi9xHPrkhNnciBbaPTT437pX75IWBu94OkAY1tRfkxEskGWs9Scpb3eYSLOvC2JWA9Mv9MdFq4m7mxkevfuPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqQkDcBjGmuCy8zPJKFmb+xqUE/N4uY3VDaMTCnhDzk=;
 b=ac//jIAeYg1XrE/s6OxkucpHeWxAL4TXhuphhM/Xlz9AhU3X1uR2QBlzF3wWd72CKUJ8HfkQ78iAJGR51Kf2dll4AvToC/nwlMZHNOJqd6RPDGF1YlhftiC2rlztsIQD2HE8rysPk8++N4EEqmKxX1j9SVEuU/byiDHDS5xcyiW+ZAi7owxIu7lXwYQR4Bb6sL9lrffov0lMG0E6srJwR+O3FCRWB8481vAe1jnEpQM2RAXGi6dO762zktIHDi81ncdwg+zO+Y3vshTDxRsJiqjDU+bylPqU2PFX0kqEsFbCQRo1y6znB7o1MDHDyBVkDz3YhOoZBn61M2kduNLLmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM5PR0402MB2898.eurprd04.prod.outlook.com (2603:10a6:203:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.22; Mon, 5 Jul
 2021 12:43:46 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65%3]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 12:43:46 +0000
Subject: Re: [PATCH RFC 7/8] btrfs: make extent_write_locked_range() to be
 subpage compatible
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210623055529.166678-1-wqu@suse.com>
 <20210623055529.166678-8-wqu@suse.com>
Message-ID: <38b7154c-2e95-4913-ebb7-82939b17f678@suse.com>
Date:   Mon, 5 Jul 2021 20:43:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210623055529.166678-8-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BY3PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:a03:255::26) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY3PR10CA0021.namprd10.prod.outlook.com (2603:10b6:a03:255::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend Transport; Mon, 5 Jul 2021 12:43:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 105fb405-31fc-4075-1340-08d93fb2877e
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2898:
X-Microsoft-Antispam-PRVS: <AM5PR0402MB28982167132AF82F860C4A37D61C9@AM5PR0402MB2898.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: csEWC2/8y6EhjggATdJMQ+BHMTUlhVsutT0D3lhHGSDjjzTrpRvr7ZK1hq+h7c3xTYiEnCQLGB+i9l7sLYtyqPgDu8E+49tXxxNcLE3asquY+YOlOU0BjxgpP1/tP0fjiCy50dKaAzevZwMlW8lkI137ZRFNUl80aQIxetALgKbLImMoHTMv1+34wDhwAN0pOx3zN4xnGbVfE3F1m0EGsbpkFLGFEzeHoAA/mbwtnKtlshW44Y5nEgPDndv1g8XN/vjwHPAlO5MdNd0Xx9XpAz8qAVog7T9aBEbcA5jzTf7QCLtiP5IxbMTibeqbC8kFJQf+I14mUh2sWM+el7/zPz6eyD/wbPl8FyxqGHNtW6jSOixigR0zfAcPNxOaRqWigWhjrn2wxhxJxHrJAvfAXRXxgXFuPvcO7z976YI1hmzhBjUl7y8eCuw82s7HiDCSOXLpfZ81ESkJkT9ezarwfITd++Ta5Dg+7RIkiqUBH3OKrGbwhtcE4k28jdkRwMHpFoYLCvLCftYTeDlcGJV6VrxFa+CCc4ypb6uATii+jLG3x1Q5DSCB6uyIk+oPxi2B8neB5eBCIuqsSNspzgJfIBp4asL80xXyUpJ3QYx+JA+jjU9svNIDQAAjOXFcZoAVWBtdG5gcXFeb+OmQcQhAtLQA3u08YoSEyhREq9ZtlxPOpvD5s/KLh++8nb/mFVzQH6/dNUr54480OIDIjZemXEvWt+8PAcyyfoc7YnqQUnMVduUKPdEfoOGCNvlttSDm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(136003)(366004)(376002)(36756003)(86362001)(6666004)(31686004)(6916009)(956004)(2616005)(6706004)(316002)(5660300002)(6486002)(478600001)(2906002)(16576012)(66476007)(66556008)(83380400001)(26005)(66946007)(186003)(31696002)(8936002)(8676002)(16526019)(38100700002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eJtfW0ScZ3T2Abv7r7wfVonbmcbcl++wTvJP94tkBjTXeUwY16lJqYOLaP5X?=
 =?us-ascii?Q?J5qPNNMI1aaAk1VwJfL4Vzm9L8McQuJ2/iIpYdNOfn7REq0kDrYb49vK1ita?=
 =?us-ascii?Q?Y5kU+q8lP/nnpR5m1sDiJa4ifw4uS3UD1zPCcEJk3rgDbClW2E8Y8VfeQlM+?=
 =?us-ascii?Q?XHmNFTEA2AILGtQuw+ghqDUr9+GvozvNIVIJw9GTNVyexGsbTDWYYHF/EqLX?=
 =?us-ascii?Q?kPfAr1Gp1HvPSkL9/McES84xJmQyicJPYmSXBEcMixz0U7JIWVe+/XcLt4oy?=
 =?us-ascii?Q?oSgGsaCinw60EC9xaG/TgbZs0lJ2JmLbCPizWI63ao8vn1OH5pDb24xY7NsT?=
 =?us-ascii?Q?PC2nI3JISlpgmun9ilbi6dimol3h6bQitPDr+booPGOaaU+WJL8MmeFK8Xup?=
 =?us-ascii?Q?KJ+IptK83VwydnHt1MYrAJOqDegLK+p9IfPFfBjbMeLk2AHI9OApxmoaOKBC?=
 =?us-ascii?Q?YEJBDtJ60GHf2SAprBh4srpkqoIrVfFFkqVIQvrujJ/cr3yW64G7uxDSzBzm?=
 =?us-ascii?Q?6Ha8I5v1HOZaxBRpPRcPhVRYi2nMkmu7BfLOptbIHoL0Avg7DB2W8A+qiQUi?=
 =?us-ascii?Q?3FEekts/ZTXGKv66hEDIz99hJKMKOnvqPSs2zXsi0Iygqn3hk7EY3bzU8NzH?=
 =?us-ascii?Q?y0nmsddCcUCUzArl/TNLCfm0afH6B37XVcfDxXzt8MeK5p3KiXAcFUCzuZWZ?=
 =?us-ascii?Q?dIYRvlpwbZRiwebfcX8f4hIwoHwf4yOJ0P6j9oxop9sdG4DjbVrfUXhf+b1a?=
 =?us-ascii?Q?qlheYxA9sciSnwe8ui+3DwDqxAfIDwFX4dgCl/lsvJS67m9+db/9+nD2c5L5?=
 =?us-ascii?Q?K98JqhKmCTHbbjTf5XlmROro921KhcX+Ts18eW9PlpwLaeHeJycuyNH23HPD?=
 =?us-ascii?Q?423rRaVjBureoLQ9oAl9MYVrYS8L+bBuFzszkPPfxQ2Hj9KO+DV2zFVHLvqe?=
 =?us-ascii?Q?GINZ6GbB0H7WJIYzmXDQTr1zFxTbMUBkvC4vXpjgLoFH1c/1AZQx9va/XPOv?=
 =?us-ascii?Q?Uo2cNcJqhHQGl75m/EtZNg5NOrjkAwCyY3p94yUn1dWhegDag5Mwv0SMRJug?=
 =?us-ascii?Q?5pMi4ueciBXgswfFTnqQqLaOUWSgy7gRj1vCAqw5AXdpExcf2pzEmpVezZhJ?=
 =?us-ascii?Q?65TXyifSbJDffyJXJRaZKynjpcMoDPlMA1jWtR4m2+vphBzr5xB8lWJ0y3b0?=
 =?us-ascii?Q?egE5roJu+vltTM01a5W2euzdupVfXLrLU0ipa0U7bcryA82W7U6V5NMnj3gp?=
 =?us-ascii?Q?faY9uJAxUuvIsjFesCfwtpu8nqbWd1D2r7zxqvWnfE0UR6AhhIXivDhbbfEW?=
 =?us-ascii?Q?ZZn0WWzLzd0s6m3MGkhj7aKS?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105fb405-31fc-4075-1340-08d93fb2877e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 12:43:46.2408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDW+CKCtfVy35hdIq8R1ZsKR8wwMk4N7XW6jJ+kLBRkKz1MYD5SkrzVSk+ah424w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2898
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/23 =E4=B8=8B=E5=8D=881:55, Qu Wenruo wrote:
> Function extent_write_locked_range() gets called when an async range
> falls back to regular COW.
>=20
> In that case, we need to finish the ordered extents for the range.
>=20
> But the function is still using hardcoded PAGE_SIZE to calculate the
> range.
>=20
> If it get called with a range like this:
>=20
>    0   16K  32K   48K 64K
>    |   |////|/////|  |
>=20
> Then the range passed to btrfs_writepage_endio_finish_ordered() will be
> start =3D=3D 16K, end =3D=3D 80K, and the page range will no longer cover=
 it,
> triggering an ASSERT().
>=20
> Fix it by properly calculate the range end by considering both the page
> end and range end.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index e244c10074c8..c5491720a346 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5070,16 +5070,19 @@ int extent_write_locked_range(struct inode *inode=
, u64 start, u64 end,
>  =20
>   	wbc_attach_fdatawrite_inode(&wbc_writepages, inode);
>   	while (start <=3D end) {
> +		u64 cur_end =3D min(round_down(start, PAGE_SIZE) + PAGE_SIZE - 1,

Here it should be round_down(cur, PAGE_SIZE) other than @start.

Fixed in my github repo, as this is makeing tons of weird bugs even for=20
x86_64.

Thank god this patch is just an RFC...

Thanks,
Qu
> +				  end);
> +
>   		page =3D find_get_page(mapping, start >> PAGE_SHIFT);
>   		if (clear_page_dirty_for_io(page))
>   			ret =3D __extent_writepage(page, &wbc_writepages, &epd);
>   		else {
>   			btrfs_writepage_endio_finish_ordered(BTRFS_I(inode),
> -					page, start, start + PAGE_SIZE - 1, 1);
> +					page, start, cur_end, 1);
>   			unlock_page(page);
>   		}
>   		put_page(page);
> -		start +=3D PAGE_SIZE;
> +		start =3D cur_end + 1;
>   	}
>  =20
>   	ASSERT(ret <=3D 0);
>=20

