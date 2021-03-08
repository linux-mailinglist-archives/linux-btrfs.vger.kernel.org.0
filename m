Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4779833099C
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Mar 2021 09:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhCHImL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Mar 2021 03:42:11 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:9958 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbhCHIlv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Mar 2021 03:41:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615192911; x=1646728911;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=e0jH7zJWRZbGLTFF7+1pSe1qI2IbQmW9KF4VgDZ7Ouk=;
  b=e7jOH067Z4dIf87wzNzhHHUn30dNIlex00R9iXL/jAy/HjgNRiz3jUo6
   cmG7U2VxXPo3YWMRKVQc/vHL1M6oHRV3zu4R+R8CkhrcBV4bnZ00hI0Se
   MLrz1XyKzCDkPkh3fnsCAMw9Q4B4UsT9EdCTZcTN9Hlv4guBUpC8AGGB6
   2iVrtl1+amAt/38e8Fsm0/N2XIRZaKkomLSuCIYwr+jPCRWanUPESQIem
   hXwOrFcPjddYu+SQd/Qvo/fbLVdboUaFo4tJ/K582ar5isDrcjllyM8iI
   55cs46Vq3f0xidVQ4DpOJtysMxTxPu//Bj5BmrO+ks4z5BMdhpecUDubI
   Q==;
IronPort-SDR: HZEC14G29DT0je1I38wfLxoo8OZd0TJ+3AKd/+0wci5VbGKXevW4rqS7u5c6Uel7sgU3LbWtBM
 Rrou5qYo95yH11OmOCSk3YjXMsyQvH45wClrNKG7oBe+gctMc361axQnPU2mZf04JqEhCMFYKv
 FdHqrSKcZOycFnLvL45Bxl7LeIvbCL4iluRegKGp5My36b6z79F3zKG7dVftZQoE03G0iGaLQK
 oVPyayD4ue+KchuuMEQ/a5SrC+mIvYpS+/9r2GmWVCWrrEwKKi+nLkA1j+KeLdxDGvyMVxpSNu
 1jM=
X-IronPort-AV: E=Sophos;i="5.81,232,1610380800"; 
   d="scan'208";a="161613264"
