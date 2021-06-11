Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF843A3D1A
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 09:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhFKHad (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 03:30:33 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:48712 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhFKHac (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 03:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623396514; x=1654932514;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8yeA4Og8hjtajETPpUQL6w7Eh/sEXLUQDBB00Q6h540=;
  b=p9NFRVVxYMSaatER4OSiOMNf3Cl4ABsFDXoZIy1rOZZHEnS6xkzpW0Lk
   1scccoDdXY7R7mJtWDqBSKAp+WQyi15L4vb6Nu9TRPPT4JLSW6TArOXoa
   H6v3t8B8lpGIR56dFZZdimirDawhHA44a3S2RXNtJ1HM0UjBq1uR1JKZh
   SSM+1HPazWQnwRcTKa3cF0EPvxwrdDtsjkP13DskdC/9sGAOYNVF4Dysu
   mgOPMhaCqUu068FM53Yu2s7HFojtwKvCNPQ6zY1+cCgfoq/ifjXyTR8R0
   QYSdV+dkl+3oAYvMr3653mnT+rfVkhIyri+90HLNTeJtk4kbG5X2qtDs8
   g==;
IronPort-SDR: 6AJBY95x8ThZmLW5/CcHTyDsdmIhpD+/bMOgXZF5jiwpCGVdoBx5eP4JpcZlIAgBoPLz4GXrnr
 1B08OFB2H5yLjpShpQ4v1gkZQg0jwkYKYTxvYXp/kDXiEjQNipDBDEYLG+rrYPCM9eVeFPHPug
 qpIEzMpx7mcU8KJpAVwzPXK6e7Wq+3/bI+zjhpRwePsyNaWp7fRr98hidFJYXdtu6imMSDIftH
 kWHVUOqxw5lvG4+vbo34JRRitWRrpguShzFVQXT8xi9JhNailb6t260wY2gbVlwwAy2s8OV1Qf
 /nM=
X-IronPort-AV: E=Sophos;i="5.83,265,1616428800"; 
   d="scan'208";a="176331074"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2021 15:28:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1hJw+0JTrKO7RsBfeuMueqCXfoJT0L0yCX0I7YQuEKBEJZ8dQuHnub7KpFmn0NL+HmrZYTsSzp3PwCEC7fBm5dJAGiU9XChCkW3LeqBvgytTy+0lROcJqwhR3M2lJqDFSs6QwPCxrju32xwtUZRwkDJcsBN2RKc9uGzPG8IweWrNlUDiXsrkabBtBz9olXVrswmNcMkQbkj/Ze9YbjawusHB7fNcHQPDFLW0aHpPFzNdZ0WB3NTeARCSeEvJ//RjUt3B3XM1wzGBxHznEimyCAwPsPPS5cIqxjwT2AXqrw6k7ijXpfP8X+pUKyemGRrBPap0/Z0hxbUMHVB3I6FFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsRTbSV6Uz63ka0twYh9crBfOyjpfO30mRIhR6Edxtg=;
 b=Q55BZFL8SxSrtZATMeFwHC+5SZCfdJX/1OoDmk45ShEjwHFsJpQsS7VXuQLnSrvt0340XdDAHXSiTq0guIqQSL+XBBRHYGJjsjQBp1w1yIMMr3nbXmT1AnVA5aKchMBQN+WSQh6BIniGMRTuq4wVs3S6mp5AK5DJeEKUJZNqtNg9k4QPaGJmWPmdbaAQSlJnC+grrWYVXZdNgu74pLrAyXO+m1BWLSQFhyc5IBXFGPVpPcytbqVsfF/Iy/h60uZjcAhOxp2ZtBKN1kPoQce+h3zhj3LJwtWHfJplsPfoEuNU+FRWfry7Wtxotgp8vvyf9Xni9ZYOU5XBuJVGi0KMGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsRTbSV6Uz63ka0twYh9crBfOyjpfO30mRIhR6Edxtg=;
 b=s5781uCxz1D0S2Gqjj/ujqttyA4DN3E+2Q+o5NDchb9ZbuFW/b5PBQ8Yz17xNZeXLidYQQwVq/CvblO8KDSSDxcRMcioICG52JgI//K16MWY8eD1A+N1kZz+IpVGnCzpMqGecbo3EGSLzSrDiUiK/9U5U5TZIHl/RPP9a4vHOY0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7191.namprd04.prod.outlook.com (2603:10b6:510:1c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Fri, 11 Jun
 2021 07:28:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4219.023; Fri, 11 Jun 2021
 07:28:34 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/9] btrfs: add compressed_bio::io_sectors to trace
 compressed bio more elegantly
Thread-Topic: [PATCH 2/9] btrfs: add compressed_bio::io_sectors to trace
 compressed bio more elegantly
Thread-Index: AQHXXmGAdnhT5Wjec06Xwb6XhB3bhA==
Date:   Fri, 11 Jun 2021 07:28:34 +0000
Message-ID: <PH0PR04MB7416CFBE9EA8E31E61CE975A9B349@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210611013114.57264-1-wqu@suse.com>
 <20210611013114.57264-3-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:141b:f301:e91f:9de6:cb32:f149]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0426f113-e700-46d7-f26f-08d92caa855a
