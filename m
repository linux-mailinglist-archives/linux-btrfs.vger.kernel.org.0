Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3992C43236B
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 17:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhJRP7z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 11:59:55 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26895 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbhJRP7w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 11:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634572660; x=1666108660;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GvEgL+iGYfzeSpEngm59/AjOWCYCCoe8kyByBjMXPQg=;
  b=mlfd7oHTn7KaZOYQbHIc0cw0sjIoDgp3dpGaR0V5e0aaT+vNrMGtVfbx
   EEDKoUeI3F5XGPtbe8/WMPmrrcKGXbUbVShjBkzScx8cGSOwgRRsm5jxb
   2ke7Uu5NYIFR2xtPulhlr1i6VDMPW+vLh6LWA49hcf1PPxJStYmxB1ISV
   BAaa7/DSvTU7+Igtl1EOcuh+gY47R+A8Bs0UKGIfbfav+f5U79RqB3mFT
   ge63uQMPSBy/QmCvcu6eVBdZY1MKBiLJYrQAoHxLJvkmGbdIV/YvoLSuk
   UhXRHccMT/fjrECwwDdxLEHQYbk/38atM2MoUWDZfEFpQPcakUo1SwHgS
   g==;
X-IronPort-AV: E=Sophos;i="5.85,382,1624291200"; 
   d="scan'208";a="183198216"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2021 23:57:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGjsAlKtxNhIncv9twLLG/29sGQc2S8M6XRWhPnGq9vzNAY5+7jiaLlNbntvnD1U7GAhshtlp2LdBdnXDXb265+puXOfvOl02ItG4sDAamGI3/dCVhBpXTUwYLaa1RdqcDSoAzr0Q1tWrbEypCdOSsd3bGTyV5AZ41CjitbzhkYRZXWd5+3okO+FwIHsp3/mZgKDAdZHNWNp/7IbU26k/RSTQXQiFPLXxQKlJuH3BYPw1DuFIh6hlHQjyoKppOIBV0LmM7TCLC5+yKSyBVDoVRAAJ2y2olrRKvnZ2CxKFSrG38tywI2Y6Yii11iPgObg0fJVjDXFBmYwlOQ+P+mduQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iYh4ST6Peag216DXnQQW5afK1wsSPQ5iLu3JHfsqL4=;
 b=h4zdxWdS32Jh7RjVXZNetRIvX4CLlj7Y9b238CeuRlu3GWy8tOE4X+Yac61zH6GvLF2idB0+LYZ8iFIeb8M/svF2VHFk0PFxxSQeh1cJONrOLbwRllPYSiX94WX1vHBglHsu6bXrEBfiwIifkvpJT4ZtuyNCMOfiTJ0tPfRxIEJMlBl+IAljOcerg4xTSL/iORp29hQa5lrLmlpiTYpGHorQiuOg+PeuWDd5YtAF4kadsIYrqHeA/6eeMN+OilGynbnrUOhL/GhmYs/rGHCqyofof6nYDTue73nVHTAQVJ5psU9Mp9pgJlbgr0xY3zMxwQeUnZnlQVatIgrc3pNnCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iYh4ST6Peag216DXnQQW5afK1wsSPQ5iLu3JHfsqL4=;
 b=loTcziJfxyjLLW5Eya8LPyr9NzlV8jljOxV/hloVFQVUPG9MhlhOQrr5HSoDUFr3MiEA+u1aNVmd3lA7H2ikVuLgXOu29wR/39BZ19Gc7HRgpUEW0hXsbh2fdp2K2vJRkOKJsdg627WOzTu2lJTNzL5h7ENekREBzvJFEGIb4rw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7608.namprd04.prod.outlook.com (2603:10b6:510:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 15:57:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::79d3:3357:9922:a195]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::79d3:3357:9922:a195%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 15:57:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v3] btrfs: zoned: btrfs: zoned: use greedy gc for auto
 reclaim
Thread-Topic: [PATCH v3] btrfs: zoned: btrfs: zoned: use greedy gc for auto
 reclaim
Thread-Index: AQHXwN9XEE3aBb2vGkG/7XnB1gVLHQ==
Date:   Mon, 18 Oct 2021 15:57:39 +0000
Message-ID: <PH0PR04MB7416BC020CEA9FBC7F535EE99BBC9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <667291b2902cad926bbff8d5e9124166796cba32.1634204285.git.johannes.thumshirn@wdc.com>
 <20211018154202.GM30611@twin.jikos.cz>
 <PH0PR04MB74162F3F81A0639E55807BC39BBC9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20211018155624.GN30611@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87ac5077-147b-497f-3fdd-08d99250034b
