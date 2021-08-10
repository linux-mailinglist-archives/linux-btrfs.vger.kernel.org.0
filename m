Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB4B3E5909
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 13:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbhHJLZu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 07:25:50 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:29220 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhHJLZt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 07:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628594727; x=1660130727;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=op6HabvekV8lNWaKModrfad5AqZzjZC/puO62xqY3/A=;
  b=dQF4qGw7fQGlejcE3MKrqgAAjN1UW/mN2Ac9z6hcsUk94Gc4W5Z7CAph
   EWryrTy+tWwENCh3Zsg0bC33ikVmihXmDSgiU+oAiiE8b7NFKSmOPpNDX
   G+8N+JiNnfKHRDNV4EZCb+7IiO2Rd3qYPiBONs0V1KxTsYnvYPlWChCBq
   J2haBfJI/h21MooRaRZceJmWigTzbhHMAi7uCPy/RB7tFTYdZeaRdjKXV
   f9NIljPXnN/jMLbTj8rcOD+HpuQtRmfH4Qp4hMid4zMfST1KxKLriAfSf
   FQjUI33fo7nOzKj8Zi1yw5hNoRhHfcwRS7NUwUi+cROa1T0A98820m4Pb
   w==;
X-IronPort-AV: E=Sophos;i="5.84,310,1620662400"; 
   d="scan'208";a="175995895"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2021 19:25:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYm8RwdaYg/Fekn7k1mVCzUQ7pFQ6xLO/APTJWtDvj1iH+0xwXMiHjTJqdE5Z8TvI8spwCLVUIikR2Yb2NhoHie70HN557noSINfRBE+RPpGxsWcdAX4BKHeBFxJwzQIyXvtBbtnSXlxiRzFYSipHY1XomkltyzPocp8NJIiv2bqXojxqHPxaoryxKfBvRQrHjYJW50vLfnPHA+ronLeKsPT1ejp1bHGYEvRgsrr/sFFYgWIqv1BnU8bblEyIe/s2IOkYMkYngl1Tj1YMEUbhJUMDgBrs9Kf4FLpzZhLpCbcs07BGwrt/svjxAvSHA8bq2sAIXwrJxmD9k5vlPYtAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXpFE8XW25wXF4liGHek20LgDOs992wA3FiXXChkAF0=;
 b=nXGX9chisvHFLjhwmb5U3deOcCqrRXdo5yGDl2OPKJP7A6qFM1O2ENYmvaU7oQJhZ86Vwei4sxtVzsZvN5j7qU1jo1e5JpQkzZWbCOhLQAx7k+8IDo+m0svx7eKMZOTK95mmU0TmFPrZ/Dhc0Gz62C61YfXH7NIz72jAY6d3rx/dogwB1nuL36RAuvdUKkE6ziDaYmTEXx5lwPpXqWvaLW+xvY992QbbDISJn0jj/pSqcGGxBNskCB3mp2gyOwBiZXKy/vQoMWa2FSbXLqj2f+eYloOHaGjKSm3ozkVJiUhL2XpP54cbamUlWuYFAh34Gqr04x9IqX5Nb3ghgelMmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXpFE8XW25wXF4liGHek20LgDOs992wA3FiXXChkAF0=;
 b=BIvonW8aEu81OVE12K38oNvx0evrNmm7mmyp7yLnBaFgoyhYLTMmoTuGxIU2C3Vq5FLzwn/TzWICtjs+/YgnuuXQlWxJ85a8eWFxVC4amweJeoWTIUmj8XxFSTnl0PQh65V1Ct93NDAAK+Z9SFFzjXghdNQO4wL/hNQeXAEAvRg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7735.namprd04.prod.outlook.com (2603:10b6:510:4c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Tue, 10 Aug
 2021 11:25:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351%5]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 11:25:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: zoned: suppress reclaim error message on EAGAIN
