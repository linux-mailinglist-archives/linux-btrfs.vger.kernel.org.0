Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EA3357460
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Apr 2021 20:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238828AbhDGScB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Apr 2021 14:32:01 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:22012 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhDGScB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Apr 2021 14:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617820311; x=1649356311;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=kyJ2wsLUjFQat0FbU68mudCn6Mw/g5pyvPLypNwiUAw=;
  b=ciC7Uc+ZCOcWOn0c7K/OBLBbyayrq1eW1oHMOxfRjrthOy9yIDIX7Zgp
   m/WrC6/ZDqcPCzRaYe4nJ/ezXSISuXokhb5mH3HfF/KAnX/rtGZtgjmUE
   7Gx6a0dRGASdlOfZQ1NE28vuqCrGB724y6uIT5WKbjnkWvLxiTFDjDeNO
   val6f06n7e4q2Jr0xXiNxA+f6Bd8mK9fcb4NRjcMI/ext5DcsGGp/OeCa
   vAHDU+PuzkWBZZh2nOpHfxcXdqcKuoHdkrdp2syNeUl8GybzYJ8FwMEiW
   WqVM1i4JWrQ7HVhlINWjkiiVfMVt5EhK3WI7LwIzPqq2rw+lA03OYzsC5
   w==;
IronPort-SDR: a5A4pyzHQWqOcY2Yk6XdMNC0ogp8MvpAwXOaEsumHsrn+dG5riIM1HWRBIMWp/kxMzMVcL1A3s
 4nQzLbHF1Le5o0AWO19Ty76uS2s1dV7f81vQNhjXH5SvuaTaaKyD2C9Em4+Ag/t/4W0jSF+YmR
 Lq4u+f/smL8CmnsYOrZ4csoPp6ViAI5or93POvQndRapPiA5GamlKB82RMvZtnlSigQbBwDFTq
 jASXddZv3y3FELhQjbLjZOyTQWZnqxXYBPg7wPHoykIDmw7RTpOshM7hhb36n0ZR/uN5QW2yWm
 mVo=
X-IronPort-AV: E=Sophos;i="5.82,203,1613404800"; 
   d="scan'208";a="163854989"
Received: from mail-bn8nam08lp2048.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.48])
  by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2021 02:31:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMqbZMFjkrI+42UtOMj32yn3hkKqJN87Bn8mV/o1mEXsb8pOGmLqt1fq0H4AeosQ8b2N+6DXQWrjNa3fpzFGgAi7VFJLpM6MWoH03weHGIV6KFwT8TJRSJsnWylR/14Qv0xVDJE7Z0UuENQYOk/fSUhfUJdRa6cEXak6PWGX3VDRUkK89/p/2E2Na6uc1AVfgCq/RRe2Jd4cC/6yvexRa6bnFCRzUhNdCFm+b21IY0TumcEDYc72k3xiwN8ekYShUDxDk0TXbw94OnLRYHBuZdWUk33AVEQ2i/lkNE4UHd5m5LMhXFRzkvZgL38oFdlNPLBlTGngQb45U7ShL+dlZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtDJFsO3CKLrsqKS7K+sqe5MxsP+h9PBU4kG9sNZsjc=;
 b=RcOUJ+JJtB1Qk+D68x1XFBBSnGwRC93/Cq2s0CVSnZLzCkYbrXyv/0PyZguK33EygRspNqFnElieVssp5UyUjus9E6RB7o51IDAgVioD7M2dWKbnBHakSNziRerP4u4IvoDYxha6fprZe3gDpGeIshuzLuIPoSKdU3SCdxN1NAFsxdWB67+BoeOsych2EHHvNIKB+qoq8NZdq9T+RBAxvaKSOEtif8mSPDLBbqK+C2yvbCnNhsTLZIS7ljlNeA23utuxPcJ/jcna0COaJZHK8A+QwjKKPaxnetk4Yht0+swQB5/xzvhMCRiCsTaP6vOS6c1Ds0Ar7tAYsPR19dEo1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtDJFsO3CKLrsqKS7K+sqe5MxsP+h9PBU4kG9sNZsjc=;
 b=Tf3ssQLPZP709iR3jUGTbvwbVo0QE1E2svhVeTR3WDJm+/ZoZYQeoBkqZkbMvhFPbm9Kugqz09wftwvMu4vmOGpQwsvzu/GRlDkoeVsjpvSOreDyjJjE3ft3EGOANMcY00pcUFbZ2Er1M87vVvd5S2lelu8gvRUvQz5jqQJIrlo=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SA2PR04MB7593.namprd04.prod.outlook.com (2603:10b6:806:14b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Wed, 7 Apr
 2021 18:31:16 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::d5c:2f7d:eadc:f630]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::d5c:2f7d:eadc:f630%6]) with mapi id 15.20.4020.018; Wed, 7 Apr 2021
 18:31:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: zoned: move superblock logging zone location
