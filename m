Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D32138C478
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 12:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbhEUKS3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 06:18:29 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21586 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbhEUKS2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 06:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621592225; x=1653128225;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=SJ7gCgVlM+sPZWCQ2AKJ2gF9QJgbgyy6wd2KPO5qZNQ=;
  b=hxkIW5CPfjV1AQqWS+Dslj/OM6cGrnUz//LvUlBRIfqG99lzIU2SGFP1
   SBJ48xELYHdQhAiSjibjFt3VY9ezjJkeVLqQxrPTcsJCbgERLM5vFUGVw
   HqGgcHeweWkFID/T6L3THHEv/RiNd47RVlM7AUQe5eHHPfTay/7Hf6WUH
   EbjlRawpyoEf/ConeDA9eT/xJ0vV6pGyT12/Ek06NHpHEI7lgkxTIkZEQ
   96J65A/gPcztOSPDBGOpGIlSr7eUCz26XhV9i4nMWZFhZG89n0lvHi/fO
   bn5f9Ap/ynL2FWJ6PRQAN+MXw2Kg/aJsgWpHW1OkofQntUSnjleKGd0VL
   w==;
IronPort-SDR: TFch//4Ko5CBr4uytVdmpfkIvu5rXCvSEsBIgEkDkIOQIIoIjhc876O1fmNFYyRmyZTbEZnM3t
 zU/jLQU5sG8FSfutQsQD/eNb2yp13EWsW7PI/edeDSy+JlQY+AZC2BVKSwj6cgYXqynEUR+Coc
 7hR8mYKgwtM7SrnG6UMTM7QG3wGgnVPmKG5vbgld79xNouVFFVLxHFoOeQGVqTfJ+LBTxc16Zk
 b7DhRHDWpLyH+HtnBEBJtdicm1uf1GnyWP1hSSPEB48jQ53jlBed/f1OyBODzkZ8yujDWXYfxB
 z9M=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="173634940"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 18:17:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9FZz4OFTkbiYcm6dZpfb8VdZk9E6j3KlkyB5rCuvWfwjeYuJxcCYjiEYCC9Gw0e3fUoa9OHt6SCCPA2qE4+ja9XAFgY5QWVe0g47LiMthlUHpMb1VwC3jBshQpeTg04TpUjCSHeIe6Wl83c5JbaYkso1u0vb+6wJOyC8QxU+pN3bZdn0FZ2hME7sxLMyEcduHgnbPEat58ouFo5kL35wAUSvImyPC8JORpvHMYgLmcx4cK6XmVkUfTrEhxtqquVpgApizzaQGbB8aX60cOULMULo/FwGBtt49rJ5B0nvkD20dtYIgcqhQAbOc8i9CWbP2KeUeMuo7wXT8lkjf7jyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOlw5FhGb6w9WUMFEx37B+MvTBiKQGNcMEgn3O9pNQI=;
 b=Xw4afIZCVxgo9Th+OZ/uscRDPmDIBsHQlU8ANeZprur3kfOi27AKeGdcaKId6nTEpvq9y8qRtnCEgo76sYUfM9mQIs59DG6S84iHQARSG9GL344loA8Hwqp/qMgaidAVj337kqTJsH4JM7XrgsyeRrlnC3OXHp+XFUMXuHYBVgayDfmP9xqMoijkyhgbonVfwmTZIOD0xO5i+rhjbU0C4SlHpIl2kykT8xkyH7Znix65BzvWcWO/p8LuGOxWrKyUfW65cvBdHPuWbxLv0UaY1axUQQVI9mNojPni7seGbz6oaa2XHLXYQ7UXkWxUxA0gasoQy69Eu5iewqH64RuYcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOlw5FhGb6w9WUMFEx37B+MvTBiKQGNcMEgn3O9pNQI=;
 b=F78u+JqJwbsYRb2//8IqRxhD6ePl/lt6OyIWE1OIdxok5PLyrcBeUpZr1S8pj5ByJrxCRcirA/B6ZoBLIOYPdtoA4CmIKrsPNPSEiC4H1yRayA4zvlp4oSwu3TGdsKsNDT5epbPpB+hiq2rR2ylPuSvkbJjydVgSqyBwoArUJgk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7605.namprd04.prod.outlook.com (2603:10b6:510:57::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Fri, 21 May
 2021 10:17:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.035; Fri, 21 May 2021
 10:17:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/5] fstests: add checks for testing zoned btrfs
