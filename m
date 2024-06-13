Return-Path: <linux-btrfs+bounces-5716-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61842907B41
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 20:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79701F23497
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 18:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB37914AD23;
	Thu, 13 Jun 2024 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jHynM702";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xX2zkrOe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B5714A4F3
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 18:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303251; cv=fail; b=ajyckRHPOjNVLN1/jqHK6ibg/k/E3OziCE/3jLOwjkh4+wWD6Z93o8Zx5ztrsOYPxn76b6BYcuHsyLsVA1bPdsd0o4DJhKhDD8DixMUBd1gYP1MIk3cu+WBIPbPsr2yWwyltkWKIdFiBczNxSyFSGCnQmbuR8J9XvzDfo27BwWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303251; c=relaxed/simple;
	bh=WXccLbF3+C3qgOTP6SsEF71SxLNRuLbBqX2HY7EYrR0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HRAQRADYo0/nM8vfm1dAqA2JJehlXpn9T8mfkUSct0oYwycNhrBWHf5VznvwIH6K5hb2wbqKFrqiBRXrxgqNxZxTK8JMhjhplTZMJSrvBPhKDigAZOWNtz+hASYpJH9w0q/lO2CLii9HJagyP1ui/wEnjFQsTuUc1J0/EFJeKok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jHynM702; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xX2zkrOe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DEtT0q003164;
	Thu, 13 Jun 2024 18:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=WXccLbF3+C3qgOTP6SsEF71SxLNRuLbBqX2HY7EYrR0=; b=
	jHynM702LHwfMtB84dR+hg90MwDVNDC+y3nxQAXy1XY9OQXGb5uigEh4zFW/Lfg+
	eGdtHp0fFwRdiS5VwMN2JFTdkiKtb7uOoISd6hyND9K2T27yHFdp4/lHSYKwR8db
	Z+RLSYHG2syP/zNaLfmVDtaV5AhNly//S+Gq1OaaH6L00zEIHYJwMffX2Gf5+l0L
	mUSsll6megW4ihu5bZoRI3FOvQP9JDYPNREcDen0qnxaXrXDH3/AE9Gh6xIpxL1K
	sBBkPIlUB1YGlJp7j6hzjZQfij7PCCABnrxZQABVzo3SXYkQp0vjiShQDsH+8TGh
	QSHWz2kVOw8m1P9VjVUKrw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhf1j6xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 18:27:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45DI1t3L014422;
	Thu, 13 Jun 2024 18:27:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yncexa5ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 18:27:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3s2FPQ7SEUPB9oDNfx2lpM9f3ukAHm3CBcpo7oGQ8F7hZ8CZqg0TMToV7mkzECb/E1c+ymQzxNJDFvoaBOMRRywON7J8jLyxG14rPaZ2aqkVlHzUH4rXgBr0atRBdsxrNPYWumaJ9HG8tBdjhxZUGInyp/SmBCC4N9XVlwoM7iD1m+6l8UFVctHhfktrbJl/Xyo3PKATQ1i8EG2m73okPnFRgWBxk4V2cG0BXXOGclCKvNujZWaP4wzB4M7rvq2xfqbe/whI1akRG1D/U1Fob00ChTXDbaRwxPIxqFokLBt9Vx7juAJoJkgANxDIgBweKKvsoxuuaowRq1A2DYPGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXccLbF3+C3qgOTP6SsEF71SxLNRuLbBqX2HY7EYrR0=;
 b=mfcgbdE8WCE54JF5jtk797mVBETJ+A1Ai1B87IG3gFAhMfq24SvhHkEDIK9OPC2KFkFlkXSyfAvWUeWdXRp+PKGR50fm+a/ltsAegMi/nesbaEt5UHGFx4aKNpXmwaJHJdr9HxZkLSHF9bCxQ0nPwHcT0S63QOhVUU81s+sZHjd/ebURn+SE187bkn4hz2U5EtpE5TrH1dFiUBoQHfwRCzF8F0sGc0zcvSTMWs7uAttLtU6YgUMV0ateb2ZSGnjB1QtExmT4J0IBkl9PpxGFV3RDySK3VkNTv1XwStRKD5p/VXTGzde63JzCQ+YOnRLqITM19UQwzWzJ5mtmceokiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXccLbF3+C3qgOTP6SsEF71SxLNRuLbBqX2HY7EYrR0=;
 b=xX2zkrOeKFUAlzKITsPMdfeEnSTNIvsUBhFF0d0xenlF97ovAu3pconxb+Q3LvuXkBkP/zjEIDY09NJH0AyByEMIc7qndjCa4L6bWENa0g1Nm5jAOspqomU+COCPQFqLYt80o8cHfVxb5FNFaw5KRwamEn3DIBpnhkWCyYu/wqk=
