Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5BA1CB15E
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 16:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgEHOHz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 10:07:55 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53156 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgEHOHy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 10:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588946873; x=1620482873;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
  b=ja+NB0czw8EiP1Wv3VPRDR43DrwZ/SDXgV0Ah5kUs3FPuJpfLmh7bs0h
   fUo8OsWx3Elc6BjbeG7/HCJSFlUvUPXqzFjVZXJMmcVru+OY++t3REmVm
   yjuTVWbtZCoWmGpzxOZvIHPkX6pmubZZ1o4abEIziPFHtePbNSJHylLnq
   tA9EP4AzSQFW2B0y68bd+mfUggbuf4jSxRAir/mhT4faHhKTeDU26MRbm
   XRuhlXtEdwTlpd5jxQydZUQmsLeGOAQEPM1ZgbQ4i78QLXfyg1S+cXw+F
   Tton6Y1E3df+r8tP10jLlnE0nKf2fQSJTYc/PdH8Lb7muI4+I0Cp+ItCd
   g==;
IronPort-SDR: exZuPLhexCU/m28hnQ7jaAwKgAqawVxX6i0bgUIfL046HIdfg4HOdAggicAzuq1/j0XLLzTg8W
 5H9U432G6TtU4t0WCJFkCdrP5hAyZddPMiO2zFaYnPPI85wG8APSilQ2/cR7piGcD0gnN0rM5m
 rBeOKq3npMPvumpyllguNEqLyAaXkxQFgMfaMdXuv2JMzdb4Qm2b2bAtBnul+BX2f2PsuxHXnj
 VOOm9N3TfmjeFwDxnFWpe2X119Qf9qeY7bntVWwJQO6o+y2zasVWwCZiRnLmmJxYSgDaPtZAtA
 32k=
X-IronPort-AV: E=Sophos;i="5.73,367,1583164800"; 
   d="scan'208";a="137234208"
Received: from mail-co1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.55])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 22:07:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImgoqeivpXENcJadUqxmWm9iRQAIXu6Xs3XzIEnxE6kh2GKoCtzQk9QCDFKPmHriFXQp51PyfNEZv1+jzPKI4PpWeZXTtbyz8cDCJNHU8RrE2mDrPWbz15NLilChjH5Ph4QypSJVcH0tGpV3exbMDT1JZoYQnKsln4DygtKK1ZvB1Kpe5XfN8w80dTmXPp9Yqj6hTZEWYJlYp9U7x7rXKn4TWFikwUUBLmz/M4eX4j8IgoLZCShE8cESN6/VWBguKaYRD4e+Y5T7dtE45PtbrPGT5XtN+0fvcXJqRfXZk5zttpYXLqPiVIawEPGS+doBSnNCwsjk8q2IWmcvfsmujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=CtwVjQ1uastID8P2PHs91kSN1ij367pR6Kb3hrj872Rjw3OK1otugmkPVg0v3bhyF90R2hcVP2cHQ1MpkHPWY6KAkgLnUIbOjotQbOv5RePJ+tAYiPAFsdkJTCE1WnJF2Aou9fKZ+Xlj4rr6AQ5Eu1r/8+o+9NthUgNs0V21ENK345hWf0EYILrbYEanZ1FzdsYGTYFFek5kcAm/irz0aUKRekE7L0yejDEQmc5/UlIEAHZxzcPo+uE9fgInJbfksLfBbceyLS8W9o0K19Cg8C5TcSJM2jxeyAEaDP3j0ZfsXfwjtTlt6xd4YsRIhQJ54iI9HaelDeNtUCm5Y3d8Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=h1zz7JVCbmCsh2IWiRLj7fQVSLCgyCG5n22vVM++LG3j2d5qNMthpGfRxVgj/2W0/qxMl3ZS8oOUZkeTrYJxwNEV06b7kwvJ3gjD4WYETCiwTpwR3KNDtBzGe9cjbnw3yu30lm2OeaK8HYtxU7WwJ40cDiV5Mb30vxUnC/XKzfI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3520.namprd04.prod.outlook.com
 (2603:10b6:803:4e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Fri, 8 May
 2020 14:07:47 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 14:07:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 13/19] btrfs: constify extent_buffer in the API functions
