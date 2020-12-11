Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0972D705E
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Dec 2020 07:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436525AbgLKGwF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Dec 2020 01:52:05 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10618 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395564AbgLKGvb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Dec 2020 01:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607669490; x=1639205490;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G1wShjZVH2MluraN7pxOborcEVP2rXXcagVbHPa9IKM=;
  b=pfnZRElyzGRY0iHtSDhle0CU62gvDHKM3WR64hGxxU0xx//lQ+J15mNy
   0nB2bPUDs9wNRX0RJmO1kiJFAk9kIDYINjpgX8RGpq3LxQMDJkFgHxD3E
   bBFK2vjYCcoJnazfCwIBWKslkOtJrSdKX6aSWrSykX5bnxWYAEYZscjka
   wFW+K1tFVWyX3THqo4BMpcuRJ+8770O+xFBtycmrW7rdHgisGQ7q5jwZx
   ji141xFT5v3dfAUz71Lp8ah6Yoaz0Qc61enI6kAxg+x0QeHI6ynPiz4yA
   sue56GP79Vf8sz2II/RSSKwV3E9NO4eMSdHT/a7j/9i0dTPEaL2gDwRfI
   w==;
IronPort-SDR: 0W3UCloJz9WzJ66Ci2cD7CW+MLdLJxs7QQreMpZZeWPoNKGNzmhmyGv7xORF/ZRKWnuaRiG6G/
 PgbW+mAH6COLhhI+nSy+x3RGxcQbD57QB2qkNvPVrc09L6LJ0uIxM8juSBTtEVdsLxh2AvbzrX
 zZ9speJ15MjCA+eO8zlo2rUq3nc9O8mM/VdehNmXnyvhNb+/KUKEHiI5qmITOGeH01ND7YttPU
 yjETbUKA9FVKt7r001z0DDpVJ/jzjrRCck0dWxI+fa18ELaJgm48TBgL8C3ytke1RKxGJvERsG
 anA=
X-IronPort-AV: E=Sophos;i="5.78,410,1599494400"; 
   d="scan'208";a="265086997"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2020 14:50:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMEhkK6AU0BNTSXW779gf1eK7tUe4ezXT5hs8FyPOJ5C9dsTo4iRH1v2tPh7n4gMbkkUcnqu1gsbinupp5zLGEAyjFung4Xk8KyQ8TzdkLGE4xFKMs9XecKFblI1p7DXnH7snmnJSaYJXa4Cakj88m4Zy8xxIJuz001b96VAq/y6y0SeaVcb19G8rkw2Ak9uwEkhWpp1otLYk3VlBqlApbsl+RcFlksUXRq38A4nTapS0o+BNjRmwaihdEI9YnG0aMh9JmIaKDKEsDYwwVwZc79SZs1056LcCJMTuFm+/kNv2Bf34hYddSf4JWMr4b5zXP138FrMJasUyOhOIeozhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1wShjZVH2MluraN7pxOborcEVP2rXXcagVbHPa9IKM=;
 b=fPDsfTMfEHw+YkUSTWeCgH3ZJcsGxGJGmjSGxEgt4H+iT+UEtaL7QrhhE9sNOiHqEL7uz6C984eKtTx8WykcCnkSngq/LjVTT+E+S9vqbs6GaGOGOF+69Pf1GIhkNtHgBmfmtGZt/zBkI/7CSahNu02w7mZqAnHA6H4+9Dyqu2djAH/6RoJjCE6uUnKVk2PE5EO+iURXfIsP/AiFh14rZyVxN3z3l2lgnTxe9R29ajHBru2rjvT/afvDdQtrDHqbto4/Bq3YdJI0y59pBWThIlBO/p6L6strX7jDZofvbiCjN0hOz/Ip2ueZp2O9JBQj0ramkVZben8buprprxMrKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1wShjZVH2MluraN7pxOborcEVP2rXXcagVbHPa9IKM=;
 b=dg99SceVuudOs1s/Jo/vQXneUfzsga8CVgoqOC31Vh3P1oyfqAC6+q2IXoqQyAXIPsO1B3NzzQrpNSwxR5Ph39biJdX88TtRL6OmFq4z1a7iTgF41l9s3HQ2XqGjmhJyPB9Xnfd1spqX590MmMZFI85VqxErnFU6MvpcL0+I3ow=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA0PR04MB7290.namprd04.prod.outlook.com
 (2603:10b6:806:e2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Fri, 11 Dec
 2020 06:50:23 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%6]) with mapi id 15.20.3589.038; Fri, 11 Dec 2020
 06:50:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Sidong Yang <realwakka@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: scrub: warn if scrub started on a device has
 mq-deadline
