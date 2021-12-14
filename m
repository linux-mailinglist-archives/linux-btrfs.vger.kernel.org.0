Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7184744EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 15:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhLNO1s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 09:27:48 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42596 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232580AbhLNO1r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 09:27:47 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BEEO3Ce004117;
        Tue, 14 Dec 2021 14:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OE/LkPr4NNWdlheR1XL+FXSG8lwesxLE+6cbLtFT4Yg=;
 b=WyBgkcHwnM1JVHcdJz1k1norvkTpzT+x9iCHIsHD4unmL4gKiDG8Vzk+dBOsakLBsPBB
 pHpch3Xsvi2eX2wv65KHSdeh2zcsJHQ+f7huqT494VQIY4txBl2+SKfj+v4BHkH3UXCn
 F8ttU9HehGCDvjwfnLwZhA3e0VSe/09z4h1TOvo0/WGfYJaACr60o0KqkJBLb5jXCR4A
 4rWBYWyk2W8Omn8JLjpbBM56gZmJ2fdSznpUe06NfavsGURIM1CczP1f/dhRCb/qQpZo
 WtzTadKHNiqd13hH0QF2khASQLHDKH3mc0VlBGbchAwsuI0riZhdcXQAnyTi4SxMpOf9 Bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3py3vpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 14:27:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BEEFpcv014403;
        Tue, 14 Dec 2021 14:27:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3030.oracle.com with ESMTP id 3cvj1dxwwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 14:27:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8rlZ1eodqu06Ga2iYdT6RgjHu2XDDwUOBek3MImx0Ob2zak4ghLPXcTnHR00zfuNRzpl9bmu7mIpdZ4qN1P1HWIOElpd1Fman8eAP5+YlfJYaMRy5yzZtkaiwj2nHq8Gwvi/7MsEhsGgo5Au0M61DuFrQARV+BlxOP6X7A92fEJB5WyrwQfDA0VV9QZljyyiLK27WnKPwSuhZ1520ATg7E9w2u9aJSMU5v8TsH6b5n/g8hnLsiDrZA5O6LUtS4yYaz7tgUGeBvxTMUng9VdpFxJiAdkfqjUhLEr6uaxBHe9GKlHAVZCgUHOToOTuN95oJIXS2r5H9UKa2G2gnxwgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OE/LkPr4NNWdlheR1XL+FXSG8lwesxLE+6cbLtFT4Yg=;
 b=I9tZV961Zil7/AZJh/SykAhb2/qRG5p18aAK/WcyJUAWr9psAn6ydat9jn+97PvE+qFw8jiNn3WEb2Pix+HH/LpoE9Nhgn/gquOAen+7nwDu8yrRDMOW6ECISbRhhWbGtPN8anOjtWgYZ+4vZwBRUuZm6tZjJ1B9kJYJc4yrqo/g1SBXgDrahO1YpKeQhnGkMSc+fr6bz+3GaMx1z2v4o9TKWZUNq9qk3hKJVFmH61oqdUYTyv+tXNrsdX/AVmVjs7IKjhe95zi8KS9bLReAMYQKm1KvT7kxNPkvWw3UDnBqt5LZO8h3fiCczZRZ1IDCPwPPIRc8FYcYqtTgu+FkqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE/LkPr4NNWdlheR1XL+FXSG8lwesxLE+6cbLtFT4Yg=;
 b=oierCUKGmKxKRGAKpT+9PUy+4KclBN28vSPUIMrqRCoojEg9EncrOv9X/Wksz7VqrZoXqTYm/YPLwWZO1BHrAdNtIYvBaTlqr1Ic9V2qSVRPxwNYPprrVDMP7htVn6LIC/BH362vCZso1cSLglk97rlevKDlI9eLwxmmULIkWec=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5155.namprd10.prod.outlook.com (2603:10b6:208:320::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Tue, 14 Dec
 2021 14:27:40 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 14:27:40 +0000
Message-ID: <e3623dbe-bc06-cb04-24de-f680f8df61a8@oracle.com>
Date:   Tue, 14 Dec 2021 22:27:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 1/2] btrfs: harden identification of the stale device
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
References: <cover.1639155519.git.anand.jain@oracle.com>
 <612eac6f9309cbee107afbbd4817c0a628207438.1639155519.git.anand.jain@oracle.com>
 <12c701b1-d8c8-e645-201f-ac5a411ab03f@suse.com>
 <55ef44fc-6293-50a8-db5f-914226e1a89c@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <55ef44fc-6293-50a8-db5f-914226e1a89c@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f16532a-202c-4fef-9d5b-08d9bf0de1fc
