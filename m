Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49C5382AD6
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 May 2021 13:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbhEQLXN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 07:23:13 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:10615 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbhEQLXI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 07:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621250512; x=1652786512;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mZLEGn29+KPeAGRNQXKE7uz7pG9UqwZjxL+SzIOu3Cg=;
  b=EhQ9/mQbn74RoncC+XmmR53PjqhwJ2waxpaDoAusO7m73xRNS86NXkyV
   ivFLOOu9+TYHKAwsyaP3iQNW1r3OvYGoH4Y99w5Ln00Du8DhQYE1B2ugv
   tzOgstGg6L2qKg7+eYClojZG0CH4q9Qa5RvwDgWa/nOkaOQsO2vBerQDJ
   NSkzl6ptNRQfHJd7YMenV7XVYvmINnEPhp5dkodWiz3LK6xj1xDtKk//N
   nylSYoU2XZ8DGicFdUPkJk3KXl8hPAYvGYtrj11tEaTfvR4ZqhpKSfDS4
   DKCnEvnFpXDU0wXF9c3G8pLN5cP5PCT4ZBhKtwUwkUzw4sbHjk11b/3iu
   w==;
IronPort-SDR: Qc+KjwwF6ikiFP5mz+yQumtV4I4HxJePItaDxNxFQ5XgC2C6NwZymThi9+ePtG+qmD5DUqYLRg
 WanD1ZX8yeOICqLz+iIKXByd5/doh2E5FSKSFVXnj8TCHPdhOuhLfMaX0vDLqRj2tlJsvigMXl
 tEvqI4J3bxaQaX4ZYPIl2vTC12mH9lYJLFyv2IHbtQzJRPi+JnqLpmKpowbtO+wqd74LEXGmGb
 rbu4DEvA3uVXyWiUbWGvoTHYlrOwN282BJ9gtgPXNhIllFBwzJ5fDJYTsl8LQeLqpJ89MjU95X
 qUY=
