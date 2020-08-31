Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6871A2578F4
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 14:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgHaMJH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 08:09:07 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30273 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgHaMJF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 08:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598875744; x=1630411744;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=DAeMqDRIx2RBOIZ+9pAh3PyZf8Kad4FgIyT6rsgzdbUVol57ZPKDrnZS
   yXWcNnnNHjS/FUjpTUDD0eYMGE94vA/Ibmh4wTR4t/m4Q7kRQmm1TDzjt
   RQgn0LbMKey5Y9IEeVXkz3EWKIoh4ckB9uryRdmWKWZv1bdX7XFsxNjRu
   EE6HIANiuaWF9xN7m1LPjuey9Z0mmR4xa/BLmWpTv9QygcynQlaY4u6yY
   7D0oUwFW0z5mnSgq9XClOAroVi3tefe5vfXgk60EScEpzCjxktR77KK1f
   Qf5ngKKnXBu1ahmJ1OMPxFsq2EhhWaBizvFw8hafd5Xxv7M9NBlaXe6hx
   g==;
IronPort-SDR: 7qOaxoMyBRZnnSIip2Zwyt5w3INOZ2x92DyUkJ/SFzCSyRWyye1kXLhbO58XH8teN2StYkMi6F
 kuM0BSX0izgsi5vqm+0O7mJfp9XvX8FQ81UXzOdYhbNMArszBUvq1OJaypam6ReQ8FFofyLWUq
 tCV5TSpj6SYA/FPjirPEhxxSgidKaYad2faNVH6blldxZaEYfOG0aWWRDVB1mlCHvz80ohX5+8
 vZboNyZOLfrH9O8dfRX/+8HhNqBtyN0VyyVmSkaDJK0ybv82NSTP3psQ2RgTm+Bjs95K8yYvVR
 U0A=
X-IronPort-AV: E=Sophos;i="5.76,375,1592841600"; 
   d="scan'208";a="146156210"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2020 20:09:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEJUKEJ1IECyf/Tqmv0AwYXEXKUeHsAY2uxA7k2jklqWdz2VDDcFtZJR2Wfbz2tKIDrrNboOCK1JG1dZP4UQ9xT6tbxrKZscNuzMlumfOPCGJGZBgTWWfUoCNNycn/hZ79rAtH1lpxxmrD/9c4kxPNgVMhcPLYCV9GTQ6hZ3yzIHu0xBanhPXuUcw3jBrtXpSzcjaAXDr8lVgoLOHqR6qnrJYs19PBegybxI3AkzFn4W3cq37TtErBcw41aLEE3ZGAWfM/0ie5s7t0YGMj05l6kRtr5hBpfFKSwpXYU7ks96NiHMAJInsZUmZAPiw2dzU8pU9TK/EPolEnF94BMxhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=K9xP2IdFtf0KVNMtfb31KygH7gu3xtiF8WWMlJ5hTnuxw4FsbylHIlEnO4EJ198qFSlXgPefjFU/k66LeWKqOrkkqH33zma2ZdAL+olPL0AG98d+aU+5BcVrS3k2pOFHfMX4XJj1/HAEm/DjWSugvCqLpZfRlJgzIwKDA2y/ObRzk6+BM1LF3orJaLo/9TYZZwsY1AGt+tKShUTZM/YcpYqsD+DxNyD9kJlOjpyfXo/jNKS46+SKfVIr3jInvM3z2iLiHyWHvG/0iRSY52o4e8Z5jZPlL4vGeukW6IlJPhKIXy7FqisH93zDDIffzQOOY+85Fpj8mpEyuQFLTmK1sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=qyf6i7fOrrpiWCCKovROaV8uwkBfPf1KPauQD6acKNSOBC4BK0WuwCJZZFXFgAV0PWPGY+odvo5VR9G3mdwHiB6Ir4PPJdQH6CxTfudJc76ZtrpYaQJ9P7Dhsl4t5/xrV5nl/9Pn7DABxsPH3OyOLiiFA6ciCZsKprZYK+SZPag=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3885.namprd04.prod.outlook.com
 (2603:10b6:805:48::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.22; Mon, 31 Aug
 2020 12:09:03 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Mon, 31 Aug 2020
 12:09:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/12] btrfs: Make btrfs_lookup_first_ordered_extent take
 btrfs_inode
