Return-Path: <linux-btrfs+bounces-18023-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF27BEF745
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 08:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3E63AACC7
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 06:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336D12D738B;
	Mon, 20 Oct 2025 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MS/aG4ue";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VAqM9NHS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EA52BE7AB;
	Mon, 20 Oct 2025 06:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760941294; cv=fail; b=Ad0kIPbXU3mTuxgPOkRK9eeiYYdMp2QZQX95W19fo45z93k+PVtB16qd0I/ww7i7qmEmQmqtEHuN+2y9VE+vYXq4JwlLBm/Kr6djXaEeljmTdcW0hoibGEGYqDkhMkZr8HOl0gh2SUyPYqcrfpysl+AwDtj4Qpc1S5x6nBHkEZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760941294; c=relaxed/simple;
	bh=cMV/3ZFy5+AYCusl75fiU5OjWMmm7WprNPpqlxUU2e0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ez8nFwGUnt0bDoZFzuIRBVFu8BrGggjpqy/IIsJHflSxyVDn81OZGiITYNYXdNOZYfKWsnVM5OdGc7SFaGKjx2Lx08hQg9vbPgJekIISribW2jSKPvOKWHYkqKvwsTC7UXxZ1DiBw38r2wMZdMNASYZrMKz35CcxqPbvG66uGNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MS/aG4ue; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VAqM9NHS; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760941292; x=1792477292;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cMV/3ZFy5+AYCusl75fiU5OjWMmm7WprNPpqlxUU2e0=;
  b=MS/aG4ueZBaVKfR2GxwSN9/cmFZq8xUX2OsdDv2fWx6DReWz39goGy0u
   K1SWyaXNSx25LbWuakfUSw3CS8mdasRZvbEZ2VxYB4CiIxa81LuOncfuM
   UFm8zIexarao2BKWJT/SE2l7+ygyW7q7hT8MMUc8U1qwHVxpqJg9opWVy
   VAcUNGMDj79LcbgSVSa8jvpU26/2my6/9nNGmeh4uM4+T/EsHKRa6T4fN
   u2I8WQ0HNhidVJDmOzVTFcc1EdIiuZNP2kna1VKFFxlf3otUORIhpGDur
   3M3t8tG0Hxyp9fk0gwmzcNuB1V5XmfURVoL15ereQREOmD0HdxmZtU8VM
   w==;
