Return-Path: <linux-btrfs+bounces-3466-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF438811AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 13:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138512859DA
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 12:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88650405FE;
	Wed, 20 Mar 2024 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d2NyaRpM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AqXrGp51"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672373FB3F;
	Wed, 20 Mar 2024 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710937891; cv=fail; b=VjqRSuhl2MesUiVUDdWxjlezRKPS9iQWUAWWZcUnVMJzIrrebx7gBGKOFtSYRoyWn18LS6WTl/Fc16wmMXFMFmjIJCz7DjMReiTyWhFxDnhcbnj944h5hfzW3aLRpuuglbyNvNEOJXOQ2/iyfmcqAsDlrtNTm59UT4tsIt/vx9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710937891; c=relaxed/simple;
	bh=QJKQoFvt1wZSvfaxmoc8bx1kM26820aQMJCIhZw2UR0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zw7q0sbfjF8dmYbm4BOf+W0FpjWbJfRrrCLG2ERjRqIY4NHX65bVGt8TUyC+It/myKTNaK+kMOgd8pWnJ6+GcDbn5X9UHxkE4IIxO5mwC6ks69Nhz1Q/m5MHQTiAUiUz1k5hTaGXtihJRBDcdy732TFLWW9d/J294XYrICdRjK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d2NyaRpM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AqXrGp51; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42KBwogD028582;
	Wed, 20 Mar 2024 12:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=yGxirBaZ7lnOBWX3SJZQXnsBAbIkAJbFoUFWCuGBsEw=;
 b=d2NyaRpMxQCWXBObtGdrVRebeJGugbbOiBIczFVpyy9IOKCoh6IfOHvShyOIjugBmA4n
 LcO0rNiDWv0gNfLuz2gqob2zrxSWxHqhsazn5kUD8aIR/jPcbESL54GDj/SPRnk0KUL3
 GmfZqP+Su/wz6gxgBm5+lYVoCHN0iQVrS4kyaCSgYU2wHJc9R5D1QmFB8UVjkr14SQ0W
 ruJELc0Y00z0LO8U3EnNIfhaScDbjT5IppzFVjuhLh6rAVrc9IBsvrVBly8UfXBkuQcK
 N62ww1lFv3Mx0BVeKddyQKNIyJIXbr17oGgehl2earyGvMoXX6aqJeTMx3rXUKMSO/oH vA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww1udfwm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 12:31:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42KCGmY4019632;
	Wed, 20 Mar 2024 12:31:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v7p9gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 12:31:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKFuNFTFRAUatKKm6Ip5mAuUsZmEA9CpRlHW46+DVL3745XJJd4y4ZMPSFeyXyvXwE222lwRRC0RQ1Y+oaRxwfroy5RBrgRVF/gEpPwSDUSnlgpgAvTZgViBA1GD7eJYVU4YgF4dQnCQMVA4jmRcxYL5HKEvxWPS7CfxRMgkGyLU93hf9HzG5oxIsXj9YSaonjCzNi0n3Q2Ii/5IdWYBbx8LbtLXeIzSwg6lJAic51udaiZAGO7aJOeWmYJ+nPuvutlbLLcOJTT7XANt/bTuQWpgV0HG/FW14ZbBq4oya9FTFRWRjdYp2pJVmoG7sMrzcUl/1yW5YBfCVsoyY+ruZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGxirBaZ7lnOBWX3SJZQXnsBAbIkAJbFoUFWCuGBsEw=;
 b=Dtgn368xSqQPrtSRBDHtxuu0oEIyOKNY82I+STabriWZ9hKa3RIN1KFdaUPgubVIsYCkL9ADDziZRX2fCAY7eJrSIG0oZ8TQ8KnEyCrvuSQaO0MYqTbYGDV7VjC8PtZvqNAKiOnTlYW8brypaR7AzY0rQA7uayQaQtzKtitWA7UqA+pSnB+3ySmNFf9Po+De1BdVIh8ZjMknMDMmbUHWdAkHciqgmkQ6euH3VcxOUKsgW+GmwK7F8r45TFhUiw/XLzPE/4vPjbC7zgIE1pm9uPwdjurEA2Dm9gcbVCuWtp85TCllFwLStIDYpgYYj5R8rMgaOgz68ZTFJJOJo+khZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGxirBaZ7lnOBWX3SJZQXnsBAbIkAJbFoUFWCuGBsEw=;
 b=AqXrGp51BuTqbf5OsRiDHnGSwCfBUcuh97JRypKyOYSTUa+VyOwWBz9o5etFM1a0xKoHwqqbAWTqwdeOxU39aps5Cwys92qIjCwnqXOFYXDVXeH50nuypZG7STqbz5Q+bDtabsYd4QEgESN7vRtWulfUm1gEHiehm9Mc+wEbWfo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4392.namprd10.prod.outlook.com (2603:10b6:610:79::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Wed, 20 Mar
 2024 12:31:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 12:31:22 +0000
Message-ID: <343344c4-7a12-4e58-84b9-6b8a7ef51294@oracle.com>
Date: Wed, 20 Mar 2024 18:01:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] fstests: check btrfs profile configs before allowing
 raid56
