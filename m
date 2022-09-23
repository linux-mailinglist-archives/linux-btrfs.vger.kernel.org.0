Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4572E5E755E
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Sep 2022 10:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiIWICW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Sep 2022 04:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiIWICO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Sep 2022 04:02:14 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2A912AEC2;
        Fri, 23 Sep 2022 01:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663920132; x=1695456132;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=lRS284CDaUg2ItzbnDghASYccrP7Ilvm9RIyn9zJa+A=;
  b=ccAnUqTMoujDD1LlSYpf1pSsKJddoJnNMbcpzDh0K3kNQ+OFCC8LxydC
   Bv9TQSmgSgEUt3rUIXo1wAm10Y0KvwSQ161miTg3ZWCqUTBg+cKIwPyaA
   IE28RdR/7IHZlBOeTqFX3/1rehXPPi3hpfGPsAQtzIT9H8k23GJfL98Tt
   0uPRBhK9SEEnlTRAsteC9GACzEsZdc8gWdlvZvZ21+UeCh8DlpIFLNaek
   cGv0xn+AT+A+9b1/7pxTDlr3VU0BHFtyqBTUUjMSxHvuAhwPzGK5+sr3R
   svkVchpeeZHGdr3OZzxphholUr9tmCKEyYuDf+ypWX4Clqhn9+pabiGDS
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,337,1654531200"; 
   d="scan'208";a="217277721"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 23 Sep 2022 16:02:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W19CT+L0cUond1pElpDHEYpSRX93OXfxeBFbr6gXy0qBg9S0e7vdaggLsp0dmBZHgP0yQGyzZDPQvPw10b1Za/zZwrv+QkayMF0rGFOSQdRoQMZZ5NTV3FXaS9QhR42y8pGBAZZrqcVCIYo232XPSUCuMY04SciOy+faVo85CjVRL1JKo8fM/K02JYPaPvPSVaWWQGPTT7g75CyIoVHNsbDY0p0iwMTzhCIrkVldoS7I2cSQShv5dub6F4xggJTMt8yLvtIJtjI7SoQTP6xfJ8N5LthgTSyIBw5lGamxB1FdddLnsbAfTeVLhCXsduYoYKx1XfT9SPmF4dW6oqsqdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRS284CDaUg2ItzbnDghASYccrP7Ilvm9RIyn9zJa+A=;
 b=cQexbaeBgWK2CtBWZIHYeJ51ayAPbmLloA6+e54Gwh3brDjjIIqnXAa/QZrKrLnG1dU9dagfvAp7VDqkdKdaPCL5etFm8lOazE54TOovG3HniXF7TXcWJ+qCa6SiP4nGuz6S+hb4FA9AtD6NDaMol6EcxUEMrXtBA2LmOK4eXNcB3RW93Yd3lR6hpYxkH/fAWVL3Ml8SzX0rnvVZ5BB89zjqtajVKeVWcFNKBX2MAsYE+9xkLaBf3TZnpQzPAE39zc8BQH+TUogHToumzSAJqrC1Y49wPbfMbawawTYX0ylIvugFWZQnf15ZoDqggqtxYz/l6rnCM6QLWDnrsMM5aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRS284CDaUg2ItzbnDghASYccrP7Ilvm9RIyn9zJa+A=;
 b=Lcask7CM6+Y4mASBn5zcaVFMx7nfWhEMAf47L1F4bGdv7qsYQRigI9/LxWFmNIjwmlaBBKwPfpjCUVHA/ZwT05ivZdUtL/CnoZXEqMsn2bWq1gM3Bmu7/fblVLWxCUw1cPtWJnVBtDWp98eoQH60m4J4Agnx6eOkctLeSuA+P1k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6249.namprd04.prod.outlook.com (2603:10b6:5:127::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Fri, 23 Sep
 2022 08:02:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%6]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 08:02:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Zorro Lang <zlang@redhat.com>, Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] common: introduce zone_capacity() to return a zone
 capacity
Thread-Topic: [PATCH 1/2] common: introduce zone_capacity() to return a zone
 capacity
