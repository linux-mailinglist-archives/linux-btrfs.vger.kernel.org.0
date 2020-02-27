Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 651A1172BC5
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 23:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgB0Wwu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 17:52:50 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:59096 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbgB0Wwu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 17:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582843969; x=1614379969;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=HVrFVIKTQ//dww51vawfSn8t312BbNSJQLPNmuKAJbF/RgWAcxjiYV6A
   3CjLp/dqhH+W21PHPbrMs+DHkc2NmaekXjTQSUP5tD6+8KDWe8Mfem7F5
   EnkNW9keBDd+HvjcEeuza8ZlA/IjCr2r1hPLEQhBsVasGC+zsumQ879c2
   MNU3PHeiprbKWfaY9ht50W0T/0WZMd/schHEZFwISeOiN20YNRqp4NLio
   ItGewkABRf3hjeShYc9QAqGourF223geBb13aexOWHJhu/zgeGCc+Z/E6
   fhearyLrZy0VRjmC+nWsJkZBIGg3W8TA6YlAashuk2RazUjUIE0LRWEGk
   w==;
IronPort-SDR: CdAlida+99Taihshb0sUq5pVQ9n6sH091om3OLmqgEU8EiEXAHHPCktF8i0zn5+t0u3crg/xHp
 bZqY60gMVlrcTyMGFd1Zji8fwPF2afw3r/F6+lI0u9bhzShJyLUg2gOA2Di3NQge2y0jI7dQK4
 c3WB/fn3x0oAfkz9ECFaLppurprqDSlH6EMCgRn1xhi8DfaaWdCU1Z8DggO/F7VO1ajwVoYPyK
 VlDaqQqSlhYhIXJK3+cCxti5vcj3Qg7FryabgKWKt1XaIBM1fnksJR1EMwCcKV5CoOSciPt/s5
 LTc=
X-IronPort-AV: E=Sophos;i="5.70,493,1574092800"; 
   d="scan'208";a="239117877"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2020 06:52:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aw36jqaQS5+DoKChMSRh/LR3rqnNmooWGS0dz3yxNoesDiz8E0AtN8RadwBUClrOfPTrA57P6blzYIBH33c6otOGP6+f5FPZcPu00piYjLAwBoXOc7IAHmxZL8mdSxQ0J7Sg21LEBCi9OzMisQ1RsOb8axAC14vQVbnTEcT8jKpDctDMQXq5VO68HurNhWvfegbFYeSEY+k4c9tA7yapGy5wG0renRTL0TBtRl4UvTeONZGOlVNNwjupG2gC1hm0CuUlg8xWyVY4sHd/wyU8qj94tixli0Cc1ebP8l8w3eKw/cL6+lDCcNBo6Zhj+gGIT47l/PoaJk1DdWNC8siCmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Y4W14icxh2U3JuzTVV7m75aYYhGsmy5PBL78gPg3TWOZZwvyqLRpaoOb8ZLnZPrXrZ7PHjWY85oItwhvWBXwMol3672zkh+ILDX7ET3dyWMKBfT2hGFkQoCA+9vLjHvq5md/juF/RzUydOr5QX9TA21e8PRnyOLSj/e9oRJ+7FuPOwjS+Kky5Oo2/vDNJrKicHe/sZ6cSCxYQRTuTYFTukauja+FBYlb63MT0Ux6T3fiZyEX2q32USeJOOlngvDvTDlW2gj/0RZYEeaZ92zhAZFZLDN+zah4Js3JjsELVp/n8XfobQX2zOn50j8tYRI7Vfyy84lOxK4gEGKbQxKZ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=lP+q/mb2CaXljNWNsSYameDPnzosm0Xz1obL+0GkU0A6GHECZiZuSn6HvLIpbJJ79fp6YaKQJV0NJrOML8FpGukLlsAf+qBV8CEOfCn0bUmDsSxw3SHm6Iz3T4NcIEA4jiDH12opCze+r34v5s4ulifgltNJhz+NwX8Ti6FFUaY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3710.namprd04.prod.outlook.com
 (2603:10b6:803:43::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Thu, 27 Feb
 2020 22:52:47 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 22:52:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/4] btrfs: simplify tree block checksumming loop
Thread-Topic: [PATCH 2/4] btrfs: simplify tree block checksumming loop
Thread-Index: AQHV7ait75IydBTi8USAxA3nEWp/QA==
Date:   Thu, 27 Feb 2020 22:52:46 +0000
Message-ID: <SN4PR0401MB35984B64868833BE42C995E59BEB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1582832619.git.dsterba@suse.com>
 <4f450bbeec245479a3bc2b40d023d1979d622587.1582832619.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca813572-69c3-4ae1-806d-08d7bbd7c3a5
x-ms-traffictypediagnostic: SN4PR0401MB3710:
x-microsoft-antispam-prvs: <SN4PR0401MB37103EF59691A8DEFCAAD1F39BEB0@SN4PR0401MB3710.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(199004)(189003)(66946007)(66556008)(66476007)(76116006)(91956017)(64756008)(81166006)(66446008)(81156014)(186003)(8676002)(86362001)(52536014)(33656002)(110136005)(71200400001)(19618925003)(316002)(6506007)(7696005)(2906002)(55016002)(478600001)(5660300002)(9686003)(558084003)(8936002)(4270600006)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3710;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: omvQEKqmExRaJpVb4FTxVVIKPWZ96w9RgqwoHwbT95a/O2oEBKfkgcbqtsWXDET/pngjkpPecPNQqrmyCAnIhWRR2S9m4mMfR1NcBHhwDhAr7a+aOTYfid73AC/8z43GxhErC8CAr7eGLPIVPXxlPK2ZjuFJtJU9TGKPHlUYWx+1fjnEinvfFxCbE4EXpGlgGJWkg8LWe3/u0ISnu/NKvy18jg4iHqK/Q0yekFMeD2NCIS4BjAWKQDqQkOmOmNAxHAEhkSUKWtdIewTOd6ddMDHA01ue6e1YRYcxGSNhH6MtdVFk4p4fbUG8QItNdIGuOsNsG44R1JxJZFgl7n8dnQ2sCFWm1Vptg0KgVCU+psJ5XqW2lNAfoPvbDb7U9Psmqg4nKoLRs/6AypvpxXVqRoeKaXGXSiMQdux3ZkPg18PmaZxo+3oKWoNwuTkPa+yI
x-ms-exchange-antispam-messagedata: qFt22xGJouE6QK5RiB+ljRC5S+7EcLHIPcCgdTa0xQWj/UD4jlViDmEpqnRMClAL8qtjOfuzE/mg29/pekFmuUpUToiWJpGhHnVMoloc+iJxNJWlKBD/BJydLyrQ33SCzUUbllmEQnCfeAdm2Xc55w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca813572-69c3-4ae1-806d-08d7bbd7c3a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 22:52:46.9801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6aDO9vfSX7QfwiyJ4Vrw6uFHkGyr/4++2DFCNy1+G8rehlhQN0YsDrQngygAUmOlqvMNeDtdlz+ovU282ego4eTfC/pM2WCcuo0ZJ/Ry2tE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3710
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
