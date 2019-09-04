Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADFBFA7B33
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 08:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfIDGIr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 02:08:47 -0400
Received: from mail-eopbgr150135.outbound.protection.outlook.com ([40.107.15.135]:21521
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbfIDGIq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Sep 2019 02:08:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qes1IVYELz1K/u2KRDdMaxPMxuA8JlzdjO+tHM85mSe00vIBxZnerjVRQEhJP5v603kaT0fRICezKFYIALZEDNvTRY/7t8K+HS6qGAlkDos+JeQN7x1MIvc+6I9rOieJ8oumKxq5AOdmakk7Hnu9cAiLWatRsB5g7WuZsAFkhLjNtV2zIpuIZ/uYKVMqt574BponvlgHp1svo39WatvUJrVpfxeHQBahTJxchuc+MD3kYSXZsiX0MfF9M5Ncyza3FQyxhsYtiKkGn/WeiNYXsXIv0iB2enos7vjISMRkatiftW+us5GxUjx2cJw59m4UY38lTl08Ed+DilpXjbRZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rGgxg4kHcBJ2dEs7hMKCI8EsIiLgQcQrJ8vgV2FqMQ=;
 b=BIDUk10bInnijw+YoXI50bhEdRWf6hAKShSoHjwu/ihzC9N09NLfJLO8gcj9RuTsZ1LSqqCxMD4r1VGn8lyQkFtbDXM5i+iMv1dARkREEXbEuhwTtWGKmH6obrK8ButRT+s51VzX8gwIT21aB5vCNIIm/k46lmhJA+1eE/Npiq6axJzQ+AjoCHE9TNoD/QZ5f5tS6diXJEFmni3wzQH0/Bs4a6DWG18OLZnHaE05HHhlNNKL9RjYCbkOLZ272Hxpi6Uv3fWmsDim9v7vhCYC9uaebm6hXT38isNCjl20/5dU33gzM/jneG29tEtME+sqOU4Z1S8Ny74ZZWTv+H2C3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirsa.com; dmarc=pass action=none header.from=cirsa.com;
 dkim=pass header.d=cirsa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirsa.onmicrosoft.com;
 s=selector2-cirsa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rGgxg4kHcBJ2dEs7hMKCI8EsIiLgQcQrJ8vgV2FqMQ=;
 b=aJ9Y+zHuc1fnHXT1rPgN8A/XO7OQgLyEC0Jr7iVD0HDypyOKI3cn5vS4ABnAlywFh57pMSsAn1D/xpY0cly6SsnPipb9bkb6RT1NgKdPfoEOzakR699pPoaVpjQICHpPeRlp5LsrOfXNhIujs0adIfRvnlEMww4GQKJYf0EZAWw=
Received: from AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM (10.255.123.23) by
 AM6PR10MB2327.EURPRD10.PROD.OUTLOOK.COM (20.177.115.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.22; Wed, 4 Sep 2019 06:08:42 +0000
Received: from AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6864:7679:ad13:ea98]) by AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6864:7679:ad13:ea98%6]) with mapi id 15.20.2220.022; Wed, 4 Sep 2019
 06:08:42 +0000
From:   Jorge Fernandez Monteagudo <jorgefm@cirsa.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: btrfs and checksum
Thread-Topic: btrfs and checksum
Thread-Index: AQHVYuV0Bwq6n8twVEGqFBAVEg/N3w==
Date:   Wed, 4 Sep 2019 06:08:42 +0000
Message-ID: <AM6PR10MB3399AD2694BEC12D6C262309A1B80@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: es-ES, en-US
Content-Language: es-ES
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jorgefm@cirsa.com; 
x-originating-ip: [185.180.48.110]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dee47e03-42d3-4d23-30ae-08d730fe5680
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR10MB2327;
x-ms-traffictypediagnostic: AM6PR10MB2327:
x-microsoft-antispam-prvs: <AM6PR10MB232706D3A2DBF4BE7A0A4B82A1B80@AM6PR10MB2327.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(54014002)(2501003)(52536014)(2906002)(66066001)(33656002)(476003)(478600001)(486006)(14454004)(26005)(7696005)(99286004)(86362001)(186003)(102836004)(110136005)(6506007)(316002)(3480700005)(25786009)(55016002)(6246003)(66946007)(76116006)(7736002)(305945005)(66476007)(66556008)(64756008)(66446008)(74316002)(81156014)(6436002)(71190400001)(71200400001)(256004)(14444005)(81166006)(8936002)(5660300002)(3846002)(53936002)(7116003)(9686003)(229853002)(8676002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR10MB2327;H:AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cirsa.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WVoYdQWuoL73hQBwIIIeTMLW6GKqwAN/DrPlzXdtoku4hiT5MYapIzUTtFQJ3yfDueoCJRdMucrTQHiFrtp9dlClKesBJtmSmSVBr9Er6JS3XKGWUuJwOsAJ9fzuvILrAniDjdqxF4xh0uA1qhNc9pwmHJPWqWEhIkOXj+6vMrKQzrDkEYpAzoxxeDalTiySwJW2D/Ij6nhdYnuQQ9lWD+gkfDZ8n/LoDZ9MGHFh9P2tbncMi9bpkSJkuA7fhPjzGXBD3bTU1BfNFqBPsCRaVxnLAjEfS+RhZDJEXcp6WCApK06vH9PzIVA49U8jewOeN4FbORV6ZCGrzAKuXa8lEAvqF7mHYSjATADMqsWW0s498ug/tPLVSwc2Hxb4xX5bgUp6lw9UkzUu0QeJy6GiUq2M/wduJlmbP/Y/xy+mqQA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cirsa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee47e03-42d3-4d23-30ae-08d730fe5680
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 06:08:42.5553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6d255d9-7bfe-42f2-a01e-09634cc3a03b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HqzSImtqeuz6rMumXJBMLdvcmJXoVD4WQncjHFGRseDigMGgUygP5szx/qTeodkDJj87qgReqQJOkY3ho0FFyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2327
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu, thanks for answering!=0A=
=0A=
>RO of the ext4, and still get corruption? Definitely looks like a=0A=
>hardware problem to me.=0A=
=0A=
It's a weird error, because rebooting the machine the previous error disape=
ars and the file could be read ok, then we know that the info in disk is ok=
. Then, the suspects list grows up: disk, RAM memory, kernel error (block l=
ayer?, filesystem layer?).... It's not a frequent bug so it's difficult to =
debug it.=0A=
=0A=
=0A=
>For btrfs, as long as you're using data csum (default), btrfs can detect=
=0A=
>such corruption.=0A=
>=0A=
>For v5.2 kernel, btrfs can even detects some easy to expose memory=0A=
>corruption.=0A=
>=0A=
>But please keep in mind that, due to the fact btrfs (at least least=0A=
>version) is very picky about corrupted on-disk data or memory, if you=0A=
>find something wrong, you need to check dmesg to see what's going wrong.=
=0A=
>=0A=
>Furthermore, if your ssd is not reliable, especially when it lies about=0A=
>FLUSH/FUA, btrfs can be easier to be corrupted, as btrfs completely=0A=
>relies on FLUSH/FUA and metadata COW to ensure its safety against=0A=
>powerloss, it's way easier to get corrupted if FLUSH/FUA is not=0A=
>implemented corrected.=0A=
>=0A=
>(On the other hand, btrfs is more robust against data corruption, so as=0A=
>long as your SSD is OK, you may find a better experience using btrfs)=0A=
=0A=
Then, it's advised to change the ext4 to btrfs or it's better to change the=
 ISO packages filesytem to btrfs?=0A=
=0A=
Thanks!=0A=
Jorge=
