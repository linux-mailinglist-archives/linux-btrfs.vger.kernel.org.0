Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7D65A0B87
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Aug 2022 10:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbiHYIbZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Aug 2022 04:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbiHYIbN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Aug 2022 04:31:13 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C107CA61E0
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Aug 2022 01:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661416271; x=1692952271;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Nr4lIE/NWSWvD4GJPRhpV5ldLNedXuz3lO/a44ajdGw=;
  b=I9mu14uwb/ADMmnOnmAQHhySksyVDKYb427grOX64v+DAuZ8kknZSRLJ
   MTXRVY4kTZ/gjVrsvitfjgggKJolQVFkGyKi82ITwtyiZeiiubPEBKdZZ
   PmTMpOLoP5KtPfBqDIEochd79NQvIlXURCfQ+jR5/Jwgfm84np0tz8MIP
   k83tCxnyHUednPQkwKrPOEc23q9x1tZvvMnSeSDd8fleWsByGl9SYgzSH
   FvnjsAk9ngXMg2HxBkfLjMR3yuBwWbBqZAeE8U3RzkqJsdgCewPgYgUcv
   vqOrm1EHzy7YqlXWVfrGPaVsw6xcLJ216sBr4GUSYcXuWeh+bmiz6KYi0
   g==;
X-IronPort-AV: E=Sophos;i="5.93,262,1654531200"; 
   d="scan'208";a="209618637"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2022 16:31:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6qRGp5KvsyXDVtNtQvyq+rLISYAhETy4AR9nc/aYu0372SjAAVb26FV6G3QhqPb7WaQezGfNbjOIsHFEinUkON0tRpElFnCnTWPcdzDtbtH2DhZTKXgYTUh2asNrZuzxfZzhTlt1mxo4PJVyw1ylkCuKMUqBS0hagwk5HjbuPLKXfD/sotpTM0mpA06/zRFoQR/kPDHBjnS/Z5Ri1PT2eFZ9ghp7bAMJPP6OvgETUtrqD+g38iY+5QqZCxgWfAxoZo+RCVpEeYYaD7C3dfqVKxdOF6CasXmuceeE98vSPd/Bn3cvRa1GaVn4SN2fHn2qjUQyO0pWHlX3VKhjaCi3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6+xBeA79o593fDWEE4YtWGJ8S/RR8Gj8QRINPUUgLE=;
 b=XWhukjRhRrJQeD+S0xPgEYE8Xx1J5eTvWAu8luPhW43UDPt1IKOFeHJQTavXxYPNZ1qZIarI04kcAzyKpLpQB3gy7drki58vALwFxRJvSsxl+QjVkS44z01M3kk8mLQkxmrFPOa0VU3fk+N5XHXpkzY6wuJoHFBAZIIClKOFAfvsXaiH0x2B8ldTVFziU2ayb8cx86Amil6a6XRDclXdeOyzIpBdJJNYNaFasulitqPd/r3BmfKBXwD6hrzJaLNu2iRHeprk/vIByteVQZnix72uagMgM4JTFrKOErxmxI8Hmgoy/ioXvgkwamjwZkMBJcmJy8mLn2pRGVVHKb9F+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6+xBeA79o593fDWEE4YtWGJ8S/RR8Gj8QRINPUUgLE=;
 b=PivDQCIsJPz7a0SI1oR+pUPuNyJ0Kc5L7EpKEoOXbnRerI8g1fWMN6mUn+U/m+AL5+jd2u+hOGZyZdmzNGewUOc/4PxHBPqUB93m+hvvWBuQsN/b2xhYudChZ3xcoXxLki0awUrA83oI1ziVOT5f+yKVU2bpeXIc3EtBAM1h1TM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB5903.namprd04.prod.outlook.com (2603:10b6:208:a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.20; Thu, 25 Aug
 2022 08:31:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%6]) with mapi id 15.20.5546.023; Thu, 25 Aug 2022
 08:31:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Li Zhang <zhanglikernel@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] Make btrfs_prepare_device parallel during mkfs.btrfs
