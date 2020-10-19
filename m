Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C875229237D
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Oct 2020 10:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgJSITF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Oct 2020 04:19:05 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:19346 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbgJSITF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Oct 2020 04:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603095545; x=1634631545;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=O1WrWLDIBHm3/P/uUKUNkXNyxJtRY9EDK6QE54jsc0261yz77rVwK7zP
   QCcVmbE5o7HsXw3EkaCmZtgaT/K7g2Ovlli20YGlu+Azj/Q4RK5Ku0dVn
   8tltKWZxsH4zCgd2crBG4o89ICOBAKTJhPqaEcYOZUAW4U7l4mbwsXKJ0
   i9TVztAkzJhVxEOvvIPiqw3mEAlU+rymFULpD/VoOiuoi9Lz7UdQUZnOt
   YY1Ak4Y62mKwAMhCH/ncp4i8hoR8jFvCfBW7KQWh/N7c/qZPiSuV0I6z8
   ZbsVWFa9R9QuMxN+ttOVk4lvs4cDsM6nvWUyLAlxjgispAMiGwp//xyUb
   Q==;
IronPort-SDR: y++xHAUPdIQtoXgcvzGs0+GB86mu+ar4PwDJ8wJTR6oznJMDL+NNU8nBS1aL+4W3p+kyDIpO9B
 h3KmUr7DVO7IGwRK/lRYvZtUCknqdMb+X8HGY+t6xzCbMVXYXmiWMoz3dM4P/qoroECrTD2y0s
 uhu/LagQ7bi/YapZlC8YAoy00R1g2Z3cen4+q1vDxRt9Q2pUN9FkPjNJR+MmhRv4ywNXPLxupO
 8B958Z1XDAXVPepcUzjPTOFHHcUFhC1UioXeW+8wNJek8XD8538tOv8P5xEB7dzOwDmmoD4o63
 zTo=
X-IronPort-AV: E=Sophos;i="5.77,394,1596470400"; 
   d="scan'208";a="151532488"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 19 Oct 2020 16:19:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIG8m3fFEObEUOqWRMdvmueo9NoQLGodjkSHCQDAXxDZnyC7t9SPYStGEfa0gqH2+1iolrsru3/3sLYqotoAptRg49dwkQDOq16+OkQa+BN73kelhj5vv0B3tXPDLpbnLpzr6C64w0p15ZFX+ssaKBugOeORJVyreP6DwQi01est+WI/cKNPQZKH/SYpRIfoCik1vpOZW4RbYDlSSLqjm2bf2i+/kq8y5NV2sPTXjT0PvJjb6UF8mtexK2xkrdKD6SZpfXVbXb6qKAi+R5bi7EynFsWnrzOrIsPfUEOnl2/71tx8/HCGFuCXPErIuA0j41+F5Sr/wkF6Q2dsSz2hCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=lvvUC0LbBnzwUk2ZRXXEMO+JG7S13C8n6IKdJ0qy6TLcEw3hOPFIn/DBVsMSUub6skDl/QgqH1O0MEzVUerlW20Y82Sf9CsViwg3g1LOFUQBX25MGzeY2W8OWeoHBEspFb5vrTeaXLnbPeSwYPAXFWsrhW8VjzsSG1YcEyuMCp5zXS/h1lhKYiNIl9BQDrKKaSjc3SZ3rpfZRHaunPhVsno2JgHPfWXfVTcnz+6yp+HjXZamXz12fqNUXq/HA7iTzGFxhlB7SZAJzib5Y7EFCibQmFhM2Wj7KWIx1aRDQrVccy8EcytKlfJF44FLITXLQImQvXvF1F1jfEGjDkhanA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=gX0OKQtflzGVjc7hJF11zexQiKgApBWhKt175nC0SBV/oratpXWt477EjXqGvEsJ6IjJxqyl6UkqGTGEvvoQOnryjwjNgTMBGhGz5NllJRs+8ek8OST9JMqgIzsD45UsOYHi3YplxjPFmeBof552KNb6KCGoPGiQRumEKKDwsL4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5118.namprd04.prod.outlook.com
 (2603:10b6:805:9a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Mon, 19 Oct
 2020 08:18:59 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3477.024; Mon, 19 Oct 2020
 08:18:59 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v4 5/8] btrfs: show rescue=usebackuproot in /proc/mounts
