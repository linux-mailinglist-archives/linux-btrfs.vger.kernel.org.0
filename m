Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF45F466C0F
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 23:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244150AbhLBWZh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 17:25:37 -0500
Received: from mail-mw2nam12on2123.outbound.protection.outlook.com ([40.107.244.123]:4448
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347569AbhLBWZg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Dec 2021 17:25:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8LBUCKJbx7PWXb9GziZ8gN9FZdSPA6lX17LtfTwiaAEwHqswbXLs8eu+tt+caYXMwylStg2AUv+Osdgpyyr9BmSyZS1xTMRjbD36iWiEc55LFG3PdpcOBFhuEoYPpzBvvm1vaMjTROgCeWQA5XdeO/bN6ATYd2rl/2Rsm9ZHuvhAv72+C37GsO+bu5qYc67bQ6l3ZmnWr7ZsNxzk45VxyynxEBsQroupJDL8o9FkR3Bk4JvsHVRjMVHH4pPR9J0ZLs4lt4VHqzfgrMzXMtwE3RzD/gGIyePj+UTHNrn0ajlV1GlDHv813/qbLhRQ3IGgZUwGgXGpZVH3raeH+JMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIGO6IgpBd/SPoifTPRzWiGIzaiUiKT4VxrABAxE8rg=;
 b=bpjeyTRyK9EszA9r3Q4zgtP+j4uv+NQufcXiT9m29N5tR8WUsXEradRPuKun7XFYDNqaZdLQ6k/igQ36kc21VYiseqWv5R2k7BLloonG2G7O8RIYd5lhGXAnBLhGMTYvikn1MLdL6wVJcFHHFkchX4mEtgjgMCIuIpx6En4DA8GLWFWmRekkevCgV1iqz9dBIMV76dxKRa2scnXmP7fc3mMAOxYt+Ml0yB7n6Ewj8e/brbeHbdCd1CzCoftpo+W0yOXBn/XgHvVspt6DTbJpJcip+Xkq2s1tCk1j28wVGNFyUtRgxIubGYmL5G72VN/36XMv8boj9jH5TYCPQP6aAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rollins.edu; dmarc=pass action=none header.from=rollins.edu;
 dkim=pass header.d=rollins.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rollins.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIGO6IgpBd/SPoifTPRzWiGIzaiUiKT4VxrABAxE8rg=;
 b=qJhT1gEPUh0ktZMZIc3RHOiA+F1AbM+glgL/A3nFlee98ralNsxvBlja3tIT6jthUMYYlq7fRzP9qdWhLVN3wv4JnMfjYTzFQPFDrJuO9hrG3E9TkSuU0gjHtcfhZrbqY0DiJiK8QGvm518XyEWz3ipJOqknclGO/YvoDBPt92Y=
Received: from DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:32::12) by
 DM8P220MB0392.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:24::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11; Thu, 2 Dec 2021 22:22:12 +0000
Received: from DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7488:5485:739b:c303]) by DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7488:5485:739b:c303%9]) with mapi id 15.20.4734.028; Thu, 2 Dec 2021
 22:22:12 +0000
