Return-Path: <linux-btrfs+bounces-9787-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E62059D40AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 17:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95C30B2C03A
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 16:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FD61514F8;
	Wed, 20 Nov 2024 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="D0OrQdee"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A0714AD38;
	Wed, 20 Nov 2024 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732119261; cv=fail; b=GJ93US31RapmHT/X7ctvbDjz/NpwhDOrg7Pd8ucQT2UfdXQepbhH12xwKD4L6gS0Ss9OYvdplblljWV8bFJyat9JMZMowyG4+Q1TwoAuuwGwUjuc4CU0LdbfcC0y3R2RL7Mq43W6w0TNntokQQc+oO3tTWjVUp24OcpOCXuzfjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732119261; c=relaxed/simple;
	bh=xEPWQxz9XMwm8z+C7xGpVqWe4PTlMfH7C3G7iN1zaC8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E0N1AWp/cX7RIEy08bCNz77BndvLZMFrevDa8SxeXBM7YO5iH27zxme35+WkQYD38Ge7qU5VEF/MV5sqjwhsOGIQKAJonZtzqLfCc83UMyETu/gcjAppBzQSEjB3AvudzMz36r/PzhiOtZit3wJUbzV/l4YDt2yzJq3MTKjkdTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=D0OrQdee; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKEohaX032739;
	Wed, 20 Nov 2024 08:14:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=xEPWQxz9XMwm8z+C7xGpVqWe4PTlMfH7C3G7iN1zaC8=; b=
	D0OrQdeeR3Z+zLSrhN8raHymKZdtfPtztOX2NFTmHPsb3u57ADwoBEYbVCQuUhqX
	/O19hfDj7TqJY+VipHFuJdbp/k3m1N/v6BckiHvQChYzubM/1eD1/yq5aR7MuZcG
	djbw8IMDnuiIUaxipPm1RFSFH9Q0iNnurmXUWwK44695txP3qCzVpDSmweC4oorM
	Vw5vUUW6ogLKIRtPFHzkOx6mf8jIEEoIJC2Vy4QhqgpShKdTvRIZ+8zqYFIn7v/B
	hT/q9qwaz+qDGhADm2jjZpWtSYFk+4Gz030m63FF3+nNSuPDjQWbcvTIATSLsFp2
	p9GHHjCP4RBefVN2/j1+HA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 431djfa199-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 08:14:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ug1E4Rk/C45j0awJ/FlcgSsBATlhq2nQ0lZ7YXx7Z2uiPs3HGqhmAZaybKMEfyjC0lDAEg5RafCmje84Y4Svyvk0YVG7y6DuUKkEzkPIBXsXRvcU+Sbw3RKYGktQ+4b065W/a6vzGn3oNBWBfcFBbff1/qWFL7jcG84uJiL0vMQmffy8c8Gh+vjBMruMpSwdAxF13kfDUQC0S9fMLby/UhzM6SOTN9++fQ0fBL6tBaei3tD8sXMOR4xwqkt3rp7ndDoappMnQVMFEy7/km4xuIiOXRQvFqT+978zKUdzAaDOAoGcWhds+EUjTHqwcYoruGk/bAUz3PjPwyhuLqP4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEPWQxz9XMwm8z+C7xGpVqWe4PTlMfH7C3G7iN1zaC8=;
 b=ZzlYj06H9WkZnaJZ2oB/JFfYsOktSUxUNInUDdzy7zjctpQeul9MEAanrgO/1DC5YZHo7h7yoJ1j4h6WOPKYzReoztBmb5z1441w4NSuP4DM65A5yh6b1aaVVT+6sDv09X8v6poxBrob58U+ME8bjy1ljnNEEHbXWQrO6D2aaF+/xRHddDZCfW1P8eQKx0Dgq37Mudlcf84IcWcpb76IPQLZsiAOB88/KmAWPmueNPABp9io5wWEystRtHkU5BJDUpBhc7okZn42wOua6ssxI9qP4Wt9T/Co89+Sqt/lV5R2sd60uGj3eZ2S2U74+Kd79n1hBcvfO69zFHMHC8whhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by DS0PR15MB5783.namprd15.prod.outlook.com (2603:10b6:8:df::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 16:14:08 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%4]) with mapi id 15.20.8182.014; Wed, 20 Nov 2024
 16:14:08 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Zorro Lang <zlang@redhat.com>
