Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6643643E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 15:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbhDSNW7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 09:22:59 -0400
Received: from mx0b-002ab301.pphosted.com ([148.163.154.99]:64256 "EHLO
        mx0b-002ab301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241562AbhDSNU5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 09:20:57 -0400
Received: from pps.filterd (m0118795.ppops.net [127.0.0.1])
        by mx0b-002ab301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JD7qwF013301;
        Mon, 19 Apr 2021 09:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps-02182019;
 bh=OIEce6/oc/YJTGKa5fb+ssnSYv75Q1153X81/mV1bdI=;
 b=TSTDxgNYL/I16Q9XQLyLu0mRRmOtffeC/5rXi4i/uTRpBNh6dGGEkVDEO34M8WnH3FeN
 EV8taSGjiIj5jfapQ0PomYUQtUbZgLmPBMHd+7TRGc1YwxMDU6BLu2ymBK0EidpYmzyO
 anYns0qErzzz4aT0NoJju1TUcYgzSnXlnvu6avxE5Kb884iL+Q/Ha2aUlgzY8pVzyF8f
 NUNXENKi6IW6Q6YCDHgGJa55oKm0N9IhnS9lJws5Q7E90eXeAIYHuORJymz2FMzq4yhb
 foDzB1xOL9BBXdKNEboyRXBWfWQMHZWMFfFWpTg6jV2jsDhEpWlhmZzN4gmwTsNQbMFb Fw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by mx0b-002ab301.pphosted.com with ESMTP id 38123g09a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 09:20:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adlppET16lWDRJ7LwXqQD7TOf0dmej5Wl/e8ro8WzxCZ2yhMcs67Ixb11xOx1/BRQax4/+wYulnpcWv1jOd0l2BeqFkgDV7fvzmN3b6iSfEepJ8gW/KzEVQNPzrq5k3WQLjtDrWd/Nuq37a9aH47vpEG8e3JpujpULEeMseJjgC6FBgRRmNF4Z4bPaDfy84mz2kGs16nTP7fp91miKSz+GRLoBMO5Z0szxJnB79XO/pAcoPejZUNuW+KRKxXyY9Wl4zvUYCSRm5duWTzM+P3u4jZGHwaknfBbJsuG0sGPn4DkAEai7QaqwgVqiooUP6xNAeh444plEbGO228IiZY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIEce6/oc/YJTGKa5fb+ssnSYv75Q1153X81/mV1bdI=;
 b=iTgu7klFBlQLZ/rGGzRrL8gbvGG+8zMMqlHKNWAk34tV4ROz4r+yDSnwl8wGwGM7byZPg55j530eySBh99+Ew5PX1hkHf1YoazXWa/tw5tYeLQ7zabe0Kzmmba2Llq/xPfNPB59MVIysra6WYiih1yDNN8dwQuZJwCCjsRFaqPdUq7EGA6ie3mQNYKpbHL35z8B8sKdezr7clUBePTnpt+FWoocGVVc0OE6pixjD9DLCWHxrfvdmE/fNc9QCYBDW4C01kd7jdwnoSrMiX6zBGxq0uTHcFSm8kY3HpMNtI9sYXMEllHTR8+WGVO2meMB8aa/MPxBJqIU2adlYqlqh8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=distech-controls.com; dmarc=pass action=none
 header.from=distech-controls.com; dkim=pass header.d=distech-controls.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIEce6/oc/YJTGKa5fb+ssnSYv75Q1153X81/mV1bdI=;
 b=QNipDQNc7mNIHOIC+PZZo7YGPXh9r0xWXvs0PiZzVd3IDkkDteHWd3YW1uOE3SuUkaT7/kk0uSZ/u3CG+Fz+nF3beTymlbddyGWnX54NosC9lynIkc2rHdpsAAmE8pQZ0YF/vp4hqvmj6FRUnimdLISssPhPRXvDqQfXCkAprXI=
Received: from SN6PR01MB4269.prod.exchangelabs.com (2603:10b6:805:ad::23) by
 SN6PR0102MB3326.prod.exchangelabs.com (2603:10b6:805:12::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.18; Mon, 19 Apr 2021 13:20:20 +0000
Received: from SN6PR01MB4269.prod.exchangelabs.com
 ([fe80::a960:87f5:c3ed:da0b]) by SN6PR01MB4269.prod.exchangelabs.com
 ([fe80::a960:87f5:c3ed:da0b%5]) with mapi id 15.20.4042.018; Mon, 19 Apr 2021
 13:20:20 +0000
From:   "Gervais, Francois" <FGervais@distech-controls.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: read time tree block corruption detected
Thread-Topic: read time tree block corruption detected
Thread-Index: AQHXMvQIVkE2UJzwZEu4ya+WYER7y6q35F6AgAPucjo=
Date:   Mon, 19 Apr 2021 13:20:19 +0000
Message-ID: <SN6PR01MB42690A51D0752719B9F1C6ACF3499@SN6PR01MB4269.prod.exchangelabs.com>
References: <DM6PR01MB4265447B51C4FD9CE1C89A3DF34C9@DM6PR01MB4265.prod.exchangelabs.com>,<666c6ea6-9015-1e50-e8a7-dc5b45cdac3c@gmx.com>
In-Reply-To: <666c6ea6-9015-1e50-e8a7-dc5b45cdac3c@gmx.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none
 header.from=distech-controls.com;
x-originating-ip: [76.67.142.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d37301a-954e-4f77-18b3-08d90335e1ae
x-ms-traffictypediagnostic: SN6PR0102MB3326:
x-microsoft-antispam-prvs: <SN6PR0102MB3326848B25599F10605FD21FF3499@SN6PR0102MB3326.prod.exchangelabs.com>
x-pp-identifier: acuityo365
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MftB5Fa6/w9TX4fn/5eT+j5IsaP7FSrlRiQ/fn8HoodRk+23MjvWUZG5bBukD87r5Zpi++Byg1njzM/mLMp6yEh8ZygcmjhTq/7J0fWMhFkni3aOarjNWPUxrs+oEgXkz+poSKRcgVUen1wgQ9GgSNQEfHsVSJZC4pBvdi1lhVRu2wPTvQACgOFWUH7qZt4VHrstpCgpGjbqk/zZgeu6cilPxveoYfYRHqk+lPbm9bckmDQ2Hl37+JsI7uxqOLJYZWMWhMwJExTBS+iAT13cY5fJAB2SKOST2LzR3SHtmIsjEGdLaxyQhcqpvuYnyWiq4H3cdB34HDCwR4gFesj5WYBhLwU9NoLG6UDD2pNUo2HTMY46bGwFe44jEgP4qMOJCEXplE8fK00PxLEQjIR9T+TCFnd198IB5x/ihlWtckmG3vs6WVnMlN/r1qjlX34SeUR24qdHtLHl1mwxGue9g1nurxs6FqhpvT/mbcpce3EZDOfdrRYlzSS7G7xNHoVvNTVkyS8JWCpSzHrMgEImUjIY64VNyttrzwhL+U8iu65ijwC5S/gOG3FHWA+xWVFvpmScaC/Rx3DXxRnvgWmM2e/VIkW+5kFhOxMsYMjuMJ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4269.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(366004)(396003)(136003)(376002)(5660300002)(8676002)(55016002)(52536014)(9686003)(316002)(6506007)(110136005)(66946007)(66556008)(4744005)(71200400001)(76116006)(66476007)(38100700002)(122000001)(8936002)(478600001)(66446008)(7696005)(64756008)(33656002)(2906002)(186003)(26005)(86362001)(83380400001)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?QiW6Ot7fjzkj8PIMpCs311uypjeXa4CeqjsH70JXvPyz/RkaGmI3TXRvJT?=
 =?iso-8859-1?Q?XP+9vba6IXbvWGSC4B/rta9sw1W9Ktd3DbAGpLU/hBdsFwaPNequ09NdIn?=
 =?iso-8859-1?Q?Pue25i8vrzEntPTDOEJJzL2LcFzyS+dt/E7J0/ntar1a+bfAOqR1Js09yh?=
 =?iso-8859-1?Q?vcp+nD4ocrW5TZkxfLUg/8oJ/k2vqYM5mqF9TONqIat6Q4QT33XuqCxBI+?=
 =?iso-8859-1?Q?05WyoBWyLzFj5cVu2JZCBkB39BgIzGehWtfuEEHqrCxq05JnWpxDzr6sLU?=
 =?iso-8859-1?Q?lYD7EOFqwRZItSB2NAsGffJzfZATBId3h17pLS/x/ETX+MabzhRrgrpxaB?=
 =?iso-8859-1?Q?9usrxQYXACuULYo5tuI0+ft8a9Htv9bdpFFqu5aNtueWykzZv2Vo+AdQ2G?=
 =?iso-8859-1?Q?qoz+yhSzm9O6xrsIH6JTL1QjbkFxt3XdzChnols30cg0nsxJJB7SLYU9sq?=
 =?iso-8859-1?Q?/99mWiHPwAZEacdIN3W9HgM09wIBkLUtdk1iWJvf0trcRH7oImcdt+Ojz9?=
 =?iso-8859-1?Q?dv4dg3F6Rilmu07Ls6IwtaqgLBWAT9hUXt0qJq4Wj0lrcnsdiZqc4nRddq?=
 =?iso-8859-1?Q?jSnsyWl9futXCgyDO58+ib2Jr31tterj7R3OEhZIJFSfSGeKQK4N4ICKWN?=
 =?iso-8859-1?Q?2N1GzfrumkKXnvrPmt/QI+fRf4GvAul5bSTpDHhymYjbf5iJo4ZaJSCaJn?=
 =?iso-8859-1?Q?mDKjTx763Dpe4p2/GzJJj+FbcMJQzth8Fbl9H9ZLcROdG9GZICkW9asU1i?=
 =?iso-8859-1?Q?doYB2y9rqLEqJdvjX5cgYufr6hO2QgsTryi3JYLroz3hkdKF4zbD9/9EIU?=
 =?iso-8859-1?Q?ZQQS7tcLKeIh6SDjUsGBObeth1RChBb/OSVFO1O+UQPQcMyoj9YbfFFLN0?=
 =?iso-8859-1?Q?nyhZ3b60nEWUGM5KtaG4gKEz/lATpYhGykVcSuOZvse7WHwo6z+Bu4VdnT?=
 =?iso-8859-1?Q?7plV41PEc0wRrAjbNLzGXbaxQKY5Xm2tXYroU1WxCgSURXq30LtfLiqJwp?=
 =?iso-8859-1?Q?YJvbl76Z54amaLFJWRylpCpLmZBwAT6F4AXdxcvC7lccJXt61DNpSKRDjw?=
 =?iso-8859-1?Q?dD8Hrz1ejPpcwWsghsG4qEJA55KEhS5lvM2CYtEyQpPiH/ekCY+Z61Xs5N?=
 =?iso-8859-1?Q?xcHcG3qphRSBDD68omGRM/5RBI4lc++h8V5A1+1liMC6so4xu/3/LJrsyX?=
 =?iso-8859-1?Q?28DQpbq/o9Jmk1rkmtfLZ88oVULV8l46jEmGvbsQhfdYvOTTPIvT9IRHu4?=
 =?iso-8859-1?Q?XlRAeCt1372bUm40kQLIYPSNuglheCgK+z5QOy+BPeIV4UB7blXVnitvLn?=
 =?iso-8859-1?Q?CnQsmSu8IYZFoHQe9myF/wD3Sf/++apEw1/wjIUTfFnDwZo=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: distech-controls.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4269.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d37301a-954e-4f77-18b3-08d90335e1ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 13:20:20.0860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: caadbe96-024e-4f67-82ec-fb28ff53d16d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wYXXNcdXvRbqTbMq+AubMoRsMMhs+UUHcGiac6+aZkrnWkYF499cpRz9qXLaE2jjyE2XcpZOPgMMmuHm8fb0ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR0102MB3326
X-Proofpoint-GUID: -TqpioCZgZOuKz0zb_GjJKLI33EXgNce
X-Proofpoint-ORIG-GUID: -TqpioCZgZOuKz0zb_GjJKLI33EXgNce
X-Proofpoint-Processed: True
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 adultscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 mlxlogscore=889 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190091
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Please provide the following dump:=0A=
> =A0 #btrfs ins dump-tree -b 18446744073709551610 /dev/loop0p3=0A=
>=0A=
> I'm wondering why write-time tree-check didn't catch it.=0A=
>=0A=
> Thanks,=0A=
> Qu=0A=
=0A=
I get:=0A=
=0A=
root@debug:~# btrfs ins dump-tree -b 18446744073709551610 /dev/loop0p3=0A=
btrfs-progs v5.7 =0A=
ERROR: tree block bytenr 18446744073709551610 is not aligned to sectorsize =
4096=0A=
=0A=
We have an unusual partition table due to an hardware (cpu) requirement.=0A=
This might be the source of this error?=0A=
=0A=
Disk /dev/loop0: 40763392 sectors, 19.4 GiB=0A=
Sector size (logical/physical): 512/512 bytes=0A=
Disk identifier (GUID): A18E4543-634A-4E8C-B55D-DA1E217C4D98=0A=
Partition table holds up to 24 entries=0A=
Main partition table begins at sector 2 and ends at sector 7=0A=
First usable sector is 8, last usable sector is 40763384=0A=
Partitions will be aligned on 8-sector boundaries=0A=
Total free space is 0 sectors (0 bytes)=0A=
=0A=
Number  Start (sector)    End (sector)  Size       Code  Name=0A=
   1               8           32775   16.0 MiB    8300  =0A=
   2           32776          237575   100.0 MiB   8300  =0A=
   3          237576        40763384   19.3 GiB    8300  =0A=
=0A=
=0A=
=0A=
=0A=
