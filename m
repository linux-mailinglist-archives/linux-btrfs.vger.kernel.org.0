Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62537204BD4
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 10:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731703AbgFWIB1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 04:01:27 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:45082 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731567AbgFWIB1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 04:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592899312; x=1624435312;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zAFWH2JkPTQEn5lxr90egASj89uYo/U8mi6uLzf+UfQ=;
  b=YM0vF4rzse2miZsQMy3F497epBCvpoyGnXe+rYxaD7ST6+0i2VEpiXn6
   Kf7FbhD4LTf+uAPFJVjsesUEa3Ei28PVvmQj/MVgoUy1Mv7omV5aKoFY0
   whXIbpAo5YrV7BjIgtNA4rot4K+BUnK5wb4yHd8zYlIsSx2WMNSgZ1vuu
   gbzW9MBl7sB6JezAAjMWk/fos2EfqeS24XIdQfRGzRZi+3jQdypUH2p+z
   XM2HcxLh0c23r15u2T/6YapYKenBCeRaJgJz90tP/aoycL5/xFZl6JQBS
   N73P/qptJznXRSC2Ar/Iy32IAsxgM8xSPgqq8K5sarwEyIZ6shnNW4O6W
   Q==;
IronPort-SDR: ENGbXnGv7vEFsQwxO4dt/HVlF3u/EjMW313/YP3taBrHClAd0A7t3L79b/Gez91gobi+XcYpnz
 0m+QTMNAVU05Fx2dLoltu6u/0YCHKg9lTEuMm1aHPM2VA5m+UL8s9iERPDRRKd46JfJHelOjrI
 rtVC/fLx6TBMsWfxzSTIMMh94UZu7oo8q26VmCXCo41Cod7lCvfw7FoVfq9ngQxvGrPTysaTLK
 4CT2lDTlwreOUOcKLC4R704xWjbBWJKIZ7Mk+qv30fFLiG9JWFEzpmnGITtSnAxiC7VT4dJP/y
 SrA=
X-IronPort-AV: E=Sophos;i="5.75,270,1589212800"; 
   d="scan'208";a="243674524"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2020 16:01:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsbmWFARiaQYs0nXCySkmncaEaqpaErJJOhUvCjD6ilohqXwYPNh37jSJkxXBGZKZhiviy0khy8II2wzuGb+pvqK58MnuOVgCBa//J1Wt2yA3cu3Yl4lfyRaefQl1PWMNmAu4yuxG0bxH3dsJ04LrY7i0LOiSN+c5sFPhU7makwGq1rdjRjFs+a8qqc992ZL2w8GQ+bhCYoYoNgyJsF5iC5yuuMISyWchCfs2AjHAU+OePOKUOdXxM251Db56d3qWKAfMPEMfOszSu/B/7QL6q/6W7xQRKvc+UWHifIhOnI66Fyhdjl4uvlCULnmlGvCXx/jhtzZTneL1+MwhyTi1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzV7dLzRDmjYgybvyWm1jQpxR1nGbJ9mFCDr4uZBjAo=;
 b=GHXZAl1Y8Xo6N8Yo3HlW9CIwsaqWP/X+aPfGXbpghK2Zwm/xTdPX8Avs4Hh0G2kbllBD7knN/d/XbEXjv+6boKKhZazIaDSFpTj5dacQ/Emv3Pn8NPoxITpKvRRQj3gUNusNWkPF0v//IwvfyG0ZZjkJpoA4bmy+N0c/xQ4vb0X54qcy7fiAQziBmpFy+n5qZa4j3Ki9657ZzbTBiKP/b6A3dzGXw5jOMjDxJKh14UJ+gMxl6dWvVZ0d2UNp9xqROqOxMWCWKSYdL58OgOM/AkSPPtrM6iNN2PwU5hJpSLkuEstKDa+D2BTDzRX01rHI1YjhRZZ4xP1mTaJajztTJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzV7dLzRDmjYgybvyWm1jQpxR1nGbJ9mFCDr4uZBjAo=;
 b=rSVL8TKvnNhMe6TyR9HHB04A1pyMqbk5jlT+tgXGBGVNV25CeaIy8m0lYxFals7J8ep+xaqnVfkJtDkS0L/oj5EJdD5fHdspEEtkJ3J1nKZC2jtegKeWhvj0/oiXNd1gLnm0Twy6gH+BUc3EYg6B72AbGxLL8ltlTQBbmWPMwZ0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5005.namprd04.prod.outlook.com
 (2603:10b6:805:92::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 08:01:22 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 08:01:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/15] btrfs-progs: simplify chunk allocation a bit
