Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B96F4E70E8
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Mar 2022 11:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358760AbiCYKOC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 06:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359006AbiCYKNL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 06:13:11 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A921D4455
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 03:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648203060; x=1679739060;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=LAfBAitTbDEwSMqBYX56fP4qfKYZjQ3qIr9ofWlScXY=;
  b=hkR/a/kQwRCQGso60mD9qRFWWuQo67STHsSb2zBz+D0OCcEHt1fw9nL0
   7YUWbB97mqHQs5jTmXL0sE3IDugYMkVokgJDagvxD3+/0DIFQoycEhWyn
   NxVMBeD7LmesqXWWd89CmeyurDQHl5SWKp6qrkb35iME4jIqrlpeNK7UT
   3ACDAUFeGddTHQlXAZH3GRxkA/D6KHsBOUBCoaCTlukEyPNkjw4YIMEpp
   LsjMPGAVq43eJcI/N1GbhIKKmsm9BUXfyf0r8lBaTwZR26kWfM3SOHfwo
   VofZHiVk486Og1Dmo2qG8Wacp8SiRtYVd5BxKWCJaecdmwurwj3OWTqjK
   A==;
X-IronPort-AV: E=Sophos;i="5.90,209,1643644800"; 
   d="scan'208";a="300408013"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2022 18:10:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKR27dw3lRTf/o1N/luEKn4ySyeviobkGlZj5eVuOJr9cIqAwVWUeiTj+w+YrrtP4/jnldUJOG3IPRDJOGpA7hblYed/eeSpjQ8D2o5TptzXTci7tDccjxYj9MW7RIKukRyBMUcIEcE1uzKtQHyQve16ZOOu59KpvuRZCxe4o2OyVxO6+1OTelhb0MpaNmExqKOx4VtKdc31qzv90tAaJSFBS/jWSWtF8OYy0ajHV11s1uDsMqKzKqqu1shUUGYVI1eFGPusu95TCi2dWIzFhmwUWWhh+8eQzwEk2UyOzPF4c0eLY2p/pmIlv7ypZsaC+QK11kyhJlQIdZmJGcOymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAfBAitTbDEwSMqBYX56fP4qfKYZjQ3qIr9ofWlScXY=;
 b=N+KwsiXvs68AISCZp10c/loYjngpU4ZSkljeZpDXV77nClFFP0zPnchheITaIS3J3Q4G+HxnGAqZjPHh8dOKrpgbsC6IFgAemaTsX8kG5PRVjIwnKD5VI1SIK0YE897PHngmhLrXouj/Y64FibJ3NYh0Jj5rPd4PVBO4ebkKWY9h3e6+YJ3e5MACRJi8FE2rPHbeP/7meJmtQPk0OTWSurAbgNsKBFililU1/nTbUIUVY5S5hXtiecbB+zTD8AqjSFs3/5j13mlgKrp7H0lb6avUbYlJ07Him0DlPvrf/0kQoY7JbubtJIAkZH5NEbEVaXMGm8CPPkOgtyCgzMHC6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAfBAitTbDEwSMqBYX56fP4qfKYZjQ3qIr9ofWlScXY=;
 b=I2kvEwHUhP9e1gcm/mcfpCGb1JeHQZIGKgW2sGlgijsBjtzfou5OaVynkQAvM3Hzv8AmcjT1ea/dkBUWH4afkKNyZ4b6cJ44yZdNQrfyyB0dMsWUtDqql6Uxe2ccJhRyvcr37iIGq2T66hypB2rF3DWTbApr1LVp1Rx18R7028s=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB4146.namprd04.prod.outlook.com (2603:10b6:406:fb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 10:10:56 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2%3]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 10:10:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: replace a wrong memset() with memzero_page()
