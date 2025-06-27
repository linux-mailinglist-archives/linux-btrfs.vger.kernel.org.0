Return-Path: <linux-btrfs+bounces-15033-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41E6AEB33B
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 11:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B103B560541
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 09:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEB62957CD;
	Fri, 27 Jun 2025 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KXcvKZ/v";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QmGq/6v5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2C9294A1A
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751017604; cv=fail; b=caW4mJggtabVih6AoXZ7c6d0ETu+duEgS9C7CS+s0/tGm+kPSJE+G/2qXFjrO8cPUV3dxeyMGOykgNs7Xf5x4Pjogq607ks47/GBr2G1WYHME1Cx5Z4aiC7k3z8zuPOOrOOgo/KqWrpB0y9B2azyAgrVHN7OCglD+u3OXypKunM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751017604; c=relaxed/simple;
	bh=rxDfb0G69sYUVGpjvrcqu3nF2uQOTNxRbK74Z127b2c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UFy9+5+YZI/f7wY2f6sE/2GpkNb/sGtlNGou8Nl8auOIAClG29xuTIG/P1kO4dmX6qRQBZ+MUMLHlndx3S3trkRMsraEeS9r80OCnWr/zCpFildCKsmkjdQs1ZkVIldDhRmq4NErN1FueNYglKkdDKvmh28GwJgHjJLkOrZ8dJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KXcvKZ/v; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=QmGq/6v5; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751017603; x=1782553603;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rxDfb0G69sYUVGpjvrcqu3nF2uQOTNxRbK74Z127b2c=;
  b=KXcvKZ/vz3t6aSLqs7L9GTJnkjpbL3SET3QF5cEdMIJkHbeH0LlZ9zf7
   rOHejzjdz8CntHnrtMXPrvX9oGtHSYytWcFIBXiUo6EIKG+LMAnoKFsGF
   gVBrWmqQA0QFd8QwZEB0VNsRIzXwtvM4czixaalL/gp+iKOfZxrN0UjzP
   SMHpr1lgETfif02zYDKg9toW1xuRczZQ4VillGwzPttkpHmJ57gYHzAny
   c5p15zS9cAcuYhpGhNJPfcgP5KZS3r/dIxqBBK6gQ290ht4lJqfIpqiLG
   CKYX0Hm8ZJ0Hgwcx3Mwq7wW39FAsPI0OLhJYWyTM48UJVNUhBWDE1CPDQ
   w==;
X-CSE-ConnectionGUID: xXoUrFjJRa6M+LmRMs1/jQ==
X-CSE-MsgGUID: uYnplRxeQJSgjR4zLE/yGQ==
X-IronPort-AV: E=Sophos;i="6.16,270,1744041600"; 
   d="scan'208";a="87329347"
