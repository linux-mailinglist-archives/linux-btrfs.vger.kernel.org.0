Return-Path: <linux-btrfs+bounces-11087-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FCFA1DBE9
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 19:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90A737A22E7
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 18:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE99418C011;
	Mon, 27 Jan 2025 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="TlPU37rC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF72819BBA
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738001472; cv=fail; b=UDagMKuIwVI7ul4SVXNyDt5Wm1u+00yR9vbKPXTdOK10lDBKLsPOVMi3hfkcANwYjpWa9XnJSQkjTJ+p/4RKjJxQ/lSY+6eN2J5cRCHYEOuz6DQOa29HsFR8j+lOBJwyC58Z6ReuFBZ+sVLvB5JdRxRow1zQq1lQRJCSRmbdrY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738001472; c=relaxed/simple;
	bh=4mXvLJCw2Ac81o6R/03WblFS0Yq4lidppCO2Sx6ZmXE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=g8MP9P+RbqB8/yO1WDqdxAtYDXHhN6RQPZ3iNvwz8L/905bdHMX6zfA2wFm43D45KWcnwytILsEB5E8lkrOMa8cRvglsITbfdArZJh+DVSH0rV5KWiDYsVLTN2DmkKf7lMDB47KpKfAl461myGGjQNiB61CqAkESJRj031T0zD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=TlPU37rC; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RHp6QJ006493
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 10:11:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=HgTaPoSfiHlgwhnCtugFOunnUitppOLGysCjAIknrx8=; b=
	TlPU37rC12FwDum9kOF+F9ASv0Bd6Y5PLbeFP2y8duRkkaNRYLw1ROdWsY/bdi01
	qmrlwIMAZTgLHzwM/3Xjl0rzwYiJuvfIcVmuVDWqXGuALFZkS1gWLelr+NZSVUQD
	jfptrWR7uN0ipp2iD33FmlDHBObRIWfOWn9Qaq1v+pUecV5iULdDW7YoTMKMR9k4
	nzLxlJAa7Oh5OpJvNwJbUW1NU8TbuXwuSVJ/6a+BUVIUn76xr2lpq/gODVqQxxnj
	GvYSmWBgTbfKLRC3qrk3sipAn3SC9vp48U0iYo0ArfezBFF1cw9F2Xd8Hy8dwNWG
	CrKejZscEqKfz8kuJ6vsXg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44eedsgcnc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 10:11:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSqbM3gfMQCam9csz5Uu+KI4P5CFtnGsTgFabpr+sGovrsfxdVdHhOv1XGxmGWS5zsvKIGXudYX77jD5+FLMwCtzWCkjr0Gy9B4Jm+fJUJl66D4BmM9lAKN25E0C1krfZutAUTYPUl+kCxk2l9TRcnbWEYW/AA9ZwaaD+3ApIN/VAGTfjyaBVLoMrAEGLk3BFq7cULzau4AP1nceEmkKaTciTUaKKFW51x3mfdzq3QQGIT7dxzAEiRAFI8J4+khaXCoWPOgU8AgQfz1FGQ/KmC3RCnQpYNjcJ/FoU+lGcM7XOGD6qcVwzh6YlD5dgZ5SGj33A+OJrg0Rwfifpvp9TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP0f6gJnzjL6h8WA8TtZl6U6+H460fxU5oHkLMhOT6o=;
 b=dWpOzX/Y+W4Eu4F7e4XB3LkOLLySNCWLr+LlmoZnG3T3JRoHli+2o6mVTuFxx2iVXSDHOG9A+ScoveIN8ImfNLTD07+yY5jbUWz0a9q5MUOXVi0Vo5WdcUdcKc/TCVtzCZDHnThsKCbBawL1yywW2KV+93JIZeHE8W3YPGpXL1+p+Bwnwt7KNExEd/gfaHoqbzd3lNCBstV3j48XjPygiHyOTS1MlVyDuH98kPckRNomqBflSW7W27u/nSAGQrlbB2/R2XpLNgxaGk72fTYSn9RJDzG0YF2bRlUPYaJBb7aXrpimKMZLVaDlfd6Iq3qY0FoBMqDewLo5eLE7ZGcNqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by MN6PR15MB6049.namprd15.prod.outlook.com (2603:10b6:208:47e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 18:11:07 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%5]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 18:11:07 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Daniel Vacek <neelx@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: add io_stats to sysfs for dio fallbacks
