Return-Path: <linux-btrfs+bounces-9074-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C83879AB240
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 17:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E953A1C214CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 15:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA40619E83D;
	Tue, 22 Oct 2024 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AJC5oh6Y";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XQmrFAMd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28092E406
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611483; cv=fail; b=ut9otFsOjwXuVloKrNqgQiql80k121dlGy0QVNqgD6cZ9aMV5M05TkPLVrotlK4vfldo9z1u5LLluKj548mNx9kY1vQhUjo+EgqNBjLTdICrhsOHm8qojOYS88G744pFuZFlVBngAD/Fl5K5WGC97RKXupI+Ld1krcsrf6NXEBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611483; c=relaxed/simple;
	bh=WZG58pj02OTVXPM8sZ7fpmQmWK570eDEWXdtF/RWBj8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lhqxar2M8NV1EEO00A2rtJLAM7ceUa4PeqBYf0hhpxJe6C5uYYAajlDM5Xmpu7O3aKBH3e2h1RU67JZe3OALrgFWqDAW7KPsXSn8TjfYcC85jY4JbJIDeqb7EHiEOefCifDoKmqIoX6Entk1kIUmwJnLW2PpIFK7oa99c35aaOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AJC5oh6Y; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XQmrFAMd; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729611481; x=1761147481;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WZG58pj02OTVXPM8sZ7fpmQmWK570eDEWXdtF/RWBj8=;
  b=AJC5oh6Y0A5KIgowR8P7r3VgQ8P8V/FcQQOSVP+vpTF2KFJo6MXzAsU+
   K/Hs0yFQZXac+2cFthb/qNhHQKqNdod3ulRp33aP6nkzeD1NOEsqThIR7
   5dp6mwC5qRRyO0gTJCoJMKYyDl0xAtKrQTUxVbBRM9vKwBrzM4nHyh3vk
   42Gz3kNIcxyqogwfG5TuE+oy+VaRUO4Pxu/DQ3hzT8oHBQ3HSy//IGwCB
   NJYAUOb9mQaT/1f2FTlKuute7eZeMVJBntmqFLqTveIqs7LSjuliOqhgk
   5SZXj3O+drhA37Qo2/uamsRWqlM4EcePP+73ePYzR5aquGKpA0IcL748v
   Q==;
X-CSE-ConnectionGUID: FPG027poR6q/jSo/0BLtoA==
X-CSE-MsgGUID: qmClr2qiStCbmKOSnTw0Fg==
X-IronPort-AV: E=Sophos;i="6.11,223,1725292800"; 
   d="scan'208";a="30568776"
Received: from mail-westcentralusazlp17010007.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.7])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2024 23:37:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqvuaXucxK5UhuODhphOXS/EisK7L29b/kxPiYilzabJQJfVNnboxRC3TskCsG6HlKqILV44QnOQgqFzqqE/PXyjyREHuWBph6O5rWurLmmEtS34kbqmDY9cofnSiNtwIntZNP8ORzmcnO63qklReW63nZ8iIOC+8es+El3u22IhaouB47BM9W/GyMV6dT7aAJ0HS2sdC4PBLN0L9Ak1sOYoj3GFI8ZTabNzFPoJz00Vo2JZ9s1s2G0kZ4gTbgIHzEENbay0ASBhtA1SZGKLrAZWe/CM4ziD+SHDApC/z0FbAcuPOXuFHKwIMTMzdYVth1EyfUex7qrYAkQ33CTl+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZG58pj02OTVXPM8sZ7fpmQmWK570eDEWXdtF/RWBj8=;
 b=AY1hQ1VBHIkakyRIYbSGgkOnGOthlcXfRB8yLnEU8aqcULshV1VMq2zqB0N2E/2RgN5Vtb26F4LQjSWLCUlvo2IrRynzEz+eKyNmVjD+vyqQbrnUbuCyFj9V7myQGcB4zyti7DSm0u+j05qa5cy+pWjbQTWwDvgG8mLnr4i1EtACliZN1vfmkWjmplI4ELTFZQVdKozuBI5XFsEPX4PpMr5NduGCLeCJgMQ47LAQo1Xd6ejfrplH1glWxRW3R70KkaiorfTbsSISYEvjCdRoEn2E0ZoqGy1A58fcuTZ75Nh7F75R1xBhd2eX50JGXg9kUtAljXtN7bdu80NqICJRNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZG58pj02OTVXPM8sZ7fpmQmWK570eDEWXdtF/RWBj8=;
 b=XQmrFAMdOl42aPWiDnoEH/gu9GWocGbSQyf6oTwFcY4uBSTryF96SDEMCvHnXK60tUqKBHVqxbNM1dec92kLS6g3k5x+4J11mo8g7voQGcZVLRAVRbskoMSdQqUp6OsLdmXvclx5Sd6EsgzaPLG3bUA2eAy0MQ3cENQ/sns5RNA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6660.namprd04.prod.outlook.com (2603:10b6:a03:22f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 15:37:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 15:37:35 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Filipe Manana
	<fdmanana@suse.com>, Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v4 1/2] btrfs: implement partial deletion of RAID stripe
 extents