Thread-Topic: [PATCH 13/19] btrfs: constify extent_buffer in the API functions
Thread-Index: AQHWJK0HeW8QeINIoUW70zndcg7Tdw==
Date:   Fri, 8 May 2020 14:07:46 +0000
Message-ID: <SN4PR0401MB3598EFC295B38B7EFEBA3DD49BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1588853772.git.dsterba@suse.com>
 <a4eda1c6d165edb24abe428af456fb224dd5e67d.1588853772.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c4bc844d-e239-4d57-9360-08d7f3592f83
x-ms-traffictypediagnostic: SN4PR0401MB3520:
x-microsoft-antispam-prvs: <SN4PR0401MB35201E7FDB93D16CB25079919BA20@SN4PR0401MB3520.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lro+73o+pGQuCAWBD340j4oG7HTT5jiuuk0AJ+YsnyZJE6NMBiYAuoWVENNZIwyQzfqPbAymUmf0lQ0GqAGB1Ms1SsETF+r9f6pncE9dD4kOB4yj5Ag1ClNr4fnVsY5EUsUruLRISXLH8MJyMn6Phdo5rc5Vr1nKzGyE0Nh76+a1hbewzVuzObJIcT2WY2qTt/y1Y+Zs5cl0uGog06iU/ZKqHHynBZEr1IuYQykPjGz8SJRQNMpQbfv1sENfu9FhIYnzrFDJEwYC5Ei7HUKAQLQTvvbcFgkRi6vHtdfTUXEf6sZ5AiJjRlPKxXoVycmyqlOBfJbC2V+NzzeeN9VQc9ZCg3e+Zal5jo4/9GK+M4fUsK7XHuGfsz3IDEn0+74DLy1ga3YZe/+AxKz55E3Mk5avx11V9u71707smszQUAxsEQbLhqf/cCLINyt+8uIxzHW3J3veg80mNeiNxFWwcwfJxpJa6eT1lTHzI/LZNp0CE4juYHpHlskZ2lnBDEy+NJNiIUrPDGdlwX1I3MtD6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(33430700001)(19618925003)(316002)(64756008)(2906002)(71200400001)(558084003)(6506007)(186003)(83300400001)(83290400001)(7696005)(83320400001)(83280400001)(83310400001)(86362001)(91956017)(66446008)(5660300002)(52536014)(76116006)(33656002)(66476007)(110136005)(33440700001)(9686003)(66946007)(55016002)(26005)(66556008)(478600001)(8936002)(8676002)(4270600006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: IkGXzNZWK82Rcn6q76ZgHH/+RSWOnMBdvkHzuoq4v8bAbM8hlUojTHw4TQJuJDCloz6SQFUG34vTZd1GN8HfLdmpFLR90ztgcLzn+20XUrRcXSlk5RC7DufpP7/jueYEqRiKw8LvKtpg34E/4FV5DEmqug3wa/fHvx5Kup8R4LwBe8J0JfvSUI+OfgXE2cG4qsoYg5zNMvY6+DpbTgH3UcXNWxwCnnOcWgiCrUb6N5apEPdsCiWwPSNte5z7+kel0Pzk/u8E66LgKUbULNP92FSvNHsD+YGYVMFGZyCfqRARL6rLp7k5l//4QLO6q50jeDgN6XuRRS94945v7hEg1aoMRKqyJivsRmb5D2CgwiRmE/qjWXoorW2on6usX9MVf45WL+Q2jZlaT0sDPE3YDZVZ05HVZT5K8sx/deE0ACVC2GPcsQwwZRjSUwlPyLhAhx2zC/HpxVph2GjK/tYACTImg6ym3IA+aXBVr0MjKEn+UuiAVcwqSsyhnw3Edilt
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4bc844d-e239-4d57-9360-08d7f3592f83
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 14:07:46.9896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 149EBDfMVLiysXIOe9PZAtMtpbSfgeYOl3VCsnw01mUEcK7PAgnLQntJH2xIe9BUTwnraNj2YfomWb2iW6bQS/27OoMrbddoe1N7nRRZG9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3520
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