Thread-Topic: [PATCH 02/12] btrfs: Make btrfs_lookup_first_ordered_extent take
 btrfs_inode
Thread-Index: AQHWf41y6dFM1EwFU029FIpPDE34MQ==
Date:   Mon, 31 Aug 2020 12:09:03 +0000
Message-ID: <SN4PR0401MB3598ED2B748D95FC6506E0D89B510@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200831114249.8360-1-nborisov@suse.com>
 <20200831114249.8360-3-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:f048:793a:58d7:f0ac]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f042f65-c07d-4c9b-2c6d-08d84da6a6fe
x-ms-traffictypediagnostic: SN6PR04MB3885:
x-microsoft-antispam-prvs: <SN6PR04MB38851D10A9541750A57096609B510@SN6PR04MB3885.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1yczKOhbjjZmds9uBHAEn3Zimy3ncfcnvoHDjAfgWZ9YLyn1/bZClkhxx7697ooFG0JQpjt5oy9J50RuiG46U9OHhXvpqBFFIKlBQKGI1MDSJ0TJabUQE31YFMNhdsGFTrPnPzujPnY21WUtL/1uSjrgoi97a5CSVEaWwrro70EZRRf322zk48qKJGnFGbqtII4So9yJExhOAXGX2dYA+65h+qbwp8QhjJWHX+WI9uWAZuME3zR6rubzKuX1h3x7TLgEScOkUi5ieXVjXPfEvlPtiHZlwvbdA9VOUBUH9lbuskn1XUcIyVXm4Hmy08J/ctdkQybD9mP4+AazkRiyqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(55016002)(186003)(8936002)(66446008)(64756008)(2906002)(6506007)(71200400001)(5660300002)(19618925003)(4270600006)(66476007)(91956017)(76116006)(7696005)(66556008)(478600001)(558084003)(66946007)(9686003)(52536014)(110136005)(316002)(8676002)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Dbq27VrdtEBUJICq8PBj5CGi8iFr7MV5RKvNfl3qFNjEwZKhtEXWpX6BmN4FHQkESFv0f0484SWaUwgNxOcw29r9BshhXg0QNjSFxyk1Ue8TO3sSvqHxqSYHEEdHSlFVIjpjZplngXp4wTxQFlszitEZfG8wGz9PBFL0iOPWmN5gJZDA+egADo06H3F4+0NNQIGyD75KHyWLQMgsDlQ+OcySPiABaX7545KyOsjyEiOJH5UpnwmyCfcuq9LrsYnrorhoVwBlorjT9dgQWVUZxXU4MDeQRd9iaY/ogO+Dn/2WXEuNo/erk4UAoLR03ygeS8ln2MUO0EyI35pLmtJAnRfM/FonMsZJM4UyrokeLFtYggAwXW4f+WoazRHFKI65ORsxzddNyaslBwaVdTDo4eltqQ56sTqXDTsVqB4aV4gG38MBmKy6Q39wlfd/vX4/o64eSOnvGlwpgcR+jO1sZoeVR4eXniUqpg+qqrjCvJ1JtOeO9GmVYiEAJ9CDDl6dTGLcNq3MVn9ky+lVsqbHUVIJ0jehkXPd0x5uZ2nkWwxQnz/XbHCR5TsbaWLhG6ancDebaAmUQkgNbVejqw45GlZ5CBjDKxkG7FFSPL7HImzlaXE8r+/dClJlNtoW9/MMKsJoXM7DjSxJOmAXO7baxds+ciy4FemCx3lyJR/raAyHwkuj23FZvrUlExOarwTFUk1UNkhpp8O65eCUqFmxLQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f042f65-c07d-4c9b-2c6d-08d84da6a6fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 12:09:03.0292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 38Cl6hH83Eub9D0tvjlid4fG6gTi7+B6QkDt7yoDbuLyti+cm9n5AWM6VIDXe99hkckp6JNHX3wqkBTCLXI7XiAQnYPVigeWkwsOU6P0wNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3885
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