Thread-Topic: [PATCH] btrfs: add io_stats to sysfs for dio fallbacks
Thread-Index: AQHbbDOYW1HaLbrXA0imAWnyJlpfc7MiafwAgABBIoCAABhQAIAIMdUA
Date: Mon, 27 Jan 2025 18:11:07 +0000
Message-ID: <293d2d0e-f0bb-4576-9f88-4133f370f933@meta.com>
References: <20250121183751.201556-1-maharmstone@fb.com>
 <CAPjX3FccHg8HUduLvOODAdj=SN3sNytOEx4TDhkKSJ+P_OVv7A@mail.gmail.com>
 <080dca03-dd09-488a-b98a-5a107dbb76a7@meta.com>
 <CAPjX3Fe+LVLn5ghRUNGJt0=_gwjwKM+LT9qt_2S9-0c389kvmQ@mail.gmail.com>
In-Reply-To:
 <CAPjX3Fe+LVLn5ghRUNGJt0=_gwjwKM+LT9qt_2S9-0c389kvmQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|MN6PR15MB6049:EE_
x-ms-office365-filtering-correlation-id: 6c3f0559-db83-4527-78e6-08dd3efdf881
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RE5kZ0xrSXBGOGtmSHB0V1VqZkNBMzNhb2s0OUdBUis4MldzbEI5cmVQMkJM?=
 =?utf-8?B?UmVyWnVlbkpHOUlvbEhOdXNqUSsyTUJKcm5ydFlOeDM1T2pCTUw1UDQyUmpx?=
 =?utf-8?B?eW16MVVjaUpJRWdocHpwTStsdVBXZ2NrL1cwcThrUE5WcUZubURJOEozL2pO?=
 =?utf-8?B?dkFJWWxkL1BXelZWNlhlTCtmNC9vT3RPK3hLamFLbjIvZ3gwanhKdmNmbzh3?=
 =?utf-8?B?bXVLWlVZdDB6UkM1cXhYaHhZaHp3ZnZaQlRSWXg3L0JtdkpGM1RqenlVNCtM?=
 =?utf-8?B?V2F2WThaajE3cWNnbHdsMHV1QWxlRmU0VE9wYm9DbHB5Uis1SWVaQjB1aG8w?=
 =?utf-8?B?dUJJOXRmUERhMGF2b0VGeUZMZGsxdG5yRHNOTGJmZDZEazdRblplVm9sQkxJ?=
 =?utf-8?B?TUh1REV0R0RSd1h5M0xVZXo3aHdkMFN6RnM5cmVQcUVUVi8yVFNFYWZlMDVR?=
 =?utf-8?B?aURsNXRsdUVaUDRlcHF2NTZLd0dmNEw4NmtjaFBVWVhkSUk4Kzg5U3djVHY2?=
 =?utf-8?B?cThTelVrejV0NVFQMENZSWtBMGhlaDZVUWdjQ2Nsd2RGNUtTMk04eFZ1YjB5?=
 =?utf-8?B?NXRFVmRXYmJ2VEliWU9lVTJ3anZtREswQ3h3S2pMRDh4ZXdxbit4UHdlcXVZ?=
 =?utf-8?B?SGxPZkpTalFSd1BmZk02MU1uZFdvRWNCYXJ5Q1dFVDUvT2hocXgvUC9Vb0JB?=
 =?utf-8?B?ZjJPOS9jLzk0V29lcWpzQTNWMlByVy9ka1U5NFhMcnY2WDlZVkI0WUxuZmZW?=
 =?utf-8?B?WkdXbFkzZGN1ZHljY1FJaUVFMUlqMDdYakwwU3pIL3RqTmtFSXd5ZE5ieWxm?=
 =?utf-8?B?T3FpWGJCYUQ3c0ZUdER5TXBkSmtXWDhWWXhadWlFMmpRQjArZG5QWU5NRkpk?=
 =?utf-8?B?V2NyMVNWdVkzcjV0STRTUC83bExXbnRVQitkQUVWV2d2ZE9pR1NvOXp4TXY5?=
 =?utf-8?B?ck4wb2dVTmx4VmNjNHpKS2h0Rm1jcEVVSStuZkQ0T2NYVFVWWU40RURTZEFX?=
 =?utf-8?B?aVNGSHRiYnd5dGNJc0FVak1lQUhOakgvajlIRCtDWVFXVjM1WWFZZFB0QUJW?=
 =?utf-8?B?R0RzcEJiTCtOaWpKaHJpRjd2NFd3Y1lqK2N0dVF3QmltbHRuM3ZKWHpDbkxM?=
 =?utf-8?B?WFRVVDhoUEVvVVVhbGYyTmswNU1zQUk4MHFmZlhlUnk1MkV1S3VSVnZ2Q0ZR?=
 =?utf-8?B?QnBVOHB1R1BZeHNpZGJzUFlWSGY2d0JRWENGYkw2cWVMOUZzU3RUb2xqeXh4?=
 =?utf-8?B?Mjk2K3Q2UW4zaFlZTjRuaHFyMjZzaTluaGxDZTl4dlc5bTVyT2tHUitHdG4z?=
 =?utf-8?B?dDcxWERjdHBYcnZpbEI4QXR3SDUzbDZ1Vm04RUtBTytUZ2NQeUZmRUtMalhV?=
 =?utf-8?B?c3lrZllHOWZYc0phMjBCYk5iNTgrUzVCL1dvMFhjZmptdE00Um5HamJhTHJn?=
 =?utf-8?B?YmlzMFR6c3pDQ1RsMHVpeXBTcUhRRGttSUtDRk9MTTdtMHcrRjV6MS9meEV2?=
 =?utf-8?B?QTVNb3BJeVdMc1lnS3kvRWQ3cUFuTW1LV0FnbUhzMkdFWU91SnI5VzNQc1h3?=
 =?utf-8?B?YlNkSG1lR1h1T3FoekR2VDBkbkJKd0xDSi83dFVlNmJZaGNWalhjMjloT3hp?=
 =?utf-8?B?UDdGU2YwMzBKVklkM2N4QjJ2R0hGbko1LzNDdVh3ZVZSRU02NFN1VkdNditt?=
 =?utf-8?B?RHhBZWROMEJ4Q2t0KzBjZUFoTjhQOE1WN0xZRGFLNEFreEtGNVNNblU5TitQ?=
 =?utf-8?B?ck9pb1BGTkM4TXU1MnJ5L1NTQXRNUncxZU8vT3ZkUTBabHlRWjRUV2ErRHdE?=
 =?utf-8?B?SVNJNjNHZUx0a2hkMGE3ZWdRdTdKZ25wOC9ObFZwUTNzZit4L2ZhcGpyQnd4?=
 =?utf-8?B?TVFGdVlDbTlFam1GUG1zY1NjVTRsS05NaVgxYXhGMTRRYXZyUkU2Z2Vyd3NO?=
 =?utf-8?Q?oCYwNPG9fctDWuVIpV0KjgaXMgH+kXU6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SThtdzg2aVRGOHZ6Nk9FTDZYVXo2QzVRcmwzN1QxYXhXN3dEUzJRbmJiT2ow?=
 =?utf-8?B?U3o1U0lhVE1nNjBzbm56TnE4NjJ1R1ZWQXF3RjlDTnV3N2hwSWxGUGg1YWdu?=
 =?utf-8?B?ZWk4aWM5N0pYek94VlVKMmVpTUxnZHBoM3J4dktubXpwcWVZR0pIeVV4N3BZ?=
 =?utf-8?B?TFp1YUZYRVVQYUMwcHJnUWc1ajdQd3d1ZlFLOTRCRWxoMVB6VmNQa21TcXpo?=
 =?utf-8?B?K3lCSndJRTdlYi9VVmRSbnhGNEhtRXVTTExDZ2hqTlEvYUJXeFBLK1JxOHFr?=
 =?utf-8?B?RlE0bjBjQ3ZoNUFIcS9oSVBIQ3pOdWw4aDRVUTlWM1E3UVJSTm1KSmR0VmE4?=
 =?utf-8?B?c3hJOEMwUC9aOFd5NG5jV2IwRlhUeFpRUXRESmZTOHpsVGk3NE9GTVhWMWJR?=
 =?utf-8?B?VHFkNitmV245UkN6UlZhTkN6SDNoVFhONlRGc0x6VUtWT0g0ZFdlb2VDRS9X?=
 =?utf-8?B?R2ROam9TRlNmRDVoT1FmNzJRdXRlWldDR3NJZCt2eTVkejNZbnZVeGRkNHJW?=
 =?utf-8?B?N0cyUFZxMkdhOVZHVExBa2YxdFBCNVJhamFyeDY2c01ZMHJaQzVPakFPdHBI?=
 =?utf-8?B?bWpWeUNtcGNYSlFjYzVWN0wzYXdJeHBHalVmS2pGTjVSUktlQjBZR0ZNRmdE?=
 =?utf-8?B?T29LbDFvRitEVWd6aWxpL3RITktjSGlCSWNaTnAwRUpKcXdCRGs0SVBEaDdG?=
 =?utf-8?B?WXcxYWt1K3JmbnkyWkVTVHIycENuSWtTRU1KSDFQMFREc3BtTUE0OU1CbUxW?=
 =?utf-8?B?RXRQWFd3a1M1ZnZGT1Q3T1RSVERqdUxPTnBpV05SMHhpMjRGUVhLakR6N1Ur?=
 =?utf-8?B?ZndsODh3dC9YSzNrN1ZadzRwOUJ0WXkybERsZEhVUTV4MnRIL3BuVWxmVWU1?=
 =?utf-8?B?QTBycVk4bGFVQTBzVGtGVzF2WVFDTGJDMG51bnJ6amFWRmdPZU9VQ0NZODM4?=
 =?utf-8?B?eTFiNWkxRjdsNXBFNFA5SzVaN3k0cEQ2NnVibm0zRCtYSXczQlRMZkVlbUdl?=
 =?utf-8?B?VDNqTmtmUmVKYStoUGp6b1dCaXBhajhra0liRFRFN05qTk9ya2RXenJTTDUr?=
 =?utf-8?B?YStpWUlpVG44RTFhY0VwWSt6cDloSzNRc2NCcGl0TWx5SWo4Q2d6MERFdk0w?=
 =?utf-8?B?cUJPZlNKdHZ2N3dxR2pUYi9KYTVKb2doYnROSWROUEp5NTlJVXFWbUlUOE53?=
 =?utf-8?B?NzFZSXY2MGhFYVZjNVdsK1A0eHdrcUtTQUN0ZDI5QkhDSnBNdDNrelI2Tk5N?=
 =?utf-8?B?M3ZZV3ErVEVyOHZHeStXK1BwQStlc1lvY2MyRFFPWHR2cFF0dzZsQ1ZMMzFK?=
 =?utf-8?B?MzU0ZldhWklwVmVSek1Lc2N6Z0M2ZDcyQ1ludGVOdHRtUmtlZWtON0Q1em5q?=
 =?utf-8?B?UzFXdGxNeUU5WnBHVlBrL2FMdVpUSHd3R1ZISU56ZnVPVk5VeWJ3ak1zOGVO?=
 =?utf-8?B?ZnVNKzBRaE9JYURtYUwrKzB1YWxUSXVYS2RxazQzRWRwdUUxb3FRRmQ4Sklh?=
 =?utf-8?B?NGY0ZHBBUzVKU3dFbVJvbFU0bmVDWnFyT00raFBXVVJrOU9VYS9IbUM3YlZ6?=
 =?utf-8?B?TkxWY3pPa3RuWWxXclZReXlHcmJMMzgvYXZPeVBIQkxkS2pxcm5ibndRWTFZ?=
 =?utf-8?B?SWcvOTlzZlJLUlBzY0xYUVRlVllXVElwSUxLVlp6bVFMcU9YRXFFTUFJcVJo?=
 =?utf-8?B?RklUZkdzckt3RlhGbmEyNUNUVm5Eb2NVWUN4QUNxdnNkOUFsSG5sYjFKZ1Yz?=
 =?utf-8?B?YUdEMXczc0FEeHhMcFh6cEoxVHFwcm13bkJzbDRHYm1xUGdJcVhLMTBqWGhz?=
 =?utf-8?B?cythM1AzL25HOTZYTEJ4a1FUU0I2S2plVmtxeEhwYnl2WGtNdVlWS0ZIbXNn?=
 =?utf-8?B?OWl6V3dwUE04WmxLNEorUGpVbVZudVc0N2JHalAzbEUyK0loaDZlTnpManNi?=
 =?utf-8?B?L2lWZExoTEdsS0NLa0ZNNUorRlJkWTE0WGozWnBKNUdNZldTalNnanZEa3hv?=
 =?utf-8?B?US9jNDRraGdNYmNHdVkyYllhY21SMFpvcjRwclEySXlRdXFOd0NPbi9CWWtx?=
 =?utf-8?B?a0RoSTJSWThWL2dyYjMycDZoZlJmUHhhNjYxV2E2MjNBR2hockkxeFBDd2Nx?=
 =?utf-8?B?WVlteDdmUUtvVUQ5ZE11M0d5ZXNuWkV4WHVsQXlkN0xHV1hTMHhkL0R2QlRy?=
 =?utf-8?Q?d7dSp26Cjz9lb1AlF5gKymc=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3f0559-db83-4527-78e6-08dd3efdf881
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 18:11:07.3296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 98N25bVxv9BmT6sA4mAtErD+v8+CeCZ+HC8UuRzMkeWSh71OfFAOHzFSoNOd8rKadEPpwUWii/KKFd9qJxGHtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR15MB6049
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <1583C759F3123446A4F864AF1879E185@namprd15.prod.outlook.com>
X-Proofpoint-GUID: S-9T7ouTz4DBMS9_KTXF5g1PZ7mq6B5R
X-Proofpoint-ORIG-GUID: S-9T7ouTz4DBMS9_KTXF5g1PZ7mq6B5R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_08,2025-01-27_01,2024-11-22_01

