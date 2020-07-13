Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46CC21DB59
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 18:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgGMQNK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 12:13:10 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:37924 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgGMQNK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 12:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594656789; x=1626192789;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=YwebdBdfqFy33z8FftszepYT1ja6cnc+wQZxfBsrBK8=;
  b=pEc7fpUvendl+236B33tn3XTQIDPfsyab9QWIMz/tAvcBiglIVKS85ii
   WIjL7EDPL+eaLVZ1z3MtzeLXpqYvVf/l4znIug9lhPBMWcZVHEjIisHXs
   vKG4g5zkdGzbsGWbNFeSudaRutnDOJLMOllahiq/cnyycfP4UqnR1pub2
   j2rGx608lF8pzGT8f348CyZbbcm32Nm3VJa+HzbkkrTi5tMTkbuddjwXu
   2rY3by0PSsCt8ZNoVItdPfdYDZflW8hz7skRMwvLZpsQmaI7bGILDPL5g
   HkpPfCnOH6BNsm4vnUa2GVIhIoed0xwe/EaMJd/pQYSPTDeOOK/8x0kDK
   A==;
IronPort-SDR: MPUdS4TZBIEi5FC03BZmlyPOgfVH1/RHR2KryBP1L2diAipP5oLdTzZ6mGO/SNzuYpWgTrLMNo
 H7dj/6nsuDMiAMSJvEJwHhA2buRc5psECPpcyDSl+wgx7Bcrh+S7UOFgCrLTAKIeec16/Bb9Ah
 /el1+qRJUtiHggdCPIsRQwawzpfwGC232QSNL50x8fl1KQrLjr5QAfM78NBjgwKhE4/YllvDKd
 SZAP86DPoKK7x9IR3v6kdibHOi26ebFyGIqeEKbq+k9ZhnLWUodi8LV44CH3z0sXMHIKDJZPAQ
 s50=
X-IronPort-AV: E=Sophos;i="5.75,348,1589212800"; 
   d="scan'208";a="142327689"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2020 00:13:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrTGzk1zLASAfwqauDy9UvE4nMfmssNHPHqp3ut0sjTNTEJIcs8MJlnc6vrxfWFZagSwqcPlarHn9cnXtnrcKLSfbJ6XHzNepxe13H56+7KqcMeoB/9kbUwFmXSpFH/6azMiWWPkor1CgMXokfi2lNOw0IRtXo194gys7nLqWyF3QRhHHDOlYgvQMW4jukZuVKG15ErpEmyXrAqcAINiFNLpxh+gmFJ6G1/SDtFhtj9eJXA2iPmBaHupq770/G4yjoIaHMw7LgCha+PFixXt6Q2ldD7pI88coI5A1iaW8NoGL5GevX/hm5ML/2Nx2YJvW5ruTV04CZz9Ad7VlCfIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwebdBdfqFy33z8FftszepYT1ja6cnc+wQZxfBsrBK8=;
 b=YgOdOcjg3N2AMGGYSBrUERTPeOPtBWdz8Jm+v220WwrVd/G27MYsElR8DKP0zUmv95d8H95ygKdE18rZFzDAY8V79H3gnnfpsqaLKM1T74+fN4MF5XE+rtWrKwNrJjgri8GRMGXfuiGMRMzyrhckXMrf7+K4ORJVhEuEgmllsfieWZ8Inulb2kmMzikVF44asx++xnMhzkohFYOi2TRnZDMAI9CcqD9tA6Pe2YYiWA0QyfVJF00E1GQqi6s+8AparPCw9kC6VvzcC3Ta57QdjPB/q5x+l7XCCMmQ46ITCauiSR9wtKtymb9Br0vedSADvIwEOLoSKuhQQbXX/F+t4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwebdBdfqFy33z8FftszepYT1ja6cnc+wQZxfBsrBK8=;
 b=VxNmq4F7Zrj9MEIZ5au5mFQtLgQ5LSr8pAA8KtmZQWHhY18l9DhHEXvYupjYoGt65TdcM7qtyVhni/tLw4IdHhjQREx7rz1iUro7bSxj8lyj5lepOL0jJTTj4hwwIIr2zr7dKr8FqWiuAOi/1zvSJimgflRfJ0rYqhGqmeR0Uoc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4158.namprd04.prod.outlook.com
 (2603:10b6:805:30::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 16:13:08 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3174.024; Mon, 13 Jul 2020
 16:13:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] btrfs: assert sizes of ioctl structures
