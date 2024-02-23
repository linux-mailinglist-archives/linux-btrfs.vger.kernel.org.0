Return-Path: <linux-btrfs+bounces-2676-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A688618D7
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 18:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06AF5281D77
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 17:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7142F12AAE0;
	Fri, 23 Feb 2024 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cSdqh91f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="enV+eUg4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C752E3EB;
	Fri, 23 Feb 2024 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708021; cv=fail; b=hmJpp/To2WJLMxa+2y3UdH58zUV/fZF/b6zQRsUnPMpTcAOXAORLNV1XPP2J3k0CvSbyBHVUvAjWObBM+pqY2nhvXgXV427NzRr2JjCTK0T0XSeBYMLj9EAAnTUlXFX7tQqMDN2afE1f/qsZr/eR+rF0VouXdJEO2L8FKC+mPnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708021; c=relaxed/simple;
	bh=ZbZunei+QpXAaDYrwsCo473nKWpUUFaujVnNlRJZdoM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JJ5GtpuqODbKjjv2dySnIR7IXjk3NBD4Bgz2pRNBvDYfAsnZ6ULvdgeM2R/3Q3QUCkgRtLSh38AKitly2ELiqiSYjZE+P2OIy83EXBWScEMjgo3MRa8jdcYhB/TVzSHB5+WBS/+serI8qWeQH7X5vIDu0SRKTLdf4STRZZtaC+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cSdqh91f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=enV+eUg4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NG4ADo006104;
	Fri, 23 Feb 2024 17:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=jzwDJHn1CVZAsWtwVHfRbaVcf+62vFxc70Qi67vBnz8=;
 b=cSdqh91flAorCfy9K5xBSGL4j0lJa6kDMRb8ij3p4rZAMNfH3j6XJUj7y+lm2f/tkRFc
 MXcoRAaumQ+PXIem2uZ+eD7Qnx2Xp21TZCdX4y/Ub1QmiPNyWfqYV8Ggy8kHv7Pv/N+6
 E1Y5ot7P8ndPGoMxV/naPxjQYcIR14whVk3qUmGR3IAvCCcWT95g1nFa1wduvi0ENH3o
 uC9YOMlCQ+NA7pPt02AzuOyqWo3qmqMA/P2PI/bo8kutnYLjVarFj75eg/WoZMdyjeOe
 R//P/i1anJdCUkGgS97IEtk0onn6obyTTfKitvMDf4g1ptpjhunRBXJWcy7RCDIDDBzG WQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wanbvr695-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 17:06:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41NFn5hU020074;
	Fri, 23 Feb 2024 17:06:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8cdus1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 17:06:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObWEGPgtR5JXf5IOvuAhx/Jxs9eQ64v5bSpS/Aao/PL7mNHYFFwkI2BOW/u/AAcfPHqGIiFI9+U2lcohmRFNW1DELMLh0FThhq86SSnsvJ8RGWZ/3cNOWGgEEf1NsXsnhxdVf1ufS6aQq3xrmmgl4bAklkibSoInddaKbyW+G+uj6C9ViUIO/Q9WOJ9y/VpIHIr9Q+6J3bFkFybHmwlLI99qZOas3po7302AjqrFCDk+pxzuIlyYSmwEOOjuTMm1EFyT1ZdfZEvIOzcVeOEInhurK9+gTUhBs57W3Oy3hv75xazyMNS0klvmmzjlbtXGa/2MlaMLw56uEXSKPRQS6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzwDJHn1CVZAsWtwVHfRbaVcf+62vFxc70Qi67vBnz8=;
 b=QljqaFkh4M0aZLBwD/Q3kbtgls+lXEwl1ndBs3ZTr4SqKV/RwpQoOEpJ2qQi87KUI9kkAuVEYt1XTmyHOGQ9JHbOAtA8WmyauQbLN9+eA4I73ffBZ8Eccl2HwK1RYTWLpN9rCFDV7YSqeECoTY/rWHBHp9KtmSCmJNtl9SBzJbCNvMVFbZx6Y303TDj9QDWo0n9LBHPHIB38WWbSA9pgsv24N7FWivVkVtvjxNHkJ0zQlSgRM1IizjubNY656zmH/4KcFJQjWvsxxYyML1f/xb6e4ZsQQ2V7lRHeS5C4hKxCWdD5aBkMd1+H7HYVrtQhnQZrnpchWDa0qXPZgugrIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzwDJHn1CVZAsWtwVHfRbaVcf+62vFxc70Qi67vBnz8=;
 b=enV+eUg4gU14kwgajhd0dpStS4Bw0l4G4aS3e9LepHRSadNtP17tsMMxk+36rzWwMh2eYqzg6PpamBn633wsISvDiUJMaCIS2LZNt7r54NkHWJqK5UxN1xQ5FrffVM+qdE8mLqOH2RPNMyTpcSFQC+cul5Qoc5bNsK7tvIfk3ZM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4450.namprd10.prod.outlook.com (2603:10b6:303:93::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 17:06:43 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Fri, 23 Feb 2024
 17:06:42 +0000
Message-ID: <b3812d6a-e4fd-42e7-92e0-8257a38f2f05@oracle.com>
Date: Fri, 23 Feb 2024 22:36:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: test incremental send on sparse file with trailing
 hole
Content-Language: en-US
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <fdf9b90760477ef48547efa1a5eecf273deaa09b.1708261420.git.fdmanana@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <fdf9b90760477ef48547efa1a5eecf273deaa09b.1708261420.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: 637b0431-5634-436e-91de-08dc3491ce86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1Y6BHfo5Hf1ql5vNKVVqJYN9sZgatNMIEFPyAYmRpP+/Qzuwu571gE0RLbGj497G5wab7ijd+zkhUU82QNm/ghb6qi4jtetVN2FOaV8GYTBhNkOa1zDDDtNV0PdjYjPcxcZNi4LrOgybaQjzK5HGQsJJ2Ov/81FnvK7YWUq1DQZugRGJr0G7CUfTnfth/5dldZysufakKX8UUbDEpx4MnbZbPeO7b3g1k7ythq/hhlAPgnMo7v97T5D1Ee1FqwYAuMwSWzrwHFgxKo7Pe68kX48hoyuN3Z1k041kdJ0kwkLdQD1GV8jw1a8oUn55NrCHc/p/p7gpWeW6cucP60wrFoASCxcQFIZopmIUyk29tQ8CvEIMEMUGv8CyLloTn4IXbdB8J1eAKnMaSRB35KbEtT96++xHRvePKKu9ZhvREWWuyBLCmDndYNcpzUomGr9KhrtWPt5aseXaFTXxTZi539gHhq0Kxp57RHaOW4EN1pXCprLCtf1okTWdZBLY78TcgYNC6wGoz4CpJiDe+7wSzX6QU2cCYIOGPC3mcAeQISM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Tk9ock84VWxxa0pyZEFGR0Zjd2dJSUx0Mkkvb3hzSkZObEYxaFUybVJWeWJE?=
 =?utf-8?B?NjRYay83R25zZGFsb1RiUHowemlIZWFHRlZuZ3lkby9xaUg0cnVzcWdxSlNH?=
 =?utf-8?B?NnV6YUdDK3hTUlNINjhHVmJkSmRwR0R6RTdmeGF6b1AvTVNpWHBKNGZpYi9Y?=
 =?utf-8?B?WWRYQ0NNaHZ5YWhQN0FHWVRsVlFFRFVJYzhWTm5YY2dabDdvQm42SWxKUWpp?=
 =?utf-8?B?ZGFTZm92R1pkYXV1OWI0cjZqOEhKejM5UU0vU0hqSW56ZkhKVGRxcWV5Z1lt?=
 =?utf-8?B?YjczME80d1c5MXdmVnEvbHdoQTQ0U0RNLys0RzNhQURpYTM1TDBodW5HVm1W?=
 =?utf-8?B?WThWdzc3bzY5dWc0NTRYb0tLVUF3MEIrZ3RqSGNWTHpSSDJKZkFXcWV0aGVG?=
 =?utf-8?B?QjF5NVRVdVBPVXNhZVFjbkdTbEoxU3JKUmxyR3Jqak9IODREbElCL0ZGekpy?=
 =?utf-8?B?blZGUXU3M2luQkczczZxZlYzVEcyb0tBUldwQjFWRStQVzdyMVhtVSsxZ3U1?=
 =?utf-8?B?NmpRNStFc3BTS3FxTGxCNjlMTVpIblFOSXQyUVY5RXA2STZCRmN4RHpmdXBE?=
 =?utf-8?B?T2w4WVBBd1FOYVVsS0JLWldSU1Z1TlRWRVNJcUFkbVRvSTM2cnhWTTVORVVn?=
 =?utf-8?B?RDY1WEZKR3l6N3pkRmMzWUsxbVJkUWlWaHpDVG96OXkwS1VOQmxrV0xUTVlk?=
 =?utf-8?B?Zlhpa0IyVXljZ3dieVRwL0VFM1YzNFJ5cVFzRGMxNWhteHRBQW9seFdEcVMr?=
 =?utf-8?B?eW1PT2NDSkxmUWpnanB5aEZCWWhpeXE0WW1LUE41SmJLTjdSM29lbzFNaita?=
 =?utf-8?B?WE1aTUdWN3RVWFJoK0hNVGNSVithQnNIenYraDQ5ZlMxYXVhTExqbFNCM28r?=
 =?utf-8?B?OUhuUjJhMll5VWx0dTR1MUdXMTcwMEdQcnU3SytaaGRnTU9kcXJTZFFua01M?=
 =?utf-8?B?UUIrbUMvRUdzUkxIQnA0Vml4cGg3SVZXVnpFYzZuN2xia2lFZm90TDhjWUNi?=
 =?utf-8?B?SUdjWU1IUXlDM0xMbjRIN3B0RlFJdnZNRkFQNlZ0ejNSYlZFK2NMa1dEWG9K?=
 =?utf-8?B?MWZQZzk3Y243d1c1VlJ5ci9selpueFhRNXVyb2xtakh6S0k3cjVpejJHTzZq?=
 =?utf-8?B?bFg2MUZRNHlPYTJ3Vlo1K1R5Ty9Ja2VIRFNGUmxsTzZjMUc3a2Z6dmx4NEU0?=
 =?utf-8?B?TGIxeTBBNzJnZWhNREtvdHJKdmVSR1VWYWY3U0NpRUJYbDd6YU5NUjJmWlFL?=
 =?utf-8?B?N1RyQjR5ZVA0K0loWE1kempDS2ZPN0JwOGhIOTMxZE1iSnlxaHM0bVFnYW55?=
 =?utf-8?B?TDE4YXRicEgvazUwUlQxU1ZmT1B4bEdXaW95RCs1Mnh0Y2pya0RSdjFlYjlz?=
 =?utf-8?B?cHFid3pJdTYzMU9JdWlQMGU0OGJyaTkrY0NXQlpYUThoRW12dTZFMi9iSFh4?=
 =?utf-8?B?SFFGQWJnMEVmbFREUlpudmxpYno0Z2dQRjVaZ1QwYlN1WkU5enhOeDB4YWNr?=
 =?utf-8?B?ekJEZ0VhZlBmc2NqL1JSbitFbkFiSnJyaXBacmJLNHRoaEUzb3RlZlJMNmxw?=
 =?utf-8?B?VktMT1RTTXFsNDl3UFpqeDdNc1dqWS9HUjlHVDc5bnNGSEk3Mnd5NFRjTGxE?=
 =?utf-8?B?MHUvRE1nMGpGUkdSVWN0UnBaS0VxRkNvdmxSZ0kvUmlVSm82VkJWclBCOGNj?=
 =?utf-8?B?R3hKNkxTWjJmWjd5aUVmc0FBUWwzMm1WYysxbkNGWEhXKytnajJZMlU4anJJ?=
 =?utf-8?B?dHBMVHhOeWVGYnZpdTMyaXBUSmFtOVVwSWdmZnpncHBheHRZUjJWSVZ4R3dp?=
 =?utf-8?B?akxUZXl2TFVCK200M0d3ZkhCWnlrd3F0U203Y09HbnBOa1NiQXBCWGhaYTU3?=
 =?utf-8?B?K2JhWGpOMWpLNG5TUVJkL25mam5WZnMxenNVT1JraDYrKy8wUUFmUW14ajAr?=
 =?utf-8?B?eDVhZjhiWGFEREEzaTJhSnl3d1ZlSXNHN0VEQTZqcVdZVy80YWZaWFJuWlds?=
 =?utf-8?B?M0VuMEFxWVdEZHJDMnJ6TTg0blFITGs0YU9lTzZLdEpwVm5Sdm9YN0JuVzM5?=
 =?utf-8?B?V2gvc2VrMTEwWWF3NXNscDFnSzV5dTVrOGpjZHkyb0s5ODZaalh2Y3hydkpr?=
 =?utf-8?Q?ocDkrmp4H9hCuyMmiIpJOsdMf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WDJ/rR8NJwc34fSzlhk+U+mTNjaOIhlNQyqmzLu+jh6cU3bdd+4eoH9ySBMMwS7v2k0G9lXVjh1jOlOHoeZh33Gx9NHjuidzfSXILK++AclLP2ypLGZCu29mIyJRKABcT20AE4gBJzeHtSpJqBO2+V3uWRMVnIUypU1oKI7/JXeAjqxJoTgyxRZVH7crcP1b5HHzfzThbgB5G2PxL2lRF0sgB1qA1eu01H05e71clMU2tqorGkUHTmHnlgA7/XSqPXaBiLYcjhLORZvKb/NRJAlew9cA2mrEjwAdkpjSRH9estR/XBkmk9a6PVc2SdYtgj4Oit4cYw7HRyvExmtrAIhY489aDgdoQ0heFPN94Qy8GqMCNKkmlPC3Z0HgxyGaRs0guxLjDvHKJzMsOkhiWTUKKpktj31LwAssnwLF7YEG6ixeYO4XVcBvu7WvcqIf51kGofjrznFMeKzXPD8GpbAjunDQIu7kKBpDJZeMyjK4pz6cS6Gb73Q4g4i1lI+9YbXYPUcsw4uyRn0vWrU1EaSJI9ka7z94LZtJCwL0f/DjcKsWlYGa3EjU7n4NYBgGlSWguk0ImMvJZNH79Uf2zf0Rln6TU7iKZh+XSxG7oy8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637b0431-5634-436e-91de-08dc3491ce86
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 17:06:42.3779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZhP039ssYrNfz9WnXe1vETU1DDC41z+92INkGg4gfyvNXH9RTg3bSM/MpZS+Itkq7qIxj/ilbGOomsd7nKxew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402230124
X-Proofpoint-GUID: SmHRoGEwus6rm3xpC3T1eYQn3-YBFsQE
X-Proofpoint-ORIG-GUID: SmHRoGEwus6rm3xpC3T1eYQn3-YBFsQE

On 2/19/24 17:31, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that an incremental send does not issue unnecessary writes for a
> sparse file that got one new extent between its previous extent and the
> file's size.
> 
> This exercises a fix by the following patch:
> 
>    "btrfs: send: don't issue unnecessary zero writes for trailing hole"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

looks good
Reviewed-by: Anand Jain <anand.jain@oracle.com>

Queued for the upcoming pull request.

Thanks, Anand

> ---
>   tests/btrfs/303     | 92 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/303.out | 24 ++++++++++++
>   2 files changed, 116 insertions(+)
>   create mode 100755 tests/btrfs/303
>   create mode 100644 tests/btrfs/303.out
> 
> diff --git a/tests/btrfs/303 b/tests/btrfs/303
> new file mode 100755
> index 00000000..26bcfe41
> --- /dev/null
> +++ b/tests/btrfs/303
> @@ -0,0 +1,92 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 303
> +#
> +# Test that an incremental send does not issue unnecessary writes for a sparse
> +# file that got one new extent between its previous extent and the file's size.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick snapshot send fiemap
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +	rm -fr $send_files_dir
> +}
> +
> +. ./common/filter
> +. ./common/punch  # for _filter_fiemap
> +
> +_supported_fs btrfs
> +_require_test
> +_require_scratch
> +_require_xfs_io_command "fiemap"
> +
> +_fixed_by_kernel_commit XXXXXXXXXXXX \
> +	"btrfs: send: don't issue unnecessary zero writes for trailing hole"
> +
> +send_files_dir=$TEST_DIR/btrfs-test-$seq
> +
> +rm -fr $send_files_dir
> +mkdir $send_files_dir
> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +$XFS_IO_PROG -f -c "truncate 1G" $SCRATCH_MNT/foobar
> +
> +# Now create the base snapshot, which is going to be the parent snapshot for
> +# a later incremental send.
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
> +		 $SCRATCH_MNT/mysnap1 > /dev/null
> +
> +# Create send stream (full send) for the first snapshot.
> +$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap \
> +		 $SCRATCH_MNT/mysnap1 2>&1 1>/dev/null | _filter_scratch
> +
> +# Now write one extent at the beginning of the file and one somewhere in the
> +# middle, leaving a gap between the end of this second extent and the file's
> +# size.
> +$XFS_IO_PROG -c "pwrite -S 0xab -b 64K 0 64K" \
> +	     -c "pwrite -S 0xcd -b 64K 512M 64K" \
> +	     $SCRATCH_MNT/foobar | _filter_xfs_io
> +
> +# Now create a second snapshot which is going to be used for an incremental
> +# send operation.
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
> +		 $SCRATCH_MNT/mysnap2 > /dev/null
> +
> +# Create send stream (incremental send) for the second snapshot.
> +$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
> +		 $SCRATCH_MNT/mysnap2 2>&1 1>/dev/null | _filter_scratch
> +
> +# Now recreate the filesystem by receiving both send streams and verify we get
> +# the same content that the original filesystem had and file foobar has only two
> +# extents with a size of 64K each.
> +_scratch_unmount
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +$BTRFS_UTIL_PROG receive -f $send_files_dir/1.snap $SCRATCH_MNT > /dev/null
> +$BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT > /dev/null
> +
> +echo "File content in the new filesystem:"
> +_hexdump $SCRATCH_MNT/mysnap2/foobar
> +
> +echo "File fiemap in the new filesystem:"
> +# Should have:
> +#
> +# 64K extent at file range [0, 64K[
> +# hole at file range [64K, 512M[
> +# 64K extent at file range [512M, 512M + 64K[
> +# hole at file range [512M + 64K, 1G[
> +$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/mysnap2/foobar | _filter_fiemap
> +
> +# File should be using only 128K of data (two 64K extents).
> +echo "Space used by the file: $(du -h $SCRATCH_MNT/mysnap2/foobar | cut -f 1)"
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/303.out b/tests/btrfs/303.out
> new file mode 100644
> index 00000000..7659a794
> --- /dev/null
> +++ b/tests/btrfs/303.out
> @@ -0,0 +1,24 @@
> +QA output created by 303
> +At subvol SCRATCH_MNT/mysnap1
> +wrote 65536/65536 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 65536/65536 bytes at offset 536870912
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +At subvol SCRATCH_MNT/mysnap2
> +At subvol mysnap1
> +File content in the new filesystem:
> +000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab  >................<
> +*
> +010000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
> +*
> +20000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
> +*
> +20010000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
> +*
> +40000000
> +File fiemap in the new filesystem:
> +0: [0..127]: data
> +1: [128..1048575]: hole
> +2: [1048576..1048703]: data
> +3: [1048704..2097151]: hole
> +Space used by the file: 128K


