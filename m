Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B62467323
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 09:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379179AbhLCINX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 03:13:23 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:16670 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379151AbhLCINQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 03:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638518993; x=1670054993;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GADzyRnyTEVd0RPn0ARtHG7LTuVX4H+f1io49+2k2E4=;
  b=Gu+yopJ/kgpU2Rtb2sELeJz4KTmpNXsoHP8rPp0sWdyCK5PxT50BDcko
   5r2/WvTqF9MMRLZdCNyDjO1+mCXm8vb8swkNUGNG3fm/WVkeZyIPTxv5O
   nRXRE6YKBEWW0d5tMZWuVPq14gzWC6MNxuxqodCpKwXcU6erpiCF9qiak
   duPWL5mxHh5sYualsSV16KZMvNxULQET2R5m10pY/Mgvp5eSgOs6PD6YW
   7HzKZOVfOZOFwx0eYeR79eTut3WV0MqjgWRDOgQYTx77d0crwt/jTXMur
   I+xswEUFhnmd2hxsD7VXgsMV6gRo0fTkCMlc79ZAp0Vkm8eW6l7x8p6r4
   w==;
X-IronPort-AV: E=Sophos;i="5.87,283,1631548800"; 
   d="scan'208";a="291333550"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2021 16:09:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i45SZUQpbiQHt5Bk5hH57nTpdFBYX2OL0l8j1xCbAo6GEgey3atQ3hCJrJ07pJT4Le0kMNCystyOaTGO54qFRsxHpFpFnWNuoNLrA8LDU353EEoJWhGn2gprvm9RO+8053PDgAFUBYrP3YqM9ftwJIcnQyKuRDGdVBlZKBkIMa3QIMY0SpaW+e8bKtUauGidiCNmGaZP9jyvOymm4NSZ9yzOy/agYCJxde9RtVPwQZnBFn8n0LOzexfs1wFI9DkSUax3p1OwyOPt3OyJ/Z0+XOJz5+qBPPoOHHhXZRkmeUpnaOceV/UkAzQ7Hc59vRVPlTZO/27CT3PKtRzw7a/hng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdgldL+WNp8dqmFe3BUiqhl8/IfPCTy9Ju8BKw503pM=;
 b=hI7syq5ghHK/ZchjaJ6AKie4e2RffTvONPpzUzi76ifq4QQslY+qgtvK0y+MzS+JgRauwXVkCg+Y59qmdY2Fdc1Lihtz4zAQsWwo0G9icONz9egpFyGVZAryFMdX3ca0Nl/fwnstzQG/q7ty9uG1T8Z2m/Hvd324VVGk/M8K6kYM0AqK2ABkT6VjNC+JKEce3cLc1Cof3XayF501HM5o6KTdFhibT4uVr3Mrt8cwt2sPskYtVoxLDyBeIVYqAWBQfhtaHPXkjZlkY2DPrdpQdItTxw4Rd8Ef9DR2y+IoW/P5eYDpvHtp6JrP9Y53pmxKtdCrXG5Yr6RATjw1uydwUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdgldL+WNp8dqmFe3BUiqhl8/IfPCTy9Ju8BKw503pM=;
 b=f9JXlCWGPFjf5SXPi/Ncy4q0JMy0ZPRoqAL9SfXHKMa4QWT125y4oBpRurmWA+VAwlqaSFhdLUOYpLHgwaZMncCrQ/ZUd68YXyA3IjKLn9w7xTxfuh/yfy26tK873B9OC/Nl2RqTbXByQbkUv1+aUe2yv4pCPrEiYSdtn/PvruI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7477.namprd04.prod.outlook.com (2603:10b6:510:4f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 3 Dec
 2021 08:09:48 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c%3]) with mapi id 15.20.4755.011; Fri, 3 Dec 2021
 08:09:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Tomasz Chmielewski <mangoo@wpkg.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: kworker/u32:5+btrfs-delalloc using 100% CPU
