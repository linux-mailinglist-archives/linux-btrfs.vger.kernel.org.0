Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7252B04CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 13:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgKLMOf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 07:14:35 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:9468 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgKLMOd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 07:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605184455; x=1636720455;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GvXrtPJuHHEz8knzQvXCR5mz5geVVF55X5AjIJfq3HA=;
  b=cn6h3C7FyIPCZF4v3bfaYEeQDzyenF25dncUoIZK7sLXOFOk/iQp1KoQ
   H+awPs4EdiSUVVeS4LyU4zbZEPGbC8q/u53WkgczDXQOa/ui6Ir0aFQED
   h5leMgrTCcWyNl20ji1gDE4KXYTrl+4xTmKFbg6OjIgO0tIUiB5CWqel3
   jOPuIaIQpXqDRDQiVhpd25KIjbxOVPUlVraMH0/lQK7TVZtUHXVjAKaQG
   ka8ABUNv4j4bp6PdB62KCMcIQFdWohhb2r9l8NHYBj3fjEmuP+C83UxFM
   tpJskG8ohWXWUY8XVfK8w2CEQZrWJX/sU97fs+LSC+zxfCwtOGBZ8zbBm
   A==;
IronPort-SDR: zZqzddhZL0ouFMEkiumiGiUDJYocGUqjhJZEAGv8sgZiwkV6Dqt/midHYX5FLKDJNGw/jXjv1N
 M5N/yB4h/aX1Z5fbDhGyEAruo7w5gzmCnKfA+cIdkY5wk5D6ZaY0zHCfzC9rkUA6VA4ABQdVTM
 EX5VoQP/DCgh2wXO/cnQzufWOpsPG+3ZXaqFoBHABqaPcOOf5d8L8L5SBR3Lw4279L7k0Pepum
 FdE+6krju0sbEUrPWgl1CZTo5rZyfAZGekE/DylETFxLSQ60d/3FJXH4oVyzN76phgxlqkt14Q
 Ujw=
X-IronPort-AV: E=Sophos;i="5.77,472,1596470400"; 
   d="scan'208";a="256046114"
