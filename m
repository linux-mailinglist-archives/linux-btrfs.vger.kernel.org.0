Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2575843676A
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 18:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbhJUQSk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 12:18:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55448 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230441AbhJUQSj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 12:18:39 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LFIPkP017614;
        Thu, 21 Oct 2021 16:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PYbS791lb4JcIChZOKIF6xGkHSbjuzoC0sY15ZPzotc=;
 b=oGeEw1xCq4jS+815cWfWEkkhL44Wh2672ALdO88MVBgVm8UapWj4RjwoJOWasAbSGxfu
 fPGPqO4VXEr4TOy44zKdnZ6msVLLYSanhpzQ8TkZfapQ3U7slNX/V4HcCHXY6JoeZ/b6
 IXb3g4OEmxcTDmLJ5fYmXcFIahdMfZggBedUjw95pr6+vHy2tehut+AtGnBTBr6isNhZ
 arMa5x04326T1KZ6kqYh3nxE30IwN+wqtMzOlN2tsFHmBU08/QcpcSu/nGvSnwyiBj5H
 2ANqD1rzgDurlcHwi4qC6WwXjdZpz88Obxdx7M3M0/hqWnCSDzBY8h8e85DRUjulCvOJ VQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkwj7693-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 16:16:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19LG0vMn119993;
        Thu, 21 Oct 2021 16:16:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by aserp3030.oracle.com with ESMTP id 3bqmsjeb50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 16:16:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jad8yib6HHk2b9wBEfT2JLbI2H6AmMQ660IYyvUhIPRxliI0Q6VL3JV0M7vnszG4IrozyoOCtya+SRHjCStZST9Tw233EpBGWzqybGvU7ei6plWjcJJoXl/dm2/nGUNmWqHvrGluFhFChaaYUsFWw59cWuS8D3vISR0O/k4aR/WWiH0l61A/DiXGQO2LlnmOMtDL2a0CQG1LVAvYBbDvBxYHHiGoi73mdHb1p8rBB9u6dX1CYSfkN789TGmhcw0TpTDn7d9LxZq8PeCj0fPDDEz3Es1gD9b3lzW85Qzr1rQuyUJ1WPTQqT2D8MRYfVjxCkLFJc3hfInwnVDENa0ZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYbS791lb4JcIChZOKIF6xGkHSbjuzoC0sY15ZPzotc=;
 b=JDMCc5J2I/KvhEt22WdJk2RF1kkCZJqi7cIWAqHPKj/1nnTdU0JCANU0PNuG4zyFPtVb6eRPCpx/qskCAf8UY+glUltaNn1oNeQq/57R6UF/19+Nrzo9XB5mdwtX22annWKhgDf0OWkaSQhS0WdHbmuAXcGbjDf1zSPnLu+eJ6+/mjLDIH/F/XlYq1I/aqyTCHMJLlNWfj5HUwFkQetjGW1nhpSl2uDkcR0LLixnmrJVFP/JE6aTU5ZVQ+rLrCUlByehgs3mkWvnjQFHm3X7XWF+r8NzggsphgeAeJjjK7BgB86oKSOyWy+lpjkBEBxJY/uFdWyEe9xf6oCcYjeAeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYbS791lb4JcIChZOKIF6xGkHSbjuzoC0sY15ZPzotc=;
 b=vS4EPr+QPyxhW0blMFfu9GQyuoFmdgW5tS+Fcv+M3aVFa8vqixdWyV+gxacmOiTXfiSg+tGkDT8BwpLdAuk8P2m1YCwVYJIDWddOwgfXKHZXRmwMHsIj8uCeY64mztx4TUcg4ZNAKJvYGMPxp00NPfuSPnb819ABIr5pz01AxJA=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4285.namprd10.prod.outlook.com (2603:10b6:208:198::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 16:16:04 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 16:16:04 +0000
Message-ID: <0c876cac-8ee2-039e-c45a-584cf1d7963b@oracle.com>
Date:   Fri, 22 Oct 2021 00:15:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] btrfs: sysfs convert scnprintf and snprintf to use
 sysfs_emit
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <cover.1634598572.git.anand.jain@oracle.com>
 <f748bd08259e2b770a5d9f2355c58c33d8566d16.1634598572.git.anand.jain@oracle.com>
 <20211021160008.GC20319@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20211021160008.GC20319@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SI2PR02CA0040.apcprd02.prod.outlook.com (2603:1096:4:196::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Thu, 21 Oct 2021 16:16:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9dbbbf5-1f9b-4a2e-fd7c-08d994ae1494
X-MS-TrafficTypeDiagnostic: MN2PR10MB4285:
X-Microsoft-Antispam-PRVS: <MN2PR10MB42850029008E796524F2FC54E5BF9@MN2PR10MB4285.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:248;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ny2NpARg1bTSiwudw5A201bYSe+NrVRlDZtvVl1XSe1d7U/eS4diKvbXkLW2owHuw+cFVSPsiA1pbIsYl//wgUZPuZvkXtNzYsQUmGTPBh/SuA1bembbXkGI4LnSaF4GO37mMn88INqdWBnt9eCDJNNZrjhYPWucOSemUP/r2psWquj+q/g1eWF5d4asH7krpe5/I2+IPVwTOyyEDNaeVeZXx1BWCWuco4bJGGOEBqZzCqwnLVP19GDU+AtoMK1aj7pbDT0Dli6U/Ij8xsxunYwL/WW/UfTB5R5s5L8y8f/cyd+v+4a+Cz2up6ykhOvAXeKfv+H3UM7ogCyniNEW45X5O2VRcDEUKYTEVJvjymtK++p9nySObG9JYjuRM1qOzdCVhwbyGOcof/tbFouQUhX+W34CL3iz7yK0xmUinC390zAiR1f5JcKbvlgbhUI8Zg20f5xANWrBxPw+DObGUiGg7xHb8iE3ujnVfGzl8Xjz6gyu5k7wnEkxVFzGbY8dBbozquN7MYDuJxl+Yso7Z4Z4NxbxYlLSUetdtkl5IIKc3zg0o4CxY1wWhG+AXpPUK/JqLykXPcHn7AhWvipmiByEPYlqjQimpCB+4tt1aju98TeCIshrT3dcwAUd8mTBfpIVRENxXO046h+yd6jHJLNPiKnJiyYBiZqc4Z87E1tVWbQhHwAWmkKGzJt1HZX319aibmxaFjne1Fcu3xBBx/HzZAWETRTELD7WJ6b3ZOI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(66946007)(5660300002)(316002)(66556008)(6666004)(66476007)(36756003)(2616005)(8676002)(44832011)(38100700002)(86362001)(16576012)(53546011)(2906002)(8936002)(26005)(956004)(6486002)(31696002)(508600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnVTMzc4RnR3TzVjcXJGS3F0OFpWeW04dlpQdWZ3TDJHK3lvWGdSNnJndy9F?=
 =?utf-8?B?MUdERmJFb0MxTFI4SXBJWXhQTHFDREVwL1ZmNEJjV0NUYzg3ckhWNzBEYXJ1?=
 =?utf-8?B?eldKTU1jbkMzbUVBVXlZQldZZXZ3Vk1FdnlFbWFCZDdvMjdaV0dMYjJUVmFD?=
 =?utf-8?B?RGx5Z091dlJzakw0dEEvODdvRnpPZUhrUFNZSmFlZC94K2RPc0NSYTRmRTZJ?=
 =?utf-8?B?dUh2Nkplb054bmFla1M1R3NId0xrejY1SjlwY0M0UTdFNyszQzVxZHZOZEg2?=
 =?utf-8?B?Tk4zSlRKcURFZTkrc3hyam5xMWgvSzhiZTkwVWVuT0FJNkxZeWp0VDRWSXVH?=
 =?utf-8?B?SjgvN2N5SXNSSGJoSVFRZUtleVFFaXpsTFVvdW91bURudjNVSGJydFdQZCs3?=
 =?utf-8?B?NEVYdWhGbFpmaVJrSU9wZEZLMzU5T2FpZXZITUhPVkhnM2FmbEFuSjZ3ZUlO?=
 =?utf-8?B?Y3hDUFhwbkdFNTlzMlYvOXBKUk1vdlJjSkxZaGl1bXJ4OEdvbkkzUEtHTi80?=
 =?utf-8?B?akpSYjM5U3hWNlEyWXBZSlNzYjdPTzFVS1R3ZlpYMkpuNlN2OC9RaFg3NEJP?=
 =?utf-8?B?S1pjSnVtaHBBbUM2bmhZOXR0VElLenZCNWpoSktONUxiMGNGVjJLZzA4ZXRQ?=
 =?utf-8?B?Nm5oQ1FuelhNMXVBaGIxZzYyOEw0eU16MTNWb1ZEV2dEbnl6ZFpJTUNjRmhM?=
 =?utf-8?B?TjVSUllvQm1aMHI4MHI5bTFMNitDWFMxV2NJdG1IYVRIcXl5bXVSOGdxQnJ5?=
 =?utf-8?B?c0tkQjArN1FMNndKL3haeUpldm5lYURubk9WcXRjdTJJQkdPdHdhaE5NUGZo?=
 =?utf-8?B?elJQdlV4UTkrSVNRTyt5a1ZGUWExRmFROVl6WFhyVTQxeGoyTXJOZHl5TjR6?=
 =?utf-8?B?b1Rqd0VBdWl2a0J1ZXp5SXl4eWtYbFZVQm1FZlIvWjZYT1RGdUJQYnE1eEd3?=
 =?utf-8?B?WEhXVThaSXM3VWtXU1VoZEF6c0ZYOUJQQThBWXpyc0ZwMzhtek1oQW5LaFNR?=
 =?utf-8?B?dkZkcHpTbDdkMDZRNUFObmlPK3ptZ2xHNmgyOWltVWZmMVpjY1BiMzM0Vkpq?=
 =?utf-8?B?YmwxMGQyYzUzNzBQd1o4MGtGemxDZzgyamdrMUpoMWFpVGlieXlYZ0VxazNV?=
 =?utf-8?B?aDFJTVU2cWRnQVZaZm1QUWpReTl2OVEwV3hxQUpUQy9CZFQwS3VwK1JvaEc4?=
 =?utf-8?B?WHF4N2J2YlFrRkNQeHNuNWlZYUQ1eHd1Y25Lc0hIY0FabmtOSlB4aGRabkNq?=
 =?utf-8?B?TU12V3IvNzBPUDFzcVpkZjVGQUNWQm91bHcxLzAvK05tdTE3MGpodjFmL3pV?=
 =?utf-8?B?T2V5VTZwcnlWejJHVFFaeW1aVWgyZHRvYS92S0VUYTNtOXdPS1I0MkxnOW80?=
 =?utf-8?B?bXlud2JGQWhwNjNUdjFRV0U3ejgyS1BKeXYzRGdpdjhqMzE3Y3IyWmhyaHRo?=
 =?utf-8?B?djBiTEVZOTZBV2VFRDl6ZnJFY2FISHN3ZVJOanFaMktUOGJManhROFE5YzlW?=
 =?utf-8?B?V3Zscm9EQ3ZkR1dMRlRyV3cxbkdZZHZwK2VaSmhFUzE3S25ZTkpYTE1wZENV?=
 =?utf-8?B?SzB4T2FmVFQyVVd6NWw0Zk50cFQyaTdkdU1JQ2pJS24rZHlGeHpyaTFGRTUw?=
 =?utf-8?B?NVNxWmpWREtRZnJRajhoS1RZc2RocUtGWXBMYW5Ba1ZjOTRIUWQ2SWR2Z0s1?=
 =?utf-8?B?azJYOS94a2ZjVXgwRTVCdVlOdkRzcXJSakFDbklteXcyUStpTzdtdmIzWG5l?=
 =?utf-8?B?aVJudWJ4RjRZQkVkcDN1VmtubFVpT3NpS3RnMFY1YWI1eXh2a2FyQU1wQkRv?=
 =?utf-8?B?cGJYaWl5ZFBnWmw2VzZBeUlCK3c4b2djRnpPVEJDWnFxc1lxQ05MRktWSm1a?=
 =?utf-8?B?OUJ3RVErY2dhWUR2WjBWVzd3ZDV4aUZEQUoxR05Ba3VjaWtqanRGNndLeG4x?=
 =?utf-8?Q?RHfnD+7c0eNuDUA0pj1/K9aIHJfl/9ah?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9dbbbf5-1f9b-4a2e-fd7c-08d994ae1494
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 16:16:04.5292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anand.jain@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4285
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10144 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210082
X-Proofpoint-ORIG-GUID: XnQIQ75-IjqIVrZ58Vo3aYasnF5indb_
X-Proofpoint-GUID: XnQIQ75-IjqIVrZ58Vo3aYasnF5indb_
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22/10/2021 00:00, David Sterba wrote:
> On Tue, Oct 19, 2021 at 08:22:09AM +0800, Anand Jain wrote:
>> @@ -1264,8 +1262,7 @@ char *btrfs_printable_features(enum btrfs_feature_set set, u64 flags)
>>   			continue;
>>   
>>   		name = btrfs_feature_attrs[set][i].kobj_attr.attr.name;
>> -		len += scnprintf(str + len, bufsize - len, "%s%s",
>> -				len ? "," : "", name);
>> +		len += sysfs_emit_at(str, len, "%s%s", len ? "," : "", name);
> 
> This is a different pattern the 'bufsize' is 4096 which matches
> PAGE_SIZE but it's not the same thing as the show/set callbacks.
> 
>>   	}
>>   
>>   	return str;
>> @@ -1304,8 +1301,8 @@ static void init_feature_attrs(void)
>>   			if (fa->kobj_attr.attr.name)
>>   				continue;
>>   
>> -			snprintf(name, BTRFS_FEATURE_NAME_MAX, "%s:%u",
>> -				 btrfs_feature_set_names[set], i);
>> +			sysfs_emit(name, "%s:%u", btrfs_feature_set_names[set],
>> +				   i);
> 
> And this one too, what's worse is that BTRFS_FEATURE_NAME_MAX is 13 but
> sysfs_emit assumes PAGE_SIZE.
> 
> The rest is OK, so I'd drop the two changes.
> 


V2 has already dropped the above two calls.

Thanks, Anand

