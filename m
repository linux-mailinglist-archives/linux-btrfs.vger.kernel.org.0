Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3574745D7E5
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Nov 2021 11:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354332AbhKYKFT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Nov 2021 05:05:19 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22856 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354490AbhKYKDS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Nov 2021 05:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637834408; x=1669370408;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Jj7roY+6GK7WUi35I1pADZ1iVtTsdfxUXMWd5R+CF5w=;
  b=Gn/hI3dqULOyD9s9seP57mvId94Pv+qJjSrP4AQuVj6O69POO01u6hL0
   N3cG+XHmRYEh18vybAfI7OYVl0tVwCevGbjHeG9Z273VoshqSmMTszmzw
   qKmIDnF33Kn34AXxDXZhfX9l3hzBVLw1ZrphjzfQMS+PiYnHRZwd7zb3Y
   ymDeqJ0lwoIygD5KXCorZpvTeHJ0bhlY3cqBuoSC2Amx24BTIds7HKiX7
   WBIdDsEJANzdPNmpTewGgc0Ttd40orZyRX6eSqDcrLPbWTv73A6XEhkfe
   fFBixA2luwxJfz7tiz/2xrnVtyqjIj1zif+ZEC5dfWW1DOUREzhzcKQjP
   w==;
X-IronPort-AV: E=Sophos;i="5.87,262,1631548800"; 
   d="scan'208";a="187623267"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2021 18:00:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eb7yeoS+tm1iVF101eSGnACITmWaYbcWHuUTBvSKnPv2pvUbesS+J7g+MDv0Gf3nLPRG0BkJCJ3ndGBqKb8h9pc4fI96r8nti36P6CpbiBWk8gvLGHD/7RFXotOuVpSmHXv1nEzwjC3xosWCr4YABl7orxbdeJ5cUhSqmxQQ0VhRUdbNXCnZfbp2ybl5Q3PuBNVAKROTx+lTjEPGlmUwsyq2NHh0VwuYyZ20HZYT6FzSXknd1Uf9Mi15sdF9/ErK4HBOweFnGlGkHEp/ldxmwA+K3BztxMWvZF9VA7WX/b/o4AUxR+hvEVZBO/YJavgjgVMMF1AULl1tAPe3eK7Tzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jj7roY+6GK7WUi35I1pADZ1iVtTsdfxUXMWd5R+CF5w=;
 b=QNRVieh8IeHX1ssS2cDu73330ZBOIQHlCV9W+bQX//hw09YfwMIDhSxf7bi0xFTqZlNKhNHrRO0/RXIt1EiF8K239GgdhX0fAyL0AxcMQCyiO7MWqa0hqQupvl0tJ5goLL+LOe0zeMzePq6mn7QEWaepv3Bu0brQZyCI23oL8rhZ2fobOIv/p3Q0pplZbUV3hnzK9N+HaMwcNs6FekArZdKOzVbXr2236ANMWQb5YOojZDGIcPTyNc+6kweOUbZpNfpxFrlZuY8GyzqomfkG/lbJytRnFY5mbYpOtHkTPFTyso5yhkcrHg31MhklIasJRnCLZ4oGc9/F5Dv62xjIaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jj7roY+6GK7WUi35I1pADZ1iVtTsdfxUXMWd5R+CF5w=;
 b=wqKu04SQe7z0DsDBqUDIqMAYD8NcodgJlUaWCvho4kvScqNUcJzJK9PSv3JPXZfVM2/VlOYetM7p1Dp7p7czmIIv0nqZ01rNyhozhc2TuNZrIZpuABAqF47prJN/Jl0+2CyUli2jjdmy8F8ErvLeNBmjovt8djxyUA0mtTZMJ4Y=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7559.namprd04.prod.outlook.com (2603:10b6:510:59::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.25; Thu, 25 Nov
 2021 10:00:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c%3]) with mapi id 15.20.4734.022; Thu, 25 Nov 2021
 10:00:04 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 05/21] btrfs: zoned: move compatible fs flags check to
 zoned code
Thread-Topic: [PATCH 05/21] btrfs: zoned: move compatible fs flags check to
 zoned code