Thread-Topic: kworker/u32:5+btrfs-delalloc using 100% CPU
Thread-Index: AQHX59Or+fvG7aRbMEaEYJLTiDQa9A==
Date:   Fri, 3 Dec 2021 08:09:48 +0000
Message-ID: <PH0PR04MB7416465C59F5F339FA87AB839B6A9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <c5af7d3735e68237fbd49a2ae69a7e7f@wpkg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 598bbea5-3173-472c-72c0-08d9b634466d
x-ms-traffictypediagnostic: PH0PR04MB7477:
x-microsoft-antispam-prvs: <PH0PR04MB7477B1D4E34D328442F8AAA39B6A9@PH0PR04MB7477.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1jEia180XK3qd8IAsQO2XRyZplnUgl9rL3h1tzEF4eP9/GcykVOk47ESOcsfwpvyvbmsMnGJByfE/zEpBrGWLqK5Z2cXe/iSPmIvE/a3hI8tNM5I7JH/DAKuIQ2E7yIekuvs8RVIY4A4MoH6u+YEIHGvnaM775b7OU6Pf2OwNEVtO8DO+eaXysm2vIEYeqC1SEWY/jINV28uVVGYI5v18jZHG+P6pivD9gmyS/Ewj7hMhcp5mWKnZAR7S9DmrdV9XPCof3Xw2A1Gw8atBkzGA1y1KjeodAM/cpp5YNeO+WU29Wd1NEA543dDryu6y6dFk/BT6M7FToK/75pPVMT644ZIZdGZsuwPaPupQWLc5k20ul3TSgusJarXhLyEk9aM+xkn6P15EtCA/i4ILffuFBdEBM+3r1O+gkHUagZMXuT4/9CbDjvO7zMkqiP95hfR2Flxva8OGp9SMhTq5sIFElk3seyNBoUgpGuTCJdzK7hIhZX+GyeaYqlAjTTxO+bZLU0WsBsL0sXmfsVl/lOnytlv5IeTd4ucoPq0CsKd9/+rU4+XzOJM6dN2bcGeSXnIwa21yuWDrUGgDuGOM8zWYw7+B5eDRWTyyCA6pgDKWgym4ltxahXKdGMTqElAtI7lu+d+49Mw+qXUl9Kbbdk2mQ7zxs4fEoFjldFav+go1r4gEE6TWWMAMfybbUJcju1wLTIfZPw9WEIYTknK7Fm1dA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(82960400001)(38070700005)(8676002)(2906002)(508600001)(76116006)(55016003)(66946007)(91956017)(71200400001)(316002)(186003)(5660300002)(110136005)(53546011)(83380400001)(52536014)(64756008)(66476007)(66556008)(66446008)(9686003)(4744005)(122000001)(7696005)(33656002)(38100700002)(86362001)(6506007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VMKO3Nl8CaEk5Jz33v9kN66ZOftYZ1xYeJxIfSDbk+Dmcvri31COvnH+A3um?=
 =?us-ascii?Q?RZAbbY8/pcEnCl/bIamd45i41nanxgSoOFBimQmmYvR1ES+NcPuESNsDCKsB?=
 =?us-ascii?Q?q1xzOgiljkZfVNlGHBzCUe29Traym2MktpsAUk2S3WEESWIBXmQMZdT3BCr0?=
 =?us-ascii?Q?tVZpQH3fV5N4434tDbQSjAYrjSWuXYXXEWzWq/6+lCuoUXlLMZgE9+midtIY?=
 =?us-ascii?Q?NyMKQRt5kVhokQ0g8Gmda6lRUa9q3WFqYeAWH9NmcLj50P/5AAv/GxdLgf8t?=
 =?us-ascii?Q?XK+C7s0K9u/oH0yQEVd3mj7C8xAAOw3FG8DC3cJv+h3+t2ZJP8mhupJ239j7?=
 =?us-ascii?Q?FE4z+eMrlqDqhZSsVVERxR2+lCtnZmsrS2fSwFoWzfSS8BeV7jxShSIhs8M7?=
 =?us-ascii?Q?Hx0+18bxt5E0gpjema//i4uw8IYyJt0njtdAtq0uIMC+WPgiUk0441FvjE1e?=
 =?us-ascii?Q?y3PiiyMDzYlKX8dQzOV2doiSGuWxh+3ONt832C/bqGIoLVBqcgxo5LO29cOT?=
 =?us-ascii?Q?d8WeyDwZ/omGI3/TL5/LPhp7BVXpJ5vw5Hxd7NbH095GaM58X14NKEAcJc24?=
 =?us-ascii?Q?tPkylCrE9AZLrbnJZg3Hli73MLHoBrPaq4ieF8HjxUgantPjGAbQzg2g4/GT?=
 =?us-ascii?Q?GpFxTLvOWWhqXJmI7XEL0nstswyx238S0qduw2f/C3wF80/+wQJD2YLkvR3U?=
 =?us-ascii?Q?bSlNn3UqCcIciesCm0USt1n0IbSKd+EcJCOXfavGvSIIpouTid3Z27h3v4cs?=
 =?us-ascii?Q?k5Dh9R8RTWzUEwCsxyarTsF61SQV0krK7iA7t3f2TVMbfvJ9y5B6zH0rqtAC?=
 =?us-ascii?Q?XP8POFm0aFVSw3hzWs8h3PcUrXZR/PCExdMWbUGNOGJyocJgcxabJymo2guP?=
 =?us-ascii?Q?BT0VbziqmdX7vn4X8xMzZa7N+ikjcqqXeHP0xye0dEesEk858BFavznmohP0?=
 =?us-ascii?Q?+ZHygYAlHi5NsKsQpxsETgpk8dB9lLswLleh4egChqipxweQiV4vOc9g3VyC?=
 =?us-ascii?Q?FQyUhcpwfSBjusGs2qv3ZEoFFvXB1qEMbnbJjD6M9qdnc557oDie8wbDMhi5?=
 =?us-ascii?Q?jy4vjGYKFoV/NE84hxv3Rj5FSgYfb6u1C5MOYG7M82fTygQZ1s0V7EEL/KCJ?=
 =?us-ascii?Q?x62P/DLuJX3slPAdL0/CVeicpQht8FnGC2na2anwzu1TUI7oJJIGrNQUB1zp?=
 =?us-ascii?Q?pOpHoHEe32x61UVPQnUoajZHRofHqoDkxWQEOpvM1G3TSatTw+nSH3Ik5MMS?=
 =?us-ascii?Q?CYnFwQOn7fs/By5dlypdvzZMjVxrgugaVnwHQEGR1fBLD3crpdK9zCNKZ776?=
 =?us-ascii?Q?HiTbYmCj2YwRss8x/ildMfSImztOkR6Rgpaw1F+P9E/wc8QSEPDMunWX1wA9?=
 =?us-ascii?Q?IME+al1RHmCEsPMCJppSSsVKTzvZYNSWj99+UkkBE+haCeVE8Kcq6CdQK5K4?=
 =?us-ascii?Q?wWOHYAMo8LjnMVPWdr/lTqDtTtz/GMMLpfxrcx3S2hW5qu3RLVsqSCbb0+ms?=
 =?us-ascii?Q?TbIPYSdPZtpy8DazEAyWnJTyQA9AgycMGznk3Fetqd5VFBDQ8EeHz/Gk7FQz?=
 =?us-ascii?Q?ZIMiugef48VRkBdiwyf9shh727HdoPo0V34RvvGNJ0uyteI4CcNbZAiZ++KY?=
 =?us-ascii?Q?pLd6aAAYgp915ooU21tUVaOxrr/EQk5jRDiI4sT/NYqmsCgq5szFzZYSZLw+?=
 =?us-ascii?Q?2Qq46549rp/hybk0KVye539XzpbNKcCpN0IVhCW9YFbel5tZFG/uY7ZaPm75?=
 =?us-ascii?Q?N/LA2Vnnd3y5CwmKFnqyjNzzcObLR8w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 598bbea5-3173-472c-72c0-08d9b634466d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 08:09:48.4264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Meo+J4b9ynyOVMt1PiMDnkMBC0zPFMe3NGdswcZVybsO7N9ebCIfp7/zjyHR4bvwd/j9YcLzr9m50PxIJ7a+u92JsPpihjwIfmd1Ey++fLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7477
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/12/2021 00:23, Tomasz Chmielewski wrote:=0A=
> On two of my servers running Linux 5.15.5 I can observe =0A=
> kworker/u32:5+btrfs-delalloc process using 100% CPU.=0A=
> =0A=
> The servers receive files with rsync and I suspect that because of that =
=0A=
> process using 100% CPU, the speed is very slow, less than 1 MB/s over a =
=0A=
> gigabit network.=0A=
> =0A=
=0A=
Hi,=0A=
=0A=
We're currently working on a similar hang with btrfs on zoned =0A=
block devices. Which brings me to the question, are you seeing this issues=
=0A=
on a zoned device, like an SMR drive, or on a regular device?=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
