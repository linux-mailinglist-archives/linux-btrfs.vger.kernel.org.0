Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2F84E6FE1
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Mar 2022 10:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356605AbiCYJQd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 05:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356593AbiCYJQc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 05:16:32 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB61CF4A4
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 02:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648199695; x=1679735695;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=KXn28iAYkWZnsA0CRzVr/tun/EjYl3KtNgpsxVaCfAHPeTYP0Vt40ul8
   1ArdBTMYdgabZr9+ESRBIPagDQMIBN30hFSseXC6twDsi5/+iQydNHWU6
   nwaQKQqgqWofqvTZv+OcPMGpV3pCBiVunQvjJpbugOxsxaTcjmEHX6G+T
   RKictsscs1bBP7uFZoUv046ijQ07k8lsTt/BzLZvlmIP/1NlMwPbV/tXn
   iInCWnYmQLMs+b45IlS+pLup+dP2WcaUT34gerKILZjvDXtrwJfdA6vS5
   zbtW414bM5HmxYyyJluZ4Tc0kfoKAtmjur5GEZjF/sGOgI0Qnx3TswHYj
   g==;
X-IronPort-AV: E=Sophos;i="5.90,209,1643644800"; 
   d="scan'208";a="300404371"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2022 17:14:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNI112ad4KcAIWyDQ1lWGx6sDmwSsRZM7t7xAThb5BWLGraIfTS9C+IBymvx2jSNEcHuISo6p2jxrU4u/n8g7deViJ3vOd4rkYBtm9+TMlI5t+ws7ElEbCXQZvt9GVn/pAd6myLlYDTPp1u2IvtAGEvAZv1tXjEY5D7SHi7rmV1NnGSoEiNIWz+kZaE/ZG4uEP07pLmXlA6Q/6UC0OYHPjVw4mUfTdTatyKljthreW0dLFQYfXjTFbK/lSljDzS064jSzld0Fvo9SpGyTyS4zndeSBtdoXvxUVz8Oexw1vg0efgIO3PQRKcTjXVlzG5UQfffhmNHPZd3+DyzBynCIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=XA0CUwsz6oWut4cnVHlFsdg5lRxczLXFN0/Eap8I/lc7f3p3/49KMsMd5Ysra/BBfr0xZstW4+CToGbtJVTa8hQ3Yqrpuw05Fkd6zvwRBEnVlhE4wZBocFuLA0dEXUxFh3xI7uk2QopcU92a54tGf41GrkXYxqmZSPsIMKFSBrokoEjeDxSNsigIeZAJkith/k2tBoK6OzV3X1TXgTctuTPab1PaOKqB9tTaDgznNHnfDpDdtH+ec3092PipWUEUWrkejkGb70p9m6KeYkvlRAcgCJ0Wt3dSIvUotOJqVUM48ngHgO2latcvKf2cISncdSKlYEBxEEIFV+pTyjxOaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=GO0CdS5QohsUrUqUcXNsChciWF0LlYrFl6E3dJnVdUMKi+7CrKipDlJ4BbV0JlY6rd23Mp7LwaEil5iBKb67zFrNoFLV8KZH50WnJsXarH/OZKRwtu/8CtJ30vEsglGNkbma2pvmfyHY1+wP2VaPg8fJPa7UZeiJVz+To4k0RKA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB4706.namprd04.prod.outlook.com (2603:10b6:208:49::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 09:14:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2%3]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 09:14:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Qu Wenruo <wqu@suse.com>, Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: fixes for handling of split direct I/O bios
