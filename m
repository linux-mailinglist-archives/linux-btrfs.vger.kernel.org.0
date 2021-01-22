Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDCE30033D
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 13:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbhAVMdk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 07:33:40 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24857 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbhAVMdV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 07:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611318802; x=1642854802;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=FM/XAH0sp37Ed7EFwdOc+mnpO2dybtf/cSPvIcs8BJk=;
  b=C7vrYLmKDPFm5gEcdqidqsiRryQrocm0TKpnv1NgKQJE4W5LGIKn8IQd
   6X4yGoZD05W7ys9rnGBX+YRxPyJ88YHr5dXIecH2KSv+RHP4ul04uc47a
   IaWlcQsFu/2SsKpMdCZjfgObSmPrhM8sUrp75ndLKtzhlwXEZy66f+41u
   BBhMiHIdpflJ80LA9qQeXhMig8/MhQr4RByJZvft5Qoy5ZrSaQmxw3N3E
   TnK7oiO2P94P2x9jtyRM7AlW0N5x8LD+DdjuLutrGX7SSGwc/I51aNnOb
   hkZcsv/eu1nWr3JBvVA4DGsy5y2aL4ZuOewpmkqLhEABprhneYB76UtuY
   A==;
IronPort-SDR: hqlif8UOQZplad5yf/vpE+g0Qf9ZS8+aijSGoDQzcnC7Vo0ILf5dK6IugGkPZAvuHzZHg+EiP2
 ioA1WNS8cIJo7tnck/4aYCR9mPMVPe5qGtb8BHeu+uQCPeVNU8B6NcCodJx4XcaIjXPYkfFuE2
 p8OnGkLS7C0A5AGfLYxawhq7/pwt08U3JtP1nUS8IcrYaQ0M3cTmoshX2LotVG5ZMBJZ9VxTQB
 3+PZeUxjI0jt1omjwGhdwoR6X72Tjp5g/Dlnj7dJsdC1o10PjafB0HbEAzv2aD2ZahwcLGRVRB
 wZ4=
X-IronPort-AV: E=Sophos;i="5.79,366,1602518400"; 
   d="scan'208";a="159261527"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 20:32:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvrxMYtD3PTprmelIFY4Q6adfS8U4tWc57hqL3UTZZC7/vcoeBp2+tg8JlmkLC/nmQR7XU6kJ1GUbqWzJiAtUMWariY97jMqfAgbEvFQMU5tf7s9ds/jNHNUqMy9cd/e2qjS/MYiDafA37a8/wXgxvS348PBJ2Hj9PpYIYx1NtoyikDsSLYgxZ6Tu2fM3NtsvScEKEgLQGRqtQgpPfAiCGt4W3z/MS6V5xUepEectL+7zt0y55tA4oJ/uvxDqXN26FTbXU2UT3uODzIKweYrM9fyUSJRZXvdXucgeotKSNIHgKdecxU6HPCD72bCiiDCpnT/jHTCacsUk1ZTyMsL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zo/LOwaGTuBFsUyR4ocGnzUJfXYKfesLN1ZU3+Qz3/U=;
 b=BrrchKWgGinS5/uK4o5hkZNCKU1EPUy7Qztf56pc9dkD71/ruYvS5qycWuSKHBmxSMBewbsWTMfySZ3XsL6wQQuKJl4V8jubpK1njA5+AbWTx08+49Os3Q0o4D6tKk3Z8bsJCylEIavnXmhtCsuWExAVKTyhVzCHMHp9wbi6Y9iXkGoCw/RMySuVOVBs5ik90uiZQ3Ioj1Lqc/v27mFYvSUePbAa131kC+Lge/nai+6Gk9eB+6hQVR/r/3UK1wbC9enpCCNvE1BgD7rKC8sd8oR3bGZamaqFnGpSd2SpA/jjxJdYRletr6gvCoEjsIWU95OjUHPOPDBnI/QpnTTJ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zo/LOwaGTuBFsUyR4ocGnzUJfXYKfesLN1ZU3+Qz3/U=;
 b=DWh6A+r9H8clxvovgImI70dFhU7y5X+qH6O42Prm09hgQcPXOD5xnXII2zQNyo5RlskIoOsG7KAuAGIahnO3fwHcY8riuUlv+7Re2FU0k5wHvlfUYDUZYQkoqiWRkbZgXOVThMHrqgoOoFWA2HxueKFK5OGEd1Mkdj+ll3fa2QE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3680.namprd04.prod.outlook.com
 (2603:10b6:803:4e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Fri, 22 Jan
 2021 12:32:07 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e%3]) with mapi id 15.20.3763.014; Fri, 22 Jan 2021
 12:32:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 01/14] btrfs: Document modified parameter of
 add_extent_mapping
