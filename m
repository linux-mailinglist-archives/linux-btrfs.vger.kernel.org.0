Return-Path: <linux-btrfs+bounces-22137-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMOQLcxipWmx+wUAu9opvQ
	(envelope-from <linux-btrfs+bounces-22137-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 11:13:32 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F7C1D62AB
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 11:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1477F3017DE1
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2026 10:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65FA396B85;
	Mon,  2 Mar 2026 10:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N3yNPFwE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="olXsNJqZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E311396B7F
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446407; cv=fail; b=muaUiDIpxOSSm75FWDg40DB8WFYWS3hWDe6yoUneCv6kyNnEWcqjGEERvTHoTUGtiPzkq0MREZpCR/qBJdwRPx2aXRb2lmE44vmW++f3KM8VT0Rau/RBopU7rthoI31zcLQHe2JtaHpzw/q1mxqaOmnFnnJQ6/ru3fV9YzRvmBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446407; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bf9t9bRohCMWyNyazaYMt8JcIRo5REdqA2BfUpj2Oro0eihn5qlEsBJUa2fi+sLHKKyd8WHAL9dZc6JfzHKjtwrmxB4s7L68m1B7von09KzJ60JZ+fyLgiKPLUtd27Hg9ym2fzaL/c5Ha2RoW6H+lmRIrHeKMj2w95K6zT0EvdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=N3yNPFwE; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=olXsNJqZ; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772446402; x=1803982402;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=N3yNPFwEVQlL9VMXuOAbpVtD+wKmGVvUW5/tcrlnpqFdlEdrZE51erF7
   RIJgLjwG7G78vIJ5yQ4JWRMwKhup5QySwvf3cC2knjQuu/4THmFgPoz42
   fCbCMqBz5mYJlS4JpZhoccEv8HH9rZBNu6HfdHMdB5lCJKTc72gIbEvB+
   7zuD8FARfpWd8daQBhDBfVMNjGtb/2u5q1aIbiwh7Hgpb+uMLPa/bXLQp
   mrV55mGn4UqdkG+ApUJlQbRgpKie48R64Q6I0l1vlXt/8Y4WiByr4dt79
   J+NLtdJWooQvpD8YSyb0mF4PG00eGM1kL4tXpqwtkglI8M95hhrazxQoJ
   A==;
X-CSE-ConnectionGUID: gpp5IatdS06q8p+DZDAZ4g==
X-CSE-MsgGUID: Ja0i2XawQ9OdpdZPScLKRg==
X-IronPort-AV: E=Sophos;i="6.21,319,1763395200"; 
   d="scan'208";a="141726177"
Received: from mail-westusazon11012066.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.66])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2026 18:13:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxq+P8YICDVVLJWcHPUc4JzoR0gc6Vvnn8Y3EY76ByDTN2mZYhI2odhvgE00q1QhTY9vnUSQ0gt5ixerSqTtdh/EbjBBrxNr92zfZbDW24LyIk+ear2cyoepyxJjUz9Loud9lT9e1Rkn8NAAB16NMXSg92dlvkG3DI1ELGRhemvthE53tP5nZrl3SLmzNQ6CimA9mgQmObWqHWNYvuJFMtqEUDa5DI/Eoih4Nuugt61u1FTYcqajZRsZLUL6ex5RhPdzysRR2e8aSra5eNiY5JAAlrTd/rNMsPXx8xLB1VDdeoIf9PZb56w3SRTzYEEQ1ngIc6WB8T8dOAL/TfD9GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=sIQVqmrHp96gqheem4FTwCCTC5EH5fIPNDchIwp+NMHehpSGYhNNrimhHJ4KfXUbiqN+wCmaLPH7fSNIOzPUS36uWTYn0BAKyXqqoZAf1BroPt3Csuo/KIexdOTEZNhtYYYh4usMnw0TgdiltlzSICslX0UtlOr/yoGNqpMARF08DHjjOHx73fTzV2LFxQhnYl2RtHDcBh+d635ONNsafcqzeUOgsB45XZtrwQdhZ8QXAeeAtJs8J5BD+fwkvTDJc5XN1ZL0JTAk4XevEBmT3rdmtrj88zjpYnMLbQ+xL3RzxDnHiUAs9b7ptf6pmwJAJI63NewZrR3gf7+jDcRfdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=olXsNJqZwvvsHAbBlVwGVYJi14X3c0WPLmPmbxwtzPVqevr2nsGg2RWYH2ELCczX1hltdCaARPS+ZR4JAQsBOsCfENZ4Uv8GNKmStPlWnH0tIxQbnFPQzMRHe4+Vv+kDAFO2gLiTRFG3eYlYOQsLOmZNXgjtUCFbqEI28W8kQxc=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by PH0PR04MB8339.namprd04.prod.outlook.com (2603:10b6:510:da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.11; Mon, 2 Mar
 2026 10:13:15 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9678.014; Mon, 2 Mar 2026
 10:13:15 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba
	<dsterba@suse.com>
CC: Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: fix leak of kobject name for sub-group space_info
Thread-Topic: [PATCH] btrfs: fix leak of kobject name for sub-group space_info
Thread-Index: AQHcqXVWJiCBLHYKv0CVhN6oGErRzLWbB3EA
Date: Mon, 2 Mar 2026 10:13:15 +0000
Message-ID: <0d55e404-1e40-49cb-8670-cf29cac6ef6b@wdc.com>
References: <20260301121704.45115-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20260301121704.45115-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|PH0PR04MB8339:EE_
x-ms-office365-filtering-correlation-id: 2dcc0909-bd16-4b8e-3642-08de78445166
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 z8nyzQmz2QK8hN+gsVEn5A/nJuC+ytry1+GryfDI7hjEJvIIHbr8IhuQmJk/GKH2RhmqUOVRSxBxLdwkGyT5Ju0+6L2ZsfpC0wp9KPKpf5WOxcKq4QcvXFUd0XMufP0krCWpe3MiDffU1RhJweIMAjqc5zZUFJtXSNHRMYP+hAvdS4AHMYtRqxpOAp9wXnPmMKeBsRd+/U1jjBMwC9I4a0uat+qNaeoI8dt8LQIu+TQ63JZjqi6jC62w+sY5uGf5S1PmO5vrZLR6Iv0TuCsUTR4AHkZ4G7m4TnqgzH5pRxfAF3+KvScDSZMszYQJrgCLuRk7sO35Exx5AITztcRTuBeGVvauoKv8l53e2vWlz7tJmQaCSCL3Cz7/eU46+WHZgsjCBc1ZVc9hUKgpG3mbJaF5ibV+pKBjfGAelWxzasxWYuv5JHdU70mj9U5qcm0iP2ahR/VJ6rd07ocr65RmGENBz8q82sWqhHu+lvDNL3Xzalf1Nqqp8P5gvbljkuElOqEvz31c2czVM/yrDgIYgluil2Ix1sjF4TxK0ncdrxMhGzexR9KI39zgB+2KGCtyQ9WYOVmt6qB8CeFQBRTcRNuzU3yS0OSLCVMPIijdoigMGArMrV1nfOmGSKowfhT7t/rflYqr1hFgjSnz/8fzSwyrStAKDQzLErZa8TWaKXOMwjiRy8+7hOkv9lD+oYeyiuYqMzeds2I60bhUnhGWCHkAHazQWxf1D0eq4JjNWD9RD4gAKapINrijxIPybOO3v9NIdamqzSyg1Uh0frrcSvy1mjF7RTrHWPL+V18hFCM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWJTbUdrVUNxelpjemtMN3VoNk1HOWFvUWwxRkZ5dEtETkdkMm9ZaUZJcnRF?=
 =?utf-8?B?b1FMd2NQcDZJNVhzUlozcnhuRG40T1U0SzBYKy94WVJNYlpYZE5PQmxYU29N?=
 =?utf-8?B?dUJGMmRjVkM2KzVBOThTUHlIb2V3eTIxYWVFb3JGeTJ6cjd4VFptcE94TDlU?=
 =?utf-8?B?OEdidTg4YkZzM2xKY1IzRC9lczM0blN1aHFvaUxYRU9RWFY5U0xZZW51anNr?=
 =?utf-8?B?czNiSjh6N2lWN2llSFVqYTZ4Q2lKYWQ2YjlnaFppeXY0bHV4Y1hUT1gvcXh0?=
 =?utf-8?B?WFJzOVBJQkluZmd2bGY5M09OSzM5RlQyczBoUDZNTXY1a2tuaWlBVTYyblhI?=
 =?utf-8?B?aHM4ZGpVWkc5T01WMWo1WW1MaXk5dkR5aHE4V2VBd0E3QkVpM1h4U3NhSGRx?=
 =?utf-8?B?aENlbklpdXc2WXdOeS9qci8xVXphUHdwRlRNdUxnTFFZamZTUkhGbDg4a3pS?=
 =?utf-8?B?NVFXVW92L1hWSmFaV0xaQnZLaDU5czBYUGFjY2ZveUEwUit5RVpHUk1YY3N6?=
 =?utf-8?B?VHQ3TEpWUTE3RG8rTkRVbmgvZWp6d0grdkJreGtxVlJnbmJTeXUwTmhEOHdj?=
 =?utf-8?B?T3dhQXdlb3JmVHVzNml0UG1oSXp6LzFvREdYZWtCSFRjQ1lqYWN5M2JRU3NM?=
 =?utf-8?B?VzliZHNIT0U3RTlPYUVRRXlreFppZFVBdElBQVBGbXdDaEZSemhyVHBJTlNF?=
 =?utf-8?B?dkZyaUpMSzdISlZ6WHgzMVBWMlArU3llWUlsVWlic2dQUWgyY0lVbXZHMkdL?=
 =?utf-8?B?TjdrSGtLT1BZaXF6bXVWeXl4dytyeGU1dW1MbVgxSVpQR1YvTGQrZnpBdlFZ?=
 =?utf-8?B?V3o5Tmh4S05NczlndDhFZjNCRTR2Q1M5WDkzUjVsdGhCQVJrYkVJRHl6aUhJ?=
 =?utf-8?B?NnhmQ0phN1RDWUZhU1RtdHZGb0tXbzJjLzZZemtKVEp2cUFxVjRMNkRSaVhM?=
 =?utf-8?B?NWphcytITmlTeE5JTjJxR1RMTmkreEJ2NHRJTUR3TjRBQUR4NXJpR1k4aWFY?=
 =?utf-8?B?ZnRmZHZwRFVhT3hNNmVORTB4MWFvdjErSVlqbW9EakxMc1ZyMmtuYm9rdHBU?=
 =?utf-8?B?RDNka2lOQmxubERuM0NQN0IyVk04V3U1U2hzNTBEU1hqTFlKdmFqOW9WZG5v?=
 =?utf-8?B?OUdWWmQ1NVZqRkw2OEFpeGxmWmZPdzRGTHNpWjNmOHpLQUtDa0lQZVUxR1Ux?=
 =?utf-8?B?RUcrdW1ZNW9lZ2JYQlVFZjduTzR4MWtNSGJKcnNhUXV2VzRWcXhITjVpbkZR?=
 =?utf-8?B?UHQ1ZjVGQUFHUEt0cTArWU91NHhzQXRwU2Q2ZXVNSm9MUFl6azV0Y1dCQUVi?=
 =?utf-8?B?dkJrK2x3SXp3elBQNkUwL2ZWNExDdWF2VER2MXVJTzNGdW5LODl1OTZSYnN3?=
 =?utf-8?B?Vm0zVlVYUlVySUNCSThvNEgxNTAzWjEwQVB2aXpPUk5tUm9EeXZXcm1BM1Vk?=
 =?utf-8?B?T2hPMmJoaU5wT3d5cmc0dDJYeDRyU09KdncrT015V1hXQ2NDdjBBSnA4SW5E?=
 =?utf-8?B?d0Z4YnZhQ2RGSnhucksrdHNWY0tmYXJ3V1V4Z1dpakFwc0V6UndTSlU3VDVQ?=
 =?utf-8?B?T05JVGpjV3FoM3VYTGdOSFFTaDZRdW9PUVdrb01tT2VBanhXa25yN3d6c2ZZ?=
 =?utf-8?B?T1dCa2E2WjQyQUNVeWdseE1DZTNsZ2Fic3dWM2N6OW9BWWV5TmJYOHdkemVS?=
 =?utf-8?B?S0IrTU8wdVRGTGh1VG1kTEg5dEJ1eUtML1RlZVBlR3VqVXNIU0V1Rjc5T3FT?=
 =?utf-8?B?R1NnVGtBMTJMUmZDR1FTNnJoNDZGZHpsWFlPbk54TlliQWNMVWRCT1pSK0tZ?=
 =?utf-8?B?MWpjQVp0NlZDOEpjb0pGMml3bkZnYzEzVWhMV0s2U0ZlZG1GRFFHbFJPOE1U?=
 =?utf-8?B?N2tFMW1WbG12aXFEaCtUbGhkYlFMZ1lQZ3ZMdmd2bTBmc3NpVmMyZHY3bTlS?=
 =?utf-8?B?MWtmc1RRTC81bU1CMFExUTBaZmg4SjY0SnQyNk96VGozQWtWSEd3QTJXOTk5?=
 =?utf-8?B?RnhrZVNlZGVSbEJPZ0Uzei9uOHJXR1pBRmFXRXJKWCtyNnozd3Q0azNScG91?=
 =?utf-8?B?YmFIZW5tYkd1VlRZYVVMekZVV3pKSmd6Q2o2STBQSHRnRWtzZXlWak5CNkhy?=
 =?utf-8?B?UFphTGV0M1BQSzdZMStLNjI1NUpoOWx3N0JvUmpETU4yUHlZTzFiRS8zRUJ2?=
 =?utf-8?B?MkRFQmJnVStrWHN3SHU3dXNUbytaTFpMVy9QY2dQL0c2a0RhbGFDc1YzaVVS?=
 =?utf-8?B?d09PMHJoc2M4K0dzekVuTytnZkFVMWQycFB5QklZc2hxd2RPN05HWnZyb3dj?=
 =?utf-8?B?WDAraHRTWWY3MCtVelNjQ0RERlArMjNDRE8vSHQ5bWJCQTh3eExiY2c4Visy?=
 =?utf-8?Q?Bcj+DwicX/Cs/bJYbhumaaj1pzVI/ZuGp1nuqoq6n1/1o?=
x-ms-exchange-antispam-messagedata-1: DbQ9NpKS08HW511zB8QPmVfF7H0pinfrraQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FCC2F1D40AE3F468F278BFA5739A057@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	La1OztOv5kAJGsNrRvGv+mVl49ieCBBPb7+i0kn2+f/PR9ZXCWNhnNTWys1GlqfTBACr49Kx7C6HpkH+PY4WhgLEZG5UzhXRtDN9w/3/ZVOjPPNSV96+9zxweHioiNY4V504yxkNXItbbq+jQsHu+q2nvvBwr4oCsTysOC+8xSBccA/rpiLU8rBi9NH4sPxEwRmNnjXAnRyLaf5TRvXmlxk6G34+/zoKGmDKC0TYDSbVB+6kN1DPeGgQJQwc3UrtsW8DwH8+wOuUmHrNuC6Lg9sFZIu043DHps8khp7nyhzegoJrP+rGhXmdMdrizre+wLRB+fZygq1qvv0bVhhBLoPgACLuYk6+tnXzpso7i7vqDt4252koSyhS8VpG5eIrW6F+kgPLOaaJaLadABasNBjMk0PQtADUxB+VeBj/61tAgOuzzQcNXG1mro12YJGDp9aADFiqGoCsBgc046jiYCrcrruR8Xq0Pe0PMESyz9+joeirGv9eLL2ER1J832aKLxx3JbUdrIE1FbTU2kTyb3phyZRNM1Qf+yIBBYSLaPs9ZuT3BsvDSaj9miHG4C9C0096WmeM+l+bBQDXnomJUvhDhbPVaaHwp2/azC+xvkumOp5IDU+xhthe23rcQve1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcc0909-bd16-4b8e-3642-08de78445166
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 10:13:15.1890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7/oxWeGPql5oOUjQrUt/2Fdkyb51JnIg+FZjUmYj1CqCObI8Lm6SacQ9G47391pv1pYarQywPtFoE9Effauqp1Kg+1P+el5+5hN4QNFfQcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8339
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22137-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3F7C1D62AB
X-Rspamd-Action: no action

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

