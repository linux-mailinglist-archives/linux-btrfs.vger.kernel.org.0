Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0598C2B5AE0
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Nov 2020 09:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgKQITc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Nov 2020 03:19:32 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11166 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQITc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Nov 2020 03:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605601172; x=1637137172;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=CwmfKAZrCeGWw34IRBOVXbJB4+fiT9QIwtRtPawHHb8=;
  b=lI4u9co7xfLwRrjIcRLXeG1/4vip53LH2iEYloBCgZf6tKlJRk1V+eae
   lfZB2QjZi33iM71MQaRaVDWvaPfE6pYLenpGteMK3Pmxup1/0PYsr8QEt
   FMzF7n1CS0o1hrjIx0REioFbiNF7YLg2GIMcvVonqZjXRncJAiXJm1R/N
   tV8tkny6T+3dCIM5yUBu123G0LjbnXGGC+yMIYszHJDDnO1dK2ZWu6QyJ
   7IIAZcQhrOV5wwP4XVti3IErDZiuvS55y6NOSC5nwB+96LqDJRZ19J5Tq
   6j0bH9uitNtsRenIS/KX54IoGoXRAdwQLDUmvU1UvwjK+HRQXPvEZFTry
   Q==;
IronPort-SDR: H2hcz4lDw+n80HIkagwMJrdRPGnU1mU+I53yJRbFVZKZNF3ZqQf/o7cHkdb9RSozocq4Hg9PLw
 C0j3JKqSy/fQMNyM70PRR/akI6hN1tfKAwOMpPYb0W4baQTaiXI18Q8l9fjdh9BQjwJHkGhQwz
 juGbb9+2qdrlnk5cI8yyRIsinxAmFZENsaXBq6ZN4Csh+5lJ8m/Rjwca5HVJqQR0wd8hriH78k
 hjLnwOmJ0dgQxQHx3hZYKlC9U29rqrSgp7L6L5lSO4yzM+R+/4tR73UAAxJWb9PoRdkBcX2lYC
 8nU=
X-IronPort-AV: E=Sophos;i="5.77,484,1596470400"; 
   d="scan'208";a="153972474"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 17 Nov 2020 16:19:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y32auXh1JmkgUr1UwFKGLF2lT+dTMzp+HFZamZA7L+XRLQQI2eHvEEfOEggui/ancvOQFYxg9AmgvHUA3ilTvzfbQF6dbRfAVcPfYRQOX/Y0Kv7zYAJoEaY0gCBekGsxY7YB9W6xAX1IuERNmXH+4sA4twgOFjtim+3AiD8B5JhsJQEsvBIsJc5FMHim3WuHA6fvQ5pIJuEIMloGFkC+AT8f7N4jKMX5fk67d+k/7sHkjTJxK5k1qBQlbLlPHp/lYoBy+m9eavcAcx3ENLXlw6Z1eiJ2Adzctv9k0fw4WE46HirSoEWOwUB3piUnU0xdZUKD2kx/dSwxZdcsoEiAZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKFwjAlgmmVdZae9DFlY4CKfr+ikge60kPIOKk0uibQ=;
 b=ITzfWhySsEgIcP2mtPHwUNY63k1T9GCyiZVdl2Q/re9TszEWy9lXSPB/nblpTW+fi/pNAiOHh2U5fwoI7ABtMdNj7+usOR0UBL3OXLOobPVR0Sp2vZnNorHCGMkXBub3Z/x4jlOxcbgZnRh2tA5Eo0kvMAwUAQzMJYhfyFFGpBQzFkay1ueJehFMlnhPsZOybWEVWa59BNGWpvbGXo0XZyz6/wmPXFvh0lAn4cuMC7SMaMkZO+1m/vJRmFbB9mxCNUCfV3yQC7zWJWYkyAr31rry1Nj4dMIelH2DBflFuor+B2WFEHP3wGeZgM3RwALRuQPcwnkMxXa+lYfuby1MPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKFwjAlgmmVdZae9DFlY4CKfr+ikge60kPIOKk0uibQ=;
 b=E0ZH199dINHzPUMlXQe30zZxCn/3LNBCR/yRVajn45/KEJwlg+DjGwEVBIh6Ieh11BGmdf/DtlhYhcC+YZ+RMrNrPJyXSxD75u6xxQ/oUSMj+5edtPGg9ClaZsNFqmW6ocWIn6JgN9jh6T5W/B9iC9rtonlRgmdn69xSmlAU5pU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA2PR04MB7612.namprd04.prod.outlook.com
 (2603:10b6:806:147::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.26; Tue, 17 Nov
 2020 08:19:30 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.028; Tue, 17 Nov 2020
 08:19:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        "syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com" 
        <syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2] btrfs: don't access possibly stale fs_info data for
 printing duplicate device
Thread-Topic: [PATCH v2] btrfs: don't access possibly stale fs_info data for
 printing duplicate device