Thread-Topic: [PATCH v3 01/14] btrfs: Document modified parameter of
 add_extent_mapping
Thread-Index: AQHW8KfBpR+nY/poTUG4A0Obkh3qCA==
Date:   Fri, 22 Jan 2021 12:32:07 +0000
Message-ID: <SN4PR0401MB35984B16F4371720DE2E2BDB9BA00@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210122095805.620458-1-nborisov@suse.com>
 <20210122095805.620458-2-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a61:4cc:4501:d881:6dc:68d2:9b00]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee92dde8-792c-4799-9ec4-08d8bed1bb7c
x-ms-traffictypediagnostic: SN4PR0401MB3680:
x-microsoft-antispam-prvs: <SN4PR0401MB3680D4EBDC246105AFEA84819BA00@SN4PR0401MB3680.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6kjtuPlPF+wAuSCPR3Nk14Fo++t3oxdOu0XpyHAm49PWl9b11HFqTYjb33qJB2QQZs/7vR4luLFk8OHRcdU9/fmItIlG2aApAci/IYB8DwkZYndBfYKp/8PTczMtnQ+FJ+m6CS00OYrs7I/D/YnESFpUcOr36jgCyu+PApXBUVrTK5ImPEg1mNXvFmu9IoSx7s7Ihd6KwNnPYXMP8xTJs6Tv+wePiI39NBSIzUPvdlw2ZtJXBKrxSEDl2IBn/9MEnx4NHLI7gVACynImNiNq5gNASaS/uMmxZXG/JsyLVyJkaajGkUg54Z9yRo1JKub6Go7vVdylMCLweiKBwTyTaqBVeIHW54AkiZ7iULcZSGwkphUSQ6h9U8d1+be4Xomi95fM11WINdZ/6fyysih2cA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(55016002)(8676002)(2906002)(8936002)(91956017)(478600001)(9686003)(71200400001)(53546011)(64756008)(110136005)(5660300002)(6506007)(86362001)(33656002)(316002)(7696005)(66946007)(52536014)(76116006)(66476007)(66556008)(186003)(83380400001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uyANBP+Q5xIah9DIUTX/yfiMBZKPpb9oVz9Pc4Ua02Pk73EBhBeQrYeJT8RI?=
 =?us-ascii?Q?UuZ2GhCzvlHG2Klbpf+F6yFF/SiqYcEqgsb6IOSHv495TTGLAdlYThdfdPK+?=
 =?us-ascii?Q?JxBPlczbonOxtARF6Tp2R9jAJn8vj8oxIpSHK33ZCogOgPpUFo2Qu0z5sJpZ?=
 =?us-ascii?Q?hrK1RcyutGbVhXHac50kq8WYf1upf8+zG87aSwRyqwLYqVLXlNzdDMNAPVTC?=
 =?us-ascii?Q?l+pFrzw9gikIHDlZZVhk5UYSpHZIJ8xQBMpuxHJQswLgmM9WLQkFEA6tdi9a?=
 =?us-ascii?Q?OYte/Z7R6np1DtWLCtwNksZ0A2xFxCucYxgFXkTi+Cf8zbqdrwJ8WwfjwQcn?=
 =?us-ascii?Q?Lh5wOjC1UYEmPZMn7j60mupZhYX+KlhxRmj4cZ0AAqtKQSKSSVXKt9zSsRq2?=
 =?us-ascii?Q?m6KpTpIKC/jBq4+yO8XFOYiAUKg8xHNT4wwFiqqk9PNTRAeWE6wQT8S2EcVP?=
 =?us-ascii?Q?eUwl1b9VeckWzlUgh4C5JoNfHXSE1k9dHUbofiF/jTNN/cRvg0NJeij+vO1n?=
 =?us-ascii?Q?dN+i6s6s85QnQauly15ekuqcbLIFahF2lN/Kyw/9wxxJfvIaN6qmZ/kp0Tey?=
 =?us-ascii?Q?Kbyy8NuNhq+IWDYaTxGZgz6G3RQ9U65qFpLeVG19HWGsuVlCu748cern3zUj?=
 =?us-ascii?Q?OHRyIkrqQPcq/76Zkog6Uk8BiTKaOcNcRrGmXcdOrkVrTVCxQ6ccGwMGc2Lb?=
 =?us-ascii?Q?vGFNbtTzNnOZyowz1We9WA/GyMwgtgRJU4dDKTfKiN8UH8/m9DHAZwV77/Yk?=
 =?us-ascii?Q?JlrkSqg3Y08330WtP9ZeFD1DjbIYNerJpznSn+jABfLg+227GGy8Gaq7oU28?=
 =?us-ascii?Q?+GRHx8DsE9Q/i0HZEjxeLRgXXBBZnZlpqfOygrxO8P9AeE3EUfirfdkh5omV?=
 =?us-ascii?Q?eIagGCUSSCeRQRM5iy3W0bqbcciP9e79WcDrM46/7j2agKcoQyQAnAtWbfzG?=
 =?us-ascii?Q?LQB3m48Ae+g0uvHhTef6yDZNln9h44IEJ3nrBE1AcPUYHS/SdDrUkfQGXsot?=
 =?us-ascii?Q?NnlqY2/s4ouOMkG4+lfN2tdRxR8cD/B54NgXed75CQXpYJeBrS4Vb2h/CLhg?=
 =?us-ascii?Q?m4F/R29k?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee92dde8-792c-4799-9ec4-08d8bed1bb7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 12:32:07.5364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ZTjPJcb4GC7E9h51Sa69C/HdYtzH1RPE2kzdNMg1S9jOyI7NKjf+30JI6LIf9RiMLtvXeJlCvQBekiqMi3u+uKGXIf979OanIHca5c1Ys4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3680
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/01/2021 11:17, Nikolay Borisov wrote:=0A=
> Fixes fs/btrfs/extent_map.c:399: warning: Function parameter or member=0A=
> 'modified' not described in 'add_extent_mapping'=0A=
> =0A=
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>=0A=
> ---=0A=
>  fs/btrfs/extent_map.c | 5 ++++-=0A=
>  1 file changed, 4 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c=0A=
> index bd6229fb2b6f..c540a37cbdb2 100644=0A=
> --- a/fs/btrfs/extent_map.c=0A=
> +++ b/fs/btrfs/extent_map.c=0A=
> @@ -385,9 +385,12 @@ static void extent_map_device_clear_bits(struct exte=
nt_map *em, unsigned bits)=0A=
>  }=0A=
>  =0A=
>  /**=0A=
> - * add_extent_mapping - add new extent map to the extent tree=0A=
> + * Add new extent map to the extent tree=0A=
> + *=0A=
>   * @tree:	tree to insert new map in=0A=
>   * @em:		map to insert=0A=
> + * @modified:	bool indicating whether the given @em should be added to t=
he=0A=
> + *	        modified list, which indicates the extent needs to be logged=
=0A=
>   *=0A=
>   * Insert @em into @tree or perform a simple forward/backward merge with=
=0A=
>   * existing mappings.  The extent_map struct passed in will be inserted=
=0A=
> =0A=
=0A=
Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
Although this warrants a follow up patch changing modified from int to bool=
=0A=
(and for setup_extent_mapping as well).=0A=
