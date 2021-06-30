Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCB23B8125
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 13:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbhF3LUC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 07:20:02 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30817 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbhF3LUB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 07:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625051853; x=1656587853;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PjeRn+D+5HMTawXT+6z06iFHeE1iks5YMrysAviIg/0=;
  b=Ko2WC0ay0AqSXpv0Ffqk+T/YzjJsgugTMEIWii8LXZaTchGtmWZMVliT
   yFeZwgvckyF4VqOR/GgmTOhmNV6FrlYGNrBvGBtO3ZsaGvNAsFsmWM394
   NyxoomfR0E/7UUn+3LiDwlqC7efhVe8X11CDpf3Ge8baiUgAfrkfLpOYJ
   xI2W8VrolC64bch5ZE71oyhevlIiN9F2xijlYCMiNc0f9n7zZY9S2+t9a
   cv8mqvy++aN1Hzs77peVPBzPAdKNqfVxz4O0LNKwCpVpebK7zOj3/GbPA
   ZNyvCtyL6+YXDFjnpi0l1EUcClBFEnRoUDZZ390tpBFUTNQlZQsqnwkEF
   A==;
IronPort-SDR: ruF9ZyN4p8pineuZYEOOjhmCvWp9GTZ7JD3v9nv+PeDFb1vLIatdLRqUu6/Lh8M/dzw6pIUOyz
 Wmnfox78snSn/rVj4Au5dJWJrOpv2kDW/a3ZazXQgUX/AUwwfTKj7A0cJ4vkTGIeyNzhaDo5GU
 W+vwfOVDzJdVLJaiBZqmhzX4LfhDLLjJ9LuGj3sxH+FuGnubnlMK3YOQonK4hOcScralilG/Rf
 c8+GhQcnbBrED65Vd1PPsNBd72p2nBWaROzT7wFuiPdAZOx1kQMdtDH/fBK+IOM5ebr1nO0Thn
 QcE=
X-IronPort-AV: E=Sophos;i="5.83,311,1616428800"; 
   d="scan'208";a="172566944"
Received: from mail-bn1nam07lp2047.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.47])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2021 19:17:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNfFMI0K1j5fnDqU6EtGdfn4PH96so/jX6Fpum8aBSwVY5yIKvi10+pRm7qvgoc7zzvxuetl66tto5hyL7nXWxl+MX+tKhxLzPTO56BlZrMfaaMW86zxV5q9L2tFGHCg0UiCqFRnxCjdlS/TqxiXI/E6DSkTFS8yIqSEWJTOT+PlWMCanSBz9ZkYCXn++5LfbXctjpUzLWB38ScZGanPI1lPP/haX8tIEt6FlDByXkcEV8s+BTHgkABFToFiXq544BbatlCnfWzCbP3LxKSyBTudXLRDv5Bqc41xk2AMDlztQb9jWt5XblivTlNF8rPHHPpbyCSnfwlAGYXJhjivnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8jH+dUYYr4lLCeoyji5GdxJj6YPqW05hSOdVg/XkyE=;
 b=hZfq8omhlaZvWvT8mxLNsOqhpGvfs/wrFzRzdFcc6shOviQ04dXM/gCBIT8gpkAOLMDpbzquIv0rOXnyDsqQzzDW5q8iNlcmyR8i5m1wzCVXZO2UdaTQkL9Chwzn3OarTCorUdmB0nSC5x5cFgzcESLdickntejGY39QAQPRS0Fzm5JjYwq3mEeePo6/EvapL2//L692N1lZCOzQkCFLiBDSumOc2UvfphCC/80qYBgx2CqtF4j6kX0A+zzhCeDgQjQJNWljo5a92rm6v2s7n0IZ3XbrTWyibILkhRor8auUp/6jBo45wihTYABR81T7PmfivMNqAb2cPbUK3T2Bag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8jH+dUYYr4lLCeoyji5GdxJj6YPqW05hSOdVg/XkyE=;
 b=DJ7tovLDW4IvnjlKgczfS9N0qJWAA66LJg2v5WHjzF6264lioSSBP7Fga2S6frLqkq7vwdlm10CM2xnFT90a4H0lf7aN4F71+cOict/gHpI3CXyQrTubgk+ZkF4MGHY0rNLPYose9KIJLHEYW0QTCW3urNfcbzfACI2U4Z6MwA0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Wed, 30 Jun
 2021 11:17:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de%4]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 11:17:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "lijian_8010a29@163.com" <lijian_8010a29@163.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lijian <lijian@yulong.com>
