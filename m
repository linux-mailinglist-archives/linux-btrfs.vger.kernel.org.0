Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6CF2168DAB
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 09:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgBVImb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Feb 2020 03:42:31 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51507 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgBVIma (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Feb 2020 03:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582360950; x=1613896950;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=PWvDXsQaMbDchHFZ8wuu9Tf+nVjp4ejC7WelNY7DJiQE8MMqaqeLp16m
   Vdem0eZI9YnhArfjqhPMzjTPYiTZ4c8SRx7ZVy2HNywdsAbbFDGtrU51w
   PQiJpXcicnMM55xtN2v0woC+7+gSb9CgshpYZxZMlQsF3Oo1hveG3B1Pw
   NxZJZefUM8Pm2UbV8y/ISC0Az0nkB/xdFORnUMoLdJLELYCQEFaR0sdYk
   SMqD4T49xAc/h6xhUieFd9/G869yUyFTAj14u4nuzCJU9HUWr/VkaYJ9j
   7zlnp/bv9tsIcS/Z4Ep0wK6BTO4WgbLV+GZ7/EFT507s3yhYcG7C/Lbb9
   A==;
IronPort-SDR: 8KrrY3j4A4+Y7deTtkdngEFe8RU/sSgXRqtTWJBL9GhOQVanM5ydOrLg0EZ/XEuMz1iUNJlQ0K
 UWWDoZ6zYDHCrHeHId6S4Sd9/XnyDU2oJ8Y84YeZDST34r9udxY6+Cila6BRXvsN833439BOHr
 3xituoNO9M98n1sIFM53SznKoyROVTay+3/4g1OVf7kAhzKlWv+H9/ZrTbpualDLzO2mMVH/FX
 40dtTc25F2kwo9uTWLSc9iC6b39ysOXpih/YUvjOxepsrVD7vuc+8tmZytgAm1H9GsosQtPOcw
 fwo=
X-IronPort-AV: E=Sophos;i="5.70,471,1574092800"; 
   d="scan'208";a="238577061"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2020 16:42:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjU+ky38lzpcJzvMrqc6UWsw6r3GYm44HZaeHbqsC7Int4BUjcIgNBaHLjh9+TeNcwXt1OISouFg6/iSl63dSvuQbN4TqdAfg6YarV+Sqoq1Wnb0c1qY1exh5zHUQiBIZVLEfNzGuJYBUX3I23N7OY1R7JADyBLFeU+Aob1gVhClQdH+ztCBnnr+T50zIOkpmFY1OHxhxZpubEXLLLW+MeloSdrvfrWZ8Cz6aeYaUJb//E3TYjiQ+WdWxHTTtwXIY6PMkfS/9yMbmx+gdodN9eNwKGI6wCoANWX+jOMuXofi8lR4iBXJvrOCuTiRrBewSxK+4vPuE8yQouuKYP5Ksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=PK8VKyXeEC6mC72KxssVIUO/q/YiIqvFeHk5XTaBmfm4Kzs2P9Fe1LAAEBKAmjx544tBRF6Yr4JT3X/IT2og23QPX//xxvJaDyDnr6Ygp5rqYH05o3Rn8qdZOWkMEfWstYKOdGnx27rv6oMaxtIpQEoYACBnM3b3wFtRjZZOHfKdZEAYe3pWd7QIiITrbYVtdJvCWpwZ0+OL6pqzWYzc1JqvrJ0ywuV6aHE37mA+nnSEihhEA4vQlEw85pBAUPoKVkuP7PTFrqr/NhUIe37GO8vgg4xjmqhtl5lIAB7qRiLCU0yudhUyQcJTYKuvPqdyt3aD7oJFUWmn38jsbSLeMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=UdXRf8xplySJQLWOTI1Ej0o25mJ6TcIuTB67VX7d5gpRKHpBVNCWNZdQPUgC6JX6Y/vhAZh7DTEENjKkAJXVdWmRvLjIX+yHI1ReMUctWr1TeC5bGKmHUArHn5o2EnyJgYNhFilGWNl75AtP7NeThhppXOakk9QfuPrTz7IKiN0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3583.namprd04.prod.outlook.com
 (2603:10b6:803:4e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24; Sat, 22 Feb
 2020 08:42:28 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2750.021; Sat, 22 Feb 2020
 08:42:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 04/11] btrfs: open code trivial helper
 btrfs_header_chunk_tree_uuid
Thread-Topic: [PATCH 04/11] btrfs: open code trivial helper
 btrfs_header_chunk_tree_uuid
Thread-Index: AQHV6NRhTPUeHULhMkeFpJ7Vwoh2hQ==
Date:   Sat, 22 Feb 2020 08:42:28 +0000
Message-ID: <SN4PR0401MB35982C0F4B0F606EC9D0C7D59BEE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1582302545.git.dsterba@suse.com>
 <67db92c27cbc6af0f5a120eff73b9efb3b281999.1582302545.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [46.244.212.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27ae5b15-b8c3-4d61-3366-08d7b7732665
x-ms-traffictypediagnostic: SN4PR0401MB3583:
x-microsoft-antispam-prvs: <SN4PR0401MB3583FDE889E55F209C2427879BEE0@SN4PR0401MB3583.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03218BFD9F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(199004)(189003)(52536014)(81156014)(110136005)(7696005)(81166006)(316002)(19618925003)(186003)(4270600006)(26005)(66556008)(66446008)(91956017)(55016002)(558084003)(5660300002)(66476007)(66946007)(8676002)(64756008)(9686003)(6506007)(86362001)(76116006)(8936002)(2906002)(33656002)(478600001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3583;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I/yA3YUgyNhBvruXJjmKQ3kKxb5F70XHFwGEjCVX0fA9UE605LaZ8bhYuNeN51mMqHjyQ/jK97dsbDqHW084DM4i93u6UAN2Hsenzi8K2LEDzdH3cMRAJiapFRqwD+UmwTPvjDIWE0BjpSBNKjmqvD+EVwlPIvmBLN8lU3uLUlc9MwXSGyUO5sjZx/iIVUiwC26x1DmIw4dzFEYOEfJ9b3IvIYMuwtS0nv00WLlfIMX4OSzlCyFPUIcbFSaMQtTp2cqNRLGATuHct0akb9M8huhYlgocu3xUGTkMLKyzOb0XBSZRw9R1xSuB11f12YISnYCLbXlkDKGF220OHAiztLtNZxv0xVtA2Jz3E654zW3RPAObeGx3WDIdnTBeA93DZZMWqmebEM4Vv/SntqX/dTFaeQIOydJE4NaAUeJYN9PvbnNPm8Qe2kVopH+YeU2+
x-ms-exchange-antispam-messagedata: q2AsyjKBgVzu5lniq/pXPH1Bnt0r6qTOygp4TMZbmtjaKT1E74JlsYm95WeLpGVD5TbLvaVwGwFBObfkGyN65RVRqFmq0CiY2Z58yRgbPlhg+snRSvuAgOtdzHM+KmKpTA+EHsY7T52QNuTIigTmXw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ae5b15-b8c3-4d61-3366-08d7b7732665
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2020 08:42:28.8313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 101dQ5icDAlwjpLJXJS6o7/+CRhM1Ovwt0QBsGF+ZBOiBpVSSoFIVQGG+e3bqS+5hdkEmbBzJvIO9jk91e2Lvg62bk0XhZynaDfbBbc2YsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3583
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
