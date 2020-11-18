Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002DE2B7BDA
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 11:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgKRKxf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 05:53:35 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59975 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgKRKxf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 05:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605696814; x=1637232814;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rgwGT8KiAFHk1jNTvXftaQTbDPgJJyFHBSp2JvJOr0k=;
  b=PTbaj9mDJxHKbTKsJV1hBgeOUX2Z2pXOGXJvhJ3D5ebCoOFpwyheulrL
   sudF3eWhBkyvtAOwCQpQp9Xfq2meWn0TlmdaMy1TNGmGBdN7Zrt0IqvPU
   MXrBoHmc4VZqV+KaXGg4JtrmKqOQaKPW+9MDYdztyU5IITycnoOTms5L5
   BNBPL7xvtRmgVAsntjktSfFz8AREFp64H/xy8aNYC/GSW5NBPphb5exhX
   3uxRxF5vB4rSCSvEqLnHtJDipN+TPEqtxcb/hQ/Y+d41AK8zmfkTHrjO4
   yg2/uCdX4Z1t7aZ+idDdp8obAiSTLeDXZLSpM1VD6d3qrr7ZU0UgVjotN
   w==;
IronPort-SDR: UmKvHx8DmCmvIQD1UeVUx/IbDd4sCq1aJpQ2ZhrDeBjwoSf5xXanZ+wc8F0JPkH1QynJssABri
 VoEQbQQDXgelz/VSWLge9S58DFEMyEEGD9P6ZxOGioVaeZQ+BtAwuPZQlnnTJi9dT89ZyJSWsE
 T/eODMrJFi+sG996i14+Os2Oz/gP40o1iKjRBbwQMSmTG7Drn6qcps2/5JU5oi3Uw+4qsN8LiP
 5G4qNNqeyRSNgxQOssVx2gpvcgncWI477xIKdADDL3/SqfrIaiK8bga8oTariKMd2BSOMVwxPP
 lg8=
X-IronPort-AV: E=Sophos;i="5.77,486,1596470400"; 
   d="scan'208";a="152783930"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 18 Nov 2020 18:53:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6oOe9vyo79wx7RM0w572FcMRrTJ9GfG1jVBk+3OgMNlZOtnOVcZhpSqSdqeTN/guqeCf9EmUsW/X3dkJMagp5uUhCI5WpcHz6eGxZx36BeJyDgNdesClEzmTtW8fe3QyvqYxgAhY4WIqaNTrCimZeplm48qkyJ2Lb7JrxM9zKJ+zCnRWvKl/XQUR9Y0E6beq1hqIshZ6Ta4EVoKbqHwrMnOy32DcLd+oFSScfEMcWPsxp0hz0rIJ7R+fdw73jpuS7WNDP9NrZVDWr9VBQhFm6I2TEPBP9kvLIHZC3Q8J/8Y4andN1hy1MVwstrOMuP77VtioCc7nkrMvUGEyrisuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txF1sql9Xh8NvisotRlkXp+IKBQKnabhvZ37UlzOzAI=;
 b=E6bXp+ch5R0+pkVxlVFS4wZpnFhnE8x0EdjfsCakNaMw8CmajAs4EnA4yye3jvMs+nuCzoqidNGbXq55n7pX3LIL9xzIzI/7ed2QI3EMwx5WjNFgLd/o+e6WBJbaqjBSbbqN+724aNTUxae7ctVoUDsgoImxtPFBlkU+66bggDspHTv+Rj9XfwOzhLGP6XZ1THQlxraah6FPqaytKdMrzYgPVqNtqxUDz20GfAWNik4xMIsuQHZJkkQt5rhqo2sxWXJO9bL4/NJVsnc5ciMGzIiA6ZpB+oyiSB2Jdyv0fvD2H6njAaGxMxrdXzk6nENMxj3wb41I8krvwvVtCGTSrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txF1sql9Xh8NvisotRlkXp+IKBQKnabhvZ37UlzOzAI=;
 b=NNeaCVCVKJImNEPctayQPzKCIAuvQsuV1Q4hibDWCsHbb37K6p+lrakmaJ3vD17xaVhXIvnDmRJqMUMW9QDNapGjsYmk4QaVdhHZRgGIW74xV2uLlGSpvGxnL7IVWHxrxd+t9/ov6Cld+AxpifHpDo/eaHhgXVpDJ+E3D342k3U=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM6PR04MB6171.namprd04.prod.outlook.com (2603:10b6:5:122::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Wed, 18 Nov
 2020 10:53:33 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::7036:fd5b:a165:9089]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::7036:fd5b:a165:9089%7]) with mapi id 15.20.3564.026; Wed, 18 Nov 2020
 10:53:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 03/14] btrfs: extent_io: introduce the skeleton of
 btrfs_subpage structure
Thread-Topic: [PATCH 03/14] btrfs: extent_io: introduce the skeleton of
 btrfs_subpage structure
Thread-Index: AQHWvYiiieuiPuOtHUKZSYdtSSBoFQ==
Date:   Wed, 18 Nov 2020 10:53:33 +0000
Message-ID: <DM5PR0401MB35912BB9DB2CC11CFFA7CBA39BE10@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20201118085319.56668-1-wqu@suse.com>
 <20201118085319.56668-4-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1528:b801:c926:e87b:b5da:7b60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d83ce32b-4498-45fe-ed4c-08d88bb03159
