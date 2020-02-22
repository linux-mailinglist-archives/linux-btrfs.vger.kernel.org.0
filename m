Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4DE5168DBD
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 09:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgBVIyw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Feb 2020 03:54:52 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60970 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgBVIyw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Feb 2020 03:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582361691; x=1613897691;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
  b=D3TSpa8bcEtT7q3czXLMdz653m4Zplh+wHdz49V2RbmpzbvaCwlRqZMX
   HIyJZOBSSI3cHdZG14llePZfrZ+GrwYHB/1uvUFGSd5cyjqjTC8v543NA
   7ylb0tyohBX3b8JcoUKKri83SxZzjavjfJiQsAVQo/6YMmG5Xbe0ugGpH
   Wk/wkCxEH0FFucBYAfp8QIMfbxuCT1MhW734d7h3c30UkYGd64t+smpkJ
   ABBMZCnvxIxBbNhzSoQbkgh2aw8HczcVF6kserzVg6RTBPgmUxJxIVCgO
   qfwza4eKtQv6KezGiUcEdbJVxMBxwJHmtx2lngLS9UeHUBpEQ39HFyYOl
   Q==;
IronPort-SDR: VHuN+G28vrjlz65bdI+m+D/nGWn1KbCS/ww5QMPM5nnVY+58zXMspMREsc10zihOS5TnQVsO9p
 pHPom5pzSUeB+wj6eWGiueIi5ZTzIgcaalepx26ubYbgQsTaah0q2GRLp+MlJgrj8xdaXFRrw1
 Xh+/a7LLuDMKgzU3yo4eXRdTIBe+r2WJlGqqmAvTwBjPvi9OipDwioZfakTVbw/Ot8VoLaQ6hG
 GtFngbghdNQWX1Q9IH0c3pb/uEKMdvdz9QZwbNoHjeydqAg+Ztpf90oWBe5trIb4bBTEScgZR5
 w4o=
X-IronPort-AV: E=Sophos;i="5.70,471,1574092800"; 
   d="scan'208";a="238577447"
Received: from mail-sn1nam04lp2056.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.56])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2020 16:54:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4EGDb+Yo9ol9/bCef+CzktIuj/Dn8Tn7fI6fPz4doTS9YSw4WTfP0EcrtSrKufManu/X01/Z4c/a3/vqyvQnHbKGk/h/Fx3OuDTzdPp1YKhaIpNrql0rwcOI9//6NKsZxZxsYxxJBkKt39C0h3CB4W8Vrt4QI/gzmMCZ8R+wG9aATLOhnfJ9OREHw9JblKnNhXKH9WXk5U/tmPgms9Zqj/FnKeZRo1b257P5Svy/p4B10QJ7nziKS1nRgD3ItiEGuRsHYfv/TFs1R6fNDoMmXzq+/OYMdS5mcs9Uz6Ml+YtuBW0d4v2FQ2UmvlhI/Z7ggC1QnzTJuimBm71qdO4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=jM65/bL973OUfCVzseSAOfFC6e07fZyZcznN2L94T5+EjZzPBTv6MVke7lmRSNUsn7r4CmDZJ7E3TZjwOhi6eh3XItMfoxuDX+APwTwY/0DLSB1pAQAI00vQcaD4A7XXYpKYMDba+RvfME6OHpqjQrnJ12aqbDhbM8EeR1FJaFY4RJv6WVO/aLvjR//72nYhFH2BX5dhItw9CfyW3QzeLNCMpX/zIX/uL63lFCvnDAIItVKI3wfTvRXAGSSNwuKt8HaAecVCFQ91TUwp/JdSZeM+NCnBSNLr3mpsbhjWOz8g+YrPpfHyPA3pNzQE+k1cPlE3U/OEuSTHYkCQvdfrow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=JHcSD+h1u5LYsYUF/TyR6t1XtAd+zabdxD+dgUIjHROTW1v9nhkJfVJvOwwKfjhW8NgW61esAaxQZKOr7XtaAYxUvbRXu+ewHqBVZaftz4FC3UdyrmnuYOo6Omxz3UTAMbgZoYlXaqdhpIkucLbnADWma6DyVuOLIyu3Wysi1ek=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3568.namprd04.prod.outlook.com
 (2603:10b6:803:46::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23; Sat, 22 Feb
 2020 08:54:45 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2750.021; Sat, 22 Feb 2020
 08:54:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 11/11] btrfs: reduce pointer intdirections in
 btree_readpage_end_io_hook
Thread-Topic: [PATCH 11/11] btrfs: reduce pointer intdirections in
 btree_readpage_end_io_hook
Thread-Index: AQHV6NRpw6CFLfVHuUuHiETGCUtJrw==
Date:   Sat, 22 Feb 2020 08:54:44 +0000
Message-ID: <SN4PR0401MB35988E38340907DB9C2A6BE49BEE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1582302545.git.dsterba@suse.com>
 <98513b19d5af7821e6e00eee4ad09b5aa5c76abf.1582302545.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [46.244.212.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c69fe93c-8d83-46a9-71b7-08d7b774dd27
x-ms-traffictypediagnostic: SN4PR0401MB3568:
x-microsoft-antispam-prvs: <SN4PR0401MB356833E059F30F23DC8009339BEE0@SN4PR0401MB3568.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03218BFD9F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(189003)(199004)(558084003)(71200400001)(9686003)(91956017)(76116006)(66946007)(7696005)(6506007)(4270600006)(19618925003)(186003)(26005)(110136005)(316002)(2906002)(55016002)(66556008)(64756008)(66476007)(81166006)(81156014)(86362001)(8676002)(66446008)(5660300002)(8936002)(33656002)(52536014)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3568;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rNpUhWcGpflEL96uaM756iRi1UgXsAOlBqpC4P2gbGyxt/86Agzl5DOhc9Bleo7V+gD3KPvAWm7ZXKkX1zQnw/kOyAc/tLIMy4XRVNI+NgctFmM9osNQ1m0udAqKs1J0FKXLx5PvMsJ+MQsaflAbmO4kc/XFNqty9ygtMSimPv12LAxC7BGkMd71ZNH93Ael8e3qg8Tk1qC6uGP14UHCRYqn3d9lli9VshWoLrgxdYeM2iYseNM3wL9Flybap7nQort8EexlPciwkGRXd/3QMkCOXuTHZGayk8M8ybQz6Mp/6RpdiJGQDBZ8FNzuZErhhYf4055V7GUdHmiru1G7ys69tht297ZCi4s7GHLMy5v1UpjA1aFhTOiGA9ixvGfL9Wt4+Ss3CP1VddPQl7dE2PNu98Y7A1IG87+rcM6JJ/xAlmVNEGZjejoKxRYaI8Fj
x-ms-exchange-antispam-messagedata: UR7inAURxqwWD0U8v9ICDZ9Bt9SKpQjuhMP7h8LqZYKVEHEi4f9Ir+6zt/0mu6yT624giDrkO+VOwG/B8W9GNkc/3CRBDRWpv4rYTJHX1OzTHjmbS23jY5D4r+BBYZitSj7HUQ2dx6CeRMIdxy7DLg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69fe93c-8d83-46a9-71b7-08d7b774dd27
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2020 08:54:44.9714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CPCP6Nncb1ThUz3UzT6M8xOvsiTIVc86YeVTpkRoTB+cpwpQeXC82HKe1MoHKqT3nJcdorsTI8wsr+IDYx3//NlIoGO3L7+YH9JVZBSMIU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3568
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
