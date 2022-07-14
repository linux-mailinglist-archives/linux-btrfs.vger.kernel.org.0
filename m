Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7B05745C3
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 09:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbiGNHPg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 03:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237419AbiGNHPH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 03:15:07 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A1213E38
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 00:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657782905; x=1689318905;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Kclv1iiQcTAJ20OUBXMobT+JGCWDkKQ5z52fKFaH3Bcmsl7Xyb+M4KNx
   o1t3/t/ViNZNtjqIQM0zgTEGq9AfEliBDF44BUUbwxOzSLQn2RhPP0vwO
   /fYYXq1TjSvIDSMN69AZfJWyuXFoxgxkdfHdbuf1QT3La4kkJfQt6rCj+
   mkh1o25FUSu2C2ALpgCVU0ollRZvoOishHMHUoUglVLZ3q38IVcFaUhwp
   9V2dzVtLPn3/KrddgcVbl7C4/tWGufPKGT3cjd60Yc9DwxJhgdikPuk8L
   LhfeMW3SR0OcYkwGd1cR2TmHFt39v8f4Y6cQVKcwGtR0uqQCHBhYg/udu
   A==;
X-IronPort-AV: E=Sophos;i="5.92,269,1650902400"; 
   d="scan'208";a="310028043"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2022 15:15:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3HCrmp667/r6f1vxTvfjqwryKu5knBE8znQyRPV6+xMOhJ55/SEX3Q758KMbSqWgpaHJ6ufUwcTYLty7IdyN/8mJ2tN5NJwcl9CVaJp1ZZ4T3Z7GRVfkpNjW4/CKQj+0ejqIipp1isJJ6PGW6kmHVJB+nQjqwu+WnhX03sseeh0ocJOYmKv9bH7dRQSHrguwHigk4JLK/jyxtzUl3RNOYxVRfzguYpe77Fg2aV5J/3fEaLLopI6uykc1lv6hTN4aAkfpbXRmo5ylqi2tD340LdFkyfVnWvBxBkPHDD7hcAYxAVlysanbCKaGKisdmjmxrWQaKBpkxcrNdVJw1pDuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=m5Doz5GUY8Dci6g9gFPNUVm5nG15Qrg3pbpR442AdWgg/OSPoTWYp8PGuqRmgL7STbEKgCzIu0UGDS8XW3pFzn+nMCLP4ui+6wi9AzudjsJEx7kevFVV2YAKfkCYG/K0mUVz+2xh6yfRVqo5qQDtoF7XMjoynYki6J612/XQBMBmBq35l7OQnTiE1Sx4VodrC9hgw5ArLT6JbSt9dndGrfY07Av8p9O2JbQOcQ5GdSRE62wSBYCY2gTWwlVJVBRdmd1/hzL+UFw1tMRwHuSv18/Cx2ymA+oiqTp91NXOoFRd36hM6EnfsPONkC+zd+Bo2OkRUDCUvZVeeNO8IBGwkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=NA7UuOSTiNq4maCjdPv3X53fSd+CrnlF5A0Dvr/syLJhUrsXf905N6e/SEnuJ5vxURQs0+zGulsKmTaKsv4tzjQBtIBhvdMjuCLORgI+dWsfrTvGVD9HS+aiJ6sJ+7Ex9Vn/nGf8tr1ulBzAG5IUyyDhSGRbnMxsu3W4LUoh71o=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB8027.namprd04.prod.outlook.com (2603:10b6:208:346::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Thu, 14 Jul
 2022 07:15:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%7]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 07:15:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Wang Yugui <wangyugui@e16-tech.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: slience the sparse warn of rcu_string
