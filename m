Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95983B6FF6
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jun 2021 11:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbhF2JQj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Jun 2021 05:16:39 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:21491 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbhF2JQi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Jun 2021 05:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624958071; x=1656494071;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8pQSpm0xJTGFxeFiuXaCAr9WAlXiY0ARbJhDt5nroLo=;
  b=aZVnirya/NHHFPDQRFL5ED2J/F92p/KxKQpMrwdDvcbimPjvnrSpO/Ve
   NksPJZVoNq41JnHv2M80j3va/NhZU4nDeM9XYYTFEOrsWGMWO5O5SLenk
   7q9Ihp6wto7FR8e5LJmtUiO5dgELPP8WigIU7rL9pciWcuQH/t+vsLv8a
   17Kwa6rEqSonJuGRJxHYhUi9KgXcvegAwqdgxvDiJ1QLxjCzUhfkj9jh9
   z2C65Byx85Ua/Wyi2rcMdaHUA039lQlZPrW3V4YdRKyjW9cQ6lqA1cm+g
   jlIIPeNRD+8KIBcXOfVat5sfYPuVoEKCBMhGLw6m3WNzRRZAZ3FKIoP92
   g==;
IronPort-SDR: AT9BRFaPDjLOBJ6XhTVQ0TxLbxgkuyGONLfDeA12vMKk9H5Tk0pwlqbajZHdJqvD9L7CleEOaa
 19FhbiHQvOPvrmF505UE1YRw9opP5v6nUG559e8OS2LibOOYBHYYIU479OW5dWcq9O0mpX3zVs
 G5wir9u0mqi4qwWtyyQPXAoo5rN+0TJf3SQfXQTASVcq+CVQtHmAK2wsGXnQfoyY8z1xXxcZHh
 Ud3FMYmlYdogyF2mo5OkPdu1B+7cMH7s528VkS2/7CbpUqEd/bnYu62SaxLjxyiJugq+mTQR1K
 7v4=
X-IronPort-AV: E=Sophos;i="5.83,308,1616428800"; 
   d="scan'208";a="276974393"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2021 17:14:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Adx1HhV0i3+uAElxoKHON05F1Ke6lfxwRSje9+y0IxMsXq0dLYwSZ+2RGdCtSNR4S5BZpX4iFZWUrZnoSbGFgj8Tn4j7P4tGbpOWRfn9dcYkaRJZ63YIJSk/6fWYJJio1H9va6kCPWFuqLnPLqFiCBp5TuL/HJDFVvIb/Pinlyk8oGAwG4o4z/7gPDAb/VyKA/YrKQSL37fk4tjJRLFNe3OGPgQhx7aG+P4EP2dL6B270Akf/rXzaRT2OhnInHXEaHuYSW2RdABh2745U4kCfQPpTEVPYOZz+RQrfQBqZ4Xpj713B9KT4GWvOiyXDbhJ2OLGGGsxy+duBddvjvboYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pQSpm0xJTGFxeFiuXaCAr9WAlXiY0ARbJhDt5nroLo=;
 b=Mu36EcfHa8enPZXsnf+z84Ymg4YKXocP6u1rsTBfQu2ZKQTN491YSx/xQZvqMPq1jzlW0S0ER8tFybq48GDuQ5dkyLOgEjIbdnBLcx+FQfOGtUEOjYF43fpNQFn74je2omHSBJsgbz47PDbNGfn9yAVLsG+b89NEC3AlDBMHFNyEM+twf3+CVWVv3bKwmAysSBc2+OioQ7zba7osfxcOvMjUe1JQM8RXdKogzIIdoWHKvOcUekr9Q8gRCijtlXSJ0yQaTDOWuL6kjb52tpYj1HGnc9g9lmyISHNNUUoo1O8qt06p2UkmvGPflIq619BMhYgHNoivpFxDPcRO1mIa6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pQSpm0xJTGFxeFiuXaCAr9WAlXiY0ARbJhDt5nroLo=;
 b=IW7QHNxvwXYY5FrfkBOjQyTWzMRtxURwMeH2UuXOOHS2knQihQTPAkFn8Rfn+REZsWi5rHIK/jA2WThGEqt0lhAj2sY+awaT7VG2DazY3ilaeqv1MnV9KBllpoCVga2fOAgZ8ZFP8dmkaTgLBOkW69ZrEcL6n3HCaBRWLJXO5/Q=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7430.namprd04.prod.outlook.com (2603:10b6:510:18::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Tue, 29 Jun
 2021 09:14:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de%4]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 09:14:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v2] btrfs: zoned: remove fs_info->max_zone_append_size
