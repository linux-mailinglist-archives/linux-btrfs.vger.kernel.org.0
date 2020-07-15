Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB912205EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jul 2020 09:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbgGOHMN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jul 2020 03:12:13 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3534 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgGOHMM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jul 2020 03:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594797130; x=1626333130;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=yrwxBv64FV5zTYBkX24ZLs1JfLcfthzZv0tSgP0OgU0=;
  b=UY0w6dhPUzNt8LbIt3sX9/4+q7WY98CI/EPyDtBW86Ax+c9JFFLYKdwG
   TthWLYCZIFoCvmGtBlXOBf+XFpEuqYqVqrv6DgGZ+On5P/eLPT/ryrOII
   4JOAPrYCyNiOtOxkfhg3VnBgNm6h0jELXFRJzEQ6I3MEhaU9nPCze4vPc
   2bOc6VVqd3O4J6rb03kZCBnvshDAjrwKofYcjGOuX/qopuBLuzXWVgT80
   ju5L25F/OugWBxA5DffAPFdoW9ZM8MA2/jo7ErSafAOGwjmUOYVtImZsd
   pcyAt16poOMcEA+fPfj+7q/fcv+exF/+R9N03aBft2FG1d10hwhoVNVY9
   Q==;
IronPort-SDR: x75tOd/t4M7C/M2JGipPlNwZwlU4qIrMmm0TCvEw6AzXeBGQKJJzWXV4o1iudKJ36KpSUV9zQm
 5zr4Vr4V7dYL4BjGeznzO/b8FszKX6P/2MhLcQsHvHmtmV5B9Ao6L3YYGx3G3ItkkBbbQB4Ki4
 GMQwBNSjz5R46I8iStrjQIdekTQkSycZovKBXBoH3cfxDT6clnPw0qLFKUccML+9SIYPLc/pFz
 Oeq22dH05dUWwh9fnrVQ2x02r4vGkQ0W+HoA4WOtRQbQJdF2lFym3+QPEcmByyPIh/OfiL2GMQ
 +oE=
