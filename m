Return-Path: <linux-btrfs+bounces-5246-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FB28CD047
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 12:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7BC281E7E
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 10:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D86113FD66;
	Thu, 23 May 2024 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Hw73PZPa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="X0vOFZp0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC3078C8B
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716459830; cv=fail; b=nJJ7dv5UrDBIpzL+3hKm4/LnvKxfKksnbt2bfbW/+d63k6SLKMskt0b5OAOTzUe9xaMYLMB14HtoWFr0uv10iFDuGYi3MLs5GbUcRL5332bOEcmGqjfhbq9ef3b6Quf0512Ob6o6m3lKzg5us1JcNsy0GQ42wUukNPP2R+WDSFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716459830; c=relaxed/simple;
	bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p5x4l+yfIRVFNp2xe8djkodMax8WGP+bcGV8fYD4LS6Gm5Es7I63X7Q52ixSb2sk2uyO37NCnYcrVRJY4QK2DzKnQP5T0AXKqaAsBcWqmZEiipkO9IlT+gGgkStXE1Fk8wxy6mRWXW4lOLlbrhdGkN41AQSA+Jb8/l19MedxMok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Hw73PZPa; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=X0vOFZp0; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716459828; x=1747995828;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
  b=Hw73PZPar1SS1S2d6+tKUb6sbkBvYJnw+xVKSPlP1+Yv+uMXoFLJBFg6
   wKq0lr8/jq4QtH3MELOg1zhDtKbcwM2fjPxXbhYa+EopreCtmkdc5II++
   TtzBNQvQEP5ll7i5tewW5xeQI4Mfosog5cwGLYrfzzOCAZy/lRAtCB8gB
   2RwSvffOuBT9FTdupzOX5Fwmwn/MjJpRdcldqmGkg0jfAp49fkan5/QS3
   q2/ZNYX852EevRdbtkHnnCa9bW2yWpP2AaLY8Tni4/uJlaikbsSH4ir1a
   lRUP6aJ+OmsQEdqSwqBJ/1nmk6JgpG09jRIAPW2qvI7XSFRe0D6PRuRnV
   g==;
X-CSE-ConnectionGUID: PzrbaskVTvuQmHacMD8cIQ==
X-CSE-MsgGUID: QCR0L61VTzSZLq289DFR9A==
X-IronPort-AV: E=Sophos;i="6.08,182,1712592000"; 
   d="scan'208";a="16801360"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2024 18:23:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXK89sefMgsbwvD5bNBzzZI1C9M+E97w2EO10XcBpaAdNiP8U/cHjUDEGcgA+8TPB434KrwfHzcYrSIebCriwtaVAp+KiB7v7UUz40o8hSHFbVpbqn9iQQY5mHwSQUNONLHtHF8pDk0WuehCqAA08F/fPPWQQ5hREAqcr62BnGKawvyCteMPtfT4m6ld8mnE2qkCFAzuRQ5ajsIoiNjTA4yU0A6kX69H3SE7b8iI7st/JUcl6QeZV569JvdZgCLrGWy4PxpAS2y7sdaQXaUbNrL5VoifhcAjGIm5onNhqnBQfUZmBOUbmT3oQN+q0mK+UQUrxFYil4qvEko/x/BOAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
 b=YQgZYs1BaaE9OYCc8QHCBxqJZ8HBejNCg9jX3pYdmsokTpArAYFvsVyGrG+NudSie/Aws29HPqeoHv/bBl8ICi41fNdmBujuEch3TRrN41E4RGpOo+MhRpPeNzFmJf2cDoZN1DOczyLS0ff588z0Q/0lY7isB+3ym6OXJGJRbqsOQfh5RVAYbbV4CYwWnqBOoN+35cyRGuHD83JFi0nABOwK4HgNhs7LT9j6ZKt6PejOICHLe0Pj02/p5mFn5fTw/hiDlw7mifV4d7pdpeVCwAdVWz3Tc5E1EazL4kTLzh1+blG9wcqY/WzVf/LyL6A8Dbzxfe26tzZ1XaIDOfkZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
 b=X0vOFZp05Jy5HNeygyZFNqTqlo68+rgoMVgk85k0fU20gKF5D+FeVMhKypcj0D3HUUB4ptRkORQkxiftZ1Hc6SRJ7VppK5jDCfa83aVqJr35+NZWg6a9pQr4ga9edw0asP8Sp44Sfj3Rr8rwwhYzeCd+8OX1mKlxnsvV7vFUCM8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8612.namprd04.prod.outlook.com (2603:10b6:510:245::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 23 May
 2024 10:23:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 10:23:39 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 00/11] btrfs: extent-map: unify the members with
 btrfs_ordered_extent
Thread-Topic: [PATCH v3 00/11] btrfs: extent-map: unify the members with
 btrfs_ordered_extent
