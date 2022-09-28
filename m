Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24675ED3AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Sep 2022 05:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiI1D5P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Sep 2022 23:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiI1D5M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Sep 2022 23:57:12 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999321138FF;
        Tue, 27 Sep 2022 20:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664337431; x=1695873431;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uPb9USUcugTKiUyKDHq5wB3TjRbybqcXJDtotJ7qWaU=;
  b=lYVLVuLwGDWZpU+vUg+HjVLsrcmePbpNRXSancMLCQ6Ka6NXnUiT1MeQ
   R5EaapECxUXuLSwGb0kdSVxRbNHQnDSGJHoCx6nDL8VsGLIH1TOHR38kE
   Tqw/YHfLr5I2r12/jVvda7yAtM4FUJtKiy5vDLXUxdWFgPywfnydrdFDB
   9hAMErbot4ii4QrINMDCQX5vNS+eGMBLAXiyWIjinx6j/exsSE7FlUu59
   zhmWeGbN3JilL3WePZyflRR6mJomhDIKvvTBErH+pmd1s3GJrwSzT+WMa
   TvbHWvCv61eo/lY6Od3gMBhVAXs8R+r9VbF6UQEhN9ZOf5fApDKizdah6
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,351,1654531200"; 
   d="scan'208";a="210811676"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2022 11:57:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzMxtaADCQTTMPi9rQGIbI/2wMr5lZX5DPhCdjrpqBnRbMNtus3WDSk122TOaQCZBtCdL9xmEb4SuV/SdCCYmfY1QIe8azZPSwxY7kC7uqniLDdN1Ut23OQCi/d0E+KUS2BxVP+8Qtyju+2EyzWjr0XQiv4rLvh4c6syCZlJ+3P403I7wnzsx1klCFHsADc14fjGAQwKMAxKfWCbFXmK+zjI2cKI3zCUs0WhKTb/oFnd3p2ZguW4XmfPIktQHgD/ryRJIGB28aXJVWJA3ZMyG1WBciy+mvq93be07hhLBlpJDIZ/dYWbRvDOa+lqmP1f0Zbx2BZWiu4O2EhPM3WziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouIBmoMz/wt8Autl+yzOXIklz/fjXR3hK5M/GOZqIe0=;
 b=U3b3CkpggoluukJuK/0LCRrarN7GkKoYXiIw1BPs9sUt/+RRCDM07Va0AvTUnig3QU5p2c7/cKyu+oyfsSX82zE4ASxdht4XGyXPVPun38/uQHgyuVSmWElJOaH1hAEwDhA2or4Jp0l9y2QrTESdP2fNUSBuJONQTN9BLdfDEMQuPP911xvLvKgrJck8xXk4lwz+B9JtDU+ym41olxhw5zZ0cYW9RDYw261iZaeVQ5wj/+i7GJv53wRrNvL+3orohDsrAzCOnV2cTq97QkTXbmBJ8eYXcBo07sUnQ9uPrGZh0yNL1lQO8mHYB79SDapEBtS+LtYd2+ZZojR8qrEWOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouIBmoMz/wt8Autl+yzOXIklz/fjXR3hK5M/GOZqIe0=;
 b=Qntw8v2YuNHjHl0M++VqLuw2BW+j7eMHFgl2Fqkflc+goL4tsRCGQSGiX65hJ5ycP0Dmg/kNZOD16aeFMltDDIUmNtGGcE1iHGdXtg7u+mrNRTOAg91qjSfYl9U/AAKdorUDzswyJ/KSfmmCyhEboAKDQoXzM8Zq4hTcsGUecyI=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BL0PR04MB4756.namprd04.prod.outlook.com (2603:10b6:208:4f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Wed, 28 Sep
 2022 03:57:08 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::11a7:2daa:ac81:48da]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::11a7:2daa:ac81:48da%7]) with mapi id 15.20.5654.026; Wed, 28 Sep 2022
 03:57:08 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Zorro Lang <zlang@redhat.com>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] common: introduce zone_capacity() to return a zone
 capacity
Thread-Topic: [PATCH 1/2] common: introduce zone_capacity() to return a zone
 capacity
Thread-Index: AQHYzkfyz9/9pluCVE+RCPN0eF/VSa3s6Q4AgAdXI4A=
Date:   Wed, 28 Sep 2022 03:57:08 +0000
Message-ID: <20220928035707.v7kv4ult46w3hjlj@naota-xeon>
References: <cover.1663825728.git.naohiro.aota@wdc.com>
 <97ede9bba67f0848fc0b706d757170d7dfacb7fd.1663825728.git.naohiro.aota@wdc.com>
 <20220922154132.dpadkhaccwzysq4d@zlang-mailbox>
 <PH0PR04MB741656D7881D11281ECBBD489B519@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220923115126.s3ctf4erpepa3zy7@zlang-mailbox>
