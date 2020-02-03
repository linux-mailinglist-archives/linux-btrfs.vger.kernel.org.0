Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5FF215052F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 12:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgBCLYm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 06:24:42 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:63821 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgBCLYm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 06:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580729112; x=1612265112;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=rXICATGXOuCXxkFnIZ84DMLyNu4fLIlht6lRVMuRgef70RHQt3FpZH3V
   TXaCSh4Xk1mlFk+RsSxdiji2ogvZhJzdWmIlN+xSoSkxNP6RR8VmfE2Ov
   ASzg5b08NbpLGTxuqtZcgIjK/bfenIJydXzs7KvKGaxsQFgu3oTCX16ZX
   YXFdxzF/ktB92FJdq95RLEtFC84CHo8m+cZG79Ho2wmC7xamIgcQL1IxL
   m5eXFKop4hlQJh9KmbrNFHJbKZaKmp3eEomO9329raslpelY4wH4wfdkl
   0Qd6Tsjxs374mzz4O/x/QImDDfOLajQ4sW39EEAE0RHu0ibJPtdNJsnLU
   w==;
IronPort-SDR: RTdBH5v7w2lZBsQIieSs63xSOPiYQafRrS9aUCKkhSJoZfQNXOQ7+fpbOHMZdK9tYD7eOXU2tm
 nE8RcUlYOXpDdO85TWGYUOJiktWGj0siq+ZUfjDi9fj0Dle9NVUkoAvJiA/q0KWAPaFiDBeqJ/
 uHXkdymSDcXH149oaDL2z4QQ8yW16OD9lLU6t4K269nJGdCzEEnV472aizJdCAXtjjZ8NjPoFi
 0Y9IeT2BWSOt1m+wKdddjNsFIR3sGFGgjuxCEdlovhEPU8c5SrIvjis/HjvSiQLQ3N9fYJWMbq
 fIY=
X-IronPort-AV: E=Sophos;i="5.70,397,1574092800"; 
   d="scan'208";a="230705071"
Received: from mail-co1nam04lp2056.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.56])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2020 19:25:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPbWy4Al9OpuT9qGUJWoM6ivjH0fTQbXgHC7SW+L8Z6oeCHHxMxjsXnfXizKwl9qNYRw2cSkcEjWdLMKn1JlYP0qwai7hTlbojG2wiKu8iirPhmkwGENvBQFm3kbhbSs5D9Jqqb+/ayRvzC7OTlWKqXGaAlG9KqWkGy5NftQJmlDPAuYcB7Hn6UhnGKTvh0DmhS6eJqtokQHkCmovP3YQ6/SkEYY+zewCEZFg2RJcvM5QJLKrML+2+1cyLbNMHDaJJX/ZGwp6NZufzhIvTjcjej2JeGs34AcKw5pOypuOlPy2sJtdXJuHufmF5a750WhscleTYVzed/YFk2R6wCxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=jpGcI2XqCe7/KPpttE477BqqvPYpdP4arKmkcjGib/DfuXuppTw1bj18FRAUJ71fPSNLOfx2epn+tU2VCoDH7T6TL3I0KE0bCAEeAr+3ka8mJ7qXxzSw9Kr9G5ZPL2cRaNpw1ApqDsTqbL2CvU3JIv8KhDwXkqvsWDhKNsGiUMxBV1L4NiQtbDZH4F8Qk1YwEwlT3Yt+/+OxowktQTZEe5gogWZHVpOEpl7+ZYRneCy8wZI90luS+ELqHYzBS5newjouXZ4kROyyoUAVABUNkmzg33bizxsaCkEhKKRRVzJ14nnHpVzgAK9JecOuuLGBfipEJF03GbHjDsdQ0z59uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=IcGkmL0y+JEK2hQyiO9l/UmjYe/z8ci2bVS0pmpC4cnea9Mu4JaUR5vX6NarN8XGlxj0f9KocCN9FP10rFjuqprx2w4t7g7RmqKx+gRfzFzzgokVf2F06pBkXeRuYvHXYL5aAaMZcqVhc7bD4LFym2nu2T7xiPlErG/lDNO6Rl4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3567.namprd04.prod.outlook.com (10.167.141.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Mon, 3 Feb 2020 11:24:39 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 11:24:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 07/23] btrfs: call btrfs_try_granting_tickets when
 unpinning anything
Thread-Topic: [PATCH 07/23] btrfs: call btrfs_try_granting_tickets when
 unpinning anything
Thread-Index: AQHV2IbzWmqNfUrhq0C35RxbOpzAMg==
Date:   Mon, 3 Feb 2020 11:24:39 +0000
Message-ID: <SN4PR0401MB35984A135DBD205F7BC552F49B000@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
 <20200131223613.490779-8-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00e0f145-13a7-48e0-f2d9-08d7a89ba82f
x-ms-traffictypediagnostic: SN4PR0401MB3567:
x-microsoft-antispam-prvs: <SN4PR0401MB3567D371A3C096CCC5B3D57B9B000@SN4PR0401MB3567.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(199004)(189003)(19618925003)(33656002)(86362001)(186003)(26005)(110136005)(316002)(7696005)(52536014)(6506007)(558084003)(5660300002)(478600001)(81166006)(81156014)(8676002)(66946007)(8936002)(64756008)(66446008)(4270600006)(66476007)(66556008)(4326008)(91956017)(76116006)(2906002)(9686003)(55016002)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3567;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JF3Yx/pXERFzkdCBTJHZDcUYQxavEkdJ160MygJuSsDMLjm2t+rQxBgVED8BBq0zYMJYYv8CMOke2Qq4Mh1HdfN/AOBgXzKNPR3LwExRolBNqC8WE9MaBZtCE+RNSAe2amETpJd8j8mAAaytLQLuMzQfPHorKgX0vJCM2ymaeY8bqGYHVroe9fnUm+Haw22hK970Nkijz5SeHFt3wdvt4TBxdzZ843FcHrdQX0FtWgtUP1UD/gvTJ369ItijUA8kF/N35odxM47NDZsg64MLg4v/f2CxcDLasTfjntOrIOy6Yf7ikuRmRCyOhoqz0y0wOojn2gDZy/C+dOV72h1R7Wz7uQ0tshp/imV/0KK7oAHJ1VTH23QcmhFOmP9cYcl+S68t9DiObuDN8GwGDELjJLA91tp+m8lVSrmCtbnPS5RJgpzf+2gdhEpPPhVY4fnO
x-ms-exchange-antispam-messagedata: TjMOx1ahrX0TmdsRUr45vBBwuv5CbI0iwKZNiqBdKPqJzpkW6wyVs5kcnULSexkffzZM0Vkmdq2If/WvUQmxvf+i+Wl1PxCIEqRpBXFVtkZ075Ne1hgkT+aFeOfv51gyXgZ6EnGNoHCd0QUvVIpFyw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e0f145-13a7-48e0-f2d9-08d7a89ba82f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 11:24:39.0336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BqYzN46EwMtrSUWsVjxp4uQ++Inbc5jK/zzB4btMSs/ZTNzX+lYq9c67wZHwfYxBlazhIGDQpaO7ww/QBGP2vB1xgzTch9h/Sg8dqUDAD0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3567
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
