Return-Path: <linux-btrfs+bounces-9628-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 006DC9C83A0
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 08:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61DC2B2428F
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 07:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922761E9098;
	Thu, 14 Nov 2024 07:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lO4RTjgO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="clgzCGyy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9680442AA3
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 07:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731567886; cv=fail; b=oHRUf1dnXmrYms3rsMWTBBD/RGGFdO3Ab2ojqr55Xj94iPb1haI0AmHPIfJqcwgi8G5kpIgpQCDAj6bhW3Rh7z1r6vQuj1c8Zs7LXptMTLjOispW2yMj+FeB5rlzKOmzfWDJ8uglc6X2bryuvX2vtzZ74K8WFBicBIpDpn98VdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731567886; c=relaxed/simple;
	bh=UVGG+iPv16/BD4ZN+TYdiZXbtXVAgTq71Ru2zeZMklY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SSWEh7ziHtrJVjQPNb0toovxpSyWqmCRul3RXmv3JAbCZo9co+E4RtJX0XwPkud1QMOCT3ND5TrQW5atpIqHG6ZgMf6lDQEeyFem/FqUNaIPuhG/sTESCIOxEUx6OM/Hnu4xadwf8d5iibD94QJDK+gZ2AFbXEaqR0Yu8eBTTBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lO4RTjgO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=clgzCGyy; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731567884; x=1763103884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UVGG+iPv16/BD4ZN+TYdiZXbtXVAgTq71Ru2zeZMklY=;
  b=lO4RTjgOwl81jMzcr1AClm+qijA5u34ZzcBakzkYqVkd+EAASPKhwxTY
   7DNSU8AY7wB7zayd9LgMefPbkSBcaYvkqMzYWcf8Vb0shc3kRAIvJk6ou
   iuYgEKfztKMu6yyP+qm4M3PEi2SskM3NJGeBQNYHg9v5vKduuvDkGa2nj
   7HN4j7KW35XoC6PN086JGnTPcVr/9yRI0Y7RnCEVKCG3353FKtPdZZVME
   tT215oMAxtd+uAgT59/Lg7do9tnuhNxPOPxJzdV3yuy84tpIkrUTCwuJE
   od/iowp19AAwvQzgPRF9nOZQhf2j0eyiEEhcifvwJudZS6Cy5A8pwfeLr
   Q==;
X-CSE-ConnectionGUID: 5Sq5GZl5QjawKdF6POBEVQ==
X-CSE-MsgGUID: XfZLfRqOSmKol7Hm5+XuHw==
X-IronPort-AV: E=Sophos;i="6.12,153,1728921600"; 
   d="scan'208";a="31974700"
Received: from mail-westusazlp17010003.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.3])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2024 15:04:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcaDTLkKwEVQtX1nPvIFk8o5wKCtpwIQRenIGf2phe35dkMTEWX7LtjwZr0ehj9Wkl4xZDDz+c9eIONlcMD8tL+iw4DfzDJzMCmAN9GwYrNw6WXP4VAeIxMBwUenDgYFDGEsXZFBHoKO5OX8kkw/snPiBJaG1ozs36aivRSksltLyy2HTmiCT/sNTIDCYOb8SQrUZnDuDYYwIqorEzHxEGirLXryHh+ANfqt041JmujYOxt3daELh7nLzitSChSIY4MvhzGg8pG51+oKMCZ6LbNgyLqLBH9ZEKLIbcjlw2bngwTiBWHEpdyZP+/6df2rCEV+7Bv2KFGEXjuKWv0Sow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyNnyKyp/SuTon+NMKU6Wy7GxAQqDX7nkRa534sAbQI=;
 b=xeATCw1iMuCMey4NeML8cs/aQHMgE6D+zC0Vim7RyHq35drrb04ZnOmfTx/YTYMBT2WXbtpf2d56RqgtE4K5+dT8krRt7lZTj2A+s5YN/jhmcMxFrnEqo9RUlN/Z0CaKb96dnO6WznI54DXhS0WU2qbw7xGuyEFM125UvZKqckoDJRluv0W5pSJhGq3MaUfFPrT72xMXLN0BNFEe0N29Q2h5mO825WaOMa2R33daGCiE81xJddPtgpJevfhCSoqp+8BNKMF0lUz94kxOaNC0ebnqjlxZXF2Qz4uC70qq1gVpT3cNxZ1WO/qUN2gVDuGYU1svhAceU0dfedE2x3vXxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyNnyKyp/SuTon+NMKU6Wy7GxAQqDX7nkRa534sAbQI=;
 b=clgzCGyyMWu9m2b9TWhw2u1R4VJ/RrY4nR2RENTo7NQZtUMNkw+86AwzCKN2Nkyri+T+8ikm/ouzi8qO5afWgMArRmDJh0oOTZHbp7sRwdlNnUxdVgkMfiz7K+/KshH8Ekg4NdhWJ5M4yr/oXLqJS8CmpR57pdZSOP8zWUQq388=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BL0PR04MB6516.namprd04.prod.outlook.com (2603:10b6:208:17e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 07:04:36 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%6]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 07:04:36 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: zoned: reclaim unused zone by zone resetting
