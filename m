Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DEB519125
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 00:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243522AbiECWNV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 18:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243533AbiECWNS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 18:13:18 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B00741FAB
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 15:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651615782; x=1683151782;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=OYIKd0fP99CZm5hA/PZ5hPOmWB/GlTCCy4TfaFf3pz4=;
  b=CIBKrgR3NSxIq/ABVymq5IzvCIxtPQ1W73rSrmziSUuZKvtCQgonwImy
   /APGna9GxNJitvkXI9iBhnZNsRVvq0i0qJ8EfPn2RyvmAa5RDC0KiI+ba
   fy4BTIxAGiO10hh8f1YCqJC7Z1ZF/BZSxF1yEFHT65UHP8Zk+Ocw5/5oE
   GvoQM+aEfeS4bn9lnjA7OxgOJEJzxXVO3QVRkAjmu1Lqg1KkDQoD5kDvS
   8CbIgwjybcr1xLKyFsOXl99AowT7B6hnMfR4MgB5T4yAku9BVJsy6Ge1G
   aT7DZ0toAkaS9GW7cAMmkA7PCv7kBYTlA5zomXLwdyDx+zkWkir7la94r
   g==;
X-IronPort-AV: E=Sophos;i="5.91,196,1647273600"; 
   d="scan'208";a="199454041"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2022 06:09:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhY+VLo2YViUIySHqzk5fdyxoyWgg6QMMmyBwQmuqg7cCIZAF+P3Yv8SDjAmqDj+bNgiTG2baBEQi4x5zcTXmlidkHw+DIn0lTDkg7g46LSazqlP926w2hRQcAioKvaD37gSyAyuzjWdLd+nIW1//+HI2JC5S0oPZPbt+NzcEUbDdwiqFlcfbRjvaVbmfyEj/lTWLCaYDC3MmBOK8hoaWibuOZ8/OQECLjVZqJdLgmZcMNamvqJsaGqkrnaJMzQyQPlYdcrBD2dcRQu6utNfGJvQk8f3P0qvFknioLUJAA15CIaz9eP0TCROFew3x6dQV+BH++7I2r3XWAaxdV3aow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYIKd0fP99CZm5hA/PZ5hPOmWB/GlTCCy4TfaFf3pz4=;
 b=kN9g922CbOUFj5/q5AsPvEhKLKBu1Ouol2cDA9JHevqfm2wdvp1gzVXzMy0p8k2Ff21NBaF9lJ4urVUEAfAP3uJ7Y8t/ASzV6Wk/0a2EXFPnldkphlg7v9XqbawPAzNRikygeYSJKL8Jz5pXshJAXtmE8Nz0i5xwNythqK6NW6gGlkRdPVaVdoaZ6cIZtY850PL4RMQ3P+2yzMrHe4411xQ3cj5KWsoaO4lsVjHKNz+eHyCP7gEf8PNkqrx6ywSc8wAU/ArCPmnzRxDa9YwvGghX+3zdPTyUVAKjP3uIE+KZ421WvGsPERlfGQjE3SRt6comQP5tqd5/ThbV1l+/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYIKd0fP99CZm5hA/PZ5hPOmWB/GlTCCy4TfaFf3pz4=;
 b=luf8wbDlHacaOb1mWCA+M3uUFGwA2Fm445jAdN0rcl/HYxZ0vH1FTxse5aRLgddngWckXtdzGZbfueuID0HAOii9SxPUqDEQQ9W/m1CWc44G4wX37noDDq4eGWAcomXaJFJ9fujmMy89iP4laBbd/EX9cgiEfizPgACgyD8JltI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB6264.namprd04.prod.outlook.com (2603:10b6:a03:f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 22:09:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 22:09:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] btrfs: zoned: fix zone activation logic
