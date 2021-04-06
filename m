Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E9B354E9E
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 10:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244338AbhDFI2V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 04:28:21 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:16054 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbhDFI2U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Apr 2021 04:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617697693; x=1649233693;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=OW+c65qQpIeMBk6fYgr2XwcE86pDRYgWJ/7Y1sC0Z9g=;
  b=fEXygu/DCRrOrd+vZxgODkUFJNh7upINisYmfX595MXqvz+H9N+tXhiw
   DqcOBBTcX3+idmoouhe3p40rEBQLO0n/mARIXbAslWzmDDrFbRIXnNYGh
   o8YFyt2dPaoTCbgLCUF7thqQEu74Rc8ooQdjoixVgygaC+n6QSpbCPJD3
   mFRXxHASnXejrNUMTbFKUOmfWpbh38znFEbkuktZ/efr5PKvq/uTyG5LT
   K6DcISt0v++cEpsKMVJjbOTUw2YXMKqKZIGqePjsQLKeQMqgQaL/nIv/K
   SfKs7P1gbaKABURBTyQ/AIU52uwfDY6nci19Fe+5UpHlqgOIxPOw7ZKQH
   Q==;
IronPort-SDR: rZGFGER0KQRxjQkwonEmpdp8jzQ8fWDOhTI8n61fZY0sy5+9AYWSuNkZZ9t9ygoGNgOwASI7G8
 kr/VUQ4hFuH07rMt+RQYsjWLWv7fkP1wnvgFHuPfbR8iHWyB6EFVJMDP65wvE4nK53dYP4H6P2
 wYZpyqt7l82FPbB8M8LyF5TYJyx33bJZwG6AabGw/FZgDdRVY27lpH1ZHdLqx+WctvpGFVK/8U
 tbhgWid1XkLoGMZHAfVX6wCtEcLLrl0qlU24U7ZRuNqU8pAMK3eyDminXp5nQkvnxCEFjnpc+t
 E4w=
X-IronPort-AV: E=Sophos;i="5.81,308,1610380800"; 
   d="scan'208";a="168417364"
Received: from mail-dm3nam07lp2043.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.43])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2021 16:28:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ED8VtAtiuaRRJ8mPAgXK3P6SBFbAIPEzD8DA5/K2B/TBt3oOi79M25SiPasLqNycDyKWVxk1ku0Xqmu8fnbPY9bBZAVr6sOqCZBtWoo8IpdNuwn2093v4InqqQZbqsZ210Iem6guZYlETsVQSwQIUs0gtX9tGXr39zpaO4JhdKze409gUzZfYotljj96Ag9UFN2pSNqmZrg8LrL8AAFw4B53wXyxsXQZsUCqSZJMZj13QPOJy5QqDu6gTIM9jaBC3MpF4dQZoKJhvVqkivPfn2Zdrgv2wBIA6yONn6dz/3c9dHsXbMoR2rdXp12aTtmgqGtuKrokoGiigMt6v4e7RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OW+c65qQpIeMBk6fYgr2XwcE86pDRYgWJ/7Y1sC0Z9g=;
 b=QHi8nL0RMXUQpvuWblO/H6ivAl9eRhrEfzJlte4e+eUg5XrZpWXSoDdLZGg9ISXqwVo+6qTQSXP9OjimYHQwvzop4RKY8PE6x6DudyXMoiBxmwA24Z8uuCF9s9lu/rFWED+GE74In75hf8z1TaZiBAQZ4t5sHBAZU06Uqct+F72onprf4GIL0xWmxVe3l1FfFAvfvxsnt6EP8Crn+2Uf3oLBCWydpOIlHK21w2msJ1aoKxM5w3Dh8qA14ltza/A6QavnfeRVQ4j+idxBb3nast3tnDPiEw2zEDewCcUk/IhdYudAcgKbtUBuXxs1qfW4PD52zc4hz+Zwj3JabzUaHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OW+c65qQpIeMBk6fYgr2XwcE86pDRYgWJ/7Y1sC0Z9g=;
 b=sZq5CDORWtqWO0RKtBeMmCHYuRnLY06yvjWn9NgwEd85pwgtVfanSOx+xwvnKUP7F8zHyLXOSjxzw+qlc9ESPZWS+ZT3zklKcmHjtOoTm4IiJfeFc6f0wovCpZdu9J8yOPwXWKnyandgyv3ECXlHRDWyejZfRIWVrXs72RBtJKc=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SN6PR04MB4688.namprd04.prod.outlook.com (2603:10b6:805:ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 08:28:11 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::d5c:2f7d:eadc:f630]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::d5c:2f7d:eadc:f630%6]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 08:28:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/12] btrfs-progs: refactor and generalize
 chunk/dev_extent allocation
