Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19226411175
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 10:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbhITI5e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 04:57:34 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35976 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbhITI5d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 04:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632128167; x=1663664167;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=FKig34kpcJ5rhWPqtEG+0PIh5V+L7Fa+9xSBXcGcsVE=;
  b=U5X1JZaXWcxZWnzJKfWb77aOWnWLyTZV5jRsE0kfO98LE7zUbvajGIIZ
   /DnxBBJ3LTtprPHzI5xmiKQpHlUEi2S7StN1IKQ0UDrk2t/5nxKagPdKo
   bWKdOqSFnOYs7oiQHK24jnG1A2mAAjhozRwcP1E7PbA5jP1Yx0dRy1snB
   mWbL2I1Vx24s3rTQbG++KzKZk1Wz2KPDJJVb0d8gwFf4hqfb1bWF1h178
   udT0EZDmDTgnzgbUVDQXH/eqqoi9iFNXMEOPHe3+7CJQKFkIrY+uBG2J6
   LhdKi4t+gNwTXkxwUWtVgj975H/CEn98W9xxrMk4g+WKy3wTIP3zIc0Dc
   g==;
X-IronPort-AV: E=Sophos;i="5.85,307,1624291200"; 
   d="scan'208";a="284232107"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2021 16:56:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAgie5yRAhuLZ4i63YSEeUg83MPTtx1+TfErIb+3FkR3yxp/CMyjOR0PAULQFuMimmHvteuNO3Ikk6UuGYDpauNShGYmGxV0L5v8qSNShHD9Qf1WKqPHfIvAihaVrRHQlbouHmBuxa7LNolY5fjjHgkJMV8Bu6yb91ljaIEkgLjs1l9Bsk0i7pRrriWYJ+zg0Yju7Q3XClR6rzJFHM1zjwSggQav4GvjZRNU2yIlc+XjNolXSN8NMCrFzrFb6NtgPnQ7V0VjcPArrjXDjzCRmHsaZ/oYKPQC57Jd9Yn+6CPK1etfaGZhYB/WEqHRB1ZqzZqSPJi6GVKGaTQB+uqthw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FKig34kpcJ5rhWPqtEG+0PIh5V+L7Fa+9xSBXcGcsVE=;
 b=mjf1eERdhNxqjvoLRq5rsstyyLowWmjcAOVp2vOZPxD01z/5mIBNOm3RZGmW0GGxXzVJ6XuHW4peSiUdDmR3C54WEdsgLb0rJCgW2FAlP3/xRzOZPVs3HOVi4pPczzDOznRzNKIkdEwKBI7ePthmiFG+sZqLWAOuj8vrT7msU24XIx6B1m1UihHsy9Mv21i7hdT/k6xHqWdNveBUkXMDgsGsZhNIAHgZXCeQ9M+ty0gWvky74V/cLMu9oL+62biAEEDWInC9t7icrHHohGM/9nWaMrVLQ55aqfPN+MUbWSW8vKbjKIySADD4n1iMaRbMGDYDK4EjQcZKKr2i/ewjSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKig34kpcJ5rhWPqtEG+0PIh5V+L7Fa+9xSBXcGcsVE=;
 b=kyLgwlB5y7x7URhwjOZls4qv6pBp+okHxPDcUbGhwzI7NKT5lx2vs1nK4MN+0RSrSX+wVWSa2h0JB3lE2d8qlfzjj5pF2ZSjFwKqp7r+ZTH6ZjWxKDKJAt5xkdCZQGPFnb5V/3xWU0FVp0LlaogWXBWWzt91M/OcvOEOfS92kUg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7671.namprd04.prod.outlook.com (2603:10b6:510:5a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Mon, 20 Sep
 2021 08:56:04 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%6]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 08:56:04 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>, Qu Wenruo <wqu@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Hao Sun <sunhao.th@gmail.com>
Subject: Re: [PATCH] btrfs: unlock the newly allocated extent buffer in
 btrfs_alloc_tree_block()