CC: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>,
        "zlang@kernel.org" <zlang@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: add test for encoded reads
Thread-Topic: [PATCH] btrfs: add test for encoded reads
Thread-Index: AQHbNEnT1dyQ3VMT+0imJxcV1/5F67KzZGmAgAHCHQCAARbVgIAKKISA
Date: Wed, 20 Nov 2024 16:14:08 +0000
Message-ID: <bbeea4ec-2f77-47fd-ab5c-6319d4248496@meta.com>
References: <20241111145547.3214398-1-maharmstone@fb.com>
 <bf3e4e63-6496-46f9-972c-c0b5c7c4de39@wdc.com>
 <28c2834b-3223-4191-bb10-81ce53c010a1@meta.com>
 <20241114050631.x3urk2ti4ukgtaai@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To:
 <20241114050631.x3urk2ti4ukgtaai@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|DS0PR15MB5783:EE_
x-ms-office365-filtering-correlation-id: 642bfa0c-ad15-4117-9862-08dd097e5cd7
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?enpHRVBjbVRiYmJ6b2luQkVNTWUxNWhFbnF3VGQwWGRyRVdZTFNBMnA4SENm?=
 =?utf-8?B?N1lSejV6Y0I1OHNZdU4wazVHSTNpaWxZWmhIOFhtUGd5WTN1WlRqZFp6cmR3?=
 =?utf-8?B?eUNhTFBEd3dZcEx0MzEwVnNhVnVScXA0Q0tCU3dtYVhXMk1zZ2krUDMwUk9S?=
 =?utf-8?B?WWIzSkdNb0RJRHgzQURYcVZPSHZpVkJpZmE1UGpnaEc0dGQ3c3NuSUdBbWNG?=
 =?utf-8?B?cTJweXNUaExTUHYvMWk2ajdFOVVqK0ZuR3h5VUVyZkRDaW9GcWk4ZFB0K0ls?=
 =?utf-8?B?UnJBZkp2UlZXTndnZmF5RHExZjFubEhLalB4elFzZjhISnlMQ2J5QkJKdGdE?=
 =?utf-8?B?RzZFVmV6SVk3dEhYeEhGQk1xK3dPekNvUDM2TTV0ODJBenlCZkIreHpOc3pP?=
 =?utf-8?B?Ym5GQXZWOGpESmhWaDZJRndiZTREMjdsbUdUQlg1NGpvY0lDVUtDbWRDVVBU?=
 =?utf-8?B?N3hnM1RQRG1NSmpDejFMeHV6N3M3VGtKUEQ0amFIdW9oV2xpeFltcGJmc1hi?=
 =?utf-8?B?STBBNU8wWDJ4WkZta0lvamVacnF5Wm1Kdy9PTEVSWWE2VnBYYzQxVllGUmtp?=
 =?utf-8?B?Tno4SjdHc0pGcSt1b08wK3V2bXZrWFNhMDRkSzJxeGR0ZDRHZTVKdTBCK0Zs?=
 =?utf-8?B?eTJWanVUZGNYMFR2aWhMQjZ1aGVUcERYcU5yc29oVHZQS3QwZGw0RkRZc21I?=
 =?utf-8?B?UDdKRFZxTXE1WVh5eHpsa2crZ3VCR3BCbTVsNTBKckpmUDVXNUQ5TWVFSmdZ?=
 =?utf-8?B?SjVTZFVpNWkxMlhPVVJuYnpyZEZ3T3hWTGJpamRTZk9tb2xTU2JucEd0b0tS?=
 =?utf-8?B?MkwyUUMrYVlleHpxeWtrbWl0N1V6RCtEQ1Y2ZUJvNXZKVzBuY3JLQmxTdkU5?=
 =?utf-8?B?L3E1b1BNVWhaTlljVloxS3U2eTQ3M3VNVzRiR2lkVWFOMHo3aUN5VTlVSE1X?=
 =?utf-8?B?WXdwTy9nZHpCRnN6K2tRa1R2Q3VxNEcxUjJEdjRpaXJBRzZkM2RaV0VMRzZm?=
 =?utf-8?B?NzVyU1NxdW1nenAyWDFDUFBxMkdaZmF0bVk4UkJTQVJrRGdUbHZLSWRxVUpI?=
 =?utf-8?B?ZkV6TkJsOFVOR1lUeXVodVE0V3ZyVHd0akl0SUFPU281TFNZSldWbnIxcnlN?=
 =?utf-8?B?ZG9MN2VSZkFSQkZJNzc4K1NSWDVNcklMMXlTMmRDWno1aUd6SnBrdVY3NXJo?=
 =?utf-8?B?ZkFMelZLQ0d6TUNuMVhoOVFGbVhoQVo2MmlXUGFvL1piYjdxMjRiVWIreE90?=
 =?utf-8?B?YlMwZkFKTlRXd3Q4NHdLSTlmZCs3a1V3aGRFMGpvUTRDVThsQTd0Vm9XR2lQ?=
 =?utf-8?B?OFJqKzRLOGpTSHkvaVVPaC9xd2QxSlp2bWd6WWVpZHJhN1QxLzhkbXB0L2sz?=
 =?utf-8?B?WU11OGpRZ1FLek0wY1NhWjFzWEx5OStScVVIWEk2TGhBM2lsS3ExV1g4UTdK?=
 =?utf-8?B?T3YyaGc0dThPZVFCckdBSjlrMHU1MCtDOTIxNThNSWNOUGJ3dXkzRDlYc3V0?=
 =?utf-8?B?ekhZWjhUL0lKaGVKUkVFU0JxOENhbmVZb0xBSGV3TFgxd3VZbWF0VFNaZ3hr?=
 =?utf-8?B?dGUzZDBxeFcydzNHcUNpWFZ2R3NiVTk4QzlNbVRjalN0ZUVmR0VOeWdXdTJV?=
 =?utf-8?B?eDIyWFBMWjROMC9SRzN6cnlWdXlUVDR3QXJONVgwZWI1TElUZFUyWG9NeGNW?=
 =?utf-8?B?N2RrdjZwMExuTmdiVkJkdnU3VUJ3bm4rZmN2TDN2R01UNHZDcm5FNkhOVDRH?=
 =?utf-8?B?SUxhQkxJQnowcVplb09XTzJHc3Mwenc4QTI5OWxJaU45R1AwdysxWXBZNXZQ?=
 =?utf-8?Q?lbMqFIcEYduphUZdSGnyDhgB/Pny2a1sYlQBk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K25tUVY4blZvN0Z6N00rcDkyaERRejN4c3dMeEcyR1lFZXF5emNPbzhNcVZv?=
 =?utf-8?B?TjV2bm0xVTJ2STBCSnNVc2xWZEdzRjA4Ymh2WVJYTFNudmY1b2FsVmtycjdG?=
 =?utf-8?B?M3JjR1FBL0RpNWtGcnNHU0w0WDNGYXdYb1Q4KzZWRWUrOW1qMmt4cVIwUTM4?=
 =?utf-8?B?SmEzamRHdG84d1hEUHRiYmhSYUY5NmVBS3VnVm1HZDNWblhzNDUzWUJ4cUlQ?=
 =?utf-8?B?TTlJMlNLajJGOU5nd2NCQVBpMEo1R1RGMDVRRVVQR2FFY3pWK1NTa0grR3NG?=
 =?utf-8?B?cWtvM2pDSU1Hc2JNNW02N2s0b2NNbUNPeng1ckRyODl3cFp2a0F4QnI0d2Y3?=
 =?utf-8?B?SUgzTzVyTWYrdnFmbkJVSTc4ME1FVm93WHNJam8xQWtvZmpSandnVDZBYmMy?=
 =?utf-8?B?L1pjK1U1N3Z3RUE4MGg3SXVzVTU4WkltSVJ3ZGJQUHR1b0dkbkpnVjVyeTF4?=
 =?utf-8?B?Nmd3VW9ET3FjK1FONHl1Zm00TUhkNHVBWTZoUk95aUFwUWZjcGI4YlhGeVJP?=
 =?utf-8?B?ZW1QaTQxWnhRQThBZFpMZ2N5dXNMT2U4d2VicWN6ZC91WWR5a3k3Z09FaU53?=
 =?utf-8?B?aXEzMENNN2dPSVhhTTZYWnhmbjhJL3dXQk1KOUlkdWNRcUh2eW5yVHJUYXAr?=
 =?utf-8?B?WFhLWlc0T0hHTEJ2Z0FiTS9pbWwxZGpzK2swWEVleVJXZi9DRmZTOGZVdlQ4?=
 =?utf-8?B?ZlgwdFRxLzJSR1RhdlJ5Q0FKVk1LLzNUL1ZLK3A2a3lyZWRVT2tyay84em9P?=
 =?utf-8?B?UG8yR2JFUHJ2NXVGb21kN2xWMWpscXlwMGpmSlBpQnVCNkdTU24zNDNFVkZP?=
 =?utf-8?B?eHlvTnBraXp3RktnYW5ORjNDbno2ZVhaL3BOeHY4ZE1ZNHdqdWU1Zk1FMXU5?=
 =?utf-8?B?ZHB1cDBYeFgrUEd2eWpXdVBXOUJLYWhzQlgzMFN2U29ZU0d6OG9maG9iMUk1?=
 =?utf-8?B?ZUtJN2Z5VUltMHBhQVlGNmx0THpUVjFaVVhzSDUwbGROQkZZbFVlQTQ4aFF3?=
 =?utf-8?B?akhCUUxmaWxzVXFXbnMxMUZvNkJha3RjMlMrZkhCTXpiSFo1emJFSXJLMGhW?=
 =?utf-8?B?S1FpWVVWODVHUU12blVmVnhWYW1UMGlaM3dKRmM0dVFsODNIR21BUUVpeXoz?=
 =?utf-8?B?S3AxMzJLVDVodHhlN0s4Qi8vV3ovMk1QcW5oS1J4cXhTdzA4TldReHlYQWwv?=
 =?utf-8?B?L2hTMFFkOW9kWlRpdkFoVUZiWFFaY3hwZTVWWXhZbkJaSVRySXhDUHFJUXNL?=
 =?utf-8?B?bGlCd0drdFNSdG5hbXhUVUE3NTYvcTZqMzJOQlBNbGExb0pHK3RZQXF3UzAz?=
 =?utf-8?B?eGg3V0dSZWZQcXNTQzFWbmIxRzZlU3IrbFY2MmY3Z2VyTmtBUm1NaDlUZlY3?=
 =?utf-8?B?YWI2ajBGTUcvbEh6M2wra2lybldTZGZYbm9vUkVYMy9yWU5LUnVsNCs2VFNo?=
 =?utf-8?B?dkxxKzNxNjE2WmpjKzFCbXZra0M0ZkYwVU1BVDBIa0J6RjY5OUttYlcvN3cx?=
 =?utf-8?B?YlRTS2NGdXRRcXZJVW50YURucGx3M3VwdjFKanZKT3FBaDZ2bE9yeVFoMlpx?=
 =?utf-8?B?TWd5OHNja21oRFRzZ0I4R2NIMnpRWndRSElYZzc0T1p4aFFtTVJHRjlKSkZL?=
 =?utf-8?B?L2pEblBHL2Jrb21yQ2wyL2VNVkllSVh4KzV6TUJyeXJoUFliM3B0eEpidWhp?=
 =?utf-8?B?dVp5YVIrKzVvTUg3VUhDOVNEZUJKNmcrT0JMK3BJVmNrdFNEUnhoZ3I4YXpK?=
 =?utf-8?B?aFNUaEZFNXJQOWFwK21TYXoyMHYrWVY1c25YakI1dUlnd1VBZ3Vva0p1OTZQ?=
 =?utf-8?B?d0dVSXFrMVo3UFVSWXkxOEhFMHFyYVlaOTVTUTlyazYvUXMwWDNFLzNkbjZu?=
 =?utf-8?B?alBsVUVXS2pkbnlmbUJPdWRGWkJZRDhXbGljWUFvcmgvUVlDdDFJSTFOaVFn?=
 =?utf-8?B?YnhtQWdRZi9ySXgyQ1VOdk41U09JbFplcDQ4UFhLc0tzbWhUZ0pHNXVsKzlv?=
 =?utf-8?B?U1hkTVhIZEVYY0dmSmlZL0x3RzNhVnJ3ZTFiNHVNeUlnSktsWmNHdzVQRXJM?=
 =?utf-8?B?bE9pZnVkSldGM2hSdjZwamFpcmQzUXcybW9hbjcwUjFDT1Q1dElmWlMramJj?=
 =?utf-8?B?ditwY1hIcWkzVFQrZWoyM3Z4ZFdadkRmWnkrVHlBY1htVitSdzYrY09nVEp3?=
 =?utf-8?Q?ojDetS2TiOv9FJ78+1+Ew6c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69D9A33E186A6B43BB24BACCB6059FE2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642bfa0c-ad15-4117-9862-08dd097e5cd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 16:14:08.4259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q09i7KZ6hiV8YTh0I4+0mTo0S094keTUsk2D305ftBjMxNH9kCDMj8kqgFFomNIiPTqrC1z7EAbYAEMWPjinng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5783