Thread-Index: AQHarM6kIAiLOeHrLUeDAkZ0+PFG7bGknPCA
Date: Thu, 23 May 2024 10:23:39 +0000
Message-ID: <bbb9bd2a-2079-412b-8edc-2f26239367e7@wdc.com>
References: <cover.1716440169.git.wqu@suse.com>
In-Reply-To: <cover.1716440169.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8612:EE_
x-ms-office365-filtering-correlation-id: df96d44f-145e-4f24-324d-08dc7b126a13
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?UHlsNHhraDhpKzdWeTNPTURrWVlWeFRLd0NHMGFhdFRLOStBQmJrTXFTRTg4?=
 =?utf-8?B?MjQreEpUSmFkQVRWWFdsYll4VmNvUEJFSzMzZGhpbVVPb3JyMUdwL2RkUmVr?=
 =?utf-8?B?T2lkL29tZGR6dUZrcjVScnBIRFVxVVZkaGlvVHNKS296bmdkVkQxdXIzZVBY?=
 =?utf-8?B?S1kwNlJvd2s1VGVXK09EcEpaMlJEN3NVeHh4MjRHdDZJZHg1UnF0OXdRdEFi?=
 =?utf-8?B?Z0RTRmRiM0o3SXVhelR1TE1xdElhajZnTXF2anRYYU12MUhyMHVMTC9YUjFn?=
 =?utf-8?B?MTk2bEVVaEIzQjIwZzM1UXBvU2tNNmRxallwWW9EMFJtYnRYbXNOYTFuQjNi?=
 =?utf-8?B?ZUVuWHZ1QWM2SWh6cktqTUhubTRtdWhhWHJ5T3ZqOWw4WEVteC9uWG9jZmVR?=
 =?utf-8?B?MUJLSU84aWlaYmJhQnY4SWxzWlVkK3o0WWRTK0NEVExrd1QwYmZGMTlYUlp2?=
 =?utf-8?B?NndFTTRUUVh3dzduaUFIVkloNm5WbDhuOEl2alpjOWZTSmdRMjVZd0NaTnda?=
 =?utf-8?B?NFQxcTBoZGlyQUVhN3ZnT3h6eDV0ZHBQcW51VDYrM21naHkzVzYva093ajhn?=
 =?utf-8?B?TWdXd0lRRkEwWUo1SnZvRnlMQTMyelpWVGtCR3hMdWE4cUR2SkZGc29lWmRK?=
 =?utf-8?B?Yk1pTGpCTDFCaFVnNnNTeWg4dFljNlBFNlhmVFJlYlVteHVUVWI2YXRxSjgr?=
 =?utf-8?B?Y29kK1BYZ3VudVBLTy9pam9UcHljTE03VjlnbXYrMlp5azRzQzZGU1Zwc0dU?=
 =?utf-8?B?b0Vsbnc4T0JZVzlmY05pVTBKbnNDWVJrMzhGZjNWdnZHZW9GTlV3VmxqRHFP?=
 =?utf-8?B?NE5vTjh0d0VkWlBvenVob3kxeGdod1M0Z3cxd3hkRG9vckUzQ1FHYmRxKzRl?=
 =?utf-8?B?R3FWeWhTbk9obDFYdVBPMFg0OXZONFd1MEd5bzkzZ1BjV0plcGhNbDd1R3JD?=
 =?utf-8?B?cTNtWTU0bzZTTG5FQlI1MzRFaXZHY0kvaUJTRFJUR05LTnlQTUhXTytCMUxz?=
 =?utf-8?B?aVlqbitnc1hqajh3MUtuYkd6WklodWN4aU9JT3VNRkIwN3lCQXJoc3FQUGtR?=
 =?utf-8?B?M3V2eXZGclc1UjhjeFl3ZUY0Qy80bmp5am9oWWJUTXRNRGFaUkhPcjFtNG13?=
 =?utf-8?B?TmNjK1FFeVZqSHN1UFJYeFRaM3JBNlJHRWtJREVydklsT0JRUXBhcXJlOHN0?=
 =?utf-8?B?Q3BTWGZwb28xNDVIekZDUkdnS3lnUHdwYWpsblpGdGgyQ1hPU004L0Q1Y05k?=
 =?utf-8?B?Q1o1dzRlcTBIQVVUTUQ0Z0kxYUc3dDJwQnNrMFNUWE1DRng4d1JRYk12Qmls?=
 =?utf-8?B?cC9hSXY2U1dXcCtnK0EyUlY3OUV1cWpNZnlFdlRaRjlnSHJVakxZRXJkV25T?=
 =?utf-8?B?UDRXWFRLWXNJbWZ2SlBhYlMycmxOVTM4Yk8xL2NmSFZvY3lwNkZTN1pqYmVj?=
 =?utf-8?B?NGFRT1kwbWZRdW40WVlDL3diNk9GRlhkVVBEQjUweUU1TjhDdjM3ZEo1Qktw?=
 =?utf-8?B?Z1AwVGlMMDZyWS9vMjh5c0Z4VU1lbjdHaWVDb3pNY0RSa1FhaXZoaWlIN3RJ?=
 =?utf-8?B?REY4VlNrVzBuZEdEK0lmOEpJYmp1L2pmaUxtYWEybnJsRXdaTlZocmNpVnVn?=
 =?utf-8?B?WHVhVmpHbkJ3ZE5PcnRQbDBHSURFbHQvQXhJUTZTUWRsNTlYNCtIS0o3UG91?=
 =?utf-8?B?Z084U0RxMWhhOTk3cTdFSllMb1hCMmRtNnVZK0J2YTc1R2FKa01GWFFlemJQ?=
 =?utf-8?B?ME9LUGZ0V0dzK211Y1BtamxyRjF4RXhmQUhjdUxFaW9nTDVkZ1h1SlA5Sllp?=
 =?utf-8?B?cnNCMDdiNWQ3NDlZNldFdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NkQ2Z3IrSUQ4bmdwZzlJTllMblpQNWl3cUcyQS9zbUtLTkZKK2w3OGhpTFBp?=
 =?utf-8?B?QmY5Z25nMm1NM0xqVHh2WTQwSVFjZGR3bDVZQ3NtVGVCZnliWFZjeGlFTEhV?=
 =?utf-8?B?ZVN6U1FUZjVjWWFGS2ZXS05ML0JYZFFIb2xmWVp4M0syRDYvNmE1cldMNURK?=
 =?utf-8?B?bFJaL3Z0NEF3SE9tZkpkUTFaY2ljNjRRcWRxOCtUWExRcDZMUFVNZkNTSVRL?=
 =?utf-8?B?NHhFVkJIenFDbXpxZ0tTU29WaXhCcGRXbkxHcDVSMVhTcUxuajJYdGZ1ZGRN?=
 =?utf-8?B?Y0pTOStjQ0RIM0c3M0pIUTRjRzczNkVucDdrQm5mcnpDVXZrTHA0SXhmNXlN?=
 =?utf-8?B?Ym0rem1oZTZMRnpOUVRxN1JmcUR3TXN6N1JPOGdkVEwxOWowaHNGdlhuVzdN?=
 =?utf-8?B?NnNYWkgxZHlGVGJISkhINWRocitEaWZpY0R0VEo2QlMyRGZuUERTaHdUUDdV?=
 =?utf-8?B?Qi9sN0VTZTI1YVBlVVdHc3VxNnJLTllPT3Q3ci84ZjJWd1JKVWtBY1RqTlRN?=
 =?utf-8?B?VEJOa24vbXllU1gzUjdiWmlHVVdBcGU4Uy8xK0Z2YnZZZjg1ditVUis5dWZy?=
 =?utf-8?B?SHNobVphVVlPeDdjMDl6Q1l0RldUZ2lTNk0rcVRsS2trbWRQdlZBMjhzMVVK?=
 =?utf-8?B?cktxRlk4RmtqTHNDUERXS3ZjdCtwU01oOFppUGNZWHZhVEhnWUJ1RjFFREJE?=
 =?utf-8?B?TStCNXNVb1RKcjhKNkhLQVpxQXFkNEI5dUlONGQrSkRHNTd3cFlnTjV2eGxY?=
 =?utf-8?B?ZlRFbXMyd3pWOXpwK1pjYUFUdDhVRlJvYzZSRzFwZks0ZHU0WHIyTUtNQzhw?=
 =?utf-8?B?enN1QWNXbnIwcU5vSGpueXZkdnhQK2JjVkx2MlI4eUU5UDJXd1NDVnhrZmNR?=
 =?utf-8?B?eWxWa3BJcTExUWQ1MEREREtmbkNmRENJdVlJcTRCdFp4VmtMQ2x0K1dQaENv?=
 =?utf-8?B?QVN0dFRVNkpxem81QkErK3diNzJsdzNGdjJOZy8wbTBqOU56YVk2REtLeWdK?=
 =?utf-8?B?ZW9FNnZOMHNIbXpzQllWR0tGMjFBcnE1YUNZcm04S3hyMmtZVWZpVTI0c0dy?=
 =?utf-8?B?cW9WVExwd21PU2RJZUxZUytkalc0OTkxcUFBWk0vYUhyN2RGQWgzRXdOdmJF?=
 =?utf-8?B?RmRuMUliSnBSaVFiWXM0d2UrdENrZjJFV2RpZjJnY0J0RFdSSm1VdE5TcVpH?=
 =?utf-8?B?TmxuUDZNeGY1QU8yU2ZCbFprT3FrVEdhV3pTRGFSb1ZUVFFyc0Q2YXh5UWxv?=
 =?utf-8?B?dVRDaHQ2SXgyRWZwQ2p6MUJMQ2h1OVRWYU14MkppSkhPNGJzTDYxWEtsTWhE?=
 =?utf-8?B?WFk4SDAwOTR0TXp4NUZyd1VpR2VCQ2dybkhVWDF1Smt1SElEVFlrVSt1dndj?=
 =?utf-8?B?SkNuWmkzbUozV2NTZWhPZ1B5ZVkzSXU2NEhoS0NoanJDRU5SM3NiUndoMDgr?=
 =?utf-8?B?eXJBNTM0STdjM0dKMVdBODFkdmRWQVZ3OXAxM0VKVi9wZGdqaUpWMFZCWVBz?=
 =?utf-8?B?bGlxQmdoMGRqZFBLM0t4NTJ3WE1lbTh6MUF6WmJTdk9oWTFneFJRU1VIWnNo?=
 =?utf-8?B?QzUyUWwxOG0zSG5PbjhMRHNjaEVPWDVVQXJpYUszUWNIUkR6bzdmV3lCSW03?=
 =?utf-8?B?cXVSNjZpb3JtaENTNVE3ZHlWcHBzN3dON3hwbWcwUXBnRTg1MlJtVDBnRFNO?=
 =?utf-8?B?djlLYmYrT2lWdXBjRFNQTnVUc2wvRmVqVnA4SWR6c2NCYTQ2dDVwL1B4Q3NU?=
 =?utf-8?B?QUIzdWZMNzAveGEyWSs0dUFBU0dKT24vSVJJK1dsZjM0cmswd3UzbFVWN0tW?=
 =?utf-8?B?OTVwd1U3NWNoOFVrTHUyWTdXNkFqN3hVbUdORklnVlNGZDNTaUZ3TTl1TDFE?=
 =?utf-8?B?Q0o2MzRhNHN3TWNBOEZpWWd4bnI3bEpSbndQTE1wNXArTjVtRDNObHpJeTFY?=
 =?utf-8?B?aUtrME9kUGg5ZTF2V09zUnYveTgydnJFSVgzV2NaMjJGMFNMTUVqTUdONGRQ?=
 =?utf-8?B?WHdIYW1mNFNBMnAzRGNsUWh5V2V1TDkrc3NJai9sbmRrTHYxSDBRYU0rNGFr?=
 =?utf-8?B?N1pUSG56R3NXL1FoYzF1cEs3OGNJTDY1RWRYT2hnREU1RGszd3hvdTRHQVZp?=
 =?utf-8?B?RzNqT01ndGdUSWRPd1gwM25VTmZRRkdDUi9SenBMd1NJTjRMUG5jbUZCNlZB?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D4DCF57DD286A45B00E644E760DE197@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JMrphJFFNwj/WdDs8ClIJ7NHi4OcAazxZmMVk49oPh7f0SqClCYGUis40ZY+wDNanv3UP9+1l6c8gwSeeePWBHQ69JZju+VIGbEHFFEWFExn1rAAR/sfzBj0Clhi96xmKgF1dNbJrKdioFlAng2Oi+PfTJpyp7yMJzTzSSSnoH/l8WtR7U1nhm0uO1XZiwEgYDxbM/saelxMP5oD93o1JFi19x3YtgahBD/5vzvexH0dTYldBKYE2b7T+5U9M7Iu9Zs81iNkpbtqhgGaV/DQ7RLlRJqHrrkS5uYmZThUVrz8ebNysByeCcVBMrl0Barieaomsv7zmn5Pi71aSvL6UOkvgn49ovrQ2u1difmVYrBQWHtFO5RXUnMbDuP0gMGNLBoH3HGjWGeCTG6YIQ9eK2v+vpbSvFVBFBrXauMbrcwhmYvzqQYz/Xm2YigwgS2QfMn1DBzEsZ79+9uwi62IgMh21t2Wz9x8BqsWFb7G1E5GkXqVQ1hMLJi4MNBKxQLrODBL8A475RNCE2wvyxpJHQnG1XQNLQxv5dlGkFGhV/sPPaUHysH/3yL63txrkaaHCuz1VsUbjZMyzUjdJynLtnTjRG+et5NsmYL2xig/RKQmF7fu6YM7xxIkIS7EcnM4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df96d44f-145e-4f24-324d-08dc7b126a13
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 10:23:39.8486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LxNyI4mMloo4LQg6qNjNBVDaKxsEPd1kbS9rsXgBVx/9GssgMunDG9NGoh6xEv5JJGn/xHwotspfH76ENTKnBLGfQbGDzYTMOzNNaPIFuzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8612

TG9va3MgZ29vZCB0byBtZSwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFu
bmVzLnRodW1zaGlybkB3ZGMuY29tPg0K

