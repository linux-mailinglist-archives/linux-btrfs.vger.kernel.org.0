Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A114B15276F
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 09:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgBEIPH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 03:15:07 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46982 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgBEIPH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Feb 2020 03:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580890528; x=1612426528;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=CMEc4gl+blSJcE5/B3OEXL9bGKgzPAAwN8NEnTfnyQ4kxgfYo4WgXGWo
   Lq4jlk38QqrIVfgzHY9KvOWtSTFXS2PbaFIFicxTq7SLp2NIWZ07LaagR
   X0KeddPecIUUqnd466U+X83FRt9Jel4o9SjGNGh+O+domVBJ0rda6CpCQ
   EF/k9wq8dIMSME1sPWkjf+BXEGg4bjToKrh/gPFccvPnUpGJ0dp3sw3z3
   1KmENZHWla7ryP6bYTq9fQRVVVxoqbciRoxlfT5V237a2ydptRD8TAbNY
   33CCevV+sEI9tf+00aGijQJ8tlOsyBub91s36i6/PK8K48CYczL53in5j
   g==;
IronPort-SDR: ySn3s3wkzxPz2Q6VrXp8Q+kIAUpP/zt4+nBYQ5rFZ7iMOt3qkAQCzdxHPMLnn7unVDOnb1GiTv
 nOdMMTEbBv46qTAE4u2vuqXyraAAD2XhUTHB3M5TdBz1ZDbKLfi22X5Cox7U3FMfl6tevCjlqG
 +8830A0CXuCLzjNQ1RBTIz1CSc+TU60fTKpZg1bUTnGtNajJaOeuiujwsS0fS6q03/+BDsQSGN
 qXnZ+fhTznlGmA08CzlUCMOo8vD/+UdpNiVGw/fjBVuyA7zW4+qCzLQ+3/HnHIvtqH3RVEzP+Q
 Ezo=
X-IronPort-AV: E=Sophos;i="5.70,405,1574092800"; 
   d="scan'208";a="230876873"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 16:15:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ex+iJew9Oeznb5cuaWiUWs5cY4YWFkiB1xTIacHQ0DtE6DRy6fsPDsceFo6jrBvpYrKt+chczN10+Jkt98OTuiJzEiVvU1eca/TbTJK7xHzLL6KbV9ZJ82p1WeUi7E9/UEI+utH7yhYwetpFCNejdR9VaL7LOJFIBdFXg/aFNbVKuSNseSBi4GiAUGsevRREm/EaICJ9x2neTtawzjzZtecWLxPy7qxOm9Il16o2/LwJyqnuuzAXB+eq3gp1FoVhdINk6bCIxK96obs9uEWfd5lIffzFXnyXgvs+AAmVGKFlZtRBSpIunoZfdpCV1Cuyz6N6KaTxMLkROSxL/cUfZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Bs0wBL99/oP7qWWQ8tp+b9w+ReXgvx8xSTOP/YbOcCGLcLqdXn5q4zPa4G7mj1cQgVTShZ126y+9lF7Te6yaZZzh8l0i/Ny3ZBTzijp7lGGg9HTgG6rzEPBsUaxL+UI+EWEfx7YZHLZy2adqIYeQQVsl5yTTky2QAQW54nx0UjGVSPCjsynrytnX8K/gQDSVNlg1sNGQ3THxlhH2wU/FCJBpn5gl9tVtvngk1nbEvT8hZlsS45x+jYSKsGHb+kQqMrBaei8c1gGgPlAC4L5LIPp2SESYMIYIs9D8mZF3WbrWiqzWJBxFVJoBr76Hp+8Sk7x42u5yggVs7JnDN+aRWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=0B8GFflDqUeHu2LpJeNwkpWHb38nIcorLdo6KpXReUqdz9NAbMKpTLs88LyECvYYWCR3AsvclgFkChWTqfrxB6D/Hqtbg8zYf61Rj2XcVEgAwbjj2fXyVp+FBuSoac0WcRHkYRKfMxc5vYqlJn2zfOm1dmI9s0h8wt5+jI/zLsg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3632.namprd04.prod.outlook.com (10.167.133.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Wed, 5 Feb 2020 08:14:47 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Wed, 5 Feb 2020
 08:14:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 19/23] btrfs: don't force commit if we are data
Thread-Topic: [PATCH 19/23] btrfs: don't force commit if we are data
Thread-Index: AQHV23cJkVrPZUk6j0Se5EPVYA2b+g==
Date:   Wed, 5 Feb 2020 08:14:47 +0000
Message-ID: <SN4PR0401MB359814D57AAEC769399E4BA49B020@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
 <20200204161951.764935-20-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2be7b67a-1b9f-47dc-6666-08d7aa137730
x-ms-traffictypediagnostic: SN4PR0401MB3632:
x-microsoft-antispam-prvs: <SN4PR0401MB3632BE1BF8371DF920B0FC929B020@SN4PR0401MB3632.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(189003)(199004)(19618925003)(2906002)(7696005)(26005)(71200400001)(66446008)(52536014)(9686003)(478600001)(91956017)(76116006)(55016002)(186003)(64756008)(66556008)(66476007)(66946007)(5660300002)(86362001)(81166006)(8676002)(81156014)(8936002)(6506007)(4326008)(110136005)(558084003)(316002)(33656002)(4270600006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3632;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eJFYJNHdSGcNCTkEyPzrSPH1mhJPuiVwux2O05oD0vArAO5KgvwzCYaz+/6IaIfcmG6Jlg6VHudUG+jl1APrMLQKzhPOXmktvVL1gZCSNnUac5K2FSXKL/1o3CSOm90hzHM1e6dGwatZCMbMDwZnfgEzLfs/dddiryH0EvDlvGqCNX4at5/R8YIUttFaU3t9RdBYugwjX8fihdQFPWYBAUNHRgXUoyzKsqWizxH2EE9deqd4dZ8bNF4QSHVEw9GNYxrzUQw1TIKpqX5XzM8dCuRvanZGsH8+3Of0UuRKm2A0OcvF/u5curUT2O9HC4klleStWnIGsVwSzKxIXYQ2cKOMNZCAmabFwKatGR/XPmRgtqVbZwb2wTbnail9gtN89lkgKfwWFB5tifM+w3m+vFSqMkk8fVbEFTNMJ6h/FKpotF4IZ9xNx2xqejTp3k5N
x-ms-exchange-antispam-messagedata: yedglDHEkxgiizD4IpZ3YaeerfQ2DaJKGtDZ73WJstowSHtgXnK09eMMBN2wfK8KiWWVjMV5OXtojJe9Jbiu0jItDrUy4DfByhFeQrXVfWKfxwAlqGp7xiyLRQDGZ3RBAi/Tabr9xByxdIaQNoy7vA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be7b67a-1b9f-47dc-6666-08d7aa137730
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 08:14:47.6196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CzsKu2DiVgTKQnARKMaasndAsd8e8R8VcoDReTVYeymB95Ik4n/bAaKC9m+DZH07oeezSU09meSC2m6D8O25VbEmvbTCzG1TeS6AYHDmJ9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3632
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
