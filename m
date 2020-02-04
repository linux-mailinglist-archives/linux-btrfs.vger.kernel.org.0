Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 671AB151EC6
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgBDQ4y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:56:54 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:17048 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgBDQ4y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580835414; x=1612371414;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=qjgyF9u7lJdQUw/917ZYZWqQqIDqkjIrNPKIky8ITgDGFvZSqyTS+NVm
   OE1IfTSShziYYG9QvXB93NxyWV5asmVHGybyJkMqYqxOTjXLBLm3P2NvK
   jmc8rlRkiKK7mbsu294DcMbnfIAMtvfarObAnz6giwe46PYmnZplFnQzu
   mGslK/+xIXhjPk1OwHtyFOK3eJfAD0zfOXnanIVxgUo+0MgijN6+jEG//
   SfsKOKwgEH73yDjW2f/ey6VdsUam7+YAuvYkUdRrtD377w2zDUQi9j9Lg
   3sCFUYeyFfY6BEWQWJM0QQ56J4Jn4kUOVEjS1MJpwDwG2BxzZLQVCPUfb
   g==;
IronPort-SDR: fAtm+m+PrZU2nph8Bzkz8zT5j1HSOcdLIUbkOoU/cS+dnVbJkLlVKgk3euacL055zx6lXPkrHk
 BfxofNxU+jK/SsEC4OsBkjeQPBWX2gJ8YJm4fMu5cDkCZuZuOcZycYsU6AcACQM4Vt/423lYeR
 o8QnWq8Kt1VwJaV0AGitwh+ulFky9uj8J6MGEfJ7d1Q7g1wtnwWYtbBJI7mZ27/WBqxHQbUWkN
 ykGqRBEWJ/s7qMsNqtde0tmrw3FaYq/okhbX3sTx7RqypRsqlfbNW6I+X6cNYO7u85ploi0M1I
 oz0=
X-IronPort-AV: E=Sophos;i="5.70,402,1574092800"; 
   d="scan'208";a="130540180"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 00:56:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGDOrTkhL/UefVCJA6RFliFO3JZuC7l2auW3wkrHxQ1AEqi7lCv7k4Sm5xKdqxhTd8YB85vATJl1r/EllKqbcYite+eauigjlKAGebX1v6rDdBagmcSPNhaXwIjApRkiUyuVFy2VzVk3DoKfv0gkdj4kdfdwxkFB2P7DILHsPIRUdmEnkOfDdF9Ov2fKT6zORi0c5ooHHh1VMNFOK1+3MF/5wScZrH5B4AnLfXxJqRwIjYQgb5oUvXKIepjjJKx6MCM4R2vGpy4UflKn3H/Erz4My7rbenDLJJfEhh5Owm1Hgo+MwZivku9GSARWyjUrMaWrFX9kFEuOiMYHYRjWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=fzmuaL1QM+BF416Cg7SYaIEfMXObz1hGzTkv+l2xyxCxLmEZjMpDzQbjmfspFVMgwBGI6tjoZR92L0fblMnFflrJw+LmKunvUqe1NFZalBlgzECshZMOWMfmhKdiTP4xwvnTUjMg8Z+wngc/z89gkkVpIA2FA5FhETAMtoapEOtzheQJt0rD8+67iTuJngGWKafCCeHDMrS4W2EPdwBWyp61I8tyVxGqgTKwPqQyT578wHQrtO0mitj6xrnKzymnm4Fbz0b6R7GYgMsPzG26mcFoSb7hCWogME3E7ulhjVrj7gh+IPGUohh77+7Kx5ngV1ncGd/HUE5yQRcB73fmSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=h6XTL/4nu9DrCt+yCu74fdMJ+FZZCblnkXqAkk+aK16yae5Bh1uQPZB1a8FHo53nDFhmcap2alNxUMGkGJpZMsbJWMIySx7eWJAP3pOyzvZ8Gu6Uax0jb9UCQeAP7/NuPlvp2QWuM0uTytDDcungIFRQnnqF68bn0DoXO9awuug=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3518.namprd04.prod.outlook.com (10.167.150.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Tue, 4 Feb 2020 16:56:50 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 16:56:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 13/23] btrfs: add the data transaction commit logic into
 may_commit_transaction
Thread-Topic: [PATCH 13/23] btrfs: add the data transaction commit logic into
 may_commit_transaction
Thread-Index: AQHV23cZ95XyZrkBhES3DhNk/JCHNA==
Date:   Tue, 4 Feb 2020 16:56:50 +0000
Message-ID: <SN4PR0401MB3598BE79C18E110E3903738F9B030@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
 <20200204161951.764935-14-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a9307d63-1cd3-453e-f7b8-08d7a9933ab8
x-ms-traffictypediagnostic: SN4PR0401MB3518:
x-microsoft-antispam-prvs: <SN4PR0401MB3518F73A20B08DEF04C1EB969B030@SN4PR0401MB3518.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(189003)(199004)(6506007)(4326008)(86362001)(9686003)(55016002)(5660300002)(186003)(26005)(316002)(7696005)(81166006)(81156014)(8936002)(33656002)(110136005)(478600001)(8676002)(4270600006)(71200400001)(64756008)(558084003)(66946007)(19618925003)(2906002)(76116006)(91956017)(66446008)(66556008)(66476007)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3518;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ao5S95KKSts9s92s9kOPqn1oV43nKzRBTL+KVxVE/brcHHonE7qSmfJCIOVdPEf6EqFS9VggTLRdrvdHRVgoUv6CguQSohEKWCF+7jPqS+ghlsLNaX+7QJB5LJXXR6vdCX4hHqulgOIU0nbzPnDpUQJLnTcZ82xhd/d84jy4izkxRhDJczXCwECNeJahjkXkrYrzwCkqmIVTUIZNDo7pUEqomKwUlLaWaaLfNuQSnIJom+QX1yHaaiw8NcDl8E7PmRT+scX7ari0Au2fbYvXDKAWXs4m2N2Ec20CrHwWOI6hehA56u7wRM29LCjOKHBt9g5AhjaQSXrWophu4qm1dofVejkZhwJIuj7A2mK7RtnvfuAtenqgaMfw/ZV6pCcm7sIVYh9ycXPMWkq0PP+yEj0RI21budak9CQr+pES5ew62jaaElMsu43laWdcCSBx
x-ms-exchange-antispam-messagedata: uuBxePcNAGu8xSRDbRt/JTt77F0Oa1Jgil4ghvh9tPoVKqCN5LTSJFX1cCdHOnOrZG4GyaSUSbve37ghORSLGYUABZ+BrKMvCBsp6dNwxdeWQ1W8C4xaRd0UL0d+sT5Zubq/IbDGGuQK27m08OCC1g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9307d63-1cd3-453e-f7b8-08d7a9933ab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 16:56:50.5652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qr0bjNDbjisYYTidjmNNJKgwl8EOR4zuwizyNXHS1u7VKWs27JDbDDzSHrwk5AMHh8W4mvdNCBZf4uVNRj/jpweQqKnvDY1abvfzhiranzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3518
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
