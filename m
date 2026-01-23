Return-Path: <linux-btrfs+bounces-20939-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCbuNu4cc2ngsQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20939-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 08:02:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6904771556
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 08:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36085300E488
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 06:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA00B33D6D6;
	Fri, 23 Jan 2026 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JLRu2yKn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="goiyF1fF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC8033DECB
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769151472; cv=fail; b=jn711dQ9r4gJX4LAAzDh92uGf5pfug7qI+Dh/wjGzW0keAWbWs82XSo9+h5ShzxSM5nfEbOON3mZWL8FHSMyVJ1YbW5sSuB9b/XEm8jNxlQacOoU7R1/YC5rx0jIJMYsyQPDJaZ43YEDOwa+jczTsh0tplzn18UCWm9J4lGt9cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769151472; c=relaxed/simple;
	bh=jPSgR5Q5ePKQspSnK9/7k48jiCX7bP9MhOC/417Y8kk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DQ2cKEW61YZYXw+0b19Kj9iDD5C80gEXKexPteOF/vIW9Ta9Avas6lv3zW+CJMMAkQIMJZfsoOBCSR+FScHM75uYQjlQEJBGIp4+K1wHlOqTAYZtg5qDSF/nppLiXtbvDH6/pVosl7y66R5zv9/0JyHLxNZ4b6HPFD+oYnlXrb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JLRu2yKn; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=goiyF1fF; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769151469; x=1800687469;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=jPSgR5Q5ePKQspSnK9/7k48jiCX7bP9MhOC/417Y8kk=;
  b=JLRu2yKnrpyrku/sP63LDgYO2K81DitAFtCn5dVBrStA1ELPBL97cOT2
   xqtgPC/Hr1QbC5v/aCkfr23PE1Eud/gDfvucpWqmMkQcqQEePSGmvr4Q3
   4qLTBdgwSOlAK+eApeJMfSZ3XosZFignD4WlLQxBNq8u7356WfWa2og3E
   w3MvoA/Jydk0HD8tJ9EtYyFo3tLJASh3XLyl4OBYaVRErs/DtQ2yOolgS
   GDuoSHrUYV44hERfKc0J5AF2Q3zFKB9rBSLB5Tfzy7a/zee3k0Ppiim7I
   w7V2cHI6/YmlVhW1bC+GseuXIPGCEJmQ57SsZdgXM3ySLv98Hqe2lcdAy
   g==;
X-CSE-ConnectionGUID: d37pK2EgRjKq1hOlUV4fQg==
X-CSE-MsgGUID: kkU9UNf6SCSiMHbkTtXpYQ==
X-IronPort-AV: E=Sophos;i="6.21,248,1763395200"; 
   d="scan'208";a="138575753"