Thread-Topic: [PATCH] Make btrfs_prepare_device parallel during mkfs.btrfs
Thread-Index: AQHYt9NpDkp3mThM6UqLJhTeMttUdQ==
Date:   Thu, 25 Aug 2022 08:31:06 +0000
Message-ID: <PH0PR04MB7416B660C501F73F47E7D4159B729@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <1661357103-22735-1-git-send-email-zhanglikernel@gmail.com>
 <c3dc352c-8393-c564-4366-42fb9ece021e@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05d07bf9-221f-44ae-abdd-08da86742762
x-ms-traffictypediagnostic: MN2PR04MB5903:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: arI+Eze4LOZwOh8g8GRB/W8bmeKd4bbGLwwkZxCHFMgJGPSE+M6X6CY2bkocUJLl9J1JXRh5LWao5lwKPIUTq8SsmJ6FsCpkVKkJpgm/fKUqqIjP0COH3zItujsaeBPyqqbApvYawphbYWRouG8JPqsSVij5p4P0M2zkMJG4m46OXEOzo3/yH+hgr/t0k8HMGU8Oth7CKELBNoyFzhdXdUDjGS8p4rp2+GYthRpCT9l5gcAmgax1XSgC25lpteL0OeZY9IzpMJupF5V2ADfTOKb5gV5FnlHjarlc8to2cG0c7rraJQcDN1/457Yt+L/J+FRe0SHNatZPYdsi7SI2P/yHEwwX+YG2a9GiXfn5nlhV1yByUmbM77rqmTtej3R1CcJmtM73WmsVQghjfdYoOHU0AB+u4qb16UCiBrEfRAltCt7WP1rGNPOEfOUjfQp6S7Mfw/P9V1HNzW+KFWZcIn1nnSPkrs6F3bU9ANsf0mfNx2PRHpbBQ8m2LPEMYsvKGnxhNQZ4ymaGSB4DnjsZg1c81l8q29XdCejDurcEwOtqcVZBRJoQyW/d7ZmJ7a2357fIWBg4INwJi33byx/CuEsldcB8MYl0+2cTar2FjuFt7E1sLs7FXtUUvfcXy7RvuZcRpg6IQT+tym2ji7iNA4CcDdHOMZeliRWDhQPvMmlghfH0+XlQ4Nl4k6CSXtX3xCtbLqyMNSXjEsYodGtphwBT/kFdR1DJ7sEWRlgdCkLlf3alSLQ7PK8wtvfAKUgavxalI+vLl75+OWjaNd65bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(55016003)(82960400001)(86362001)(33656002)(38100700002)(122000001)(52536014)(38070700005)(26005)(316002)(8936002)(71200400001)(9686003)(53546011)(91956017)(76116006)(66946007)(66446008)(8676002)(5660300002)(4744005)(64756008)(66476007)(66556008)(186003)(110136005)(41300700001)(6506007)(7696005)(2906002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A7kv0/4CugMiClkVufDzSFgvPxvuMsP7y1OXZvfBxAia3XH73zHrB1/nqDka?=
 =?us-ascii?Q?NfywsSwASotfc2zwBcqZ4hoAwA3oqxWicGBFWj5bSlEybiYH9srGhCPZF0BS?=
 =?us-ascii?Q?MX/BfUpEyMjTvqJlH7UKLpNJ6l3vORXRToUS9HIM4r7iFEF+se+BUsBKJvv7?=
 =?us-ascii?Q?Gmooz932tWY0rS3dD4nOT7RFZgizaCOwrwlzdDABIrdISsgFqc7F0n7SQ2mH?=
 =?us-ascii?Q?1lpCdo1LRM9bfnsUAOr/AtP9o6r11jL4veP1WmQqYb23rbJCx++uDdsBOxlI?=
 =?us-ascii?Q?rpb98T0hn6CjKMX/XsAiL7DeNLEIjmXBFU1IisOC8cCz4Oinuqs1hUeOib8n?=
 =?us-ascii?Q?bIlPLNS1sMVJCIPlcALYiCTkrb0Q76A5ElGVkekSS9cmcf7AymdH2oQRyODB?=
 =?us-ascii?Q?oW4J6nYqOmB5Ywq0Hmi6skfLUc9ZCatyCIRanEOIkSt+/D9MvWGCuLyGB11S?=
 =?us-ascii?Q?WXSFHoJFyMR2YewdwO6FGEH9q+gtgty0tnOjeIRfinvV+gfs3PCKSH7xK1u+?=
 =?us-ascii?Q?p6AHn5XE5twUtSxBTvA979Io4vREHzS+RUcczb1bEJtgVaZXTNynURMOO6cD?=
 =?us-ascii?Q?qE3ZzUHel+NynA1f22U/0VU1awNxOAnD251/7PssLksKpk5r0KOy5HQUkV0w?=
 =?us-ascii?Q?LJs2wlW3vNwP++nNw9IMZHq+fssOQ9vxzJ9zifpnlzWcxKLeEm8RNxkoc5i6?=
 =?us-ascii?Q?JNOPNLongy4JsG8ULsU/lf3hWF5dRy60csHK91doQUJwjYK5ufoHo4/m+khl?=
 =?us-ascii?Q?B1uQh5V/aN7FtLRpzypPxUorLfJjL7BQes9PYL0etm0UXhFZz66KmSTfzsvv?=
 =?us-ascii?Q?bDACaotpHALZ9ysPbSWCOnrprGn6UVd+Q4GcQbYhVoRGCoHZFDisFFbo3d/i?=
 =?us-ascii?Q?6+kZFYbIDytDeUciWgeq4FTZUji3QYTuekkPSMEFsQFR2cmuWXfbsNE38iFJ?=
 =?us-ascii?Q?zeLPiEA7+mPprhvPeeQ7P9NxnvwxxO2cxvvLMAOli2kpjCYpj6ehKDLEU9dv?=
 =?us-ascii?Q?FFyvJoqd6+fpCxK50R5GOlUaTV8hbpPTQoMUxfiShNMKSZofA77pizGh0Wsq?=
 =?us-ascii?Q?/kTNstp8N1Cfau6spRcaABLYYuP8ombaSd+mWyVXP+XgwkMRQO9jnrYIA5fj?=
 =?us-ascii?Q?PmJzZH1lDETd+c9FNYoc2lcShJt2OsG1VT/6G+atS/Yf1Gc2EPapvbaZT6nA?=
 =?us-ascii?Q?wZFrh0IfExEceUAI91lBO3LzHPxT/g/mY5EfrGK+ILPtbkopmMjNSO7Z52vv?=
 =?us-ascii?Q?XXFGvR9C3JSgI1eblBJl7LyT7g/+20f/w0T29d5kAz7fay+Ia+K1HqBopWAa?=
 =?us-ascii?Q?U7KsJ2gnvriimliH2LpREi8SrvnQCGSs9TjC9B4ETOW7hL412TnsG5/2ombF?=
 =?us-ascii?Q?SsmU8kkRzFiOE3TJoarD8d+JTESyWwfvOfnuo7vACVNS8agD+6/fnrRL2GcM?=
 =?us-ascii?Q?NcEArhQj4giT2tnkSpH8ywC8MV+sjSpsZQYLwZHEASFu6eYCT8IxgHZXbWhH?=
 =?us-ascii?Q?ijoPHCMlKpA+TtAbwcDWY6rO4CpjcAzvky+YEJAmfOKtarFgQEUf3wYGa7G4?=
 =?us-ascii?Q?KHdmUsmB6WL2HjXAIfvCD0NwX376vgTw8p+zTAizqmfKfjOJsCUYzfFegTjt?=
 =?us-ascii?Q?+A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d07bf9-221f-44ae-abdd-08da86742762
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 08:31:06.0827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FmsjY7FfluNhrJBU0lY5q89pG3Vq2Zhj7RvsfCE2+SuyfgVaRcyrU8TL28JwEAhv5Lo7hEvnFv9wFeh3JrJNKAJHFJza4YqR6PWZB4644ao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5903
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25.08.22 07:20, Qu Wenruo wrote:=0A=
>> +			if (zoned && zoned_model(file) =3D=3D ZONED_HOST_MANAGED)=0A=
>> +				prepare_ctx[i].oflags =3D O_RDWR | O_DIRECT;=0A=
> Do we need to treat the initial and other devices differently?=0A=
> =0A=
> Can't we use the same flags for all devices?=0A=
> =0A=
> =0A=
=0A=
Yep we need to have the same flags for all devices. Otherwise only=0A=
device 0 will be opened with O_DIRECT, in case of a host-managed one and=0A=
the subsequent will be opened without O_DIRECT causing mkfs to fail.=0A=
