Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B06B318C10
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 14:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhBKNam (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Feb 2021 08:30:42 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:31020 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbhBKN2c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Feb 2021 08:28:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613050109; x=1644586109;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=fMtLxOt4Fap8jPTdl4WNrEmaEb0bgBJaokspbWjIXmkyPPoLUdwZu3p5
   pXZhfd81ByOIVYkHmhOCByi3StWedktUCNPY2rEajzLroXHI0uuygP5LB
   OM7tAxB6UQGZ/dhqdgFc8IIU9SV+P9zFWUO1mhPtNZ7EiBceSdxWJ3KPC
   jpbXvHz5+/7MySUJMzi/T+pnXdYtUofXESKqyWtln/FBvScWhhNxGHRiy
   Jx87Hnt0Zd8CxmhnAliT/7t7dNLhnX/CFD0u1MjjBHJrqr/9og2hMAL2C
   VoZ5igCHNBuiiOYUXG5cYWq2nGf/ESxj3ZTj1BYe5bclp+ziuwtFm7MjO
   w==;
IronPort-SDR: x9yY3MTocJnwhb3SBuKNzOV1hTka0uKyMiazLJK/012mjmsPDznovlgFMS5GixXaoGRIFya2s7
 rDXnDo8LPpew+8yaSN9GhWxUMOkjO0TbLu9KSWtIxYfP8NZzk/AR+0Gnn901VPSbFu0Dp7t3rU
 1gNh0iM38vP1EfAMDMzlZUHPl0ka+F6WFg1rDm/z1oWuej4YMQZL8LLqRy+mdCKCwM3wu3abX5
 SHRhfLyQuYXF6GhzKk2uh26R4LAWPe/QRwmK00HoYuQ1D4hiscYwpexqYJZc6yxw2XKgDelM8F
 +RI=
X-IronPort-AV: E=Sophos;i="5.81,170,1610380800"; 
   d="scan'208";a="160925195"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2021 21:27:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8s7NYuAXmV/Y0a2XSP6xpFSfZCLp+6SRjKpy+W+hHUn64UzdgHfxsbYimG9DAege/TfY87wWn1iR9flUe/IPd4AC+Kxm+F6j+9k0Aib7qKwQSllDpAjAPryaOLRzPmVpscyNfjJRep/id0+ZF88I0LX/BJKlSSr5b3q0tq/p+hJwaJCq/eKbOgiOPzvcHnHUZA+q4/9mkQrXm7ENyZeOWocKcgkV8B1ulJAyFuhS6YwMTskmveEES6R1syrfGH1GNSC+IXCzkc3TJ/Is4t29M2IDt3q3EpKDpOSWEP4O2oPL4uvX6bRF621oOTpk6a8vPMUlWriR3a4oRUvB/nLxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=gAQD7p892HzKnKKqoRyw0bFCsljGQwsUbCQmTaxsnNNZd+io3cZDmHk8F3LJ7woicXQJdi1/89Edv0OoojOo5TFpmfMMOvGzlE2ILOijUq4AjMVkeWoCGkPnw0IkKMt+gUm1k6vI2wOsY+O37cg9HcSH3w8W/K1PirwMwmTIBI/qg9Q+VCgTjk/A4GhOsTTH4FtYd4JSnXvsCs3EOO2DROCC9AefUlpHV/doP/c4sZe/PVmtNhkNSFGuTYnq8rWxUCYC3HgxXsLO4u1XzUxXnT9nZ40lcLTnl+89+1otPfRkFzuik7swyJAjtYMJ1HhKre7vNpyn87dDaMP9VO7SEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=piKSNo+HSRTrKuF0Zu78v0heTt/kyJQia+kQtyqUjJhkTDyMpFfoRagvWg0+fmEA+z5wk6teqWS/uOJ9O7OkHZBPp3sZEC5E06qJKiXQK7Kr7b8Hyc/QBLvlEnEeodNa3Xk0M92MOxxMzqeAaSFggCpNB0UVNaxXLTC7vcKBGc4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA0PR04MB7212.namprd04.prod.outlook.com
 (2603:10b6:806:ef::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Thu, 11 Feb
 2021 13:27:20 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3846.029; Thu, 11 Feb 2021
 13:27:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [PATCH 3/5] btrfs: scrub drop few function declarations
Thread-Topic: [PATCH 3/5] btrfs: scrub drop few function declarations
Thread-Index: AQHXADanroq+/xZYkU+puoYxKRzYeA==
Date:   Thu, 11 Feb 2021 13:27:19 +0000
Message-ID: <SN4PR0401MB35989985F7C0C7886281552D9B8C9@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1613019838.git.anand.jain@oracle.com>
 <0b82526e15e6d0cc33ec625f8eab3f42b8a76508.1613019838.git.anand.jain@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca028e14-bdf2-49b7-c4b1-08d8ce90c21b
x-ms-traffictypediagnostic: SA0PR04MB7212:
x-microsoft-antispam-prvs: <SA0PR04MB72122A122A3404A98182294B9B8C9@SA0PR04MB7212.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mOyWvnlOLivFmZw8e6XF2L7dN+yxWWepaGCftXANBvaDQFbXtiiaGfbipIpd7ZLr3ciJdFUUREaZwCuDFeb9yo2bS4psw+Ln8hE/twVeXlx+VyyRNqEtzWIC2CBXLKh2j2JIjKqbO9LnoS9yhLTGVl/XjtbR7kKNWHoUWb4UjmUbPl36ZRMe63KOUKh/kNbAXxtc729JCkNgIOXKfn88ufQL5AatAY5xGFN7bhElpFRi2Pt5S2ei9W1ibkNB6lFt2bMmyoYoqFYeiaqW9viodsWtYYYEI93rXUshX3Mo3tNKfSJCSnXFsGobPxw+gq+4n9dRnHs34xBzSTfy+ixR9EscZ8ATu39hNjcQezlseru5gX+uPZ3/2LoRegs4ZvdpuB4FsTDRm44CX5L0CSV6YeJ8bFFjGQs15KyI7ws63WlbabaF3XII9bUEc39BCWAsD9q8Qodbk2wLSVu85GAEKGspG8EZ+5rcVRz/jTvRNq0x4l87QyyIldl+gxaudU8ncZyafGKJrVmq8kI2X22W1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(186003)(9686003)(5660300002)(26005)(19618925003)(55016002)(2906002)(8676002)(52536014)(71200400001)(6506007)(8936002)(558084003)(316002)(478600001)(76116006)(33656002)(7696005)(86362001)(66476007)(66556008)(66946007)(91956017)(4270600006)(64756008)(66446008)(4326008)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tWMDYN3PmrzE1Hbd3IL1uB15HxZXwXxtEscUBFDmh+HWisBQ/kZqs7xksGUY?=
 =?us-ascii?Q?Rr9OXkJa/DpUsSe/J01iVACGTZwb5eVThcwzIkWf5HI7Rgy5IpHuInROJIrc?=
 =?us-ascii?Q?SQFnWx15RfGeK2Fecvory6GabbqH7u2WK0NnuB7I081S2nAyUakAWRWPJnb2?=
 =?us-ascii?Q?0+1TgAqTUnOw8SNc5YsPyhNPzd8FA80KggwGtVFmXH6cPocV+ha/r6OBE3ED?=
 =?us-ascii?Q?m5dl0yxGBE7EP2qtaPvR2UplyeTEQCy4wSTQ+DNf9XDzo5nGEVNqx4qs9KmK?=
 =?us-ascii?Q?UPWPVmpXv28ksKRMP1H/pVjIWDOm41QAeLHiZQsECJWmy4pUxo+vWSLIUVvq?=
 =?us-ascii?Q?XtimAJdALnonje/jAdlKGjC3+c/+4i90mwqYj+jUy2Jn+DzDL31WA7VIQJAw?=
 =?us-ascii?Q?CER7/QfVbYSQsropQOR5U5xbeqRbE8KXJdRT2NEz7r9t2MPx0OejcZ1TNFIX?=
 =?us-ascii?Q?WwBfb2TNbNWZYBPGbYSGS1ZHwzYJWbs2gGnKCR81Moh5Ae89oU5IBR39T+f5?=
 =?us-ascii?Q?XZwbnXcr3Z35GOJ0H90EIKHcqYPSLQQqGlM3VF1j7/hXPXCwCOX7uxh2z+j7?=
 =?us-ascii?Q?dQ9JChUACq5D7KnZkFIzPWGCe1lGBmYPMCH8krFvKY94MWNzKb/Xxz6TodU3?=
 =?us-ascii?Q?l7XMxDAWtQgsl1h3JlTDi/hbiScKHaDh2EGETVxR5tyET8+HCetOXTNvkpWY?=
 =?us-ascii?Q?l1222mNWo/oE0OmBPFRXxLxNw0pTvYv+8k4hVba+MltokzKhyxMR6sgLhHL/?=
 =?us-ascii?Q?8aiauYx/vg28jwUzp0NdrTQ5K85mIuO2K9s0WwaLznjZLN5me1PVPSCvzhZK?=
 =?us-ascii?Q?ds0ppLyAi/k02MyoBKCNhG6fpZcNjdcAnKZacv493g70fGYpUq9udnesRTK/?=
 =?us-ascii?Q?WOVC41fVImMSIGDqiuuT3X2IuoA47ziCWFaKLpQOVW87FZ9CJokz9/kB6sRj?=
 =?us-ascii?Q?qxSYSJrWzAYTrqBtGhwqpWOfGWvktbGFw8KOEPq1S+8T2Tijn7TdxgPCx5i5?=
 =?us-ascii?Q?zfqkKzyeRv8IZtIN4ODGakG+mlnZj7vE7HxyFI+26XrSGMGDcAJPLZwD2iza?=
 =?us-ascii?Q?8oEp5N02MopmUl9OnvPfugW0CcA3052FEyt/BIBVks/iv+nNjfS51o3cUuYd?=
 =?us-ascii?Q?u6VDzQ71E2AXhPX1wmCHE38x1xGWpGqAOKxEqIISxeSzMk1BktlZuYpzEvrf?=
 =?us-ascii?Q?SvWn4W4jPqntd1DUhYMqwE38QvYGYsrc2rfqnhUuRNPfyrjoxnp/X6+60RX7?=
 =?us-ascii?Q?BX+aHfb79P5syE51JFWBSKGUcd77gAXtCX9+GbRKaLfbyhOsVRAxkeQXtmlY?=
 =?us-ascii?Q?3D95E7a0QveYnSIS1p4mJIYWMnlg5Pgegh5NhH6fdcni1w=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca028e14-bdf2-49b7-c4b1-08d8ce90c21b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 13:27:19.9387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IeqVeiHN7cJ8dsXd3W5T62hrzRduBOam4nIgOP8Q7s7SKUouuIijVh/fct6fcMs5KueqeloCRc5JvA1NRHU3c0fecRgy0lIo8c0uZnm0zHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7212
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
