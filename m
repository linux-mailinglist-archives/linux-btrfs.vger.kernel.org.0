Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA6F56C939
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 13:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiGILgw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Jul 2022 07:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGILgu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Jul 2022 07:36:50 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140C55926B;
        Sat,  9 Jul 2022 04:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657366609; x=1688902609;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zGwDDDAoSIBqvABg4vRCk2ZzgAzwYmoc/QYbQT/9dz4=;
  b=CSpDpTfh4mq5asAwkUWVm1l1Mqvm071AzLk5q1RmqxvlH5Z6J44NuuO4
   ufEr6wFf3V7g0MeRVCSO3u/61F30fFG8jmx+J7nesHL+Qys+WKXQIIEpF
   Kqi93VkjuD1L7wZQnbgQmQbCcqBG3lM1WkBbX6maExGl7G9RfqxqPXPg3
   wB7NFm1g9YcoT1qGi1a99oBlmg7WCmMSPOcvYB1JZnIUeCmArLBZTfCfx
   C6xbvw9tRratpeMoMn3JlDteMBslzjv3IPPIHIDf7Lgv7qhSkwQruVApy
   xBHh0+ZipxdRyx8VlOkpgArpRKh2GZfk0jz/SsuYUrqAmxG3thF572ueH
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,258,1650902400"; 
   d="scan'208";a="203895977"
Received: from mail-dm3nam02lp2048.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.48])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2022 19:36:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfeeJnnLVKevxC5JqW8/00/XeBiQ6s/JM6iJi/qV0msA89MtwfqbUvAT62gl1RyJLOIdw0UyqX2oTTzU/1a9aBjPoXPADRyJfMMMx/OPjRoUUFcaImrr0ChUXn3a/pMib4I0T4t3G/IB9TiBBfCRpv9N3T99LXhXdBeMwwbf8LhsgDxvpwc/BdBOKO70uzbxGa7ibGswTN8r/22K6WEEy7Xs+Cja/NS65NTwhk70ODD1HGE6XFHvwMBPFM7AXJOOXrMdL3gw4kc960xL1II3lgr890DiR2vjSwiIrnGtnypiheFdWXY2AgXf4gftKBYpldu3rrFsGvHaM4geunBqMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2aAHpZgFt+cF5ODXuLAI5wnVR6bPfa4xJVrJ4ti9b4=;
 b=UvXznMfdONjKW1B16vORhPwGTMqdMhaXFb6zUpSDf99OaJZqnfR9JtLA+M67EZDNEqXN9MA1j7x5cY4bC+8l+Y9sAA/wv8Y8B2zsZ5tmoE7uFAyCiflN4RoTN6tc8LptpNgYv5nlff3dqJ8GYxuNzIqi6jAgT3Uy3YvLES7K6hS+c5Ga0A/eaq4rg6A1G5fCajFyqg5CQuZmxfYdh7VZ3VrKEPZtBmg5KlUg0PLgjx9oWqvnM2bCilC6KpcWZXXZkfELCUaQ2WGLUE6R8L3KeiObEkqq/P9sAR5pIksQptZNaDyJ2U9oZAGukcyXYQd4Q9cqJGiXlAF1sEaZNGWD4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2aAHpZgFt+cF5ODXuLAI5wnVR6bPfa4xJVrJ4ti9b4=;
 b=rfL8yAWqlPEkms1vVFFslt3ex6kBCw6PdDiZy1w2UD6wuFuFY+Exb+Wa5Mo6QK7Khls7p3ycYsuq7Nw7DW8biBs3L21vxxAKxmgJWs0Jk25Ncwe863Wb0PQQSQtdLyS7chha3qXSZc/ptE1jhhSVqZhuwpMsXHFBfTjbYPnwoQw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6737.namprd04.prod.outlook.com (2603:10b6:a03:222::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Sat, 9 Jul
 2022 11:36:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%9]) with mapi id 15.20.5417.023; Sat, 9 Jul 2022
 11:36:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 03/13] btrfs: replace BTRFS_MAX_EXTENT_SIZE with
 fs_info->max_extent_size
Thread-Topic: [PATCH 03/13] btrfs: replace BTRFS_MAX_EXTENT_SIZE with
 fs_info->max_extent_size
Thread-Index: AQHYkyF/ZcqHeayXpEaFUIdmxem2ag==
Date:   Sat, 9 Jul 2022 11:36:45 +0000
Message-ID: <PH0PR04MB7416D26D6BC98BC13EBD09309B859@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1657321126.git.naohiro.aota@wdc.com>
 <f5c4db672fc1862b1cec6fc3ee75c5aab85f75f1.1657321126.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 492d8d34-b672-401c-ccad-08da619f4d81