X-MS-TrafficTypeDiagnostic: BLAPR10MB5155:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB515544009ECFB5358A89649EE5759@BLAPR10MB5155.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Gkxu2R/1D/6ccwalL0N1UiUYp0sh9TNL2oa1ChUlrgb7nXESreOma6CpuIB0pT907YXB+asOKw61jrnQ6ErGTYzChE2WWsa66TCwugYDPjtYAPCSRL63Oe/BIqinZ6J4L/r0QaU6z+9q4H8n7HcpaWElOlLXiXVm6kHiXOi0SJO8QGWtlZm4kFYwyDLy/Khhvy8r7lgAg2rHTeVtOnSmg5s913KZEUWU/A1TncWbIHMgdTjGgbmUEl8uxvfkjhA/jGr5PF/KcpwaR/dT/y4PDPqSq4KQiumrUXHMjs2QUw3/r1PwuSR3Ijr1jHSiBrvk3BJL/F9wjz0uWlH0WM1aMm3L6W80+7iXDce1F2QXm+ty2f8Z47kf5mEDx9MV/llUTyIZ2lHnZRcU9YtzxucLKDy/z/UAF3u3nTYp9VOtFNDU2pMrtlwAiCelSXRuIbhtlMt5dvKi+07/1bRIOtf8wzJd3XfuEeBEDQVrr2QV/XBoqVIyYErp7OQkVKsPC/giiZiNsETZlZvjP6q9dhDinmMJPzDB5bQQDt1G3mwlAPG0ehkFURyD48+wWSgeT6098rNdBNIKCkEX6tNMsHLaansiW6rlQNy9B1PEmzMlACYSIMbdmZ1VRGJo8nu35llh1dSPCt7sXcf3nbjNl+21hBH2bt2maIjkFLVvUjMmXnvZ4r7LhvyWa6HFr/Ck0+jtK1ccnlWucE0orrKIiaixSra8zvScKuaYnMXm8a1iIE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(31696002)(6506007)(2616005)(26005)(36756003)(6512007)(4326008)(6666004)(31686004)(8676002)(508600001)(316002)(83380400001)(53546011)(86362001)(6486002)(2906002)(44832011)(66946007)(66476007)(66556008)(38100700002)(186003)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U29qcjJMSGplRUVCUUxVN1pwdGcvbXl1RkFJYXZPamNyblJzQVhNS0dpYXB4?=
 =?utf-8?B?WjlXaWJ2eWhSaXFoazRYSVcybE1CY2RPcTdBQzRCczZqajZqajJhWDJhRzJa?=
 =?utf-8?B?VVNJQVEwMWR6TXJyaTJIb3diT3NzVEQxeW9PeFFOVEMwcmh1N1ZuVXYyRm11?=
 =?utf-8?B?SFBWZXpNSW56R01SVXVtY1RheVNaeUdFdHYzN0lybUJJdHd2QjBrVDRRclNk?=
 =?utf-8?B?bDdIY1ltK01lR29OczVHaXdjZDNkTGMwUitkRUFTczd6UEUzRzk2UEo2UVZw?=
 =?utf-8?B?OEt0Vjc4UjNXZUVYOTBLVXlwK1ZOc3dNV2NZSmo2OEVNSW1UWDFYME5NMnZX?=
 =?utf-8?B?R21VVkM0YkprVlJXQzY2YWFuaytDdm1KOVkvdFFuU3NZQk96VFRWNWJxUmx5?=
 =?utf-8?B?ZlQ1Y05PTTBmd3k5RHh0WWo5SXo4V2lYSGx2Vks3Q0hGaUxHc1pqcEw0Q0lN?=
 =?utf-8?B?ZDRtMEQyTUZhR3JnRTY3Z0Q5TEJDcGZVczl2Z2l6KzlVR1V0ejZaWG43WG1T?=
 =?utf-8?B?NndxYUlpOUNhNzB5TjZ2OFFjVDFEbm5NL0RsTjFNY1JYVnNtVEw3MVp4VjZm?=
 =?utf-8?B?VGZSK3VMTURsckl6cGdJK1UxeVk5M3pJTUFGTVNsS2wxdyt2NkcvOWo5VUxR?=
 =?utf-8?B?cGR6bXNvUjZhellvZzJZNEc0STlVbGg5TnpkejFuUG9TRGp2cTZOSjlKMkpK?=
 =?utf-8?B?QldhUnZYOW1FNmtlbmdRL1h2SEhiczVIS1RFNldTTEN2Mlk0d1oyaFpKMzlv?=
 =?utf-8?B?N0JtMWpxOFk2MWdybGlEb1BqT1FISXlFenhDVUJPbm1sZ21vTjVXYjNpc2RI?=
 =?utf-8?B?QkY4bFdneXVURzBEOE5MQmp5Ykl5WXg2N3ZvcmZJRUdtaGUvM0Q5WFU0dDI4?=
 =?utf-8?B?K29nS3EvWi9GbFhhOXVuaHNMMUF1anZpVXI5RmFBUFBNMTI2R1o4aFJ3QjFn?=
 =?utf-8?B?YlhrLzFzTHp0MzJsSTQrSXo5Vjc1OU5ndHBJVjQzN2FoZ3oyUWhpN25MSDda?=
 =?utf-8?B?TmNxNG5Ka1dscXlSRllYK1lnYXRwdVREYXEzTlFOUzRJRHJxQ2ozTzFjbWVY?=
 =?utf-8?B?RUVYR3A5YVM1OFNpMkYrN3RsZzZPNENJOFdHYU4vWjQ5YXhIOUNpVHB4SmJl?=
 =?utf-8?B?OFlHM1NHZkx0YWdiUkl2SnBmMW1XeXdyTnZiQXhCNUttT0JhcEVqMTVDdnVw?=
 =?utf-8?B?SFRKSk9iUVM2QnNZcXkyeU5jYU1JTEZzQjZ3YVFxZjh4OUtIYVhreVE2KytV?=
 =?utf-8?B?RUVyTSsxdGRxN0JkWTIyeGRRTmZiMCs0YkdVS3VoWUl5enZCQUxlOHlwYjVY?=
 =?utf-8?B?VVhha1ByOEMzQ0ZsWTlaZW5nY1YxMVY2Yi83UkdncW1Lcy8rMEYwMHdMeHcv?=
 =?utf-8?B?TnFpcHVhZ29ZQ3RtUzJESDRlUDZiUEZkdlhEVzJzcDVkUHYzdjZMNnpvTDZs?=
 =?utf-8?B?U3JlNTcyR25OQVBxb0RrYllkZ00zM0FmUWxUbGlXZVRKS3YrNktQNm9HSkp0?=
 =?utf-8?B?MzNJYmNUbDVFNm5TSjYwbGlNVHpzYk9LbUxIM1gvaEUrT0JBUVNWUXlFV1Yz?=
 =?utf-8?B?cnJyb0lXMUc1dXE3Y1o1Wk43bE1oS01YK3hVWUtQUVpEdFc3Qmxtb3Y5VmJz?=
 =?utf-8?B?LzM1c21Nek9ZWElScEtVc085NTlENzBLMXFsSDBEcFlvKzl5U2R6c3FSaFQ4?=
 =?utf-8?B?Z1hmNjd2eTd4Z3N1VlRBTUZBMXhGSnM0clN1cmU0cS96K3NLNkdvOW1SelRF?=
 =?utf-8?B?RmxvSEVBWXlJcVI5bDllbWZVeXBuL280RUN2K3lFWVpYRkEzNGpFRWlpR0wr?=
 =?utf-8?B?bFh5RHd2Y2VnUmRReDJCdXE2UGRKcDkyQmdNOG1GTXVOaUhIZWp0S1VvS2p0?=
 =?utf-8?B?cERnVE1MUzJjd3VWUnRQVmFyVi9GaURxV2Y5YnE5VkExUmppSndYYkNVL1U5?=
 =?utf-8?B?eTcwL05pQkRpYlI3QVovdE9FNDlxYmNsZHRsWGxVRDNiVTkrNENvaFdVUFJK?=
 =?utf-8?B?RVExQ0x3RlJMUHV1ZzlHdG5TS1hKMnBNYzdjWVQ0c1VKMTBPdld0MnhXN3RK?=
 =?utf-8?B?WW9UbkJzV0NFU0xuT3hNVWp3UW9MbDNlUHVDT2ZveDBoM2pIdk5naXZVZ3FY?=
 =?utf-8?B?Q21NZ0F2VVRaS1RqTWtKMGdyZ0kwc3gzWkxqNXBPU3UzWmlkbzRnT0J0K0Ro?=
 =?utf-8?Q?TYm5o53VBovfO30d4T1r1TY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f16532a-202c-4fef-9d5b-08d9bf0de1fc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 14:27:39.9994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFqbQ+vyYmfsTwe7o6sAUCXXRqcFiKS5X9pcMyUNcMbdUwrLKzMBmEFQbxWmB7G39E7rsbdcR2/YnTTTxpQ5DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5155
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140083
X-Proofpoint-ORIG-GUID: F45i7Q_mGzrnXA2y3coJ6RCZLWP0_fY7
X-Proofpoint-GUID: F45i7Q_mGzrnXA2y3coJ6RCZLWP0_fY7
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13/12/2021 23:14, Nikolay Borisov wrote:
> 
> 
> On 13.12.21 г. 17:04, Nikolay Borisov wrote:
>>
>>
>> On 10.12.21 г. 20:15, Anand Jain wrote:
>>> Identifying and removing the stale device from the fs_uuids list is done
>>> by the function btrfs_free_stale_devices().
>>> btrfs_free_stale_devices() in turn depends on the function
>>> device_path_matched() to check if the device repeats in more than one
>>> btrfs_device structure.
>>>
>>> The matching of the device happens by its path, the device path. However,
>>> when dm mapper is in use, the dm device paths are nothing but a link to
>>> the actual block device, which leads to the device_path_matched() failing
>>> to match.
>>>
>>> Fix this by matching the dev_t as provided by lookup_bdev() instead of
>>> plain strcmp() the device paths.
>>>
>>> Reported-by: Josef Bacik <josef@toxicpanda.com>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>>
>>> v2: Fix
>>>       sparse: warning: incorrect type in argument 1 (different address spaces)
>>>       For using device->name->str
>>>
>>>      Fix Josef suggestion to pass dev_t instead of device-path in the
>>>       patch 2/2.
>>>
>>>   fs/btrfs/volumes.c | 41 ++++++++++++++++++++++++++++++++++++-----
>>>   1 file changed, 36 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 1b02c03a882c..559fdb0c4a0e 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -534,15 +534,46 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
>>>   	return ret;
>>>   }
>>>   
>>> -static bool device_path_matched(const char *path, struct btrfs_device *device)
>>> +/*
>>> + * Check if the device in the 'path' matches with the device in the given
>>> + * struct btrfs_device '*device'.
>>> + * Returns:
>>> + *	0	If it is the same device.
>>> + *	1	If it is not the same device.
>>> + *	-errno	For error.
>>
>> This convention is somewhat confusing. This function returns a boolean
>> meaniing if a device matched or not, yet the retval follows strcmp
>> convention of return values. That is make 1 mean "device matched" and
>> "0" mean device not matched. Because ultimately that's what we care for.
>>
>> Furthermore you give it the ability to return an error which not
>> consumed at all. Simply make the function boolean and return false if an
>> error is encountered by some of the internal calls.
>>
>>> + */
>>> +static int device_matched(struct btrfs_device *device, const char *path)
>>>   {
>>> -	int found;
>>> +	char *device_name;
>>> +	dev_t dev_old;
>>> +	dev_t dev_new;
>>> +	int ret;
>>> +
>>> +	device_name = kzalloc(BTRFS_PATH_NAME_MAX, GFP_KERNEL);
>>> +	if (!device_name)
>>> +		return -ENOMEM;
>>>   
>>>   	rcu_read_lock();
>>> -	found = strcmp(rcu_str_deref(device->name), path);
>>> +	ret = sprintf(device_name, "%s", rcu_str_deref(device->name));
>>>   	rcu_read_unlock();
>>> +	if (!ret) {
>>> +		kfree(device_name);
>>> +		return -EINVAL;
>>> +	}
>>>   
>>> -	return found == 0;
>>> +	ret = lookup_bdev(device_name, &dev_old);
>>
>> Instead of allocating memory for storing device->name and freeing it,
>> AFAICS lookup_bdev can be called under rcu read section so you can
>> simply call lookup_bdev under rcu_read_lock which simplifies memory
>> management.
> 
> lookup_bdev calls kern_path->filejame_lookup which does an initial try
> to lookup the name via an RCU but if it gets a ESTALE/ECHILD it will
> fallback to a full path resolution and that *might* sleep so actually
> doing the dynamic memory allocation is necessary... Bummer.
> 

Yep.
Also, the device_matched() function might go away in the long run, as I 
found it is a good idea to keep the dev_t in the struct btrfs_device 
when we open it.

Thanks, Anand

>>
>>
>> In the end this function really boils down to making 2 calls to
>> lookup_bdev and comparing their values for equality, no need for
>> anything more fancy than that.
>>
>>
>>> +	kfree(device_name);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = lookup_bdev(path, &dev_new);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (dev_old == dev_new)
>>> +		return 0;
>>> +
>>> +	return 1;
>>>   }
>>>   
>>>   /*
>>> @@ -577,7 +608,7 @@ static int btrfs_free_stale_devices(const char *path,
>>
>> What's more lookinng at the body of free_stale_device I find the name of
>> the function somewhat confusing. What it does is really delete all
>> devices from all fs_devices which match a particular criterion for a
>> device path i.e the function's body doesn't deal with the concept of
>> "stale" at all. As such I think it should be renamed and given a more
>> generic name like btrfs_free_specific_device or something along those
>> lines.
>>
>>>   				continue;
>>>   			if (path && !device->name)
>>>   				continue;
>>> -			if (path && !device_path_matched(path, device))
>>> +			if (path && device_matched(device, path) != 0)
>>>   				continue;
>>>   			if (fs_devices->opened) {
>>>   				/* for an already deleted device return 0 */
>>>
>>