In-Reply-To: <20220923115126.s3ctf4erpepa3zy7@zlang-mailbox>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BL0PR04MB4756:EE_
x-ms-office365-filtering-correlation-id: 99326f88-aa42-4f03-dbca-08daa10583c2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wh198nAx3ZukCWQfdgpoOJx59dGXq90VqVoKgtrw7ZL2/qmK5WxUP5NiXUTVOBZnbj2j5pqq6Tnv5OPJc1LK74HCF64pmyBSskXw+EU2+IE6dvMokXmzBlHDGisl8GvZ8R2xXGMiHb/lnOquE7kcxT/ImnyHGYbfrxLPbDDG9JNFBpeFlL/ZICUUinklsankzqmKtRhNNUyFM1LkayxUodSiDvagQ+s3FR37n6CMSwl8BzvubfNYJQgSfm74hQEFEN682KHCPbid19eZpjjk8ZhN2D0sBgkPrIIB9wMSWaOu+jkA1XgLTGXrnyGFr2V5TyBOp23hDy0VaghdajIVURY7ofMeJiwWCv3Igc1S7u9sdYbIE3tpyg7envPyjyGjOECW3WT0wplhbfHZbe75pfRA0HrXu5lhuQK06xed8jkZSsDl+VVenp/US5SP8OwIJQsAMZU/jzGtXNyE9x8SGRCp3VRqmOBy9RgphQQ9I+BExAbc0rQxJc2q996uOJ51eDn+H/WMX6Rb/T5Npw57Xsf/TK5Avq7wCc5g3VdIPQ/kRKI76IhXK+IK3sQKrZl/Kvh7/m5jtSA7tY57OVBuJ+O5CQCec15KkFzfgekc6JFMObWUTSTyE2Wo9iZDFQ/RbVp1G6Abhrylu941SD9Fcjsn7DXhVaYfQJmnx3L1Ms51Lm7d8gqy7KvKdKAqzoj7x4UwQPMDIkw2kceKZDEiIUh0DAKdMYTkuZrwBXtOy2bGqzXT4laT2Qw1zdO8jxTlDWW12E93pN/E35m49UKWcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199015)(71200400001)(478600001)(316002)(8936002)(6506007)(26005)(9686003)(186003)(76116006)(66946007)(64756008)(91956017)(66476007)(1076003)(4326008)(66446008)(66556008)(82960400001)(38100700002)(86362001)(53546011)(5660300002)(8676002)(6916009)(33716001)(6512007)(54906003)(2906002)(122000001)(6486002)(83380400001)(41300700001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?49AZGiiJBe978jiLpIJwlCmlFi8JDWTTNJR77PsnwQfZEzPfCFjlAttgwhKc?=
 =?us-ascii?Q?454qbAlbu0yiwYwRzCzQDiO7nR5v1hBiPiSYklNdT8HZTz6clc/xWJvMkBYk?=
 =?us-ascii?Q?S3a1AmjPMPXlaY7NKHuu8OZ+Y410n0A15TwQFJMh4E4KTTHNPGPZPAKJmaJ0?=
 =?us-ascii?Q?278bI+xEdXx2lVfm5rRJPLg8C/FBGK4pgIOYqOkXXdlyXKtaKY2V6YuyPs99?=
 =?us-ascii?Q?fCJbvOBKvWdV8cIATRZ16iAwWwIQhurgq6jXHhLya1fL+ySj9/UVrT7TxCIB?=
 =?us-ascii?Q?X4U4wifdml2GrJ816ozuKdRabEWTK8DsomwqWw6uV2PuJw7mnZ6rtaTeSyyr?=
 =?us-ascii?Q?ulxG0rueWRu4iAzvPFTMuEfEprQnYDJOurjzEzc7nhMZ6SRLskmwCu8dzWjT?=
 =?us-ascii?Q?b55ibEVnQjbih64nCbx4f1xvHQ3lhWXA6ydGR6X+rQm6rFNmuIoDRt+by/8P?=
 =?us-ascii?Q?4FNY7z8XHADcfyFB1UnAFRAkWyDXLKoxCKdixROe93VMBL1cyFxzKak/mHpN?=
 =?us-ascii?Q?HQvqEzzNgi2MVbscE1ASmw4mcAwQ+zuS6isDhE88DuQpniK+QwLNZBFNcLMX?=
 =?us-ascii?Q?0Hk3xQl12F4q4FUJHMl3FfflvhAC0RJyYq3QPlC2aTMYQdbwL2RgH2u75vdz?=
 =?us-ascii?Q?ubDelifG1GqEyrqYCJhXXXLUVjku+rGKSmE1MYQD3z7q3EJ72BNrUxUtAmMM?=
 =?us-ascii?Q?5c4STF0Qj2Ywl8cm46vKGKEyLj3jVjreIM4Jn3QjPjuSGVoXoOY2pjVOS9rA?=
 =?us-ascii?Q?SGVuaFWGZA5DvBLQtQy3F61xrl1C9SeH8uBGTGLTUlyoL1JVVzB3UD9TfwbI?=
 =?us-ascii?Q?R+Ev/DVU3LN+uQS9jXtPQqw7pRnGCv8sJVm2H69ZG0C3R/FqEuEzVFLgsYSk?=
 =?us-ascii?Q?aYLC23WqGqc+hw6JvxEgJEB/2q4CYVmB2amUngZS85O0CBume0tUeiEMwUoZ?=
 =?us-ascii?Q?fEaArKFpaRjupC51ZlkO0fKSJeij/+H3JGYl2+LJtZ97wQ9OpPpLGcp6JE8r?=
 =?us-ascii?Q?aXsTGdcakhJb1ZmVUrNuS/KEzAbMcYg1mwFjd3ZVhA/7IoDk4C7lnY/oyAX7?=
 =?us-ascii?Q?b71sZM/wYIvs1LO34Wz3bdHWfATsRBVLItF98ucQc83HgADnkuB2F/TooQic?=
 =?us-ascii?Q?HTdZp3DgUPPi1ki0sq6AwnZ134J00arAgj1V+EmVtQhmURZYfYP/rC9r6OOc?=
 =?us-ascii?Q?rQ1zHCV9kjDyoGHcYQA4+l+qVQt8yJTrCPgWV6Gg+dqrPthK4IRRP+OWEF6R?=
 =?us-ascii?Q?p8yDEywpzIxMUTqXkhZLsjNGKkXU7UtDVVUHL9VVgrJAUs6G2cpHq4J0Qxgz?=
 =?us-ascii?Q?YPr3VXu/9PzXFiCrFkP702ruuVcf7MgdUbCOKSbaAGWeO+C0rKrEVQVxvnWr?=
 =?us-ascii?Q?TyI55RTtfxiDlei1xS0zaagmWhEuMDgzdMMvPL/+oOzTmzJwGW/T2IdMaO4H?=
 =?us-ascii?Q?SBu3PoEbBsDRiq1NIl5GLjQT94XkAyB3YXjgvDicr+zylvwqhfwAWUVQw5aS?=
 =?us-ascii?Q?c/gj3JachhJ5yU6/aba/ORcvo+10ad0e4QWNNY3bgPFoS5GaCDVHq0zATTyV?=
 =?us-ascii?Q?5fdCITnoQC0mvFdYl5MmZfktwPebe3fPB3fggOPwxHUf6EcJmlCcJ6FBy2YQ?=
 =?us-ascii?Q?xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <72D6798C83853945AE659DCEB401FBE5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99326f88-aa42-4f03-dbca-08daa10583c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 03:57:08.3528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zbb3WP1b6f+FbSFllNu0tUq57EE6c3on1ZTDewNp0BVLIeIJSokH88TUuMaffWXmcdMOCYgUzGk3g0WJLfVVhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4756
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 23, 2022 at 07:51:26PM +0800, Zorro Lang wrote:
> On Fri, Sep 23, 2022 at 08:02:10AM +0000, Johannes Thumshirn wrote:
> > On 22.09.22 17:42, Zorro Lang wrote:
> > >> --- /dev/null
> > >> +++ b/common/zbd
> > > I don't like this abbreviation :-P If others don't open this file and=
 read the
> > > comment in it, they nearly no chance to guess what's this file for.
> > >=20
> >=20
> > zbd is a well known abbreviation for zoned block devices. I think most
> > people in storage and filesystems know it.
>=20
> OK, but we haven't been that "a single character is worth a thousand
> pieces of gold", so we can use a longer name, likes common/zone,
> common/zoned, common/zoned_block, common/zoned_device or something likes
> that. Anyway, that's just my personal opinion, if most of people prefer
> using "common/zbd", I'm fine to have that :)=20

Sure. I'll use "zoned" as it is more common in the kernel code.

> But I hope you can move all zoned block device related helpers to the new
> common file if you'd like to bring in this file, likes what Darrick did i=
n:
>=20
> commit 67afd5c742464607994316acb2c6e8303b8af4c5
> Author: Darrick J. Wong <djwong@kernel.org>
> Date:   Tue Aug 9 14:00:46 2022 -0700
>=20
>     common/rc: move ext4-specific helpers into a separate common/ext4 fil=
e

Yes, that will be better to have things in common/zoned. I considered
moving zoned functions (_zone_type, _require_{,non_}zoned_device), but
_require_loop() and _require_dm_target() use _require_non_zoned_device() in
them. So, moving _require_non_zoned_device() will make a dependency from
common/rc to common/zoned, which I considered not much clean. How do you
think of it?

Moving _filter_blkzone_report() would be fine, though.

> Thanks,
> Zorro
>=20
> >=20
> >=20
> =
