Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6413928B312
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Oct 2020 12:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387833AbgJLKyt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Oct 2020 06:54:49 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:33544 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387774AbgJLKyt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Oct 2020 06:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602500087; x=1634036087;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dDDGQYe+o/+n/c4ov4wIahCktUu2C4ODIOFUcPuQxuA=;
  b=CETnRRdSeOcG0axDTgtyMNlbiC3zVTvm14ynJL+2TgUQncUcZL2M2NYL
   j6ekW+FIfo4vZvOcuPR62EMmfjhtu4K7t9u8nmiHSBygM4oDR939Tzb6x
   E1AO0hSoRjY9VB69e8RrqlPaaGRuJaTiGrb6DGJ7ntRXI6GHBuR9IOykS
   r8vWhOjKmJOczJ51Id8xlyYhvUDL55T9XHou9IlA/kWs0mFJONX/YbkyO
   nP0m39zROvZe0+av9MHOAYDHm437QIWyFyBcZNkjNkz5BJfUNBb5oCogW
   5+1i3XXhviboePrbSAUenO5iy6nW25SYHO9Kqy5RD5ETKvbeZJfwXFqxk
   A==;
IronPort-SDR: +JtQSRkL+cGlxJvNQOzeBU5b/ju5Hrw4d2CwoGqd/ChQ8pwvUywIBDCdaHh9OLXEGXQAYX+IJ+
 fTnCYIqRhkWypH1paNhTUz0kwJ0TBWiEDef4EOz41s64K/9dxiTZI8C2eur4Kn6fjBOjx/whga
 VqhNWAcT9EwfeLcaQo/mJvnYiBu22aQS2n04ApFf5665Di1hNCBakYeMpmnMUk5iS7zqZeS4Wz
 XmK7V0/X8zI3Fwl2QmHX+8kdXEhn6AIOpi8sn8/dKUXT3I2HjxY0JRrEj0+L1O2T9OLK43B1Vv
 CNE=
X-IronPort-AV: E=Sophos;i="5.77,366,1596470400"; 
   d="scan'208";a="149536557"
Received: from mail-co1nam04lp2052.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.52])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2020 18:54:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVP+9Z9Di3jCe/JJlYwrsNQjUCZQ5pK1iJ3YBwgPgm9SxnxT+ZdPxFYhJbK7vGITEKcAu+0APOvO95i9RZSWKKin/UpO7Gro2lKVfcdsnQCtPxObFmu+xYARZphvlplK18BIKIyGO3hifDGtqoNrOlfwL51bTh4exFOE7m5EZrEvSmzDhCo9nBdJ8c3Z/Ws47K0g5vhGKlNuuryW9AEDSBXAiEC21nbz8Zz6nfko/scxK4XBhXthgxjwt7z7BwM2BqLsasNSSvBxeuxPtTrJ1v8sPpXAycoxc1mc2wuYrGwD/y9HO3Rn2vYGdycpP/8ZRwGE945r774IrLt+eOGnfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDDGQYe+o/+n/c4ov4wIahCktUu2C4ODIOFUcPuQxuA=;
 b=LjDKLMqLXxcdqY3fmIUSlETAXn7XLq5p4sdRbI9si0B82K83CytQrOU3NwotNsid1D1fvSqeT+ASzwisYP5yBM/cE1qFRAekBYPR3glCSwi76ka2Hq4v5/kJgZYIlzy1kGqpgmw5EeN/I7p939ZyS0tqh1r0km9cmyNwwIVQdSNVXucjORio1QQ7nr9DYmbzZTSLTAof/Ox5iFf3iYlSS1NFVZdV3fz4L52BvSmZ2OUxf6VtdriivU+GHG/uNZVAa5fTc05pSuMYszyLOsqr6ZQ9JYcSDJbj6raFQcNZ+CDuAo0eP1R/WkoKWUULIek03sg6clhSe1mpPeygD/LX6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDDGQYe+o/+n/c4ov4wIahCktUu2C4ODIOFUcPuQxuA=;
 b=i418bQWb+IO8DoPCwpXOdeg/Gv8/0s7/bIBVxSEZ3wjBGp1wj8NpCKmVHwUmOsmGWANh1XLYrA965q9TBjtqGTiIonmFLGg4f8gsXyNVWC5crBmlsiN00kDT+zuIA4ScSlQejabgYG9807gM0Pku9Cyh7KWnEZ+YmlLPkNdts3M=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5168.namprd04.prod.outlook.com
 (2603:10b6:805:9f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Mon, 12 Oct
 2020 10:54:45 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 10:54:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v3 1/8] btrfs: unify the ro checking for mount options
