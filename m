Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8112D57457E
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 09:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbiGNHIi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 03:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbiGNHIg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 03:08:36 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD482180
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 00:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657782515; x=1689318515;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=y7b9ExStAiF8kXKQbjnAUmtbk37Znkh4CNopDdabGVQ=;
  b=G6E4OS6QrhCg62W6JkojyEXVtTGcEu/c3JSOE//wGxaPnhU9+3VegW7c
   Bmljlhi41EfgkYqjeQ50tLIiOQuYklMilVO7jnVR9ffqoONbRpXVKXyCu
   Bl5p/uYhO1OzlwoOvhLmyoO72SiLxpGbxj6xnzfRPT1v17rBdNm7cQD/Z
   YFih/6kkCkNoYypRkswzOFvOZlbeOmkaNkw71uE8AWnhl/b5VuEwN2Zea
   0GaabxveI/bZoQ1bGj9IAv3LtrzZcw5z7ZVjFY3QOQ/EsomsCfiEg272b
   FkOq6hk67vgDFPpIvzXRm8vcrxSixQ3/EUlgmOP9YoFQdbArXmpz5yT8k
   g==;
X-IronPort-AV: E=Sophos;i="5.92,269,1650902400"; 
   d="scan'208";a="206383390"
Received: from mail-bn1nam07lp2043.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.43])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2022 15:08:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqWtaJUc63Xm/wxVfcptSUn3Co24sApP4wUMfajVVFh5aA/mPRyVTz57ZNipSd0meho85qb8V9S8rd5E4Yc27G6q1XccfSaCWqzPV6wuyk34Ru1DcvT+8v7VEr1Ehd7fCrp7vYkCt+y2uXnrx9n7D54m68L24HPPxeYLFZ5AMP0zlu71BmzjA4xeyL9mmuplBx9LXMvj34AeVJQobnn+ay/jNGJlukCYWcXrx7QNLDjGdzb4RicumoU5Ynx6grspBafNe3VXgX2WRnTnsfKyqOcZQCX96BlKw9K/aTfHA55OEdhT/3GeozqZJ33JiMxKO2O+m1iUpRYpU6bR273qbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynw2t/Y8KBMD2nM0wd1JMTdaKqHjlh2ZAOyhD5csrvY=;
 b=ZJ7woaCWcaeSJDw8XI40vOU+4Ygdsne3Ve/IR7btbb5em1gD/gsxhCRn+2lwq1EntvCB5z61Q0wl/7e9ko8NLs7W3Ybn9EMvCR2zGR5EOgHuylpqHzGXsxgVH7oC+LQCWOs1BKzeu7te+cms3IgusO7QnmQAghMgTUJgR8tZAEN4TEBXnZ8b5GPMLx+3dwsOQ0jQCRz8t/StdVz2ORG28OWZO8mQZx+xF4xLYHm6RHOkW4IndCEw0NYpOoOizfOF7nfN4WwgNQb4vxqddM1u4F6a7mlIdBvjtoOU3T2KKazIYe/oq8woyFUDWwJU9GPqhQJMAl2lGUxNjStEohaOOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynw2t/Y8KBMD2nM0wd1JMTdaKqHjlh2ZAOyhD5csrvY=;
 b=ena+BUBegIh8SKgcMjVR60UK5wCnpil/7AWHlIrYrrn/ibCrphdRhTweHDAXv6WcieiXOdsqEkcspwxJZkFieAeuyqoVMJ/j0/ejXDXf+CEKNkJIUwYcfkzBKDLCAjs7dYNjalCPR121LHiTe2+6veun9coc5phmHTUVM2QCxFY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MWHPR0401MB3545.namprd04.prod.outlook.com (2603:10b6:301:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Thu, 14 Jul
 2022 07:08:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%7]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 07:08:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
Thread-Topic: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8]
 btrfs: introduce raid-stripe-tree")
Thread-Index: AQHYlqb43VRMNwcKo02MAxAIJIVEbQ==
Date:   Thu, 14 Jul 2022 07:08:27 +0000
Message-ID: <PH0PR04MB7416E68375C1C27C33D347119B889@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <78daa7e4-7c88-d6c0-ccaa-fb148baf7bc8@gmx.com>
 <PH0PR04MB74164213B5F136059236B78C9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <03630cb7-e637-3375-37c6-d0eb8546c958@gmx.com>
 <PH0PR04MB7416D257F7B349FC754E30169B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <1cf403d4-46a7-b122-96cf-bd1307829e5b@gmx.com>
 <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <96da9455-f30d-b3fc-522b-7cbd08ad3358@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2cfbb745-6a48-4ba6-e1bd-08da6567a65d
