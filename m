Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C942FD544
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 17:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403787AbhATQRP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 11:17:15 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54394 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391516AbhATQQ4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 11:16:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611160185; x=1642696185;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mSFmH9YwIEUUE7PvcEbTLhWqsLdpL2knCMHHa4dCaHs=;
  b=Nsw8SSrvtIvegMj2v3QKgpsrp/ZtTvuH5DPv0jf5HKVaDrBcSvqxtrEG
   yYaoyfi/eK3eDlbJsV3YeGh6bXwRL2yYEW2pKewNSXc1jdc1czc7I7pHq
   fN5StKG4w4NDJSPKOFXK5m7Ps0pVIEOzeMsPTgZWhpfj7T/3xE9vy0WTI
   BzhmlSzV5c6yk8Vrv5Fp0nqhn9qyYCWC2kgVuEWUNGl/M8p11BojNBH0c
   az2hsrj44GspuP/yi6pU+azp0AP0hiU2k3+nlrENuT8Y/1OjJ8TH6meAN
   fd4pJHMS1kWpHqQnzQYyYGPBHhSaBgON3yMFx7YDriL4+G4ks/MWk0+zI
   g==;
IronPort-SDR: MA4NHPNxBElz6vv7AyX5iuTXJafpeRVLr1f9aKza+GbtyNAksQ2UU14YnipwYUh0N8a3/joKeB
 e4aCLCU+1IW4Fo8HgQJHpNlzvMONmTArYqni2XExP9rIa9cSKUkLuql4wDhmiAT2bssOLjpRlr
 4yuTSX57WmgCUFCmA/s56ylbekHyaqguzCFhbUd3SnySOWYbGzra7y7K4DOfXCOgNjPr+vcEgS
 cpIjJgKFMz5itq8NhOdyfmLd5PED5FbGwlOSNVS4zTS9qC3O0Yg1iluPWPKYLRmqbb697QTjXr
 Vxg=
X-IronPort-AV: E=Sophos;i="5.79,361,1602518400"; 
   d="scan'208";a="261879267"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2021 00:27:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXneA8H33MKvtXJ8t7f+qSstXY+GOTuhQvtHn3kDSbA61SZt0/ojdn36Nb/RkTdijNQk3PJvyl+e7tZWqSAH7uY99Lec/JninxMununJvSb94CJUpEMerwGF29PgH7jROV0hwRA8MRH0Wh/8J5POXUNUdsvGv3PGykI2aC0Gc7jajxUdZS4yIqh9KGgWAcoCQpOlfoHNATn1PsWc6eLbrdvc/RO+iBzVq8pzr6hPF8SPYpsNCEFDTz2mG+mwNP7G803A7vNjF5OR6E2VB3NYchZ5/oXGT3A5GSSDNLjR3FpyY9DpILdCiY/qZqZrar9X+DyCXqobg8BQGTwkbSzpyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIgW8jKUT4Me2yhh13//NGS5sN1Ukmq3RI9reHoAQQQ=;
 b=bCiI0Y+DGV3dp+g39SRDveadALPMXbFrx82JI8xbaxIjbgOpeo5CQ7CzUzQ9+3p0FY0BqakegnwO90oUbevtmi8eMbmf09gto3ErbIRWtZ/OO8K2a+KbG+md797IwWv5ZZJCPITa82D3GGgqNmDsybCEqlWczpASJ1u7uIl08pL/9k7Jop7FraQ8ARWTKVAc+7fKlVbVdZgu1ST68SbUr4OVq8Q9fujmWKBIiADlmSFosC1ifNj3bFbjTxvy89STQJ+CakiIwRpzjvf/QNLf2uEqPhlfvGDVWTZoLzhkA1QVkgdjpfsKbrPrgBTOXfVELo0CN2UjFeSN5KAjBCYq0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIgW8jKUT4Me2yhh13//NGS5sN1Ukmq3RI9reHoAQQQ=;
 b=MvLnq8W36512z6G5zRzQN/3jEKa53peajJi8yyw7H8t91cMeVfj48rTviGAfx79rql7SPuPYnsggM5d+oGL6VpdrclNK/fHJJUQ3ccRbVUtVdOkAkZCQVt6ZKs3Q9CINylsYWdVnmBe7eY1E1XalmdRU10y1Vs2oSjHusyWGWk0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA2PR04MB7481.namprd04.prod.outlook.com
 (2603:10b6:806:143::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Wed, 20 Jan
 2021 16:15:28 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e%3]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 16:15:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        Goffredo Baroncelli <kreijack@libero.it>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: Re: [RFC][PATCH V5] btrfs: preferred_metadata: preferred device for
 metadata
Thread-Topic: [RFC][PATCH V5] btrfs: preferred_metadata: preferred device for
 metadata
Thread-Index: AQHW7QKhSMPbZ5rhqEK/8JylGXzzKg==
Date:   Wed, 20 Jan 2021 16:15:27 +0000
Message-ID: <SN4PR0401MB35989479F9B02A1E2795728F9BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210117185435.36263-1-kreijack@libero.it>
 <30cd0359-e649-dcc7-e373-4dd778fbf70b@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15c4:1c01:1587:d74f:253e:d796]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50bc3b73-4aa2-452f-8538-08d8bd5e99ec