Received: from mail-centralusazon11010069.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.69])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2026 14:57:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHKPHpL8qjv0rW3INbWPWPI8a82z41AykFN8nBEeBgbZb7VV4Aa5mbVuaZmLy8qOPTOe2stBc0mPIj07IkxHUJHL32CC7nNtlnqyscLOdw+RqAxPpcIy7rKxYgKTx6m+A4bKfN8n0zFDL61l6HAwK7NQgndgfbsaOFT1LUyYzYTVUJHC04vaNtdSZyzGaKaRVSupBAxwzYWzt3nScjZJKJcP0pwOY0VGlD8kRFCG1x3E+W70lI6NvuaabF9L2QUWEfCc+P8qLSOmKjJADLhOZnSrsKdD23jQtO+tjU/TczXskZiT2tarva4QVs2oxvEj5t3mlxbdSZ7+KzFKswaPGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPSgR5Q5ePKQspSnK9/7k48jiCX7bP9MhOC/417Y8kk=;
 b=SnmwS8nwUpmEWPm4tZmUZO26ANWh1CXkSOxBgglBNTurigMoC8O22vk35mVrL/AmeU/OLhlM8QNyfmxeIqhAJnr9wSceNMTx+njQHrmSpUijcPV3AMGAHEMB1Fh2SOqedLAtYNYyx0FjdBS7DQayH5nr81Kl21e2MpiCTql3ORCNZPdycTNxgufEfNIbiBJgnZVDSHWlIR8Lfndy7xTv+arAlgw6rKJquyBmFfVECCmPDqCwbPbhu47z9pxyn3ZVIO6YTQn15r10ZsEIlDIjrKpbtA4KbFnoc+fuTOeVaA9Z1RflEaOEeFFBBllBubr26/HzzBYn5+SSc6zJFYoZ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPSgR5Q5ePKQspSnK9/7k48jiCX7bP9MhOC/417Y8kk=;
 b=goiyF1fFw+cUK2zoOlSyfACiY/UfNS1FH+1IndNq9p0NGFm19yoWLOphaatEZ++CA3I9hrJsTx60XRe+UHWdu9l0Z+qm6Hmzz4YxFaUtjJL8yR9Q9tJ36RUYUuN+1Y2kd054+ZZsjg1qELoKtRJZeIxjRV9qoBoV+h9As5BYprA=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by LV2PR04MB9787.namprd04.prod.outlook.com (2603:10b6:408:34c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.3; Fri, 23 Jan
 2026 06:57:46 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9564.001; Fri, 23 Jan 2026
 06:57:46 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: zoned: fixup last alloc pointer after extent
 removal for RAID1
Thread-Topic: [PATCH v2] btrfs: zoned: fixup last alloc pointer after extent
 removal for RAID1
Thread-Index: AQHcb0dWc3utNPP/00K2pPPCOaizcLVfjJkA
Date: Fri, 23 Jan 2026 06:57:46 +0000
Message-ID: <669aaa30-3b35-4b66-b7a1-b8733cc31458@wdc.com>
References: <20251217111404.670866-1-naohiro.aota@wdc.com>
In-Reply-To: <20251217111404.670866-1-naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|LV2PR04MB9787:EE_
x-ms-office365-filtering-correlation-id: a8a57381-93a1-4cd3-7ecb-08de5a4cb716
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bUhCNU9OS0ZXWUVUdkd0L25tRVdieHN6NFJ5ZVlNdlA4aFZvL1kxSzViVHV0?=
 =?utf-8?B?UWN6NVZmV1dadVhYc2dNZEYrV0p0aERYeGs0N2x4WUtlZE5TcFg5TzNhWFpv?=
 =?utf-8?B?MUlSQnk4cE5oeGZKdDdsb21SY21vMUdnL0hldVhhbHJjc3hOMTlYWi9iZTdB?=
 =?utf-8?B?WUxPZVU1d1Zwa0xFeEYyb2lNc09CVUJ0TlBIWTBmRjFmZG5QMFNtcnd1cEQ4?=
 =?utf-8?B?RTRpYUJJWG5sWC9CQ3FGTy82QzEwa25paGF1azhGNHpZNFI0NGtKbWV5MVcw?=
 =?utf-8?B?T3MvVldXaTRoTE1Kd0pNRG5aWnliNVNzQWlockp0VlEydmtKVkFkYU0ySnF3?=
 =?utf-8?B?VDA5bXNQMW54OGFBZUprdzVwalJTUnJ0dlFlaEQ3ajRoV0NEK1FGVmE1c01W?=
 =?utf-8?B?ZlJld1RNUzBhOHhqeTBBOTlVaGpSOHprTG8wZGlmenhOVUQwNTAzQjUwM2hv?=
 =?utf-8?B?MHRTc3NqYUcrMENVblNVVDRQSXZrS0VudmVKbmxpK0NoZ2hNb0VvYmtIQ20y?=
 =?utf-8?B?R2gxaFpwN2VrOXBIbFdaWHFZaHg3SisrWVB5WldRRUpRY3RyUWpiUjArYzZ6?=
 =?utf-8?B?ME45N1BQY096RjIzSko2akRRVWxxeVFveTdHNk5OTEtLMXQ4ZVU4M2VKWlFI?=
 =?utf-8?B?emthUHAreGNLYjlSSEQ5VkZaeDlZL2xXTDUvWDVZOVhYZHl6T1RXbmszSGJy?=
 =?utf-8?B?WGovTmtUWnFWZ3dCaEtoWGxQUW9ydmp0UjF1Q0F2d0J3Z0ZMRlpNcWx3aWxG?=
 =?utf-8?B?U2greGVqZXZtallXeVFHaVgzZVZwNDdwcnhwbHBqT2VhVW9VOXF4MklVaDA1?=
 =?utf-8?B?VGRUY1FoNEdadGlFb05xaFRnb2JrWFZFQ2hsYTQ3T0t3SkkwTnVJelZvQjNl?=
 =?utf-8?B?S29KRTlMKys1dEdqc2IvNUhIa0lIamxTbUhodVJhOWh5aTRGVG1DNk5KSWtF?=
 =?utf-8?B?c0JFVUl3TkZYUVE4RHpCbjhsWWZ0TGpxUW1UUFFuY1VxSjNCRVRodXRFVjgz?=
 =?utf-8?B?Z3lmLzlaaGVlb2swN2lYa3dBdXZ1aFBUYnVPOW1FNjlBbFRFc0hFVHJiTENY?=
 =?utf-8?B?Qm9PakorWTFXZUNrVlVNSUZ6WmR2SENOdWdCL0VRTW5EdWc5b1JMSk1zR0to?=
 =?utf-8?B?TGRsZjJLRHlEYWhLbmZTRzdGTmp0VGJLS3BYbDNMejcrYWNpZlRFdDZjNFdv?=
 =?utf-8?B?THNIaTFDa25DeDViU3ZlbFZmQVd6ekdTcEFBT0cxNjNydEYwa2xaN2V0QzRE?=
 =?utf-8?B?cW5heFIrVkFLQTZnamlYajl3WnVxWTZESnF5OFhiQmRLdnJjN1NPMEVrODFm?=
 =?utf-8?B?SVh0RkJpeFdyRnY0NVZBWWlHaVpFV2pxUW5aaTc3OGJHTjRNMVpLOWJ3dEdN?=
 =?utf-8?B?QStaek1seFBJa3djMktFUXM4QXJlNHYzR3plaDhmUmx1cFVMODlsMmlWYTMr?=
 =?utf-8?B?UXkzclZLdi85Y1p1ZUdUK09FejZ1NVJOMlZPenQ3RW45a1lReFo0Y2ozSUYy?=
 =?utf-8?B?NkNpZnRNVEFBRVNud05tUlFUdC9Pb09NZ0JCclBsL3RKMm5LZndXSjNCUG13?=
 =?utf-8?B?RWdTTXl5ZmxRcTB5S0t6ZTBVeDFRUWVKcWdxYlFtSVdMZVdsV0JIMU9NK3BE?=
 =?utf-8?B?Qk4zQS9HNEhyYmYrVnNNaXhBcDF3WEV3eVhlSkZWTVpqRlJVVzRVVnpXVGor?=
 =?utf-8?B?Y2l0TGM4bnVHSEtZSFZ6bHdPQm1ZODF1clFPVjU2Z1N4KzloWW5iWXJsTDky?=
 =?utf-8?B?OGN0eFNpeXhaTHBGeWNYWFdyL2RyWmJBMmhSMVRFUDlsSFVNOExmOGIxdGQr?=
 =?utf-8?B?SnBsOThwNzg2aS96Zm5mb2duWVJKeml3NXZpL3lrOVM1OVhra2s4VHRZWGJ4?=
 =?utf-8?B?ZGwzcm50TVc4TytvYTN3OTBHREdpQTR3K1dYd1VzNWZQRXI0bTU3VFg1aGdL?=
 =?utf-8?B?UHhkWkZkbGViaXhZUDN0eEwwaXVPSmM4QkNyQzNFWkxOS1JvTWt0MmdFSnBN?=
 =?utf-8?B?QThzemtGM3laV2NjbHlNY25iRExjQzVLVG94amhrYjl2RU54T05ISk5VT0h5?=
 =?utf-8?B?cVhNMXVyTEw4Z1JUbS8zL1BPbmllRnB4MWc1Wm1WQnFoMWc2K2xuV1lqMCtD?=
 =?utf-8?B?ZUZSaUdOVGlPbEdEWWMySjM1SG00WXVxZXdVNHNSNkxtRjVZby9KMFNubTdm?=
 =?utf-8?Q?PaRWRiH8Sjl4wBjMGGcQwaE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dERSVkIwQitPYU04Z2lWcHVhTzJOdVZleFBsUFdudlR3ellJMjErcGNnd2hj?=
 =?utf-8?B?TDJ0enY4ZmlyQkRxTUVCdjRsMjNxN0o3eXdIMGJhdHhxVmRzZk11NVp1Y2F6?=
 =?utf-8?B?OEpkQXdrTUd3bHlONnhnVHhjMWdSajRNeXdpcXJrQXhVdk9ZK1lVN1AzNUxi?=
 =?utf-8?B?c2x6bjNJd0Nua3FpR1NmcFkwdUNXbWlPcnNLRDZJR1dYZm1KODhDTHpKRWEy?=
 =?utf-8?B?bHNJTkw5M3N1QnNzd0JoOEFGVC92MzVZSnhsSlJISnNjSGZhNnZSMlJ4SURs?=
 =?utf-8?B?d0dVMlYyRlhUL2U0Mmh0KzFrQzYzVmoxbUJ2djg2NjUyQzVkWVNIV1hHTkQ4?=
 =?utf-8?B?T2FkTUpvV3pHL3F2RzJBeUZ0WkY3UjRQOElVMTBGY3planlLbnBxdEZmRTBD?=
 =?utf-8?B?eVp4S3JYUXR6OXhXTzNkWU4zYjZPVWpHcmJ4M245ai95ck1FSVVLUEM4UUtw?=
 =?utf-8?B?dERrV0RVNFlqNWNycktpYk1QOFlzV2g2TWVIWDBxT1U3UzN3NEQ1WHlPODJu?=
 =?utf-8?B?UWFlakV5Nm85RVp6N2cyQW16a3QycWVBb0xoZXk5Z0FaeEtIRzhaZE5ON3Zl?=
 =?utf-8?B?N3AyNzVjZ2dyV2dvZXhJWUQ3MDhYWHJRaWJaSkN6ek15bEYvWG42WldiRWFk?=
 =?utf-8?B?WkdJNG9veitZWi9Qa2xPVTRMTm1sNlVuZmtLYWZnZHQ3SlBsVGt6a1JkdzM3?=
 =?utf-8?B?aDNvUHJHK2ZBQy9qTkx4Ly9BVTlCeDBwN1d2V1Q4UUwrL2VwVTYwaVpxSEZX?=
 =?utf-8?B?MlZvQ2ZrVjZLcFB1b0p5cDk4UEkxeFJLaWFRcFcyTjk4YW1uNkFuUUVRN05u?=
 =?utf-8?B?WXcwQk9WdjJyUmZuN1RYZkwvZXB6ZElUMkdNbTJZR2NkN201NjVFT0EzZlJa?=
 =?utf-8?B?Q08wNUlmSmVLaXpkd1JqdnJTZ1phQTVTME5KaXJJc2pVbVFyM25zektscjlV?=
 =?utf-8?B?RklmQzlEekY1aWYxelBud0MxbVR1RGpzaEYrSU9mdTQwRGlwWlZPTzBYWXQr?=
 =?utf-8?B?UDRvYUdWOXFLaTdZVjM0Q0Q3c1VuWHdnYk9NQVBDUVBwMTVHTlJYWC96WWJ6?=
 =?utf-8?B?cmh3VFc5VUpOQm82bmIvM1I3LzErdWlpT0kyZmRmZCtCWStSRzZod2l2aTIx?=
 =?utf-8?B?bGpYZk1oay83QTZuanY5Y3pXbVUwdTMzWFMvNjFtclhBRnQxVGV0SUtzaGxG?=
 =?utf-8?B?Q2l4bmRvYmVmVjlsaEdhQUlTa1VwRnZUYW5yMDVtR3FxL1BkWVhqSWhaWXRX?=
 =?utf-8?B?a1dnRzNEcVZZRzIvNm9YMUNBOC9Qdmx5VEdUelp0dmlIRUowZGZ5eHdsa3cw?=
 =?utf-8?B?K0RWQzZlVWVXMjRJMVgwaEI4Qmh4VVZZb1M3Tnh1eDlRMTlqbUpSR25PWnFP?=
 =?utf-8?B?cGVnTk9wWHBnRHcwMTNVMjhWVkhiT2VFY0JVSDlGb0xQalVXM3l4eTlSdkRj?=
 =?utf-8?B?cWtyVzFpSmYvNmtHUDRaWEEwL1U2NWZUOTJJM0t0TzIwQVdjS2FoYmRKZ3Nt?=
 =?utf-8?B?bHdKU3NqQWliT1ZOVlFSYnR6dC9KMVRtUWtJd2VJYW8yc2wyRjB2cUNGUjhS?=
 =?utf-8?B?UGJuc0I0QWJIM1VNaVVxc3oxODV2RHIvZEJxRUpNS0ZzRXFMSjVwVmltU3lJ?=
 =?utf-8?B?SllhemVMVTRJV2RhYTdKZEZjVkpMVXcxRS9mcXhxOVkvaktvTUJXSmV0dmRX?=
 =?utf-8?B?SWZnYWFRYm9XMlBhVUhMMlJvNmNLT3gvUzAxMWpXaVJrbzVLUjlna3dRSmlk?=
 =?utf-8?B?MFNhMlZvaGZMblRHTGxaZS9GRTBBN1NtTm1lRDcyTjVRWXhlaHdrcWZqdFFt?=
 =?utf-8?B?NXVZTzlNQzhtOStCdUZmWktXMURadEdJVExpRElqSFo5VllueG5Iam9IVnZw?=
 =?utf-8?B?cXRnQ2RudDVyRHhRVkJnYkZ5RHFSQmh4MjFjUzRVVWVnSE1pWTNTaG12NjI0?=
 =?utf-8?B?NGpKQ0VmQk8vOVVzcDBOWmhiQ0E4ei9GQmMxeks4Z0VGazBSYXozS0dtN2V2?=
 =?utf-8?B?a2pQSEV4aFAvNVJPNlU4UCt1SVFYNStGdHJzMEVmQ2FpbkRRQUhJQi90L0xF?=
 =?utf-8?B?RElValV0QllUQ0Z6WHVINUdiaDliMkpsWXJoRnFCR09ZUUZENDhhRFhrakI0?=
 =?utf-8?B?czVSUVhIcXRjUE9mK1l5Um95aXB0L1g2UERZbnlWUzFrVnphUUhucnRPdlFD?=
 =?utf-8?B?MFJKOVVFQUNIQWkvQ3F0MWl3aVRpQ3hmM3pzemtiNWt6ai9BdWRSSUQwbWxR?=
 =?utf-8?B?Sk9HckRRQW5iZ0VndVlFM3FhMFF0clNlWThLS0J6YVhXb2JxYUpNeXl0NFh3?=
 =?utf-8?B?NXRCTW9SU1FJVnNOYjdsbUg3T0pZaE1IYVhQZ3ZTcWwxa3NLNkZIZ1dZT1Ja?=
 =?utf-8?Q?6xI7/JvTl6dy//MorgowyBbGUvBREzLl6Fhgp9NlZHSoW?=
x-ms-exchange-antispam-messagedata-1: 8Kx9FxJZZUG6VHjoQAY/MGVElyAx+RhCLtc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C215E01035C0FB49BBBEDD7F0B6EBFB1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CHYu57svc7uWF+DGRF/gKhW8+tgDIJ2UAWWVMIXDQdX5Wz+FN2POg5UZsbgNweeSMakNEjXoJai0pZXOlSjhmdI7dCIghPYerL5mw6MnWGkcNcrVTQZnhQxnd3xIXS0cpj9m6oSKzzP/ayTSP29mW8Vs/GxjhQFD7ehU/IwFaeyqlhENDHYJMJGIIjPz/39m6rt5aCRB95EGaHmX9VM21jDnvv+xs3qQupHJsY81csVbtvEh+aABYxCiDKYdm9nIcRM71v3KXe+01+rkmHa9xwAjbvm9yoN1uLaLS7nRjl0OLxB/z6lYQPDLizw2aw6PFGYMGGtxLgcb0lv9rUMv16nAZwxBX+omx0rbZPqE2HlGPwWF3FjqtfLqRHzznXonnBETEq+Y7J60D6ekBks0nIVcIE/tNU3cjZHRnN6I3ysaJa5oEO1kxliRxehvE2vJjcuHuN24c1gh44tfP8SV8XmrByRqk89tb0/c0ybF1EVomRhZAyIk7ESte+7hXNExkMvEOUAP9E2L5Hx8C5mmwllWE18/xpfvHumqfyHjdLrS8syky0Cb66u6cYjQR5e39wnAaR2mhqQdkqGtuDXca3G8eGjSQwRh0+i/xIxVGU0jYXHOh0k2dB+lEz6P4XHL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a57381-93a1-4cd3-7ecb-08de5a4cb716
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 06:57:46.8721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 79oDbg+76liZ3aYm+bbJKpXROjei6DVF2+srXsBH8vjJs1ED5zSsCFzYbqDyTxfUHx2etoT2L6AC/dS/UMZaMfd5w0Mm8dasS84FqM57QaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR04MB9787
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20939-lists,linux-btrfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,wdc.com:dkim,wdc.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sharedspace.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 6904771556
X-Rspamd-Action: no action

T24gMTIvMTcvMjUgMTI6MjEgUE0sIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gV2hlbiBhIGJsb2Nr
IGdyb3VwIGlzIGNvbXBvc2VkIG9mIGEgc2VxdWVudGlhbCB3cml0ZSB6b25lIGFuZCBhIGNvbnZl
bnRpb25hbA0KPiB6b25lLCB3ZSByZWNvdmVyIHRoZSAocHNldWRvKSB3cml0ZSBwb2ludGVyIG9m
IHRoZSBjb252ZW50aW9uYWwgem9uZSB1c2luZyB0aGUNCj4gZW5kIG9mIHRoZSBsYXN0IGFsbG9j
YXRlZCBwb3NpdGlvbi4NCj4NCj4gSG93ZXZlciwgaWYgdGhlIGxhc3QgZXh0ZW50IGluIGEgYmxv
Y2sgZ3JvdXAgaXMgcmVtb3ZlZCwgdGhlIGxhc3QgZXh0ZW50DQo+IHBvc2l0aW9uIHdpbGwgYmUg
c21hbGxlciB0aGFuIHRoZSBvdGhlciByZWFsIHdyaXRlIHBvaW50ZXIgcG9zaXRpb24uIFRoZW4s
IHRoYXQNCj4gd2lsbCBjYXVzZSBhbiBlcnJvciBkdWUgdG8gbWlzbWF0Y2ggb2YgdGhlIHdyaXRl
IHBvaW50ZXJzLg0KPg0KPiBXZSBjYW4gZml4dXAgdGhpcyBjYXNlIGJ5IG1vdmluZyB0aGUgYWxs
b2Nfb2Zmc2V0IHRvIHRoZSBjb3JyZXNwb25kaW5nIHdyaXRlDQo+IHBvaW50ZXIgcG9zaXRpb24u
DQo+DQo+IEZpeGVzOiA1NjgyMjBmYTk2NTcgKCJidHJmczogem9uZWQ6IHN1cHBvcnQgUkFJRDAv
MS8xMCBvbiB0b3Agb2YgcmFpZCBzdHJpcGUgdHJlZSIpDQo+IENDOiBzdGFibGVAdmdlci5rZXJu
ZWwub3JnICMgNi4xMisNCj4gU2lnbmVkLW9mZi1ieTogTmFvaGlybyBBb3RhIDxuYW9oaXJvLmFv
dGFAd2RjLmNvbT4NCj4gLS0tDQo+ICAgZnMvYnRyZnMvem9uZWQuYyB8IDE1ICsrKysrKysrKysr
KysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1n
aXQgYS9mcy9idHJmcy96b25lZC5jIGIvZnMvYnRyZnMvem9uZWQuYw0KPiBpbmRleCAzNTlhOThl
NmRlODUuLmYyN2JhNmU5YjQ3ZCAxMDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMvem9uZWQuYw0KPiAr
KysgYi9mcy9idHJmcy96b25lZC5jDQo+IEBAIC0xNDkwLDYgKzE0OTAsMjEgQEAgc3RhdGljIGlu
dCBidHJmc19sb2FkX2Jsb2NrX2dyb3VwX3JhaWQxKHN0cnVjdCBidHJmc19ibG9ja19ncm91cCAq
YmcsDQo+ICAgCS8qIEluIGNhc2UgYSBkZXZpY2UgaXMgbWlzc2luZyB3ZSBoYXZlIGEgY2FwIG9m
IDAsIHNvIGRvbid0IHVzZSBpdC4gKi8NCj4gICAJYmctPnpvbmVfY2FwYWNpdHkgPSBtaW5fbm90
X3plcm8oem9uZV9pbmZvWzBdLmNhcGFjaXR5LCB6b25lX2luZm9bMV0uY2FwYWNpdHkpOw0KPiAg
IA0KPiArCS8qDQo+ICsJICogV2hlbiB0aGUgbGFzdCBleHRlbnQgaXMgcmVtb3ZlZCwgbGFzdF9h
bGxvYyBjYW4gYmUgc21hbGxlciB0aGFuIHRoZSBvdGhlciB3cml0ZQ0KPiArCSAqIHBvaW50ZXIu
IEluIHRoYXQgY2FzZSwgbGFzdF9hbGxvYyBzaG91bGQgYmUgbW92ZWQgdG8gdGhlIGNvcnJlc3Bv
bmRpbmcgd3JpdGUNCj4gKwkgKiBwb2ludGVyIHBvc2l0aW9uLg0KPiArCSAqLw0KPiArCWZvciAo
aSA9IDA7IGkgPCBtYXAtPm51bV9zdHJpcGVzOyBpKyspIHsNCj4gKwkJaWYgKHpvbmVfaW5mb1tp
XS5hbGxvY19vZmZzZXQgPT0gV1BfTUlTU0lOR19ERVYgfHwNCj4gKwkJICAgIHpvbmVfaW5mb1tp
XS5hbGxvY19vZmZzZXQgPT0gV1BfQ09OVkVOVElPTkFMKQ0KPiArCQkJY29udGludWU7DQo+ICsJ
CWlmIChsYXN0X2FsbG9jIDw9IHpvbmVfaW5mb1tpXS5hbGxvY19vZmZzZXQpIHsNCj4gKwkJCWxh
c3RfYWxsb2MgPSB6b25lX2luZm9baV0uYWxsb2Nfb2Zmc2V0Ow0KPiArCQkJYnJlYWs7DQo+ICsJ
CX0NCj4gKwl9DQo+ICsNCj4gICAJZm9yIChpID0gMDsgaSA8IG1hcC0+bnVtX3N0cmlwZXM7IGkr
Kykgew0KPiAgIAkJaWYgKHpvbmVfaW5mb1tpXS5hbGxvY19vZmZzZXQgPT0gV1BfTUlTU0lOR19E
RVYpDQo+ICAgCQkJY29udGludWU7DQoNCk9oIHNoKnQgZm9yZ290IHRvIHJldmlldyB0aGlzIG9u
ZS4NCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJu
QHdkYy5jb20+DQoNCg==

