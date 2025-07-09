Return-Path: <linux-btrfs+bounces-15370-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51268AFE302
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 10:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B0AE7B72BB
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 08:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1D827C178;
	Wed,  9 Jul 2025 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FFRN50iY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cWH1Zq/8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104822797B5
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050646; cv=fail; b=hVgyv8avfZokzvqR8RYd6mF7VXyrR1+1kGN6YTbHb9IAr/o1kG/vQuNSQ3xkEgZg97u+OzK45cfdS37mbjMtL1KDeKnci/7WnFIjkSBtTBhh0aiotFO6zyod+glHvx2CLlvQg0hyWToxlwJBSm7G6PZsfAHVwPj78pUZz9riFCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050646; c=relaxed/simple;
	bh=zrEi7k4r3bmz1n1Tf58CwfLL6ibIPSub8xIduuz8kAg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VdQpZgvVCjnX4HHSWDy3RBKd4eZ0dY+S/q35aIMvvP57xQhY9Mekld6h+cRSUfBIC9ws2iy8LQitMo8Eaku4aF+/zIROeYvDPE+4AVjJwJ3OIDe79EIpvEN7zDE2uLcVB5C7V1DoKt8ZIbeCq9/lXInWo5zzIKfJySgKkB12I6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FFRN50iY; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=cWH1Zq/8; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752050644; x=1783586644;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=zrEi7k4r3bmz1n1Tf58CwfLL6ibIPSub8xIduuz8kAg=;
  b=FFRN50iYQuaYRYbSuXns5syWRvW3rfFKeWlOxeFuxDMwWop0d13c3li0
   mp4eKZ1Ga1ZqPz15kS2eH0HGH3nEn2PwW8wml8Ob5ZRoZb8bWhYsn/M+0
   nSVacXtPTmPIxOUiMl5wdnsT54LKPr+Bu8qpgrejAUMFf3YH4V3/rhBva
   Lzoc3qSG995LSKVaHnDA7YLtuFpcX93PdvTkBayNzV0LqNljYyYXrRDjT
   1mpOKP4dA6Z3/PVs+ZEkPVxAiez1cZR+HKzykNL/0EK2nrTUxojLNBFFj
   +bQHlkKhesynYLnZ96LDVH9O08GcoJkikzNb4t4YmtZ8evKJvnz5LQzl5
   g==;
X-CSE-ConnectionGUID: XaI+jza1TkODk6S/GtIJHw==
X-CSE-MsgGUID: Tn69G5mmSGqWgGHbjR6rlw==
X-IronPort-AV: E=Sophos;i="6.16,298,1744041600"; 
   d="scan'208";a="85668955"
Received: from mail-mw2nam12on2052.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([40.107.244.52])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2025 16:44:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymP+2AsnUGup84MdP2AVEGwNGHvhnJaxhS0I/u7FPy8+DeLamOI1NlxPnBweC5mWQGSDbP5/EyHoOKgxWpilW7emIHAwqdULlhBfkv+e+vEp/oeaEMyqTmYC7HHBMjnQY2W+UntpQmPn4B7yka4MXUgeRbHJWJ6fNGTTbViV8k2O6Y8N1jVS1CUYBD20njIwuT+ZZ2Zv/dK6qdwiSpi8ZViB7wOROnLOtPXMN07DG87mbq0eWqJOcInTyHq2nwabmDfUEbzH9rLLYYMe3OE0sjOXNa7MyS9S1eEYSvoxKSScMn4iq3I+nDS9FayawJsdtbOzAHR7HsrwkqUHIi+qEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrEi7k4r3bmz1n1Tf58CwfLL6ibIPSub8xIduuz8kAg=;
 b=s/uIRYk2d+nyOfn509QJqRSW8ByiX/ibMlLnohX3wgyoMbdsy8a3K/YPjEjJuPG6CliSvD+zGlHfkSGRgWlab1IFBWLoD1x8Etvb5wqDEap9qpRL2EloqmI1ooGy5R4dxcTgBUODKKKHh+I1GP+we3rscfQ1XVltpAl8jd273JbTL47q7uyRQWnRzNlcbsPtNPsYPQeQcUbeFYVKmtfgOJOOS0jeGiBj+/yyJRQJc3Tc7my3sBnPK/1KDLyAd1vy4HuQBmxXW2hGtSnCOAEZecG4qd8+RvTzoGtP2WVZ1/M9HjUP/K9xS1PJTQLpzxwL/hpDcArAe39mv+us76p7bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrEi7k4r3bmz1n1Tf58CwfLL6ibIPSub8xIduuz8kAg=;
 b=cWH1Zq/8Ql/+l5rJFol1Fnzu3STiFuq5MKAdmgIydBTM6kKYrbYSeLizpHMXfPmPFLezcXj6Zzn+W+SvoHpYCpIkTjZFYQfnG0VPKnAgzObzgBy3+GORfVh4ulFrDnGws+eub+p7VgrrYjeolgwZcFICRsxkkERDQHxTCXmKEVg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7470.namprd04.prod.outlook.com (2603:10b6:a03:2a1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 08:44:01 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 08:44:01 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, WenRuo Qu <wqu@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] btrfs: do not poke into bdev's page cache
