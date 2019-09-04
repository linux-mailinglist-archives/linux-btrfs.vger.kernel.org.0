Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C874DA832B
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 14:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbfIDMqM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 08:46:12 -0400
Received: from mail-eopbgr50126.outbound.protection.outlook.com ([40.107.5.126]:9955
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729398AbfIDMqM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Sep 2019 08:46:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jq9Sn2EyGivH+FKEBAcldSxfxNMhrdEOjuUNYMNA3lBNoJZsZd2LHrGCtrDKQP+4NflII1pu97UzOiFCPhVOq4+HClPvZO+RYDfJ/C9ZfSvwjdu+hBA5zSu0GpbTBWkon3x2ZWsnNF0di0foVt0xvHPqrrjTwIQ4tz7fHheIjb808WJ4TaR7pZuqPNoaOBBps/krG9BoBeAVOWzcA9ZEUCY5GWBMVwg6wR20/aF1VpoC+RZEetWOMdUZ8rCZG9ujMr1k1QHZ9dagaoFYlsu2AyTBak/EFky+HAGJaOhUWMz3aSJi/AoCZEpiH6+FyJkuvsBWVYN/n/oOEll8cwlQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ua04i8E2QO5RCzrMAs5giBTSCpqDhuD7XtMFcTCBlig=;
 b=LTfQrtidQmLqB55oZskOQLPXQijbrIljDnzI4aGX3O4DFF9zkLBzb1J5iSu+bqMIgUJDTXnkfwEj6NQJjrbdUqzbDg2DJQfV8UJHv3pqhYGTaG2FxS41yDTgWcNIlKxRDqRh9RgNQK59LXqHEBrIue2i4/FrPS8WcZw3haw97Jdh9aXnwj0q8m6Not4kCL9QrohWZWqDtelvLmcgZOcFZXHQ6jDTjM3Jt6rAKWvVtyVJogaX66ehDKujrCdNakjcCL9CUzGQiJwYAolqiRc6vYdYONBcWE4K75edHhgXY5gMjdUiRuvGX4MCq6XkcxcOCq7/oOCjXXlGKqckUEKQQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirsa.com; dmarc=pass action=none header.from=cirsa.com;
 dkim=pass header.d=cirsa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirsa.onmicrosoft.com;
 s=selector2-cirsa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ua04i8E2QO5RCzrMAs5giBTSCpqDhuD7XtMFcTCBlig=;
 b=LoL01+nyVW2ft4jVXApSf+f7aDSZuuFTRmzrRMjtGWfIAP/yMmY1HGJF5oUU9WjtsXxsBI2kZdpHp1HZDoh5OndXTpIdid2yb35fjxQC0/m9HTp6BYslQ04XmTLxAZovbZG0F60k9kn2oABJmK7CK2lj/tZRh1ymDbBPv93xKkE=
Received: from AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM (10.255.123.23) by
 AM6PR10MB2520.EURPRD10.PROD.OUTLOOK.COM (20.177.113.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Wed, 4 Sep 2019 12:46:09 +0000
Received: from AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6864:7679:ad13:ea98]) by AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6864:7679:ad13:ea98%6]) with mapi id 15.20.2220.022; Wed, 4 Sep 2019
 12:46:09 +0000
From:   Jorge Fernandez Monteagudo <jorgefm@cirsa.com>
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: crypted btrfs in a file
Thread-Topic: crypted btrfs in a file
Thread-Index: AQHVYujiWxzQtP5zw06pZsChWgT+AacbcPiAgAAFqVU=
Date:   Wed, 4 Sep 2019 12:46:09 +0000
Message-ID: <AM6PR10MB33994032ED7F1C041BE060E8A1B80@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
References: <AM6PR10MB3399F318A3BAA232A0BCAA48A1B80@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>,<effe8460-808b-e94f-33f5-b7a5ea4ec8f8@gmail.com>
In-Reply-To: <effe8460-808b-e94f-33f5-b7a5ea4ec8f8@gmail.com>
Accept-Language: es-ES, en-US
Content-Language: es-ES
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jorgefm@cirsa.com; 
x-originating-ip: [185.180.48.110]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebbd7ddb-5578-4813-0c9d-08d73135dc1e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR10MB2520;
x-ms-traffictypediagnostic: AM6PR10MB2520:
x-microsoft-antispam-prvs: <AM6PR10MB2520A9678CEE20C892FC57C3A1B80@AM6PR10MB2520.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(136003)(39860400002)(396003)(189003)(199004)(5660300002)(66556008)(478600001)(14444005)(256004)(2906002)(76116006)(66946007)(25786009)(66476007)(64756008)(66446008)(7696005)(71190400001)(71200400001)(6116002)(3846002)(52536014)(81166006)(76176011)(229853002)(8676002)(81156014)(8936002)(99286004)(305945005)(446003)(7736002)(11346002)(55016002)(9686003)(102836004)(53936002)(6246003)(6506007)(33656002)(486006)(186003)(66066001)(316002)(86362001)(74316002)(4744005)(26005)(2501003)(476003)(110136005)(6436002)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR10MB2520;H:AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cirsa.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yFFwM1OcLgJWvzxXN1OsZb2accUYrNzqwzCVwnmM3SbXUlzEAjxnEVcodt6K319LZyDcPsbgkN4y8jFx8LSV5E2wju6nuggMgGLp06TLT/mJZxpT4A3IentPLIKqG0HCIp4ihG+h8GOX8IEpSIcmJPXj1RVWxl5AJMkSzMbXspHO6jPpiAkfkKh2/SIoBsnPsGWP1LnNFBq9lCLHDbxs6+wQRbRSyWo3/EvvwIPxYaeqhDewlM9r5bA/2hymutVYtWT/53Lz8eauSGR0AZN3aaY5Uu8Jh8UBOtl4CnLwR20UuksBc1WUrMt/4u/17K9FCSN/SigfMNF1f29Nv+ofqmvQcqj4AInynhKpxhF36wQmZ+D6zalDJkd4uKWmhcVja9mg75SLcyE9xg49sf50S/COIrsXWzA9cg3abiKyIfk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cirsa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbd7ddb-5578-4813-0c9d-08d73135dc1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 12:46:09.1229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6d255d9-7bfe-42f2-a01e-09634cc3a03b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6hGRyLCRRhhfSNKK/wVtjWuhGVgIDhvLD24evFZWclnATB9AOglDcPOfyPIC+g7O2Jc3R9d8ZI5tm+Qg7JmSbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2520
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Austin!=0A=
=A0=0A=
>What you want here is mkfs.btrfs with the `-r` and `--shrink` options.=0A=
>=0A=
>So, for your specific example, replace the genisoimage command from your =
=0A=
>first example with this and update the file names appropriately:=0A=
>=0A=
># mkfs.btrfs -r <dir_to_put_in_the_image> --shrink btrfs.img=0A=
>=0A=
>Note that you don't need and shouldn't use a loop mount for the target =0A=
>file for the `mkfs` command.=A0 It will generate the file at the =0A=
>appropriate size automatically (and as a general rule, `mkfs` for any =0A=
>filesystem works just fine without a loop mount, you just need to have a =
=0A=
>file of the right size for most of them).=0A=
=0A=
And is there someway to generate a crypted btrfs directly or is it better t=
o do it using cryptsetup as I'm doing in the example?=0A=
=0A=
Regards=0A=
Jorge=
