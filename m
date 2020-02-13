Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 723C115BC55
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 11:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbgBMKFa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 05:05:30 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:28968 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbgBMKFa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 05:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581588330; x=1613124330;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=JoNGlDfjbLVNLQI2x74vGRZDgqHP0AfCMWZNWfR/RCX29v762CXp3DIx
   GtLkXoz17e0L69acgctZhCOPqA2VbBeSkRA+wNIIFg7YMxAQjyiXPmUod
   OXCwwojDBJztm5FX5bg5aSedvsgxr1HVlGIslpWAoNTha0bjtMsA21Fj2
   r1+6bPDDYf22y7pOJI4M+ryvG7wbwXMr/VBowkxRCnIY5WL3FXIbgVNnz
   AzJtV/sU03VbEoPQDd4kAGCRt6yqmj5dqq41bNMWa3OlQjDidWLLkExBz
   xiytXcPYPlf82S3EhZg3gbbrAuT3t8W3e5PGOXgesVe+6rYg+46fwbvxW
   Q==;
IronPort-SDR: Qc101sEZjStG/BXk7e3TZ48BphPZfTL1dh/nuKOSVTVn4B6SnbKJu4KgM94tAtWA47ZN3Ptdlz
 4czpZpMwswS3NaNyv1y12WNSzLvwjsBK6+ZAVPmZ7K2ZOV5rU8BNbdtlKcOXfZLfoT92jmdotZ
 2ssn9LrWc9Tn8Zl2/HJl2wb6c+YfK3RxqB5sBNVdmeNRtqXFsaRkvd5gLLTg2atpR0W1WzVM9o
 KJFMMx0Dt2tZ61FQ6HO1+XVPMIT8FxgkIm8YBNCGBUUIt2mI0hi7HyBHZlJ+eLXHzXCy5E5yV0
 XBw=
X-IronPort-AV: E=Sophos;i="5.70,436,1574092800"; 
   d="scan'208";a="130294893"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2020 18:05:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrmuqaFqvPMKaCNLoHioA1+qi3ENUqqr83gNZE0umj0VoVdT53iywHki+pe6E/os7zKiz7s8V0NJovePDyy3MQxz2UvsJh2UCOLAXSn3EesWo/7yopqo4lPvvnLMp5Q65UINV18Wea0ZiI81KO2ckIhhi7ZJWtt6O7XaAOq7pC/qFDpWJUpcBnk2fQ7cHpteerKHV4Xu72FzfVyyoGPjZKjekaXo8EQBq7xf9Kp8pfKoVTsB1nHM9NBKw6jmoMc+OO5PwqvuwMWXIRcNAz/MKfEIMutjLgaTqB1x2qk0l4r59a8a4tWm3nlI2RYCdTzuBwyyQz1uhIddlD5LIAwB4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=RLvuPNoPqlebHMgbtDJVAs7T7d8kcgON9TXgQSlsrOg/yf4ZklGNS3xc7PARQ6VUnUKkAKyIKn/p6kxNBeO2SfkrC0lJnCSuQSdzEJYPYodGGiizBT8J1+hGyz/36Ldc4pCVKh3fcxbGdq39Z0VHzLaqev3CPqS9NAWRcLROrofD3imREVnQwpJ+F+IRshg9ees+7G24mK9zeKvtkdI6IdT9MRj2WqTwS8FysTrrnEKvlRS7+xapb+a4Mc0qzmgM3/4EVylq1BWwcMCqN7U8YRzV6X546lKXzxOdrOTGO69P0OYGXKeXVtS10DJKmCIVNZHHhLZnpbKYBUlbs9CiWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ZYqKeFvVX4qsFC4iSElrj+t1ib5gr28gALRfTSJ1fis79JzFGzv7Omai7p2j9ALDnDZJpEll0qHXWWTGTPW4rj9BxixmCxqwRXZbsGkUKVFAzNd6KijWLmzu6UwuQOHu2J4lET3H81LIsd5vTo/e8bkKH2IccuGdpIMhsLB4xFI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3662.namprd04.prod.outlook.com (10.167.139.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 13 Feb 2020 10:05:27 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 10:05:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 1/4] btrfs: set fs_root = NULL on error
Thread-Topic: [PATCH 1/4] btrfs: set fs_root = NULL on error
Thread-Index: AQHV4SPxywjAUfvdJk2gWYoCHpWJBw==
Date:   Thu, 13 Feb 2020 10:05:27 +0000
Message-ID: <SN4PR0401MB359806E8DF477CE9E4DAFEA39B1A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200211214042.4645-1-josef@toxicpanda.com>
 <20200211214042.4645-2-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d76590ef-89c6-4bf5-36c0-08d7b06c402f
x-ms-traffictypediagnostic: SN4PR0401MB3662:
x-microsoft-antispam-prvs: <SN4PR0401MB366224A171DE6FFF1B6108169B1A0@SN4PR0401MB3662.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(189003)(199004)(8936002)(6506007)(55016002)(9686003)(7696005)(76116006)(66446008)(64756008)(66476007)(66556008)(91956017)(2906002)(52536014)(66946007)(86362001)(5660300002)(26005)(4270600006)(110136005)(316002)(478600001)(33656002)(186003)(71200400001)(8676002)(81156014)(81166006)(558084003)(19618925003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3662;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ae3SKH7+MATvGcTaGB7zFNKDuzndX6qwMA1cf+zMPY8jpMYK84Un5r7YON2GwIcucecOH1VMClltQZd7VmajIYMUOyQ4f812qh6nYOUWbLOMWGWq+GACFFzVfh0uuIq28IrlsZXYDhVwTeJARVNAI0lVgfizZfCeQIpVTDNH0c2LL//Pd72F1yD/swsE6V1OVR7tmTqwH2qQbquN9QYZSnVjxRFNg/fTe2BlNPdpiiVsZ2zNX5qPOgAgEY86n1d0bPX1AUD/BtnsqRos60wwY/84eVYyxQ092o0qP4j82Ar85HqtmaRLzyuaDhVYHT482bL2r1Tw3Q1UU+QsAyNr9TOaAsqQgYvzZ1tGsdtMr1hJIKSmge3gfSwRwctTsSZhPiez/JgIxa9D4JHinSDjPF2BI4CXgbK4libNtJYfeplNjjJMnQaszs/uqB8qBHnu
x-ms-exchange-antispam-messagedata: hATD35/MhQxG9ChOvcA5b3WG/Tn5FrFwc3vPli9rH8NBlgIL/EWnDC71iKOiaX0udmMOkCHpLw8x7EncNbwPILK31a7VTtl7s3/XeyU7XCdDXxrHmoT6HcTLsPJWs99yM2BwB2oY3D1cxYeCF8Vryw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76590ef-89c6-4bf5-36c0-08d7b06c402f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 10:05:27.4987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJRGKHDHDpfRG0kh3hQuhLpIh+fKsRt8iihbc2VQdQhEPlXYSrC1gc7W5yF9hKxNgEcr+pSxEdnmS8iuaukpajvL33W926ufJIKlETFtEK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3662
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
