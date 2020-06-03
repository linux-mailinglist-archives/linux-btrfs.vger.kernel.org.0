Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C141ECD99
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 12:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgFCKdQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 06:33:16 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1612 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgFCKdO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Jun 2020 06:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591180423; x=1622716423;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=cRit90LJPQncTKVofmRbmuYvk11PD5ghNoF9gsLt63Hpd9yUDYbH6B+H
   Rg/xr5HjjFeMfHb9SEhmAehVfDBn4S6hinqq/yowcDAOBaTnQC6LcfpAW
   TGibstmqNyVz06aoSsVGcUAgm9uELnXvIIT9YRsVMMsK72thjKe10V780
   eDTKzQ9EpQef5Tb6Fy8nLN41CfEiQEKWBEpoj2L7miY1VlU7sjdiuyOCn
   ygRQOL1/zwDKUOaJlJd3Xk19iW+rUvajw6CZ64qVWHHMRuhOF2F9LGygY
   pPHxdVeoOOMQtdtETOyMJZrtIvLN4F/iLL8KZly+QbwG2SomGiTOt48dM
   w==;
IronPort-SDR: JArkHyaDUSRZnXoK4rF3ewMVBCi5zc04CMrZh1SjT9KxA0hQEsatRRGY2j/QQY7be4fT/vHVKL
 btm/N9Xz0SPlCiVQK38dj1mq5UVMMLt/Vk1KjtKI1zMXPJvGGvkVevzNJgdvBY10aOQO/cVO8W
 SVIc+3JSb2yBd0jTrKtUJINnbmaXNkmGjx48P6oGLIo2UjL9yFEvjXFFI6dRo8FJbAln54X0Vo
 Qmox5RNQR/ikANHDAH84+zsZsVpPZV7vZfu7wy8nVQjYK9R7Gm/JF8lCJPNhsSF6JB17DpFA8v
 GPU=
X-IronPort-AV: E=Sophos;i="5.73,467,1583164800"; 
   d="scan'208";a="241963574"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2020 18:33:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkV45In4lbcM4k/HTvOdchM8Wuy3TXbzVc/HvKZowp7PZSMlnBOWT0fzaTKbJARyDQYmWq+zXW9NhiT3Qauu4kMu9wlhxwdavJBglGrw6TU86XksurlPYVRHwij5FTxIOMELCsZzhiLgf+euZydyIfzVJif2YJE6M9KWNZcXkZF1gezRx7KFGW8WmJM5qvE8qk6s0gXR61khJH4tGoOIyzwVuU+kQ7CDYeATt4y5NVEWtmHTy4Jfw8K8LXKqgdx3Ub8cn3bZBikA4PjkLavEpKzKHSQShE0WeCLuhpiRz0Ifkj6PQNLzMt1Bi0WlU+fjKcl/XqAn6dFCvAWFuyxwtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=lx5FfijtLUfs80/TpTTrMee9j3IBdmOemNnoqEaG1AC7Ci3bkl392F2YbFUk/HGG5OLLCtMppqiQQR5wT21CRo9e7AffUJmEZkGiL01QfQuGt0FWtmrhQbgg9dsNmMW/yWzW/PQ+EnuB/wTe+mVs7rEvq0S3usMs6F0eBFkytY9dWGX7qEqMWBuJtrXE5NsYQuRnArgWMGySEY56UxppqS3TVQGyEUs/2Q3fgcCRnDK5+kbGeTW/tB3J4rAh5yfWEByhRDlj7DEtGjR0wcz3e8uTGg4qeqDUGfstfMp1DkGjxyX1hIxeN4pJbiB/M0/NuK9hIYMloPHdpIG87TTBIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Xpk/6qPTAMiLWN8ASgJzyaFWDruRmLPupBIVKuaYVJhnBBjEzfWqac1b/vitpEC90AGK9BRMeNeC68xalyf2p1DP6DVflN+Koa79xoqUv+7wVVq8MF67mEHqQDInruj5MbpcpMNDkNVvpnHknhcWbgZOZ4SYIt0559toAXuqjP8=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3647.namprd04.prod.outlook.com
 (2603:10b6:803:47::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 10:33:11 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3045.022; Wed, 3 Jun 2020
 10:33:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] btrfs: fix btrfs_return_cluster_to_free_space()
 return
