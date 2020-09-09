Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3984A26282F
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 09:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgIIHPe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 03:15:34 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:29424 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgIIHPd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Sep 2020 03:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599635732; x=1631171732;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Uen599ign/yi+3a4VkIJ0Y5JBI7liTLRWukF9dBqOJE=;
  b=LL8weDzccIQLbWyy+Nh5VJP9oNlOY8N3yxwZtVOZL2My+9M2VgfBTpQ0
   yOMrLyuOFwts3lYbXDZwwvMAGYxDIrEfShhGoLj9GiflTCVPmt65VGomo
   66Q16ibVnuyvhVL2u1YWT39SIzhB9DtzK+bf3nP6dQGVdeDzoi8QI0JNf
   tsdii0LFG35Ae87oLmjV35iB5LvphhbWPtp1xoPeDSqhR3CpdROobVMJz
   bId6D4tV0xqOd2MQ7vh9vEm/h+mRofuoEA+o9f35tx+MDRBzl4sEZQetg
   STHHKJhpH2BrhwscRQE1HVn7eRYkRr6nU4L/26GIwcCAlmfQyVnPoZbyp
   w==;
IronPort-SDR: nrgCzFFP+uiEj6KkZSvHfYb+xZlKg6jX2u4qmXv/xejmYp64jPXP7N/7bVEPGNlT1XKgl5pqG4
 5hBXhnKjZxquIQeFUgzodKh49eMopc94o6jmAozlcXHBZppYv5Nn8Xb6MbO5uwBXNoKwf3m1Yd
 uBahjK/AdGHU/aS0zXA2NGZkoqQ97XaVJynilLiI/XOnPwugeWpfA6KEeOp0qQ7RF+tSt8ZNhR
 /uQaVjenANbaBG66dXjz/HwegkGmUJEgE/WaWElpXGqYBr1UHHksEQ1U+KxvZMZcfdruBD2Q+w
 5CM=
X-IronPort-AV: E=Sophos;i="5.76,408,1592841600"; 
   d="scan'208";a="148131813"
Received: from mail-bl2nam02lp2053.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.53])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2020 15:15:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRFJ2+EbubCr6YNDlmiV2YZ+6Jf1WkXkIuM24xfkh762fy5SyDfbpRMHgd1xtLlgjWvMFR9SW7098t3gueCPXP8fqgMAJ4OiWoliVoSCS2eIeYjCvOojaGCt9bYoaLTnvEEXqL/Pbedt8UKz346uo5BwS4UUJIEP6n1+/28YK55BCdAg241eHYqK0ltyqofXMpCYhtZYbCr8WrQXTgsmexf0bY/b01roiFMwgU93p8h2QdWTFzhH6gVhPyYpcAHn68u3SSltnuSGg6+Nay3X5vS2I7eXP1OSB5IQXtIu+jOIYxTqiYjcKTwZinKwuYo8LlFXMlWZxu+AHg9y210mgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uen599ign/yi+3a4VkIJ0Y5JBI7liTLRWukF9dBqOJE=;
 b=IxJslDconjuo4C9xd+FgJ0dncQ0+ZLg1uvAW8g50Y+gUXSacaw7L9bp/6dlPiNBUaUtAgDUSVRhzqRPezG08w+7SEIOrcdCJ1OXaUmLE4xk+ItvJEpeJYBHy/n9Rx5XrdrBWGkOqaIGVwww03dVs82bsCQ4qlsGN3r/4sGdzmlcdXw8degnl9pCC0RMFU17KAvy8EQzRVz9LLepvt23F3udcanT+Kyh+KhJxRz6Wb31TI5CVofw2RdxaV3mHdihzJhjConz8I9xOljqvAjDjAhFaSsvG1n1srHN2DeKB95DsNuMpt5+RDctvFxypAT6ckjVAmCXnKMw0PylrGuIgZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uen599ign/yi+3a4VkIJ0Y5JBI7liTLRWukF9dBqOJE=;
 b=LZWLJNSVfr6r5+/mr6KzQ1T3FMyfeZkHfEVAazGgqV2VKNLD5p9ShhcebbrHPk5AuzIWIeLv26OtC32L6UCZg8F+5ZTCR+cwCBR4jG9sbS47cfOnm6etEck8IJmH08ksMRKQO1Nv8/0cY+u3iRJttZWDLznepoQolSfIFQkfuc4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4688.namprd04.prod.outlook.com
 (2603:10b6:805:ab::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 07:15:30 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 07:15:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] fstests: btrfs/219 add a test to test -o rescue=all