Thread-Topic: [PATCH 3/3] btrfs: zoned: reclaim unused zone by zone resetting
Thread-Index: AQHbNA4FZl0tQwF260mzf45S9KGKy7KxyV2AgASVc4A=
Date: Thu, 14 Nov 2024 07:04:36 +0000
Message-ID: <gjr4vwt5qm7j36xnjijp5wqttpmh62trhsq5vqeotcqm6kx2pq@qovd36rh7hap>
References: <cover.1731310741.git.naohiro.aota@wdc.com>
 <72946446ca8eda4477e0a11ea0b9d15cb05aa1e1.1731310741.git.naohiro.aota@wdc.com>
 <a419cf9f-7fa3-4f75-b459-23c1fe014c14@wdc.com>
In-Reply-To: <a419cf9f-7fa3-4f75-b459-23c1fe014c14@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BL0PR04MB6516:EE_
x-ms-office365-filtering-correlation-id: a1d27d05-bfbc-4253-bcee-08dd047a995a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BJHoj8Vyp1d3QrVV/jcl06G3sahprKk+C0YZoEiu3dhFxF6og3LXvy4F0q1D?=
 =?us-ascii?Q?Md0jA4s3TZrrGW0NI5aVBWRDeUbqlDcN4Il5XvjIaEjpTeml5XOE8U0fXaM1?=
 =?us-ascii?Q?HLyX44mseuFwoCw+YRLzEXxZ5O7JEuMCDTqEQvySQqkJdDpcRZA3BAXhrhFj?=
 =?us-ascii?Q?tV7rBIZJT9kmj/aX3T241yzUx/2kKznO5CPDpwBpOsJMaa0S395kXNh1habo?=
 =?us-ascii?Q?Hq8CYERB1xPnpVYSvkFmwi0hy1RZXS3JnzKqysvizYl/hQDuK0Qgh/fdvd4A?=
 =?us-ascii?Q?S/7013XCK/5Ua7Nqz2TJ0culdsmGlU4w0+LSH3fR3vNtViqR3GdW40b/00yG?=
 =?us-ascii?Q?CsUIbKSLAIvhQWNO6yrT1XKUqcBKg/5+bJm/W0FrDrxwerR3xcZGnHL3NK/G?=
 =?us-ascii?Q?gSFulJ0qIHTFBiCaZKTBbiPRo+OrMr8cjLJxJw+aFVvfGPRLbMhAUKOlepIl?=
 =?us-ascii?Q?drthJn/vPz8l7qdQOVkbVFEd5C0CdC+yRh+7oJzSVt0aDoukRwqvSF8x5qWR?=
 =?us-ascii?Q?KuBkZlJ3EK8w3Vs88eNP4zCRZlEIsimdbFXj0qJrUz8m9LaeBmQbMEC+kr0w?=
 =?us-ascii?Q?+R7LM53tKyDStzv+kgxl2WdOd1m81s6Tnew2D+5XQ7Wr0bb2UObkGC2uQCop?=
 =?us-ascii?Q?iiH4dw4shMWiF1LOuTW08sXNXHX3EycxZXgDpS3LT+kTEZDiKVm/OlrFogSP?=
 =?us-ascii?Q?ammd0L+Oe9WOXpXOqLumwh20P+F18RawTZ9QyeLKxF1p8qZdNO4KRICDfjx4?=
 =?us-ascii?Q?6SWRURssgMhXORvhuNcH2xUxQ08Xm5Oo0uWIoXIgiImQ8AoSb/HcBTPlkBXf?=
 =?us-ascii?Q?tq6FYNpahPXPs6hNaiW2tKsaUHMeixBEfwLLtke6pcuPOWSVQxzYtznfGhHX?=
 =?us-ascii?Q?INQHJI08OSy9Z+rSAaWLH7rN1mS7M6Abl8kHq6qeeRjkBEwJz6RmGyqc8QPx?=
 =?us-ascii?Q?2TiTq9wOk3EbkJNuwlFc2f52QYUmPlIXsxw/pK/LiZUFfFlSl1AcpwerMbw8?=
 =?us-ascii?Q?TbaFrqrasbd4epa1eCg4oz9JntJgLOle1LKWNJ0Iwu0bFEruu6BeJ0o7ZpGf?=
 =?us-ascii?Q?tYAsv7HbEnuiBoyIncXDIoio87U5zSaOQSHcdvmkvJmG+5vpjTKSmsr6hx85?=
 =?us-ascii?Q?ewvtP5KAaPscG0GHw/bbRJz9+cpvtcBgYGz5W0g3hDe8EmTzLvWYds66Jq+Q?=
 =?us-ascii?Q?PDBzdxSolKCjPRis2LoGqy2PB6+kqhhfEg0OSVNtFd00ZtexQ/oCS2KA/nri?=
 =?us-ascii?Q?3YNWEqSrlDHdqIpG3T0MgFzoly2OgHDb96LkudC53fa2U4rwf1J3mkibtzRK?=
 =?us-ascii?Q?29sqnzYJZBfGhe5auyFcMd2J7WEHw2w4hkzxkNOgqapVWHqedciq7OQ5umkM?=
 =?us-ascii?Q?65VQG3U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?saeaMZ4O0ZZRZUh+O5sAa945x3J/A9YZ8y7x7WfVGch1gUgrRfjI5FS4iJux?=
 =?us-ascii?Q?ePVO6iUeMqkC4puoqQ2NpFkbAEpjIJOLX5zd4ak+FxeUUzmcp4mQkw0malZZ?=
 =?us-ascii?Q?wlzG5LcqPrZMeE4k519i8r/2FpegwTUZh3/m1/RfdvFjJ/2e0N3SOtXiHaC4?=
 =?us-ascii?Q?nmZZsQSyzduDkYUjN6rXoLzi31hRPqDdqfjB5Cmb8kIENZWUxtGw7cNm3UmH?=
 =?us-ascii?Q?ezg3L4MaDdaHriqiPHu23sSYuhcqzgSJR8FZPZ257xOk21Aed6QueiUktcMP?=
 =?us-ascii?Q?dvGOYf0HqaAghbafGWf8oypVvumvs6zLQdfegN5NFY2oCAFzrHls8cNGnkxO?=
 =?us-ascii?Q?WVXmarq391RyHpISxGvDENf3EQ6GLEong/VJ3hrxQo6CgwN+PpLN4E96SbLl?=
 =?us-ascii?Q?gSiC9VPzGvSrwJ4FCsKH5lW5Dt/IB2qUq4rKXZGGpowYXi6G38BXRLM9zRHS?=
 =?us-ascii?Q?6e2G832K7VcDTB0WiT/TxbMVAL8DSZqJzprqp7JdapmcqVSZTKyt0siQnLN3?=
 =?us-ascii?Q?zaYCltX53qrkEit101j8XVQemLJCGXhysCKyNO999whs4j/nigFgGhO2PBwS?=
 =?us-ascii?Q?VrXxpY4Sn5hy9cXEtWoZcSJsXcHmNHDzkjw3BQGOCCHw0FMsI54lVJzGL2dK?=
 =?us-ascii?Q?84iissdRDYNhj46mwH7nNIhfh/872BPYyIkzkohlGldckWCfJxdmrcNSOlpC?=
 =?us-ascii?Q?Afl7aq0zYC+DwKKdk8Ln0W5ZrGZu7CfZwNnQtno2sSrEWTzIdZC9cR44bcEu?=
 =?us-ascii?Q?xcU8h0c+UNwB7y5k8MGlZWdJhz1jjuyhuhPaKpB7IVwH1nQbtyxKkYi52oGf?=
 =?us-ascii?Q?xc2pI0rfcaoN7Yq+h/XMHLvkujn2Gl1o2PCkxe+3xhhn/dziE9hkTgIzMLWZ?=
 =?us-ascii?Q?ztZqm7fjKYjo/5jQHcEcOs0fUUATNea8p1BjTs5ZlIqjt2ukhCvdQ9GVJCTT?=
 =?us-ascii?Q?ibmToIsSjk9tRf1jShIoMPKoWQaiu2Q/SD/DOUiuHJvVY0YJmkrJCofCcP2S?=
 =?us-ascii?Q?UXmQkhhfd3i0DSZB2yj8j3We9wlqIxdrNnudTUlE+zVyznZ/EfsdnJznZI/2?=
 =?us-ascii?Q?6FNTfVBWsiVD4XtixJ08pok3FQv+6/2ArEFJyq2ksRooohz/pJvVh5o45tLp?=
 =?us-ascii?Q?UDy1iwq7pmMU76eAsBf8HemwQonLElyy7/cNRllIvthx0nVUZI3nKqbUYTv1?=
 =?us-ascii?Q?w9DlbS0giuHScDt+wRC9Aav/Wu3Q/0pp/0wJ8X9PsLi5L5FZyKd/pliFiUQI?=
 =?us-ascii?Q?sOGIlrS2IXFlsGoog04qsahwWB7bqbCoL3pCnAsa07tda8j+MqK48EYr4kru?=
 =?us-ascii?Q?NToCtPDhVvpGFdHewbBnx/ln8cYPGOzqjiy/UBBX4Gsu/9NKLRJpbpO8k0GE?=
 =?us-ascii?Q?dBZGBXptD6AEw7iN+RKZpclGBdhzg1yXbO8Jna9mrn+JgYM2fxTBWnsCc50S?=
 =?us-ascii?Q?g0jOQtifn/Gq+8CLM8bgY/QDLYsL9FMCN90JKLwKRdkGyCp2MErY7exuynde?=
 =?us-ascii?Q?jzcSuOeMqdwoJmdUg3u27j6EpaRLgxQqtjZ/G4piSbuPFR7wu/205fj0B64w?=
 =?us-ascii?Q?KfGIYIEKK/U1Emjm2BOE8OH5e28deK7iMT13is+oQX+Sufze0qX8AO1gvNdK?=
 =?us-ascii?Q?QQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DAD3A3CF86830843B49A51C953D84012@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nV0S7C1//f1TV1DCwqt8HZPmOY1+53BV9E31DTZ8EvppnO8yHfqkWvGdElXa+D9KLnUT24daPcVTz5HTV02ay93UrSNjHG9H5zca7IMZRleml+DYapsib5ydTWT2eZIsaOmI+ilEhXZ5b5QpuiVhrODX3IIx1YLrSpKM9HE6pPCjU/c9Ma3nobjgLQUObOuBB8J20zHaIEDiHRdWOkbNwYWSM71NnXrV/cJFE7xe7j87VIjwIYHgx7Ub9Mdox48lwo+zBec0QpvZqik3OgSrKPL4NqTn4iOF1uGodq2DovCQeokACgFAaVKvjgLMI2Uqgzkuln1NM8rYVWL3Rym0oyw/8dDVk09uEJXJeJj13UJMAQCq+O4Y4ll1WGN6ozjDjmM65Agvu0AIb0Xp5WdFZEyp1en86AvZpB6lrTjRTKgCV017ChWn1vCKhYO7knZapWxCjT3mVQdPUqZ6STrJvfZNWsXIAw9cA0QxpbEruKJRSJXaUKYuK8K3e3xFzE2h5qRTGRvF5ll7Vy8Z/ZUpSBIgRaPG01Sv8VSksOsS+2350Wl/a24+0s9BKtqhlUS3ZeX9SDfMefEep7fwZvX9TnXZ8vO4xC3oGLFMHVSryejya+Vck3UjdGoOAmbAZVyd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d27d05-bfbc-4253-bcee-08dd047a995a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 07:04:36.1819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lwlvkjpB3OXyqbHs5e3gZ6DiHemqLxHLfkEeybwHvPv1WQj50bCYkQED6hzUoYFaSwd+M7qeNJWQ0yYTc9sYow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6516

