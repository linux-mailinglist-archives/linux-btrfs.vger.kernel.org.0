Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1621456C24
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Nov 2021 10:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhKSJNp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Nov 2021 04:13:45 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:24438 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhKSJNo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Nov 2021 04:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637313040; x=1668849040;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=dqFs6uBJs2ys9eaEhqflnmuwEkbwdQ9YZdqZ5oMY0YqJGyoSiFrILfS3
   mjvP8yIbfZ0KurTHf9dPGcyn3b/vKNnx2pNvDuOtN53GEYgarqZQar5IT
   gOMYsSRvHIGwK3saDRiyjVOqoGFwTQzn/YOWPmhO8I+uDoJw2uq0+8VtT
   S7vOHGe9kA6vj+a3KniwbXNfmOvjQHSDgalY/ivM9v4l89ccQ6BluBf7p
   Zr/cQTA6XirjvmCRiAaNsg5O4qFdh4gObOkNgjNLbKUr6WqWjR60G9cS+
   7K4IkwJlrUpHgzASNQEXQlvZSOykuj6vmmH13bDyPCTs2NIhCgEz1S9AI
   w==;
X-IronPort-AV: E=Sophos;i="5.87,246,1631548800"; 
   d="scan'208";a="190883028"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2021 16:36:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQDROQ+7NPRhWdo9XIQPJgJ3Tmcl+UZefd37TIOXD4T8wPHDih/4Rb3gCUhGdWUIKElherG8cwUqOyYNIVPm2XxR8tnJac/CQ695wXZ+CJCLrruQ41a5Q8phc9bWAfN5AbGzR/ruwOkhKMlFs/XgjRNWrR9GKutRwWKCihdKomf44KViyMj74XULw5qvh1kqnNzqXyTR4joIiwByGuxfUjwnWbIwbKrJYsqFnREmKdY8cvUlzl3fRdv4mkc0Kqdr2Q/NFUnylzDgfzT2shCg05KWY1Fv2gS53NFELkbJirkY+Ni5quJXhRLdKTY80k21TjVxjJy1vGbpCBHpxAgxWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=IlIy0ouWwMwZZUvvUm7VGkfYTyxVsU0mb8D/uad83lJ/8gHWuQJ2v0RfN3iVWDfoduU7im3xicmKaZd+09HNdRRhU2ykj0ev+Sg2WrAjW5fvmyvOnQvxCAxXuwE6o4o1HQPGGKjpoZeS6AaLveCWU60oy7M6xUWncwKFL2/BYHFDGm77h+o7HwkIDEOOFX5VC0ZUf1/PB8sOtKVtm9uUeZmwE9M/Y6BCxrVaxQRa6NbhlEwEl9ske72quK98EpL8D+fgXVk6cd26JoPbD9+KWTQxr2+76xl8+CnxqM1697gbbR6PgaQthfTPhjmdWMTb8NK+Df7mJTa2ufBkvQR/tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=tlNZ/0+H4I51lLhnVkViHjZqf8jM7UoU6M7JnsQpc7A7c7typBUThiKQDDbanfC38kZgwbrruR5XyPB71OYbPa2ntNuxDLWjqCPROGTh4JpDzznRTu601ov88H11Xje+juid5N+ByrxAzVQlMxh77LMWUVAIx6Dyl6nNgaQnS9s=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7446.namprd04.prod.outlook.com (2603:10b6:510:18::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 08:37:56 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c%4]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 08:37:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: don't bother stripe length if the profile is not
 stripe based
Thread-Topic: [PATCH] btrfs: don't bother stripe length if the profile is not
 stripe based
