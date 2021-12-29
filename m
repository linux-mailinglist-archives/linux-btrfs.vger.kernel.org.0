Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7563E480E3A
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Dec 2021 01:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhL2AWf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Dec 2021 19:22:35 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:59194 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbhL2AWe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Dec 2021 19:22:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1640737354; x=1672273354;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=XFIPEX2tKM23pvTz9OiMMlIVFmndcmZnQO17lAj20QI=;
  b=S8ni7o6d+uTV+8HCFRizvH2WRqDtCXUYP9ebts0nlfvMqKqrwogGWTti
   +89PXjjYue71NcOnj13t+NlTKHKUJYkrsgBFmm+ndzWzHQrJgjEuheCAr
   S/G30Y2T9UCAnWPAsyfVOEpIOkRvn3nLF8jJTl3DKRpT99SVMkvyh6eiu
   qBrVsVfebTQsIVLO+FZYfVWuKh2QnQURloujrgz+pIhVONtG+29ZhmicZ
   gsjCzdWXvefPsPubiZJwtGCGDFfSMBK3fU0B8jkgJbF2wkheD9e5gUuN8
   U8SnvlzM1Yp5F71ts7CqgzKkscWhYu/7NWD0vhc5p6auCB4sjUgWCW/wK
   g==;
X-IronPort-AV: E=Sophos;i="5.88,243,1635177600"; 
   d="scan'208";a="190300889"
Received: from mail-sn1anam02lp2044.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.44])
  by ob1.hgst.iphmx.com with ESMTP; 29 Dec 2021 08:22:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bgp/dAq04I4rObPRHjHIs9x0edyf37QVJxnlWXVZeyVr+a5MlcZL2YhU+i5ewVKtMhE8qCmGSQAcjCUCR9O4JYpbg+Fjq/PK+Y3hR1rPiBM4g678A1uQRkxq9l/s2sbe9H+2VDmUU/fJFSPEmMtie2ywM6d3ezJG7QnlKS/uXlibQJIeYIEgex73JTWLzBOzput7j4lC7SqaEUgOJVT0ySDrN/vl1SSc4JOIRjABNay6Pn76TwEBA8wgWRNcDqp4Si/LfdjtiMIA1Xt+JjnlbXGXazNmkhjCdIlAkER7X2M1TvIT3kCxYe+AHubeKOYLw2i4KHgFZa3Wj0CJhg2jvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cb8ZQTOFRyVcTV5GH1wBBXtOXt50F02o9DOQUNLgAxs=;
 b=j0HTZEXggWTlWR/b0WMyRYCq5qGvzkdtiMY4DhBd/3jXxgKfZNlpJK2G5cq8kSjky/LieGZ/LGK7m4YBZbCEDMxKV15kaaApxxvHM4lOFfGMPtlFbqvPfuo3piU8wta4LuqdKsBRDEXIO0J1kfacOUZW31XkQShtWCJf7qEXPoRLT8OpksPtzBuP3lDB542SBIL4uxDDGm20Mz2NaC2dleFjxGg2V5IRYUPVa/vU6ybSfgM6ZtB9ARq+kK6nrz7uW2AH9X4S3DT/AThqF1Ba1X0vEWwQyOhO2PSocnflH8G/y5mfDVvfC3HqLJNLpQ1h9f4KgxMHmw4gTeNQAD4mKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cb8ZQTOFRyVcTV5GH1wBBXtOXt50F02o9DOQUNLgAxs=;
 b=vl0WfIbGYzgNBOVHodErFDktbbyJ4qYm38nAi6TRfq0YR88kygRs99JV6JgZOFPIaG9G0Xgjd4Srsn3wKAduvu1FEREn+L2u4fneWCB0ygg2awwLG4eEHIej/lojiRXOeNXNf8jNAa/Z7PTKI4FohYJavMgAa1fYZ42ghMUWXe8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB8071.namprd04.prod.outlook.com (2603:10b6:8:2::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.19; Wed, 29 Dec 2021 00:22:32 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::51ef:6913:e33f:cfc]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::51ef:6913:e33f:cfc%6]) with mapi id 15.20.4823.023; Wed, 29 Dec 2021
 00:22:32 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 0/3] btrfs: zoned: fix zoned extent allocator
Thread-Topic: [PATCH 0/3] btrfs: zoned: fix zoned extent allocator
Thread-Index: AQHX/Eor2QL7xhF92UG0W9y8378Z0Q==
Date:   Wed, 29 Dec 2021 00:22:31 +0000
Message-ID: <20211229002230.6qvi5jelmitwjvlz@shindev>
References: <20211207153549.2946602-1-naohiro.aota@wdc.com>
 <20211208161814.GL28560@twin.jikos.cz>
