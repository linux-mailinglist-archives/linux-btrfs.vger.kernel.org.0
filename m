Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F01D54F4AA
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 11:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381088AbiFQJye (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 05:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380339AbiFQJya (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 05:54:30 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F225B49FB6
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 02:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655459670; x=1686995670;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=evPaKCSiYIUA0o4Fo9z91OWZkiOUYnV9ShNSKpMU4ZCsYAcPn2/gSRdT
   ZmXGRSdV0WQ/1lelhmW3NLwZiVHyvP7QaG6PB1WJksrW6GFjY6J9NGQY5
   v6A4icnBZ/A7bKCeAmKE8aHjydSR7qS3XGogshg2+8OrPEiOI+zpZsogg
   DGlzu5mbBhRY6ayHRSLzJnlTCfzk+VyhqpyW948v9RkGjfmm+ZM4fPXZk
   N+vTz+zTNlm+yHXtzX/6LiLbbcwJAwkmkOS7LHS5EwGeqOzU6AJpIOP9m
   RumEqWwY2yAdJj7pc3OLlZCE9ry36poZ4dgQV9D8dsST8MEqQGh88J/5X
   g==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="204178582"
Received: from mail-dm3nam02lp2049.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.49])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 17:54:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgFb/iMLe6iGop+s8Tb5AvMiSS0OR2OtGXbwEUpKEdIcetGdnRaWCxv9pMuR98rL5Q2M3qrrwju7P7pW28nX4aq4/nFsLRLYTrUpkN+aFyqRoZ0oMY561EMWnNFytOP0h7TC69GOi4SduOEiZj4m7omQuQhJOxhfYscz4Nfm9iivdce+k6TncsFiQnc4KrwreEZ5sBRdNjNhD1KJA1ibTDEVqdokcz75OeWPm65Yb9APDrd6TmMHZr2dER2kNoC7OZki7IKpjZgKVfBT+Bl8wGHiVAY1LQVX/7bwqZfKAyQxhaAINWHrxW6O4c7llgFKjoCbiFTx1HbwuTqgJP2eEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=A5eAAMytENROcsejhC8eGETIa6IOCEZyC7xHLXtqd578UOgwuNdOyNe49csKELuO0r+ApmCym62s3Z4cyfI2ohnVffVAQHgrWJdXn4A3hK4MnFBYzD1j6/XbCtZ+I+fCUL7OQlPfPrLjYCjHwv8Cq+9BmrIbI0lcvoL33G+GU/XRoLyR9f7AUk/21HkC+2oMMaCwUFjMOIJ232nKRutX5LsiPRl6CErjr6ZvbQyisxp64zItIffFZWIvSBhn9gn5K8IABfU4FHDJ/7DsY4JT6coX5b851SOwlRLsEFu8L/IUsmvA6NR0XJjwqrAgvJjPUxxdYveUNChUvi+QpaN50Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=nN3/qOjAtrs1sD/skxMD7FKLQIg9BuNIoB3ZdXpJwLEbHodr33VSnfKxVLYfQ3aNjrozOV/3dh3f8fU0R+Y2UkJ5KgbbQVHyqeaNAqat5aUwpe10iF10uhdbrqRhVC/ILfV+3ijATR92clRsCuvSPBWtdOFr1/cjwMlM+jfrZ1U=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB3973.namprd04.prod.outlook.com (2603:10b6:a02:b8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Fri, 17 Jun
 2022 09:54:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d%7]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 09:54:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/5] btrfs: return proper mapped length for RAID56
 profiles in __btrfs_map_block()
Thread-Topic: [PATCH 2/5] btrfs: return proper mapped length for RAID56
 profiles in __btrfs_map_block()
Thread-Index: AQHYgMrMOKQhFOoRjEWdiPPrCfCiSQ==
Date:   Fri, 17 Jun 2022 09:54:27 +0000
Message-ID: <PH0PR04MB7416644749326EBF2352E1449BAF9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220615151515.888424-1-hch@lst.de>
 <20220615151515.888424-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8dbe6d15-3953-48f2-386c-08da50475dad
