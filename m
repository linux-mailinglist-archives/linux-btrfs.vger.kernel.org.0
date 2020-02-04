Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F114151E6C
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgBDQlL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:41:11 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:22445 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgBDQlL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580834470; x=1612370470;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Vek7y7cP51Q21UsOQS1G+Rof8mmixBt4F/JUmEPwY2c6N8vLz81SFcee
   JvdVmXYWTfxy5uv4aWMdyundnND+/Y3Nh/qSiZ/dQozpmke4E6QJZik5z
   kqhT/MG4Ct2RDRdoyGr92dYj726UFsTCPmfzHknNv+OB6gZ3MU3o2eRky
   t3h/2vOnoXpnS/6V5Rp0IX3W1vwB00z+j1SFrf+nPkc64eus/bG0wMwui
   FgfImCQjD0dzTaodTWgngkvQybeM6kjFvQcelRX8ZcO1jEsyLZ1I5PLh+
   L3pt/wFwyDnDUW+vq0kCoMeGam4XhzrkOJACs/Kc89T9JxO3LFC9M+UY1
   g==;
IronPort-SDR: n1Xty9bIm7v4zp2i02KS1FAZkXQRKHRoHARshSggyzcY3bxSxXJaj/SFbHlnS5EFDOV6iLq+pB
 HUOIKP60emY+a/2YQDaOlA6YqMN8SHyuUgs9Amfd9mVRrKqGOj0jNq6qSRdbBjpSgqZUKC+8lE
 tl8VkfZI7sBpPzCiGeOKqr4p6xfnzUyTDcPaTxLKtVXWPsjesXRD0WUdVtRfoUDBMmjIuYMj+K
 CslKzejGAGS7ANdYcel4yyGxQutESFCIHhQ+rgg1wezhRgN7GW/BFSCjaCDWg9jCs9SftP6Akw
 /vE=
X-IronPort-AV: E=Sophos;i="5.70,402,1574092800"; 
   d="scan'208";a="237038823"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 00:41:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLYz3Bdy+HLUWlqtEQeQMpvSBZUFZZCuGqIh8pbTQ/FjQ8aefIiPzyrRp9oAX9cjLwlNYNKhlSk8NmoAVc/UpMayeQgABttt12KwgzOX6NicmRngcaE8+UIsCZc40SVADH7HPd46TDK6eS4jsj7Ya479Z5fv/E+4PTojq3RwFvarxyF0b6IDZuu2iR6ZyYlNOEIhh6PS1GkGfLSTvzz+CMTjzm6U5bG2JYspYzhdxhybm2Rw08j+8EDmL6wnlt4h6dWhBXrtQ7zbIWrxavYpq9K82f2nlEAXpS6qlDFByF1gm5BrDTLEBJqPG5SEPnn9HscvEyrXqLPljx9SR+7gcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=FIpXW1Ig8W/s5cWsFWilKjNLC61bvfH0aaKmPCUot8o28jPmnzWONEH2Ol9r/D7z7jyKJzZwK4ayXHkJvruPGvkKZw2ODlpQP3le6Zs3WD0w30wVOtb2osCGFY4lqDz7bvw/6Bgbe+OWepQi3EJ+4r5G5DMfTjJW4EGFFklk6cKjELbsd9TSFzTxWS9rv+475cf+JVEy2QpksSeC9VcBWMabU51MnWzkwY6p0UlLWd6ityfPlN+ij6TvQi6ZXpgnj9RK9tX3e1ziwSJvlNNOWU6IglxNnJ0GD1hvIenvjzygCjyZ/DpSgWsYibNu7Tp/uh2vmFzKT7+ks0hfqlnj6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=x2pM4QDrDK2yQdbJxuQ6auComZQmLy2lDdsXRUO+eXfoYQgbV8+8f9S+QZ/jVpWJpGYzc7DR3Nor3TArQVAxk0w/scBGDOdpePGMVTQNmtuVZUpVlUymWVozW0yb3DmnadE/HM24YfbRI2JHPrmXameHAmHoFxfZ8y/hlwGOq9Q=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3550.namprd04.prod.outlook.com (10.167.133.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.33; Tue, 4 Feb 2020 16:41:09 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 16:41:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 10/23] btrfs: use btrfs_start_delalloc_roots in
 shrink_delalloc
Thread-Topic: [PATCH 10/23] btrfs: use btrfs_start_delalloc_roots in
 shrink_delalloc
Thread-Index: AQHV23b9kEajq+h2HkaxNUuU6fXasg==
Date:   Tue, 4 Feb 2020 16:38:35 +0000
Message-ID: <SN4PR0401MB359804FC94A023D6556CB6429B030@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
 <20200204161951.764935-11-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3cb35cf8-4e48-4bb0-aff4-08d7a9910973
x-ms-traffictypediagnostic: SN4PR0401MB3550:
x-microsoft-antispam-prvs: <SN4PR0401MB3550E0FE633A2A616B1C5F8E9B030@SN4PR0401MB3550.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(189003)(199004)(76116006)(52536014)(8936002)(4326008)(5660300002)(2906002)(91956017)(66946007)(558084003)(6666004)(86362001)(33656002)(110136005)(478600001)(316002)(81166006)(186003)(81156014)(55016002)(6506007)(9686003)(66446008)(19618925003)(4270600006)(26005)(71200400001)(8676002)(66556008)(66476007)(64756008)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3550;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NFuNrL11QktiAVKGgkY8nGn+XfZmEtjzjZ0pI47NFSynAAa980UWV2ANrcNraGWqPBXMa6Fef1yDwhZjetiCKnjYoNwthMQpZgHkknZpqtuTl5H9vJaCJO8fL/Len85Nv/S7b1u71EkQ1k6iy29bfuH63XDRewcV88c+6PLSiJtf+jHLY5oKFq1uwnqdYnjcBELFxVlBU605L2PBvwAqzq6b7JCkRCuA1JrozHojbU7dDlnPxPvENRIwblUVirB3nC4HTazikBuKV4bWv0fwKfSaDX3uH6Oyt/DDA/OrzguD6ZBXAAFZl32mySlnXA0C1BCkN720HfbtCOfSfo4aTkLvomWqzBZh3WJ4N3TAkYuMnTM7HUtqJH6Ylj6cS3aVdG+1YeuFTP3+rQORXOP+hspJN7r3V+lKX/T2uAw3DtN3tWntIaxGGjmx2fskq0Qa
x-ms-exchange-antispam-messagedata: octONkkvU2ntteNOBkxE6L0/q39sBRayQNIGGSZQHsvCu1RZUM3mgRGQlfshyv6trW1Rsst4FWMdfPg3idK+pN86zFxX9IQK2dRPLu3hbaTAPdJybal76AQ/wEqJ9vwOWC3FSqZQbDGqwEolIejjsg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb35cf8-4e48-4bb0-aff4-08d7a9910973
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 16:38:35.0453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JsECf6mXB0+8XehXt7S1+Ka49jmsN0+Y0MIvcHOW8UEk93fPptTdJt3KNcTMLA6UrPqpyLgUNsrRkCa7aNRzMD8CtnPRpw0m9aniywcP8sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3550
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
