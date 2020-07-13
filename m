Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E1E21D347
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 11:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgGMJ5S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 05:57:18 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:8397 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgGMJ5S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 05:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594634237; x=1626170237;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=jFm6gM/RYTB1a1PcD1obwiEfGd9PThhgrcOj6qH9QkM=;
  b=LcDKEcUlpcTY03kB15AkIA1OMOuejOdkXaiRIFC2h+qZRDFIiiroLSw3
   1SUT/9AO/IimfJZljWlLSdo7u3NEcuYPOvoxz//BhDcC4uD+nQkCAZayf
   gPI4suk/canKYqY9sAkkHRGBrsnjxgxTWdwoNBIyF3deAmF0Z3OfuqdYM
   SeN6R8LlZmsB8mKzd9FjkchP8ts/VxoArmwKWlFDHfyJnClr1MEK3iDun
   iOalHuL0NAemWSLj/WGhxSUpruEnHn5xrgwUw+vp2qf2C9AnaA1uAAXyJ
   CRPpzFMRyNjndVn0lBdoCmVmi0TlHMAj3Eiax9Q4yBCItjENMwQBVAYA/
   A==;
IronPort-SDR: m4nGukm86mp98gr4O9FFq9Fz856pl7BRmWRMtsmb6X3h0GrRCWrX98w9LYlxAqpoItrjVtYCEi
 n5BE0e1SliH4lhMjgAMptPpFF7FTGvO5JitSd2nZ6j9J8fYmy43a1fD6RLytzIZ3nqDbUn7mSH
 YFzwxUg7J7qdrFfhnTMwnXcjeEaqr03mFrUc+dDDP12yT8nmTGTcWFsGM+2AczuXcp13n/eE5z
 z217homKO5Vot0ZeT0QcCw85rzuFOAbQhOFAnXb13nQsdd6OCnhlQZJk0XMVQQ5aG2/5XTgjtc
 wTQ=
X-IronPort-AV: E=Sophos;i="5.75,347,1589212800"; 
   d="scan'208";a="251563144"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2020 17:57:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvxWy8h8SSs/bU/gTm5q0EcHNspscEAha4OqoeG36KaladORfw/ckBkg4M8/I/c4ujBMAKEFX1hln3RwiDZHUUpim/VL3z+s+nyzojZ0XlQKmh/66Fl/wkjr76xOeuXcs4PPd3nZmzhOTchpVX1+bfFgVbJq4cxjPh1AYnkJlXlIqs4pu+Ra7oIjR+hEbTY1FyzdmD9Rs3soz2JrlAJ8l97qbIkdXZxnTUiAaMqPPdOTLWPZqNxiAnkusiqBjdCndvZUFyNKzgkrL7JlZgvbOsS2eESBRsYuj38T/jms851Snl93qrxdfIl/bOZngmQbh2fVqa4JF7Q/d6U+4wYB4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+phRMMwr2apOT/gZGYABI5F6CdzQJhXBJpP9aqC7i4=;
 b=QTLciXjVn1lHQqRlf1yL/om421Kwm9jsLcyi4xtjY1OuMMGPvDbpRWrAWRLe5lP7MFTKYM9n7EddUmpADYV2v0dQTJKdhfa2K8Flwph9OpOyDHp1DW3oWkWeJf4razE2kWsxr1G10Bn7gjp4+B9fjS3K1QN961HKotEZWDsTH7WKEaap2Skdb4+mnkIhIB+QO7wvuGFZfpOSE3H/wbFWr2dr5lnTAFLYBYXMIuM5UKUCGHI1go90ryY1+TA2O0LlTCj5aF54E8mSLyKnN3b4P6hpOix6rIaolnzBCfZCcW7XbWBJryj3chhi3uktx3Oc+I3ZbTm4nj2CkTvAlIlwag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+phRMMwr2apOT/gZGYABI5F6CdzQJhXBJpP9aqC7i4=;
 b=BTMWVKJChJKgTY1SdEAxbQr33GeEkcwcfBG8PQ4w/MZB8BXn35xsRBnwXtdhN/yRkdl2DIzwyZumHV417f6tYGpmWd8Ya5/cP5juoAmvvKnsfzzriW9POfJaftWRh0muA98kqLu4//TAUNfTdLMZ30TvJCOQxAWsVgVg5zIUOQA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4541.namprd04.prod.outlook.com
 (2603:10b6:805:a8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 09:57:15 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3174.024; Mon, 13 Jul 2020
 09:57:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] btrfs: add filesystem generation to fsinfo ioctl
