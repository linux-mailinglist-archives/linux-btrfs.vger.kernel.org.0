Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF934E43CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 17:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238793AbiCVQFF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 12:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238773AbiCVQFE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 12:05:04 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1696D948
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 09:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647965017; x=1679501017;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=w5DfTPAZv27T86MTHmMsaU4M2ZGtTiIy1rM+/vMngu4=;
  b=FIw0u1ZarcaKRY5wBlB0wmYY3Vpwv6JRvXlLaajvi8Ip8gF+oT/PDc0M
   pNBDKv5M5sCXx6ise7En4o07QhhV6Z+QHRaGl8noxE5qdFWI/+FhJuj2t
   X6nvo2WVq7ensf82UhfMjEa840gNaLkPXycAXt9aGS0LmMWaBbnIXUNkS
   rkXhiTmwHDltsXRpg3CysZL9pwlePUVTe8SFLn9ewILj0Ou9QefSDF2H/
   64ezg/aUy9kZPybgDLJMKELFK42BHC1rQ4VAhNAZ6cgytPH+j48Q31UHV
   MYKKM66yarXG1beDx9+oRYpy+IGHGFmJT5hJryD+i2ai8tMG3JoPPEtoh
   g==;
X-IronPort-AV: E=Sophos;i="5.90,201,1643644800"; 
   d="scan'208";a="196903588"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 00:03:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGGQWapPpz4vIouk3U79p/w9ETEB0AKS96aPbzP4R4XQuuxEeqTiu8o5DacF1vSjA7Oe2uBE8KixLgcLTgalUON7qNpOSKj0WZtQ+KJVtnxJKDSX7bIgvfXB4N+QjfWLfBt472LjYJ6xkJiBKBqrtIliHbswlu5U7CtPksjqkAVL5U5JwpiW1ixBqJlRe9IkbelhLfhs8YCsye7x81ZGhjYWk9g/HA68h2PrdBr0JeXq38Z5Dm1VkWF9PnAG8w4ykD+CokuWMRPqPO3HijV64M8X5Dq2e1M7QGeqJSw394FV1N792hn2LeSIJfHmPZ99IKi1QZyAeYjBCK/JNwrTng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2z2t9L39EmW8dBIE/GkT5RtCinf2kkVV1EQuT0MmXY=;
 b=mzfOwGDgC4L+VvnyXoNZMd0SG7KciizHY1N0p0tC3+tuZy03MAo8ppjewWWTIYW6O2HYMNIQlRGmZpGFJxlhPBwPUJjV6CCRC3XHg28tpCXOTy3izFa2mw3SRKl05bnWh2ikaKL4dN+pIleLAjyCrXj6f7KvqjgDgMLWqh++HfOi2Tv79k5VRQQHDnWrO0TwCAgHzMowIjUI2XekqSCuAFbW3WdRGr+mTPZ7vOvAoZr843gKwYa5PrgA0xbq74UcMM1YrxY+0YxWCaEupWXAFQB6hpGk9XhzSVlo+h8zEuRz1wiHX2ske19Gx1rBkOuW4oCCUH+4Fg81x6DRLZy66Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2z2t9L39EmW8dBIE/GkT5RtCinf2kkVV1EQuT0MmXY=;
 b=m+/Wd2dFs7RkSLHXGmST7jZkAGmX9w9b0xJsd5eQkZImYc3MK9aC5aY2eIjAL+QVoFTAaivtQce+MPN9/ETeNFkyqF9DXn+DdhZOnBmESWU+WCjxxMNP+8sq6RtPGZ4lYqoIxefhVGziAJmJsIRDStSFzsyMnDGkgcbKCVU0vGo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MWHPR04MB1041.namprd04.prod.outlook.com (2603:10b6:301:44::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 16:03:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2%3]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 16:03:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] btrfs: zoned: activate new BG only from extent
 allocation context
Thread-Topic: [PATCH v2 0/2] btrfs: zoned: activate new BG only from extent
 allocation context
