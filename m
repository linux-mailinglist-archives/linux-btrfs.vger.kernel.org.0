Return-Path: <linux-btrfs+bounces-2885-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5343086BE79
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 02:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D571F2441D
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 01:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADD0364D4;
	Thu, 29 Feb 2024 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fRLhYukT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NyK9d26c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F861364A0;
	Thu, 29 Feb 2024 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171408; cv=fail; b=YOyKdRQAsKL6+NqjbG3KWomgTooIAjFwpXDTyzPC/zMYTFSrZdPCLk873pFYylxQKyv6Zy2ueVFkwhlyq/ZoQs/44eGhUOp2sdCL9ymHvHeMXXTBVtv1jd1BNZszz7YkS5IlbanoCJRTwBhXgouHfUNpGuiCN6xyDAFDTmnVb3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171408; c=relaxed/simple;
	bh=zTFIUW8LFOy9ek3PuDpILun7LIRkTAqwDTaVOHY0o74=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rVj+WZgXHRxDsex4WOp0X4S6sJgDP9wVtwzs5Z8nZC5Dq2e8uTFEm3RGlORwsqKtnyHLkCAhV0wvwJJFpp4nTnyyusaGD2vbdU8sFyrc++EKEsoF2QQ1itvRakYM3dmE7dfBQTa2JX02fOJUg7y8irXtFt+MYKHInFQz4wtcIIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fRLhYukT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NyK9d26c; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SK3CBP012890;
	Thu, 29 Feb 2024 01:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=rYP21eOIHbEx1/S0p3n5zenNKzmU0ZnsaYKQpg18KbI=;
 b=fRLhYukTrv7n8M0Dm5mKhV/EWBlRS/Lygco/7mEkXDs7OvavOIIMZNg7rQCOjfUk1bvK
 b1JhiVG78HuaAAXVhlg+P7NcROWL/fwVgbD/Imsjv+USj9S7Mfv7iYhOm3cgUP0/+jJn
 MED5Yu48NeXNjEedT/owEWYWWZq5hEzlHCw0m/OscR72TQU9R/YQtUl0+C2ArmHotVln
 VMWN0H2kfKVlmCF4r9IGYc6ecnzXhFeQTGC6JewblQ07Fn/1mbRJfmjsReZk4wa2ncR/
 eyOeMoBFNYPVRZig3por2flf0cNkqdAL9HPr5O1XU3Dh1SP/UFKuqJ++cskoi7atj4Y0 MQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf784m5hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:49:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41T1jbmX009836;
	Thu, 29 Feb 2024 01:49:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w9rp29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:49:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMRPGydWVewsy6po+LINZrPpM0EbOiYqPQzfecnVRaPE0sexD9bZfnLnUPAeXUsSBf9xVE+3WT/5bARPgQ+aN2AOKDGCMyiSimmoH13NaqBycMmVeemR7JWhmcajJnjzKx7HfxCkBkPI5OIHJGFwgUz7JYu9OWaAIqevgS+nVmSUZGrBEMSaniijocb4Tme0en+QuRydEuqourBFO2G2sq4kdVDtisjG7DqRB/Ii9E7lb9exoRWZtTKodVHyNVQz3UXiONp3K2wteiAZAaWCmlHrh8jVTJGn0MpA4v3K/+DyvQjs+XANgXq7mWY81zas9p6BUHxcSFzRo4hefqP4FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYP21eOIHbEx1/S0p3n5zenNKzmU0ZnsaYKQpg18KbI=;
 b=E0aJ1Ur7zPJXnkESj1w2uUazGitNPZoaic+lrL9DMRbas5k/0ovXGeuF39bq8TMEayr3LjxqsqEkt/pnClNBx/+MDyoGVXQxDNObTjMptUccfzNsM0Q1ZdgUap3lTteTSRfs7aKOaNjzbabC4x+e8nPG7geS1rDT+SZ9V4iy4SOg/x9jMSLsswJTIKHACoiQdzgfjEQ3P6SSaNwBoHpuAw1GzsQNyGASNePnwxPmCzJ/vohaJfoBu43PfDsOzr+AklL8bVMwhbY3IHOw2L4OupHnl9f6BobTcGIfBXpvJWgPX+OP7NmnKk6YmOQjkbst3j/9TmMHIrX8dKtnGVcrag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYP21eOIHbEx1/S0p3n5zenNKzmU0ZnsaYKQpg18KbI=;
 b=NyK9d26ccik20WObRlLrnyMhqNPOOJjjvl8nvCDsZV2f0bxV03/JqLAqOOI4L97+/MV1XPdh02CRQ7ehh+zUqAnz32KRVda7fLfF858pVfKldg1PpLRNH3xKfbAtAW29EvITN69Np2p+1XdI6yxgnRh6SW7uELskva8deK8EU2U=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6239.namprd10.prod.outlook.com (2603:10b6:930:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 01:49:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Thu, 29 Feb 2024
 01:49:55 +0000
Message-ID: <c5bf6886-252a-4614-a1be-25481d3776fa@oracle.com>
Date: Thu, 29 Feb 2024 07:19:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] btrfs: test tempfsid with device add, seed, and
 balance
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1708772619.git.anand.jain@oracle.com>
 <faeda97208d0a2ecca94490b35a4dc8e98e7fdc6.1708772619.git.anand.jain@oracle.com>
 <CAL3q7H45T0+BHQqDwOTjWhWeG=yStY+x6EsznRrrdeGAE9qzng@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H45T0+BHQqDwOTjWhWeG=yStY+x6EsznRrrdeGAE9qzng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::29) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: b902b1ab-5cfd-4c40-76f6-08dc38c8ba68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ywpqPc9EBA6P+/Yml4e9OvL3whoSw/zU8TXq4YOXfSiojX0hxAGo+tTTJah63Cyz4r71nDg2utR6KbVU5aCjJu2MFcsYtEemm9rDdwQNZLjRk5VGE2z2JBKH5AiF47w3j5ETkhm/ofUiHoxP+PqbRxIEy+kOYYiwuD93sfpkcOh+6L9bMwlhgrqq1J/oayCMiWJUcD5LpaYcd316GzpoM9ai3lbYpB3VCOkogCwveHHoUfdeGvHoUGCPascIDy0lftVD6s1auQnFloC2gVfMeSQ3Q7Y6pjaZFixZZxAehFRrO1/4/nNDHjmDrmRKJhEgIrPc/8szaxES0oa8fQNC1oSwlwEc8fqkOIpddXbqTYnvrAzKe0FGs9073IPz4d/tC3ZdK+3x23JFfTomYVGX+qFOqnx8HkilAYAi35cIDs9WYunNbGBE+IZ/Jr+HVIrhSw0AkPUPvbgDy1OXQI7xc415F5D3iIaf7ZLXosUrPbL/EW02TciNoKDoLVPEDsLRddCkPQqYUrcDr5iRuo3haSK/HYypzON7Dt80HBR1oBm6iAk2qamGQjFuWxjOT0IV6wHkp7Nm2WFgzI1RM6dOQ4iwSR/ARQ+htNU8JwC+UbF+NtD79XRS05qCEtmKsAS37McNtgHXqqGGhweghNoveQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OWdLNFVxT3hrQ1R4emZLcHhKcWpxeW5la1pNMm1VSHVrOXVtdmtXN2s0ZE5a?=
 =?utf-8?B?cXJjMTBSaTErNktGbzNQZ05sS05JeFcySmJEZjZkL0RkN25NQzFRYXd1ZTRP?=
 =?utf-8?B?ZXJwVko4SjdxOHdMUEdzZzZsY0ttdXlZakZoT1Q3dWxEdUh0OTJhSXdWRGhR?=
 =?utf-8?B?RDlhUkJHdkVjNkRiQVljVC9CK2UwZUtPL3Ftb3U4a3ZjeDVZUFVETzZmcDB3?=
 =?utf-8?B?RmZkczFDS045YnhRZWpORUtTMVg0UzV0aHRSNHZkZXphMkZCSG82ejZuR3pp?=
 =?utf-8?B?THUvbk90NEtWeXBaSGlwdVhqNklWcnpuTXVzSllBM1BYYyt0TXdNcUl5SGt5?=
 =?utf-8?B?dGc0cHh0Rm9lQzRjRklkL3U5UURDSEYvdTNxSDdaOExLaHNlTkpEYjNiYmR4?=
 =?utf-8?B?alFlSElldXJQUHRDbEhOT2Rkc2p3dkg3VHRQMWRuWEkvZ3FRN1RGQS9RdGZS?=
 =?utf-8?B?anMyOE9YWjhRVWp2QmZTbkZQdTlGVUxFRDAzQW9rT21NVE5zY0pTSUtUNUxX?=
 =?utf-8?B?WFNCZVV0ekRMaFlMdU90OWFSVlJ2ZzM5cXpwNEtxMXVOeWtVWEg5OXFJbys3?=
 =?utf-8?B?Q2h5eEpWd0Y4VkZSMDRMK1ZONnBubW02Z3BGSkhvVWVrQmxuQ05nK2hyWlJ1?=
 =?utf-8?B?czVTMWdLMmIzRmV4M2ErUzdKaS9ZcHRscjArc1VVYTZVMUhURU05N1BLOTBa?=
 =?utf-8?B?ZVJWOGFUZmVSLzI0ak1QOHdHSHA4ZitNSVFoWXpIN0E4MTk0UDRtSDVQcDls?=
 =?utf-8?B?ZFB2ajdJVHVhbTdSaFFKTC9INHM0K1p4VlVkNGlQakJXclNuZTg5VVRDbmxw?=
 =?utf-8?B?MGlZUXR5bHVMRnBRbGp1b3VnUlIzcC8zZWR3UytQakJRek02c0F1eWxndDBQ?=
 =?utf-8?B?NVR3STlsRDVPNUw2UGxLaDlHZGl1L2NCVjFmeTcrWWxBaEhlazN6Tjc1TW9C?=
 =?utf-8?B?dWpUMlpsR0pSVnd6RlRJZXBNM241VFZuMGZSOWVOdVFINjJWQ3FOSkIrK3dM?=
 =?utf-8?B?dWhnRG00eTBhdWJDZDFqSzZEWmhqR0pYQnRWdEI4cUF3NGludngzYUtJUUs5?=
 =?utf-8?B?eStseFdFU25XaGpvTHN0c28vSUhESDA1Ulc1MDZKckhjNm9MaUpuTCs5Zisz?=
 =?utf-8?B?c1h2enBySkNvdmJTUGdhWG9PeDJ5dSthaVJ4Q0d0V3FTTnZRY0RJUDloeTUr?=
 =?utf-8?B?MklrZFRzUitOcW9yMTZHWGpNR0dFSjJyakxHZXdNSFlMdUtQTVFnOWlUK04w?=
 =?utf-8?B?NFgzYzNQalZOZ2NtM1BkQzJtTW5lclRUNlVVYWhtV2p5UXl4cHhFMGN0NCs0?=
 =?utf-8?B?aExhNzRHOHlJK2ZLcmNVTnFvSU1jYzZvYkNzMGdmZWR1bEtuY1hMWWY3QXBV?=
 =?utf-8?B?MWtuTTd0TjdwMGFKZ0FkTWVISTZMYkFZa3FVUGx2Y0E1Nk81RzBmT0NIUjBK?=
 =?utf-8?B?VW5XRDgwUU9IMjViWUZxTWtYZ3VyMzdYOUxKQy96YlZQeWc4TEI0SjNRQzhQ?=
 =?utf-8?B?QUxqODhVQ2RTbkttdGxVRDFXNm9QVjI5dWdZMWF2MXNXaHRXc1JwWU5oNndJ?=
 =?utf-8?B?M0lDQXl4K2Z3dUVscjY5aHh3N1RHRnZyVzlJMVNvWWllejVNekY4dEY0eDV1?=
 =?utf-8?B?Y1FOb3RBdXNjajNqaDJVakQ2UUdIOUdSQjVSWUpLYzJMNzFEL2NtbzB5Y3F0?=
 =?utf-8?B?Y2RCNFpTZnEwSm8waFh1S096TVV0V3NNSDFKdWYyNm51ZjZsNW1pZUpaaURu?=
 =?utf-8?B?Q1lTb0ZWdjRBdGxISDlnZEJQelFKbEJHVk93NXlYWFdaRmZ3bGRvVlZoTU9h?=
 =?utf-8?B?Zm5wU1c1Zk5KL3JzU3J2R2tTOGt6bWQvS3RGT3BURGxEM1hIUm1YTC9EbVFQ?=
 =?utf-8?B?clJMOXNGa1NzUjRrRkR5QU1ERkN4NG5UWkVTR2cvSDFJaC9KVk1oWmFrS2tP?=
 =?utf-8?B?NTZiKy9UWG1RQlNzQzJlZE13UGFOTmQ0Vk9BaklWTWdjUXl3VzN6YmdEL3lp?=
 =?utf-8?B?dnMxNU55eUEzL2dhWnRKcDd3MUxSZWE5UEVnbDJlSmhPVFUvamZBMXIxQU52?=
 =?utf-8?B?REk2WE9SOTdUdXJ5bnRDcWZKUm5DRjExdm5HY3RSUko4Njg2ejduNnBycDlW?=
 =?utf-8?Q?qbo/1tnj7HFLJvn59oAQdaPSi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1xQdO/UshvYhHTVA6iocynC1845SvcIc4QdjCbLSRQq2tgvkwCSdro0oFJSokCwfg/hvCeWAFo8mbhMKuEQUostizJ9fn08m1QhK7QybVsQ3dLnfD5POOpffEoPg/90HYTjb25PwGx5jO0Dlnn1m1/hVL73CU+KCjGHjxp0p6k8mTAM1sw9mWvHjZFlLYW8CACzyrvNC2Mu/I5toIGXxFKyPVw/M03pMUzFPO/6zyw1dgF5XTGw1pEJKbeSIn8pGDmo+I4ruJAeB2SD79L1mhu/DDQmFH1t+10+J7oZZzUnPMh70C39bvlLKvO+6T04gwrjE4L7bz5Hln/8CullJXuuPjUQxnPpaaCfbZE+vpTUZwr98gglJZ4VYWy19GkeRGcZdnJzFZinjfd6wUu71PMTWrwJVH54+SMAtWzQTaBIigsGZrv1YzhuIwfEBDXTi6P6Kwu3zAoPtkovZAPF2n+aJRrF9eRN/EPp09u8uGm9covzs2R2QwmDsB+v8BoBDATsQMcTlYSUz7upxnYHUtzxcHB+PDln9RF8hvJrnoKBHn3nePl5EEaRoHBfS4Qy9IHmIL68ooeZDNhSOFxOxvyTvZJWXWXmLK1075KVCz+I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b902b1ab-5cfd-4c40-76f6-08dc38c8ba68
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 01:49:55.7658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RINOvJ53o3mhTmVnjS9laxaIhTQxsQ9OASkjIxlNVQ0yxukUXNnvmsTW/4CC0IhcYDBaE9JFbSrtt+tvPbpJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6239
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290013
X-Proofpoint-GUID: R-l7v2CkT3IHFoWi6L25We16C8llsq2o
X-Proofpoint-ORIG-GUID: R-l7v2CkT3IHFoWi6L25We16C8llsq2o


>> +_require_btrfs_sysfs_fsid
> 
> Same as in the previous test case. This requirement is not needed, the
> sysfs fsid path is not used anywhere in this test, likely copy-pasted
> from previous test cases in this patchset.
> 

  Yep. Replaced with "_require_btrfs_fs_feature temp_fsid"

>> diff --git a/tests/btrfs/315.out b/tests/btrfs/315.out
>> new file mode 100644
>> index 000000000000..56301f9f069e
>> --- /dev/null
>> +++ b/tests/btrfs/315.out
>> @@ -0,0 +1,10 @@
>> +QA output created by 315
>> +---- seed_device_must_fail ----
>> +mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.

>> +mount: TEST_DIR/315/tempfsid_mnt: mount(2) system call failed: File exists.

The error output has changed due to some external fixes.
V4 contains changes accordingly.

Old:
         mount: <mnt-point>: mount(2) system call failed: File exists.

New:
         mount: <mnt-point>: fsconfig system call failed: File exists.
         dmesg(1) may have more information after failed mount system call.

Thanks, Anand