Thread-Topic: [PATCH 1/3] btrfs: add filesystem generation to fsinfo ioctl
Thread-Index: AQHWVsMoDlwog9NMkE6lIoGR4dEhPA==
Date:   Mon, 13 Jul 2020 09:57:15 +0000
Message-ID: <SN4PR0401MB3598247EF50C61FB79F98A369B600@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200710140511.30343-1-johannes.thumshirn@wdc.com>
 <20200710140511.30343-2-johannes.thumshirn@wdc.com>
 <20200713094251.GE3703@twin.jikos.cz> <20200713095234.GF3703@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:3d54:75d5:bb74:f595]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 254d0ea0-9750-4ed5-c5c7-08d827131f3a
x-ms-traffictypediagnostic: SN6PR04MB4541:
x-microsoft-antispam-prvs: <SN6PR04MB4541EAAAE429345DA180ACD99B600@SN6PR04MB4541.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TR5gEJckp7vzrLTKM0ZWGGeaoBlax1j/buP6j7P5bQBdioMrgXYyVTwMMFne6d3xMUo4V5s1VyQ6m2Gy9flwk8gJYNp9elVbNXy8TC7Iw6XoOK+PlMlJfvUx7PeAZPYKeWTMKgkgRpyWU2aPux7HdXevt7uTvVlK+x/jNyyDw0ErP9mqNK+z1uZN1wp6G/QOwkAEu4sL5W6CatthOJ2Yc1o5WWYcc6tcwjQmgLq9knLSOM1kvqo6WOS8IyjCgoFn86eqwJyMyzMAiITSgGTFrVVVv41SfBhTAHbxBL74Rz7xcqjg32PsgdFEmBDuM9MiRJiCodcTA282bE0urwcuPPsTZpGm6Jo+2s/9z2osoNi0oY9sE3ek4vcYsRwphr6l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(64756008)(66556008)(66446008)(66946007)(110136005)(66476007)(316002)(2906002)(55016002)(6506007)(52536014)(91956017)(76116006)(71200400001)(53546011)(9686003)(186003)(33656002)(8936002)(5660300002)(86362001)(8676002)(478600001)(7696005)(83380400001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Z8iYM9EYHo76XDgqFhZY7yVs0+pMwfL9a5gE7J1wvfnHy6ViRm6WuPhTt1QH3MwIm1A2elaXrFZEneQpj/8mOrDDGo5r2S40dsHzD74IhPDt0UThrHsQiShJ7EN5KACUr0uDOBl8IHcBYmtnZyEqoGInzO4Yb9h8YzhhdQPh4pZ9VS7//0cQWd0jJeRuJ8LTLH0gDP42Vn5/ySUr9DkQkTKZEpiopatnw3Y4qc9EsBHxb5kqtkpMgQVhonW5L1WWbXrBckaF7kMhB97v0QMOM7819cYrDhI7D3MqOqcYWAGyGtuWlDeuCb5DM0rGWw6yxmMeqX/lu4BOaE4ldEg9IyLBuUptI5b7CsZMegvrWiyl9O9bu1GvW76KrWkEogNMapcGncPcpjvpzoFGr/KlGledhtR06jo86nTIwpO8TCMe57QyA8VqvfWbldiDEl93sxqMSJ0gzdm+475AxS73B3nHFGs6FQemWtmYUpRFO/v9FPvuImeZXFZuRP0i3p2fzqn5jhFPYqHr0qoVa3iJPNneY13pCwpbSnS6X+7hyMIYVGQtqsYPiMOfMhlc0phD
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 254d0ea0-9750-4ed5-c5c7-08d827131f3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 09:57:15.3403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dhyzFMJNsoZcTQHC+YNJcJ+vfDHJoZf4cMGUkAyYfC/qcDl/i3M9sJMsPtgbeqZ8JV36aM+8B8Ioi/mUEAh690kpEj4C+cAPgVKgY8URw2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4541
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/07/2020 11:53, David Sterba wrote:=0A=
> On Mon, Jul 13, 2020 at 11:42:51AM +0200, David Sterba wrote:=0A=
>> On Fri, Jul 10, 2020 at 11:05:09PM +0900, Johannes Thumshirn wrote:=0A=
>>> @@ -261,7 +264,8 @@ struct btrfs_ioctl_fs_info_args {=0A=
>>>  	__u32 flags;				/* in/out */=0A=
>>>  	__u16 csum_type;			/* out */=0A=
>>>  	__u16 csum_size;			/* out */=0A=
>>> -	__u8 reserved[972];			/* pad to 1k */=0A=
>>> +	__u32 generation;			/* out */=0A=
>>> +	__u8 reserved[968];			/* pad to 1k */=0A=
>>=0A=
>> I've tested the static assert by switching just the type but not the=0A=
>> remaining reserved bytes=0A=
>>=0A=
>>   ./include/linux/build_bug.h:78:41: error: static assertion failed: "si=
zeof(struct btrfs_ioctl_fs_info_args) =3D=3D 1024"=0A=
>>      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, m=
sg)=0A=
>> 	|                                         ^~~~~~~~~~~~~~=0A=
>>   ./include/linux/build_bug.h:77:34: note: in expansion of macro =91__st=
atic_assert=92=0A=
>>      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_=
ARGS__, #expr)=0A=
>> 	|                                  ^~~~~~~~~~~~~~~=0A=
>>   ./include/uapi/linux/btrfs.h:270:1: note: in expansion of macro =91sta=
tic_assert=92=0A=
>>     270 | static_assert(sizeof(struct btrfs_ioctl_fs_info_args) =3D=3D 1=
024);=0A=
>> 	| ^~~~~~~~~~~~~=0A=
>>   make[2]: *** [scripts/Makefile.build:281: fs/btrfs/super.o] Error 1=0A=
>>   make[1]: *** [scripts/Makefile.build:497: fs/btrfs] Error 2=0A=
>>   make: *** [Makefile:1756: fs] Error 2=0A=
>>=0A=
>> Good.=0A=
> =0A=
> There's extra padding now required for u64:=0A=
> =0A=
>   struct btrfs_ioctl_fs_info_args {=0A=
> 	  __u64                      max_id;               /*     0     8 */=0A=
> 	  __u64                      num_devices;          /*     8     8 */=0A=
> 	  __u8                       fsid[16];             /*    16    16 */=0A=
> 	  __u32                      nodesize;             /*    32     4 */=0A=
> 	  __u32                      sectorsize;           /*    36     4 */=0A=
> 	  __u32                      clone_alignment;      /*    40     4 */=0A=
> 	  __u32                      flags;                /*    44     4 */=0A=
> 	  __u16                      csum_type;            /*    48     2 */=0A=
> 	  __u16                      csum_size;            /*    50     2 */=0A=
> =0A=
> 	  /* XXX 4 bytes hole, try to pack */=0A=
> =0A=
> 	  __u64                      generation;           /*    56     8 */=0A=
> 	  /* --- cacheline 1 boundary (64 bytes) --- */=0A=
> 	  __u8                       reserved[964];        /*    64   964 */=0A=
> =0A=
> 	  /* size: 1032, cachelines: 17, members: 11 */=0A=
> 	  /* sum members: 1024, holes: 1, sum holes: 4 */=0A=
> 	  /* padding: 4 */=0A=
> 	  /* last cacheline: 8 bytes */=0A=
>   };=0A=
> =0A=
> What if, instead of inserting a padding/reserved field we switch the=0A=
> flags to u64 too. This unfortunatelly requires swapping order for flags=
=0A=
> and csum_type/_size but the result=0A=
> =0A=
>   struct btrfs_ioctl_fs_info_args {=0A=
> 	  __u64                      max_id;               /*     0     8 */=0A=
> 	  __u64                      num_devices;          /*     8     8 */=0A=
> 	  __u8                       fsid[16];             /*    16    16 */=0A=
> 	  __u32                      nodesize;             /*    32     4 */=0A=
> 	  __u32                      sectorsize;           /*    36     4 */=0A=
> 	  __u32                      clone_alignment;      /*    40     4 */=0A=
> 	  __u16                      csum_type;            /*    44     2 */=0A=
> 	  __u16                      csum_size;            /*    46     2 */=0A=
> 	  __u64                      flags;                /*    48     8 */=0A=
> 	  __u64                      generation;           /*    56     8 */=0A=
> 	  /* --- cacheline 1 boundary (64 bytes) --- */=0A=
> 	  __u8                       reserved[960];        /*    64   960 */=0A=
> =0A=
> 	  /* size: 1024, cachelines: 16, members: 11 */=0A=
>   };=0A=
> =0A=
> does not require any padding and leaves the end member with 8 byte=0A=
> alignment.=0A=
> =0A=
=0A=
The swapped order looks a bit odd, but I don't really see a way around it. =
=0A=
Can you fix that up or should I re-send all 4 patches?=0A=
