Return-Path: <linux-btrfs+bounces-1595-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4C28362DA
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 13:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477BB1F239C3
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 12:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40C53B780;
	Mon, 22 Jan 2024 12:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GfBpVkeA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rRjPgmyL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3DB3B196;
	Mon, 22 Jan 2024 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705925556; cv=fail; b=gXhtjPNGdD0ksneuJk6HuZRvqK6sy9HmZOYjYUWT8ooCIsiwrjrfJVFNrK/rteSLFxyAdcwkfKqeC715oP5O5vxbSKTYlgrq/L+8Teu9+K+mZocA+7kXRbPEwvtv8iQ9s6qDUBWffmHOPaVKQZF2NV9D2GIplxaUPpNR1XGtsiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705925556; c=relaxed/simple;
	bh=QN7jogb3RG5lZnCzbwJVq00qL1/UKqptynO9R1KPZsM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hv31uZlOYWwc+YGsS/NEHxAbnYuXV1DGsg19ItlWgdhPtViq5GtD/IuG0/T5e5JEbWdUVqaAGqsQfRUi/+l5QC6vSE8qIHtb3bLtZ4IQs8Qy623VtFqbNNEIxwuUVlrhYf2C5GuZMh3g4EDqjjbEY1spypU1rJDqUz0jZVixlJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GfBpVkeA; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=rRjPgmyL; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705925555; x=1737461555;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QN7jogb3RG5lZnCzbwJVq00qL1/UKqptynO9R1KPZsM=;
  b=GfBpVkeAIFfyv38PYGFeHFxe2+Pzxglzl6Cn75Yexe4iFe742ESpst5c
   EOj5ZWOxZCuCmbpttLDJ8Mk/q8vvBbDpQZBdz2iLqVJ2FhE/uhX1tLS3C
   STDqJ3j5TX5KFz4Kiqv30wJqBUaIF694frI3ZOCVKkgTlKUys5WhT7OjP
   byBXA5OupSIPNHEpiEzFd6jCf3clLU3KBgzvfNw+1RnGT2UTjQfxXjN0/
   CgbU/Wkn9GrHixZZQ0vR1RmBv6HdlAH4pd+TmYUypwPSFRYegpoa/nPnR
   5j197Ae7U6AZ9zhT4gaF6qPSAhdTqdtJI+8kEer3vbzBPd/6UXc0ZJOSx
   A==;
X-CSE-ConnectionGUID: TiNXXhSYRtiXchjJjkcz8w==
X-CSE-MsgGUID: tRMi3IRlSmaGYqKuOAIOgA==
X-IronPort-AV: E=Sophos;i="6.05,211,1701100800"; 
   d="scan'208";a="7928162"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2024 20:12:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKRoi/9ZWuAw7etHymtbEOpcbDldmL/sI0s/vfvz7Q354d5WdKg9TDWU1PGk9iRfbqj3qWKjY02AvrCd5QW5YEKKg+jb/Fr6A6QFNF61z/wOXwwH2jcJKOwr8gOKmICTyWhFoqW0sKPiGLGDWvQ1MlLFB1dz1/U2uQ4Pn06r0uk0iB+DXqW0MeYRKsTgzSKW2zquJjAbeMVlXcge9got4cwGaS9MfZmBoh9NztLwqWn7znth8S3YnUTFHIg/DjiGD42vYLn6s5AMnDsB2/RP9n5DrOl50L/0unipckR5PLTVUu014sKQPE6FqsgNEynDwqjF6MW0qfn5Lp/AfhlpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QN7jogb3RG5lZnCzbwJVq00qL1/UKqptynO9R1KPZsM=;
 b=fauV2rl+H851PpVDr6g8kAvdaB9q0AC2WsOfoWLsMR+1DgUayZJVCoXt8Z8RpbhgfltTS9psFvIaehAMFNV93jPpm6lcPKhSISuf4mDzsfadvpNqfynh5OIj8HQYSKcBHmbLlzAdGWsScyBZcTBoHl0JdFHc7hOZHg7NMrfYGAtAigFl8lZFabKtt0jFBvWj6sgcePFTMZKT4bVqtLUMMjAtwJY83OtNZkgZndkDBA6tHlXEDc0ThSS40Hq5OR6HR2x29RjouZM2Mp1S2ggjWUoWMDkTJre1UVhTz+Y2CJ6JA9danBGrg0zd3/9pmvnLE+UcRyAdFow/UQ6iZNV21g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QN7jogb3RG5lZnCzbwJVq00qL1/UKqptynO9R1KPZsM=;
 b=rRjPgmyLsF7E3rJSfej571FDb4nEsXfVDsK1enCz7YErmRGzkE57UGifpiw2nsUFuU48/cBAEqrkKlF//1JeGb+QfD8A1HJ8tHuX832Zh8IJaTBn7vtvdA4Kqm0/cJhko48zn89VJBT4fqEJOdJW9Hy+rGiAINNCq5Me4w1byH0=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BY5PR04MB6293.namprd04.prod.outlook.com (2603:10b6:a03:1ef::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 12:12:26 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf%6]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 12:12:25 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>
