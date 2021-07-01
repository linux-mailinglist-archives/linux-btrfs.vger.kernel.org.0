Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D44B3B9085
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jul 2021 12:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbhGAKdF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 06:33:05 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29113 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbhGAKdF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jul 2021 06:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625135435; x=1656671435;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=aKYlNEtdIp3RUP9p0jSN4AUI50JZE+Kz5bl17StRCx0=;
  b=kUmFJZcgtmXCQfv6mRAtpHLzThCzMchy24UeoPTu9KfJzo7xAdPCn1ml
   IfxQMs0g8sb+ENbIxuO1GbymGCbh8Toh/iF1qlo7U2IxjHbAvRYSfuZGS
   UrKvhHF8B03NfbJdBp9t+g4HLT85u5OclW0sRe/hxuG6JIZwejacizzYi
   QuBSnx7q3jjrOsAImUuDUt0YewvAcBwi5DZu95aF8n9vDSOlDgS4iBvSW
   ZwEIKE50fixPREfZzfxtVYEguE4Ge6V9p5GE7KVi9W1aujH4y+ijWPZx9
   2QYtePVsgzeB5T8wOatheSEtn/NhpdBY6X1osZBb8m/tvBrCxpWgR47wB
   A==;
IronPort-SDR: RpMvbWe2WM02Cmu8Iyd1g/CWZyMR4rPwlnLQXCl7MS067sMOLiiS17xwOCV91DKDuuLZqR+u2l
 u8uVM0mPpQmjL3h8750AGhd1wjr+i9uSQYBpcun+v8b9MQ/7LGLr9v3j1a1GCaWXwdJQjHVHAB
 Bx64q1UN0FbKIT8MYfXUEO1topGYvkXVeaUgbC6HDTIwTrqHd6neYCFfVi8GUY/EhQb6Ohf5U4
 aEFo6vo92ac3R2NAJUb/fHB05w2nFQrTHyq6OXXv0PxtpkY6AfRyTVUy/JuLxHkknKAlNSe1h8
 nXk=
X-IronPort-AV: E=Sophos;i="5.83,313,1616428800"; 
   d="scan'208";a="284931924"
Received: from mail-dm6nam08lp2047.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.47])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2021 18:30:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9KhvUmOmbeS9QA6TML0ku3G6CEDe0Hll+OzNBxemG38djrv1BTFPiC2IBUyXrHZKYX8j/DTdOn3LjOibYcvweV/UEi9/5nDtH9fB14+AaqjNWlOMedFzvRqMIsMC7VSot2r47W2kBvruJw2sZXPkbAACzL+DcsmAOXlGSpvsGARQhV/Zq32tfJ9appUE/bjs6KAyO5H2JHVdNY3c9HH51x3mThUnmehK7YS33arBUiElDrLfuZHPPXryQxfjJ8vP4F77CSwodm6m5QBCv35RpAGPh5WErNyLxFlEla3Q/xesuwUwholtNCjHFbQqhaGEJQlzzwAhI2gdMrg2PT4Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogp+c4C2hxHDFdFwZzncgn3SVbUIl2pajig9b1KbKdQ=;
 b=XHVM9CylE07q0HLT0TzlmFStpD69LbzatLUG8OVh7Q2nkTfnN5hRIWhODKZweyM0uYHdvIjyeK37+i8eSa6XVmaTsNlb/entVKewjXg6QWjjLs2Q5WWt05YPlCZQwLo+FvUSKFsMnEJBIX3HctLQ3fhL7V80OaOvjEFVc5DRTBWx9Pkk/ptWtTmsP2YCvJgEtyIqN4UuS45XGtx98qMDrlijX81pD3WrRVEEgo9k4UaoRuHg2C7UVoncY8iehOkamB8lMStcrvtVf2tWcurrjBpMfZnLOcYCY5Cg9rNXCKKCLSU4OBc3bdQJlwYQo/ppr26ge+D012TrNEp7XUg/Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogp+c4C2hxHDFdFwZzncgn3SVbUIl2pajig9b1KbKdQ=;
 b=qR1MKrbAxWNFiaEuBX03kH34BZQaLVkThpHKL3Pe0ZbdS1Zun6P07QJA+55kO+0GoBUrG+BL88nbxgQZbvuYAqkQWleJyCCezldEavCgvab86i+KBFarYk8U7R7oF9qwC82f6aMwewZxWlmeTUMpzwPJljxRvp9sePNoSBmytbY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7557.namprd04.prod.outlook.com (2603:10b6:510:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Thu, 1 Jul
 2021 10:30:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de%4]) with mapi id 15.20.4264.026; Thu, 1 Jul 2021
 10:30:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v2] btrfs: zoned: remove fs_info->max_zone_append_size
