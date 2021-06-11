Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7C23A3DEC
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 10:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhFKIVB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 04:21:01 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52598 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFKIVB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 04:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623399543; x=1654935543;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RyEPalm9218tN/gJxrnAl8KJf//HGQS//0A3ceIqoh0=;
  b=nkFPf9G3q0YwVsDOpqHQD3pgH3ToX8vChJfXZ8yedvIlEPX0rFnZGNQ+
   TQO08gxkvmyou7f/QlJ5r0Kia6VBgXjGwjCyXN7YU3gRrEcRs+CglOI+S
   XnhEzwR88qyEqQyeeO3QUOsbJ/pDugcJtbaol0FGy4DoEIXc84wudHPAT
   rcgdbkEHtVXYfNVMVeuiCcQirI8zLi39hlsERp/gbHnSoclSrzUANhhRz
   J2AwGgiXKACwAvNmA1uq7cS4b7nBeHXPJHr2MDoLLFofIxTwVkKSBsu0t
   sbhN5RhYp0L03psv6XsuxbVi7lSQzOSrdZ2792mVWXC1gmEh5OjnARei/
   A==;
IronPort-SDR: D43A6LYskbcBq5IypDwZPXHo+mN9gjwcxBbpKDVKE244jFKwax/adYBJyUGvCMFXI9cQ5JJZ1/
 Y7aBPnzMAfuAuRtkfwrxrNjqG/65OmWXvv6cIJFgT+9nR0R1UyP45oh6UVPMBmkcJzf8FYSefB
 NA04smnswhxnMzbK9IgaNTsJryii/ZHqvHLmZ8x+ZMHJ9/vlfZitpjAOoZ7ACgHk+iYZ8tg9kW
 Eve57pQHyNZeQKMa5neUwNpR+mMmctLZrQ/crtsucyvfv9dlGjjRJOfpWDBK59KRz179VtAtDq
 MRs=
X-IronPort-AV: E=Sophos;i="5.83,265,1616428800"; 
   d="scan'208";a="176336195"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2021 16:19:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJesQ+a8pPZ6Jj2fm7R3BSyuAmOZvIGsZuFLyjxGDdZAwOSDu1s2ge1zGGlGvmhmzvCeiBWaWjogVwPdlpwrw467lrtCLzpxVCAaDIA6Yu0uCggdrf9J4B7khvAJABnd7BYY0niJ54jhmO9OKAm/oho3mNMW1BVssD883RdD9GI82eM41B/Y3HRfiYz5BhH6gp44bK+HYsNeGyVzJy17rDQgFi4+3qXv8OvDhaYZd8rA1hMt4Bl7H5h/rJ7m0Wd3fyl/vNC277Ldzwap4P0Eexge0hegHgQ3Xxim+3xtQ/wSUXSgVwm0jAPtE3QaZC19HYjDonluujaHuXA0trB1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyEPalm9218tN/gJxrnAl8KJf//HGQS//0A3ceIqoh0=;
 b=SK6pJ88LutWCPTjF4q6nPbLQKz0VS969f8SEwkEOo4AaJue/p1KZffd9udU2wNk6VZQRLiC8RYJN9v4xS9CLX+JSk4S5J1hL7YM50s2L+XjM7YyZS+LWDzViQy80eU0NhBJWSTLfbu4HOlaTudvNTA47ZBejA4Brb+LitwEIsW2OFaL34o/8DkyI7pnqNpsYI7zRULsOh/5RaanRsNuE7zIr+ZdOufFoe8kNMIYG3uS1IRVM8cA6Lza95ynl5+sN31qlA8XT5z5PEByDDt/7B4R53gZuGUzDm65nX9DJMDwpeDC6GrLwOzcTSyNV7I1jtwj+eG1E5Lh1xNN5jSLwgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyEPalm9218tN/gJxrnAl8KJf//HGQS//0A3ceIqoh0=;
 b=ROJfxU9zp+30W4bcDZQIFX7j+gJpPhANiv4uRiRzMudem3NbzPvjWPj11lRiMtgeJzwzl606KsOtk66qPmCVGPjmRrETAz31uGJMxEQqtc8tK1EvkMm9aMjdqyxZQBFfe+kyg2YiwIZ/C6gP9fmbJ/9lL9UVcp4YvMScsphbhms=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7303.namprd04.prod.outlook.com (2603:10b6:510:1a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Fri, 11 Jun
 2021 08:19:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4219.023; Fri, 11 Jun 2021
 08:19:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 8/9] btrfs: make btrfs_submit_compressed_read() to
 determine stripe boundary at bio allocation time