Received: from DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11)
 by MN6PR10MB8167.namprd10.prod.outlook.com (2603:10b6:208:4f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Thu, 13 Jun
 2024 18:27:11 +0000
Received: from DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::1e9d:8ed8:77a6:f31f]) by DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::1e9d:8ed8:77a6:f31f%5]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 18:27:11 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>,
        Rajesh Sivaramasubramaniom
	<rajesh.sivaramasubramaniom@oracle.com>,
        Junxiao Bi <junxiao.bi@oracle.com>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
Subject: RE: [External] : Re: [PATCH v2] btrfs-progs: convert: Add 64 bit
 block numbers support
Thread-Topic: [External] : Re: [PATCH v2] btrfs-progs: convert: Add 64 bit
 block numbers support
Thread-Index: 
 AQHauGDoDe2/f94lNECPwQghwg/+QLHCGSbwgAKG2ICAADkTAIAAAoCAgAADYICAAADQAIAAB4qAgAAIagCAAR4FAA==
Date: Thu, 13 Jun 2024 18:27:11 +0000
Message-ID: 
 <DM6PR10MB43473AAFD299F9DF31189F41A0C12@DM6PR10MB4347.namprd10.prod.outlook.com>
References: <20240606102215.3695032-1-srivathsa.d.dara@oracle.com>
 <c3060faf-f0e8-4bd2-865b-332e423a8801@gmx.com>
 <DM6PR10MB4347A0EADF68B973447C5591A0C72@DM6PR10MB4347.namprd10.prod.outlook.com>
 <20240612203743.GQ18508@twin.jikos.cz> <20240613000200.GS18508@twin.jikos.cz>
 <cd0fca3a-94bf-4913-882f-ee433a61e06f@gmx.com>
 <20240613002301.GT18508@twin.jikos.cz>
 <2d1a8153-274b-481e-bb0a-63504d1cbe01@gmx.com>
 <20240613005255.GU18508@twin.jikos.cz> <20240613012302.GV18508@twin.jikos.cz>
