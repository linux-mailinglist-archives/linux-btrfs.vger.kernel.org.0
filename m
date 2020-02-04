Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7B0151ED3
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 18:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgBDRAk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 12:00:40 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:17431 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgBDRAk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 12:00:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580835640; x=1612371640;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=tsSv1j6PipCqqcwo8W4fNfp8zYo+tWa/IovSX70JZKM=;
  b=BEZIj4OAj3RrZa1V4qbxMwFHBeXR7VecQ3ej49XCajtmddJ0fdOFIjm+
   lQDds/RywmEJnZC5HkLaWFNEs4vScnDYvgwTS1hZ32ALSAUqRd2iVlPTZ
   lwFZQOSJI8jf76Afx8es7hGAZRtUJ3bHUFT6OgRvbd7cYhYxeIVl0Dvvs
   C/HTg52PYf4cfOlID9Ov643Q39m7rcpO1MBK0tqFutMU10KNyBXPmUxVn
   zP4YR633acKasBR+IPzpAsCw11JLtAd482j1OazzOUa61MY1GZ/ZD3OMu
   Gm90hkJzJGNkFSCm5qkYFlEgD3rfh++GlZFbhjlxTlWdrYiIzFrGfSVgH
   A==;
IronPort-SDR: 9sJYNyR0Gm9nW6uAv0P1NZJt4DbZtxWckAQRIqnNfgme9MJBhWW6/AbME4n4B8iBMVJx9kfi9v
 DXVs7Mt40UGB8LKf2RSC3QwnHc8wEYhMsXJTOz8D/eXMGuaSUcQRxPAORR62zHUF4iRmue9j5B
 Sx61N5Uh/Dp0o++tj7fgj8eadbFI41Fw4Ig+HPSsnLGosqwx8yzfvpM3BTTMdP78wRoOV0ndAV
 FCycfmmTgf0kQCidJwHEZ9SkOZ7Oip9Aeu3FInO8HZBQz6hs+ex687t17281AmcbIGjk4rUjSl
 jGo=
X-IronPort-AV: E=Sophos;i="5.70,402,1574092800"; 
   d="scan'208";a="130540409"
Received: from mail-sn1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.55])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 01:00:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0sxWJp0F6oEd99fB7GyDeNkX/bJiYnqzLvFggiqG48RaFO/pgiCXgVfywIv5O/FE+sqyyR3Qw68yShk7rn+COAUM5axJH3ZgPR4kh8hOh1yNra4XtDpjFeM4996Kylxv8FD2LVxq669LQS0Cg3seKpPgCfvEsWgNuYzvEpeuL8u51Tb2DBeOYc/B4euPkaAtWUTqwu3LAAdvbJ0P/Ng4wRiCAi6ATb6czZJD2OxoZiKBOdqNBm47UE4Mj/PH9GcGO6rWGPqBxlp4TZ+cuOOnueD5I6WCb/ZF6V9SE3z/a0DzY9s2hKsYsWXjAKe0zmRIdskvwUi7Rie1RV3Fsyn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWnH2qJCd1KW8+op9pX5VvYOJC8zPJTPEfMNUC5t4Ew=;
 b=NbyeS0Rt+KI46C867GCt542lWfOhlfGWYxT6HqEss7cXo1mQ03uqNYUYenuPC/NEg2yWgzbxERrnXParNeUS1krZ3TNSTGonEezdcX8q4FHZGDYP+TjtNdu1vHswjcHwl3Gs/NsRiVUGQLEcbi+WAvnUY4TrjGTfMKNqxH0UdDV0jqM+sbDTi/rgyXRD+vnsqnJVSFC2ygiqX3WysJQCLt0MbvGvGOZ2rrVrf18Sshpc/mqDVVsqSIcsxKL5up1F2P1xWGXiZ41DLdApiMKtYFZWD393jxLP/bEhbd9OOGSdNXLDuof5mGgCB8KiTVByeEZ/YY6a9UdxADvXXjTzYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWnH2qJCd1KW8+op9pX5VvYOJC8zPJTPEfMNUC5t4Ew=;
 b=GYg/8oF3hZ3D2s7J1SGcXugxd3m4y6H8onbay/koZRPflrg7dU2TQO4tp/77V6Sr5MW378dp9Se2q2+gy2IVK/K0EVi9hiyuyFY39QiE+fqabbBJTxEilinKo/zMc6CY/VRDYLHTDUX2h42zFeIgaWeqjb9Q7N8f5e3HdRb64R0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3567.namprd04.prod.outlook.com (10.167.141.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Tue, 4 Feb 2020 17:00:23 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 17:00:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 14/23] btrfs: add btrfs_reserve_data_bytes and use it
