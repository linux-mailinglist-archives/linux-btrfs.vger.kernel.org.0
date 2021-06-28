Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFAF3B5B9A
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 11:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhF1JvI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 05:51:08 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55563 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbhF1JvI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 05:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624873721; x=1656409721;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=2hfjvIoVPnKX9iiZ5/mjdj9SayqPmsK4Ld+96uyaqpE=;
  b=oULtiM//PavoyNKPRoR8bfK6nQ0lUMR6zP9KmurmUn6MjcsdGpvqQFsJ
   itRxk+44ZzPjc0j3vL/2XSI1LXzfhRlKXBj+gkdtjPDAzZcEWxB7xdlTU
   BkOzHjk2+VCzpt9EETZxgDRDvC4JUt0bkVEGRpy5mxbCtQeIXoO+7D9c1
   PeOfL1OfA1KENaTHE7yTXmO1seH66GYVassGxevSK4opSOzBVL0aoAti2
   fGcNZxfNaSkBsdZQ9ee4pW3eQ07+uthHyQntpaULd+38Ns70bR89/cy3e
   Nr9NhJAQFv9xIF3H9f3Cd0UhLPqakjZGtLJ5J1EXn5n1Jh2D1ebCUpg+l
   A==;
IronPort-SDR: NwlFeX+2i+RuriNWzJUBkwkje+iGCBejvsfH+jlpqe4/kICC/9mvA6RbQ3CLCU6kTtGO5xjb/3
 oNIH2vFCSLKTA0gwUCt/HCL85QIehLt7qukh14tA41HJjCuH4ZDfRGj4T8tQQ5UzVvBCLj15vQ
 Gjc2oqRlQzo4n1npG2mFwZPRZTrcTJh6xvUbTFNhJDVxX/cxZOQsYrp1tf5P9Q6UwJ7z7XURgA
 bcDy4/mKzOp5MyjuzZF2lYdP+LOAJcoBOjXS54E64IRF2RGYCG4Nu1lL5Tx6GpqU+68C23xHfE
 Q0E=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; 
   d="scan'208";a="173082100"
Received: from mail-bn8nam08lp2044.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.44])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 17:48:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1TWiFBXQPyLkXqy+/GazfB5A8vxgMtp2E9MSM5+KdXg3ud9UHkzP1bUC+bPTrzTaNTZl+BKczF50qJeCHsnwv3tJsstDOPVc8WtmkSvcyRNbRD/OMS8914xzmFON/JWMmgHF+LkCNSIWpiZe9BGYODx0zVSEnlj5fBn4Z1va7KzjTcpqrbXw/QubEJYoZux/4wCs81N4i+9szinClQSEly2p7s5ysCXj7ah651RLCBbCsdWukkR0JoHoAEYOaA3+ROWfMfSk4ouDIieiQjkUdrOTf+EaHt3+24hKtVBGWRdutzvV/hM62s1WkWpgRTSokoPFmzARLfo6njoEWFL5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hfjvIoVPnKX9iiZ5/mjdj9SayqPmsK4Ld+96uyaqpE=;
 b=Fk6kxCC59Jc918krm3C75w5pHEjVKEc7C/jXBvn+7jaaTKXIOCQpks3w6xox1wncWJCWcgwo8lQRgK2OWmQUIWk7MznsaplXPofiePsvbwhr+mNnN7u0yRWWZFI1bOOBGGhzcM/64539lCHeK6toZXUWEjABZhyJfZrqejaVX7mZj7U3mbK6eXpXPz9jE/LEhheiD/uFOvuROky647d491K/HvV5ejR7h2SmHEmMJavbltaJs2bmsr0XtYOMZUL08047fZG9kOAq4hXIXOGtrQ5qAwd9eGzWgDAUdYGpSESRpOEZoUq2mgLLN71MQxFJTc+7usKqK9SYNa5nd14BmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hfjvIoVPnKX9iiZ5/mjdj9SayqPmsK4Ld+96uyaqpE=;
 b=0Au9y1fJA6ZZ00S5U9VmsbL/B3JHrPkmjrSe/rU7zjXa9dhABwEgye4X+LcrIevELkWvpmCD9fqHq/zeEiFKJr0IDGF6+c1x9K82KfZecg+FE5CpIMsu82LMp8lWyvwWwHGKrg0Lwj+dRPjk89/RCQ0FnKmHmCJbZJfVVbQ4Lak=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5994.namprd04.prod.outlook.com (2603:10b6:5:128::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Mon, 28 Jun
 2021 09:48:40 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::a043:568a:290e:18bd]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::a043:568a:290e:18bd%9]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 09:48:40 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "13145886936@163.com" <13145886936@163.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        gushengxian <gushengxian@yulong.com>
