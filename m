Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3229C172B51
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 23:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgB0WcU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 17:32:20 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:39491 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbgB0WcU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 17:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582842740; x=1614378740;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=QLvtCIg5PJuJB8IlqnUKPRucWsoXCFjvJJpo0QvJHP3sePfHgZDaaFVB
   ogcYsytNTyMr3ZbZMelT9Gl3CoWS4wIsSUx5cbLJbCfFSlPp2WTOaEpWJ
   GwecB/3ViR2tZxiLC5ZE/akLDENSzWBRDVRYMC5wZn4hJy+DkUlcIk418
   xNxrwVmiSNMoI4WnIxEWpkQmJRB5m62mX9mKuBe1/MtkaT51+7+UEEKO4
   6cSlbagdKDOOBbNzF/CxCttPY+nbedhhfAY/CtQiJuGjZXMWRNOs7smfc
   BU6YK/uF07Xp0mZ32+3WGLX3KXHDp5AIxLovju/+Xh9e7SvYoWJPN5j+1
   w==;
IronPort-SDR: c7DSiaK+QRH928qqqiku+gdTBeEcCbIvRYW3HOv0jAcjGaQOS5QS5UiGwLH5TF45zsqdT4GJIt
 VOncjbpm4TAB6M6NfOGXCjBA9sjWhDCRBpcrXii3jIAqhmz4VJh1wf/glx+zoDLCQBImifH00N
 zphd2ZI8I0QuuQcHn8bQdXV2X9OKP/vRNDB6QinL9zvGvC1Sxxsqsk5IHi2tRyInb4PeYRGul4
 ToxYj9Pyrzkg5sq/LjXst/EX/0C8MR/PYuOayzcwlr9/NjQUSpSbo8GWhak1kwO5JuZCpF1zX9
 wuI=
X-IronPort-AV: E=Sophos;i="5.70,493,1574092800"; 
   d="scan'208";a="135345476"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2020 06:32:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmUoy0HfQksCIHqUSZpeAatZyTyZfZe9H3u3PGuT/7XMfhNUMy82Iwieq0dVjbr8tHsZ0/kfyMqf/aZZLwy2bW7LoX+YQPL9G02sQWMo4APg199zCnQpNom/4KSWzb7X5//7pdfn7oYsuJZrFtg4KFbCgrJ2wLkbIaoNIVq8BpA1hGPr3dPMFT0FaCmbX9Z3jMv+jpEm+zdu4aoOyU90iMWFZJOofsthrmnslAOpOZ40kJB/oj8Dux/yb5YZVPnLDHKWYOalizmC+XdISjgLjcU5if8x6eBYyBvV1uSyIcGSFYAHYgl/Q+3B6DarUZt9BxGazPCgHlHT9H6wSmXxbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=dRE0FlQGltOl17DUOegDzBzxlYA9A860a0Asd38xifhurVv4yo745NW0r8rMuEOpf0EgFPkWJb+T8OZgFAFzTzjSlObjgdbteaZ2+1LFduraT7nnHa1E+s+aF6KOgc3mduvpk20XFm/VN2ahfNeUlaXMD/D/rdcLv6pDywNeLtM3nuGpQt6sGDOjv2ycnUgFXJ+2k1nXn4EwyyCTC0seJ1e/jwSnU7agaQ9p2izbZkyoiDTNvfgCPFnCiRJiR8rZxbLGExe2aDSM4wqN4RmuXDYZSCwFZpvavqOxYL9Pos/nHfuDjfvSP5DHowuNaHKzsZ9349l0dqTsUUsybzm5Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=A31/1Q9p26x8QugYXle/TGjm+V5R85cG4fykf5WoVakJByxMjddF1KoEzuAQ9gGhX1IhLk27xlIAmC2Gn2wTPurkbSCd6j8h7BkVRIMJPVq4giqGO76VRnPsNIWw2GuUeNBTS/NjDBksQw56T+bDr+hIdrx0woAk2Y11GQiwa3s=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3551.namprd04.prod.outlook.com
 (2603:10b6:803:45::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Thu, 27 Feb
 2020 22:32:18 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 22:32:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/4] btrfs: return void from csum_tree_block
Thread-Topic: [PATCH 3/4] btrfs: return void from csum_tree_block
Thread-Index: AQHV7aitdrAMAjmNTUuNCVv1oO7RYg==
Date:   Thu, 27 Feb 2020 22:32:18 +0000
Message-ID: <SN4PR0401MB3598C270A54B11A72476EBDC9BEB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1582832619.git.dsterba@suse.com>
 <c6518711b16ccd373084b8df681db41c198cb1ec.1582832619.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4bdfc18a-d3c8-4ff1-6847-08d7bbd4e74c
x-ms-traffictypediagnostic: SN4PR0401MB3551:
x-microsoft-antispam-prvs: <SN4PR0401MB3551D71009EDD3ACAC5255FA9BEB0@SN4PR0401MB3551.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(189003)(199004)(316002)(7696005)(5660300002)(8936002)(478600001)(4270600006)(52536014)(71200400001)(26005)(6506007)(186003)(558084003)(86362001)(81166006)(2906002)(8676002)(66946007)(9686003)(33656002)(55016002)(19618925003)(66476007)(66556008)(91956017)(76116006)(64756008)(66446008)(110136005)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3551;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C0Dwp7NjRUq8PWB0vOQud/FVt1f7yb3G0gPZR4I5yolrTa4hIK96Oz7GtaY7uLkiFiUc1/4kvfZd00WYTdi4fMUFsC0aMiwe+s/5Tt9bHEDA2Ak7S651j/Qqx+VtQrQ1VUZqUCTMYQ83IJ1wWN9ZAvrVO11iQCEEaG8aNijvwVP5xcusNNBbYgjOURTND/GGkjOHi/waovz5w2Rb/F9p75vpTj318m/up1Gr15UGJH1lu9ie/uMJP2GAkRuzqTkyUrISJy92FZVoyyCUKTF7gT+PhgMDbx3ydwJjPGzUc1KLudNzKRb56XHZYgfiPOjAw5/y/UnPmpLbA4bhWMNTpilF8Zn2j7qCllSr/P8Zc90IWJCrEOWO9XTzDi4Gt/Wtw3AljKY/D5C/puAVQGPM6rkRDkN66SDMDRHEJSiARa8NXF0Oaw53gTvhIz8wqDSW
x-ms-exchange-antispam-messagedata: XZIfMQmz6vQFU0Jew4dOxH08clljoD/xU4bLHZDHDXIVJw6+FWB2yPFk7vQF8Tuf8xBFsY2jQJzS1ZbOO/wQE9mNGqZVyi/+eWHDRYPC+Pe7d1GwU44ueo3DW38/YglHx461fEZELjl4z16sAcOPaw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdfc18a-d3c8-4ff1-6847-08d7bbd4e74c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 22:32:18.3250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iMFydg87Yg4K49BXHqQCuoQB5mbU0A1EOiQ0yE/M4ZwM58CzGb+uwsvl85mfJx4TrmixPzUkPSlL8URxyhvE4gQhj2+y+Rbb3lcj25Eds/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3551
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
