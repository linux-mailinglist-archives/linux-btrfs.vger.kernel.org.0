Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23260151E5E
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgBDQhD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:37:03 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:22014 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbgBDQhD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:37:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580834222; x=1612370222;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=ED7yklMs3YZn1SsFHSNdvilYKcaIrZ27fwwGmVHPIMcBhmHhRQI/7ihD
   H0TPodWh1PxXda6gO3EpbgVVqWAelkCMBmdpWO6cD9WrrGgNr0BMrSske
   XFqBFgcFSzXbgl95yLFrwC02betVwUJWR+Csfag6sMIcCcFWE2DJdC1WK
   GZArA9n8oczjqeKuDU2e/G6xzmqWu9MpDd2aeGTRALCiSThsLaqx8rkk5
   rw5DdiyRCGjAz62Tqq1cok8JSHBmeY5druKsxY6V+vmgTPMo7c7JrWfaU
   rHJbMk5wEvaTyxX8d6VkyzXRXixr7rKhAtqaR6oYhWW0w/wcOgrBubJfP
   A==;
IronPort-SDR: FC3B1VunFpIt0Q6C0/Bi6ABhNOn/Cdxt1t4PjUv+pv/zqEOZRp4mlkOAcqchzpB9CwvyQ+P6oo
 qn4xVZxkfC0uFRC916bsS/r5LbLw+X2cWz3AEy/ku4Pflbg89kVQsSx9NTASk7faxSu+6CSSpf
 Gkcs3wQWp4yv+E0Nv+KOeS7OEG05H4PDBvmiKb+bAyZeKmnlLWnYDyXzFmzkwnyFpKk4lcU48b
 K7bFImvVFvQ9z+zCDVTW9Z9HYPCq+qgLz30sB0OQfmET8l/pBCmPuXiLNThXxuTa0kmmLjsOr2
 /to=
X-IronPort-AV: E=Sophos;i="5.70,402,1574092800"; 
   d="scan'208";a="237038597"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 00:37:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6RyJOYf+coqPWGgpZrBEGmW1UJs2699lmoQ12xmHwbrJoSxfaizyz7zbsXQSJTKSZ0B8mhqEkDoXXia8jUdahJ3tDFbKZUzZnGjlR1Kz7xHeJjR73eqw+/sOVj7FoUWSFL/YkB5qwIwy1tAUgWdpE0UVjAm5DloApiAjBjla2ucQC7QLS9v11ibEgrUcSFr0BPJ/RYJ0ekMZQuUuUuBkidGpj9Z6O/wtfwwq9DRSMsh2ZOOa9WRzzUHjDQsPvOcfhEnSvhDvkZwXsejl7wUgvRJNYrNWhLXC8s1al8+k3ZH4Y+1woe0gUGrO+gUSJvmbOhwfLrnXZy2wgWJIIQivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=YcFVbDsqTJnCUAlqhHrKMaURhvhO+KQptHP9JRO1t53ymMVjzrYturReE/0lbcIh98xlofVMg9HcTLX143xNWJaO1j/4+JYUIAJqOXVg+8FFMDDufwHnZBVEPkkBKemTMbCK9C+xTbwJPXeY0tRcySjqKR+ZFULBHkpU30iymWxGZtnqSfbFjDD48g0k4je32IqsylupyN9/hsFZhpZJbYU1leiaC9zJ75axhutyO+tnsyLodcgg6rzTFHXI8i3/skXQ6QbwhfOkdBMYPCyOi7CDD7wp2ErzL96D+gUmmospNUe3cRx9gg817WdhJU6/C2mRFhF83SMGj/OtUzuFgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=sZCLD+i09W8yuDFzyy5q/gK5KrAFHK+C5reaq+4aOGwj+WBDZ5o/EROiPh0mCsSf7fusKS21hIoFIcQke2KHkekU9GKizS0dIN8RH5mgNpM1MCOAiR7keyKweWlgjzIFukW5m6vQr0xKVN8WvH7fJNa/B9vV99WK89QEN7iItZA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3664.namprd04.prod.outlook.com (10.167.141.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Tue, 4 Feb 2020 16:37:00 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 16:37:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 06/23] btrfs: call btrfs_try_granting_tickets when freeing
 reserved bytes
Thread-Topic: [PATCH 06/23] btrfs: call btrfs_try_granting_tickets when
 freeing reserved bytes
Thread-Index: AQHV23cPfo6vlfT6kkGbAePc8mVHnw==
Date:   Tue, 4 Feb 2020 16:36:18 +0000
Message-ID: <SN4PR0401MB3598DE6643A41A2F013CFBC99B030@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
 <20200204161951.764935-7-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d23d6d7d-a46f-4c8b-5950-08d7a990752f
x-ms-traffictypediagnostic: SN4PR0401MB3664:
x-microsoft-antispam-prvs: <SN4PR0401MB3664D42BBDEB0999A1871B5D9B030@SN4PR0401MB3664.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(199004)(189003)(52536014)(33656002)(64756008)(186003)(26005)(66446008)(66946007)(6506007)(71200400001)(66556008)(66476007)(76116006)(86362001)(110136005)(91956017)(5660300002)(558084003)(7696005)(6666004)(19618925003)(316002)(9686003)(55016002)(8676002)(8936002)(81166006)(4270600006)(81156014)(2906002)(478600001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3664;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lFpyIQKVM924/Vyl8jwu3FWQDOSjNaHSnvndtjFpuhBBtNGNvDwXGDxHYWZCEjmKEPXDdhH+z9kQ69qwfMjMamfAiVlRafNk0euKz/2lL/1iEIYJ2qi/p3TFg46vGhvtYRrRqzKx1RkOXsqjcZRo1MdsOntcvSMzD5AlIn0cD2aovdf/kmUhIrLEiH7/C2HQWsxyTMYYCYay5pieyAclnWWKV3qlmXlUHunw9ZpgMi7CO+q53X8PeOEdBy99804GBXjZGLTA/DUD8H1PQgztFWjO79Ut68sdPSTI/CnnxX1apMxDEC+KI65SHrLuxi/pJYaAqHicn63Aj3Mb+ztfm+oujmMxrTA9s4z7pPGVK1EC7nhho7wvsNyXhK32dmWUNG1we5nscli9o1XFuMGSIUF8ZfzLgMAaHBny3R4hPEwvN+9CRPrWD7xWyavKfQZE
x-ms-exchange-antispam-messagedata: Bvas6O+jv+4ovwAW9qJCYVyNXxOGfcYRLYbkiIOyME75JGV2iblzyEgvONehphk0V+8gryzSoboFRo1+Mmu/qoipBrsQD0/ffGYQonJl4f2ElHPKl4XCUPLKVTsZodrL7Oyv/MdKMMGSSytTNlR0Kw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23d6d7d-a46f-4c8b-5950-08d7a990752f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 16:36:18.4536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a28n+5M22sv8omSU5xgsG4la0KzKlvuVBngE2fs6N2hXxmh80T/dJo+NJdyvNs6D6cdRNXg5p58cutgDAWt/cWMjCIitpdVgOT+E7hiLbhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3664
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