X-Proofpoint-GUID: I1O1BzDK7cRcPRzOaFp8-By4OTCxFxun
X-Proofpoint-ORIG-GUID: I1O1BzDK7cRcPRzOaFp8-By4OTCxFxun
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

T24gMTQvMTEvMjQgMDU6MDYsIFpvcnJvIExhbmcgd3JvdGU6DQouLi4NCg0KPj4gSXQgbG9va3Mg
bGlrZSBJT1JJTkdfT1BfVVJJTkdfQ01EIHdhcyBhZGRlZCB0byBsaWJ1cmluZyB3aXRoIHZlcnNp
b24NCj4+IDIuMiwgd2hpY2ggY2FtZSBvdXQgaW4gSnVuZSAyMDIyLiBJIGRvbid0IGtub3cgd2hl
dGhlciB0aGF0J3Mgb2xkIGVub3VnaA0KPj4gdGhhdCB3ZSBjYW4ganVzdCBkZWNsYXJlIGl0IGFz
IG91ciBtaW5pbXVtIHZlcnNpb24sIHdoZXRoZXIgd2Ugc2hvdWxkIGJlDQo+PiBwcm9iaW5nIGZv
ciB0aGUgbGlidXJpbmcgdmVyc2lvbiwgd2hldGhlciB3ZSBzaG91bGQgYmUgd29ya2luZyByb3Vu
ZA0KPj4gdGhpcyBzb21laG93LCBvciB3aGF0Lg0KPj4NCj4+IFpvcnJvLCB3aGF0IGRvIHlvdSB0
aGluaz8NCj4gDQo+IDIwMjIgd2FzIGp1c3QgMiB5ZWFycyBhZ28sIHNvbWUgZG93bnN0cmVhbSBk
aXN0cmlidXRpb25zIG1pZ2h0IHVzZSBvbGQgdmVyc2lvbi4NCj4gSSB0aGluayB0aGF0IG1pZ2h0
IGJlIHRvbyBlYXJseSB0byBsZWF2ZSBhICIyIHllYXJzIGFnbyIgc3lzdGVtIG91dCBvZiB0aGUg
dXNpbmcgb2YNCj4gbGF0ZXN0IHhmc3Rlc3RzIDopDQo+IA0KPiBUaGFua3MsDQo+IFpvcnJvDQoN
Ck9rYXksIG5vIHdvcnJpZXMuIEkgY2FuIGNoYW5nZSBpdCBzbyB0aGF0IGl0IHVzZXMgdGhlIHJh
dyBzeXNjYWxscyANCnJhdGhlciB0aGFuIHRoZSBsaWJ1cmluZyBoZWxwZXJzLiBJdCdsbCBiZSBh
IGxvdCB1Z2xpZXIsIGJ1dCBhdCBsZWFzdCANCml0J2xsIHdvcmsuDQoNCkpvaGFubmVzLCB3aGF0
IGRpc3RybyBhbmQgdmVyc2lvbiBhcmUgeW91IG9uPyBJJ2xsIG1ha2Ugc3VyZSBpdCB3b3JrcyBv
biANCnRoYXQuDQoNCk1hcmsNCg==