Subject: Re: [PATCH 1/2] btrfs: zoned: use rcu list for iterating devices to
 collect stats
Thread-Topic: [PATCH 1/2] btrfs: zoned: use rcu list for iterating devices to
 collect stats
Thread-Index: AQHaTSDueMfLZECX/UiLJj78u0qsV7DlvkEA
Date: Mon, 22 Jan 2024 12:12:25 +0000
Message-ID: <xow7peddc2x5dyrttecs2evtw2vtaf537ed4cyzpp2htbufcjp@ul7zzkmkfcps>
References: <20240122-reclaim-fix-v1-0-761234a6d005@wdc.com>
 <20240122-reclaim-fix-v1-1-761234a6d005@wdc.com>
In-Reply-To: <20240122-reclaim-fix-v1-1-761234a6d005@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BY5PR04MB6293:EE_
x-ms-office365-filtering-correlation-id: 534e6b71-28e1-4d0c-7bac-08dc1b436563
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GricgW1aBwJWfaACs3EjeYhdl5HQaOq9oU6Biy2ivrVBFlrIumculWlxmgguj9CAYYyg9iH7K7EMHejttbql23rq2fohPvzQrZBZuAWMe3ucWSuiZKBUmhewoj87A1lOKYnKiPYv6S6DxBR139PWi54YBb/2vNLVU7SWNg5c3qRfpIu/HobVY7vdsl/cWlmuCZWKdT+hG76e+jv2XybNGXhiwbks11TZPv+s6gQO8lrXTlNzXG+y3wjya7PcFG72lOqrdw9J69fsZRhDtB3ROTvlqLudK+233PdvVH8ZQdvL8XJjBwbiuWdhRD5337s1BfzBYYpBrn/qGgLkeVYGO8PIBarg+ki5XBZPaPpF2dsAyd+4e9yaebFgbSL3c+Sze0DDVYT2al4haJ7+cMRKIi/hiyvQIzmWCf0mAWE1bXDSrUNCF9y4CioYwb0quZP4LEmQgBiqvuKxUoi5M1JRQmv/tOaIgouskP+NaVnPvEdXOc2QTp4vnIG2Az3CKvMAIVpJOF7P2MhUXU4Wy7KWhQJ+YAj6zmoksIaAmnRG9W3GctSEPjFimklbJyJyk0wcCBY+ffuoUI6jloxNtUIlj6a30O5n5gNBYS1kV3YNZakf/72W7fghRgydZNtlUcIK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66556008)(66476007)(66446008)(6636002)(316002)(66946007)(71200400001)(64756008)(76116006)(54906003)(9686003)(6486002)(6512007)(6506007)(2906002)(4744005)(5660300002)(8936002)(8676002)(26005)(83380400001)(91956017)(122000001)(4326008)(6862004)(38100700002)(478600001)(38070700009)(33716001)(41300700001)(86362001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Mekj/70XnamkorbGXng8u8ufvaT0TMw1VQnsjSaIy4fXp6m5232TbiTq2ue7?=
 =?us-ascii?Q?9oqBy+S7nkAmTesjLjGYd3o1ZciXH+npByvbS27lFYm9uqVn63Wezps0qG9T?=
 =?us-ascii?Q?Mg22ZhkmTWfI993ZBQjq4vYArdoNkvGgaRGO3Hjp5uQzE76bYzMmUreIHtKJ?=
 =?us-ascii?Q?XBAfQYAKykeGpnC1cO8dEfvKtJ7nJ/JNUtgle1lku824k0EmpXIMSCFc5trV?=
 =?us-ascii?Q?/UcuuyggGxFgExk9K3bTnX9I79YIUkFYjB/+w+uHvt0bmrdTorU4WEB0tHsB?=
 =?us-ascii?Q?+6s4DyLXiyYIV9GZzLWIXXCupDKczul7ZT5KDjE4xA1079T1prp2hFx15Bcq?=
 =?us-ascii?Q?ZTu2e2H1HJyNLL6sGoqd7syXqavrqvk8BAA4ENB8/R4PPToF/mxbkiD+OMXA?=
 =?us-ascii?Q?PVe/pJ5S+BYfF/izeh1Uh0ExTx1yweHiNy1LMx1F0gQojwkOfShBl1zpBNIY?=
 =?us-ascii?Q?CicT6TLIDDRkmIuH+hd/dOs3sBRAjcVDndEdK/wlgY2jQud4J6ydOwEBlbmf?=
 =?us-ascii?Q?hj+p+IV9S2yujB27f3f2AYYLEi75zm/rXGR1lzcmMb9IKwEg3BeEO934NHLS?=
 =?us-ascii?Q?G449h0AivJyHeMPoX9UibakIYhsa6+e0Y/amEksYnwHwmT2qL6b11bGmDKMb?=
 =?us-ascii?Q?5Pgw9Dh8iSLPakhkwn/y+KbDnWgY+7h0OXuIRHquMyvwB/NaXFwbr0lB9C1v?=
 =?us-ascii?Q?oZLcH/sKp9jSHUVDiE+8wzOb+PoC9v1rUcd7vDgRCa4C5hbQcJ+xCAJmjshJ?=
 =?us-ascii?Q?AwXDDh0C0NB0zmkIoCW/kjJbq+cDs5ZmUSu76CLeXritdmldK8qlWTKYfLsr?=
 =?us-ascii?Q?9DegNw0DawhojYMKZ2nRgAVMBYCtSV+ebnSe9/wq2CybQjFnCs3lH+NS+gXA?=
 =?us-ascii?Q?ziWkMudP68beZAVQ19yb/3hKUYjaYgwoDMgLM99nnSDCUu4/E3XsO8v4m8jH?=
 =?us-ascii?Q?NhXm4d7+nlJ9OvdQgoyTbyO+9OXBau4h5Xtcx+DqzmF6wIGKEoUY9uDWTY+I?=
 =?us-ascii?Q?kodHXIj0aKKPSIKcrL1SI1HiB/lqjsGgsRrRb2vO0qZDwvDkd+mM6rFgQ7iP?=
 =?us-ascii?Q?z/RT1ex6TxMjRzvhh5FW1J0ldza3+GZxXGFnHy6/nEBN89MAAeMqt4B/2IqW?=
 =?us-ascii?Q?Y6ZAVswbi0YVcNh5p6WOyBL/OK2g9bRBgx/7dXitMSnvhWtmdFWbnnpRHgHf?=
 =?us-ascii?Q?ykHQcGNz3e/p3JbQHV+FD3EO+B3VMo2oly1Lb6RCplDGP2N2k6VyxnvQcYo8?=
 =?us-ascii?Q?PjWWVxgc85BDGKcF52kUF0ZBhdDM9lSVxoE3B8qtKReQ6xymp666a3FEUqJS?=
 =?us-ascii?Q?Vf/VKHTZsYmbJnnqVb2mk5+pcxoom34lmX3ZCtoFb78/fRP7iXQz4RpABJUe?=
 =?us-ascii?Q?ThzkDAnMNx3S1+iTv7yObaGe0BLOdG9L2NLpaZ2M8LtLrUKXuy5dTKum36+I?=
 =?us-ascii?Q?OYNMWzQ+pOcvLshrwEyAcrcvcjYirQAqmwGF7gdjt2DzflVB9vjGWEUiu1Ap?=
 =?us-ascii?Q?fimWFwrb/nr/ccJqwUv9hfHBSSTFrugFCI65P7RF+xopcnfXY90pUVOmt/yB?=
 =?us-ascii?Q?JasS61CXNK5Sg/NX10y+Lbgls+zrQ/o/C8e3qSCxYrlSIjegUXFTFEnRaelS?=
 =?us-ascii?Q?RQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A10C12A8F910F54994B3C7B227DBFD17@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xr03RWRjjolATwBPgyGGZbRQr7i+7BkrqQwJIKcErtDAdbUvJC2n7tqhiCtFoQFBN9SssFqbOJ2Tp3UBxaiK+TgT2OZfProR6Bayo1mrClwft8Ls3S0zphXLpmdsuxQTsch1/Yo+kJnLke9kguLQB1rhAZ08NkvhBiAwvkzH3aWvpZZJyh7xFLJ+CaFpXQ7w7t6WHpEiaC9EQsKxqrQASdFYM4x10V1CafIKNpn0dLPMD9C0MMPUtvd2FwXM2U8s0I//zmP6yacWuvBMHnJRSCsGDwC7/U/agRoXgI3JYz+gPPfFpU3uO66aEf5W5rs7C/vlsT53VviNaSB/DpxZCRwoSl62h6zrrZPSAEbGgzMbR5lO+xyuL4cy9wnBFjo3xmnI0nb5NJt5Cb+y6z2zilY0r9t7Mzcy8+dmOSFzF8opXZrPjAziP21XLL8w156hDX2vQd7LSscq0axTl4L31hdYSjlklp/1zzfHSVoHxUG/3cj0qYL3oiK6fa1Yerdj/zBTtubDmZIB86mArdlkS3VVx882zLoxVOKRd8K7gOAFBHctO2Qv97KhxDTCz48lLkK3ggzftIhMtnEE/kzxivvhSOZS8tpguweIcm8DuhMd39n3TQAax1J+OTdinpg5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 534e6b71-28e1-4d0c-7bac-08dc1b436563
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 12:12:25.7235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k/c1wz58RAqbbG+/Z9zyZStuDVDwfRikXMCiN381jT7DZ+TqsjcPxnXMpKJjBQvvQ6uSCGVK83VTfr1+TplZgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6293

On Mon, Jan 22, 2024 at 02:51:03AM -0800, Johannes Thumshirn wrote:
> As btrfs_zoned_should_reclaim only has to iterate the device list in orde=
r
> to collect stats on the device's total and used bytes, we don't need to
> take the full blown mutex, but can iterate the device list in a rcu_read
> context.
>=20
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=

