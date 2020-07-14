Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507C921F557
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jul 2020 16:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGNOty (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jul 2020 10:49:54 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:29459 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgGNOtw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jul 2020 10:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594738214; x=1626274214;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=YBY3IUPAmd3PNAIdkyi6GDBAN+niVEGD7EEPpmOPl2Q=;
  b=geA1O3MQYxwYMqvttLNuegunMLFmALCllHnOS/seXsnlOj9pnt0rep/h
   pPR2lZW/6EGA5weKFJBogHOlvhcyYQTY/aIsKVcPfoiJnnxaE37RzzY7S
   qBPE7AB4EgU0Nywm/fKzVByFB7bcOc9d95yLZzx05tsEbWTlZWijWETmB
   X/bg4H/8AIGNjhnTHBiytrXte1+5i4PcSqnrAvgagh04X9wDFpMHFtkFq
   /ygV9YyPQGaudSkT7vynIEWQtF30GVURPCRfbxg0OMk2N0CUGd/BNq+w5
   Xnn4OIirgtoOJ/IESjJYbuyJ+M2w4JzbPtvKREjvl1qW1LQQ+4BRHEsAP
   g==;
IronPort-SDR: jq3MLfQh0XzVOZERlmQD4SweeKcwQ443/F3Xjd/LsrDY/ieMaFDJ55FT3HgGCLteoQTglqG1ov
 kYNQIDXUBEgGzjSW94E4wgRXbV7Q4ch9SgHJAAwOPQPAa0FLBSlm6c8E0Mlz9SijBTF9FasoUT
 KkhVMAK4KW7mDHj1/879V8kr2hjknZMkZyD81ivwBZxCvqmre0NCX4JXd8z40HpDZj+iIkqXDl
 n2Uk4UGlSb/XMKMbMyRAk1XpO0WG8mnjAPutZswB41zW3HazsPtYUXe4hlZKClJJt+oqZL4yFK
 K+w=
X-IronPort-AV: E=Sophos;i="5.75,350,1589212800"; 
   d="scan'208";a="245463498"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2020 22:49:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1MWtmmqV1HfNSsJ3U8DUZmv98t/gdqdq7q4gqpZhQ0V3j1sTRVA2sIs5hFOfQzqREUioYO+oAcFP93Q9JIf2UhQwGKOS+EnpDv98JWNm9Hnki+9hbAusXAkU45krfHGl5IZbryf7CJcvP9QJwoIhtoBI4liZu/T5FfMcbyTxZpqyIFiLYBuEut4wkJQ0xeMZsiD2GKI5vAC4MnEx7NSZnIRmUXEO92PV4/YcyEqQ0wYC/uhPHnE5qpY1BvypuGaJCN6+qMwV7hWSo1ok+jhsDSbgmO7W6C3ztu4aC2nSzeWRym/Pf7FyPB2h+DF0TUY/xBx8iBY3lC1UJY5yHXaGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBY3IUPAmd3PNAIdkyi6GDBAN+niVEGD7EEPpmOPl2Q=;
 b=AjuZn4eQa+L5EGTV070IKIOtmYsxAgY576r7X6bSiRMFPYBsqm/fs0iw5EBvm2HMayuUW8WAx6cEw6/v6/aBJsvvjW6+QLYAArCIqxMMjeJt31ViVJLUwZMqJ7J4o7PhyX0bE2aixEZJru77HPPIqil+Mj+27jm+/SAbNsO8wCugcyOXNHnjvkLMbiFvsB3wzKsw4F8gh0ghqWMotKfdN5H9YHM8qrrEeXA2VbiuVXDeKQegEdCVzfbauHS2jnMnY3h87OqZ/mA95/UBVfhcxoGVl0Iem7KDRTY4hHRhB2eWGx9uNiwx7ampYxxpSp7edAkOOAROdFAaDzQ/UPh5IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBY3IUPAmd3PNAIdkyi6GDBAN+niVEGD7EEPpmOPl2Q=;
 b=YFizga/SLjxGEo055wvZ2JjCfn0HhjbSRCOU/hhllAsdGbsdS9QQyA2y2opJZuTTmxaZt7yzqt+CsTzw0EoZX9M7k8ZFERa6jqk2xqEWxkanIB49+UvSion/UksDolkOBQWev7UtVH/t7VsrAYfxOIg+5+TsP6Eoq2zVkBgInrs=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5327.namprd04.prod.outlook.com
 (2603:10b6:805:103::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Tue, 14 Jul
 2020 14:49:31 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 14:49:31 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: assert sizes of ioctl structures
Thread-Topic: [PATCH v2] btrfs: assert sizes of ioctl structures
Thread-Index: AQHWWcG8Q9fN+Cg7uE6ZDELwaAfkAQ==
Date:   Tue, 14 Jul 2020 14:49:31 +0000
Message-ID: <SN4PR0401MB35986997606AF4136D0218439B610@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200714093236.6107-1-johannes.thumshirn@wdc.com>
 <20200714123234.GP3703@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:dc3b:feea:5e5f:2d30]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 071d74fb-a382-406c-3a34-08d828051dd9
x-ms-traffictypediagnostic: SN6PR04MB5327:
x-microsoft-antispam-prvs: <SN6PR04MB5327EBDBF0ED27F691B578709B610@SN6PR04MB5327.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wbhT+8IFcEWzcztrfSgT3rICp9hXo6qUGgrEj04V652l4ZEdVTQKpvcYhp990bxzNKMKxBuv6+mRQFc1PHx/0D3s58Q35Mni/Q5UzKeb0Q7CMdYXNWLIqwRJ4UluFf6yncsojlXl+cf4rI9Xl5rDDf1vn3O7ycuLpqx1h6s0SMwxkjAYNZx01+MAw3sk9Ztsg7oqkqHvLZelp3d9T305dXrgGoaDUwsdGXC2LgNfunczaJQPkg7se8tTi7jdzalIHKWwX0jxj7Fa8dI/y41M/8mKK3UFKnOlKyXTHEkNT+P/zlmnWjPBT5+aKedM8WI7cjERpzYvfFdk6szqei4ZTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(186003)(91956017)(5660300002)(8676002)(86362001)(498600001)(8936002)(33656002)(66446008)(71200400001)(9686003)(4744005)(64756008)(66556008)(2906002)(66946007)(6916009)(66476007)(4326008)(6506007)(76116006)(52536014)(55016002)(53546011)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7LHaiPB7oaFAjqJTu5H7O7rSX9OTgIMEoAoeL/mk/x7KzabwEwP3KJA+6d+qm8qvq5E62TO9Dk7fnDbzDSVmYpY0WySHiOVJErt64VNhYVZnK8kCZi+UbISuZwqQi4PnuTUIzkeOPx/yjHoyjA7B37owa0xhipBxAo87tkeOg2nXPNrdAwDcjH60lqema0waCzQSZIdVC/yaT6IxbMoMw0ImjbwcMxFUNrtSzhAn0M5MMwYHZeBALjfGtE/jPclcQ7tL/PaS4XHVao6Xh7I2ysVDBHReWh1zNYztUYAWR3L7E3+BjVBD1lZavPpBLtfU5v0j3PsHE5H5UUzi6lUzHE8qvX77MqLj4R7B6E00cDb1rF0UqAMrcWg/keVnHNHfw1xjZou71vnzHfmdPtoYjz9neQGzN2fkojZeqbImGQejoSUYKVhxKzIKEYuGV6TS/3bAcU5OdoJwGc070kTXwTRv9I2BcBEdvajeEhZPoKct1h7i2m0OADKeS4ujcRe3A647YxGu7rmONM5QNmt4mlRAK1inVLVE09cYRB3DxlPTY/uw07QakyVzu11D5rMm
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071d74fb-a382-406c-3a34-08d828051dd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 14:49:31.2278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2pdFPrsW4NGT/ivQ5/yJgt/3A6JhO+IWnXryQ3GPNKmLCBd4FKHk93qKoFLRczEEJVXqR+HbhjvXk6TvOn/zoZaNkOnKfTrlo6GweSKlmqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5327
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/07/2020 14:33, David Sterba wrote:=0A=
> On Tue, Jul 14, 2020 at 06:32:36PM +0900, Johannes Thumshirn wrote:=0A=
>> When expanding ioctl interfaces we want to make sure we're not changing=
=0A=
>> the size of the structures, otherwise it can lead to incorrect transfers=
=0A=
>> between kernel and user-space.=0A=
>>=0A=
>> Build time assert the size of each structure so we're not running into a=
ny=0A=
>> incompatibilities.=0A=
>>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> =0A=
> I've tried 32bit build and the assertion fails for many structures, but=
=0A=
> I was expecting only the send one because it contains the pointer.=0A=
=0A=
I wonder if we should have two different asserts for 32 and 64bit for =0A=
these structures or remove the asserts from them.=0A=
=0A=
Having a 32 and 64bit assert will add some ifdeffery, let me see how =0A=
ugly this will get.=0A=
=0A=