In-Reply-To: <20211208161814.GL28560@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 880f97d6-dd34-4ed9-932e-08d9ca614e18
x-ms-traffictypediagnostic: DM8PR04MB8071:EE_
x-microsoft-antispam-prvs: <DM8PR04MB807166E813722D80F36FE3E3ED449@DM8PR04MB8071.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5UQupanluZnXe6jtHaK7q5sY4BFPqd5AbsNyZ3IuckDY6v2tf4CKf7zkdmWuV/iwsVidWTRfOSW/ZiNiixrlTJ1acnRPw5ZTHWapLNfmTSWorUHxS8E6o5+NDzydoaOZvU1mHlJOVtlQpdCsAnmBgiBHzv8OZU5+yrONcGWnuZSjUlqr/FKieNHcyqP3raOpzoJsF5avs8Gwi+vYcqund3qgsOwtIUnx8FZ4q1SZ2kqxgSmiINgSjP6HImGXTxhuzkKWwCmClq5npaoCt6ithQU69TEfOVweqQgYjKiPkfOtfFXkLpn3se756twOzHFVhktAMkVNgH9o+6YHaU2rPeHQFwdEmEeNezaSa51PWnb59Zr9tclqvh7inhWNHtdKsyb7h4T0vm9v4i8OKfdFjTG68b5N//s+w0a49wisxAojcKIu8I/moN9Cg3fb+YZzA+9lq1DzxgZVilOrEQlOYhJthDmw8WGTu36Q3ZmKSAhnsfiO/VpiLfpZC0koAt90RFwSXn6TKkkzZb3lL0UjCCudVZd/gouuaPhHStZ3ZzwBzG3hFSDtgkzc4pP2TaMjZ4fTjrcLxe0e6dzLyQg8ZYV1Hnn5VEgM2UCJ/nuJSeoOjRrbxoqz+PJvY0I0LWGhVI8DAgWjr1wePEz0ABz+lOwPNQyBWT47ZEEpDUC0H37H7UtH474sJ7lRp0iFFPpHVmTaAYmTPnfYdZxmxDtZpE5xZ2Lgn27/ydUq3hwVrpMiI/aNO6YvVP0P0hyTHKSQDptKRkS70NHeaQWZBVb5LwJjvC86g8YIRxwM+vuGAYlZm51MRbpOdib7V5nK0V+UJ0Ia3IOXr55VbkSRP1eLug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(33716001)(26005)(110136005)(83380400001)(8676002)(86362001)(122000001)(82960400001)(2906002)(5660300002)(316002)(186003)(8936002)(38070700005)(66946007)(66476007)(508600001)(66556008)(38100700002)(64756008)(1076003)(66446008)(966005)(91956017)(6512007)(9686003)(76116006)(44832011)(71200400001)(6506007)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h/1HEcPuDBEGCl/gkliO79xcf2yfym39/YhRLMJx9+tFUSdApQaRfKPeOvpO?=
 =?us-ascii?Q?Wg4TrpHj+Umy5vTlz6nSj5rxYWjvFjOlZg8cizpWIJ/i4CRx2lQNNprr0SgM?=
 =?us-ascii?Q?iebnQGwE6fPReTgGDetODMMFG0uXbH8AGYgT3V9EfbVxSTHJ6DzHru344NCD?=
 =?us-ascii?Q?9lQlgl32hUe2U0skOz+d/F0wWmHRtFE09nqaADXYzLkAMQvFsGk0hNxttGvS?=
 =?us-ascii?Q?+/LaSgamsWb9wR9fM0vEAekzC1FYJURMcshFvbL+nPX/HHK0xabQucSfvb2s?=
 =?us-ascii?Q?fGq6MQVvrJJMbuor3MqjfyelGmX7Ueo3dGgVnelIe1biT/+/H9J7U/awLfwK?=
 =?us-ascii?Q?tkY6JnTV50Qsxzt+vGZhuHA+KJB4hrAPyxISs/T7aC/OJB6VDrYMe1isMg4i?=
 =?us-ascii?Q?mh0+xIxQTRBGDL1MtRnWfc5z+aQd9PYWO6ubWaQtIMfaclr6I5ldl/Q2XgRX?=
 =?us-ascii?Q?OgreswmbNLvomdDyG8yD3wSPwjyg2PXMEmgRyLMsQ10ktMwCgb2aztglkZxa?=
 =?us-ascii?Q?cE/tnNgRbb0vKW1E+vxiV62758jq/AkHiwjrt3/j/q2nG+Il/jllVTfZcaVR?=
 =?us-ascii?Q?6cBT+OraKuaja+z4yiQWViOiJYfXFq2q9k9u1cgKtZ2eLvoUOprP6f1Kcu/s?=
 =?us-ascii?Q?d33GLKzaIlly6YzlvMcGGxNp7DB43WvF9MneqxNGsuUQYUIh5JNj7y8aH6oE?=
 =?us-ascii?Q?zHF50W8cZE2msDsBIPA7DV/gRNcGs1KF58A1QzlGnJbOG9EEYEZbO1ziEVDf?=
 =?us-ascii?Q?BlYP6FiRtoeF1YOqgCnd6AiYeVgDckYbS5kcjUWLIs3/u52PU7zOfIuUZp+l?=
 =?us-ascii?Q?LOMo79wLPaJMTRf8EBEBfq7FbiQhkeIz9hwQOQ/E7A1E/HRK2eR3kklBGDZn?=
 =?us-ascii?Q?kIqqxHSvDNAubbq2JfZ0sDjcxf8Aawjc+eZxJm7nijuxxervLRFXE3vKXJ7a?=
 =?us-ascii?Q?d9GlRkVUGcOtQEZatPMmMv0BcfprfJFYREzlSc+W6DcydxToqlgFOwtN/FsM?=
 =?us-ascii?Q?Vy02Uhtg8ANCyE9LkEFeyneH4/eti8Vkx2VVOQGRqxSbG7W09GHZRts1yxaX?=
 =?us-ascii?Q?42qFFONAnvUBlf1dfEckuee3BqXTXiH2owMhRiJklIUjQsQAb/k1hghyIctQ?=
 =?us-ascii?Q?XB+OqH1+D0oZb9F34oTnCdJY3H5ZO/r1TVHRp3QkZ2ziGfB+8bAahaKWo/wh?=
 =?us-ascii?Q?c7szktBvnNX4ZCf5xRd44DD2RIQYZQN6UA2wepGyZar14luTOXyl9XSIFxBY?=
 =?us-ascii?Q?WDi/g/4htXvjyh6RGOU4C43kYHr4ejwSGU/xj//ex3Et6UvN4wcWiV9qKnJB?=
 =?us-ascii?Q?qTiA9icMVmLI/5qonx/orPpakjAwcmGuGkQjvBWOunWdrtjS8yNTkBp8qJzm?=
 =?us-ascii?Q?lLRwlFI3htc37aZElYyVIFrmv5xaKLqakV/Nh1R8FlQy8HPnTH8dG7UGimSN?=
 =?us-ascii?Q?iVJJqDCzZY/Pr6bhQvrbQoreN0faa0/MnsEWRVcZatCMjFUWVhKIqKXFaekU?=
 =?us-ascii?Q?pUt/MY9uMAH8d+KhP7Gf4OJjw9xlqR7QzYRakVcmIZ26GXsRciPtpuLRu6Y3?=
 =?us-ascii?Q?7q1bpxV+mGzFIeBEjKjXYdUfAVF4MqbPoy7LGqsq6QOeQ+SEoY64N1UxyRKJ?=
 =?us-ascii?Q?xXUEzeWSeE0M0HPRa2CQFVTjYl3Z5phJc5WO72p1fZfmjp0F+0eVwOxeSRZ/?=
 =?us-ascii?Q?X10Y83WuCEZr23sj0rsSs2niVcE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <633AE8AC0F5D2E42A04B876EAEA04E03@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880f97d6-dd34-4ed9-932e-08d9ca614e18
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2021 00:22:31.9726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jjQDTc2wmvL8a5QJWe8eY65wYGENuEdcAhEWbW6WNTPD7CtOBWfwKqRKNslVPOqJod1xTXScrMQSRKZy9LHJDnl5r6duhm7nrNYt6C4nV48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8071
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Dec 08, 2021 / 17:18, David Sterba wrote:
> On Wed, Dec 08, 2021 at 12:35:46AM +0900, Naohiro Aota wrote:
> > There are several reports of hung_task on btrfs recently.
> >=20
> > - https://github.com/naota/linux/issues/59
> > - https://lore.kernel.org/linux-btrfs/CAJCQCtR=3DjztS3P34U_iUNoBodExHcu=
d44OQ8oe4Jn3TK=3D1yFNw@mail.gmail.com/T/

