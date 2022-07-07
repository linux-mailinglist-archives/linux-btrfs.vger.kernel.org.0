Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A80D56A62F
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 16:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbiGGOwn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 10:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbiGGOw1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 10:52:27 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BBF59243
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 07:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657205490; x=1688741490;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=eQ56PzmaLa2WKKKooWpk3bjATAHBl6atHLbHdrPnP/VLpWHKpCtmQQFD
   i1R0UzrAQ5t/WtNnH/9TUrV1SPLdRLn66OCya7Fxm6oEe1WINDS2Da8AF
   mtDGd9eLLj4hRNCchIgIKhxpToYTkw7vozKpbfkfeQ3tBseJYwuB5zIjr
   MDGuGy2+KVHVkOnTH3iIxi5jRFbEcm0Cm0SsIsBnZ0txh3zP5ixIydpPe
   vYP/SDmLEDSseEkkEWVJLz7ZUGFXwKaXDHmazj3u87T5OtXdTweNk4gZx
   EEXvwDhCDRUuOYVTv0fP1as1SYRG8QfOc8gTEsX49i9RPah1x7MaFg6O8
   w==;
X-IronPort-AV: E=Sophos;i="5.92,253,1650902400"; 
   d="scan'208";a="205807984"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2022 22:51:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xhx9xVh72S70kQUwX9395EkdoqoPmgSil8fbLZlmkXgMxIDqEVpQNRlLFvYS5YhDdhduUcgAPA1uf3a6ao+j7cOaMzdgzl4OSjZNDTEjK/Kh3aTlGCwDdqoEE0GGKdu2NqVZIDPwkDSlc+tpcjHvf3fWI6UL5rLzWu4Y1jkWsGcjTCmXlptaX05xI7ZK34vsaiZ8M3RCfFa1cUQI3vcdABQ9e/ahscjZ208kcCJckf7Usx6mtAHrtvpUmv8Y2X/7kmTDiAYhnauMNGJDKwu8uDJp5os4yqao+xNxhh0y1glIPHViKgRU7AzNrR7+/CZXja0cIpOpc+FLq81xhT7yIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=iy28Bl1k2SNJ6JzjbP+OmDGrMeqvIlHHy2aOcj9c3l3rpQ5Z7j5ykmWPzqGr8s0r0w40zglUG3lBgtJGaH4Cp+6w3MMCIcNN7Sm7wNsLDRx6b8kYLG/qTYVt0X5XWBZ6sWa2f78RHwa2PdnOkz4CAYjdtPBFz3M5Teo6P74PXlB2Un9O5Tm5kwkWuOjuS71j6MgVVs3RkC8UPgdwvJLF4mDWhzbjQXGP06jQiLtCgn2WwTKy7R5xgaUqZ2CAZoPNts4iL1p+yIuewwU/OegpWd34QADiBWiGLMZwJh5Ux3Ek4xjUChHHywcfmwb69ZFcqnbvNMENruKIqBWZ90sk5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=nuUI12zC7SJLNS2tVtBjGravJ/5eQNyTTFfFtIDznF27BKkYjng2EkaEnGY9Qvi48/ZI9Wl4PiBNhrFCOjudKtYQu8rIK9O1joT6RNtsLP4cAd+IhA3pipE/B8laPmOk0f6Qky3Q1jYEuU9ezLlfVhgr7o0EnRo2odJp9RENy6o=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by CH2PR04MB6839.namprd04.prod.outlook.com (2603:10b6:610:91::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 14:51:26 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::dfc:dff6:4f94:78e0]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::dfc:dff6:4f94:78e0%3]) with mapi id 15.20.5395.022; Thu, 7 Jul 2022
 14:51:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 10/13] btrfs: zoned: activate metadata BG on flush_space
Thread-Topic: [PATCH 10/13] btrfs: zoned: activate metadata BG on flush_space
Thread-Index: AQHYj2LLp7GoWtUHa0uixrONZ5/rmQ==
Date:   Thu, 7 Jul 2022 14:51:26 +0000
Message-ID: <SA0PR04MB74186E229C2BA6B1A70420699B839@SA0PR04MB7418.namprd04.prod.outlook.com>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
 <bedcc3526ff4acc1e83ce7fdd6aa4fd41d3d0461.1656909695.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab9c10d9-2808-4ee6-e352-08da60282b20