Thread-Index: AQHYzkf28413lrnh20GXPGsrpeGARw==
Date:   Fri, 23 Sep 2022 08:02:10 +0000
Message-ID: <PH0PR04MB741656D7881D11281ECBBD489B519@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663825728.git.naohiro.aota@wdc.com>
 <97ede9bba67f0848fc0b706d757170d7dfacb7fd.1663825728.git.naohiro.aota@wdc.com>
 <20220922154132.dpadkhaccwzysq4d@zlang-mailbox>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6249:EE_
x-ms-office365-filtering-correlation-id: e3ae2b3e-4ece-4578-09d1-08da9d39eaae
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X4Z6swz1vHML33q9fV0syLv8qJJyMRzI8tgeEvFmdmn19hOv+fKPdNUnyCQ3HkQEapvCV7SLOhhqmnSHIFF9ciiCKeyDsOCvKRsyMGieso73JKu0uymqym41rqIhE0N+xwDfiPUmjC7OgD7MTSipGNqBEfdeFILZmui4h7ldiP1K5l0wyx+690NNuf5yz+zSinV7HT85Jh8rxvbYsoZFmrmhfaYAJ22DmNHSd9rLYogL4HQbyLM0ZY//1ApqXPeBD6bl3KgNCOLaPKflITPwSshuZPn86UbdDh3t/qi5cHIyZ0kk2CRXHu/TKfWwyYxDOrMFlaQh+yYJSHLo5SUz91xQWVHP7H6zkuU3l6c24ehoWlRrB+M8LLL/Zv2043CdqOViHDHYZwF+7GAlh9PyOfrXsP2boD4+mqyG5qo6aX1Z1T7C3O+Bto8JjjSz+BFR6r2+PPSsnzCDV9dGfjWQHRO9fDx50RZP8IoI//rd7VK9fII6CfBan2A10zaSKX75AqR+lW1DZwRiURiWzF1bZaFtL4h8Yh/XjVziwxKqqDWIW9WbI4hCn1SGfd37kf/zT3+Dn0nX1HzltAL+rW3gGND0P0TxO+lraHrlZkcU1W2HMEL5upRtxikxTZj4ZvBiKoMXpsExZZolck1GKOLl+N9ZU82OrAKXTLxK+yFonD/jpzHMTfoDNEgAXsexib3Io+OFoWTH6GqLO2HjxyuXwr5sYqcWt8p43Sj5CJY0y0W8NMDMMtTb9sdicYT9g919QFl0O+hpOgOVAQ95YKXOGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199015)(86362001)(53546011)(38070700005)(316002)(110136005)(7696005)(6506007)(122000001)(54906003)(33656002)(71200400001)(26005)(478600001)(6636002)(186003)(38100700002)(83380400001)(55016003)(82960400001)(9686003)(5660300002)(8936002)(2906002)(4744005)(52536014)(66476007)(64756008)(4326008)(66446008)(8676002)(91956017)(41300700001)(66946007)(66556008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tWerj5MNPt4zb5QAUG1VLGF5IBFmh8lL4eqnw5XLIM3xeUrSTeVNiopBEZa3?=
 =?us-ascii?Q?mJ6BqdAoB1qSKtQQnJTFAHfO+GuEMrElB+X3umTcYRco3T07hcsF53GOTkkQ?=
 =?us-ascii?Q?4fDGWtFDBuKG/wKhRtMdagBCaV5AK9e+UcTBUN4kgty1cAARaUetKlZYLPWS?=
 =?us-ascii?Q?RbpPY0gGlvBVzKew0iDZubvIILGy+2enZ3y6aNvul7EG0VE0jtI3LjJl45fW?=
 =?us-ascii?Q?eGISHpR45ZzU3hgVi1KH/NMeIPU6kV3xw718c9i6/frn9LxJeJIFQpzCjGDK?=
 =?us-ascii?Q?kdzIqQCOMnYcncKcDTpg/YykIWcLjKDPvF/sYWW+CQ5Y3bB9KihVnCSm+XtQ?=
 =?us-ascii?Q?40etAjBLSapmiYSGgzWk8OXoznOqmcArZfawKhRr3itujM7sbLKm4xmo8uwd?=
 =?us-ascii?Q?HfJzw64t5UeYhkMOlE1ai9EiKmpfKYAOiURUtKdD2tHtjJUK1SpHQhIVsmpi?=
 =?us-ascii?Q?EPbHoLKG4N+PbnGi3Dlwz9FZUyvSTOK3ISFpEdcUHLN/1JvTfyualjebhH7K?=
 =?us-ascii?Q?rOUOltPFSiAp+mds3zQWPAcoESLE5Wa4lqr/ddZfgVGLjQDWdMddoVr3rRyy?=
 =?us-ascii?Q?TvDs9ndl0v6/Fsil1EhE9miUVl5PMp4T4EMkYE5qrU+zLDDwflvQA0CZN1uN?=
 =?us-ascii?Q?nQVWy3HlUNeY8jpjMiMjnkDgpmofB79JdQ+CDVrre8pLm6Pjoil6f0BFMHEY?=
 =?us-ascii?Q?Ze4tJ1ZIRJnoEKCJmMWKoNkjlMRSCw7VO3skmzU6aEgNx0LDNmUChSA0k7P5?=
 =?us-ascii?Q?ZzIBM3u4FET0roMypzAX0UmmR90WAD8LpWj0/fMAGbp5/UfbzR74nvf46+L3?=
 =?us-ascii?Q?wCcr/TrJzyp21L77ToaDEPeCcWG8mo2dJkJP6nY3u40c9dWyMsm4ucMFJiOz?=
 =?us-ascii?Q?o754Y9YXsqzF0Jca9fnsyNpjVt+jFmA8LyFWHHCsJqEZizeMoJ3D1OC+6YgU?=
 =?us-ascii?Q?j+tArrTaZo3u+/i05NRtMwA6T/4hXnmOU0v/yzhU9q2oG42ZDj2m6hq/3T6x?=
 =?us-ascii?Q?Nyqmjr5JKzRLltGN+Cr+SNRZDIs8zEwk22bgHvfofjdN6TSraWkkSgruttai?=
 =?us-ascii?Q?GQ1XbRXRo/16CQbvXfUzdAhb/8zD4EylBtAnC5D9eg4cNhfv3oCOw3c25zqW?=
 =?us-ascii?Q?J6u0eQH4aeejy0ioxna+WAJ6n0Mk19ROhbSR0T8eb7oDt2ahUFegr3R3O5pe?=
 =?us-ascii?Q?nNv8JF40s4sxnMW0KMtTEnInAAcTkvGmAeGSMeP2JM9flW3dSCCM9Ob/nIpC?=
 =?us-ascii?Q?Tbdunhe3f74lKF2PnZk3STXEiqpjoaaNrExJ4n1lvFLX9pUpQ2BqnNMHGZYR?=
 =?us-ascii?Q?DfSTBTcrcPUoVCPC7rq/sGpCbZ68YCPDcSdr0wqOS3z+M8i1PyqLUWxr7b+k?=
 =?us-ascii?Q?vm2dZu61NcrR246TetbecdZKavRtL9Bb9QHyBtV6Wnh7oHRCam5DM66zgZxe?=
 =?us-ascii?Q?EkurTbfPOi3zEgcSZk7ORN9NifaC2QMkZVu1yq8owVgZr+q5Na76TI2cs1YD?=
 =?us-ascii?Q?vWJE1QPWrnSY88ezsIbG2uYWFoB3wa0fSd8WXRaBur5qcOGhDSqRmvlhuyPp?=
 =?us-ascii?Q?OL2eLc1pamrrmKBMMJIkpFBiMIH+QFO6joa2BaKXZId7s5RnFywRhkGIfRw5?=
 =?us-ascii?Q?8A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ae2b3e-4ece-4578-09d1-08da9d39eaae
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 08:02:10.1848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6pNjlTJC8y4vlz+4Y+y0Ge80Jnq/sZVXuq1huCUNSspu7rgKkI6tWRsfheFWUGmecrR82YQDkuzQW3OY6edacXToTspCKToRwci5ipYJgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6249
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22.09.22 17:42, Zorro Lang wrote:=0A=
>> --- /dev/null=0A=
>> +++ b/common/zbd=0A=
> I don't like this abbreviation :-P If others don't open this file and rea=
d the=0A=
> comment in it, they nearly no chance to guess what's this file for.=0A=
> =0A=
=0A=
zbd is a well known abbreviation for zoned block devices. I think most=0A=
people in storage and filesystems know it.=0A=