Thread-Topic: [PATCH] btrfs: zoned: move superblock logging zone location
Thread-Index: AQHXGV/Q9cRb+mZCUkOVzV9kTIcRjg==
Date:   Wed, 7 Apr 2021 18:31:16 +0000
Message-ID: <SA0PR04MB74188C3D3453ECFCB504BAE99B759@SA0PR04MB7418.namprd04.prod.outlook.com>
References: <cover.1615773143.git.naohiro.aota@wdc.com>
 <931d8d8a1eb757a1109ffcb36e592d2c0889d304.1615787415.git.naohiro.aota@wdc.com>
 <4fb00423-af48-49b7-c39b-3dde90289064@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52de7865-10ce-4c4c-f1fe-08d8f9f35479
x-ms-traffictypediagnostic: SA2PR04MB7593:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR04MB75933A5369E9047A2EB6F7F29B759@SA2PR04MB7593.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WrZCpxoSVOUQQBny+xvjBGLrOpI0KEYqHP7+BZ1FXEw9/eMdXW0gzyiY4QFLqOBS9r62zS/WHMx3RTx9EATD6VHCF8OJq9bxdUJnnFRTieYFmMl53198aDpZNLdiyiGUFOzSztqzv4H+vs6c3B+Ia03zsRAG8cEp7fn09vEPWm2ho73mSDY5yZuuHnSwKSSR+RSbwgsK3RzEKFiO2XisBYZYZa6NXGuPweZ0DkSv8+cYXLtT3wnfkyKIaYofFWgiKqTfjR9D1P3BZlizPsBf8h7PDzM7AFuRsRGvR8WNKUVQVvY6EmERYxTC8R8mDjfRjKnAw0niCc4KADPX2qAZ0yfKGMDHTzPiTu+4FIj8WCsg8H8cF7IUD37uUzW0v04aIGieNddnQDKt72t8Bru8yrNqtAErNknPTGlZtD7VNkVJdPfelH6R/odOBn1HZxW4cuUDElcpFKa8CVxv6W3KRsI8aAOavR23kf2lSCTJN7KpYwqh26pi1isFI7Adr1mp6359bnSWBb9HYIrfgvux6YJ3nOdDphwhw2L2R199OmN16QFCQhtrhrLucXg9cH/wGKJgk/D6+TaUvkMNY3dYJ5fgbAJB0vniioU/oM9GOsvC3EKysEVekTYKOAz/TiiLfby0yI8ToBw32QJavrgoY/FXiMlx68XSCN/yl8ePRrQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(9686003)(86362001)(478600001)(71200400001)(33656002)(52536014)(316002)(186003)(38100700001)(8676002)(8936002)(7696005)(6506007)(53546011)(26005)(76116006)(91956017)(66476007)(66556008)(110136005)(55016002)(66946007)(66446008)(5660300002)(64756008)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GQffPahYM3gy6cUPEodN5AZkeifUv2CEHY401yFD+ImtdjLg8+BB0bOrQQVR?=
 =?us-ascii?Q?8f7IteIicxtK7xuYYVacSlTn3ULcyL0F6t21dS7BkeYxLq30zwiWC7tyj6vg?=
 =?us-ascii?Q?mRi+H+WQuM8eID/KXVcnog0RXGYn9Jkj0OI5mU3kkA15IfJpwf7Mh4NRQikN?=
 =?us-ascii?Q?IR7AdQeyqvnMrvSeEN7eS9lilfBmCEl3C+MAOQbChActXRpUXZmAUJHoGCjp?=
 =?us-ascii?Q?o5zl+zJDy2o5Y3frBDS+vhaLM/j5XW9aBEL+jq47gHkroGHxF/fgY+Nk8gEj?=
 =?us-ascii?Q?X0AoFcEOb+tGsAMkqU7M3M9CzR8vrSZ/WI6hIHXdE3g3ldqTs+cvaw98jzbx?=
 =?us-ascii?Q?/zIT/BOg+v1ZFAuqSAqLogiCx//rKBMULd5IWUaBKt08YCTqMPG15wE5C27O?=
 =?us-ascii?Q?m7fau+1j0qzERz9K/Jox/Dou4iv0QQ+ppy9bjJsiPwHVB2UJF7cI1fc/wV9m?=
 =?us-ascii?Q?mSVMkSevkAONQCOtj4Uis4I9atJFvfQts+SCPBVGr6rahQhQJBj19Z6PCF63?=
 =?us-ascii?Q?3AE/s24V4gvqJKfZu15uSFWQ21MVp62y+sv9aJrkI2dAn9ILEGGpvFGG31+7?=
 =?us-ascii?Q?FHtMfZ2MArstAQ+HT+sKznSjNZ0USmAX/eOpjTCQr8bSpMwE3F7E5lweQq9P?=
 =?us-ascii?Q?OcRH7BYPJqgXPLyIJPZ9lKm4xZwyxDYjSH6cXIPJMaG0+ntSZqkm7ItwrONF?=
 =?us-ascii?Q?6sWZbcpeAm8OtuH+sSkxuzwb/OKoLEur0RXnJATCS7E4ePSnTtTd3XCaBEdA?=
 =?us-ascii?Q?FfRKcZv8NoXxWzel23ymxv/01X8uez4LKFquxpAKCoRIEX5RbY5oQt06kqwc?=
 =?us-ascii?Q?33/1EP7dsrQLr4gY7Cff+oBPVga1BYesv7sfdWSgTYnSi0Mr/V/jfHvcBdM3?=
 =?us-ascii?Q?IXEtWNxbXFFPIjZijm9ASa0JX19gGlklE922qbHWhEwnAADoxVqYPzt/a2rc?=
 =?us-ascii?Q?B7YVbXKkW6vKUOXrYIOlrnM+7ojhKZyVvxCZV2UT+rgUr7KOrdsTVyWQwKlf?=
 =?us-ascii?Q?2a6n2h5Fh42CrtsAnagH87gYq1Z47vehBP1WqiTk90RZLc/3OUJ1YpKr9uIc?=
 =?us-ascii?Q?ZJcFUx0lI7paXFFXdrzVH7+KiT4tKjWqVWMjCZkMAJ2evd/32xt7S5rkgHbP?=
 =?us-ascii?Q?DRX/UVCaBHFg2Ud8jXzOzeqs1V8bg2zhJ372tUg1EkL6MPwUbUHSJ1CPmyEd?=
 =?us-ascii?Q?C/XcXLUrh2rsvidR8vTJqY1rFktTuNsKikIgLsAl4uHQ/X2HQM3yi4DBSnon?=
 =?us-ascii?Q?4c+hEEhE2F+4DB1RmLkkbyJf0/cEn5/r+e/Mke+bJR/69BukmLEOOniTMBpn?=
 =?us-ascii?Q?joyXLoAr0Md9V2ws1Y/GQj9XGSaNWpmo02rlU2eoYjzPog=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52de7865-10ce-4c4c-f1fe-08d8f9f35479
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 18:31:16.1497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X+bBjpkfb3r/qVEYcZ+v/zxr83dfraHW9UWXf6++uby4aGQ/qN+wuXSF1V4rT6+0lFyqrpVoKzXkzjvaDuxCaMj1bJX6xJZ+N2/sKW0GON0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7593
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/04/2021 19:54, Josef Bacik wrote:=0A=
> On 3/15/21 1:53 AM, Naohiro Aota wrote:=0A=
>> This commit moves the location of superblock logging zones. The location=
 of=0A=