Received: from mail-bn8nam12on2048.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([40.107.237.48])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2025 17:46:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqW5Py6m4zCZHD9311G/vPpHdn1w/04QIe+GJfir0p54ldEabvaJmP7NA0QPlpoCtCJMhsU3p/r9zpuw6lvsFSaMJHsczlYiAB1oz832aeQ4dbCVNiioNWL8zby2yk8nvejuLzdjKoCOreMu5/YppoDi+fuffWZID2l6K16FPeDsa2EQHZgKd4q3ef9hbOmgB6eB851WnS67lvhu/8vHcEajr6rl2NHnVfKakt5JWNQIFjnBR2Kpkub8Z3LIVbv45DF5zz3T3ew6hOrc9mn6FYVpT3UxsSFXH4kqgW1udvaX7g9D0mRJsD4JVknb1qMulXBUC28GsKqtbczOEowhJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxDfb0G69sYUVGpjvrcqu3nF2uQOTNxRbK74Z127b2c=;
 b=RcOREkWQ7LzxCvpyEd3mqrrpv6dFjObPYU0y2e+YcjkzQgUjq7SK+8zBFA3V5U9Wnts/HP5zPiY27whyP8WbMFBkrlhcrYiukK4uZZLnwjBmpz05rqRWGA9w6TyhwGmdT7PenYSt38V/HObEBOgzn1RON0kBkDTMi9Yr2QbPDC4lzMAgeW5M3WUNIObIMIaCzWcHl0phk8DSnuIt+BmFXcWKzlm6hnYtMt0LW7MZTfftt5ELW+BnPGgKiDRJ+cqbUnqFGKcNzKYS6UhYjSlubmH00fRjQpWrGFvGFWHypMouvSA4XL8/+6qVNjs7F0hDa5x+AgYZUMUjhEDvkcVHIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxDfb0G69sYUVGpjvrcqu3nF2uQOTNxRbK74Z127b2c=;
 b=QmGq/6v5GY7iqjWVB/NaCNbrb5hAneYSkSoUn4clplAnfe+7JXvorLOLK++qRu/cmT2FWE4BP8TMLp+XOEF7WVXh8yuBE/yvAnyesvQzTo0AS8kcZl/rPPzBh2hHViWa4xcU288TfocXCbDxZoY+7MTu1BLqk9C/WYeN10S4DsI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7879.namprd04.prod.outlook.com (2603:10b6:8:26::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Fri, 27 Jun
 2025 09:46:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 09:46:38 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Dmitry Antipov <dmantipov@yandex.ru>, Chris Mason <clm@fb.com>, Josef
 Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: avoid extra calls to strlen() in gen_unique_name()
Thread-Topic: [PATCH] btrfs: avoid extra calls to strlen() in
 gen_unique_name()
Thread-Index: AQHb50DHlLFrsZGqPkaQzFLe5arhU7QWvBGAgAAETACAAAHiAA==
Date: Fri, 27 Jun 2025 09:46:38 +0000
Message-ID: <62ea1bc4-838d-41c0-a33e-c6c44fec8ed0@wdc.com>
References: <20250627085117.738091-1-dmantipov@yandex.ru>
 <c89ac44e-a356-4091-84e4-c709615051be@wdc.com>
 <bc391c80-e09e-4460-8599-eb8ca4b68811@yandex.ru>
In-Reply-To: <bc391c80-e09e-4460-8599-eb8ca4b68811@yandex.ru>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB7879:EE_
x-ms-office365-filtering-correlation-id: 038c2b8f-0e0a-4aa2-a33b-08ddb55f8371
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aUdVQzVZaERXam15c3YvTHRtdmtlZG52RldYeXMwUUFtYkNxWDkzbjZMazdm?=
 =?utf-8?B?alhoNEw5Tzg2SHF5ZmNucVYvWEtUVGh4SGM5UUhLSzdzTmVJMVpTRyt0TXov?=
 =?utf-8?B?ejlFVzY2MkwrWlhvakxxbWkyY0doR3ZjODhjM0FDTUMxTXFNV1RPeDROMXQw?=
 =?utf-8?B?aHg4Uk1nWU1wMlF4QjdNQVFLRjFkVnRpTWJVa1QwUmZhQXdxdzJmQmVPWVQ3?=
 =?utf-8?B?VEM3S1Q0Y2J2S0tZeWVzcDVuVEVBNWRUTjQ5ZWxzN0ZoLzRUZEVWMERTTkI0?=
 =?utf-8?B?Y05ISlR5SXpYbzRkcGc4bjVNb0tVYmczZHZHV0xtRTVuM1d6d09Gcms2SE1D?=
 =?utf-8?B?L2xQNm1SaFJzNXA0aTdmaE5qZ1FrVEVjajFrdi9BZEM1R09xK0Q5eXk2bFE1?=
 =?utf-8?B?eklWWkYwcSttK21DeFZWN1Z3d3JmbVh0UUxTdU4zc2NSMkFjSXVvYTM4YjJJ?=
 =?utf-8?B?c1BLTDNYLzlCcGJzTjFwN0ZIQ0dka1B4SDlaYkFlQzRRVjZmaTA4TDVWY2g0?=
 =?utf-8?B?a3lLZSs1aU5DbGNYalJhZmplamJsNTRaek5XQU0rY08wV1c5WFQyTy9LeHkz?=
 =?utf-8?B?bTBDdjhCb2hYMnZDWm13M251ZXIydWUvaVFzVW5JdVR3STQxYVk2d3BoMjB6?=
 =?utf-8?B?aEJYbWxnbkQrcXRvM2dVRC9GcUpCTzFma1dXVWZ4NWlPK05WUE85d0xPOGc2?=
 =?utf-8?B?cWdPYUpMZUtRK3hNTkh5MXpuS2NVUzBZKzY1aXJ1TmZZdEJPUE02UVMwOVpO?=
 =?utf-8?B?b3lyTkh3aFA4S3h5TEhsS3lUeDFQcmxpRjcvYTJNZHdnOHp3dFpXUXdUQlBk?=
 =?utf-8?B?UXpxeDduTHdsNkxyWEdpVVEyaUIvOE1wY3RzQVZnM1lyeWpUQmJmT0U4MjZ3?=
 =?utf-8?B?UWZkdVAxc3RhTXVVd2pKaHROVmpEM1RLZDJWVEZtT2FkcVp6ZlhrT21DSFoz?=
 =?utf-8?B?UnYrcUprRGg4V0xIdFZ3UUN0L2loQk5OQy9WcStNTDJZRUN4NFZSTkNOelhY?=
 =?utf-8?B?QU5DaTB4d1Vnc2NDTGdXZnJEcjJvMWRaNy9rYlcrWFdsakpBcU5lYTlTWjQr?=
 =?utf-8?B?TktpK0lVNTlFM1UrbHBCbTdjMGdTTUxSOW5mbS8wdWZHbU5MTzZReEFlMUI4?=
 =?utf-8?B?QzZUZThHdFJGSzBCVjRzZnlSZzBvYUVaNUpCSVRXZnlnaUlES05GSm5WUFNI?=
 =?utf-8?B?M21FdGZ4ckRTalByRW51dEtOenNmVk1LT3M2YkVEb2lUNWw4ZnlpVVhLeEFC?=
 =?utf-8?B?KzF6a3g2RXZRUjl3QW9uQi9JT2ljUUZ3Z3d2R3lHdkdEbVRUT3MxNFFIcDhs?=
 =?utf-8?B?K2RaWG9nakxPanZkc2ZWaFhVVHhUbkxOZzV2bC8vUDFsUitVWTlpKzFjci81?=
 =?utf-8?B?Rm92WEYxSW9qS3owLytzeVRsTWlabjBNS2xvS1BZbHdhaG54czVZb0ZCN0J3?=
 =?utf-8?B?dytsN1ZIcXRhbkVKL0pBV21TQ1VLTWN0R0FzUHhDcGdML2JsTjJzbi9zR042?=
 =?utf-8?B?L1VWWVE4V0lPN2E2T2hRU1dvWWdCejlQYkxqVW5jK3FwQ09JS3k2MkorL0di?=
 =?utf-8?B?WkZ5cStkSytGZFh5YmwwWG1BNHlCVkkzRHZDc0hpTCtDZkxnbCtpZzZEQ0dm?=
 =?utf-8?B?dkdoUGIrODYxSlpMWjFGZ2JPSG9jVXJKMExqV0tnMW02NXhZTWF5RDlnbndE?=
 =?utf-8?B?YjU4QnRDNWgyYnYwd0dhcXFTZDhvbVY3OXRqRFhnU3h0MkxwUkNoNXR1T1pV?=
 =?utf-8?B?UTZWYnc5dnVaSVQ5Uk9lbklCTEIxak4vM2ZlV1pMWW5OZnV3SEhxRkFHRGtE?=
 =?utf-8?B?cUZ5bXF6TXNBZGg0OTlMTUNkaDRrZ00rOHM3UG41UU92TmN1NnZFa0tSZ0xH?=
 =?utf-8?B?STJ1V0sxc3Z1SjBMaUZpUys5YmpoUkhQcFVnL1BEc0xYQUFIb0tadVQ1akJP?=
 =?utf-8?B?L0I4YjY4d0lEYVlERGZQelVzSWJvNjd3LzZmTTdaTmJXbG84Y1AwOG9IWXBG?=
 =?utf-8?B?UDIyMWswN1lBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?REdVZkJ1Y0N6enVaKzVxOFZWRUVVMFpEd2s0TVJhVmU1T0l6MTlqYS9aR2Fy?=
 =?utf-8?B?L25iQTF4N1RFcHNXZTNIbGJIRE1peWR0WTRmd2lidVdnRnpkd1MydDU3eGE1?=
 =?utf-8?B?cWhzYzFlcm14cTRHMnI1TWlqcE5pQnRtTmVVRWc2UlVpeU5LZFpHdVpFRWhx?=
 =?utf-8?B?bHFpeDV2QnlQMktZRWVBQUx3YlVhbTg5c2k2eHpZbnFaaWRIOGIybkxtQ082?=
 =?utf-8?B?SE5RTGwwWXlBeUk3QyszRWtrWXZrMUs4YWhnQnlQUkhVeWNGeFdFNlRNNmN4?=
 =?utf-8?B?M0lCT29ydjlkcm1qL09zQWxRUmxjemZERERYR3Y4TW1hOUN6VTZncEJnR0V1?=
 =?utf-8?B?K2tLUlFDL3I1SFlRR1BCZVR2SGNVYWpHR0RITG10dVV1QW9HWnNZMU0wazlQ?=
 =?utf-8?B?TExJbVV0ODZ6Z0NtRTNCaENaeWlXa3JobWtwTm92RWhMcC9LVVhGeE0xUkVF?=
 =?utf-8?B?RHhuUUdtMmxwcm5TamNXVXhBczJPWnh5VXM1N2NGQThpTm1INmRyUmFyY2RE?=
 =?utf-8?B?MGFaTWF1M3RtRVlHNUNPYXEyRFFNR3dETllldS9weUl4aTlEbmNjT1A1emZZ?=
 =?utf-8?B?Tm9YeEJxS0N3d0F4VndRRHI1Um1uSFV3dGEzbllDUzk0aWwrRmVCRFBQZ05z?=
 =?utf-8?B?NlA1RmppZzhrRjVIUzBZaXBDRGVlbDdaY3N6bGRNMWtyK3pPNmcwei94MU9x?=
 =?utf-8?B?dWFlZi9KR0xZTUNCSWFlR1Mva2pkTzlDTnZTV0NwMWw4TytwZ0grQ3psTnFQ?=
 =?utf-8?B?eXhLTkVHWkEvdEhhcDBaL2hKdTB5TjZZYzkzZzNRSzNoeHFDNStxN1NqZ1Ay?=
 =?utf-8?B?OHk3V2tFdkJMNUNvcmVjbDdydFVkcUgvNTVrSmsrSjlUSDlVUFFaUHh1ZUl6?=
 =?utf-8?B?cUt2a1NVQVN4aGtkUkhsUGV0QjVIbFArNUNUdmNxWjhsOEVBV1FGa2lMVVgw?=
 =?utf-8?B?VW03aVBuTkt0b2QyTE5abXhYNE5sV01melBITkNXNGxBY2ZHUURyT1RIYmlU?=
 =?utf-8?B?VEN2T01Yb0FkNC9JYmRsZ2lFOXMzeWlnYTZjT3VjbG10dllXbmlUS1FYQ05h?=
 =?utf-8?B?SFZ2QTR0MUJUV0ZGemR2UUo5TXJ1S3RPUU9JZGI3R1ByQnNPMnZhUndrZXk2?=
 =?utf-8?B?Y3JpbkcrQWxSbWFNQ0N1RDlreXN2bDJTdjh0bGk3dW5TQ3RLY3JENzhwMGd1?=
 =?utf-8?B?WCs0QlNZRTRab3FCZm52VEVUcm9qejVycFh3STF5YzRHdW9CSEFOV2ZzNklT?=
 =?utf-8?B?NzRZc1VPenNlSDZhK0JuenNoNTZuZ05XZDFzSWIxUEN4RW4vUVVkejd5RFY5?=
 =?utf-8?B?Rk1TbmpudWtOWG5ta2JBR1J4ZHN0aUM5bWFvdWx5UWRwMkRjOHVIbzVubm5s?=
 =?utf-8?B?b2VLZnJ0bllZSFFkRWlwNnZZZjBVRFV6OU52ZmJ6VnA1RFMxOWF0WmVqUTJY?=
 =?utf-8?B?bFBLSm9QMVFuNTh3WjIvcFJ3VitDaTNaNE0xMkE3a1QvOFZKUjRNMDl5dDQ0?=
 =?utf-8?B?bUhrei91VW5VQzV5TWE5SjNHUnJtQ3NSenY2WEozdWIwM09aVWZ1bWROZnlV?=
 =?utf-8?B?TVRrUE85OU5ubnNEZFh1bkFFanR1VW5KcFQwZzZqUnNkU3FPYXl0d01kL3dO?=
 =?utf-8?B?THkyeTJKNHdyNkNaVXBhQ3B4VFRqd2o5anROK1AvS0ZZVExaZGpkR2NhOGJQ?=
 =?utf-8?B?ZVRFN2xPSDN6aFNmcEFsUlQ0bzUzS1ByUkJRSFZpRENPa3dhRTliVTBRTk52?=
 =?utf-8?B?TmdqWnlTTytxQTVIV1gwOFNvWUtyNVNCTFh2Y3pGRHlHZ3loR3BrZk1UbDkr?=
 =?utf-8?B?MmIzOThQRzg4NmFaNXN0TVowcFVzdTczeXRWdlVodmJqdlU3WndxbnpVQjJP?=
 =?utf-8?B?NDZuRzdZNndYY0VqUGtuS3o2bnpEOUhCRXZhb0NOaWd4V1NRRm9VckpWNHJB?=
 =?utf-8?B?ZGFUSVNRNHUxUkRobm1QTm51ejNJdlY0YVluQUc4UmJxWkxmeW9mc0gydEFD?=
 =?utf-8?B?VmRDWVkydjBMLy9OUDJLK3V2K25CUm45WXRobkNBbm9LTTFNaFlTUU5hMjJY?=
 =?utf-8?B?V3pKcUFnTVVQSVU4bUpnSzNtdDIwUUljK2RQRVZhcFNnSVByWTF6Z3hyN2xv?=
 =?utf-8?B?bkVPU0d0bkxOK3RkK0dvTW9jWFVmaW1MczRaRjhWR0psMUZ2empJYld1bWRC?=
 =?utf-8?B?dDRRQzJmai9DL3BUTTA5cHhNRVYyM2F3bGhlNGFEeUVxR0FuKzZkYmhUREg1?=
 =?utf-8?B?cEM3Q0lRWXFIL1g0Zmt2aFJrL2JBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7091F9ADB7E1DD4C9F4823B443C85EBB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Lm2MkTKfQ4mbDPqYPlBKZ5oEzFuDGa/c0dxsLY3ilfaqZoVl3hGeDa1RJXi0a9KLRP31DXdesZOrjXybynYPDhhh7mIbaLYPKUb15AMfj2b8kM0ca56MeZB4Tr/htGjkk+AlXGeCsZRP7nQ+LvbY3OusZ8E7vudWHzPjsX5Z4VCcG8/HPZasBCB0mstEqP0Jtu9v4jUuX9NzXSJI2hGNCHpid7fwjqhycLrX3yOacmS0xyQwBG1T04/PIw18WRATB9nDtsy0fM6onXxVjlOGvvYjCzkwqCMbwclT3xCIid1yUFPVwlvY1vLFF+Cb+SCcbVNyYvaInJqeSlnfdC1LogRo5kOta3xBmrsup7xp5uCbjBWHSKofu5D0qXK2//BKpTC5DDN6X5JFyDLLTdZSmTICF4hc4+ICtJF6QIz8RG4opKccI/p0aYEMigciCRqgrUVh1fQBpfhewX0oxGuFxI2u8RpjT5OSho93EkZ+xNJ54M7+qFrJS8fMiSwkfHNjo4smxbWt+B/6njYApVr7BenRJEL1h4y6Z33qHIvb79q46k4/IM1kmPpOaYKMuOYmW7u9o5j13DVrpS9AiLNe7evojrB4egSiNxHzXKkDbKgb5PZE5JEq7VNCTu4Ele+J
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 038c2b8f-0e0a-4aa2-a33b-08ddb55f8371
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 09:46:38.8215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 17p6bEKRUa5Enn3oi2i4ki2pxP7vLYcLkKIXpTA8Uylc9vMSCgOMzmVL9s/UYUTznNlWcbN0FoZUDiwUUivOi92eIg8psWGuPD6WA5Ykp74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7879

T24gMjcuMDYuMjUgMTE6NDAsIERtaXRyeSBBbnRpcG92IHdyb3RlOg0KPiBPbiA2LzI3LzI1IDEy
OjI0IFBNLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+IA0KPj4gVGhlIHBhdGNoIGl0c2Vs
ZiBsb29rcyBnb29kLCBidXQgdGhlIEFTU0VSVCgpIGxvb2tzIGJvZ3VzIHRvIG1lLg0KPj4gc25w
cmludGYoKSB3aWxsIHdyaXRlIGF0IG1vc3Qgc2l6ZW9mKHRtcCktMSBjaGFyYWN0ZXJzLCBzbyBo
b3cgY2FuIGxlbg0KPj4gbm90IGJlIHNtYWxsZXIgdGhhbiBzaXplb2YodG1wKT8NCj4gDQo+IEl0
IHNlZW1zIHlvdSBtZXNzZWQgc25wcmludGYoKSB2cy4gc2NucHJpbnRmKCkuDQo+IA0KPiBEbWl0
cnkNCj4gDQoNCkFoIHRoZSBBU1NFUlQoKSBpcyB0byBjYXRjaCB0cnVuY2F0aW9uLCBnb3RjaGEh
DQoNCiBGcm9tIGxpYi92c3ByaW50Zi5jOg0KDQovKioNCiAgKiBzbnByaW50ZiAtIEZvcm1hdCBh
IHN0cmluZyBhbmQgcGxhY2UgaXQgaW4gYSBidWZmZXINCiAgKiBAYnVmOiBUaGUgYnVmZmVyIHRv
IHBsYWNlIHRoZSByZXN1bHQgaW50bw0KICAqIEBzaXplOiBUaGUgc2l6ZSBvZiB0aGUgYnVmZmVy
LCBpbmNsdWRpbmcgdGhlIHRyYWlsaW5nIG51bGwgc3BhY2UNClsuLi5dDQogICogVGhlIHJldHVy
biB2YWx1ZSBpcyB0aGUgbnVtYmVyIG9mIGNoYXJhY3RlcnMgd2hpY2ggd291bGQgYmUNCiAgKiBn
ZW5lcmF0ZWQgZm9yIHRoZSBnaXZlbiBpbnB1dCwgZXhjbHVkaW5nIHRoZSB0cmFpbGluZyBudWxs
LA0KICAqIGFzIHBlciBJU08gQzk5LiAgSWYgdGhlIHJldHVybiBpcyBncmVhdGVyIHRoYW4gb3Ig
ZXF1YWwgdG8NCiAgKiBAc2l6ZSwgdGhlIHJlc3VsdGluZyBzdHJpbmcgaXMgdHJ1bmNhdGVkLg0K
DQpBbnl3YXlzLA0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1
bXNoaXJuQHdkYy5jb20+DQo=

