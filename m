Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87ED6489074
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 07:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbiAJG63 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 01:58:29 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10344 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235124AbiAJG62 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 01:58:28 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20A6lxAE014029;
        Mon, 10 Jan 2022 06:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=CDLiv55IxRj/7peWyPGwfveJQ6taVzzcypFDSg3t/5w=;
 b=bY6g/sd2uNLy0kd4In+RReBabDAq0QSJORxRFeLVQqksENWogiRPbnW8c3VK0QRJe3hW
 zC4vxtEfc89nUWYAX/jy/FwNn7ab6QI2CsNBgxx8njU6lr8t9KQuEQPVADC7Artp9Ghl
 MWIt5fWl/Xn9K8eUdTaMRvS0TExyzD+vWi3T77S/rfrUaFh4fmrUbnY3X8zbWqLaC4p5
 aJ73FcaIatXp2yFtJu3hRxsjBp+vdf1Nv9jit60wkJYiQ58On2pdFShAxK/lUX7hsNgp
 tRqT67S06H4u16eT5H5wOGB7tsiJHW1Lex4FwfYA5urZqXZFBbArgZc21UPynbbIkqn+ mQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3df1712b5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 06:58:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20A6tWJM173372;
        Mon, 10 Jan 2022 06:58:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by userp3020.oracle.com with ESMTP id 3df42jg01q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 06:58:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYM8TS6kchPhw/nDO0vg2glA2VGUKHDmMxLpI4wNPaJEiWUnOkvXs+ri1tfhg1BSmYX0uzuFK6dXh4cUxslUBrgpLrcQSah4p7kY/Mw4oQFEV98svjBqFC4xW5p4hX+4shh4W7EN2YLqcNg4W0Sq/r9HAeHGSaC3FpjVRgshaqKZo7APr2JqW44XiViSi8C5H1tDhTm5ePVFP6ydkGCatR2ebA+hVIz+VvtuSwr3mTOEbY/4I3qhoAXR19GyDbgsm6gSUlnKbmGP/21Q0goe5hdExzgVEoLx/uSB+A4qlMj1L1M7bSgyqF8Zc4sRpqLTxljCPSLYiREamt4JVGKBSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDLiv55IxRj/7peWyPGwfveJQ6taVzzcypFDSg3t/5w=;
 b=WhGyJHZPvNOtgNVybtLkFRD7xkCEIGn+/PmX9zB9RC46Mh3FhnpUl/IfjUfssrk46CLwYbcS/KQRigF2XVwfY7eISSTSOsPkYn/aIzz1e1EGgQ0ubv1TsX9F9HhItONmT+SnsQxD5YimLdHVd0u7edudo6l9jzGsuUF0n6og7etVGF9aRqH5RHN1Rv5a3HXcvm6N3i0IkwW9ZNn43Qi/H0p/wPQ1I2obfLFOa+hwOE7Nla7ESwahl6IqBc2HVFJmNcWqyQZNgzkdrw9xzmjLJkYo5oyp6/hgYd8KcGL9KJ4FlmxNJ9hZTzNMvvzJ/V9qokrf2H57qRziU08aGnbyqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDLiv55IxRj/7peWyPGwfveJQ6taVzzcypFDSg3t/5w=;
 b=Vo4byb1t7xv/46FOjxyUKy0GgmUzSjngxECcMi05YuHdmNlcimNskQb4WRlHnINDNMDkajJZLCHXtqLXkV/d1rH+8HLd0wI+inLtOdHBNC0ePuTTCBvw07ZAkTg0fwsK3QNOIjxMeBKe00edxQ31pXT8Y8N4pbBa6SutG36pngs=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5171.namprd10.prod.outlook.com (2603:10b6:208:325::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 06:58:12 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 06:58:12 +0000
Message-ID: <3b839710-fe86-e462-0dcb-b6c38adbb92f@oracle.com>
Date:   Mon, 10 Jan 2022 14:58:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v3 3/4] btrfs: add device major-minor info in the struct
 btrfs_device
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     josef@toxicpanda.com, nborisov@suse.com, l@damenly.su
References: <cover.1641535030.git.anand.jain@oracle.com>
 <6531891b2bcb2d68baf4e0cfbc37e6d9d614cbef.1641535030.git.anand.jain@oracle.com>
 <20220107162001.GN14046@twin.jikos.cz>
Content-Language: en-US
In-Reply-To: <20220107162001.GN14046@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0100.apcprd02.prod.outlook.com
 (2603:1096:4:92::16) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8864d288-af15-4f8b-f875-08d9d4069141
