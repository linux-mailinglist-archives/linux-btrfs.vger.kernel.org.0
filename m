Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF73587919
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 10:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbiHBIe6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 04:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbiHBIe5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 04:34:57 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B063F32A
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 01:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659429296; x=1690965296;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/6OlWTxxdnHTRwVYCL57amkNq9C3ZFj1SIKNfJJsAU4=;
  b=IxeAYURdsJF/Zqh0AYlXlUvwgkvH43BlA2nujdhigILOcjIqMgDSewMo
   5aMuLgoYUoABiDaKL2KOql3LE1tF8brBjJ+buruwotp6ur1+JOx6eY4WM
   CFJoboOCwrSY2lfZjWeJm376xfTo5CgdsfDvxUIkv5CT8ytGgbYUXYb2a
   PiIGo54WibI9iweK6t7POX2b3q11hBpSNVz2VGmBd85rmyjTHvz/JObLd
   qO6SxRsoY15NGjVLQj7EqfhCsispCa6gOl3TB0zDHEFqM4pX6lPa0TQgr
   pImZcCJ1ePaqys7FThkZiI9vyZ0QRiG0/WGk5fcJwCZ/q3tCsfAd7Cvb4
   w==;
X-IronPort-AV: E=Sophos;i="5.93,210,1654531200"; 
   d="scan'208";a="212527864"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2022 16:34:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epXetorkUaUCwcQpEolH1SLu+YfRJaL7Y7PvfoHc8d38tNq5KUR5D8TZdzL8plPGqjNMJk645UBPMgA1FPw0dHZs4ug8ZQvFWcBe3uggq4iDsrmzlYF75sHHgz/R5wCjuDPegcMbfxq+kEMjgg4hCZNAZSdzKeTQEUHtXzpSImS3MpZ3CR3lomt58rnUP0FIWHKJfvzPIE1ou2p3kmXE/RdOLNO2MOCxmcF5q/+sxbmTtoCeI3z+xwhQyE5k+bK5EZ8NHox/57hpMSbYHYzqUSxgoH9lq3ozqZ2s2HA7T9BAUf/D4HBdvbuvVNDIavJTerYOc3olUqEWYMUu/dya/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6OlWTxxdnHTRwVYCL57amkNq9C3ZFj1SIKNfJJsAU4=;
 b=MJhYEebElcONmFiVVbT6ePNtYXbr9Oj7yJKfAUecPwRbsgsUrZqI5X4JDNL2a9mHCiyOrdK2cWAcAMzpAhmY19ZMWj/j7tfOtYYJLC5UK5c7ttFcf8QRvxvpj7mULUKnprSqe9TXM8LYj99Tr6Fn70g+Usq0DGCzN4YUWgAhYTh8ib/xOssP6tzcK6HVM1Ln1Pssr+SKnBAoUCgxr/ATi7P2I5/OiPvP6rWbUgDsYWnUZ7QmLZPM5iWldCFRxyGTKOwnTQ9IDWAtedN4j6iWNLhkS7mmbEcjvtcmE/pZj9IOG0szGQyeAKeqwoPZVyT7xal2kD4jAQrJ+M+ZUSaPeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6OlWTxxdnHTRwVYCL57amkNq9C3ZFj1SIKNfJJsAU4=;
 b=pWNcciaVitrenLpxEkl2Sd1Op+vM3dmoW9hkBg9B//SG95ZpxLqRe6ZuAWefTK1wzBQ9kpFoA/CZ6KvMWdb0as6xIdIRlSc35aIaDZdWILtpFuWlaLUH9456oQwukqN0bdlszJdDm3ct1UXGdghJcDiK/vb7lOcELdWSHr5ZZyE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW4PR04MB7266.namprd04.prod.outlook.com (2603:10b6:303:70::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.11; Tue, 2 Aug 2022 08:34:54 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%9]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 08:34:54 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Qu Wenruo <wqu@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] btrfs-progs: avoid repeated data write for
 metadata and a small cleanup
Thread-Topic: [PATCH v2 0/3] btrfs-progs: avoid repeated data write for
 metadata and a small cleanup