Content-Language: en-US
To: Josef Bacik <josef@toxicpanda.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1710867187.git.josef@toxicpanda.com>
 <65177ca9d943c043f88d8ea034d1e625af3d0e58.1710867187.git.josef@toxicpanda.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <65177ca9d943c043f88d8ea034d1e625af3d0e58.1710867187.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4392:EE_
X-MS-Office365-Filtering-Correlation-Id: b42954f2-a4a1-4b01-b7e3-08dc48d9a661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	60Kru2IkOZisKxDBtxivZUD+BFhhUZQGn0/jsIaiCX4tMbpQaQKSDaFwjQOxQgkcLeSKjl5UtT8qHDbOUAVy6eJRiN/mMOUrZYt66xEmUA0PU6VXqoum35dVz3gdRf8jmmuQ1MFJmCUYv+sUHN4x8jqdtxeTDi1acyN0sEoqEzlqlbwhXDmp090aggkLw6fK2IFNYO7bh5K/Gbnvrr0QIzM/dG8B1GvT1NoICXh6K0AyenXirQTKlr3xcXxj/BqPIiDYpjiFJVfxryaAbmfAR+1kjewGXELuq7rZAJ3pCitICuNArCs46QSfc8sFU+U/fKNlx75k7sk0kFOnqgohOE+BlBuyppy8mvaGrapALItz/QAbf1zvd+6Cxj2qqkP3sO+wd9+v0NYBXJAW+0C6wdLGokZReKD3ZzbdHcW2dFUEQpv6FsGAFGymDLlIfXN7xkkcGmt3SESiRtgoeqaU8Aw5e4H2IMhUFvBuoltMcor6zvoXx9kboGscnqbOYhKsOQnMppSFtJ097jW+zDWhpypTMA0/cCN7UL7/YS8H9Lf3sATeQ7KU0nXpUdCX4wkJ5yC+cDMcJU6aFdlqjNHvBkP5e9IXKqiPSQ7dJvyC+EnIm2dI6vZ5Uh7cr23hUATyriXoDyVW/SwFyYHTHyBUzXVGM00uV0uzCOOKAJuaBvU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NWZJZTBSWDE1T3NVVFlneC9hUEltdDNzUVh2M1FZcjJZSW9lOHd1bDZTTjB4?=
 =?utf-8?B?dE40ZDU0ZVpaSGQ5RzlrVGNjUE9SMTlwRHloc0h5WFZUV0ppRWR2NzZqekhB?=
 =?utf-8?B?eDAycy80elRVWTRmYy93ZEtNMnJiT3pybWp4bEtCMUJ1eWNXcUR4cnNISjN2?=
 =?utf-8?B?OW1jTXRSdmlYYit6N05PeUFsU1pleHc5Q2VZV3ROOFR0enNTNVpuZi9MVW9U?=
 =?utf-8?B?NUtlb3VjZ0tVWkwvaUkrYkptaGVGSFAvMW5WTlN0UjllZUlMK1JlZDAzNFRS?=
 =?utf-8?B?RnhZRDlydDZZTnlKVlF3SEplQWVqeEZ1ajIrWGpPTTVoaXRubmFMNkdady9H?=
 =?utf-8?B?M1JBUHp2UUMwK1YreERRbHpoZWNmRGZ6bVFmSFRWQ201SjJvSlptNXBWYUpE?=
 =?utf-8?B?K3lTNnJySE9jQU9JSTgrdDdIRUdiWE1ROXNaSW1EUVJ1eEdpWThWTkVqdWwv?=
 =?utf-8?B?Yy9RdCtEa3JJc1BuR0hpL21wbFg1YWpwVGp4RTJKZktrd2l4RFJERTZ2UkR0?=
 =?utf-8?B?KzVwbDRFcFNrdVJRQzdsbnYxZElwelJoM0p6eHZraHNXelpLNldPR3FneGZ0?=
 =?utf-8?B?eDVRZHVYa1dBallRZU1hZUlnWVh3dG9Qb0wxZ0tpOGNXd0syeDdTNTl5Y0E5?=
 =?utf-8?B?bThBYVJ4SzFPT3p1QjErU0xxS2pUbWdtVWwwanlQRkgyV2tqc0JwN1VzcUVR?=
 =?utf-8?B?NDZXREdhNVFDdnp1YVo0OFhjVG8yUDhGN3paZ0ZMUjl0aTYrcTY0blFobkh5?=
 =?utf-8?B?N0wyaFdFL1BoK1EycUt6Sk0zSUhLQk5leUFaTFdYd0pORUY3UGx3RHJSMEJ0?=
 =?utf-8?B?aTNxREpLeGVTKzc3RVNyN0dZVWt6Ykk1dEdkcnBoc3U0SlBhTzMxaEdkTFBw?=
 =?utf-8?B?Ukh0TExmL2NjYVFpT3dyaTJ2cmQrVzJrQWUzd2ZOM3Y2WTZSbkJKWEN5TlIw?=
 =?utf-8?B?U2NrZTRoMkpVWXRGQU5OVXUvalNIU0ZxUXpHZkRGcmVxYjIxK3puYTBOOWpG?=
 =?utf-8?B?OTRpOXYySStNUE84MDkvcC9wZnBvbzFLRWo0U2xGV1EzNE44ZzVHWURRWjVa?=
 =?utf-8?B?azdadlJEV0d0b2plZUJoR01EZm12a285ZEZQQ1Y0dFNnVnhIM1gxZTZ3Zzc4?=
 =?utf-8?B?RHQ5TEtMRXlycmc4ZzRXTUNTblcxN1RXclQzSHliNWg1ZTRUK0pxN1VKbGFv?=
 =?utf-8?B?THpDc1pJUXdXK3M0a2Y2WUkyRWJ6TERJVWpCcG9IcXNqRUI0SEZXQnJDanlo?=
 =?utf-8?B?VGxFSnZpd0ZlU1pEVFd4MndOOXBmNUg5YkpJekdDL1ZYZ2thOVBndDJ0K2RQ?=
 =?utf-8?B?elZpSVZEekFPZlcxenlKM0tTcyt4QUtOOVJlQ0Y3VFBTd2JIOUFtTzBFZFhu?=
 =?utf-8?B?MjRvcHdqV1o2UFU3eGxsTEphSnd1S01XWnU3UVMvd0ZGUlkvblB0d0xycjVX?=
 =?utf-8?B?OFg4b1JWMnBFOWxwT1plbjNPWVZOVUZRdDF2SWlBR0VPR0FXSDJKMDcveTFq?=
 =?utf-8?B?NEloWCt5c1FWNTg0VXEvcUxUdUM3WC8yRmJJaUFPb1lUajl6UENhODVuZURp?=
 =?utf-8?B?U0w3Q1RDeUt0QlpPdjFPUXNhcDVUNVhhdW5PcWhSMk1YNlY0WFBBQXRkWnhI?=
 =?utf-8?B?aDNUamVjbytORXNEeFdwaW1OZVh5NGVGWHJ3NTBTMnp1bG56ajN6cVE0OTJr?=
 =?utf-8?B?SjJ2U0NWdUpnRVMyVThNQm5Ubks0ZEErWER5RkFnajRIM1BXS1RPZlhNQ2tu?=
 =?utf-8?B?V1BxVUNwdWx5dGNmaVBvTXBZU0RqYlNGQ3RqSVFpYnZHQ3VRaEh3SWMzazh2?=
 =?utf-8?B?cHlObnJHZC8wdTFwS2JaMkFubzZyTU9takhjbGd6bHhsNVJ1OFpXU0w1bU1u?=
 =?utf-8?B?K2VTNlJ1U1JpVk5veFFIODBEVllycnh0L3ZCOUhrMjROYVdkaVJvczBGWjdu?=
 =?utf-8?B?S3hTZytTTW1PY2JXVDFqdEJOQjgxY1lYcWVrSHQxbUFsank1aGMwU0ExSlpZ?=
 =?utf-8?B?d1RxV242dnlXV0JyV3docDdUdTRiT2RxRHdIMGtmMzdxcldqVnFzRG01R3hp?=
 =?utf-8?B?WGtNdTQyeWZZcFNsUTRQMHROOGdNcmlzTGp6VlRtenk0dmg2RzdQS2RnbnRB?=
 =?utf-8?B?aHh4d3pZMVJETVlkM0NRaVhWTHFLcUtHMVpTTmZBSlgvKzkrV3MxU3R6VXBS?=
 =?utf-8?B?N09jTXFFc1hoT3YvWldMdjZWTVNPeXFtK1BGQWt2b2dOOEtRS2tDY2dYS3Vn?=
 =?utf-8?B?SFhHQURUYlY0UGdJQ3FyYzNxS0tBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	U5PbK0Q8RpHTwQLvinAzNrgG99TYZJcp6Q3KDBYDQcX4QFyDyq3VvW5ZOyq+F8FW7cBbzgyK4+2ma6MzZtpM8nNvtpsPyyCSTS7eXmUxLsKDfh5kdRBhhLrA5/tB5xMB1kX1vrPGZsQ/jinPf4RCFvQFh7y7CQhijArbvWwqfo3hozQ4n5qG15kSOupVwquNfaY7/vjssm9Pu6R0LwzgAPV5uxFfROw4m120uTWLnPM16b0xu8ignPX2kjcC0wjygk8IQ3JCitEuQkIwDNWlUSWjsEEs6kZ84hWnQgJbbpVyYLxUUQHo2QLGhhWHwTISWU9mOUopiCQCks+rbhs95Q669+c0Jbq7LZqnvTNqYcxAx+ATbpGI2HfbUBUBze144UcdVNlFS1ZRFok1UVsrmDOFOlWwZIsVt8tCpMPkGNtoLscoL9EE+GKzXoPRUQUKKmoPSWuivfaSlvgbJeBwE/Izuc1Jmrh8W9JNZ1+UYH1YUxoQmEtAWXSrRGZAfq3UGze7dLD2TUSEHWC5Pabzn10SkGOvycWfuHUszba4vQqJlM+XoABmcG/2o/n4tJpsmqqn8/SLorPlt98g5sxi45B7jS6+H/SVymwePepvRzI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42954f2-a4a1-4b01-b7e3-08dc48d9a661
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 12:31:22.0242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlxQAVvfedfWha+0n0VQ7OsVcqVtmx3aVBnNrQKQiZNdXgj5zkwwYu5qHvAh9H5KZ2c/aDN7ya9dv/v2uUMsMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4392
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200098
X-Proofpoint-GUID: LobiGyT91kmuTBYUy5SwJ2zbjxaJmaxm
X-Proofpoint-ORIG-GUID: LobiGyT91kmuTBYUy5SwJ2zbjxaJmaxm