Thread-Topic: [PATCH] btrfs: unlock the newly allocated extent buffer in
 btrfs_alloc_tree_block()
Thread-Index: AQHXqTXgZbADi+3ZHUutwYMBuMP/7g==
Date:   Mon, 20 Sep 2021 08:56:04 +0000
Message-ID: <PH0PR04MB741600D1F781CF62BB582B129BA09@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210914065759.38793-1-wqu@suse.com>
 <20210920084822.GA9286@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5376da31-3473-49a0-ae11-08d97c147a5f
x-ms-traffictypediagnostic: PH0PR04MB7671:
x-microsoft-antispam-prvs: <PH0PR04MB7671B01560EAB9481EE640B69BA09@PH0PR04MB7671.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xkSTVl2PeoDB+cVF73UOY4sJeXhL1u0oKuyHShLoU4gVWhtw70KxfgO3qIagX/WNAqhiStwZLcUuU+9PLnozdhn2ihCzpp6Wi9yIqhSTR5x/4hQi4DcbHH5AEstjEuSVc/LwmW7EXlZbEskRlq11xwBvC0s+yOOglneKDVsud6wPtAKW1/8QMH+E5M9Yon0FK2coWzJgdIf1RRl+ADon+6zqmRME07aU2AGxKeOxY6hTg4yfslmQUi6n+2CFfp4OsJlbIXlzGRqg+z+rNo4V9teGhZLNqP1EYlgZgcWwd9MS6z6DIP6iTjswFQC9VZ9emrbpVIOB6apcf/E06q4nKzxJRQyJwasbtYMafIHZO87riRqzIntgOfNxhozs9VQCeC+NBZJNkXw789ZqIB7LVC3Jk91nqxdsZMRKiOc1FCDQHJEMunK+xFQYeYtBHWv+sDeT7bS/GdVgF32jsaibqDb/mkAJpEDU5pjC89Pg7sEZhUT1U63RxdUZAgnkvRt9hT9ttqGQKNQDT0gqsqq7nT3lF151BSjrjJCG0WswZ6nmNpTfhh/2LELLZsKW169070AegjK8FCPukZ3JHaRAifbSanUqCEnXqu1BDc4xSuGRfVVZWBERL4iwFgIdo3GGxvicLeCiK4wkFTf+MvFZzuQmhRytZLUqQHM8BsmaJHyjSnhrYOpS8hPHqmPf6MJ4jUbbqt+6nAgMuSYsbRw8Yw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(71200400001)(7696005)(66946007)(54906003)(9686003)(4744005)(8936002)(91956017)(66446008)(8676002)(4326008)(66476007)(66556008)(38100700002)(33656002)(86362001)(64756008)(76116006)(2906002)(478600001)(186003)(52536014)(110136005)(55016002)(83380400001)(5660300002)(38070700005)(6506007)(53546011)(122000001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HIpRS59UUQRAummlW68wJBpKxpuAVmTsnfS0yK0cedMC66l5HlD2L3loIIKP?=
 =?us-ascii?Q?U4cTo6jKTgX+IZ4CIuWcVD7qAV3D2jsdtHlEY8gSwHK5mzcjyi62RsxTdRYT?=
 =?us-ascii?Q?8Dw26CNrklE429xDoIqiDQFReswTD61QHCTOwMwUHfMunZ6yL/mxfKvhvS+8?=
 =?us-ascii?Q?mWk9aqXim46PABJyb8SivE51fimX0Xvx20hD3UM1YKa2H56cm3ZTFDnleCXU?=
 =?us-ascii?Q?EYlXE9dpsbHl3s+D5vXDkh82zowB0vXcZ94oDrCfB3UrxKp1S3uVjUihrLK/?=
 =?us-ascii?Q?imfa5XZRna0zcvb+GhlTUzapRq7wgVpKLzt/zkUXu2oJ/wKJRZ2MhNCe1olc?=
 =?us-ascii?Q?oS9hPO8MdKhJAoDbFnOAxI3o+mxyAZxxpNWjxUjf1BsQbQdCatt+mqzuyaSB?=
 =?us-ascii?Q?YCmuMlJKeQyJox53e/tDhtAMVCIqpFjZnX8JF2Q5TKCgPJsADt1LIYzuUosp?=
 =?us-ascii?Q?FZqivxP3RpqkINeMFiDQrBbpLvuEenoe7bnpbwxbvjbfrPOyJ0+9yOPCGKEn?=
 =?us-ascii?Q?UMDVbzu6q1Y6gmJJ2jbjXoRn799dpYvaGMkNS7hX01YPdOW/g0pX3ZnDfKbm?=
 =?us-ascii?Q?o91lqIRt9uC8DTQ8E37sAdDoZHmx8k/8qhHDqqupJsdFBNDI/0KgJuHEpZR3?=
 =?us-ascii?Q?fnlDDnY9LEyprQ6D8uFeUubgNwJi8lnIKsK1xt+cs7UO1CvvPHGu74MYEnRH?=
 =?us-ascii?Q?Xp9XZtLlSdLh7tGRemkEYmMdzm/ZnZkCK7TRgDFqSyEitIgfNy88AWGDVrTS?=
 =?us-ascii?Q?BMlRstg1iO19W5PLbDJFnwcsoXj1ecWluadsjEGwbZO6m9xUbH4sfgY88plT?=
 =?us-ascii?Q?ge/8xC9eujWcr/V/vkcOXkFd/bpAjrNAgnANjpr6X2GQrjXmI86CasCS4CoO?=
 =?us-ascii?Q?faQcveclCXdkgq2hajdICfj4an9BET/6bMZdw2VhJCZibTUYDxouwkshteLm?=
 =?us-ascii?Q?egQDwl4oIrosKxUZiT1ddqs0skZA3wLWrQM0iBfnCUBPqqza+HC/JdGlLWHv?=
 =?us-ascii?Q?oKnqr4CPh4V2HLThPUDENkfwjgLUEOW6A2auwGY3mazD8Kujv5/CfQnrWnMA?=
 =?us-ascii?Q?8sNjXommA1dVA61Q6lsQOFZuwDCrziZpMBG/QGe9vLbJXmla0qzW9rrMV1uf?=
 =?us-ascii?Q?n9s0EgDHlYGsDf3OgqWv4bpNA2enyJ1zno3TBxWsoGMH0AXVTiufGlviYNyY?=
 =?us-ascii?Q?DaccSX/5bL9Y1etx931Ahj5ca8rJVVdpZ6Th2hsTCxG1kebyn5A3kROfInfT?=
 =?us-ascii?Q?9Cn4uCAZFz1/1DXIoUkNkk82OqHAUh0cHROKDpBPkOZ2tEpOtB1D+Uqv56UB?=
 =?us-ascii?Q?MLE4qxhW4bT26UrvQITjd0olF9F0tF88hWz1bcsPUgtrhQJXQMRvl1z5NLJY?=
 =?us-ascii?Q?ksglgfk5LA7Ixw3CJTXjY6LGOADKcZXLZ7Hq47aofL6Jg/qNLQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5376da31-3473-49a0-ae11-08d97c147a5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2021 08:56:04.1666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e/Kd4CImZazsgmLpj4D9XXb3FqCaIQ2S+4IPf2fEXT0CiEXVv7J1qV2NCvlApERZ/27lIWiqJpAWBRZfr8yiM0Mji3j1kvBwIPRMbR6YDeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7671
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20/09/2021 10:48, David Sterba wrote:=0A=
> I found the following lockdep report, it's been with recent misc-next=0A=
> and the functions on stack match what this patch touches but I haven't=0A=
> done a deeper analysis so this could be a false trace (though the=0A=
> warning seems legit).=0A=
> =0A=
> The workload was some file creation/copy and relocation but I don't have=
=0A=
> a more specific information.=0A=
=0A=
This looks very much like a lockdep splat I know from zoned mode, but assum=
ed=0A=
it's a zoned only problem and pushed on the task stack. Was this test on a =
=0A=
regular SCSI/SATA drive? =0A=