>> the logging zones are determined based on fixed block addresses instead =
of=0A=
>> on fixed zone numbers.=0A=
>>=0A=
>> By locating the superblock zones using fixed addresses, we can scan a=0A=
>> dumped file system image without the zone information. And, no drawbacks=
=0A=
>> exist.=0A=
>>=0A=
>> We use the following three pairs of zones containing fixed offset=0A=
>> locations, regardless of the device zone size.=0A=
>>=0A=
>>    - Primary superblock: zone starting at offset 0 and the following zon=
e=0A=
>>    - First copy: zone containing offset 64GB and the following zone=0A=
>>    - Second copy: zone containing offset 256GB and the following zone=0A=
>>=0A=
>> If the location of the zones are outside of disk, we don't record the=0A=
>> superblock copy.=0A=
>>=0A=
>> These addresses are arbitrary, but using addresses that are too large=0A=
>> reduces superblock reliability for smaller devices, so we do not want to=
=0A=
>> exceed 1T to cover all case nicely.=0A=
>>=0A=
>> Also, LBAs are generally distributed initially across one head (platter=
=0A=
>> side) up to one or more zones, then go on the next head backward (the ot=
her=0A=
>> side of the same platter), and on to the following head/platter. Thus us=
ing=0A=
>> non sequential fixed addresses for superblock logging, such as 0/64G/256=
G,=0A=
>> likely result in each superblock copy being on a different head/platter=
=0A=
>> which improves chances of recovery in case of superblock read error.=0A=
>>=0A=
>> These zones are reserved for superblock logging and never used for data =
or=0A=
>> metadata blocks. Zones containing the offsets used to store superblocks =
in=0A=
>> a regular btrfs volume (no zoned case) are also reserved to avoid=0A=
>> confusion.=0A=
>>=0A=
>> Note that we only reserve the 2 zones per primary/copy actually used for=
=0A=
>> superblock logging. We don't reserve the ranges possibly containing=0A=
>> superblock with the largest supported zone size (0-16GB, 64G-80GB,=0A=
>> 256G-272GB).=0A=
>>=0A=
>> The first copy position is much larger than for a regular btrfs volume=
=0A=
>> (64M).  This increase is to avoid overlapping with the log zones for the=
=0A=
>> primary superblock. This higher location is arbitrary but allows support=
ing=0A=
>> devices with very large zone size, up to 32GB. But we only allow zone si=
zes=0A=
>> up to 8GB for now.=0A=
>>=0A=
> =0A=
> Ok it took me a few reads to figure out what's going on.=0A=
> =0A=
> The problem is that with large zone sizes, our current choices put the ba=
ck up =0A=
> super blocks waaaayyyyyy out on the disk, correct?  So instead you've pic=
ked =0A=
> arbitrary byte offsets, hoping that they'll be closer to the front of the=
 disk =0A=
> and thus actually be useful.=0A=
> =0A=
> And then you've introduced the 8gib zone size as a way to avoid problems =
where =0A=
> we get the same zone for the backup supers.=0A=
> =0A=
> Are these statements correct?  If so the changelog should be updated to m=
ake =0A=
> this clear up front, because it took me a while to work that out.=0A=
=0A=
No the problem is, we're placing superblocks into specific zones, regardles=
s of=0A=
the zone size. This creates a problem when you need to inspect a file syste=
m,=0A=
but don't have the block device available, because you can't look at the zo=
ne =0A=
size to calculate where the superblocks are on the device.=0A=
=0A=
With this change we're placing the superblocks not into specific zone numbe=
rs,=0A=
but into the zones starting at specific offsets. We're taking 8G zone size =
as=0A=
a maximum expected zone size, to make sure we're not overlapping superblock=
=0A=
zones. Currently SMR disks have a zone size of 256MB and we're expecting ZN=
S=0A=
drives to be in the 1-2GB range, so this 8GB gives us room to breath.=0A=
=0A=
Hope this helps clearing up any confusion.=0A=
=0A=
Byte,=0A=
Johannes=0A=
