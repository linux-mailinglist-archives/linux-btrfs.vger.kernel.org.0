Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6444D2E2B89
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Dec 2020 14:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbgLYNKV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Dec 2020 08:10:21 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:32575 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725912AbgLYNKU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Dec 2020 08:10:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1608901754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wR7K4wah2b31DJnjHJx2U2Dkp2WRWQW+sL0H7I/BNdE=;
        b=aT0Mm5jw7zFbOb/zsG+emwJ9BI0JWdd1CeJ5JynixjK2QPST88Xqu1XIIXqxMpnZGOkkiQ
        fPNETRLryezMvBLT9wKWn/qtOJTymvfjm+YNz2MXotR5h7Q7gxdCrJtTC5Oli7Egi/yWGb
        Epmp6+q9qMBtHIwVigalBYguJGeNb/4=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2053.outbound.protection.outlook.com [104.47.4.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-8-P0EfsGRGO7Skj3_LDzUtvg-1;
 Fri, 25 Dec 2020 14:09:12 +0100
X-MC-Unique: P0EfsGRGO7Skj3_LDzUtvg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpI4qEVI7wkaLBy/gH+Xfl4/PZ92XizY2jvI5va6sOfYS1ORZ7x2VvCPJLkMxZjy2AyrdkvFfzMnZ1k6xVSisemdW3pHCv9oIYt4aLX5wr/e+RUpsC2+gLC6LTbvnULD0yfEP+bZ9GQlSO4H5Eq1JHkC47mDB89XYYzXCWbZ4RZU59aXJudpRt9M9JJP/MWIuwGHyiP3K83feIS/IdYxQtAAXKrDVGeCH9qB8uvJnCOsfxsFsNzDNXONbU5y51qsyps7CzkBRFNSGhDg/2oNGEOBrZesx4NXcqaik1ik6JN73Ln0o2B7Amg1/MUvzBRmjO2MmyHnkIv+axpoBef+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6GAmxcxpN3orV9+YGljiiYZaww2U6FYXM5DhfRAj14=;
 b=GSZgMIuybCxvhAS5SW8umFgTiKZ5x4/ya8Ip21ADLwQylM7SPXwzi2DPwjv5qckOg6pK321sswU6Edx1SHBQwdBOOHhYqPEazFlloN9kHUA8n7VKAAG1MUrjhg/BvuCesDR0mn2hGtmw3Y+k2CV66VUQXtNs56jfnj0an1MHMMTZf+fxLbVjgdoVF5LjiLF589Q9holRAxxmXi1toNNPSobXWYczHa5iSPfFKMpcKE1O136BtzdR+TW9dzw3lLce+i5ck3lXr9wREEFcMq6Eqi00dsx8KDmNChENZcy8vTlExLH2ngXMdtW4Oy2bpbt36BY93Kg6DZaaZPPtsLZ5yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.denx.de; dkim=none (message not signed)
 header.d=none;lists.denx.de; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PR3PR04MB7209.eurprd04.prod.outlook.com (2603:10a6:102:82::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.28; Fri, 25 Dec
 2020 13:09:11 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::397a:950:d8c8:d709]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::397a:950:d8c8:d709%6]) with mapi id 15.20.3676.034; Fri, 25 Dec 2020
 13:09:11 +0000
