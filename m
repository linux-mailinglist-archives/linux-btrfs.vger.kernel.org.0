Return-Path: <linux-btrfs+bounces-20505-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 836ECD1EFF5
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 14:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7EDF3032107
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 13:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEB539A7E9;
	Wed, 14 Jan 2026 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NqxE3tWA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="B1vQgGBr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D95399A63;
	Wed, 14 Jan 2026 13:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768396173; cv=fail; b=EsMJeozv/+/m7OFRTTa6ySxj8J+J44WQarTfrlWJrFsWggRqqRl6lVH1m/kuOJEY8uwiqPAqIKlCsKqNN8MdPQk9KjeaFTLHW0m1vZ6eo7HVAKGLSO3i7F2XiopOu8HfWNGZFiHwq6AczDz1vqsAZbGN/Pzy7GSTAikQqMfIrqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768396173; c=relaxed/simple;
	bh=JTJf5RBWUKQ+t1tYZiJYlOxLD4lvTD3wPDmfe6lD+oE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=onHxNOt7MzJZKrLeMhOGiYWtEkUCTdzge36U32ix3cps5MXMQ+otsiPRRu5tn1XUTofN2CW0CwMUizmOJPSqj+uSFSxZ6o2pAO+NOCtNR2d2kFT9uIdB20CIlg7Pmc0pa5SXhFsx0QEu2ycXoIJ8v8NaRrcee3VTrWZZfcttyu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NqxE3tWA; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=B1vQgGBr; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768396171; x=1799932171;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JTJf5RBWUKQ+t1tYZiJYlOxLD4lvTD3wPDmfe6lD+oE=;
  b=NqxE3tWADbSdBbYFx4mCgcJEBQG5cfy7CqP6LM+Bth3TilinCAkjB7Hm
   2m5e6r1kxNLtU92RNEzGCRh1h+qH53gPOt7IqffP4jXZlXuJPxsQwpmfy
   Dd7BFj2AJLLLo0djUAB2/Kq9bNg/3AVxV78VT3W1E4BOyTaPksV6ZqMb4
   QHhKWWdOXgWGBkGHHUWPH7DADmGqrVKoX3YFZSUeCfngFbQycn4Pdegvy
   iQRu3MvFu3EELxYXnaRoYz+MjZl8fbe09JEDMPW5HrFDYNcYUmQxN1pDy
   mrswIFMB6HNQGFLQLw2PfHfwneJ9368DihMi74CKJbek380R481p0yGFF
   g==;
X-CSE-ConnectionGUID: K9d2FptOTOykkpY82Lc/9A==
X-CSE-MsgGUID: KobARCumThCpWV1OdlQrWA==
X-IronPort-AV: E=Sophos;i="6.21,225,1763395200"; 
   d="scan'208";a="138059757"
Received: from mail-eastusazon11011021.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.21])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jan 2026 21:09:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HURUbIJP0txOZdHBGQuKhvFSAu3lPpv/7RCtwoIpBqXwM3+KY/la7YY4K2Or8a5hDyQ79Npb3VvEuWQNHiaZlv2ZsAv4ckPvSzOhlULg4/+aioSnMlYsZKw7Epx5cSXFTDOTd5lqwLnkL9+Jxdg7zA/HCnw0sFAhzh8TWxCQKiaKzPt3ORa0TarZMNqofypIOvU2TqzSWXQ1y9aZFIE7XPf9biS263af26nid2egnpCUP+5AyPSUvXloLCUB9tzPg8m4wi4G7Tf48TcZK/jWbYqiEx3+4p0KaXUJslj2h+xFIjmCVUF6YuPM+YOZszO/fEkjYp3VacmbKsgfYOpOlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTJf5RBWUKQ+t1tYZiJYlOxLD4lvTD3wPDmfe6lD+oE=;
 b=KlZuy7dVNeCzGOG4wKbY+v48McCJSwNd6VkU9taOkdyNc9fW/SNI+jyO2RIBucJvWt8Me4N+dwj013NnsVCKtr7OmdpbZ5+13rqbEEV63O0fpN+Hu9ruJ7AQMIQC5Qj15YU0e8K3e4/yS6YQu/rGe2+FFdejQwpZxFRHdZ4IoY1zNhauYkZI5JjUgCFzoew+275JGL9MnmF4UDrUo4d/0VNtV6Y1BSeSq8WzAlMS6yJuNiFVOMe6MfmLU73DqsWyzEvSAG+Ka0MzvoYCser33v8y51KOqWgqHizep5PaLc6uf0k0sW9a8w1ezg5lmXevMGFqQy0Ov684h1AIb5YV0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTJf5RBWUKQ+t1tYZiJYlOxLD4lvTD3wPDmfe6lD+oE=;
 b=B1vQgGBrUcO1HoxQoOv7DyCoCt21hPXzi30nXVMEn6t2VHxiXgldE36ECkR66zs/FaGZD9VHOswy36SiI4K2n5kaU/7PBdEqjd/uMcMcdfslY8cw1b2igeS4vmt5OIbe+qeKTpzp4ORMc0dfpOTEEQBSZd0qA+Y0lx0DMxN3u2s=