Thread-Topic: [PATCH v4 5/8] btrfs: show rescue=usebackuproot in /proc/mounts
Thread-Index: AQHWo9EqbXUzglCAwEaQLlU7h/9Q2w==
Date:   Mon, 19 Oct 2020 08:18:59 +0000
Message-ID: <SN4PR0401MB35984E555FC2B3AFBEFB4AEE9B1E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1602862052.git.josef@toxicpanda.com>
 <007ef6e4d542210148bc373d3a432d801e83019e.1602862052.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a61:53e:3c01:9550:141d:bfe3:44cb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0630ee34-e6a3-4ce2-ae53-08d87407a197
x-ms-traffictypediagnostic: SN6PR04MB5118:
x-microsoft-antispam-prvs: <SN6PR04MB5118A11D82FA91A83E5C77D39B1E0@SN6PR04MB5118.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uSj0jyhrqusi1q/6052/vEjJBGDAlueAJlkG4+DeBqbHK1W79tSKqVaxxPH32h/8II0lC2KfNjCm0BVaCMVpSyke43dtUaJ13NiUODkaQzoLlVrrnqI9EmheoG9IwQx4IsSj4/QGskbkw7ONFbF3XQFvas4tu5bxjbMMnuTOOybj2H9l1GxjVmEJuL8qQgVx+YTED3G7ET+swe8OHgEEHSHw/wdLgKLu8GUR+rDOnBbMStqGRDaNHjNdeF31xRkYmVC4jbBNY+35GFvyzaAFGGR0GxmhCWunXPJSbLVk4ejXwPofEQSQZbduNx+nAc4Q5FPv9Kd94pAm9oNjgkiy0kfBRgKfS8DkOzP+34WxwasKrDOVmFXpqb0Xj63Jssda
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(66556008)(66946007)(55016002)(91956017)(76116006)(33656002)(64756008)(66446008)(478600001)(6506007)(66476007)(86362001)(7696005)(558084003)(8676002)(5660300002)(8936002)(9686003)(2906002)(19618925003)(71200400001)(110136005)(316002)(52536014)(4270600006)(186003)(151823002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: LBRlVWFFNVfEsXr02covKf1c8YHyhIzPmCP6ZIXPVX+hpFOuU9ORBWmyT9oXEno+I520/BJ9yW9o6FZ2hhT41hdPt+9enwufa1t3Q1B05YA61sMz6Lun8SCw9pjHjwZQxsFWBF4/VeWezaCceU9wRpcCqv89ciH+fzfq10daMDvjRn84c3RirkRi3WeU8WSqXcNWhmlUl9kWeVQgHGgG8/ZEzeMuAUWyLpywAeeGQKpXS/ynGI3TzAgBvcF0EvkamombaJY93bDUAyE3o+AmaiNB04xJNiMrp44GGZLVhQ53JoeriK1BW5KTFXuAW8BF9VH/5tr3TnSkJKg4W+2p2zv3fERxlxysQ05DdIKCTYzxj53zcDIr2QZWdDCJnM9vc8GaEyEN2HBVMCj7ZD1/kR26C+NSYuO1znhNAGMXqPldv9ZhO9fK9TSzBenwPw9bE2X+pS/r4Zu+1KrlAdEnhFcUFjZ1bp3C4rjPY8vzHbm/HtCDX9HNjSk1s1MSiPaBNB8h1Dzv/XtdF9X0K4QlvTZ5urOrdt2o+UKcjYTPYwrq5rfG0i5lNyViWEy4FUiq8+cKeb/FLWCXb+MvqAY00t/I4BSANwNE3Qa1lJfoPQ/C1QQut9tbCA39FO3AW5unCpgdTB8bnk+mvxD4cmYZX3BMeAV5RqiFqQtBwCcU/yz+YjpMQ0mAA8/lXSeBqJ7keqqxOZl/Xz2KvHgf9FNoXg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0630ee34-e6a3-4ce2-ae53-08d87407a197
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 08:18:59.5691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q9u4F+gC0pMWsATQqTzVUyO8JuMDQC94mOZkZ5aLgaxgJUunp4ISbTUsD4O9pdyfQ3wLiS2bFdl1n8zzEJq8a8VwVdmAK0/C+1xBS9aTfYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5118
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
