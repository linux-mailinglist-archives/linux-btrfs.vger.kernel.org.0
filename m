Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD113EFCBD
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 08:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238207AbhHRG32 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 02:29:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:17414 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237947AbhHRG31 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 02:29:27 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17I6QesY010293;
        Wed, 18 Aug 2021 06:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yplLN8gDd0Iuwigx5X8CjqReeCbtK0s0GAE1BlSzT7g=;
 b=AquQSE2AYZWlLKYrgg94F4vv1hUOUEZdD8MEisakupcRYoJgD51KWXZ+ovAbKQf/W1xA
 ZarHq32iuKKBlLZ3E/kK64PAEbcugCIbnnnHEUXRe7dLcm6/rqebYd96TtjGXKZEYF3k
 RThzd9XcPD0zpIQZ95k9pwlFzMOA+O/Mt5OK3tagO5YVzxKVg0VB+3MpboQ3Wkhp1ErD
 x+QcCENVdm+QMMykp3sk0gWptPz13L97NSCnc9tL8P3l7VaIyqPqhd5ecYQzbXfYD0Rx
 x19GwF+JzvImgTOz0nKOv3Ja3+DdNgmoUSTDJ8LliZU1Z2FfK0zdsMiSqRBB2Y4Sq7qN 8A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=yplLN8gDd0Iuwigx5X8CjqReeCbtK0s0GAE1BlSzT7g=;
 b=BtRJXLJWgaW7myeH4BMUut0pAy5gKn4TfYgry8v6np7J1+cyp1Yw3x47K9y2hYXQJmya
 7irXaLUQZKeXzPMLdr8FUttX4DKaaP8wsx+mI2ySO2LwIyZ/1+HEq0yfGgITFcOsB/ad
 lthXtx5cS9yD5w0tU6V6sDeIl11j8+2v4mRgOFLIQW4R3d8+VaCsjVJZT+hccHr0tszn
 vUgRTQKwYV6jh2l+OMj+0XHOaG/iJMVkIN3H3O1zPiR9yqJU6icZ12I7EYtYEoPopKB6
 B6k+yJdo35F/FUF2eEkgtA9jX471VJ8nGPo/POH7PLR6iaN4TuEYsj7UL4DlUjtxkAlB nA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgpgnqb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 06:28:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17I6P3HV050948;
        Wed, 18 Aug 2021 06:28:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3020.oracle.com with ESMTP id 3aeqkvmbpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 06:28:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xn39CSlzRdDv9+PxJsHb8w9clYe7mExdyiaLoRXDvWDZmO7H/IKhV65wqPKz6qr07uKuirRDcJu4bqqe9p0+y6NRL7zzU+QwvaD+y4xDZ+TMvGIZLY8UtFquA+bQ3di+YbsC4aSEmENcQ2i7EEGJVMZ1tULrSRtJSfVqTRwYEHHPsfKqCV6lk4z8yDgpLF8YYQmdOnfx5XhWZdC7OfcIft+DJ+vwj/1fVhfeJsFABPkncXAMM0q5s5AWbHlEI+6//JcbfJ3yLkD51jCs5zcL82/KbLUBwqavuG5guM2NyQ8RkUR5YcpsJPNmhyMywrLbPrXiGoXZNVGmKNCyGnxezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yplLN8gDd0Iuwigx5X8CjqReeCbtK0s0GAE1BlSzT7g=;
 b=g9zrreN1TDqrzSoKANqsMOGKZ0BEpra79TwsVyoBa8FII+qZ51tIJosEH6dC+d/x6ZSwQ6fO4H/ksjoDfpoR47z2D0doILHDsS6ONOi+UjwLB+f0rCsqizInOm/4O4uBokzb7VZ261jsbDSwXnFWYxgJSgsQxsa6dbd+qo0YuK++CBHR6zm92ttR7D5jhxzWNz2nyXz4KBHA7N/DwD2K0ZUAZ9C8efQsc1c6Ka8MYkZb5/SfxKSOG1H6OSdD1A4s6NJKlVL6ue80P4a0xn7XFnbE1mJeYJkwBkWtjRP3gfFGIWFJOcTpXpGQle4zkmCgmV5GATpaw662Il56PHP8og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yplLN8gDd0Iuwigx5X8CjqReeCbtK0s0GAE1BlSzT7g=;
 b=kg5asVt4DmS3+WJz4d/lFu1o64vDHmLKwYdrm+GfmaaDXiy4ulu+sjgAv/5EZ0D6I99QNsoeGEOawAuPrhzLJzxeLqJdn7c1BWKfHLddQhR0i5dF9mp2iZjUXpTLx9mlsEGY9AyjylCuvbTDb8YiQLS4PYEvKFDqTNMhV3E95zU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3965.namprd10.prod.outlook.com (2603:10b6:208:1b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Wed, 18 Aug
 2021 06:28:48 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Wed, 18 Aug 2021
 06:28:48 +0000
Subject: Re: [PATCH] btrfs: update comment for fs_devices::seed_list in
 btrfs_rm_device
From:   Anand Jain <anand.jain@oracle.com>
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
References: <20210818041548.5692-1-l@damenly.su>
 <ce1a0cc1-b616-36e3-8c58-4edde5f924cf@oracle.com>
 <a8f575fc-2741-6379-5b89-62353a54cc8f@oracle.com>
Message-ID: <6e187852-f3a9-02a5-1eb9-d01b4ef8bc35@oracle.com>
Date:   Wed, 18 Aug 2021 14:28:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <a8f575fc-2741-6379-5b89-62353a54cc8f@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0177.apcprd04.prod.outlook.com
 (2603:1096:4:14::15) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR04CA0177.apcprd04.prod.outlook.com (2603:1096:4:14::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 06:28:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c408c42-57fb-4a6f-11fa-08d962116fcf
X-MS-TrafficTypeDiagnostic: MN2PR10MB3965:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3965D549E287DAB3961E7D69E5FF9@MN2PR10MB3965.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: szEU9jCZLmqoilIPWwl1lGPR0VsHn5VomNgVert5dgPN8ygrhJzqaMe/jG6xtKWI0/u4cNb09kIvh55QDu1OmYHw0SBDN3coYRxrgFQZB5XpMsvh7jjIbfFo20++GIP0h64D+djir/1ihaXl05ivNEg6alQgfNaoV9byPuNQlas9l+bqZpd9eygDigVKfftMpiBXeZ0XrHuupKT52LFyNLdWxQKWjLCnCX3F37+Fr6jmOoayf/rgoeMR9xLBWMbcui7RlyOXzV1kXzpvpUsSi5glQ9+OVp2V4Ig/Scrhiy5KgrAo6z8sjjxExLJDyCoKosUJDCBUgOu6ZBk6G5yFwunN/2tAh5F7eDWdW6f0Y7A30CCmi13XgJJSaoGLStzFnzbke2sujHq7Z2NOr8Bh/z69TSq39cJhWvXiKiA+kTUpjqoRoWb0MEeRkOLEX+3WLjn6Y2JdELGrFSyNW81RTC4Hwrr2U094xJB3KRTFIrk9JQS1xlkdL8d/uiG95pIBo2CTX5BRQelDZ8olMCa0g1f3USWz+siYedrWs3BlTbN1OqPtB+O1HZhlt+rFF3Ad1Yw9/mEzWqwAtEwef8e41jqN5gMLhAkx4ZAyJkh+2LQqJepvH+jsP/J7UJiF6jFY2yGp3I/lhXAuNVDPPElxyC1TgbzLR1zkpONZxlOIfq4g5GCBFhc0cGZTQ7KaUeHvlGDLNCKsdGZAVmKoLKBw+0tgMHkJg5zWPwOBEU21+YNd6Ohj5WhUk54nFMHZ4lIH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(376002)(346002)(366004)(44832011)(66556008)(66476007)(2616005)(26005)(66946007)(53546011)(2906002)(6666004)(956004)(8676002)(31686004)(4326008)(6486002)(186003)(5660300002)(15650500001)(38100700002)(8936002)(478600001)(316002)(4744005)(83380400001)(16576012)(36756003)(86362001)(31696002)(6916009)(781001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTdodGhMLzNQYWF5TnJuUlBWNVNVYVJwNjRjQmowZ015M2ZhZyt5Wis3bmNW?=
 =?utf-8?B?cEVRZWI2QXNwNVRoM0loR0FzY05zVXZDWDlCc3FPNzJuNmYzRjBIeE0vbUxn?=
 =?utf-8?B?MVpkeCtBOE41Nm0vY29MRU5tbnBxaFFiMmJWUXNuNjduUlJGREFqSHRQcUI3?=
 =?utf-8?B?Ny9CbXhtWHVLc2JoMVlYSVBTK1lPWEVMZFZMVm9HYVljOS9RU09IdXFNamEw?=
 =?utf-8?B?b2xXTStiYXdQeEdCZmtRMmNNaXdSYmxzNHFXU2w5UnFJWDhXSEtodXgwdDVh?=
 =?utf-8?B?Sng5aTV0RkNEd1NFaFhQbktyRVIzUHkxek5YQ2tTVGFuZGdMR3lRZnNZdlZi?=
 =?utf-8?B?b2dEVkZZamR6VDh4czVSY2tTRVRHTnp2YndBQjJ1UWJ0WUdzQ0J4WHF6S2Nk?=
 =?utf-8?B?Sm5tU1hFSHNCZFhBLzdKaXUvZWw1Ync2VXdtQWlPaUxSenc4RmljR0t4aXVU?=
 =?utf-8?B?bFRmQXA5d3I0Mk1lZk95aVZmYVg0aGFIVkZQS0t0RVJvd2E0Q0tBcW55N251?=
 =?utf-8?B?ZUxINHQybVdqTzFVNWQ3TVZseG05WDJOblZkWDdLWkY2YzdtWGl6Nnl5WjRz?=
 =?utf-8?B?bjcxR0NJcUlSVDlralo0WWdLMTRGb1VMTXcyMTM2djM0RzhCa3dUUVY0M0tj?=
 =?utf-8?B?QysrRmx0R0ZtMEovVmMwMlZmTUFTZDhXY3NOVXFVQTFPRnJHRnRITjlDcDhN?=
 =?utf-8?B?c2FGNTA4U2tPd3RITzRHUGxuVTVCQXFvVDBySzc3QXFsSWZMb2lqNVFBSnMx?=
 =?utf-8?B?THF4QW9RT1dvNTBBNUZZM2IwNExsV3pMNTVNTEpIbXBPUEQvTVI0NGl6MTZw?=
 =?utf-8?B?dVBhTWZaazVxYUwreVZxWUlTZDZLZFdkS3ZLTXRFd1pOMStHM0JIaE9xOVhk?=
 =?utf-8?B?am92Ty9hREh1L3R5VVFDU29HVTJ5bE1RVTlPcVlvb09KS2laV2ErNU00YlBH?=
 =?utf-8?B?MEF2UGhRd3pvTHZBY2drN2dBemVtVHduT1d2SjF5Ulg2YlBZS0V0V25GSnc1?=
 =?utf-8?B?NGUwZzdCRGI5VndSTUc3aFAwUVFKMEpLWEI4b2Y3Vm1JWWs0Rzk2UW5UdXU2?=
 =?utf-8?B?NnMyRnVETm8vdGdWYWI1WTdKM1pXNTBFbmt4UmpQMEpDa1NrMWVYWjB5THRT?=
 =?utf-8?B?Z3gzTDZBeUlsVkVGbi9LcWd0MGRyUDFaYytVR3IyY093ZFlNQkcwMDg1dWF3?=
 =?utf-8?B?NG9VWlB2NDNyMk5jNUpHT0lSQy94TEF1UXBGYUJGVXk0a2tYUkwxenNGSDdp?=
 =?utf-8?B?TXc2WTYrME05em45MTY0bkxvS29FMG1jZG1zOXhHMFdqYXgzSGtVM1FIQkRT?=
 =?utf-8?B?R0hlTDR6L0kzTGdNekFHSU9tZ0dCMjVlVkJrWnJVdUltZUpVNXZLbSsyR3BJ?=
 =?utf-8?B?WDJWbHFMYTVtay9BdlFYc2VkeS9yYXJRMnNsOTlCVC9SWURuSFRMN3FzMnZj?=
 =?utf-8?B?eXZnd2dBWHVrOHczQ29BWE5YeSt1WWZGa3FtbWh2WlZHYzVrZ2ZOclJOalYz?=
 =?utf-8?B?S0dwOW5TbWx0WUhtQk8xVFdwZlgvd3JCSUxjZkVUbzh6RVdLeDNaTE4rWDFr?=
 =?utf-8?B?MnZnM2NXd1pqaDVNa25vdjNzNkhtUFVTeWdXd2ZNeVREYnE0bWQwbGsyUWpy?=
 =?utf-8?B?bUw3UVZJY1c2bC9JMUxrUVhIaFA5NjNlZCtybGx3dkxxeFE2WHF2TkVFQUsw?=
 =?utf-8?B?L0w1UTZncVdzRnFiZE5UVWg4dk5FZXBNR1RwNGJLSGx5TEV5TVVTVm55K1Fz?=
 =?utf-8?Q?ktG2yro4vUy1RcwL4lUYFpxANWkulyBfbhAgDvd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c408c42-57fb-4a6f-11fa-08d962116fcf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 06:28:48.0857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7WGknJXqCEk+I7cpqJH5bk1CYBGFXyGi8SXlaYp+e7f3btSXKhAFbIBaUYcGpeOURiAPqNGC4Z1JH3LUNKwMdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3965
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108180040
X-Proofpoint-GUID: KacrhiWj069m91Fr2XqjQFVtxahb0jaw
X-Proofpoint-ORIG-GUID: KacrhiWj069m91Fr2XqjQFVtxahb0jaw
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 18/08/2021 14:13, Anand Jain wrote:
> 
> 
> On 18/08/2021 12:25, Anand Jain wrote:
>> On 18/08/2021 12:15, Su Yue wrote:
>>> Update it since commit 944d3f9fac61 ("btrfs: switch seed device to
>>> list api") did conversion from fs_devices::seed to 
>>> fs_devices::seed_list.
>>>
>>> Signed-off-by: Su Yue <l@damenly.su>
>>
> 
> 
>> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
>   Ah. No. I have remove my RB...

My rb is ok. I was looking at a 5.4 stable branch by mistake.
I didn't realize. It is embarrassing. Sorry for the noise.

Thanks, Anand

