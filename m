Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC4C1EB7C1
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jun 2020 10:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgFBI7B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jun 2020 04:59:01 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16381 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgFBI7B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Jun 2020 04:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591088340; x=1622624340;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=RVteMg6CGQu7EE8LPO2FOPZtuySTpRZjKvAIrmF1YPs0xMMkgAU75P0B
   1BIHtRlcqpe7Fm6PmMd9k1t31PluMw7GJoOAcoVvp2oZB5d6yK3uEkrE7
   IgtU5BO6A7FRgh4p9c7CrX4FixB55i9GKCw8+G7aiELNrT/rXfMkfZWYe
   HI8MCA49EmHCf2o05S+0SRh92RI4YTjaakW/mIpRJsngWpWZxQKkw54ws
   hoTPeh2WCY0f32o1X0bqHK1938Y3HJyP7ruKFWZOlsXsmqOmPFhCfEYi2
   xuegzkKV/W2KFzfMTBvV0EbZ/DERBnAbA4bPZCSWVoeqh4yOddJfkdWfi
   A==;
IronPort-SDR: DLsbN1gw3VNRtKA0I385upvnzxhOsoSLcwqNU4dbQUc9k3coBZ0xIvxs8ZGNG8c3zs2jCh0Ikr
 +gnuft7zz1KYaatD3PXl0kXnu/tZNlI3Av4ETVkRXbVmBv6DIhNoMPkpJU2WoxnKkg+w3MfjYz
 6d57AqEJO7BDaMxYqdmxsY6NW+i+ii6v5ZYa40YQ6E5LIzUBchyZfUE2DbYgZYk8dKpxrXKQVY
 6dpVsG3dvilke8QNlPcVyJSZwdpUbexHseMaESoDCFHcYKE2nr94PtMWJ/+V+cwCAAgC2Erpkk
 3hs=
X-IronPort-AV: E=Sophos;i="5.73,463,1583164800"; 
   d="scan'208";a="139334609"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 16:59:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOCWkgQCHmyTNynKchFNFIMgWiYMqYAKtJqxNpPH3G1MXYfodEUxpqs+n7vAsgGBS4sByQs/JORiBVRs9O2xxP3r035GMkCY/ZxF2c0M4gkJy0b4xWIyhtNcx9FoGtnEGIfHq8E+mUg5y3g/DTyTDB6AQQn0XUjIRdODYGC+ZYCY5ilIQwlj6VPYvV9y+3xLiLyU2jXMsQQSC4VYCVvRej1WiMI92ZX/hEKRxuSyyDK7X9BoWBHT9Ot2bQzeEcPtgHbCDCO1oLcr3TlR+9boL9lKWsusoo5z/K3lxN0u1/ldmTReUNhrK7gt+wIq9h1n3N0bnBwQ1iagf8/Yfc+BuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=bD+6wozCbEpj+Mh+6gzXpyDl97A842Liv1aE0E+hBEeF9k1ExWGVUExrUfoR5zDuCcwDYNB703/YGNH7dqm8N6dMz+zxWeyLEMlxqkjeQRS9IysCVNswixL6LTlEmqoHzMghi/qAZwVDckL0CbFi8jHBb29mXVbWMGIeRazcKbdha3z0QjekTFQgcU1PVa5fQhvxWdILB6jFgLmUDYw2Pt9zsZRfLInbwm61JUiWKKaKgpSLstq3B4zDrlB9PMq7ilRmp5OPOJJE1U7/CrEM4AuV8ljIgBsDJkRgr5Yj4LdHyBHpFdhYcT1jdolOMjnow1vtTICLGtltV4hV7Pp+DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ayIugjmfFbIQFha/tSu1F/SRZeWrtx+Q+njZgtosFwk5QzLQOvGVqWJhI3VesZw136R8XiGa4ctmD88PAnRLbHRdQrK9XmEUpW5NOSQ8WRlHXp/tnpSzUOa/OuUkPoevvna+y2RHjcvZ0ZJVyh7tF+OsJuyE7mh18tFYmqmOXkg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3695.namprd04.prod.outlook.com
 (2603:10b6:803:4b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Tue, 2 Jun
 2020 08:58:58 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3045.022; Tue, 2 Jun 2020
 08:58:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/46] btrfs: Make create_io_em take btrfs_inode
Thread-Topic: [PATCH 05/46] btrfs: Make create_io_em take btrfs_inode
Thread-Index: AQHWOCqgKGsgrMW8VkGS24Y68SO8Tw==
Date:   Tue, 2 Jun 2020 08:58:58 +0000
Message-ID: <SN4PR0401MB35988A272CDE9ECD440A1D3A9B8B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200601153744.31891-1-nborisov@suse.com>
 <20200601153744.31891-6-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d351d9b6-6ffc-4029-4dc1-08d806d33008
x-ms-traffictypediagnostic: SN4PR0401MB3695:
x-microsoft-antispam-prvs: <SN4PR0401MB369509110960A777984958E39B8B0@SN4PR0401MB3695.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pmA7IG99vNZbwMjlKEBBkAk7BSIx53NDYL0InE65X/pA54PYBE1wMEGYDcoLMgTpH3LTFUwqxShteupO9DuGaMwGD1o6QrsIFf9s8FCIjtZz2FP1Ac38SlmgoPW2nDldagRKku6lQW703jC9QYyj/jgjmzr0H3FSQkAMdvWkvERxGDOQ9Eg+1RrJR7pVkSSa8j1/JZaktm4+AwyWleQH6KKEscpD4WMsBXQi6StTXDOE4YvirupBRRZegKyW9PCVEAMQXgU3QZeog/EcqIGarB5WgMuiw6nPpMw0CMKERWCgj3oU9uA+0yBEPyT0y/jfstwh9OAJOYvKFSm2Elgo2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(8676002)(76116006)(8936002)(91956017)(5660300002)(66476007)(6506007)(64756008)(110136005)(9686003)(26005)(66946007)(55016002)(558084003)(2906002)(66556008)(66446008)(19618925003)(316002)(52536014)(186003)(71200400001)(33656002)(478600001)(4270600006)(7696005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: i7QTWZohkx9mbA5NOhZMpGimH4QR2SKcY0lWQ6WixihuHqPutzIJnvDtyW3vvLdVID/RxiQUb6snrcIlBfrViWQuSKcz1N04d7y76KVXprDOR2EO0G+jHeZqSMSnNNZ7/kIjk7bK/5jYix6C7qX5FbCa7d89DnOxVbP/XZCHChQazTtFvzjjeohNh4Gr9EbeU93wmLyZs9gCAqZtNjUUy84CbZBo3zq85pyvzP4pAfHOrbwzB9bdgjqC7XdZvWyyBjU2V6xRsLSwr7eafUQg/rIJDEwLtKyKou1vLCwHq7rJTQblSp27OriL8ExSvsFLRh5j+hD9XUCo8plCncVwP0PXz1uhdFdnHnaaNgOBCwAtxsWZlHqoU5TUHTmM9xaFaLS+btyLeiUyHtKJBj7WMma0G3cvNZ/UROvdQ7SGJkklgY+8gFGDrgNCc0/sx3LAaaxBYdipx0RO5ApQGVl1N12FX3w0f39s5rhR38+qFArG0gO1zWqO0v9td+ngWlsc
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d351d9b6-6ffc-4029-4dc1-08d806d33008
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 08:58:58.5662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j3/VbKwei3B65c6AIUwu/E5KucUA5NSzdiUw8P/MTT6SN50SkoOpkTBfu55a1fbDpd0ahhoVMb6pmgWrw67UsLoNBgos9XcEde5sS/3Fsvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3695
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
