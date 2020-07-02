Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD372125CF
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 16:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbgGBONC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 10:13:02 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30702 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbgGBONA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 10:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593699181; x=1625235181;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Rj8mjvK/QNsSxE+GNbBDItOGyl9okGhNDv9FImZYaks=;
  b=d5vT8m/R1TAHQV2sKUZ7j0iij+KfCJUqi+4t57dHt8zjfslehAJdHsFX
   DR6pzCkF28KnniwnVdO/X3xWtVaDNK0/+yGW1viDHnc7f5Nf6+Bk5aQW4
   VpUgLcEZ3xId0YI0bfYHbTmYvTU4mTkA0tlVCqJnWaXPtMvSBUFP03xNU
   XzgYY7I2KZGlmutLiFchTWCEerc0HA7ygOYA+fPRBtL/ZgZq7vRabFVT+
   sJPDVln2u6oOcMQB+igxYaLcwhjLs/SfQvdKcdLiFCtb/0szscYQCbMWg
   UwlQelKRmmqKxauICavDug/mmkP2SA+mYtDy8VKpnk2Zt7ylIMZOGFJPC
   A==;
IronPort-SDR: 9Up+I3aiglnMhgjqO5V6rpNWLASnJcjR1/d8ay8AIfhMpnrUxqUX8n7rjibTNR3bs4ceC442Ez
 OxQV8GS4IwbkcRPqPv+sTMgkAbvekYeyg8efnBObq8Jnd/+VO4z/l3xKJ99gWHp7q0IS6ZCp4/
 TRTlyJfY9XAtdsYWOLSNeSpAWAm9QgrsAAl0RO+RCIxVFdd1DCvDUqNQ2mSprBQML7Xro+uGIU
 byX79gfSWaZcWboRkkz6+fDIcqMU0Lw7iAVP5yxjtDOgY2Y6qwa/38NE6R4nJi61wgDhylNaev
 AUk=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; 
   d="scan'208";a="141683803"
Received: from mail-bn3nam04lp2054.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.54])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 22:13:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVyWERNiStUNxZQABoSkO3N2/c8pcDRttdW6b2hhBUocI5VDg88EHxp0WGU4a5vtXIewNvg7QfNUoWNHdVsERZoWNvUBrdeMhwfhbDmdXHTI9TuyCTwye14E7iI5XVJRqMjTuRlSOAovaFJUU+QGqLAQhsnPC97ZymGWJ/GGZ69QgyJP657/PlRmfC98KpxdfCHy1z7oQXSQr7kdIB6va8d20Ydl2ddhGG/AEP5JFfvC3MYRL2wxhJ7eZuD4kMsWaw68bm+J5WxVtsR10xdVWt1jHPpNquvTjStvRk9taYKCxqviEQwsmHVjwYiPK/lgNxhFRKIPnEhmSMeZ3fAh0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+78O7LO9HIFV0Wf4w5T1OdKmnyH5qn4XIiugUWaTIc=;
 b=RWLbWU5q4sfeup4SxBYfItJ1Nf/zMId/IcjjQpthM+wh72truWEFR6P7caDNrmlvWZ8cfbREfj71SP88Ey5brLoR15B/h4eIxcna9910669re+RJlg2aEVSUHE6s53tgnJIXNJrw02bzcgbRlaHah5kNJKaExIYOWALG6RI1mTEUIaC4m4CCDBOHr3ndM/K/Z4/YjtDDld9SnoOabYmfSELLbkY/ndx6Zrm+3wVrne9B8ku4SVMc2CwZRSg0LryTX95UBbbHX8+j+k4aSfYTxcAL+0l+XJeuRPOGZzo5vkGGWnjYhG5XT0DjP3F/vZEwIrX6l+Z0y0muJWmLb86I4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+78O7LO9HIFV0Wf4w5T1OdKmnyH5qn4XIiugUWaTIc=;
 b=TyTSEJTVn4NTSE9EIw1FPXcqc4Ju8P64co+WuohJBloUaYPbAdaJqFAQl7zTILjUUuw+NVGwe70CC8TfuXqx3OGzC4O7+u4IIjKbmAbGioxiwBn/XxN0MQEndv3P9rQMoi1UIRT0YHnV/lxkBUKzIqh1CKX4Nfcl+yLASaukH88=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3519.namprd04.prod.outlook.com
 (2603:10b6:803:46::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Thu, 2 Jul
 2020 14:12:58 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 14:12:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/10] btrfs: raid56: Remove redundant check in
 rbio_add_io_page
Thread-Topic: [PATCH 02/10] btrfs: raid56: Remove redundant check in
 rbio_add_io_page
Thread-Index: AQHWUHdC6fymSWXLbUG12sBDoIHHuA==
Date:   Thu, 2 Jul 2020 14:12:58 +0000
Message-ID: <SN4PR0401MB359874B9954A2147AD73E26B9B6D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200702134650.16550-1-nborisov@suse.com>
 <20200702134650.16550-3-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 64fbde3f-ef9b-4e67-a553-08d81e920616
