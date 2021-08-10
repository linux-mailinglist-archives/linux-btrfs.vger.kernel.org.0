Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55DD3E5860
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 12:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbhHJKcQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 06:32:16 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:37462 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239045AbhHJKcQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 06:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628591514; x=1660127514;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=evCsG0IxsxWbz44V3RaOwC8atmZw0yvPr/Gv8MQm4KE=;
  b=ZHtMMYVlaGkMlVotYeCpTIj5cnanYkczgQl79ma3acOD3dfd/SJWokU8
   8OwU6nR9jvxrap7aR0o0kZ4D41ntnKpV0oXkfs9hZv5aN5PBfPJrGxJXT
   n9OUmJv7LOd9P7ZT1VSSCJupz8MIJ+11U+lDiXdGWaQAqsDX91qSzrpM6
   uvJDOpcgfK7NEMmekb5/fl4eN/bivd3cWGC3YI2Gp5k1b8I4jLXyDmcS4
   cJu+1hMFHr2TGXPFM1PoBFVqwrXwNnaPlw8zadFLZUl7Z7w9a1/ow04b8
   f63asqnTg6B4AnLS10GXrAiAIjYToEr9wXwi09+38xUepteUsX1AnV6UO
   g==;
X-IronPort-AV: E=Sophos;i="5.84,310,1620662400"; 
   d="scan'208";a="280625166"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2021 18:31:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lml2mktcRVTzayrYu58hLBv/bK0r4b1HiCKTvmO8O7S8n3OQY7tvgJJXLBHKFS7OZdi9ivEIX4EDoei7BJjBRM/eVtjpZl5Cg2gi6ip8ojrab7C8FFYpHhANzAojBMi688LeyjPewGWlQoN7oPnkrSyXG4qz6kVsQ/M9lqWrR3V6Du644bcRJW0HX+64hg5MtlFRhQVGJ/91JwpAlElw0uOal+EYurw9UrqYe6UZ1sBQiL8x6k1RenLX8jI+ytqWWeUCUjmxQ3CdvxtKGy2nDrXKDj6Rez3ERVpFyrToEWzowfdI3L0uYfwxbvpMhalskGIJiT4vzZ1qtUVb/DlskQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIFRsdLYkxLU7cRG06MMfDYDS7WHlLiy57Kau2XBrLo=;
 b=OfxvKf7Nl8QlpqOSF4s+MCwp2ole4WtOb4oZ6KBTqD2VDVuUEdI3CC6HrDEV6Id+mc7FUGeBWcavGiApmpmv/DLrk2+Pya7jHLO+Aw+MsUZDdDOKrItdPkYgTdBPMW1kDFbUM8JUfcKAgKTNXxEgGAIvaqqCzZAtD92AKbCpv/ILR7zpfu/sxL2cL6L6GGXrkJ+MTDIh8JlVgwgvex2EntBMJVTbJJhM7VnMIbTr3IADL6tUIthz7GqEXorZY/rPemkfzZLvi60Ct+9dEsBMC4K13VdmaSGDU4Ft2gFMC7Ky3aDQTimVg5RQ5prFvCjcBDtJ0GbFQd3N2RRcEylAPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIFRsdLYkxLU7cRG06MMfDYDS7WHlLiy57Kau2XBrLo=;
 b=SQ5BJXRYBb+F2SOrQjhQWkX0hfOgOKIEJaBdz8gA4j7uxInhGyJ6gvb23G/sGL/M+9Xp4M0o7PqX8eQDXtoXSCCX6RXF+YsUPCm8iGZP5uLldlKlsTiQeeP5yvQblyc+S18lqnTGsKWICdumvi9c1Jere3wVIkWrkCmEQUbbuv8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7397.namprd04.prod.outlook.com (2603:10b6:510:1d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Tue, 10 Aug
 2021 10:31:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351%5]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 10:31:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: zoned: suppress reclaim error message on EAGAIN