Thread-Topic: [PATCH] btrfs: zoned: suppress reclaim error message on EAGAIN
Thread-Index: AQHXjNgS/USBMjdAT06L07uGALANYg==
Date:   Tue, 10 Aug 2021 11:25:26 +0000
Message-ID: <PH0PR04MB74168F50C75DEE622FB9AFBC9BF79@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210809043230.3033804-1-naohiro.aota@wdc.com>
 <PH0PR04MB741663E3217E66761066219B9BF79@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a0e0790-8036-4d0d-49ce-08d95bf18d22
x-ms-traffictypediagnostic: PH0PR04MB7735:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB773584A4E7CEC76DFCE9DFF39BF79@PH0PR04MB7735.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oVVfeP+8V6VeVBdD4Ira27ZFE13iPL3OI6qZZNLc9uu2lQI0Vu964i+/SPF/Tu6Saj7Bbmeh8fa6w9f3tJmwj2RUPM/3rMI84ucBll6s2TUxTlU25l3P9drHv4q2R43AJf6R1UKu2nXbKfCpOs9jJlCX9fAqzwOzdXdBXIKL6TwqFRCGiqp78SdppQJCShioRn5htl+Sm/174SzKn6etUv4wKcITcvnLnBzv/fFzqy1YwxrcLYMq1+2DtkHdozvH69fwD2RiZ8OOS2OrUURAKT33ul/3AQSapPh0SYv6m9yvV9z2YlhBGJM+rGPPBJYKBKQcs6plNfv7v/Q8azy/JSlrmyC+QuFofBK/q61pyPJD/BvZEx0P8++hI2emUe7s65KdmdouyeTqTp8LdWQb+P1VMpWOrr2jXXClRGQlj0Zw6sCu127pTZ1J6MtmXQhoyaRATdyX5f8erQwEn9cM0dQJBS4yTNPlJOxTobbbZb19JFt77yebq1udH7aoSSc8+DYQ9Tf9IP911fa8RqyiZrP6/JbAhiRSYxUpV0oEFIoxitwG5/sNchJ1TU9ardPP7b/JEHeWfHCR2RuUxVeDYpVTDuzb9HWDdA1q3IIjexbJK57U6K7aHbEtiaFsJyXKxkDKnW4sVlXiNzBL1FrvFw0U+DFGZK2aagxK9KmNQmqul+cB6efdxXBUhZBTvBs77KPLm6tsOw38W6WcUYuOGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(478600001)(8936002)(110136005)(316002)(186003)(8676002)(53546011)(6506007)(38070700005)(33656002)(4744005)(4326008)(5660300002)(55016002)(76116006)(66446008)(64756008)(2906002)(66946007)(7696005)(66556008)(66476007)(83380400001)(38100700002)(122000001)(71200400001)(9686003)(86362001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uZZN0nEZT4/mqcEz93d9vJyCgVMCtPyf59XoJGzLH6tTZGXjulNDylEQzr3V?=
 =?us-ascii?Q?XvHC638UkGRXsD379WLxS1uIGTdICDlm8u7AnZm0rMJm+8Rjz6AtPnBjG4Ae?=
 =?us-ascii?Q?vV8K+mgMH8AQvqUijULBcuH471X3Af2fbX3kKAaX74piKWAvNedcqsYWMJX7?=
 =?us-ascii?Q?yXVP3K8DcCtiXaAqQhSwlZSs/c0oXldm2NEPh7t5MdGuiJQb4syoXs9CpKLc?=
 =?us-ascii?Q?ZaLZKAd4DFgbicMzb1kTkM8pbeWKIozq7nYSH9vO/t0fVejyFWmNIaaAWy0I?=
 =?us-ascii?Q?6N0DJGksQWdSLb9xpyZU49JFUsMfXcDgt4vSRZOVggK+1/8/IDwWFO4nPAkY?=
 =?us-ascii?Q?uyA7tMBBRG/ygoQwIwzuwhkTNtsMpqf8ODgQ7Zw696BndnN7RVX7K/RYAoKV?=
 =?us-ascii?Q?HBnic2QpzZqyYAsyLXX94UhEgqWIgU/ptfp/2iKfCvRDhAL0UjCpKRvFGX+E?=
 =?us-ascii?Q?opHwGZdxkJkr6xZImFCY0T966depx/AcHzkckoH7J02TU9QjmFpRqkrMKW6X?=
 =?us-ascii?Q?nVrMQMo/IHLhTjaassas1bff/RzONxS8wN13BInq8AJz6e/Gi4Kr1HQ2/7/j?=
 =?us-ascii?Q?1fauJ6ANRw63a2L7TAPiAP43kwooEG7lDzfAAcsaMjsaLFXBwHJMsfYYdAPz?=
 =?us-ascii?Q?4BPGZxq4t/GH5EljcxGyPnqRt4CXJATpMI7cMMVfolJINxOHbgDnPMcqARKW?=
 =?us-ascii?Q?P7jNdnUs7TR8DRMNdU4OW0/aseufF+j8O0ACNJWrT+Gj+IoF4ycCC7qydL8q?=
 =?us-ascii?Q?rj1ypdeh6be/QCm/+YxtPkLjcLVp4PlRFS5vBct5DFYxDHzEuZDXecpaxtTJ?=
 =?us-ascii?Q?6ZQiaUaHQKAwvGmlGkBSEt46D908ZDYw6S1q2MaNnTUDeGuVIMlekVH027c0?=
 =?us-ascii?Q?GQRL0x0yyYt48+QK7KatI300ZfntWmO0dT+OaqDTtc5ugA6JNasDF75kiUSC?=
 =?us-ascii?Q?o5SZMAKHIxVLPYTWX0uKxZDJvoYQyunJ6DtG7S3WwtRQCvigA0ml8NdLfYk2?=
 =?us-ascii?Q?sZTILGP++JSWP1QXp6HUga02fvFRhjLtERAZtzQkM61dUveWxHKtXYC+j5Id?=
 =?us-ascii?Q?4N57IUkGSWIPcJRFLLhyUVlvC+aUP6f8JCs9TGfkKU0IcYOiyvzs5QgGvCLD?=
 =?us-ascii?Q?EvjBlGhpHPHZr6hsLOZS4Gbgy8dNfhPscn6r5NRAURpKXA0y2/ycZFdOdjRw?=
 =?us-ascii?Q?MyLslj3Jy876j7EbPtWTFVv15Ko78OX+UlrdKjFGh3kTEnxWVzOiXcG7vsDE?=
 =?us-ascii?Q?vJPP1P6P061mHfwlNp7TgRL4wZSsIFnfqpTY4Ae3hq1GqA4b1FLGE7VycVWD?=
 =?us-ascii?Q?dz7FMLjLz0roKdtdNcbo2uJb25S3DH6fIRZO6B9DNxo1Hb8AfPFLQfl7EE69?=
 =?us-ascii?Q?TL4pJ7S3jd/VKJDD554QzLCYHO6ns3mtVPu0apczW7l4A1jMWQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0e0790-8036-4d0d-49ce-08d95bf18d22
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 11:25:26.1023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tsFk2m4NoGOgMn/JhMt9dkdcej94cXZCkdWReJ4fEZcVIUnZN2OTMST+YCvMRsnEcv/hs6i1BiuSemKUf7iC9ni7LCSGYcoNpOr4wcgkD9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7735
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/08/2021 12:32, Johannes Thumshirn wrote:=0A=
> For those following along at home:=0A=
> =0A=
> btrfs_reclaim_bgs_work()=0A=
> `-> btrfs_relocate_chunk()=0A=
>     `-> btrfs_relocate_block_group()=0A=
>         `-> reloc_chunk_start()=0A=
>             `-> if (fs_info->send_in_progress)=0A=
>                 `-> return -EAGAIN=0A=
> =0A=
> =0A=
> Looks good,=0A=
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> =0A=
=0A=
Totally forgot, this should probably also have:=0A=
Fixes: 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")=0A=