Thread-Topic: [PATCH 00/12] btrfs-progs: refactor and generalize
 chunk/dev_extent allocation
Thread-Index: AQHXKrvgMzu7WK/w40SD1mRkYW98qg==
Date:   Tue, 6 Apr 2021 08:28:10 +0000
Message-ID: <SA0PR04MB74180E467B5AD71C36D7D8DB9B769@SA0PR04MB7418.namprd04.prod.outlook.com>
References: <cover.1617694997.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69330fd1-87b8-460e-a407-08d8f8d5ea0a
x-ms-traffictypediagnostic: SN6PR04MB4688:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB46885D2A75FDC157D7D3A6A29B769@SN6PR04MB4688.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JoJ8HMhfannXgQeCR5N0vkS7Xw7BmdONtCkHQYdEinWdM0xBFyoXHxE3S/TuB3m18DIMsR8eGaqQ1KpK4js3K5RvUHdJ3zfaB2Xl21VvN8k9QwdeMmj/XPOrv/1FPEBrDH53k5a1auNcFFyXqGE8sDQJNABlMn9EXcPQjCaWm2ScJqwUmOVRa/p9YZr0JxmVgjSBgEP/K90L1uPwpTdEq88rF8kde0HDpNNXHgeo6lykHkbLJ3L30nZ7AlEVs9pjVhgM5Ic/8+lQTW2H3o5dnpRqUr9y5LQmPhUx0WOhPr703OdnBP4fpXwotx6thLCasW8uUfh9vQ017+1/e/Sjf2EvybcXYt0pYG6HECuMEgoDtaRfjxizZzesT1Shaw1IgSKHxaqsFPujmdbif7dinlXLxJZhCeZA0LOM7V9DV24QnQNCpj/FLjCPmfSV8DjBCUcgY2hoLNroLKFLSHQ6veAJgFebO7YGx7vaYRVsudQhWDbT2eL0VY5C30gpnZXlmyZO4dq22yiuMiUyFVuLyFkm0OiNn071KL1D8yX6TwCqReFx9t8Qk7xCXa7k5FjAJdrQVA/so5zChgVwd7douqfeETYUuSIitKgc2DgjNcyn4tUwGd1SQ27z/9JbHiMYYnPBzwdPCQFp8vHscMLIw6HGddjufB+W/WqOoFQ52SlNPQUeHXbait0ZF8de1KJdsyrOKjpbxPSnrBLa6bqXouykqV+McBKbDB43GO9g2oHjq08FdqhhtQzxBENhM9tA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(4326008)(76116006)(91956017)(966005)(8676002)(6506007)(86362001)(316002)(478600001)(83380400001)(53546011)(66946007)(66556008)(9686003)(52536014)(7696005)(55016002)(38100700001)(33656002)(8936002)(186003)(66446008)(5660300002)(110136005)(71200400001)(66476007)(64756008)(2906002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6jvy2S0xNPaG0tvz9IuUDII3cjNRuUrX+QEkvvq3kYrWdXJ/AZXq3RlhSHiz?=
 =?us-ascii?Q?EoBS9P4e2Oq6JrXNQ1zOhGFmHaYEKiBCZ2QPWazcShkewz1lp8LLnUJcc2n+?=
 =?us-ascii?Q?IGs56NWRSiiHG5xcLQhNblpROrx8Hht2H8oLcAU1YLN0IwGx4zl2L01WeCha?=
 =?us-ascii?Q?t3K/+qWry7stol8scu/k65KaRD4e0GWy27RTCdI8xm1rxNsoOcuUrsvBa863?=
 =?us-ascii?Q?u/mO/kIlyYwItFPxCWiyFC1WZVjr+KqDFRP6o3FwmTyPZG+pgj/calyWh1fN?=
 =?us-ascii?Q?0WKyvRBYUi/7BGyuKJsBsRwA4ILS/oKTN67Gy9Enx8razl1OMw25RKo9yVoG?=
 =?us-ascii?Q?KBar9nX2DaDiWs2sdJkM4rkfEGl5hrOeUkScPP7zHP4gpSc0bKNK2iC4T1Sx?=
 =?us-ascii?Q?xbeGGsphLI7JozEH9UsdH4w+aG7xNfekFSOrU/XHlN1+F/tbETAeooTwTpwx?=
 =?us-ascii?Q?jNSkfP7Cz4w30aAFPwgmGRSp4kyz5olbHCWrB10dEg2YT0PRn3K1+XEnt363?=
 =?us-ascii?Q?Xhe65AUUZKBvvxR2VOvbbPv1Xoby0ypDqGhca2inAufYIEu1VTg9BrKoL7Ya?=
 =?us-ascii?Q?UikIISxSWVqEhveFfylruSqjcWHVW3wTCollb1cuvtz0yekHv60GMb0csWRA?=
 =?us-ascii?Q?h7dadGTWTzVLYkP4C2rqZMnwy/7fOdBs8cLuMhzpi0I3JHyABWjr8eYOp0bV?=
 =?us-ascii?Q?mn34xBJ4tnteXscDPAl2rFrjs+KTRCDhtR92G8+3Ch6v6Lspt2eld0eDNyaG?=
 =?us-ascii?Q?uZegXdWk2yflXsJiQ0uXaPv8v6+apR9xjmg1zQXsShCzumkNWmjv1SuYQGoi?=
 =?us-ascii?Q?HpfWwclNggJcDdFV30I/TWJWyKneYjC4w5hKv9EgqSslk0h54I/jnUwHCFvC?=
 =?us-ascii?Q?HJJu7guRWiLRGMO74pBp+Gmyz+h0NH7LsI6tttv7W0BPHiW6iNia3taEikpm?=
 =?us-ascii?Q?v0tJZhpSnBAqMy8iMJ8ILk1ihhBc/RONFH4seV8QaKSWj+jZ1A3WFT2IgjoB?=
 =?us-ascii?Q?+DKkgxWHzQdeeZC9NpYUKWdFaUQQiGa+1iWfLlpozlS39A12YcDqht3xmHTt?=
 =?us-ascii?Q?i7/DA01fFO48g3MZYDlmvP8I06v/lALzos+J+hXOZ3et4huVsgXDW1nZkzPb?=
 =?us-ascii?Q?Ha/KKo40nXLPitUSfsQQe/6U+GbwALhonSfu/NTPV6k/lgKNkDf91OLY7dBf?=
 =?us-ascii?Q?bcwHkrK8rO6KTmxjbHBuldxl2OESG3R80iLB6jBEnHPSxS1f3QxpxgKWvOB7?=
 =?us-ascii?Q?Tr4aYApgTReNHTKiGabu/p5YYEx0lyCnDpqlPM/DHNUVBDvBbNNjLSk53ol7?=
 =?us-ascii?Q?7sT/F78AP/7+dD684WdFM6cXSPLGwPTOw+LR/qw1r0IZ8Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69330fd1-87b8-460e-a407-08d8f8d5ea0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 08:28:10.9859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aQnTP4tPKMzq8hbYxvey2BJwODeWgNaaZjQkc1iv5Oa7Mwd/KxqxZA5I3FkY0s+ldE9894hBC16XMVDRD9/Cl+yxYG68MvHUi6MlgAyNC50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4688
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/04/2021 10:07, Naohiro Aota wrote:=0A=
> This is the userland counterpart of the following series.=0A=
> =0A=
> https://lore.kernel.org/linux-btrfs/20200225035626.1049501-1-naohiro.aota=
@wdc.com/=0A=
> =0A=
> This series refactors chunk allocation and device_extent allocation=0A=
> functions and make them generalized to be able to implement other=0A=
> allocation policy easily.=0A=
> =0A=
> On top of this series, we can simplify userland side of the zoned series =
as=0A=
> adding a new type of chunk allocator and extent allocator for zoned block=
=0A=
> devices. Furthermore, we will be able to implement and test some other=0A=
> allocator in the idea page of the wiki e.g. SSD caching, dedicated metada=
ta=0A=
> drive, chunk allocation groups, and so on.=0A=
> =0A=
> This series also fixes a bug of calculating the stripe size in DUP profil=
e,=0A=
> and cleans up the code.=0A=
> =0A=
> * Refactoring chunk/dev_extent allocator=0A=
> =0A=
> Two functions are separated from find_free_dev_extent_start().=0A=
> dev_extent_search_start() decides the starting position of the search.=0A=
> dev_extent_hole_check() checks if a hole found is suitable for device=0A=
> extent allocation.=0A=
> =0A=
> Split some parts of btrfs_alloc_chunk() into three functions.=0A=
> init_alloc_chunk_policy() initializes the parameters of an allocation.=0A=
> decide_stripe_size() decides the size of chunk and device_extent. And,=0A=
> create_chunk() creates a chunk and device extents.=0A=
> =0A=
> * Patch organization=0A=
> =0A=
> Patches 1 and 2 refactor find_free_dev_extent_start().=0A=
> =0A=
> Patches 3 to 6 refactor btrfs_alloc_chunk() by moving the code into three=
=0A=
> other functions.=0A=
> =0A=
> Patch 7 uses create_chunk() to simplify btrfs_alloc_data_chunk().=0A=
> =0A=
> Patch 8 fixes a bug of calculating stripe size in DUP profile.=0A=
> =0A=
> Patches 9 to 12 clean up btrfs_alloc_chunk() code by dropping unnecessary=
=0A=
> parameters, and using better macro/variable name to clarify the meaning.=
=0A=
> =0A=
=0A=
For the whole series,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
