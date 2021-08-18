Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DCD3EFD1F
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 08:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238080AbhHRGuS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 02:50:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53118 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238791AbhHRGuO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 02:50:14 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17I6kKJv022770;
        Wed, 18 Aug 2021 06:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UIZ6GQLI8urJEqYivt/YDOENvtwIqiudEKUh8iWpWhc=;
 b=cM09ubqGK9qB/KJ9BBnd5CWpaDgVj1LEuUH2MkWepKR06uuffDvm5ij+qJ04g8iKnsyD
 Xn9ie5AkUz12jXzB/yKFm21/piXc/UlAWggFnOCc+sCrw7l79JC4qNBb78+aGP6VjTKZ
 28vOs9SwmsWXRgkFaMjQeHkIkJnUOFPJfRDFinciv7eKw2Mx6qhLIJReW+mq3ey9nyzO
 8LH/CipsfEbGcH24davjKPbMnjQDGE6kLUrfGur1x5jLR0uKgIuIfXzVJdr1O9HPBlDj
 AtpY09WFKcBptiPi+IIBJNYE8kTAt7yeMXDJOQ4x3YkHNJz4KmFsRJU2i6SAotPCquYt +A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=UIZ6GQLI8urJEqYivt/YDOENvtwIqiudEKUh8iWpWhc=;
 b=CRUX06E6YNg2eGzMVWB2OGD228tvgIL8wtombQLO5X3xdKf3rRIlSdnh01cPZJ43E+JE
 3/Qm7OyUEXwYjKAS5ujvtIMl6N8At0UdiN01TjGAIG2+dvoE0yAyDSLH2D8qeVJHNNWX
 P1xk7YU+41fgpO6djDqS/tEvKfUIhBUVok+ViS8Vmxipv3qxBQZvd/yTq6v1w4ziWU2n
 yRxxzZNFQV9IDNWEx4XtCsJaY/2/anFAvkpYCtr0yNnfWqlH3hwUgsffwZWE/SMGsVy9
 YTYfuxojli4fum2dZGUPGKBnhmXByg5z2ZhlsxonKZmgfRnnmGaG9hRvXatj1R6nr3fO 5g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agw7t006y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 06:49:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17I6eqtP133354;
        Wed, 18 Aug 2021 06:49:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by aserp3020.oracle.com with ESMTP id 3ae5n8x9th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 06:49:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEstHdXmcIgZK8mvaCxjOdmbYvGg6kwJD35mFvGmTs0c1ln7GY9e93qmnzKsltTpchoh3UZvuajvBvrt4N88FltP9z1tEbwJvDMipbpAyLme452nwRjM/p884nc6uWYHaIMSKAVmy/5p9snWJr/10FslWyZvhvjkTCBYwt8cQxpXhMoVJdpDjOgSvO5aBk0p+jVoyhVhTQ0YWYVMxBRPP+ZE+7oZKZu2aTCnHrvhOXxfJ7pw0DgBA8tfzoJGNAv8DTu4jpzuZtsCd7imOM1nRxBvsQcbDLDfmdTAabJ+QnwxBt+O2gbnDT4yGI5QjCByIOFf1rxDT6810rV7kOuKNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIZ6GQLI8urJEqYivt/YDOENvtwIqiudEKUh8iWpWhc=;
 b=CRb6noch7jdszbcKqJQNFGd69Je9dTjnxBZcxDmFMmL90tRLBRa/UvAtMtRQ2wMamc4mxTJbApec8oXiyYLjnDS+QGiVDd6gwvR8Di/a+V0beIF0Mqcu42O0Tms6Orggkw1iiPHFml1dzFbKu9oBjhaz80lNGNEDlYgZErV+mtCMRliiEO1DtI7Z1re6FQIe2POFPNZScdb5hdaTxmRGGv4JZ2tvOlAQfy9z0ZD9o0OBm/QeVBP+PoMNCnuqhfRKvw69WbnZ10vgizAbxW9rP7KfkJhhgfPTdUPEEQYGL/FQW5l8l0ZGkQ0yfn0f7Spofm3dTWfLxZrFCFgbc985BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIZ6GQLI8urJEqYivt/YDOENvtwIqiudEKUh8iWpWhc=;
 b=uAN6WulPf6FXaSL/5btlcJxdTbt5IgW9XxvIjaImFWEGnmcBkgJQGCv4y7slaTXGv2sYQahzA6bRWImft3uyslOLSBHTQYq0WTx5Z3oypMvndB7/NPU1Vxi/G3H00qPcJrCOjVQTOa1YVeBeIckQ7pghyrNXyk4GUwPRxfaheZw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2914.namprd10.prod.outlook.com (2603:10b6:208:79::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.21; Wed, 18 Aug
 2021 06:49:32 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Wed, 18 Aug 2021
 06:49:32 +0000
Subject: Re: [PATCH] btrfs: update comment for fs_devices::seed_list in
 btrfs_rm_device
To:     Nikolay Borisov <nborisov@suse.com>, Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
References: <20210818041548.5692-1-l@damenly.su>
 <ce1a0cc1-b616-36e3-8c58-4edde5f924cf@oracle.com>
 <a8f575fc-2741-6379-5b89-62353a54cc8f@oracle.com>
 <548ca0ec-4a57-3d20-cfa9-39521560feb7@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <436a36bb-b2bc-1b15-08ab-3782fcb4ac81@oracle.com>
Date:   Wed, 18 Aug 2021 14:49:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <548ca0ec-4a57-3d20-cfa9-39521560feb7@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17 via Frontend Transport; Wed, 18 Aug 2021 06:49:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b88b08c3-5d30-46c5-e484-08d96214557e
X-MS-TrafficTypeDiagnostic: BL0PR10MB2914:
X-Microsoft-Antispam-PRVS: <BL0PR10MB2914B99C0253068D0AF1ED33E5FF9@BL0PR10MB2914.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:605;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XmChv7dZ0G6iGBxb2I8UiCH/TIsQQEnGQ55m4JpXh0/vs7mI7teLUf0W3gTbLuwytz1mrSyUvxt5FxCmQx6b4BP29xj3gHc9lTM1FcXavkKRIBRUxvDglfixmNV9ydjabdfrEnJ2Ug0cRh4iJ6HFxIotBfoZiS4QksQQTF2gYyhgNdpS1urvNG7rN0pO+znK9SaiqxcCGcbxA79NTl4touvQxHs4gVA1x2ipRFUOGsyn+rDrbEpK7lWv/CIIcMKHb698EEBAMLmtwlQK5IkKwXL4rp4c8Lsi2r7zZnQQULU6/XTPM3SeCgQ7cuWlNcYFX9zZ0NK5QjKnSJalpqosqSgdvyh1+6b9+CEUKM8bg1zXsvq3XczPCmKraFd6yczTwk3S6KeK0XsRHZ9Ioeoha5W+BVKw6kAQWJG6L0kfAPusobm9d8FdYVpQIpFYTPFw+lWr0vX62gFCMPxhFYudGqDk8D/2Ax63ceg+NiC+/+dRCPlBRQaTlDeoyJDoFNphs6czAabjjLmv9mPmhuVWNYDUfI9Dg2lWBMNPcd9QKDqgTgMJql+UIB4R2JzbsQFZM0kgWrpUmRCy8bBiU4/1VP6z2IKrQnjU17VALBSWD1+5vN0XVuiJUiJqXTdOvpCjDFzRD88CCOD3Ij5JyXFcCE4rDgqgi30xwtLIVLiXxRa0MJPQyItrKd3k7+dbI6EdZtkRUHqAayBWs8G63RnW5CoA4PZZtL33JsA7exvQfZYabsnrw3XCirZ0kEhXXMCO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(136003)(396003)(346002)(15650500001)(16576012)(2906002)(6486002)(53546011)(316002)(6666004)(956004)(44832011)(66556008)(8936002)(2616005)(31696002)(8676002)(86362001)(478600001)(31686004)(38100700002)(110136005)(4326008)(83380400001)(186003)(36756003)(66476007)(66946007)(5660300002)(26005)(781001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3NsRmQwSHI1TGR1TERMdkdLZTRTVllOTWphZ0wySENSK2xOS1lTY1RjRHI4?=
 =?utf-8?B?OEhOM0I0NUVMT3dpMEhXVnJsYVZ0TGpaMld2SkNvdWVDaTY5emxQdUNDbGtr?=
 =?utf-8?B?dGYzUlVEVDg1RlpZeXI5YUZXYUpKRVN4eTZ5SUFybHpuOVEzRXowMFdMQWQ5?=
 =?utf-8?B?bDJtdHk1YTJGeVFFYmtCQnIrSGpLUXJibmlmUVFoWkpHQStKUnR3a1Q4R0Rv?=
 =?utf-8?B?cXV1MFN6dVU2aG1sRE9EalMvV1J1dmo1dlRTZThMTjhUS1NrR2FaTU9PSFNZ?=
 =?utf-8?B?SUhuYXhEZ3pxbWRIbVhvSlhCSFVFSjFLeWlITDl5U1NkWk0wc203YlRibFdS?=
 =?utf-8?B?dWowdEk1L2UvSE5ZOW5UNFJQUGkzNDZJckcwbFNnYlk1SExXTHlINkdHZjZs?=
 =?utf-8?B?N2hEU051SGlNL2hwY0lvUnowVmxvOHM1ZDVOREdUL2psQ3dyQzdYalJuNFdw?=
 =?utf-8?B?VFByUndBOEYxQTBiZFVWWCtDSk15VHJDV3BhNzVSMnUwdjYwZ3ExWkJndFFD?=
 =?utf-8?B?Q01rTFIvWlh1Nzd2ZVVDZXF6L0NhYmV5TS9aRjJEZ2FIY1o3MlBqaTduNktM?=
 =?utf-8?B?UEVUMFJSQUNTbEZWd1FuL05jTG5tWGdFVVFYcXJ0Q3M0cXcwalpUSG5rVnpr?=
 =?utf-8?B?N01jci9UL3UzN2wvYWd0VU50MWlHbjNjdHB4aVN2TkVIcUxROExVcnQ1SE5u?=
 =?utf-8?B?Y3FvNTVpclQ4Z2tJMTUveDYvKzYxN3ZVM0cwMTNHelRLTG51aGdXbENnWXRt?=
 =?utf-8?B?Vit6eTZvS2p1Y3NheUFMYWJsZWlLdjhHWjkwTDMrUTkxUGFMem13Ny95Vll1?=
 =?utf-8?B?b2FuYjlPRkMxTXZLS0hWcHhpRzgwM1FsUTVjbk5XeVQ1bisvTU16MHBXZXdi?=
 =?utf-8?B?Q2RxQk9Ib2lXUCtNckJBOHBDZmw0THBUODlzcGIrQm1ub25Nb0xjY2JUWTlN?=
 =?utf-8?B?Mjg5cjRBZ2RYUHhZaHNNeWhVY2l5RGZPN2N0cytPeXFhV3NwTmNISnY5VmYw?=
 =?utf-8?B?cGFUM082TXlkREk5ek5FOE1NaE5VdTc3c3V4Z1ZQNG5xRjhOWEM2N0lSNERn?=
 =?utf-8?B?bzlPTzh1cnkyWW9XaXJsYXNTbUx6TENLNUFUSnhsczg4V2N2OXNCUms1cGNp?=
 =?utf-8?B?N09GM0RFRUVPVlNaRmlOZFRrOG04MjhuTXpCZWhFclRqNXFFanFkWVFpMEdz?=
 =?utf-8?B?bGlrWUtEaWx6emlOV0p4MjFGek1vTjVlL2FNZjQySG9RYVJBZHg0WlZoSmNv?=
 =?utf-8?B?Nko1b0hMSlhVYjFTSGFPcU5yc254enZBSHRFa2lrVzhxYTROR0FzTDNtQjZS?=
 =?utf-8?B?ckdhNkcrL0hoYUZWUm9KK1ZPN3lESnBQWnZNcUJqVHFTNjdQWHpoTE1jdUZu?=
 =?utf-8?B?VTRiVGkxZkdxejJwZkhNOWp2Nm92YlVoSzhWMWNweitQTXE0WjNHR0tSMk9I?=
 =?utf-8?B?WndqMHJHdkxpcVlTaGtqSXVDNVNXU3dDRXJEcmNHS3M4dUFGYlVRWkdWK3Vk?=
 =?utf-8?B?a0dJRTNoQ2N6N3djWlZud0xiT0lLVkhMTDJlWWthRXpxVTRmT05sQ3VsaFlO?=
 =?utf-8?B?Mm5xeSsweVNGMS9XNHl1bDR1SXVURUVWTVgrNmhPVVNXckJQZ256aDVTYTRD?=
 =?utf-8?B?eGVDMnlsTGkxekQxV0YrUmNiZ28yM1JGVEhDb2ZkMncxRlRWR2RCUU9BdWVX?=
 =?utf-8?B?MHVEbzhPeVlqakRsckFUT1hXbUZEQ21KS0RpbjRjcnArVlhmMEliSmVCNEhk?=
 =?utf-8?Q?YWuVArl4odlTuEYiXPqqGec58JQZDhKuUx5STBh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88b08c3-5d30-46c5-e484-08d96214557e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 06:49:32.4147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0atLJAdzpWZern7kHsFToLVhlCedgCgNh0Rr0Nq2/DHR/cG+cComvktkMzknul7Zcef3OsofLK8liTkluNYolQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2914
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108180042
X-Proofpoint-ORIG-GUID: lgDkTGH6xiG9K6bf022lFhV70ZisloSc
X-Proofpoint-GUID: lgDkTGH6xiG9K6bf022lFhV70ZisloSc
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 18/08/2021 14:20, Nikolay Borisov wrote:
> 
> 
> On 18.08.21 г. 9:13, Anand Jain wrote:
>>
>>
>> On 18/08/2021 12:25, Anand Jain wrote:
>>> On 18/08/2021 12:15, Su Yue wrote:
>>>> Update it since commit 944d3f9fac61 ("btrfs: switch seed device to
>>>> list api") did conversion from fs_devices::seed to
>>>> fs_devices::seed_list.
>>>>
>>>> Signed-off-by: Su Yue <l@damenly.su>
>>>
>>
>>
>>> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>>
>>   Ah. No. I have remove my RB...
>>>
>>>> ---
>>>>    fs/btrfs/volumes.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>> index 70f94b75f25a..fcc2fede9ffc 100644
>>>> --- a/fs/btrfs/volumes.c
>>>> +++ b/fs/btrfs/volumes.c
>>>> @@ -2203,7 +2203,7 @@ int btrfs_rm_device(struct btrfs_fs_info
>>>> *fs_info, const char *device_path,
>>>>        /*
>>>>         * In normal cases the cur_devices == fs_devices. But in case
>>>>         * of deleting a seed device, the cur_devices should point to
>>>> -     * its own fs_devices listed under the fs_devices->seed.
>>>> +     * its own fs_devices listed under the fs_devices->seed_list.
>>
>>
>> fs_devices->seed is correct.
>>
>> 222 struct btrfs_fs_devices {
>> ::
>> 257         struct btrfs_fs_devices *seed;
> 
> You are clearly looking at the wrong tree since seed got removed exactly
> in the cited patch above.

  Yep, I notice a little late.


>>
>> Thanks, Anand
>>
>>
>>>>         */
>>>>        cur_devices = device->fs_devices;
>>>>        mutex_lock(&fs_devices->device_list_mutex);
>>>>
>>>
>>