Thread-Topic: [PATCH 0/5] fstests: add checks for testing zoned btrfs
Thread-Index: AQHXTf36vav5X+sU9Eyulyb+u704Vw==
Date:   Fri, 21 May 2021 10:17:03 +0000
Message-ID: <PH0PR04MB7416E64E9F3C70C39EA657BB9B299@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210521045825.1720305-1-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:f8bd:921e:9aa5:6d21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2edb9342-6933-460c-13e4-08d91c419416
x-ms-traffictypediagnostic: PH0PR04MB7605:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7605EE067C55A780322890DE9B299@PH0PR04MB7605.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kSaAv4trs5MEwI8R2KJcNlv64M+3AO6IgprIiLnh1znMtkf1WxLFnlQRXj5OfAJeyiffsyGg+a40bWKDqN5jxKm09g0F80I13J4tZf5famQKd3ZPNqU9kgcyPKAYTtGqm8bKoWkjELiTD/UPoE2kFU41mT9IeLy/sUY8O5cKI0wmbpGFKGYPShp/43bfFUtWEovcmCAHHmbxqp4/28+gpEs33wRePyNyj9VevnISEhlBA7+emANddV1ImD/7TEyxQfMpESBpgrk+Fuy3owwcflbKLwJpLTZYuHyr46uihq6uZbx2g/1VzoOhwe6IUZ0IX4XHZjRZgwnrUn8/8Kyso6k4X0sbEiyk4hVo1za0wODu2pNoFb/HpjgR+D2okwrsKzV9IGMtAglaC4I4xxZyEx6eGkIfKeQ+56LlBeltjGpMpW0lrmTGlxQ/5ZHVT9gLTFjLe/UF2IkzXbZXgQtuSqRnEeFDlUgGZK+Lg42WlNOWXmqywHRd/0Kat1m6hSX5zUoG981sZ+MJ7ien6x3jVQGS3OknAwSXqWwy1cCJl7xjy/gHR3JAHgHBvCnaHtIhT3UzHc3xzdABl86se2D1p8Q5aWuejVgCx+iBL7pRKv2zdFw7jncPP89Y0WG9EcljYbPtFRCKDOfUBt5TqX5u/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(66556008)(66476007)(64756008)(66446008)(7696005)(66946007)(55016002)(86362001)(33656002)(2906002)(6506007)(76116006)(53546011)(8936002)(71200400001)(122000001)(5660300002)(38100700002)(52536014)(316002)(450100002)(110136005)(9686003)(83380400001)(478600001)(4326008)(8676002)(186003)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vnUWYybx6tK83VKmYd+uXo0j6ffE4hOf5YJhFhw/gUuq2oHS3Dvs36miOqwr?=
 =?us-ascii?Q?+jtoPTj9feEiYNEwmtC5dzHzHBFTMnI5YlrL5lcEiHNb0i3G2ymg3idacofZ?=
 =?us-ascii?Q?I1MgwMfW9XhSDKZX2XCVA0hMLGk36cJxJMqF9ckI2pb+f6mAzWgXambGL0GU?=
 =?us-ascii?Q?Dxf3K2bFMnRA9c3ImvZhwD6BcCsMOn39w1fO67fN7LWB6c1i9EfmX4PsuFdl?=
 =?us-ascii?Q?Es0C3k1tCVdJHKvtU+urYkh5W2gKOly4++UJyFHymzZstCK/Vi9a2A0+JkB7?=
 =?us-ascii?Q?hBGrkqpj4Glfir2d/QUEvIWC21VYsFwEmZPi9TuTihIPxQBfkdEtRo/OIG3j?=
 =?us-ascii?Q?2Jr9L6FHFZhiWs+jnMkIciyH1BpuxwXZtniiqg+jg5AYGEDqlhopJF2vTxWo?=
 =?us-ascii?Q?cfQFlSLhB+mz5028Q6QUqIIMz+EV1iAkf5T1E+79j6RTE9dDV2k1U//Z7aFe?=
 =?us-ascii?Q?rkokDoW+qtq2QHfU5yyjGn7ojKVOoX1a64fbFYhNZkDVjWZnHy0j10Kw49ws?=
 =?us-ascii?Q?Mwh4lenI5tJfsuOSFvEgJFyig63rHXa0ngrJbuEObuJN8oM8vhQHGnoboMgA?=
 =?us-ascii?Q?d4lZrBTG9xsUPcb9PujZGYYAc9NjpOvm2h+Mqkll/Ia9gRfolaRZNaRQ1sGV?=
 =?us-ascii?Q?zztVQoMmAs8GlVZMprF/hrHAjHv4L2D0yWjI9aBvZj4ob3PV6kWj4UvZlar4?=
 =?us-ascii?Q?fZUiJV6CgV/xWE8pd3R0gxJcVBz4YxKQdtpUSoCm+3bD00M6SpXdGl5fgiwW?=
 =?us-ascii?Q?ItrqSMZAfj955xzrNf1JUXYo/TRhBWoXzTHt5Ilq5kpUCUpNMSZEC3Jr4TF7?=
 =?us-ascii?Q?JhCtXm5bltFD+r4HDY02NRV/vVodTxcb78piT1a2Mt+6p2ewKM/FH6sv6YYI?=
 =?us-ascii?Q?OCVIp1cjxCRkzIBGx2hUiccZqJChjoVDRCDqBXwwzQ+CwSHy7mKqoobXntCL?=
 =?us-ascii?Q?C7ZGtTt3NJR3+4gTXu746cmNgVmCbHHGdLBEylu5ixTneDfFR2b7jw6F1xg1?=
 =?us-ascii?Q?i+DUN1b1QK+RsLmG3wq/THMdDfnxruiLNCzTaWdSHjFSHncCEh9OLqZu3YUh?=
 =?us-ascii?Q?L+N1cWTcC9nGUEi7k+eNMskE0nEU48JOn4heV2bNG3zPndWOU4zYakL0ieE0?=
 =?us-ascii?Q?ek+WvCn5gJ92ijGkRKMWdT+iGx01p5WILZ2Y0s7FF8HKzPG71mGi208EFq18?=
 =?us-ascii?Q?7pu92+0A91L/Fq+c31XwTqobLui+G926gw9ZJVLlUwR46f7pHmGRmZAv/hOy?=
 =?us-ascii?Q?L/V4i23UO/3oVcMucIBMTtQOQWGHVkRxtRxsmCiglgmZggdZaPhFIJUpBgXD?=
 =?us-ascii?Q?MHAWNvGpGSK4TcYA3aF3aun6wHVt6fTP2mBPFj9Gy2bKqjAOpNjRYH8cbFu6?=
 =?us-ascii?Q?G2GGAWrF0TjylukPDSolxHd61aOwGw04nR1ypO27gntD//MCqg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edb9342-6933-460c-13e4-08d91c419416
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 10:17:03.0999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vrKttOhwXx0RxfzYFs5pvT+cW1lDsf++04BkM3ZBblkjw3c6dasdZ3Jb42aDKIesaULveh3xUd79JmRbyxpcFRdzf73Z6AVdNa9Mnk96JGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7605
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/05/2021 06:58, Naohiro Aota wrote:=0A=
> Several tests are failing on zoned btrfs, but actually they are=0A=
> invalid. There are two reasons of the failures. One is creating too=0A=
> small filesystem. Since zoned btrfs needs at lease 5 zones (=3D 1.25 GB=
=0A=
> if zone size =3D 256MB) to create a filesystem, tests creating e.g., 1=0A=
> GB filesystem will fail.=0A=
> =0A=
> The other reason is lacking of zone support of some dm targets and=0A=
> loop device. So, they need to skip the test if the testing device is=0A=
> zoned.=0A=
> =0A=
> Patches 1 to 3 handle the too small file system failure.=0A=
> =0A=
> And, patches 4 and 5 add checks for tests requiring non-zoned devices.=0A=
> =0A=
> Naohiro Aota (5):=0A=
>   common/rc: introduce minimal fs size check=0A=
>   btrfs/057: use _scratch_mkfs_sized to set filesystem size=0A=
>   btrfs: add minimal file system size check=0A=
>   common: add zoned block device checks=0A=
>   shared/032: add check for zoned block device=0A=
> =0A=
>  README            |  4 ++++=0A=
>  common/dmerror    |  3 +++=0A=
>  common/dmhugedisk |  3 +++=0A=
>  common/rc         | 15 +++++++++++++++=0A=
>  tests/btrfs/057   |  2 +-=0A=
>  tests/btrfs/141   |  1 +=0A=
>  tests/btrfs/142   |  1 +=0A=
>  tests/btrfs/143   |  1 +=0A=
>  tests/btrfs/150   |  1 +=0A=
>  tests/btrfs/151   |  1 +=0A=
>  tests/btrfs/156   |  1 +=0A=
>  tests/btrfs/157   |  1 +=0A=
>  tests/btrfs/158   |  1 +=0A=
>  tests/btrfs/175   |  1 +=0A=
>  tests/shared/032  |  2 ++=0A=
>  15 files changed, 37 insertions(+), 1 deletion(-)=0A=
> =0A=
=0A=
For the whole series:=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
