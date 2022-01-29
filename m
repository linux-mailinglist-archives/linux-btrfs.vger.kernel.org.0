Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C29C4A3086
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Jan 2022 17:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352455AbiA2QYu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Jan 2022 11:24:50 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:32574 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352436AbiA2QYr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Jan 2022 11:24:47 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20TBGHCn026853;
        Sat, 29 Jan 2022 16:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7MZuSmqjW4jD3dfE3cSX/dLdiTaVcaO+zLN/+wYhzuM=;
 b=mrb5x+8FSPc7JjVsBulXvFqnRoc6fIKarJtcNslxGWbh4lcT+1k4telwrmwfFNcgU2S1
 axel5fpC6mQpuLDfA2rEc0VGYzRosGDwrEgED7vWMAjsABMIPb2GXiNVIgqdCAuGViU5
 kz/bSnUfqXNjA64CCYrnBbsRRI7WZ6Ru0KJmdac62SGfV3yyOZu+fWe3+A7ToJ/7a1IS
 UWhY7e1Bv1y6OwPp7d8hgldG/J944lFeOPW0bxeoQD74tYKzwIalOt3VN2ihH+HqQnPU
 Li+295qb8Ypmc4dA6ec66A/IJPtD2aOGTzoJ49NS/3MCJ1dY54ykTiBvNXN84tjtEq0M /w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dvvc2rwb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jan 2022 16:24:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20TGBEFm055348;
        Sat, 29 Jan 2022 16:24:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3030.oracle.com with ESMTP id 3dvtptqdys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jan 2022 16:24:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctEYjSK56Cm9YQi3/rf/tx8cypM+63XEcfqUU82fHW3uz+TyxKLAohIxGSAid1DN0GYLWBd/viWsFtrD/rWiFMCaROsapNC8BMd4rES70pTuwJyRNkZY9UcagiWqmLduc/1O9SywPdoy+Q7WshwS9PNJUYSFlXKYPi1Okiq4L214rZf9Q2ddi+UsliADvmIoPyom0mpRKGzMSts5npeDh3ijTVdyScOC00CthSLIyd8Xdus4So/JJSoTW7+BZ67rg2XJjjfd1BWSz7g32Yzo5tNya5yp5yMiaXVYP0MiQI043etc03vS42gyrJJTH6Z7hNWtC6g7c7dtcTycv47jYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MZuSmqjW4jD3dfE3cSX/dLdiTaVcaO+zLN/+wYhzuM=;
 b=Yn24pK16tANg05Y28WiVoeCv8POb9pAzAZKiCru384QROj37f8XaeYHe87iFUYUVT0gcvmaXkfvT6D4CHmAC9x+NNTnLEPrTenY0e9reBJbpuZ0uYxnaa0E/VmTLShND1wKg8mKk+wR+WGE8aOaYVBbYwFuWcV0JRN+8Di0jtVbd8vM6295z8xf1sAiOfydxDquAYqlhZdM4dxxtKv4plDJPgWrU8qgqtvDHbUHhkjBGlHR0YO7fTWOnSfXUXi+MsOa6VO9F4EaXBlPY/rhqZqYzXQFpBDoUhayHmYU10OmKZa3JXgycXary+XVjFFVBdPZb13O3+lf9vJ9+V+x2Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MZuSmqjW4jD3dfE3cSX/dLdiTaVcaO+zLN/+wYhzuM=;
 b=Piwd/6s3GPacnYIbyS8iqU880/CxGgKS4w5zyFinwly69a5+MwuXPLtQASRWkcZ7yq/MwF6YY+IMSNgSfx3ClF5u8aKyqdJGdBVQjAOAscUUeuce0ekZo0960jFj2f4LGb8Gq4KFPSxfD0idt5VLnpRnx2S+dU2w6/d5b8f+14Y=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MWHPR10MB2031.namprd10.prod.outlook.com (2603:10b6:300:10a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Sat, 29 Jan
 2022 16:24:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fd17:db7:2d3b:6ec6]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fd17:db7:2d3b:6ec6%7]) with mapi id 15.20.4930.018; Sat, 29 Jan 2022
 16:24:42 +0000
Message-ID: <87d61359-ad1a-089d-b78c-63c038e5e26d@oracle.com>
Date:   Sun, 30 Jan 2022 00:24:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH 2/2] btrfs: create chunk device type aware
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <cover.1642518245.git.anand.jain@oracle.com>
 <4ac12d6661470b18e1145f98c355bc1a93ebf214.1642518245.git.anand.jain@oracle.com>
 <20220126170136.GD14046@twin.jikos.cz>