X-IronPort-AV: E=Sophos;i="5.75,354,1589212800"; 
   d="scan'208";a="251758514"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2020 15:12:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zj/+dYg3HEZ4oY2DZZCfrJfZB+AGxBm60ThalZtMYGhccMt65+OvUI20FNMSkhEBEfJQnV3htNg17xX9dJeO5w+imljCsgNFk1lJjw5aamUv1iFAXAMW4oXN9EtnTzvudf3io2jM0OkWyUPjr/TNiTplgv4wHdWqpTRnpM5d0ZGLXAUosqpzpxQrPbW1Ze0Xg3R5qKHF3vHUf5LdNmPykGxNY6rxw2dst6i1ambtmphWpIq4YFxv6ijS3j0pss75mqE18DWz7X1O5g4y7v1kbQjwMSEBETfh177m7arK9IeS4CmqOq+Nk9b8+wtNN4VMQuTEC3w/CJ6iCDoB8wzMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrwxBv64FV5zTYBkX24ZLs1JfLcfthzZv0tSgP0OgU0=;
 b=ROoOreqw2uVG9Tu6V1/p8cIXUvXu/Bw7jHmBm4smXtVd6H1vIxvtyR6vucwWg2/kgMyIfTUiqLUC6wpZ0wJc9rAXVju1ItBDruedKCIAjiiEByiAcoiSFi/1HHX2AVtE6p5H/34dGCQ+S9ko4iEN3cwSsz0Oct0hgGzOYQTv4rIojDld9GXYly+cbmdO0xnwWHyqnhnGVlNWwJc2j/lVPp4+Ziv6vEQSAtlbHY4XnwbQP1ZnDmLjVwg+Fwk1zJVF4V3c51tgRjY/iZswU1vQQ4HBwSbW7lpf/emkcLFBoMSmeB5TyG9iS0pa3rBpZtnZY5pxHFeRVDno+fV8hwuMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrwxBv64FV5zTYBkX24ZLs1JfLcfthzZv0tSgP0OgU0=;
 b=FQ3d0nmckVo1Xkb6iDg8EAwVkIMq1nS6nolyRIdg+3UMlqPLsnZT0YQNBx0o4wtBrpwPEbS18Q5eZT4rkwlgK5ypIt/fzN5hwL3IjfIicdt07oW/LuWblzQSl/+WDA4oE8C7ozNr6SH0HU4MV29J/G1SVEsX2Xs0ZoeSG9CeiOo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5117.namprd04.prod.outlook.com
 (2603:10b6:805:93::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Wed, 15 Jul
 2020 07:12:09 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3174.026; Wed, 15 Jul 2020
 07:12:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: assert sizes of ioctl structures
Thread-Topic: [PATCH v2] btrfs: assert sizes of ioctl structures
Thread-Index: AQHWWcG8Q9fN+Cg7uE6ZDELwaAfkAQ==
Date:   Wed, 15 Jul 2020 07:12:09 +0000
Message-ID: <SN4PR0401MB35989268008F43EA5CF63CA79B7E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200714093236.6107-1-johannes.thumshirn@wdc.com>
 <20200714123234.GP3703@twin.jikos.cz>
 <SN4PR0401MB35986997606AF4136D0218439B610@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200714145534.GT3703@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:853f:9b43:c773:dd89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b4a2c699-c16d-41f2-b884-08d8288e638d
x-ms-traffictypediagnostic: SN6PR04MB5117:
x-microsoft-antispam-prvs: <SN6PR04MB5117C01CD5AF5EE65A417DE69B7E0@SN6PR04MB5117.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HDmP6/JWsq3b0kkZHyxKii93EHrjv5s5nI2hkYuO4TbZlj4Yxg7sf5WA1eBLG10eufBQF5nVZz6jz+pHAlNSbZGFOitaDwc+uZB3hekNBD48aLHlehrvXjhiBsg0z1ozdQqgDmPHg76cea+UxTNu3DP9vl+amwV603l4DU8clJs9aJA/rkpAZ8l4NVvlC6NHKhiLb755I7/ZDpqM9rZ5DZRCOgHHW5W9E2gTf0JMlpXZCfHNyVM0VhiDO8D/Afc629V4vi/2XihPZmMGUSRcSKt2MJEmopaasZr3Xk2/+p+FGmoWOpS7roke/E3LL79oBGVPs0zS4kgr2YxyLAEGxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(76116006)(4326008)(5660300002)(53546011)(8676002)(33656002)(186003)(91956017)(66946007)(66476007)(52536014)(64756008)(66446008)(66556008)(9686003)(478600001)(8936002)(55016002)(2906002)(71200400001)(6916009)(7696005)(316002)(86362001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: PqlOO8XLTxd4DHSjuo2sRDlgzWyH9mYMNhlaqZL44JkiF+OBZgvEsQBnc3FW+gEJMugmbdmiUBOGCNatLcLj3tQU1T6k8JMmL5abik1cYPibaU5j8NjHwvwys8hsDjkNUJspUMaMJiWpnQzI74X8+UD4P3XGlHHT2wyfMCxONFkR0sWqDpaA8GVCm6bsG/9MtDi4Rgf+MfM2kO7+TVkCM4i5xLScJw8Q9696W8/BK+bNuAxw122mmcYtDNollOr7FnqhNfdQzJUXZ3XEaDKnkbTHHfSZ3esS05I9/5QTSFJPcGELshW0osQ8byr0O5jSwB0y11bE+Zvs3l/H7HUpmBPZ506XoM5ECBb5PmbFT3MQfIn+Nbk9ETuY5scUUmzxtbAUna7kvAyqc+pg08GP+BKpTr6uDWV0JUDqXJKl8yFJD1J6JwcqCQe1eDATgmYswy9S1AyrEijs0ckHLDm5FUjQq3n8Pze5nShq2OHcWnhY8sI7NQkr3EkBFu/ynuVFFg8aFljH8RdTdLolVGapAcvjia/GnfUzHSyY2G/vPqFbfapqoyVDDmHCWshQ/+Ch
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a2c699-c16d-41f2-b884-08d8288e638d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2020 07:12:09.2694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CsNOwP4Y/ZBgGJa03E7TUIl/GeBv0NIhNai9dkmzVXE0GF7I/VBk1q42vFHmrYvKii1NcLpdHa7o7+dfJTX/uheavpqPie8lGB51EWOJzSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5117
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/07/2020 16:56, David Sterba wrote:=0A=
> On Tue, Jul 14, 2020 at 02:49:31PM +0000, Johannes Thumshirn wrote:=0A=
>> On 14/07/2020 14:33, David Sterba wrote:=0A=
>>> On Tue, Jul 14, 2020 at 06:32:36PM +0900, Johannes Thumshirn wrote:=0A=
>>>> When expanding ioctl interfaces we want to make sure we're not changin=
g=0A=
>>>> the size of the structures, otherwise it can lead to incorrect transfe=
rs=0A=
>>>> between kernel and user-space.=0A=
>>>>=0A=
>>>> Build time assert the size of each structure so we're not running into=
 any=0A=
>>>> incompatibilities.=0A=
>>>>=0A=
>>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>>=0A=
>>> I've tried 32bit build and the assertion fails for many structures, but=
=0A=
>>> I was expecting only the send one because it contains the pointer.=0A=
>>=0A=
>> I wonder if we should have two different asserts for 32 and 64bit for =
=0A=
>> these structures or remove the asserts from them.=0A=
>>=0A=
>> Having a 32 and 64bit assert will add some ifdeffery, let me see how =0A=
>> ugly this will get.=0A=
> =0A=
> Progs do the switch using sizeof(long) and ?: operator but I don't know=
=0A=
> if this works with _Static_assert as progs use the struct + bitfield=0A=
> way.=0A=
> =0A=
=0A=
I can try but it's ugly as hell IMHO=0A=
