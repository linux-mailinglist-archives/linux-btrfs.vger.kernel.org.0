Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABEC26A14A
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 10:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgIOIwi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 04:52:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54444 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgIOIwf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 04:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600159955; x=1631695955;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=VyUjdcmaWdorsx9wy0MzhQvBkpC59czXFVmJP5jK41pfYop20sMQxz7v
   0Ydj3LWu9qLNaXPOdB/fkFWz0+oK2FxqBvB5hI8RXExMGI48pkiJ4RFiG
   jXKjCs9UT4E4IybcLzZiADVfCqAckRUBKba30yXXmYvA7hlisr+lvwXCm
   k3NYC0LU2piEcvbsPkDRkdHRq/vq6v4Cr3PEe4axZBYyPWud5rObbTptv
   Nz7HcwRW5ejai8PuWZSlL8xbSNIiQIzFfJrB9Nz/5JxdEp0k1kPkfbW7s
   +dI/v45QyOn5ionG2n5L5zJrKWFUIsm0ZSehk0k/a/+7uVTiCCP4W2kXt
   A==;
IronPort-SDR: oCBIacG/+H7SK2AKq1do1HmP3l2CVt+e5RSFIpos3D0Ouq6Bow4IoQGe/mCv9Zuo+Nx+TKwY58
 8NXCDhagtbGueUZ2G/rEkdZsUtFzn3Uh1WdbR+H9AUK2M+PPk/Bxahh1K+jQkw6HD683Q9SQn6
 qrTKhJ+joKI+/k8HtGkyi1bzZmEdk8Dzp8KJ6/plT9ZsTlSsae/bggu1gSEiuYQ6j9KA9LF/gZ
 xymdt8GK8s4ZrvcShQoKegfQ4uLvEFmawbX7TkwWYfPLDipoMXJq7YBAfXW0no73FEGOn5mvJC
 m2A=
X-IronPort-AV: E=Sophos;i="5.76,429,1592841600"; 
   d="scan'208";a="147413250"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2020 16:52:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lK8AHAd/FGzL6NTehtbCHT69DSxlPe4NW4pPvD/jlmKL8scqpPBvgWk42M6bcICAZGbiCckD6g0EJETOi8ByNm+urtUI8MhxtelKhl2WftBzBKegU+CXfz+j2JNWEDQouI3UYI+vSa7kNziVqe0q+kxONCg+DNegVNRzyMnVb2M6UC8A33UIG9zq6tpsH25cUpr/Z5o6c1CSRa8URxYkVLKHDWbGUTWPjNQmyksQQrjqVBVpc6XjZMUZezx9XSRSbGqYn7Msj8/VTIXkAhKQo8Fej9AmMk4S22cUlt6idZdZCqGOv/aJ5D2FG2o4xh3Rs89GeHT0OOKbylvRMJoeDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=h7UZKEpHTJezdKAItFseoYOE7//C0iOOnx5K73iF1lDNEHmUgN8VzLBmfwUAtHDopS9zssd/VV2eaIoCexqrZGff+2o6bnAyD/6J4koSc1sXFK7yAdRmU4H7Gta65cQtdSrPwrGIq/GQsE91DiSsdwdeaEDT3mdpdji86uXhXGxfNvroBLEUsyjMTQ2QYsQjJwxgPq5yp460jWy1aCU5hWn4DPeO7zbNIVjVHWmmU9yI4gngeEdF/7bTBJ4K1/SHrBi+hMFsA9uWvcH+7QsaSB3MHQZ+SQmYKuD3ewfXWCOo3lEKSyMXvK+IhvXHetLMKtQlwm40Fd1lqkpMnPs9fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Z/MfpRTbDgJU7uz1SL+YbKOLZFDjKsY1T5XjggIQS/deFDExJyhGwp4rkBI/ZLY2YBO3xU+jbwWqOSs0lFXs6ZuAvynWryDeSABqu6zqMueLYNFSB0gVU8ndX40Hji5Eeb5ci04AfarIgY1sQUTooO5M2Znp6MtZslP0WE1q4Jc=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM5PR04MB0651.namprd04.prod.outlook.com (2603:10b6:3:f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 08:52:33 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573%5]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 08:52:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 10/19] btrfs: add assert_spin_locked() for
 attach_extent_buffer_page()
