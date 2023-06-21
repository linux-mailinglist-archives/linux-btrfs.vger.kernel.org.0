Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D794F737BAD
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 09:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjFUGxp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 02:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjFUGxo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 02:53:44 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01on2074.outbound.protection.outlook.com [40.107.107.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD6D10D5
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 23:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5j6w3OHZ8yIboDxBYRIfWlDlviuTCYFY3Umcg180AVOoPDPmawVlQdj3yfkAy9ezBPAp0M89pbrJQxsXgqJIYngYWOloIEF3MWE3sz0zK/eT8WC5w5V+kVbXlovjwnwrPzYtTO80n3OLmzpWjkImhEzU+dbYPfRBnHTR0+6+iLum+xQOuCyrIVXU5EmCO047CYKjWRxcywSoeNC6SW2ozPOAZgywq3+PhfBpyy6UpliZMnd29+DIe/1fQ02pS7OMEsXlnsZD275eSHR9SNzeumniMLICru2/rWa15/JTXhWjrRoOe2yYebJFVZaYsNy/NiYc/33HhRLKBRtio+H1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGZ4DK4MDFGFpUXSxy6r7qhPDLttfO8g4zQpfDGYv58=;
 b=K193SCeFYQ+NaJql6Ev0dYTMVcm8SjdzEa5QDjREKhoxMdl8nDZ4XQ/fV14PnB81OreOZ6CX+gbAKmcelsm6t0ZWUaicsgIYs/KmYucpoTaZ1TxSr4UIhZwJXb1nQKhE2ST6X/lWIct6w+cVKRqZ/4yUnTOCOdLxHhfvaicKO3UaYipp85ZQTR9QUaWNLWEjsaiP7JKJZikdaljYJBWeLKa1rLkfUTob4gmfk6LQKTov/3DTNucNvR5wzxia9weeXqoA4mKHGV5qPf81TgIlO0TqtWNK0/1JhB8H45hguzvOqMXm5aRrKiOqBQp4fAuMwwrKgcfrKuzZYUYUMMzzZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGZ4DK4MDFGFpUXSxy6r7qhPDLttfO8g4zQpfDGYv58=;
 b=Jv+JR+6T+CVsDTIW1mpZ8MOR69n/Mo2zqzD5eEynuA7/p1jSK8NluWx1JDW7NRiek6vsViM5+E5QYKoQ+TTnVfiUwQo1Zv+kSqipLYSscZMfzMIQJxERwQ6e6WVajb/2SkMtpzHaYNmiya5CHlp4UlzACAQ7QKGksZysE52L5rQ=
Received: from SYCPR01MB4685.ausprd01.prod.outlook.com (2603:10c6:10:4a::22)
 by ME2PR01MB6018.ausprd01.prod.outlook.com (2603:10c6:220:eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 06:53:39 +0000
Received: from SYCPR01MB4685.ausprd01.prod.outlook.com
 ([fe80::e5b9:9692:ecbd:fb4f]) by SYCPR01MB4685.ausprd01.prod.outlook.com
 ([fe80::e5b9:9692:ecbd:fb4f%4]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 06:53:39 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: btrfs replace without size restriction?
Thread-Topic: btrfs replace without size restriction?
Thread-Index: AdmkDReXhL8v/HFYTgKvho7pOkYr7w==
Date:   Wed, 21 Jun 2023 06:53:39 +0000
Message-ID: <SYCPR01MB4685ABD2A45F14C694BC68DA9E5DA@SYCPR01MB4685.ausprd01.prod.outlook.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pauljones.id.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYCPR01MB4685:EE_|ME2PR01MB6018:EE_
x-ms-office365-filtering-correlation-id: 84135f86-64e0-4f9a-c3bc-08db72243e8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0zGnCI82F/x8N3pGkjMy2XWqXEd8DI0TXVwGAQxTnJvA9pLOsBnxgvo9HWAyWfzBWwjAagtCOwidjErDbBNKL1jkMOcXeF4ABYc3kW85ntWXSLvgHAlJrXOp0Ws4BodkbgqbfkAVTG4etXGehU88sg5n4TWkiPQrDQZmeNzBkf9yp5xwmLm1Q7LmEzLGo87uwixGZHSTQVjDGp8Cm85kZmYX6K+oE+TG3I/mrtLFzd50zBHTFTJeasJVuvEERLWUkphtdjsJi4ebUyevnNVrtSjKinCcOVVbd4YxEaF2eci2jkgYYmdoN/3pC0dIyv44a+QK7nGX70autUiQGZAwGX7LQ8jta5aE6qvgdsMWDRt3x5PRi3JWPP7ooDWInjlCf49M6MefypioBNF5jS6sJE1M1iGbyn6jv9V4uJhe/nC0230BZmXsfPlJju7B1D7k/oAj06ETI6Pzo9TwjbqBClxZS5kCrZSq6PrNp19JBm5uqIFXQR8eJOvl09Jifhvqjlbhf/AkzsA7kEh+I7BAT0pZWBLammORdMjTU0iRFUUpnkBbPZhtI3qV1Q8isR5elv1l54l2yub1E6qS334Cnq2rZjzYU3ZTRa8omgmC7/faJGvjZDjjwJBrPzp85zxd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYCPR01MB4685.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(376002)(366004)(39830400003)(451199021)(86362001)(33656002)(38070700005)(122000001)(38100700002)(8676002)(8936002)(186003)(26005)(9686003)(6506007)(41300700001)(316002)(6916009)(64756008)(66476007)(71200400001)(7696005)(66946007)(66446008)(478600001)(66556008)(76116006)(2906002)(4744005)(5660300002)(52536014)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sexriXzU1J9PUcNNOYVCW7agrwqYGXPy39ofKy7iQaw4zDHFnRvkEs0T93ci?=
 =?us-ascii?Q?J/YqJecw8bYb98K/HS/IM+sLotzOFyWVUJ1Z2DwRrZanq2EnNI8Ib2nojykE?=
 =?us-ascii?Q?vA3YwE/iScFoww5UxTq4UVdpUHuipyMkoe1YhvjeP/Ny2bY6aFLPv8K4oQ+L?=
 =?us-ascii?Q?EL8R7YNOq3SjKp1KzUh+EPMxtE3B/S8PLnqlEzfU/1VmS2ypIxDMrNDILL+O?=
 =?us-ascii?Q?5WemRihF7Xb4KK3OImG6lX90fG5BbguFi2OPJd4QI9PsqJiH35K9PHLefB3Z?=
 =?us-ascii?Q?cD7PqqjGw8NeOT0IknQhtep9eve/cr23QnB6INRKYrwn3mdk2BCoObROm+FX?=
 =?us-ascii?Q?iHe60FAXfl6UXRG47NjvjL+H58BXF6zsFwMCH0YryJ2iciUgyTGDgesdCVhB?=
 =?us-ascii?Q?Jr4XnIdSwWQgqus2rbGlcee2hqBPuycs7C2/bTbyIRMFoU43jJy2TMRQtGy1?=
 =?us-ascii?Q?AqvnLm2oOblv24ELhPjdTF769AobnKLNcbFZdFGlmFxENwtS+PRdz31z09ID?=
 =?us-ascii?Q?1iBomDVH5q6QtcejZk+gdwMLLKHtIj/ABnHnDOdHDNzqKgwxTCVhlG5abpx5?=
 =?us-ascii?Q?tPp4++oS89ovo2PPJiM4ZLSesJlvMY65fb5R0nUh6obUXlI4Jdjpj4Im7lPE?=
 =?us-ascii?Q?MuKSRypfFXpVKBcGfUIYrQvan8mXnbFygyWkbkWjM7dN7XK9OHLQWXef9Wez?=
 =?us-ascii?Q?akjMWjZ0qqWnDEafc5k15Hxx6pefJNPQsQ2QV1qNUaH8okjMCRmbrzlnEgA2?=
 =?us-ascii?Q?5CAhy5BY5SN+2EtUAIo3dGachEu5xDh05CAbM8C3Twoj0ir1SgCHN+MoVSKb?=
 =?us-ascii?Q?Ad2Po+7w3ojqUBNAQ0E6KmcBNgXB0X+pqYWG268nw6iCPpaegtzUiD3IqV/+?=
 =?us-ascii?Q?tbgvJRg07wTgw8k/ZN8nTWsHSP6j05Pbqx2Dpn1Kbic+9XYiOFZP8C0OT/mW?=
 =?us-ascii?Q?ovm7Z5YKvakkxy/mMhDyOCj3aQfph611G6w4/xc3nMaXHi3xtIFgu94pR2Po?=
 =?us-ascii?Q?lpl03Zp6Xb5BF9w7AeySJ64N3pLPE4hGna8YCvdSEe//1JqFAWVmWT4UX9q0?=
 =?us-ascii?Q?8QU1AS8aZKmvLWAksriBKEQyA1cA3jXuH0K3t1szt1XSeu3D4YIDnfQznzZD?=
 =?us-ascii?Q?2WkIRhW/VzPbseAx0cp5yvvRJJ6f8gEawJzXGrgRZ+laEkQtNr3XhCA3UEyS?=
 =?us-ascii?Q?IlJvVgmz2fPbc49ftyV0VV5WlannandtAasNpewPfa+kJIL5+7qXssQ8RQsn?=
 =?us-ascii?Q?2vrejOv/L3EbSDsTTKCT2Ac8xzxeDdUMQhpD+/HQjU4eP8gIigOrriKNLCiS?=
 =?us-ascii?Q?HWP9iFC5DwdplWRCXzvI5CLF8VYQeLIGjGvKM1frhSp4hc5P24eXI8MqpGlO?=
 =?us-ascii?Q?nfqZPn7MHCWbSqc8AUGLml5jzPSVlMnkG+bSd3+rmzZpVA1F1wRfSkSEOOSh?=
 =?us-ascii?Q?n3qTVRVKJpZVMG5tII8NRUAmNqqBUkjNB3XIwBES5bh7K2bl4tf+zAVNGSnA?=
 =?us-ascii?Q?cB5Q0y3txoyAayv3mhVZ1n8HG8F95xlqtzqUV1bW/RnkXwedyrFOTyhbpoEB?=
 =?us-ascii?Q?EHaQesaLAilCDqL3KbT0ET4XIW8hLYmIeRSi7iNu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYCPR01MB4685.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84135f86-64e0-4f9a-c3bc-08db72243e8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 06:53:39.6631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AaqncsFflpuVwIRUDgnQAETIB42sVhWKfB6jJnjosn+zqnJSxOypBYosO8CPZCPeX5ypBc0bcwSD9K+SUL6msQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME2PR01MB6018
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

Would it be possible to modify btrfs replace to have the ability to force r=
eplace with a smaller disk than the original? One of my disks just failed i=
n a raid1 setup so I tried to replace it with a disk of a different brand, =
but it was rejected as the new disk is a few sectors smaller than the old o=
ne! I have 20% free space so no issue there.=20
Adding a new disk and deleting the old one seems significantly slower than =
replace.

Thanks,
Paul.