Received: from DS0PR04MB9844.namprd04.prod.outlook.com (2603:10b6:8:2f8::22)
 by SJ0PR04MB8247.namprd04.prod.outlook.com (2603:10b6:a03:3fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 13:09:27 +0000
Received: from DS0PR04MB9844.namprd04.prod.outlook.com
 ([fe80::9647:6abf:8734:547a]) by DS0PR04MB9844.namprd04.prod.outlook.com
 ([fe80::9647:6abf:8734:547a%5]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 13:09:27 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>, "boris@bur.io"
	<boris@bur.io>
CC: "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: zoned: remove redundant space_info lock and
 variable in do_allocation_zoned
Thread-Topic: [PATCH v2] btrfs: zoned: remove redundant space_info lock and
 variable in do_allocation_zoned
Thread-Index: AQHchAE7u5Jo9ljG9UeXcwnXtnKl7rVRpcWA
Date: Wed, 14 Jan 2026 13:09:27 +0000
Message-ID: <DFOC3S5F0LN3.158CDRO798GJ8@wdc.com>
References: <20260112185637.GB450687@zen.localdomain>
 <20260112202227.37626-1-jiashengjiangcool@gmail.com>
In-Reply-To: <20260112202227.37626-1-jiashengjiangcool@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.21.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR04MB9844:EE_|SJ0PR04MB8247:EE_
x-ms-office365-filtering-correlation-id: 543aa2d3-371e-4939-6a50-08de536e2590
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q3NhNU83KzVFM0FGOUY0UkRrZHF6UVVoT2FjVUNIaEI1dzl1aXF6eVNLbE14?=
 =?utf-8?B?cGNZbjJBVndMZlV2R29CSVJCUlZFMWdQT21WNlYvdjRqbTNzL0xnTUxlc1hG?=
 =?utf-8?B?ZERJOTNGZVJPRno1TDlGVE9MUC9Ka2FTdVMxVnhFSXZkcjZRaGpKd0FFYmxK?=
 =?utf-8?B?N2UwNXFUMzZDVXp0bVUwdXBjbUl0VHFWSVBDVTArbjVYdEdvSlRDUUNaOUtu?=
 =?utf-8?B?UWdMR3I1QnlXZlJKSklnY084VG12MGh6aEpNelJLZ1hqZ2VGNEZ3c0dvUzJP?=
 =?utf-8?B?TXZwamlpNlRKZU9TZ3ErOElhKzFCN3FiL1h1dHJxWlNEYjdFU3B5dXhlN3Jm?=
 =?utf-8?B?aHBKT3pONUxTRE14a0lMVXY1YUEveUlYSm5UbzAvK21pR0ZlelNPRmxxMWsz?=
 =?utf-8?B?bnpxSlZPdENMYVlVeUJSbFJlWFJBcFlFRUFCdHFSZVpGb0ZmakNPMzJkZkh3?=
 =?utf-8?B?amU5SUVYVlpPb2RacGtKTU92THIvMXNrYjVKY2xsWWdiU1M5WVJqbFVFbm5w?=
 =?utf-8?B?TElReUcyZGJhRGVsdXRwOVlxQWs1VzREdkhmaHd3b2lzd040NzJ5OVVIWmZX?=
 =?utf-8?B?V0oyU3R0bkMwcWszOEUrU1poY1BtdEtiRnFaczR5ZEFHUmhLNENHcG5hTlU2?=
 =?utf-8?B?RXdIL0E2Y0dmdnFZRkJGZUR6OGIrQjlsZVpabytVOWJQLzhHdmlSZlZBTFgr?=
 =?utf-8?B?R0EvTC9Dc01ZQUxhV3lRUEpieWlyRjRqRUQ3T0czSmJNa2p4NVhLZ1AvU0tF?=
 =?utf-8?B?ZTZRRWtpL1pBZ0ZSaFIrQ1V4VmZLSFZoai9LQzFtWEtMb3JaNVI0UVBDV2Zn?=
 =?utf-8?B?NmhFWnpkMGRKbUpLaHIyOHRwY1dpTGpTNFdNczNEd0lTT1dHK0EvWHFYN3hE?=
 =?utf-8?B?aTR3SllkNjgzMzhiWTkwa0FyRTFaT0x5a0JPTnFQTzlCSThvUVh4anRxbDNW?=
 =?utf-8?B?bmE3OS9zcFlmQ2FHN2xpNzZzTzFYL0Zzc0tyUUZVcGcrbU1MZjdoRmx0clVX?=
 =?utf-8?B?dWp6SE04UldIa24rZXk5MWZZT082OElCdEI1dWRUZ0w5ZWJIck03VGdhdUxR?=
 =?utf-8?B?RzE0aFFJOG1TYXJsdi9KL3NMakRNZFZUa1hZU09QK2NGQ2MyYmxVTm1leVFZ?=
 =?utf-8?B?enV6NkRxM1daeWU0VElqUnpmM0VmWnhzOGZLRlV5c3Frb2RqaWdQTHh5N1lO?=
 =?utf-8?B?TnhGYjhIZVk3Z253OTU3ZUtsTDRaZUx5ejNqR21yS1ZCK0RiSlZNWW00UmhZ?=
 =?utf-8?B?SnBrY0NaUER3WnlOU2UvenB0RitXeHZKbFVvTUUyeHlZTnIwRmJXaWxGRTlw?=
 =?utf-8?B?bUNyOTR6THZDdHR6WW1qZTZtV29aTFkzMXl4VWdXUGszVmxVWkoxenl1WE9R?=
 =?utf-8?B?U0pLSHU5ZDVaeUF6ZlZZYmdHRW9icXNsTEFCMENKaFpsY1ZXSnREWGZRdExN?=
 =?utf-8?B?QVZvQ2lEVUIxUTNodytueXluRnpmMUlld294bjRobU9ZbVBtT2oyMW5UY0NM?=
 =?utf-8?B?RGVLZWVkRVVwSGF4RUFwTDFPUlRQUlF5QnkwZGdRZ1lTMzZLWUFQZmVqNXN1?=
 =?utf-8?B?aW1xQlN0UEVXVVFQUzhKQzRDekdtdlFMU3JPRTZLalpRcTU4QTRvQXZUMDRq?=
 =?utf-8?B?ZHNyejlBNGNPWUwxd0xHMVgzU29GNVVEZ0xQSElkMXVoc0hyWURWakZGbVBH?=
 =?utf-8?B?ZU1GRzNEd0JTRlpVcGRyR0pzb3BFTmxnQ2pPTkZ4R0trODkveGN5WGVtQzcr?=
 =?utf-8?B?T3FNZ1JZQU5NdUttRXNOay9SZjVOOTFnbHZHeWgvdm15dkpLTmhIMStXUWFK?=
 =?utf-8?B?WWh4eDZVSXI5SjVIZm1vaWVuSTBZaml3SnpNdnFwUllXRjFYNGVxd0Z1dlZr?=
 =?utf-8?B?eksyYU15YVA3QkdZZE5teDg2am9HQzVpRktXbEFaUWhuNlZYa29KRzAwTWky?=
 =?utf-8?B?UU1weDhxNXp4bk5hL2NwcUF1RWNXOWR2M2xLbkRwTzUwK3VZcnhUeFhmNG1T?=
 =?utf-8?B?SXExNlZBQWRHZlZRR2g0Mlh1SmoxRG9mL0VQOUw0bG0wSTRpRWIxM29ReHR0?=
 =?utf-8?B?RDh4SUpkSHJEYTlhK3p0dFpwRjRzYytIRS9QNHhLYnNRKzcyemVqb1hYbyt1?=
 =?utf-8?B?aDlNN2pudG12ZTdVOVg2ckp3aXNGQUNxakJZd2daZytDaEFqNzVrMldNUzB6?=
 =?utf-8?Q?C6UfOM5qgmEEyyP73uq2m1Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR04MB9844.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QnM1dWR3bnFtd1NVelBXYm9UU0tkcGlreVhCVjNrOEVodkk3T0FOOThKL1Zo?=
 =?utf-8?B?RUxNdjR3VWJ6dmphSDdNemlBZ2NLUHhWOVFrSmRja2RFMHJCQWFHeWVBV2s4?=
 =?utf-8?B?WGxRMkhSVzdpaEs4Rjc0NCs2UWdtSVRuMGhMQ1g0ZkFwLzgvRTdwbmVyaklx?=
 =?utf-8?B?SVdBTy96S1o3cGgzWW8vNzQ1MUw3OW1FR1hMZmUyTU5kb3BIM09MTTdxUDkz?=
 =?utf-8?B?WnJxVk5aYm0vWXVwUkpQRTZaV3ZpaXplQnRjNUg4bExVU1pOa3RVK3ZqNjcz?=
 =?utf-8?B?eTZzRytoYmsybFV5RXRkaExLVlp6ZFpaSUxhMDlXRkNzY0NlLzhtbVpMd215?=
 =?utf-8?B?dXVuOWVsOTdTamZBU1pEaTZkSnF3aWVaUkR3Ny96ZDN2cThraUJ6ZndJSzV4?=
 =?utf-8?B?T1JNNVZWZ0F2amVsQWErZGtOV1hLaU9PSFhQY2VlUDRQOWNHTk5WZ1JCb1Yw?=
 =?utf-8?B?ek51aHVTOWpidkFhbHlYZFZCcmZQUTZGdEkzNjRjUGVkNnBjMDJRM0ZqUkZm?=
 =?utf-8?B?blZhdzZHM29sT3BiZkdUZ25ycXY2MnROaFZTcjVIczZsQjV4bkIrY1JyQ1hQ?=
 =?utf-8?B?Zm1oOE9xczZ2WnJybWQ2WnNjaXhYV3ZOZDZCU0w2djRUbzBkcVNBb1ZyeFND?=
 =?utf-8?B?VGRyNUc4czIwT1MzVGNickExcDd5ellUajlZS2NFSDlvM0FrRGx0WFhNbTZQ?=
 =?utf-8?B?YTVGNDg5Rno0ZHIwbTZ0ZURtZVlDTEpGSnRkMTYzdFFEZFNIMGFYOVhwS3N0?=
 =?utf-8?B?MVlRMHNBSkJCbFkvTHhsNmd0d0FmNnJROGoxNjA2OERpbGQ4d0VxaGF2WWww?=
 =?utf-8?B?QksrdjZycXhSakNjZENTbHVXZi9aNjFsb0NmcDgzNzNmYzh5Y2tzeWFjSXQv?=
 =?utf-8?B?RFQwS3ZMLzI4RWoyVU5HbUE2REhkMWVpbXNncitzRTRMWEJxbTVuUjAyUmlV?=
 =?utf-8?B?ZmQzck5aQm15Y0JHWHRvZXRRNVlyTHhCdE56bkM2NFdLVmQ3clBWOWRBSDQz?=
 =?utf-8?B?bzQvZkNKVjhXMnN1OWdnYkpMd24yekZVK01yOXhKSm5XYWFCKzFrL3kxanRx?=
 =?utf-8?B?WkR4cXMvRUdONS9qakR6NnMzek5JVkRBa0xRSDM0UTdwOXhLTm4zMkZkYkF5?=
 =?utf-8?B?SC9QczNkUW84Z0ZYRGE4ZnluWGtSUnptNFVlOFNKTExhelZ0SVFnR2s0MHFI?=
 =?utf-8?B?bXFWWXZQYzlnRVR1Tkk5eWc0ZkkyRDYvTmZZSGVhOW5BK2Q4WUYyN29kT3hX?=
 =?utf-8?B?TEdZMkNjRE9pT3dTL2VqWFptRVRUa0ExVmp6eGVua29sdTh1T0laWXdGeG5V?=
 =?utf-8?B?WFdNendKaktPUmt4emJ3alVtanFPUTV0N2tqUkNhRjYzMHduSndiN1pEZDIy?=
 =?utf-8?B?R2ZKZHNtZlVHZllNRHFWT2F4VVdmdys0UTVwSVRScGFaelNzVDYrZ3ViZHZS?=
 =?utf-8?B?L3Bnc0RqRVIrZFpKZHlkYmNXUG9CREtIZlphbGM2Mm1BcVZ3TitBRXozRURn?=
 =?utf-8?B?OFhNVmR3OE0xVnFwTVBOWU9RZzRHMnNBZ1A2U3VOSy93RzFpV2wyQmhoaU13?=
 =?utf-8?B?N2pWbnVxTVlFVDhFQ0FIcVgyS2hQYW1GK3BOaHdxTm5IZ1dMdVNrem56a3Z0?=
 =?utf-8?B?dHhBdis1ekJlaHk1UlhtakMxYnVuMUU2bEpTWTlMK1gzOGEyUUhFVmtOZXRE?=
 =?utf-8?B?VzRQNDEybXJNT01jd21hQ2kwMUVwNzdhQmlVRGhVMmpPUFFZaWo4djhZQkY2?=
 =?utf-8?B?aWVnbnUvZVNrRWlMTE1IaUk2NlZzNkhrNGtyZWszcmF5dVdQSlpsaGs2Sm5D?=
 =?utf-8?B?aFg0QmgxK3RuWGdoYTFiSnVnVHl4Z0tWYVc5U3AzZWRBRU1kcG9CaU1SNldm?=
 =?utf-8?B?eHpQUEtaU0t1UzRMQUVsaWs4YmU5TEkzYk9RKzlqamZVakNXQ2xseVptWGx4?=
 =?utf-8?B?bTZod3BmOVg0YUltTlA1RW0zUUJld2Z1d2RTZDlCTHhhMWkybXJQaWdEM0Zo?=
 =?utf-8?B?ajkrRy9KTC9uamtkejdtd2kvdFlGVHV1dlh0anJ0ek9ycmM5WWZ1UnBhWmpK?=
 =?utf-8?B?RU1YRVMwa0xWelFhV085Q1lUeUQwdnVhZVlJWlBTQzZJVTFzbTZMZUMyYXZ5?=
 =?utf-8?B?bmVwYU1EcU03VnhrMHNZaWhCR29BMFlJNEQzSTYrOE5TbTBFT3RpalhFdUc5?=
 =?utf-8?B?elBQUkozWFJsdllXSENlZHlGejl6cFpGR2xpT0tkd2UrZENTTllDaXJMby9R?=
 =?utf-8?B?MjV2NUdhWlM1eFI2NU9CQnhhWmwxUElRVC9SRG5ZR0xOQ1UvS0xlRXRJUG5Q?=
 =?utf-8?B?Z2x2R01lUjUydTZQalJSMXdONThoMERGd2FpbXBFRDJJemFQTmNGZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C71A65E1A5F0D649B6CB26CD445E8E91@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G63hFaYGhzBh674/jd9mpmcfnlulokKIa96S3lTW+tkOZqX5DRlyzABCqx36i1Q97bHED4m0gTzTaSy7mJGXeIRS3Pua/y7Er1arQTORSYcxDeyxiXB1pNZNQmQFMmLHHveJtq9RbrQ8daxSTNyUnOIMKLA3BUcr23wfFDo6kuOoUT2c3yLyXeTbfO9LqNt3Iv8+maBdLK3OCQZbdNnEJiWd0O5BjhbagWGHhNkL5qBUepgSUCRXlsommcc5Z6uy3kyTaAxO3uSWHZb7u8ft3q7q/ymDlxEX0GsrRryy6Sgo01WUSONGYsUp22R53zi5vU3nZO83Jvo6Yspm4S/IRrdiePklOZOPZJYjhsY7IEOiQ5ylN76O4JNf12EArqOAMAdNNoBJeP6IvzpBWGd9tjSstOjofpz49l72BxQgW3n1T0OifzJELHq5B+ysS5097zw0OTilsh/2Sfago0Bob327NADa1+t433eSBrLKOn0r/wOyVNCbaRMdWzXlMh092FeszJeXfaSDK8Qr/nu/FoIDULVxkY/YOyyrV/zVjmf+yD7OnDIBm1QibodTUKL/roIMcNyG4KL44r3Sx2el8ihQ6Y+V9M0fT/f/i1nMXzBKneUzzBVXpD5RPuwSTe+V
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR04MB9844.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543aa2d3-371e-4939-6a50-08de536e2590
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 13:09:27.3792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C1mV60bdDjsZrb6SXa2gULlwlbx0WK0N5NCU+vtB8U52lyOAw9fEJz8XOci7YOKNihXRJuqUOR0fz8871mSCxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8247

T24gVHVlIEphbiAxMywgMjAyNiBhdCA1OjIyIEFNIEpTVCwgSmlhc2hlbmcgSmlhbmcgd3JvdGU6
DQo+IEluIGRvX2FsbG9jYXRpb25fem9uZWQoKSwgdGhlIGNvZGUgYWNxdWlyZXMgc3BhY2VfaW5m
by0+bG9jayBiZWZvcmUNCj4gYmxvY2tfZ3JvdXAtPmxvY2suIEhvd2V2ZXIsIHRoZSBjcml0aWNh
bCBzZWN0aW9uIGRvZXMgbm90IGFjY2VzcyBvcg0KPiBtb2RpZnkgYW55IG1lbWJlcnMgb2YgdGhl
IHNwYWNlX2luZm8gc3RydWN0dXJlLiBUaHVzLCB0aGUgbG9jayBpcw0KPiByZWR1bmRhbnQgYXMg
aXQgcHJvdmlkZXMgbm8gbmVjZXNzYXJ5IHN5bmNocm9uaXphdGlvbiBoZXJlLg0KPg0KPiBUaGlz
IGNoYW5nZSBzaW1wbGlmaWVzIHRoZSBsb2NraW5nIGxvZ2ljIGFuZCBhbGlnbnMgdGhlIGZ1bmN0
aW9uIHdpdGgNCj4gb3RoZXIgem9uZWQgcGF0aHMsIHN1Y2ggYXMgX19idHJmc19hZGRfZnJlZV9z
cGFjZV96b25lZCgpLCB3aGljaCBvbmx5DQo+IHJlbHkgb24gYmxvY2tfZ3JvdXAtPmxvY2suIFNp
bmNlIHRoZSAnc3BhY2VfaW5mbycgbG9jYWwgdmFyaWFibGUgaXMNCj4gbm8gbG9uZ2VyIHVzZWQg
YWZ0ZXIgcmVtb3ZpbmcgdGhlIGxvY2sgY2FsbHMsIGl0IGlzIGFsc28gcmVtb3ZlZC4NCj4NCj4g
UmVtb3ZpbmcgdGhpcyB1bm5lY2Vzc2FyeSBsb2NrIHJlZHVjZXMgY29udGVudGlvbiBvbiB0aGUg
Z2xvYmFsDQo+IHNwYWNlX2luZm8gbG9jaywgaW1wcm92aW5nIGNvbmN1cnJlbmN5IGluIHRoZSB6
b25lZCBhbGxvY2F0aW9uIHBhdGguDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEppYXNoZW5nIEppYW5n
IDxqaWFzaGVuZ2ppYW5nY29vbEBnbWFpbC5jb20+DQoNCkxvb2tzIGdvb2QgdG8gbWUuDQoNClJl
dmlld2VkLWJ5OiBOYW9oaXJvIEFvdGEgPG5hb2hpcm8uYW90YUB3ZGMuY29tPg==