Thread-Topic: [PATCH v4 1/2] btrfs: implement partial deletion of RAID stripe
 extents
Thread-Index: AQHbIHOUlojwH3HzrE2dKsMLVW4XYbKS0nYAgAAdRIA=
Date: Tue, 22 Oct 2024 15:37:35 +0000
Message-ID: <0e990104-19c5-4695-bbdb-4dbceba80490@wdc.com>
References: <20241017090411.25336-1-jth@kernel.org>
 <20241017090411.25336-2-jth@kernel.org>
 <CAL3q7H45VMP=NeU7itO4M-T4m0kA9XYEsTkLttODy5W4_m5OLw@mail.gmail.com>
In-Reply-To:
 <CAL3q7H45VMP=NeU7itO4M-T4m0kA9XYEsTkLttODy5W4_m5OLw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6660:EE_
x-ms-office365-filtering-correlation-id: 47bc2843-2543-4d37-2026-08dcf2af73d7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bFM1aFFLK1BFMklDTFBHYUx3aXVRbWV1eW9iVVhoZW5CZ2Mxa0MxWUo2T3ZE?=
 =?utf-8?B?cnduUmV3ZEVtcG5QTm85ajJkcU5FQzNRM1FxZUdhTEV3UzAvT1VoR2gweFkr?=
 =?utf-8?B?ZXc5amZIRlI5dS9WbFRrY2pWWGNHZGpTem1EcllWN0V2K0VkVFhUTXMwNjZy?=
 =?utf-8?B?VnRQZEQ3aTBhdFFjMjJQU0NXcDRqWUw4Sy9zRWViWmRZT1RESytUZDgwckpR?=
 =?utf-8?B?NUdTQkRSQmVzY1ZEWUdZbkxvaXhRcUs5VXNmVkFNS2ZjRUdjT25SY3hRcXpF?=
 =?utf-8?B?Q1oxSVZnUmUwSTVUWWRNdTVFVHpkbXIwam0zcEwwbWlIbThMVEFjTzBsR242?=
 =?utf-8?B?eDdHNmQwS09LYkFsUWpPOUd5Y2l4Zm1tVnBBcU5WVjVia2JnMVdOZWhmN01P?=
 =?utf-8?B?OGdVVHBQVVFoQVZqTWp4Wld4MllHZUFJOVQ2WjJRNDRpbHZXamRXQi9SaWF4?=
 =?utf-8?B?dWdsTmgrVWNQVVU1czl3MWJ4eVhQZDlqUDNXbUwydzJ2QVRMMXYrZitQSmhN?=
 =?utf-8?B?OXBPZVJjcGV1NFJORjRhYkp4V1d6aG9sanFNUTRYbExsUTFCclBSeVNNWVRQ?=
 =?utf-8?B?SkErTVBCRWJzWHQ0QUwwVjdNbFFPREdLRXo4QVpLenZCRERTM1JZREdNdkRm?=
 =?utf-8?B?WVA4R2NlbzUzWTdSU2tnYTc5MUdPRHRIYnN1VTZMNm5EY1pvaks2TkQvZTcy?=
 =?utf-8?B?MHI2cjI3djZpY2c0YmdhQW9ONVVIOEN5KzVObGRzV1Y0dVBXcGp1UWkxMUZB?=
 =?utf-8?B?RFBacnJodXlkek9yRHVmcEVCK0NvWmdVVm1JWEpvRlYwT3grNjJ5a1lLcXNV?=
 =?utf-8?B?Z0t6YzJuRkNaeE1tRjZEdEZMbDViaXBsT1NHVlhBZzBTMS9Ub2dhcE9leDVw?=
 =?utf-8?B?ODZFM3JUb1ZRRlJ6TnlrN28zUEV2L0RHUEdiSk9FSmtZdzZMcHBxN1Y2RDlO?=
 =?utf-8?B?b3NGelptQ0Z0R01vdVNwRVBDckxJZFJydlA2R2FSOTltWW85M1UzK0s3NHBC?=
 =?utf-8?B?cjc0QnhzekNxcEkvaXY0M3RGUkZmYVJKRmJ2dTJZUHRRcXpSMHB0V09ldHU2?=
 =?utf-8?B?VEFKMDJUTk0xZFBuNlUzZy9KU3Z4ay9vcGpzSEcwTElCQU11c3dhektyc1B2?=
 =?utf-8?B?eWljUWM2SUsxcUcxSWc4TGpOVGdxUGFIK3RqVWdiaHZMUENLWDNWMEJMR1Y5?=
 =?utf-8?B?eklKa3hzRVI0dTlYTzR0OUtpU0s3SG5CcXM4TUpBVlBmd28vUkpDSXhHMW9w?=
 =?utf-8?B?Q0JLeDNocTJWc1ovTXNUS3VraDFHWFVOL0VJQkRlSmJ3SkQrVWdJV0dNclVv?=
 =?utf-8?B?L0hQQ3dRNTN5bkh1eUhKbTlPL1VJcDgzelJxbHcvVXJzV0t5UFhjdzQzTXU5?=
 =?utf-8?B?M1oydUdUY3FVcEpTRWZFWmRQdTF3UG0rUUtXQmFCMkRKZ3RDc3IxU1NZUDY1?=
 =?utf-8?B?amZZcmNSUzMveWcyczVjbUU5ZzR2Q2E3VjVQbzFjb0tCU1Vsa29VUkwzQ1Z2?=
 =?utf-8?B?OEJmcCszV09RRDZlc1JQMXk0ZjdiZUVRalQwbmpqQTZPRXREMW5nRjVsWG1S?=
 =?utf-8?B?U3g3RndrdVQyQXVWSjB4cS9GV2puTG9YNlFnbVpmM3NVdmEzdUVhNy9wVlJB?=
 =?utf-8?B?WkJwajQ5eTMxdzFhZnFHeU1rd1Ywek5rcmdJVXdmcFpTOHlwa2Z0SHNES3JI?=
 =?utf-8?B?aXFYQS9TT3FwbDRJc2xLcWFBUzdFdXlJdk1iek1ISlVWSi90R1pSZXVrZ2dL?=
 =?utf-8?B?SHdtNmhCNGxDWDdzb2wxNUd5QU05TkV3ajBja2hXVHhRUjVRcHNYc1ltdHVR?=
 =?utf-8?Q?P0QZeOy09jTFppPPbtLRtBTTQWItxn1vQkrh4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3V4ZnhoN2RYcmdleUZTOFZZcGNiZmxsODRiNE0wVmNMeUNrWlRGNjM3RUk2?=
 =?utf-8?B?YUNLY0l4aTNxVjl4bSt5c0UycGYwNml4WGJwMnRVUTBRaTJkQVNrK2VRZHdi?=
 =?utf-8?B?T2lFWHZIRXZ5SEk2N2ppYjdHV21PNDY3V09RNytkQnFFWGpMek1sZDlvbW8w?=
 =?utf-8?B?MVFKWlpod1lyTFRuNC9qcmluUDJMdDNtM2NyeGFqaGJDQmlyMXhvd0xmQlp6?=
 =?utf-8?B?RE9xeHVQVWdVbVlnbzN3aUtxMjg1bWJoTUY4ekJ2TllyRkdzRjlsbUI1azI5?=
 =?utf-8?B?ZlV5d0ZHZlVQVGRhSHhPNzl2MTQxVjArbnByUEZ1RjlnNy9uUFA5VUNwcmlt?=
 =?utf-8?B?QmcwMnNsMS9scHhoNWtySlU1NmRkak44ck9JQS9ETHFQRWFyQm9RSllwcDFR?=
 =?utf-8?B?L0FqelhiVzFuODY1U1p0Nmk4djMrTi9EbU5kcHRjc0htRHVDRWEwcFFkS0VR?=
 =?utf-8?B?aXZkcWJBVStKSlp4VGcydnVjZjMwbUREcmkrTytrT3VsQ3dqbUZVWktrUUYw?=
 =?utf-8?B?dDJnR1dTOXc4clhtYU1RQVJrNU1EcEZ2NDRWYlpuMnVxcFA0eDB6M2wyNjd4?=
 =?utf-8?B?cXVsNno0c1RWSnNoVURoU2xSeHZXRmF0bjNrSUJhUkE4RlBVWFN3dEEwZUdl?=
 =?utf-8?B?R0xPYmJoeTFwbzRqUXd1UGhxN0l4RTgyTWh0NGxOV016MkJsL2xDcnM5dWlI?=
 =?utf-8?B?Nk5LeDB6QVpQWmxoWUFTbmdqcDdvNE5VNXp5UW5RY2NJbFFwdGVhdTY4UUlP?=
 =?utf-8?B?a2d0ZkkzbnovN0ppTzl0YTkwTFFvOXlmRUZ4MmJ4U1J6bkU1UzZ5bDV2TnA4?=
 =?utf-8?B?NnpzY0MxS3RnVStOL1dPb1g4aFpHYmJBaGRIK0V1NFpEay9BakVxOHBmNExI?=
 =?utf-8?B?WHR5QTR5TWhVcjBoOVFMMk16a1VnTXFLTmxmV3N6TWs4UWRNcjJJYjducUh3?=
 =?utf-8?B?YXVhdGtkMFFieTkzYzFCNXVPSU01WFRkT3kxWlc5emlPWGhaMnUyZjhKNWpk?=
 =?utf-8?B?TU5vSTJ0ckx0RVd2VzV3Q01XTFU3Smdyc3pPM1Jid2Z3RnF2K0RoRzFrejBq?=
 =?utf-8?B?VU5OT0gyVHU0Z3F3RlovQ0Y4M0hKUWVmVll2c0FOZm0zTVE5RVM5OTl1MzZu?=
 =?utf-8?B?VGtQM3JBbjd3WHV3d1IwZVVjak9yOWNpZmE3YWdXWS9MNmwzdjBHanRnMDgy?=
 =?utf-8?B?eXFZaWI0ZmNYRnhIa3dNOFRXbU1paTdWQ3Bkc1lKYlY2b3JUZDBnZ3JaczNG?=
 =?utf-8?B?c01aSVR0T2hidWFNb2VxUG5jYytDZ0VLRG5KajM0bHE4a2tUUnJZWU5JZ3N4?=
 =?utf-8?B?U2pxZCttWWhzeU9jMVY4ZGw3a0NqdGZlZ1hXN1pHbmRtVXJxWXdCSXlGMlB0?=
 =?utf-8?B?SzlvbzFlSHVlbGVxU0hYMDY4QjhMczg2WXpBQ2JYZVZtdnhxemVYaTl2Q1pK?=
 =?utf-8?B?dVpLakxaOHNCTCtHOEt6Z2NyN052L2pGdzVqbXhFNU1vSVZuTXMyR1N4M1I3?=
 =?utf-8?B?SHpTU3ViWVIyRGs2Y2VwNHJ4K2tJRVVFQncwbUFPa2xxWHRlMThESmViazBy?=
 =?utf-8?B?bFlSdGRQVGJqVmpOaFlhQlBBSi8zL1FZekUyZEFGVG1lOVZVL1FZaEdOV0Uy?=
 =?utf-8?B?RExGVXdZOElDSWhYSDVwMFVNOHRZQURkeUszbm5kQU9pZW1qTDloTFkzcGJq?=
 =?utf-8?B?S29qNGV4UGMxekVRMjZzWlB0V1ByVC9mWFdDZFNwemFPR0F0bk1YTi9LNk1C?=
 =?utf-8?B?RUtpM2hzNlJOOExDaVdubDZ1WG9nU0tUNUp1dU1ZTjlkWFJCYlpGSFcreExz?=
 =?utf-8?B?RENUT0I5eUZwUnVHc0RaVVlFOXJsVlB3NWNSbWdVK0FEU2xpQzVORXdmc2l5?=
 =?utf-8?B?RlJTY29zZE5XL3VHYnlnU2pYYm9uUXQ4MzNoaGU2WGttYTFkdVZMSStvam5H?=
 =?utf-8?B?MUNrWEZmMytaaXYwYnd6WkVzeVNKbk1sNGlEby9nanJ0am9XWXFFQ0lDcjBm?=
 =?utf-8?B?bUJSSUlBTFMyRkRmc3FwbzJsaUoxMm5tUXNINWpGYkRrNVA0Y1J5QWRuVE5y?=
 =?utf-8?B?bUlBQWtlcGczZzlFdmM2RFkwWHJCdzhoS0lxYVpwNE5KakJ0Tmhvb2hxT1V3?=
 =?utf-8?B?WnZFdzZDVHBOQXlGS2VnUmR0U0MrQlZQTVo5TzkxTEh2RTB2KzBkSCtNSjhP?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65034EB02EF8FE44B907CA07FA62D3C4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zdem+/ePv0z+T/s1M6veuDJMmZIG9LCAIb7PVRPeQqhB8Z0oppbiBcUd/uSLWviX35QWrOo7/NrOXhJklLzGaKNczDClfUeeEO1lLGXGgXR4N9hUyUcFnZqcUPM+1EwC4kv/O94ccPE2cMIhy/uhdC1ticChEF8xCv3bYhzsuoJo6m80C78wbYbjjO+Xj6Or6MvuDQCvVdKMjRVqdnsGdWobS3Ytb/i24VmjFisvyWC2eY4eDwloyBq1d9uJCjTjNHCmFZY0N/OZ4S0dRc+jaAH0HRMPD//LZZisTLN2VKC8ACJ1vmGR6ailDO74xvat4E8b346fRKjq63nbd9DmIGJjMz72NhrSNdfzWFiIPKjQ42M3ydPtYXqFVh/ajM61Gv3XNaNSoXRRpBir/jE20UdCCQoXbwvpv1z6kGkM8c6WDZTMkJoUGXv+yjwNEYo83Izrj4Bh6NQTUAFAopNyfgZXkhGjlkdOfFQPiIXlnRHY8sdlZ70jRE7FhzseUusrC6ZPQtwVRt4YLHXLCN8VSkNfkdtEkSD27jQodikm1rJC3FnANHLLx5NBL+Udp9Vbbd8D9aE6YtBQrGUN7O4YziybigY9Px7FIzEHWBjp6D/Q+vR2pTHUkIXIG+amQuit
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47bc2843-2543-4d37-2026-08dcf2af73d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 15:37:35.6384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a9ZKqCQ+PfHCW5KjdqLwQGhg8AdiwiE6XChhEtFNw2sHh6om0wsE4jYN3FW8LQKMX/70QZdiu/+nm6ccnswYmpdPUqMZmnOYjg4idAcAIhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6660