Subject: Re: [PATCH 1/1] fs: btrfs: simplify close_ctree_fs_info()
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Marek Behun <marek.behun@nic.cz>
CC:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
References: <20201225124525.17707-1-xypron.glpk@gmx.de>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <14307445-59dd-d2b8-1549-cac821c76555@suse.com>
Date:   Fri, 25 Dec 2020 21:08:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20201225124525.17707-1-xypron.glpk@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR11CA0082.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::23) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR11CA0082.namprd11.prod.outlook.com (2603:10b6:a03:f4::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend Transport; Fri, 25 Dec 2020 13:09:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49661e73-9e81-4a9e-8a79-08d8a8d6459e
X-MS-TrafficTypeDiagnostic: PR3PR04MB7209:
X-Microsoft-Antispam-PRVS: <PR3PR04MB7209A5D8DC10477E7EE66879D6DC0@PR3PR04MB7209.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aEsVd5ci5MuKCaiLykzF/4EyK0sY30ta/gkoeHvH2kCD9y9LoUCeYkcN5BaqNWBWd5MfBb9KMpJLI1KNo4ctjOG7SlNs2HzaUq318jQze4ORps8h340Lr26+ZgDMScpgJ/MCYAOWKeEX6zljfJVihhrdtZu2P5VPL7+90ddaqL3gd0LyyU0qWKMf8dbFef823h1c0V9RNQxEUCuusPAy+0sJuGUMvF/ulkXdYB8+VRj6pq+D18RLpXiUC7ek1rTw/x1GdCuYB3d/a/UaA0SVyly2+Cqbo+AoE9vioq7Q50ye4wp+Qiw+0/DebGYpv7BLfphcmys0GboIMMVnJ4bMXVtB4wlXqk9Ak1UQ+qx4Mr8UGAdK4i5aoPyPNaJPfR/BmVztHuM/Q2M//XZWNyuWGLNXiL2+zWPIaEnyrj7nsL5nH6o/MF2OTkHn29KGSWSmRX1W9x2EYsSibGeMqlRcd77o3s0xPZaVYUVsHzed1fJW8HfDRwK8gMChLZ0OcK0K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(396003)(136003)(346002)(366004)(376002)(52116002)(478600001)(2906002)(86362001)(26005)(36756003)(5660300002)(110136005)(8936002)(6706004)(16576012)(956004)(16526019)(31686004)(2616005)(186003)(8676002)(4326008)(31696002)(66476007)(66556008)(83380400001)(6486002)(6666004)(66946007)(316002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?d/5uJINYUoCcs12606CfSAREESh4RHpxtClyJxNTl6UJdPbqcYInkCYfm1Oh?=
 =?us-ascii?Q?Rd7q0t3E1fb18p7SScWAcSwVnOTWnoAAu8gxjqlTCAReFqVBuHDsEpqL2Yz1?=
 =?us-ascii?Q?nPvZUXjKlgCK+y0clR/Pd2kK8NKQtu4oICZsaU1cwl/NHlmKS4V6cenSa6at?=
 =?us-ascii?Q?8G9jHCenNahXQ7pxudPsGnjCILNmScPRrOicNuRONlxYHP/CctzB7y7fvWBW?=
 =?us-ascii?Q?Cqq8QOgyEJKUsUjugqDSq6lU5W9FsIKZrjIC8BUOQfKVekjgNFbqiegvlIqi?=
 =?us-ascii?Q?IPYefhuKe1n2R1bwbHR6IMSehvoYBcPSqOcbqe3uuhP+f3BHqm16vZ+o4/wi?=
 =?us-ascii?Q?I9I/p9n0W/2grhRWajfWj6VdE4hfvD+cMzlCdD48hS2b5UmGUTpzxaqB1N/1?=
 =?us-ascii?Q?1BQfuS8NXGxcEHSsELTPaMLNpHgUTjSjORXOs3P3V0EA7BS2JYxGcdtZbyZx?=
 =?us-ascii?Q?9vs3oWg9gh0bJKjSRwXdoJEshF7T5oc3enVNCGgVLpVCmuYpbzSB8ZsNrx4T?=
 =?us-ascii?Q?+W37YaHI91wD0aLlZFr89Dmpjnbe+KLbELqswXfLQvnv4XrUd0kGrenXJE94?=
 =?us-ascii?Q?n2umDIkukv285UJVOnQ0Yb77OD53z9VN9BCekwuXEEAabCT0EsrN4LNju6NW?=
 =?us-ascii?Q?gbwWDIbhr/QkDjhZucM7xzLvcw96EKxjsDHmTmRqJT52yRXw7aXQS0m6GuwF?=
 =?us-ascii?Q?Ix4+F66BAVhCrVq9TMiSl2i5sbR3eQgETWGAHS4bSMHYgQs/PeInCqvg+9BI?=
 =?us-ascii?Q?e2z8et+ZGXFtACY1+EER9C1lFs+DIjVKDsVU9wup7s2XVhQjYOc+BZY5hH2f?=
 =?us-ascii?Q?HKSqI0knfAT8ywNGUATCrqhnXNR5AZCGkuh0z8pDyTVElaOmkVPeJy/1HJTO?=
 =?us-ascii?Q?qBZ1trhOzV3stg3nUv6xr2Uq26o/4isSBGgflPU4NodPJgRuCalGSEoj3ZH0?=
 =?us-ascii?Q?n/x/y1kh1g6wFJAZ0AlfUwatA2Yw70XfPAwDvqTMB8BjQFmAtnBGbU+ya6tB?=
 =?us-ascii?Q?D1Dn?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2020 13:09:11.5718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-Network-Message-Id: 49661e73-9e81-4a9e-8a79-08d8a8d6459e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+XjKgd+PA0936jOPSxDIW8sQYcehFPkJ8/1Dq4J6bVN86JTwalNtE3XsltIZanA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7209
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/25 =E4=B8=8B=E5=8D=888:45, Heinrich Schuchardt wrote:
> At the beginning of close_ctree_fs_info() the value 0 is assigned to err
> and never changed before testing it.
>=20
> Let's get rid of the superfluous variable.
>=20
> Fixes: f06bfcf54d0e ("fs: btrfs: Crossport open_ctree_fs_info() from btrf=
s-progs")

This is because current btrfs implementation of U-boot only support RO=20
mount.

In btrfs-progs, since we support RW support, we will try to commit=20
transaction and we can hit error during transaction commit.
Thus we use @ret to record current error and @error to record the final=20
return value.

I don't believe U-boot would support btrfs read-write any time soon,=20
thus the cleanup should be OK.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>   fs/btrfs/disk-io.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 01e7cee520..b332ecb796 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1030,7 +1030,6 @@ out:
>   int close_ctree_fs_info(struct btrfs_fs_info *fs_info)
>   {
>   	int ret;
> -	int err =3D 0;
>=20
>   	free_fs_roots_tree(&fs_info->fs_root_tree);
>=20
> @@ -1038,9 +1037,7 @@ int close_ctree_fs_info(struct btrfs_fs_info *fs_in=
fo)
>   	ret =3D btrfs_close_devices(fs_info->fs_devices);
>   	btrfs_cleanup_all_caches(fs_info);
>   	btrfs_free_fs_info(fs_info);
> -	if (!err)
> -		err =3D ret;
> -	return err;
> +	return ret;
>   }
>=20
>   int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid=
)
> --
> 2.29.2
>=20