Thread-Topic: [PATCH v3 1/8] btrfs: unify the ro checking for mount options
Thread-Index: AQHWnngtQt1pxThyXUqLdopoZuKIPg==
Date:   Mon, 12 Oct 2020 10:54:45 +0000
Message-ID: <SN4PR0401MB359801E80FEF737E3392D70D9B070@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1602273837.git.josef@toxicpanda.com>
 <b339269ff176fd575cab81b40a15f2bbabcc94f7.1602273837.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 331bd57b-bd0b-4b24-d840-08d86e9d3b1f
x-ms-traffictypediagnostic: SN6PR04MB5168:
x-microsoft-antispam-prvs: <SN6PR04MB5168CDE4D9D51EE97A19FC0F9B070@SN6PR04MB5168.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V1nVrz5pq2SHfEMQc7WOOQa2pUl00r2CsfMlLzVpNHRzrprSOucLG100A0pypdc60EnfdxzDGJDGye4YXIfRRSpKAdwFBI1HnZBvk0h4F/5U4dhhgINChm/+/m1d3+zZs8Z3FPw99B8zjyN3nDOjoG4pp1q7NXwskUV+YT1eVPBIuTJjgF5/YeHJLiv2ODjxc6DXGIeaSpXn9jjeEXPxnEw0b/2PlS3xrb3C8+Wa64hdWwRe0j5YitlOvEWqWCSFDGNtrkVMHzM30XfAj2B5sGbbdo3hJZbgA8joiFdxIyP/t/6kGn/p6BEIytikNUdzSAjiiTgnXr+rrQ6SYQzdFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(26005)(2906002)(33656002)(86362001)(4326008)(8936002)(66946007)(52536014)(5660300002)(6506007)(8676002)(186003)(66476007)(478600001)(558084003)(64756008)(66446008)(66556008)(55016002)(316002)(76116006)(4270600006)(71200400001)(110136005)(91956017)(9686003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 4nvrFwGN+SlnZmRf0oOejTqjc6RvGtsT8d3XTpS7N6zS6T2rNOK+LANMXGTfE3D+SR1wfZvXrEhktEPSflUonPCNqAkDWgJ6qMNo+0889qtOM5yLl6t2NfLU/nZzYWiM+gaX6Dp/YbDXJEP/anqDiJhl3COqRdilgshjpK3ginWYTkhygtpNNEQJtu8ve8RAoHOZNGJukPh4V/MEbMrvK91j4Xt0XfJqHE+IfQytgCnPmrylL7DdYt4MzKVkGSAapq3YBmRHCFTbqx4XJ9D3TxKw+fPsW4Y+z9JX5utwDCBRyYHITYpB9P94H/yPlhKKBt81BRtm6lEFyHEFa0xVgDltLIxrv7fCpZY20M5YBtbW4VwfOsu0/OKI03qHfagBcoiz1gNyqX4OrO8IKOqqEoGkVJmSIeoXNU6TS2WXoMn8HDlPA0wrrsOy+Jbvg2FwHXZdonZfo/+FNnCmncc18E32IgDfh4qBVpEfhCg2F1BRZ0S1YhOOrRfy1zoS16+e+PBTOT9vxzEaCzjgojlm+KFiYmj2sbbvt39AZyNvJgFMGiBOeQvt2lOot7dbh4vUjcPdaKcGXl5dk9muO5kBXViLX6i4/+3xDD4gmmHupzGPY+0Kj2bcA7tesCMvsgA+4HK6oLrQ7WsYh3/K9/83fg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 331bd57b-bd0b-4b24-d840-08d86e9d3b1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 10:54:45.2049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hrmzlXb5cPzh02vWLpw75NvK2N22tppIXI4+7Ycur+z4bO9xEeQFLIr3tjo5MOxbm4ZF0hP/gyiOcoRObNp5/aFWzv7eo6lEJqYhgQGaGX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5168
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good to me=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