x-ms-traffictypediagnostic: DM6PR04MB6171:
x-microsoft-antispam-prvs: <DM6PR04MB61719FBD57FDFF54DAB0EF409BE10@DM6PR04MB6171.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cvXPoOVzHd2KgRa4+OoENXqNPFigP7NcEl2jyanYDVLZtbpDj0RHcwq/RDkwePCJvxQpvDjuW/E3yh3ZKzuH51zvKQBSD8wtavkQ+qXMF6KaJls2tE9nQRFEOolHV+tWKam36u9UqccGxtkw+M/fEZoYzV1JI42YjSI79dq4+G5o2P9UJvYS9EAzSgu9DXAY6EVX5g+SACrXho+zbm65hDBSyjLJZX0xZImeqXlJ0ul8tCdBZwXkd6AtZ872c0kbWrq5W5Bka5vJJHB2BqsOokNiK0FMcnwpfXEgrjpYnHkv2tsST8SoRPk264ehaaS9ctu5pDjjHWUxn4SGsivwDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(66946007)(478600001)(64756008)(66446008)(86362001)(66556008)(316002)(71200400001)(55016002)(9686003)(91956017)(53546011)(66476007)(186003)(33656002)(83380400001)(7696005)(110136005)(558084003)(8936002)(6506007)(76116006)(2906002)(8676002)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wFR/Y8EdS9TNanmxPSc9+z+ay08MaIr5KegYw5j3/kK+8rP3P5w63Ev8I4AC?=
 =?us-ascii?Q?GM7uDPh1sM7p/Xw9MvfM9JxaNq223GCQNzXaQf9EUIq1CqoZSZEbTrjMXnNv?=
 =?us-ascii?Q?IyGU0V8Pa79tRWE+mMAXt6NXJYOFvR2DyuwSYzb4OWpNiEw64Fj8npd1snmR?=
 =?us-ascii?Q?rJmTM49tIMZ5dbtUEM1V0pDooKKTwU+/FjJVoq3BPhFHK9f3VJduWWSKq62r?=
 =?us-ascii?Q?STf7MMCYHMLyY9qbe0V8HvlK68xjv1lJsoi+egKatB0YZGEHKFaRHL4HcvE0?=
 =?us-ascii?Q?ua35z2pdLjJZOVUWMnl3tnnAtdV0RUgJMlhapAbhJbqToumNeI7wQybGrN07?=
 =?us-ascii?Q?5bxaYNb6jSiXaTsleHfgBcDIWX2aGLwUVUUK79+uO9ObCMFivqcuMLQ0ls/6?=
 =?us-ascii?Q?C26vjmq2a/hJEE4Im/PO8Kxpj3y+eks9jW4IV3l5InInQRrUY0zQ6k8Ghid+?=
 =?us-ascii?Q?g24cypxCnGnz8kFwATD4nWRAEgdOz6xFaycLRMJQepD9r4P56BLIsSzHcEto?=
 =?us-ascii?Q?BU9vqK5DBjKMe8Fi5/LLoq3Quq5rIX7qmhK38Rg7s/5mL2AaovkHKXOGPOiv?=
 =?us-ascii?Q?00Dlg7MjgtXLfgyYEN4e8uptqnbbUh18AExCcyw1LHjaIA7I8p/kcIHubdma?=
 =?us-ascii?Q?f6EHbSoc/zhFhw0oUuWRuI1k6kagiiWQEFuFd9klZUzNJ3Uoj2xbRSAXIWQM?=
 =?us-ascii?Q?VEVPP3aUmyMGDm/ZTGca3TsiK1dcE/AxY2n6IRlL/Bywxpvc7TXVRWVwF3lO?=
 =?us-ascii?Q?qQzBxpTki/TA2vcfaCSAJwQOqjWGkxVHpGNBmpFSqrE8i2j3q/bsC3Y4QEhR?=
 =?us-ascii?Q?a21KWrDGptUTLT1TpFKBuTZcyTYqbmH0xQKPVYkhqD7ubiiaJmciDToXBzcH?=
 =?us-ascii?Q?OQPW55nluYb9DGC6hbOz1GAuzgJPp+AxF7wHvf/daFjue2Sx1uof3hYLsBhr?=
 =?us-ascii?Q?+kMx5226VoPLj6Bv3oZDWw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3591.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83ce32b-4498-45fe-ed4c-08d88bb03159
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 10:53:33.0217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 21foaOk+sXQd18j72OIh1aO5hkinpSXvjXtjxEKqrYEC3mP4HAVIsv5x2UqDAnMacTZzZV0+7VVVxzuH3YUTnt4kr37hRk8zM3SrqPs8aBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6171
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/11/2020 09:55, Qu Wenruo wrote:=0A=
> +	ASSERT(subpage && bitmap_empty(subpage->tree_block_bitmap,=0A=
> +				       BTRFS_SUBPAGE_BITMAP_SIZE));=0A=
=0A=
Hmm from this patch it's not clear to me, what the bitmap is=0A=
supposed to do. Maybe add this ASSERT() to the patch manipulating the bitma=
p.=0A=
