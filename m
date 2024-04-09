Return-Path: <linux-btrfs+bounces-4066-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AA589DD94
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 17:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F1A1C2312B
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 15:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C4B1327E9;
	Tue,  9 Apr 2024 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gVVHdlu4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q63gLNbh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A271311BD;
	Tue,  9 Apr 2024 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674888; cv=fail; b=mwO70FkILNr9hl4H1T9sJvuhCRlMHlGFgdw4gdZChXEf6BXhz3WPKEizcEKL/c4Zs6J5ZypS8IcLDndrS/fQGVgQMWH8BQLJm6CDM0ki9yPLnYj4UbWW0Jt6qSIuzbw08v+Q94Xli6wcRqQopD3Fk5icTaCdJ4LrHlCrLtEH3HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674888; c=relaxed/simple;
	bh=Col5DYGIIYOgCsbVx/1An3xkKtGsyG+wHMcmFKO6BBo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SV0kK6ptPFUQXBL1sQ9s731yjqDsOoPUcq7NDJaqZTv91yZ2HnBznjWs7FInD4DgRRyV1633KutpZBPluYlSzCgO1hIz9cSZhvx83R8kM8xZHCNMsDLRUBgb5EKv7vZtEJiDkJffkzcKRC1SxsWs8Su7w3nICG/6gSyToGO2T7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gVVHdlu4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q63gLNbh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439BYIM9031282;
	Tue, 9 Apr 2024 15:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=zULiWfpP8LGoagvehE1Ys3faZy+H0y9GJmqpMW3DFOA=;
 b=gVVHdlu4sjfkuvi5I4tzIfUoutF9DP+MJOAcNLAGRtLt38ssAmJoQIprjWUVoxbIG5DO
 /ISSRBztT/FHA25xr3oAy0wPLRNI/JhkE2oiQCQLUzmQ5mGhsWSlizwtKsee4hNmZQj2
 DVjeqfYGFmypFuTP37lAJ2QB93qzCfQ9xyXq3yonjkML03iRX8hKx8dnPGuAGgHhI8uZ
 oVxPlx9IeQXEpy2GR7zXEAXLXpYHSjBlXcIZ/4sdkjIeTCEJ3jT1reC4MFxuwlnpgNXx
 Apyl5Wk4hfDZlUxaWQIJHgwPAi2Yk4N4OpOW0ak5C9+8jDgB1Nlk5sJ2R2rMUnOdOGBc mA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax9b55ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 15:01:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 439E8jve032535;
	Tue, 9 Apr 2024 15:01:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu7a54s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 15:01:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awCQhgWxdCWSezMpHKVPt7IlQXxlHtfnEu4cR0+uApXgOgE1LhyuRXpRmlvvruvMRGO/bgINRCFLYHRcbcs5i1/3+v6rNV5MzqmaEOe1CypxMOQmK1Os8DByUcIL21mVaVkQ0NN2utJez5TkdoPa7Qo6Ki8Y9/q9A6Nycblo5uAi3PmhYC0U3AzUmyAUqCCMPWYdqdMLtI27BEOF6h+d4sKxW1a6L2OSgglIzj8FFYEYfeoEmZsO2kPRAxgMaQMDMpMn1GI0PlI8+Jzi3z3RckM3mzYiK3dSbR72SA4XGlOatXaZrLbGrDkHDA1bdca11obWYPeS/TOrSDC0lbVj2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zULiWfpP8LGoagvehE1Ys3faZy+H0y9GJmqpMW3DFOA=;
 b=fDsRxFqKAxeh8iK6bfcPOznZeTO5I7cb3+8lr0Kt/suHrHFMxl74fxD2n5HH7X29DPUmRRXSkBVFOVijUlARHYanbVY4cp0bjG+S4r8UVVHu3pFI9enr1F04U/guyk9t9frBY30yz3Yyd8IRto8GWhnb+f5MZ8PpRXuQMFNW9V6cj7BR5C5DrI/XjiUIjcLx/2eniKm/yCltic0ulI61AB0GJFUPVvrQz718xiL8mzqr3Hg2Sl9wYgLGj6HOo+6NmwKiesIpiWTJ1hXT13AnjInWrt3j4PcEZvaFKHU3RO8j7hRPu6jmYUdDy7Si5x52fQhlJAtFB3/wydxxIJOA0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zULiWfpP8LGoagvehE1Ys3faZy+H0y9GJmqpMW3DFOA=;
 b=Q63gLNbhXeN4F7ARf0Y0Fh1+j7DBDfxCaMEZ0GK29Ga4NUm9fiSf44QFeM06BgV+tKuefppoQCcBZwOp3E85aNAQI1aZCeNyyHGQsHSpQSZVzFDM5FgGEGKY1fTEWNihgpeSDOndt4ruC14Z46JnLzWs0iRAqWCYnluODv386cI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6782.namprd10.prod.outlook.com (2603:10b6:208:42a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 15:01:14 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 15:01:14 +0000
Message-ID: <3b67bdd5-8579-47fa-aec0-898d4750b064@oracle.com>
Date: Tue, 9 Apr 2024 23:01:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic/733: disable for btrfs
To: dsterba@suse.cz
Cc: Zorro Lang <zlang@redhat.com>, David Sterba <dsterba@suse.com>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <20240222095048.14211-1-dsterba@suse.com>
 <20240225154123.pswx5nznphszonns@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240226113340.GA17966@suse.cz>
 <20240226180723.v4vwjts4dxndifaq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <91ff6357-7b21-49dc-93e5-14f2f4e3efab@oracle.com>
 <20240409144600.GF3492@twin.jikos.cz>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240409144600.GF3492@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6782:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XFSwr1h0/5sLOjJb2uEaGek4yxdZEpbKxYKqzYT7TK997K8g61FQPZHPdLvSw8c49/7FZhPK7BFEoTyTi/CdEtDvhl3+6BUd5T3FcuhCCnJlY4rKbdAwfbDt4amPk46f2MtaxAKHb/6do7UkhAbwAJl/5IdpvmCONxB8TIde8JUcr2dRFxmnJg7KB3l/LdNno5dyPWwQ3Qy1AUHuXjoDiuKYn1Pj0En6LsFPvUrR+OY6gQqIPSLH+Ikaq/BSM9F2ot6skx9pj9HTyy2TC0Q4mZ/up3AeTuuxP8Z0cog72LdANK5X2dVZsAGpFtucumd87dJeYIjOV9GdnH54boRSqCsjJPpGlZhsVuq7EiyvsPOOU4vY20lNWb8qWRmnesqeaki33xhFRIDfqrMDN7NwT2UwnzqJLO2Orx3ByyZdVw9s4qXgqmqtgk6r8U3iwRlPEnejbZCtv6SeqflLyxugduEmLpqeXNx0mirwdjC2cTFxF802aZCc/8CkWW3hwTlQpOidTeYEKu9e/gmALVsZUptQD4PGgsan17LuStzbQ3OgmIz2+67XxJt19FYn6c8Y8FktgAl51Emcq0gminCTAUofXk0FAUq7oR2PqcmvXFZiOKjckQPOor7xcweouGuDeFKTBNW/un690edqNXOG8OAc2zz44cFlHiesZ7lZwN8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZFlCWlVVT21tR0RiN2xLRTJPQ1BjTzkrSnNsdWY2WWpLOVFOZGprK0syMlR2?=
 =?utf-8?B?L3I2S2tVUnhCV2dSdWFnbTg5d2xWSWxUb3kvZ2NEclE2Zy9VbndIRXNxeWUv?=
 =?utf-8?B?V1R5Si9lbnh0dGRFcndKVlo5WHdwT09PV0d3YnkvZ1hBSUNQcHRlMmFTSEo4?=
 =?utf-8?B?NTdhaUJvYlEwUGloSVNCT1AwWEtIQjhBVEw2dXRxN2RUcy9HSEZVeW5kelZY?=
 =?utf-8?B?NXNxNXdJaElKUFVxdmQ1RFAzQmdxNHhldG9YUXcvY25YblZ1TTdSS1JjeVVn?=
 =?utf-8?B?dko0R0JKVkRSSVRwbUZTUm5BZm9TN0RYMEtaVmQ5anNWWC9ydU03SXllTnhX?=
 =?utf-8?B?RHZ2bGZWamw0MCtvZ1hPdXRCbnQxYnpYRFVUZ3JKb2Rsb0NWZEJYWWxCMzZO?=
 =?utf-8?B?L0ZML3FQaUdTUy9YNkwycjRRQVJtY0pvWXFBaStxUjNqdWF6RE50Mi81QzNQ?=
 =?utf-8?B?eDQ1ZnU3aHdwNlY2VWJ3dzkwSG5kaVF6K25WTlAzTHlrOFBneW45NGFWaEVG?=
 =?utf-8?B?VmZKRE5BTVlHRUs3OGhuM0dVamZKTG4wNUJuKzdmeVR0OGkwV3JJMFFKVjRD?=
 =?utf-8?B?YVova3VNcVgxZ2diOXZjNllTc2dpUWN3dUxHVkRFMllPNURpbUcrNkxYelVB?=
 =?utf-8?B?UDg2bzhqc0YzRE9Sd3c1OE93RlJCNW4zUWJyNG4rMDlnYTdyb2duZnQxRjlu?=
 =?utf-8?B?RnpiOWt3MGdFK2FtTThFbHdRMk1BQ204Z2VBdnRXOWNFVU9lUW1nZ2xkUFg5?=
 =?utf-8?B?aXVnQ0xmdW1ON3k0WGo1cTNiZlJiZ01YUFhkYWhrbHFiclFHU0lvV2lkUWcz?=
 =?utf-8?B?OVBaK2lFbnJPeEw2SnREOVZjWDUwWWZXQzc2REJpdzdoY05lTk1zOXRsS3dH?=
 =?utf-8?B?MW1tT0psdHdHUjdiNllUTnZqTS9FbWFuYTZJTlhZSUd4RU5xMC9IQnRQdzdP?=
 =?utf-8?B?eW9nU2pTeFBKbXBWZ3RCOE4rcnFGQkNBbW1NTWVRSHdvRVRmNmN6UllkYU9v?=
 =?utf-8?B?RTBFdHF0QjlDQXd6YzAraVhWTVJOZzhoR3RURXF2bzdvUGdvS2tiVlQ1TEJT?=
 =?utf-8?B?ZnlpTTlacCt6MXFVK3hKdzNIWUxTNEdRMnNZK3gxRmhSYTQwTnFEKzNjcHhq?=
 =?utf-8?B?elAwV1laamlmWTBqaytjKzBrRTdRUnVwYUZidElFek5wV3gyQWFNQklDVDNn?=
 =?utf-8?B?MTUwN3U0d2IwcCs0Z1EzcVI3aTdveE15a29SbFBTeE54V2ZjcDR2QWRRTjNj?=
 =?utf-8?B?MFMvQmN5WmpEZEpaQmQwaGVmWXFjejJnSWhQK1N5NXF3L3BuSHJCSlJ3T1Nu?=
 =?utf-8?B?TWNNcVNGM3hvRmtLM3RxTktvU0RwTSs3SXRyVTFBZnZDRWI2dnZQSDUzNlNr?=
 =?utf-8?B?SHRlM2V2RThjY3E0VG1LOEVhNFpzYjVkUGpQRC8vNlhKWVMyMklGVXFnWWFo?=
 =?utf-8?B?cVNRdkJtdWZ5N3lHWVBFNkNCTUR2dlZja25IOFAza24rdjlOK2ZIWmtudlVr?=
 =?utf-8?B?ZkpFckFVUjhtSml3VFZXYk95N2VTM1ZKR0U3eE41SlVoRjd6U29xeDY2VnE5?=
 =?utf-8?B?MTY1MFY2VWlGV3NYQjV2YzIvdGxRNkFTUy9kK0JPeW9OMWE2TlNzKzJyU2ZY?=
 =?utf-8?B?S3ovV0xIZ1JHTW1UY1BTTXM5TjcxUVFJQjdOeHdxM3hhK01YdDdlc0VRM0h0?=
 =?utf-8?B?MStOSWp4UXJERmxYbXhseFBPT3BkU3NkV1RLMlY5cUlPN3c4U1FPc0VGZm50?=
 =?utf-8?B?T01uL3hZZlduZ1hOUXpLU0xWUUt4djZTcWFjblc4ZHI1MnB4dWlodXIyOVZO?=
 =?utf-8?B?S2taNEdMbllGZEU1TTJISUhlYW5ISW50Sll3R08xdnAwdGdXTElMajVoNHBV?=
 =?utf-8?B?VkFGK0R2VWt3RHBBYmtuczZOZFE0aHd6QlJPY09CT0dMdXpyV2lHYjZvRXhQ?=
 =?utf-8?B?TTlQeXlMODVCUzZUdGRia0lOM2xXSElFWFMvMWZBVHhzN1Joa2hVbGxJRFkx?=
 =?utf-8?B?ZmJ4TWIraU8xNncxUU1vYjgza0cyenFJb29oODJsZTMwNnJyV1Q3bzNKRTlI?=
 =?utf-8?B?R3RiN3ZPNGUvYUZZTHI1ZU5EUDFCSU1JWEJXaGIrY3VCVnBqNUtsU2NTclRM?=
 =?utf-8?B?WjBPMjRwVGJpL2xLSmFVSmtYUW03NzBsSitiMHpNVEpsNmExRDgvMlA3VkZW?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Mz/x8OO66g3tXfclkUXSAVeV1PsusseN3SEe0/G6Xi7oqR1VdcCjtbY6Q3SjWN4rPBrvi4tMKwMgIaWRKfave8pRGC3Oa5yDT6DZBHcGRW2HutzGNlwkgXJBGu0WEDFUYNsKp7EvuXJlzNRMMPm6UA9rbBVYWnLRWU9/HHCQW747ghhPaCWL3gl51Iij7S06kO9azH1jy1WgpBo1ZX9AvMcSbxS3gse2yn9yl+Xyokt+7d7BUBE4jbjYSbxQBJVwWMN5pdKDolMmaqOWTyS2OtN2YaDS9wVldpZnUgQHD4xHqzpGroJbWU5vI04w/9nl+snLIC0WeJPNSYolMdT3LTtmdym1ctlQqrep71eODCPc2tmO05dNXUTSqHTfvKxgbJd/NDAcnIMLv0v/dyHYuDzoySqQjLFqspYnYQv2Ojtz7wi8r9XDEuaAwiQ9pflqI8FREh8gTvHUP36pycf1E8oMU+X0sKCR8fKipBm766yjsaOoGwJWuy+2BhQT89rySN9qDR1QztKK2vGQTx514UH3GokP+8uYjYo9+pP19i7nH3PvGsZJNQct1xpKn/m4HwxgouapEzf1oVDAUSJDlQ6g44ybpHOhlqqqBtCU02Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5d5011-26d5-4914-aa7f-08dc58a5e653
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 15:01:13.9664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnJ1BgZRrjE2vfuXBSnk49/jZJInZ6SmmZ4ZAfOCZFyvEj71iNZFl6gMiC5/+XWWxzXG+IHOEMDjWv9/6Zt7Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6782
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=939 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090098
X-Proofpoint-GUID: N9fG4NG2O02F_SuaFcsPCNVJ8a5i9soV
X-Proofpoint-ORIG-GUID: N9fG4NG2O02F_SuaFcsPCNVJ8a5i9soV


>>>>>> This tests if a clone source can be read but in btrfs there's an
>>>>>> exclusive lock and the test always fails. The functionality might be
>>>>>> implemented in btrfs in the future but for now disable the test.
>>>>>>
>>>>>> CC: Josef Bacik <josef@toxicpanda.com>
>>>>>> Signed-off-by: David Sterba <dsterba@suse.com>
>>>>>> ---
>>>>>>    tests/generic/733 | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/tests/generic/733 b/tests/generic/733
>>>>>> index d88d92a4705add..b26fa47dad776f 100755
>>>>>> --- a/tests/generic/733
>>>>>> +++ b/tests/generic/733
>>>>>> @@ -18,7 +18,7 @@ _begin_fstest auto clone punch
>>>>>>    . ./common/reflink
>>>>>>    
>>>>>>    # real QA test starts here
>>>>>> -_supported_fs generic
>>>>>> +_supported_fs generic ^btrfs
>>>>>
>>>>> If only need a blacklist, you can write "^btrfs" directly, e.g.
>>>>>
>>>>>     _supported_fs ^btrfs
>>>>>
>>>>> then others (except btrfs) are in whitelist, don't need the "generic".
>>>>
>>>> Ok thanks, do I need to resend or would you update the commit?
>>>
>>> I can help to change that, it's simple enough.
>>>
>>
>> Applied for the PR with this changed.
> 
> The test generic/733 works after patch
> 
> https://lore.kernel.org/linux-btrfs/5fe82cceb3b6f3434172a7fb0e85a21a2f07e99c.1711199153.git.fdmanana@suse.com/
> 
> so please keep it.

Ah, appreciate the heads-up!

Thanks, Anand

