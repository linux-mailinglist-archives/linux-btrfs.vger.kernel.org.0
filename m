Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2113DE62F
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Aug 2021 07:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbhHCFb1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Aug 2021 01:31:27 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:39413 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhHCFb0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Aug 2021 01:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1627968674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ZEoJdAd04t/7G42ADx4Oxqi2Ysl8zXuCWM8G41GoBQ=;
        b=gTi9lXybOte1PUYxutqSZnxLAuuQ3Gg5FC6sgC1fSW4ZvXfINje8iTcoB3pzpAUU2dS84u
        TV0LGTCtipAL7NU5YI5VMN5QYd93aLqYI92ffEkHDAn5Swh+uKWbh/jjMmU1N9okXNGuxl
        e4+Mx2AG0/BrZJ8Qyr1LIF9/Klg6QEU=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2051.outbound.protection.outlook.com [104.47.4.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-24-y2-nxGo-OKKtDBAUYpUueA-1; Tue, 03 Aug 2021 07:31:14 +0200
X-MC-Unique: y2-nxGo-OKKtDBAUYpUueA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIhGLapTACr7iGTR3F1rAoHVUg1TmWEFY3qN10ho/886WUBlNIClVYcC4riXmfIYGUAznw0FJVkXR9ONzPn4n0fkVRbF/8ytu5lfLr/gC0wY+wA595pS0D6CrVscQE6UmO9YixzqQ3XYDFHf6Lmfgp2rz5luH7ZhcngwIJPqFv9nSg6yqfL6kH7P26DzHyJ4LVR6noLX39iGcqxbMWrgtzxy/6J4M4yBOyrz/mQONk2Vh5yLOzNC4Tcfw5E7zSHpqgT0WUIm/PXV8fn4DUUu5YSZXI+waeH9H0dM7Nt3c2xp/iXsmigbZ8zZg5kuJm7Obafn4aQAkBk8dXrdoRaO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVHFS7FebpFQ8AX3y5fI2KczH731BJIcpWUeuOC5yg4=;
 b=m90jowmSIZCqLDK5HccdLPGr0KI2Av6jo9YIM60GBqe1GJJd/yAQP/7SiOJlXzTUAo2DKvqBi8QitH+dcA5J6iOKCBsGVPvxpiZ1GyS4K/h1TEZ3qIrd1kM7ceSd0tGxKvvMpRINMspRnRBygdG3Zv8BAn+GgEy5TZRwGJSR0ghIThFnBQgztb2JoEbfIephXUxMNfNvpNN4PPTYtJ4CRGm4BHK3CMvL0R6VkhQHNyqpBnvvpkLP4USH2z83W6fBTyLqAbQhQDfaEYM1D1G4/AoSafa/zd6hGlilmDoTHESLIPYvkm5DMi80OD2tx5za1JLa6CaLLQ9fBIBen7fMNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM5PR0401MB2676.eurprd04.prod.outlook.com (2603:10a6:203:2f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 05:31:12 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65%3]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 05:31:12 +0000
Subject: Re: [PATCH 0/2] btrfs: fix the generic/475 crash for subpage case
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210802065447.178726-1-wqu@suse.com>
Message-ID: <934ff096-d51d-83e1-14d1-f254f095bba0@suse.com>
Date:   Tue, 3 Aug 2021 13:31:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210802065447.178726-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:a03:333::33) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0118.namprd03.prod.outlook.com (2603:10b6:a03:333::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend Transport; Tue, 3 Aug 2021 05:31:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80b1e109-5d71-40e5-4950-08d9563fe7c9
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2676:
X-Microsoft-Antispam-PRVS: <AM5PR0401MB267653BE942D089DC997E74ED6F09@AM5PR0401MB2676.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AndzU5V6ffdlCbBOkvL95bB/yLzfNgho+dQlEP5J16QqdgpxlCt9bYnp3NRoZ/IAzT5416Ax7Uo1ef8wEk78LMl5Nn+PAMJC7ng37mMeExghIc84NXD3McRho7mA2yEMXn1IJ7usrhtDecjFFR2cnRw8/hLIFuYGYp/xSP7wj5Ctx4tC8HUPXdiknkDxORZQ5Mx+sD7m9a46/c+L5/oLmlYm43X6fqRX5zMoQgxTP3zCP3kAL3m5ufrmACwsBMVls/ae4EU8NpE9FSOvck+kM56ZF3VrYbXScR8e5Y5Kg8g9PBAi5BE/GfLvhiyH3MTl8p829lF+kvNBVyDXtly5wtFJpuPJ+nFlKsAQc1FMR6SpXdlF3rI4DWUkquHOFRWi8iStz3S0ROXyaNnzTXKxFLD2bYwBKBxWe+wrXePbwd5hbxYO+tg3j4ZFbe99vU9/gUpRJkPrhHGJSBWwCrHPstvIs3DoPNcCgcxjXosxCv4el8v86ih3b8mrSJEqiXLj8s1VFY5i+5E0tSTYoSkvZq4jOchUZMe8Vn2d+slJfTMqG5mhG79MWH9MAjyAPFbxjQp3q8Tb888RkJhu8J+U2sz9NoFDA5hf9d7PmKXAGOAsELX78hDPW5thu12/JLlg3JOfnHQz/6ekqdABMCXhHxV+l+ZVGSYkbMq4a1+H+5CiKe2ygN7lzg9Ijs5KTcICYYC9cgSqKeLS/epodKjUzsss9P/pM6nXyBSkW4s4+XIP8LDh3uPYAkqkMCtqxqpF5f+KV3IwAQ3WTHTuNrR51w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(346002)(39850400004)(136003)(2616005)(2906002)(8936002)(31696002)(5660300002)(478600001)(956004)(8676002)(26005)(316002)(83380400001)(16576012)(6916009)(6706004)(6666004)(86362001)(66556008)(186003)(38100700002)(31686004)(6486002)(36756003)(66476007)(66946007)(41533002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bGteKApU9xAT5Klx4ZIKU0z0gr1jKrr8bmt9CWPUkM10277v6F20biFUNxp1?=
 =?us-ascii?Q?nrFS5AYaHR3EpjefEF/owNbRZoq5aHFhYEbruOhqGhL8n5Bw+lE6OuTCZpFu?=
 =?us-ascii?Q?FKk4LykaEswqFtxpfQOLxHMM4GCVFlc6TamA+YrO8u+kJW6fBcox6ffZZrsB?=
 =?us-ascii?Q?D3x5XLQGpLsKRTs4TKv2fqZEO+p5JzpfGj11i32C5sKVsJ1wP0Soz01Rj6Bx?=
 =?us-ascii?Q?4b2vczDRSMGbfmiH6K6YN8+d/usULM8/5DXZ9BcYi3CUWq/rZp5Z1cmSXd0x?=
 =?us-ascii?Q?wZAgvdgemmbTkwSL4FPwEWnUw38fLhM4obvsTEif+M/YiAQW4Zqmfy4n+B+l?=
 =?us-ascii?Q?ELc9160bs9hRvM6GUryYVky7mLozNZQdbD0/gCqxSgnYyN5aREiqg7yyKa/P?=
 =?us-ascii?Q?beQM/uXmhNDU+rxfhIrFCfX+OgY9cvCI9qE9LHPFrnjj665HKPWbCDUSoZCQ?=
 =?us-ascii?Q?VRXLZoZkEfivDP6Pdnqdkj0claIOnMd9tvdwr8usNpObdZbFoIN6An0VlqPQ?=
 =?us-ascii?Q?4BXd9QNo5dixpLZ1JDmQIRsGveDncEMlMa7buokCSOftQuEnpTjzndeKsrCm?=
 =?us-ascii?Q?J6v/N9QbtwN2oMCjf9nFmLoWwj80pRBBGDhSsIGRoXiiTPib+bASP12kKSij?=
 =?us-ascii?Q?uUWdc0vj5TEnstHXSZggW89l46+nFhvyUZPWHw6WSiz8crxZZ3LkhNsF/iPc?=
 =?us-ascii?Q?eRBaORxxToI9IveZPjKOpJp6ceoHefXZa8Gg4+It0IJDfnm3FmqmxHKTiouU?=
 =?us-ascii?Q?eqbGWdbCm6iCZq37SWWNEj4n+D1vJdc36WO/yeaGYrdrIx2XtzOj0tZbK72p?=
 =?us-ascii?Q?3SLNXy3dVQWCK3guA2UPEmRGSVVql4YO0xBMLu5rdSyARBsYEGvaIyADA/0S?=
 =?us-ascii?Q?u+W6iVcusrq9R78Jb721mYbmYN1EZVmhLbKQ7AL/CzaUvztUr0yLxOWvDg74?=
 =?us-ascii?Q?6pyEnTF0vGG89UuTjs8V/uDGUF05hTGMrdp8bXqaCMrVXt5/FVjF0Q6Q/BdM?=
 =?us-ascii?Q?GnDggtRe2fNvYYwoLLf2kObhhcuj8eCAmabW2//04QALAVBNIHXZnITnPEee?=
 =?us-ascii?Q?Kz2dAygfTILHuN5ELPD0d2oos8HjNWyTOx2sXPFp8jFu6gvf4pyxlkNS4nvA?=
 =?us-ascii?Q?fKgMvDGKEBZvoXecfYvhLkwp/s+aS38JPxxFgNysSnH9hIEoRJm6sUAKwfsg?=
 =?us-ascii?Q?vhh6zzP/VlMNMlq6sKU/mAJF1hgpEslUFauDmE3FupZwju9QO9txKdCAykXQ?=
 =?us-ascii?Q?E9P8aOJLFchN87vX96t36dR+u3YcW3B66Tb5qeLDJYErCO4MuNBbzsOeljpD?=
 =?us-ascii?Q?nu1scA4MnIRLeI64gWURFlL9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b1e109-5d71-40e5-4950-08d9563fe7c9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 05:31:12.3044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4JU0cicnTVMZOVTF6l9wABGQIIsbwQ9DCV3kJTg8jhI3KjSoA7T9S8lA+laedw5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2676
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/2 =E4=B8=8B=E5=8D=882:54, Qu Wenruo wrote:
> Test case generic/475 expose random crash (1/20~1/5) trigged by the
> BUG_ON() inside btrfs_csum_one_bio().
>=20
> The direct cause is we're trying to submit a write bio, even after we hit
> some error and already have ordered extent cleaned up.
>=20
> The first patch will try to fix all those call sites, then the 2nd patch
> will add an extra safe net to prevent such case to be escalated into a
> crash.

Please discard this patchset.

The first patch is not the direct cause of the generic/475 crash, and=20
it's the 2nd patch masking the problem.

The real problem is the end_extent_writepage() call in=20
__extent_writepage() when the page is marked Error.

Thanks,
Qu

>=20
> Qu Wenruo (2):
>    btrfs: don't try to flush data write bio if we hit error preparing it
>    btrfs: replace BUG_ON() in btrfs_csum_one_bio() with proper error
>      handling
>=20
>   fs/btrfs/extent_io.c | 17 ++++++++++++-----
>   fs/btrfs/file-item.c | 14 +++++++++++++-
>   2 files changed, 25 insertions(+), 6 deletions(-)
>=20

