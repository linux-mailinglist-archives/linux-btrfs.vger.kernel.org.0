Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408DB4E70F3
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Mar 2022 11:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353146AbiCYKQA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 06:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346104AbiCYKP7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 06:15:59 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36E774600
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 03:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648203265; x=1679739265;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=wfkqYLoXNPExnGsp1UNu4xMGaZUWNheP5uE3e3T9QfI=;
  b=fvVUnsxHnXgAKEwu3rbC9dOxBWkJzI4oPZPesI/6oZ3Ee4LU/sAUqFkH
   8GLLUV1AG9DLlilI/qs8+uY1DHZpeNGupZHGDm5DXrWzLaxeBmOzzAj0S
   i9pNPCc/w+VnhlU6EOhh/cE7gl2EP9ysNL/7+PbfhS4paHdyCiZyTZRaJ
   tMjWWO3+t0WpNCiF/8f1zKZkHTjG1XA4BVswb6Om5rxDGimiIYhNQpPKh
   A6xUuyeZSDYEoAwgFk/Za1LM5hW9qjoXtMJZnnkNDvdrCjD7UrDSjc+05
   PzHHDne2EI4FYNVw65S8tM3CqfL6d4QNo8Qyl1v5LQGr0wTqE5rGP4cXA
   A==;
X-IronPort-AV: E=Sophos;i="5.90,209,1643644800"; 
   d="scan'208";a="308213995"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2022 18:14:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zzdt9X933bSLp4BlEniBUfw7HqAIldRMEpmzJkeKa7I9tnyuv/G9Np33/8XAdZ8lJDe9uyxorCVjsAZ1QE109RGVYwAhD5/1mcc4DbK1d03HVDCEmviu57TcJIqGtS983P90lFu03vHClkRHLArAqvHtpiEGyEJCsSyr/aAkgZIC4Z0zMqo3k8tRivtQQdtrxC34xAd7sNDK68vkUpNVB5EgUb3ng/bh5FvqsxsH9rkFJLySxrrD8hnM572jsG+DtXqSCvus5n5gOIFvb40y92lwSz9+7BWWMhBVonKb7K7ldHYfeVswizTZ+5/r6dE2L4pYyDtKALLy7vWWNd1pPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfkqYLoXNPExnGsp1UNu4xMGaZUWNheP5uE3e3T9QfI=;
 b=CxYnFCvOW1u4lHffyrcq3Q8b0kExqwDC/xJvgCcAI/6fkq3K7t5ntUcLhZKZNJdeOWR5TgyXN0N06gtNYlq0wuYawG74DVa1dCWsvqMqPGSJggOlpkesFvXql3PQZE2a4nfogRHwip/8sK8FvwLJFRXErXBVPL47EsFVN74s+zOsK4rQyWhojLoA3R5u1bA4U0OuxlPFkJ1DJJULpitm9n0XCSPMT1mp7zZxrZ/jprEaEHs+VBIro4QpFQR5deuuufRa/Lj4bTczsJdNL1vsHLhPPXmUtbYVgH6xeBEcc77XAD1EbI+zoW4IIl/Huj3Ohtuuz3IKMNnZjRyUoLIe+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfkqYLoXNPExnGsp1UNu4xMGaZUWNheP5uE3e3T9QfI=;
 b=AxLraUru55k+Tfeq4DnCYHK710zncZpNHzd3HbsOUngnbLCWdSota6VQkES0RVA/t6D/3HDdF/gyJv8wQF210d8WSmUxg5ZN0mFUdYdFOTz7TYZ+5aCQQIkjdMaLxg42M+Iu6YqSU8b6DRPRH2nal3L8ppVJDFkwtWeVwFfEp+c=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB4146.namprd04.prod.outlook.com (2603:10b6:406:fb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 10:14:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2%3]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 10:14:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH RFC 1/2] btrfs: introduce a pure data checksum checking
 helper
