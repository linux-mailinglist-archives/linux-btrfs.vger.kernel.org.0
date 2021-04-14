Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFD235F243
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Apr 2021 13:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348970AbhDNLXU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Apr 2021 07:23:20 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19485 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348955AbhDNLXU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Apr 2021 07:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618399379; x=1649935379;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=L/m3HeoWhmfFg6XnnE7sbgJ9YIAijys1YTOqsDlYS+0=;
  b=HwxzbF4OFdWPeFa8gOgMMlrEL1DF4hH2Ws3IoL0biN+BgHzMeO0fU2Jm
   ZiOfKGFCgp8qJbk7Gzusg0QSduZKHcZBAgEdR79IUXDqEQLTXfrhv+68P
   SV4rHf0hdJYmhIuZCDnUM/+RIDProFgMci8dmuejd7s7fGUJBprDMeME9
   W533Pw4yTD2khhW84/q8NY4kDh/59kUEo5G9Wy2fKsPXCfVVUBFPk9WRU
   C53mCKE7kY/hX/HJA61AQRxalFlqyNxMzJxWGN6iT/qjM/WAi/AFR0qEE
   u6M6nw1d45P8J/HnQPWOy8BBLmNEdmveP15pBoOkUYGvc32lJGT4HbBf4
   w==;
IronPort-SDR: cAoatpmzs/wLPxKlko5vc56olJHw1EQZ9EcLN9DX880Rp7HGZrQRIyJrrtMG3xlGFyT1+9dl36
 alE193rRGC3///YBMVRCuk5Q4Ax5nHjRXJKmeRTUm8r6Lkn69DKYXZzxrvYqDwis8aEyeOMxy2
 T7yrMOekD/HX2yPXXKt+MSm+TdrfoaQTALXTTN1RS3AQpSZNTHqi0ZD7fRJ7u71RP6RW0z3nDm
 nhCsHPy+uJqQVnHXZZXxRLx2YAS2ES9Oe0/3nNvvHmIf4anBTV4hMz83FQI/2zXQtknpGTGXeK
 Q64=
X-IronPort-AV: E=Sophos;i="5.82,221,1613404800"; 
   d="scan'208";a="169270308"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 19:22:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMHu7vSBcNqtOi5rXnRaOfyuGY9rD7D0JQmCbAVF+eD15tbEzrMO51f4gyXK4P2Wp2tg6dBnf1TRMnUPBnPJ78PWjDubOaaTHDZJVbTVevyOBiI6VRxqPBTRcPAORwz+HOK+Vr7JTjeYZOdt7K1eIh/IMgeVW+RmmrfK6KvLQV4HUNumtTLJQ+n/UOIJHQ41VYRK9HmHfRf2JRJviAeOR66TFqPICl6cdKhmi6wvfwd/9bQXqMRltNo21J/ows5wNkE46fLQ61toVtQPNgccIXh9nYFnNrdzoCWlfKRSQ0ElBH3UOl0zRzR5CgAF+wKqb/rOHRsFKeJfqtTqBNPZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRux4uWNgrXpCiCuIO4L9Rgy9sT8faaciwiZiNLDYDc=;
 b=JLurbdBF1clHiHC/mKSu8Sc1H6H8toCQJNeIXLY/QTPSP0SJc0s56nga8ia9G4aNQYrcmd81u5haPE4ls+Zc+mRWNo3rOqnmWvelBzQQRmLEuZ3LZqbEND3E1DNrbftsQ42yNSZwYUehghWIBbR3J24Z2cuXy3/yugSkjmlwzfTPu0hqUjYXozBVK1c9sTETUHPZUATqicnRAFZE7TPFu7MtAPq+D5mUXk0NizU6XsqXtBZBH4zPDGBqj+ES7W7RP+pzqagDjaRzg7A7N8VRLBbvxnAqDfUoZ6L9/R+G5geiFCKzmka8F+tHR2M1K2KNMtXHIVp7oanAyhnRn3o7zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRux4uWNgrXpCiCuIO4L9Rgy9sT8faaciwiZiNLDYDc=;
 b=Zvr0DE3MfJL1G9GLJirUklmy1+3Ovq03wmQ0gWAACXDixhVmuTO59Tdhd2PWnx1sPsDtBFRsGISLsDGM0sFUctf4nStV65c296kcvMJ6VBLslmgLWrEFzVXxRdJvuOn7hwCExcQLOVKu8qFR6yuORhy7l3kJLonRPwx6snYS9w0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7351.namprd04.prod.outlook.com (2603:10b6:510:a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 11:22:53 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d%6]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 11:22:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@gmail.com" <fdmanana@gmail.com>