From:   Charlie Lin <CLIN@Rollins.edu>
To:     "rm@romanrm.net" <rm@romanrm.net>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Unable to Mount Btrfs Partition used on Both Funtoo and Windows
Thread-Topic: Unable to Mount Btrfs Partition used on Both Funtoo and Windows
Thread-Index: AQHX58rv4e0MKMaQn02bJH/GVkYSxg==
Date:   Thu, 2 Dec 2021 22:22:12 +0000
Message-ID: <DM8P220MB03420EEE0DF343EA2D24732FC1699@DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 3a87e71e-1807-0c1c-c45f-b1d089b3b9ff
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Rollins.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c6e79d5-aa24-49b4-4187-08d9b5e2300c
x-ms-traffictypediagnostic: DM8P220MB0392:
x-microsoft-antispam-prvs: <DM8P220MB0392DE3E5E3ACA50959C80B4C1699@DM8P220MB0392.NAMP220.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 42pGMmM+C9SqEjqWFx9V/iDsojxp7r31OQLXQbD6JySEC2j/po/Q87iCdYYhFJz9ZVOUTGA4dUVV1A/jpbTfJQ1KShAQ1m+Mv7uhhhGH2QzGcnwGxS+7OyelyFRTWVNacjwQ/2qnhBXBRTb1QwkuaKzlVTpmPSZRiA9XhpSlRSIzy6OwJp3JELNh4dktNCc3Bw6/fpY1xubQ8j/AvmdyWlIVi2VxeEAvPWNQlVKKnnBVh+31l9YmSwUCdnmKF/lNNCemTbs5mnyBljpgeZgXarWM9l1OUhnuvm1fwWv5ycFVi8flsJ3NfFlMBbJVA8ay/S259JsqmC6NCW3bSh5AH3Il0PwCxgWRVERmHUqxUxVhqc4aPMJM2Devm4zhMruMno0j+nBrJebbq+TzFs+R94qm7FpOe3ZsO3/Wu2qNpfh57w7mPk7975jHuJnZ0BTSaRM72Emebv1Ry8L4qO0ypYvFt4jfRnRJ8y4EiTM5FajxIdtajXkAYulc3xSDEfkEpRGaVlwSXrlGyxDHO0XnkB0wAcGeCFF9zoJdj9x3AZY6tEnLn5xHkDhsEgSQdcdzCyQNgr+r5yEnJG5rsuX2oFOwsMul7aCuFewLdgvILxuZ1owdxA2PDI5g6Nn06fa0sf37T1U/ywllfIolbwdonKVhnN40eEsOjxWERdkTotqpbC6XXGlMsdzwJrsEUhUe+P9oHh3qF2jqGr/Szxa7lQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(66946007)(9686003)(71200400001)(91956017)(75432002)(2906002)(86362001)(786003)(52536014)(316002)(38070700005)(6916009)(33656002)(83380400001)(64756008)(8676002)(186003)(508600001)(38100700002)(26005)(55016003)(66446008)(66476007)(8936002)(4326008)(6506007)(122000001)(66556008)(4744005)(5660300002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yV+Xrj0A8FzM7lT01QDx/4NI6c4oqNmjUQ9Va8P3BNBQNmvLD0VkpZZHLH?=
 =?iso-8859-1?Q?Xkv0oSoeEACRjT9Xt7cZKyzwH/DwHyTKu10AxgGDKVptfpHaNTZxX8ACtJ?=
 =?iso-8859-1?Q?999fvx3sIZgZ1crZsFPeDLFrjmOvsY2nkJtXXUSeJl/2Ziq2JlVFB4RBl0?=
 =?iso-8859-1?Q?6CXVvowTSnnP6AZbrstAaxXDIYc6pqBPUfzXeesiRaZgvuLH0kqxbC1niR?=
 =?iso-8859-1?Q?gNCJbhZbfeyPgVs/EfucDozAAn+JRlmbCOaPvKhrKqVJ1VkgvnHBta5Yo5?=
 =?iso-8859-1?Q?mbcj7s3Rz+M/u7zK4fwEMT7l0D1O4BEBdipnsH9SqVmPfsQeZloB8PkZlj?=
 =?iso-8859-1?Q?oaiKTjavOyfbvKW5J5uanvKzfvDyl15qjBTEEnh4IMGjHDDCXDvQ0coZqF?=
 =?iso-8859-1?Q?XQA9kxZhkczP2RINmKh0LoKkAZyhuFRJke3rh9G49FCdpyez+UxJzR3Dyw?=
 =?iso-8859-1?Q?mj6qex1z4CsgpKDRBxZjKBEig/PN3ODZ4eHdH9Q+peDqcnQczlopDHFsYi?=
 =?iso-8859-1?Q?k3XQ72Jj+pndPs3QgdgmTJe5lx+p3k44kFhk4CbMlfYmL5HW7uGw2yxu0R?=
 =?iso-8859-1?Q?jMp1hPZ6Z6jI8ZL/2kOqlIDbuTFTUATMhS0LkIxDcyOw/pzdjAydexXxVY?=
 =?iso-8859-1?Q?LYn244+6UqdP7E/L7xsLY/hv7JPypvWelooErS4QqCVKlDiz8+4A0AaZvL?=
 =?iso-8859-1?Q?TfVWTX0m8PxB9xwFcGDi4B8JqHyDYTpcdISrRhmer8fT+mL/m4a7nWP3LR?=
 =?iso-8859-1?Q?2DE3tHvIfojuwUXH5bx/zbwCjDXlgpPBN1kuqGNS7kAzrzbNc8iaAXsMLA?=
 =?iso-8859-1?Q?AKwUkW9QGfCTlleHD9T6nwR0yqlgEZspKGXT1Xuykdwzy+qtLqeoCWpTuw?=
 =?iso-8859-1?Q?slcMGTam0/eVAWPTqph8hkz4sYSsTxV7pI3rLpZ6W01Bxlzt5+sjx/p+nr?=
 =?iso-8859-1?Q?pIVuRf/aM3nD/+L9YYiJT27RhjfQ/PgIUUfS7fIuZZmN7iUDl//7wI1eb8?=
 =?iso-8859-1?Q?gMjvzDprPZg+eaOVcOrF2FuBfKNssy2+QZw/BxQc79vXa9APxOaZZvvpDS?=
 =?iso-8859-1?Q?tCjZMd9pIQ1mRzYZXrOj8nnNuVU5aXcA4xe7F5wigF/H1QuwkUnjsF2hr6?=
 =?iso-8859-1?Q?ruw7uVuNF0EV7NDOazgfILy5TC6eNceZ/Z8ClHJV4/wT0kQMVQsFI6DDwH?=
 =?iso-8859-1?Q?l+1CGDwJk4aMwDpH4q35ErU87cbry4Em/D8NFf6njn4wTloVNxyHpeQHAA?=
 =?iso-8859-1?Q?DXbls2Jh6eaK4MMxyu0uUA1do30nPr/6qjbdHMMiInBAEXbbPc0iJIzUgi?=
 =?iso-8859-1?Q?r4/hCYR8e2RRKuFACegM9fbcqJH7l+VtF1TNfaAYNylVR6uBqNqF3Mc3f7?=
 =?iso-8859-1?Q?CxgaT86O1AH/pfklIVb5WLKhQHMJc0tAnoZgxLWBZqDnKtdnds/TfRE1R2?=
 =?iso-8859-1?Q?I1L6DD66mp2AZkUQXXAnqVEOwJrtVINWWQZRlccAsw8Nkl6KssQg5AtGnJ?=
 =?iso-8859-1?Q?s3vT9kZfPFsT8BCo2m3X1TXxfu+4EqRdS1eqBhlR7JjVIOegIaOp5em9Sw?=
 =?iso-8859-1?Q?Y9dtuUUYbmTGtCLwDnX4Uf6zwZ3Rn+0Cycbbp228m7hrOeDg6bH8p6P3Wj?=
 =?iso-8859-1?Q?hsiW0yp2Fvkw22FRuiHbEv2JlcYJH2ovZ0MPUOjhHnPMLWGy08jW+gsg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: rollins.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6e79d5-aa24-49b4-4187-08d9b5e2300c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 22:22:12.1826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b8e8d71a-947d-41dd-81dd-8401dcc51007
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xJpPUPsIYA8y0+UlZkZF/jXXGzt9+nNbR262slIiEtln6fASyW6X/GabZRPJhX2EJH4Z97IQmdGxEGKB4leIeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8P220MB0392
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm actually dual-booting both systems on my laptop ie (Funtoo's kernel and=
 initramfs are on the same EFI system partition that Windows uses)=0A=
=0A=
Admittedly, I configured Windows to mount those Btrfs partitions at startup=
, and for both OSes to be able to hibernate, so that I can access the affec=
ted partition by hibernating one OS then resuming on the other. This worked=
 well for about three weeks.=0A=
=0A=
Anyway, are there commands to try to recover /dev/nvme0n1p{6,8}?=