x-ms-traffictypediagnostic: SN4PR0401MB3519:
x-microsoft-antispam-prvs: <SN4PR0401MB351928391D843EA3488849E69B6D0@SN4PR0401MB3519.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ed9K5L974HP7TlvW85iMvw80XrJfmy7g8ECejPxdO+ZtahPAdiJQmNzbWuc0mW4TuF1Ec81gZfFEm3BeXpHZ7vErevvDPL486te8KXZmOWqkaymcWoQNke+PuTNvIcvptBw3rb7BFj0X+tqUJb4Ua0LnGB4uiNpKFolVmIhY34uLnHmwlAEyGciSDvtrYUV5dxzmRny4v0ENPR4c4i7Nv27NNLj+0hnrMy/qYFnV3DcOKCGYeTe1CPM7N8QTiYx7lW6UFzs9I8sCvUxxawNRCVNNHAAArsr0fxl/t6nLNyxRaCeWNwd8pohB6oaUaVtjzBfiaDt4GbU2u0I/V/WYeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(83380400001)(52536014)(7696005)(55016002)(2906002)(9686003)(66946007)(33656002)(66556008)(64756008)(91956017)(76116006)(66446008)(71200400001)(316002)(66476007)(86362001)(110136005)(186003)(5660300002)(6506007)(8676002)(478600001)(53546011)(26005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nuqOExt0bizUB4HttaVhtTTQ/piaUAdP7gdsinU7QyimuQZBwNN9y5SmRuxt44gHM9LrWV6y2I19C6+eCqwrn3yrsr43WgN96z6mC4iQ2/tkbtRoym9+vlYYnqA/NE9Kkw8d8M9+vAD516ymbyOybr6zGeaqPP5XWzWri8lEKqvpjFuz3Y2469xVB1OMKs9WazpBrW6tI+Peg068t/NOX/AhpFrnpsjAy5QJFyZxFXWov9ce43enIYOQUJB3oGeTK8jttFhJtlWm5s+PfOjG5r5NO3JnDaEjwfCRd1zIT9ZlGMrGOujJ9smjFrngUTGJNmK7+6HtUhw2QwWnL95DEXVswPgPbxzd0K8h+ypa7Sg5KP5Cx6H+HuZBdYrBE2489K6a2k/lzQ9iYwNl4B8T8Cc9PIj1qlhN/S78HliB5LpS4BkQTMeg291BYVY2X4VIvXNOCcjEIwlae0KrdgBhctR58EMAiYSD7VTyTeZhr8EAl2NqAEsOWcFfL6Itco4W
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fbde3f-ef9b-4e67-a553-08d81e920616
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 14:12:58.7801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MUpVdQ5czI+MxFUgfQL8+wK5QIjHI90Ddw0xr0dqro43PqXBwSwuDXBmBUyTYyoTYT5111mgloZbNrbdbkpK/wBkF9QaVg7sNPVEkHZVGFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3519
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/07/2020 15:46, Nikolay Borisov wrote:=0A=
> The merging logic is always executed if the current stripe's device=0A=
> is not missing. So there's no point in duplicating the check. Simply=0A=
> remove it, while at it reduce the scope of the 'last_end' variable.=0A=
> =0A=
=0A=
Maybe add "If the current stripe's device is missing we fail the stripe ear=
ly on"=0A=
=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
=0A=
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>=0A=
> ---=0A=
>  fs/btrfs/raid56.c | 6 ++----=0A=
>  1 file changed, 2 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c=0A=
> index 4efd9ed1a30e..f21bab45b7ce 100644=0A=
> --- a/fs/btrfs/raid56.c=0A=
> +++ b/fs/btrfs/raid56.c=0A=
> @@ -1083,7 +1083,6 @@ static int rbio_add_io_page(struct btrfs_raid_bio *=
rbio,=0A=
>  			    unsigned long bio_max_len)=0A=
>  {=0A=
>  	struct bio *last =3D bio_list->tail;=0A=
> -	u64 last_end =3D 0;=0A=
>  	int ret;=0A=
>  	struct bio *bio;=0A=
>  	struct btrfs_bio_stripe *stripe;=0A=
> @@ -1098,15 +1097,14 @@ static int rbio_add_io_page(struct btrfs_raid_bio=
 *rbio,=0A=
>  =0A=
>  	/* see if we can add this page onto our existing bio */=0A=
>  	if (last) {=0A=
> -		last_end =3D (u64)last->bi_iter.bi_sector << 9;=0A=
> +		u64 last_end =3D (u64)last->bi_iter.bi_sector << 9;=0A=
>  		last_end +=3D last->bi_iter.bi_size;=0A=
>  =0A=
>  		/*=0A=
>  		 * we can't merge these if they are from different=0A=
>  		 * devices or if they are not contiguous=0A=
>  		 */=0A=
> -		if (last_end =3D=3D disk_start && stripe->dev->bdev &&=0A=
> -		    !last->bi_status &&=0A=
> +		if (last_end =3D=3D disk_start && !last->bi_status &&=0A=
>  		    last->bi_disk =3D=3D stripe->dev->bdev->bd_disk &&=0A=
>  		    last->bi_partno =3D=3D stripe->dev->bdev->bd_partno) {=0A=
>  			ret =3D bio_add_page(last, page, PAGE_SIZE, 0);=0A=
> =0A=
=0A=