Subject: Re: [PATCH] fs: btrfs: extent_map: removed unneeded variable
Thread-Topic: [PATCH] fs: btrfs: extent_map: removed unneeded variable
Thread-Index: AQHXbMQAzBmALZ3G+kSY1PzHly/n7g==
Date:   Wed, 30 Jun 2021 11:17:30 +0000
Message-ID: <PH0PR04MB7416AEA4D23FAE000C86DF729B019@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210629085025.98437-1-lijian_8010a29@163.com>
 <PH0PR04MB741666CF29DB96CF0DB0C26B9B029@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210630095923.GH2610@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:156c:b201:ec6e:b732:eb2c:38fb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1473a590-205d-465b-06f0-08d93bb8a696
x-ms-traffictypediagnostic: PH0PR04MB7416:
x-microsoft-antispam-prvs: <PH0PR04MB74168309727CE2CE6A63E2899B019@PH0PR04MB7416.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lC/yFNDoao3/Ub2SFWfrMFQ6yItJvohJe/Zuw2dCz1oxp4DwCijWoOvtjlwQnrnvD5dxftOlpSyPV0uUWJljUxV6rTNlZ8RKjcWx+H8K6Tx2MkIf0bYMzXekT2OQ64XbASFH0OxqvRIW9mw7kPIGomqhAR8aUzuQRY49+lapuF9EnE6Fubigk8O+biFvO+4Vz4QdLtuC8rS5grTwFZqaMsnrd1w27vCMUE5uu5nvfLfHKof4s7LS18Mq0mWSUlrsiahGciPYlYPakERf/b9kzjnVrlrj4RNygtdgzIDXYQDIXLZ/JnFIhCM7eAlUDk2Kr1Gsx/bMTZjen3WBYmGqMJlq4Tuv/EC/5AarGC4VmxFbn+G6LFS6KKgC0+83oxIRBzX9FEvlYWdY/uSnoEdKBSZgWKKYtLsjKVkoV3eKwd4DL5iUeZxyTQgm1Vz9NJ7l06Lm/47wDq/LD5tx1puU68wKCGlOC1b5MxQ8l1xRNxMSRRqnUqN6cpcHb98QYMWLS+qJ5Eomj6+rxvTmgD53BKHPbEJ4LwNWSrUOFHGIFtQlRES/1daicE9kDPRa5WGFuvrxcAVjSg4EaM9B/TAgrC3SgxJE22vEEQXQbYqb9xz8wjjp03iUfjSqhBBF6/DU5zLy12SLYY1nXrGMU72o+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(316002)(6916009)(8936002)(38100700002)(66476007)(76116006)(54906003)(122000001)(33656002)(4326008)(86362001)(2906002)(478600001)(66446008)(64756008)(66556008)(66946007)(83380400001)(8676002)(55016002)(91956017)(186003)(52536014)(7696005)(6506007)(5660300002)(53546011)(71200400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BBVoBYNjMT7qBSPXEevXHnMoCpUT/YZZ8Qws+T/n6G2ixsi1sCOQIfcK/jKx?=
 =?us-ascii?Q?6gkCTcIzp01VwXHJgw0XSgiRIfR7K6W69vg/9KjhLmkUMxYEsBTwSyG4LvTJ?=
 =?us-ascii?Q?7Zi7oakNvLS7oYLnzvi9ZnVSF4NvZWhOGyybtru9nhsdce2CKo/Kx0Y7DMoK?=
 =?us-ascii?Q?ptX3pJYYCxUlAOqvdTXpRB5bdCoQQ/rEHzTW+kw5k1K4LcvS6tgjiLxkuqrd?=
 =?us-ascii?Q?bQICNZErQhHnNBjLl4lcuYIjlQDH/wTHY8bfS3uiWSYTsqG8/1p4VLFOXbve?=
 =?us-ascii?Q?U9PYLB+ltKhWBtwAWhDdBi1k0gKNrVqqS4kuCv289gB0mt6jrkJCJ25YOyZx?=
 =?us-ascii?Q?0kshdgXPMqX7oe/bqsuzgal2r5YXxeFe1YRcE41X9ntM7SIWud6zLWUWXaFg?=
 =?us-ascii?Q?5RmWh2XwEamqsgGc0uP76FlEY8b+0H8LrHFYIbNA3b6ZVe0qFzyR58T4x/74?=
 =?us-ascii?Q?sI/ent3FxSC3nnRVabJc9KHgv6jlqesxhP6gMwOgi38ZyTokfGN6UOboRWqX?=
 =?us-ascii?Q?glsiRzILXieVuEC3SeWRs9Rw8PqWVcNS7HzFCw8G43Pwq3uaZl14D5Pculrj?=
 =?us-ascii?Q?9fMUbj0xqy1Zem9y4+Isd/zQ/1Z/10l6xN5ejcMGblWxKJ3w2mseNEOyWd6n?=
 =?us-ascii?Q?v/iPp31TiQK8O8l69aNSwLAlL7FL1wC7gDbl/b0RZ2NHPRa0ifI/aY5pzWx4?=
 =?us-ascii?Q?CvZWOyyDQrQ2M49/XZAe1MTlxIAxsscFRw7/crCeq+hiClCZRh0IFi3ZfG8O?=
 =?us-ascii?Q?Z9kMChZ73v7i+TM8XrPSggzwWtlIK8DyKzkcN/afEYktDsYL6CaWkGr2q0ug?=
 =?us-ascii?Q?broOZ+hR7XUt/xrEXuCLPtvJz+4r6VvN3bn5/JRjjZ330TorBI68bA4/4yyy?=
 =?us-ascii?Q?T1dmfaLcdrFj89UfgWdseQrHdR+mTAPM8yMwFf2CpRFbPVCmilTpN0EU0k3J?=
 =?us-ascii?Q?IZEWfFutruJEyX1c0GeNYt5QDhI13/eBmYWX9UbJlaW0LYVEQwyBQvR+NQkU?=
 =?us-ascii?Q?p/YtZyoO3Cub3TWlQRpqq3O94oUkTcggzR4HR1Y2p+mUh86z2+fyUTlyNFA4?=
 =?us-ascii?Q?wWFiuLCTqZJon5VOI7mycCfR482faqOomAnAR4M+c2MvyIde4EJigNJ9wsDq?=
 =?us-ascii?Q?tgql2at0EkXFa+vdBDifHmpczcEgkyDZXaS+/neZf3sRpAczEE2EHU5RkVa9?=
 =?us-ascii?Q?tYprOWb8Pv4nsBBZWojUjtklC9lUEcqhassl4kh+KRQRE0dp5ueoFpcrGdH2?=
 =?us-ascii?Q?fzsJJxe0wpqOWMuHGlBWmNBEPYDH8JUsVRFmLlPq0YkBWtN4ef8nEotNuNh9?=
 =?us-ascii?Q?y6VkoeMQ/ntnQenWiGSrfgm6VHBJu3nUDJLGxLkvoAvj8BJBD/tm9hPAgex/?=
 =?us-ascii?Q?bu0oWRHqgOIoKXsSMbzZq9rb8EQb/CAiYy0LI2CZikEkpY0Crw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1473a590-205d-465b-06f0-08d93bb8a696
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 11:17:30.3232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bCMfe9UcMgQTuJb8r8iWL7dtAoLS/XyYUqok3PddOfQxWKptd9B+8/fRZfITuLniQbW3OMaCjc9XcftzgSHvphKQqgTynSEdMStiKxVOtXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7416
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30/06/2021 12:01, David Sterba wrote:=0A=
> On Tue, Jun 29, 2021 at 09:04:40AM +0000, Johannes Thumshirn wrote:=0A=
>> On 29/06/2021 10:51, lijian_8010a29@163.com wrote:=0A=
>>> From: lijian <lijian@yulong.com>=0A=
>>>=0A=
>>> removed unneeded variable 'ret'.=0A=
>>=0A=
>> Wouldn't it make more sense to return an error (-ENOENT??) in case=0A=
>> the em lookup fails and handle the error in btrfs_finish_ordered_io()=0A=
>> as this is the only caller of unpin_extent_cache()?=0A=
>>=0A=
>> I've actually tripped over this a couple of times already when =0A=
>> investigating extent map and ordered extent splitting problems=0A=
>> on zoned filesystems:=0A=
>>=0A=
>> 	em =3D lookup_extent_mapping(tree, start, len);=0A=
>> 	WARN_ON(!em || em->start !=3D start);=0A=
>>=0A=
>> Maybe even turn this WARN_ON() into an ASSERT() when introducing proper=
=0A=
>> error handling, as we shouldn't really get there unless we have a logica=
l=0A=
>> error.=0A=
> =0A=
> If you have real workloads hitting the warning then it really should be=
=0A=
> proper error handling, not even an assert.=0A=
> =0A=
=0A=
Up to now it's been coding errors from my side so I think it warrants an=0A=
ASSERT().=0A=
=0A=
But still we should handle the error in the caller.=0A=