x-ms-traffictypediagnostic: BY5PR04MB6737:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DXVX6EpQjTNlI5s49w6Bx36HMAYj6yz8ptYI4vZ4QiDyCPVMzt++2XjUaEvWbG5+cwb2vMRA6Kz2tqE0/kFbQwsA0U7Sm31EmmibU86I7iSLHxnw21N/+1ND8ewYlL0IHmrTxv/D5pilSqMy0ap61R3VgU/XC8eWms6EjLh8zWVLfHAqGRmnPNxSwtd2qjFksckFqUlq7Zm++8d41x0i0sGgYtuIpPPxgdTqGoEyPpid5oWiihWU/S1S3cvfOnHP1TgXd6IkdSmwiXWW/UlUKyq+3Za6FwaEmK9CgLsm+0p8Aa2sbITvXPGKK9hbzStBM5C44TvLmeTTVhh0QUSvYAiBNYYvGzucVvDWi5itqqDxwGqwfRbV8e2v/7yPQm+sn/US6B3I6ww2N+kuxLMplOgjf09qOiN0146mM7RUjuX8S+BrqapWlnth+qYvkODZ/JcVWh5t9aK/NsRfKrxGCg+MTdu6UfMMyewMfnR/s5ekVFcZJxpmDVaY2PoW8RQGN2QTzFOf3MKoDlyjmiaafFfGBO/WbH6bPj8pL7y/IRMQ3PtlU+maOgNJM4T4eHMIsunD1SeGpOCVObJq/YMoKqB+D69N23PoSCEYHNsuxLD1j8B/a8y/sSASCvtM0c6QMV3wH80wPQvW3wqGck6ds/jsrK2ic5+EavU3eU/UltCGOvBjO3WJmRglPvSO6EfAhgJFEf1OeatLkJDAH/RaWbFT5BcDF+zu2QMqsVnssS5c6SooHHLBUAmav/5SLjqpG7d/i9uNEIuChWG4vV3xDSahDYCnYId9V1grzjNNTsDLOdus2SOEBRrucdNcVU3L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(52536014)(8936002)(2906002)(55016003)(91956017)(4326008)(76116006)(33656002)(5660300002)(4744005)(66556008)(71200400001)(86362001)(64756008)(66946007)(66476007)(8676002)(450100002)(66446008)(316002)(110136005)(82960400001)(41300700001)(7696005)(122000001)(53546011)(478600001)(6506007)(83380400001)(186003)(9686003)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1df3K/zDrVUxIJRcyNDe/gc6HyERJ+ntmUu4koPxz30LjHo32k9Qu6mAT26/?=
 =?us-ascii?Q?/y6llTuK9O6jTbc4v+J8uS0hJHuldXmW40O5sqUboBS9rRCl05bPCgtMIbPm?=
 =?us-ascii?Q?o3Td8IWcpUEmKOxbkkO7RpuIwKXz/JeXO4BZYSfCFAUtJEdnId0S+wwdIT29?=
 =?us-ascii?Q?D2eZ4eRJiHQsZf3rkkjYcoa6/ILJljCpQWotir4ipulOEwHRvn0xKuRaUu4k?=
 =?us-ascii?Q?1v/1vNkuuPWBxqVEHrs/Ka7j4b6GlBetq4QcCe/xYdTb+nZCqfJnGaQ8ORNo?=
 =?us-ascii?Q?dxyBVRGgnCsEkdDyKPLz7rYvaVOhoWqL/VJ4ckd7ytaXDCmCPjVAyoACJiHz?=
 =?us-ascii?Q?43i1Y5O12WT3DlJMMLe8s3OrnnlGwiOU+qY18OtnPdh9/8MTFZqUrsmtZv/B?=
 =?us-ascii?Q?l+c1SMsTh8vjQvIcw0BKfwNGsl8QYLZNvyYtMqwR1eiyF7bKwcu47byew4b3?=
 =?us-ascii?Q?x0jOh/AYzNeS6inJlVP/fJ6U0u1nCi62eFR2CuiOcHnur81BHgxinTdgVztJ?=
 =?us-ascii?Q?j2NuGZR6oRkYemG5/v269pncj4baGNPffQPfYj3pF2rdF2CvDzZTCnUkhV6u?=
 =?us-ascii?Q?adh4VcGFBHbxus3CYy0I+geMnSFQYBwhoPtWqVyOtSERWrPbu5iVO49y8IAh?=
 =?us-ascii?Q?m9boepAOCuoORXjXXbckiWawTleAJxoV4AZtmyTL2nTbb1fzr9jYLYnUXyDa?=
 =?us-ascii?Q?7aZQEPzgxRmLR97EziN9Ez3PF8aCTUadZXKr1GvDeIs7XqCDS80BIFfChtL/?=
 =?us-ascii?Q?6Q179SEYjzdH/Iu5teOln9EzSoHsxo9rzyYk/ZoPv4/tSEmmRTGENoA5Kv83?=
 =?us-ascii?Q?j2/7iXvzwp8wCbkc0cDtCJ5Vdp/ga3wc4KZ37GU814dnaf3d7rprDNRfaqul?=
 =?us-ascii?Q?e3zFeWfw+Z0pfhJV0WLa9G4l11WZYWLmlsb1XqneVLSOpnKPIbvcbUDCKSD7?=
 =?us-ascii?Q?5s3BZbpNmANGus6PPCtm1bhGdmUKvZQREJx1etiNWOvryvaEfJlw8RiHG1G2?=
 =?us-ascii?Q?G/8eSQxO7cdow0ACDPEX/npLJC0dJolUf+2LB7UX6ZGRQAmZr/Ul/KYxMk0t?=
 =?us-ascii?Q?pL0DV+kpdq3hcCJ1xcukq+H1ADfUTosOS3Y4SQ+gnhAk3k4uy4yHMlGFe87J?=
 =?us-ascii?Q?lS02Z78fb5vNQATHNII2ncgz9ldGWH+4/MV288Jwl4rQm2rOJVLBl0WTQm7T?=
 =?us-ascii?Q?dRdyh7s0iyf/XxmV+6VrJqIab8TX8/WxddBmYEG491BR3B4SHug0AMpIA71A?=
 =?us-ascii?Q?/XSUyZtg7tqoedS05qob6tJZwJfqcXV59T6CyBEC2JOtG2K7AJtVWK0szJQL?=
 =?us-ascii?Q?0p4SwzL3NEQh5DDrFtbInvcrTOpAAGv2LrqJryp+SGux3UAXUmQ30DrA8wX1?=
 =?us-ascii?Q?TKO3sSGz3H8R/kkBlSAivrSAXGVp/pOV3si3gPZ1RzuCNmn0/NpB3LbuSl5X?=
 =?us-ascii?Q?IU1WS7OjhfSKzc+Wa5V+ZrYltApP0AhiMk8A6kkfKqkQ0sJFgFFg9nrjoRIQ?=
 =?us-ascii?Q?vwsiqQ8aLHTNNx6asU5SPmYS5R21EbsW7RfgfUjF+A1NLjdDoe26RaaBZcAj?=
 =?us-ascii?Q?obNqgAPCvFCqSRi2atRv0y22TenoP/n2ERQloxe4v6uhVXZIwRJb6oeAuw+A?=
 =?us-ascii?Q?tQ4wI5zBcphA1GHxUL+UKhY/gJW78VD2TsxNqSx3+gdlJRVlz3z+1BIlHjbl?=
 =?us-ascii?Q?tQjVv4SFLuUiXf1Ylm8BLbIjxWU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 492d8d34-b672-401c-ccad-08da619f4d81
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2022 11:36:45.3767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: agDeSc64Uh68SFpeyRP5bTxgHBFHSzRII7agTqxOsoy1bzAJF/i2iPc8+URFkU/w13r8DBVKzYhLGwy87bytobHFYryko0VVcmhUiiizrBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6737
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09.07.22 01:21, Naohiro Aota wrote:=0A=
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c=0A=
> index 3194eca41635..cedc94a7d5b2 100644=0A=
> --- a/fs/btrfs/extent_io.c=0A=
> +++ b/fs/btrfs/extent_io.c=0A=
> @@ -2021,10 +2021,16 @@ noinline_for_stack bool find_lock_delalloc_range(=
struct inode *inode,=0A=
>  				    struct page *locked_page, u64 *start,=0A=
>  				    u64 *end)=0A=
>  {=0A=
> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);=0A=
>  	struct extent_io_tree *tree =3D &BTRFS_I(inode)->io_tree;=0A=
>  	const u64 orig_start =3D *start;=0A=
>  	const u64 orig_end =3D *end;=0A=
> -	u64 max_bytes =3D BTRFS_MAX_EXTENT_SIZE;=0A=
> +#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS=0A=
> +	/* The sanity tests may not set a valid fs_info. */=0A=
> +	u64 max_bytes =3D fs_info ? fs_info->max_extent_size : BTRFS_MAX_EXTENT=
_SIZE;=0A=
> +#else=0A=
> +	u64 max_bytes =3D fs_info->max_extent_size;=0A=
> +#endif=0A=
=0A=
Do we really need the ifdef here? I don't think there will be a lot=0A=
of performance penalty from the 1 compare that we safe with the ifdef.=0A=
=0A=
Otherwise=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