Content-Language: en-US
In-Reply-To: <20220126170136.GD14046@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0113.apcprd02.prod.outlook.com
 (2603:1096:4:92::29) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70aa2412-eae0-4636-ea52-08d9e343da77
X-MS-TrafficTypeDiagnostic: MWHPR10MB2031:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB20310E48F8676714EE4E2172E5239@MWHPR10MB2031.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cseIe31SyKsbMadQgIvHSANP73BX/KZfRnK8Q8CnGEmq6siY3E94XLpwAUS3HhCTwxw9XVqUjig69NikMjOWFyGdsHcRsU6Pk96uFxbJLiUi2dMDvYOTmiRfi2rK9xu1vvKffszrFarN7Dp5MIkXEw8I1OvqgKtF3l+A2Nh1yCASbIC97nQ5uhcul/VJWMYHpkX1DZ1BsLyuyr79U2EzJsj8+HRSwrLS/Sgip4B1zTcEAPUBZa/nFap+kIIsb/nU+WF0d6bmba65uG0VQzJa19m5x1I8B0M46chcjP8j5PaP41rwWxCTqapjwYkOOw182e8ZKsJDTXchzQue12cUWXfiRV+ZllY6LPksN2CrVWcVTQfgYgMBjvckhe+Uab8dWZboPhmrUqdKmhtvhRJS84MuoW/u9f8WlsPcLvKRhFE2+yasIXL4ilEulRHV3U6jaGpInhNzLPQuPgySJqIiLKumuKbnpUoxXzDD/qm4jKaNyZQXFaecaWzdAzR+MMvCZv+wH9pZz7FtLYfaB5Fb+Kcrm+22WNyCDGuNu41VQNXozyZ/PJe0C8hgmz2SbZ4Jk54KBmJIjjpPJPSOT+bn46OCwTyL5+kL4tp9Yrq9LOuG8w27mO03XaT4NeCawzdl78xYZljNIpOU3j+8NZAm8BU4r8SfkQPfTqb6Uvoc01y9gqXPqEl3mUezCNJaASMlnE+NQg5GCOWaC4+jk6vKUiWhg1eqy3WD+f1s8LRGw1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66946007)(5660300002)(66476007)(31696002)(8676002)(44832011)(2906002)(8936002)(316002)(38100700002)(36756003)(26005)(6512007)(186003)(86362001)(508600001)(2616005)(31686004)(53546011)(6666004)(83380400001)(6506007)(6486002)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3ZIcXRBcVB3dHRaRUkrQjk5dFNWdjc2WUZ6WkNoNFBQZnhhc0pmSWoxYlRz?=
 =?utf-8?B?ZW1hZDZqcDhMNGoybTV3emo4MnRlRGlkUlpwY2dmaStwN2lCNVdGN0RrcFRB?=
 =?utf-8?B?RXZGWWY5cHUxamZZc29GYVRrVkJtYTdGV2wwS1B1R2tEZjErOU1VNUcrWGc5?=
 =?utf-8?B?U2FLUVRiQTBocGxVRGJmSWh6anEvZlhqTTAxbEd0NmZ4cmlVdGd2STkzaDFt?=
 =?utf-8?B?OTV5RnZJcGx1TkxsWDlDT2ZJbHArVG5GVzNtRTZBd0gvNFhTYkd1VDM1Zi91?=
 =?utf-8?B?Mjhrb2t6OGNYWWM1WFBiSXNvZDQvK08rS3Z0TGI1R2JiMkZpNW1SWnlqakJt?=
 =?utf-8?B?ckl4NGZ4SVB0eWJadHBxQ0dQZzBGa1FpWk9ZRTM3b2tybmlBNmNxNUsyaEd2?=
 =?utf-8?B?eHlJOU5xNTlMMWsyK0xrMFUvc0xWdlpXeFkxSTZvamJDV0ozWnJpWkFuWTJE?=
 =?utf-8?B?VlFuVnFSNTJWQUhjRFlydVFSUjcxVWNNSCtkNVdCa2pwQkRvdzY2VnY2dTcy?=
 =?utf-8?B?U0RiY0dHZFZjYWhsRUlsQ0dyaGRSaHc2THdEUU51Zm1aVlhkU254bVN2cGFN?=
 =?utf-8?B?VlhJTmE3M2dJQ2o4cFRuQlZLZDVFNUJmaUJMMmFNdFZ5N1o1ZmtDdnlLY3Jr?=
 =?utf-8?B?VUlSWjU3RWsxc2o1WEw4NmVQa1dtNkVja3owamE3QnVvMjU3WTM2YmNGbjRI?=
 =?utf-8?B?R1VkNjlwQlZIdjJmQ3NjMEwxRHFpcmtJUllKVXJ6eExUSUNLWXVTaXhuMzNo?=
 =?utf-8?B?enRmS2txeWc2bDl2a3Y2Rk92RG5VN0tFZHdTODB1Q0thQ2pYRmZ2NUozdFZE?=
 =?utf-8?B?ZWpkSDJucXRJR1dtVGNWUW43bXkrRDE4SG1nYW96OGhOejBNNGE1eEo1cHBu?=
 =?utf-8?B?aGQ1cDc5bklJTmI1dGlaNERPMEtaUGdWODhzbkdZVzBNemdMQ1d1OVlCNnVs?=
 =?utf-8?B?dUlLSHJFaDgxM0tlYlRSUjdJMDFVYndlSXBkKy82UWNtOCthZjdkWHRSb3dq?=
 =?utf-8?B?a2tzZjdDRjV4eUZwUHR0aWx4em5IdnBkVnhGVzVPNXpJRnlja09OZmtzeFUy?=
 =?utf-8?B?dnh5UG8waWhvNUcrUlhydWQ2MGdrZnpuOGJaZlZJcitoU09aM1VZTFZIUEU0?=
 =?utf-8?B?UVJFSTZGbUVadWErNkhPczRlcEcweStIcWEvZHoybWRCT1dUSmhuSUlPOHRX?=
 =?utf-8?B?N3Z5bEpQbFhGSEUxbGFuemNJQ0hFOTZ1ZHVkajgrK3JUWXBpSmdBZjFhbEYw?=
 =?utf-8?B?U0lqTjFDOEtCODBrTW8rT3lYRkZXTVpmc0NpYlV4NWd0WW5lalZpTTk5Wldy?=
 =?utf-8?B?NWVoSmJOeExkWmFUdmthMjg4Q25vc2Jqd0tpMllnVEpiWW14RFQ4K29CQVAx?=
 =?utf-8?B?ZjJaTmVpK0x3ZVJLUURwR1dSbjBGa2xWNWsweDVQekRtYmtTWlNYNzBTNVBv?=
 =?utf-8?B?UnBiVUdXME55MTVWWk1ybXRyTWJoS05aNkZPRWt2cW4vOUtVNnFUU0FSeDRa?=
 =?utf-8?B?K2h1dDVCY2JKUGFYT3dTNkx5YnFGWHFDUTlkT05LcnB1ZWMxNCtuL2JqdnpP?=
 =?utf-8?B?bE01bCsvcVIwcFhLeDRiN09KM3NtZlNMNkFLKzdiS3psOE1BMFpHR2k1SlZX?=
 =?utf-8?B?b21ETHR6a1RwMDhiZ2x0NXl3Uk83VUFaYWp6S0NpQTBUY3poVFFZcEdvM1VY?=
 =?utf-8?B?dWFsSk9IRDFnSDdWVVhtd2hZb1dlM2MvT21VUGEzQ3J2U3hBZVVtK1p5OWMx?=
 =?utf-8?B?WHgxL0R0d2lGU0ExbHFraENwS28yaEdEVEtHT1NiSXdaSUpNR0JHQll6UU5J?=
 =?utf-8?B?Z3RqZlZWZForZ1d5b1UzRXNndGoxbXVMMWVtNVhXYzVkL0ZCOWRGRjAzcldq?=
 =?utf-8?B?cTRMYWh0QXFncUVSTlRMZ0JyMW9PTlBvL2RFT3liVUtrblQrNGY4ZkRCcStv?=
 =?utf-8?B?bVV5OXlxekszSFJjdkM4VTNobGVxU2JUZlFFeFA2cmN6cU4zM0duV0FXVUhz?=
 =?utf-8?B?dzV2RXhONHJORUNGZ3dFL3FDOTBibnJGYTNXMzNLak5pZ2NIMWZXMFJaZXZm?=
 =?utf-8?B?Q0pCUTEyeG92c0VzbnNVRmRaZytBYy9oTjFpejZ4WCsyQ0hLOXhHZVZ0andG?=
 =?utf-8?B?YVdXM25QNVhEQU9IY0tjbk9YcDlXNnltZUV1bWprNmo3VmtJV2NCd3lHM0Qz?=
 =?utf-8?Q?i/RXZM1rSSir9AxJwDNg97A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70aa2412-eae0-4636-ea52-08d9e343da77
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2022 16:24:42.0209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbjRCmxF6UJs+t5/N0E2liS6VWCUQXpkxkB6fZC2urIo/VzTCQJWk4PjUgWF63r7p7KjUm+FxF86JqW5DD4+vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB2031
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10242 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201290105
X-Proofpoint-GUID: xViF-yBmCcsJ5Eu-93ixhHBi7_gnrmGX
X-Proofpoint-ORIG-GUID: xViF-yBmCcsJ5Eu-93ixhHBi7_gnrmGX
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 27/01/2022 01:01, David Sterba wrote:
> On Tue, Jan 18, 2022 at 11:18:02PM +0800, Anand Jain wrote:
>> Mixed device types configuration exist. Most commonly, HDD mixed with
>> SSD/NVME device types. This use case prefers that the data chunk
>> allocates on HDD and the metadata chunk allocates on the SSD/NVME.
>>
>> As of now, in the function gather_device_info() called from
>> btrfs_create_chunk(), we sort the devices based on unallocated space
>> only.
>>
>> After this patch, this function will check for mixed device types. And
>> will sort the devices based on enum btrfs_device_types. That is, sort if
>> the allocation type is metadata and reverse-sort if the allocation type
>> is data.
>>
>> The advantage of this method is that data/metadata allocation distribution
>> based on the device type happens automatically without any manual
>> configuration.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/volumes.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 45 insertions(+)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index da3d6d0f5bc3..77fba78555d7 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -5060,6 +5060,37 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
>>   	return 0;
>>   }
>>   
>> +/*
>> + * Sort the devices in its ascending order of latency value.
>> + */
>> +static int btrfs_cmp_device_latency(const void *a, const void *b)
>> +{
>> +	const struct btrfs_device_info *di_a = a;
>> +	const struct btrfs_device_info *di_b = b;
>> +	struct btrfs_device *dev_a = di_a->dev;
>> +	struct btrfs_device *dev_b = di_b->dev;
>> +
>> +	if (dev_a->dev_type > dev_b->dev_type)
> 
> It's strange to see dev_type being compared while the function compares
> the latency. As pointed in the first patch, this could simply refer to a
> array of device types sorted by latency.
> 
  Agreed. This will change.

>> +		return 1;
>> +	if (dev_a->dev_type < dev_b->dev_type)
>> +		return -1;
>> +	return 0;
>> +}
>> +
>> +static int btrfs_cmp_device_rev_latency(const void *a, const void *b)
> 
> Regarding the naming, I think we've been using _desc (descending) as
> suffix for the reverse sort functions, while ascending is the default.
> 

  Ok. Noted.

