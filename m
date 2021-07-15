Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688643C9978
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 09:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbhGOHSh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 03:18:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:29744 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230410AbhGOHSg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 03:18:36 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16F7FZdY031650;
        Thu, 15 Jul 2021 07:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tb+uTMDzhE1dXpuZ7LmunmasJ+yQx+NER7NaKgf58GM=;
 b=Kj/yHMShcL4p9eVPAVdOEsHJ20Oura4ywvfb1W3Fp5XDdr0CzsqNUHfmR2J/hIHYUOmw
 YXWjafRPhob5duhjZHHPEGttfHdpYLlMn3bDpk9N4oAcnngK2SDZAaQ3aidv7dB4GXfQ
 5Wnh1E0LIElQL2bOyrLrsif+b3dqEo1j+SzJELEMLbwOuu/lsHDMeN8sbk3+5KMzFzrb
 BiIY0AVyvEo6QdVPzkti2pVgKnYQ2PCWq8o59mcsEbVzk0/mlALKAiG7AVkcGCHrg8ki
 xfpWxAovurqmEf9GlbrZIa9Ux6WOeDh1goco8dygYNOS3YGAWxRAICQSMNu/Kex7mEVK /w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=tb+uTMDzhE1dXpuZ7LmunmasJ+yQx+NER7NaKgf58GM=;
 b=QMCyZH4Qr8xuWc1Z3WB/Zn//R66JfsweLC75LLkrjQpbHW+lhB2stw9cuGzzR9KqvlBv
 8Gz7YlirrjNjEkFmZQRlXNh1Pm44wnaiNxPROMjDRHSn9gDeLblwOU9yWj2lS2UWpORp
 j5jw0UQHTccgF9nYwzr93YmhBk/IQRvLqJ3lls5NN+Z2UchnAAW/akU3jVk2a5VELMXj
 dr+siCJ72WGqhIbEDYSZ4123geuQNij8gsRgQN7/B7pQjrCSTfyV/NCCbpvb5bSeRmB5
 6NzoidmvrwaT0W5DD2UpWdNEW2F95B2W5jHIhUQ5jbG5JCcw4i5qsqHL+YKAW41ZniXc zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39suk8t8w5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 07:15:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16F7B3AT014343;
        Thu, 15 Jul 2021 07:15:36 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
        by userp3020.oracle.com with ESMTP id 39qnb50xv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 07:15:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/E0IUoU53HPCdfrBwaZHdLFi3EvK5xk8ybFZWU1NfkfNZJfhSQuwmN+D0/9Vf8RMAMZRmXssK7m47w4O5io/aQ4lFDlta+dYr+E5cFlB53gXqzhRq8PGkjgLhzEoBNe0GHMm/zujmrjhLPya7Foyt3egMGjWSPDWwXl26Cb7ZY4HnHE0UPw0rI+akVATAIuIzO+8S5bzY3qOfj9E5GCL7HSxP0PZXY/GkMtarrrr65Kg9bzmKHsLb0pdQ7hJVhEq/WfcGovRnULBjX3pzBdiz7TrB7CbEx2mqzx86MhHx04I5TL4uNfpmw/XdOCjytH9Cl6fMOhn0P4kqQ4EVPu5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tb+uTMDzhE1dXpuZ7LmunmasJ+yQx+NER7NaKgf58GM=;
 b=NEuNthqsalbrhh45jPVowMMwbt9kv2R3/pb6aoQNsxEIrkTk0yg2wNZ+opRSAiwksxWsMHBxxEDPVtS/ONQ7wqxBuvzR4YTAaWj6WgldSgLel2pICJCPMl1+FdApZQ735nj8g1tBRZy6CnwhqrWDjRvaTSOeN/Do9NT5SE+PFgZENZYdqzcCQgztPkzYfNuaMgUpIdYSot+kp/NSTd5740X2JkU4RJ2mVTj5OKUjcJwhR3Y6KkK+wU3h+j2cYfFLBg2ebDm6DWrlE+FkY7Ysy3n19Xxz8hWLA/W26LR0TEChWRxbPb5BO5i09h6I2rGhgJVyf3nVKnGfccq6O+BW/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tb+uTMDzhE1dXpuZ7LmunmasJ+yQx+NER7NaKgf58GM=;
 b=eSSXwXEclr8+Un2H3DpKvCQW+qIwZX9fHMGs27trBmJgy2CF5voCZLvNLw4cLalph/eSrGPTqNBTwFkyHB9QEStlbYmrhVwyu3J7Kvuqz3xaNbk5Nc234uHfdmCSoTbtSutBZItCiSf0w5hG7AbaLoTVtORjEw9kAIMGLpxZkfg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4237.namprd10.prod.outlook.com (2603:10b6:208:1dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 07:15:34 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%3]) with mapi id 15.20.4331.022; Thu, 15 Jul 2021
 07:15:34 +0000
