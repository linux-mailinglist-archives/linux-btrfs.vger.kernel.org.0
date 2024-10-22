Return-Path: <linux-btrfs+bounces-9062-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF109AA117
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 13:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0941C226F3
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 11:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1BA19B3E2;
	Tue, 22 Oct 2024 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sz7Ee6Mq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DTKMT0G3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17919140E38;
	Tue, 22 Oct 2024 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729596303; cv=fail; b=gUYJ/kJ393aCykeUC7G5cYuDXqMsdebIPIeYP1dU0HQ1i8IU5jKueZoPcnsl+NjAxXvyKb3cEr+LHFkMoFWtXr62dasMflHJwoAW6X3LOxvM7Jao6hM2ziuoKtPfuQeLeIqYXBB11jDqC2+WbrlVCmvbEe31OTosjOxo0dyQscU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729596303; c=relaxed/simple;
	bh=FC6Ig5pJDfhlPZ14U0uRKtIu9eRSIjsOWbC5UpMDMls=;
	h=Message-ID:Date:From:Subject:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pKF6gRbHwVsVNehYks65uqB7hfBbiRnyQcyNh6L4ZQrlS2QjFvsidnyXY71eU50tGO/UaSTosL8kVI/GnvkcN4oh/EsYrJJQVVs2kDc8hoMREEO5hDMWVCK1lnrzH/6ylqFhPVPXOhwW5O6AgYPhVrsyjzkkO8Kn8/mPQ9Ly32o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sz7Ee6Mq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DTKMT0G3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M7tgXL011354;
	Tue, 22 Oct 2024 11:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gSI8pyEhKPm9V9apStagXUWxrw3aZwMeyQjBON9zzl4=; b=
	Sz7Ee6MqMalRBgFV/7TB5Ax31DHGY1kRKaNAfPjoCBIGDcLxCpbze/3lR/XF6Ajm
	rfIsJQkMn5IHn4FCP2vMlh4dKnIfjqTOYKf9JRJhZtYu8yVoSp6x2+8Cqno8g3qf
	crVkojgwhcxoXxYbLdY8YrvTxYmU0qGwq6O2LJXfExRTz31lIWUPuOmEJhewV794
	laqwJ7Q+ZOeyzXCTxos0LfsEq6aDBMt7CD864wbFp/rmByaAxhJ7f4AVqK0Oppyq
	Kt9aJnbvX7knNy0eor2ruwe82wK/mO/fJqt2bHevJSPjPTQ0MuRY2K7FrPF/HX+p
	dFqh9QxSKsgVJxiqpOB9lg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5455bkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 11:24:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MAQ0hA012449;
	Tue, 22 Oct 2024 11:24:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c377ayd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 11:24:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOzS+iZyKgqLzuqWVECF8HtugfKJfGPFy03bvUSFApzIuUizRJdJH0fFGIyLa7UR3g2cb/lrR0Bk5BH3ECQxv8hNU4tNm+I+xZlO+OWgjce9hf6dmKycNV0o1eLGVNrrpcVsh5YpQK0VSJ4tJr63+l2elKbXui0Pmax9/iwTkUbiuvx8PicaeQ80O9VpmpXZ9tIVGO3LDpvP6KWZEVPX9xLy+ZvxVx/21vBdf21d8N/6ihUsxclYMagXbe65U9JP6l+vGNbISQZsSeE22SVlW0nM0/t6lapEI7+NMpK2zL6LWpikMxqY8NIl30sjy4fcjeJm+Id6sjz6HnWgrmn6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSI8pyEhKPm9V9apStagXUWxrw3aZwMeyQjBON9zzl4=;
 b=BscCNMbo59mzvJkRKxJMLszw1aCWgWtQRg6X5IQC74qHu64LbKtvz4UegZBiI81qnvVzMbGOL0jZo8D1iYZkyB41pWol0nFkFLGYxHlFb3OxxhJgzX1aJ3IbJmn+MhGDkrmvWhOC1x0cm9oae3ssZxxyesAdN44PccBH/bJPJVanmwH5ipf+01xdMsaVPMgHghI/ttntxP3x4ZmAx9RGOQi3YSZkTQUifPOLTMk6pTb7HJ1/98QqcK9zBuUhdx4Lk+7jNtQzyXFdUriab3mPGvDnquVj5JlOuTEfiduULudQmLJFP3FENc2Qk0152Mk1gpKkjq6I9SaoE2CM/87+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSI8pyEhKPm9V9apStagXUWxrw3aZwMeyQjBON9zzl4=;
 b=DTKMT0G3/Xlqb6w8YR0viSKgqzfR0ZdGrBsA/MKVxDByI+f3jya7SXY04K8tKfyrjzupx9eY9JhPfikzAeT6TlVYj4URRXFIwVG78Vq+bJglsRTxcAZf/3+cmVFOGLdnU0yQd9aLLVIcm4WhDTYwh941Rs9xK+DYkZhesqZNvvo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6417.namprd10.prod.outlook.com (2603:10b6:303:1e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 11:24:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 11:24:55 +0000
Message-ID: <8f1a88d5-3199-473f-881b-1844c4f1cfe2@oracle.com>
Date: Tue, 22 Oct 2024 19:24:51 +0800
User-Agent: Mozilla Thunderbird
From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH] fstests: btrfs/002: fix the OOM caused by too large block
 size
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20241012071824.124468-1-wqu@suse.com>
Content-Language: en-US
In-Reply-To: <20241012071824.124468-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ddbaba-1e2d-4186-f889-08dcf28c274a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVZvVnlPaTQ5VUdnUlRvZHNlVTZ1NXduTDhKMWRoU3ZNazJvV0RrZzVDMkZ0?=
 =?utf-8?B?ZUJqOVFWbXRnajNsQ3doY3RkNVJnWFpOOVRiR2RPekpQeWtPU1h3MHJncTN2?=
 =?utf-8?B?Tm5PWEdVQ0Y1N09sb0NtbFkvb2tzaDJYa0ZxRzh4VG5BRW5IdFI2S2w0Mkgv?=
 =?utf-8?B?Z1hKZkttWFBEclZvS3BqMG5DZVJSSS9EZk93RUpUSHJjQlpsOEFHLzdzZ1hm?=
 =?utf-8?B?eEdmNTVWSTlFTDY5cjd1allPZiswTTV0MnJnZWNoendKNGkwaDA2RVVIeGhE?=
 =?utf-8?B?ZWQ2UDQvM0k1VmIvK0p0bnFlZkhYWVBWVHBwUHBRcUo1VE5lckprUjZ4NDVU?=
 =?utf-8?B?WlZYbXdWK3BRd1pPWkh5aUlFZjFoL3Q5SlNaeUtGU2hXYm1XYUxmdjNRZGR4?=
 =?utf-8?B?c1UvcXpXOU9tZ1NObXVDSWZNclR0R1VxQk51TTkzWGJjSmRTdjdqdCtueTRP?=
 =?utf-8?B?cVRYL05Od2t4bmZsRWVXOHQ1WS9rZlRFcHAzUXZzYjJvUitXVHUwR1hxZ1Vi?=
 =?utf-8?B?cDA4Qk9BVk5DRVluQVZtQlJBOHlnQmFZcFdNL1c0ZTIxWGpsUlJQNUF4S0Fr?=
 =?utf-8?B?UnhrbHpGNVRxT0owSzR0eHdXV0YxRlo0REEwVmd4Q3UvYUlnVXljeExiVTUr?=
 =?utf-8?B?ZFAyTzNHZ2d4THRKSHNhOFlrMkRMVmNLYUhGNDhJNlZQZ2N3Z3BCYjY3UThL?=
 =?utf-8?B?SDhzdzdWMm5jazRpOHdpYXM1YmRQZ0p3VzdzUUUyVVZtakdUZDVhd1dHSHkw?=
 =?utf-8?B?b0VRcnh6TnpPNVhZczFkNDNRc1J6c1AvcUlwNEFNL095d0ZKWkdvK0VYTU9V?=
 =?utf-8?B?R2RRT1RqazVydGIza1p4SVZrYktqdzE2bXI0ZVh0aTA4THl1Z3NaVVB3emVp?=
 =?utf-8?B?bHl4VzRmTUY1MU15STY1eEFtWVVFR0FJMnl5RE9YdHBwenAxdytydmtPRnBZ?=
 =?utf-8?B?aWdPUnF6QWE1UFVGcEhTaTBNVC84d3BGRFFWT3RlME9wNWFTbCt2dDl0UlEv?=
 =?utf-8?B?MS83L29JNGNWcWxwYU1vQUpsU1Fvcml3aW1TZmZEWEJvNklEK2txMGhDYVky?=
 =?utf-8?B?bjlrZ0dkREhrZzBPQ2JZS3hHUCtNOTd3cG0zdklJS1NnZU9DWFQ1QzZPQVJG?=
 =?utf-8?B?eGxkdW1RMVp5MFFhQ1NIR0cwc044UitiTG1ZdlE2a0FjMGpIUmc1Z2RBdUxv?=
 =?utf-8?B?d1RCUDBMZDNKdmd2SDhsR1o1ZktPRlVnSDFibk5USFhkVVZUdEI1NExXbVV5?=
 =?utf-8?B?UlI2RTV2ck1KNzdIZ3MyeFZ4SlNDTm5RT01Cay8wc0dNUWZpaGsxbFQ4V2xQ?=
 =?utf-8?B?OWhIb0ZpYWppUk96dldmTTd3bmJlcWVoSEZjYjVkMFR3QS9uOUZDTHBvTnR3?=
 =?utf-8?B?NEZqVzhGaG9hRWZpTjhEV0UyY0NRbi9QcnNEQ0FCQkNRZklFK05DR0tIQnNl?=
 =?utf-8?B?TndVTlRQVXRYcEhDamM0aDRGQWpKd3dQRWJjakRCSXBWdHBOQ0V3WWd3Q1hF?=
 =?utf-8?B?RUV1SDlJUmFLQzcwZUU5ZXpKMnErOXI5WlorYW5BWHBzNWFkVnI5Y3JOUFpZ?=
 =?utf-8?B?dkZIMGh3NnNRWGhma3FpdWNrV0hWQml0eExPSnkvNmpMUmJoT1dkalBSYzhv?=
 =?utf-8?B?UThwbENyS1hCNXoxWDArbm1TblR1UFl3RVl5U0gxQXJGRytUOFNiV1pFOWJC?=
 =?utf-8?B?aFpNc1FTNUVxY3A2cThOZG5OcWpVL0tOL1lUK1lrcW9McDhJK2RJVEZHdDB5?=
 =?utf-8?Q?zEj6dFqmMcWwv8tJfmEUFGtdu18m0YjTlAX1vFf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amZtbVJ2U3NOclBVWDFraUhualBUVmtXM0ZNZC9YZGdMYzJTK04rV3pxTFpq?=
 =?utf-8?B?Ujg2MDNsc0lGUnZkS2RLMk13R256ZzN0a0NPYkNNQmF5TXRnMUZkaXVtdmRl?=
 =?utf-8?B?aVNDcGxid28wZnZjSDRidjkwcjNKaE5VMGRDYnowN3hLbXRPTGtlbFlBc2Zu?=
 =?utf-8?B?cytwbnZqK3BNZzNmRHEwcW4xZDVTVkF4bEM0SGxtZUJSaDREcEJ4U2xJY3c1?=
 =?utf-8?B?dnR6azdJYlEwOUswNWNVbjk2SHFpWEt5RURSUklwR0dXUWpRc1l2cGpXeFA1?=
 =?utf-8?B?dXdXeUlLK0N1T0xXYm9ERDRzVWp5QWFUdHAwenB6cnNJMCtaNkpKSkxOelh5?=
 =?utf-8?B?YzNqSThGWjh3YitZNHN5bkUyUzROTjhwZ2xPKzljdWNKU01sUHJZZjJicm5l?=
 =?utf-8?B?aGZMVXBxc0VVMFd4S3B5am5aWlRFWlNsNjQ4ZFBkSjlPb0RQT3ZuL25GWldC?=
 =?utf-8?B?ekhQdnI5ZmZha29xbWlBc0pqN2w2UlFmQWRaQUJKaEJrVVoxUTBuRGlzSVl3?=
 =?utf-8?B?VytzdzJEWGhGRkZOdFl1Rk9wWWRpNGNFMmkwN09QOExybWlyQXRSbnBKZGxD?=
 =?utf-8?B?VUFXNGRENmdjS1JGMmpWeERqNENjeGxZT2dzK1lXTkRuRWtnWXdzeVZjeTJU?=
 =?utf-8?B?Wm9HWHhqY3p5Y1BwZFNCazhxelNlY0MrTC9KN1BVU3NwOGViV3ovWEdTeHNO?=
 =?utf-8?B?MkJCSUVlbXREaHZOd2RFK3pSZjI1dlBtUFVhU2ZaM0xib2VsVUdzNnhEb2dK?=
 =?utf-8?B?NXBRVEEwZzBBVVR4Z0VEOHNBV2g0dzRaZmJsTkswNnZNbk85azN4Y25ZeDNy?=
 =?utf-8?B?amVZRzZaY1hFTjdGNExqaG1mY2ltTkNDS1ZZcmRLbXR2cGNiZTZEQ09KL05K?=
 =?utf-8?B?ZkthcjRJVFdGNzl0SDVsaUFKZUxLaEpXMENrN2RFbDdidFJPbGgwR2hZWWww?=
 =?utf-8?B?V1hVQlc3WUpmRXhUejJ6YTR0ZFozYUNROXpiOXNsUTFiWVJzVHJxZXY5YjJ1?=
 =?utf-8?B?cHp5ZFd1WHZkaVlXZUd5TGpPU2hYV3ZybU5Hc0VTWlQxSHByM004VzljV1R0?=
 =?utf-8?B?Y2c0SnJSQTNqQ21sTmVPaFZmSFpTRHRnZE5FeWNvQlUwMG1EWFkyV2xSQUx5?=
 =?utf-8?B?dVhZT2tXcThndUJpdFVjTWVWcGZTdUJVendVbk5SaUJpenFYdjNFc3NLM1Vw?=
 =?utf-8?B?VTBCQWI1SUluRmkwb05rckhhV1dUazhoRzRYbm5Fc3FrQVpJM0dCUUhhbm1D?=
 =?utf-8?B?WnNJbC9SM0ZkTEhWenREM2tWNGpqUUE5TkRZckwrUzBub21sNzd2WjcvVUhy?=
 =?utf-8?B?QVFHdTJETWtJV1BjakxLMUtUY3lWMmNMQ05FcE4vLzJBUEZZbVBoOGFSY05O?=
 =?utf-8?B?ZGlHL2xyM0xyNm9nRE9Femx2UmkrQ1BkZXFEQ3krWnc0cjgyYkhZWUNvTk9a?=
 =?utf-8?B?Q1NYN2RuOEhGZEgzMXZzSmhpMStseHM4MjVTeFFLUzMwK1VSM3g1dE1pLzdq?=
 =?utf-8?B?SU1WY0QvN1FsYkx1RzJLb0pvc1phZ0hPdm53ZUpKVWRNQUFMNEJWWHZlWGsw?=
 =?utf-8?B?dUZpYUNpNkErQytQakY1Y3lnMllYcXNZcWdQQXUrVlgwd3ZwWitBZXRWTXBF?=
 =?utf-8?B?U1ZEcDQ0UFVBNjhseFYrUmFVME5YMkJ2RXFYRExhTDNzdkVxQzdWRG5YMGJR?=
 =?utf-8?B?ODFNRGtGUjRCU3lqTVlOeEgyRXhRV2UzUVdabWdIdHBwNnZYK040QkMwQlNn?=
 =?utf-8?B?b1g1WndDeGJwOWNpc0JveWdXUHYwSzZPL1dRbzNxRFJDWUdzaTM0SkpIbVRi?=
 =?utf-8?B?R3d1RjhnWHdjRXdVZm9KREZLSUxvdENkck82SUFMZGxBS3dYQW9jcU1uSnJL?=
 =?utf-8?B?OElZZ2U4dTdnMlR1L2lZMzEwRUlFK0RJZkMzRXVQL0NieDIyeUtUTnVRdTMv?=
 =?utf-8?B?OFYwVk94dGd6d3I0ZGhHa2JOZERlNFhxTS9jSlhabTlsUktxaC8wT0cvS1NW?=
 =?utf-8?B?dEdXZ1prVncrOHkwaXdpQm1RNVpTZWxhTUlhd2RGVWFLaDlaV054aTYzNXYy?=
 =?utf-8?B?c1AvK3d0K1JIZWhjKzJRM1JtZXJyd1h0Y1FtdGdVdUxEVHpxM1BCY0RaaEM3?=
 =?utf-8?Q?X13nR5ngxStCpr8rmoOGl1LO5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	grr/DqEnDydyOese06yJkmKZDiqiaTU3QoQ0yrL1HBvqybGZf2dmdUte3huw55w2pAYB19zv1uaTrEKuYYRIke088Y0Ch8JxnSonxXom29alwKQgNWFnvK6EFuvElYTayGm3mpGXgtwpvEQMSxaAQrno2VpPG7pf0VbZ3+FJ9yGhGuasqUkljwHl715fcS3IUubxotkIHidL45MnLiWs539lVvNCdj/ejO2ZEGNixH7CEYZcQLvWCJiD69Vfph7HJqosKYbHsiQWhIXEJiduOP/M+m8tP+il+xsUAGwmO/mrtaU8hPdOuFQCjnY/gN8DyN25XeAIRnAcGjvJ+GHUsE/wnRvZmc8AZ+4Gr02yof05W7OzMFdIwEHpJTEfm+BZnGbCkduOzz53mjYDnJExmHhiMYx1J7Ohr0eix7ehI7G0vsElgc+Sk3zRP/I8iEw7vbuHaGAsp3Y1VLQ4IutP5+WhkNzzwcS/I9M/eYmvKk+rU1i5voVSrWoDythpU5BqIuxgGbl590RIrqnI+Nds0dHlZJQxRlXjiEt2KH1SqvskQde3s2XwEV8wIh1QDypM/Rm/1HpzKo++sgzHyRGlFj7f8IylKdcG9a08sLFg3Ow=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ddbaba-1e2d-4186-f889-08dcf28c274a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 11:24:55.1631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKvqguJgBs7vcq1TENFxmmPpRU7uEvwQBffc/TKsr0PwnohH+xF5QJ2avSwb0Hz7kTFjmOaDr89+nyrkGlSG7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6417
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_10,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410220073
X-Proofpoint-ORIG-GUID: 1iVFPtT8obJ6bdvJSelL2S7k1m2oZiz8
X-Proofpoint-GUID: 1iVFPtT8obJ6bdvJSelL2S7k1m2oZiz8


