Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE4648A759
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 06:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244570AbiAKF2N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jan 2022 00:28:13 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9058 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232010AbiAKF2M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jan 2022 00:28:12 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B3TFnj018671;
        Tue, 11 Jan 2022 05:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Pe6TcNx0ohoRu9ja7zWHOxTKQZm19esK1p79LIx3I4A=;
 b=DYwGCp0LQwbkTXQKwFuGTzRGRI4vcdgDTvtHd2BHzXbSxAKlJSXE9e4eKoY2rd0ytnNM
 OJxwWE9WVcMPLgOsG7i4uaDBjPgNqDeXkJSLRLiLmHZQe2nC8WJsLxHSRaupWJOcpQrw
 C7VU0KiGcOY8ngwoto56tjpN1i7Cjl13kPralDRxTwBl5CP9qomarKKUW3gRu+oIqJLo
 lf9nV6IaXncXAmA/DgBbIv9zWLGozHDV+AigFdDK1tNHNHN3fpkJzz9LzJRjjyRwC+0T
 GJUaH5GkU2mzOTS6eaR3mQIxuKsyOKESlxsMtjodAtgsECB5wlNFJxmBWVZOqhs8pw2/ Xg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7nhwqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 05:28:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B5PbJ4018049;
        Tue, 11 Jan 2022 05:28:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by userp3020.oracle.com with ESMTP id 3df42m4h65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 05:28:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tflu6c6gj1QT/T6daEjuPvbrVRN5vFFWBshP6o6QmXB9u0YhjgEGnAVc4ykWHxPqaIIRg1uaJE8wZSKKkmVRuDe5hAijTeOW96MHEZ8Xrur2rzNMDT2aRXDdjihY0vzrJ3ncKrYaudL5WYtIPibp/keZmAEstGNvzJj3MHWJNPui+F2x28Dip2SapniwAdnFvKTF2BUXgBcVnhBTDrVze1gsYTC7Jbas+GA3bf0svm4vBX/dxE5o4a6vv5o7MEb6Xmq+5rbaX0Myf9UoLzcWNJHPpNVCwPQ5GK1OET1Nw8/uTguD/Jdhd6TNqSakKTgq6zP3nTwWXKBAz8N8KqNbVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pe6TcNx0ohoRu9ja7zWHOxTKQZm19esK1p79LIx3I4A=;
 b=TzNkUHDyxUe3iCRdKCXXrrjgRWcdl/NgRWVyCGr6NAoU05WEyxkZgIUJMuHAqdiHSN+AM47P11cUA44vjU5qavOtvTsze9ZwE4Jg4vAdSpqQXXKWhjMwgLC856PCsE3Pi8fr98VNF46beh6g3d348WIyU4+H1BSjo1/wKCtEwvXUG40v/U0JTICw8o2KhZXqffA0sa5V2kQi623GKnZV/DUGB2sczzTxQXXfmJ1BhH/vVYkPZMFWGUUrx4F4qIzm4dflRGDNr1YNe4bak1m6rg+0rJNMoRykPaOK+IE1CFDGLftnXcRrQHz/S8vYTcfe0Yo3QjixoASefWeUo7HMVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pe6TcNx0ohoRu9ja7zWHOxTKQZm19esK1p79LIx3I4A=;
 b=ng8LKXpIsl80X2Hg2uYZOe7SLjf5K75OMO7iYLSnfKdvpUocAQ+8IFhTR2fWokzAHxb6wtrRt2T9+Dj0otZL8KdneVCUI3wjj2c6PYtRXdXXhjm3f3OagJAJwPquiL+4olZTULBfpVT4brGZ/uv3RpWosZnL53K7S7ud5ZCYFek=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3789.namprd10.prod.outlook.com (2603:10b6:208:181::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 05:27:59 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 05:27:59 +0000
Message-ID: <ebd02efc-0ff0-0954-a7e6-308757d70e49@oracle.com>
Date:   Tue, 11 Jan 2022 13:27:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v4 3/4] btrfs: add device major-minor info in the struct
 btrfs_device
Content-Language: en-US
To:     kreijack@inwind.it, linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, nborisov@suse.com,
        l@damenly.su
References: <cover.1641794058.git.anand.jain@oracle.com>
 <9dca55580c33938776b9024cc116f9f6913a65cf.1641794058.git.anand.jain@oracle.com>
 <03c7c3d2-5abe-0087-90d9-698c77a98fc4@libero.it>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <03c7c3d2-5abe-0087-90d9-698c77a98fc4@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:54::15) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bc086a9-e8e1-4ab4-56ef-08d9d4c3215c