Subject: Re: [PATCH v2] btrfs: rescue: allow ibadroots to skip bad extent tree
 when reading block group items
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>
Cc:     Zhenyu Wu <wuzy001@gmail.com>, linux-btrfs@vger.kernel.org
References: <20210715022848.139009-1-wqu@suse.com>
 <d3d1dfea-2858-0877-e671-73ef1e1ec7af@oracle.com>
 <4808cdac-986f-ee84-154e-5a4d90b6a06f@gmx.com>
 <45bba91c-1e79-852a-c3ca-80d1fba2c083@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <38658bb4-d977-ec5e-885b-52f10e005507@oracle.com>
Date:   Thu, 15 Jul 2021 15:15:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <45bba91c-1e79-852a-c3ca-80d1fba2c083@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:3:18::23) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR02CA0035.apcprd02.prod.outlook.com (2603:1096:3:18::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 07:15:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7cec857-5a00-42fe-1d35-08d94760562c
X-MS-TrafficTypeDiagnostic: MN2PR10MB4237:
X-Microsoft-Antispam-PRVS: <MN2PR10MB423745DCC1E39DAC254204C7E5129@MN2PR10MB4237.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CgZPx5Nd5w7U8HKzGy8r7xXkn/VcFsTOUjGypkW/F2eqQYxnvYCp6CTvEn1dv+Mr2xFix7RbC/E0J+wWhQCQS1PNtaGgWHmaWhjeYXiu0AG4BtIoRMx9FFwmxaL5ypoIj/+CXpqigIcHEqBYdeT3xRSssMBSRbZTo9klxypdTthWQn4FrItY+Ik+ZadQSqnOIMlG/yFB8s2EzBT/Nru9SZqwaYBqdQTf6lQdhhWAPxbKKKT4qGqGWwcb/LNbbe/URFcolHWwPIUQ05iBBVICf/ew1UE5AbbVHM9AO0tQ3fqh1Y+gwKRlmOViHwasvX4ghRKNK3W/A9ctYToLyfYvK1/jZN9RVl7sPpiHthcEi6cClfgeOEiwkSPw06+3NM5dX/dz6EkXtDt5/agXf4HY3CXgwFVZm/zp4h1gVDDYCvlOnPRYS0+WSxn08W4cUCLarNWchQv1vpXlHzwZsazQnqq2h4Gc1aG8mHeckffa4xF8hBxJgFZL40pADzkmIS0TLzWk5ZSw+bpqvmFHcYIh7Vnwhv8E9mo/LROV/40ikPsOqCVSzpnYXPsljGf3YgOJRAMbWPPv3NZA8K2M4igEki7qRwLsa4VZo1aTaG5azRgv/H2q0YTm/fF4yxFyIFYRq9dR/hxqsHQ7kDTlPDxgYi3G98SHVneDd/V6SbsOvdOascWmMt6gD2adw92qJFPU/+OZQXVb5WDvf6K+Zy/wRDx8rS8Vs8dXkrVLAHNZNeln49P7VxPD22/HMz/r7HtVf3YUIllWeBxGdSYbgNLqo2knO3Smkxvh7fFPAQrVDkrtLpksxdwPypE4IEhMHU4l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(136003)(366004)(39860400002)(316002)(966005)(6666004)(478600001)(31686004)(110136005)(16576012)(36756003)(83380400001)(6486002)(31696002)(86362001)(5660300002)(26005)(186003)(38100700002)(8936002)(8676002)(53546011)(44832011)(66946007)(4326008)(2616005)(956004)(66476007)(66556008)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDFNTmNmRjhLa0p4bVliS3JtbG0yN3p3czVHZHJMN0JXYm04UDR5L1drcWtQ?=
 =?utf-8?B?UjNWem1VOGF1c2U2ZWg5VitpTXJTakR3UGlTVmJnYURHdFMxdDNCZkc2bWw0?=
 =?utf-8?B?b050cFRvZTRjNStiK3ZTaWsrOFJ6ZmxMdU1HV2c5T1A4eHBJTEtwL0lTWjBM?=
 =?utf-8?B?ajUrc2p1MzFxN3poT0J2OGZJYUo3UzcvLzlVaWcxR3BBdVo0V2doZlE5MWZ6?=
 =?utf-8?B?QUtNNGhNVTJ2VlZhdlhrbWRDaXRhWHFzWCthREV0UklNMHhZN1VMcXBMVHBx?=
 =?utf-8?B?a3FjTVlRNUVaWXN6Yk8xbDBQSll0U29mdXNBdURBMEtRazBVYlJjYjRmanJl?=
 =?utf-8?B?Y3FMRDNKY0VUMHBEZmo0S2lWS3lXOUd5d2hwdlNXRW1vK09GdmoweWtoLysw?=
 =?utf-8?B?T3RhcFB0V3Z2T1NzNnZFYlQ5SkRYK2V1VkloWDVVRmJ5cnZzajNMOFZlcU9r?=
 =?utf-8?B?Ui9nUGFqUjlKbmVWQzhubVJKYndIUGhMc2ZULzFSRkxsMEloYitxbXpNUEM1?=
 =?utf-8?B?eG1iVEJtZ0FaL3p3djhRYWpkN2JQNzF2OXZuUVY1eElPd3lsTllyY1A5VmRV?=
 =?utf-8?B?YnRwQTdkNUFFUjM0cXk1L3NvdXp3QkRtWkt4Vm5FOWFEZEs1SWFKbTFlMVln?=
 =?utf-8?B?L2ZsbUgvRVQ0YllWdnR4amlSTi8zeUdGZE42UStwdExhWTBHSERobHpwS3Bu?=
 =?utf-8?B?bWNnempwTGZrR3NJRDQ5eWhJZ0QwK25LY3dLcnFUOEVYZ2pFWmxmR1dUTUM4?=
 =?utf-8?B?TFU2K2JZRk1xZEpTSUs3WTY1N0xCWGhteENMdDVyMk02eVB6bHNPMi9JVGNo?=
 =?utf-8?B?MWpjQkNTZmlCVVZJUHkzSlB1RzBkYWtQVzRTejNPZUdJSG1aeE1KcEhMK1Nr?=
 =?utf-8?B?NTZMR3lzOUh2SFgrMzZZNEt6Q2lkOGdLejVSZjhpeE5ubDRmQlQ3Ykk5SFVE?=
 =?utf-8?B?RkdjSDhQMXREOG5iQVZ1elpHOGFEbXlpbDZJVHRMVFJObmdobmo4SENIYjAv?=
 =?utf-8?B?QlUvemZ6WUU0OThIT3Y3T0ZNdFh2MXJHcCtRQk1uaWs2cndDVlhxbTViQjJL?=
 =?utf-8?B?UEF4dDRKUytnb0hQUFpDd1dJbXFFWldMSEo3WXk5SlJRRVM0bkRiYmY5UGc4?=
 =?utf-8?B?WXlLcTd6WjVGd0hIcVoxd2xSVHlZYTZwK1hmRmRxblAwSFU4c3VEc3VlTzdl?=
 =?utf-8?B?UlhxWHNvQzVuUjR2V3p1dXNDcnhyL3pGZDdteFNMakxjZjkvSnBSY2QyckFN?=
 =?utf-8?B?U1k3dExzL3V0SEQ3U2JoMTNNSTNGeXBEUVM2dTJZbWMxM1ltZGxpOHNvT0tF?=
 =?utf-8?B?TTJKcmN4c0dtZ1BaSXl6ZmtMT250Wk5XQ05BSkxJaEVTZlFOWmhYMFZmc3Vk?=
 =?utf-8?B?UWRuY1JpYWRSU1VDNENuV0RKK1VlVVduSWw0aFJ4bGZ1M2hzd3NmR1R6R3Zk?=
 =?utf-8?B?eE5keVgxa0p1RCtJblc5Wk1vWTNEaktXNlc3dTgzdVNiZllPZEN1ZEdzc251?=
 =?utf-8?B?TFU3UlA4TU9PM0dXTmxoMXRBeXhLR2kxSU8zaWNzRGwxZjltU2xXekQ1dGJ6?=
 =?utf-8?B?USszdmNoeWlTOFNJTGZYbDJZZTZvMVg3aWp3Sk0zVnJMbHdmOTBJZFF2MWs4?=
 =?utf-8?B?Z3BvNHJIWVZRdkQvZVc1NEdTQ2lXUm5RYUVFVWZWcnhtTnRQbjJUMG02dVgx?=
 =?utf-8?B?REc1c3B2KzNmSXlCK2J2aVY4cklubmpYeCtjY1ZYbzhWZ25NRStYc0NnY3V6?=
 =?utf-8?Q?gUqVfTpU2P2KqZfyXXTcWytUecF7+XA8VQTKzky?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cec857-5a00-42fe-1d35-08d94760562c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 07:15:34.0826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmeB4uxTcyfi69HDJPKlMDTFl7GuUh2Kp5H0fE0R5EiYViLQmbtnSEIsCMTZZGqf95Oquis1lkzRm1o7nEt8oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4237
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10045 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107150053
X-Proofpoint-ORIG-GUID: MVgNEPoVoN-Or_7OpD9oUrjq5UskGX44
X-Proofpoint-GUID: MVgNEPoVoN-Or_7OpD9oUrjq5UskGX44
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/07/2021 12:54, Qu Wenruo wrote:
> 
> 
> On 2021/7/15 下午12:52, Qu Wenruo wrote:
>>
>>
>> On 2021/7/15 下午12:19, Anand Jain wrote:
>>> On 15/07/2021 10:28, Qu Wenruo wrote:
>>>> When extent tree gets corrupted, normally it's not extent tree root, 
>>>> but
>>>> one toasted tree leaf/node.
>>>>
>>>> In that case, rescue=ibadroots mount option won't help as it can only
>>>> handle the extent tree root corruption.
>>>>
>>>> This patch will enhance the behavior by:
>>>>
>>>> - Allow fill_dummy_bgs() to ignore -EEXIST error
>>>>
>>>>    This means we may have some block group items read from disk, but
>>>>    then hit some error halfway.
>>>>
>>>> - Fallback to fill_dummy_bgs() if any error gets hit in
>>>>    btrfs_read_block_groups()
>>>>
>>>>    Of course, this still needs rescue=ibadroots mount option.
>>>>
>>>> With that, rescue=ibadroots can handle extent tree corruption more
>>>> gracefully and allow a better recover chance.
>>>>
>>>> Reported-by: Zhenyu Wu <wuzy001@gmail.com>
>>>> Link: https://www.spinics.net/lists/linux-btrfs/msg114424.html
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> Changelog:
>>>> v2:
>>>> - Don't try to fill with dummy block groups when we hit ENOMEM
>>>> ---
>>>>   fs/btrfs/block-group.c | 14 +++++++++++++-
>>>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>>>> index 5bd76a45037e..240e6ec8bc31 100644
>>>> --- a/fs/btrfs/block-group.c
>>>> +++ b/fs/btrfs/block-group.c
>>>> @@ -2105,11 +2105,16 @@ static int fill_dummy_bgs(struct btrfs_fs_info
>>>> *fs_info)
>>>>           bg->used = em->len;
>>>>           bg->flags = map->type;
>>>>           ret = btrfs_add_block_group_cache(fs_info, bg);
>>>> -        if (ret) {
>>>> +        /*
>>>> +         * We may have some block groups filled already, thus ignore
>>>> +         * the -EEXIST error.
>>>> +         */
>>>> +        if (ret && ret != -EEXIST) {
>>>>               btrfs_remove_free_space_cache(bg);
>>>>               btrfs_put_block_group(bg);
>>>>               break;
>>>>           }
>>>> +        ret = 0;
>>>>           btrfs_update_space_info(fs_info, bg->flags, em->len, em->len,
>>>>                       0, 0, &space_info);
>>>>           bg->space_info = space_info;
>>>
>>>
>>>
>>>> @@ -2212,6 +2217,13 @@ int btrfs_read_block_groups(struct
>>>> btrfs_fs_info *info)
>>>>       ret = check_chunk_block_group_mappings(info);
>>>>   error:
>>>>       btrfs_free_path(path);
>>>> +    /*
>>>> +     * Either we have no extent_root (already implies
>>>> IGNOREBADROOTS), or
>>>> +     * we hit error and have IGNOREBADROOTS, then we can try to use
>>>> dummy
>>>> +     * bgs.
>>>> +     */
>>>> +    if (!info->extent_root || (ret && btrfs_test_opt(info,
>>>> IGNOREBADROOTS)))
>>>
>>>
>>>    I missed this part before, my bad.
>>>
>>>   info->extent_root can not be NULL here, which is checked at the
>>> beginning of the function.
>>>
>>> 2138         if (!info->extent_root)
>>> 2139                 return fill_dummy_bgs(info);
>>
>> Oh, you're right.
>>
>>>
>>>     So should be
>>>         if (ret && btrfs_test_opt(info, IGNOREBADROOTS)) {
>>>          info->extent_root = NULL;
>>
>> But this is not needed.
>>
>> We can have extent_root if only some extent tree nodes/leaves get
>> corrupted.
> 
> In fact, if here we manually set extent_root to NULL, we will leak some
> extent buffers.

  Right. After I replied, I thought so. Thanks for verifying.

-Anand

> 
> Thanks,
> Qu
>>
>> Thanks,
>> Qu
>>
>>>          ret = fill_dummy_bgs(info);
>>>      }
>>>
>>> Thanks, Anand
>>>
>>>> +        ret = fill_dummy_bgs(info);
>>>>       return ret;
>>>>   }
>>>
>>>
>>>
>>>