Thread-Topic: [PATCH] fstests: btrfs/219 add a test to test -o rescue=all
Thread-Index: AQHWhhfENfNfB2b+30qn/1kB6qe7oQ==
Date:   Wed, 9 Sep 2020 07:15:30 +0000
Message-ID: <SN4PR0401MB35985107123C67C711DE69E79B260@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <5e29c56193c6de8bbc364f22595479d292da13d3.1599579754.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee9ee6a1-3da6-41d7-dfc3-08d8549022b2
x-ms-traffictypediagnostic: SN6PR04MB4688:
x-microsoft-antispam-prvs: <SN6PR04MB46889F99027B4CC2728B396D9B260@SN6PR04MB4688.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wDq+fsO273nHbT/ZReRnPSMVHm+vrxIurCQAm3PZXPV03B4Ta0BBjhoOcginkSvkkVlAWPCR23bhh9xNRyPOgurQ+ymk7mRWxQ/yi2coLpW1qjkPeZGCjbq6vEi/l40jwb7AKYELgnU1FPeTHdK4Z6R5INscbKTVsVsGDKUSC1pgO2e3hGuOa4Wq8sbU7aLnN8k+zP7pUTrVKlsnnnr1C6XphyY9hTbFUKKR4FJ11GK9OPVTJaaWzpVKic85WdLYnjUvxnEjoGZQHFGvFYH3bo+twwMeAs5HMKDNMcWpVDcFccpx4zyoJB4SV+Jb4MYDJWMFWFfbsasH5Q/2a+eKvjvaakVXBk4WYbP7/UnwQu9b4WG6ezSnNxYj1nzYu9AG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(55016002)(52536014)(478600001)(76116006)(66946007)(33656002)(91956017)(6506007)(86362001)(83380400001)(71200400001)(53546011)(7696005)(8676002)(26005)(186003)(8936002)(2906002)(110136005)(66446008)(64756008)(66556008)(66476007)(316002)(5660300002)(4744005)(9686003)(151823002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 2PFlBHguw5fDs4dQbu948l9i93uRgAMiGtjJXyOaS1J44RrGtJLfpWu8S6RUZBLHBLS/wjk9+zcnTPTQLHiAvQHX0fKZtnaSkeJr+gi2raNwRwwGFlZxL081SGnLg1q7WsLYeihRg/t/XXCoP6wPvOtV+KUchqSG3At/hrfWBqIzsdoIo8R+NuQcE3tRiKxcorARRwn+L7PP0ydQ5iEgfjoAkBThvhPqHiLm1gsUaeXd8wjTxfOG0f06MMfHplX7F/kxvvUjKjRID2mV0u+74oqrh1IPJzcOdCF3/UXziEljMVSO0EqFuJQtAJ4vmQidnu9m1ZIn5XGsrRcc3TheYFHyXT+eGFjDfI1Fm5JDaNK6JeUPXiau6IvBfFsZ9uk1WqxsR2fX44zivKWag5F6NV6Uxcwz0G//8wHFGnWELzJiSidbzA6zDA4ToQSo8+byAPNNjCpox5V9mnBg8cMjfVeHUNQdzfzooMSa0n3N8iMPijp8e1q0qfZ+OdtLmhRO768Ga+5yRKgrC+k/5LEgzu9TWFAAQBNvCapWmCeCK5lErXwcl4kpFB5BZNXSa+mmOALwi7fLAzM7gYuZEfLQ9960czBSLHuseBUmzgQlW3hFB1Cv2cj3HoKyhKLgn6qmcfr6khd5KXUVDVayLc2M3A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9ee6a1-3da6-41d7-dfc3-08d8549022b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 07:15:30.6097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IwYKbFb1FN36ebtOgzgvjBPUffeJYiEwqnqN+YsHMNeK1Bn0lcslN2fuDgptPdEJ+Pc0XcvbBOEeGsCRkLQR9HZhDaIFUJ0Fm44f1etDmxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4688
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08/09/2020 21:39, Josef Bacik wrote:=0A=
> +# Modify as appropriate.=0A=
> +_supported_fs generic=0A=
> +_supported_os Linux=0A=
> +_require_test=0A=
> +_require_scratch_mountopt "-o rescue=3Dall,ro"=0A=
> +=0A=
> +# if error=0A=
> +exit=0A=
> +=0A=
> +# optional stuff if your test has verbose output to help resolve problem=
s=0A=
> +#echo=0A=
> +#echo "If failure, check $seqres.full (this) and $seqres.full.ok (refere=
nce)"=0A=
> +=0A=
> +# success, all done=0A=
> +status=3D0=0A=
> +exit=0A=
=0A=
This looks very much like the test template. The only thing it does is chec=
k if =0A=
the mount option exit and then exit, doesn't it?=0A=
=0A=
So it either gets skipped if the mount option isn't present or it exits wit=
h a =0A=
failure.=0A=