In-Reply-To: <20240613012302.GV18508@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR10MB4347:EE_|MN6PR10MB8167:EE_
x-ms-office365-filtering-correlation-id: 6ef0b135-e9ef-4af9-0448-08dc8bd67134
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|376009|1800799019|366011|38070700013;
x-microsoft-antispam-message-info: 
 =?utf-8?B?M0sxdmkxQTlhbEc5ZGdpanBxY05SNjc3elNIckYzc3V5QnltME81cG9kcE9Z?=
 =?utf-8?B?ME9LTDV0TmhIMHBoYlJqNHFhTmU1U0Nwc0pHTUxwbFpSWFdlSFpDVDZNZXlt?=
 =?utf-8?B?NTBZWFdzTHM2SG1KMUFCcGxlT2x1OUUrMEpTMkFuZy9VWVl2K2pRd01pY2lN?=
 =?utf-8?B?NXlnYTU4SGprZXYzcXczVXAvNis1UkdmUDNNRnlIODQxSDVQSHNud0VybWJM?=
 =?utf-8?B?aWFzN2plZ3NPcTNoa2MrRUZsdEtGMTlqRlBMNDlHbXhXZ3BCeDFLOHBuNlJ5?=
 =?utf-8?B?Z0czclg3ZEpYWnJxQU1DREFUMmVuSURaZTNrUWtxV09uUVBmdFdFZUlnbHBp?=
 =?utf-8?B?WWZmc1EwOExYQ2ZoMFZUUEd5TnNWTndWakhyV3REOGYyUHJSMEZXL2Z0Z0ow?=
 =?utf-8?B?QVBkcjRhY24vb3hoZjVRNGFMYUhVSUtLenBEQmwrVGlVMVgwT3NxTjR0eHlW?=
 =?utf-8?B?L05VL01FK1J5V3ZudFNVUHVrbEF5ZTF0d2RBWkNOc3dIUUFlTU0veVRzNlVl?=
 =?utf-8?B?UnZ1bWlRVjhoMkRVQU1kWVAxMlg2cTdvK1MwQXFKdTNDT3M4ZnJ6VVRvYnYv?=
 =?utf-8?B?cDBpdUJiaVhrWlpJa04wVUJPamNOSC9VOERIVkxUQUcxVmI0ZDZXN3lYUnYz?=
 =?utf-8?B?VjZ0NHM2cE9oQ2ZES2ZZU3FIWUdJa2VvRy9jMmQzU0k0TmwxYmJTNmY5Mlg4?=
 =?utf-8?B?aTR3ZkUrU25JVlZQZzZwNHM2OTRERnBqMVBKaHVGN25HTDlqU0pncFBWYjMy?=
 =?utf-8?B?aVEvdndieUhQMkkyWFhRaDJyU1MyREJydGJISzdSb1g4L01yViszRGpsS1I2?=
 =?utf-8?B?NkFrUloxR2s1S2owRUlISXE4dTRSU3c4bHFkeFBKMHdLdVNhREFCRFFlVXFN?=
 =?utf-8?B?eWRQUlNsWENRM2lKNWs2VHBOc1E4MlZIdFFYOHJmYlRRWjBabVRGbGxUemdj?=
 =?utf-8?B?OUdKRHRGaVIxQVA2Z3VKamp4dW9oZW5hZGY0a0doS2ZwQjY5YTExTU9XdERX?=
 =?utf-8?B?TmJ6VFFSMlN2NWxMelpMcjBNL2NPdDZBcm5kOCtxallRWFg3ZmNlanMxM2ZC?=
 =?utf-8?B?MkFMU2E1YWwwTmp2elNtZ2NhMTlMNm9TRkMrSVZHbi9CZi9jOFJLNkFNOWtC?=
 =?utf-8?B?ZU9xNXZGY0RIVEQ3N0ZlZXp1ZU9Pb3E2TW9VeDVJY1pXVGVuWHN2cDlMOVlE?=
 =?utf-8?B?aDR6WXkwOWRkUnB6aXZ2L0t3aXk1cDREZmhyTGU0bUN5UW1UK3VTZ3pQZGxX?=
 =?utf-8?B?Njhud29TK2MvY1p0b1ptOUV1SWUzLzBqUWpveWNHUG92NGtNK2lXVUk1STZB?=
 =?utf-8?B?RHFEcUVyd2ZSbUh5d3F1UVFKcTZLVGVDOFBLbVcwamFmL2FoclFtblFqc3Zy?=
 =?utf-8?B?OUkyZi9tZ3lDTzc3T3RQenJoRjNJQmlLazk1MG9FbFhWWUZMRDVjYWJaanV3?=
 =?utf-8?B?WGd0dlRoNzNaNDJlRnhhYWZuNXJaanVtZGxlWUgxM2lqdGVxOXZQelZYdkF3?=
 =?utf-8?B?TjlmTk4yWTJxSFk2Z3E2MmpNbDUxRUN2WTFyam1ZZlJTVmdrRVQ3cE50ZGtp?=
 =?utf-8?B?bGY1TGdHM2VYNnkwenNuT001OFd1MEZ6a3hUS1VsRDNURFlwN0h5ZkFlc2Iy?=
 =?utf-8?B?KzNZRVBOaXlPQ08rSmVoQ2dWcHlVVHpabGtHLy93NjhWZitENUVlVTdmc2VR?=
 =?utf-8?B?RjR3YncrdHFIUXFvNXVSaTJpVEdybVhvei90RmNhZFFOR1dlR2lZc0FGQjhr?=
 =?utf-8?Q?htN10w9DWgXsNQXLtI+ItbK8jaf9FIw82tU1bmx?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4347.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Y3EzcGFsUWRibUQ5eWtJRU5YeHByVERhREZTZDl6UUs5OVZZRkVWdUw2OW9Y?=
 =?utf-8?B?RnNRUzM3L2llT2UvZTByKytaTjFYR3hkWmJyaDJFNVVtZ1ZFMkkrZmtrN09P?=
 =?utf-8?B?Qkk3SVprMHo5aHdLd2h3QjFZaGhNd2FGajNRaHBXSGhEcFhicHFVczZhNCtP?=
 =?utf-8?B?WEdiN24xdHdlR3UwVS9yYzVyOGtTVHVoWXZ1ejJ0WlppM0Y4N0hUcFNnNFBQ?=
 =?utf-8?B?OFc5VEMxWFFINm1FQUIrNjdhcTVnck8vb3IxWWVvTGtELzZUQWdQSW9DR3BZ?=
 =?utf-8?B?YnFKVmx4bHJFbWhJT29SQkJxeDkrcjJzRytsVjE1V21yeVJVV0hNSTM3WVJn?=
 =?utf-8?B?TmxGVlRYZHdYTDZNb282TXN2TU1lUStZTXFDUlo5UUQwRWJXd0l0ZTM5c01B?=
 =?utf-8?B?cm9qRDlIblp1M3BYbzFudkdMczFVcnErYmxodkUwSTYyMVo5VU5SNkNSNHQ3?=
 =?utf-8?B?ODAxb1ArR2hBSVJCUExwM3VUWkVyNkhRaExhZmdkM3ZNdnJNRUcyMm9GbXN1?=
 =?utf-8?B?bWMrdGVLTWs2ZmxpZWg1M0xabUVSUXZrQ1hpUHZzbW5YQWdxKzVCTHJyY05k?=
 =?utf-8?B?UFh0ODRINHdNZTRBWk02MjNqRmhnU1BuSGtXNVowNTdyZVc4WVBycTNaQjk0?=
 =?utf-8?B?YS9CaENnVmVYR2FRMkNMVWJFUmR3dFFnWkFzQWZCU0NRWTdzbjMrMm1pS3RB?=
 =?utf-8?B?bGhic09kcHJHNUpnaGFrMXltdkxDSCtZbkc0Yjk1L1VzbGVmUG5jTXNrRXQ4?=
 =?utf-8?B?b1l2ZjhBUk4wKzhPVC9rQ2hQRXdTSHV2TXBpNDQ2QmlQYXVVcGZEcERIeTlY?=
 =?utf-8?B?MytqTFAwdGN4RVRnVkorMVpvbW5ZS0tRQ2dQT2NPVW1WSXJ0eHJVYTNJV2Ju?=
 =?utf-8?B?L3FBekN3YXVFVUxYU0l1NTlSZC9uWGZUMVpGdzNieFA1S09oZnBOK2FyM2I0?=
 =?utf-8?B?VFJVQ2ZteC9BLzMxNEt5RGRlcGJaRG5wU3dxbDkyVGtZekdWNFV6YmF3MFY1?=
 =?utf-8?B?cGxtR0tKRXBVOFpNY1E5TEhLKy9wZGxJeDVGZDVRL2lIalhrMndLVXJCVkdl?=
 =?utf-8?B?QmViS3c1RGM4dURlL2Q3eEwvclJGbjBVdHVkN0pTems4YUZIR05seDJYUGhX?=
 =?utf-8?B?WnU4anZnOFZWMUh5b1MzcDIwOWVIeno1SHVqZGJSWm9mSTZ2ZVZldlJRWWww?=
 =?utf-8?B?RUc5bVJEM2lqeDVOdVdtYlNGQWp2NzNDdDRKNExFV0puQS9mMmt0Rm8wdjhI?=
 =?utf-8?B?ajJLc0oyQWlIYVIySDcyT0hHM091WHBCTm90a09zOWJnOW9LWkhyTEE3ODhI?=
 =?utf-8?B?cXNwbUltV3B4b00zK1hHN2VrMG9YOURBTXpad2h3Zm1hSXFXSEZCOXlrZkkw?=
 =?utf-8?B?K29LVitMcmczMmxVUmtqb1ZHQTNNcTJRc2xJYXRJR2crZ2hUR2Z5UFBrekUx?=
 =?utf-8?B?OE84MXlwOVUxNWxYaVk1YVYxV3lBRHZkYkUwVHVkVGFDQnp0b005SVc0eGw0?=
 =?utf-8?B?cWZMNXR1cXViU3A3WDRCcHYvRlJtTi8wNVdaNVE3RFBDRXU4cDBMdEZvaTFx?=
 =?utf-8?B?RTc3TkdZSzJ3ZC9teGZYS3JVbFgxZ0ZyNVJlRFVVUUdqU0RhQlZCSWlBeDlE?=
 =?utf-8?B?WXVoeTUzRE9NNHBpWWJiWHhGditIZHMyVlg4eDRRek9mZlhXenJDbkZnb1Vp?=
 =?utf-8?B?T2VEcjlXSXZnSUZ0YWx1dFJJVkJUbEpLQjg3ZzUzRXEycEpTWXBuVGRPRTcx?=
 =?utf-8?B?MStldTdyay9rQzhsdURObmx4a2tzbXcwNGZHVTZOU3BBUTlDWmJNOGgyeURR?=
 =?utf-8?B?N3V1R1pMenJoK3RISE01RWZGc2hqQzBsQ0U4NW5sTXFEYVJkb3JpcEV6cGJm?=
 =?utf-8?B?Ky9BRndub01BVkd0WGJWcll6YVYvVU80TWw4a0pPbHZyeVQ1bUYzbkJLVjgx?=
 =?utf-8?B?aU9PdCtzWjFsQytlVFFnMituUjVMZnMrZWR5Y3E4eWloRFhJWUlxcllBMFdQ?=
 =?utf-8?B?Mk9xUFl4dmdDaEMvNmZ0TjdNMXBkRnRQMVBuLzhMVVcxQmh3RVl6amVVYUtp?=
 =?utf-8?B?SlU4U0JmOE11QmVjS1Y3aHNQYjZ3UDVnVWdOa2l3czYvNzIwcW8yaEgzSUMr?=
 =?utf-8?B?WmJuaUF1Mnd3aTgwZG5XRG9NR1hQNDVRNjhSTXI4U3IxczZvblhUUnc5M2ww?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1WqDA+behpfipV50iQTIpy/ix7l7WSNZQ7IJG0Yobh0WFtGFJz9PgdSUOg78vOaelZhZrIyMzOveridiQYaIUJzkgyUQGFnoiQbWnz0OUcQNkvJlPudIOjyZAwc5rczVU9M/qXAPcFjQsKoq4DLX16Ev6AU1E9GhgpGW6DYba8QuMcNkjoLkWYV6bhZbs4MLusMpkL9+mQglbL9fVXEZaPlpkAem6oLvmzDA/YiDG7zluqEbJ/AsKwCSYCoAdFnv91AGWjgYtWxvQMRjW6mpArBPQ0WQ0/AswPzkEnaf3RIKkvTvQYQsJCm51RSlHa7wO8D6eXH7O3nJw11k5uV9cnNQo86vaG7vETAQC/8MQgq3thdQkej0aPKytfUtoXS/qV88+vvkfRJkzLM/HzrxOTVeowHUblo1uAno/p1LlyQPnfdgl9fGNfrLcXNs+rho/PpsHmDkhQkVtyJI66wu6rJtONWA/mSoEdg9YCs137dJG390ShwzJ3WTk/5tzVF1nTH677PHu/DPJQzlhEBu9nZpjQwhK+6REiyzA+0I2XRS8xKGweYJGBdWLy6rC/ufFoxRTwaF5aTs4BnmUP7I9MMzRdBtkT9fOHdDAAOfXbw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4347.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef0b135-e9ef-4af9-0448-08dc8bd67134
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 18:27:11.8185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x5v5P0aVTP3dnFWzlatd31e0eWDDz/+Gxs++yHDxGXNY16iQXs9aQZp/8R0qLTK0GJr9MNfoEkUZX5NkyiL3zz6UgZ5F+YDU4U2IuI2p5KU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_11,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130132
X-Proofpoint-ORIG-GUID: tSkPi_7ADCcanw0iHwhg2nMvrPW7J_2S
X-Proofpoint-GUID: tSkPi_7ADCcanw0iHwhg2nMvrPW7J_2S

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBTdGVyYmEgPGRzdGVy
YmFAc3VzZS5jej4gDQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDEzLCAyMDI0IDY6NTMgQU0NCj4g
VG86IERhdmlkIFN0ZXJiYSA8ZHN0ZXJiYUBzdXNlLmN6Pg0KPiBDYzogUXUgV2VucnVvIDxxdXdl
bnJ1by5idHJmc0BnbXguY29tPjsgU3JpdmF0aHNhIERhcmEgPHNyaXZhdGhzYS5kLmRhcmFAb3Jh
Y2xlLmNvbT47IGxpbnV4LWJ0cmZzQHZnZXIua2VybmVsLm9yZzsgUmFqZXNoIFNpdmFyYW1hc3Vi
cmFtYW5pb20gPHJhamVzaC5zaXZhcmFtYXN1YnJhbWFuaW9tQG9yYWNsZS5jb20+OyBKdW54aWFv
IEJpIDxqdW54aWFvLmJpQG9yYWNsZS5jb20+OyBjbG1AZmIuY29tOyBqb3NlZkB0b3hpY3BhbmRh
LmNvbTsgZHN0ZXJiYUBzdXNlLmNvbQ0KPiBTdWJqZWN0OiBbRXh0ZXJuYWxdIDogUmU6IFtQQVRD
SCB2Ml0gYnRyZnMtcHJvZ3M6IGNvbnZlcnQ6IEFkZCA2NCBiaXQgYmxvY2sgbnVtYmVycyBzdXBw
b3J0DQo+IA0KPiBPbiBUaHUsIEp1biAxMywgMjAyNCBhdCAwMjo1Mjo1NUFNICswMjAwLCBEYXZp
ZCBTdGVyYmEgd3JvdGU6DQo+ID4gT24gVGh1LCBKdW4gMTMsIDIwMjQgYXQgMDk6NTU6NTZBTSAr
MDkzMCwgUXUgV2VucnVvIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IOWcqCAyMDI0LzYv
MTMgMDk6NTMsIERhdmlkIFN0ZXJiYSDlhpnpgZM6DQo+ID4gPiBbLi4uXQ0KPiA+ID4gPj4NCj4g
PiA+ID4+IEFueSBnb29kIGlkZWEgdG8gZ28gZm9yd2FyZD8NCj4gPiA+ID4+IFVwZGF0ZSBDSSAo
d2hpY2ggc2VlbXMgaW1wb3NzaWJsZSkgb3IgbWFrZSB0aGUgbWtlMmZzIHBhcnQgYXMgDQo+ID4g
PiA+PiBtYXlmYWlsIGFuZCBza2lwIGl0Pw0KPiA+ID4gPg0KPiA+ID4gPiBJIHRoaW5rIHVzaW5n
IG1heWZhaWwgZm9yIG1rZTJmcyBpcyB0aGUgYmVzdCBvcHRpb24sIEkgZG9uJ3Qgd2FudCANCj4g
PiA+ID4gdG8gY2hlY2sgdmVyc2lvbnMuIFRoZSByZWxlYXNlIG9mIDEuNDYuNSBpcyAyMDIxLTEy
LTMwLCB0aGlzIGlzIA0KPiA+ID4gPiBub3QgdGhhdCBvbGQgYW5kIGxpa2VseSB3aWRlbHkgdXNl
ZC4gU2tpcHBpbmcgdGhlIHBhcnRpY3VsYXIgY2FzZSANCj4gPiA+ID4gaXMgbm90IGEgYmlnIGRl
YWwgYXMgaXQnbGwgYmUgY292ZXJlZCBvbiBvdGhlciB0ZXN0aW5nIGluc3RhbmNlcy4NCj4gPiA+
IA0KPiA+ID4gU291bmRzIGdvb2QgdG8gbWUuDQo+ID4gPiANCj4gPiA+IEp1c3QgYWRkIGFuIGV4
dHJhIGNvbW1lbnQgb24gdGhlIHNpdHVhdGlvbi4NCj4gPiA+IA0KPiA+ID4gQWx0aG91Z2ggSSBy
ZWFsbHkgaG9wZSBnaXRodWIgQ0kgY2FuIHNvbWVkYXkgdXBkYXRlcyBpdHMgaW5mcmFzdHJ1Y3R1
cmVzLg0KPiA+IA0KPiA+IFRoZSB1cGRhdGVzIGhhcHBlbiBmcm9tIHRpbWUgdG8gdGltZSwgZm9s
bG93aW5nIFVidW50dSBMVFMgcmVsZWFzZXMuIA0KPiA+IFRoZSB1cHN0cmVhbSByZXBvc2l0b3J5
IGlzIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2dpdGh1Yi5jb20vYWN0aW9u
cy9ydW5uZXItaW1hZ2VzX187ISFBQ1dWNU45TTJSVjk5aFEhSWZyUHlHVXFCcno3aG5ySGJaby10
Q3V4bnJKZ0o3bGxHNTM4UUVYeGNVVmhaNWxvb2liY0JJSG14OWQ1UU1LY080aFJGWG1pNHpXTm1T
aGFjblpmaWckIC4NCj4gPiANCj4gPiBOb3cgdGhhdCBJJ20gbG9va2luZyB0aGVyZSBpdCBzZWVt
cyB0aGF0IDI0LjA0IGhhcyBiZWVuIG1hZGUgYXZhaWxhYmxlIA0KPiA+IGEgbW9udGggYWdvIGJ1
dCBoYXMgdG8gYmUgc2VsZWN0ZWQgZXhwbGljaXRseSwgYXMgdWJ1bnR1LWxhdGVzdCBpcyANCj4g
PiBzdGlsbCBwb2ludGluZyB0byAyMi4NCj4gPiANCj4gPiBLZXJuZWwgdmVyc2lvbiBpcyA2Ljgg
YW5kIGUyZnNwcm9ncyBpcyAxLjQ3IHNvIHRoZSB1cGRhdGUgY2FuIGZpeCB0aGF0IA0KPiA+IGFu
ZCB3ZSBkb24ndCBoYXZlIHRvIGRvIHRoZSB3b3JrYXJvdW5kcy4gSSdsbCBkbyBhIHRlc3QgYW5k
IHVwZGF0ZSB0aGUgDQo+ID4gQ0kgZmlsZXMgaWYgZXZlcnl0aGluZ3Mgd29ya3MuDQo+IA0KPiBJ
dCBzdGlsbCBmYWlscyB3aXRoIDEuNDcuMDoNCj4gDQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwczovL2dpdGh1Yi5jb20va2RhdmUvYnRyZnMtcHJvZ3MvYWN0aW9ucy9ydW5zLzk0
OTIwMjUyNjUvam9iLzI2MTU4NDgzNTE1X187ISFBQ1dWNU45TTJSVjk5aFEhSWZyUHlHVXFCcno3
aG5ySGJaby10Q3V4bnJKZ0o3bGxHNTM4UUVYeGNVVmhaNWxvb2liY0JJSG14OWQ1UU1LY080aFJG
WG1pNHpXTm1TaGdNc1ZrYkEkIA0KPiANCj4gbWtlMmZzIDEuNDcuMCAoNS1GZWItMjAyMykNCj4g
bWtlMmZzOiBEZXZpY2Ugc2l6ZSByZXBvcnRlZCB0byBiZSB6ZXJvLiAgSW52YWxpZCBwYXJ0aXRp
b24gc3BlY2lmaWVkLCBvcg0KPiAJcGFydGl0aW9uIHRhYmxlIHdhc24ndCByZXJlYWQgYWZ0ZXIg
cnVubmluZyBmZGlzaywgZHVlIHRvDQo+IAlhIG1vZGlmaWVkIHBhcnRpdGlvbiBiZWluZyBidXN5
IGFuZCBpbiB1c2UuICBZb3UgbWF5IG5lZWQgdG8gcmVib290DQo+IAl0byByZS1yZWFkIHlvdXIg
cGFydGl0aW9uIHRhYmxlLg0KDQpJIGVuY291bnRlcmVkIHRoZSBzYW1lIGVycm9yIGluIG9uZSBv
ZiBteSBzZXR1cHMuIEkgZG9uJ3QgdGhpbmsgdGhlIGVycm9yIGlzIGR1ZSB0byBta2UyZnMsDQp0
cnVuY2F0ZSBtaWdodCBoYXZlIGZhaWxlZCB0byByZXNpemUgdGVzdC5pbWcgdG8gMTZULCB3aGlj
aCBjYXVzZWQgbWtlMmZzIHRvIGZhaWwuDQoNCmBgYA0KW3Jvb3RAc3JpZGFyYS1zIHRlc3RzXSMg
dHJ1bmNhdGUgLXMgMTZUIHRlc3QuaW1nDQp0cnVuY2F0ZTogZmFpbGVkIHRvIHRydW5jYXRlICd0
ZXN0LmltZycgYXQgMTc1OTIxODYwNDQ0MTYgYnl0ZXM6IEZpbGUgdG9vIGxhcmdlDQpbcm9vdEBz
cmlkYXJhLXMgdGVzdHNdIyBscyAtbHJ0aCB0ZXN0LmltZw0KLXJ3LXItLXItLS4gMSByb290IHd3
dyAwIEp1biAxMCAwNjoxOSB0ZXN0LmltZw0KW3Jvb3RAc3JpZGFyYS1zIHRlc3RzXSMgbWtmcy5l
eHQ0IHRlc3QuaW1nDQpta2UyZnMgMS40NS42ICgyMC1NYXItMjAyMCkNCm1rZnMuZXh0NDogRGV2
aWNlIHNpemUgcmVwb3J0ZWQgdG8gYmUgemVyby4gIEludmFsaWQgcGFydGl0aW9uIHNwZWNpZmll
ZCwgb3INCiAgICAgICAgcGFydGl0aW9uIHRhYmxlIHdhc24ndCByZXJlYWQgYWZ0ZXIgcnVubmlu
ZyBmZGlzaywgZHVlIHRvDQogICAgICAgIGEgbW9kaWZpZWQgcGFydGl0aW9uIGJlaW5nIGJ1c3kg
YW5kIGluIHVzZS4gIFlvdSBtYXkgbmVlZCB0byByZWJvb3QNCiAgICAgICAgdG8gcmUtcmVhZCB5
b3VyIHBhcnRpdGlvbiB0YWJsZS4NCmBgYA0K

