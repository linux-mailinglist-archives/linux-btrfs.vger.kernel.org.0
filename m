Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC4A2B04B5
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 13:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgKLMJ5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 07:09:57 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2242 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgKLMJ5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 07:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605182995; x=1636718995;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=2HTLVqe/mYOtrMmq2RT9AraCicEzAIXWTbO0e6TgK4Y=;
  b=TVGy49rJ6XQCY/cursQD0oLDIXsav8MGldcg3axIQIiH/6aFVzgkFH/G
   NgluqJO1JpK+BW8HzZneQbPRhK9HJ9Qx8ldlLlnNCyV2wnAi+CfXsHOOA
   9XCJdfTmv711IQ6vE2K8AfRymvf/LqCPy2ms6fD3V3+6GG3Bq0VSGjTNe
   B0oVQYe6lHc0435m3yn+QFrf0sp2zNZxtZhVNrS1MGnJL+zj4YML3Nl19
   i2aF/WrtbvvB0IZEgMjtCNPP0pjjXMXC4rDQvJ+FD5x9uNVQfjeQErRWf
   bkR+B+a1D2WcVhM+g9EhqsB3O5FY2djiF8toZaBNL8G8yReljBCX6lJm1
   g==;
IronPort-SDR: aWPrtqvFRse/zGsJVMaaNxbK90CySJvH9ns3QiSsp1dexdRUj5+5bQyy8PbxIQcrd8Op5UAoLI
 0q6Ue/MVAsfs55E1xzH6Ti8gv9d5isAGpjg4zmf9INXqCP/Z3j9Unpca6nZ90+sPKc44YS7pBM
 1PPGpbGljPvYmgpQJ7sckyaohyyyMnx31wm5VCLKh+Zp9LL62CxiAaG8vYppdwhB7Modk/5aYG
 CgJM4JdZrVT7ymb687egG4lHbBecE6pqw5gVuLVCWAOFluPUx0konpI41VeUZG9qaGixmM7ikx
 Saw=
X-IronPort-AV: E=Sophos;i="5.77,472,1596470400"; 
   d="scan'208";a="156961559"
