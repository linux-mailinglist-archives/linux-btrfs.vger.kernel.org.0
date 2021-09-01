Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA123FD52C
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 10:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242911AbhIAIUL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 04:20:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55870 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243084AbhIAIUD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Sep 2021 04:20:03 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18168E5v018611;
        Wed, 1 Sep 2021 08:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OgXCdhWuowPAASVrNCkydjacMnndXiTtvVPqosqszdc=;
 b=suL0IMTWseGicdAQWLsQ98JA5U4o9T8FDl5BottJ8OJL0pf9jbYM9dCr4SzMxwSwCv1b
 TLoTu5bxzka1A/ME8e9ApImhovqoddMiQtEyWwYt5D8dm7zADKsZZsTwANLZcCZ0XtTs
 VdLObRQzeOG2zdtVPKrzQTRMUDBH6/12SSozSYhlsCZDPCnzPKApyh88LzVPOf19xLgD
 jzkrlX4Hl8kq0Oqppt5qJVo4Keup6j49q5/veFd/0uLLqVckSiKXuPF41X9AgQceUWws
 HfT2vlEv2k0WBVsevKhWmFDqc15Gxvgw0Swhj88zsEKpA9zq9XvE8E5DUgCtqXJ5kUMv DA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=OgXCdhWuowPAASVrNCkydjacMnndXiTtvVPqosqszdc=;
 b=mn6XXhd06OGSimWy3czc5eaOFrk7LIe/OVU0ka1gdJ15wNgkUzSH27pYn+ztsBjQEOwx
 1i4jmki6IIGhFCZ6EfgFJ8P5J4zjFeihMRT/9JSxt+o/D+94UeIWyMlTEqJMJfb8+J64
 YxogY+FuV78XwF7QgVpGStP39sLysVV8//+W2TZJXN5fOX0pX7nn2jptcEo9odbZo+FH
 bCfoKsI61mz66QfR0ODNczsCm4kVsQyTbNxsrsF67AeM456Vuk0ZkzuFPvFbfrlfTdKZ
 bB96vPAsfuZcq1Eid8Hza65oOu5cXRfm3KRC1lBfzrH3CQQ3wZpyAcm+CvkJ467SGe4d PA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ase02bufn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 08:18:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1818FruY142484;
        Wed, 1 Sep 2021 08:18:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by aserp3030.oracle.com with ESMTP id 3aqb6fdb2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 08:18:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4qf+XwqYvl47YiH2+dEHGjGz/2t+eXQynG4n1cHSZBQmvFrokbnFnmihwQxsVIJo6f8UFn54KXzYV1Rxce2uf3YF5SymsKHObyIbwW/RobBqIN6krNyFMjdSW+Ifl5/v1rKV/syjed8uxGroycqXu73+8kxlE6WYl7kogAVQNqDeBhJ31HHbmI1oGNWYb6dKPgfbwPg3wJ6DrLTjEuQJrEtRk0JIWz8Nu6/Ud0NPgyYHE2Mm2klOjUKTRWuPDplPEnt8txzpY3ThWCiO0/o8HyzqgsPOBpI0aOH4ouJT3652O/OBnvrCbl+9RQJAg5g/GeAGVrMEoSuJ6bJo6p5dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgXCdhWuowPAASVrNCkydjacMnndXiTtvVPqosqszdc=;
 b=ecd4++Rv4Ryb24H5ORO3V9yvzWC+PTfnSFNc1x9qd/Sdf3wZZQnWF1cXAiCL1HNN9bLlmkusDT6jiBimL+Gq5rU6SV+pzfWE7kEughO/u2YabhcZ+sA1nWX3SHH/u6FGwsZmacMWJei57ERQwe4Pbhso9hvBacJyVrCID92oopcCL52uMaTLQX1R29IqohMfswgiOniqPW2c61onE2/7d1dupDE/2yQUSASAmHaf+Ab+mn02WHQVcTxS/WzD9Vvsu7UTIEJPuAFZfVFJi43rl4DiM+oLiL98T8Rgy3eAqTzRlAKhI0KB2eTz1mlve4uRynngm/46/T0lPoDU+N6zXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgXCdhWuowPAASVrNCkydjacMnndXiTtvVPqosqszdc=;
 b=yT8M6Gl+clM7kZRMdGBBlhjoxb5HJCuodd94UabkghI+Vyg379Z/bt3hOlxXOEmYajtd3flU5wbuuTdaThkpCev//xgf5DNESetewig9VJplYI6h662iR4FI/D/LOTuoxTeEC1qfJKKkeROy2Vm+R7YRrXmwdhr0P/lXqo6tvIk=
