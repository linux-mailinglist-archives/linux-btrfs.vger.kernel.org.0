Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE09BA7BA1
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 08:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfIDGXb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 02:23:31 -0400
Received: from mail-eopbgr20105.outbound.protection.outlook.com ([40.107.2.105]:28839
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725267AbfIDGXa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Sep 2019 02:23:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lsi30zz5ITMn6S4dHWZc5kuV5O5PnoA6DxuKdEESYwAthNEOrSPYOo851sVfle9dmF9GlMXyR+fzlBO4skPb7S7zqAjLDd0R3yOGmmg8POsZlqKMx8BBsOdLmB2X/iXrK7RpL3iii5rMzEF8Myr2ke5r04AbUezCh/cnkxtbS7gPRWqlezBsbbImEeC76sMce6qCNSgtOSgdcLSQwuEEWtMZ6JaGUHTKg8RFB2K/V3MjsKRuKrcajuRfSiHLbhrZRAxThvqTPzQFlBYGFkIIG7kvYhourkAn0Dgs6qMiUb6ernn6PReeHo+E+47PVwcS1CNdbjWzVuzZJuLuE212JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iu5NKYznCM3YJ8eGqegsNV3HkcvAwm2mSsOBCcS0ePQ=;
 b=nfGG483vOgEF5Kg8BsOwed/GrwHNNtp/K1OO6OltDcr/kbVd8wMPcpbul55qz2sRHsebSE6FQg+N+Mt9qhUTc286VVuQEQGFqY9A/XLfTSG6o6vMRW3b276HswFDCelRfMQ8WK73qEwF1sKXdvq3NCHiRtttVcierJLfp/3GwDrOvIz7t08mCaigUyyTqNe1rWn3QP98eU8rWuuKGLTxK6JnnJSt3seRo+yNM73OzcVUMQr5dXJmfAjWoUaFzTK1mKkHTQuRs60e+JaC7Yq/UyyLdGEql/5z/D/q04H1Z6y4S9Ye4TDndIavNkPoPY1Q9kyeEVdEuAG8v7T+MyWJ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirsa.com; dmarc=pass action=none header.from=cirsa.com;
 dkim=pass header.d=cirsa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirsa.onmicrosoft.com;
 s=selector2-cirsa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iu5NKYznCM3YJ8eGqegsNV3HkcvAwm2mSsOBCcS0ePQ=;
 b=NuVtvOxjPFA///byN95lJIPdutpbqcPpAtfepaJWVWctAZmSyp2cdDgs4G5IlTi+nEPCcGo7Nc0hLAcrOpu3boYWAQ18mccE8A1RqfkaYW9JkhENLy2yGdPy6ShnZKbVumrOlX7xw96ZASWM8Otb/vZsb6kHmK1JsHZ2ULYnAIw=
Received: from AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM (10.255.123.23) by
 AM6PR10MB2664.EURPRD10.PROD.OUTLOOK.COM (20.179.1.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Wed, 4 Sep 2019 06:23:27 +0000
Received: from AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6864:7679:ad13:ea98]) by AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6864:7679:ad13:ea98%6]) with mapi id 15.20.2220.022; Wed, 4 Sep 2019
 06:23:27 +0000
From:   Jorge Fernandez Monteagudo <jorgefm@cirsa.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: crypted btrfs in a file
Thread-Topic: crypted btrfs in a file
Thread-Index: AQHVYujiWxzQtP5zw06pZsChWgT+AQ==
Date:   Wed, 4 Sep 2019 06:23:27 +0000
Message-ID: <AM6PR10MB3399F318A3BAA232A0BCAA48A1B80@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: es-ES, en-US
Content-Language: es-ES
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jorgefm@cirsa.com; 
x-originating-ip: [185.180.48.110]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b044676-6b49-4b00-fb86-08d7310065fe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR10MB2664;
x-ms-traffictypediagnostic: AM6PR10MB2664:
x-microsoft-antispam-prvs: <AM6PR10MB2664AED92B28A34202EE2FF9A1B80@AM6PR10MB2664.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(366004)(396003)(136003)(199004)(189003)(53754006)(25786009)(9686003)(6116002)(3846002)(2501003)(186003)(6506007)(2351001)(26005)(5640700003)(74316002)(6436002)(55016002)(102836004)(86362001)(478600001)(4744005)(5660300002)(14454004)(52536014)(53936002)(8936002)(66066001)(2906002)(316002)(7736002)(486006)(476003)(81156014)(33656002)(81166006)(99286004)(305945005)(256004)(71190400001)(71200400001)(6916009)(7696005)(66446008)(66946007)(8676002)(66556008)(76116006)(64756008)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR10MB2664;H:AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cirsa.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NtW/Xw80WDcolbvZ9zuhiQ/cjJb2RMQ68Yb5zXNq6OvE7oGaVIyejSYxvsFUxBlabPDBFca+9Wq4g+5IcWY/dzALfzvo83/BoKHPlzHrshpQlKk0lX+6r+drbVyviPghAPEHVhIiJjuvRMvY/UGv/tOncNF6bP7ypqyJIGV/rr0Q9dwUEb7znblRgksCtnTilSfTgBMIIMwv+M8iUoCklscLF5mt6+TzkcWa+w4IgcRJHXqcwCHiudBAsDOVwlxdFU0lijY900M0+CqNNJFR6OIl1yfIpjBYIeHE5VIKUqXB8NZPAok87kQ3pHWZOi80jEvIExCrV+/rN2hJ2vIveeqNKxqIZ2uufiQFoOX2rw9frIAVVrwvD6pzjXLak6IaNpN4zUzkidmhbhp8wDwhpcEWX994q5y0JYyrmBs/o54=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cirsa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b044676-6b49-4b00-fb86-08d7310065fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 06:23:27.6415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6d255d9-7bfe-42f2-a01e-09634cc3a03b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3pSDv7ci4K9RgrtThf7Nsl3fuIFTUxHKWnqtejEVfbBzvD74vQtdOeVVcuUDU4YNPMc4nkPPd4LenKaE3JsJgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2664
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all!=0A=
=0A=
Is it possible to get a crypted btrfs in a file? Currently I'm doing this t=
o get a crypted ISO filesystem in a file:=0A=
=0A=
# genisoimage -R -J -iso-level 4 -o iso.img <dir_to_put_in_the_image>=0A=
# fallocate iso-crypted.img -l $(stat --printf=3D"%s" iso.img)=0A=
# cryptsetup -d <key_to_crypt_iso> create test iso-crypted.img=0A=
# dd if=3Diso.img of=3D/dev/mapper/test bs=3D512=0A=
# sync=0A=
# cryptsetup remove test=0A=
=0A=
Is it possible to do something similar in btrfs? Is there something similar=
 to 'genisoimage' in btrfs ? Or, at least, given a directory, is it possibl=
e to know the outcome size of the filesystem to create an empty file with f=
allocate and create a btrfs in a loop device like:=0A=
=0A=
# fallocate btrfs-crypted.img -l <btrfs_size_for_dir_to_put_in_the_image>=
=0A=
# losetup /dev/loop0 btrfs-crypted.img=0A=
# mkfs.btrfs /dev/loop0=0A=
=0A=
then we can mount the loop0, copy the files, unmount and then crypt the btr=
fs-crypted.img like the ISO one.=0A=
=0A=
Thanks!=0A=
Jorge=0A=
=0A=
=0A=
=0A=
=0A=
