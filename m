Return-Path: <linux-btrfs+bounces-11318-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7000A2A8B5
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 13:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6867B3A8202
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 12:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1176222DFA4;
	Thu,  6 Feb 2025 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z1hmpvMm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DhIW/y0M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698CA22687B;
	Thu,  6 Feb 2025 12:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738845873; cv=fail; b=i+hdYfYWGlolXWBRkGXyU+UtvTX8yzUti8oo/My92wDqHppCkW9iGhz7pDhD/i7ieRieLdfdWTSTrnTeF8VwlZe45EVVCS/FtMLZTFMHMskVZHYBqhF5uTw0+zifaebaHVZPinHMjGlETJG9LA4rcazbTg4hp141fqQYxxAA6lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738845873; c=relaxed/simple;
	bh=q+el3GqW3F/aYRXRHO2WET271Y4k/4E/i1Yvr9ZTh7U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hpvQluoK+0czDGOF8a3WaejCHkiMuEqe/wR0Om2BbA5E2uFYgqejclr398EOBT9rd+3ZQoAL8TvLXjJEw4Vz2+UFfqATCQan4Hmh7cxye79Esrq/IBJgi6h6IpoJCMJu9yNHzNfw4pnj3xO29rMO1rzwQSVaypjz6O/Yd7Hm3uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z1hmpvMm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DhIW/y0M; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5161gLnE025971;
	Thu, 6 Feb 2025 12:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=oZZKMZaSiqB8TUouwONu1uSBBrMkTYcRg/cKas8Zrmc=; b=
	Z1hmpvMmHkFwwYxqbnygbr4emVeE5DtWuREKeEBQbIfDh7PVZsvioPI/IWtwMZcN
	6cBr9a+xBxribT1LBxm2+tY0jiDjwLGoOXlJk/1h8f0g8UF/WSXV+7q6iFcSqx7L
	aZVetn+PV38ud1FPr+PjEVFpMiy5J4rp/qps0EUX6nATjBKbbDge4+k6Mpty6hDP
	pllZkqMJpUwtsFXQ9reuqlJfc8Y6j4VEVBgNGaAuh1U/gjkzsAk1Ia7s9erPMdCj
	fyyP49OpW03FDLOSTs9w0Lx6tNN6TwE7wEyWEh4iX2gLFYqsHJ20EuEvYSdsiO4R
	+aUJuIBi0afy0aAV0dIIfg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhbth8k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 12:44:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 516CNJJQ027832;
	Thu, 6 Feb 2025 12:44:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8p5sd2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 12:44:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IO+ePpFRW0nX0Zi3oM2VBb5EZuOjTo1yWYPuSSu6bBBTcVRP8b92EBQgHYbqSD12xGXSMBSPKQmmvTAlDQRmowB4i8rrq+H8zr11Itak3ESoP3Mz8wvAAq23CszYYq0wL9+GzYmGGwH4+CWd8En6NAMBqnEo2V6AHaHuJqrhfKIyPIoPaDF8fT8f/B4c+RB5Ef/PMnLaKGcFJkkIxxr3RvCNRLIz8f6hxYnNOOPRqUAWjtopkTiZGIBeZ2Bw9QZsm3LNpfjHfVRPDy0K/9rSDv6KVZaisRT87lUG4LfXkdcFzL2TL/Dux9n5+RGSG94+wKDaWFZFh4AYwq9qoWBMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZZKMZaSiqB8TUouwONu1uSBBrMkTYcRg/cKas8Zrmc=;
 b=dIyVgHN2lnG+BP9umshjGWgEtUkwjdjZwosxTlaG5tkq3PKGGWvJ7Q9KTsD1m6wiKZK54kwubOxWz4EHnW0FSEqWcWnxgYWsy/Bmh4tR+bvwjqr3qS8SEvGJ7VNYRCDF9k9TszDyyyhRZDpwjw6KoMU5BBCdYqELePzR1KHoRq5igH0pqVUJ2dGXzc9lCE1KI8fmT92vAo4B2PkwQnUSQGPxyGQkxcfUETW/+JVC8WG/fpnJ9vUiYsJqkUDkPzl/rl+wLmk4yK7z0qkMpFlw3j1H1+Zj7J/aSwXGwhmMtvuF3jvU5rzcgYEyUYgmn7+xdGegr41oyxCav/G5e0a1Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZZKMZaSiqB8TUouwONu1uSBBrMkTYcRg/cKas8Zrmc=;
 b=DhIW/y0MMcMY0EbWMH8bIdKDv9p7mtZ63xDgp4wOiyGsGqyNdJ4Lu3y9i3UJx2FgwZ73jYI6GzgTOxfTCvAapD8X2h7BAOmtTErfQlStWBt15VFVJvO52/Zq2niaotNn7pJGpC+TnbCHIJPu9Q1FlI7nXY+CMNbZEeputufGgEw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4745.namprd10.prod.outlook.com (2603:10b6:806:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 12:44:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%3]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 12:44:23 +0000
