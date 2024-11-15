Return-Path: <linux-btrfs+bounces-9704-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F28B9CF087
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 16:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D658B2D4A3
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 15:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A151D47C1;
	Fri, 15 Nov 2024 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YGocZtKz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BpUHWsCF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248B71CDA2F;
	Fri, 15 Nov 2024 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684072; cv=fail; b=uBMrOfKZr9p7CCppwX0x+VVp31mUES4FtFdyEVV6Ifq0bntiTBmZEu++Qhsa5p2p9VHf5QafzY+JX/AUJSNrhiD7jFV7rLOJTXU6Je6EGxnhQGH36aNdF0epnnZ2seObIIpwqPBNXi7BAxS7Z/lElqq8VbUTY21HreEBvcSVZ5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684072; c=relaxed/simple;
	bh=KQWapqIMFS40ZWTnqIh76dMv5rE9kLsLvJidG4i3+PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JBtQblgJtf4pzNYzLerJ59uapZ7ukIuTgy52itV1O2YExWxO79qxVpJ2GNzMpVbwHmkRiWXE84igrOjsGHE0yQO867ilNMFTiMbY4alRBEF59etrAr9LVhYf0sNABUEtPUbWVQT7H7D/5lEPUzxdzF1qwbFH4DwyfJ+RIR7Ixec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YGocZtKz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BpUHWsCF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDCQPR029317;
	Fri, 15 Nov 2024 15:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=KtZwvoR6mnWbbeEvS0HAuhTo/16wYVCFNT1BUEgyu60=; b=
	YGocZtKzWtdO1N2/gS/95Z1+6mWSmVcxwEF8cvZZN1fGzjeW+8uS1xTnRj1WwjoR
	sQ/Mo358vKy8Xe6EOZ0N6dXE56JMDldyi8ZcdjMI/0UyhiJG14mbjvMZY7laPZOW
	vGr8y3Li1RdFWhb2sk9+VmfQQLXXto7/Mgm57Icw+LlKQbNlKOFtExD9FC6tq4FK
	1dsdhBTRtc4faN/H87oeFi0dgOlRKHhr2SEg0Ko9HSdtDGc9Sxm/A3BntdJUL/9O
	EGSOFeePQE9rjWIaajPCqPxQ+MA6w2q83YDjMLlPQwugB2oX2/ZUo28ResYRB4uq
	uYX5bLWYRF60ZxjFHnOZ8A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0nwun62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 15:21:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFEeAlU000481;
	Fri, 15 Nov 2024 15:21:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbpbr0cu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 15:21:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCkHsNt8GQde8PhynOoZZywSix0A5jbeMH0oKBhLOv16D5UGB+ypR/ib0rJtKVjWwFmkDFNDXGaGo6pEfwgw/Tnq5wdX3r7PyALpdTRLVWInIOEtBDu/rzxocm5k+ur2a08Y6n6uqL+w7FTxQN1WXb2gHCfW/3WvjDk6lDZxqJA+dIUucNTcPK/rXD7QMZ8aSeSQkQYWdJBsTx55SFSENFyKraquKh22aP5NE6UWa/aQcLMUnIWXQfbfyTW4m03RyEeGjPuYOJiGzbhT/itr+AUEhuVJJTxIkA/izyUJUv9az5kVsOpljIap3OSeztaX2YZ2E37nS5xxJhQs/8ta8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtZwvoR6mnWbbeEvS0HAuhTo/16wYVCFNT1BUEgyu60=;
 b=uGOdQ+9PR50IT3xV223R5jVoiFAVuiL2h0rI4xM/a0V17i183nFvoboowDIYFG28La4mkNVBYp/1KXj5OyVlg5pMCXcOTs5pOycDHWF8KxdJMfXTeKh6fIxVYlDpSKIwOkqCfYucZBvdec55YuWrGAfHxZH6g67LOCk0B5RkSxLwPfl4tCQ2zzkN4LfBoDOFmDd9OGxT9ApJFq9VfRFwauNWBY9KYASqh0tERTeAQ/g7IQ6F0UnIYj3J1KW9ISvu5ZYmd1JHU0aZH3Gjt00XeK6j9CgfGHrD97m7tr3s3UvlCs0r5baS5O8NZUrBU1pi3G17xGcGGDoxaCiVR2L3ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtZwvoR6mnWbbeEvS0HAuhTo/16wYVCFNT1BUEgyu60=;
 b=BpUHWsCF54M1sNdGH5rmh+l82fr3gYdirzt6Z5OaKCE31GFOz6VFxlPtIPd901Zq68yAOTuSFuJkMr1z8/VRAdF8Z5lEKK3I7Zfoq5H+V6ny+EpanNdowX/eOvsvqg8KNspsb4CmC1elHesnOlRE5QFyE1UoZWUA5K3/ikSOPuU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH4PR10MB8100.namprd10.prod.outlook.com (2603:10b6:610:23b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 15:21:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 15:21:04 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] fstests: refine filesystem module reload handling
