Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7331C1CB19B
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 16:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgEHOU1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 10:20:27 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45956 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgEHOU0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 10:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588947626; x=1620483626;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=NsgO063uH3ljFMkY9p+dvJkbiOsPcuSNff+cC0lUFSOj3eg+SrlQlBcp
   gaaW2uqeRRj38WCwFCn6uzBIQHN1yF8WJxGkORyaWz0NnCsiBCAtSSWvF
   Jrk0LPvifPteCanno0nJ/At+3HfvqjuN/k1v4cAYI0S7TrItQPnkDH9CS
   DhVotXuRScm5YgyrSG3bR4V9R1y6NkjaVWD1CEb5em3nii/Dz/jgRP7nH
   sbLyv08puXq8lUSIBQ2C8IIT+wv322w8W5rq05aVyxZoG6dty0syl4n/d
   8E0ZfzxT6NTjvQn2ODF+VaejWZ8GuWD2hnGBcgxzKi7h4mhd7EJwCxQOb
   g==;
IronPort-SDR: B0lvmMe6tO7jIxbwVgUZAc+bQZxXXo2BdhD3tj5NmOw7aQsEqD7vAo1dQtqgdppUA/paBZnaSg
 leKIaxwgkEFgadct9thLK+McZMGY4dBfz9nMZgO7WPf14BIrsYChco9YPK7PcpFlkP/Yg1cUur
 1cGDjR4Ye1u69gLbz4Gt+tJc3568IwV2wuZaakNZZ4jaONalOrLiAz1ykC5Zdv0rDEpQYcvPWS
 +Y37ynjh5io9odjWbIAsURIkKkqAmpTzgvN2J2S7ACWMFkZE/Nb0LFhxWhYFqah8mf390/Fu4z
 2IA=
X-IronPort-AV: E=Sophos;i="5.73,367,1583164800"; 
   d="scan'208";a="138661068"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 22:20:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elHcvTPhI/3ASUFiFST6bh8tvWwaFTRmVF4aY1IHSGU/OLU+5X3R+1cqukjPC96Q1hJq9gCbaHytIoyw6X4bcTW0Le51Aj2/7zIl4FaT+hx7fk3rcJSQWSY0298jY5v8YUFeARDt4b7EhEpTHySTKu3Ii2abIcRTUf+C1UbpUzRADq8c2AavXPf7ybzdlHe+ENuAexuxqdTWN4Ap9k0HRJgtCChOsyKMENK2Xz1vLgK83IX4NFBlXbeVEiSyshQLxQXGE7E9bUICN4H/zYgAPYfIaaH4qOtVaXrC+yb24dWfEx2W6RAWSBGzDBXm1+N90V7f0SfZ8V19axM0iQsDVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=AI6LPA3DDiWVpJhYTWYB2qOkcvWOLU/MeS8b/JIK+1iCpjZPeAPWnsCRtpu+z1BmBFeAf5GzB+wDEm0hpmeN1BThVciVKbjiboLVfJmOhhBJocpuHqoqcD259bTTNp1W4zQ7sUK/Lj/d8Shtif6T1Yne3gskxgsX7vEB9mBIXlthcQzSPWSbuAq4InZ3fce70sbf8AEHkvdKP7vaQTcACcw7maSAc1rGclfT3GtLXq3jroakFCv9g3D7FWhimljYgqfi4dUfHKvRDuRMvEfL7qpRieMqKE+r3uDjesTrYbCBHt3ThTnqYfeNT1wHlhL4NnoV/CNoutdr0jt5nlGqzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=CT9bkBLexMYrxZKuBfNhHY2pFW5XF0JPTvyqyeFEARk7j98OgPS4f+am3zcHjXKp+1gDsoqHWJf6kwJV1SCs32bTcXHqrIaXvOn2EfYJJ9J/x1UROYXugecD/jIcOOaTzXWDFgbWYWxg5N161BWKctL38xDKKjJxXyUyhplfDU4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3680.namprd04.prod.outlook.com
 (2603:10b6:803:4e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Fri, 8 May
 2020 14:20:21 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 14:20:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 17/19] btrfs: optimize split page write in
 btrfs_set_##bits