Thread-Topic: [PATCH 0/2] btrfs: zoned: fix zone activation logic
Thread-Index: AQHYXzJcFvSDxS4gRUCOzgJHZW1HPw==
Date:   Tue, 3 May 2022 22:09:40 +0000
Message-ID: <PH0PR04MB741625AAE082DDEFF8418BD39BC09@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1651611385.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bcfcaf5-7ba9-4213-3a34-08da2d519ea8
x-ms-traffictypediagnostic: BYAPR04MB6264:EE_
x-microsoft-antispam-prvs: <BYAPR04MB6264B28308D441BED18393E69BC09@BYAPR04MB6264.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6jDyGXHX6bviTYY4D2e8G8u+VZgGAW9b2I60rZRssfW2swtXNb1QrqK9Hef3SlpIXwc2vwpdMt/M2NtljkZa81HweeyqetqpJc3VGqf1BNtCkYBya3meQ9gUlfEcWt1dWbRWd4Tf8tN04zhvc7q+rzAcEWolq8Ry7Cf2GT1n2qmapHht78ooBBWx7WPoTYI1NXxljnXxK5kirQgQuM1Km2P9gjleY+PzwXPB3UNa4eUqTzXFH6wUATD22QbkFaqK/uHsYnpk07e2NMMd7/acznQRrOpYikMGXqUKDJExq4ist06yM4Ksg6+f4kLNF/9BKQb+8X61l+2T0COg5CCh3HuHjcQa3B7BJVm5PSprJGoTxTngS1u4jXzyx2Kqt3TAeiz+FsYRBp+rxV1aduIj4Exilsz5pCXhSUx4G9t015uY35GyNgFCGKfO2+KvEwkkI5keD8Qbn3fZaPAYBwJPGGf5wyd2d2A3n/oSoAgWPkYuXpWrN17+hiP+iAqLMBJZRE/qss08M0JOnhA1BMBRXXEwhP9QwUF46fAwP2WDlMRVu1I8c/kIhMSeZd4Jc4LM9IP0+nE12cKYKxFd/1G/368fmoNERKni2AP/g+8bo313a1p+SDIPe94Q0JBfjj765WUBGNIh9lndBL2Wb+K31tokwV2QeF7KW8wPHqe/yDUcUj/QDP3yqmdwLv/emny3sxqOA5HRXg21hHWJPy7PPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(508600001)(33656002)(38100700002)(38070700005)(5660300002)(316002)(86362001)(55016003)(71200400001)(7696005)(4270600006)(186003)(26005)(9686003)(6506007)(8936002)(91956017)(64756008)(66476007)(66556008)(66946007)(66446008)(8676002)(76116006)(122000001)(82960400001)(52536014)(558084003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PXNC0asSpMzuT6rg9GXu7bnoq7gkXjX+sIdGFzQZQZsGXkD8cKKhN5Q5bVwN?=
 =?us-ascii?Q?jke9IlDOaSGLd8McbWKu2A9ZdMGK917+LZXFYZFRBi/JLBLqTt+ShMrRdP/A?=
 =?us-ascii?Q?L+HPnm4ByKYm1l4XWYn3Q8ZSEp9BqvJ7AH6qzGjESs5aXdE9NGkT0A4eEG0j?=
 =?us-ascii?Q?jzd507gAvZmHGdDjiQHqSUcv9hKH3RXOYuKanK793b5OVjvZs/NMEnc+405P?=
 =?us-ascii?Q?38obdRYb5/uD+aSpyxRu5fO++0ZzktKuSBNwENVA3zQc6RAGriE0kHrI50Xf?=
 =?us-ascii?Q?i/MYlvoJVYxPt8SA/bx0lqBOEOVIjcUNeJ0wZ755Y5z6U5JX6MC1Fq2aalic?=
 =?us-ascii?Q?pH6BEeT+WT49o18FyzRERTQAO8Vk9zyWw7VrOgKmbhPAIsNnseXHElOI9/l7?=
 =?us-ascii?Q?VD+uzdyQwtLQJw3zJvDTPatA/CYJ3kb5ATae6W3uIk3QhFTiirXJxisr5Nsc?=
 =?us-ascii?Q?K8GdHXtu7Zlps2isg+6CZ5fQiCKs76A00lFhw/N+0/Mi1foTWbWxbfZxOou2?=
 =?us-ascii?Q?MweAbM4Y055G8cg7CFxaJTiaF8ohh7odu5/d7PJIRPumfdvjnj9BHcMyScl9?=
 =?us-ascii?Q?iXN33gXZ53dwi8xp66uecQofM4wA8A9Y2n0UpI0Dt80wqLP/g43HPKGtIk21?=
 =?us-ascii?Q?EYeRUmIrsKydwBJmkNdfpvgN1Zt2My3RdtiABkoR5LviVNn8uRuRdmMAd2H8?=
 =?us-ascii?Q?jKYxSDjJoDqhweYEfGoL+5TDOaDk6BSjm8o/H/jj8gGWx0KhmR6meq1ZXmoi?=
 =?us-ascii?Q?S3cqKyJDI+oxI1GYAprRsrc4lOG1m7JoWctTjtxy91uc7fAMe4bRf1/KJTB9?=
 =?us-ascii?Q?bIUiw88aepj3M5VJb9rG6u2eoJwOrWm8EgxIB37hrs1RtkJPkwofUqNbjD3S?=
 =?us-ascii?Q?cBmU5Sbt3KsUnTEuyN9QOj5UM0ebesHhZ9r7IiHgEW6Kwu1c/Vq9IE1QmHK9?=
 =?us-ascii?Q?5sZd/ya/Q0FQZnOMD/qxasSovvMEjjH3UgymRdmKfOkCpE2C3nkJc3pO/XU2?=
 =?us-ascii?Q?vfkJfpnHLl35IM4fj89aJ2pDvjscbn38I2w7yYhEfumSDTPglMLpoWhoz2uR?=
 =?us-ascii?Q?ekuQRU4isVIe9aufGp9MIQfUN/CfYJw8zSV+h3wBkQMd0MzCnx/s0+215OtY?=
 =?us-ascii?Q?4cVw9x3HYHLqYkLVO6XbJJw3KMY45yzIVxDPxhEdua3pi+A8jEUn5nD7/RHl?=
 =?us-ascii?Q?lrSS+sZMn4EJpF04+9gauHJHMx911g6AVWACKE9VP4vRTpeb8CurkExZAqWL?=
 =?us-ascii?Q?3+I7GOMTh1uzV+mW3w+cmktZeft3HjxQ1CAeBST94Tg1iqzyMTqcniNkj0ah?=
 =?us-ascii?Q?ZdyIU2RbQXPiaZhZb1jFPRgZxx2ZLGpewOq72yom5ylrfCCULkkenp1dby7+?=
 =?us-ascii?Q?FWLJRcz9GzIwfRDJiYKunZcj9HkYfbqrA9oLNV4j/zULRMig6v3F03+v/7RS?=
 =?us-ascii?Q?C8hbDZIggDYZFFVqndSDqSlfuIiHhI26T4VUulKH1FiZwcUXZugnDD4uW8hj?=
 =?us-ascii?Q?+/1GkvohWbSffT4YeM0SxB+lH86rCL4GuOUeTNjdE4sB5gmXYjAwvYWzJs9e?=
 =?us-ascii?Q?GODTCaAQst27Q1mvKMrRMl53FxEPw2doCQ/ANPGRRujfJn1SsvQwE/PVrRdV?=
 =?us-ascii?Q?EyzcUIhquBcMLMw04QgpGSdKtsd1AKsy33PIb2lo4ZZVaKlmA/iqXav7Wq58?=
 =?us-ascii?Q?785PXS/JcjPmtqE2S5GkY5HAAToKr+fUt4IIBbDvS3Z6ck6VMIhwn2v42mKi?=
 =?us-ascii?Q?O/4ZeolhdBc7xxYyQtpUY26cqS6TNFFugDmGUqCvUg6EShEBOSwH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bcfcaf5-7ba9-4213-3a34-08da2d519ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2022 22:09:40.3459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: blYqxR00Bb2sHKse9onY6xDqKOvd+kj+qkp5fnlD+HLDbmtWaP1wG5NC+woecne+dWyR35vn/fEejW67noLYAB6VZnYDM+nj2BLNxg+f/90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6264
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Oops I'm sorry.=0A=
=0A=
For the series,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