Thread-Index: AQHYpkq9S7jqYPeYtk+/tSyLYpT1zA==
Date:   Tue, 2 Aug 2022 08:34:54 +0000
Message-ID: <20220802083453.jdqafjkansdrui27@shindev>
References: <cover.1659426744.git.wqu@suse.com>
In-Reply-To: <cover.1659426744.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3354fa66-55fa-4d28-da81-08da7461e01c
x-ms-traffictypediagnostic: MW4PR04MB7266:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nzsvaQeU7YrG/2J+bOFDZBK5LiQQx7PTfzpt3CxVepktT0EqxSEMJjexq07VjrOkpYW0t3M2rV3xDI5Sa9Er2uPl4uH83OwWVuX5soorG5HT+sneyuc/JqWgecUXeLp4/PO3EUwj2ZG15c5R2zH+v8SBtvfGnP2DilfMtFO6L3FsaTFhv4mxlnZs8vNLXjdM5quvsgdfLtt//+bqo9fKSMEd4fUlJtord3yL6ox0fiVXRQcWuOdGDfEnAV1Dqf/AFVk5pHbmRkGrOgxgbRwwAfI68wX4Wvfa1EIi1fAwFYi7+5QuQbBk6y7eIWEIsJr7k2tAzka74vhRzIYlotILXXB5j2sGURpGqLiLg9srFtDgey3WBveyNMWDzVyMhp/uwbVQ/XYL4/PTJTh7V985F5RcePBtuI8VmQss9lfSZ/v0R9LRb3lrZ91oDIE7qz9dRr/4gcnNiOtEDHrzKEOKgL/JUK/ipTC2DutoVfSnkYI5vQorWrI0qU3+Bapp+oiBy5RmelTh19y5PrzindfglbqFy9uWikCIPohPSFTTZzqrkg24oJaolbgl7iRQQxK3MkA+CPoJLZeRUKFzMnURcvrq2kX49iIqF72Vwd5Zh/rNb1KHrHd0PpnyfKMZlzpFXXFaMwjXQxJUkoCTtE/+xh9IozPIdG9s4qHSJI2bY/JO5RKos1vq5q8XCL8IujOmKYqhg9UK4CXG4XRAiBv4t1nKqi3ZXkObB03kVuA/N8pXcrvkaumE8hw3UMTQ1+/NBpg7Nx3PFqRxz9G2rM2Bk6kj3YixJm5d/wzkX1al3KmuaOwtYHAodvUSZLW9XJPg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(39860400002)(136003)(346002)(396003)(376002)(41300700001)(478600001)(5660300002)(82960400001)(2906002)(6916009)(6486002)(33716001)(316002)(122000001)(8936002)(38070700005)(44832011)(38100700002)(71200400001)(66946007)(66556008)(66476007)(66446008)(64756008)(86362001)(91956017)(76116006)(1076003)(186003)(8676002)(26005)(6512007)(4326008)(9686003)(6506007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f1t0XGwHMmVPyezdQxzxn0brJJZr00NwVE4sggO3Di2WMt6jAX2pQ1fOPtK9?=
 =?us-ascii?Q?+REFqrA3sHoTqeQT5Jux/AXShGrVaWJ02awvZa+rzzDj81SQQjIgTtfIiGij?=
 =?us-ascii?Q?5Jtjhy3ax6RKLZV87F+iJRZbAhjDpWV/IWls8TyBcuBgxJFqmaqVggWCcXiJ?=
 =?us-ascii?Q?xXVeQnB1oSXjwBTJOvrOdSxvqC1v4frvn3mxXaPQErpXTxZsabtOkD9CWHYG?=
 =?us-ascii?Q?bRnsUVBKyfKgv147Sdj06k8BA1vjjYRQqVVaHbkTne0lOq+AUuFR890YQ0//?=
 =?us-ascii?Q?xYamsFNd+kzjH2NtEHynKs0K2OoDzWSTks7p1if30IKBXV0nOuycRJchkCn7?=
 =?us-ascii?Q?Ghtey56jLbUbjpmcjTLIqp32Vd5ETQABHdS/0lZ68PuGvKXR8FcA+R54dzHP?=
 =?us-ascii?Q?2CRa+caEE03gJC5iV3VYqitzH2UgP6xSPuDOkZeIPXnsnPhQ2nYoOjgobPm4?=
 =?us-ascii?Q?VQV2MWVymANlkGqDR6eSc/IO96U8hRHnoT0GcnJcfw23VbV75+AJXAmvEpfa?=
 =?us-ascii?Q?2Vnz9deEDxEeulg5q83kTPflBb8+53MdH5no7/sVCwg+6NbZTRn8axori5qI?=
 =?us-ascii?Q?rzAJyEPhBxuVXVx9l3ryrsJsEj5h43+44AH451ClwS9BObFLvXJz/3XYsRh3?=
 =?us-ascii?Q?Y4+xCBrqP16nJLRPNIgKG3f+yq4FUwPuOsUz8+M17wdggzrSBQBKZdJOjjDh?=
 =?us-ascii?Q?GLb74WY1HP3ILOqvqxxEnHI5HAKCO5+tUd2I8REp210GDVQZPqJ9MtLefDFc?=
 =?us-ascii?Q?y7kMgAAMKpPdRnjxsPayqgTJ3+lOcz0L7xWOL/fdBKnkAlpyRAMpt73vUwcf?=
 =?us-ascii?Q?H48UPhF/yBmvujCSnFWUg+pCSDjgV0GV4e18eF28AiSAtUkq2jVcrFA6EkkB?=
 =?us-ascii?Q?1M/Y/u71tO5myLKzjh8EbgfbTr2i9N8+RYtO35l8eOTGEnmHN7didzybdFsp?=
 =?us-ascii?Q?Pm5Tk4v961MpDY5L5ioDKo7/4K0IqfHfFQriUcOVvmIHa/HJ/xg03c3Zvj5D?=
 =?us-ascii?Q?Is+GzGWXHvAjQ8hLbVqiKAWhaXAQ18OCgjGDFF8IGnjbMI0m8WuU5W55R3c5?=
 =?us-ascii?Q?TZ+IvIRrR8E+jd49VQniHuhguvVBVN7iQO/r0MS03XPdAawl4B8VGM3NntHM?=
 =?us-ascii?Q?YnXyiKXu0rwELDG26wcXfzBbQ8r7RVMiv7nnqcBURFXokC5WhpSV1RVGZW+v?=
 =?us-ascii?Q?cABr9RB2Cf6hv+RvfHGSbOYZPmI9ybWBmjCumTtf+D8MakA2jvR9C2WTzgQF?=
 =?us-ascii?Q?Whk75oyGrKqSEM/g+rX9siWfh2q73ztSGrL6mIwGMN9PidvJEGf0Eei0Rct+?=
 =?us-ascii?Q?kEDZ3SZCfY6g6TaHIB4xgaqBp92R0aqrjRJB7dQsYilr62AMWGtkUfz8cygR?=
 =?us-ascii?Q?+8e7dJrWDhnQD1ORZrUNZYaTI9c9aE3/pKpC9k35iEFt+TpzBVKGc8XaF/zz?=
 =?us-ascii?Q?63fnQExuTaO0RfNwrlm/TuMVJxxy06NxtNt5XonABElfojMBsOO3D9yPzI4t?=
 =?us-ascii?Q?/iW0TIB9gBLzbcaUiAvm+66povPC+lY+F2ddGFVQ7Y+u0DW/YCzLCjcBjOkn?=
 =?us-ascii?Q?NIVe8VnY3PIHLkRloLNg2rtghOUKGvaHuGzTYUOespw5KmMPTtPDb3ZwvqrY?=
 =?us-ascii?Q?Tnu0rGer/uFx0aSR+SHGTos=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20A6F516787C984780157E499D2036EA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3354fa66-55fa-4d28-da81-08da7461e01c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 08:34:54.6358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a+H/vItBszlZqLvo8glAG4OXthaatcydeDBqlDxRQmFN14BZmSfXrd7XB/9StmDfW/QR0hn8Ayn1+r4gIqDIDy1Gs/bJ3Mb9M1CZiaB64xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7266
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Aug 02, 2022 / 15:52, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Separate the fixes from the initial patch
> - Fix a bug in BUG_ON() condition which causes mkfs test failure
>=20
> There is a bug report from Shinichiro that for zoned device mkfs -m DUP
> (using RST) doesn't work.
>=20
> It turns out to be a bug in commit 2a93728391a1 ("btrfs-progs: use
> write_data_to_disk() to replace write_extent_to_disk()"), which I
> wrongly assumed that write_data_to_disk() will only write the data to
> one mirror.
>=20
> In fact, write_data_to_disk() writes data to all mirrors, thus the
> @mirror argument is completely unnecessary.
>=20
> The first patch will fix the problem and cleanup the unnecessary
> argument to avoid confusion.
>=20
> Then the 2nd patch will fix a BUG_ON() condition.
>=20
> Finally the last patch will cleanup write_and_map_eb() to completely
> rely on write_data_to_disk(), without manually handling RAID56.=20

I reconfirmed that this v2 series avoids the mkfs.btrfs failure. It
also avoids the duplicate write. For the series:

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Shin'ichiro Kawasaki=