Thread-Topic: fixes for handling of split direct I/O bios
Thread-Index: AQHYP5kn3FwYnfj2oUuC9VXAKpNjoQ==
Date:   Fri, 25 Mar 2022 09:14:52 +0000
Message-ID: <PH0PR04MB74168AD0FFAFB6DF7870E41A9B1A9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220324160628.1572613-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81d083af-3e75-433e-05b1-08da0e3febd6
x-ms-traffictypediagnostic: BL0PR04MB4706:EE_
x-microsoft-antispam-prvs: <BL0PR04MB4706B0BBAD6C4D52C55AC9DD9B1A9@BL0PR04MB4706.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EoYmRqoI6y4wdpdIOk0NxDeKmNIVOMV9IN9233TUM6CuI3jSc2Hx8BxyCzMBBQVzZ79TlhLfE3kstLj0VI6wK7Wu/KjRIDkTdFLj6y3RYgaVUcXz2ab+UM+wTu4BM8D9FTEo8t4cAKQSbLI9kRQcyJaxtqCZHs/8nKY9EP67OTZ0dmPBl8IXPcucoY7BRuO+s0hS17YqufHXvRf5daBD0gI+QXmqUSVFencBc0TrG8cVbchLzaN+xI51ieoaLDURfQyh8QaMBDpO+aLV6b/1EqFfrX8V9hFDNOBLU6KYD1GGVH8uNoN35d6VfGa0tZQOZQ2feul2w6nK/f+OuUSyvIIO8e51D9Z/ZPs6we7/f4G03zZf2aqVkDvxmKQho4xO2l3dv2wi+5wf0RieNo0Aq1NX9BU32HcaOdAPCB8ybvAOXgmfKRXKhFDUjEle6Ua3CBVO6Gl/nsVfvgp01RyxqU/K2CvThfRnhNA1HwKteqt5VW5Yr7V/4KtgxAtJBmWxfa0YgNjHd32Qv7Ct8EHLz3kE1Lh+xZ3Kavm+kKHyQkdpzV+hFZSbE0INhJW6Iymz+tRKBh8mz81mymCCBN9lKj88GA5/ikKIDLJFdJ9YRkJlQmCtCENRsovfCC99bflwoQ6IqnaJ6yw6pCly7678Pas/rFyHvJIlDtgs1pMk2eDDpbwCq92p1jocsL8BuDwPG6eTKDdpcsnbLigegVS5Ig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4270600006)(52536014)(86362001)(19618925003)(91956017)(71200400001)(8936002)(66476007)(4326008)(64756008)(110136005)(66946007)(66446008)(316002)(54906003)(76116006)(508600001)(8676002)(5660300002)(82960400001)(66556008)(55016003)(33656002)(38100700002)(558084003)(122000001)(2906002)(38070700005)(186003)(26005)(9686003)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?whN/myI7qY5BXUXM5R895kWmDfqizvgu2k/+xeLZcCPRl3H/Bc/RPjgUKErv?=
 =?us-ascii?Q?5Xto2OaaNJ19l46yY1q8fcp4v8dlGsmA/NCpgtz2kBZCczofjv3C+MdTQSod?=
 =?us-ascii?Q?J40uO46QO+R9LG8te9kNubfwB8MkW449TWtl/r/6toBLXirE2xLphQJoEQWt?=
 =?us-ascii?Q?Z5ZAvQUZ3ykx9QNIY7iJjKs46KJ00KgTFoBKz9iU4N5LaSv5K4i3s3nMDTLe?=
 =?us-ascii?Q?URAg2i4jbTGDc/G4+g3FkUGgUGeszVRL7RLjKMq2FmNRlu3UUTCYCTSo1SHw?=
 =?us-ascii?Q?lFNdbETyqdw1zkRGXrAeRjhUYov7nQahhTkDb4BbThRC0V2Xr2o8SBhGnspi?=
 =?us-ascii?Q?ph8NBTMxmh9zKE3R1EFaEPAeIy+ZREHlzoLpDXFgIA5In59IDbCvUvlEfXgE?=
 =?us-ascii?Q?vwlJs5xrHRUUxCE7dZt+ySWbCupMUIeLL4al9223V+FFuOKo2rCJxe/8bHRH?=
 =?us-ascii?Q?+MQICYw3owetutCDMrxD8ShY5PNoqhSB/JP5m0xqlKB7uhygfQg2gHJHIqvR?=
 =?us-ascii?Q?KA2ONWMUBaz4zuhEZQ7QLmvv35mVmxqZiHXeQWb8AWCqBavcY8lqRSvEyLQW?=
 =?us-ascii?Q?uRuDFvCpMuaS4A1PPvXvZBC2xcsDSErrKXjSUjHu9MsBCwQhIqhj0jDTYhEG?=
 =?us-ascii?Q?g29dDuDyHdrG/2VjwAkfQ51ipSHtX55LgiM/Z55BsrVkXfWD3jTp5lIPdaRM?=
 =?us-ascii?Q?6OF5z8f4Lek9A4H/ktbSoDtsAY2jC1Tzq5HaK9sNdBAD0R+D4K6UIiwqttit?=
 =?us-ascii?Q?EgtYaCIZMMKHnINZcTvUyLOSGKH11YLT5AOdHRaHNOLGvlzl36Z8lmeWMiTY?=
 =?us-ascii?Q?OvbzIXoDsxe8tKdzjkwhWuBNIRzy2DwZj4jtJQBXgIyJ1xBJM0rNLbMwotjV?=
 =?us-ascii?Q?YT64zxN+QT23HXhJ7Wt8xWTMY+urduJdYAh8nl2P1W9ylksQT9Hpflx9SNE5?=
 =?us-ascii?Q?8NKT3aUeWQjxjigv6YDDyf5BKb33H0Hz0+CTSWclP8U/c+vlivWBKsZLLRfJ?=
 =?us-ascii?Q?SEpezVJzQCgs/j/vQMQJcBGrVbVcSz5K9uTE2+52cktd1mkOucLMer5oTX5/?=
 =?us-ascii?Q?XPgXKgHQxts7auWam+o6lGd2+/x6ajWH6N9FAhT6H2G6fLqDxR/Do9iXYf3V?=
 =?us-ascii?Q?7H3ldDQ4xdMoh/AZMT29G8u4XocKrc1M8Dc+KynXORBH8cthzzIWES5flVy/?=
 =?us-ascii?Q?HHYSQChPIf0XfjuwJqciL2c7b5S24K7QBXdsLkEBzOLOaVqfKYTB1xgXnRyq?=
 =?us-ascii?Q?EZLjLJ8j+a4cZbN4AK9V/sx0bJCabyTaVR7ZyIqO0oRD97wTMoysUnBzOFrH?=
 =?us-ascii?Q?v4e19DAa4eMPCh6TOFcP5uidyt/Svx2sj/ux0LUCd2J/pVTcXoW6BF8cgxus?=
 =?us-ascii?Q?eDERy8sqQLFvOco2Oa3Ng4mtx8kBPwWGEgL5b6HURXh0eaOf31aBJ/Ht+p7o?=
 =?us-ascii?Q?zUGk141JUyBy8ORTbdtuk5PskAWKuh6Cv99HYXqYbiExKTx/lSwIDSovztzY?=
 =?us-ascii?Q?NUx62gEqiUsA+Lk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d083af-3e75-433e-05b1-08da0e3febd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 09:14:52.7809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /pOnXcXXsjD2WPIouj2jBWvN1nQaWs9wBIdcjAe0oRT4NSN+5WshlkRwYq4xG5MatisyxPRN/bYXqxyGi7jCjErcJY/2rc5YlNZwnFW2fGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4706
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