Subject: Re: [PATCH] btrfs: remove unneeded variable: "ret"
Thread-Topic: [PATCH] btrfs: remove unneeded variable: "ret"
Thread-Index: AQHXa/qIqPYC2XVGwUGkFAjG5cdOuw==
Date:   Mon, 28 Jun 2021 09:48:40 +0000
Message-ID: <DM6PR04MB70814C2126868BE1DE1DDC19E7039@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210628083050.5302-1-13145886936@163.com>
 <ee06042f-da1a-9137-dda3-b8f14bf1b79a@gmx.com>
 <DM6PR04MB7081A02339DB3ACC72F86261E7039@DM6PR04MB7081.namprd04.prod.outlook.com>
 <PH0PR04MB7416F1BC157F848540DF37389B039@PH0PR04MB7416.namprd04.prod.outlook.com>
 <e73fd408-d5c3-0e17-b3f4-e12f2c105bc0@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:49b5:3cc7:e59d:b478]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07f2ec7c-72da-4e58-db86-08d93a19e8d6
x-ms-traffictypediagnostic: DM6PR04MB5994:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB59944FD6FA9E0AE4CBC63200E7039@DM6PR04MB5994.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9zeCbODJBBn1gqQ9WLbCgzujL40zKJv1S5y0j3QncQXYLY31N7WBPMG8AIgKQWaw6z8+PWdPe9qi0FAzKXwdu3R5L0xRJmikrq/DcHt99NoDATLrwY1JFlGDvOzWy8WbeHUwc/AGE4Qgn5Fan5GCw0GRy76xMiRwFkh57N9/AkA4gLl89FxvfI+UA1i6l8i+p4fk7m6jdXqVRKAgidYLFy78oqbAmt2j4KmzsZKKVsY/b5LOvqMVaOQRhO99xuTBnGGbLpYN13CO6z4NNTSs6vqspxFm8MJEvcVnaje7RzFA5li1H7FwIGJ392gOXHxhc47kuMEj38D/W1QP7ZhNaSQUqw9FPlqxh6/d63r06EMe2qGy8ODTgJeIAa2oCWnra01l4b+4S9WrZ3pYZaDRpzH/tGLCwCY0Rh7rTd/FGPwVN2YOzvuhcU+BBNTzIckjy29lgJQpPOyWovabyzxxghY5eearO76VJvDk0j+KD1Q+xVBD5qR2CTGV8ZLFDtrndPRuTCNj+EHFhsW8AMOFHkOIHoi0KBYit3jjbxlcu4H8X16vSB4ZdAOJ0Ir/3SRqngkJihD+BuQbmBwmek31RkHjiIlB7dipksdj91F9Cv/bit10RdH2dfm2CT3fiAhqMy+pPzGF+Ehdc3boP1bOQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(316002)(86362001)(186003)(6506007)(122000001)(38100700002)(2906002)(53546011)(4326008)(110136005)(478600001)(7696005)(54906003)(9686003)(33656002)(91956017)(76116006)(66446008)(66946007)(71200400001)(66476007)(5660300002)(55016002)(8936002)(8676002)(64756008)(66556008)(52536014)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?c3hicFE3SFpxK0E3VG9OQi9Ib0RzM25VbzZwMTdyUUhnalpKa01WTWpn?=
 =?iso-2022-jp?B?MjBuRk9QR0h4SHlmVDAvZHNxdzZva1RLY2Q4QjdPcGs5UzR5Nmx2N1Iz?=
 =?iso-2022-jp?B?Zm1zMDltZVpPY1k5YTA5OWR1UVZmNjRQYlB0ejZvK1IrcUFkM1FOMW95?=
 =?iso-2022-jp?B?ZnhXQUcyUHpxbVc5U1EyZWZRSDNlOXFWYkJJRmx6dTZiaTQvakRZK3Iw?=
 =?iso-2022-jp?B?UmtQR25mcVUrWFFvZklNYWoya2tJK0kzeEN0WXdybUxWMjE1TXZvSEtn?=
 =?iso-2022-jp?B?b2ZhOGRnajV5UjBOM0lYdTVxcGoyQUtXbDZwdTluSDRrMnpucjhETzJP?=
 =?iso-2022-jp?B?VGNNdmJhdVljNExybG5tcjFpNkFMdTFBbkpUSFJ0OEFxWXdpY0ljWXNh?=
 =?iso-2022-jp?B?a04vUGhHd3VtV2VVcUZabEwxc1Z4OCtRWW9JRkZjWW9FUFpqS0J5dFRL?=
 =?iso-2022-jp?B?VnNOUHdGWDJSemJmRGdIVHdPYktrTjcyM3o4Tk42WThSMXFuaXVCTERH?=
 =?iso-2022-jp?B?QnVxWWFRbG90N21aUW1IN2FYVzhlb2VMV01BbVFOektvTmRhRE0vTjFB?=
 =?iso-2022-jp?B?bDNVeDdldEU4T0tLY1pwTlFDd253TlRtSDJ3Nll2WE5hTHJYVUk0NlEz?=
 =?iso-2022-jp?B?ZUpuVUsrUkZqY0l1eGQvQjd2YW5KcXpIak9BTFBoajh4NEpNZUdkSTN6?=
 =?iso-2022-jp?B?aTJXUU1wZHVybzNpSitTc3NLUTJUNUI2MjRRMXZDaWVMOHRhSUlacXJu?=
 =?iso-2022-jp?B?dDlRcGZSaFRaZHpOQnJZWlZGT2c4dWN6a0xPNmRnb29KWlFzeUJSWGxs?=
 =?iso-2022-jp?B?Y1hGWlR4OXdOeWdwVXEzV2lwSG9Ob2ZmM1lYbWVVbU1XZzI2ZVRCeHRo?=
 =?iso-2022-jp?B?U0lTVHBZbElOSlNHNWlRdVp1Ynh3NDkyYS91UmVtbmFUZ25TN1U5aTVx?=
 =?iso-2022-jp?B?bGVTMk9IYWZTRWRlQkxVVHl4d0xyUjR6MEpNald5ZE9NUEdNQkQzSlRJ?=
 =?iso-2022-jp?B?TVpJYTNEZUZHOWNoazFZSy8xSEVHRzhwVkVqbk51NEhic21wVDFWSGpy?=
 =?iso-2022-jp?B?VDAzNlNIOHFJU0Jaci8yQjk4am9UV3lUL1ljRUVtNGNFUmYxeDgybVBn?=
 =?iso-2022-jp?B?SHNXZ1JHM3JUdEppUzdFMEpYYlNKREJ5Y09rc2pLcS9HZEVhd3NqSGJ0?=
 =?iso-2022-jp?B?VHVvNXB1R3JUMG1UUUZqQlNSa2tpdVN5ZnlHWmJNZjhHM2RUVXpwMklj?=
 =?iso-2022-jp?B?MFJQSUFKaVZ5UElRdi9KcTd2ZDFWbTYwL25IOHR2UzR2SldhRjRtMzYz?=
 =?iso-2022-jp?B?RVhDRVhaam9UNFRCNTJoZkhOVHE3Qll3RzJBajBVenBZcTIwam5qenpn?=
 =?iso-2022-jp?B?RXJVOWVmbFY2T0trY0hEWmErTGs0MW5hRUhJdDZrM29kR1VSUkwxTmww?=
 =?iso-2022-jp?B?QVc3cXZHME1jSmNPQ2hiVi9LOTU2aVQyNjRnOGVpSG1BRWFlWklwQVcx?=
 =?iso-2022-jp?B?eVVkU2sxeThhb0h2UytVL1FtWE5FTmZjZG9hdUwwY3R0bVRWY1NUeFVN?=
 =?iso-2022-jp?B?dTBmdVlGRnNPL29PTG53Tzhra2s2Qmo2Ui9MQWd0ZlVONDlMZ1pUMGs3?=
 =?iso-2022-jp?B?ajJpaUo2VFhDZURiN3RJMHRTTy9mUk5DZHl5UXdsemZsT2sxS3Q4R2lP?=
 =?iso-2022-jp?B?VGVJL3pHQ3BRSUxFNTVOQkx1U0V4TGNLZ2lWb2ErK0luUXVONk1sN2Ez?=
 =?iso-2022-jp?B?VmJacXN0bGl6cmxiUkw4c2grbzZoczVWM2xaNDIwYTBHY3VwM1VwZXo5?=
 =?iso-2022-jp?B?eEZlSVBXM2R3RkNvWTFZQlU5cDkxM2ZEckhCcVpodjVxSU82NU5GNFoy?=
 =?iso-2022-jp?B?ZDBHdWlCY1BCOCs0eGFIQ2RVQXEwOFVjZjc1YnZuZjR4UDRnUlpDUzZY?=
 =?iso-2022-jp?B?aTZtbU44TFdWV1lFTlZ0dWY1S0R6ekFuNis3M3BISFBkU2grNVQ1cFoy?=
 =?iso-2022-jp?B?YlZ4WFRBZ1FndTBKRFp4N0hPNS9DSGltNS85K3FXalNZdXREeHlsYStz?=
 =?iso-2022-jp?B?V0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f2ec7c-72da-4e58-db86-08d93a19e8d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 09:48:40.3897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jDPZEJTu3SRMSaw37KNbEKttzemVboQoiUITV3j2K4Kt2iZbHcnfZ+jGONw/Xv76G9qLsdzaV17FWmvlq7jr+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5994
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/06/28 18:45, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2021/6/28 =1B$B2<8a=1B(B5:38, Johannes Thumshirn wrote:=0A=
>> On 28/06/2021 11:34, Damien Le Moal wrote:=0A=
>>> On 2021/06/28 18:22, Qu Wenruo wrote:=0A=
>>>>=0A=
>>>>=0A=
>>>> On 2021/6/28 =1B$B2<8a=1B(B4:30, 13145886936@163.com wrote:=0A=
>>>>> From: gushengxian <gushengxian@yulong.com>=0A=
>>>>>=0A=
>>>>> Remove unneeded variable: "ret".=0A=
>>>>>=0A=
>>>>> Signed-off-by: gushengxian <13145886936@163.com>=0A=
>>>>> Signed-off-by: gushengxian <gushengxian@yulong.com>=0A=
>>>>=0A=
>>>> Is this detected by some script?=0A=
>>>>=0A=
>>>> Mind to share the script and run it against the whole btrfs code base?=
=0A=
>>>=0A=
>>> make M=3Dfs/btrfs W=3D1=0A=
>>>=0A=
>>> should work.=0A=
>>>=0A=
>>> With gcc, unused variable warnings show up only with W=3D1. clang is di=
fferent I=0A=
>>> think.=0A=
>>=0A=
>> Nope doesn't work here, as the variable is actually used (but not needed=
 at all).=0A=
>>=0A=
>> make M=3Dfs/btrfs W=3D1 just prints some warnings about improper kernel-=
doc formatting.=0A=
>>=0A=
> =0A=
> Yeah, that's why I'm asking for the script, which could be way more=0A=
> valuable than all these small fixes.=0A=
> =0A=
> And, again a Chinese company doing the same tons of small fixes...=0A=
> So nothing could change their behaviors, no matter whatever...=0A=
=0A=
Keep cool ! This one is actually a good fix :)=0A=
=0A=
Just did a make with gcc 11 and W=3D2 and this warning does not show up, bu=
t there=0A=
are a lot more warnings about unused macros and some "variable may be used=
=0A=
uninitialized" in the zone code... -> Johannes ?=0A=
=0A=
There are lots of warnings about ffs() and other core functions not in btrf=
s=0A=
code though.=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
