Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA751E42C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 14:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgE0M4P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 08:56:15 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43652 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729534AbgE0M4P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 08:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590584174; x=1622120174;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=C447FDCFP4/JXz4k8N8Hu+CxjR1XiWyl8wzP81w8vfE=;
  b=p6GBtSGuplmzo+HrGzAiM5Zatn2okEpD/f50x94DlZlSiJ08drKFK6Np
   jA0Kza9uj/dgahVJ8O9wpYrlWAewI07MtNhJpBDZabgm/4NMq85zaUl7O
   vp7PVsZOMK0zoKXMnNLn3GrVm95FKUory11eLFkqnZ7coSf5q2DT50aro
   Qu8HODzsmV3rel6MEpWHCQmTghGVq4vq1AwwMEqjPDcVF1AobCT27zyLm
   2uH4IFg+xQMTJiZf8W54ruUO16/55dEosGjE2hVMyzyowiLL5qcNJ3zsQ
   iRom4e4PXPCt2SpsG5bNF9poL/SrmrfbC7hWd/pw2B8Rfu7oqPHs7M95G
   w==;
IronPort-SDR: wkzbP6w62OWSRTDHpARKP9y2E7NbKmJwSsW7f4MIaXTDdFWjyud3Pq37m9pHumArxZD9cgciMv
 xEjFvYP2c8Wmbsm0RldfCMWGBD16r0gx32s8EXHkimCclYTuUvZsJ+tZzYguXOru1Rmd9x650Q
 qt4500k81Erdl6cSy77DNkPCa4PB+mOngfToXah601MjWHHUaQXsoTuaLogHYaZ48EnVOLUQD9
 AnIOm84y+UKTpkqpVZRiRwFoBVRcQpoIJX7b1YbZb0v/TjWhOZZLPhB4iOLqGdkZ8y3NmN5g5y
 D5M=
