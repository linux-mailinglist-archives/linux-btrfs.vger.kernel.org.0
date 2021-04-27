Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216A636CC0C
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Apr 2021 21:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbhD0T6v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 15:58:51 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:10328 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbhD0T6u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 15:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619553487; x=1651089487;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qz3MoYEyapYzve18RQ2F3s1xsIy5ZTJNWsyFb10UuR4=;
  b=atUdIzJ8SDMBDQwbwvwpPxXZxLVIB++ilmPfxLwbvniVvobOytdeDm+m
   I8yGX/1VjAMUHwHBNw83LWuhKFjo7Jmj8qSooac9UqJl6/h9KJvnC+IVP
   wlJGUMCBh2Wf7bBvjSyaRxv6jBbK6crxJgLE1AvMnhjoYltQqkK8cpXnx
   JYQpRnhAeWLLcFOfoOHMcasLtsiJMQQm28S2kjGF2havOZmuo+dKVYrJa
   JuMuVfSel+Y7zbgNw6qwWurNyOZmgaCkgXG5v1OxoStiyyDX3ujiA0zcT
   +B6v83c35yPnG146Y2mkLOeNO7lwfAGAjq7XyJLOJvs1B7xLV9f9Z+UOx
   A==;
IronPort-SDR: GAtyZzsFDEQ71J+qpFuMvApP/bvsIVRL4x99WMUje7N1TJr6fK7UuNu9Hk8GJCIXOpFE9OZvWr
 Rbtip84tvy8dxA9/yhf/TdRP7HIzcoC9T6rE6lzHfPUNwNrqhFnJUddEkkr+Fe5/bKzwUVRMpy
 Yo1mrPXN33LM26BAQ2LkALl6bQWTT5yZbzxQRITBWHC6Wt3MlbJAwUHoUlAn1uhdoGUYwFzMzc
 7RYih5mW4OMDf1XBRkEUGk5ZzA8EyIzDl3YQnbgWQCj+9xsdshMKfI7aTDAnXxQxV+ZpGIzDo2
 Qyg=
X-IronPort-AV: E=Sophos;i="5.82,255,1613404800"; 
   d="scan'208";a="170981379"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2021 03:58:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rq13ULAJzCXjQZTwCnd50uG5/5FR3hbA2m4fEHoDqFIvLJxv5W/4W7iyvHEKfynWv4/QYwLO4n+MxkyQPDSiBs7TdOd6RaG9MMZ3B5im1HrvNLM8AajaURyqv5EUo1hycW0nGk5NclCX10dkfEM9i4RklzTFGtsNHojOyi1/KJ7b5YNeoOsxH9pHVcSkm+hAEP/uKlllPaAW0xeXStUq4ukLpP1WxhU/qGS7OnruxUTT/6l4AIZAIFAdZuTjfpNBz/rp9ryyR6oSToNNKmFrjn13yjTd2U8hhrpl5r6b6HRpwowrX6kdRo0ayqH7Z3JXqk+j925msby+GV7e2lLGcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2XPyNpRRkpBAV0P3bVuY51TkYQ/ATgEvTrl8eiycsM=;
 b=R0Pezbxu2Iud3k0+91x/jNa6DvtWSjjWKkLvww1wPAV7JpsOX/PDq9jm6xWZ6Xx7NZgdSmpW4wzZFbB8RIkb9tRh+6f2eyYNZXudpgoOtvswnpq2nAmztHBTb3jQn+n4yYZ19LGBG9LjGFTDViF3mqjm6lj9aTIr08Npvos/HwXAKVQ2sSr8v0rv1762EdBNk/zvZJD47aN+M2cc6h2cwVuu+i2iGLnjoUh3sbIKsKA0vcbrhMgaOeIMZGfZxNhJdR1xXJ+bKSovxYjR9hvDz+ozMAQt52FxjjWxj8WbqOnCfNYxOp9emOfDoZ82L17sbygZ3KaXABNVxhn66y1+pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2XPyNpRRkpBAV0P3bVuY51TkYQ/ATgEvTrl8eiycsM=;
 b=B1MauyCpcqhbgYiphMQo7WvVXGSaFUaPt/UfMBH6+r4uclB7xySptCMroTofvpZMFZXrHVp5eg82Zuo53PeoooBDjLGqq1R2mhsIPmCAr7jrfKSB+CG1mC0kcIVV/nGoJvEgi8djym48eLxnTy/U8AQ3+wf1S4A+a8TPDOIQx98=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7334.namprd04.prod.outlook.com (2603:10b6:510:b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Tue, 27 Apr
 2021 19:58:04 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 19:58:04 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 11/26] btrfs-progs: zoned: implement zoned chunk allocator