x-ms-traffictypediagnostic: PH0PR04MB7191:
x-microsoft-antispam-prvs: <PH0PR04MB719103E7BFC7ACC5C0152B7B9B349@PH0PR04MB7191.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sMKMtP0I5V1jQcSMIw9LrH9+EoakooXiV2hUo1qhf6cy016bM2WKFzjqnjRtBGWMR+saRbNQ1qpoTJBBcMi0c5P7auqmV8ncY80TsJ/QXC9G/tgZoJkJ6askEb0fMTBkdcAmK+BcTGvFz0c466ySOwVbArYXfAtPqtzhCeNaxybRA9SfDmjeTNpvQltxrrgUPKo+eed77QKEAtRSuJNkRgPVEzq3ITJmtUHIjf4/iYFUaG6aa1GxI3Kv88bru8VSNpX1LG+YkxcExOArKDa8oj9JGU10rCB7Zc4IjZQTvzzNTVSsdfXQFzDnkUqLvAJYj2KM9wi+XDg0NlUO0pJNswn7R0GAMuKKD3wgH5VpcN/uvZKHlw++M/pdLhVSFeuXRWkx831lE39yHpVELcdVz7dt743trEFR4jiwY1qX3QUgS3sRz7MmolLOnHX1BBIJVR46akLRY/lBkExq6VOmy/ZjI/Rjb8bWCUEO5JoSiHo9ovia9k966R9KOoAwFQCfeGlaa0r7CB+O8POGFJqSqM99pTegO3xzCYih0NFxO10FDJWzgWBM7tmyf8b2yLCCR64JOY5CxUfqEFoNmgmXwJE4s7U2LnvoPmQgo2eHLcM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(110136005)(186003)(66446008)(122000001)(64756008)(38100700002)(91956017)(53546011)(33656002)(5660300002)(7696005)(52536014)(9686003)(2906002)(86362001)(66556008)(8676002)(8936002)(66476007)(66946007)(6506007)(55016002)(76116006)(71200400001)(316002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1/jwScU8AwYLWodKk60QynRYpoDQ/YmPFIDPE4x5WbtXxoOElojGnYWXkRol?=
 =?us-ascii?Q?POP8KTZLI3JV24xvoZ2RiE4Je6DgS7r4tjxIyA2T1y5Z/Of7fMcUrB/Tt1J/?=
 =?us-ascii?Q?UJHSEzdJwF1y2egC5Dt6i05eYSx5+dNnveKd8n4zbfl/P3NZDh8ePFVVwng+?=
 =?us-ascii?Q?XoonZlyTOCwqwbW+YGxKIHOGf5CpYQTTgW1YEDKEGL2nsaAtTS0LPMaovpua?=
 =?us-ascii?Q?SILqE0D7v5yuaOqjVihxSms3QiWWPA0kCqgyTKug9Kn2tyKjesCR0LNUM7b/?=
 =?us-ascii?Q?M4extXLs4W1v8/X/uQGM5rz5lFHUXULgyGM6+VmcdysuqAbexkR32N+PQBCO?=
 =?us-ascii?Q?f2pySm/C4BkRCyOKPPzIaFDE5drrcgoIMM9sZAgO9Cxjxc3yzVHMwNSzNcuo?=
 =?us-ascii?Q?NzxZqg7pGOE/zNY6YsZaOdSioTtOODHY0QIPPggT2PbXhSnuXdAioJZvCCVt?=
 =?us-ascii?Q?bv4dLnVqXRrIBUOtncuGOeP7vsgY5nttTsJKIMlaeJMZa5pNY5UWZUrxT2vn?=
 =?us-ascii?Q?Hc33nz6apwDuJ3vCWsIiqOyMk1fJpl8exQJT0d9afNRmj0joDjmtIZE+Wtam?=
 =?us-ascii?Q?o00j43oLYzeFIlDH9gZxkTH7+5ROarY9+2Rpi76z+Z5wez7DzDdT1rq4e7ix?=
 =?us-ascii?Q?0pd5/30qAU6lRHZT6HqVMyxnvFYYGDXcsymLOgjRjW5NONm3JE3duTnKg4bY?=
 =?us-ascii?Q?mzslwjgh/85w+LKFflj19bCjGa86ZylderltDcsQjN2Re7DwRrEgjjL5ZXhr?=
 =?us-ascii?Q?NWVOTgJwMlz0mVonz1Ot1Q1EpjQKvmYlYJ9InjXV7SfiN5/82lCzycDJh1Ot?=
 =?us-ascii?Q?NUlcsfPWjL40HKZwY99z6JfPfng4qk4miXGe1DuJv3a37T0+rB+Yrr1Eo7Hz?=
 =?us-ascii?Q?sdJFL/TVdzsGUb8Y8gHofKK1miNpa44NcUpaLkRiCESDrdoFDlit8qk7QQDz?=
 =?us-ascii?Q?6GZZA4PrB2CSeoZCDb2+mMV3pkyLMdECM2aKSyog4X/hb8ZlAhhiXwFdqfc2?=
 =?us-ascii?Q?uVsJeBZFePqJfe4rIKotwWKimvOq/OM9WpbWYVm9yQ5AXMupZ856CLVwfWCx?=
 =?us-ascii?Q?Yfl2bSlfEZkPwcKbutj5zP06jpg+S4JHG0pQ8Ls1oxbCZZzmpTJdLneNsFTF?=
 =?us-ascii?Q?F3lcIRggGWdSkNBSj0hbbAFeuyB5XseXYEAVns+u3B63DcCOTVYUg8lwsmot?=
 =?us-ascii?Q?5Dc5sXuOypG5HEuca9DTPjvXQ3fEJ7uwHI/cAp7G0XO8kjz1CSGpd0QRyQVz?=
 =?us-ascii?Q?hFNYNKp0r/80AmBUeprZM+XjWYZCYnJVoeZ8S65J7jrS1ShTOeD6FWrmkSnA?=
 =?us-ascii?Q?2ilIwZNLZC5y1IvjPh2L4ZNRU4Oaclrp4oeKLe6fSAQK6ire5pfyinVgPs7K?=
 =?us-ascii?Q?cJRgcE7qgY8IqazmzZ91VkNbOQKsWUESfABO6/h8Nn4DBqFa3w=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0426f113-e700-46d7-f26f-08d92caa855a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 07:28:34.1325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LUeGNebl4ZZyVMY0qI2AW+dmOa5ebtbDGnfwdWsxT0aVODgOdY7lfCfdNe7Md4QL2+lvaOz7Jo6xtUMW9+GTeWSGl804kLRKw5v/dSIz55c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7191
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/06/2021 03:31, Qu Wenruo wrote:=0A=
> For btrfs_submit_compressed_read() and btrfs_submit_compressed_write(),=
=0A=
> we have a pretty weird dance around compressed_bio::io_sectors:=0A=
> =0A=
>   btrfs_submit_compressed_read/write()=0A=
>   {=0A=
> 	cb =3D kmalloc()=0A=
> 	refcount_set(&cb->pending_bios, 0);=0A=
> 	bio =3D btrfs_alloc_bio();=0A=
> =0A=
> 	/* NOTE here, we haven't yet submitted any bio */=0A=
> 	refcount_set(&cb->pending_bios, 1);=0A=
> =0A=
> 	for (pg_index =3D 0; pg_index < cb->nr_pages; pg_index++) {=0A=
> 		if (submit) {=0A=
> 			/* Here we submit bio, but we always have one=0A=
> 			 * extra pending_bios */=0A=
> 			refcount_inc(&cb->pending_bios);=0A=
> 			ret =3D btrfs_map_bio();=0A=
> 		}=0A=
> 	}=0A=
> =0A=
> 	/* Submit the last bio */=0A=
> 	ret =3D btrfs_map_bio();=0A=
>   }=0A=
> =0A=
> There are two reasons why we do this:=0A=
> =0A=
> - compressed_bio::pending_bios is a refcount=0A=
>   Thus if it's reduced to 0, it can not be increased again.=0A=
> =0A=
> - To ensure the compressed_bio is not freed by some submitted bios=0A=
>   If the submitted bio is finished before the next bio submitted,=0A=
>   we can free the compressed_bio completely.=0A=
> =0A=
> But the above code is sometimes confusing, and we can do it better by=0A=
> just introduce a new member, compressed_bio::io_sectors.=0A=
> =0A=
> With that member, we can easily distinguish if we're really the last=0A=
> bio at endio time, and even allows us to remove some BUG_ON() later,=0A=
> as we now know how many bytes are not yet submitted.=0A=
> =0A=
> With this new member, now compressed_bio::pending_bios really indicates=
=0A=
> the pending bios, without any special handling needed.=0A=
> =0A=
> Signed-off-by: Qu Wenruo <wqu@suse.com>=0A=
> ---=0A=
=0A=
This doesn't apply cleanly on current misc-next.=0A=
