Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0358D5F630A
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Oct 2022 10:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiJFIsc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Oct 2022 04:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiJFIsb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Oct 2022 04:48:31 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6080B92F79
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Oct 2022 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665046107; x=1696582107;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6PmAgqu4Vk8OZayIIdXkj9j+l/Mo6YcymSVCBpo3M/0=;
  b=b+z+wKN7bextxpjVDD8iiwkOCBWYFZqSHTkbljqqjpUdUVNseZwe+rDy
   VufH/m+JBxGON2rV8RZ6yTfIfTcOuQaNyxdD5jQ8UJVC2Tf+GsH3yGRK/
   hnTFQWlIlyUzF3+x4p5NfXq1B+IQnUP4anWp8G9eBd8PNUZst3lMs/r7f
   Ukiom9iLdiyROsvCpB2JyA2Vc3HJk0m0YF6oXHl54iHP21hAnc6Vy6/q6
   8KJ1dl34F0Do9lQV8ysC1Gg0imUX0DKABF9xErigZqD6hthyQEH+IROsW
   hgjvOpGeIEhGJbqfCWYa9WZ+HesOY+r3SOqzn8sa14Z9dK8YG49c9HUP1
   A==;
X-IronPort-AV: E=Sophos;i="5.95,163,1661788800"; 
   d="scan'208";a="213522015"
Received: from mail-dm3nam02lp2048.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.48])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2022 16:48:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXaIa0n9BbOUIDQugbvasaq7wSUMWT9m9jE4z2SvkySOkmDwjJ0ee/8WNlyelS7af8dLoVtk8JhktZF5lybuNJd2hOnsv48AAzI9HexyE2LVItU9KmkqT1AqYJVeJLLOLJWLRUGbIzoBcj4+MW4+qHYZj31FjNL8WtrDg9u9FtaWPpIHgQ1yC4HUvqDR3dma9ca37WzRIBctWP/6P6ALbxuoxIlvIiDBLa2JW5S2Pz8c4ONWPWh+GiCAtyUyqeMtHGRP6LDOYfeE2UOcBYb9Xp7f540ZmwcNck62OiycqBl61vwwngMx/FDJ1g/g8Z3IeIYYkvcnCG+BwzOdBdGN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B75xlfF2IFMZptYMI3+AKS5L1+QFhjG7EO4AIiOWMKA=;
 b=KMIpBILGa0wcq6jabA+RwHc9xnhUWvcr5xdgJH2j+SGtECvKVwiWnWJFcS2xvIO/vvHmddLzzH9eyMASKkOnfxnzT3oNnp4KIiSVVo06tDlH5ZNt1a+RPhcZzq2+AGGXiKoFxHvXp48JdTXk2UNog7K9eHJ7r+bXgS3cEowx3C08wBC1NM6zCo+ZEuin8UlU2V3iExAMjOgU3bl2Su/BoUGQ6ZMSz7awD6NBjvm9rhuTl7ni+BkUsW2COVhmCXbDlZH/EpJu9jm96eda45rN3+yVpaxy2hYxUwFz+T/J21YhfkWAAL2fP9RVDJxfAoPROxEMXak38YCgzdgwrnIy5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B75xlfF2IFMZptYMI3+AKS5L1+QFhjG7EO4AIiOWMKA=;
 b=AQBbWpuvQQvaS8DrC6ZUq9tsk4A3d+soj6fW/PNW7hzhkrKNsM9lPFubwWmfvZxvdg0XDceixmpTAixW99SVCx4bQXGB6rbzLmOQvgtQqnV9gUqnzY74D6vVrua8RgZkwv9BwMDW1CshjJ5MRAgQMM3qfAf+sCfX/bSi1CKmAZk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB5315.namprd04.prod.outlook.com (2603:10b6:408:8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.33; Thu, 6 Oct
 2022 08:48:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 08:48:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Boris Burkov <boris@bur.io>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 1/5] btrfs: 1G falloc extents