Received: from mail-dm3nam07lp2047.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.47])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2021 16:41:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0Qbsy9MO34NqxXeMM/BmmRr+yibK9sJ/aBJShalt+7g3IqYJphS3YL1u9HTMauy/VK2KzuYTQhuFD1hBAOBD+rvhopHU8GFHCE68Rrzs/a5NKQP2VBH1fKBXDK+TpsADeo87wreDzZmrccC8ihTwE41PITrodAyoTzhdzYy0uE6BZ+1thWmEcP74wvXJMUCH296R7GVsAabhXsPtOT7aPdAE7u9fei8JUa9VdiS4712ooLnySh44aBrCRqDzTWOE+ZutbsUtyCSU3WZCSxIf/MGyKd4A+hosKMA5cl+w0NGySl81k6ycv18kqoU+vv3AAsmb6zgp7jdMftpxDpskA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQESWPn6CSUWApGI8xHgKQV7k70EC4pT9ygfan2tIgo=;
 b=iDDxMelmJwWHxyEdu/vq5xlfozmelLyQSwq6VtiekenpsMX3kvy+DcLERc+x1OTJ4C9DV9+eUI7/nZI4GsVQA6zMnycQDqT0iShPh2GenZ3gjKFFyqOEX6NK5azi2KvyejrerO79wAF4H0PKYP1EmIkoucaLFZIun+/XWHsrv4EVSvMI4+Tfq6b8jAUVt9CEedMGL7cau53T7AFy7cxh9HeY8K5HNWnkRZ+FdHOiyk12FT9/zyr9LsToFgybua3Buv+u64IcrcYQU5TUGMKKkffHGo3qd9PJ1FEhYG8KEqzYNogSiih4Thnuv7y9GCRM+7nIp7FcaxPRTzGa6GYJ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQESWPn6CSUWApGI8xHgKQV7k70EC4pT9ygfan2tIgo=;
 b=UGAwDROM9MaLZpKvlWeWH76OV3aPOvMqa7zvFhtWTer8QRqn6SGeP+khwLaLqDhvv2rddyfILtsBhyrR0+g+rwXJ5FdzIzb1ry4wL2qfGrDXHXoifwQ4DYXRe+0vNMRgz0oGzTeCFl/CCHV3pb3cILR/q3LhoHz3aaunZTTG46E=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7590.namprd04.prod.outlook.com (2603:10b6:510:52::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 8 Mar
 2021 08:41:50 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 08:41:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     chil L1n <devchill1n@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs error: write time tree block corruption detected
Thread-Topic: btrfs error: write time tree block corruption detected
Thread-Index: AQHXEmi+J/8EU8AdXUeeW92Hex1ZOg==
Date:   Mon, 8 Mar 2021 08:41:50 +0000
Message-ID: <PH0PR04MB74168E7E65BDF004A6C06BB39B939@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <CABBhR_6Y=H6Eujw51xkt6_fjAQFjdcp5trVgjtbrNf9iMDxZ0g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:48ad:6225:acc6:23f9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aa7ad67c-56f4-4672-28fe-08d8e20e0444
x-ms-traffictypediagnostic: PH0PR04MB7590:
x-microsoft-antispam-prvs: <PH0PR04MB759094464E7617E8572980B99B939@PH0PR04MB7590.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tKw5cvrMQ4hYbNhIoVWyGmWTzfBHJKjuthH6gm0WZ4YhKkwaI8Em3QkEOx8AOARQBHM1ZDOVROE3mXdhEoT4dZ0DVh5Nxw5E31YXs8K1+/89C/iY1ahG8NoUNqJOhTuyvrGdaPPjZYMOwsT3MUNo2H/dvgGzRjc6eIjPQOhiA43Ptax/8a1sf0zpQXLM5eK5i/M8ojXArljsxIkr5tha6jO3u/+SjFnVbvxdOGYlJoqt1+cKlM6dXbF5p0pEKnonsb/WHs/BZlC0ogL1pzk8fNj7VRfO//LoK+W5sDfPVGgLh0/NOuz+fi5FoSkp/RloEuIFmtuWO2Cl+YEX/fuu4jQYKo7GsXd5jfrUFO5rwb0867/n7sXlNSZfxFwhPLNy6eFBytJwHDpoyB9UF8osUU3U7j0S46Iw8Y6k1Rx02OkmquRvVgcGUxYff8KG1mNVCMIIVdaFohyG3+Edub74XWp0xk+CnifGZoc6dpfpE2lQ7WDfY8EgHMs7fiFYiS8bqYJ/9x2ub5wsvaoPm/sX/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(186003)(6506007)(53546011)(33656002)(55016002)(76116006)(83380400001)(5660300002)(66556008)(91956017)(64756008)(66476007)(110136005)(2906002)(66946007)(4744005)(478600001)(66446008)(7696005)(316002)(8936002)(86362001)(52536014)(8676002)(71200400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OGj5+/srS2Zi00LbT1IabEkTKeEGpxSwfbDCTyCa67DAfOzi/zdnv8eXlzbm?=
 =?us-ascii?Q?Nas29C64FDshbdF5SPxHQ8kC5LCMy3S+h2/sDoa2HQewsG6QI9oOWqfA35xg?=
 =?us-ascii?Q?OsHCOzCZV4SWo5PeZhSLcQODahQuq+DkodbeezQENAoKqN1LW0SVVUBTNpcH?=
 =?us-ascii?Q?BbVJK6oSkg8bewPuF7JoIAlBGxXlKjVoqmYGqw9D4InxdR6za30i2fmr2C5h?=
 =?us-ascii?Q?VuiLJt1TW2G+uQCIVsUUpMPXp/UOa3vsBDIRU8Y+X0Zb1kHoaX850f5qDoTu?=
 =?us-ascii?Q?zHS2DRgsm70F957PKnl61fXnltdSNSVzGaU45mR9qBiJ+5uKgfwFxWhRYuph?=
 =?us-ascii?Q?9yDSjC8Lw/o5bxmBEqX1PL4BnjBLcQtNZRTwZ+azwuXF7fb+W834qtpzsMfv?=
 =?us-ascii?Q?dMjO+CtexhyEVN7Tv4HcNv0mgOfOQuRkTZ2Dr5uBYPT7y5JfoJL8/1HG01yb?=
 =?us-ascii?Q?KNTGnUZ1gyEh6ydXh06evn+1NbPXDSdMQPkyD094aPl6QZlW1ZmnRGrpPi6d?=
 =?us-ascii?Q?6iYru7+SQSX6wPOuPLTyyoYMN6TD4cEY9uoXNCmpDoSn3dXhwzsGg8z3Jvgz?=
 =?us-ascii?Q?c4spwrTKvZS2BDVIYMEeHl0JFuT1VCjvJTPt4tGQFjdPWev9icySwfSf1jDM?=
 =?us-ascii?Q?0xDy0dCw+UVduPl08BbEZE72Ee6es1zS3eyDROa+ntCd7mUKLVQSlibYJSP2?=
 =?us-ascii?Q?5jbqkSU3DRLtra+JDbFPX9NFyDlcmrDBtWf5TwzwL9+oqiizkCtgM7B6L/3K?=
 =?us-ascii?Q?O2ZGrTwnihVoUh4c111u1x5uNWLnWgxiqY06is5Km0s8I4Li3L1+aXqlwnnt?=
 =?us-ascii?Q?LTRZ747ClP6xw6x7ANaDL5HX4Z1Rybw+e0P44A9NQdKHTVEhy20Rwi5fagfa?=
 =?us-ascii?Q?kwIKa70luqmBUIfYMGLyhEt1a0WuscnnMIeNUbI3BZf6Hd0m1ipowtOEVpJM?=
 =?us-ascii?Q?xNogplwFLOW2CHHu+e9xglJSpK9myFkAqP41TntKqAdV1NdpFK/azFLSqC/Q?=
 =?us-ascii?Q?c71JwPW61YGP8dhkadag2QVCQmhAjUjcawowYqNopDNUC+oSWVrhHZmWo/sZ?=
 =?us-ascii?Q?zM7zRa+1JQv2B6azO8trmLCZWwfRLj/a2jbA/RHLPSuMw/6s+jnaeXf3+UH2?=
 =?us-ascii?Q?e2HEIUl+7MJzHUh2pxlxAwqf3Yph/Y2MSmFPGqA4x37B8lzVALmFIBiE6nom?=
 =?us-ascii?Q?bj34sOSCDzsl19zUQqqAcAgY7PeOKHYHDouewNgV+P6oZ4XF5N6WahJTvLum?=
 =?us-ascii?Q?dNnFiJZCmppErFo/FoGepvdFj89cBH902zR4k/TpOd9LV67+aiTnCesHiWH2?=
 =?us-ascii?Q?tS3iFo9d2ggz1bHAU+TYHB+lmFlCBieLjYOCurzpiz0tnHwpGE1QSFUBDHpz?=
 =?us-ascii?Q?gZmIaZW19yD2dNC1OU24rMAlIWeu2vuhWKJvkGGDoD+I6Ygx+w=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7ad67c-56f4-4672-28fe-08d8e20e0444
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 08:41:50.0367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Il4orNwZleKnYMpWqLEFiNY9Y636QRM1KL6SmPMRDY78PplcU6r8leS3XuwMDqDAsW/JNXOetNiCKyQMGOLqR/XlswAtUv2RdiWYk2aB5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7590
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/03/2021 10:11, chil L1n wrote:=0A=
> [2555511.868642] BTRFS critical (device sda4): corrupt leaf: root=3D258=
=0A=
> block=3D250975895552 slot=3D78, bad key order, prev (256703 108 3276800)=
=0A=
> current (256703 108 1310720)=0A=
> [2555511.868650] BTRFS error (device sda4): block=3D250975895552 write=0A=
> time tree block corruption detected=0A=
=0A=
This /might/ be a memory bitflip:=0A=
=0A=
3276800 =3D 0b1100100000000000000000=0A=
1310720 =3D 0b101000000000000000000=0A=
=0A=
I guess the highest bit did flip so it should have been:=0A=
3407872 =3D 0b1101000000000000000000=0A=
 =0A=
(3407872 - 3276800) / 4096.0=0A=
32.0=0A=
=0A=
Can you run a memtest on the machine to check if the RAM is ok?=0A=
=0A=
Byte,=0A=
	Johannes=0A=