X-MS-TrafficTypeDiagnostic: BLAPR10MB5171:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB517175A1A7B87FF082AF3B95E5509@BLAPR10MB5171.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vH7EcN2UEBjkQxLUr1DRSwRDyCDkCliwlAPB1cz1xnNHeZ8YMraBymxe4SxEvYy8uZmW5Jj76hSv8rtXkoCAZvR+5udVCbQCP4B15OaRUl8sa+BmTXH8EKEsSC2hsKV//rJq/EHsQDxw+9e5MJw1npbRPOd1YAjtSkTAw+p7IBJObbTvkmIrAWTiIALmpYXB61ft9E715w41ChnO0gObLO8aRd75H9tZeQNWTRpaK6f7h3RSvzlmxW7aZ+nljHWYpwblLFgJw4EbO+UD6DcrhyPtRIQGcbHwVZn/6LfqhrwV/VXfA3ZMtEG0IIZshM8ZcfR/fLVXP1zDd1TIHafAbXh+Q55+FXDMe+XdEJqGbSuVH4jQeoCMVp5z/HLho1c6v/ACXYhGUSyrYh14vM4rj7vWesHyh/IOpVNlD9w/mfKyCkEZ0III+UETblNDVQZZlpss01/ZPCzY+xJb7Shfl5vvGi/YwtUI5DTCMu8mk8iQgFZE4mMYeWIQx3UGRuxgBeZybhlnh7uoNWimpL94IxIZ7qEgbYwQJ46XoFZdJPM0xkYgD9ObnT9kw9M6Oy5FYfYfME9Ju46TZN9DUOFJVjIg9mmcBEs3dWMsoU7znReOMbPl7A0kyDdK5TI6x5W6S9q5LcIfNa3TKXtdKiiPsj283URgeinPmYWjQKu7Tb5jPpF6mQ4sDOlgxpv7ygrxy1ZFrU7rdPYjV/c6vEJlH/3LsskJkZzw74TG/Fbd6HM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(4744005)(36756003)(5660300002)(6512007)(2616005)(2906002)(44832011)(31696002)(6506007)(8936002)(186003)(508600001)(26005)(8676002)(316002)(66556008)(66476007)(66946007)(6666004)(6486002)(86362001)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEVWNXZBNTBHUXpaTmExdCtxUVZQMUdrZ1RsbmNXeGxEUVFKeWwwYVR6aTNQ?=
 =?utf-8?B?VUtoRnlpUGlHNGJoQTU5eVdYdVJBMk0rM3Z5dSt6Y2JBVTkycnBhUnlaTzA4?=
 =?utf-8?B?REt3ZzlCSWZlVjJ4blh5V29Jb2xmLzRiWG9YVWpLOUExR3ZNbDdQblovRWlM?=
 =?utf-8?B?Q1FpczZRK3llZlAyRWF1c3JkSG9YTEhiTXlEU09sUDBpYTFVUmNqc0xYcjBU?=
 =?utf-8?B?RkdqNU53VlBRNGp1cUU4OFBhTFJvOGZHUDloSEN5aXRMay9OZGlaNE4wVjVR?=
 =?utf-8?B?Q05tNmUvbllJZkVBQWh6Rnh4MnRtWDcrVTBvNGVCWEd6N1ZNbmlXLzdXN3ZK?=
 =?utf-8?B?WHdwTU1xbmNHWkxuYmhxbDVnZWc2alNINzRmUVoxZGZxdjJ0b2VuQTg3RW9J?=
 =?utf-8?B?VVdCN1IyY1lzSUEySTNabktqM3RpTXI0UFFSM0xYZTJGcVdpY2gzS2JnUFZ0?=
 =?utf-8?B?Y2lxU3lhWkRmRlZlOWZldUVVcERJNXhTR1RxMHNkK3FHS2JxdkNiVWJNMHVv?=
 =?utf-8?B?NWlaN2NYeGF6dlFqdkh4cWp1OENMb1V6UzNoWXhFdGV5Rk5mbStFZUVHaTgy?=
 =?utf-8?B?WVB2cG5BU1hwQVJpcFRxS3BKL3NsUi9DTE9OOG1ycC9POGhleE44Y3JQS282?=
 =?utf-8?B?RmcwSkNET0Uxc1BuaTlSTEVrT09ObG9Ub0wvMEZVWGRPajlIZk9LNDd1WWM1?=
 =?utf-8?B?bDNGUGU3MWRVdVN0VjRBV2FhbGtxc1ZOMDZXWkdFczNIV1FLZjVMR1JFVUhw?=
 =?utf-8?B?UXdEQjBWdjNZWUx3b3AvRS8razJNY2hhbGZzZ1gvaE9GSGZNa2dXOGt0aFJz?=
 =?utf-8?B?M251OXVnYUFqazM1d0I2a2lKTmNjWHU3SGRvN0R6cnh2T0Jhc3NEbG81S055?=
 =?utf-8?B?eVlpaG1nWWt4aENCcmZNdzE5cStCZm1zLzRUR1N1T3V0TWQ0cEhzQXA3SmMw?=
 =?utf-8?B?dTRMOTVJMktiT3JBZnFZNGUwUkdERXF6MzRmMjdlYjFUdDVKVFNIaE81aGFF?=
 =?utf-8?B?UG9TMmdRNmIvSXNJcDU0MXozekRYNHc3SllUeVZoMlFubXNDemNPUGpRYTNo?=
 =?utf-8?B?ditGVnhmVG81TWlNaXZWeDJHZkhCNWVGL0JNMVlwYVhscU9vU0JSNWdObnRV?=
 =?utf-8?B?V3BIUEN0SDU2OHdpSXZnQ25HOTdJaVBSRHl1YUpzQnVpa2FTYUM1bVJKandq?=
 =?utf-8?B?bjhjWWw4R0hnQlFnSHhVQTBncUNnUzZVY0FsYjM3enZpanJhTldpeVpzUXhI?=
 =?utf-8?B?NEhwNytmWU5Ub09rd0MvaWVzSmpNRTkwT3RTWExDZ3JlN3dVcGVoUkQ5ZkJl?=
 =?utf-8?B?dFd6Y3FsQ0pHelE2eW0yY0trOHViRWY1YmtPRWZ2bS9XZ2NnNDVONHJyYVZk?=
 =?utf-8?B?TzhxQW5FT3U3bDhkWWMyUG1tWkRhWDN5VFAyMlgrSFBNS21JSFFHYXJXQUJo?=
 =?utf-8?B?ZVVNRFVJa3V1TnFPODJMRWlFMTROL2FrZFB6bU56bnhRZ2VFM082NFhNUG5r?=
 =?utf-8?B?WEF5RW5uMzNKM05oMlZxVnZDYUNpek1yL1FrVEg5a0QzMWtURGR5d2txZTQ4?=
 =?utf-8?B?a04wZS9ZM0R4K0MwSGJoSWYwcTlVeTk2c1VUZWdRZTFRSDdMRjVPU1ZxcEh6?=
 =?utf-8?B?MFBKT0Fnc2ptcS9OeTVUOEJ3aWxqMjlhenVIUFJVdTNsN3JRMjJuWjhYNm1w?=
 =?utf-8?B?SXNnaXJFblZFVE1VUmQwUmZJNUREc0VlbFBVV05oZjl4Q1p1Rml5YnlHSmVh?=
 =?utf-8?B?ZXl6ODY2WEhBU1ErZGFiemg5SW1zTWw3cmNmVDJTbWh6VFU3dE5OK2hWc2wr?=
 =?utf-8?B?MUFQcXF5OE9MK2lnbStoZk1CZHVIc29hcy9MWS9PWGdQTVl2a1pEZzMveEJn?=
 =?utf-8?B?Z0JOTHJINTFJcWZZRldJTXhUcVNpSGZIU3ZvbWdldDVvN2ZUMWdNZVRlcjhS?=
 =?utf-8?B?MFErVWZuT2FvMDY3MEdxdVptZkxOR3dySjcyS29ZL2REczZrRTd4cGxKOEU0?=
 =?utf-8?B?SFJKTFNITjM1RjZDcWxTUHpaNFVyY1RxZnhmV2RoR05DQ3FXSEpyTkZRVS9P?=
 =?utf-8?B?VnRYM0UxRmo1SGg3U0pZcU5MTnd6WmRCTG80ZmJ1SjdUbWFIazcwY2JBR2k5?=
 =?utf-8?B?VmQxRU9VU1Z3SlJlWEZqS3FtNHFKQWxDRjFFTDNHcXVOVzV6TTNjUUhuemZm?=
 =?utf-8?Q?TEi2fSJ05EhT5KezJrsAFvQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8864d288-af15-4f8b-f875-08d9d4069141
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 06:58:12.4997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lWINGVaRAP2vqmLwvho/dhP2O/kkxfJKHgvn2cuYBvY+lmB07sOwdpfwgFp6jlhvKafIGsEaa7Ml38k1pNlFng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5171
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10222 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100047
X-Proofpoint-GUID: IqGTHUFXilbsCs-Nr40GJ-I4pCqjhhjG
X-Proofpoint-ORIG-GUID: IqGTHUFXilbsCs-Nr40GJ-I4pCqjhhjG
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index 76215de8ce34..d75450a11713 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -73,6 +73,7 @@ struct btrfs_device {
>>   	/* the mode sent to blkdev_get */
>>   	fmode_t mode;
>>   
>> +	dev_t devt;
> 
> Please add a comment.

  Added in v4.

Thanks,

> 
>>   	unsigned long dev_state;
>>   	blk_status_t last_flush_error;
>>   
>> -- 
>> 2.33.1