X-CSE-ConnectionGUID: TR/4p0bjQbu1V+gYf91LYQ==
X-CSE-MsgGUID: tp029hu0Sc2KAgJHZ9pHsg==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="133452671"
Received: from mail-westusazon11012037.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.37])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 14:21:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JR0RjIA7PKDDCTlnAvIMFILKG6B1nPsf0RK81/Pv4YQ+B786ye9v4dmOzs+wXEF8Tmc4l44us1JE5AHNVb3qUeGCBM4y7ZzYPTzfaEhyNgs67K5y8mxB6NSxRRw1tQljWW74UAapLxB86TMbGIPqlT2B237BtLMmIiY1taStbSB7/hg7K2SUG4RI4NifOSy5yZpABoDKWTjNE/F6d9IW5SI30HoeyNhjtH3LizvHHzUhooiuZOLTPVJO3/ILHVON2L+xshGkEsqAYMj7UpOuHosylSYdiViBhnoCbCaYMGHBJF7/yEgDPvH0EgOdSP+IlUSJW1rWuu1GWA9WTXtidw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMV/3ZFy5+AYCusl75fiU5OjWMmm7WprNPpqlxUU2e0=;
 b=sC46z4GARWgqkY2QdROnXbkWZxkkDa4PAwy7cTH+WZf3Z6zTfY3rh4EWUXku2Ihih5aor7sdXYk69w91kaMZIrlLyjS99DoQ3Ef7HJ8nKOfePWGAYE8mNnAusUuBvVYMqfibpWdWDSGuF7wFZyXwZG9sGpP+zIELAZnWz5v98t4e8Wl7M14E9GwHZbgwepg8+YbM2k30k2qymSh2NbbLwZdn/F1oiFCLQHXqU5ZWBp3LsmGDv7L9NKZcUGUTa/FWCShMXoyYLHHf0Y6Qzr14u9Q3+dwVT67ZKnaB1zEhjy2o547H3Ys1efJtoyF8zhqMVcP9+qvWH3mUOcpOGfMMvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMV/3ZFy5+AYCusl75fiU5OjWMmm7WprNPpqlxUU2e0=;
 b=VAqM9NHSyHM/aufBv5KMsdNR4EM3C2pMemXe505FvibkJskJLa3TOO9KHev2dbGrKxNYDzkOK5kr6flwjCExonETUeLORyuCqxBdAukqyr6P6lzKrlhpjS1+d4h710IuvJE1DhUSO2Y6JZuEpRwmRhcKqmzUaV56hcn7ya6iuJo=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by CH2PR04MB6821.namprd04.prod.outlook.com (2603:10b6:610:94::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 06:21:23 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 06:21:21 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
CC: hch <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Hans Holmberg
	<Hans.Holmberg@wdc.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, Carlos Maiolino
	<cem@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino
	<cmaiolino@redhat.com>
Subject: Re: [PATCH v5 3/3] generic: basic smoke for filesystems on zoned
 block devices
Thread-Topic: [PATCH v5 3/3] generic: basic smoke for filesystems on zoned
 block devices
Thread-Index: AQHcPrB98rc0Re5Mwk+pm/9ca/TvXrTGsiGAgAEQ1ACAADAhAIACowWA
Date: Mon, 20 Oct 2025 06:21:19 +0000
Message-ID: <8253d6b9-e98b-4a05-80c0-f255ec32ee38@wdc.com>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
 <20251016152032.654284-4-johannes.thumshirn@wdc.com>
 <20251017185633.pvpapg5gq47s2vmm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <0d05cde5-024b-4136-ad51-9a56361f4b51@wdc.com>
 <20251018140518.2xlpmmqajgaeg7xq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To:
 <20251018140518.2xlpmmqajgaeg7xq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|CH2PR04MB6821:EE_
x-ms-office365-filtering-correlation-id: d5ed524a-8e80-4ba6-66a5-08de0fa0e32c
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|10070799003|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bjF2Z2hmaHRDWlJMbTlBTTM1N3hyb2ZxZ1Rkd2pDMk0rdWQzZ1g3L09ZMits?=
 =?utf-8?B?dmpSZzZlbHo0Tm1GS1d3bjV1RnhiN0NjbHNsdU82MDVaY3hTQlQyTFBiYnBk?=
 =?utf-8?B?amZrVzViSDZId3d6Mjd4VjRsbkVtNzhTckkwSUR2QlRCSnJIVk9mcDdpUm9M?=
 =?utf-8?B?MS9jVnAyTE5Cbld2M0lHR3h3L3prb252by80YldEa094bzdxNEY4WmpKcUp3?=
 =?utf-8?B?UHVaUGVaWHcwZHpDREtsZ2dxbzhQUEE3NmREWER1UURDclVKSzhYZmVkbXRY?=
 =?utf-8?B?eCtLclgxSWc3VE1CL2FEU3lUR1pTMkpZbk1STDBFQkQxb2Fxd0xvcnIvT1NR?=
 =?utf-8?B?cHZlTzIrL3RtLzcrUDBjVUxTSkF6TFl4MGxmTFZTQlM3WFNqZTVQL1dlUllj?=
 =?utf-8?B?RXMwU0liKzRWQjZya2ovZWMxTnR6UWxtRmlkTzhwblJGZ2ZSdk8ybTh6bkZm?=
 =?utf-8?B?OFpRcko5UzlNdyttMlpxMWVBc0JmSTk4ejY4R3RDMjRkYVhaTTk3bkFaRHAz?=
 =?utf-8?B?S1RPbW1OMW44TjE2b3R4cVY2d2U5cHp1OGE0OVFpcmErWG4yVk8wN3ova2Vx?=
 =?utf-8?B?TGRKTGpuOVdLVlBkQklvM1dFSldJU056VG1qU1cvdy9mYmNDcTFJelJ0T2pW?=
 =?utf-8?B?Z1RXUVZ5QUIxUU5Bak9mM2p2c1FOajYvQlY1MEYyV04zTFMzZTQ1WS9uNFBu?=
 =?utf-8?B?OHZJWE45Ykk0M081QXE4a2ZBYThFMXNoVVZaanBBelNzNnRRRUlacWJqMFdk?=
 =?utf-8?B?VGdIMUN0SGhHNEU1dmVoNUFWVmNYZm1zRk1YQmJBeFZlZUNSa0FOclhtRTAv?=
 =?utf-8?B?NjBrVUNNNmQ2b1lvTWY4cllCQUQxUW5DbmNxenU4a3hPR1B5Ui9GcEpsQ3NY?=
 =?utf-8?B?a0dDVUJDVi9mTkVvOGhxMTBaZmNCbVJRRUpPWXUwVFM1b0hjNXMvRmVBaTk2?=
 =?utf-8?B?c2ZTWFNNU01zdFlrcThNMUl2c2ZreTZLUnAycktvdVBaMjMwTFkrd3VMNEc2?=
 =?utf-8?B?b3B1cGRuUDY2MzdIWVgrZnlONkFJSHcxbXdYcXlaZ1o0d00vMEVJTWJPK1pB?=
 =?utf-8?B?ekloeHZ0QWxBeENYZTloOUFOZVNKd0NyTlgvdkpEZTI1OUdHT2dBZi80NnNO?=
 =?utf-8?B?djVmaWZJT3BhTVMxYmxwd2lqZ09NVXArSm1tQ3RmSDFXWWxmTDBsS2lzRVFT?=
 =?utf-8?B?MldDNzRJbVowK2RSWmxVZUtsQ1JOOTdFSlo2dTg1WFJmYk9BYVBDZDc3c2Ns?=
 =?utf-8?B?LzVmemFFaVRVRFRZQXkwZVl3bTk2Z0JIbVpuWW9PcUJYQWRDWFlEeklEQkN4?=
 =?utf-8?B?NUl0ZzNmby9URnpCSHRZNjZUUXBsSWNZMlFOd0w2VkNuZXRWQlV3bERDajln?=
 =?utf-8?B?bEpQTDZabHIwcTZRSTNacmJTY3cxMXlCK1Fka0NFWnlKVnBJN3RPYkJHQTlB?=
 =?utf-8?B?OVJtWFFHUkRzTFVxSDV0QnQzTnRoT0pKaWRGZC94RGFuZXdtQVFiVFczUi9U?=
 =?utf-8?B?S28vUEtqSk9UcUlRU3RFZ0tFRitpNmIzVGFkRHhacUpkcjFBbzRkVERNQ0FT?=
 =?utf-8?B?SnovT2d1aENjUFlsUkd0TnFhb0lDNmtlcTIwZEpiVGtVMDd5QUk5bkdlcTQ0?=
 =?utf-8?B?KzFLbTNnTmVoeGdNTDBRN21rdmtRZi9tbVJVYlowUElRNWM5RFZrak1wYUZE?=
 =?utf-8?B?djExQy9jRnRCYmhQVDQyWGh0WURiK0pqZUVQcXBLZDNYeUhNS3B6OWZhaWo4?=
 =?utf-8?B?dTNVUnI5SDFzVjBlalJ4WjNLS0xZcEdaOTFzR1NKUlhZdHJ0aUJVaXAzRWtQ?=
 =?utf-8?B?MmRJYk5RTTQzeEx2NHc3K0s4dVFSSVRxRUJwd1Y4MU9jOHZZTjJzSTBiemFl?=
 =?utf-8?B?WUtvdlMydnRKWVpLci9BQmJaYlhDbXVmYTRMMmY2OU1Pek15T2FIeWpqMER2?=
 =?utf-8?B?S3BIaENmajdJSjljWm5WYi9SdUFneThKZE9sNUZMa25GcUwrZDBScVowWTRQ?=
 =?utf-8?B?ZFc2a1VhR293PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(10070799003)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WmRmNWxmTFdhVGs0eHJvdkszcXc0WTJ3S2VjZm1QT1dCMjJBUzQ4T0ttOEU1?=
 =?utf-8?B?cHYyVnVIUzcvN0FZUVVmNGJRTU4zOTRhSXZWazlHbE9mck1VeHRrcnI5SWlL?=
 =?utf-8?B?QURxYUdtUGZYTTY1ZnZXZmRaTmthQlNuRXVDVXhUK2VGN3N3ZFNWSGpWME5w?=
 =?utf-8?B?ckh1WHhIL1ViSHpPTWhXemlGZ2NuUS9ObHlHeWYvNEF3VHh3ZytXYkd5RjJz?=
 =?utf-8?B?UkxCRkhXVmVxOVFCQUhHZkJNekw4ZllidGJsaEpKN3JaZWYvTG45b1NvZzlh?=
 =?utf-8?B?V1JISXRocVEzNUNqSHJLVHdaZWRkUVJNU1cvRnBrc3RzdHJ1M0w3OUxFKzdB?=
 =?utf-8?B?Wjd5V2l5dDViTU8xdERhVGNZSXc4TFVwaEFQREsrak84SUdFbzg2ZzR1dHd5?=
 =?utf-8?B?MjRudDVDQ1VFaTVhMVJWMnE1dTJXTkNFNUpEc0pWUXk5WXlEL0Rqem0vZ2Rt?=
 =?utf-8?B?R09vVGFDNVJrYndlSlhyQkFWOHdTSUV5TE5IbTRwNXpVSWNLQ3BVT3RWMUFy?=
 =?utf-8?B?OEFPbEZFOUxiWUxQV0NpZThnL2o0eTJ2UTBncVRPSU9xemgwcTA4d280UTVm?=
 =?utf-8?B?VVdZdVRKTGwwTDBkeExPRjZQaUlQaTg3Qnp6VUxEZ3dPaFNEelNYcERLamRt?=
 =?utf-8?B?R2dOOFhpamZ3Rm9OV0o4eFFmVE0zSnJGc0NOQkNhWkNyUWZyU0dNa2xyRHA0?=
 =?utf-8?B?QjB1c05CQ0VXOFN4U0dqSXhmVWt6TVdJUURrdVo0VHNHUWJuOWUzV2VkTVQ1?=
 =?utf-8?B?dm9BWTZjSisza2tWenQrSkFHN1R6aUhCZHZuUXJuZm45N2FiMS85QnVTVjhP?=
 =?utf-8?B?RG1tZENiOWJ3MVdwd1NvMkR3aTNVdkpUQWM5Q1VCK1lvYzVGWnpkWXVVcGlr?=
 =?utf-8?B?SlFlZ1lndllCYU9XNWFQRUlxQklUZk9oSDVwQlZtOUdHMkFtWXJqaDFWZmNi?=
 =?utf-8?B?T25tS0ZqdlhMLzVkRStzZVNNeTdTRjN5OE5lWGxJOFB3ODlrNFA4SzVPRTRB?=
 =?utf-8?B?Yk9DUEsrSENtS0RaZXljVnRVTjdkVDhsTnF5dHZLaHYwZTVUcEpxN3pJeFg0?=
 =?utf-8?B?anVrYit0ZmRhZDFseTNaZnYxSSs0dnRwQitnZnc0MkNVd0NWRVpvYVJ0UlB5?=
 =?utf-8?B?V2FSNytXS3g3ZUZNc3p1bFJEOHBKQy9WR2J2QUhCWWx1QTZ3S0FXUDJKZTl3?=
 =?utf-8?B?eDBLZmNHdWZaeXVZcEx6Mm9LWWtKSzJ5TDM0YjR6c3FyRFU0UGpVQTZJZjVU?=
 =?utf-8?B?VjlWYlBPNU9MM2phdkNPMGNVWnFGbUFsbkFsc3paREZXaXcwZ2hDR3ZXZjJt?=
 =?utf-8?B?RkxZbDFDclVOOTBmMVM0bkU3TzVpVWEwUHVKamJ0WFZmcDB1QkZNdDBIaGtj?=
 =?utf-8?B?MU5qeUtwcFl4OHN1S0VxOFZPTm1IRXhCNXFiS1NwdXhmdWlnbXFLVTE0WjFI?=
 =?utf-8?B?U3l2UGpQTVdhYlNoZHFXUEJWSkNCd3U2L2liWmEyRlBJaDBpMm81RElabHdS?=
 =?utf-8?B?aUIvMjFKU1hBK1d5bTdOcHp2YWY2MUJ0R25VNzFBc0U3SmUyZkNKdXc1KzI4?=
 =?utf-8?B?R1kzTG5UUDJlU3N1WFNLVjBHOFNiWXY2MnJ5MHR6anAvMEFDc3JheTZLeDFS?=
 =?utf-8?B?N3pIUGR3czlhRTc5SXNQcFd6M3FIaEkrVThSMkxWYUNXdG9nZmF0VmhUdEpt?=
 =?utf-8?B?ZkhTbVN2ZGM3cXFUMFViSXBkVEFVNTZERHVza1dqWVFMUlJ5THVGSVJFcUxS?=
 =?utf-8?B?T3pweFJrdWRMT1RuWlUwUzd6TGl5ckhZL283MmxIWTdYMW5YdEdCTnoyZi9R?=
 =?utf-8?B?SlZ4ZytoYmJqVlEvSUViajQwd0REcS8xZFJ3TjZocllRbmJuVG5XOWZWSUZ0?=
 =?utf-8?B?WWNBTmVQci9VcS9uUUQ5UVZzQ0p5VjllbnpFYWRvbFpOUEZvUGM3b2FjYnZM?=
 =?utf-8?B?MnZXS1h5Z1E5ZzVKUWMzZ1pXbTlTb1dSSGNLYUkvZURkUjZTQStTUlp3cDZS?=
 =?utf-8?B?SEVnYVA1cTVKdVNhcEVOVkxRZ2Q4bWExRlkzY3RxcGZjK0hmQXZsZm0wN3hB?=
 =?utf-8?B?OFdCTGlia0QvTUJHcENuYU55aSt2OTlQbWVkcW5kV2NUS25TZEZ5TW5zWUdi?=
 =?utf-8?B?N3JraFQrWEhEWHcveTVPaUI3TkpkNmd5ZjVRenFFamovZGNvK1p0UytCYlpk?=
 =?utf-8?B?L2JWZy9LQ2tqTk1JU2ZoTmZ5V1NEaW56NjV4MTIvbVl4djZ0TzZvcXBRQktO?=
 =?utf-8?B?MDlBY0FaRTJVN0Jxb1IyNlhSazdnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA5F4F2473F2BF47BF9DFEBE10D6834B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oB17EPjMSQevLfyp8Ey9zVWkm+EzsLn73JUYUWYuUU2PF6mHAv1D0z2WcvAjnPphq5G24AkNGKeG1I1jEHVvPVU4KYi8jK+qlWyZPkoJDBjXEYVXLwmOttRdJjnNbaw7gbVBpwrWr8pQcmxrxGngldtjtcnH+ILmiPn8OWfB6LtSvm+duT/m0OB69uHp4XeaPBmt2VuWOQoh0c5KeQO+sdN89flpRn+VUdPSeiasoLjtVyt4bNtNuTUmA3gip1W82fS9nGmTPyGsySkiJFeAuN+tML13ZSa0mo7WnpUpSUH1UuYSVvXvzE938/S4PQzyLxUvR3S5aGTj8iPASnCGnC+In5GDG5f+c4N5+9drDm2Y3YbR2uwoEqobmDTHsSHECLxHHj7FkDjz4eniOGL1cnhUUSJwRsdOofxeAilIGaD7F1+G5qqszg2YVSUkbq71c4cl6ZdR45wXURVW+l2YgEhVOu0QsrbtXkJQczxqxaWJ/zu88U6YlRfP4qjeBPrGWa7gM2B714TvcCBJxC8ZO4zDHCtHg4IlBhtEnh3oQJqJWE13R3lpEYUu3QNwV2bEMU3SgvpjD+sFS1XyPC6kZHyi/SdSMpRgrMK1TowWxfiMqD3NXqZ5B3S+/bk0Vg7t
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ed524a-8e80-4ba6-66a5-08de0fa0e32c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 06:21:19.8282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LCBL4lne+0SWfae5Vhz8fPU1csRYajhg+xEqtw1wcFcFl7CJ8e3sCqCulkxOm4utcqelYsAAIlYBVvTIrNVOQZcsmfwburhrAW+vhfp7g1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6821

T24gMTAvMTgvMjUgNDowNSBQTSwgWm9ycm8gTGFuZyB3cm90ZToNCj4gT24gU2F0LCBPY3QgMTgs
IDIwMjUgYXQgMTE6MTM6MDNBTSArMDAwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4g
T24gMTAvMTcvMjUgODo1NiBQTSwgWm9ycm8gTGFuZyB3cm90ZToNCj4+PiBEb2VzIHRoaXMgbWVh
biB0aGUgY3VycmVudCBGU1RZUCBkb2Vzbid0IHN1cHBvcnQgem9uZWQ/DQo+Pj4NCj4+PiBBcyB0
aGlzJ3MgYSBnZW5lcmljIHRlc3QgY2FzZSwgdGhlIEZTVFlQIGNhbiBiZSBhbnkgb3RoZXIgZmls
ZXN5c3RlbXMsIGxpa2VzDQo+Pj4gbmZzLCBjaWZzLCBvdmVybGF5LCBleGZhdCwgdG1wZnMgYW5k
IHNvIG9uLCBjYW4gd2UgY3JlYXRlIHpsb29wIG9uIGFueSBvZiB0aGVtPw0KPj4+IElmIG5vdCwg
aG93IGFib3V0IF9ub3RydW4gaWYgY3VycmVudCBGU1RZUCBkb2Vzbid0IHN1cHBvcnQuDQo+PiBJ
IGRpZCB0aGF0IGluIHYxIGFuZCBnb3QgdG9sZCB0aGF0IEkgc2hvdWxkbid0IGRvIHRoaXMuDQo+
IFRoaXMncyB5b3VyIFYxLCByaWdodD8NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvZnN0ZXN0
cy8yMDI1MTAwNzA0MTMyMS5HQTE1NzI3QGxzdC5kZS9ULyN1DQo+DQo+IFdoaWNoIGxpbmUgaXMg
Il9ub3RydW4gaWYgY3VycmVudCBGU1RZUCBkb2Vzbid0IHN1cHBvcnQgemxvb3AgY3JlYXRpb24i
PyBBbmQgd2hlcmUgaXMNCj4gdGhlIG1lc3NhZ2UgdGhhdCB0b2xkIHlvdSBkb24ndCB0byB0aGF0
PyBDb3VsZCB5b3UgcHJvdmlkZXMgbW9yZSBkZXRhaWxzLCBJJ2QgbGlrZQ0KPiB0byBsZWFybiBh
Ym91dCBtb3JlLCB0aGFua3MgOikNCg0KQWggc2gqdCwgaXQgd2FzIGEgbm9uIHB1YmxpYyAxc3Qg
dmVyc2lvbi4gSXQgaGFkIGEgY2hlY2sgbGlrZSB0aGlzOg0KDQoNCl9yZXF1aXJlX3pvbmVkX3N1
cHBvcnQoKQ0Kew0KIMKgIMKgIGNhc2UgIiRGU1RZUCINCiDCoCDCoCBidHJmcykNCiDCoCDCoCDC
oCDCoCB0ZXN0IC1mIC9zeXMvZnMvYnRyZnMvZmVhdHVyZXMvem9uZWQNCiDCoCDCoCDCoCDCoCA7
Ow0KIMKgIMKgIGYyZnMpDQogwqAgwqAgwqAgwqAgdGVzdCAtZiAvc3lzL2ZzL2YyZnMvZmVhdHVy
ZXMvYmxrem9uZWQNCiDCoCDCoCDCoCDCoCA7Ow0KIMKgIMKgIHhmcykNCiDCoCDCoCDCoCDCoCB0
cnVlDQogwqAgwqAgwqAgwqAgOzsNCiDCoCDCoCAqKQ0KIMKgIMKgIMKgIMKgIGZhbHNlDQogwqAg
wqAgwqAgwqAgOzsNCiDCoCDCoCBlc2FjDQoNCn0NCg0KQnV0IGFzIHhmcyBkb2Vzbid0IGhhdmUg
YSBmZWF0dXJlcyBzeXNmcyBlbnRyeSBDaHJpc3RvcGggc2FpZCwgaXQnbGwgYmUgDQpiZXR0ZXIg
dG8ganVzdCBfdHJ5X21rZnMgYW5kIHNlZSBpZiB0aGVyZSBhcmUgYW55IGVycm9ycy4NCg0KDQo=

