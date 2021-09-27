Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCD9419468
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 14:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbhI0MkT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 08:40:19 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53666 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbhI0MkQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 08:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632746318; x=1664282318;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Jh/lYQvU9YKhpMVMLiRLmorQTB8i/LVcokO3yEZ2eSNv22zWELKwc8nL
   4e4O46lb7/vH2rCzfgbkYk2WRMD9z2aJ3o4UZxsyGey9d40pZkweJftAq
   fNapknrOUMyGwVxCu6zRUOM88ED90sgYruIaLBuPBOCsLZexNtY5MgBbF
   JH7YgJNFLYRwjfihTJoeSpgkFijtUVYFgJTysRL4ldRPqUc/vCR3P2UxA
   QmUP/1CgI/g7XVCBL/C3karVF4C/PPQQIhWt66jcNnPnbvoMi2Przt2ag
   g12XInJ3qz0ze7+qFaQJqoVU4ABYZo00l+V10sBYnoTfnZ1tlaxANohSC
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,326,1624291200"; 
   d="scan'208";a="180130813"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2021 20:38:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCqUc6HGZLr1s8opkDA792nSbn2PtpMolSjXJKNYkIy770ddOH1mi3ka9bJBTG3DgTIES8YC1jjT6NOnlzw7Yfy0oi4Yc+Y6eLO4LGlhDDS4qieOP1JjIMDyJgtu2Owaw58crxN9r5/nZ1rj2fv2QL186zHQNahIZ2qAFkzH1H7wdv3IKBWCbH/YhxIBnC76Z4/TN7gPOSmnkgNWde/5mt3aUgbfEd8WAIvpxcFByTtwAOTS8YC5D7SqU7CfvDL2FXfNOofI/9psm3JZDmQfQD0BXzkyeAZ0ygCWXrulQQDMhx7G14aYBST8NfDUVapabqAfnntuOnqVK5stGdNw8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=DhwwWPuM3EVoiE+5trXlgP81cwTfjPcmHM4cRzgwdgF6pUUaBKHSMtmoF3gwRFrFckgD2gLDIKjJbiAAtXwQzOaE9LN0SwNVauSQXzhNxIIWRV9ii9XaF0deOXL51cUssFV4JbVLqi3eVxgupEhBOHVdMAs2/b9+qYlhXdShD9r+deLzDH/DMj9pSVcwYW/ImP9HeRfPjbMTbDspXhD/U2dEQEXl2zm5TpjRGq7kWu+bbxSj+6rBGd4UPo77MLZTZgOA9iyenuCxLLsZgkrPIwfNfqXQVd6TeNRYKwBOWknFVQHOexruUl2i1A0Q0+NZrOI1u1aArWzwlpEyW/VuBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=gqly4i630hnOcgoZI3v+FZsjjhZODuJfdIvWgG9dratq/x+5Lkb/MrEeb/XCGWGWsZHSqxbRByy1ccArVm/hU/Nj/f7XDQHfAC3ErXRGgxlmrAAOp1TKmBRfdEeVHL/4GbU0lpxY68GCU+2InGkEVlCGZhKp2oP1y/HaPSJ2JHw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7382.namprd04.prod.outlook.com (2603:10b6:510:1e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Mon, 27 Sep
 2021 12:38:37 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%5]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 12:38:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 4/5] btrfs-progs: temporally set zoned flag for initial
 tree reading
Thread-Topic: [PATCH 4/5] btrfs-progs: temporally set zoned flag for initial
 tree reading
Thread-Index: AQHXs1ZsT7Ug01bxQUe//2sSNcYcwQ==
Date:   Mon, 27 Sep 2021 12:38:37 +0000
Message-ID: <PH0PR04MB741644D6E1E3FB655C7A63A39BA79@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210927041554.325884-1-naohiro.aota@wdc.com>
 <20210927041554.325884-5-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c590a19a-7398-4878-5eeb-08d981b3ba42