X-IronPort-AV: E=Sophos;i="5.82,307,1613404800"; 
   d="scan'208";a="173052383"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2021 19:21:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gj/Fy9s0W4kjc7aRAhQ+XaAHDYvWf9mAlhOQm1eb4nIU8B5RdzVd1m7bDNUpqJCwre0NENpqyse9Hc6mMPMK70CjAlcUBPJKk1eJjUNmwf+OcGaE2VPmtslnDsydeofQpCOH9vRevh5KW1SQXBSgWiEJQxyaEP+lEWnM8dPQVPgy5LlcQ0nlU9d/FGNicYUgdan+Sv+3KhKn3HSFZEi2kOSLtIKoKK8VBBGlTa39UQpqsVbC5sGKXA2uOlIjjcKtDzVbFc18d7lwWyAaGAI7m9E2OYMeX4iAXsci5GP3PTjPtE7Fa5cZ5vTs4yQYPTu8Yp1ai20jCt9jWZMH1pLpFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86/44sHtcX7ifZNjYzlYNN2kyjcZfX5BLTEHzzuokCw=;
 b=NgYOMOhriylTlVxkwy1cPHINPS/4NclevjSkJH/nlaNJfHNmGYxgK3Ab9ytFrxUKbq3eQQ8CBkjSGkxV5wVOkDwhhOtzkz/V9QUoal111/BDPc5Jbcdi9npblsAMuwTam9FrVVpo3zlkBSfa+g5hepRiMS0tmq5InNRYI3kIwq3iCnyDdHKlvvtGmAEcDnauIhKO9iNv9PiL+X2OOv2o4sE6bqRURmIhCbKljst/Cg9u0w4Nrwgphc21u05SJ/l9pmBEz+P8U8UBOwG/EgNwUoGNqzwNuUGVpUmXZZaKi/AFMmW9WAL6HXy2/XmXVuQaClNblWGeTwmawEj0kPGDbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86/44sHtcX7ifZNjYzlYNN2kyjcZfX5BLTEHzzuokCw=;
 b=m7Aliq3YXcuHkprfZ9rahcqja8uP+9kzHyFSMvvjJyOs/aKZL+MkwDazc2zVZy6ZftR0X5ltd4g6tsJ+mg53doUTj1D8hz1XmpVg0wgxuy5Xdrcqr1VjfU9CAXO6am6S3P7D3+pLZ2aWm+/5HS2aEu5q7FilAWfYXjGELxlzy1c=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7669.namprd04.prod.outlook.com (2603:10b6:510:4e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 11:21:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 11:21:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: zoned: fix compressed writes
Thread-Topic: [PATCH 2/2] btrfs: zoned: fix compressed writes
Thread-Index: AQHXRzde03R8KYGMm0efltVC5jDu+w==
Date:   Mon, 17 May 2021 11:21:49 +0000
Message-ID: <PH0PR04MB74168343747A058F5F53D8309B2D9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1620824721.git.johannes.thumshirn@wdc.com>
 <52c1251218441dfeec909b34069d654aa45311c1.1620824721.git.johannes.thumshirn@wdc.com>
 <20210512144213.GS7604@twin.jikos.cz>
 <PH0PR04MB741608A91B3171D58DA902EF9B2D9@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:aca1:f828:1e06:c30b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5dd46eb8-c808-44e7-eecd-08d91925f6bd
x-ms-traffictypediagnostic: PH0PR04MB7669:
x-microsoft-antispam-prvs: <PH0PR04MB7669B858FB2B8C3759FBDFA19B2D9@PH0PR04MB7669.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VivEZcD6u6jNmkfJPHbQxemT5/c2BXDhTCVqJUgfKPfjuxMEjYyO6Ta7yZBoCDs2CsB5S923US53pST1IVtmiJ4Lgn0TW/jnImXn89EN69Z2bA9mZYdpjhzLEJc1IwgnUqRj8CM/xCYkGwPV8oXYAuGnX29CYgIj6lh+fr7/K86KRWKfXcND6/a+1RxtowPSM1N6niEMujkjkzBpErKp+hcO4znKVeHcBcteVPjDwBbogZyxsGcarZK1oZLicMgamEtuYjoTr4/bNmD8zyOcv6cjNyCgpezEEB35qyt4uiM4cIjym9pcwMBO7W4jOadAVeaWh88UjScUCJji9g8nrA6zalksTd/5XJmF36mp3KgVo6vQgy56uFtNSUl/AJH6J1Mm3oMvSje/yVWS7CkzlwrwaF3xBH5yalfc9mCOS3eF79+aCfFFxCCEOWIU8NEfcEy9HD0u/mVyIpCgnMxl5FQdCVzkx5+legVvplWeBIKxMy0n5qjh3TxUKB90SIenM6UAxsMlueHtzgrltyhwP04eP9g/PtPB/8U+3FBwbjzMPh+xoVm3PqhyGrCfUikW0HKuCDO0elqX5pklVh6LoxhMqNa8XZ5lwGIXgSmGA+c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(2906002)(53546011)(52536014)(5660300002)(122000001)(38100700002)(83380400001)(76116006)(66476007)(64756008)(4326008)(316002)(54906003)(9686003)(71200400001)(55016002)(33656002)(4744005)(6506007)(8676002)(86362001)(6916009)(186003)(91956017)(478600001)(7696005)(8936002)(66446008)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0W04qYj03tuvD+A7JAlFxnf9DwIMj/LSRsj5F3rPxIH7ZF6KsvIjezD+RbXK?=
 =?us-ascii?Q?9D/YetJ21vCxmlCnJZ3SF7vekugGYT09EoGuAELGlg7G5hcWflD1VkXqddvn?=
 =?us-ascii?Q?z8eTuT1z2ZFd/UWndq8JNmzqD1HmkiOTd+TbrDEaiEFO9ks95LpLCrrGnaai?=
 =?us-ascii?Q?2IbTDj+1CMh6oh5P12dUZevB9aaGESXNEnCEi74DGbb3S+ASgWnHRrTUaLeI?=
 =?us-ascii?Q?j3REVxC2eWrGPC7jA6cKF6+fGWRLijkz2g89xghYaB8+RXVS+xhtx0+HvnKJ?=
 =?us-ascii?Q?3ybnjb/SwHpUyuCVdzfjNAbBgY3vNnlsWYRZ9z8/M+eRk9ejg+fjzpZHdnCP?=
 =?us-ascii?Q?qaJ4w6Uk18k8s2ySuMBHgF8MmlqVeplU6HSiR7S2pbEJkZkzfo82YOCgJq34?=
 =?us-ascii?Q?zWtxf6Tg0cnr54TQSgssuJUxQS/hWA0vHGVGViqmi34LeDkRipDLB95JcAuq?=
 =?us-ascii?Q?MEdKCWO2EKaTCnf8Yi7cJxQBbMlSUMNaxuNJdfCtgf3sx2qvx1qW7/44SnhS?=
 =?us-ascii?Q?Vx8Q2jm1lhwOtwtNGlNoy3MGuiomOHmQJFMumh0OiVYYX/rHBl+sFVrp675o?=
 =?us-ascii?Q?BKIzwvGTvh6L1jSoGuUSKsWNqT5aurXzIs83YiZqom0sRDSxLzC6CWYnwtTK?=
 =?us-ascii?Q?DkCC/hSQ9cxkLhOQ3qZNFPrj9tj+tDz/zjOyCLoAOynbFmAp3wW1Bx0T1aha?=
 =?us-ascii?Q?yMGeUengd2AzMMXbuPd14rtahDtd6XQRHrh/1/0YqBl26T29nS9QfjPezqZc?=
 =?us-ascii?Q?GUAtQJ9mjOLYfF3UvDH7oAbfGRIwSyU67H6bedcM6xiap4kw8Grsz5+1G0jp?=
 =?us-ascii?Q?vvvqIZVl9O9zFFifOrtYJ0fTsn0noZOffSDPojl9XF0w6Bt1jndhvMC5f8fS?=
 =?us-ascii?Q?7/NMISJpjMSGBCnPMTJNtVWIowVi5UfpBNuDlW3l9YLuRCK1NSPtKScABnzs?=
 =?us-ascii?Q?yymc3c10mX3na1qYTuRX2wWYY952N/xzwuETVbSvGQyozGLl0F9o7nDEDkcO?=
 =?us-ascii?Q?Rf4YpZh2LzhgmhcEkS4U9gW9OvcmlhKI6BUlWEMHJM1qsyOkRFvNLbWTDHlB?=
 =?us-ascii?Q?UMGnQjP4UeeGYkVVSDdswYdgCBo9W8C57P0Jj+cyfEsPtdxdQpJFi1IVErFV?=
 =?us-ascii?Q?doxnt+lPZAgHqFqgtV8UosKzEhHr3jUin6dYBt+nC3e4U1OMthbU1ndZ1JEU?=
 =?us-ascii?Q?xjQb+EZ7AJfl9hNRocUN4AAtsMjOjwCRTyuBqOjAXa/2fbSTkD9yp7V669mU?=
 =?us-ascii?Q?+AjIB+YqwgI8OWTVgzIeBliQZOznhJ+W7uYfU5uNbuHrGeGwQ2LrI87RYixg?=
 =?us-ascii?Q?8T4byvW52Hkm/z9llI+yjHzPTKgFeL9GMXuj7F9VYozSCKm/fbdM5krnYK5N?=
 =?us-ascii?Q?EzimygJVo8c1Fpw2VJvx8B9192D85xEuuQnb7YakTiXIYxdkjQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd46eb8-c808-44e7-eecd-08d91925f6bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 11:21:49.2319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2gDC53OzT//NOpkTFQbDkuOhwkQKHe5sz7F/j8gfo6hV8zvKU+pZN9qe9FnkQ0ADW50PTGASTgQ9Tjj6Cm8jSP90Zes//kHx84oteF1Ld8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7669
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/05/2021 09:07, Johannes Thumshirn wrote:=0A=
>>> +	if (use_append) {=0A=
>>> +		struct extent_map *em;=0A=
>>> +		struct map_lookup *map;=0A=
>>> +=0A=
>>> +		em =3D btrfs_get_chunk_map(fs_info, disk_start, PAGE_SIZE);=0A=
>> The caller already does the em lookup, so this is duplicate, allocating=
=0A=
>> memory, taking locks and doing a tree lookup. All happening on write out=
=0A=
>> path so this seems heavy.=0A=
> Right, I did not check this, sorry. Is it OK to add another patch as =0A=
> preparation swapping some of the parameters to btrfs_submit_compressed_wr=
ite()=0A=
> from the em? Otherwise btrfs_submit_compressed_write() will have 10 param=
eters=0A=
> which sounds awefull.=0A=
> =0A=
=0A=
Actually I can't do that. The caller does calls create_io_em() while this p=
atch=0A=
needs to call brtfs_get_chunk_map(). The 'em' returned by create_io_em() do=
es not=0A=
have em->map_lookup populated and we need the stripe's block device from =
=0A=
em->map_lookup.=0A=
=0A=
So it looks like we need to live with the additional memory allocation and =
locks.=0A=