Thread-Topic: [PATCH] btrfs: slience the sparse warn of rcu_string
Thread-Index: AQHYlx6q7REut5OQRUyAoFFHfDrN2A==
Date:   Thu, 14 Jul 2022 07:15:02 +0000
Message-ID: <PH0PR04MB741628A7C86DCF094A6187889B889@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220714011102.10544-1-wangyugui@e16-tech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76d1527e-d6a6-4d6d-8083-08da65689238
x-ms-traffictypediagnostic: BL3PR04MB8027:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hAmclRO+cn3XnR7zDaiyZr9leMS5TMApMurAMEHVoMP53qQaiyJmAv/P0jAg1NskKS+dOLiwkOrnK680gbtOgzAIc4W+ZoV92HVcxGpDK4HCkqRM8m2iepnyRppTw73QfSOnm8zX6mRgMocRujeTFcAnkRAk1jQxqeNkBgiVcLGwt2jDUndXFts9wfzxWo1rrOVqBTHQf9/6PWr0FkeOv7fqHZiiAFV+GIuXrFWW4jZFC5BZ9M9PTkGxxRfzcYsuGjkKmGacxC7oiXSnrkXhQtEDaD5O7Fij3FPYVdV/6EQ2DEqYhuH99nHZoeR6rZ6JS3A/bSQmvQ/cpJA7lUlRoIDX5MgIC2HIgbc0r4MhswhTxtix9NUaZK2pR+NmTLUT73s+87B9Q4wUdsDgPUQfCr0/7wT9l/0S/urHwlmEjgirTg6fjT4WouPdh3KMQdc3ftaIHYRiKIlaQ60fyM/PLmGlbjAqB/KWczOTtaWnB37jv6SwyHjQ2taMgr4RL2I24omkdOWUHrd/kOksun4L66aGuwEk3NjXlruDJFUwKPciPQQlnimCagpxRz50Xau6Pa5XElMGs+bcTaHP9bUxW2xSYxsPnIjwYx607kY4TaiZk3LU4Nr/XfsapBeNLF35NZ7A1wvXmEyEpSy/xwZ5EoXDtY4UmpAA//RX3VxkyWQOlehKSmMprWxjAJ8lF7Zxez5/ptX6rnPBfxsr5Yzf3V4+iXrZgrmCsTZqW7db+mKJhCkR7ezX0dLPIWTnDTKUz+Sir3cHw2/pVpbas4PNS6FbT1btn//hIiqpWO5X1tYFYKQuyTA9eLt8mHeudaXD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(76116006)(38100700002)(86362001)(41300700001)(4270600006)(6506007)(82960400001)(2906002)(19618925003)(122000001)(91956017)(38070700005)(186003)(7696005)(9686003)(64756008)(71200400001)(66446008)(558084003)(26005)(8676002)(5660300002)(55016003)(66946007)(110136005)(8936002)(478600001)(66556008)(316002)(33656002)(52536014)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b63RZ0iQg8NFGbZRVYw369vkc6V/ipL5d0kNkOTonEv0jNFBxnUZbMiL/xCF?=
 =?us-ascii?Q?P8EH8IGwi7R0wxE4jtLaVcU5XdpDW20nbOYBLeGJFTBKG8eatsoycZwzePYp?=
 =?us-ascii?Q?ayOASFSp4b1+uyKuYGO7Jubz2dk4aJmlOyk4wqjhoshjJdOtvNR2eYf3+Ulr?=
 =?us-ascii?Q?ycDefwbBwragoC/98Ll9r7TufvmU5+on892z30ovGkNTudf5X5/MC0sOuUI8?=
 =?us-ascii?Q?1RPWCg2oTUmxRzJU+NjppYPO4ujnEr2MjTpX0mCaTsMqxOIi7br8VNQSg91P?=
 =?us-ascii?Q?4N7KKr/QJmQAskQCTnn4A7U003ZL0dxWomIjEWE3kq8cNJT0q5uUnX8Q2f7H?=
 =?us-ascii?Q?OLNGwWuE0rsgRZh6UObQ86baDQw4/PD8eqIFETkFf1ll+6HvW9nt7KXUPYZg?=
 =?us-ascii?Q?X7ThMqddWJg/Hzd7ptC1HPZeytdReUV8sOr8eJOTu5Fqm6LUohvaAcJmzDNg?=
 =?us-ascii?Q?XuSBdBWmJC1jhXEkG5LTxjF9V8TFx6/HPEB++E3pNwaOESup1a1F29fSdbaT?=
 =?us-ascii?Q?Lg+MWOfpz2DrffsKDk4l3qXTEecBlB/6IGFbdAZHJ9kdBqs6ZB8ouynGADmG?=
 =?us-ascii?Q?aOeYyNBjrIxuFcZxpXE+g09CNIDP6o8/wx0JMHeBHBlNmqLumISF/+3EBUtI?=
 =?us-ascii?Q?gmMeAvkwoo3ZpZ7vVaTZlE05xy+hTP28oU0B3oDuFYFUWn/7PKUE0soE45dd?=
 =?us-ascii?Q?d+BtNNYnXfp2f/Z+8XoGCuAAcIby1T0HmdA8O9ZPdV8qz6Jea10KT3oVhukW?=
 =?us-ascii?Q?qTKcge69QKorsorPc6/+Dtr5adIpSh/GemR1vG/zmIV9aO8jfHiV7QNzauXi?=
 =?us-ascii?Q?QTgrPchHod8VGfWKMX49tcFxQB6A7W2zQ43Qj8n2o3MJmnaipeSV1TpBMaR5?=
 =?us-ascii?Q?9p9rnx3CB0WoRI5ranBsfoUxai4rG8UNpyFBCz/yHKBMjw2IFRNpv0XQn46J?=
 =?us-ascii?Q?+PKs9lNeWNz8ir6fGLfhaVNx6kVonB77qu5ejAZ6QUvTIJ4sEZi4DF8RPPZg?=
 =?us-ascii?Q?lHNthANRFdC8UVUOUUdMR0/Up4PR96q1xQ+KMo80v6xRRsRqHTPuhSg9WeZt?=
 =?us-ascii?Q?rvwvuGyRyonIeG6Ou0Ez4zI1P3ZmuRDuxCT+K2GtfU1qs9ZTR3cQFSrHeBCa?=
 =?us-ascii?Q?h/E6VjMnv7DptNGFvT7hbWDNQ1SnytXXEAE1eBfu172pws5h8qmVXxJTsaFf?=
 =?us-ascii?Q?UWQ/jyNp0HCJI/IKniqM+mMGQ0N3iyEvWi8x23fisJ0JwYvpespl0fUx0np2?=
 =?us-ascii?Q?ERpOS+8Ja3OVQSB3eUmohzOFUVZgz6YtHLcT2xKAV6hp19csVmUolm9qZBva?=
 =?us-ascii?Q?vdlMwwlursUwSgaiko8ud/v0BiS0lPcJLn+mJPadiMCIruH1YBeGq11dy1FE?=
 =?us-ascii?Q?HYMr5M+jokFWMs9QKP2DH7Zi+Z4VP99L9xilcoPyIbe5eNgPpHLdwmURyn7A?=
 =?us-ascii?Q?qsFeMElLzu9sZWNhFvzLWRmKlzEJ2uBWmOJvaTbFID01o+5ESkfsC9ObSoB0?=
 =?us-ascii?Q?HkXEFI2ObHWHS0Mac79+UDxhQQkea+tbvb+CsSSrmoszBWog3cOMRlFIz805?=
 =?us-ascii?Q?XrxPLu8l/ShZ2a+B3Z+wfLRi/i073dwc6AAFxf3SoIkb0wNk9Sg3USVoL4yw?=
 =?us-ascii?Q?sesYNCQVHQqD73fo1oZfuI8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d1527e-d6a6-4d6d-8083-08da65689238
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 07:15:02.9902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oBICuQYBwUoOX6iYb4mrCr3CpX4s7RgYBObqN3MtyXdyyueXJli0PXzD/PYW2VrxBJ0WrX2CKMq0LsdpXWG78rsnOZdXpv2ZWYkmF+zDK2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8027
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