Thread-Index: AQHX3Q15QpeQ3ijqB0yZWQKTDwCM1A==
Date:   Fri, 19 Nov 2021 08:37:56 +0000
Message-ID: <PH0PR04MB7416E1243F9012253D3044409B9C9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20211119061933.13560-1-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9475afd9-1b77-4e22-1872-08d9ab37e28d
x-ms-traffictypediagnostic: PH0PR04MB7446:
x-microsoft-antispam-prvs: <PH0PR04MB744671A2D3FB46EE41F342CF9B9C9@PH0PR04MB7446.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7EYDeM68sU1ootNWW5LOsHWLrBs/m2RVCwnLEQjWuQoHfjXTIPpC2VMWBwZlkOjHfpmiZHluOuwLUvbEgbrIeP0PbBCF9zFj12Gg91hii2Yn4c18t3EhSHPBfrA2dZ5I7SZf2z3+4tuVlehEu/sYkj/7hOU9FSV4IbXAzSNXeCzMLf3qn/ARbcmeCagXUETo2R+xY/Vnot7kP2avP4zb3ZzYMjJdx7/SNw1UHPJKPkDyLmbUwbffbn9uhIEmpHmLumG/GQ8V9367P7TgTJxY5n1RF2EYaj5R3gjyT7h4r72QGiJhSTKX3AaOqhnQ9lNSAZD4O3GScxNphzoPF80gJBPnBWhf0OeD86w7Xs4DEnyRMzb5dkcOymxiXVeSSqkB/3FbseNrLb8no//uEdARzyYmyLIaE4tvYY6Hp+v4sGqqJizoXqTsRtB8Yrl925xDOyFYqfYzGn4NbLzYeHqo5aXrYBAXiCi478MkE0OslNeVKE/iwGl0NSQ7/V9m8Q42t7s/FCvl8HjR2ZY8XCNNX4tQMNCBNempVxy6uoZJInHX3YKBxKTDt04Aohs4r0vrN6285NmwN7aYK7eqnnBNI0zTPL70krcAUUhujQmM1JRWkyGq/nkeY1lu6m24lcRaJOSbYKtQrE+77+GP7remkyQefQXlDBDlA2lQVFO0I78m+e2pDfV/QPxt07do7NJgBmEVfJxP186PJWaMU6nuEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(38100700002)(8676002)(5660300002)(122000001)(4270600006)(186003)(38070700005)(66476007)(2906002)(316002)(52536014)(19618925003)(9686003)(6506007)(71200400001)(110136005)(86362001)(82960400001)(8936002)(55016002)(558084003)(64756008)(66446008)(66556008)(7696005)(66946007)(91956017)(76116006)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tgF9ZSHTXvrJMYdM5SeHZAWYR51rgFTwajGBVj/N/3L2UWJT4dJwZ3tjOwOA?=
 =?us-ascii?Q?2/gBOieRmZbtEZKP0sdHcRusrRUyZq/EmkrVmGk/tvSYV6ukmv5ArCTo0UyZ?=
 =?us-ascii?Q?LzdFpGafv+5A+agZBuBRuXGAU1cGy4/72dtV3Uxj6vYkoCLEJuw/I2y5S7vV?=
 =?us-ascii?Q?ilH4Na74hg+CA8XHEFPb5j1Y5qVLbfXjzfO+jVegNRx3LawLXfkMaYNCOI3r?=
 =?us-ascii?Q?1KIEb9FEQxf+fNTn0VTbVqtNYTcjD4KwQPiI0/gS4twFw3zyb/qYcBG5bmGe?=
 =?us-ascii?Q?V5Fk1U0suiq+4wh17/JGmFz6OR8LorvQx/EzB9tVnSYN0O1IS87pBo34FLCW?=
 =?us-ascii?Q?YjYf8+UvIFuBOhCLlmrBmRuT9xqMVyQu1MdfpfVbA2FlOx83xKKQawZUWGC+?=
 =?us-ascii?Q?87le78qNv1l2jjbWTJoDyNPFEjo8MyVMsWBZ/y2fY8PFkeAjJ2fAsdfnqbF/?=
 =?us-ascii?Q?Bwi1AUVNY3MbQ00VfrfqQkvpusK4pcVI5KT/CNLPL0hbT1AmkGj/R4A6F/3g?=
 =?us-ascii?Q?H1X3kwXp7EEYiTJpK7wwgWbBw/gf+nBfDSPtYcQBrCuyS7U1h751ZYIU4Q4q?=
 =?us-ascii?Q?jc06dyr0G/eKXJ74gg69cKG7FuaLN15t6Uqcp3NTPDKblE/Mjau+T0ytE1QF?=
 =?us-ascii?Q?X4hG05aYR9MWAYKFT4LQQSlR48S+bsouXHjnQEk5SbcgFU4IcChtzRifBt6h?=
 =?us-ascii?Q?Imeb7S3ofBVVcDjq/YawZmh/+4Y5ZuO/gUGQjHy0BCLWUdH/rQ846jt8SO6L?=
 =?us-ascii?Q?gwO8mQuBsj8js++aXixiRfcXujhZtv5YkRjGTjNgG6CS/raGGWugB0hTZ2BR?=
 =?us-ascii?Q?J2ePf1pxzg7f/2YBNvK5RPauPf8iCcr0OmIUfBXol7ZBVL+P6+bo+Q41kPI2?=
 =?us-ascii?Q?h2Sq0i36YLERy+CtjfLJR8JChNztqmhSXHP3p3JH6mE64vU2YZA3RuyzMcl2?=
 =?us-ascii?Q?Dr9zWCBHpT65SHf1Z66lNcZxWIUdErZYncznaZaUSE1y/QXqVrVL5VyY2dpc?=
 =?us-ascii?Q?nqfP93fJzLa/HKUl6PjZHmgUrgML1nF8BePBmzSu2YjGSwFSdTqjjfqMbKqQ?=
 =?us-ascii?Q?vox103TDI1ygs+iqjiL7J+uTddnxk4iCPOXA4LrZF0TrW0pgqs8z+VSNd+nY?=
 =?us-ascii?Q?tZUwacKsFkqcb6FpjUP+r0m1fK095oHnmVbDJ+jWAGqWuPd4OFpKsHS8z9DH?=
 =?us-ascii?Q?6VHQqy1HKIGCzvP28oyUaAI0LQlkkognE/eAeMLs0zzodU4gxHBZsC22Q82I?=
 =?us-ascii?Q?kxhzQqB58gYb6nc+LrQdvWu8BacyQ0OucZcp3T+zd3V+fBIlYQ8wczZ+ndb1?=
 =?us-ascii?Q?Mmk3CyCyUXELZAFxWwQUQUTpRxetdpm8SZFWHIe3BmlomHP+F2LgYvPgCMwu?=
 =?us-ascii?Q?csV+4tnScI4A4es28UoCMJR4DI9fc9wdtZHIu2ezdaG9zNzCRHEdSkwRZ7QZ?=
 =?us-ascii?Q?eEBQw4sEapZQMdSgH+oF8Qfdxkw7oeQkDno1kkMHOWGUWNxk3M2AoXlgXYup?=
 =?us-ascii?Q?uCps+brVIIzuu16RQyDVUUGcGXYbOTSpb9YZWeKJPKpUfpVprg5YWJBACb4c?=
 =?us-ascii?Q?SqwBvtHDime/czUjkMcruOue0d/tsxsRWJ+SwEHbZMkIwe2/Kpfxl/DMPnz7?=
 =?us-ascii?Q?Uo6O8QQolwxLg9a9xn9BOwF8C3zz4yCegVRlWBYz238wZTE0XcXJgwkQxI25?=
 =?us-ascii?Q?90e4C80iT3a2Kn6abubefKezedl6ME7OrTs+dxq+e9+W2Lmvg00pWt5xiB3d?=
 =?us-ascii?Q?W496KMpTeUTzJ3puEf8Zeo562jd6QCE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9475afd9-1b77-4e22-1872-08d9ab37e28d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2021 08:37:56.0501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvwzilRGdAV0Jkqlg1je+86McT3GHe/owL8rVdmasGtjoRiw86D5h353p8+h6m6vXRT4lGl1OSqZMmVLeQdlOUPa4Zp71k/Kd/jD9LWL2T0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7446
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