Date: Fri, 15 Nov 2024 23:20:50 +0800
Message-ID: <cover.1731683116.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1731076425.git.anand.jain@oracle.com>
References: <cover.1731076425.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH4PR10MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ed916c-0d11-43ea-7825-08dd05891eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWlBUkRwZlpMYWhlNDBBRmNZOUk0aVNwb1MwYjhwU3hzanlJWEUvZkthWmJr?=
 =?utf-8?B?SU9kUDNTR0hoZ2ZrNlZBSE5KU3AzQWhIZHIwbXhOVEorRm5pdFJ4SW9PR2pK?=
 =?utf-8?B?L1dvK1RWVU94RGVUSWgyb000MTUyaUpaeVZ5MWRQTzFEelpvbDEvbnlrU1du?=
 =?utf-8?B?MTI5M3BpZTE1WnVZQnFuR2V6Kzl5ZTJMSFMxbXExNTJoOENaVldzOHlwWDNx?=
 =?utf-8?B?K2NFMEVxRWY0dUp2ZUhVbVFxMmQwbnA0VGlZdkNaV0RPNEZBU3VRS20zZ1dn?=
 =?utf-8?B?dFlWYjJpdDVGS3U1cHRmNVVvRkx3N0ozc1hyM01Rb3Q2Tm9ZREFoVmg5VDR1?=
 =?utf-8?B?RVJwdTVqZ0lneDRDQ2Z0em5wdXhUU3lNZWxJaFVZUGI0RnJLYU5XR3IzTlpq?=
 =?utf-8?B?ei81U0xyR25UOGkwUUQvNUFZdjJrTlUwdkJNZ1BPdEpuYWh5ZjVZcHdyOXNT?=
 =?utf-8?B?TXZ2NFQzd3ZKLzZRdlNybUhoSDNSbWMvRjQ3ODN1TXZYZnlMR0NxQWdVdWpr?=
 =?utf-8?B?bnZzWDlaVDFZWU9KRFlyd3EzTXk4VDZ4N3F1OGRyaU15Q05JV2pTVHB2NnBy?=
 =?utf-8?B?dEl4QmU1SWNWL213NUZ1OGswYlkyTW1ucjlWNWlrMlFjUmFFSGduUVBnQ0RW?=
 =?utf-8?B?UndmcHpHakw2MG9QakRhNzQzWG1lb1BSdm14MXhBZEZoWm1ncS9ldUFGT2ZK?=
 =?utf-8?B?Vmx6TW5nbXZkNkMxN3cvR3JvbHMyU0RoWFAyUFhDZld6YmhoTUJURDdKZW1K?=
 =?utf-8?B?NHdVVm5veC9YWU5zVW52OTlacnRJSlV3WkwveHh2Qzd1eUZMZVV1Y2EwL2xO?=
 =?utf-8?B?ZlV6dXVTUHN5QXJSVXJsU1ZpZ1hZbGxhWlBmeDdNWEpheCtlRGtpaFNHS3RG?=
 =?utf-8?B?dittQkp6QmQ3UUpISkpVc0FNMm41Y00vZWdGK1hxR0lhN2xhQ1JhbE8vcjJW?=
 =?utf-8?B?Rk8weGhxYy95ck9qZHRpQmJxMHVYak1QMExyRUErWXNLWFdsWEJyWElJdW0r?=
 =?utf-8?B?YnQ0bUFPMTlkbFIxaDdFWG5QTnJHckZ4Mms0Qml6UkdsaDZBTGRRRW5TeFZj?=
 =?utf-8?B?cGdvc0lpYXgvbXFiMEt5Zmd3dlRpbnZ3V0NXWG12ZFJHazVwYjJUa3pBS3N5?=
 =?utf-8?B?NjBZVU1yUllBRzJsTGwyRGg3TjV1VGJzS3JFVytsR255RFFISDBGUVZhTjhI?=
 =?utf-8?B?RGtCaDBXZ0N4d2d4VFBxRlZ0ay9TYkphZXFrUFpWOS9KSDBpZ3dQYXFkZmVL?=
 =?utf-8?B?UEQxMUJyKzNJTHFJZU1oRDU1YXNlRkN4YnhvcmRkVEFmQTVTMjZkeVVTMHBZ?=
 =?utf-8?B?VmxXRkY5WEZaZzhCRXJ4S3E2ZzVLUDUxNHE2dURWSEx4c3c2aVhuMm9HbGpt?=
 =?utf-8?B?MVhrenpmKzJFZ2lCYW1mUzNDSWJXKzdON1NEOFZORGx6M2VrZEtNeUlYUkpl?=
 =?utf-8?B?U0p6ZVRGT2RNT2l3c0hTTVJNNmxXa1ZhZDJRNDJXN2pMc09OMmtKdlAwd2tQ?=
 =?utf-8?B?WmxOcXNZTzdTQTZ6MEVFUm04eEJWaXlobFVVa3hjTTlWUnZBRWpkS1NYYVQ4?=
 =?utf-8?B?S21MVGZWVjd0bTlyUDFGYm4xci81QkMzb1ljTVdGSGdYSkhwSU9rNU83cUFv?=
 =?utf-8?B?dm00Zzk1SXJ3eCtOazlDL0wyVnp4SXptQ1A0eGVmNlUyNXYyREM3NHZyTS93?=
 =?utf-8?B?ZGgrNzR5WGMwVXVKUE5sVHBpVlZ2V2hOL3lWanJuYzRLc3pySERYVmx0c0tW?=
 =?utf-8?Q?BbLSpwxE15Yfd7/VgEE4sU1JR2NStcy0Ym4LnH5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clkwdGh6ZzRMdngwTThPa0EvT3RjdHF6dVhIT0VjVUI5RzRDRkFHRmc2b1Fk?=
 =?utf-8?B?djhEK3JPQXZtLzdpNTlRQ0QvamNockhvWlV4Yk5UTklKSkJhMUh4RkZhTzNl?=
 =?utf-8?B?alh1bkY3cHQ1NzE4NUI0N28vRS9ZS3NLWTFqeThPUHJhRjlESmNKeU8yQkY3?=
 =?utf-8?B?TGxFTTZZcGQ1NlJhZzlVekJPY0tONkFSMmdPUk5Ba0RJa29pbTc1cHQ0UUlB?=
 =?utf-8?B?QVE0YlNYRjl1YVhkdUpBVHNWTFJGSE5WWjlqQkdyQ2xWM2JORFVPS3hoN0Yv?=
 =?utf-8?B?MWZwK2taaWhzRWRBUGtVZnhMcTN5OGVsWlhZQm5IY1ZnTnJTakQxcWVPamls?=
 =?utf-8?B?YUZHSUtDdmJhSDE3bVFvbjkzOHE2ZTZrclc1dVJVWnRMVTgvK0tsUkZiaVN3?=
 =?utf-8?B?SzR4UTZIaWVxV2YzcmRYcVJNSVBLSXVHZysrdG1PV1VYSzVmSURjZ1dWQS9M?=
 =?utf-8?B?YmdJVkluMkNGT0I1Nyt4djVBanFXY3RjZHpkUjgwN2twMFY5dEpBQ0c4WS8y?=
 =?utf-8?B?cWRmWDF1TThJV0FLaGJvNGNiRzdseU1xT0llNWVQZllWQkxHNzhmUk81TC9I?=
 =?utf-8?B?aTh5d3ZWR25lOWRnY1NhSldSVTVnT2FsVmNuUXNzWXdmYm1MRFpTWU1EeEdw?=
 =?utf-8?B?N01kN0xzOUJBaDluRW5RNkh6eHFxYm5uMVFBcFQrSHJHaUFtSk5QQmdFMTdS?=
 =?utf-8?B?RkVZZ1d6SU5FTzlOa25UcFZJQWxJRkhmdElIWXA1Z0FDai9jdkRVbVNPMENk?=
 =?utf-8?B?NThMakYwWGk3eFdaZEF3SFRRU2JKQTBCQ1ExeXk2ck1BRGFudnZsTC9wM0da?=
 =?utf-8?B?WTJ2RkdTbTRnaWFlL0N5VjVTSGNJNEhVOFRhSGtIbWRhRkovbTZ1UndnZVEx?=
 =?utf-8?B?dEdJa2VhdThOY0hQUzRtdUg1RitHazEvK1MrQmQ5cG1VNnRkRmh1VDVWRkJa?=
 =?utf-8?B?dDRjMmRRMTBSN2pMMHl5cWo2WGY3UjZDcHpKVVNBZFhQZ3dvbzVUbkFwSklV?=
 =?utf-8?B?ZHVLc09TL25BWW00TlFMdXdEUEZYK094aVNKS0xFNVEvMmJXc1ZIRkxPcWVy?=
 =?utf-8?B?UExrWUIzTGRjeEhIL2IvTldoZDRlREoxQnBKYlhYbjdmYVdOa3YwMEdiMWlN?=
 =?utf-8?B?QytQNG4ycGcyYUZUcmdvN2RNbzFHVzMwcFl3dkhuNm5Jb3VnNGlZNXJJMXhZ?=
 =?utf-8?B?S1p3c2JzNDV1L3h6K25HeVo5S3l1Vng2M1V2enFzdkFiSVg0SkMvNVk2L1ZL?=
 =?utf-8?B?aVcxSDBkc2pic3R3OHRWek9JVG1SdUZZanlxdTFwSHVKd3JJOGtFZk1kSTU5?=
 =?utf-8?B?a0ZBRWkvV3RTZjB0c1dhS1dqZkphWnF6NFNUbnpMSFpNSzJQaDBJUk1jejQx?=
 =?utf-8?B?WVU1b1R2THBSNldrTk1vMG1RTUVhVHBhYVZLcnExWUUvYitHaVFheGJ6Unl6?=
 =?utf-8?B?bFlZaE9DMUpzNU13UkpQRWdOVkcyTURUR0loUnRuWER6bEFGTDc5MnAwbFJn?=
 =?utf-8?B?UnNWZEJvZXJlcDhNQ3YyNVFoamNsTTZydG91Y3RFN0RTRVhuR0tBRC81RXFZ?=
 =?utf-8?B?WitwN2NlZENiL1BkZWozOTBmTWM1K0xKL1NQNlpPb2Q1bmdVZEpOcjd0cHNE?=
 =?utf-8?B?RkhJMERMaE4rZnMrZUJlZDU1cldjM3hIbDBSWmI4bkZZL1lHejZtMHE2K2JL?=
 =?utf-8?B?ZUF2REpDd0pKeVc3Y3hDcXVSNGxRTSs3Y0FQNlhoc2puOGpyM1Q4U3pMM2NK?=
 =?utf-8?B?dFA2a2ZWNjJNaHowVVpvLzhXSk9yK0cwNUlkVEwrU3hic0FZTnNIcEZPYWRC?=
 =?utf-8?B?amhrMHNFSTdqVFZRSWorbmpYRGh5RnhUYVpVaEVrSVF2MlE5OGdvOHc2ZTdq?=
 =?utf-8?B?M0RZMnJqNm56aGNRUDRWTDQ5M09TalRBZUpmR2xWSkQ2UkNCWHpZdHpkWUsr?=
 =?utf-8?B?RUMxYWNCa0hIUUFILzQybDE4YzZGUDVyeUdwMEptL0cxYklZWTVzNW51NmIv?=
 =?utf-8?B?dnpUbS9JRU5wVmkxdHFHdkhhUXdndERyQ0k5OXdobXk5V0xlRmRkVkt0OVZv?=
 =?utf-8?B?RDAzMkJhazMyaDFTV2FXMy84WjE3NXAxVVBjOURNVDRYVjVGQ3VsUDZBak8x?=
 =?utf-8?B?K3haMk9WQXV4R3pKcS9QK2NFRFA3SDh5NW1LU1A2c2hBSEU1bjJqSVcwTEpO?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U2mBHL7TlY17NgQbuLUaX9Ch3dEwHtScq5z+PaTxSwlOd1CvUTGpn6j+HNmQbHOemG/TGTfezgXqhn2KeBTWr28aovmS4m23StYFTv50qc0+N89u6C2BIw6ZjhrtgvDLdKUnAHeg9C9f1p00bTrTpdZWDMv+lA/ATXXFsKeZQrtD1KIxHC7j6MBXYO89ZJosb1/Oz1TNc4AVHh7VHFPoacKJZIUanO/+Bl3NHGlNM01cH86vR/ZWxAnmT4eJlaSz2IZFN++KiHzYW3Kz/XIrXzyrE47ADg2Jl9M2hgljadTbvQ2CoTvCXZHXPeykiogys9ubuQbmOhlW3VIuIDmlz5KgN/uCk27RY4GfmNjkhIJnKBrEJcBQiwTfCzJnHR6y+1sxJO8Sjqm6LETtgh4cs//QwsswiFwRohTfmQLCRBBLBf4kjNyJ6GYjgAQ9+igBasJvh1e3KA9fFMk4wi5XJkyVeb0eij00aNoAhbT1EeZoerqLJcP/2Q4gJf8S8Jg9yZuLii1xAWhVeRQupFgfbbhqYD/AkiZIpEdoUdqSC3qnlEhrBgc654Cyok/0rPumdiVaBKtw1otDfR/x9oLr7njhTOeRqCdIS2mx4jSsyqk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ed916c-0d11-43ea-7825-08dd05891eda
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 15:21:04.4173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wG9SjJuTmyg6fl5Iisn3pnceJSqXAHnPA6L88PeCI6OkLMu/6B3uF/12IZCL2S+fbpGdjthHMQkCmOsy7tk9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8100
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150130
X-Proofpoint-GUID: Gk2XvSLht1GtT6JcvAz5PP4UleTWXFCx
X-Proofpoint-ORIG-GUID: Gk2XvSLht1GtT6JcvAz5PP4UleTWXFCx

These changes refine module reload control in testing. Patch 1 reloads
the module earlier in run_section, ensuring each section's first test
starts with a reloaded module. Patch 2 adds FS_MODULE_RELOAD_OPTIONS to
pass module options during reload, useful for the Btrfs pre-mount
configurations that aren’t available as mount options.

Anand Jain (2):
  fstests: move fs-module reload to earlier in the run_section function
  fstests: FS_MODULE_RELOAD_OPTIONS to control filesystem module reload
    options

 check | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

-- 
2.46.1