CC:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v3 1/3] btrfs: discard relocated block groups
Thread-Topic: [PATCH v3 1/3] btrfs: discard relocated block groups
Thread-Index: AQHXLS6OQPw38ZTTm0ORPeiHMuNyDw==
Date:   Wed, 14 Apr 2021 11:22:53 +0000
Message-ID: <PH0PR04MB7416EE187963A0D7718D57979B4E9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1617962110.git.johannes.thumshirn@wdc.com>
 <459e2932c48e12e883dcfd3dda828d9da251d5b5.1617962110.git.johannes.thumshirn@wdc.com>
 <CAL3q7H4SjS_d5rBepfTMhU8Th3bJzdmyYd0g4Z60yUgC_rC_ZA@mail.gmail.com>
 <PH0PR04MB741605A3689AA581ABC6CF3E9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAL3q7H55vudYBNFGHWWuWCaeMLuVm8HjbBsmTYD7KQP_dKEKOQ@mail.gmail.com>
 <PH0PR04MB7416DD1B232F797944ADD6EC9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
 <PH0PR04MB7416807F6FA29B03EF6A4A7A9B4F9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAL3q7H5xZLhHrBPJb5jwe8ZxAv=XfFC05kcw5-WqBySQP4uTBg@mail.gmail.com>
 <PH0PR04MB74167FB19522DBEB1F70E80D9B4F9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAL3q7H6Bgqkdf8Z+xRBH8C=XxtrGzXyNUf6BHaLw54LZb3Agsg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47ac0b3e-e7d0-404e-6c63-08d8ff37a574