Thread-Topic: [PATCH 14/23] btrfs: add btrfs_reserve_data_bytes and use it
Thread-Index: AQHV23cKBIAC95C6xUijWk5WLsbbcQ==
Date:   Tue, 4 Feb 2020 17:00:23 +0000
Message-ID: <SN4PR0401MB3598D3D8EAFC177418DD020F9B030@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
 <20200204161951.764935-15-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 503e0e35-1248-42b9-7f3f-08d7a993b9ce
x-ms-traffictypediagnostic: SN4PR0401MB3567:
x-microsoft-antispam-prvs: <SN4PR0401MB356784C1D1A4E750932B74829B030@SN4PR0401MB3567.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(199004)(189003)(33656002)(86362001)(186003)(26005)(316002)(110136005)(53546011)(7696005)(6506007)(5660300002)(81166006)(8676002)(478600001)(52536014)(81156014)(66946007)(64756008)(8936002)(66556008)(66446008)(4326008)(66476007)(76116006)(91956017)(2906002)(4744005)(9686003)(55016002)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3567;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fUwlYrxnj8KZMPcQzj13/DigFunNTrEkDCcDpT5sPXcvYNqK9YW7Xn9uPz8BMBXQjusW/u1ekUSOFpbEQCGT2U2hTaTu4TpPBKLEpEFOqT3smyUgRPzaYygYesiHr3jtedRV4ZXkQjJFDNaqXEBSZqI3+82jsGD/jTbscxbQwfewLVXVlv3HDrBOSoSwWz2/TlM0hC0XsYkzlAf5DVwO4J7ZFzjXEmTYi2K8KcEBXnqVe9TXOWIEiEm/uBkrzhHAz3yLotl7yNDkKcRM1WuYTggFOuX/97UV2e1uHIz5zmQHCmCav+5hY9UFlyER5HwLudX9vt0WD7dim7BLwJAGVEAw39KgWWauTWbgjTJMS6NAtuT+6UqZUszyqq5EwPhBxjPtGB2z5JD952smH1YVHIyr6MGAi6cQ5IAOV9oqM1181M3ib7jL3oK/dCqgwK8a
x-ms-exchange-antispam-messagedata: bEzi/szNUzWufuUufEPKnA6UojuXsJJovCzK0Gnib5UkKF2RUFYnVkRice93j4ffPTipbkQGj9yKecmITE+SUsMwOhiZZ29ZREuqcWtYBAfCvbirMHQxI9Iu6RNcGs+t8JAmL8Lk8HkXijIC68TtkA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 503e0e35-1248-42b9-7f3f-08d7a993b9ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 17:00:23.7789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K2xHc2uS7lIf6gyWCuD7ooL+z7F4FYYqIGpG30K/pH6p1sP4k/UNtPWeuLTo21RDGJ3JTVzSWeGF9iyH/aVuKj0+1ocq+ackuyRiq7FbClQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3567
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04/02/2020 17:20, Josef Bacik wrote:=0A=
> +/**=0A=
> + * btrfs_reserve_data_bytes - try to reserve data bytes for an allocatio=
n=0A=
> + * @root - the root we are allocating for=0A=
> + * @bytes - the number of bytes we need=0A=
> + * @flush - how we are allowed to flush=0A=
> + *=0A=
> + * This will reserve bytes from the data space info.  If there is not en=
ough=0A=
> + * space then we will attempt to flush space as specified ty flush.=0A=
> + */=0A=
> +int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,=
=0A=
> +			     enum btrfs_reserve_flush_enum flush)=0A=
> +{=0A=
=0A=
s/@root/@fs_info/=0A=
=0A=
Otherwise:=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
