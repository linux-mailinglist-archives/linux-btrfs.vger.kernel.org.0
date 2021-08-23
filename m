Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59C33F4910
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 12:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbhHWKzH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 06:55:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:12084 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236301AbhHWKzE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 06:55:04 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17N8TNvo007335;
        Mon, 23 Aug 2021 10:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RHM/v8UFD0OU165Jv3NnoFF8GORx+OP61uKdXEJns5w=;
 b=aa0+i0YileoW6KtGm3sPBm8IGEnZ7QnN0QNb8EBpN6tAK8rToXhftn7P86CCo3B96OVB
 aM68dm93I9XWuaf23DbdiojcjF2WWSnCADJez1AkmJZ5Gge9E39TJzHWsLtV7m6wdKYg
 uIL0S7D44fa3ZIagEdhyu+uxnsjJ0CUJ5AIwRUDsXyIYHRvVta+M50qkFrwamDTm7xgk
 eF7yEgJa/RaJDTmD/TjywaUWAwCx3hdiGZjU7Z/F3hrmfuSe0lPJ1Of/WFOmPHAd5yuD
 hTfKUbZ+8Vv4MHfIuH/G9Xea3mLV6C4uL9pq8z81AIf7wymPr/mIa6APV8Cv2LKFWOLi aA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RHM/v8UFD0OU165Jv3NnoFF8GORx+OP61uKdXEJns5w=;
 b=iBzIOi18hPO41Brs/MA12xvI0qAe0Gj33eP3Z65FsKh+fS6rUqkJQ18iMqTuaSpHS8sv
 4SIzjBZrbYWAw0Q3tlpSQ5AwcgHncgfbDlCl7rBDRLUgAj7JF75rvA81sMJEduRL5IRM
 K7PMnY0oqgA4AC2TJbDIGfl2px697Dj0b+FrZoV/1eJzoafE4wFWe7z5QO6n1XtPltOM
 4kt5pzAhacX7tMtjKTC2blHpzR/QDWFxULTfEtCtt0EEsttpxwBvbfNOCYAWFh6g1eKY
 MlrgPUYroC7WK0LR2SAIV9EIbDpOAqZVELgDmSd8Ui91KYtkVhSLuowJXqioycnPML3P Vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akw7n94m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 10:54:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17NApALq059026;
        Mon, 23 Aug 2021 10:54:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by aserp3020.oracle.com with ESMTP id 3ajsa34xwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 10:54:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3/5BS3GQCwr/xbH8PkZJ5Q3hBUxywiKYEdKqaIXyNl9Ttm7g8qJW3zOOkwXHQKZX2aKP21+f7hc/sRC/nJmKAQCQS+gs22IX+A6DPjTkQdgYs5G6Ae4wBKwNpJX5w79RTO/pO7tY7f4Mwyaj7GmVTQRlt2snHi0ScL/fiRRTTE2TLgNiM2g6cCQrP34kq5hWSNnYMeJq642L2BBn5GkJsvC5iuZ6ap9hdzZsadzNBqyUfEE//Mz1RFTIxFcYsYQYdyQd3wa/gOfvsc5DG/s0PAwr9UbS+MvV3akzTtehMbCRygl595c0ca4lDcpx1zZ0scIpvxX5Xs9I6MjQshNoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHM/v8UFD0OU165Jv3NnoFF8GORx+OP61uKdXEJns5w=;
 b=a9th2D5eOMLUEM84/v2l96o4xSEa0TAxFJNCDJN+pI62RJ7V/SIxRQFg8rNIkTRICmOP2EWt3IQzT3HL/Onm60nb7BrlQQ9stLzbF1qMkSLo4Gc+JQkP24fLjlYNX+6pHI5d0y07DzHR7zlcnUBA24alxi54Yte8RgemQUgiRe9GbXgALe98e47UoEOo/C4KmfeJ1lMOR8PBJZ8h8lQcVFbFgxFDI5qRjmFKP22N1mic75lgTXHXjITdF3WdXRdmlWXvgdc2QfNrX07ANAOH9cNW7K2ejENFoQFGFZ/LOBdsn/j/xJcfjDxsMd2cD2SI3RN/dkiAeVMvz4LrqsFlkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHM/v8UFD0OU165Jv3NnoFF8GORx+OP61uKdXEJns5w=;
 b=dvvtdBlBjsUtpoJTaoDyhcGDwNiFkXbQt9qaLdBJdW2cPbVUOsZ4jJ3yURCoKcBX2v0qoAHgTMZa2W17v9G5ymB9hk4BkMghs4VleX2aId0LOvJoAlFaKTFQE14jlGyjWH/7kWYArpSLTO1XynsNEioI3NSOAhNEPV3Mg8umu5s=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3981.namprd10.prod.outlook.com (2603:10b6:208:183::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Mon, 23 Aug
 2021 10:54:12 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 10:54:12 +0000
Subject: Re: [PATCH RFC 2/3] btrfs: consolidate device_list_mutex in
 prepare_sprout to its parent
From:   Anand Jain <anand.jain@oracle.com>
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <cover.1629396187.git.anand.jain@oracle.com>
 <8b8e72c87d0ee97da1b2e243a24b68d84d0ac3b9.1629396187.git.anand.jain@oracle.com>
 <y28weeg4.fsf@damenly.su> <4b891418-b8d1-6e3f-ae71-b1dface98ae2@oracle.com>
 <sfz2etf4.fsf@damenly.su> <pmu6eta9.fsf@damenly.su>
 <82c756a2-bd1a-9b11-a39e-525105ba65c8@oracle.com>
Message-ID: <953bdec3-4698-6faa-04b0-d1b71a75477d@oracle.com>
Date:   Mon, 23 Aug 2021 18:54:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <82c756a2-bd1a-9b11-a39e-525105ba65c8@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0152.apcprd03.prod.outlook.com (2603:1096:4:c9::7)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR03CA0152.apcprd03.prod.outlook.com (2603:1096:4:c9::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend Transport; Mon, 23 Aug 2021 10:54:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fed4e275-057e-4271-d1af-08d966245764
X-MS-TrafficTypeDiagnostic: MN2PR10MB3981:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3981349C0079C1D3AAC9D8FAE5C49@MN2PR10MB3981.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fOQ3UpGvKOHumnNubKfw6sxN7ucDxifJ9OHLhdHpt6+A28fCrrGY9F/3kw+io0iY5fLIs+RwfLtqkcv0ML9FJyBLhvAocBwgwduXEdHQhz6AEZobc/B66Am+NlUtbiw5Rb/EYcS97wsMUd4TYc6atLzOvTWlU48SKtxeHCkrIQBpRyoN6GqibeClLuK+Djjrdsis+mMIDL1eU3crVUXpsBBL4zhRdeLjIrOhbjrynZzw4maNK6Sac0kHMDTs4eJAFsrVTTv7h6RMWNZaXQdwsBAPoVesR6uoTSuJevvZhIBlS3GdUJEfHvnJlqi34GWfP/fAREHIgIdn1OKl9YfFHjHl/QwJiDEcgFe0keR9+PIBSc1BCmaD/KHB8pdUPeLXyJviENwURyJd8yNVdUrr0jSLfM0VDkJPyg7dwarw6e1r2QRMfAtrL8rE7yhdv0gu2jHZXtSEzM2SehKoatL7VO/EiqgYc3ZkBZXhMpdDd6UsnZXlQuAwXiv+xBwkEx87Ra7ZvVJ2x9scjAgF7a0mCJdVhjWdHIsmvUwuQGNUxi1WD+GhG1EFq6cnr+gc9uO7FDHvQdKjBOvelzaKUG4beUBf8w3BNDLtcfpaLnuIS48eNJHRR5m/1ZqQAHfexl3Omq4XKTh0mSXYGFcFAMtPcQGnT6zWeOG/NUlezutO77jIkrSwcCkl56wc4AabhehlxJu80S7HF5cwfvEypIxsIVqO7+4LY5cMV+VlM+G3IgfqGTaJ6eNuSBcLEaRNXMhpAHhMpwsb0eCMUgZP7fKFDsdJxu/jmFD//BprOP6onYMcN0cKElyyDnUcfU/UJmBXSWVJ4rrfaexi4dXsvmeC1+umPcjVChNWZdnj7XvV+qrwzQuN179REoE59LcGSwjd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(39860400002)(366004)(346002)(396003)(316002)(16576012)(44832011)(2616005)(956004)(2906002)(66946007)(66476007)(83380400001)(53546011)(6666004)(66556008)(86362001)(186003)(6486002)(8676002)(966005)(478600001)(5660300002)(36756003)(6916009)(4326008)(31696002)(38100700002)(8936002)(26005)(31686004)(781001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEsxSkFMcGxGT1ZsSjBiZU1hTFgvWXJpakpZdUpxb0padXRIK3ZpUlhvOExt?=
 =?utf-8?B?bysrQlBOQlpCdDRUb0Fjelh1ZGt2Y0hwamRPbzdHZWx3YWtKOVNYYk9FdzZ4?=
 =?utf-8?B?b3MxVmNPWVQrelNVRkE1c1lCdEtqakZraWtMcGFUUUt1bDMvenVTejYwa0xZ?=
 =?utf-8?B?b2F3Mit5enp2VDBnM2JuUmQ3aGRJVGVpTDVIenRlU29IRzJPRk5ueE9ZT21N?=
 =?utf-8?B?SnQ2Q2UyQ3d2ZHlLQjIxY2MwN212bWxiSEV4WHNZQ2tCeGxQTUNPY0piUURE?=
 =?utf-8?B?RC9DVE9lWVF5aXRzUHgrVGlLYlpERkZPbHVqWTh4dVNCT0NuaEZrSmJBK2Vo?=
 =?utf-8?B?S05IbVZFdHBacEtCRlhXeTNFanVsQXd1VGJyRzNaZmo4cGRNaTRUSkp6Uk5x?=
 =?utf-8?B?eDZMcDcwM3FnRm5hMldBcUZ5ZWFtZUdIcnY5b25jN1JjNmg4NHRMQWJrcERl?=
 =?utf-8?B?emNGa010Kyt1K3dWNkxtUTVJYlJNSDFvckFaaXBkdmpUSjgrV1Vqb2hybEpT?=
 =?utf-8?B?dDlmQWdPeVg4RC9sR3RhQnpnWnkxa0Ewc0xoV0JkMksvSm1IdzlTL1FHcnVs?=
 =?utf-8?B?SXFqZEVpV0pRdlY1Z0MwRDduUDk4dmZrQ0hlR3BQemhZYm82ZFMvUWdTN21o?=
 =?utf-8?B?aTZscVVoUk5IN1lZaSs2R0MvZkJDQW5pU0tmZmFaMFR2eUptY3ltSXVoS09u?=
 =?utf-8?B?ay9TYWR0RFlYZnBvYWp1UFZDZC9tOTUrRlkxcEpZd3FFdmJBYVBucTRFdWlk?=
 =?utf-8?B?M3ZNTFliSmtKcERSajl0UDdLYmdyZFlLa2FLZWhRWENteEQrdVkxWWV1Zm51?=
 =?utf-8?B?OTJNNVN3ZXV4RmJqdFBHcW1qZFFtSGRScXFrTFZ6T09Nby91bEtWU2JjaVhk?=
 =?utf-8?B?QnR5K2ZTQ2NPWnE5ZVdQUEhxQWVVbWtaVURZOCs2TU10M0hPS0RtZno2aTFG?=
 =?utf-8?B?RXU3aVFJMnNzUGFRRU1STncxVnJFSnJoR1JZdnVZTjF4R2lhM29wd01aOUM0?=
 =?utf-8?B?OXlPRHZNN3dQZHp3OXkrc1d4eURsdUIyeWNzcGQ5UDRscEhOc1JOaG5YZ2xh?=
 =?utf-8?B?WjBJNzVsNVpFVXpEYjFBWkw0ZkJoWnZsV0twcE8rN0VIQW1zTDJYdDhaczhj?=
 =?utf-8?B?V2gyRWY3M1h4U0M2SzhWVGFxZ0FFL2dhb21UT3hkQ01VOXdRZnJLOVNjVDdm?=
 =?utf-8?B?c2ZrYmd2S3l5RGIvTm5sZWg4OTRNTUY5UXlwUkQ1bXRCVzVzbEp1WDlSdStY?=
 =?utf-8?B?U2ZiS1ZDenZramtZeWorR2l5NFV2d01ORWlkYnQ3aHQ2UlZZSWdHOVJXT0dh?=
 =?utf-8?B?b1E4TWFRNGRXbEZHYlI5WG9vRnliRjR1NFE0TC9RWmxvNzF0ajlVZWVNeStJ?=
 =?utf-8?B?aXpLVWExNGtOS3pxZnZsdVpnOCsvYTZKOE5iak8zVmwwc1dQZWgyKzF3RnV2?=
 =?utf-8?B?SkJDQk5DNmRLb0tpaUpTSDhXK2Q3bmNLeEs5N0xFZmJhR1JOb2RjVEdHMWR4?=
 =?utf-8?B?d1RzanV3cjk3NCtYZGhRVkF4NVd6aHkyRXVsSVFNQ0EyZ0ptOHN6N1dIcS9S?=
 =?utf-8?B?RTRhMHgzMzFpb1VKdkxSNjJvTVJsaTVpZGM5endxSnpGLzRaR2sxWXlEZ2lK?=
 =?utf-8?B?ZEtWWkxDMUszZFU1T3NjdnlYa1lBSVpHQzZyYlcwSmxqeGRuODN3bUVoUGRo?=
 =?utf-8?B?NWJ0bzRibFBLMG1XcVgzRFYxb1l6eFpUTlR4K3NMaXNPTWgrV3pNMXM3dFhq?=
 =?utf-8?Q?YWQEfV+Ki5psjJOLKQ8hLF8In44EnA4YLequZ9p?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed4e275-057e-4271-d1af-08d966245764
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 10:54:12.1791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Up50t4XRg4bFL5CGU7NAIWDFbdO9TjiDYhX9yNYN0rjrs3wFuXgTy0aeFYI9mgWLJttZ98W38gx18S0+YZVhsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3981
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10084 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108230072
X-Proofpoint-GUID: XBXNYMrpvY-YWfks7RICYJ-GP9oO9RID
X-Proofpoint-ORIG-GUID: XBXNYMrpvY-YWfks7RICYJ-GP9oO9RID
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 23/08/2021 18:34, Anand Jain wrote:
> On 21/08/2021 23:00, Su Yue wrote:
>>
>> On Sat 21 Aug 2021 at 22:57, Su Yue <l@damenly.su> wrote:
>>
>>> On Fri 20 Aug 2021 at 16:53, Anand Jain <anand.jain@oracle.com>
>>> wrote:
>>>
>>>>>> @@ -2366,6 +2366,8 @@ static int btrfs_prepare_sprout(struct
>>>>>> btrfs_fs_info *fs_info)
>>>>>>      u64 super_flags;
>>>>>>
>>>>>>      lockdep_assert_held(&uuid_mutex);
>>>>>> +    lockdep_assert_held(&fs_devices->device_list_mutex);
>>>>>> +
>>>>>>
>>>>> Just a reminder: clone_fs_devices() still takes the mutex in
>>>>> misc-next.
>>>>    As I am checking clone_fs_devices() does not take any lock.
>>>>   Could you pls recheck?
>>>>
>>>
>>> Hmmmm... misc-next:
>>>
>>> https://github.com/kdave/btrfs-devel/blob/e05983195f31374ad51a0f3712efec381397f3cb/fs/btrfs/volumes.c#L381 
>>>
>>
>> Sorry, it should be
>>
>> https://github.com/kdave/btrfs-devel/blob/misc-next/fs/btrfs/volumes.c#L995 
>>
> 
> 
>   Some of the Git commands stopped working. I had to run git fsck.
>   Now I see mutex in close_fs_devices(), not sure if I was blind to it 
> before.
>   Anyway, this is a bad patch. I am working to fix it.
> 

  Git errors were distracting. But why I didn't see the 
device_list_mutex is because I had the following patch [1] in my 
workspace, which is not yet integrated to the misc-next / commented.

  [1] btrfs: fix lockdep warning while mounting sprout fs
 
https://lore.kernel.org/linux-btrfs/8325002d-f8a6-a9b7-a27d-4cf62cbbc672@oracle.com/

  So as of now, I can say this patch needs the above patch.

  Could you please apply the above patch before this patch for tests?

Thanks, Anand