x-ms-traffictypediagnostic: BYAPR04MB3973:EE_
x-microsoft-antispam-prvs: <BYAPR04MB3973B58B7A0D508D7051EEB19BAF9@BYAPR04MB3973.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UjOnqdaHnNyXHyLd71hmwEj79sKHy+IeWe5imzVgrg0ZMAU8Ux8mI4fQEyrQqNyigr0j1K9hB0olX6VBLJYUpNi1SQwBwUtXXD0F+MLPlM8UfyCAsaFoGeKoasO7x8btJJATZIO+xYn8r6Sl/7j+Zu9MC6lWpHUIqry5CcwM9fuMVqOw/bJbRCbEofjIlSAc7SaWR1kUuqmkJVCeTgFb1lEvAVE7d1ufJqVi3rUKycYxwtTZLd1nj3JPvExhKeNpE/l6qkP6deAQo6iPHDXO3ykXUyEkVIEk6thei+cZRgO+7uxnmmzD+sHFg+Ioa54/3mgvhxRGyc/CHlg4hxhm6GzBF0mu5UVjRzYVJ1eBKN82uTkm6sFDDNACzU+/p6W5Nq58k/3SByT6UiqPSbuYPXX3tv2X7ZGRO2d/SctdR8oiNeks6EjDb1DQhx+iwCfBPDs597YDhVMiNPCMia+H9F21lXwmGcaxuU/DX6AhIqieSd+DhYoe35GPrjKrseCRlTNyII3Y6Cxa/BmexctQocTOo11JAPcgBBv7DM9hUmBD+FAEuZtUDij6/6JYdw3t2cHM6rz3WCpdbMr16zwH4uspZRK753csUpDW1e0vdyrHN7wRkoraZ8Y/s0DJWBkG+GantbMZyEvTv/vy+cAG/1bHTSpMryQD8WVzoA3JNqEWEcAx6Vkt5EbLkk6GF1FC3NpDw5UyKkRPWGJ5tAHFsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(110136005)(66446008)(64756008)(55016003)(498600001)(38070700005)(66556008)(558084003)(4326008)(7696005)(122000001)(76116006)(186003)(91956017)(2906002)(66476007)(8676002)(33656002)(6506007)(82960400001)(4270600006)(8936002)(52536014)(38100700002)(19618925003)(86362001)(5660300002)(9686003)(66946007)(71200400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZhqrUIGN39+t5E5+2sP8nZBpFslfEnq1k4dYcwAWhjlPrju4Z0fnQNgn7Oa8?=
 =?us-ascii?Q?Ujbv7U10ERFwSg8AsbI9Cp2EFeBpXLNOYcSAlqEjy4LlewBSBrfCqGXs3yWT?=
 =?us-ascii?Q?kfUFnpbP4kdZBuRd+Z5peuV54ukSIAKKG9y0OQF1cKdEJxb1mZYq+a2YhxKf?=
 =?us-ascii?Q?jPdVA/WHWjrSqqbVfZoi1mPWls8xPCUON8S1pUXXF0d4+8JnBBfmaRMgltX7?=
 =?us-ascii?Q?hL6FqjeQBnKMJLbvuwGXCmC5SX2RoPISSblHC27Z5KkflGbAO5L8+SiOi3FT?=
 =?us-ascii?Q?PfAb6GW98Uo4HqY1fn2c7z0bUAypJBVSnBeqUbhjuTe9QnV3S6tHnhVGladD?=
 =?us-ascii?Q?UwrqDjFiSGx6KDwARVqESNLDCJfj+kjlTQqVTo4hb8LchsB6ifIKYwdlDWY7?=
 =?us-ascii?Q?gab1t5LO7Oj4iQiNwHTE9WsU8v5XQywl9C43wa+EB6iqwVtQJszrfjhoUAUa?=
 =?us-ascii?Q?9nFcPxHuo1ZKbxBk8ipxNXu4guij7ddgu1zqCAqDM6Oho034HSWPEkMBSgEg?=
 =?us-ascii?Q?hjgINB3XqAHaJR7zRYubGPBfLcg+ks0eXsUOT9Yy3kfiEE/mbzT0kn55dv8a?=
 =?us-ascii?Q?aecgqnJS0p4V+aFeSE/nOgT3fVOsWrdV3PLV9+n5b82nZET1q4OFlWUX+Yhx?=
 =?us-ascii?Q?XqoFCWJuOd2l9OmboCszMM+xrl/qGmGHiQFT8AbeWbFrIQ3QrGcnABR24+j6?=
 =?us-ascii?Q?SZTkfTg0UxjvDBL9Fc77FKiPgCIwbspocISOT/s9CHUV4afwY53AdsZ0RjXY?=
 =?us-ascii?Q?hzU7pC3TrDEwMba8I79efwEuDOccfwcltMMajQRGQMzQ2db42vtLZlsA8vtb?=
 =?us-ascii?Q?v8qb9Z8lItxCtkEzwjecy3Ri2T3EyKjEOVN2f3QZZM1/hW7hStcwtmChRgdw?=
 =?us-ascii?Q?zuniBHiGOu6flS8un6z/RQnzohBaj8PI/HqRE7isGonjQ+Q6/7wHkUaFzFj8?=
 =?us-ascii?Q?k0zVJRbm7RmST02cdROCi9L9V1PqgHFws/EzOYbuwO28TszOpn2L+miDM/m9?=
 =?us-ascii?Q?REc6l0z2m+6Wfia5PSN5TU60xHqjcbXDhIgxQHseoqRLwL92tOItaZoCnhae?=
 =?us-ascii?Q?mD5HXMF+9RR3JyJb15N8OMnRlTzmYbhFrIAAu6DG2/7b3P8yLt2S3S0xzHUE?=
 =?us-ascii?Q?ZvRnKE5rLrqkurAtl+/f49xDl745wfmCST/Pq6AdMPWohFc50ywEr9DKcOBp?=
 =?us-ascii?Q?sOiotYYFQVfWmkeUT0sQqpZmr2YS19+pt67dBj1ktRaFoXmoM685wBasU+8T?=
 =?us-ascii?Q?TZZfBX7lsKRmVP8w9mdH0vThs0DcnuZyAYBzicg+PGas6cSFqa+Wd0yP5een?=
 =?us-ascii?Q?381cGRXxa5JIpf1NHKP6LKR0B3hCv7bab3nCsEocEdo4UO/POr761wL0nfUI?=
 =?us-ascii?Q?4noekzg7PyMEbScu8qmzubMgqK//MJq0kRAoT2XRWBPEzkfJqigAdUmARoKG?=
 =?us-ascii?Q?Lxhx9LrNNr6pTUcc6yYvsqeGzlYtDZLCUSOvWtiNCSzUktMUKDEpiamDGEc+?=
 =?us-ascii?Q?fsTKXmZzVWh9RWo0YI0QLSNXakNX6O1oqckIORwLoC9/3Vt/W7SHERkbmhkH?=
 =?us-ascii?Q?UZM9iC9xNeGcM8V9r3rieKM9qLgAlghg+ESdJL8nVK4bIz88JaBx9nuQ4hiG?=
 =?us-ascii?Q?Gg/KUAwNY6KgvJPSgtzqMVtELBvt7qB6rvpY4l1s2Is4ds4rw/6qK3NI1/R+?=
 =?us-ascii?Q?X/jB10mNOyHY2WIhoDeOUwbscX8WAXy4WRWd33Q6/R8mWCoHulVuh9DF3Ocs?=
 =?us-ascii?Q?k9fupQzd2QHGQIp9JnBgpaYPnsHOCPwP0Bv+j35VLbLtouD6BZn4tJbqJars?=
x-ms-exchange-antispam-messagedata-1: OjtwRBx2ALdUcCLZdou8JhI2N1OnL9tArPpCQusVJJOng8yLI43P5p3N
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbe6d15-3953-48f2-386c-08da50475dad
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 09:54:27.0254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LSMiIovBs+EA9gfRl5f8qrEUC/oKrVb36VhlfTchLoeySCqi1KBEJKyUQ88GR2jkqLa1qr2tPksVr0Uy4OSXWHthMEMZ1fHQJ2dSP8TPtSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3973
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