Thread-Topic: [PATCH v2 4/4] btrfs: assert sizes of ioctl structures
Thread-Index: AQHWWRE3zsiCQybFfE+FjxqwUTRniA==
Date:   Mon, 13 Jul 2020 16:13:07 +0000
Message-ID: <SN4PR0401MB3598925D03DDF1C5F418DFF39B600@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200713122901.1773-1-johannes.thumshirn@wdc.com>
 <20200713122901.1773-5-johannes.thumshirn@wdc.com>
 <20200713145809.GL3703@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:3d54:75d5:bb74:f595]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf4cc0a3-30ab-4c23-1acc-08d82747a187
x-ms-traffictypediagnostic: SN6PR04MB4158:
x-microsoft-antispam-prvs: <SN6PR04MB4158AC0706552CBD24083B079B600@SN6PR04MB4158.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GHFNz2YXfa2b6VAbzk4SOGxW3p/UyKKM/VBmI6cGFCJtqJ4NQSym2DBzTh8UgmNKr+nATCqWABp2uxsZ1ZBUxRl2AlBmUA7XxA/UqHMmB0gK5fMxRANewXi3/x+PEYqGHn9qH13M6hOMCrwzaEpOR4U9D5sFkMtY74SmbsQnYmseqZGRiF18UQnyqnhe6G4FbTBVGU2I/6mU/RViRTlWxUW6HO38mvfdBDXRWBoK5GOXgAnig8r8YJT6PzDeh6JUul8nhREjV4z3aPE0ygJu6JudSTV5UUSIYEyjzKmAy+Qob4UNHPJCbbtsh8ZWKG1G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(8936002)(5660300002)(33656002)(478600001)(7696005)(83380400001)(86362001)(4326008)(4744005)(8676002)(2906002)(6916009)(6506007)(91956017)(52536014)(55016002)(64756008)(66446008)(66946007)(316002)(66556008)(66476007)(53546011)(9686003)(186003)(71200400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jivDD2Pio60tEziNWdahJQ+MXvUULiriGXmicXlq1DGlgYtxwaxEIF+t3CjHa8om0Po6sme3UVVdwOZVcoxWdnrC9pC3njFKvLfxfzwHIm4EfrHuyNQQU9C6uwxdUNqF/EIfc7InkZcNeKF1FxCESnhKjMfsw/f1O8jQVJKH4420KnTmrPVBW1Z2MRsj7Z/egwwmDzC2HGlfTYutiiHbv2EAb/VyQgd13ZdFF4YybtySbL+0i2UE+Kj5WzbjXwZZwmqYzdcn6rfnsfQGa2Rj/6OZlXUqbruXhj9+Q1ZoziVZd4ZdgPy+tvIuubc1JQ1kwxWW+HsZHGqtr3yH3YjRxsvi1VdcjDAUdxSAfPziUvQ2rRmzR58deTBZiHZZsQ/82rNvoTzOP7VwhfpHCmGVPXAkhoGHOz4+aRddYqKBTIfC7Ym37SZxZfSpZoIcjutWKo8CSnh1UCm97bDemhIe+7ydHrbQmnapWinjxmZMFpqbDRT4GWDXXzgcQY/L5Gm486Myppb73Un1wKe4TFF1ARydhq1IIgfyE0lwEJfTLeF+7HcfQsF/MnZGCZRutXH3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4cc0a3-30ab-4c23-1acc-08d82747a187
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 16:13:07.7233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F4BOzdW+xDWEUJ8CDwsvZE1yErmtaJwJEuyyveCphnHWwtIktTN11k0OTcnGrwF/bjcZ0YuznF8nJWEZnGyJ3GcYjvxOyUBbz7ChqhYtxAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4158
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/07/2020 16:58, David Sterba wrote:=0A=
> On Mon, Jul 13, 2020 at 09:29:01PM +0900, Johannes Thumshirn wrote:=0A=
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
> The structure size is ABI once it's part of the ioctl defintion, ie. in=
=0A=
> any of the _IOWR/_IOR/_IOW macros. I don't see the assert added for=0A=
> btrfs_ioctl_vol_args_v2 or btrfs_ioctl_quota_rescan_args and I haven't=0A=
> checked all.=0A=
> =0A=
> Can you please add the static asserts for all of them? The file ioctl.h=
=0A=
> in progs should have that already so you can copy or cross-verify from=0A=
> there.=0A=
=0A=
OK will do.=0A=
=0A=
> I'll merge the patches 1-3 now.=0A=
> =0A=
=0A=