Thread-Topic: [PATCH 11/26] btrfs-progs: zoned: implement zoned chunk
 allocator
Thread-Index: AQHXOmVvClKo8cft8kCZixJS7PEBdw==
Date:   Tue, 27 Apr 2021 19:58:04 +0000
Message-ID: <PH0PR04MB7416DB08383BAC7C36F4AB089B419@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
 <b60a5f40ae0072ba9c7f1ba03036a703bb6b81ec.1619416549.git.naohiro.aota@wdc.com>
 <20210427171911.GM7604@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:8801:d92f:f227:4e35:fedc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd066383-23ed-41d4-b693-08d909b6c549
x-ms-traffictypediagnostic: PH0PR04MB7334:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7334B77F6916C35CAE46BD699B419@PH0PR04MB7334.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pS1JHTHAE709hd6VA3wpTOoFjf9s3wEuVbYBLACkTnPB6UD2G8lgqMNaZ5EenE0MNj3FVgSqfFHmyoOqhQyQzry5x/TLgKdKN5H5lexx04kALp++AJBg0P2F5XaDZiMTrJmIQA6uLCe1i27k6f1lfWARuQSOJtN71GY3sUKviJFU2GAMf0nm3l+8pOHXG8YJf8SLbzCPKykZl3xfYGi3FfsTskc00A0puhyeeetteq061t9EfXIb8PdvwnxkADrQr/cgUF4XtqH8CfDoA3dZBrsGaSY2nDP13GbH8rT1hVIKVSBauk3Z6zA8HbEzCbOjDJ+tjtNxfSmuq10OLC5+/FiBQJoZTGewM+85T303N2cBwJhEa1gF4VWINYVKwnC3yTfh5ZP51yDPLtNoqdt0GaRHnYKxRXG1TJVABd5UkHTBy6aVZUGQHFzrUvyIffUtYb5+x8EDS2BWFzDMDDs57S5FPgUVTZYfVeoIR/xtiXlBuThKVwIqx6OlD8HVT0us5z68K8rNEH4ZuHKWEZk5BLT38J52B7O/Dv8LFWr4x9IoN89q/Il8n0EJqU19+RrOnanhp6X8c+XjBX2tLbqhqxMjenSUvRA8ydWOv352Q5FfK9fEjxT9WaKJhN1yOHSX84n1Tnbrc59sQOcCDk4RPcJZrZ3yBPNIFI/relBWb4kIUIPe4vqKmm+qKVwjmbgH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(9686003)(33656002)(5660300002)(55016002)(66446008)(66476007)(66946007)(4744005)(7696005)(64756008)(6636002)(91956017)(52536014)(8936002)(4326008)(186003)(478600001)(6506007)(66556008)(76116006)(122000001)(38100700002)(83380400001)(110136005)(2906002)(54906003)(53546011)(8676002)(966005)(71200400001)(86362001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ZDTcpLr7CUEqv466ua9zSPWPdL3SLXFLzQRZmkvTX2qjTgZOdGYlaqHQLrYg?=
 =?us-ascii?Q?etu9bcBuFXNx89Q+HOiJVDwz1aBe2YptXR45elv+PPW+VmESjKaSO6ifBa/c?=
 =?us-ascii?Q?VkhS6JuMBC0SgVKdLLkoQcvVFYPZTR14U/2ZA+g879/R6XwCEWPjm5m8nKEw?=
 =?us-ascii?Q?zMouws9KmCkDqg4sVwdr69eV+sflyQtSj8u7oiIKFLt6xShksCXy+V5ccHGI?=
 =?us-ascii?Q?33g+cXZmkCgyy6EU7+ziiT91fzOVttNtvcW3IkdNCRnxDvvw229OATrM2WOD?=
 =?us-ascii?Q?n35ztg+/pW52rO/jPfKxJTPnzHBgQcv9HlaOojUFzd/y+O9Wc8WEjpbRNM0G?=
 =?us-ascii?Q?k8Q+iOiC9sx269aIJLLbQj+33JTvq/JJ9cGmLvVxbEbFE7oOIz1Gvd4LddWS?=
 =?us-ascii?Q?pn5joMPFlOWxR4cYArVV3O2Ly6vYdFgnoN98DU4k2akGBqENP6Ls+Ql+BYSs?=
 =?us-ascii?Q?1GQuPkyHAFloOAewOGrJnc7JEk5LJJWPxj6fiK6fvQs71VRSZyVSbfTwp3Xn?=
 =?us-ascii?Q?4XGhTLashbTl1ZJdcf33rqAF0nE7W+hfON7bYqWqPJXYjo+wkfwAUmbcLloe?=
 =?us-ascii?Q?K4Y+hlhvw5vzK3PdH0ylRAGCaITVBVAzx8gQEC+pBtGwoGMJe9Z2/JDn4S2h?=
 =?us-ascii?Q?a8187SMkiqEgWfEkWawN8YlPUi0GtE7ACM/kAivfS2ssMVDqA3hQRN9tVB3E?=
 =?us-ascii?Q?PSp6TeYXsagnw/7aF09NR5ykuqeez4ObcbVMKb33Hw2Cd6+bWadN+pqfQI8x?=
 =?us-ascii?Q?jjEM9k0meM+6nY9VsCY9ObvDSKRBQSbR5HbvUnx5XiGHMKglBvMkSgEiDjl2?=
 =?us-ascii?Q?7SdapPdGVz643W+Dype0VwsovQecHu8cBZbSfYi8kqgd4HcPB/7L2bt/BqTM?=
 =?us-ascii?Q?lGTOJc2QHot5sNZmF5qJfsPVXoSrECidgTO31Ru9DUQ6fzS8/Ktt5Cw8MRWu?=
 =?us-ascii?Q?FckpIs5qDLeADS2U6P8MhLVTselXWlnxzz2HnIvK1T6a6EJj6QsII6MDSrcg?=
 =?us-ascii?Q?f90iekiQnprb90gou5db/3tTWa/PVHO3XDCPNiv2aSnRuFqnyOJhODiQAyAG?=
 =?us-ascii?Q?v3yhkwjQ3DtuT1TlSUAM2Ez0VfwB7ASMHMiWJWaD89hfHA+VjehrwD0BEZzh?=
 =?us-ascii?Q?M/AnLk2iPKGNhItCW11Be1W0bjJRAIfixMwPpQrRSWLNZHXnWDO31Rw/GAr6?=
 =?us-ascii?Q?ntL+T2pHYiMBwV4jWiGIfppxihNG55FT7JD2V2HDm2HX02/9J5G0wM6Xwijc?=
 =?us-ascii?Q?jWmyn7WUOKeJSsranVln7DMVnlASzGqF/sWtyFb9RKP0m2BU9dJ55Vt5wI7g?=
 =?us-ascii?Q?Whb3xUT7I0AGIYhKOd1EErR6ZA49iWLqk3RnLqiZ13aokdM/JftVPINy0E1s?=
 =?us-ascii?Q?Mmjfyl/rvqSTL+X4z6SujOnJQ1opcPJPJ1wi8Rd4JkBIilB4Tw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd066383-23ed-41d4-b693-08d909b6c549
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2021 19:58:04.6762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hB2lfBUKz1DYz1ceIsHn0ZD58l+94KJsdrhdMBrbxiOCKRe+rLe6nCIo4yjeGCseh35KGYievBwPgcuokiwwfBPF1/tD3dkq3+dK/Qno+ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7334
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/04/2021 19:21, David Sterba wrote:=0A=
> On Mon, Apr 26, 2021 at 03:27:27PM +0900, Naohiro Aota wrote:=0A=
>> Implement a zoned chunk and device extent allocator. One device zone=0A=
>> becomes a device extent so that a zone reset affects only this device=0A=
>> extent and does not change the state of blocks in the neighbor device=0A=
>> extents.=0A=
>>=0A=
>> To implement the allocator, we need to extend the following functions fo=
r=0A=
>> a zoned filesystem.=0A=
>>=0A=
>> - init_alloc_chunk_ctl=0A=
>> - dev_extent_search_start=0A=
> =0A=
> This function is not present in current btrfs-progs codebase=0A=
> =0A=
>>  static u64 dev_extent_search_start(struct btrfs_device *device, u64 sta=
rt)=0A=
>>  {=0A=
>> +	u64 zone_size;=0A=
>> +=0A=
> =0A=
> So this does not apply. Looks like some intermediate patches are=0A=
> missing. There's more missing code and several other conflicts.=0A=
> =0A=
=0A=
That's probably this series, aligning the user space code more to the kerne=
l code:=0A=
https://lore.kernel.org/linux-btrfs/cover.1617694997.git.naohiro.aota@wdc.c=
om/=0A=
=0A=