Thread-Index: AQHX4RYBzzRHHPm1x0uRS1222f26lw==
Date:   Thu, 25 Nov 2021 10:00:04 +0000
Message-ID: <PH0PR04MB7416C949401D84C2F124E0989B629@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
 <dd096a7fac48e8314eb43b3f4a17fa5e4ca56c53.1637745470.git.johannes.thumshirn@wdc.com>
 <20211124173647.GW28560@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ce1521e-163d-4e21-d2b6-08d9affa5aca
x-ms-traffictypediagnostic: PH0PR04MB7559:
x-microsoft-antispam-prvs: <PH0PR04MB7559F1FB392FC976D4D429E19B629@PH0PR04MB7559.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jel/IPWU4Dzt7CuQ3YfzVQeT5zwDFDCPjbaiVts44+kIhtSTqcqHx8BoNmBn0NCklsF1T1fKUY/A7MST6lMZRnrUcaeG/SqZhQduPc9FgcFVECHKkO9I+Z4yhwT92s6HdMnxJj8FrQMqZgUabYwH2ojHEvPHgZy4QqtqEZNmf8mlvxmaRA0c/3R9rIad0QKJZPqaPMz6gAyth2KKeXa++pV8kv4YvxPq2Dit6WNMTqUzB57mvE99veyrSe+F9uUeovIFEPtd4KYUPKalMI4yAgnSuPCpo4+asphZXIQLmHo/JxVRTGQTkFmbO7RwG/Ughw+AHViu2paFYKv/jr6xU7RZl5Lk/NrQ80SUjJ+dpJ64BES6lB2PJyZo3Pbbp9FPhf6x+gH8XemomRcnEkAucYRP1KmcxMUPsq0Ml+rWzgoGb52YVdobaUKm3gT69u9IiocpbS08kvTkAfvcjrFIXasqK/wuQNgEjlaql5x5mYoag13iXzNc30l2Z2dz9IwWtMaO2rZk9eA8zWqp5haxSaQP/1EJ3ZFLS+2xV6SCdNZOjMF5/E1y7dipLVpvcuB+EeoVl08IcBiVBHqA1BG3IqiHUWJGx2H8bOsjzavtccMmbylmdOlImYB+XnDlFL/BBEly01nCysG7COx0oHB5o4Oc/HY2pcEPjHLVgAZn8Xs+t+SUqP4I+zt7eAAeK34KuNcxVUrRTlRNKfSWjptmNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(38070700005)(9686003)(2906002)(76116006)(54906003)(4326008)(71200400001)(53546011)(82960400001)(508600001)(86362001)(6506007)(8676002)(316002)(91956017)(66556008)(4744005)(64756008)(33656002)(83380400001)(38100700002)(7696005)(66446008)(66946007)(122000001)(6916009)(5660300002)(52536014)(186003)(66476007)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wf+Jz0rYtsxDyPganL9aHnTiiakpF/+vFP12zOQOY60VC7oqy8bG9HpRa+Le?=
 =?us-ascii?Q?+hrEzXIqFKJBORCSK5CiC3d0eh0+0CZ610uaH4GCtcB+UL0O7ptm2Maa24ij?=
 =?us-ascii?Q?XPbSPEoLjLnplYBF34jkisgrYDwineodQb1wXl0QFag6IHBVkki1MhfrTQm8?=
 =?us-ascii?Q?kN5W/5drczrMif/1uGGyFYCRfqjF7BL8yi8nNY4VtbhrHxqfYGuXWXx5nf4V?=
 =?us-ascii?Q?jGcWssI+80TrLIzwPVBw6hBeaaT6gyB7XpcWZxPmKve/5qyjsaHUq2pEmJar?=
 =?us-ascii?Q?XUcY+U+p3KdkfXAu1pUQwRvhnlC+I5UxlX2QFE1k7oBa4ZV3BsZYFP+1EHgq?=
 =?us-ascii?Q?kUHTGHeUzuxFAI/rf86tCXA6slje5X4UcxIkzWoodcKJdaswYGUUtKwVuY4i?=
 =?us-ascii?Q?TaiYFOyKeQ05VSZi5GKkhdVNuxufbmi4dz6IPFSyZpXQjjlTF3SYijLbNWxQ?=
 =?us-ascii?Q?ykP2RP3sCGCZBdKJU4ZHUZeTQgfvwIyN9qXrxkTj8mw55BOLkxVqHWAzWbuJ?=
 =?us-ascii?Q?Kf6DyALuie1qjgQjjMV1ztTgPvbhtHkm6L7zQ6nruSEe/gylu+cDBdyILp6j?=
 =?us-ascii?Q?ZsEBRUH7x9qhGphhjLRexu8cxO2Q+ZmM1koly43jJoey6ag6lA1ihC1REhmy?=
 =?us-ascii?Q?xlWDJweGnk3cvsu2xWAGjG8vy6eavo3Y9fR7acTQRkNjGzv1J5GJD7MMX2hq?=
 =?us-ascii?Q?rrNSUnUncxRoagSG5LWUg6xAuq0LG8ngirKZ9W/3l4kq9Vxd291NiBo/vzSB?=
 =?us-ascii?Q?CorAUy2RGc6Ut+bZOx/LJQom7puEgCVWnp8fY905V0kd1MsJqb8dPyD8DjgN?=
 =?us-ascii?Q?OZVzvVZAFZPQc2CSwzeD0HhJ4kZXU2uwXWbtYKjv6ux+iknwvWNOJUch5lQO?=
 =?us-ascii?Q?olZjC+PwomVU8Y2IEFoJZIjSpbJbtYt+dM0KFJrVR52SRe9S/nMcyJT+xTKo?=
 =?us-ascii?Q?0xduL6SA6uyyQnxi94JHAMXIyq4n5gnyhqn3DLA9wI8K8EGzsRcIEeCJdHfb?=
 =?us-ascii?Q?R1YWTHCxF4wwRabxON04wOeungtye77UEmu1FjbvL95RVis4kqDPLY7HcFMI?=
 =?us-ascii?Q?qf8p0sX39qX4NZ0Vp46T42aFCme2itIMCONUbmbOydDuQY5zznZExGB2wM2G?=
 =?us-ascii?Q?q83Kyxt7hPIpXjQeLeOQQfAXyogYMRIZ0osRK7RBAxnPNO8tE5dX7nhIiFBy?=
 =?us-ascii?Q?7hf2dwD15bmc0tjRmw/t59SYDaAfW0SiA+9rVvaCIy2s5DPD5BnJ92qkWkQT?=
 =?us-ascii?Q?Pv2cOeTbLwISAUnmz5rqczyk5zaW3V81PTTUoJjVBYdCdurLNJ6TBrlnY/E8?=
 =?us-ascii?Q?/cVxkbBycnuHRVuoOtep1YT0S+0QIaLRCVr8LJc6Nq5NVTZWAZlngk5Ym7vf?=
 =?us-ascii?Q?npTxe5MnLnKUYIpIQFAzKFYRdymOUuA0t1Pf6yzWTcuirohH9UFCt+Xlqc4K?=
 =?us-ascii?Q?9YmdH61bq5QNeO6Z/8OYEtrCPCpn3wpAX3qe4u97LdVBqPKQQQZYLRUcw6eM?=
 =?us-ascii?Q?FRQvCmptr7Z+sueBaC1/ZxXYkKNwu+yrYB5cZFcikCqRS+wduAPF5aiW1n5D?=
 =?us-ascii?Q?edWR7RSI+yU1MD7lmbrNdAfuk+NPXG1A3eooQCH+TULuXAEDgRIkiH6XYKdD?=
 =?us-ascii?Q?x2mEVfFs+BOj8CwjEqCtwHBVloYLDuXwEvjNOXxnNuQwu13zyUfQQVUHm+sT?=
 =?us-ascii?Q?GMBdYa2SkrNu1JgQww9vbUhoVBOXk3oHuliO1ae0Ei34R8xKy51kN83buXQc?=
 =?us-ascii?Q?DXgBk+6SS7vxWZ7S1YFJUTtE+QG8G6s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce1521e-163d-4e21-d2b6-08d9affa5aca
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2021 10:00:04.8447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pBRijXzOqmSDIJNvmHCG4noJEAmIQiSUOdtewtvZ3yHaIYjEkLBlj/kWIHf/LPpYsMDvRM3I0PKW2UtHXdyfpQL95YLz8Ok0zpqgZpCtgVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7559
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/11/2021 18:37, David Sterba wrote:=0A=
> The intention of the function is "verify anything that's relevant", so=0A=
> checking the zoned condition here is IMHO appropriate and expected as=0A=
> there can be more such checks in the future. Although we don't have any=
=0A=
> yet moving the helper to zoned.c disconnects it from the ioctl.=0A=
> =0A=
=0A=
OK, dropped the patch for v2.=0A=