Thread-Topic: [PATCH 1/5] btrfs: 1G falloc extents
Thread-Index: AQHY2POc/Qwj2SuLzk+iKBzs5mCkvA==
Date:   Thu, 6 Oct 2022 08:48:24 +0000
Message-ID: <PH0PR04MB7416818DDD2B9DEFFCD4702B9B5C9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1664999303.git.boris@bur.io>
 <cace4a8be466b9c4fee288c768c5384988c1fca8.1664999303.git.boris@bur.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN7PR04MB5315:EE_
x-ms-office365-filtering-correlation-id: cfcb96bc-9ac7-4a53-cf10-08daa77787bb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7yOU80D4S45peRrGGr1yjXU628crr+JiZEBuz33qAUE64yah54wuE4Z77r5bgX9L3dOaoKwr1zfvdVwkfKLSZroE0WRhR9FIxMoQYjGa+osMiEtH1cifNJQMxzxbSdmWXPo+X4miDvKiq/57/w5aQ1uxaHrpw9V4KVDBfJN4D7JTc/mlAasp1SO5b33E5gBw7xPYZhjbnn1lD+dYITJa59ooMZJJS8QSZge2PClweo+auocCOEwg6YzTYO2wa9gOdwGUIms5QaU8DAPSEardoGDtYLE/85KYhtjams7NeZsakp5kc0LSwxThLxrAw3jLDhPnSMi5P05jxmuL2D4tl10e6SkX1b7LjFdMOL4lm8PjY2MT+bs24Q9luXiwcrYmQZ1D8PtjSySCf+NIjWVKhh3zLx9rYI5dTf9e/CcWCwQA5BXEqhbp9lyncxh06p0uJ0/T79ndbgYCycyT62nXTvsmYNXgk6zIEx6QV7wFUllcqe4w/AMgTl/5O5TAsjzIaiSiKZQ7716JOtC9ns2V00jG7FDhGUtvgji8vP6vOpR9UstkngGtVzkugBrBU2hBuEAeDWtA4u5InBZa7jIzUiozy0o9sKHhDxiBvSGNzMJEhIucT/WNt3gtqfX01DvI9HyuVZA3WxxbV+IEni+UneTWHAt5AZa+MI9ezbrvE5RndU4eEdEmYppuRCFUOhXc0GYXr0WHyq0J/0oNyFZZPBhNlv22WCpzQnsxxELabV9WLXhN1zbfaW3OOT0CPXa8Kkt6Mq70+R2ocldCfp3VJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199015)(71200400001)(91956017)(8676002)(186003)(76116006)(64756008)(33656002)(122000001)(478600001)(41300700001)(55016003)(5660300002)(66446008)(66946007)(66556008)(66476007)(38100700002)(26005)(38070700005)(83380400001)(316002)(82960400001)(6506007)(52536014)(86362001)(8936002)(53546011)(9686003)(2906002)(7696005)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nIXU7/2LC5E/koCwPIHozVWMHDNSz1kLrX6wkeGFx9Hm3uRhs1oMiFEMqhQg?=
 =?us-ascii?Q?kFeUCIjMFkNEdkScWVAH341gluy5hW1JRf866XD9bmaI1WkWJrXBzEseP0hK?=
 =?us-ascii?Q?O1Qe5aC7MxhZs1bbA/8C2xP8FJ0cPEmyv0JYiwGKgNGlGKk0Ep/83fBA+GVr?=
 =?us-ascii?Q?QMm4dgRMWiSey/JjuaYyvlTbqFJS63GDMTZL/Lakf5IG7gtrq+KdeotDPwKo?=
 =?us-ascii?Q?3MgUrG9CclPY8KdbhGrZo1PPeQSA6XVbr1cn5aT5NM86c5LbpWZysRs/aoqB?=
 =?us-ascii?Q?Tzl3PP0gcxOM3BhJH0ZoS3MnzUZ7uD6+bALXwQpefgVrDaQk9L5NWAt9zHW9?=
 =?us-ascii?Q?T9N4S5R74W87ErDqp1ulRWzKK0IGF/7nb3SSPV6Vx8P2kMD1YzVXwXuXTnHg?=
 =?us-ascii?Q?4dZ2UtrvjotVxsXrX1J/a7Pvl+eHVqJysvhi2DwDZI5y8RPUaTcKLMmb3Zxd?=
 =?us-ascii?Q?Jz+8L0x8Wmf70BocTBTnfnAgkHR0Ca099wQOy9iAPFHBmEwjwRbqe5msIxs5?=
 =?us-ascii?Q?7bji8xQKtnD/krWIW8DewZgNmqxio2dI7E2g1O160kd5yRVJ3QwBt6p2Nck2?=
 =?us-ascii?Q?DUq712w9084uYlWXNo82sJLGh/vIL/X8eYqCK9vO6gkW+PLTeJpYpwK307m9?=
 =?us-ascii?Q?t2yR5moG/EkTuQtuxMKCCDaCUSgI4+QKU3NgvPJVR/aKa099llgdUFSSNJ6f?=
 =?us-ascii?Q?OGQNVZhCGDLAp17fBK04Z2+pM+ycyPDerpbZTid0lB4FL4azM3+/tGVj5Epi?=
 =?us-ascii?Q?ntKjDgDezq/xXKRAazTcIRabeFJ9+VINBWTZMEngykRPvuAt5nqQTcFefP8B?=
 =?us-ascii?Q?yHvID38at/FyY+Tpn7xdqDpGHk3/dxwqSKMJf1PRMfdXlof192KjDLud2SA0?=
 =?us-ascii?Q?FSDLR2HZqVDpJAlQdVdNf3OZzNQoRjULRiHZTaMJx7nXEWMkNUWPehALndz7?=
 =?us-ascii?Q?uHaVl+D/N27O7ErQS8GILlndO3fy5ZRsBhroGEDcA07ENv9Wfxl5LcQ3RRvC?=
 =?us-ascii?Q?oB6W9eZoKjxZBLQ2D47zIo6rWUmbe40LFXxXFt6oBMLD2r1LAJpLMWYJrnmf?=
 =?us-ascii?Q?DHI1mv1zZCFODjtMe8iYyeVttl6dW0dGx6bXCXibRSS9LY9/9fnmUzFqYJgL?=
 =?us-ascii?Q?CE55HCO8T08e2ReVGXcBbwKiezaj87LXQDpl2Swkwzd9/9IAJe4TeAqwJJud?=
 =?us-ascii?Q?8xE15PqzuemHYtxXxV1+L1lKrekVGXC6SimDQgD4NpcwH0P4YEOgSPkaTjkh?=
 =?us-ascii?Q?H38dNN3JAIl1T61XY2AStUuMLtGG+HbdhPv8JmBy44bV18oOdsJyrcmwZ/35?=
 =?us-ascii?Q?wo+eEIavcs2IX5RpidZpFDhjL0YA9XpacuV0UdMlSK/4wrWjyw2rZDvjoFd4?=
 =?us-ascii?Q?ZS3wSP11o0YeEZNy6tyxpfWUgiMGyCEk2W4yQzJ1xB0OrsH5lCMJ0+k0q+zz?=
 =?us-ascii?Q?8X7WRIA0Rtsy5hxir9C1XSrA1az2Rsn04lb/1/EZ4v6NuNAz76Uk81n0qxMO?=
 =?us-ascii?Q?6Hg37DR/y23ixrhliFfZacNgWrYsBgTELPrgDidCIUmI+TmeCDAkw1vHtyM1?=
 =?us-ascii?Q?wXroSCXTXzrowvE4JNTfViO9g4Aq9CC/gfj/GJ3PtCFiXncx9RCZeofZYOOe?=
 =?us-ascii?Q?TyjNIkAcM8bVplwlf2W5Rsc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ku97fmcsbuRVhdpy1jh2y8243jkeoBvV/+SC9W65h3NDaV/+eSgktJHIaMxiUYth3SQx6qN+/uEDVzU5NlGu1cKar3plhfqVX+dSNWQhnjcu8ybKuQktwH0ZhrfZrL5zrSLA9V61KirT6KXjsuHMLkRi0NM+ZSrKeW2uWIk2qt3zPHET+gfAOANOLZptqVfJDzFETHo98EafP42DdOzQeQXPwlUeynmm1nzVKwYf0fmV29GNPLHvYo51M5Mj9U8634u8SiJ+palIlKk6puokA7g0IavLxu5nKN3JTQramds0ksVcTF6RReKZ8d+WoQ3XtlJTFqwswiExw3Z/HYLUnIkfh8ZP5eBQwR4gwj/OVEO4l5vlZGOJ437LhEogoKTZP3ZAhcZYCrqpDDvPQ1f1f22DXaSKIpjvmYcIHmIK88E1qFGe6pXSmkbFJiIHxGDa0Yqx/IdHHhWo4OdRYk5Kg1eaM6nRilfIH0HsiVAODoStQUq/MoXDQLzW8ELCFf4o2QGxYibFOuokqLcEAwHBFOaxHa5mLNfOhN+Jqg6y5S7l9VSt6XfXh8SfDh9DzO1MVTAilnxdkiXEO7jY8x7SHAtM5a2Xq3OJ4PLm1sxqg0HCVt+I5U8iqG6M01SZkTVGB/T2Wqg64kIycqDJtuoHzfFOyagGSAoOBYXYFNGCCZUPqh2QzAs6Tzj4XRi3z1mLZdKH3tdaAcPM/Xmpz4txbj0UpogtaazXzhHk5XONnF/5bflvDb2/IOhqhHmDr+dyJvU1BdOfbf2apmHTJIC/c5MpHFbHV0E4qp9mQPkeMTpWGU6MQYfw+OkjVGKnh7ct
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcb96bc-9ac7-4a53-cf10-08daa77787bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 08:48:24.6057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2GgC0tSk9qOrZEmz3Dul4h3S/7VhLWjKCaN0tmAh5D8bJTgnWniz2eAcR4MlGG/+eYQ77ygtaFWuCANb2AIJIK8gSQZjGsw4Azm3XUfZ1Qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB5315
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05.10.22 21:49, Boris Burkov wrote:=0A=
> When doing a large fallocate, btrfs will break it up into 256MiB=0A=
> extents. Our data block groups are 1GiB, so a more natural maximum size=
=0A=
> is 1GiB, so that we tend to allocate and fully use block groups rather=0A=
> than fragmenting the file around.=0A=
> =0A=
> This is especially useful if large fallocates tend to be for "round"=0A=
> amounts, which strikes me as a reasonable assumption.=0A=
> =0A=
> While moving to size classes reduces the value of this change, it is=0A=
> also good to compare potential allocator algorithms against just 1G=0A=
> extents.=0A=
> =0A=
> Signed-off-by: Boris Burkov <boris@bur.io>=0A=
> ---=0A=
>  fs/btrfs/inode.c | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c=0A=
> index 45ebef8d3ea8..fd66586ae2fc 100644=0A=
> --- a/fs/btrfs/inode.c=0A=
> +++ b/fs/btrfs/inode.c=0A=
> @@ -9884,7 +9884,7 @@ static int __btrfs_prealloc_file_range(struct inode=
 *inode, int mode,=0A=
>  	if (trans)=0A=
>  		own_trans =3D false;=0A=
>  	while (num_bytes > 0) {=0A=
> -		cur_bytes =3D min_t(u64, num_bytes, SZ_256M);=0A=
> +		cur_bytes =3D min_t(u64, num_bytes, SZ_1G);=0A=
>  		cur_bytes =3D max(cur_bytes, min_size);=0A=
>  		/*=0A=
>  		 * If we are severely fragmented we could end up with really=0A=
=0A=
Shouldn't this be space_info::chunk_size to be future proof?=0A=