Thread-Topic: [PATCH RFC 1/2] btrfs: introduce a pure data checksum checking
 helper
Thread-Index: AQHYQCzBleuzPI/f5UW9dVeyoBqPvA==
Date:   Fri, 25 Mar 2022 10:14:22 +0000
Message-ID: <PH0PR04MB74168AE6E4EDA9703D6E59C89B1A9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1648201268.git.wqu@suse.com>
 <9b69fcc642594113c8a0dcd9aabbd65739bc8253.1648201268.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8816992-204a-491d-91c4-08da0e483bd9
x-ms-traffictypediagnostic: BN7PR04MB4146:EE_
x-microsoft-antispam-prvs: <BN7PR04MB4146E286C32F893B10C82AC59B1A9@BN7PR04MB4146.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eQvgDSRyP5oK/d8p8WZ5YtUYjtQ59sgbjIjYpk+xF55kIrx3TRgsDkKXbvRX6Pmz0VlyhPoQqj7Ii3GeRat+fDQI+6m01HJKXQ/lLKL8pMRP51o713ASLYXUr/Y7fQE0/L2GmWQWPuAi26bMlvoUE80PzwHxyiRrzx1J/QyHmglpZHXim5aFppVRWZUYJ/A+l9NCmwtVXRanjehEZrOK4o1PnT+6bTc3XKkL7+H48Mtag0fg09jLO3NNGYrDJzm3YICRJf6yUm92xC/H6J//JXweC96TCmO4vHRpHLHaYR0kwaBMQzVHFWeODkRbV8dokWKnKkvtWQHmFdKSk4fsAD9UrGpEA6/xqvy9rlB+LJy4YCQu8T+NHEBdw8ayucsTRhW/G7L8iSD1VuDPAfldsH/OkMdlPZDW3zP7M4ogNY1uUiTTTwVK+/Yr7fB4SzHd3OqXGXbVMuciL2OaAfvz4hPyj7aYKQVDgClk7le0ht4eVvZhKL1PkSZHoIyugQWfxWrxyhYF9zfBx0rQ9vkQL9ex5+3Mk2iClnacmYrHuBAqce70GZnxe1kuftWdifIKAn48kPl9u9jWZbWHm/aGZ9+kVAJgYv3OW14RTScuXPq06AO2RyM8SbBTXLKDCyzBkWyYqevXkZf0P54vTc/IBeXG7Yxcfwrj5aW/0iF8qLRt2KTF3Cnio4l8j9Ho2UbxMBWkrjEXm2A3mbCc2yN8Tw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(558084003)(33656002)(38100700002)(6506007)(82960400001)(9686003)(86362001)(122000001)(38070700005)(71200400001)(2906002)(186003)(26005)(55016003)(5660300002)(316002)(8676002)(66446008)(66556008)(66946007)(52536014)(76116006)(110136005)(8936002)(64756008)(66476007)(91956017)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?skgqmwqmScoY2JtWlm6LVg0LvUWyWg/BJ0jraEwNkfTvoa+JX6JNdhrNvmmE?=
 =?us-ascii?Q?i8Fp33OZcjeAyEZilS5UiKtuZtTHmwhNQ/eePqXbt1SnTIa19dQUw8kvWFA+?=
 =?us-ascii?Q?d9BCFsb/xv5gipAGC6vMkJk4G+3O4vJL1D4jvzxoBRz+fNRMQWBMBBzq9fpZ?=
 =?us-ascii?Q?j3KwXDomYJWfDC3hpZ1UBRPrw7JeOGtdLhUDmdv+tweJm/XwAeURfUM0XqOG?=
 =?us-ascii?Q?+iWTieZ6RKpht9YaNoQRwi2UHo931VP9y27A5fQ8Qa2l1LWt3u/aNjjkY6P/?=
 =?us-ascii?Q?8ubrnLmzc0vF16w9DQ7HOx6WpZis+dVEO1fjWAF75Wezs5Y4vvmM6GYkQuV1?=
 =?us-ascii?Q?JyK/lp27+taeuKOspGtqF17mKwL8XudEKDg69Wtr8KT8okNXWT97o/rbcobj?=
 =?us-ascii?Q?AFFGnFGdxGBUYRPrEpQgaTssyT/IFnWXtYGNO8149tCBt23rZi/fm4pcgfCO?=
 =?us-ascii?Q?UOJkDvmXs3njDh1pjMyaZ0sDYzkN4v32WAMozAiwJPSB996D8b/XFmAxcT1N?=
 =?us-ascii?Q?CMBAwmih6CGGFH8yikQP/i/xSKgttAeuwTfteHy75rwNqsonyKXsQ+31OloK?=
 =?us-ascii?Q?bgQK+JZGvEhySfyIbsAVRWs0wqs3XvPN05dvtmCKmV3pKxJv3b8V4/wxOPsh?=
 =?us-ascii?Q?R9hqSNsCcw+5id0tSrlOTS3IH13HRdNa9CHMNEJPVR6eRJZ77a2r99D2K77u?=
 =?us-ascii?Q?KtO8lLyXNCyGMdvzxqclWiQIna/XTEfjZgo8mQxkodFf1KJ206rQPG2N+w8s?=
 =?us-ascii?Q?wOD00/dHhamrUhXcWOr9Z7wCErCDP9lPEQSEZJMmEhawU/+GGGDgQW058D9e?=
 =?us-ascii?Q?iUZwlBpo7v5Hpc7Zg3xu40HZm7Jo+OzQTnbflYoaa6z7c/cl98vJrV8uWr+m?=
 =?us-ascii?Q?f0Y/m2aVDDAygCb8a8+o4wQtYpCv1IupH0olKu2jb6z8FK/9Bv4GQxny6sbT?=
 =?us-ascii?Q?t/YwT3T17se9m2+zwc1HZn3reOvzxFP6ZbXqjw82JwCb5zWEqJ9X8YZZwkVS?=
 =?us-ascii?Q?jun25Dw5cWGn9U6tjBuQ2NPGYfOGjHA9GCkY8kBObfpcyQ5iKqqmORba7vSA?=
 =?us-ascii?Q?viwxrHZvXqYX0MzPryrg5jfvSdc4YTF1irKDc6d6X12BGE7gFYUo/H7sX5ar?=
 =?us-ascii?Q?FN4CsgaNn5VfCgoyLOvJQpo99zenFNYtxTExNNZSnpRUzXsjbXWV6Ojru9sT?=
 =?us-ascii?Q?D8ewsvtpdV7PhLsVi4pbqtIimlOMgvz6PLFRSi+NO6qO5olu7YRvtC8pSrRP?=
 =?us-ascii?Q?tAval+jWbMuVPHOsA8k0d5NzkPuGQdH2rEUxzsQl4tQHBQ40KEykbRE/k99B?=
 =?us-ascii?Q?ukFLFIz0xSuzoWc2HHdtgjtbbE1z9vC29hARKEoEP/dmdXUH0dKjd5ItHj9n?=
 =?us-ascii?Q?2stKmxbhElr/ulRm7T2nbBTL798MC3BwXI2pMUDaDU/PNX5u/mkZpFYbxULr?=
 =?us-ascii?Q?skqw6eFB1BoK2ph+ZeJVleeDv/j159xEe4GU+OtVxsJ9YMCkWnpmzGKXidza?=
 =?us-ascii?Q?kG/k3JST+Hh8J6U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8816992-204a-491d-91c4-08da0e483bd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 10:14:22.9645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rULQwT5Hc7+XBwCWlm82VlrQQkv5xlLmERzVygD1JfdViOWMRYcz0XD6KbqnC+z9+AO8HTjE9sDE+0zRWeVlVefJBjdfI+n/hhLDW/tTJvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4146
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good in case 2/2 is ok as well,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
