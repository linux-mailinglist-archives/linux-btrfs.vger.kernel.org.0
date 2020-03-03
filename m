Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 707DB177470
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 11:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgCCKm4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 05:42:56 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:4061 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbgCCKmz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Mar 2020 05:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583232176; x=1614768176;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=EK3XceLW/Ro9DTg91ICuA06Nc+58j3MeA2dZkYBMXho=;
  b=h8nFhbGEJceIlOHBpTgiNBSvfMKWgeT/RFFX69QjfpgKLettqaYPL/KE
   TameSA0iARU1NqXTcjrqGy1TNqz0HvSWs3P3Cu0oDFN2NtZC0flqDvDym
   BNUyamGsDVSQHQ7xmxfg0x1Pxmdf6FMc75MUUOgn0bURzBE1pVOYKqr5c
   XviEokvKKiT1zZXIT2wJS8F7AFn5frEkyIpOEdVeGuV+3RCAacfy1inGm
   pTaLddIAZpgnQa8YvQfUpEKcMhqnwn7uBkKBLD1mlvEsxLsGgmoVZjJ/9
   Paj3oH/oX5igUA+EF+6Mn+B0BgyECRJrg838N2sm56jyhXEDqOMoZxoiv
   g==;
IronPort-SDR: 1CI2oWixFsQqz/ssc5gso1Tok2+dDAGyh/xBRfxM8hJCR/eUyHWNhYJp9qFJh9RYA4Ifv1CsgZ
 Y3X8Q/FJ/2EQXWa5q16VipKJqVf4IuJwnBdqXNrR5jq7lfTJ5Ngr6gHzzU4YBFy0zhkK/TYFWk
 t4cmI+mqxuBnqINoVGh4bk30plKBcVfSjsZRpuqo7XVnbKorTX/Hwda5LUCBx6SkEL8FD5BnYS
 BHOBxQHsq4Tv8nUJQ6WmOfGxr7RimplNXVK9Jj+2p1Wj79Y+ICbllQxmawjQOlJPshq6hU3FIv
 A5c=
X-IronPort-AV: E=Sophos;i="5.70,511,1574092800"; 
   d="scan'208";a="135655901"
Received: from mail-sn1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.55])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2020 18:42:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ve/CdMcQi/9/uvJymmHq/3P5aAcPTsd5Xev9JyLEpzf+8V6MHLUXwQaj7Yj0WWPflQ8ycw2WGbbCPXLIodRBD96AQIf0Xf/jhhL4xQucyIJTotvqoc3sNthGA/uEksEysMmSGX7/LQgSs9/xBuHUuP8QZBxwYyLMJOF/4RSZhZopE13c61tP0whOru3DU97sGU0jhpeIAGHjUPsDbrYRy/4HycEImlkB3dk2/3bSCLhr3cDVC0g0842yxx1bYLmsh5U6O3kvVutJ0tD0eRFOYLU51pkmO8NGRAHyQ/EB1PQxGHv2IgrCZNilOhJOkEwAgUflQMpjr1aMwBVwIS4/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EK3XceLW/Ro9DTg91ICuA06Nc+58j3MeA2dZkYBMXho=;
 b=HBXWsQjIN38H5Wm9ELOUpbP55iGZQxWEVsr47LxK37yYZAwA0lYRxUw/AgPn8xKRbMLym70EQa7rhV/v3ieNBey2dInXvnYgCFHc8739aLMp7RC9orMFkonywzahl2txZB0d+0BwU2IGa2e5Uw3MBVXchayPAhIK0hGa/511c2FIVM86CdUja0imJTTNY/wLIVk25b6/PcOtFpWsXcN4nZB2PDKWjk2Y1OWpSt9RaJ2fsbZm6U9wkQ/DCMvlPbZNElcEFSIKs8DUTpeKA1xG/gr2DBMLTV1YY4aNvVoLCNn/UnbomaUhpwoIg4U1kjGxZohke/5cVbDfO7GILhaE0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EK3XceLW/Ro9DTg91ICuA06Nc+58j3MeA2dZkYBMXho=;
 b=Jd8imK90cqK64ONQsRWv+UlHIUeXVNLney4+EE+pNuB7stec53kcfZVFzg6mx1WGoZK6x8s4HpEuGzz8HsUDAG5WkJsEUBnMlBA1YMWahHfZBAty2bH4bxvl2bpDEKUhGJKDrR9NUPnFg93kU817JbKEohzbRJkF7WwewEkVutE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3551.namprd04.prod.outlook.com
 (2603:10b6:803:45::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Tue, 3 Mar
 2020 10:42:53 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 10:42:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "kernel-team@fb.com" <kernel-team@fb.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH] btrfs: fix RAID direct I/O reads with alternate csums