x-ms-traffictypediagnostic: CH2PR04MB6839:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r9Mysi/das3VqiMSZAW9JBaNO66aBkfffqjxIbABRX6mCvkD3bmlEbsvFEX2M0kghGRvD9AsqV3FyAQLEIcy+3RQAy7n7RJPsAqShVL1j+40gYV2Zm/5AIsLWf9eFyZVvIQY4c7WUjzSCR9dWvB5GQyZUWfUcrUbLx6gQ72+Hhiw0gBrTgzAgCkILXIGq2VwM039uvXxnnZXUbpvT4pQ8C0jVwkAHn7GFs0aZgJ7xDeVadXaVvWras6a35J3XQSkQW0F3bI4PwOXtNu9fZDZvT/5/sOwTsH7Yq4FdyTo0ipwYwbHlu97415HBQ3N7Ll+k0W2GMXRIz/e4FNySaDQ7GePc84oHFyNq6UkYCs0keaEsdDghRUYwx2HL/3w+7/+1RXvTrGb5GMLc7GkF/aUSuAv0F/0fYc2/Idwhf3+BlSNzm+H5fU/l9hEufyNtaUv7OyrCtPFZTjRydR3pV5I2N3iPLb4J8+hFNlkqlumvnSkThGnd0OTfG078bs+emxlZKr2i91kq0PHFUYQN1udSFHRDBJenpI1nGZhhlZkzpw9GEK6PvKdQeuHxTOakHDyHenPm1XOMenP6XncSIRo4FbPs27WX/Y5dpSCwJjQWxgCaf130oyXs5omFfbqGji/mti1VZl45qHZzB22DCb9B3rV01ulSJ4iee8ZSWEMNnEOEa0s14WczuHsAzApObtZ9AFTLagY7JjrxrYATYHYTLZpUtztJQ5HepzXyh2Eq1XHTijiGOlMijQyL1g5294cbPJozI8s0OHImu+fFDNXrPDHpXk7K2BkFSkIYgCjxQ4ATts3mqbDKWfTynAzAXp3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(4270600006)(9686003)(5660300002)(478600001)(8936002)(55016003)(52536014)(19618925003)(86362001)(33656002)(558084003)(186003)(41300700001)(2906002)(7696005)(6506007)(76116006)(91956017)(122000001)(66946007)(66446008)(66476007)(66556008)(64756008)(8676002)(316002)(110136005)(38100700002)(82960400001)(38070700005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aZAeT6CfNSxIXD21GvITlK/7YuvR/HkgAc7Wn0UsD2g1dIdxkAMO4v/fe5VQ?=
 =?us-ascii?Q?NzBxr8QsCg4l6cCYL1FXzzu+s+2cTNN9K0eLnrHnRXi++PYo3wyHERV2S4uA?=
 =?us-ascii?Q?gIiH5Llz1ntykzv43nvuLmu9fmmV1iC0JO/Tud74SDTSzKnJryVDArZV5hDd?=
 =?us-ascii?Q?no8demnzX42qk87lfN04totoja3A9qdRGy72JyyfKpiM29IT2XimAiFSe9Lf?=
 =?us-ascii?Q?1JIdehYWg+sT3UDMMKyLna0mreLVUjWo3jjaT4bGA/Z+ATreTViQeIOnjiwY?=
 =?us-ascii?Q?RDCQNHwMrrkZjwzaDFc7LfK4Zy0lIpGYWcoUUFg+BcedE2F+vnUzCwpgCf2E?=
 =?us-ascii?Q?g5CWvkMGQqqz1Goj75san6J2ADfZX6PU7SB+NoUxzmazI3KGqZxgCfVkje1c?=
 =?us-ascii?Q?fZj8p3e4DCeQKECtaBCCaAlmkbyOsVZlBK8pZSx3apmHdidGiARegPVuHdTH?=
 =?us-ascii?Q?tTbMRdyRjrKeGrr1iiZLWlgDP2IE+Jwjvsa0rZlyWB5PAj23pXjcE/YZ5BTE?=
 =?us-ascii?Q?6xV1JgZ6n047l4DFbNpIQQZ4Z/ilqMs3fdrrcfYigWntJJhmL4WaNLnGNvvV?=
 =?us-ascii?Q?TyzKPq+U9xSFG+is0/DpPdXI/wKVvv75Rmu7Ougz4Fl+mdjiAZAlCNrCncTs?=
 =?us-ascii?Q?kphA474Bozjvjl6wmX3B1UFMIlpj6PUoGyAiB6aZYTDjAEEepB8MOvacPzYX?=
 =?us-ascii?Q?OWkVJzBnZbR3hrAH4f4hbtnPxchYUk23yUOXKVHhYwdgvdIsf72PGXWMmZcc?=
 =?us-ascii?Q?5NHGdxeJyZf3Ak7/E/O+wSsjrm1rBVfVA5XHFGTnkdyZ7s4Usmja9il+BNFa?=
 =?us-ascii?Q?0gf2EmOFFFBeWShIoeu+Z23PEdgJU5xbgVMYxgpIrT6wJZsK4h9bQv19j+uy?=
 =?us-ascii?Q?12w0MPx26fld9g8H6vCYNmxK9EjejL7k68sMgwYyA/Bs3tBr2kHzy4R2o2Lp?=
 =?us-ascii?Q?/DQrT+tktpKVz7sfKHHBSMUlP1Pik61Iqm6kWYmN59qLlxxjwGZmnbMzJFsT?=
 =?us-ascii?Q?Rn6LLqXVSQKHJufe9UNi6U5CSg9dfiGEN4BslTZpFj1VpzHizhZG4IRy+6kF?=
 =?us-ascii?Q?Zpxr+HV/3zJ3sm2/98A8/J5RcFKDlcdohgyelnJC88+EOn8+iBAF62gvLLSz?=
 =?us-ascii?Q?2Iu3HD2CuPFOPnQfUsw7ZZqx1DHtHSY1/33u8LeYV8rL0LdoQxj9r9w2uUpn?=
 =?us-ascii?Q?MS48j7cXnno7T7A4ROTpPFDCXJaOPduzj5CXVVOGo8FD45PuYRNtL7aPFrP2?=
 =?us-ascii?Q?DWkC3CR3GrR73gePOWdwPjuhVjGDxcCIgOHCPR888ANMSlpEkmSKCD3k6/QY?=
 =?us-ascii?Q?jKM8Ty14zO2JeMNwP0GOfODrOcyOMV3ctkm0UCzxLhiKFDRm9Co/EgX6JpLz?=
 =?us-ascii?Q?21pcHZVLql/UFu9XdgyvzeKrqhZkqPVbRzaOMkvg8bWvEQQMs0RfWWBvtxdW?=
 =?us-ascii?Q?JvRbmGK51HDfO9Ceq9FIMWyYTncGutNeWFt27SA6rV9SFDVNgi3b41VDu6Fh?=
 =?us-ascii?Q?KWQNMuPowGEKLz853dGPirFTHsAbleYLMdyouftSFRB0wEHmMEG2bbzDRl4z?=
 =?us-ascii?Q?aGBqXBp/k1hUwORN8IEqWn9zGCB5WVjfR1IeMHpy8MvSAMkSzvYFHbeF+Ryb?=
 =?us-ascii?Q?+Km8rWTmsROTDKDPrOGkqICOOj9Co/Qagkk74HF3jX5mOXqW2jnpurYiniAY?=
 =?us-ascii?Q?WG2nug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9c10d9-2808-4ee6-e352-08da60282b20
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 14:51:26.4568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oCWGt6YJotkffkVpgvbqtIl450aNg0BP3q36hhbNLHull2GrmdN+ZMg6WxL9YiSwZCE1RFwXs4OkGfbYnXJcSiVURQd2TpFwtQmHj7mueC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6839
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
