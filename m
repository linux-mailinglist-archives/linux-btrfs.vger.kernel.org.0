Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07DE26A107
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 10:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgIOIjW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 04:39:22 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60066 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgIOIjT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 04:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600159158; x=1631695158;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=IRhSCODTJdrKFiO6l6lb7LPzh7aqmZkwuYBzzoK2aD0N1YWpCB17ZuWJ
   gO1IY24ToTTih+00DIkb4o/BCPzimZ8syp/l9kiw1beXZvpjL/9zYbLPe
   5Tf4bXqgia1TJa/MZ0nJeUGotcHiw3bR0v+ibi4Dx52jyrFFlowLdP+mN
   JvXtU7Bld3HAVIvnBT7YzAd6YIMU94NQ9+DUZJHIDaQWwybEc8pZB7Viy
   /y0z5OStiy3kAWwQ/i8xVwhnQeOc84nN+lqeLWesKYwr/vILyRq3fkI/R
   XlHrkdx9Lzi4MJpMHzimRmCwvnMmFiyGnxbm+rYMcX/r7kbrVka49UsM7
   A==;
IronPort-SDR: ZAaAQy3igJq0VnQly6nhkIxNdfWimDFeaAoRBfJVO/NkY8vfdr2eteSsTHokK2Ok49O3Yf0lNl
 bTciRDeyvqe1CkJqcXFwAMWr+PeW+KrC8EDZkgRN7l243wBu14Twc1XoTfMVl0pZvMWLFsAj4Z
 eWd2US9ciCzUR7KLTrIWy4xofgsKtbEDnHB36raYUFZPpyO+XWB3vUrMEfrSXkOi2gTkE3Mxlb
 HiOvCaMUjnreKI3kw3UYlSqLvosL5T9K5PxeSQxKyuAirnToHg4DtK/Ji0MRwrefLVqAeQ9DBx
 dUU=
X-IronPort-AV: E=Sophos;i="5.76,429,1592841600"; 
   d="scan'208";a="257044582"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2020 16:39:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEUvmEEvPqJrai8cKBd24rzp4YjRzTqYM3NQuxza3P4ONjRod7uZrLod7zRd/QsV547i3EJrZLuEbg3LSPsGTcYrq2lLq7HgUYyntGg60LlH1BbbLbXfmINQL4nAYmVqFYcTmr/oVRIfDCUx4AjKoj98kGDDhW2IoRyVU5m+cbD/iKN9jEHcQ1B3Om+q6YhZ24ll9kCUzXaGtZ5uS1A0MIKZGeqWe+9y4pqUs0hE3Rszcl4vFhe5bEZEn1Fqa4v6fq6D9LGuphyoV2yxQqcpQ5s/aKybqgz8u0Ju2F5pGqPRQYlF+qKaMXMlwRavSbEsHUn3SRb/w7fGcC4+ZNWd8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=GJeFCpS7lyebjs6rtgTgl43hxuhftX1hbgIT1RMrg1+PSqIf+K43JA8oMT0kq9sCRF+e3ug3t62j3K6x4tN72V+w9TVf/NV3yLnDaEIuYuME4demOOzlbA6CIWvQfx15NDUAz+InuJ0o+43nv6REKR5vGJxcJjpOaGuAPtr/IdlVGoBjg3PeaCu727HthX9FWiBPcOsDZDAFRVdjDyk57rkpNnyHQnRcsQX1xOaDXGN21k0XOSL6Z1kszB7++5jod7JYo/IfattUFPuDZ/VWNW9bF9vV1aw7uzlWjxDxSYJXodycjPAlN6zfo1CbI3wQc0wbFvIhwzKggb3VW5qm7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=cF9zTC/rZpn2NWC1a0HiIpO2yXk5rEKLlIZ8N+2lV48loJvHn5p5Imp19PU+fFiGnfi6BRK3mPav/QZ3Ysu4qUpx/ftE/d7z966TNue0TR6E+vxnXbzaghYg0E2QxuTvxQfIWCusfn5gcbmvNPwHZR0vUCghCYpBpw6WUXSrO4k=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM6PR04MB6459.namprd04.prod.outlook.com (2603:10b6:5:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 15 Sep
 2020 08:39:16 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573%5]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 08:39:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 02/19] btrfs: remove the unnecessary parameter @start
 and @len for check_data_csum()