Thread-Topic: [PATCH v2] btrfs: zoned: remove fs_info->max_zone_append_size
Thread-Index: AQHXbEyTtFQvRlqoQEGKBoNt5m0IBA==
Date:   Thu, 1 Jul 2021 10:30:33 +0000
Message-ID: <PH0PR04MB7416FADC6B5DF7D84278A38F9B009@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <a7f717432896b5f12847435727838b32bd6e2b35.1624905177.git.johannes.thumshirn@wdc.com>
 <20210630184851.GR2610@twin.jikos.cz>
 <PH0PR04MB7416EADB226778E4CA09C8309B009@PH0PR04MB7416.namprd04.prod.outlook.com>
 <DM6PR04MB7081B6FD97AD001BCF85BBD5E7009@DM6PR04MB7081.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2.247.255.248]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bebb374f-32ed-4c49-b90c-08d93c7b41fa
x-ms-traffictypediagnostic: PH0PR04MB7557:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7557BDA8706FA11622DE209C9B009@PH0PR04MB7557.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nSyUIcnLd47Mr+2esaixKjngd3fMXYYMXbObkblvO6F/xLx24Wjw/0Z5S9r0MhqYA/3QvZU4T91yFMChGFKtmZGiR2CDdPfCZZsPRmnOpEXkNv9JMd5YTsc/yWfq8WDIbbLPZEusir/jknIgQpUWgD1wQSKR2TKNvP+xIk7u/ERr7yXDzN8g6QwdCXBx8ny8N+/8GpMi7k4M9NqeELiO1W+zow9HudO0Bax1aw8+D0Pa+DZ1bW2btsg6Z3cskEc0u/6S1gEG849ZxbyT/KTfEC3btyInig1yBCsYS3ecIdJ9haOGpo8XKxpgvhK2o+xgO2vDVJb1onRGCbC+5xdsS/exyT/cDHKVDq3XsFQtHDcuuOlLbm4L8tEfBDx2ts2Fgcu25KCvWTFogoYoOsBZgUzUKoKdbK2/G9ziK0vkdKDRNGR/PJDCO0LUUYs64zXiH9+deOTvKaEaaKuCKVZBcOMEiwn3LmM85Ssiq/8fsws9hiVzyfMaw9MuBuGCuELTXE3wJOCDmuZyQCPbqdwPWKe0x+oTU2gjdu1XoKRCVfMI67djei/mq1zhbcIkSjpxqhoTBtlBeV5uGFfLM2ed6C3YzdQDpZZovBSBe2g8FxfA9mkd2cl4Bze2fj56uWbEZHJRamIErB/LU+4gt0a6fg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(316002)(26005)(71200400001)(54906003)(5660300002)(66446008)(478600001)(53546011)(110136005)(52536014)(186003)(66556008)(4326008)(6506007)(122000001)(66476007)(91956017)(2906002)(76116006)(64756008)(4744005)(7696005)(38100700002)(8676002)(86362001)(8936002)(83380400001)(33656002)(9686003)(55016002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GV8Y5hsEhepUe4MrUwj/YkTgYO2p6u4SrrKd21es/paIVEVa/dVwjJi562UQ?=
 =?us-ascii?Q?rHs+apIiSHSs4yu2nHeHGdUAl+vOmwO/JRy/eGPJoGVxxvbZqaF1OyHh7Er0?=
 =?us-ascii?Q?c89y6+w0clpnrMijenJmluYtDaTFp29eiW0ybLDCkLL2oMPZzUerx0sCIg3/?=
 =?us-ascii?Q?8rAxGfeDahqosj2dRKEOzBKRnOwtccL8vkc6OuD8keThE31Fn3SvBeSm8eHI?=
 =?us-ascii?Q?dSgPGu4rDoMFBw7GOXlUPrAypQaXohv1mVtI7HmojjG+6VRo2U7bfLCVvTcD?=
 =?us-ascii?Q?yjivnVrUzXsIJHImeVKdxmQHnb9wT+Syg8egCrwJkZZ+O8V9+JuAhM+BNyzB?=
 =?us-ascii?Q?gVtEJwo9k79PCv+mqwcYOz0ezi4NFvWArEWmVWMOxx04muaRUvA2cjelQ4J8?=
 =?us-ascii?Q?zNQjm+XzRiK2sdxouREl/clo5M9j8rSN0NlfjA8Ly8iyIyatPckWAhrH4qRu?=
 =?us-ascii?Q?l+62PJtd3KfMt7ceiRsx5EYremH5u0IEUdTBb16Gndri8A/oNh0yMsRlooGR?=
 =?us-ascii?Q?DdEQlOxFIiqSSu3JBRqLAP5mtnEAaO0/Ol1W5zitRDTWkya5ox/jsEu5P97i?=
 =?us-ascii?Q?8iI+rSV0iAalMsvuY4afzmKkYNY5eD3R15TY1G7ha+nKeAMLEkUQXcmW5NFA?=
 =?us-ascii?Q?VJOBpPRyHV0HHPBYfqVkZDTTHZzYE4Dxhxj4IobrvPxwQ8KUqHzVuGx2OgIY?=
 =?us-ascii?Q?ODm89J7ALFpJK3stkcUN24pzwJ7eZj38aWTC5bPzkSQwZ0KvM3Jbfujhlhvs?=
 =?us-ascii?Q?Hlkla6dpvHUyxNbqg6s+gQ7IYxOl2Z/xSEc+8yLgiblvCffri190o9hJGxFm?=
 =?us-ascii?Q?8SYlMw7o9e1C0Pt80Dem/NyogQXoQjfGv5AWgVEHfYGtI24NLCbbkBFcMuJJ?=
 =?us-ascii?Q?ISbh6/naM1X5TFwIm5/Z4sh+IenXncvRBM8z5dwJlmFo8mcKW1vjkhkn/jav?=
 =?us-ascii?Q?Z9QkqtiOxvRPTTPsri6yvPvy5inpV9nIQfPXwnpofKBB1hhFmMCZ+yKO8qen?=
 =?us-ascii?Q?PlL7RhM4f7fTj9SGIoJRe+kYsErgBtmISjW1bNZz/sg8o7He+aE4FdmviAjS?=
 =?us-ascii?Q?PcJKVge95KL8tvedYgAlyPp2p5lNMc6h9PsS+FUd+UawsypvSnVBcArjeP/9?=
 =?us-ascii?Q?r1lgZqT63mBKYIx2iJddcLbuBvw0QhQxU89+IF2tOzV58qdsd6G3v7NqXurg?=
 =?us-ascii?Q?OIuV+lLHvNv5Py+SxOwMvLQUMscqy9fa/YYZmUNXYSNNxPCKuyn0873+dOrV?=
 =?us-ascii?Q?z84iBz9mVzexEgPFBTmor2/pVC7xAcW5869GkhtD5aHaUmSX6BOWf54jJmKM?=
 =?us-ascii?Q?AJet4+RnA7qRDObbtyt7WDt/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bebb374f-32ed-4c49-b90c-08d93c7b41fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 10:30:33.3537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ayS8gku/psPQ1qKc+rLzfYlvXRaXwoBRFvVaajBcqeXhJWajNqGpfk/K/Tugx3ityx8dz2T7s1/VMmMLIqxGQBaMoG+ZLKXnR58VAgRIynk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7557
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/07/2021 12:06, Damien Le Moal wrote:=0A=
> On 2021/07/01 17:02, Johannes Thumshirn wrote:=0A=
>> On 30/06/2021 20:51, David Sterba wrote:=0A=
>>> On Tue, Jun 29, 2021 at 03:36:45AM +0900, Johannes Thumshirn wrote:=0A=
>>>> Remove fs_info->max_zone_append_size, it doesn't serve any purpose.=0A=
>>>>=0A=
>>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>>>=0A=
>>>> ---=0A=
>>>> Changes to v1:=0A=
>>>> - also remove the local max_zone_append_size variable in=0A=
>>>>   btrfs_check_zoned_mode() (Anand)=0A=
>>>=0A=
>>> And what about btrfs_zoned_device_info::max_zone_append_size, should it=
=0A=
>>> also be removed? In case you don't have plans with it I'll remove it, n=
o=0A=
>>> need to resend, it's just a few more lines but want to know if it's=0A=
>>> accidental or intentional.=0A=
>>>=0A=
>>=0A=
>> I /think/ this one can stay until we work on multi-device/RAID support.=
=0A=
> =0A=
> We are nowhere near close to this for now, so I am all for removing it.=
=0A=
=0A=
OK then let's get rid of it all. The block layer knows the limits when=0A=
we're constructing a bio.=0A=