Thread-Topic: [PATCH 17/19] btrfs: optimize split page write in
 btrfs_set_##bits
Thread-Index: AQHWJK0KM4Zy9HX2HEifMQaTN27KPQ==
Date:   Fri, 8 May 2020 14:20:21 +0000
Message-ID: <SN4PR0401MB3598931133F630D5D9C239CB9BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1588853772.git.dsterba@suse.com>
 <d2b64677b512a5d4f43f5c612270ddfdbc93fd52.1588853772.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0b9953b-195f-4e63-57e1-08d7f35af133
x-ms-traffictypediagnostic: SN4PR0401MB3680:
x-microsoft-antispam-prvs: <SN4PR0401MB36809FA8A2C280F28E5436049BA20@SN4PR0401MB3680.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fB0NLG3uWqNP68vwQfQTlWBTO4mHrlJUMlOznB2GdaTGQY4CqhMAg0p3qiMCu1FKnIhaoAaLXibRMegNbSB8dk3ZMPsN8BClZWUxgkNr0x9Daxpaov0FximQdBLlnn/bTQbmz3LDebATeE7JlEUStzSP/JFiQGk/P5cmf6tPqIK2TRXr4LR5VCYgyomzNl6XAcCGU9lv7MRBOCyIfcWONeRI6K5HEbXkWweDSQ/y0/IXrfGvO+B4ltadKed/m2JCvnKfUHgT9mDpUhJugv3WHOFMu9VBFmuGlUxq4NDo+1NCh9pHFCLDBMIJgP8bfy+HV/SPzbRAC6rAzJRGBf38k/VyBSDDXvuW5Nax95t1sFclyqrBUIAFvG+VltW8xZjZL0+wLNoTMi5XmN+L9MpYxmo/TWTBGdMLLEXEmAmAagkj7Lg5LjVQzeuJ+puEMc3lW6QpJaejo9SiQ5qZl1WLWomQDplP6VNpcNiD8QSUgOvw1wumgYjInuTuO7oweqDtd73U0AZxRqLglQFxKdmffw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(33430700001)(86362001)(52536014)(186003)(26005)(71200400001)(110136005)(33440700001)(66446008)(66556008)(66946007)(64756008)(66476007)(2906002)(7696005)(8936002)(8676002)(5660300002)(478600001)(19618925003)(83300400001)(558084003)(91956017)(316002)(76116006)(4270600006)(83320400001)(6506007)(83290400001)(55016002)(9686003)(83310400001)(83280400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: YNBNaMB7E6ricN3weBKvD+3J5wKUKRh3bY+44XQEdas67GvsAyRmQEGf2hiULF6ySbGYSVbR6r8erlaO41S3HiTW0VBRSRMDbiVMFxsQldRWz7+avXHb5huez0Z6jG6GiJ3kMz1LbC4Ull8pIdt1D2p2Ra5G+q4PDF80M46439i0kD2Dvm+FqTkJzcFCJ8mLDkXUwFMs5t+5xZ+uxoEftklxw8YCYtASeFrVy0XD/BJifbYpZZ9roLCl3EO3L41AEJlLbl7cMQBVuq9dHa39IehuLs3IbrNgt8QLfi2QaZOLFsBfiPsTwN0Pe5GxXDGFj5JOSMxkyuWjjY4vTWk/s4OopAE21lVSLKeH84RrUl4V/uF5rpmDvYK5px7wVTmoUZuoKHWTHrd25RHXb5bgxd8kck/UxvFuLOBU+0hDYyIrDZUqIz7tkGurMEnWeO98nXdrglX82sm6cUnP3EHAq20x3bJZ67O16mefZnvLZfr2xWKCPMT66kBpRfBbbSwx
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b9953b-195f-4e63-57e1-08d7f35af133
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 14:20:21.4255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m7+uwqye8JPlZbBwtUDxwOSnHtvhPqZ7yY2QouJnKOMj78b+qwQAs0lkLq3NzE4yVJqv/Fs1e+Wj/fuiVwt23CEZdlOB7A0ci68bZeGIong=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3680
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