x-ms-traffictypediagnostic: MWHPR0401MB3545:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aVr3xAN6nPHGoxNXeSOwRcjKbfx/v5SPyBVdWTJ0Q9aaT9IB3D7mzGKir8ZXFjkHB0fOkPEEMGg2Jy2HhdM+5AEGPG9EK5W+WKYHMtANsoIE1i+5sPnNYgYVk0DEd5Lg0vs4hQFwQARyR3DgqFPat0E4rydk31BJMD96kpjnfuHvSH8x+UyDAK3BKdH3tjyGiNoSH3wf1UwEoSOiaQR2tPMw0ICpR/8pK+9PcvCcW5EQjVNODnPbcyurkg8AWwB9tvGvKRsS8Il9KAdiusR5EvwXtbDrTWloqGxR8jCrDBDu0DxMIZwN+4kvp8hDGB90iMu++Q80T5DaRrgwu9gB5OoNuVJttf93tREth7ROJq0EQChPpwEl9t2dGt+cVM6HqhWkfHKwgpW6NeyVP2fgmGYf1vQAt11D0LNcR16uTA93p3KQdTs/FENGEcFhm6xezVX7c3+El5Cuu0IO+f4vcnYeBHaNIkMG810eaRfxeiR6Dc7PILrnwF16dRpgNisgRvPLAZyA3Y0uZWgGq6cOJaaNc8CTM6kkevc33n4G0zvgRnJBAiDFEkJw1Ay2lcwtH9yar0deUC7i305A6wmTM6xFryJZiut3Sc8Suj/Er8TxDP57EDmR4Tfn9mM35VFiSfDe6iK3JsbMZFoK1Vtuj50xronru9X1DLl9MOrcr/t9BDScGHe+TxUw1XDyyOqB3oyCXdPAj/edyQ7dMYO3gL5Kc/oZnxTYE0c2lXVRZMd6lM95lU5G/C9YSeETm3HM/nngz0Q14xVbUUbZWcWr9JDlMbaYaecJSUw+ZsISgX0r/9iAiyGV86o07Ox7sTT8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(2906002)(41300700001)(55016003)(6506007)(52536014)(83380400001)(9686003)(66946007)(38070700005)(71200400001)(186003)(82960400001)(66556008)(7696005)(8936002)(66476007)(76116006)(64756008)(91956017)(38100700002)(86362001)(66446008)(316002)(8676002)(478600001)(5660300002)(33656002)(110136005)(26005)(122000001)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lUYmFzLsPlrJrrHyV7MzYiwdQnBCCJG2y0FcwKkX3US9g7hMhFG7XKlI1kx9?=
 =?us-ascii?Q?KuP6bZm3QEJsZocZ/XAeXLh1ZZ3i4pvpiVrB4sVcZSZFqseBy1Qo+gMiOth3?=
 =?us-ascii?Q?lnh4sdG30M5CcZoNeeeijCMHNCq2gPR3L6zBPuVW8mlhIJ/fdU55nnuV2Ey6?=
 =?us-ascii?Q?L1DR6jrVERC4Sj9JXE9gJqLvc2yzNxiZ1Mp4s/tkq2rPZror8ixLJvaY7/9n?=
 =?us-ascii?Q?FcmSlBUXn6EEfi0qdOyTrL6fbdgqS2eQxKDReyyB6xvBvG6R8J920ZV+IBZN?=
 =?us-ascii?Q?HZ8HV39YrbXORil85IcrG+z0Rm5rPR7jX+KL04HDX8VU1QgrIqkougOZyMP9?=
 =?us-ascii?Q?pxdnVrkVQKbeD2DchYwKO1CtPW0XmdnjVcZd9Q3ec37HHa3k90xSnLUZv54t?=
 =?us-ascii?Q?Pg3DorAIspN2n4qHNpKxwiJWIOcI42/N8edG9SZdShl3A0zCB/+2JA2YFSpp?=
 =?us-ascii?Q?AMowZF3PfAVfywtka8MYSqMJUluTtvEx+mMNk+e/JJMxKHGNDEMAluzkCwLS?=
 =?us-ascii?Q?5bd6WZ43Jm9pHODo/N9NdLZjc1Fh0fC5wjdHLI+5LO/8eKRZfSuuL638A88U?=
 =?us-ascii?Q?rpzbLciddN/LUWE3gJ2+SQPlULGtQWzWxWc8/6UtvlQhPB4Xv2dqENuNuLM9?=
 =?us-ascii?Q?ICQENNuhdn7AQK2c63EKhwcZBQDceNLtHS36f/6GNdimMJxtQtQCl6S/6hOm?=
 =?us-ascii?Q?WTq+O2Y2D5e3mcNzVn5U1w/dLrN7azIbkNX5AvPSUKJNEgy2qZwGMbTVoOVV?=
 =?us-ascii?Q?37Zim6YgcKsfuXN6pnKkKVyMQjmw0m3Z7YCwTLvl7+OWecDNvWaOG0ZtGCli?=
 =?us-ascii?Q?sYU7uC3POzz7Qp6AdL3DFD9zMYbQ8GZzETkIQxxX2EwKbtyWVb9DfhCk7/NY?=
 =?us-ascii?Q?yisA5WeO5dbSscQ+fsGllOvQjk+VQpX6oUZMAt5AT4uiBKsFwfx6MRSK3R4s?=
 =?us-ascii?Q?5qaahDv++f4gitRIf7Em0Ns1nahTebzySoXOq9MAByQW0FL2GdkTq9SwGOgt?=
 =?us-ascii?Q?tDlPLs7vPW5fSz0CjKeY/VZIZSMJfmJud517o7+hrGodcTvl9dxknM0XIslX?=
 =?us-ascii?Q?epmWZQbRp0+4NK0Gvr0JjaZnzr7JytqBzg87r+kU59fIgwWTbhfgaswlmZbk?=
 =?us-ascii?Q?CkFyikDoOkxY7zA/JtK8XR55Dz7P1wu5O29MYpVtzaL0YJOaK7AajI/XrG4A?=
 =?us-ascii?Q?Hf3AHhkVWYj/1oZhQgt5PmZq7tNBkbEm9gHSkSjq6P1QKOeFVMaQgDGIzA3W?=
 =?us-ascii?Q?YxKqOQ7liZhDi4cOTIq9490OCSMK7XWc0Z0mtCKx9PdJYZMdhQKUnQHqyh3D?=
 =?us-ascii?Q?4S4wgfzO0N1zvnSa8wvfE9kaaK19Mxp7qzL39Yw0XDDluy4RWcnpH/z2w+1u?=
 =?us-ascii?Q?v7UQ5JqeWHKkjP7+ay2LeRgp3UVIbnQ8uAdjKtpqOwVeNFANDtwiRQlxGIbC?=
 =?us-ascii?Q?sySBdN8hKGpCU00Kr79t+w+TdBMyuOvP1aOl0laE5mAAjs6DKYSsQ9yijlhs?=
 =?us-ascii?Q?IkxtHaBbvDRmn5dY4rhZFrxNO4O/li29jEtcCYCBgeEfgzSCQwYOmjGdSJ28?=
 =?us-ascii?Q?u4c4PPzGxq49vfocFHiCiwEUPXYTHxDvxxgAix4DFNn/28giuOBn0zcaz0PW?=
 =?us-ascii?Q?++MC1IBm1GnXQFaWjXJbX38=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfbb745-6a48-4ba6-e1bd-08da6567a65d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 07:08:27.3397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5PtkWhQxlg3q33PUe52mqgx9vP5Xaw9+oispBXtwF+06o/JsR3LMs5UZlPSM++BnSDF71J3khS6Nm8mXZOwA0s5tqxebN3mYAsYvGhknFBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0401MB3545
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14.07.22 03:08, Qu Wenruo wrote:> [CASE 2 CURRENT WRITE ORDER, PADDING> =
No difference than case 1, just when we have finished sector 7, all > zones=
 are exhausted.>> Total written bytes: 64K> Expected written bytes: 128K (n=
r_data * 64K)> Efficiency:	1 / nr_data.> =0A=
I'm sorry but I have to disagree.=0A=
If we're writing less than 64k, everything beyond these 64k will get filled=
 up with 0=0A=
=0A=
       0                               64K=0A=
Disk 1 | D1| 0 | 0 | 0 | 0 | 0 | 0 | 0 | (Data stripe)=0A=
Disk 2 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | (Data stripe)=0A=
Disk 3 | P | P | P | P | P | P | P | P | (Parity stripe)=0A=
=0A=
So the next write (the CoW) will then be:=0A=
=0A=
      64k                              128K=0A=
Disk 1 | D1| 0 | 0 | 0 | 0 | 0 | 0 | 0 | (Data stripe)=0A=
Disk 2 | D2| 0 | 0 | 0 | 0 | 0 | 0 | 0 | (Data stripe)=0A=
Disk 3 | P'| P'| P'| P'| P'| P'| P'| P'| (Parity stripe)=0A=
=0A=
For zoned we can play this game zone_size/stripe_size times, which on a typ=
ical=0A=
SMR HDD would be:=0A=
=0A=
126M/64k =3D 4096 times until you fill up a zone.=0A=
=0A=
I.e. if you do stupid things you get stupid results. C'est la vie.=0A=
=0A=