X-MS-TrafficTypeDiagnostic: MN2PR10MB3789:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB378925BDCDB0CD7CD59C0420E5519@MN2PR10MB3789.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xTx9SBAug7Ek+tpI7RYfeShWfoLEtESq/gREXhGCDDv+dvQc5Tn7vA550uo9wiC4zw5NOxnWFVQIKvAohB0NIRoOMteCYd3Pr48l7QJH5edWOXrFVjZzGO4bzdbk9rxvrUG79YDEnc4zKDYnP/JE5TdB3Nn0G4Y6TnmRxnUunrX6YWEmSHb55VGe57Pd5un9a6+sqOecFEx/SzhcWud1LsKKEwKxJD2k8gvRU6XMGQs8zqhwD5tZYY1gfaF+6phDE2c/Oti9Xm1MC7iQvgn69qa9HEQU6DAQkLbNWD/20dfQHlwk26FDfI6xTiGvrUgGO61zN/efVurzswgXTcgH1CNI5uoJfDmK34jiqU5UppwNyXyLUBgWSA2TlKQdGzoDSvKd68/5gg4lEVaO9xU7YRPNz4uNA21dj2j82oO5xAuiur260LDXHfLKsegmMhmljGu0EqpFQBfYmdMCIk0KIs8sGVROOGwEb/cMpJ/wrnNly7d9fg4WCPhvOj9yY5wybzAvcKDgg2YHXOTvjw6UfhG1dL5lAUUc3qE6SnIzo3sZyKqfyPAoHGLCmkU6lI2G/FZu8gPRKBsQUwplNmzpaB6ldfNDtJrHls6KnlcakBFKrd+aA0x3ghxAWVSmsCjr4r1sKpVshOyUciE453ksA+GRC5+ahk1yXlaBMo7n7CdHW1czVTMWHNmnUbY2euHy1KIJbQKi8ogLig4RLCNwDvtDKWG9hP3huRDwFrrKT2A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(6486002)(31686004)(38100700002)(2616005)(66946007)(26005)(31696002)(44832011)(186003)(66556008)(8676002)(8936002)(6666004)(6512007)(66476007)(36756003)(316002)(6506007)(4326008)(86362001)(2906002)(508600001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUdRZDAwQ1FZcHl1WEtWVGlKOWhvb3AwZmVWZnowV2l0UTVoSnB0QWQwMzRF?=
 =?utf-8?B?Z1UwUUdoNmFXdUd3aS9NV3VaeG5hcWZOT28xa1QrY1A1Mzk4emswZ0wvZDU1?=
 =?utf-8?B?L1pleUY3SUo5OW1LZWU2dExKbXUreWdoSFdTU0xXRTRqOHhQVkx1L2J6NHVz?=
 =?utf-8?B?aisyTk9FMXVVSFBqNmdPeGE1d1NYbVVHUWJFbjR5d09nMkVXYlQ0Y2J6OW5z?=
 =?utf-8?B?VXFkZkZCOHU4dzQ4WXBJdkRqVWtYbzZMNmdWSlVUUUdSbjcxNFB1bmM0S1BI?=
 =?utf-8?B?dlErdTRhRGtvV25LRW5Sbi93b3k1V2diak04b3JEajRJcEtsWGtzcDBzUGVF?=
 =?utf-8?B?cThUK2pZaVlUbFhyVmM3Q1BBcmNYZFFIazVUd3d3VHoyOU1aWWxnNXBrQXdG?=
 =?utf-8?B?L3BaalVpa0hKMkljMnFUNGNZNVI0R0l0Vk5CcGIza0o0a2NkbkFuRjlCY2pi?=
 =?utf-8?B?a0JObjlqcUJLYWVGcnpHeHloMWNGTURnWThTOCszWDRJV0lHSUh0Q2FnZmc3?=
 =?utf-8?B?UFVBQ2FFS3lJYjd1NC95azNLVnlGcnJ5RFpYR1A1M3k4QjF4d1BEN0RBSW1K?=
 =?utf-8?B?MkkxRGZjejdwWFVKOGtPdHVneUF0L0k0aDM2VFZHUjVyUjVtNm13cFNmSTdK?=
 =?utf-8?B?a1JIeWFEaVFYdFZ1Q3kzVlpJYVJmdlFEK1pWd1ZJZE9pNEF0Vjd1YXhMeGxF?=
 =?utf-8?B?UGh3Z01PNFdWSWdYcm92d3dPWlh6Q0lMb2RLNmVXMkd6aWhRUUM5VkpuaHRa?=
 =?utf-8?B?QUhaZFVab0ZpSGFMcEt3VXZEVlBuY3BXRzk3ZkJmRVQzQU5YVlp4V1Vxa1VZ?=
 =?utf-8?B?T3kybndKQTB0NFcxOHQyb2ZYckM4ZVBhYklkTmUrUDZTbmVRekRBTm1DODVO?=
 =?utf-8?B?UGdHNXhNbjhhQTAvcUtscS9GU1JxcEgxclAyT2ZNeldVN0ZJay9ORExvL1ow?=
 =?utf-8?B?akdiTktOY3JNQXJHYW5TYmhUVTA2Y2VLYUdwZmlwMmpudzZQZFdlWE9VNHcy?=
 =?utf-8?B?czRJVzNPRktCekxER0RNSmFDVE0yU1J3WExmMTNhVTE4aTNLMjhXY3k1Z09U?=
 =?utf-8?B?QlVDNUY4OFRVZ0dya1k0OTZoUzZiOEZyZk1yU1ZaNmxNaHNUUlZIZHZJcE9x?=
 =?utf-8?B?ZFQ4Rnk1YnZXcE50bEN3UG11MXZjK3hWUnRpTVZqRUFsN1Y0UjVoeG12T2pJ?=
 =?utf-8?B?YndZWkE4VEhjWHNaU1VvOGNEOExkTU8vTWkxbzNVWlp6TWhycnhrMTRaaDMx?=
 =?utf-8?B?ZFFuZmNxYXh5VTZxangxL1daejBLbks2RFhxVmxaUWJWV2lXa3NkTHJiZTRn?=
 =?utf-8?B?TFRWbHplZFdVWkRnZDdFTVRpWVpwaG4vUDl0RTFicDZMTUh3dFBMQ08rdk5x?=
 =?utf-8?B?MHpGcjF4STgxME5GNURiQ2ZjN1h1UzI1bE16ZjNTUjYxK1RtSmRUZWhTL2l5?=
 =?utf-8?B?eGtOSWNzbDZOdkNxVDgzMHpEWjJrTGZ1MFhDcUFibFplWHBtbHhTalZra1F3?=
 =?utf-8?B?NlRJUGM1SUIrN0lwcSt2NkhzTHorQW9sKytwL2hNZjJkNU9ERkh5VW9KSXl0?=
 =?utf-8?B?eHhmNUdZVkw0c1d3ZE4veUI2dDhLMHhsMEJPZENuSDY3ME9kL2lSMU9jdm1J?=
 =?utf-8?B?Z1R0ZU9ZTHN5cXMrYW9mZ1RKK2dGUDdqUjVLT1Z1azZKY0lKU0EwKzdCcGR0?=
 =?utf-8?B?a2x6VUJ1VUxITjBwcVdtR0NacDBPZ3lhMzhWbFdrc1NmTURtbEExTFI0L1FS?=
 =?utf-8?B?ZjVQMDN4amUwck1uVkZ3ckpjZThjRGwzSTU5OStCRnNyV01xT3E0RmFwbEw5?=
 =?utf-8?B?YTNSV01XMm5aQjYwWlRzK2FmYnpDZW5qQlNQbU0vTmt4U0psUlFnRzg1cjR6?=
 =?utf-8?B?MU5XR3JhKzkxODFQeWtNaVdVMTdyazU4RjgvV0hGcVJ5YXNKV2tESy9XOG1u?=
 =?utf-8?B?aDc5QnB4YVBzTXlwOTM3anU3UTFMdE9DMEEwQXlER2xuWG9xaUJEMXVORjl1?=
 =?utf-8?B?Vi9OemtkaTZTamx4cTlTV3dScXcrN0E1U1k0NHhaa1lVQWhXNDU5REpyVDFL?=
 =?utf-8?B?VVB1VlJsWUFlQ0pLT3lmejF1QkQvcHdzOWJhVXNmOFZWOVh5VTFNZUVLNjhr?=
 =?utf-8?B?MkxPRDY4ZE1zYng2ZVY3K0RFcVlyV0JERVZ1Sjl0Rk4rY0U4R281Z1dCdTU3?=
 =?utf-8?Q?sb/z3fAw0AkIEC6LhYZbSpQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc086a9-e8e1-4ab4-56ef-08d9d4c3215c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 05:27:59.6496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHHrQbsKIFprChKjCbwvM6/G7sQ24nAa2Yg+UKXrJCtZA5MSOUc2/6woV7wyGeUdMaxx7pk2T9Y33nhyez2wtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3789
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110026
X-Proofpoint-GUID: wBFTIAimIQJx1erWL70okENdXtNcV8um
X-Proofpoint-ORIG-GUID: wBFTIAimIQJx1erWL70okENdXtNcV8um
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index 76215de8ce34..ebfe5dc73e26 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -73,6 +73,8 @@ struct btrfs_device {
>>       /* the mode sent to blkdev_get */
>>       fmode_t mode;
>> +    /* Device's major-minor number */
>> +    dev_t devt;
> 
> What is the relation between
> 
>      device->devt
> 
> and
> 
>      device->bdev->bd_dev
> 
> ?

  Both are same. device->bdev gets an update at the time device open. 
Otherwise, it is null.

> I assumed that there are situation where there is no a device connected 
> to a btrfs_device
> structure (e.g. a degraded mounted filesystem where a device is 
> missing); in this case
> does devt == 0 ?

  Even for the missing device we do call add_missing_dev() -> 
btrfs_alloc_device() that will ensure devt == 0.

> But are there cases where devt != 0 (a device is associated to a block 
> device structure) and bdev == NULL ?

  It is possible- When we unmount, the btrfs_device continues to exist 
and, both device->name and device->devt shall not be NULL/0; However, 
device->bdev will be NULL; If the device is scanned again with a 
different uuid, then the free_stale_device() is called to check and free 
the old/stale struct btrfs_device.

Thanks, Anand