>> +{
>> +	const struct btrfs_device_info *di_a = a;
>> +	const struct btrfs_device_info *di_b = b;
>> +	struct btrfs_device *dev_a = di_a->dev;
>> +	struct btrfs_device *dev_b = di_b->dev;
>> +
>> +	if (dev_a->dev_type > dev_b->dev_type)
>> +		return -1;
>> +	if (dev_a->dev_type < dev_b->dev_type)
>> +		return 1;
>> +	return 0;
> 
> To avoid code duplication this could be
> 
> 	return -btrfs_cmp_device_latency(a, b);

  Oh right. I will do that.

Thanks, Anand


>> +}
>> +
>>   /*
>>    * sort the devices in descending order by max_avail, total_avail
>>    */
>> @@ -5292,6 +5323,20 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>>   	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>>   	     btrfs_cmp_device_info, NULL);
>>   
>> +	/*
>> +	 * Sort devices by their latency. Ascending order of latency for
>> +	 * metadata and descending order of latency for the data chunks for
>> +	 * mixed device types.
>> +	 */
>> +	if (fs_devices->mixed_dev_types) {
>> +		if (ctl->type & BTRFS_BLOCK_GROUP_DATA)
>> +			sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>> +			     btrfs_cmp_device_rev_latency, NULL);
>> +		else
>> +			sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>> +			     btrfs_cmp_device_latency, NULL);
>> +	}
>> +
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.33.1