x-ms-traffictypediagnostic: PH0PR04MB7382:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB73828D0D93086C44D7F3FE289BA79@PH0PR04MB7382.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jEU1+vixmJeW6FdPl1FjaQVtKEygA1gRKcS7InOvy53oEWtrzEEyBANj3deKv2w70x3OilVmR8LVZkCQ6nI8Yt/ULbGwsAS2sN3UmTqan7ZUPdQs7ppV4ZG5lgpPzfhvkflebM1G2K7MtDMjeMciicBj3P7aQQIFT8i+d3JCB2ZSN4myq4zpPmtbdvqIy1HHJ75DRudwq8Yz5Az1ByGso1Da4V0ZxiikoOFbBjDzdPO3y+aUZcvqD8vK/9wl4X8fRerkYjzsuaBXhx2iGF8S0JizYbqg3WWZ37Zf9t0WXjdknJSeU7TLWR1BYnbksaqW1Gum8AlPx9oDmNyQPPTulyExRGyGYgByn7iiG/M45ilbnjnQdVbzWc3Q+C5paQGXlg1/GQHVfrUXBrRAqtdt48GxTLaJWM8lUS+E5gksSM68HyC+ver9hLMxI8iZ+U8JmhVK6P4qeHek823+k76gYWxlPGiLXhzvmYdNXctHjLAFbcKdfixlShIeEueI5M2MA+bKiAd93Esk2nb0I7kmhi/hWsuItDR3z9NFEt+3REss7FtTXocDwKp2K5v0QAITlw2gSS9TeMgC/MUVywXjM2GMkc2JCifHhjy44m515lI576lcrVuHYHqFab9yTlvAHvlp7uRRIhk7vlfQ8cC4YGt5WQHa1pfjt0jgkc/qO+puyNOzoCCyhYl0jmQBJt+ztnXkZw8fiqqncFho/BFiRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(2906002)(19618925003)(110136005)(26005)(8676002)(38100700002)(8936002)(316002)(52536014)(4326008)(91956017)(122000001)(86362001)(76116006)(6506007)(55016002)(66556008)(66446008)(5660300002)(558084003)(4270600006)(33656002)(66476007)(7696005)(38070700005)(186003)(9686003)(508600001)(64756008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AS8qvl3HY+FI/GR3Zjvm6tgB1t2iZUPpPKIypQM8SWUU4a4mu+OAtOqiuCYj?=
 =?us-ascii?Q?S2moVFWhaxHsLPfhyUEp0iq5RRkU52yC6U+qmLvNn0FQ/y1DbY9ZwW7w6ioF?=
 =?us-ascii?Q?qK9vXFF1jGn9Yb8DH+bfZalMzV7k4Sv6C2zFojkcYolDU05zS96XImd2DPEp?=
 =?us-ascii?Q?S7+XbaBOob3rGhcIXwzADWklWuBHWxtz7bNZWeKQarXHL9u55xNWhsTV8rVi?=
 =?us-ascii?Q?x0pE/wh9kI38QiOoRj00K5YpPeQTX0MTyIH8oj+NIMsDc5y/1o4OjY8FJYie?=
 =?us-ascii?Q?02dyRuH003iwPr8qU5tqbyHvQSsjvAwJZ2BAv/z0vuqNCy3vS14eqiJcSeE5?=
 =?us-ascii?Q?p7vgEWatS4CuIYpgVJCnHXpPyUHyKsEmc6s3RJAIIl8uDVIbQQWHeC4m7rrF?=
 =?us-ascii?Q?HxxJQP/frQab/4aCPvXtbP3DQc5FgP/X1gtw+3RU2IRIZtwGpJ2HWN0RhviG?=
 =?us-ascii?Q?OE5DHNlKGjzjJMbmGo/ZiYfhAu3HogsKf5l64J9Am3mQ7752YLFyJqua2ycq?=
 =?us-ascii?Q?3DbZcaxOg/8D7MZZNpp8DH8oiOCJMJbH099HJZttQkP+U3ArhPmti0Ffrj7q?=
 =?us-ascii?Q?0lbJx6ET1GncFBZ6fg7VtaUQ+o/o3gCBCC8fZnLn+OCsHCVccII/F2lXTrcc?=
 =?us-ascii?Q?udElcpBbVbgw5Sxt5naUdHBqE7xJLFRjSPE2lT5sdqMezD9M/p7K3iDvq6nu?=
 =?us-ascii?Q?AWyOK3k5qHU6g6BW2Ns7nsrVHXhFilAtI5ZLY+3hNPSVOoqHUbVX0YPOAQlR?=
 =?us-ascii?Q?exVVC+/OJRMeKLU+yqNQ55osoAMXyAUZKMZgFsr80RePQ2zD28rDGqV9JTyF?=
 =?us-ascii?Q?HBGBoNVYxqEeXL8eljaJf3SIyIeMCP6CS1SrNJZ2g5MRQLr7spJjL3leEYrb?=
 =?us-ascii?Q?DtGuGjJsQr9bKT7a1bvcbYJkXGyhgoVLZ6Nz7LaEkwHslTQqIr4qyNM8e7y4?=
 =?us-ascii?Q?0EWFApw7ob1dwDhr6N4TZERo6JfuqquRaisaCvAua0kCV78yLoHFT8h+sQFE?=
 =?us-ascii?Q?SWBSDjgUF4ZNLI8OXU7D20mbuAgEwI6XuacU97uloFGu2P3fWUl82gSsEl1b?=
 =?us-ascii?Q?2M8f45qJBJHaxgTMZt3g6dHSORvBCgez32iR+uiX6HoDcU6p8mcwb77j6f97?=
 =?us-ascii?Q?QqQ62wgncY2p3tjyDTz3d3oWqmQplrJocCyAggZdjh3S4DgAa+qBmEiCZuVA?=
 =?us-ascii?Q?Jd1csT61w2sryDtk2tqjKEiSOqDQGbNFgxNM/DzCVBX03BA7sxbBaJSWCHTQ?=
 =?us-ascii?Q?cikD9l7guNcHqgLAdpJxy9ZlydYukxHS8y0i7RAAhsXQ01TOnibCUVWHTGhe?=
 =?us-ascii?Q?5KjpnOp1pnMzEQutf+tyKRxpuDvDYaNtRW1VYWhzlHwNyw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c590a19a-7398-4878-5eeb-08d981b3ba42
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 12:38:37.2641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O5NV8m+bfSE1kHnqOmG1N5YpL59LpdFbWcuJQJtnpNPFMqy3EAlDDKCQzZ9ERpzXwveMj+0x5wt2n0R+aSrNuJHe/ExbAgSRdxboP+PmVh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7382
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