On Mon, Nov 11, 2024 at 09:04:39AM GMT, Johannes Thumshirn wrote:
> On 11.11.24 08:49, Naohiro Aota wrote:
> > +
> > +/*
> > + * Reset the zones of unused block groups to free up @space_info->byte=
s_zone_unusable.
> > + *
> > + * @space_info:	the space to work on
> > + * @num_bytes:	targeting reclaim bytes
> > + */
>=20
> Maybe add a comment what's the difference between this and=20
> btrfs_delete_unused_bgs()?

OK. This function allow reusing the block group space without removing
them. So, it is like freeing region on the non-zoned mode. It is faster
that btrfs_delete_unused_bgs() which just remove a block group and need
re-allocation if we want to reuse the zone region.

>=20
> > +int btrfs_reset_unused_block_groups(struct btrfs_space_info *space_inf=
o, u64 num_bytes)
>=20
> Maybe call it btrfs_space_info_reset_unused_zones()?

Hmm, currently, we only call this function from the space_info reclaim
context. But, like btrfs_run_delayed_refs() or
btrfs_commit_current_transaction(), we may be able to use this function
from other other contexts (e.g., extent allocation may want this?). So, I'm
not sure sticking with "space_info" is a good option.

>=20
> > +{
> > +	struct btrfs_fs_info *fs_info =3D space_info->fs_info;
> > +
> > +	if (!btrfs_is_zoned(fs_info))
> > +		return 0;
> > +
> > +	while (num_bytes > 0) {
> > +		struct btrfs_chunk_map *map;
> > +		struct btrfs_block_group *bg =3D NULL;
> > +		bool found =3D false;
> > +		u64 reclaimed =3D 0;
> > +
> > +		/*
> > +		 * Here, we choose a fully zone_unusable block group. It's
> > +		 * technically possible to reset a partly zone_unusable block
> > +		 * group, which still has some free space left. However,
> > +		 * handling that needs to cope with the allocation side, which
> > +		 * makes the logic more complex. So, let's handle the easy case
> > +		 * for now.
> > +		 */
> > +		scoped_guard(spinlock, &fs_info->unused_bgs_lock) {
>=20
> Again, not a fan of the scoped_guard() macro...
>=20
> > +			list_for_each_entry(bg, &fs_info->unused_bgs, bg_list) {
> > +				if ((bg->flags & BTRFS_BLOCK_GROUP_TYPE_MASK) !=3D space_info->fla=
gs)
> > +					continue;
> > +
> > +				if (!spin_trylock(&bg->lock))
> > +					continue;
>=20
> especially as normal spin_lock() calls are mixed in.

Yeah, this is nasty... there is scoped_cond_guard() variant which can use
spin_trylock. But, since it uses "for (...)" internally, using it will
break "continue" below. So, I avoided using that here.

>=20
> > +				if (btrfs_is_block_group_used(bg) ||
> > +				    bg->zone_unusable < bg->length) {
> > +					spin_unlock(&bg->lock);
> > +					continue;
> > +				}
> > +				spin_unlock(&bg->lock);
> > +				found =3D true;
> > +				break;
> > +			}
> > +			if (!found)
> > +				return 0;
> > +
> > +			list_del_init(&bg->bg_list);
> > +			btrfs_put_block_group(bg);
> > +		}
> > +
> > +		/*
> > +		 * Since the block group is fully zone_unusable and we cannot
> > +		 * allocate anymore from this block group, we don't need to set
> > +		 * this block group read-only.
> > +		 */
> > +
> > +		scoped_guard(rwsem_read, &fs_info->dev_replace.rwsem) {
> > +			const sector_t zone_size_sectors =3D fs_info->zone_size >> SECTOR_S=
HIFT;
> > +
> > +			map =3D bg->physical_map;
> > +			for (int i =3D 0; i < map->num_stripes; i++) {
> > +				struct btrfs_io_stripe *stripe =3D &map->stripes[i];
> > +				unsigned int nofs_flags;
> > +				int ret;
> > +
> > +				nofs_flags =3D memalloc_nofs_save();
> > +				ret =3D blkdev_zone_mgmt(stripe->dev->bdev, REQ_OP_ZONE_RESET,
> > +						       stripe->physical >> SECTOR_SHIFT,
> > +						       zone_size_sectors);
> > +				memalloc_nofs_restore(nofs_flags);
> > +
> > +				if (ret)
> > +					return ret;
> > +			}
> > +		}
> > +
> > +		scoped_guard(spinlock, &space_info->lock) {
> > +			scoped_guard(spinlock, &bg->lock) {
> > +				ASSERT(!btrfs_is_block_group_used(bg));
> > +				if (bg->ro)
> > +					continue;
> > +
> > +				reclaimed =3D bg->alloc_offset;
> > +				bg->zone_unusable =3D bg->length - bg->zone_capacity;
> > +				bg->alloc_offset =3D 0;
> > +				/*
> > +				 * This holds because we currently reset fully
> > +				 * used then freed BG.
> > +				 */
> > +				ASSERT(reclaimed =3D=3D bg->zone_capacity);
> > +				bg->free_space_ctl->free_space +=3D reclaimed;
> > +				space_info->bytes_zone_unusable -=3D reclaimed;
>=20
> 		btrfs_space_info_update_bytes_zone_unusable(space_info,
> 							    -reclaimed);
>=20
> Which perfectly fits once we get rid of the two scoped_guard() macros.
>=20
> > +			}
> > +			btrfs_return_free_space(space_info, reclaimed);
> > +		}
> > +
> > +		if (num_bytes <=3D reclaimed)
> > +			break;
> > +		num_bytes -=3D reclaimed;
> > +	}
> > +
> > +	return 0;
> > +}
> =

