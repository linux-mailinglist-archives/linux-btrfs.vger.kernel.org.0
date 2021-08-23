Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C1E3F48BF
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 12:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbhHWKfK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 06:35:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50458 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234155AbhHWKfJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 06:35:09 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17N8TMDT021828;
        Mon, 23 Aug 2021 10:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RUk/h9TbEy6lqShpcPRZdJfoVxzXI3hx4J1fkIwxdpU=;
 b=GSIAmgysqkvRDEvBPxI66XkN317U/Aj3HEm8Vbg3UIEcxNV61nBIErxPY3dKFPFI3ZJn
 frRh/bGPOyMObozxjg+/O+sACDVPMceNFbzsbc6vdXA4jsGN0DQFhOfLAslDEHlJ78y3
 h8GUSUngfh5FnpDUyMawQNpVcI5WFOafEkfU8ilExuWVPX24lhc28QkcwR1IUVEvyA/+
 F7TxbtPKFbcCR0LaQBxJ7C/1A8/jPKYrgIESUO0o8WWmMMsbAXNdprKwvZ901KzyDmKK
 pyJdLmazTgekRdxcOCWeMFK1bYsxYks4a8dt0W2cL0qh4rZZJxviMPFtCxw/0OSHwiNo Tw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RUk/h9TbEy6lqShpcPRZdJfoVxzXI3hx4J1fkIwxdpU=;
 b=qf0ti0lkTWz+DvljQXw9w5ZJoHPaeIQdDsRf+vTx1Q6WDsH2VHlOyHnmsSyIydSmPcis
 veKkxFRXTGeCmPLB8xA4+SIH/dNHCB3ZSAYzXEwC82LfPyj59qdcnI8A//KPsNaUG/kX
 amTA2RvV8ElrS9048o1rinIvXg0zuYu1SLbmhsACxYZADfOn+1izYQxrSmKkXWPg6dYi
 0bpxt6wzVd258/wsw3rxv6Uv9tkPLMMOxFs0wLsX/d/gU3mGVoBWOsTqHBFMjVO3BzZo
 5QaryEQKDAaXnhCpyIcagKXH74Men7oFH3ru+OXx3wFjxMIhYVJ8s6XMdc6Ay3gwxvbj MQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akwcf92tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 10:34:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17NAFGkm072118;
        Mon, 23 Aug 2021 10:34:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3030.oracle.com with ESMTP id 3ajqhcem9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 10:34:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQESKuUTUGm7jm5ZPrZpq4SvD9AJF43EZFCnSx1tboFDJGfkK8pS4t+W51AW/kYTt9RfmLPvBlC79i/r5jV3J5GW6dPvkepVQTpJwfUmxiKp+aFTJeNh8Op067jARXW3a/feZaCZD4NwWBWp9o3KAgCdkrvrvJVSk7EzvOodW1tDc2mQS4lMqghNUSweAls1w88OiGmVteBxfwPA3fKo1Zbq95+8bri6/rzu5nxcO5VcGtKht0lGJC4Mg+Qq6U505bMVGbHAw6vy472GKwGm6+mTvYOkzG9ADTGiqenO+Kilkw802Rz3bJ4hhCnwOsgAu+cu0vsAOUFFcJ8Bosb1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUk/h9TbEy6lqShpcPRZdJfoVxzXI3hx4J1fkIwxdpU=;
 b=P6idtX1/MVwjgZj8c7yi7oPjgJzS92xxnmAgearMIE2x1Fc9PdQWR9aH3PSCTAcQ/IhfSxE6BmSOF132Nv3ym3S2DT18JRkihZYyo11oqPdnRLC1vLmngRImh9rHFpG11BQHxIedTyDT9TmU7AXVEoAlfJXS8oj1qnc0Fo3L8ifXZsFjWNz5uIoAccGYw6wNkkYGa3kDquMEOvnTuihz2Rp4+QEp6PtIDCF+kLkxGQy4rUx9zix/AtpBXs39oqNf9rYRBPzdTV7/gZJ88YqovWKXK3JPJWzVtCuYwUyrLr96OvvFYTtyOZWgZoBeqiYKtllOjXHdL+zeaOZByx6/Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUk/h9TbEy6lqShpcPRZdJfoVxzXI3hx4J1fkIwxdpU=;
 b=xYffAKPY8SqYCwviF1sKibVcwTiu7x3+RBca5HFdncvSJKUwVGZhtofik1QrzZ6Zpc3diE6AEHzxH7l2N/eK4+dSLhhwaQaooJYBFNpvkp4qOTwJ2W6Z8gE7Hl8lcPTJtEa1QU/fABsMoGf14bHmSiQP7CxHqMyxbejpdvN5QJ0=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4979.namprd10.prod.outlook.com (2603:10b6:208:30d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Mon, 23 Aug
 2021 10:34:18 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 10:34:18 +0000
Subject: Re: [PATCH RFC 2/3] btrfs: consolidate device_list_mutex in
 prepare_sprout to its parent
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <cover.1629396187.git.anand.jain@oracle.com>
 <8b8e72c87d0ee97da1b2e243a24b68d84d0ac3b9.1629396187.git.anand.jain@oracle.com>
 <y28weeg4.fsf@damenly.su> <4b891418-b8d1-6e3f-ae71-b1dface98ae2@oracle.com>
 <sfz2etf4.fsf@damenly.su> <pmu6eta9.fsf@damenly.su>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <82c756a2-bd1a-9b11-a39e-525105ba65c8@oracle.com>
Date:   Mon, 23 Aug 2021 18:34:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <pmu6eta9.fsf@damenly.su>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0140.apcprd04.prod.outlook.com
 (2603:1096:3:16::24) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR04CA0140.apcprd04.prod.outlook.com (2603:1096:3:16::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 10:34:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39d57573-9353-4952-c295-08d966218fdc
X-MS-TrafficTypeDiagnostic: BLAPR10MB4979:
X-Microsoft-Antispam-PRVS: <BLAPR10MB49790A96254FC8DA2A11A8D9E5C49@BLAPR10MB4979.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LRpfGIu8/pJ00MRdSHHBtn+nBYssIvK15knFUuNyNa6rE7HgMAquHcs/NCStnBFQhBnaih0J6j7H2hP8afX8z9IfD1E+SPevqQ0HejvHVHr5a/56PKQbrlV4ZJV2o5c4sioyLie8q+Q+uK7hwI3kvSrQElhzitEj0Tr9184nQ7LW9mvrdANawaDtTKVM9VbdyDqu0QuXX5pVogz0mNA9xLP7M0vDvkAct+fzAarb5pb1mRAPHrmYcCQGSN9FXI0BKdISM+cdCPrV7nBR6ttVM8sKX6AVhTsOqePwy3nBs0nIQ2jbcchDvlVnI5aPTOqk1zc3+uUN0nNH3JDl5cKWcnYBu8FoNu7RJ1U2wxbXuhikNERuGVCiOrufpSe28c6qhezdtOD42IoZ0IxJzq9YYjEd9T0myPmKumUz91R8w42fjqxEKaxhIu+BFKikJfm/WZuR/yvbStbWKt8qaqc8V8MIXjtRqEUcGwSug8w7i+9Tnnir4o7XPhgkmKQFcYkEZo09kXwseZM3RtI5ZCqu29D5oZJ/0NGjzueSnb0k3f7Q5ztzioBJNRv1qwoxFpTMBolPpCHxip4WZNToFthsVW7SzMigsOhbCcOhgXUji/Fh33D07AVhvxTuOWq4Pn+oETtK8E+Jq1Qk6pkKaPyubO8w2XEuxcpSHvLwQrGG1Og+407PHldQPpJ7aqHVDbka0DbrHOFjBZ2Yep2/f4XaMUYi3BCy6JTNnFGWXQ34BF9PHs12lBFnHSeaWlofo7fj9QTxA3rikmZQd25RECheRNdyhcvDrVqr6inLPa7MAg4QVzDhzqjSh1woq4w/epU4YXq8Z9zBW0Z4j5QbkYnAk5GyoXp9DvbctFxeream8Q6K5a/fWh8zsirBXnhjxrPn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39860400002)(376002)(396003)(366004)(38100700002)(316002)(31686004)(16576012)(86362001)(31696002)(966005)(6916009)(478600001)(6486002)(5660300002)(6666004)(4326008)(44832011)(66556008)(8676002)(66476007)(36756003)(66946007)(26005)(186003)(2906002)(8936002)(956004)(2616005)(83380400001)(53546011)(781001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTRQcVNSTDd3NzA1d0pQSTRUNlU3STI1REEvNzJiWVhvUVJ5cTdOSHFOSkpE?=
 =?utf-8?B?dWJLYUJqdVhOeUF6bE9kN3hNVjloK1Z6WkpCSXFoeU9XclVrL3hMeDFqZ3Jr?=
 =?utf-8?B?SlgzWmM2TXBXNjRsSm5mWEExYU9mL0Q4UEZNMnhHYTlUZ1RIdDZRWTNueGZZ?=
 =?utf-8?B?VHVpMnhXVnYyUHU2aTFJaGtVSzJOTktzTEdHTDRwNTFOVmkvN0dOYnZBSWZi?=
 =?utf-8?B?SkZDTVBhaXpUdWp6Um5haXZ3ZEFGZGZsdzhoVEFrWkF4NEZhamtxUTdjWTVr?=
 =?utf-8?B?Z0QvWDNnVTIrOVM1d2dOTnlhRGJCUk95VzVSWXQ1Smhjb2o4YWtrRndBUDBD?=
 =?utf-8?B?bStiZjNERUV5dGp4eG93dC9hdDJ5ZTRucU9VWk5KQ0RIcHgzK0JuVkMrQ2tr?=
 =?utf-8?B?bG1yQ2pDVk5VaGRGbi80cXltLy8rU1YvTk5sTHQwRFRuYjNycjNydmEwTVlH?=
 =?utf-8?B?U1NJNmNadmdFVlV2RFJITzgzZVZyekhQZk9qWDBQYUlsMTNOK0tsRXBVbjdz?=
 =?utf-8?B?bmtQQWx5MldPcmRjL1BjN1pXS1N3U09iNDFRRGJtS3d0K1BablhITFdhNDJ3?=
 =?utf-8?B?VXJQYjhGL2FYeGZZdXk2YmpTWWkvb0RGMVNmamJmK2N0Q25ENUZXbVFnckdY?=
 =?utf-8?B?TUpZMXZFOG9xdUFoeTVuQWNsRUpKcElzeFZ2QjZEckRyQXJNQVU3RWk5bWRi?=
 =?utf-8?B?WkZWdmJaVmZScnZuZDRUV0JHRTVGWEo3T3ltU3ZhS053RTFWd0w4TlQrSU1p?=
 =?utf-8?B?VFpOZEhvVUg2K0QyYUljMit3MUpzdU94djMzdXd4VkNHRkIydm52NGV2Q0tl?=
 =?utf-8?B?S2ZSVWd1WDlPalRod3VlanlHWGhDQUlCMW4xYzFlamZjckZnVTRGNzBEckt4?=
 =?utf-8?B?SHdEd2VjYWRFQWJNdUZuRUJaQ2dQVUFiYjBtZExRMnNucC9wUXlOOGJ3bmpL?=
 =?utf-8?B?UzZGY2M4b040bzNtM1dVaWV1SUE4UTV2OUdJYzY3Y3E4ZzNwMXFiZ1IyWjRE?=
 =?utf-8?B?c2RwL3djOXVhZThaNUJrdm1pa3k4bmVOWitoUzdpSlJKTHBxN1FNNGc4R3Uv?=
 =?utf-8?B?eCtwMU5Peis3MGNIZXdrWDdmRTVoNFRZVldZNFoyT3JYbWVPMW9RNWt6cDM3?=
 =?utf-8?B?a2cwYXJ5N3RSTUlOV0pnNGpOcGs1dXBOVGpSYzNTUFNST0Q4S1R0eU1wKzdD?=
 =?utf-8?B?STdZa3lWY1VhcXlpc28wbjRCbG4vRFlJM0tITFQ2eDF5a1pxWjYvVStKNWhI?=
 =?utf-8?B?cFN2cVhBRTRjTU9hWmVVNEhlR2xYZTRBSm8vbzFzTEpreC9MTG5sWFBZTkFW?=
 =?utf-8?B?SlNyd3YrZkpEWDB5NCtyMWMxUmpSRzdlZlV5NDZaMERoTVV5RllGZit1QXFx?=
 =?utf-8?B?REZBbmhmeWYwQmpIUm96SzhLSEhKT2NFV2hDaHZnZ1ZVNW5kT1RyM0YyRFdk?=
 =?utf-8?B?RmVZNkZIT1crSHUySG5jZlFqQTduVExVZWl0a3dnbVkxSk1wNzY5TlBnYkVS?=
 =?utf-8?B?ZDIyTFdqakhZMmxjQkxIZW4zU2hTbnpuUmxTdnRNTnJ6QkR1eVpwRDYxYXp5?=
 =?utf-8?B?VmJqYUF2SmFQdS9SdnNreVZGZlRyV0lWNFp3N21uZmJoeERMV3QxY3BmZDB2?=
 =?utf-8?B?VWhHdFVQMmc0RHlaWWtINktxaHNsU3lJd1k2MVVVU05iSzRReWIvcE81T2F1?=
 =?utf-8?B?QVNJeGEyRkUzOFFlUUR0bTVIbWpTbVJrK1dzVmJPSm1WdTFwNDZZKythMDBx?=
 =?utf-8?Q?i6o6BzaxP2NjLlW1Enn1H71iya2sH5ng+CQJd5w?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d57573-9353-4952-c295-08d966218fdc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 10:34:18.5001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPhI+FrCTtLEEWxvYLkAIAJ1SbLvG+qchTFEF3PhGAWaGE+YYD3EU7ycwn5doFRkxyrQ/ma453U6ks2QNr3M4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4979
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10084 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108230069
X-Proofpoint-GUID: NrgwUBkkk41V37nBA1Gz4SYJblonknQz
X-Proofpoint-ORIG-GUID: NrgwUBkkk41V37nBA1Gz4SYJblonknQz
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/08/2021 23:00, Su Yue wrote:
> 
> On Sat 21 Aug 2021 at 22:57, Su Yue <l@damenly.su> wrote:
> 
>> On Fri 20 Aug 2021 at 16:53, Anand Jain <anand.jain@oracle.com>
>> wrote:
>>
>>>>> @@ -2366,6 +2366,8 @@ static int btrfs_prepare_sprout(struct
>>>>> btrfs_fs_info *fs_info)
>>>>>      u64 super_flags;
>>>>>
>>>>>      lockdep_assert_held(&uuid_mutex);
>>>>> +    lockdep_assert_held(&fs_devices->device_list_mutex);
>>>>> +
>>>>>
>>>> Just a reminder: clone_fs_devices() still takes the mutex in
>>>> misc-next.
>>>    As I am checking clone_fs_devices() does not take any lock.
>>>   Could you pls recheck?
>>>
>>
>> Hmmmm... misc-next:
>>
>> https://github.com/kdave/btrfs-devel/blob/e05983195f31374ad51a0f3712efec381397f3cb/fs/btrfs/volumes.c#L381 
>>
> 
> Sorry, it should be
> 
> https://github.com/kdave/btrfs-devel/blob/misc-next/fs/btrfs/volumes.c#L995


  Some of the Git commands stopped working. I had to run git fsck.
  Now I see mutex in close_fs_devices(), not sure if I was blind to it 
before.
  Anyway, this is a bad patch. I am working to fix it.

Thanks, Anand



> 
> -- 
> Su