Thread-Topic: [PATCH 0/2] btrfs: do not poke into bdev's page cache
Thread-Index: AQHb8IbWqC92CFPqaESD+dF/YwAuerQpaVQAgAAM0wCAAAQHgA==
Date: Wed, 9 Jul 2025 08:44:01 +0000
Message-ID: <4d1fe325-4b7e-4d70-a076-8546902fb84b@wdc.com>
References: <cover.1752033203.git.wqu@suse.com>
 <d3fa291f-656b-4430-923d-567208146302@wdc.com>
 <68c81f63-d7ca-4222-948c-36b7e5c863c2@gmx.com>
In-Reply-To: <68c81f63-d7ca-4222-948c-36b7e5c863c2@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7470:EE_
x-ms-office365-filtering-correlation-id: f00ec3ac-b14d-44cb-b033-08ddbec4c0d6
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NFhpS0R4ZXFlRHdleXpZYUdrV2hVaTU3WDE4eFMxWEFGeFdDZDJNbzRrM0Fo?=
 =?utf-8?B?aUV3TnFocXV6OHRCenZhU05qL0lhM1hORFRFdlI0S0RnOTRJd3RaQXlheldH?=
 =?utf-8?B?SVVocklQamtRNWpTRG0ydXRST25LWTNYM1NuOWhHNzNYYXZPOW10MkxWejBB?=
 =?utf-8?B?Nkdpc1JidzBVVU1IbTdJR2JpdTduVXRVWDd1YTNWRkt2cnBaQTRnNzBDQ0xt?=
 =?utf-8?B?ZU9XYzRpNDlDaE5YbFZGWTNIT0xOQTYra3lKK2dtM3BJOUtaZ2FDTXh6dllL?=
 =?utf-8?B?NDVjd1RFd2JtRXJGTjdpODNxVjZpbmlRRkNVb09wRXRoTVNHQmhySXVNZFNL?=
 =?utf-8?B?Qk9Sc1ViU1p6MlZGZlFsVXo3eVdRczBxVENaTkpjMENKY1JTYVZjeDRNdDZ6?=
 =?utf-8?B?ZlFmSGw0aENZMWdVNmFDUzNKQWQyVEhMWHZpWGJyL3RtTzk4Z0Q2a0w4M0cz?=
 =?utf-8?B?d3Q2a2E2YU94SEY3WXVxS0hWcGQ5WTNZWjB5L2pFTjBlK0I1RjhWVGdWWEho?=
 =?utf-8?B?V0JLQVA3ZVUybm9QdDV2VkJOMlhaenYxS1FnYWkwMTk0dzV5RkxHVm5mQmdv?=
 =?utf-8?B?a3hHUkxiVlptSnRPM2dYMjR4T3VQRHhoNkNaU3dvdXkvZERBcjFTMFlmR0I3?=
 =?utf-8?B?ZkU3KzF0V2RIbWt6eEdGZDVmdUhiQ2pWZHZVblpnMFZJQjQrQmNhdVJIV3Jz?=
 =?utf-8?B?Zkd0dUVmbVo2dHE5bmdzK3hsNk9ERGtMRndPRGdtVGRMLzErUWErUE1Nakw5?=
 =?utf-8?B?QjBFckhwd1FqaFQ0ZFd1R2lnZnJYUTI1MFdzSkpjS1hpeThRcHZoREk2L3Zk?=
 =?utf-8?B?TFpremRNNGt5SkZ0RlNnbi90Uit5aDc3OEYrTnA4UmhVdUsweXNteGppdyta?=
 =?utf-8?B?SGk2bUFWdW03WmxtSWcxNndBMHBMTm5wSlRYL3FkaU9sUnpxY25sYVdJY2pr?=
 =?utf-8?B?NzF1NzlRdXpkZzFXOWhEMXRyQjNTQ21vRmtxd3MzZWhIYVFLdkpVRi9aOHlG?=
 =?utf-8?B?anUyaDBaVW03ZzN1TDBHVXducUdQY1dQcXFpbHI1R2hiYlJtbDFyMDFIWlU5?=
 =?utf-8?B?R3V5b2VkOTVkcDFkU2lDMm03ci9NeERNeEQxcEZwaFcycDN1bGd1RFdWdnZ5?=
 =?utf-8?B?akVFdzlSME4wanc3UnpaTjV0czhYQWNSTW1ZM0R0eFJOQ1ZjZEdGODkwZU9T?=
 =?utf-8?B?Y0pqZGJQamVxYnB2L08vekhEWTZORGM1VjZtVHRtYitPS1dJOFp5YVRTYjVI?=
 =?utf-8?B?S0lQUVJiTzRGZEd0UzBuNWE3QVpla0VrNVVFTUYrRUhRbEJ5eVg5bE41M1oz?=
 =?utf-8?B?SWdwelQ1OTBCMXc2c01oc043OHBqVVFYZHoyNFlzenZHMWR5Vm1PWHNxaktr?=
 =?utf-8?B?WjV5dlc5UXBkUnFYNkNXcXhsSmN3MEplNWxRZnFnOHBOYlc4NjR2bkx3TmRQ?=
 =?utf-8?B?T1ZodUo4N3FZNVpLV0dBdGdJWDdwQ0ZrMjZlK2ljVHhEbVFRbHhMTGw1UFR6?=
 =?utf-8?B?REVoZmcxc0RYQkYybTBWcjFMUTYzQVF3NjRONS9oRmpGUDlFc1J2Tk1uRWps?=
 =?utf-8?B?WTdHNFR4MmVHaUpRV0F3WEdvUHQyVW4vTkdYdzdEMEtLVUZvTWZSdGdBb25T?=
 =?utf-8?B?emV1Vk5sRGJacndmK0RBaEpSMElYd3dVVkk2d3NLV29MaVYwVmlUdTJXVHpF?=
 =?utf-8?B?WjZqWElXWDZmelI3QVNTazJwRERGWWJGdWxVVHAzU2RPTlBQL3VJTy9UZUha?=
 =?utf-8?B?bVh0cWtKdU5tRnRYVm1KRDZ1eUVVN1lBL0s1UUc0Z251TERGN3NidGFzbEpx?=
 =?utf-8?B?Q0loc2Z6R29pMTlIR0JvUW1SMTl3ZFpvVUdSME1qTnZCK3NIUDJWa1FhQUYr?=
 =?utf-8?B?THBFSjRZS29kOWM0MndTbVNGZEVXdVFhWndHTEg1azhZWmh5YWtRaDkzUE1Y?=
 =?utf-8?B?Z1N4amFqZUdXWkxqdUw1NGdKbnEva1ZBOUVPMlJnMTI1VnNDbm9ucTEyR1E0?=
 =?utf-8?B?WGJaeUtIcE1nPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ni9kbFJpMVh5NTdna0RSRGt1ZGlORVR6TEFWSjhUeEgzTS9ua053NVE0ZCtS?=
 =?utf-8?B?YmpPUXVJMmlWcUY1dnVqellQQm5TSHNOT0xUZCtBVzlXQjRNTVY5OWRCaC8w?=
 =?utf-8?B?djdWSm96anpwODI0WTI1Wi9ZUVdMV3VqOHZRd01qT21SayszQkZtSit0TG56?=
 =?utf-8?B?M1JkZDFPdkxmUCtYNnlRM3hDQnNsODNBbWRPOGxlMnhldWVUZm91M0tkS1Ay?=
 =?utf-8?B?V3hxRG9kbXBmeXg5Q1QwODhYOEpzSHozN3Z5OW9QZDNwSW96UURrUzZoUVhC?=
 =?utf-8?B?THdEM1dpK0ZQbHE2Wm80OG0rT2pud1VoelF6SWZnRzM5OGVYc3BxdVJqdFlj?=
 =?utf-8?B?UldLN0JTRHRBR0Uvcko0c29zM1lkcVhNVnRwMGZvUWxCWVd4WFJpTVdEaDRY?=
 =?utf-8?B?SU5CRVQwaDc3UXlKQUV4OEN3dGFVTGFzVUtPb25BWTRveVF5UFY1VEtzbURO?=
 =?utf-8?B?bWZtYmJtL1JlQVBBVkFjMzByaGJzeUVoczBISVJ3Q05vZmNpR0Q1SkFGcXI1?=
 =?utf-8?B?REhuQnNXUXVXZ1hNS2luOEFLQUFUR3hCVWpqMGJBbXh2MEllTXpzNDlXZWJN?=
 =?utf-8?B?S3UrWnd2SjZac3NoMlppQXdtcDlBOFFwZEpZZ3IxbEZ3bW9xOTVpZ3Z0WFlB?=
 =?utf-8?B?WVY3THFSdHhGVE1BdWR1RG4yUEpvclUxbXQ3ZnNXalFBVEQ3eURIK1orcFJp?=
 =?utf-8?B?T1lhamZZNXRQMVQ0N3c1bldMMDh2Wk84TjdXZHNydndqMk95M1pVV2ZEUGo0?=
 =?utf-8?B?d2JqR2paREpzRFhwM2xVYXFycHFheUhxZ2VodDR6Tmt5ZkJUdVFUcEVVQVhW?=
 =?utf-8?B?TDl0Y1NQMm1teFNMKzlqeFBlV1NTVGdIZ2tJQk4wNThZSjNGSHJlRnYyTndV?=
 =?utf-8?B?b2NudTlidmpoSjRKVDZIRklsSzFGODErOFcxbGpnTnVWTXpjUU1ick5abE5h?=
 =?utf-8?B?dk1RUEwwbkU1K3pNdFhmQmpmMFh5Y0grOHZKTWNjNGZINDRrR2pXYzdSRTVq?=
 =?utf-8?B?aCtUMFBZbXp3ZjdWVFpiNGF4dWRXU0dTMHVqOFR0VFpGQiticEh4U0VNZk5D?=
 =?utf-8?B?bUVWdFNWeTFjbVA2R3E1R1dHczZPZU1OY3QwTXFhUDVtelhZbjBwSWdIVDJP?=
 =?utf-8?B?N2dSWStINGNrTWJ0NjdhWXd4VXR0bmszdjFzR21jR05OR2VmT3dWb1NTVGlY?=
 =?utf-8?B?T1dJaFg2bVR0OG1TSEZ1eGRiejNoa0pyZllGRnZBSHRpQmpncWlxbVRRdFI3?=
 =?utf-8?B?VWpiMXRUc0czR043WGxxYW42TWNuZ2xEcXZIWXNqd1FTRFNsNi80MDQxb2Ir?=
 =?utf-8?B?eUFiOEdxaG1kZ0VZeGlBZEk4UFF3ekNFV205dUhxWHBsWVFjelN1K0FadUxO?=
 =?utf-8?B?TkFEeVJhN2tsZXhLV3IraUNTY0YwNVBrQjh6aVIvMFB3R2RWR2x1ZWd3dWgv?=
 =?utf-8?B?bnRDRzlDVlFOZnFHNWFYLzNwTC9TTlJpZlVKVzluMExoTU5ZdGxyb1ViSTVG?=
 =?utf-8?B?QjdyZTNVUzdVenNXT2wvdzYrMXVoWXhjc3pGUXNqQ2MrZ3ZzM2xiQVArTmZI?=
 =?utf-8?B?VXFLQUw5NWZBa2xJRFN5YXZ5U25HQmRQYi8rWkFkTUE2eWozcFpra1V5RkRB?=
 =?utf-8?B?dGZzL0JWS0NjV1VZT1MxOER3U0Fkd3FHejRHbWQxUG8waGVEb1hFeHlRRW9V?=
 =?utf-8?B?T0RtUzAzdCtieVhNNGl5L29DL1BJSGViellFa21RWEVHUHhhcmNMSDFCTzJo?=
 =?utf-8?B?azZsWjg5dVY5ZGJXVVNRUzdYQnBwcUZ3Rmk4SWw3TExMMFJrQktCVUhibXRE?=
 =?utf-8?B?QUhONjd1NnlkYXJ2aTgyUUN0YWVENHpDODRVVXNnSUtqWTZJZHZlR0doYzlk?=
 =?utf-8?B?dm0wOVByZjJmVmVqb3VFK1AyN0FEV29od1ZVeTFjVkJSNlR3QVpmYjRKb3Nn?=
 =?utf-8?B?YVM5bDZQT1RwR0Y2eVBPaVVpZkVTWHhrRzYycVg3RFRKQkhVN0RMMGtERmxQ?=
 =?utf-8?B?WkF3MXZmNk9wKzhJQy9Famp0VjJxWWhFeFhGdWltREpJZTlJc2czOWhNQzdT?=
 =?utf-8?B?RVkxM2JCMzRJUzhOWTdmY1VDTWF6aUh5N2NTY1BXUlBTUExUQTQ1OEhZb0Nk?=
 =?utf-8?B?ZGpOOEVER3ZIRnkwYjN3WWdPRitXc3ZQbzRRK2FvZ2V3UTREbTE5UVAvSFoy?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A73DE1ED52BF52488B05AD6E62F6B074@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D16yuXi8crIyVWbmnDD/S2JU5ATStLfiuCAmXVwmd5aOkot3QmGanDVXQl9FlaSz/NyId5ALqgM31wLaMtsh0Cp6HSmhYljLtpErpt1YpjmcUQsDDWCxV8qkyHGPC9VgncDKT/4uiA7yQIq2IEZBMBaN5O8jqf42NSseBvBaMowrYGvFerD3CRAZqkRQgmiGH15UCjvtRY9NlN9tXV7KlAxv9vLNXhRe6KJe6msoE3bID2X7x+2MzWp9YQZ7V6YuXWu+BCeajChPyApXZuRAMdz9pPb/6aQErdgNdnqf60OvQVPrbmlOqhsxg3z+lnIYb3RycORBjv7bVL/G4yJ7eI+tDnfs882ec3Ks3nSjYMXxGsVqpDQvToWPKyJrUuuq0pVoOBntKfHWRGnXZNyUqJOy0Y2k98cHyDckBQCqegXWuaT6xk/hNLJ+PsKqMnqVeVbGHmqCKHLAburXOhepo0QKDF8Krx614r2/ObVPq3p+xZwQvZy9x+wkQKh//mbnGTab8YcTMp1QNmLIKhnxw4BmILCBX8UPFdd8MMevcS0EUxp/kcNmd8EY8t76TKAU+Pj2Wd3RMXuMtKwiHo7AaVcl9KEvtVgPE+I+fE3gLZDQhMuvr2LOmQPh4dEHAMTA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00ec3ac-b14d-44cb-b033-08ddbec4c0d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 08:44:01.4431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RuXq31jMCvr6TyGYteV5q4Ltgp5E/BJ3KV9JS5+HpYl3KJPDoYq7s9NDWpUc2gJQXylyRdUr+Rg2PKcY77/fv0fforJ7fMO97Fej9PftZNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7470

