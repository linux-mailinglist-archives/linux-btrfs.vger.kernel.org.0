Return-Path: <linux-btrfs+bounces-10522-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9B09F5D40
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 04:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449ED1883B4A
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 03:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7872813AD3F;
	Wed, 18 Dec 2024 03:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dV61VwO4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YAKCYe0r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9638D35956
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 03:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734491307; cv=fail; b=Q0B7GNMMkxyFmG6/yuKSGbXYVWOt465g5Y961U2gWPOwkjXBd//G17Rq7ehtB26ag2gu/V8WbH8SiyYlXLurw9pteTHCv9HyFIY37XLsvgbh0hWmdj7XnEirWF3MWG2tuVIKV83oU8QNaLAQp3NY/HF9mv8WTZ0p4ACnXIpumdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734491307; c=relaxed/simple;
	bh=AMaJCKlshSgMZ/i3FwQz5PKm5jC6x1nieShuw1XaiyU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T5ZKSd9DgUD83xJ1kDPDWeupX+Do8I87ivcL2F3THXZq3UVhxh+0IhxVQD6QJva2ASj6cmgukCWD11nBqUUMkvC8xRfMWW478tO+ieKBlUxNRW/qD37N7etI/X2cQOxXC2OuJEgXnYlMYSpg4HngEEMvIbYPrerVvC84Foi+2Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dV61VwO4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=YAKCYe0r; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734491305; x=1766027305;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AMaJCKlshSgMZ/i3FwQz5PKm5jC6x1nieShuw1XaiyU=;
  b=dV61VwO4ansZ3mzSq8UvhzNzHJg1M15UTEocLrsd81Tlz6upuaP3wWh3
   aZt5QwnWGgZvrCUTf6xFg+AwAFcPv3sr3P45J+NHFDrTJ1nRzZb/CzQYc
   RAff3zY6Fty8UyO1y0Y9lJccpVoJ0UF0PeUhR8xxNoQNGLefKd2NIkUG2
   TstB/xCTaYh0GYhnjciWvqQ0SUXfQUI4BcqIDCszq13B/yz3b6rAq6Zg7
   lqVoLfopSCZxLn6scLHiqNQQ3Nk5n8YpVyHP8WdgKFR2rjgRAyv6ErRVC
   oXBx6rQNlDTrVXpjWtFacPyLhfyHBoiLF7E1watzUsbo/+nOowiQBrZI7
   Q==;
X-CSE-ConnectionGUID: HE6NDzuvQDKbl4X/5d3U+A==
X-CSE-MsgGUID: i5aVyhQhTEu1BV3FS4B4nA==
X-IronPort-AV: E=Sophos;i="6.12,243,1728921600"; 
   d="scan'208";a="35149564"