T24gMjIuMTAuMjQgMTU6NTMsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IE9uIFRodSwgT2N0IDE3
LCAyMDI0IGF0IDEwOjA04oCvQU0gSm9oYW5uZXMgVGh1bXNoaXJuIDxqdGhAa2VybmVsLm9yZz4g
d3JvdGU6DQo+Pg0KPj4gRnJvbTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hp
cm5Ad2RjLmNvbT4NCj4+DQo+PiBJbiBvdXIgQ0kgc3lzdGVtLCB0aGUgUkFJRCBzdHJpcGUgdHJl
ZSBjb25maWd1cmF0aW9uIHNvbWV0aW1lcyBmYWlscyB3aXRoDQo+PiB0aGUgZm9sbG93aW5nIEFT
U0VSVCgpOg0KPj4NCj4+ICAgYXNzZXJ0aW9uIGZhaWxlZDogZm91bmRfc3RhcnQgPj0gc3RhcnQg
JiYgZm91bmRfZW5kIDw9IGVuZCwgaW4gZnMvYnRyZnMvcmFpZC1zdHJpcGUtdHJlZS5jOjY0DQo+
Pg0KPj4gVGhpcyBBU1NFUlQoKWlvbiB0cmlnZ2VycywgYmVjYXVzZSBmb3IgdGhlIGluaXRpYWwg
ZGVzaWduIG9mIFJBSUQNCj4+IHN0cmlwZS10cmVlLCBJIGhhZCB0aGUgIm9uZSBvcmRlcmVkLWV4
dGVudCBlcXVhbHMgb25lIGJpbyIgcnVsZSBvZiB6b25lZA0KPj4gYnRyZnMgaW4gbWluZC4NCj4+
DQo+PiBCdXQgZm9yIGEgUkFJRCBzdHJpcGUtdHJlZSBiYXNlZCBzeXN0ZW0sIHRoYXQgaXMgbm90
IGhvc3RlZCBvbiBhIHpvbmVkDQo+PiBzdG9yYWdlIGRldmljZSwgYnV0IG9uIGEgcmVndWxhciBk
ZXZpY2UgdGhpcyBydWxlIGRvZXNuJ3QgYXBwbHkuDQo+Pg0KPj4gU28gaW4gY2FzZSB0aGUgcmFu
Z2Ugd2Ugd2FudCB0byBkZWxldGUgc3RhcnRzIGluIHRoZSBtaWRkbGUgb2YgdGhlDQo+PiBwcmV2
aW91cyBpdGVtLCBncmFiIHRoZSBpdGVtIGFuZCAidHJ1bmNhdGUiIGl0J3MgbGVuZ3RoLiBUaGF0
IGlzLCBjbG9uZQ0KPj4gdGhlIGl0ZW0sIHN1YnRyYWN0IHRoZSBkZWxldGVkIHBvcnRpb24gZnJv
bSB0aGUga2V5J3Mgb2Zmc2V0LCBkZWxldGUgdGhlDQo+PiBvbGQgaXRlbSBhbmQgaW5zZXJ0IHRo
ZSBuZXcgb25lLg0KPj4NCj4+IEluIGNhc2UgdGhlIHJhbmdlIHRvIGRlbGV0ZSBlbmRzIGluIHRo
ZSBtaWRkbGUgb2YgYW4gaXRlbSwgd2UgaGF2ZSB0bw0KPj4gYWRqdXN0IGJvdGggdGhlIGl0ZW0n
cyBrZXkgYXMgd2VsbCBhcyB0aGUgc3RyaXBlIGV4dGVudHMgYW5kIHRoZW4NCj4+IHJlLWluc2Vy
dCB0aGUgbW9kaWZpZWQgY2xvbmUgaW50byB0aGUgdHJlZSBhZnRlciBkZWxldGluZyB0aGUgb2xk
IHN0cmlwZQ0KPj4gZXh0ZW50Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1z
aGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+PiAtLS0NCj4+ICAgZnMvYnRyZnMv
Y3RyZWUuYyAgICAgICAgICAgIHwgIDEgKw0KPj4gICBmcy9idHJmcy9yYWlkLXN0cmlwZS10cmVl
LmMgfCA5NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+PiAgIDIgZmls
ZXMgY2hhbmdlZCwgODggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvZnMvYnRyZnMvY3RyZWUuYyBiL2ZzL2J0cmZzL2N0cmVlLmMNCj4+IGluZGV4IGIx
MWVjODYxMDJlMy4uM2YzMjBmNmU3NzY3IDEwMDY0NA0KPj4gLS0tIGEvZnMvYnRyZnMvY3RyZWUu
Yw0KPj4gKysrIGIvZnMvYnRyZnMvY3RyZWUuYw0KPj4gQEAgLTM4NjMsNiArMzg2Myw3IEBAIHN0
YXRpYyBub2lubGluZSBpbnQgc2V0dXBfbGVhZl9mb3Jfc3BsaXQoc3RydWN0IGJ0cmZzX3RyYW5z
X2hhbmRsZSAqdHJhbnMsDQo+PiAgICAgICAgICBidHJmc19pdGVtX2tleV90b19jcHUobGVhZiwg
JmtleSwgcGF0aC0+c2xvdHNbMF0pOw0KPj4NCj4+ICAgICAgICAgIEJVR19PTihrZXkudHlwZSAh
PSBCVFJGU19FWFRFTlRfREFUQV9LRVkgJiYNCj4+ICsgICAgICAgICAgICAgIGtleS50eXBlICE9
IEJUUkZTX1JBSURfU1RSSVBFX0tFWSAmJg0KPj4gICAgICAgICAgICAgICAgIGtleS50eXBlICE9
IEJUUkZTX0VYVEVOVF9DU1VNX0tFWSk7DQo+Pg0KPj4gICAgICAgICAgaWYgKGJ0cmZzX2xlYWZf
ZnJlZV9zcGFjZShsZWFmKSA+PSBpbnNfbGVuKQ0KPj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3Jh
aWQtc3RyaXBlLXRyZWUuYyBiL2ZzL2J0cmZzL3JhaWQtc3RyaXBlLXRyZWUuYw0KPj4gaW5kZXgg
NDE5NzBiYmRiMDVmLi41NjkyNzNlNDJkODUgMTAwNjQ0DQo+PiAtLS0gYS9mcy9idHJmcy9yYWlk
LXN0cmlwZS10cmVlLmMNCj4+ICsrKyBiL2ZzL2J0cmZzL3JhaWQtc3RyaXBlLXRyZWUuYw0KPj4g
QEAgLTEzLDYgKzEzLDUwIEBADQo+PiAgICNpbmNsdWRlICJ2b2x1bWVzLmgiDQo+PiAgICNpbmNs
dWRlICJwcmludC10cmVlLmgiDQo+Pg0KPj4gK3N0YXRpYyBpbnQgYnRyZnNfcGFydGlhbGx5X2Rl
bGV0ZV9yYWlkX2V4dGVudChzdHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxlICp0cmFucywNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgYnRyZnNf
cGF0aCAqcGF0aCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgYnRyZnNfa2V5ICpvbGRrZXksDQo+IA0KPiBvbGRrZXkgY2FuIGJlIG1hZGUg
Y29uc3QuDQo+IA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHU2NCBuZXdsZW4sIHU2NCBmcm9udHBhZCkNCj4+ICt7DQo+PiArICAgICAgIHN0cnVjdCBi
dHJmc19yb290ICpzdHJpcGVfcm9vdCA9IHRyYW5zLT5mc19pbmZvLT5zdHJpcGVfcm9vdDsNCj4+
ICsgICAgICAgc3RydWN0IGJ0cmZzX3N0cmlwZV9leHRlbnQgKmV4dGVudDsNCj4+ICsgICAgICAg
c3RydWN0IGV4dGVudF9idWZmZXIgKmxlYWY7DQo+PiArICAgICAgIGludCBzbG90Ow0KPj4gKyAg
ICAgICBzaXplX3QgaXRlbV9zaXplOw0KPj4gKyAgICAgICBpbnQgcmV0Ow0KPj4gKyAgICAgICBz
dHJ1Y3QgYnRyZnNfa2V5IG5ld2tleSA9IHsNCj4+ICsgICAgICAgICAgICAgICAub2JqZWN0aWQg
PSBvbGRrZXktPm9iamVjdGlkICsgZnJvbnRwYWQsDQo+PiArICAgICAgICAgICAgICAgLnR5cGUg
PSBCVFJGU19SQUlEX1NUUklQRV9LRVksDQo+PiArICAgICAgICAgICAgICAgLm9mZnNldCA9IG5l
d2xlbiwNCj4+ICsgICAgICAgfTsNCj4+ICsNCj4+ICsgICAgICAgQVNTRVJUKG9sZGtleS0+dHlw
ZSA9PSBCVFJGU19SQUlEX1NUUklQRV9LRVkpOw0KPj4gKyAgICAgICByZXQgPSBidHJmc19kdXBs
aWNhdGVfaXRlbSh0cmFucywgc3RyaXBlX3Jvb3QsIHBhdGgsICZuZXdrZXkpOw0KPj4gKyAgICAg
ICBpZiAocmV0KQ0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+PiArDQo+PiArICAg
ICAgIGxlYWYgPSBwYXRoLT5ub2Rlc1swXTsNCj4+ICsgICAgICAgc2xvdCA9IHBhdGgtPnNsb3Rz
WzBdOw0KPj4gKyAgICAgICBpdGVtX3NpemUgPSBidHJmc19pdGVtX3NpemUobGVhZiwgc2xvdCk7
DQo+PiArICAgICAgIGV4dGVudCA9IGJ0cmZzX2l0ZW1fcHRyKGxlYWYsIHNsb3QsIHN0cnVjdCBi
dHJmc19zdHJpcGVfZXh0ZW50KTsNCj4+ICsNCj4+ICsgICAgICAgZm9yIChpbnQgaSA9IDA7IGkg
PCBidHJmc19udW1fcmFpZF9zdHJpcGVzKGl0ZW1fc2l6ZSk7IGkrKykgew0KPj4gKyAgICAgICAg
ICAgICAgIHN0cnVjdCBidHJmc19yYWlkX3N0cmlkZSAqc3RyaWRlID0gJmV4dGVudC0+c3RyaWRl
c1tpXTsNCj4+ICsgICAgICAgICAgICAgICB1NjQgcGh5czsNCj4+ICsNCj4+ICsgICAgICAgICAg
ICAgICBwaHlzID0gYnRyZnNfcmFpZF9zdHJpZGVfcGh5c2ljYWwobGVhZiwgc3RyaWRlKTsNCj4+
ICsgICAgICAgICAgICAgICBidHJmc19zZXRfcmFpZF9zdHJpZGVfcGh5c2ljYWwobGVhZiwgc3Ry
aWRlLCBwaHlzICsgZnJvbnRwYWQpOw0KPj4gKyAgICAgICB9DQo+PiArDQo+PiArICAgICAgIGJ0
cmZzX21hcmtfYnVmZmVyX2RpcnR5KHRyYW5zLCBsZWFmKTsNCj4gDQo+IFRoaXMgaXMgcmVkdW5k
YW50LCBpdCB3YXMgYWxyZWFkeSBkb25lIGJ5IGJ0cmZzX2R1cGxpY2F0ZV9pdGVtKCksIGJ5DQo+
IHRoZSBidHJmc19zZWFyY2hfc2xvdCgpIGNhbGwgaW4gdGhlIGNhbGxlciBhbmQgZG9uZSBieQ0K
PiBidHJmc19kZWxfaXRlbSgpIGJlbG93IGFzIHdlbGwuDQo+IA0KPiANCj4+ICsNCj4+ICsgICAg
ICAgLyogZGVsZXRlIHRoZSBvbGQgaXRlbSwgYWZ0ZXIgd2UndmUgaW5zZXJ0ZWQgYSBuZXcgb25l
LiAqLw0KPj4gKyAgICAgICBwYXRoLT5zbG90c1swXS0tOw0KPj4gKyAgICAgICByZXQgPSBidHJm
c19kZWxfaXRlbSh0cmFucywgc3RyaXBlX3Jvb3QsIHBhdGgpOw0KPiANCj4gU28gYWN0dWFsbHkg
bG9va2luZyBhdCB0aGlzLCB3ZSBkb24ndCBuZWVkICBidHJmc19kdXBsaWNhdGVfaXRlbSgpDQo+
IHBsdXMgYnRyZnNfZGVsX2l0ZW0oKSwgdGhpcyBjYW4gYmUgbW9yZSBsaWdodHdlaWdodCBhbmQg
c2ltcGxlciBieQ0KPiBkb2luZyBqdXN0Og0KPiANCj4gMSkgRG8gdGhlIGZvciBsb29wIGFzIGl0
IGlzLg0KPiANCj4gMikgVGhlbiBhZnRlciwgb3IgYmVmb3JlIHRoZSBmb3IgbG9vcCwgdGhlIG9y
ZGVyIGRvZXNuJ3QgcmVhbGx5DQo+IG1hdHRlciwganVzdCBkbzogICBidHJmc19zZXRfaXRlbV9r
ZXlfc2FmZSh0cmFucywgcGF0aCwgJm5ld2tleSkuDQo+IA0KPiBMZXNzIGNvZGUgYW5kIGl0IGF2
b2lkcyBhZGRpbmcgYSBuZXcgaXRlbSBhbmQgZGVsZXRpbmcgYW5vdGhlciBvbmUsDQo+IHdpdGgg
dGhlIHNoaWZ0aW5ncyBvZiBkYXRhIGluIHRoZSBsZWFmLCBldGMuDQoNCk9oIEkgZGlkbid0IGtu
b3cgYWJvdXQgYnRyZnNfc2V0X2l0ZW1fa2V5X3NhZmUoKSwgdGhhdCBzb3VuZHMgbGlrZSBhIA0K
Z29vZCBwbGFuIHRoYW5rcyA6KQ0KQ2FuIEkgc3RpbGwgZ2V0IHJpZCBvZiBidHJmc19tYXJrX2J1
ZmZlcl9kaXJ0eSB0aGVuPw0K