x-ms-traffictypediagnostic: SA2PR04MB7481:
x-microsoft-antispam-prvs: <SA2PR04MB7481C472821FEF1EC9159C7A9BA20@SA2PR04MB7481.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hNdsynC9cEF0nIECujPo+vXS8+pl5wm15aYKQQG2IYzkYOjBUxOwHQFJJNjY65pA3ZnwdciCKEosFm+RbpnQCNJzU2c6YmYDXdT+vHCflqRCYk+mWmOsAHEg9x7F7AlCyX09Wpdz/BjedCD7IvNFohNJipMyUTaQuhgh9w1PcH8QVz3sZzWOy8ToKgF3GE5T4wG7Evy8IrL1QopXzmKF2X7CbO2mv/2tX8WD4dBoUeha4xzgxFWSG4sdGc1SSLRJ326W2e8srGaMParapnP+VYGsQsBwZwRHWQ9NNQQSxJEGKiVbOm4fb3sY/fYcv72eZF0OccH8t/ANlMs4ln9rbw4GWymhcY7iR/Y0eNG8FyuTNeRbtv/e8mnin3N1CZpG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(4326008)(55016002)(5660300002)(52536014)(33656002)(4744005)(2906002)(9686003)(6506007)(66476007)(66946007)(71200400001)(478600001)(186003)(7696005)(316002)(8676002)(86362001)(76116006)(53546011)(91956017)(110136005)(8936002)(66556008)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?36TMyi61+XpH2vLbIoOaKW3P8DLIowURhFT8wNfoaWtBR3LKDpKzCjJ+08Yo?=
 =?us-ascii?Q?vWn6/Lwvyg0YpM//2PcfmLFFdNz41px01a0KShkftYhPbY5nP/HhtEcYelTY?=
 =?us-ascii?Q?lZbF2I4MjXVJCxuDIxEX6G46yB5i9QAipfyA6wvMovIugekxUkf8oGYqT5EZ?=
 =?us-ascii?Q?lyxRkJcCNj2kR3+oyqEIWkEEc7+BH5VqkxN6OIrDzqmqdFD93x6K3jB0VQE2?=
 =?us-ascii?Q?loRnwkU0aJcikQ4CbHLjncnyHDFVL8RPYRY5ijnLmJknveRoJ4TeiwrZUeSR?=
 =?us-ascii?Q?uomnQTuKkDEBWPkF+KyO+4bf+kaf1Xoq9hBdndAyl/lg1QqDTldqBEPd5OQq?=
 =?us-ascii?Q?Jv//hoZr4nllL9ESYK5B7p266Ydto/MhYw6Jx4gNyAoMpfkpnyJEk9liCvBS?=
 =?us-ascii?Q?RQgaeTG4SgBgwts0ciTXjSwumo98tvOA9p/+6OV+woNUGm9XO4UtcP9iH0Bt?=
 =?us-ascii?Q?czCH56eDJzz1OtjWDMWFe2kE8iJx/KOu2IlEEsKyzpjftNFy1QzuqTgyLtIC?=
 =?us-ascii?Q?8uq08MyyCMFJjZRvVSdBSiirilZ2mTSdc564XWAzCghqpWKc+6dmzyjI1NUo?=
 =?us-ascii?Q?TAYKPEVOd95NVpGWoj/vtq5t+4LbPSN2zavMCFZ/g9dhRTVuxHWmseMnj8+G?=
 =?us-ascii?Q?BfEC7UhaXj/hi7+kOHYeCo/AnXxryBy2pza2nILVltq1EmcUDYjW0o06zxfa?=
 =?us-ascii?Q?SeQi3xKs7oWurNHad52SfPibr/8iEammK0Pa7aLuRc78UnRPeXStqzu7wfOc?=
 =?us-ascii?Q?c5PofOyMTlixNqfZxXCekmQFlshz9ABIzLD0ZG29Mvhl1p1wFkq4atEWgpr7?=
 =?us-ascii?Q?ufgn/CAAETRfqr8sX7XYVCwMY6QavySuJCD0zoGwDK1LjTuRO0y+KVQABYM/?=
 =?us-ascii?Q?dWpEklx1OUvLEPG7THfBDLaAIX0+iJoMZZyoSYN8xLw1ZHZm7R9D8rYSemJo?=
 =?us-ascii?Q?KTK1Z1Ccxp/bMihlGaxabEcKv0MwLVW4jthdguHjEcM1waNLYgNPOrscF8qd?=
 =?us-ascii?Q?Eb+WayhYGvFo65dZhaLcMeWbCaEQMpu3gCkgvIF3EAT5kygz5QmhItJksLPq?=
 =?us-ascii?Q?bxmKlomt?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bc3b73-4aa2-452f-8538-08d8bd5e99ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 16:15:27.8616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XiU1sP46Uewei0rhAVhK9cZh4v6S2rNdNNx0sRPvW/Q0tkm48V0jtrOUZSoyqe2MnuCJiwi5C/kQv2y78C3NO0QAf8OkB6tVDoNrYfcRNIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7481
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20/01/2021 17:09, Josef Bacik wrote:=0A=
> I'm not against adding new actual keys and items =0A=
> to the tree itself, but is there a way we could use our existing property=
 =0A=
> infrastructure that we use for compression, and simply store the xattrs i=
n the =0A=
> tree root?  It looks like we're just toggling a policy decision, and we d=
on't =0A=
> actually need the other properties in the item you've created, so why not=
 just a =0A=
> btrfs.preferred_metadata property with the value stored in it, dropped in=
to the =0A=
> tree_root so it can be read on mount?=0A=
=0A=
+1 from my side as well.=0A=
=0A=
I have the need for this in a planned/future series and I'd be more than ha=
ppy if=0A=
someone else would've already implemented it so I can jump on the train the=
re.=0A=
