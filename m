Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BFC1E3AE1
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 09:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387524AbgE0HrG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 03:47:06 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:52619 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387423AbgE0HrF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 03:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590565623; x=1622101623;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zdbufOLuDgVtxbBYM1v+Gprr04XAA/fhKZrAZrN5epc=;
  b=J8yHk9Qf+0VBVyPeyo4eMobLgISzOOGiqGeLRL3+yTl17T4ewCXeK2L2
   sxp9dyHTXUCBGsYFWG4ib5T3PFYdlCoeMwO2qDyjFbnZ2cNozWn+cH3IJ
   EEnyQDCxVlcIlkntyoeL0sAZm3a1KQ15tgp8QhqXIIecAMj6cxnaui7y9
   qM7u3MzoDAJ6W5tDAq2DXql8u3Csc+MbNQzi0czFdHlPZ2EzBlpoyunsJ
   zPC2amNPuDJrk3U1bzl9Gc+AlrlFm5wcD7gjhuCreo6tZNGo4tjALN5Ej
   nDMBi7iz1MLMlRCa7DB7GFc/NMyuSKHBApCSI0EsfxSvyG39O988ltAOc
   Q==;
IronPort-SDR: YbmtMpFb4qLi7Ap4v4lrEjNKe+nbOipmv6aWZz+smYgGyrREvNDR6oxKPvH8U1Iv3Ltq9ivnJ6
 xBxSO6uZpDe1+asW0/9SoKl59hxcyLk03xzucRlp16VisWM7TDJoR2fJEnMQxvrfkebavI2HEn
 UPzyFU+hdCLnj62OSJ94iZTiD2bBu4y/saxcoquqV6ELixh0EEE7KyEjctqDQ/cITf4pAq3XU9
 0fHYyOOhqtPn8N8q72pzwRysnzJOmYW94Ic2NxqVgqj3CrX0JVtDwMV03ez04Jfi96kf4G5v4E
 X5U=