T24gMDkuMDcuMjUgMTA6MjksIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiDlnKggMjAyNS83
LzkgMTc6MTMsIEpvaGFubmVzIFRodW1zaGlybiDlhpnpgZM6DQo+PiBNaW51cyB0aGUgbml0IGlu
IDEvMg0KPj4gUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNo
aXJuQHdkYy5jb20+DQo+Pg0KPj4gSSdtIGFsc28gcnVubmluZyBpdCB0aHJvdWdodCBmc3Rlc3Rz
IG9uIG15IENJIHNldHVwIChuZWFybHkgZG9uZSBhbmQNCj4+IGxvb2tpbmcgZ29vZCBzbyBmYXIp
Lg0KPiANCj4gSWYgeW91ciBDSSBydW4gaGFzIGZpbmlzaGVkLCBtaW5kIHRvIGNoZWNrIGlmIHRo
ZSBnZW5lcmljLzQ5MiBmYWlsZWQNCj4gcmFuZG9tbHk/DQo+IA0KPiBEdXJpbmcgbXkgbG9jYWwg
cnVucywgZ2VuZXJpYy80OTIgd2lsbCBoaXQgcmFuZG9tIGZhaWx1cmUsIGR1ZSB0byBibGtpZA0K
PiB1bmFibGUgdG8gZmluZCBhbnkgdXNlZnVsIGJ0cmZzIHN1cGVyIGJsb2NrLg0KPiANCj4gQW5k
IHRoYXQgaXMgY2F1c2VkIGJ5IHRoZSAybmQgcGF0Y2gsIHdoaWNoIG1ha2VzIHNlbnNlIGFzIHRo
YXQgcGF0Y2gNCj4gY2hhbmdlZCBob3cgd2Ugd3JpdGUgdGhlIHN1cGVyYmxvY2tzLg0KPiANCj4g
U28gdGhlcmUgc2VlbXMgdG8gYmUgc29tZXRoaW5nIG1pc3NpbmcgcmVsYXRlZCB0byB0aGUgd3Jp
dGViYWNrIGJlaGF2aW9yLg0KPg0KDQpJbiB0aGUgQ0kgaXQgZmluaXNoZWQgc3VjY2Vzc2Z1bGx5
LiBJJ3ZlIG1hbnVhbGx5IHJhbiBpdCA1MCB0aW1lcyBvbiBhDQp0Y211IGVtdWxhdGVkIFNNUiBk
cml2ZSBhbmQgdGhlcmUgaXQgZmFpbGVkIDcgb3V0IG9mIHRoZSA1MCB0aW1lcyB3aXRoDQp0aGUg
Zm9sbG93aW5nIHNpZ25hdHVyZToNCg0KDQpnZW5lcmljLzQ5MiAxcyAuLi4gWyAgMTE5LjExMDMx
M10gQlRSRlMgZXJyb3IgKGRldmljZSBzZGIpOiB1bmFibGUgdG8gc2V0IGxhYmVsIHdpdGggbW9y
ZSB0aGFuIDI1NSBieXRlcw0KLSBvdXRwdXQgbWlzbWF0Y2ggKHNlZSAvaG9tZS9qb2hhbm5lcy9z
cmMvZnN0ZXN0cy9yZXN1bHRzLy9nZW5lcmljLzQ5Mi5vdXQuYmFkKQ0KICAgICAtLS0gdGVzdHMv
Z2VuZXJpYy80OTIub3V0CTIwMjUtMDUtMTUgMjE6MjY6MTYuODQ4NDE0Mjg2ICswMjAwDQogICAg
ICsrKyAvaG9tZS9qb2hhbm5lcy9zcmMvZnN0ZXN0cy9yZXN1bHRzLy9nZW5lcmljLzQ5Mi5vdXQu
YmFkCTIwMjUtMDctMDkgMTA6NDE6NDcuMjgwODY2MjcyICswMjAwDQogICAgIEBAIC01LDggKzUs
NiBAQA0KICAgICAgbGFiZWwgPSAiIg0KICAgICAgbGFiZWwgPSAibGFiZWwuNDkyIg0KICAgICAg
bGFiZWwgPSAibGFiZWwuNDkyIg0KICAgICAtU0NSQVRDSF9ERVY6IExBQkVMPSJsYWJlbC40OTIi
DQogICAgIC1TQ1JBVENIX0RFVjogTEFCRUw9ImxhYmVsLjQ5MiINCiAgICAgIGxhYmVsID0gImxh
YmVsLjQ5MiINCiAgICAgIGxhYmVsOiBJbnZhbGlkIGFyZ3VtZW50DQogICAgIC4uLg0KICAgICAo
UnVuICdkaWZmIC11IC9ob21lL2pvaGFubmVzL3NyYy9mc3Rlc3RzL3Rlc3RzL2dlbmVyaWMvNDky
Lm91dCAvaG9tZS9qb2hhbm5lcy9zcmMvZnN0ZXN0cy9yZXN1bHRzLy9nZW5lcmljLzQ5Mi5vdXQu
YmFkJyAgdG8gc2VlIHRoZSBlbnRpcmUgZGlmZikNClJhbjogZ2VuZXJpYy80OTINCkZhaWx1cmVz
OiBnZW5lcmljLzQ5Mg0KRmFpbGVkIDEgb2YgMSB0ZXN0cw0K