Thread-Index: AQHWu+2JIGcbXmk3M0+KAGLZwJ0R0A==
Date:   Tue, 17 Nov 2020 08:19:29 +0000
Message-ID: <SN4PR0401MB359815F550099C9117016F359BE20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <0e9eb675e0a199bf034f13c58fbe5678f4e94a3c.1605513154.git.johannes.thumshirn@wdc.com>
 <58b88874-7ca0-cb0c-1752-315a3fb5bab2@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1528:b801:c926:e87b:b5da:7b60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a9f1340b-00c7-43a9-c7b1-08d88ad181a1
x-ms-traffictypediagnostic: SA2PR04MB7612:
x-microsoft-antispam-prvs: <SA2PR04MB761246C615FBB591733A439D9BE20@SA2PR04MB7612.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: awmqtqYjoPbJAS2FwwNtidoj8zM5gOsvyrTQ+/nrV1DfznQNoitj4I3BeXPVH+cXNO5RQx6hqkbOsuTosSeZMPzJ9K8N67TMU8AD2dC5z0+Nf6GZ+ud06vYK4VP8d8cSFJ29IdzsPAOXF9Banh8T3PgpUTzsCYwjr64akO9fmF1K+BvFY4abLQ6DtZlNdWhck9PFJhBE3qXBp9tl964FlTSw/3LKi+g6Cu72ABeGYUJmcywXPWi1B5g3egfK97FvE39pZHouzby/HoV1yWMzSRumizi1S1LGaHn3vPNFp0jUq/6XqOIpWM5CNJKYBu76
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(86362001)(83380400001)(54906003)(76116006)(8676002)(5660300002)(9686003)(55016002)(53546011)(186003)(7696005)(110136005)(316002)(6506007)(66476007)(71200400001)(52536014)(64756008)(66446008)(66556008)(66946007)(91956017)(2906002)(8936002)(4326008)(33656002)(478600001)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jLHhV1+3pJFsyEOJJvuCrv//FfpDdhRauAYkA0VcgRmKyuynw5LqYvh84YxSpninmfC2gpHZI9hXj4BlojSBx4wgROLKxKw2Qx14tC/jIQiP+8Kd3EBOUD8Ur9yLb1OW0VOzazeacAGg9FoGv66unW4zH4BZY3RZzod/uVb5/BG4ZXbgikYr1bWa4ehiA3afnnrzwPdsHkYsCPq8Kxkc+NMHvpyQElHANQaVDRqTZPKwKINH77FQPa/2RILvwec47QwywJfFBxwjCLuTVTffgiYUmB4kRx99hkJxApO5tnBkevgno9hmwvSQaTbXCNmMSnIN3jmo6ksaTCMISQAeS35V3N22xB/4/GngfxggOu/UaeacZB/fwTH1bwNsMwIMsM1ZsOiZTtayj54PYOyi6Yn0YIYp0Lh/8fQdqDqOoOP1xMEdIDm2yIA9/3kD7HyZ2ecqF+IaUbEqX5XX7a2XywXVSkPPRPYdC5h2I56cMHeXjGd/1UZDITqPUZ/KrJ8SBKLHCK/VqB369J1iqKqXedRqECKYQYcUYdnuIXImrM7NAY48xsHk45DYthREug/W4WnU7GRhhJ+Qf51t92TyTMZz82TPmxvY6wc9V+mOzo3v8C/Nv13LfNCyY2Ha5/0+Qc1iFFofH0s5P6Wi+Aqx90BOdq33LttWYlWoLMJlc4z8/wEaWOtuAErhtJuAp5GCnSXIfAwlHpEmDwtjvJ0Hjw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f1340b-00c7-43a9-c7b1-08d88ad181a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 08:19:29.9633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1vOzVTFFBfDyoX2pHrcifmTLeshvxqrCWW5KDIDAcj8oi2Ni4ICKEPl7JtWumr1ObxlmsRytDdZAIN4/t/N8Z8sn6p8vHqTvwajZiMLWkNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7612
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/11/2020 08:20, Anand Jain wrote:=0A=
>   This patch fixes the issue in a very gross way, as I mentioned.=0A=
=0A=
I know but I've not found a better way.=0A=
=0A=
>   Instead, do we know more about what/how threads were racing,=0A=
>   leading to the access of the freed fs_info?=0A=
=0A=
If I read the reproducer code correctly it's just mounting a crafted =0A=
image twice via different /dev/loop devices.=0A=
=0A=
This image is rejected by the mount code, because it can't read the chunk=
=0A=
tree.=0A=
=0A=
As far as I've debugged it down scan_one_device() is racing with =0A=
deactivate_locked_super(), so fs_info->sb can already be freed, when =0A=
device_list_add() calls btrfs_warn_in_rcu(device->fs_info,...) leading=0A=
to a use-after-free in btrfs_printk() accessing fs_info->sb_s_id.=0A=
=0A=
It feels like we're missing a mutex_lock(&uuid_mutex) in btrfs_kill_super()=
=0A=
but this hasn't led me to anything.=0A=
=0A=
I'm all ears for a pointer to the correct fix.=0A=
