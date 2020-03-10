Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF3291800AB
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Mar 2020 15:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgCJOxa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 10:53:30 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:54952 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgCJOx3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 10:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583852010; x=1615388010;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Q32QRsRtvtObYYuTNzLNG3+HC5lh3SmW+ga9yYvPHT4=;
  b=UkcLvTqtybatEXAKo0vfDvQ7AOoa0Oipa6Hef8gh23XaE81HCTDZxMCu
   lw8rzVrPuVv2T9EDxdXZ/DPdnalSHBQpuX9hq5/4VSbh+hUOFfTGnW8PC
   +XCSFpQXmS0a88Y4fKAfglHtoV2KlHtY6uD2YTTGLwwZ2HZ+1Zz5jQJ7F
   Iaytdfnx/h+rk3UyHjOthAycNdeFFW22kMfPKmaZXVGWcWb+Y6eRZy1W2
   auP/a5HVYPG2g7fqfMnQ4Quv+SfwRDDn4h+dVPWoeM35mS3MuNiFHuens
   EVB1ubQnxHzlMbqaimye+ok/2RtvEgwaWsUm1of+cKuoZaEYl2NTViB5S
   A==;
IronPort-SDR: 2sWLZCDnUE1Cus2IGt9iVSf4NKzkWxqFmZ0adcigqr4ofutZnVhUlpGQYoNeyHloUrTvgh6S63
 j/BUa+Hr7hzUyrydvF4Sh/A89xqJWN/mJGn/zSHKvEnNv5XNzcSQNn3nV3+0i5JI23xgYElKF+
 lVifLFa6Zs5eZogkz/tYuPWrpoKMA3auRB/0aj7nriJVvqecu8f50jdlCCMsELdFzwrbTISdEW
 KmQYWaUp6fKaeqAR5929/zlcIZu/CJZfWZ6AGdSsO7Z1YAKOocY9bnuzM5TlEmJqElI/jbbWMW
 YaA=
X-IronPort-AV: E=Sophos;i="5.70,537,1574092800"; 
   d="scan'208";a="136442165"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2020 22:53:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHbLiGlkumQzGIyeRRJBZK0zDKQnc81j3/sikZqn+fjOjNawc+i2KL8C5vYJQOs5RUIyXBhild/pkeIWT9qFd2wMz4ZlLvCDAcAL9y1RGhqFZyxKXZi/m7oQ3TZMXUOW5hCXBDv/Eigh8Sj6piPtUq2a0CURamIzwGvzfUsU6NbtwDJzA2BDCg7gtvXJ+YAMWM7L40Je/hDZj0VrA2UoIenC/Ewp3W5yzsb23GMcdwrymhqeUUXzZCE6smZR/9CEQswxoKEZZ3bsyYEU5HOTMe5s8prYOnhga9zvVRVsOffox0CzIuKpe3OE5Cd50v/dYw12I+mYpLcVj+H1iOxEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q32QRsRtvtObYYuTNzLNG3+HC5lh3SmW+ga9yYvPHT4=;
 b=hllBzJpzH+QOKbolu5eKvRKxaNRZx/qMiP9duaKedTQT646exiAFaRIU9+EMqv1hCMqsQ8eLkKTUUocQU+NMqSLrSkXgE5/dC/wLbVIK1LUUx4pqo4bavaSIJaOjWqQQsSicOSUPhDJuBzDhYauMT0I9McV/56rkTNNAQrKqXoAXLJ6OOOPynqk4ZLUz9PQ2iON9yDdpSqJmZXUs48fsrAcM31jID9v2jPqsN69mkPugxVTJc3F4MnbZf/ojQaZDIUPuPBvJaKNTOqGVX0Njr2Zm1nOR+p5FNunrauVY/HIAd1qNh0EVNe+gMfShM6wPCsdXIYh2MXDGhcMK/PKl5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q32QRsRtvtObYYuTNzLNG3+HC5lh3SmW+ga9yYvPHT4=;
 b=udBs+3ongOG48aPsyfiiOkgVTumAd3SafT2DDmwcf7Ln73NKc+wiuqmmHJYqPT7fY9gnFTBTsMVUDQMUDwy733kJswdp7ur32uy3Zlz/2mWFA7YHtQWCmirmds8LjY3msGg9v1ViU1aLlJ7pLrv8pg6Y0ChrI5lJHgQWnj6YGjw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3534.namprd04.prod.outlook.com
 (2603:10b6:803:46::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Tue, 10 Mar
 2020 14:53:27 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 14:53:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "kernel-team@fb.com" <kernel-team@fb.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 07/15] btrfs: make btrfs_check_repairable() static
Thread-Topic: [PATCH 07/15] btrfs: make btrfs_check_repairable() static
Thread-Index: AQHV9lpXoXX5MeyuLkS3FokjXqhwpA==
Date:   Tue, 10 Mar 2020 14:53:26 +0000
Message-ID: <SN4PR0401MB35988EC4049478B03D6BB3CE9BFF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1583789410.git.osandov@fb.com>
 <1ba159f3930fca7d11350f798ba140e1a2176358.1583789410.git.osandov@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b463c189-e954-4728-c0da-08d7c502ca44
x-ms-traffictypediagnostic: SN4PR0401MB3534:
x-microsoft-antispam-prvs: <SN4PR0401MB3534B6443C858C179AACDEEB9BFF0@SN4PR0401MB3534.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(189003)(199004)(558084003)(5660300002)(86362001)(76116006)(66446008)(66946007)(9686003)(66476007)(55016002)(66556008)(91956017)(33656002)(64756008)(8936002)(110136005)(26005)(4270600006)(54906003)(52536014)(7696005)(2906002)(19618925003)(81156014)(81166006)(186003)(316002)(4326008)(478600001)(8676002)(71200400001)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3534;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IU0+U4MdNNHV4uuRZdeP9rZOC6kozkmkfB288pHV1mlPNmd98YmGoNUNnPfE+uoo6B5pSDPhBOFzx7FansD1J6xMUEKlU9xslRge5acMz4d3/2gFHd3TfXWVwRFaoSsWrAH8pGV4yL4aCDQfZ31AcYzhmyEKMxsMmKCO8/DRqZyTOvNws8gSvG8Y7H7QqJ4XKFmcoAuR8vWkndcJ6kj0XsOOw88fwDew57Phjt9kBmBBNDd1VLieGCCUCytRPZE2WSX1u9bOaICpoQxgU334sGz/9xLPcKQmY+wo+oyqUPpuptfi0DoZZUHwpSZgYBFlPsc/k391BidUARCbJtZUZuoPu2V7w8OgBXpD9SfIakbaSO1Of7a5L22UkIcwJ+pMJQ7hJmedsRXGnDsdnWRajdlRYYI/ireHaiqgkizP3TPAKzi7GDezlJ5lLdE/RrIV
x-ms-exchange-antispam-messagedata: QYgxc9TYm50ywPH4TevcItCbv/pDyMWNDAzEjAr8QKxdO4129ia5hH9bL39GBayIGhLc5AFMZ3CF4Q3+CaaAfUGm4tR4PlbJsCNiNRCNrZzaKAwKn+O1crEzl1nkTR0UYOjvbnh9L9nzr+DPv/779A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b463c189-e954-4728-c0da-08d7c502ca44
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 14:53:26.9255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZOBBtEPugRL2heCW2k9ptMpZc4L+LkVALGphUjcNfOKw8hY1DwwOfSZIukZG2/M+8Yi1wvHmf0GudyKRsBLmAiAvc7xzGDCYvfHqzJZA1iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3534
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Easy enough,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