Received: from mail-bn3nam04lp2055.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.55])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2020 20:33:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jODhX+MZdV8FWSIPRgx7KqOLCu7CjVPLqcsgI38xMgsYN5+2biSGPk/mkluTmabjK2NfdKMGdhRFcbFZhtM5ES5vEBPJjLfPzoA21bnA6/1kfysPiwfaquc1s+d5RWYIQ90YOxbc3GNcvStIpnAPqDZ3DchorHyAnzHQHPucmIHpJ0xqbECwDC0hfkqwBizivshTDJKt7H4zWx8ViJg1mTIX+unMi12OOR4/qyZpMIklZKFsEcMgnuSNmqg1rmR0KNWAYHAe7T029m9KnJSUQm/S9JF1aUfyS1eNntAynwWZMuRJ7Qr3FTrKB9nhFq9WuUCSKUHswXJx0wxnfiKJPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvXrtPJuHHEz8knzQvXCR5mz5geVVF55X5AjIJfq3HA=;
 b=HFDarPMridfmAPkTLSqzXLl72NIroCN0G8w1kPuhfDw4ay4NM9hJLedXL5BAUPiYG6xlkW/iIlCWEMt1xziL2k6bJ1HvZ77xV59JKfzMYSBMfDP4l7cEh/6KkVUJvGSh/PTubqzEU4UXV+x1Q/UEt1BhQCjM0vJuyUjafDqEX9rdKza5QxmcXOfsgC+1UYc1Bi607RmDQjz/OMdfOlnon5SiWDNdxz/Xhl6lb5ViWLQOO71Y3sJNdZ3wLB7G452enQx6maEcuB6JcXvcrLpaFe0+sIaeKbzG8p7ecdQOFYlEpl1A96+zyC46BMAj7LrOo1be5vGK00snORL7w8qBnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvXrtPJuHHEz8knzQvXCR5mz5geVVF55X5AjIJfq3HA=;
 b=lsaVuda+yAMq+hb6ZOKR5REnBhNOXGS3EguO2uqGGFG6s08U0e9Tkt6xhc6+v7s5+W4Wk/aXfsp5j8gTZGFyACT0lzc145LsFTTU7fdcx+h1ItT2NErBbuJvad3uI+1N2CGycAIAF7L+3+CTQpTKdEBb53V5Xy47CJZGvdLo6i4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4045.namprd04.prod.outlook.com
 (2603:10b6:805:47::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 12:14:18 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 12:14:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Remove useless statement in split_node
Thread-Topic: [PATCH] btrfs: Remove useless statement in split_node
Thread-Index: AQHWuOZZMy+uLzAqm0eTPelrBArA9A==
Date:   Thu, 12 Nov 2020 12:14:18 +0000
Message-ID: <SN4PR0401MB3598322AE5DE841E916C26A69BE70@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201112112402.784923-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:145b:5101:3d02:4ac1:70fb:2ebb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e6b3424d-89af-4123-7f72-08d887047b08
x-ms-traffictypediagnostic: SN6PR04MB4045:
x-microsoft-antispam-prvs: <SN6PR04MB4045B09DA69B3B9B950F8C0E9BE70@SN6PR04MB4045.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UiE2Vbk9fPiFaMuuUSd9DRh0T/BxU0gigE27dtBjv0v6f3GMAspKFL0prh8SMluRtLmrt3mPoaAD1rhkX0uQu1iAyMAFVksHOE+xUgbboUwWOgYpyex8xyL74TxiOXeKgnLy05QqoCzDnnd7t8LhuPIlsmkJ4nmdjt9w4or8ggpRacZWYB96SxTrw4JXD9yecbEeGwwI07CFaWsRzD9wbvxmZbS/b0lDs2qQBeQ13jve0xS7mkBnv9cQoaA5VMYB679hLXSIVBzLhuhX0MhiOlLMd5eIFs0wnKtCCtM5U36ih34rjIuDP1+ujFolDqT39qTLotJtvRuW0pBgU+5r5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(5660300002)(86362001)(7696005)(76116006)(66946007)(66556008)(8676002)(478600001)(55016002)(2906002)(91956017)(9686003)(66476007)(558084003)(316002)(110136005)(186003)(8936002)(52536014)(71200400001)(66446008)(33656002)(53546011)(64756008)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: gE4Vmfwqn3KOh2UgdyZM3ce2Ty7730q6QNsQmfg2FWzK+87OlHOTqo3Gpfke+sLae1SX4cB2Q7codGxCmwF+Z/nfd0bdFzL9kXssTcnWtJZQnR/ECh1mBoerdv4eruPkfEJGgUKsHpwWix6xp59n3LXJj1zeJcu5vbJQp6buofAvJHbw+7k48wb5Sy0dcAOUUktzgT59V11+UoUaI+gQuyeErv60+10QOz1rT1A6qpl8VpM0KtaeMjaaUPRexlM9ZKwygRuaYO0r6RGRolOWTHKKEA2J/68HGJLHGJEbCe9FIQjSeVzs9TL5uhifMNaBCW1sa60XxerBnZ2mF/F6j2I1SQxErWL4Ad+QOF42cuU6HdTRcGkWjnL/8R2SczNiP6/h49kVi7kS2ZUte1iIFtCS7awHtyl9RJv2hX2gv7sKx48T5PojaCGQSiIGf9WieCb/AxTL1O7coYV6nxSRWtRVK9idL0O+NP4CRsY/HJ1KkM1XXLpVJxQZZm1hCtrTotNkoF29MZ/OLEqdSnLJeSF2UBaA0WtttEGQ3x4t7XVxbFs8xGGr6kLfVHURUvE7sOPh9pnHJ32i41TPYtfYNVAFutL3M/AOUF/3k9qDMRLIiM7qC9TQ1x211UieH7bwgIpgYAcuBMMTL0MOAs7tHo8jsv22iY9OfXR/qhFH0pzDunzWh7o6vi2fXV0+T3FyUZHPagIHrycroJSJ3J6paQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b3424d-89af-4123-7f72-08d887047b08
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 12:14:18.5999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HJAjBFVMfIxI94jwNWNlIubazaST+eCEzP0olLEPu0miHuvs+B1XOGhIzr5VMXnFlwoUqgCjCrpG1UWpCySCzlBdhznauB25uKhuApKfTFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4045
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/11/2020 12:24, Nikolay Borisov wrote:=0A=
> At the point when we set 'ret =3D 0' it's guaranteed that the function is=
=0A=
> going to return 0 so directly return 0. No functional changes.=0A=
=0A=
Indeed,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
