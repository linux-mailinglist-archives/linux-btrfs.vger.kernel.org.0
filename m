Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754B235DF28
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Apr 2021 14:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244885AbhDMMpH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Apr 2021 08:45:07 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:58275 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344326AbhDMMob (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Apr 2021 08:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618317852; x=1649853852;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=khuKT7PnZjN0QWDC/mg/3wMATRMaezSRy6Qye6UBHVI=;
  b=CEit0KyeueWXSe9cdyyYdPw1nxkilMFm0efbFGY7Ri/Jstm0CCUsoTgS
   RlrOTWKlxtMdUdBPrdVyhL5GyAo6XNl6jFeBYLWXWVwXnH29UN4j7UKLK
   2lb/tYiBKLj2xN5SvJLCbpKlSYE1AQItc40BEl8FYxJcIYXH2NBaOmGD1
   k80kEJgJLPUFLWLvsj5JHPlXb99AGiECWXmZLuW4LC+YD6lki6kPaYJXP
   Pe0T1S4CuutfALWdzf5TFH2+NA76iKyhw4xWWoviaP/lVTADYIq8EAbZK
   OS7wFNDybUc7Ynxi8cQcAHUUa1HqO8Gp4ZkCNeQOI0+hExxHsG6lhIYUs
   w==;
IronPort-SDR: eoFdxiKNN8du9o2qZB6Y437xAM80B9NbbGta0uRSya5GVLmTjgpq9tJLpVBZb8xES8DLIHM1dN
 /XSEv1+EgdQSoi7gsmRvSiD549/f1oMI2Bz4w9GM9MDfF7ZDPqB97Qu5PEZRl6R0qyRVGXLH/z
 QCjYC/9QGPsUpFIUvIQg6qzR+zyVnAzj+0t9mSUd2WVVI1RqwG2kzFrNw0xxfelopa6h7RXT1o
 AHasR8K/ki0/+rwX4k1sKa4w+Z8GWlomBe7A8AtjCeDN4yGqb9l38nxsfkKN4eBGTDr2iL3r1+
 tac=
X-IronPort-AV: E=Sophos;i="5.82,219,1613404800"; 
   d="scan'208";a="165392030"
Received: from mail-co1nam04lp2056.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.56])
  by ob1.hgst.iphmx.com with ESMTP; 13 Apr 2021 20:43:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARsxIak0T0zXkZkZaOKhdWzBTV8BAx5prj89CO+ck+Pe6zG14aPfrVgCPgB/cJAUVpj4KUBN0nZ4bnMsaT4cukTq87pxNKrKJRFNxziJaoT0HzGk9zmcNSUOAvH4CKBd1G2AOxWeNvUwqj7QQoRkwKT2FnhuojLB/xynKdZMi91aP/eWd3xjBJqpegKpX2kdH4dOCt2QuZJnJTIWx5n2XquZxGpEGnckJmwYSLQn6bSQoBrVXVcdwTkKpM/b9n9lGE8YSBMIswl5qneEwABN46CVUMN/BscmHuXlSA5QRp8GwSWgMGZU4ybcstiwehdox/6OEtYPeLh42dUdudmGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MksFjEN+ldw7uumEy3SFrxfQhV0HLmADAjCIWsHLYiY=;
 b=MYw+O/SizqdXIUKzIZPrK6Ooq0NUlPRdlI34SJT7gpI7xHU/aDc27Eo7aoSGP7OrMyAumwh6+YaBAY1oH7XuxAjJPh9zDH9p7drRZ8ncK0xqhEkFvLA5wu6TZ02sVPr4a6M0odsWbl45Q9kcbgzObgUK49EPOeVt0jua9PEXD5YjTimRGf0dRM22e1cUVq51mUjhbS6sxDfhFdtTa9APL9rsKtxWgwR7zp9UwfcrbhGatQ+ozGzVEzpt3dPqggnVO+AEv3ihzoBhfwp10g+3IxuW25lKL2qS6/paNnvVCFzGath8XN6AZOOLG6SRYPfd+Y6oLfB2Pz1eNDkWbj7g7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MksFjEN+ldw7uumEy3SFrxfQhV0HLmADAjCIWsHLYiY=;
 b=QUdrwi7Ida20UDLe95TJRP8icX9Akn34Cbu5R9t7hAsCYTwFegoGfiqP7auDu2lVJ7IiH5SuR60Xx5i/TWqlXxro+nMYFpdpfpaauxnwjyITK/SmXvUFjvd69RGcjfRDbcsic2zvul/DwBYhO7FD332cQpXmXlkLWhRhPoeobdU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7192.namprd04.prod.outlook.com (2603:10b6:510:1d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.20; Tue, 13 Apr
 2021 12:43:25 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 12:43:25 +0000
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
Date:   Tue, 13 Apr 2021 12:43:24 +0000
Message-ID: <PH0PR04MB7416807F6FA29B03EF6A4A7A9B4F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1617962110.git.johannes.thumshirn@wdc.com>
 <459e2932c48e12e883dcfd3dda828d9da251d5b5.1617962110.git.johannes.thumshirn@wdc.com>
 <CAL3q7H4SjS_d5rBepfTMhU8Th3bJzdmyYd0g4Z60yUgC_rC_ZA@mail.gmail.com>
 <PH0PR04MB741605A3689AA581ABC6CF3E9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAL3q7H55vudYBNFGHWWuWCaeMLuVm8HjbBsmTYD7KQP_dKEKOQ@mail.gmail.com>
 <PH0PR04MB7416DD1B232F797944ADD6EC9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 158e547e-1891-4552-59dd-08d8fe79bac8
x-ms-traffictypediagnostic: PH0PR04MB7192:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7192AD859300E5D1D37043649B4F9@PH0PR04MB7192.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: um/Pd9vXpOE5Nbt/72RTrEwhjjiyFB8FKMgAbA4vtOfSVtzlde2uJARaTtw/U7yu1hQOyXo8EvbTXLZwteDu0Q7cK6wErMcTfNCvZiMv/9rMD3UlGIGgD8+3Tne9/cX2SPvZGju9MVlWULRd6ubnh/DaXyP+roooAI2gYpe5keAyoWeiyz9cbi0IZLdoxJXjenTH4nvOgty3dZht/SJsS6vREAoLPzlC42Bu5BHgMAf5eumWoam30NVsGRqsGzaE5XTZTUVlFwji72TKQrZ7wReuuuyR75xJTCHgR4ha/t/Nd7S2zTf7lkwhcyfQ43rEKFHdQpCA5fyxCrrZS32KpQXeG2teNs1G6LAFVP+iYCNrCX7K4AxntCsl4xATU6upexvKLCUKzouKwzF6MLlaUVXHsqcS7vG5z0yj9pPiJ8TLSfqFSuptM/0Fe4Ksk41c9MhFT6VDYLNfPktYy57OBhANGxIQaRY2bTHikl39r3ySuVU+aP7kR3uPJCIloDBSRABoQMtW36uSyefDq6N7lP/RzZ/tiH4dlgrrgf9TjcCRnT3LZx3cyf09/bsIDioQ1PgWJw19P4JSRnATWmdbENzxFQj5MFVnhzn/1IIZcog=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(71200400001)(55016002)(498600001)(9686003)(186003)(8676002)(6916009)(33656002)(122000001)(5660300002)(26005)(66556008)(4326008)(7696005)(86362001)(76116006)(66946007)(54906003)(2906002)(8936002)(53546011)(38100700002)(66446008)(83380400001)(66476007)(6506007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?f2MoXVhaadnSKuLc3CV5sPsXWE50bGPqgSPhZQKIGcmCyM1Xiyllu6vW8iW6?=
 =?us-ascii?Q?b7PuR+JLL0Pi9cFy8L5T5LSNvtc5agJxhctqer62n+t/RVZMfKJAmbVy500q?=
 =?us-ascii?Q?j0sXWpESyP4VoAXWhr/UvTU025jeP9Lji9jPVJOjUURCujgyteZCc9Jetf9L?=
 =?us-ascii?Q?s+1qM3bxWY2ui9FP7yun2vn5AigWdLvhXZgOKSPMUwni00EhONEAtEkfxbnr?=
 =?us-ascii?Q?A3WanDnSb8Tkp+4bQkQgR4fNuufNJM3NUAm7m8ayEzM6U4VSlEdk8BD78Lw6?=
 =?us-ascii?Q?/uaOqOISTmC2dZQqBD97g5KrV4C134JtBFZxb0OxV3y5eZcArHaqnp8nzxx2?=
 =?us-ascii?Q?7pSYaWlRiZ7cWbd6imfs8M3hLIJUcXSNgiB+8nGLAbU0/2gVnFHYQ2SvLnq2?=
 =?us-ascii?Q?bgpnuxPM4bD4ASotcDSF6i/UOuLzTduC2mvUfnGQ5AFWdk9+sm+J2IoIZqvD?=
 =?us-ascii?Q?zPwNRLzAKhvOiee6Q/+F+CVVtrK6oPYXcsYRinN4y9bKxMGJ/G0VOZb4cmRn?=
 =?us-ascii?Q?aEPZqZgu68Mn1pl4tB2wsydbzdGkTFoRkzj5NrBDYEO/Eu5uOvATEUfYttEM?=
 =?us-ascii?Q?yaQ7r2BfvH6xrwm5DtyB6SUzPsC0bUxYw6VLHxDaLeJEo11r0YM6V1abys4n?=
 =?us-ascii?Q?aW5a7xglTnWXPZttVQJMlH3Ubqh05JIAzMscyHF3xippxSKsEPkoLAG5RBFa?=
 =?us-ascii?Q?3xCvy8El56iJo+bhwiCBU6WxZ2riuq1/AN8aZbNHPv65EyBQs96GGz2zIjwZ?=
 =?us-ascii?Q?jBAGR7/FZxu7fIhRRUAa5MShBHBfoUe3NWksg3NnQKCBDxP/DgSjFXqfuqcw?=
 =?us-ascii?Q?ZC7ZLH5NnRu4sQv51X9rnYArBeeRuK7Z0Uj6kISShRvRwWAWL0zIWbxiD0Im?=
 =?us-ascii?Q?X78U7XBrbxQG7ro4xFSTyu2+ULjyRWJCSy3GJvpvJ4C9DD0EndEbxX0wl3XQ?=
 =?us-ascii?Q?05+LUAca4FVzSXM+lB6Jb6k7FnIFq7Aj2QP2xkZ1GOWkoLmI9SoT6lFExQsh?=
 =?us-ascii?Q?p37ihUL0GnzNdOLwV2PZBsQtYI1Zms6pKJ8SrlXyNs/O0rEd/1mfu1tmk9qm?=
 =?us-ascii?Q?Re1vCNYQmtdqPqS3TgGpYMbRxXu7gBDU4kZHRKq0Ypfem5jEv+tFVvfIomSU?=
 =?us-ascii?Q?yzK8zj5nWBexMhNcK/KI3NARaijVn7WxOPPVb8elpeqAhaWLSPdukDmuroTw?=
 =?us-ascii?Q?P8f1ykLiGo6bS6eGXJPMh/hQU3xRdfDPaxyhIFpP+cAZ+oJI/utYkmCZk8qz?=
 =?us-ascii?Q?dh5kX8iwb1JffxsqqWbM6MGu9asRHitv9hjvzXqV63OE8MymeWxGZmoFze8d?=
 =?us-ascii?Q?U6QyupC9wfsoukQ11cNR0+kH58liI75PoET33sCGt6zwWw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158e547e-1891-4552-59dd-08d8fe79bac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 12:43:24.9402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X8QP/wqcRFtI8MgE6B8jSvhyHVFtL5aR1YAy1zZjUK3JJ+ANxdN5PpO99i/rLABGMU3tW+zAUMI0gH2904+Z6t45CMWl3A+gk5RgZS1Z/3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7192
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/04/2021 16:21, Johannes Thumshirn wrote:=0A=
>> If it affects only the zoned case, I also don't see why doing it when=0A=
>> not in zoned mode (and -o discard=3Dsync is set).=0A=
>> Unless of course the default discard mechanism is broken somehow, in=0A=
>> which case we need to find out why and fix it.=0A=
> =0A=
> I'm at it.=0A=
> =0A=
=0A=
OK I've found out what's wrong. In btrfs_relocate_block_group() we're calli=
ng=0A=
btrfs_inc_block_group_ro(). btrfs_update_block_group() will call =0A=
btrfs_mark_bg_unused() to add the block group to the 'fs_info->unused_bgs' =
list.=0A=
=0A=
But in btrfs_delete_unused_bgs() we have this check:=0A=
                if (block_group->reserved || block_group->pinned ||        =
                                                                           =
                               =0A=
                    block_group->used || block_group->ro ||                =
                                                                           =
                               =0A=
                    list_is_singular(&block_group->list)) {                =
                                                                           =
                               =0A=
                        /*                                                 =
                                                                           =
                               =0A=
                         * We want to bail if we made new allocations or ha=
ve                                                                         =
                               =0A=
                         * outstanding allocations in this block group.  We=
 do                                                                        =
                               =0A=
                         * the ro check in case balance is currently acting=
 on                                                                        =
                               =0A=
                         * this block group.                               =
                                                                           =
                               =0A=
                         */                                                =
                                                                           =
                               =0A=
                        trace_btrfs_skip_unused_block_group(block_group);  =
                                                                           =
                               =0A=
                        spin_unlock(&block_group->lock);                   =
                                                                           =
                               =0A=
                        up_write(&space_info->groups_sem);                 =
                                                                           =
                               =0A=
                        goto next;                                         =
                                                                           =
                               =0A=
                }                                                          =
 =0A=
=0A=
So we're skipping over the removal of the block group. I've instrumented th=
e=0A=
kernel and also tested with non-zoned devices, this skip is always present=
=0A=
with block_group->ro =3D 1.=0A=
=0A=
Also the auto-relocation patch has a problem, not decrementing block_group-=
>ro=0A=
and so it's left at ro =3D 2 after auto relocation got triggered.=0A=
=0A=
So the question is, why are we leaving block_group->ro at 1 after relocatio=
n =0A=
finished? Probably that the allocator doesn't pick the block group for the =
next=0A=
allocation.=0A=
=0A=
What am I missing?=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