Thread-Topic: [PATCH v2 02/19] btrfs: remove the unnecessary parameter @start
 and @len for check_data_csum()
Thread-Index: AQHWiyITDaTlzRzCCUqwTaUigsghSQ==
Date:   Tue, 15 Sep 2020 08:39:16 +0000
Message-ID: <DM5PR0401MB359188BA94A4E318D71569029B200@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-3-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:38cf:f1ce:e1ec:d261]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 82c8931c-a97f-4b8a-5c39-08d85952d4d2
x-ms-traffictypediagnostic: DM6PR04MB6459:
x-microsoft-antispam-prvs: <DM6PR04MB64592BEE1B24090296DE0FCE9B200@DM6PR04MB6459.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oGP7vHWOMW5q1tZdWYYenKIayJKdxyGFgPOJJwEPKxkDsWbRB3dd+BMNbFUpYgOoghWhcHQkaPFe0x7KRmklXtUHHHcOkQOMdyYko4NPSgBfwg+arHZWN6PDlj57LeYumlFNd1F3CVrmaWSRg1YJzGA9h9JahWSeBZsuNW/lxBki6JOsVyOhhKKBcKzFarDmjavo2sW93TkRFV4wlXL8UNDINBOkrb3k3DKOV5bteyh6baRz+WRMsVq2YsOOgIWSD/2aZ1Wy8bZO2p0GCAtS5SC5i8ArcWVDs3b+NgINPbm+DeBST5mjE43r1pC1p1wcRoBQ2jMSk2442ekf3SrSWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(186003)(478600001)(558084003)(8936002)(316002)(110136005)(76116006)(5660300002)(64756008)(91956017)(66446008)(66946007)(66476007)(66556008)(86362001)(9686003)(7696005)(52536014)(55016002)(8676002)(2906002)(4270600006)(19618925003)(71200400001)(6506007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: yYTN/HMEu6ABkE0siDBGlkCpC77phDuETLkgfqtQLfybJQaMdBa16cOcuYndy2q/GMUwHL/z2akZRtOJzxfF8+U2O5hk7jBlLUiIjYb964VFVkpaI4MbvjetFCo9yQhG83cSQTp34Q0IPTp26n8f1+WA856Yw+Nm9lyZFWpwh//a+1/fZXiscqFkWxq35FEHWWsOzJ/MoRk7SlFR5DNov9VY7OoKqogpUTbTZs/rLIvMyyyBqbyJjTQ2ok13wJ9QL7rpgVapO/rgaTuC4jz7drwgLZxmHj2x5E8tIKnnfDjdzIjMR1Zy4CTzvwiOC07UN4/XKFUd5KgHWnYEgkFoaxTP0frjIv3/Kac6H1LXe66q/BSfRDjpjjC85yaI3s+gREOfPhiMhgC565iBjM1mKH0hW9aYwPaG1IVMLRfBGgk9HTzE0uGsP59hZL8MXKcp2vUricjw53eEyAJKvwHD2Vwr3yXLagoPhDjK0SQA2YnfeZbe4RYYmpr2YidkBk0F6az5VBmWXaaIT9OYlb7+NTFM5pFqPGGEP2xUA89cBIOPA73Lb2wMU0pb/5CWTHjwc+scYkpoY4w5ZmiiTXIwzEb+DJV+Tcc47/9u0hBt5olqhCbhaLtAjbXjmQpJ6DDiNTQgFPYFXrIQghGWHsXWiBnIvjHQruMLXTceSxP/MptEJNWQlWtaZ6mRkpmnAAT3zMCg/Awxxc0ayxJanp8hsA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3591.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c8931c-a97f-4b8a-5c39-08d85952d4d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 08:39:16.4022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jEYA0I8a2Ylf3VV+9M02eMWwZspftc89a2mLrNL+N+kkrJWaY0/ybZ3JIRsQbfaOjjqALijALt0UP1qyUUsQny8xxdlaiWuHp25BcoH9Q2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6459
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