Authentication-Results: damenly.su; dkim=none (message not signed)
 header.d=none;damenly.su; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB4123.namprd10.prod.outlook.com (2603:10b6:5:210::10)
 by DS7PR10MB4846.namprd10.prod.outlook.com (2603:10b6:5:38c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 1 Sep
 2021 08:18:50 +0000
Received: from DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::99af:5f7e:6cb7:922]) by DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::99af:5f7e:6cb7:922%8]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 08:18:50 +0000
Subject: Re: [PATCH v4 0/4] btrf_show_devname related fixes
To:     dsterba@suse.cz, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        l@damenly.su
References: <cover.1629458519.git.anand.jain@oracle.com>
 <20210823194618.GT5047@twin.jikos.cz>
 <b0792837-0227-0404-315e-d4a5d7ca4a2c@oracle.com>
 <20210824161106.GD3379@twin.jikos.cz>
 <a3af668b-a91a-548f-4ec5-1104bd831a78@oracle.com>
 <20210831154008.GK3379@suse.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <27d0980b-6d04-ae45-701a-62660779b5ed@oracle.com>
Date:   Wed, 1 Sep 2021 16:18:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210831154008.GK3379@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To DM6PR10MB4123.namprd10.prod.outlook.com (2603:10b6:5:210::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 08:18:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49e3b70c-3bbb-4515-1cf5-08d96d212100
X-MS-TrafficTypeDiagnostic: DS7PR10MB4846:
X-Microsoft-Antispam-PRVS: <DS7PR10MB484621C380820C02D018D899E5CD9@DS7PR10MB4846.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ly1qAE0f2SQiKddciu3wH4CdOj3fHbsnJSs9iJmH2L++ovYbUO4J8fDoRL964LN9W00n8ENZda0siLSLlL9ZlNtwkQvJo2RDNf+qht1+07qSrFqFhhNP9jxXDwXt9Vw5AtcDo5aOEekzW5kdJQF0pvrOAgAAEUg4cyhMChaj+gXvIw0U7IQJ4WJbWgBgujQP3JSa4huqPmAgL4/qRynBa6ooF0ZTrb8/EqoRLw5eIzVL1EuV3copr2onFJz88FiFXCTDQGL8L9lXirO+Bvlm5iUKqlQt4niJWPu496urQlsywjfUK956YecHWEs+ydd6o1mCUZ6I/7WbhbNFVUXXdoC+5IdMCXgEHJJduS4tQjSm/i/yYVSzotDDioBpZjtTerdcA+1+U9K4BUPTuGUUpUW+b2iWnmzbcZy/fRdKqQ1neCK4JysmNSIj8RNrwdCItaKjAYuDRxS7ZFB/lrfTM7ISC5Gyd6w2iF44BxAz6IsT4vZe0nnjXnUWuMLD1gf1PaUtg+L87Y6zZMwtdkz+tVsvwvcMMh1epdRWPdAM4k/WPfPEbKTWwgjt1wKF4icb/0WNTwrdtnSXqZyLw2eybF5R6pXZDhMST3OKrsa3JYuYbXYUP1QRzz4Is5guLy4mjzezCOWu5o1UQ04gGHTlfztCpGO8R2mF2ZjE3eXiMaupVE/Fd0XqqlDpBm/qAvKNgHn5J3xAu4i0jyAO/49r/+vxoaoACb/ildxmPOYXKlxn5sYMUveKFFCxEvoxyBNMMB+LG2GQiUaTyrbMHpve9uow02PN+5LClHmnmzBShwl+JbqU1bCpNmskOBIpmber
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4123.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(396003)(39860400002)(346002)(2906002)(478600001)(16576012)(6666004)(66476007)(66556008)(38100700002)(31686004)(83380400001)(66946007)(956004)(8936002)(53546011)(86362001)(26005)(5660300002)(6486002)(8676002)(966005)(36756003)(316002)(2616005)(186003)(31696002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXVGcktoVVBGUW8wRWVBVUZLdGhJWit0dVJhZUhiWnkvOWtCbktnL3hYc1pv?=
 =?utf-8?B?blA5d3g0UDdxbW1HREw0cHB2ek0rc1N5Wkpkbmp0QitpMHNwQUxnd0lUbkt1?=
 =?utf-8?B?dkNRWDRaNklRNXVLd2I2VDduWWxUQnFwUnF0OHBma1FmL0JNcnAvZU9mNk5O?=
 =?utf-8?B?N1FlODBHbU8xZk0wNS91SVFDVUNFRTdHOW1DTndKR1NOYWxVRnFub0pmOXIr?=
 =?utf-8?B?eklHL2tESVZxay9IUzNTUWptTVZHWUJZN0VyNlUvT3dYRXRRR0tUU1ZvQTAy?=
 =?utf-8?B?WWUvQm9ZNWdySEpMNU5YUXJuR1F5eWNJKzI0S1NESmQyUUFiTWxQLzI1YlNL?=
 =?utf-8?B?UnoxcXRja1QvdTFvelh3VDNnR0pkTVJkdSt1TUZhd1ZGWEYxbmNmVDBnbTJX?=
 =?utf-8?B?MTR0eUpyZHZoaGRBQ0xyTUxGaytLYURBd0wrOGJhZjFCM0U0SHlQV2l2RzZD?=
 =?utf-8?B?d1JIKzFiVlJsV3FMRmRpenFkS2VTN1hFOFIvWXhVQVJzRGlxc25ZMi94WmhE?=
 =?utf-8?B?VzhsNE9ITzhsaHgwYTVaMytKcDVMVGUwU1E3K3REY1d6TWdQaUlXakJWemFn?=
 =?utf-8?B?ZmhnY042Z0dCRURqVW5KMFM2eWNxTUJjMkgvRU16SFNNRk05WXJIcW93VFM0?=
 =?utf-8?B?RnlIdmdvSXlyU3VtT204UGI0T0xMd1dvQmdLcWFPczB0MHZuOFcxZTVhbkdC?=
 =?utf-8?B?bEZ0aWczcDRwa2hnQ0Q4dlVEcURndXVJbHpvVjNxangxK2pIWjBFbFErZWVJ?=
 =?utf-8?B?bk1YU2puWmtMSCs0Qzh6S05HY3l2QVozbmRFeXNEOFAvT1VpdW9jd25yTzA2?=
 =?utf-8?B?SElFbzAvYlcxQk1IV3JJOGNNR0wxWENwRGpLVnZzSG9EUFdCRWVMejRIRjRk?=
 =?utf-8?B?VjVIZ01DVXo3Sms0d2IvTFNrQnVsMGUxMUdUTzJpN0FPVy84dTZOOWZHNnlp?=
 =?utf-8?B?bjRPTGFHbDFvWWlQRHdoVFhMWHM5MnFTbmRrMVgxYnVvY3VxdkhNV2ZzdnZh?=
 =?utf-8?B?anh3ZUZySGI3S2F4ZERwNGtYTFZvMzBKcDJJbkZsMndvRzRsdUlLYWM4SWds?=
 =?utf-8?B?a3gzRnV0ZDNSdFBNR091Kzl4QWFLRGFxd2NUZytsaXpERk9Fc2w0dG8vVG9q?=
 =?utf-8?B?UktQZGpvWExST0Q5VE5FZmJrS0syRndveEdDeGoyZWtFMUFFaDQ4WHZ0dkh5?=
 =?utf-8?B?MHM4KzQrdGRYakVhQ0IwQ3dickdqUTUwNFBXQ014djZtLzcrQ2htQTU1NnF0?=
 =?utf-8?B?aWVjY0ZNTDdnQWFoV254SzNCVEgrMjQyTmw0Yy9NSWFNTzBrOWFRUWFJTkla?=
 =?utf-8?B?NENmYklHMXUxaUR2blpzM1F0V1FKNDdMNDZuQi9hcDNMLy9zMlZDU0FrSGc2?=
 =?utf-8?B?eTlNM0NQQktRbzVQanZ3c3owUE11elltY2lMNXZpKzlYQy9UY2svbDF0V2pz?=
 =?utf-8?B?bzNYZER5TzV4ZHNqKzVIZHdLTGhnMzVVT0I0dEoyZGpVWTFXQ2dDSXYvRHh1?=
 =?utf-8?B?enhGQzB1QldiWmtkc09WMXVEUXlpY25RQ0thaW1ocmtjajZtZnNIL1BrM2RV?=
 =?utf-8?B?WmZkMXA0QWgvUmh6UUlMMWlueWFVL2dHb0E1OS9GZDNsNlpwQy83N3QvTUw1?=
 =?utf-8?B?T2diaHNrTjU4eEh4OFBCRWt0aTNndVJodzhINXlZZU9hdCtGL2Q3WEVoWDE3?=
 =?utf-8?B?bmFqSFpZNWJuR1FJY2VkdHhVZWx1L0pFWEp0a2xBWTBEV291MGxwYXRBWHZq?=
 =?utf-8?Q?BdL47fx9Yok7WvrnnyBx/bZogoyhaW5zbT+fJvb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e3b70c-3bbb-4515-1cf5-08d96d212100
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4123.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 08:18:50.6073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HuZbx1Ho/TQ4Vzik/8vbQ1PZpJ+z/s2VTzfRmFIl343y07hrIY9zpxyLa32JPcCVp3OvT2hxV1h1lHCg/qo+/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4846
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2109010047
X-Proofpoint-GUID: RaXDAa8PxQYbcWDv8ZveENPNyKkitxoF
X-Proofpoint-ORIG-GUID: RaXDAa8PxQYbcWDv8ZveENPNyKkitxoF
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 31/08/2021 23:40, David Sterba wrote:
> On Wed, Aug 25, 2021 at 10:13:52AM +0800, Anand Jain wrote:
>> On 25/08/2021 00:11, David Sterba wrote:
>>> On Tue, Aug 24, 2021 at 08:28:09AM +0800, Anand Jain wrote:
>>>>
>>>>
>>>> On 24/08/2021 03:46, David Sterba wrote:
>>>>> On Mon, Aug 23, 2021 at 07:31:38PM +0800, Anand Jain wrote:
>>>>>> These fixes are inspired by the bug report and its discussions in the
>>>>>> mailing list subject
>>>>>>     btrfs: traverse seed devices if fs_devices::devices is empty in show_devname
>>>>>>
>>>>>> And depends on the patch
>>>>>>     [PATCH v2] btrfs: fix lockdep warning while mounting sprout fs
>>>>>> in the ML
>>>>>>
>>>>>> v4:
>>>>>>     Fix unrelated changes in 2/4
>>>>>> v3:
>>>>>>     Fix rcu_lock in the patch 3/4
>>>>>>
>>>>>> Anand Jain (4):
>>>>>>      btrfs: consolidate device_list_mutex in prepare_sprout to its parent
>>>>>>      btrfs: save latest btrfs_device instead of its block_device in
>>>>>>        fs_devices
>>>>>>      btrfs: use latest_dev in btrfs_show_devname
>>>>>>      btrfs: update latest_dev when we sprout
>>>>>
>>>>> Patchset survived one round of fstests and I haven't seen the lockdep
>>>>> warning in btrfs/020 that's caused by some unrelated work in loop device
>>>>> driver.
>>>>
>>>>
>>>>> There's a series from Josef to fix it by shuffling locking,
>>>>
>>>>     Hm. Is it a recent patch? I can't find.
>>>
>>> https://lore.kernel.org/linux-btrfs/cover.1627419595.git.josef@toxicpanda.com/
>>
>> Thx.
>> It is the same fix I sent ~3months before in the ML[1].
> 
> Well, I've seen the patch and pings but sometimes the timing is not good
> and there's something else I have to finish before looking into new
> area. And device locking is something that needs full attention. The
> bugs/warnings in question weren't that important.

  Ah. Thanks for taking the time to explain.

> But anyway now the 5.15 branch is out and there are several patches
> regarding the devices so I'm going to spend time on that.

  Thx. That includes read_policy patchset as well? Let me know so that I
  can refresh/resend.

>  Also because
> the recent updates to loop devices started to trigger lockdep warnings
> that make testing harder and we're missing lockdep in many tests.

  I am reviewing the patch 1 and 2 in Josef list.