x-ms-traffictypediagnostic: PH0PR04MB7351:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB73510F3E5B67E6041001F1DA9B4E9@PH0PR04MB7351.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YC8bHU2r6ZxoX11PQlLxM+KxLzL+p+dSZy8xEiIzVjWQ+1+M14vth1XPB33rLcnxFGoz8/P+jJymyYEWEWjO4pjCvv7GggbQ1FENqwCHoSSsxEauuDecMQhcvliWZsuXx46C/OAFHEjh3SOQTVfc9xthHu526XuAaeA5DTByhMxFRrjwoBlekYgIPRcm1Xl8WXTQ1sDxwmpbpA1IO1DemzEDECMSdZUA5R8diA/ygJrMVbFe3iuYcdhX481j//wRuXIhpqp5VgTO8shNZMsuqYpRxaFRC1QZAlunR5QF5H6E6f4pxPs60reVWrTmYJlUVw5lBtYD6lsKkuTkk/4Ee5RyZdDgedElrjQENzhrBA3aEJNOlyOSFU/TGKJBiYFZ4DT/AtegQB1nWUUP1CXDIG/WQreHwvkwOBV9GkGVLLT9QQZ0RjsjN+BZ4YYkLR/oleBlVQrghbKUpCiizervCniZvD/BOTHRZVi5g+vI2gVqk18wwhIKJwR36ve4YVaKC5DgORUUhMxa3n9fzcm7JygoyELqVN9NM3GYL5I3Yz50m5xvP0ZwZuU2Y2ZyJUKQZFQYsKDORQRSdhKKFSPUsTmrKAF7Ne1JiIH3y8X/MME=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(38100700002)(9686003)(54906003)(316002)(2906002)(52536014)(66946007)(66556008)(478600001)(122000001)(5660300002)(6916009)(26005)(53546011)(76116006)(71200400001)(6506007)(33656002)(66446008)(64756008)(7696005)(66476007)(55016002)(8676002)(8936002)(186003)(4326008)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3jaEpl/nAfSlxysspaIWCUADmrh5OR3i6dC2REbx86WSiCJ6/fr0XFCvxkxy?=
 =?us-ascii?Q?2yyIsw7MEohBlEhGLrEU8OBtQ2mOmXDuOWsjscCrNLAzoIoYNh7SYCKNJeSY?=
 =?us-ascii?Q?j4EV4dIoK75Xh9/zCPKtE9SWdMViXdBdiuxnYZq2wHA5e6AbaKItnjU6QR7s?=
 =?us-ascii?Q?108s5V/0YpFLOik+y3CRT0pUUG+Qro2b2+VI8YWeOEYFmWruy1fgN8Uqv2gv?=
 =?us-ascii?Q?NZw9XEONVEdcMnWcsS2owap8y6odsbe2FiSjZtEdcDAmTgcFQWZrPFxOnxOp?=
 =?us-ascii?Q?OIfcw06TXzRvxejq8GlyAHkjYWOlKf+Ynq3S4S5D58GEaGC3+A+Gw4KYwcsw?=
 =?us-ascii?Q?ztQB1Jh1uqCvFFhmAWON5KqFXhAB4iLVuBSOO9bv+r7gM2X/DfHmA03mr73/?=
 =?us-ascii?Q?Ga9nYsVaPi4o6fPO/eLLRPBPmLEWFD2EpUEQqghBVqUQCxou7Vt7dyC9z/2C?=
 =?us-ascii?Q?KpbOeShFnsvBP2zxlEHrniOeWVu3KiUb28wHn9mDNfIWXtlylaS0xc5TsDa4?=
 =?us-ascii?Q?fltgzLkZOWCBZRRAcP/9FkHLyBZmvhIwpZ2ougwEx+3vDQzitXu+KMmGM3C9?=
 =?us-ascii?Q?dY7Vt6Yv467cfnnvymUQxkD+VoMm9XqonUBLGZSvNeKxh6pHlsXkES1JCywL?=
 =?us-ascii?Q?+osjXscZLKlHy4qL9tSTP42TSTpOXFp4bGu14ZcHW6lsJs7yYPNUqa2J/v8V?=
 =?us-ascii?Q?imGcoT2e9MnOkWhBTXto6138oWlQtVzWjdxSiAQxW2PZEM90uNa3JkH4fYkw?=
 =?us-ascii?Q?xXwFnKr9sQn0HkZ5ubzdIXeDu/JWQqlKwGzboSvxeTvmEdq85cOFhU7qt1/y?=
 =?us-ascii?Q?XRQnSg079ICHn3xf5IiZrRyg8tlyO3R0KhxJQ/+uQHD98OYliCGBXEz37xmm?=
 =?us-ascii?Q?btLWOIAn6eD4ePgu5f9yaUU8wNVsziSsf7197rdH7ZweWg/6CMMFdEQ0cgW5?=
 =?us-ascii?Q?75Jh/UJZIOrxqJyQkt+L85PCZkffzpTw7tU3Y8SvZuUU4j28DE9ygXNBO6KD?=
 =?us-ascii?Q?VUc8IP6To4Nxu0mzYb72i+5pnPi9sTJlO94WNUdtguCxuS3pQwjuL/I0j7hF?=
 =?us-ascii?Q?mczbKPXq3EKW6EOHRMmQjY83INqEfB7iNnBp1Pubo0lmEcrF/nMw/nlb7Qrw?=
 =?us-ascii?Q?VYDGxRev0kSi00tAI51a9rjS40x//Nfs+VXVa0+8iWY1yj5k2BXYHV4g3IQr?=
 =?us-ascii?Q?4yK5zL/KMes8g+287jscnlvlJYhfOwLyIJNxQXgrhe50JmxTRZVbVc6gwZ2F?=
 =?us-ascii?Q?c8i+CNyHpvkw4wB2wsVJ/lt8eVvh7M+YbCWTSvPqFpNqEgGZKVUy2CtN6jxV?=
 =?us-ascii?Q?qfM8tg6LoXCnqCQfDGTiAo9+pSfzAnzOABlRapzPaNPPMw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ac0b3e-e7d0-404e-6c63-08d8ff37a574
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 11:22:53.5307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zNPZ+kKx0Q6pkRCLnYnRCB9KCzCQnAnGmJO4AnsYnr4tGjZ5+7omAD/sGOWWONHpi4L8mQJZBA9TyTOHTXZ4i/jDNjNmqR26Vx/fFSr/H/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7351
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/04/2021 13:17, Filipe Manana wrote:=0A=
> Yep, that's what puzzled me, why the need to do it for non-zoned file=0A=
> systems when using -o discard=3Dsync.=0A=
> I assumed you ran into a case where discard was not happening due to=0A=
> some bug bug in the extent pinning/unpinning mechanism.=0A=
> =0A=
>> So the correct fix would=0A=
>> be to get the block group into the 'trans->transaction->deleted_bgs' lis=
t=0A=
>> after relocation, which would work if we wouldn't check for block_group-=
>ro in=0A=
>> btrfs_delete_unused_bgs(), but I suppose this check is there for a reaso=
n.=0A=
> =0A=
> Actually the check for ->ro does not make sense anymore since I=0A=
> introduced the delete_unused_bgs_mutex in commit=0A=
> 67c5e7d464bc466471b05e027abe8a6b29687ebd.=0A=
> =0A=
> When the ->ro check was added=0A=
> (47ab2a6c689913db23ccae38349714edf8365e0a), it was meant to prevent=0A=
> the cleaner kthread and relocation tasks from calling=0A=
> btrfs_remove_chunk() concurrently, but checking for ->ro only was=0A=
> buggy, hence the addition of delete_unused_bgs_mutex later.=0A=
>=0A=
=0A=
=0A=
I'll have a look at these commits.=0A=
=0A=
 =0A=
>>=0A=
>> How about changing the patch to the following:=0A=
> =0A=
> Looks good.=0A=
> However would just removing the ->ro check by enough as well?=0A=
=0A=
From how I understand the code, yes. It's a quick test, so let's just do it=
=0A=
and see what breaks.=0A=
=0A=
I'd prefer to just drop the ->ro check, it's less special casing for zoned=
=0A=
btrfs that we have to keep in mind when changing things.=0A=
=0A=
Thanks for helping me with this,=0A=
	Johannes=0A=