Received: from mail-mw2nam10lp2044.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.44])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2024 11:08:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KR51XuNq+aQYd+JPzpPm3zeDW0YPjOnlCNajMX5aIlIa061aOzMfhsuClMsLZh+9xgrwR0fa3OMBd2CY3+YJ2ee6s/XshzjgDRe5LPU8Pq6RUbyHpU6hH+7CH4lYoWRVaTRVg8tdC45FMQoxfkwfZA2CkNJhZjHfgrBBE2SSJdUlvpA+CeBWowXjW/X4jFpnOSXhyQNA9dG01/foK5PCTfLGR5epvz/SFtW4QwtZyW4YebckAEYFETj1txKt0Z7tBKmZFumwTV5edWfyUyj/rFfPmvVAI/Iq78Tug6f5dlQ5ov+W27K+2IZdfdHYguGgb3KrdkBt74eclzDAK3LcSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMaJCKlshSgMZ/i3FwQz5PKm5jC6x1nieShuw1XaiyU=;
 b=Zsw/Dt1RyM2VFlwzYbmevCNVkNl01Z3o14CBK2HUugA15WLIy7puvgOiuIGBLEvhH/6yTPAP/uUgkiZdSIugvMIf3CTZTvNXr9xK1HSjC0IHrcLmd0yis++gpm0+VveewwoS5VrQl22hXNr94FSnjyZ6lYwwR6gpqNzx8eQ3eYQ2V7SCCHlsylISObUOwLx4Q9uKRXLljIonbQ+KzLfwN1Clhrzs8LmQRnwmPy0JJBlKpYn9Ta9cL7Pwd1QvzKGBqPI5L7Kiu/k5iuUQdAUEEEPfpC39hIfW6sWkXYJDXJlGCc8bDwPMeiRXxqYIwY3yjCOYdyLGnOHJkrK/IRuYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMaJCKlshSgMZ/i3FwQz5PKm5jC6x1nieShuw1XaiyU=;
 b=YAKCYe0rDcGc3X1Hl7PIBifPZPS0YcxKF36Ut50Yqnvp5taVpM5PMRxNYrCl7aRKNHusc/jS0bMSTMBBIIE08UsJsPv8E51lAwRhKZX3KpenzRN5x4xWPuV2h+jNKaPtrg7jOeGElzkNQrK3qhFMlBgHWqcs34sVQ9+KKuZ3y1k=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CH2PR04MB6872.namprd04.prod.outlook.com (2603:10b6:610:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 03:08:22 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 03:08:22 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Anand Jain <anand.jain@oracle.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"dsterba@suse.com" <dsterba@suse.com>, WenRuo Qu <wqu@suse.com>,
	"hrx@bupt.moe" <hrx@bupt.moe>, "waxhead@dirtcellar.net"
	<waxhead@dirtcellar.net>
Subject: Re: [PATCH v4 1/9] btrfs: initialize fs_devices->fs_info earlier
Thread-Topic: [PATCH v4 1/9] btrfs: initialize fs_devices->fs_info earlier
Thread-Index: AQHbT+cDuogWO+E9Aku6+8Z2mkI/GbLrVGGA
Date: Wed, 18 Dec 2024 03:08:22 +0000
Message-ID: <tzxtaqktzh5zf5cmcf4ntthyv5hcvt3bifv4jyttxgyy66viia@77mi7jpdajgk>
References: <cover.1734370092.git.anand.jain@oracle.com>
 <767bd0e42792760d77b7e8225111d9c8a6f4039b.1734370092.git.anand.jain@oracle.com>
In-Reply-To:
 <767bd0e42792760d77b7e8225111d9c8a6f4039b.1734370092.git.anand.jain@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CH2PR04MB6872:EE_
x-ms-office365-filtering-correlation-id: a8131ab7-120a-41de-81b2-08dd1f113b42
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fp40EutAOfFJoOTZepblro2yqZiwNzFxIIPr+GJwzqOroiLh7SoBQubPN8zj?=
 =?us-ascii?Q?2OvBT6g1H1/Pznr5LXzT/gLK0+GdGgGr9PnkgIvukguyp0RYm1old9GwULV6?=
 =?us-ascii?Q?TH+1HPZ5yKSGn/xk+eiN5fOsmDPX47zxhuWp/HhOf4smvjSLVr0zpmrHO3UA?=
 =?us-ascii?Q?6fUZ6e4so8cv57FE+9GPfXKkLH/KeIAuyenI7nkHGurhDJvKmKRUjZqBh3Oa?=
 =?us-ascii?Q?HAmn96XPtLVZNicz7RUCq5NhjNFM2EUsRKkzv1e/VODGAz6HwiFA4WWGdtzN?=
 =?us-ascii?Q?hEYscRg2JE7ihvl/srwnwjf2a8Fc2T3+b0U9ySjQfUxuDJTTxbzVZLbkugkn?=
 =?us-ascii?Q?iBQHszKBQXOKHPpGcryDIP0Ru0znar49tex5clRugoAR5lgum7uurquLnaEC?=
 =?us-ascii?Q?DIY1e0j4AO3lN/ppQEA98HzqUmkWC8DnVI/Q/0TT6iy5HNsGJUKqcK8ErVzP?=
 =?us-ascii?Q?nvbv+bp7rgIFVULqmcg9E88pl9QnIno6zN1tWCLyqvgLXoSvfLAtaEBzXsqO?=
 =?us-ascii?Q?rrUz0sqVPYTdIcT649e/HbhajeNRdyX9Mj4UA+RL1FIYCPczS203ZHsWlzVR?=
 =?us-ascii?Q?46BfmC3NpxidEZP2zFjFQkJ0+ehnvbIBCXaAeRbj8zAnZjjxd6vwK0jvRQXW?=
 =?us-ascii?Q?Gtzg2GUzTAzEScIeXnrwMGf0RJwWFkzKgFg96HsmnV1Nut/iA66OEsA5nV2v?=
 =?us-ascii?Q?lZLbJHxtB2sTXVOOWxOzaUV5HdlMNPEX6CBxCMQY78tubiidFkWaq9uN1Y0L?=
 =?us-ascii?Q?y/tkQCUSIN1Wy29GwGIj7UrWIAFo6jXHdhY1aY3OHBz2l3NYZ805QwltCnoV?=
 =?us-ascii?Q?jrAmjHBK/BHeqZ/Un1EfZc+qXjPcYukc7h7xkE76bieEvBdBPras+x1P7cP9?=
 =?us-ascii?Q?BPZYqDcoNKzHO7yoI9qC4vf951TM+5kzBFLcPAvY9ol/TCSNnqRw/lnjEKxr?=
 =?us-ascii?Q?AqytddaSZHaHZ9joBD1KthTtuHF2hTc1K+MzNkrSPNxL46giWUhPbThA6jjk?=
 =?us-ascii?Q?ixa+ANI+aSSeLpFwLj9ZOTf40iu2m84cqfQXekJtJQXrRf5OuZTEPFwfDvjJ?=
 =?us-ascii?Q?9R7KAgMISxPX82IAIdeICpUbNRDHkk0p8/JLsq5vdeBEP987rfSqQNwCti+p?=
 =?us-ascii?Q?a5y8Nh73PtA9YGWvO4ZRLX6xYM7QthIvUVvNdE4/ehahm6gyguI+bpYHlv+5?=
 =?us-ascii?Q?bM7pEIcRbLDMmq6uKt5O+MpAIh63gcRMWe7tk5mzU9+aB4SBcPDsjy9eJtlx?=
 =?us-ascii?Q?5oecTCwBLoytXwkobvbeSykdWuOBS3Qus2Hd6p/HGPonyf44ZxtXFgjruCSw?=
 =?us-ascii?Q?RD6J9Tsd1emrXK0GBjnws0o52MvCKEnrhgYmgLW2cjPjJJJsc/qiHCsjCmrq?=
 =?us-ascii?Q?YfOLT+VoJ5mtg1T/2mril1P6cHLlA58T0zYpg8hCbPfYeoFGqlq4FJ4+KCw1?=
 =?us-ascii?Q?Vda2OzyDghQ5/cgZV4Rawy66AF5rmn3/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?z+SCRAziIVZFZOz0UGJwCAhbZ9iZeTnhvmkCCxbBi2LGJkDcZF8UdudXfjUl?=
 =?us-ascii?Q?wmUnwFJO4zbE5mg6j/mAmhcs6DA1yUvoRSl0ZDhH9rqojS2E9tbG423EdMUR?=
 =?us-ascii?Q?S7u49W1U7IbJ2+fIXzhYdkX4j8f4WGt6HXBPHmCGLKSiC7sVVdoZ0TjrsiaN?=
 =?us-ascii?Q?xuooxHf2uPjfZ7rva+0ULdkYXypwBD3NUsegoi5Hwui9/hdrJNhE7Q+AKW1Z?=
 =?us-ascii?Q?kZ/cdL1ij8Mk6bQpWuBEwZW/G4F+cytFq6WDsNbp0sdYb0pBt8+VhuJXhOWM?=
 =?us-ascii?Q?b9r+R+HAx75E4XCukrOdtrJrfteBhENmgnOHpJJ0Dvj+TZPOZcGmtryK1Qgb?=
 =?us-ascii?Q?AgXoFNyp+HQwyzqJ9JtdACHzZy2EGr9YSiZeMvsSLPPSldbFXDkH7uAJCYAQ?=
 =?us-ascii?Q?esDFbtVew0VnMXKSZYDsjRq1FyPvwx/LiOnSXCgE+n98dgXT8bKdWFA1wyrM?=
 =?us-ascii?Q?n8GfhoPVmbJzVfjMXi5ElTlIv2qIAlm8qE/qktEMt5Rv4Bs82iUn8s0+kQSS?=
 =?us-ascii?Q?XzvVPGixJTLFm0f0JKC8M/W5JVaClWb5roYXlGd4/43h33QohQK4KRLwsjd2?=
 =?us-ascii?Q?0K+IGbzngmTsv/jQ0HcapdSOkD+JHI20Nybb1owNJeUytuy+pPKvm3rnmOeu?=
 =?us-ascii?Q?CemXYOLL0DhhyPhScDmtpIg+8Xbav7fm/JcQLAbD/SqOABuiH67jXYYxuAyd?=
 =?us-ascii?Q?8X7mCj0yvFOausUeOOHTWsdantNMzHQcWSXOcVA2/9AFbU9u+o1YV2XvDxNQ?=
 =?us-ascii?Q?jkKNbEEfCQWRej24SV6NEhy29XQooYkvggORfYeK+badEcQKUYeyAwy3JbZm?=
 =?us-ascii?Q?Sku+52tgWc0K9vcj/tYmSd9uzx7eCrVc2NnecP46wXJik8Q5VcrEKrAVm7tO?=
 =?us-ascii?Q?ydSgWhJK06qq87ZTpzlyzzhJoB5mWlvBZNfilR6oHIRDNQ6C8nzeSlXyRTF6?=
 =?us-ascii?Q?BUIYf+6gTl0muNc68itjS3O8ylHce9bzqreg2SWS4co8zUUiwRsGiPSFO8Z4?=
 =?us-ascii?Q?dcK0wVZpYeEeTZwVlyy+VqKSrOGG1Tgl53i4EtM2i11VnxFs2DS5REqzOq+F?=
 =?us-ascii?Q?p1GgVf1Xmfmh8goqvIfGpF6spEPmkNGjZL832tHJAZhSBR+dYLjkSrw9RFdH?=
 =?us-ascii?Q?Qy+QCaybv1kzJFh8HUILh/FY0ClttmF+7rXkPNPnAJkmEnjmwQLSQ/KDWENr?=
 =?us-ascii?Q?GIDAIokrYfLnIM86BBVI8cw0pI+PIa44Exw3VA21hGfm3JmTBCmvZw8LW0nD?=
 =?us-ascii?Q?hGlDx3Xepd/4vl5zmtvk6LJOaN6GXTQFqJN/lp6vA/bLwOaEsnyJxnKd+uPQ?=
 =?us-ascii?Q?bLN5wsYVlShcgr/BVrTSHWSyyP45GsXh5n69odFcqe3hVxdBHfY399MgwnND?=
 =?us-ascii?Q?2rNPDbjRFMcEjvEB/X442cc7BRGf+f+kcdgG7OtpycGjA1HIGCznma/kiJzU?=
 =?us-ascii?Q?zTH0QUTNylVKGF6MD7pSxFhIARMPonE+mGcEa6vuCwFLlMmLGMORi8jdPn5x?=
 =?us-ascii?Q?JgFmUQU+TOO+jpNDDq7cHCc0jBhFo+BeuLRexbXDWmYnNBPxjtJ7C1F9sxhi?=
 =?us-ascii?Q?3XW8gltImdaFm6Olj1aE11y9mxto3cL4hglMVd/2vP0Gi0oQhW88N4MajgzO?=
 =?us-ascii?Q?cA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4FD2DA88D196A04CA604BE9E6E90A6BA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mUw3MziGadmKrTLMGN2MS0laVShInbbAwl0fU8rfzUWom21DjxKv/uPvl/Ei1Vb41KYwhPp8oivYExF7B1cyabAp93QF3elu9F6pFW1F/iJb8eN1D6/aM8k+i7VVoIpok3nICapSpo4+iYnoY+crdFIOw2Lp6Dc4inBZJiPXuy4YFOtmAyZCKJmnLoV/XXVLHesQjwDGtCKli9WIwrrAaNGkCt41wYsnkAJvGph5GGRuFm/mcGmnSB1b016UKzKo+946gTjGy9eS/UYYvP0bhhaJ8gEbEcFrOg+kFNrVgmlpq6HGmcwSW1JE7ivyRKkKSn7qIlEa3jC7O2kJ85MEmj5muCUEMoOIH/YHRy6S5+eKR0V913ls5Go4j4Ku7hWAJRRdw9KhA3OnJlsfnE3CqfcomA0X5Bcrz3NHq2a6/bKVNYsOuMaxP1HDseIhSA/HjCVU017Q8Z9zTB5NoO7hlyXNiA6tDLaFT21Zt9Aj73IYqWejIIpXrPosAGUawryrQWEeUsLuz/z848Vngz8WG/jpzkze5lJTHVX3UnM4SHEsaRXmeF3RiBMcrP3vcZi/9yaUcLXtafmTBmpnJ/PGtj+Lq8/cwznQstsySbu8e5wuCpccxNRoROa/4qWO18MZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8131ab7-120a-41de-81b2-08dd1f113b42
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 03:08:22.5004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PaRAWwBjE1zFNOO4YLmsVLBBDHEU0awkhR/nzl9RG8j3fa0Lau5GKnxzrIXLrWt3NgWbpjyvo577uOZA/vd8QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6872

On Tue, Dec 17, 2024 at 02:13:09AM +0800, Anand Jain wrote:
> Currently, fs_devices->fs_info is initialized in btrfs_init_devices_late(=
),
> but this occurs too late for find_live_mirror(), which is invoked by
> load_super_root() much earlier than btrfs_init_devices_late().
>=20
> Fix this by moving the initialization to open_ctree(), before load_super_=
root().
>=20
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Looks good to me.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=