On 3/19/24 22:25, Josef Bacik wrote:
> For some of our tests we have
> 
> _require_btrfs_fs_feature raid56
> 
> to make sure the raid56 support is loaded in the kernel.  However this
> isn't the only limiting factor, we can have only zoned devices which we
> already check for, but we could also have BTRFS_PROFILE_CONFIGS set
> without raid5 or raid6 as an option.  Fix this by simply checking the
> profile as appropriate and skip running the test if we're missing raid5
> or raid6 in our profile settings.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   common/btrfs | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index b0f7f095..d9b01a48 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -111,8 +111,12 @@ _require_btrfs_fs_feature()
>   		_notrun "Feature $feat not supported by the available btrfs version"
>   
>   	if [ $feat = "raid56" ]; then
> -		# Zoned btrfs only supports SINGLE profile
> -		_require_non_zoned_device "${SCRATCH_DEV}"

Don't we still need to exclude the zoned device from the
RAID56 test cases?


> +		# Make sure it's in our supported configs as well
> +		_btrfs_get_profile_configs
> +		if [[ ! "${_btrfs_profile_configs[@]}" =~ "raid5" ]] ||
> +		   [[ ! "${_btrfs_profile_configs[@]}" =~ "raid6" ]]; then
> +			_notrun "raid56 excluded from profile configs"
> +		fi
>   	fi
>   }
>   

Thanks, Anand