Thread-Index: AQHYPczZC3sz7fbq9kWNdZlHbHUcIQ==
Date:   Tue, 22 Mar 2022 16:03:33 +0000
Message-ID: <PH0PR04MB7416D5F191AC2BDBF4533DD39B179@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1647936783.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64f72e78-0b42-4e4f-0faa-08da0c1d83d6
x-ms-traffictypediagnostic: MWHPR04MB1041:EE_
x-microsoft-antispam-prvs: <MWHPR04MB1041AB74651C9BE5B3BF7E549B179@MWHPR04MB1041.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M//iyG7DVVD0VC+k5S7Q2VAQISnJMQA59tfy1ZoDcuv/FhSRQME5X9nCGpR6+pJQfjadp0fFNKJVQj1d9TcOgFuJWp+YZkI/MGm/W8kzaenls+n2q1no7AJSakXg65ugTJ0sALuxK/oRXaserfOysBpIB2ApmNE5tsdtsrB2Px0ucjB77ae0A2qYUv7IBsjYXcNn4ddu3j9r/fKSLaYLYTbCpci6Sfzqb/8wTcLlhjE6ASm1C31zD7nFTq+IKN9jjxtGhYoyV+XnFnECPAQEOc/5uwBpNufeqwgoKks0KRLWK5g/GIaouJz7j919OfNLgymoYrrOQ7fOlmotPMaJf3mtB/TA9UTPQWG5PU7+olxXKyO0T+r1brXLN6lGG7MQXBoVLuz1A1PIBF659hUMJ/u65O8d2Mh1+jsWQX8OjX4oIrnLkdPMF4uZOjRRzhSq8enSzW3sd8lzR48jHl2vhmphRZN8MMAapzteAzQ966hV22NUlmddfS/1j9wYIZK2lJ2i7hn78Y8XS7VXHdq4r6az3iQy4OamAaG7tNWCJMHfphsDUrjBSBAouEPNs7q2mm6JSjrosPtK2gREX54XMWJ//4v6jQ7D7joQNJrs9h4LO/9JcLHjLznRTgM8JMFTmWfFEM3ihhev3+J/opT8SeuDV+TEKvXx1EpHi8ybCDzTrmF0P6xa10xS2zBlhZunUMI9ke1K7ZndFG1HXVr6kw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(2906002)(83380400001)(33656002)(186003)(26005)(38100700002)(38070700005)(122000001)(110136005)(7696005)(9686003)(6506007)(91956017)(53546011)(316002)(82960400001)(76116006)(8676002)(5660300002)(71200400001)(66476007)(508600001)(64756008)(86362001)(66946007)(66556008)(66446008)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EJ6n8ZkHMPXwz5Jgo4UjsTyXKbqMhUXqR2HarXqoD1Y0YMZTYo5UPVrNM8wV?=
 =?us-ascii?Q?tYAA9fLQXd9OHtqWW5O3qrKLDxAa9MF5s7n1CuaMpy9Ejl1loq9AEtPQkGOr?=
 =?us-ascii?Q?+aWfDIjAUIX0qAvsnLDipUyZfEslthRVdmT1wXcXZOwYGMt/hNCIj7j0pO1y?=
 =?us-ascii?Q?UnigG8wEiTQ6cZ2o4XLKFqC7HWgbrywrqDVbypPqAvJwsyXqQPjiBMbD7RQS?=
 =?us-ascii?Q?XA+azTJDhJBfyXJlkBwe5xDS6w+sMld8mnlZdsktrYJMxARcEBu4vET8uaXv?=
 =?us-ascii?Q?CfBplRkuOlWvVzUxiW3EutBCkycEDj1IJ2BdoIVpvTLpQv0DKb0ujPGgfJK9?=
 =?us-ascii?Q?lmpXSXqPNuH9UC+lHtngKKYNnW/92jEhd+/Z9usFqRPD9PPIGIyb9sFM2JsQ?=
 =?us-ascii?Q?N/8k0LUDtjPY1JRizlXqccwcNlV84KHfgCtXtkB8Al7Cu8ZwyyItrbsvo9IQ?=
 =?us-ascii?Q?UIHvnpNoQqZRa3hVL6O//UJNgaPDjDFhyrZhY0XSZfmsOCsG8fRbBbTllNWR?=
 =?us-ascii?Q?l0n/GJ4bmioyAgvxga63zD/A3hKH+XF8xfYRbuFw6k/7ETSxdIDg9Qa3cxIv?=
 =?us-ascii?Q?SIacoeDvKW8g3t4ltlOEAIdQ/dF0JwOupSozUOm4PE6vlfdSoMWnMOD+sG3u?=
 =?us-ascii?Q?SQf0juTW8Rmszdq8CzhZ0j/UfSfILjmHJq3mtAMgODGYWbTentWO5hCBbxm3?=
 =?us-ascii?Q?1RyUumBvIZbuBLZ90i4O+2Mtt+y19mTlQ75N9VUerJ4vT61je1ilPwN/QeaA?=
 =?us-ascii?Q?RewnEGHsHaV/iHwJUEl9QJB9HDauu5Ig4Vo+EbPk5VEMx0K/0kpATPwdUVza?=
 =?us-ascii?Q?yrCLIWlTnI6t5t8Hbttlq/z0GO42LUMts2Z7yF+wkXBuIa2vnl+DXXTN4zkQ?=
 =?us-ascii?Q?FTvpN0Rf3NB6QB/C5XA6TXaOzmRMkXDQmlouTDDOMMRai0zFD/ivwJnb/YDb?=
 =?us-ascii?Q?fxV8RdMwb+ShFvXiXfRGhwXEJOS8R8klPSmMcE1hY/P/1Yv8OfXpFCSCHOUi?=
 =?us-ascii?Q?Gw4LDiThLtHZxSYEjP6epa7ENVVhp0wVD0nGnZxvsiibPdTy0tPw+5topaY/?=
 =?us-ascii?Q?1R8Nq0jzaWt7ItPNv4VK3K0glaVYnmJ7ASRSnHiBK6/NBkx+FxzPoG2COtV2?=
 =?us-ascii?Q?KiO2tfYbxddqw+xyXiRzEBTGID8GgJdW5HaCS1+X+V7hN0rUkZqQmF7DsQor?=
 =?us-ascii?Q?mhqJa8oKEZiRAEq59f2dcYBteq/dx9fYsewJ44UqlcTXzFOkkU2Q7RqQQa6P?=
 =?us-ascii?Q?M6gToxUEPHjpFvYxhwKBCVPi9yVTPyadt3KeR2pDrEjcaYsdIPiNd80i0cM+?=
 =?us-ascii?Q?JS0R4uzjfR4hEIGyZMhBrn9LV0N5mt9AZFfqybpI1FI4U8ybOxJ+W1/btyw8?=
 =?us-ascii?Q?IWm1P6bsj2zoHGWVfQI6KLUxbMfpf/mBw70B/uiZvt+k8VufFcDdMSBw5jOk?=
 =?us-ascii?Q?c1AY5gHkLHGI1Yc6VG7XDfH1GIY+bSsp8EbfkU57OLchNi3LONGg5YJgcgpr?=
 =?us-ascii?Q?uApEqN2aAWe0z8o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f72e78-0b42-4e4f-0faa-08da0c1d83d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 16:03:33.0670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vF8I38uBPzkcuUy9/ttHeKjwHwoDO2R78+kBbvvbQzqDISpfqltRaGvgrn2P8i6y6AfkDLzaPzLCiWEuxxi9rUNJ9pvm1mjblyTnc5TDYmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1041
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/03/2022 10:11, Naohiro Aota wrote:=0A=
> In btrfs_make_block_group(), we activate the allocated block group,=0A=
> expecting that the block group is soon used for the extent allocation.=0A=
> =0A=
> With a lot of IOs, btrfs_async_reclaim_data_space() tries to prepare=0A=
> for them by pre-allocating data block groups. That preallocation can=0A=
> consume all the active zone counting. It is OK if they are soon=0A=
> written and filled. However, that's not the case. As a result, an=0A=
> allocation of non-data block groups fails due to the lack of an active=0A=
> zone resource.=0A=
> =0A=
> This series fixes the issue by activating a new block group only when=0A=
> it's called from find_free_extent(). This series introduces=0A=
> CHUNK_ALLOC_FORCE_FOR_EXTENT in btrfs_chunk_alloc_enum to distinguish=0A=
> the context.=0A=
> =0A=
> --=0A=
> Changes=0A=
> - v2=0A=
>   - Fix a flipped condition=0A=
> =0A=
> Naohiro Aota (2):=0A=
>   btrfs: return allocated block group from do_chunk_alloc()=0A=
>   btrfs: zoned: activate block group only for extent allocation=0A=
> =0A=
>  fs/btrfs/block-group.c | 36 +++++++++++++++++++++++++++---------=0A=
>  fs/btrfs/block-group.h |  1 +=0A=
>  fs/btrfs/extent-tree.c |  2 +-=0A=
>  3 files changed, 29 insertions(+), 10 deletions(-)=0A=
> =0A=
=0A=
=0A=
For the series,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