X-IronPort-AV: E=Sophos;i="5.73,441,1583164800"; 
   d="scan'208";a="140044507"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 20:56:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dE8CkIzjg+slsrAJVUGiFiEd5IJ8RxmHavBSZpZOu3DN9hERRqiNMos0jKoNjEzVaA+ObvPbk0V7h5bVoPcf48upJJMEY5xRG5Tw6FtZdobOQgtMzmVkgw6wg8lixZDTABSbMi1aiLX26aAJz5CeK5qtP+Bu9dn4gigAtpuVCQYGob919Ha5CSegEaohw4YBjZ8Ai3pZ4Cf0Nbu1yviWIeqKfMyf/gChH87qHsir60qfSfg9jOlMn93jzpHjIlfO2hNr1omPaftMunVZXJWPjVd8QjFXxfRK/AiP0bbBLv+auH+WtohowfgaJsq6A3jTki/ereZHvh8nBCpyY4bLSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C447FDCFP4/JXz4k8N8Hu+CxjR1XiWyl8wzP81w8vfE=;
 b=fkcw7edzxZs772UHzPciIi/NcQJF/mlbuAdCKsePt4bRWuh/YbpG3Nox0e/3k8pCc9PntSA91giSuLOQ//Z7tD43nj/szTBsVAtyboMlaPOCGhDexXW+E5neoLLiQZRWg3ZpbuMtTgN7LjafhvtoCOhkKKqbjfzjoVQZex1It6snpC1sIcpCwP0Y1g18RcvjlNqvq/uRnisiLGgVuBu0fnK3aDk9qoJwqUsNN6dgr8mCWSwCPkYcT04fGLYCgY4+t0Xy/yVlfOLmM7uyG431xdQkVo75qnhOfsYRJadIzMXd2+gwmhGIyakwCwZI58KYM24aih88395ZXG5ksDgDMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C447FDCFP4/JXz4k8N8Hu+CxjR1XiWyl8wzP81w8vfE=;
 b=evTTgcWFN1XwMa4TyktU8SUr7c02GUpZSz/1AeqBGl76RHYSiMPCEim6xKDaWNE7l1lrZcMIaZHb2obqNHO3fyD9gYzE9K+LUXCEOtkF4AP9NHLkhJPU/m1nrKrW0uFBPSpUFkrVdRtepy8LhW3MF9h3ZQ1jGonJnBtAczcAqIE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3663.namprd04.prod.outlook.com
 (2603:10b6:803:46::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 12:56:11 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 12:56:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Simplify setup_nodes_for_search
Thread-Topic: [PATCH] btrfs: Simplify setup_nodes_for_search
Thread-Index: AQHWNA8q5PGzMLfqvUG+vNApoD2spg==
Date:   Wed, 27 May 2020 12:56:11 +0000
Message-ID: <SN4PR0401MB3598D65E53BDA0206CB684039BB10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200527101109.7492-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49ed1d23-4248-45a3-b211-08d8023d54f4
x-ms-traffictypediagnostic: SN4PR0401MB3663:
x-microsoft-antispam-prvs: <SN4PR0401MB3663B21CB612693C593560739BB10@SN4PR0401MB3663.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZgZxOBxEThnr6aHesWIeP4ClLiEIbJ3/nUClb/CGSg1e/Zi//5E6KVdFflHHKV9+vz26ZJ8/VGe+kVkfjCV+3GWSF6Hn/i5YRVXl0UGaiRREazcZ5j1921qPrq1EoMZJeQsKMBnplzrC+C9SZ8XuoB0zR2dmeknz1EbSYYhKeQBvWkRLfJI4mwWq199qSbWmjQdqtj0mI5YUkRgv9aDXsWD8tLWpCHnLq+pWWpyvJYkWz6vNN9U7DjcKETjl8Nxcmo/2PFVD0jrKY136DxSqodNiTBz7xyrvuWw/WLps/szl3dJ0D03ytLFYphpcMROVy4sZHXrhEv+XdmqPbjfmAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(86362001)(71200400001)(5660300002)(91956017)(76116006)(64756008)(55016002)(6506007)(66556008)(7696005)(66946007)(66476007)(66446008)(186003)(26005)(19618925003)(478600001)(110136005)(316002)(2906002)(558084003)(4270600006)(33656002)(8936002)(8676002)(9686003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 6N+3JK7zRzG2ohXJqEOjcWf84uksAapHuihspY/Jg1ZbrchUk1+V0Pcz3FK2Zx3TLjn+Jm2zZayVyXtZOBwGvif1Wwtu9Ooe4HoCM4tc1W7hEKOqYIVPx6/uq0tyA4N1A9r08N0mTujpmEQtP1lyEb+RXC7LafI7I2hh928xZ7iBmMetk5QUhN/BOGnYu/dNi0iygkJWBv9O/DFufDj+3lIL3nUMJ66lWq5fERmamm849N6y7FFoQiIbPXjY8ergRdaJB6ewnOcugaRkHHAD7vOxgVdkIjJbdj1nt/mzuM6Winl7V2xuOVwjEzHVgFKwTbI5lBwMGkQH31nERYaJuCkKByPKwUzYWLy4sfJSMnnw3WiYXI4mDJ6Z5WPJFGvFjQz8tgeHuTQgqclXGf/c4HO2U+98HLOvFa4RrSzAeH89fpsglkqrpdB5g2u634k+XHgrFrfKhg7WsZlpJJHRi5Lr4mevK4QQ3r/DbXzPzwGttO3p43Wh1SyEThnhoFp9
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ed1d23-4248-45a3-b211-08d8023d54f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 12:56:11.3618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q3/T5Ejs6HpAbrZ4Ldan9Jc0WuG8hvEkb0V7051yNW04EjM3BP9hQGBFT7XR1Q5HvflpA6SpoWckWdCu2RT2Ui1aOlnr0pRfS0eZuOPg9GE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3663
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Highly appreciated,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