looks good.
Nits:

> For 64K sector size, the BLKS is 512, and BLKS is 128 (one 64K sector).
                                             ^^ NBLKS

> $FALLOC is the correct value of 64K (10K rounded up to 64K).
> 

Not sure what you meant here. More below.


> diff --git a/tests/btrfs/002 b/tests/btrfs/002
> index f223cc60..0c231b89 100755
> --- a/tests/btrfs/002
> +++ b/tests/btrfs/002
> @@ -70,19 +70,14 @@ _read_modify_write()
>   _fill_blk()
>   {
>   	local FSIZE
> -	local BLKS
> -	local NBLK
> -	local FALLOC
> -	local WS
> +	local NEWSIZE
>   
>   	for i in `find /$1 -type f`
>   	do
>   		FSIZE=`stat -t $i | cut -d" " -f2`
> -		BLKS=`stat -c "%B" $i`
> -		NBLK=`stat -c "%b" $i`
> -		FALLOC=$(($BLKS * $NBLK))
> -		WS=$(($FALLOC - $FSIZE))
> -		_ddt of=$i oseek=$FSIZE obs=$WS count=1 status=noxfer 2>/dev/null &


> +		NEWSIZE=$(( ($FSIZE + $blksize -1 ) / $blksize * $blksize ))


Please add extra ( ) otherwise it is very confusing.

    NEWSIZE=$(( (($FSIZE + $blksize -1 ) / $blksize) * $blksize ))



> +
> +		$XFS_IO_PROG -c "pwrite -i /dev/urandom $FSIZE $(( $NEWSIZE - $FSIZE ))" $i > /dev/null &



Reviewed-by: Anand Jain <anand.jain@oracle.com>


Thanks, Anand