x-ms-traffictypediagnostic: PH0PR04MB7608:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB76083F3D1D7F0221B38439529BBC9@PH0PR04MB7608.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:480;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x9xPwVpuS9k1zOXrDQbHWhBFqfK92g3XeowRlB/ITkNF0oQJvR4oqb7bS5psl1vnwwj2jvo8AH//9aAB+C1sgSxjnX8vnHYDmEX2UK/lZUfqRlMWZD40NUL0SM2OqY2Qn1FRPXvgdE107UdkV2RvYbeu/jGzgAV0J8w3Ly74bj0+ZflZiF7NaF8HRuGmVvPbeHyFuphrroG0m0iYgDinPpdSrwaMYmHTO7nBwp7DWK+63wipUWmY+57ymhKwbnQDDTpOj8t8BOj9r3vWVMC44lEiym08+ZNJhv3ommZNXloVvOUMXC5PSFM2LdWjv5TaO9emBHB+QrqogZnXqcDlOiUnDjzYgE/ihHIVrV51nbVhATL6Q943xVt4xXG4dGPTSANvRFoiZAUiOzDNUv8hFtp/HW5nK6JeH7ZwgWibpA4/iesCNUBD/DYaCwT+pTHguH+DqqQrJQn9NvXDVBQhrUym7fcDjQwniKROJ6KSiTezoyo+yfSSUXD9ZSwdEZcTKAQPNcthMoalToEwjS/I4lUW7gcu0PzdSXDrzCBFUU2Tzae26YB6As5Xet1nTQKTz+QjP6eP52MDlXM+TosiMI6RegTetTYDkYqbl16Mi93rLr0w6q3EzYMN77yv5CjsmXa+1OFitaWipuHzIvRu1dZtj8+7+NxrNHHOvpYuefc/z+PSPziEknLJED2xKzIgNH/DvDigRjygVE3gJ90ciw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(76116006)(6506007)(91956017)(9686003)(122000001)(5660300002)(83380400001)(86362001)(54906003)(508600001)(8936002)(82960400001)(66946007)(7696005)(71200400001)(38070700005)(8676002)(66446008)(4326008)(316002)(38100700002)(64756008)(66556008)(2906002)(55016002)(66476007)(33656002)(52536014)(186003)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0NEn9ae0pxQAaIS8VjjrJvD8lD/pWk9RhkUndphaJnYpIhiPg3EMSKG8SgfX?=
 =?us-ascii?Q?OHvMy+3xn733ZxGgwLPQEI16GyoCZ8M1I0yeMN591BFoVRL6GeNqqhSvL6Zp?=
 =?us-ascii?Q?TxbNqu9c+NK3Kfh3Y6YvF32OfDtHdPBJGPiIgTZUwhpPDFwVfC30JC+k1NjJ?=
 =?us-ascii?Q?vwq6oRN6KNcC5j5gc58q0UxUVeaD3hdaLcryWe7BADRqletA/SLwix7fl3D0?=
 =?us-ascii?Q?cbyJIUFlWyrmgSiVfHhpmhxmaC5QB91aLS8mYhioNipAGpgUvLtf8uSyePaK?=
 =?us-ascii?Q?bYXTH0vGzs67JNuuiywjBWer1ulbXPYPXdq9moR1d05s4RMUUawvMHXX7PjF?=
 =?us-ascii?Q?MmbfbJABM+l3/VbTCfWzQGvHCZ9Kq66j+HKiEzjqQRb1984slvMLiyAh+D17?=
 =?us-ascii?Q?6bHjoIvJuIFbPm6ru0+WuxEfUGgYlAYszFiB766rK5yBDfso+Fw46fO6eBZ/?=
 =?us-ascii?Q?69/gQ+ayuh7FTdj7Sg1+2Aeh8yRY2y6Gmc1k380MSt9AcclAAJYKPQ+CVa9J?=
 =?us-ascii?Q?dWdwYdAjrNHT6a0T/RCVF/8960iMVVelXvXO0VbCYDEiTXFiz56zCYS9QaFu?=
 =?us-ascii?Q?TNsJ6esN7W89r0MQj2jLPrJTSs5m/92FsE9Y+RQSV/zNt45NpCoWxtU1pRFZ?=
 =?us-ascii?Q?Zsztf4GpNxbY8QghyIu/jXqZVITfyKRHWpSEG+OA7aX9tn7uTqbZfw7fSBQp?=
 =?us-ascii?Q?Carw6VxjDShqUbcHQk199L/2RhnBJboBgFpbjZKF1Nx6l8rkQ5zWY/jIRuIG?=
 =?us-ascii?Q?mfL+7WmPFH8/PlIE++eUEfahGbp51YdXxsUtpNxC6rP0ATQTGozoP2CYgXpE?=
 =?us-ascii?Q?azmQBOTZCeD/necRHF9sqrx7dy9aPGiEoFh7n6IoWTYuaLnCGxY1qJmgfrGm?=
 =?us-ascii?Q?tg/OEe4N5ii4MilvS8CQjSfGS0c3edSVRzj6SbAywLoFJaAyemvJQ9pu6mfd?=
 =?us-ascii?Q?MxTkt2wuJKbiDzrwL3WleTPKM+MJ0sw0KOO+OUmhVDLWB+mYlZKKA9cEGsXT?=
 =?us-ascii?Q?TENsOEQuCSaTXk590g4JsWvKCSEnMbl29vVGJs11PV02XjDTcZ1nhyz8DR/D?=
 =?us-ascii?Q?GoT0O2Csg4UBYvLnVhpj1j63jhm+FKxFRLLklFMGibfUltgixN1vimgifChE?=
 =?us-ascii?Q?hPFqkrkOZSD6XRqZi8GtwC1F0ws2dksXG3Hgw+2Weef7tMNFxFtQvTZIgkDy?=
 =?us-ascii?Q?suULjA3RXHsRKBwetXnGaUc/29OBUqGuqJT7H8zUtY0ie4CjzEf2UzQnsWld?=
 =?us-ascii?Q?qFDIBE3gRC8OGvCDRgGGCvYUx8eQoDQUqwKqK/S4GM3W1PSbJtdA0wta3CIc?=
 =?us-ascii?Q?57ZtmwlakQRtKuDoYteUrTjLG4+h+KZyN4mJxLrvvYHBb9n0UIlbqX3BHKZm?=
 =?us-ascii?Q?PznW3/PWmRRsUZ9coXybb7qaS4p/0OEz2lUWp78el+WuFCynhQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ac5077-147b-497f-3fdd-08d99250034b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2021 15:57:39.7827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RcwJRpj4JuHXZT2oI3Cxv3/EqM3ARe4J7drckAqDwiuGqF3zcyO8nqbP44xU0W86VRo//RBXnpY0M3/xeTIm1AWz//5XlhV6k3cKaDIItbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7608
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/10/2021 17:56, David Sterba wrote:=0A=
> On Mon, Oct 18, 2021 at 03:51:44PM +0000, Johannes Thumshirn wrote:=0A=
>> On 18/10/2021 17:42, David Sterba wrote:=0A=
>>> On Thu, Oct 14, 2021 at 06:39:02PM +0900, Johannes Thumshirn wrote:=0A=
>>>> +/*=0A=
>>>> + * We want block groups with a low number of used bytes to be in the =
beginning=0A=
>>>> + * of the list, so they will get reclaimed first.=0A=
>>>> + */=0A=
>>>> +static int reclaim_bgs_cmp(void *unused, const struct list_head *a,=
=0A=
>>>> +			   const struct list_head *b)=0A=
>>>> +{=0A=
>>>> +	const struct btrfs_block_group *bg1, *bg2;=0A=
>>>> +=0A=
>>>> +	bg1 =3D list_entry(a, struct btrfs_block_group, bg_list);=0A=
>>>> +	bg2 =3D list_entry(b, struct btrfs_block_group, bg_list);=0A=
>>>> +=0A=
>>>> +	return bg1->used - bg2->used;=0A=
>>>=0A=
>>> So you also reverted to v1 the compare condition, this should be < so=
=0A=
>>> it's the valid stable sort condition.=0A=
>>>=0A=
>>=0A=
>> Ah damn, want me to resend with fixed commit message, subject and compar=
e function?=0A=
> =0A=
> Not needed, simple fixes are ok. And I correct myself it should be ">"=0A=
> as was in v2.=0A=
> =0A=
=0A=
Thanks a lot.=0A=