(snip)

> > While we are debugging this issue, we found some faulty behaviors on
> > the zoned extent allocator. It is not the root cause of the hung as we
> > see a similar report also on a regular btrfs. But, it looks like that
> > early -ENOSPC is, at least, making the hung to happen often.
> >=20
> > So, this series fixes the faulty behaviors of the zoned extent
> > allocator.
> >=20
> > Patch 1 fixes a case when allocation fails in a dedicated block group.
> >=20
> > Patches 2 and 3 fix the chunk allocation condition for zoned
> > allocator, so that it won't block a possible chunk allocation.
> >=20
> > Naohiro Aota (3):
> >   btrfs: zoned: unset dedicated block group on allocation failure
> >   btrfs: add extent allocator hook to decide to allocate chunk or not
> >   btrfs: zoned: fix chunk allocation condition for zoned allocator
>=20
> All seem to be relevant for 5.16-rc so I'll add them to misc-next now to
> give it some testing, pull request next week. Thanks.

Hello David, thanks for your maintainer-ship always.

When I run my test set for zoned btrfs configuration, I keep on observing t=
he
issue that Naohiro addressed with the three patches. The patches are not ye=
t
merged to 5.16-rc7. Can I expect they get merged to rc8?

--=20
Best Regards,
Shin'ichiro Kawasaki=