X-IronPort-AV: E=Sophos;i="5.73,440,1583164800"; 
   d="scan'208";a="138597502"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 15:47:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYcL7uLlfz22wqPjAPHyWldcKfJFJGSIL4wKKnW0jmwZKrl2h4AbrLPuXbNAAR751qhV1F2ie4FNiIE2HEpDcKy6MpmEFG0eeHHAL1FyqBERG+lfX5RjvRMk+uUPlHNSAJ7LhmLNg28k0EbhGiJh0HeStYd9xuKFjx2ayTwsHdjpia77hUsoFlC0cYfOTPTwk7fx8SZG+jpbna8I30PGG0QaZ68VhpmzCf5r86jw04xzFqvEI38S6p74dnDXcod7y8/U4JybVXwbKVJlJ8lji34YYOoxgHejYJAnuZmaLVfWxpAzvmJsfULpx/cXHxNDV2DdvyAX8cLlGHuasqw91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEL6k24bmNGOeMLj5X695UK8G5J7kWn3A8n2Uf0NXhA=;
 b=kxwmdL8kMJqIlBtOdALrfqiXabOhGd+8hDuaaqn851uNgSegcBG4KY2L/PhY2oggA6q1/n6MWXPBfUZL8Fkj/appJdYWlS4yHZDwGf4lyHQr6OcABHgCmSrBANhGmcxQngpGntPHTokkHyCcmg+Ti1BEZR8Bi7G8FFQLhHakY01Rzdbo0xJ5769Lj9GPluGCC3BNJ9iGXn3h4uF7N8mAaiegFmsNEhoByx7XjHhCk9G3Vcs9bBitMoPijYsc8ZO0/xCy5/VpETm3QpsFwINR8LQMugV8rawnDC+U3MGibT2Kqg8RlDAnvpfvo7W47LQiu5v44KU3+YqKFbVaA3nxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEL6k24bmNGOeMLj5X695UK8G5J7kWn3A8n2Uf0NXhA=;
 b=ApotyaPYsqZLouTiyJS7XmH/i0eB3P4gktwAwHOAh4JhDKRJctZnpdHYr8+bwsniI5Z0LmBie6Y4ILgJiDkq0yhJDPsBevV35Wg91FdMfidCJStwuGlj0KQANZxBMS3glp9GfsOVsKbmNUmaQciWTFh5bVU6u3eBuDOq/eVP320=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3694.namprd04.prod.outlook.com
 (2603:10b6:803:49::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 07:46:52 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 07:46:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>, David Sterba <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: factor out reading of bg from
 find_frist_block_group
Thread-Topic: [PATCH 3/3] btrfs: factor out reading of bg from
 find_frist_block_group
Thread-Index: AQHWM2j6kuqHQhkK20Wjygnij96X1A==
Date:   Wed, 27 May 2020 07:46:52 +0000
Message-ID: <SN4PR0401MB3598F322682CD9D2A0433FBB9BB10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200526142124.36202-1-johannes.thumshirn@wdc.com>
 <20200526142124.36202-4-johannes.thumshirn@wdc.com>
 <ac073d60-7df1-bd20-1da5-350672d5b780@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5c1c6eb-411a-4b03-e621-08d802121efc
x-ms-traffictypediagnostic: SN4PR0401MB3694:
x-microsoft-antispam-prvs: <SN4PR0401MB3694C81CF8E2F5057A5DCF3A9BB10@SN4PR0401MB3694.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4N7SuKIIwwNsWrSBfpXshGVUv45y6bbN9vroB7VpDHJfpZ+c94BJzuag91jKSqXbDORruzUoQXlSDs4IpD4ZLI0DhE+RPw2x8GDAjAvv6h6uffyLwI4LVkDD/hasEjRq+sZPKL2AN7RnN5l2c4/b+vnYDL8ze1OL92xgMpxHoLGM0L4cCkWxoXP0eh3KMTbkcSVuliskm/OxE1GLF8NYAdqFJi4+kLY++Hjp6V4c8fV4WYlwDri3mjOzOlckEM0wjpNCZDMMkgRhmiotlFFeDn1A84z/cbf5qgt5iqZFe/MoLgyBA3Ue4PcTyf/KEI1G0X1DPLeUcTnxOmjpI/02Og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(66946007)(91956017)(66446008)(66556008)(66476007)(186003)(6506007)(53546011)(7696005)(8676002)(52536014)(26005)(64756008)(8936002)(478600001)(86362001)(55016002)(2906002)(71200400001)(76116006)(110136005)(316002)(33656002)(9686003)(5660300002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nOEJiR8V0oMhExZ5YSyZYjqJNnClxPvtT8WCD9y3YEB+rVOcy6zCP6a6FbnTQWzW8naIbXzarZoGZ8N8LFanUz+WCrveB+77zOn5IjfOMnTBSktMTsiKV0oYGZCkzGnEb25o3/98sRYB8K16pvtkVqzpXdfECZ3N3wMXxXEiDMT2yZ5eKrGA1bN96Cqm8spYqXbeeABDh+stRmpUOUw5jYInUC6NvJCo+wFw9Fpt5y4J+omSEs3l0436AudkuWHslUc3tNcFl18RQY7xT7m3Rlg3JyyaUqz0G7iYkDCKxdAG1wFCFuoR7kxlozgUz/WRY3kEqDDDod6waPiWTo+3jQLj/jNTRlTyOgEwmku9dMYgWA8Yd2DxCwWXb36ZEQdd8Mb6R9hhkhmXvXbue/fkc67iBykQ91ngS4LO/anLJmCpieIzFQdarZKcwo+ApvMSN2eU/N+5Yjbrcl3Rc0jXIttmG68f/GolsfnmVtOLkYdMFSQQVPgD6enN7CVG0zqO
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c1c6eb-411a-4b03-e621-08d802121efc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 07:46:52.4523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cL4JHZhCPkdb/3/npBX/N+LwFTomPTWQcWYu2MUWOSr+4ZWLzEThO0JpYyGrDaMKE0HBFPNMJrcOrvI8tHvrYc51H9qVL1S7o7tAxpcCDSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3694
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26/05/2020 17:33, Nikolay Borisov wrote:=0A=
[...]=0A=
> Always be careful of such results since this is likely due to less=0A=
> inlining. The bulk of the size overhead is likely in the new function=0A=
> and now those have been replaced by a 'call' and a function prologue=0A=
> etc. So this doesn't always mean better performance is all I'm trying to=
=0A=
> say ;)=0A=
=0A=
Yep I know, I've just included it as a small "bonus" but my point was the =
=0A=
increased readability.=0A=
=0A=
=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> =0A=
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>=0A=
> =0A=
> Although look down for one minor discussion point.=0A=
=0A=
[...]=0A=
=0A=
>> +static int read_bg_from_eb(struct btrfs_fs_info *fs_info, struct btrfs_=
key *key,=0A=
>> +			   struct extent_buffer *leaf, int slot)=0A=
> =0A=
> nit: I wonder if instead of passing leaf/slot it'll be better to pass=0A=
> btrfs_path, since that function always refers to nodes/slots [0]. My gut=
=0A=
> feeling is this provides better interface abstraction, but this is=0A=
> effectively a private, function so I might be overthinking it.=0A=
=0A=
Agreed, I'll add it in a v2.=0A=