Thread-Topic: [PATCH v2] btrfs: zoned: remove fs_info->max_zone_append_size
Thread-Index: AQHXbEyTtFQvRlqoQEGKBoNt5m0IBA==
Date:   Tue, 29 Jun 2021 09:14:10 +0000
Message-ID: <PH0PR04MB741606592F69DA989383A2C09B029@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <a7f717432896b5f12847435727838b32bd6e2b35.1624905177.git.johannes.thumshirn@wdc.com>
 <20210628202013.GG2610@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.88]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d346d240-ad77-4417-d03e-08d93ade41a4
x-ms-traffictypediagnostic: PH0PR04MB7430:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7430956E1583907C40C568AE9B029@PH0PR04MB7430.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q44Jjrw5eZdApqcNQUMGb0l5LO7wL2UHNIU0OV5TMrS7JA3EoMOyJzYqZk57UvLxNQU/dw4VZVJUlwd9gQTlV1pCwa86jCvPcnM1FjP7pBGnhe+bVwiNUZcIDXXZyzMKk86e5/xEHrbKQLDsxEmi+rg6R8J3RamsrDr8HpkS11BLdhDavLat5eDWzr6JESp20oy7HEPZ6HYFiQ8x34m3JgqaTyXt+ht2cu4dy1X9hq1iKU743Q1yABBSHZzhA/3VZKq6r2hU2Fm5ifYbO+MXklpp+4ddd4sP6zWyxjnxAPT9sP37rYbMBOrs7DYUgG/BgNAmigsnkkBnA036mix0cv+L7AGK0bgGN5mJVp7JdVnp7oJsqtOvun+U/4D17HXGF7oWI4Ag5iMBcSiwuGvbLN88bnJJDF6osvOwS79Sk6qYIRlx1C5fQoF20bgzs4TK6iNHC/BmceKohOFCBBgG07qFRyMY3cSHuBAOla2Z3+wM7FA0VVnvsjhbr+agdBUYGr017XQTcb8PQp9Iionh5oKIkTfNw8MoLqp6+uvnCe67tVRRfsYk3IIbqap6MqjYfSyTbh/H6T344n4xLxZF+66cMrdkTCoMxp3j9o2mX4Nt8S5sAfcHaF3XqvD7DW3Z2kDwJSbd87iWKTEQlKR4Xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(83380400001)(7696005)(53546011)(38100700002)(122000001)(55016002)(6506007)(6916009)(9686003)(316002)(54906003)(5660300002)(91956017)(76116006)(66556008)(64756008)(26005)(66446008)(66946007)(52536014)(71200400001)(66476007)(186003)(4744005)(86362001)(33656002)(478600001)(4326008)(2906002)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F1uyY92Uzjsm2vC+6GmKmJcMNd1lvmoPymWkM65IlsnKANa42oBdSiM26H78?=
 =?us-ascii?Q?psQ5dkngNNS9SS2j43x04z56KBfBRE/G0YZMHA8lfikEuIr/8lXvJ1j4HTrB?=
 =?us-ascii?Q?PXbBYpuujwY8sq4hGV7P7m4JCOtE6b9q/QtGPJj46tdSS9Zhzc8jhFr4sAza?=
 =?us-ascii?Q?8WJrQeGwxX0gwdNiEl3p3XjDsrNfYWPHzp+6bxw4DB3+0IXYopjo5Q4vx4gF?=
 =?us-ascii?Q?/ZXluDj9nTDBXZuhYE4e7TwiikJcwcBP2jdM5gX9otKDCOoL0kaKB8qpbhUt?=
 =?us-ascii?Q?8+h602ZJXfs8ApCR8wGAmgrTfTcM3ZBdEStssTD4ONBBteiqmUYKkNpxqzIX?=
 =?us-ascii?Q?/8K5/48v+agkXFXAOZ7nF4T/tDtV9gk8PzLetbDFFB7MMKe6KZFqG1NpALP8?=
 =?us-ascii?Q?1z0GbIfXC5Xp9ZdPeSxg/5nAJIw+K0SSUu96/DNHJ57j5xMJyCxeh8G2zIs7?=
 =?us-ascii?Q?WJpTlBn9Y9q39FXfKxuQi1h7D/gyPwkW+LHGEbprTtLYWea9yVeEBYMVJsiH?=
 =?us-ascii?Q?+EgBVOr2/8HVHagkHNh2xqNCHidqaGri2TY8Ht/oHHqUggm86azrnN0S7hW5?=
 =?us-ascii?Q?AivmtrgekHZz3wmWDAfaN6LKbD6wcZ+vUBLpzx7yzq3wWhRXZ4Mfwv2hdER2?=
 =?us-ascii?Q?krkJL0030tNwx9d5GTrflLDdDOAa02O6AqKxx6lUkgKcMIuvtxYA2zBWPNg1?=
 =?us-ascii?Q?elYwTnJkzGgEFgEWyCW25DIYdCB10gdKFSCImwivgJDlj6nmI1la9cQ/BO1y?=
 =?us-ascii?Q?cjX9eDlU/1XDl0fzzf27aSIhW5oMhRmT4s3ibW9MS2S/7G39k/7jOXiqk8I4?=
 =?us-ascii?Q?V1aQ/VY2tkL1YxjUSyhbmTNZaMkXY3Q1Zc6X01GXIEgDr3EZjsebfr5UB2Kh?=
 =?us-ascii?Q?EHUKA1x6B5Ed/LR070lUGmo+WMbHITZiMG+GEuCUdyYyMQ8Ui1m249V9sNI5?=
 =?us-ascii?Q?Gbp7bO7NTuM6y48IHXaeq7CRuER6La1yHDHgpP/O+T2pdq9uYFLeHj36VTJ9?=
 =?us-ascii?Q?/1rbAQj8lnfs0IbHfgh95wwOEW3kk5Z1hZ9nrA2bdnRMiSFrJwLJv8Hp8ad+?=
 =?us-ascii?Q?QpFDLAIAONToA708DFiyfVbz7VoHlYtB98Cu6j+D3dknoLGXoarYAp876mRk?=
 =?us-ascii?Q?oRaMvxq5wsVhZocezuZAIShPDh3H36eSqAslCGPL8PSSObjDESVDpWCoR6Ac?=
 =?us-ascii?Q?B2IGR9vRTGABAGBGpG3eeNecUgK8GGozTFx9crC6pAi0pZXd6XaoTdOUHd5m?=
 =?us-ascii?Q?64pQI0bsr/uUm0q/Vs/55kSyv+82H3ATHL1wuMT/4wk2M+DTrzEwEBClkrl4?=
 =?us-ascii?Q?rCwhUa9qUcmLeAaAmTOZ5F/0aNGDHfBSg++SC3H4q6CJnw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d346d240-ad77-4417-d03e-08d93ade41a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 09:14:10.7469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +3nydiSVzjLB27Gqdg9gYs6CEdoGGOcC/kL+P2b1WFUGELy9tnSC/XFeDJQ2YHaDFp90yfQUhAgCn58gQQcOKLG/01xtiAaWMUqNptPWDgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7430
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/06/2021 22:22, David Sterba wrote:=0A=
> On Tue, Jun 29, 2021 at 03:36:45AM +0900, Johannes Thumshirn wrote:=0A=
>> Remove fs_info->max_zone_append_size, it doesn't serve any purpose.=0A=
> Why was it added then? Commit 862931c76327 ("btrfs: introduce=0A=
> max_zone_append_size") states some reasons so you should explain why=0A=
> it's not needed now. It's a partial revert of the commit.=0A=
> =0A=
=0A=
There used to be a patch in the original series for zoned support which=0A=
limited the extent size to max_zone_append_size, but this patch has been=0A=
dropped from the series somewhere around v9 IIRC.=0A=
=0A=
We've decided to go the opposite round, instead of limiting extents in the=
=0A=
first place we split them before submission to comply with the device's=0A=
limits.=0A=