Thread-Topic: [PATCH] btrfs: zoned: suppress reclaim error message on EAGAIN
Thread-Index: AQHXjNgS/USBMjdAT06L07uGALANYg==
Date:   Tue, 10 Aug 2021 10:31:52 +0000
Message-ID: <PH0PR04MB741663E3217E66761066219B9BF79@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210809043230.3033804-1-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51e57342-cd2c-485b-3fd9-08d95bea11a7
x-ms-traffictypediagnostic: PH0PR04MB7397:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7397CE51E486793132AF84389BF79@PH0PR04MB7397.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G0ZutY3zDimiYyY8U8tdjAPDKS+/sU/xYTMGwO7NvmmDEA+Ju1tb5dMYHhmVgPJAAab2WEHu/mvwFfCdKh/y0KKqK2+CAXDYbTdZRb2KVW/2bRxbPjlLVB9mgZ4NSi3ndk6bXZ9BkGNJwcehO5BqvU0uLYXDfRMgOShFhneeef5n6fau8owHu+ZnLMCdSPSkgRXsrVk6+wm+FhF3J402fixquClmzadAlEcBswcnikPvZDYHWR703IRnSeFEbW9M+NiijkhO2iko8hfz52p4eql0fLMAuk16YKow+7g4Cpfp7loudnxxrKUERzy3p2kF5dv2igx1k5+cYkhNtKEsl8TMZCe/0e9/bsiAnWOjJoc4Pt1gmFpu04Nf811tUYuSmsJ3l7s9QYk+yqFHSYLr7+T2KLTwAGsmFn9Edg8x69MSszbU78a9riBE3Re8AdSakpFwRVvsyEXnDJopkz5R4YjKXkmxv+sY6u3qyv4zBT2ZujCQPtajpvGt9f1cl3FaxE7IpnAH2iKdV+qOJTMjLsaIeEHGpWC/NYoizp1DPl5eEzNq32viN77axdE/zKaKf7TADzw9pzNAnrvfohSJqAzepP5JAmfJ1Ayf+tL+wVvNNMmS5IPchLmj45Pb/ICwLV5eK/8B1jPn0HnNiUJN4VTnJu+toKa9AfDGwMUZlCxiez13+3Z0Vrl7C1Xe78Ko5vXPFq4CMubzEHlhmeOHBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(64756008)(66476007)(66556008)(66946007)(66446008)(76116006)(86362001)(5660300002)(478600001)(38070700005)(6506007)(122000001)(71200400001)(33656002)(2906002)(38100700002)(7696005)(4326008)(558084003)(9686003)(55016002)(186003)(8936002)(83380400001)(316002)(8676002)(110136005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q/YBbiEn8DhQ9QrIH3GIR6ZaW85tDjefaCUOPakI2fs63BlAlbx7LrJHEdZ3?=
 =?us-ascii?Q?A8/Dk19+hj2wFEr/FxGuz+Rv5QkRDgUhiPWLybUesxTcHb25O1ZWgIl9gzX/?=
 =?us-ascii?Q?BezFSi2fsn0KZNEFeqauEztg6p2zdE7ivcv6aWUXZvyQY4oitWbgRM5Kzfyh?=
 =?us-ascii?Q?rb/x8IGiNLdt7PH4U6jMWWmfTQ/QPTOs4a/7+DmeW1Atcvol05UdD5SLcrzN?=
 =?us-ascii?Q?uRK+yv+VU5RFID8rB512YPiDynCHDmjtkbDX7YWgkpYDi5Ca+FSt2pgs7VTO?=
 =?us-ascii?Q?yh2mi2RcGALsXaPbR/cGTd9zRI6onoZRl0235y5yyurs4458mCF5BNp8EpcR?=
 =?us-ascii?Q?xiwNWAtHwAQtEajIw6RA4cx6ir/Z2HmrQsBU1lZ+xfMTKPk1YtQWdYKOeYUJ?=
 =?us-ascii?Q?ipOD1YXHoo+MXhx2zJDEZwkvOcDKTH5U3u56Od3ILStjR8XsL0E1o4JYoedK?=
 =?us-ascii?Q?UEK1TaSS5hJ8xUQpXVjDs9qewGip2tC0OQibHLlfruYZqawhnUEvyE6PD3Vt?=
 =?us-ascii?Q?6FUevEJRlVu7AvIDhWrLqJZ9FM3Yn8lV3sh9zKmEhVMqG+WczyeEHnP5raVX?=
 =?us-ascii?Q?D0Ohav6bxxbiqWG9qVrjvVQK2KZnh2+hXAcf/FTZbIP+XkbicY2V3iYPA2RW?=
 =?us-ascii?Q?/uFXkj+QBmqKjr3gmaKhCjpyoWA5ay30ZcEXb+D1aiPLRUaSu/ABT3MwhJPD?=
 =?us-ascii?Q?EgetVodzct6r6K8WBSd/XV1xPtLWmAEccF8clGNmb4ylKNeOykiJZMVknZbd?=
 =?us-ascii?Q?OLqesVfLESGF1uH+oIiiI4caYI4hn78TuXG/W2Y3SFW6ePnVTA0ytxl798FN?=
 =?us-ascii?Q?VLBPc/818MhcJngeWcktnP3TVrBib/JbZBNtShZZFwkwRoT/1i0bmoygNSEl?=
 =?us-ascii?Q?ZneRgWf1Rjm5tzV4cnLwiC5m++YmjNYwY7bg8apzXZsY4VRtphmn+F1ioBQM?=
 =?us-ascii?Q?MqBgvz4EZc8ARPI8d3X1hq7Q5aOLiI8pnkuG64Qj4N+IYtDM7JeadoYaxx/g?=
 =?us-ascii?Q?XtM0AVH9WcKdPQbVVWRK7cKBHPoGXG0RLwAmn11ztq77dK3Q/uoi5f5t3e55?=
 =?us-ascii?Q?J2HxbTnay1N7uWnKtIJsGsy+KLN3eYWGyi5/9lUADXmNyyiOLnuhduvE/KWX?=
 =?us-ascii?Q?n4ZNytap08L57K8D45bJMsTpDr+byAfdhZ2nTjbnkZM0zNf1IvHf1nSZ9BCQ?=
 =?us-ascii?Q?0T/S+Lp2ia0wcFKr+mfX6cR805X8ugtC12FWGUEtizt3wG2tRu+oyHDPQvB/?=
 =?us-ascii?Q?vUfpum4Ho90Q4zL8/GlkIp9EcK5iX4GxW+1GaGSDt/Dxo9HMCmxRHyH7sX4w?=
 =?us-ascii?Q?jzP7+EieQFg0PmS/hBoBXOX5yGS5y8IDTfzNs0LUG5zdA6pDBlQgegKyqfZe?=
 =?us-ascii?Q?9Sf5TbW+d70nlYJKxqtpV9GGucp2SD5c4jXz/XEeAE3o3coTvQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e57342-cd2c-485b-3fd9-08d95bea11a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 10:31:52.4322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+borflj0JLsu8yyGa+vxwrv8Y60JB4KCz6KFDeWd2nULgpESdriPjjO9O7UtI+msOCg5m8THlt5ilxYdDPgW6y7zZjBRUSruhidBo792w4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7397
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For those following along at home:=0A=
=0A=
btrfs_reclaim_bgs_work()=0A=
`-> btrfs_relocate_chunk()=0A=
    `-> btrfs_relocate_block_group()=0A=
        `-> reloc_chunk_start()=0A=
            `-> if (fs_info->send_in_progress)=0A=
                `-> return -EAGAIN=0A=
=0A=
=0A=
Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