Thread-Topic: [PATCH 1/3] btrfs: fix btrfs_return_cluster_to_free_space()
 return
Thread-Index: AQHWOY9EURe1twg0zU68xT5C2XdEvw==
Date:   Wed, 3 Jun 2020 10:33:10 +0000
Message-ID: <SN4PR0401MB359861D2A24DF457607D56689B880@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200603101020.143372-1-anand.jain@oracle.com>
 <20200603101020.143372-2-anand.jain@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ed94392-1224-48d0-43a0-08d807a9836b
x-ms-traffictypediagnostic: SN4PR0401MB3647:
x-microsoft-antispam-prvs: <SN4PR0401MB3647E9EA2CC97D631951D19E9B880@SN4PR0401MB3647.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JApMKwX3JxZ9BlnAH7EW39+G7wW8mxskPUcRmYO5W1DfrNyZq+Kww+88+BrjyHDGx522vF3C9xJsmZl5UI92kfeg1z4bCQjpKDadgE4FvYnNRSF6axa3VfxtvZeSSKTzaE4BM0EzsrvQUZN4XQ5tAu4e9cn6hRblpkI1+tBSqnenXlkwzQiJz7zcx88BKEsflymvlXoCbZNOtvbpsDNrtKAhnR8fwCUjWeiz/MzmAajI+0VMEUj5n88R2sWwz7Ofe12WcqupUoxrau9Z3HP41KEm6Et9cvnhAMQ5iaqeAILUHfdilRlaEBMfzwmXBWGA261rVrlWJ5uEsXy7Z/gCmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(478600001)(86362001)(4270600006)(2906002)(8676002)(19618925003)(6506007)(66476007)(5660300002)(91956017)(76116006)(110136005)(26005)(8936002)(52536014)(33656002)(55016002)(66556008)(66946007)(186003)(66446008)(558084003)(64756008)(9686003)(7696005)(71200400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: q3kTPeuA/vg1BPB0mCV0NsNc8RE5lynOqN8fXpPLtCwp3To2KQnZNnOdwgOvmfjFYJQS9lFOTKi4mub4Bb2UKkrt3aWeGaQqKxHHNLajs57mNsuB0t35fkCoEjgEEaTvNUDckgaFtaoiAccgx3XX+U0+P4fv2KTnRzU/8H4QQJIveX1GALym3+PuhcNxsj66eYl7Uf5zZfNjxSsVI0CUij9VNSqO7K3haAxWbuR890ilbp9RANDzV1r0KNkY6QFaM/RCQ54iMe39PWzPzMBVyags6eubev+bhizD9YMiarCbq101o13Dp4NwRx4VWqSRUOINXFr2GWpVRaPv96cAodyPpyityYa9FFyBiEk63HLe/g/2XHbpwwfU2u3hO5uwOHOEe5CoNFtTI1DBhezUaLKFbnsi8sZwUIieVnqVXC0Rf1bNonndrFiB/wjIUSyDgktv4yJHLOvWgLh8zbiPIe269jGdDug2jK4n+LDLykemPEZzsHOqktgLoDC2C3Ia
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed94392-1224-48d0-43a0-08d807a9836b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 10:33:10.6998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +EdTLToRV+35kdDJLqdkGiahW3qfWquF2mjtDL6L5ogw7j0zGgjRTqEEbDoVW6KS+8Wm7B7cAk/OzhG4ld7eebC+Z1/PsMJn40IV20+iJMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3647
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