Message-ID: <1a2610de-5413-48f1-a3ef-658e0a2a8708@oracle.com>
Date: Thu, 6 Feb 2025 20:44:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic/631: suggest xfs fix only if the tested
 filesystem is xfs
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <9e38c9daf9d330ad2c3a180df13c4bcc0f115416.1738844738.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <9e38c9daf9d330ad2c3a180df13c4bcc0f115416.1738844738.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4745:EE_
X-MS-Office365-Filtering-Correlation-Id: bd766eeb-5795-425f-063d-08dd46abfbd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDZPamRmZllndWFSWFJXOCtkU0lGN3htaVRaYitwaTBVRW1XZmxFOTRKT0pB?=
 =?utf-8?B?cDNrMGdabDN5ek9idnNoSmlLZkxtMGlBWUJ0U0l0bTJpcnBnb2RoTXdtTFZz?=
 =?utf-8?B?SEpCQXRHRHgzbUo0VGxFckE3Q0o4LzNCQnVxNUhkSldoU1ZPdkJZTzd3Wk50?=
 =?utf-8?B?MjFQbGJWOUVHbkJ6Zi9VUTJXTDdOYnNBRGhJeExpY05xZm9LMzJ0bG5MU2dT?=
 =?utf-8?B?d1dSRi9Eai8yVTVYVmZFa0wyVzI4TzdOUldURFArdkZhTEg1OVc0YmxnRE5u?=
 =?utf-8?B?eDEySjAxcnFzS1JUTkZVdW1YbWx4UnQyRjh1WXhYZmVvbm9ScnRvekx4MWtk?=
 =?utf-8?B?N1hiWVl0K0xmanF5OWp3cEdOc3VOQWU1WE9raTNLMWdHci9sZmVTQWRHd1ph?=
 =?utf-8?B?d01LQTdHNm1JSGx6RmZSWW5ZUFhXelc0c3pnSUttK294VXdnUG9nL29ac1JB?=
 =?utf-8?B?NGFOUFFiTHluNXR6QjJTWkx1NlQxeEtDODZ2K0J3WmNudUpjL2dDRlRrZkJl?=
 =?utf-8?B?cW5OV3JoUE1ON2R6cWszb3JtNUE1YS9jM01SemhjR2UzTmJDYm1EZDNLWXpp?=
 =?utf-8?B?QzdsQzc1cVdMT0NUK3RrcVRxQ3V4VWI5VlFpNDFLRjVvSmVlSEVqOFFNdmxk?=
 =?utf-8?B?SXJLdTdJV1Z2RmpSMEpJTkIwYk5FVXV1aDd3Z3FnaVYxc1RxbTlBR3hQbklu?=
 =?utf-8?B?NHRlVTROQ29zVU9YbVhQbVh4djY5SExqYWpKSjR6MVdqZmRzYTBJZ2tHcXVq?=
 =?utf-8?B?Tzd3UTFteVlzKzZieC96VVd4dGUramVORy9uTit3QW5vbzdINkkwRnhycXBD?=
 =?utf-8?B?S3NjOHE4RUNtMHNnZWdCMEU5MHV6d0UwNW1WRFprU1I3TzM5RHBPa2hGOG1q?=
 =?utf-8?B?Y25YemJpbXJrdWJTWWVPOHQvV0ZoaUNWb1IwSVRKMFZBSmdSNmdyb1VYRXpq?=
 =?utf-8?B?YVRhVmF2ZndVUktEWjA5RDdJV2NUTElvdVdCS01PMmNOMUFCb1YxSzl5cjkw?=
 =?utf-8?B?eEhyR1FFT1pQZmVXMWJneitCQmJGblhpa0FHbk53eTNnd25adVdzOXZWbE90?=
 =?utf-8?B?cm16UDBvTUJsd1BsL1BJLzdWQ212N0k4Um1uL3gvM2gxN2hvT2ladXJrRWF2?=
 =?utf-8?B?S0N4Yzl0UEt1QVY1RksrYlNQY0ltV2xDbC9UQjNhd3l2SHFRKzEyUzE2MzJm?=
 =?utf-8?B?TTU4WWE4UUhOQVYrZy9RTU9CL05kMDdLNmI2eDM3UXpMSEJ3STJqOTE2QWFO?=
 =?utf-8?B?VitrYzdXbmhmcmsyNGdNMjJOcHR2NVhLUkhoNWRzdko2Qjc1RlJReGxDYjhW?=
 =?utf-8?B?OUFpWnpvQ2l3b0hRM3dvQmZRU01kNSsySllZVWx6dnZyNmZITFljRFJTcXlD?=
 =?utf-8?B?RlRZY2x5aWtwTkVueUhvWENFSDFoMlpJUmZmWlNUa05QTjVxbDBwMmpRZlhQ?=
 =?utf-8?B?S0lYUUlyN1lES3NQdUpSUFhaeEZIMVJCUFI4d243eGVnWXU3aUs0Q05qNTZx?=
 =?utf-8?B?dDVtWDJ2THN0UGV4MHhzSHdOZ3JmcUxEdlNONFp2VEtMTStCcFBVVmpqNDQ1?=
 =?utf-8?B?TGxETXNyVmM5eGRSWG5Hdmc2a1dQbzBPVWh2cFhRbllQK2VreWRxTzVyMHZL?=
 =?utf-8?B?L0FlMjAvbXJ0ZHZCd2dUYTg4U0NsUjlUUGx4WnNsY0Y5OGcvWjFEa3ovQzI2?=
 =?utf-8?B?d296aTFqUWhwU3c3VTdmV0Rralp2cDJvNVVMVXFtQzZ2Ykx6bDZBZlNYNDhh?=
 =?utf-8?B?RWhoVGNYNlpya2pKb3I0LytZTDhXdmI1MW9LOUR2YmRGRmhYYktwaW1wYnlr?=
 =?utf-8?B?eHZiRUx2NStZZDd0UlJZT3pNa2xsMWV0UzFEYWRkekhzVGJ5ZGkwQ1MydkdL?=
 =?utf-8?Q?J97wy/924E0WD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1BwME1OTFExZGJGdldzZ0FYTjJpUUNCTmRHTGpiS0dQVWoxUTRDL05LM0hq?=
 =?utf-8?B?ZnlTU2lYSmY0VTM5NzZmZGJ2WVhyTUlyUWp0WHdGL2tsNjUxM1ltR3BQN1Y4?=
 =?utf-8?B?VEhHbDRjVjJZSThUU0tmOXJkUnR5LytFb1NEdWEyVTBOMEhZQUo1NDBNMmt2?=
 =?utf-8?B?cjF4b0VqclZuV0VzUGRCNHM1eFZ4U3BVVHdXSXVDVnlSODdWdTNudWxOVGlR?=
 =?utf-8?B?amRkVU5ncDRUaklZU0l4UXNGOXFIMk1DMTBkQWpESnU3Qk5hUHY3dUZQSy9H?=
 =?utf-8?B?U09mc1B3M21OZ01ndHgrSmgvaERJODBmTlcrUGJyQ0lYblNQRHNYaDlnTEFG?=
 =?utf-8?B?NC9kcFNrVSt2RWlZSTRCeEM0UTZQcXlYeWg1ejExU0hUSjZhSWZ2KzlNZkZO?=
 =?utf-8?B?Q0ZqcUh3a1RXUFpnYmo3TEFEVzBlZzJPTHByWmJJNWJscEs5TTBCKzlzZXFr?=
 =?utf-8?B?ZG1ySnlpWGlEcFFzaGFEcGxvdVdHQUdiaVNIQThQWXphV1gxTU9Db3RHb01Y?=
 =?utf-8?B?Q1ZUaVh0VWYzOElQVWdZcExRSlIvNUQ5Z2U5SnMrRFRGOUgwTy9WR0dRdVJw?=
 =?utf-8?B?aTNGMVNZUm94ZmRTRmk3OG9tVlVGU1g2ZWxLQ24ySlowaTJYMnFHOWFORXZE?=
 =?utf-8?B?ME0rUjBPNU9sdGlPaHFRcTRFQ3FJSnczVnRHc0xFMVRTRGRrZHRDOHVRNmlU?=
 =?utf-8?B?Tk5EV3lpSW9aNWo4WHJnSkVBZGVIRTNTRVFjUEFmTExmYUpEc2g4R1VBTkFa?=
 =?utf-8?B?WldXSzY5N21wU3djcTBna1M5OVk1NzM3Y0lNQThjZlM4SElmNXZjNWZDMkx2?=
 =?utf-8?B?blpzYWsvdHEyRjlrV0hzTzU2Q1c3YUhGUUlUR2ZpLzFZOERTaXZRUUIzdis2?=
 =?utf-8?B?RTRQRFlBaHRaR09UZnQzdk50QVJhSEk5dUltQmJKSDk0THlpTXMweVRjMVln?=
 =?utf-8?B?aVdaUnZqOXU2TnVUNEhUMkNUTFk0eXpzdDFQMUR1akQ4SDZVSktsQ0xUV2pZ?=
 =?utf-8?B?ZG1tOXdtanZZaGppbGpKL1pScUMrWUpkU1hZUGhEUHVxbTk5RjBaaXpjZlp2?=
 =?utf-8?B?MDY1c2FNNXdhQndGcldPdjR0N2hCeXZYZTMyQjJDN0Y4NG1JK013TWl5ZnVK?=
 =?utf-8?B?WE8rdkUwZ29nRWtTbHhJdkhDZUhTNTdOS1dOdXoxWEo0elJrY04zZk9ZRTZC?=
 =?utf-8?B?aGVVTjV4Ymx5dTBGMEd6ZUI3VzcyWkFZTWRremdENzZwWUZ6Si93UG1oTWg1?=
 =?utf-8?B?dGRtbHN6Q0lvdHNjdWcrUW81UEV1TFhYZ0VkV3hMbXJGS1RJT3lNb0ZkTUlP?=
 =?utf-8?B?MTZPZE5XUmZ3NS9FaUJ5RnU2NXNvMWhLK2xXOHRjb2hMNHY4cXpIak51NzRa?=
 =?utf-8?B?Z0ZyYnBxdXl5SFdJMmwxcWhNa3NmcWk2S2hsRnowK2hWSGV6d1NzZTMxajl3?=
 =?utf-8?B?Uk50eG1BdHR1YnJacXdTUm44a2ZsT2hnWXpNUDlVV0JGeEVuL0xoTld1bnpa?=
 =?utf-8?B?bU1KZ09scHVuTUNmVDFrT2ZLSngxa0xQaFFyNC9OOTNvYkxEVWFxTFJ3REg0?=
 =?utf-8?B?bi96K0pqVDZBN2p5TUZ3TG1Jb09tMlVkdm81cm8xem9qejhvQXUxUE80bEhm?=
 =?utf-8?B?U2FGTUNYOXJzd2RtM2hYL1RBMWNrZktIVFFqWTZZaDhxM2JpVzdVdm9tT1Jp?=
 =?utf-8?B?SzRRL2ZETVdWeWQvUTNxN3J5UXF2Z2d5S3I2eXNRRmhvOVJHcE0xT3RaOWVO?=
 =?utf-8?B?bUZ3R3FiMHpYT0NGeEVrODByQTZUV2JwMW05N2FRUVFUMjFURi8va2dkeW1w?=
 =?utf-8?B?cXVBK1JUTFdLY2JJeWJQR2p2dUY5dFJnZVhEb08ySU9QSlBpMUFiZVVBL0ht?=
 =?utf-8?B?NkJObG93RzI4Z1o0SmlEVlJ1NTVENlFURjNFZTJyTG90dGdIRUhmaVpFekV5?=
 =?utf-8?B?cXZQRE1NcGk1M3lCRmxvK1NDVUlvZWQvTjhxR1FxQmZ1RllYVStPbXBHcmk5?=
 =?utf-8?B?Nk1nZUVJblJqRXBZeGxTaW5sUnEzRDFpSU9HVDB6SnJhSkZUa0xwZWdZL1Bu?=
 =?utf-8?B?aGJOQmRxMXBKLzZnR0YrWm9waVR1bE1WSUJENXh5Y0ErUUJmOHljSFpxWE1G?=
 =?utf-8?Q?AoOUoyoMAYgo+buII5+Zj9I4Q?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0je7Eyl5MP5MT0GDPcmiKXbPiJWz2E4xcimdVszQzH70xiTYE7nGAiCwGoKJZLuR7sSXdo/GQhgbk8tEYJgkYocX6LSs2oA0MLI2tivD8F3BujtWzOhwAtgpz1AQymz9wlxG+zYYzvF5xw040vZJ/eO5rxYv5SFLUtjktUHvbtSP11AgcPQAYCeRO5d46n5cDDXjSv2+yyRhtAzY2hlvH+t8CIgBHiLySOllw8l2NLcB6pGVyeTfVb441ZwF4jbgWAnV769vWiG1fua2u3xKMZRvNx7MrsUngXWhfYEujtF3gihgvfOhC/KyeAud/7b2ki2WWPdSv1pl+xcSnNzDxMWtGp6Xt27rnolWIsVyOUWrannlB+67z0QQCH1GCRe/pmLIj9GAxjbEVXrTUZ7r2IpozHz/6TsHNXumghxNUKLGBFSkub/uiMjN2H3wamyzV9J/WscDu49CQhpxY20t5wkbpwPYOp0jmbPxyvjipyeBCg4LMBr2ka5/3dCb68kp9uKlH558kqkaibx407hEsPgs98uJft1uq/Iv1oXvnLgiI8nZ4t1ucQoQr3cheNKw3VZ9q/n+Pp/2AWzo9zjqudPqSFBw+k7CWTuktvveWTE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd766eeb-5795-425f-063d-08dd46abfbd0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 12:44:23.8892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPfFgJ0n5aQsnJTXBtzuOC0PgeBF9TV7JXBJ+8gBdDY39aXM284bdvdWXcXDEzn8vOUOrvXIA0PZ+101qUcQrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502060105
X-Proofpoint-GUID: MXFoE8KCHygPYj59KC5z_WdLK3ryl6FU
X-Proofpoint-ORIG-GUID: MXFoE8KCHygPYj59KC5z_WdLK3ryl6FU

On 6/2/25 20:26, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> It's odd when a test fails on a filesystem that is not xfs and it suggests
> that a xfs specific fix may be missing, which obviously is irrelevant.
> So suggest the fix only if we are running on xfs.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   tests/generic/631 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/631 b/tests/generic/631
> index 8e2cf9c6..c38ab771 100755
> --- a/tests/generic/631
> +++ b/tests/generic/631
> @@ -41,7 +41,7 @@ _require_attrs trusted
>   _exclude_fs overlay
>   _require_extra_fs overlay
>   
> -_fixed_by_kernel_commit 6da1b4b1ab36 \
> +[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 6da1b4b1ab36 \
>   	"xfs: fix an ABBA deadlock in xfs_rename"
>   
>   _scratch_mkfs >> $seqres.full