Thread-Topic: [PATCH] btrfs-progs: scrub: warn if scrub started on a device
 has mq-deadline
Thread-Index: AQHWyzejHW6Ri+MjBUuw45QEtiWblg==
Date:   Fri, 11 Dec 2020 06:50:23 +0000
Message-ID: <SN4PR0401MB359892AE5C0771A8209A4A559BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201205184929.22412-1-realwakka@gmail.com>
 <SN4PR0401MB35981F791C9508429506EDA09BCE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201210202020.GH6430@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a94b350e-f0a2-4746-b9be-08d89da108a5
x-ms-traffictypediagnostic: SA0PR04MB7290:
x-microsoft-antispam-prvs: <SA0PR04MB7290707CD22FAC2D0E5497059BCA0@SA0PR04MB7290.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X9hV4Rh66ivgvtrmJLGTnRYOM0TjBA947EHEaqsfxessVzVcvZVfkNmrdD+5/ZEpOQfjVXUuGAWBk/yXhV8FKyN0vrM7PF1lrjbiW8ByNLBMATaIJjptg5gx1IE2EgieEdWJr3DPxvrstBIW5rCHvcPJtf2E9esiD2ZD7y2qDDaLudFd6vCUEF1m+47uFY2w/3VioiBzl+p3P+h5B5ZushunMnMVbUHUb4HavEwWlFEZCDeKXnzIwQ6nKH+XAt7ML25eXlIG/8r+8h8zr+oOekg9pfaRe1/5Txt1KE7wEV+Qfb27l8A04nofG4pjXrlO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(2906002)(55016002)(9686003)(4326008)(66556008)(86362001)(53546011)(71200400001)(5660300002)(83380400001)(52536014)(26005)(64756008)(91956017)(54906003)(6916009)(76116006)(6506007)(186003)(66946007)(7696005)(8936002)(66446008)(33656002)(508600001)(66476007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GQIjYvb6wKbncyIInQgkIjCItxxDoQ9qsJHym3Bo+dOx3zKU1l1QkVgbz5Jn?=
 =?us-ascii?Q?xrE/qg43AK8Oyl/UhLIFv21j4Bd3wGQcQQJF8JfRFcDhjWbPpOTXozFwZzo4?=
 =?us-ascii?Q?sm1/arlGETbLpzDLXcCxQdOhN+CSBoBoCLNrDP4sR1urY8fRMesmN7fZfxMU?=
 =?us-ascii?Q?FTfpWNRtHhLu+3avg+CqVtNrRcOZBEYhDU236DTNKqBL4UDCxXVHXy3fmOZv?=
 =?us-ascii?Q?eUzsuGHNIahbQQwHcj6xh0G9xdH8GnEAEyecCxH10RRIVBhLADrcMwKSUDJL?=
 =?us-ascii?Q?56/LaYMDbo2s3I9mozINxPMp6nOzA/kPYGV4IBpSvkmtt91FGKV6yE7zb0vH?=
 =?us-ascii?Q?FR/ZIovyqxVz2C+2xVU8OVXeUUPZKvVYEujEx8L+VG3VWsHWGjSU+UHk/oLA?=
 =?us-ascii?Q?OxajtTLvr2nzFhY7Ta04BHXdsLldUAibA5syYmTHxj/ingadDNmAH+i7Mtc+?=
 =?us-ascii?Q?eFhMbbfTtWutRGHVkEWMjoaEu91Jb1yOwz1B0nxeXfwJ2qGpSfTKq/NkIQmk?=
 =?us-ascii?Q?dnMgGh2js20Xp/9p9q3JUElTc2TyJh7pfWYTfJdgIpc/M85VZeS9uGSTHhYZ?=
 =?us-ascii?Q?4MEyDSQXTnXwlW48Z0E6DVzGWHCm7YMjEx0JVkSsJHalUXXFoynl9DOX3AFj?=
 =?us-ascii?Q?e+gW2jJB2CgJjKzjmulyRbyLE9ExEzyomQzjFJEHFhxm9KDiGEdIlTfRviY0?=
 =?us-ascii?Q?7SFKSl7AWqv4R/7c8QM07rdJ2iujluVucNlVUDrM0eMCoj0iz7IkJZ59IF/v?=
 =?us-ascii?Q?SXrMkrWw2FwVi7zh94O6YiVNhrmQtiGh5QG2cCiXLbnn/2G1gOHl28wnS82D?=
 =?us-ascii?Q?4j0l+8zoPXrz90NblUNELthgTu0zWczU4+AKoxizP2bJso2be4CImAbuhlTy?=
 =?us-ascii?Q?I3tqwHLUguzoe1f4d4rAaxB3V5opUA132iTKzkhWTUvKs7r0qgUyL3Wigpo/?=
 =?us-ascii?Q?GeqB/JpFnSYaH0Afv/2Nw2DXgZwAHsRUhMExVJ4LeljtkC/DFpnHsnDPb/Yu?=
 =?us-ascii?Q?T83L?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94b350e-f0a2-4746-b9be-08d89da108a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2020 06:50:23.2379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yGDEg5Iccye9qnD1GOg5rnmgPOBUcYbSuEa13TN1aIHKH1ZIcZF0e6LtUsxzOFOqHntytU1DjA9O53yt8n4kbIELuO5oR59cn4rEqrTmTYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7290
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/12/2020 21:22, David Sterba wrote:=0A=
> On Mon, Dec 07, 2020 at 07:23:03AM +0000, Johannes Thumshirn wrote:=0A=
>> On 05/12/2020 19:51, Sidong Yang wrote:=0A=
>>> Warn if scurb stared on a device that has mq-deadline as io-scheduler=
=0A=
>>> and point documentation. mq-deadline doesn't work with ionice value and=
=0A=
>>> it results performance loss. This warning helps users figure out the=0A=
>>> situation. This patch implements the function that gets io-scheduler=0A=
>>> from sysfs and check when scrub stars with the function.=0A=
>>=0A=
>> From a quick grep it seems to me that only bfq is supporting ioprio sett=
ings.=0A=
> =0A=
> Yeah it's only BFQ.=0A=
> =0A=
>> Also there's some features like write ordering guarantees that currently=
 =0A=
>> only mq-deadline provides.=0A=
>>=0A=
>> This warning will trigger a lot once the zoned patchset for btrfs is mer=
ged,=0A=
>> as for example SMR drives need this ordering guarantees and therefore se=
lect=0A=
>> mq-deadline (via the ELEVATOR_F_ZBD_SEQ_WRITE elevator feature).=0A=
> =0A=
> This won't affect the default case and for zoned fs we can't simply use=
=0A=
> BFQ and thus the ionice interface. Which should be IMHO acceptable.=0A=
> =0A=
=0A=
But then the patch must check if bfq is set and otherwise warn. My only fea=
r=0A=
is though, people will blindly select bfq then and get all kinds of =0A=
penalties/problems. And it's not only mq-deadline and bfq here, there are a=
lso=0A=
kyber and none. On a decent nvme I'd like to have none instead of bfq, othe=
rwise=0A=
performance goes down the drain. If my workload is sensitive to buffer bloa=
t, I'd=0A=
use kyber not bfq.=0A=
=0A=
So IMHO this patch just makes things worse. But who am I to judge.=0A=