Thread-Topic: [PATCH] btrfs: fix RAID direct I/O reads with alternate csums
Thread-Index: AQHV8N5eHR+cReUjsEOfB0Nt3xJhYQ==
Date:   Tue, 3 Mar 2020 10:42:53 +0000
Message-ID: <SN4PR0401MB3598F49F21DE43A6455170329BE40@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <b88c888c800d66ad39b4a561ec6601d2db59529e.1583186403.git.osandov@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0534c1af-94dd-437e-436e-08d7bf5fa0ae
x-ms-traffictypediagnostic: SN4PR0401MB3551:
x-microsoft-antispam-prvs: <SN4PR0401MB3551025322B17CC4CBAFD2799BE40@SN4PR0401MB3551.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(110136005)(19618925003)(66446008)(66476007)(76116006)(66946007)(64756008)(66556008)(33656002)(91956017)(54906003)(316002)(52536014)(5660300002)(2906002)(8676002)(55016002)(81166006)(9686003)(4326008)(8936002)(478600001)(558084003)(26005)(186003)(71200400001)(81156014)(7696005)(86362001)(4270600006)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3551;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bS5KLE0WVIhZstLWKAbpg3WPnGW/wEwQVmfabXzurNkWLj1cHxSLwKtvmt2+GR4Cc4a6dQ6cFbMUCrRWzi3cjfgwv+AhVggll62o3TSyDHftcEWO+RYeMxOodmxNvwWj6ln0LBIeh+2wMeK0434vkStspHpR5BGNxndvlnvx/OmAEJPdpk3Ri+gpd0XkBWLVW+CSK/WlWEglLUOkPjP/Euhe0d3qtke+9soXGFfuwUfSiFqndGhoCHXhSBMsHSmVqEsj3LtqC9cE3yLlEtmHWb1mOtr8p1wT4XouU3J3+SSHH0WWwurH3Wclrkk7Kz9hygjVzG5Cy2TGTsnL2G8yDYluEJ6sWfZJneW5qTBrjQzSeGK9gZ+IMuiMDYE0I4UMpWUeqZiLw8ceTBqb48OQy5ttAoKMnRF9QJKw9EqGt4CprTKPSbUFofZM/Qqs9rQP
x-ms-exchange-antispam-messagedata: 1Jad/SKh5s6TtBmhMHR6lhsOK6CClkWu190NYx94G00cbXtjls54fVWjbVS1bmfxg3pO01EhLlfpi7zhEqETcTMCAC3JgPi10lwcnKsr/3X3w5/azxV9Y5Nfo9SchUlt5Tzi3m/LZRwum1Vl16OuqQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0534c1af-94dd-437e-436e-08d7bf5fa0ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 10:42:53.3608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OEdYSmgnDz6kF7PSYnS1/gZuhGEEP7Io3TvFuRA2u0I9E6BRb2YsbT2c2pNamYmZpyE+XfngrRfeyiXiI9fV5bWGD2GlUcdhL18VLlUGlx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3551
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Good catch,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