Thread-Topic: [PATCH] btrfs: replace a wrong memset() with memzero_page()
Thread-Index: AQHYQCwVua9dYMym+kuSOsI5USV3Zw==
Date:   Fri, 25 Mar 2022 10:10:56 +0000
Message-ID: <PH0PR04MB7416A2B700E658F640B7FEF39B1A9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <8d6f911a0282eba76f9e05d6f1e7c6f091d4870b.1648199349.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4ab25d8-5d3b-4870-ecf3-08da0e47c0f8
x-ms-traffictypediagnostic: BN7PR04MB4146:EE_
x-microsoft-antispam-prvs: <BN7PR04MB4146DB88FFDC3BBFF69F94989B1A9@BN7PR04MB4146.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J3nQIVkpRIGziGJABXcCdv5SaTbi/9R5L+DX+Vh7bWpQSE6ANxMEWUhR1GupyLTSXaY61c3VUDJRJD5AVCL2/NeEbgfDjKqDJ2BLmB9TsC14XaCZWmOAgsc8me/DwxegxrBusG1/3g7MLw383KWes666MUB5ccbJ0MTVYmn2J8gHy9/SbFcxSOdxldkTfWOz+K7fju+ssfaI+z4AxX735o1N9DmQxiisKt8WcyenfVAsbP99NeZFMatr57ZLWzqyr2dghD1X4nwc+hwAG766Hcl+g/MSiqfpJSAolOl1UCxIz4IRItaaXK260por18Tp7+B0S1GmlFVtocL47q49ph5kahPv0CZLhqQxEjjWKUqrSUdiB1nukDv9a6VS+g4uhq5YSkfAaF//Sa/W6JJ9kDtGSDG9D2L3dSQJFxKR9qk7awfYfBai2yHugkrd8ySXTS9wfhRbCIGKQrskslFrn7c5t388BQXZXpAFvG1p/bf7Z/zG79S40RjarxKXzc56E6GALSCcnr+hFsc38xbRHCn3XavIXkOGW5wkeijRixUY+1oqATt3mQBhU0GriOreAa2+fnt0SJw3W69eO6BY38DiobbUR5wA8YGTBMstWV5fGXYJ4NkFLid6yiFnPMrie0j+zozcA5Wlt0LFS6dwUjW7rrjapHJ4Ox0E1mt7INSvVA2xQrv2xiT3tCM4mGV/CqBFNSGMgqVfyCTZjPjpgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(4744005)(53546011)(33656002)(38100700002)(6506007)(82960400001)(9686003)(86362001)(122000001)(38070700005)(71200400001)(2906002)(186003)(26005)(55016003)(5660300002)(316002)(8676002)(66446008)(66556008)(66946007)(52536014)(76116006)(110136005)(8936002)(64756008)(66476007)(91956017)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PTH+ExJTxsPdzqLvU4MHQxDvagTMF3bNBM3nK+r6hljQ+Xfdsc0JTOpPd0OW?=
 =?us-ascii?Q?iz6Kpc2i5L8gbCPFBJMgD+mvFPA8RUvXLTnApDL6t8/m3iI3K8HEzO1cl8ku?=
 =?us-ascii?Q?YPFTYXCz/JoI9zmE0nNiFI8+YaIyPim9ip7CU8VwkccuEWFW2+f0J5tCgV09?=
 =?us-ascii?Q?FRUclJa2S8XuoV3lVcW2jtwLSR202bwQQLexAvm5uQjHO1zsg5DObFIjcfcs?=
 =?us-ascii?Q?A2oXpTfdPpRMjtmleO8OkYvgCAlK0SSV076TKsGmV7KdrAL+ogHiDsIVICHm?=
 =?us-ascii?Q?F7QFx+8rJF9vM6LZD4pQyUKVgY+u4GKJDaiaGCDgdG0WNMpBzz2TA0XiGTcr?=
 =?us-ascii?Q?65SjVCi1pI4xa1+KrTtAw8srjMXedtXr84umINW5d5JcyY4Q5y/YPLngIzzn?=
 =?us-ascii?Q?x7P0CR4tbA8shEKNQylFpio7+ikLG1NHXHPbF8DFcrZlOYUIh2Ei0lDqJzVV?=
 =?us-ascii?Q?fwVdd07NCoDpfTZvZOlx8BHnVRgNTqdTyvnk59li1jn9jEBkw/uilQqeV8en?=
 =?us-ascii?Q?J96+hS9E5pCvkFQZSpJPZ0XDfrIH1GvV7zOG6Ba9qZrM1XCrJ66dy6Pemdcj?=
 =?us-ascii?Q?VLGZ8NgqwoMzXirMbEAmvYLOxZeYVpnTVVZFEXA7ZxojEYs45UKH3rcMj4+T?=
 =?us-ascii?Q?tk5bU5CQvaqqaRukO8fDuQPVkKzB3GhMoOXVjeUAz31at8vS1tsLBOdMT5di?=
 =?us-ascii?Q?vgqPe+ayiDGD065Pc3xhtKzT3oUuJfhUpsSJb1hm253pZV7xYv7oIHqEPxcW?=
 =?us-ascii?Q?fA87h1FA3d8LoA1fYDQku7hJT9NAgo5XRZjetCIiMscsjEs5MBffmLgpqC1s?=
 =?us-ascii?Q?aXAAT3tWjw44mVewiURjdCvdmVYnx1ODN4dMMnkFK+/6BnHHgn+SXrQRDNMl?=
 =?us-ascii?Q?bWXN7W5sRIMrDwb5cqEXJUmgGvMa25DTPSKE8kH8YR7ETrOeZbgfebRzw6P6?=
 =?us-ascii?Q?9C2nso8Kxbbv2VmHYu6NE+oQoq3oJInS9fmH0PUBb1ScsK6x6VnAwHcUWFj4?=
 =?us-ascii?Q?R8jZGnSE06P0g6OeZzeV8qFSbAQuddEelJUTUEPO9d1ZEdBRDGkwH/yA7dW4?=
 =?us-ascii?Q?NZ3blVpKEjry0tABVo6HfqMXwuxQpFxYGwZPHeEY1rxpd3bRa+s/81/BSP1F?=
 =?us-ascii?Q?qKs9Y9NuL8isbjDrlVHVB6ifz/qvNv3FR4DfXcOIz0jSM1/APRD1Bd9/dyAs?=
 =?us-ascii?Q?9xBzlJD+Rc63fBXJsjQ8h046lIA57bAYwT69HPDZHwd1bJQUkJVxzsEJO0jE?=
 =?us-ascii?Q?Om9dxBK7BovXEtlw2q0pOpyMhPqbhMyvKYrwenJKkP3qICdm/yRz2vhaNt3D?=
 =?us-ascii?Q?g5WcYZCnhQb3yo35yu8XPTwS2OUEG1BIBvIqWZ1OICt+/7R/Gd1yros2praE?=
 =?us-ascii?Q?RDjT/a6lIep8vSQPy+k5Vf6tLsuNAFvu4qJqAwMzwbQbXTBiHfupsJ5QEYvV?=
 =?us-ascii?Q?RNcDoZ/oKWCkS7ARrfOJgSWOAL0Q2notovZ3mYAhcjOgDCEfXZ12Eb/buDQP?=
 =?us-ascii?Q?LBqLpZaV1DLgfU4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ab25d8-5d3b-4870-ecf3-08da0e47c0f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 10:10:56.7946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xjbe8K0Jzg7E/kLcoH585Gf0+YUZr+iOxvXJ2HHEY7wbRDmcLvo8MCZW86cF8RmJzZbU1Ugyzv8kuiuTZOil0ieI0tNcmAlgr6onazcuC8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4146
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/03/2022 10:38, Qu Wenruo wrote:=0A=
> The original code is not really setting the memory to 0x00 but 0x01.=0A=
> =0A=
> To prevent such problem from happening, use memzero_page() instead.=0A=
> =0A=
> Since we're here, also make @len const since it's just sectorsize.=0A=
=0A=
Any idea why we're setting it to 1? It's been this way since 07157aacb1ec=
=0A=
("Btrfs: Add file data csums back in via hooks in the extent map code")=0A=
which landed in v2.6.29. So basically since the dawn of time.=0A=
=0A=
=0A=
=0A=
=0A=