On 22/1/25 13:02, Daniel Vacek wrote:
> >=20
> On Wed, 22 Jan 2025 at 12:35, Mark Harmstone <maharmstone@meta.com> wrote:
>>
>> Thanks Daniel.
>>
>> On 22/1/25 07:42, Daniel Vacek wrote:
>>   > On Tue, 21 Jan 2025 at 19:38, Mark Harmstone <maharmstone@fb.com> wr=
ote:
>>   >>
>>   >> For O_DIRECT reads and writes, both the buffer address and the file
>> offset
>>   >> need to be aligned to the block size. Otherwise, btrfs falls back to
>>   >> doing buffered I/O, which is probably not what you want. It also cr=
eates
>>   >> portability issues, as not all filesystems do this.
>>   >>
>>   >> Add a new sysfs entry io_stats, to record how many times DIO falls =
back
>>   >> to doing buffered I/O. The intention is that once this is recorded,=
 we
>>   >> can investigate the programs running on any machine where this isn'=
t 0.
>>   >
>>   > No one will understand what these stats actually mean unless this is
>>   > well documented somewhere.
>>   >
>>   > And the more so these are not generic stats but btrfs specific.
>>
>> That's fine, I'll send a patch to Documentation/ch-sysfs.rst in
>> btrfs-progs once this is in. That's what we have for commit_stats.
>>
>>   > So I'm wondering what other filesystems do in such a situation? Fail
>>   > with -EINVALID? Or issue a ratelimited WARNING?
>>
>> O_DIRECT isn't part of POSIX, so there's no standard. Ext4 seems to do
>> something similar to btrfs. XFS has xfs_file_dio_write_unaligned(),
>> which appears to somehow do unaligned DIO. Bcachefs fails with -EINVAL.
>> Nobody issues a warning as far as I can see.
>=20
> I mean that also can be improved. Or btrfs can just do better than the ot=
hers.
>=20
> Maybe a warning is a bit too much in this case, I'm not really sure. I
> just offered an idea to consider, coz silently falling back to cached
> IO without letting the user know does not seem right.
>=20
> Well, the question is - If you take it from the app developer point of
> view. What's the reason to explicitly ask for DIO in the first place?
> Would you like to know (would you care) it falled back to a cached
> access because basically a wrong usage? I think that is the important
> question here.
>=20
> Imagine the developer wants to improve the performance so they change
> to DIO. But btrfs will never actually end up doing DIO due to the
> silent fallback. They benchmark. They get the same results. They
> conclude that DIO won't make a difference and it is not worth pursuing
> further. Just because not knowing they only missed an offset.
>=20
> That's actually where we are right now and what you are trying to
> improve, right?
>=20
> What is more likely to be noticed? A warning in the log or some
> counter some particular filesystem exposes somewhere no one even knows
> exists.
>=20
> And don't get me wrong, I'm not against the stats. I think both the
> stats and the warning can be useful here. The warning can even guide
> you to eventually check/monitor the stats.
>=20
>>   > Logging a warning is a very good starting point for an investigation
>>   > of the running program on a machine. Even more, the warning can point
>>   > you exactly to the offending task which the stats won't do as they a=
re
>>   > anonymous in nature.
>>
>> But then you get a closed-source program that does unaligned O_DIRECT
>> I/O, and now you have dmesg telling you about a problem you can't fix.
>=20
> That's why I mentioned rate limiting. Actually in this case a
> WARN_ONCE may be the best approach. I think that that is the usual
> solution in various parts of the kernel. And I think it's always good
> to know about a problem, even when you cannot fix it.
>=20
> If you can't fix that problem the stat counters would be as useful as
> the warning, IMO. Just more hidden.
> And well, you can always reach out to the vendor of that closed source
> app asking to address the issue.
>=20
> The only problem would be some legacy SW where the original vendor no
> longer exists. But in that case you can choose to ignore the warning,
> especially if only issued once.
>=20
> On the other hand, developing a new SW one may not even realize the
> DIO is not aligned (by a mistake or by a bug) without getting a
> warning. So being a bit more verbose seems really useful to me.
>=20
>> I believe btrfs' DIO fallback is more or less what Jens' proposed
>> RWF_UNCACHED patches allow you to do intentionally, so it's not that
>> there's not a legitimate use case for it. It's just that it's nearly
>> always a programmer mistake.
>=20
> Agreed, and that's exactly where I think the warning is the most useful, =
IMO.
> That's also why compilers shout warnings for many common mistakes,
> right? Just my 2c.
>=20
>> Mark
>>

My concern is that putting it in dmesg will add to the overhead of=20
distro maintainers, i.e. having to explain to end-users how a warning is=20
harmless. And having once had to write a syslog rule to work around=20
Citrix's chattiness, I'm not eager to inflict that on anybody else.

Plus any given piece of software will have far more users than=20
developers; the warning is going to be noise for the vast majority of=20
people.