Received: from mail-bn3nam04lp2054.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.54])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2020 20:09:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCqIBjpeBldVyy8JmQUxH6kAlhJuaOt/wAxaTFkjaw0x1Oc1VGx9rS0UV0FRF+BxiSPTQ1mzLVK5DioKXC5SGy97VgrX/7CHVTxiD0tGhduyjDAPffCurMdFYnySVKx7fkiorWL6H1H90XV3hfbLc2B95w4vMWLk9b01ymButTObzp1DEqmWWIw5j6waZgCvUiNuvytqtoWVQRKvSRx6v2guJ8105INEr6rJk9WFbtEZ/RVL+Qe53h6qbs0hGhbh3AZWE3ECVX8BVSG/v0iPHTU9SavdQJc1jnjoxDkuIvQsnf4l1Z5egVEpPtjh2+65w4i8dMD1EdZecZ6nhP5bKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HTLVqe/mYOtrMmq2RT9AraCicEzAIXWTbO0e6TgK4Y=;
 b=BsE4xLj6zyGsdfGnt3Icxbt9H/9kNyrhysZ4Tumcyccf/NzzKkxEOUIlfxo7nR2rt4t7EsW2kw3F374PxhVOtCI0RLv/izudwGDyvGSoeW2xQAmtsPwoIhLavcIEBYh0iPH9TvVA0R2oph0p4lG0g/oIlJlt5C2JwjDA6KM66+kX6QvaKGovF4UL0HntHHfZAvwIcbYGCn6EfxSWOUycZ7kyuls5UUtGyskyFebOArN7pifOP/jKvPIm+OzC5nGZWXSg54K/MpmXldCSvHxOKeVatV6+zkfV2gGtUR1xe28ak4FfOSvjCJLew6N7SUNKIf76FDnpcRDKJgc3esbaIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HTLVqe/mYOtrMmq2RT9AraCicEzAIXWTbO0e6TgK4Y=;
 b=OZF3KGBqOoVfWNmAI+gOAw4s3dH49nozhRtsu/A4DTbwvNrEh9BOfV2DPhvogli1U8UeDOgt+kDcDzPefxfoz7aNV81ZgmU+9cXrJ1dxnS03bLrXgqiKjDnNKzSD2sQpQ0gUx5si0Y15AawHjpv0JUGlN4UymCUxgJFgCl9VHaM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4045.namprd04.prod.outlook.com
 (2603:10b6:805:47::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 12:09:52 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 12:09:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Anand Jain <anand.jain@oracle.com>,
        "syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com" 
        <syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com>
Subject: Re: [PATCH] btrfs: don't access possibly stale fs_info data for
 printing duplicate device
Thread-Topic: [PATCH] btrfs: don't access possibly stale fs_info data for
 printing duplicate device
Thread-Index: AQHWuOtRAaZijNInYk+P8NzKw4BntQ==
Date:   Thu, 12 Nov 2020 12:09:52 +0000
Message-ID: <SN4PR0401MB35987501AB13F33A9498D85D9BE70@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <2bb63b693331e27b440768b163a84935fe01edda.1605182240.git.johannes.thumshirn@wdc.com>
 <3454d885-21db-199a-76bf-0da6f9971671@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:145b:5101:3d02:4ac1:70fb:2ebb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f48a0cd8-ea92-4b96-e1f7-08d88703dc3b
x-ms-traffictypediagnostic: SN6PR04MB4045:
x-microsoft-antispam-prvs: <SN6PR04MB4045B014BC622011D66040FD9BE70@SN6PR04MB4045.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Quw0OoHbIx+ExMbq+DJrbWBBXADK8b17HsCWi7p7FAtHK/ogRm901OaHpeXB8oKBkG6BrlZkCe3QBftU96v41LgOZKBCg1sIPg1erTR9184jDC6TR8JZV3yiTLbKFElTIvidGJlzWigM14ZeQoRQPoZ9c1CmRUMI14w3OedMDtR6LSB4gn6x/INukh0SX4jlYbwSve0Tf9/rfAaemWHqNQmP/4ViDpldPoXxqmAZxnMLZfjuiozJrnqsyh8FObuaFuYhvmqO53Rs1OcDqmQwnRUsUPHb+wAUvlwPCEfBVNVxA/oycCSefljGAoMOUMP4L67Oo3/MD+tUvzUVAy63Qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(5660300002)(86362001)(7696005)(83380400001)(76116006)(66946007)(66556008)(8676002)(54906003)(478600001)(4326008)(55016002)(2906002)(91956017)(9686003)(66476007)(316002)(110136005)(186003)(8936002)(52536014)(4744005)(71200400001)(66446008)(33656002)(53546011)(64756008)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pkI4Ui9VDyGQOY7veOjFWDav7GfznB/BiqMk7u+vFm0CNOQMFop2iJqqieXOCUOKol489B5hsg0qFjMS9hpR3i9VYxG2AxzZ+tdFvrTsk6SAXxYF277uBphZnFJQXSQSszHveCED6hSXSiiwzosA4YZwLF8bprbtuZxSPKcA/b8aB9CyJqHvzZtYnVPh0XaNXZVV3+F+QhNT4brcjZK7BTzz8ALaiiEFtoJ9v8ofESYTczkC5RkLiOPc5WDKp/YYXw8tR9YQxUwYyikVlwP7dbDpAVvvNCkhRdf+Xl2ILGGyyzSdNeOpSfE7Dje0vYlupANHGOvio74onPAm0ubGCclYeVWbV2/53Kt7tvtc00bM9KM1cTFiDN6qGC2CxbeJEgDdbeELOyGvNqLxaE4hoO5ldV3Fl1/rfLKqncTkjiFTn7zLhMIG4po8kKSHcChvTXmmAND3rlrCLuJiU1CPGpYcFVIfne+a+uwqyF6mbnw9lpT0gA/pIbErkq84T6oKufGiyXakmjlO+t/t03DJ2hIH4u3kXRF5URQsijs1GGkrNERQLutGdjVIfEJME6XzL+XYwb6xhyfVp80M0/wTVmI7USZKm4M5xV4ZrkzejOnk9FU9uqGc+QCnVcCUGW4u/HOgwyDbhaYoL/PO+QcRlIiOfTF5n5jjXw5PZy5hwE1zfPYeJ5eKlNr0AwoDRRPDjn3kAH3mEyKLWuHfuoBiHQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48a0cd8-ea92-4b96-e1f7-08d88703dc3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 12:09:52.1780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0b2NqwFlBiVCUSmC3P4b8SSGfTDojtOSzMLekAFLxu7MifyIVIFAbku4sOVturCdZ8T/EZLY57LDmtGU6lkMpQgY/jonsiUuVx+fQsepNKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4045
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/11/2020 13:03, Nikolay Borisov wrote:=0A=
> Would a simple 'if()' here catch the case where fs_info is not=0A=
> initialized essentially open-coding what Anand has proposed? My idea is=
=0A=
> to be able to provide the filesystem id when we can (best effort) and=0A=
> simply use pr_warn otherwise, but without having to change the internals=
=0A=
> of btrfs_printk and instead handle the single problematic call site ?=0A=
> =0A=
=0A=
Unfortunately not, I've been trying to do that but the device->fs_info poin=
ter=0A=
exists and accessing it triggers a KASAN splat.=0A=
=0A=
Actually btrfs_printk() is already checking if fs_info is NULL or not to de=
cide=0A=
whether to print <unknown> or fs_info->sb->s_id.=0A=
=0A=
Another option would be to do btrfs_warn_in_rcu(NULL but that doesn't buy u=
s a lot=0A=
more.=0A=