Thread-Topic: [PATCH 8/9] btrfs: make btrfs_submit_compressed_read() to
 determine stripe boundary at bio allocation time
Thread-Index: AQHXXmGkeNgEMm2fkEuHw4DggYnomg==
Date:   Fri, 11 Jun 2021 08:19:02 +0000
Message-ID: <PH0PR04MB7416BE7F9C7820B29E0EE18E9B349@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210611013114.57264-1-wqu@suse.com>
 <20210611013114.57264-9-wqu@suse.com>
 <PH0PR04MB741678D81425B3F3E24DD28D9B349@PH0PR04MB7416.namprd04.prod.outlook.com>
 <3542ce4c-f2ce-c834-6866-eee6c28a967e@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:141b:f301:e91f:9de6:cb32:f149]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1207b796-9446-4474-0789-08d92cb19271
x-ms-traffictypediagnostic: PH0PR04MB7303:
x-microsoft-antispam-prvs: <PH0PR04MB7303CD3C7CDC070F7A4491129B349@PH0PR04MB7303.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KJ/4Wn2sn0JR6yDRWVuprQT6XIMIW/cDyGKximKcpmWzv6erKDWgDYPK90JUa2hCEz1KO1/cUOK06Fulto0po9o8ZG5G65wFsykIS1Iai2WeZScoT1sXT9LP/41MtrTKatQISIXlZNOMo/y4kqkRufd7clp6YVA+SSZUzryx9Ru8nyQuXpK73IVbd8iUGLqKPXxzzlJBwWEoMRpjCz2vPKU5dkYRUQTc/y+HSK+SaHXY0e2iT2oFRW39hoQbNG0IJ9pwiPa3+q64McNDs0d8HlRj0MLZSCr4JOT9tyF4xSGaaPB1g1mzX3BAVH0J75GTGxMmYnfGGis7tzdZVKtAWPKMmTCj7Pg+mwXOKAh6UPM7AHL/hD/7cpZmp7O1zBWWdj53iu7JBCwgiT+TXgze6/0WpqEAqA/GDERPcGBcaUBPD+f6KnBgMQKhD1tgdDMdyT552G6PEU7k9dAHnJ6Ol0kH5qUa2eGR5pXAxJQ9+3u+dvlfFFEaYyWZlHYrsqeyEMuUC2zrhu571UeNtwZ5qW5Dm/EJiA4xCQJ0g/i1m5KdLFH4esK+1HzStIv7jT3Utb8Knypqs3aNFtKJlgz+Z/c6gV2siazW4ZB4iHZ/6cc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(110136005)(66446008)(55016002)(8936002)(8676002)(6506007)(478600001)(53546011)(66556008)(66946007)(76116006)(7696005)(91956017)(83380400001)(5660300002)(64756008)(66476007)(52536014)(316002)(33656002)(9686003)(71200400001)(38100700002)(4744005)(122000001)(186003)(86362001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D+DluG8Sf1G5nMuoihqzJHcg/9ukxPyArzsOiR6iNo1jksySa45jkQlUUF6N?=
 =?us-ascii?Q?VhJi4tVghojBj92i89TEI35qWMB/ygYWk6PvGT/239EedOMtNmDaySenqaS0?=
 =?us-ascii?Q?obXesbQZMLtI5EkRFzvJc8z+iJQC8teXLj+uisgbWTUdA39u0+VPErUQZOZE?=
 =?us-ascii?Q?eJK8AD04YEcqIcOyyJ3VBZltjv5cF3M4UfcgQsiW+jBLn93nB1HVh37L1KtN?=
 =?us-ascii?Q?5Jk8bTe5Gpx4uQNAI49lXEoZeO4vZ0On1U13WSzxl9U8ZC6ksvYv80kj5uxH?=
 =?us-ascii?Q?Jm3v/7pwXRfBSITEYmlroqZ6pJaNTiHbvJEVVcu4kSkgAID8nByIyn9WBXFb?=
 =?us-ascii?Q?vaRQdybYuRqOCllzvvPuow1co8AYnG/C4o2vyNZRYrOdyRkbf8+QsBGJ6tGh?=
 =?us-ascii?Q?YrCrKPwDekxkKtatuR6ORoMV9F1Yb8gk1g/LOE/z60iZStO9Pe4kBC+YzkDy?=
 =?us-ascii?Q?fkke31XehQtipGqktB09PdkHb1xuxNw7wi0pjIoDNOEj4JYonWL50i56Ihat?=
 =?us-ascii?Q?INl19vapyRxvxsnb3hiWoqgbj/shiRRBHz/7SNxcUL0/wZCyhGr3MHNLKNsw?=
 =?us-ascii?Q?bnG+QO9yAgRRZPQ7BFuFnILg6hZV+wF1DYCbXtn9ENGpN4NQwNDWFhDNI4dO?=
 =?us-ascii?Q?9rU/htOXa0jw808lheqXYsqhY1RBot2wJrAW1SuLTozm/3LYMane8trE4jzV?=
 =?us-ascii?Q?qdFYdlxENleLQwEsWvbHz81Bi/nSqySNICn+CfNUxe1QTcn8bTiWjgiXeBio?=
 =?us-ascii?Q?LL71Ujz6z52XCNA75k6243PPpXCYTpyx6QeHPS0nXcW0+oMydtTcyq9klDVp?=
 =?us-ascii?Q?5VD8sS9u+rdrfvVkyz6cl3U3dnKAIXe6rrDqw+Qx71fW6qqjbfDCIZja0qBt?=
 =?us-ascii?Q?uOFzaeiY7BpxAX3r/Q9SZPQpAOc62XTHcMLv3Bsisv86ZYAZw0nt2cxcHAIz?=
 =?us-ascii?Q?QhW7AX9i1bkQgm2HpO9IOiVZuobTX4c0F1nGkm0wzhPEtDcb1MOLWpEQYc/y?=
 =?us-ascii?Q?5ulUKkBkP6ZdFZ0cCgTfuYILJOue87VpvS70AU7dVMuc57iY//o5uyj2rm0O?=
 =?us-ascii?Q?08vvhUP2q2xrbaFXq2JZfkG7nFnW5fbabS/PcNfsWCF1ekvuRKHfpBD40VQA?=
 =?us-ascii?Q?tneBMpyZ+uXDVGSWjydoSJNlP74SVV7ysLqNpar7/FB85CCqAHeY1iMwxZ8r?=
 =?us-ascii?Q?lNzFXtXEyPCTYZnk5xuKk3Vpj5lF4uu3euuizLfK2a3Kl7tZ5DWCjjr5I6/E?=
 =?us-ascii?Q?jV3/h7j9hyTs1WrqYYInx5MCEb5aWPoojTQlp4kU2TbUwf39tu13rVD/8vNF?=
 =?us-ascii?Q?1JsPorWGy410zyw9xaJxt0b19ck77DBsirmN6PInSsQlmQvTM5DjFHhlTn0t?=
 =?us-ascii?Q?jx1T6NwUXkNbMq6Bpd3vHBhjiTcEKLGwH8zRXjoPPAQhUjRk9Q=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1207b796-9446-4474-0789-08d92cb19271
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 08:19:02.6374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4xxRLz3BI5UOCUPkSwI6Y63WJTX3ziW/m6xhgzjT8bMcu0fL9K7k5oHbpHGAcW3IVgV/u8C1jLC0SI0t0i2/Ep1a/j417j+BFE5h1QbAasQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7303
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/06/2021 10:16, Qu Wenruo wrote:=0A=
> Did you mean that for the bio_add_zone_append_page(), it may return less=
=0A=
> bytes than we expected?=0A=
> Even if our compressed write is ensured to be smaller than 128K?=0A=
=0A=
No it either adds the number of requested pages or it fails (I think there'=
s=0A=
and effort going on to make bio_add_page() and friends return bool so this =
is=0A=
less confusing). =0A=