Thread-Topic: [PATCH 00/15] btrfs-progs: simplify chunk allocation a bit
Thread-Index: AQHWPyNKErpi71GWi0ib2UxsnqK04w==
Date:   Tue, 23 Jun 2020 08:01:20 +0000
Message-ID: <SN4PR0401MB3598D133969EDD20DEC3446D9B940@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
 <bd2ed4a5-69f6-9b32-b86d-1b637bae2630@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 38fee4e6-737c-4827-2b53-08d8174b9da1
x-ms-traffictypediagnostic: SN6PR04MB5005:
x-microsoft-antispam-prvs: <SN6PR04MB5005EA787406F19F665B3D079B940@SN6PR04MB5005.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X0LUwEDV7QIa5JxhM6mtaSY87QYJ6kDuzU2jHL09H6Mh9gR4Xs2IcvSFChcVxYuJ9b3+YHZqYz4jOtcMG/q0xjEsIHTTA+BHwEsHHFVRzmafhhu2t78uVFF1nnxTyQxTgSkXLihtDL+SNxj5tZ3DZE15xyd5qNL5gJ5zdQBmqQKHoS4NG1TzgABIT0oQ2IZcahLbSfmoiE4GZ9ts9C21LEdUt2cFGl3L8dSpeAPMZJw7yhY1fHiv1aTSIGAxfkGtnfOCeLUD4fQFKpj+NDhyJBgMP+OLlRMzNAwda+GbcTD4s1O/tyWYrTSFVrv6SPPSWH0uGRynkN4WqTTe5O214A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(33656002)(86362001)(76116006)(91956017)(478600001)(186003)(316002)(6506007)(53546011)(71200400001)(52536014)(7696005)(66446008)(26005)(8676002)(110136005)(8936002)(5660300002)(55016002)(9686003)(64756008)(66556008)(66476007)(66946007)(2906002)(4744005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 3kzJ8iXdlAKwpcloyN8gQDas+W9DqZBuz4bddc0qv1vSIdkm6jWK8LvWUt+oAwDDm/SuA9LQVmjDmt9nixTLZP7zgzdtbGsRnqfadaDadO17XaDIE/o73XtBcfigNe9v7vx/ZZa+Iufv2ytDM+1pvN5CF8+OSUmOfyTtMYSJaXv72BL08QcbX+jX10hhePmbDjPxoqMSZmauR0QrslCTB7e+lntf/WaIfRqFKQbsSx+ZnpNzqoMpHIhP0XoEgzTud27aTucjHAGVupDaoh+D3N3HGQyZCC0inX0w+d0oRnO17ll57FVTEFUZUjqRASs6GZDYodwP6/cp6ayLkjPNhQe89OgSr13bY3yLU6d0hG2JVQhi6h1qgUlNfMMyvL4N+o8YXvgikZe85dPCr7LvHcW2o8gvhS5XL+oRJuVB4iAzde7Zvik1X9QY3kZms1wqbubh0PfVSuwUrslpb88tt9cxGUJKiDzrv0ONZzQpGs/5omOkQW7xHfJpYaUVmsmS
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fee4e6-737c-4827-2b53-08d8174b9da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 08:01:20.6039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2XFiVt1OH3GM1PISHl73i/tyHijqS43cfOxXD5Pi/FClPDzSZevGL9mWt6bFejhCfPOFIxjHl+/eR1S4kxZKx2D+QmS1ZOe+NXiCUXw6Wso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5005
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/06/2020 08:33, Qu Wenruo wrote:=0A=
> But comparing with kernel code, there are still too many if branches for=
=0A=
> different profiles, unlike kernel fully utilizing btrfs_raid_attr.=0A=
=0A=
Yes that'll come in the next step. I still need to fully understand the =0A=
mapping between the current variables and the ones used in btrfs_raid_attr.=
=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
