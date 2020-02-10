Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81ECB158070
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 18:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgBJRFx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 12:05:53 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:48942 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbgBJRFx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 12:05:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581354353; x=1612890353;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=CuFmzbTlDqG4xNfyiHNGIBmEhJrhIY/oCpkXrOcXGRTPKmRW7JFabeYr
   LBnJ2H7e7WfQccP2UbXHNoiVncej2c+IWlfF3o+PTe+qRhVUUpw6NHIW9
   w4j7ebNTTORx+ywB0Z2zwpM5dcEb4rhP+TB0704ttdbUSUW2Z6WSsFXW/
   vtdu1tP6p8HMsENS/S6cfxfKaVPXrrF72sSzo2DCNRF3ksGscymYS9uly
   afH2cAa4EXaiTclU3BG7+a/+zQTm2dwo0r91am62b28zQYutM6kUGPz4Q
   Lje/60k7Zk3l1OFJwykFbSzZh9HZb93anSePRU4w0/znXmBoHciFbQ5J8
   w==;
IronPort-SDR: 7EE9Kqht61SOibyRNLjRzlifDYAJkHqy/zB4HrNFAHZXzdSAeyruHiFy4WB7/TjpyFEpFu/0px
 NrhlvWYAwVLRMlVCr4SkOHZYLLjg2J/cvxESMSct/GNkaPa9ZhOUabUpfvS8V4g1oI8TqtlIcu
 XlhVZaQtfUNnfKxCV2nqtMsjauO+WE32ptycBoMpyY/KfCeU5Kgd6OEY+G3xG6O1lhjR93ETsN
 hBPFqKRO8AyCuaG0HMoSP9SRVSW2fpxD91lQXwWaMwtBbvvXRS8Ja46SXzf1CxSow23z37vR1V
 38I=
X-IronPort-AV: E=Sophos;i="5.70,425,1574092800"; 
   d="scan'208";a="130057949"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2020 01:05:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fi6y+lE4J6BICY4PeDB2D0qzCIIsD9d/ifxDDruK5pXRT3x5MBEX9beXfwDoALQ3aWPRsSXUidB45y8No5cikKvVdc16U+ftd9RUczIEOtk7Uu5DG1tnCbaQcjUoKvQ/Xx0bpTyb7BZuBn421Ee7XvZny43iuW/q4XYOvIG3qAqrvtC7/xAmCDiIXIPIrZ/zz3CsYov8yh1+lzdffSDiiToo+woAxItDbxTVE7pQdxLdhk69C1fAGsjDEdl4VegwXhLF5mAhSSdmlE56WMtncfdYyULZPGkLpfj2QHzj2eT4wppM1NTeS0mke+CQBk8q4oTMv8ga3edShmOqONPWSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=X7cBGyFL3h2vkG61vuLDYyx/JRBH9npQCTDeB0aaJZIAp07AujqLNUZ90rYwxyHGL9g+1/0pu9uxPUnRfdoJuxjFSXwFtyFfWpi86QW3BwIlQmsEzn11WqKyXQtE3UFacC4NV6L8YTjoq6A4maUgd/UuGAw4e9q6owiasikZe/pu1EsfO1Z7lImVw8/w+vJU4dXCftccMSf76k2ZlZbn0/ZUk2E0wxjMYpuaZoR9PeA296xOvENwbRahxP1yLUAnbN68FvufOtD5Dy4c80WZmU7MClMfp8oVg+Ed2vIIQ7DZkyySH2Vt45h/PnvC+RrWtIMfALHg8LqTyJIZAC7Piw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=c1HBgfrvlCIt+qMIDApg/fHnOIH9bzyhxflHwSlb+kVznrZMPdvjsbah5/txCYsCk1qVA/nrZUVKJyS8Cg0Tm6txdHKyX5g6WdG90JE5oCqOpEUMqfndyuehzkFh2q0Hel4skLkOFzx3alkWmo7/ZcWvUAwRbM5tuifVIui3OdY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3615.namprd04.prod.outlook.com (10.167.139.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Mon, 10 Feb 2020 17:05:46 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 17:05:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH] mkfs-tests: Only check supported checksums
Thread-Topic: [PATCH] mkfs-tests: Only check supported checksums
Thread-Index: AQHV4DQESvjPrcY5fUCyv4q4HuOWPQ==
Date:   Mon, 10 Feb 2020 17:05:46 +0000
Message-ID: <SN4PR0401MB3598799A051F215E34196D1B9B190@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200210164300.14177-1-marcos@mpdesouza.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7b857a21-432c-41ca-3a46-08d7ae4b787c
x-ms-traffictypediagnostic: SN4PR0401MB3615:
x-microsoft-antispam-prvs: <SN4PR0401MB36156DF6E42064ACB6B697749B190@SN4PR0401MB3615.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(4270600006)(110136005)(81166006)(66946007)(66446008)(71200400001)(66556008)(91956017)(86362001)(8936002)(2906002)(76116006)(33656002)(66476007)(316002)(64756008)(81156014)(4326008)(8676002)(558084003)(55016002)(9686003)(26005)(52536014)(6506007)(19618925003)(7696005)(478600001)(5660300002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3615;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UvwFnkygXfipnuHnZwlXnuHgE5FSiZBqm7gOfXVAocbLVWEEx0c/lZYRdy5ZLZGzaEvsZG3GJrq0K0PkXIhhGY5j8jJNkBHaNquaYkPfbxBvrbcYZ1pGGKzwXpewIYp/brEPFzyUThwXg4v+N93XeFaL0jB+R25dQUPRlRjT+dinQCBqEu3kiAzGtX+2PU+sRcYIoK0NgqvsQXCaxQxSw+rn4e+SFonCNTw4gcZswl4mUqSWpr0RafFZ03iiAl/rwobzzYvEbSfRO0/b1X67ugFdQtSZeifdWn9mPyXzM4GIwD+15yFiLO73fA3JRQJPhflYcd2zzDfI2mfsUofX2xVbXmhyhZRheIV2zoU0tbt42yX0ln0+wuY1d1IdMEUOV+Sj14w2tg0I1dyKcsfwBEYcxgvsFcFnOkpZEF6qfbSn3LATp5ej/SIK0invhe6n
x-ms-exchange-antispam-messagedata: vOnjJgTdsjGvC83lXvAjHZZdZqy3gr1keM8oWKqSfnQsyjYeWVMUFxlH61dquOewO3TKgjb23P3+ip/+K8dUjY/EBkfO0mXHze/gjUA3D8iKkg2j9uapJGR2VaBAcpKY0mq4deK2BLcrybWmtOTGDw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b857a21-432c-41ca-3a46-08d7ae4b787c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 17:05:46.2602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZiJOPQqVoH4gAZEeuYrcqJ/TkNcZRNVe61iBpSBN6NMdiWUFtI7gcJMX1Dh1P1/IDSwsF/o7a5xlV5uOYbys5jzowoB/9pfdotOjoyzYofo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3615
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