Thread-Topic: [PATCH v2 10/19] btrfs: add assert_spin_locked() for
 attach_extent_buffer_page()
Thread-Index: AQHWiyIgRTwVsg231kSVJepi498YNw==
Date:   Tue, 15 Sep 2020 08:52:32 +0000
Message-ID: <DM5PR0401MB3591BA7833198A3DB168E15D9B200@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-11-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:38cf:f1ce:e1ec:d261]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 025e7f21-6b6d-4840-798c-08d85954afa2
x-ms-traffictypediagnostic: DM5PR04MB0651:
x-microsoft-antispam-prvs: <DM5PR04MB0651E53E7FDF098197E3B2769B200@DM5PR04MB0651.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LUoERpoOm2jYEFAWKDhnVneNW0vhisN7xWY4HRhzllWQTl5eL+JYIrtTRZJNZMDEyDXRMlBHyjBMv7oHdO1kG9ID4HA/DE2PP9EcKiMq3a/MJIOUGfd6njs3D8DXxtm3iNJ11IhoX4glUbyOa8m9cDRvLzlwBw4X9kK4lkFwUPqBXKIvQCJuAUU4W0BQpUGisT3AhSPEgK5WJqpv3CEhIqDsKTvhOCK/8DQiqbIhazk7Qq5oPNTaZVfmGHEawP3EOdE1aAFz5vyfkOrjwgD9Eb2pUnaOL9wtAz4pq12ZUjvfIqDMfREQKm6vN0TPxvVjiBUAYxhihCTTT/EtuRC1Pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(6506007)(558084003)(33656002)(4270600006)(8676002)(2906002)(91956017)(186003)(66446008)(19618925003)(8936002)(66946007)(66476007)(64756008)(66556008)(5660300002)(7696005)(76116006)(478600001)(86362001)(55016002)(110136005)(52536014)(4326008)(71200400001)(9686003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pFRD3IbHGa1VeQOcIo0kQTqX+YrSPPg5to4DZ47dcAA0o/F78JZqj5K1LEgx5PlOieSst9Wc4jYfg4mjSj9B5P2+EvwBRA6jwlsgDwnN1k55Dz6m4VPgHsm1N8ddSUxgt/FUF8yYmGTc5UCodCYeXu5TJmnDALNjy4ZCORbkr6irGmgbYU/r2MrQRv5HdnduI6tVeJRz88PS2ooI3oHy4A4Jdta2c5Jo60E6wUGRH8o7bcqL7VKdVpGOowBGCXxL4czthL7qRmREY6RTYoienEQr2fPkhwUC/yu+u+LJlLVu2ibAwff1Vbt5Lw34FNM9vay32ltSJWo176GTxFxV7ntfRd7Jp1MQjO1SrEWNhlXLRv/z1PUPPqQoH+wxfuBq89a5GwaiaQD0huJWMDQs1TB3SCQd6c0ReFKXsPUyfDYbyVuW3JPKxS21xWdRk04k6jsrwDKLIrcP4wD2Iai2i285309aJeEIySLWwHxgfuKf0Me6Pu7OHrBOdMzByYI5wTjBLFdq++fGdMJpmeiHqImI56OQ4lzaIa1xtvFcXWBo2ZwHOhCBB+ZbZnb15l0WogH4x3xgukuIeVY3Du734Ke5zjWxAtRDRuWiMK/sb/al3OR5Z1zxyN3H+JJlsrci4LyMF2zvWjGxmjmEcuo3BcPyYOCkUD5/du3BarlAqoWZNsHfax6HvR/sy9YFpLLXguewIXSxnGlLF0byr5QMhA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3591.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 025e7f21-6b6d-4840-798c-08d85954afa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 08:52:32.9921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/5CmFGwIuHqCHhOLbjPd8YsQS6lL7s5jCVVN3XPImpwCXJlwx7HEEcf866qXtKZGtzGGGOkEiriyQfw75twFQx5sYmri4gUlVyiTvp5H/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0651
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
