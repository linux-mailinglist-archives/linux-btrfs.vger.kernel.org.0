Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1346F4851D1
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 12:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbiAELbs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 06:31:48 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58680 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233838AbiAELbr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jan 2022 06:31:47 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205AxgLR008818;
        Wed, 5 Jan 2022 11:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4dIIsWtJG+1L/viw+F5dJ9SlEDhsNKHzgAA9MAui2VA=;
 b=XR2CzYgP5V5Fwr7ERuGqjlWP3nRZT9l/Tp6wNnzPbPpo8CcuWc4rvQZDxHq7ZJBo7XDL
 9OB1YL9Ti43sJ4TPoSxrn3PE+LmkRN9CPi/VhdmY07x/d6b56bNpiAklu/N2kne4TiTA
 uO3TfQ4Gtv6axOi6MmIGqcctwPn3l1UzfIMgyRxXYevPebv7rLoRBav/M48HA+6WZGLq
 RHHqkLjuLZrPm77mA2REdD3wEKWU8DzOoSWttbslrpQRJeDcnFByXBoBnEeTPLQoLDOk
 vDkeoTh9gVDYdTNjbvZifdeCqkL5dnF7ekamCsn78Q0gdQqFV0pLxj5d7fG/pbPRSJf8 Vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc3v4mm9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 11:31:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205BC7mg056875;
        Wed, 5 Jan 2022 11:31:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3030.oracle.com with ESMTP id 3dad0eux5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 11:31:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtcPi5oSeJYu9Zu0DUqr1CatDZ7LCN3HEVXIVPvXnY6hriGLcw55DIkkxlMsNr8gImhrAXzzCGdFhfHB3mjmQ/Mpgb11nfAn25ZwGXo8qzrerNlXkAT+qJlgfrbocH1NMGlxOCU7LzV3y7qfsjJ22DZ0kSifjicJjBVp9BFO5UJGufckbWCcuga2WN0g+KvbNbVNY45UTNZ7/Ez1omb+fbS+jeOjbI0PKpcr3wsz/gVypkhbPW7bYfc/XzcntNBqxvgz3fjNAt8JNKY5txapz4Sf3Au+4En7avI/jDDRUh/dQNgcY112pc5l9sJHkMPuESHmFzuziu6PbnJXUiF5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dIIsWtJG+1L/viw+F5dJ9SlEDhsNKHzgAA9MAui2VA=;
 b=GlXJHSbTVDfz5IjOFw0aKe8TbUYuogtElzFbxwrEKHSS3VdbkoxeAB7jo0TB4HaqNRtguzubsGoKlyCSEBQSGMwXp+7hg57mH374BAcjCEacoiPCRYxZt2TnYih9CMX4zxJZlgTjBo3P1JbOkC+KGkgyMv648UsnfjVLy1jgg5zqGnFCQZOl1029Y4+c5Kj8dtvFmaAQyUV5q87QlJgCzqZk+xN0RalVd+eiO/ypBYi3W+/O1un0lSJdmpyQZ6XV1RvvZ+n8w/j7AE+NcnkE4U1NHztOUC4KzrFeL9vKmEWlF5ssh3aEvfz3GIqWGMhUIhNbzD4fGm9Fp/f2kWz0UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dIIsWtJG+1L/viw+F5dJ9SlEDhsNKHzgAA9MAui2VA=;
 b=OL34Ka/ElWz8OwYCZoUHreDdeh98qWmBShzdxgbfDLs7mdNUNfmBBKuLKNwQOhNGcg/yIywnMS2yepDYwNfJWPlGM+Iv1VN6B7dBWyyV9xzmkbE54LVL8qaXzqJHisPuG3tUx7rqg8NWL3FvMKzub51ZHh7wG/kYwob9AIn+1I0=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2897.namprd10.prod.outlook.com (2603:10b6:208:7e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 11:31:40 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 11:31:40 +0000
Message-ID: <4210807a-c727-19be-9f72-797f0e1897f2@oracle.com>
Date:   Wed, 5 Jan 2022 19:31:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 1/2] btrfs: harden identification of the stale device
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, josef@toxicpanda.com
References: <cover.1639155519.git.anand.jain@oracle.com>
 <612eac6f9309cbee107afbbd4817c0a628207438.1639155519.git.anand.jain@oracle.com>
 <20220104185611.GX28560@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220104185611.GX28560@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR0601CA0008.apcprd06.prod.outlook.com (2603:1096:3::18)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e22f4cd-8940-4b91-0c80-08d9d03ef0d7
X-MS-TrafficTypeDiagnostic: BL0PR10MB2897:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB2897B62DF45B09FDB580A777E54B9@BL0PR10MB2897.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+XlysD13SIIdXL2qD1QcsBIaFh7cS73x8P1a3p7aSqtpzo7tK2gkY4+JyJtu6/ej9ruMrlTQB/Y9vLbdSciU+Rb8kxKkeQqaaLB17HSgAt3MhauSOXPQKbJ8QZ9QTAlSu6YhRLe/1LHcuYtAxnPNRKmfIuLMuVkygyegWcd1kfb87pn+6kX8gkCJbQ2tsW+vSCkYktHpt5dmVkQ9KhGJoGQ6Cmd+j6U5HJFEk7CMRU2MNYlqYDVShCsgUKYmYX3JS5cJBTVpljiYdLoaD3dtbzWKgCbd940bMsP2C3UQmSBQEzYSuhBUSByyA/XEVFsFBbyqAzlrZM03c00eJDhlg9QTp9/M/KGkB+o3Nm7UoXKh//o0EzRAR9hg44F4nUBO3xW3x/+T7SxGA5NXAwHWM+VxTAZ3bLBiQF1XSzInuJqK7u3jhcA3ZjrSVn7I62R+4gHgyjwGkShPEd+RIVj9tLKZrxz9fNt7Yq6JR5QEJdjmmsGLmVI33CTpWldQwH1uRxuIhf+paVzHjhMvaNNcWzL9e/8KHEjGOXxfJ6y64UvXbRLyiTfFBrbpAzfbPuQ8RwDPt9Hrqh3a24UxizfLRS+0TrYoo3iKAzfvGUFnJQ2Ul6UyAEawHRnfsbySKiPd99mL+pgc2WsZiEXz96nWy/d2dqw5/+H/7dcy2XXOte1nuUGEYeLHTl7eW7SCIm00aqHacstLd2x4SmHc0Ec1LrvYspALdfUMMDdhEpg8bU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(6666004)(6486002)(8936002)(6512007)(6506007)(83380400001)(53546011)(31696002)(38100700002)(186003)(2906002)(31686004)(5660300002)(66556008)(316002)(508600001)(86362001)(44832011)(26005)(66946007)(66476007)(36756003)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWpvKzFqcmE4RHRPR0lCdkxHMlVhSmt2TE5IREZCK3ZnOUkyRkw4amc0NmlS?=
 =?utf-8?B?b1BZdXdocUtxVEdUU3VCWEZqNVFmdVovOXV5aTM5VkdyWXBBN3dJYXllMWQz?=
 =?utf-8?B?L2VkTEZ0cXhISGhQU2M2UjNBRDhTc3pFR055T0J2cFdJME1veHBhR0VHUmhU?=
 =?utf-8?B?NlpTNVVsRnBDbTZoVzVJb1hHbmZMSE5TSTBvR1hQUWFMWVVrb21OUmFiZmZi?=
 =?utf-8?B?Q3VOSHNBNFRSd1IzL1c2N25MUWFVY2UxNDQrZElBVitVWHprRnVpRDlVZ0JW?=
 =?utf-8?B?QjRaenFBdVhYMU1qcGlRdjNMSFZZbUNra1lSaENPekhPWVFENWVOZWIyT3ZQ?=
 =?utf-8?B?UXQ1OUdPWHpyWko5V3ExNzBkdFVXaU9kaGxqTkpZQ05BWWJFSXRrSm9PdkN5?=
 =?utf-8?B?Y2xKZVFwanFtN0hwbUN2d3BNRWp5WnpEdVM5ZFRWQ3ljV1F6VHVESzVVWFM4?=
 =?utf-8?B?WlR0NXRwZngrdFEwc0U4OUNqaDlmTzJDSFdOd0M0TzdkUVhObWJEL1ZhWTdm?=
 =?utf-8?B?ZnMvbGxMZFJ2RWFMT29oQVJQZVdlTHpsbW1lclNDaEU5R2pMcU8yeWg0dEND?=
 =?utf-8?B?VlE4RlR5QTdIVHpxTDJQakNoK0pCQ21GRnhRWExJT0tjUDNMa0JiYStYRDF6?=
 =?utf-8?B?R2E0QzBPRDRNVnh4Yk9OU3ZNUkwzK2thQ2ZaelcrQjZZR1dFUW9RRDNVQzRD?=
 =?utf-8?B?SmI0amFFc0JwSWJKaVZRSmRvWjNRWjlOUFAwaFJITGtOOWVLL3RiSjhzSHFx?=
 =?utf-8?B?NTVMamNEL2RNajc1eExnUzdhNy9MdHpjVWFxT2syRDNTVFRQMzE2UWJ2TWRC?=
 =?utf-8?B?VHI4dnZpUHJ0V21SS09DTngrUHdYQUlsZ2RNUGQ4S3ozdWlUaU5jaVhBZVVU?=
 =?utf-8?B?OXFXRmp4Z1huM1V5blhxRkNqRHl5UW1jK292TVJwVTN1c0xvdktIL0JtaEtC?=
 =?utf-8?B?RUhMMjJWRFdTWm9VOHZzN25BMUtIVXBXclRSSk8zN3QvOE5aRW9DQ29NNzNK?=
 =?utf-8?B?SEgyTzNTWlVSZjcwMHRRc1NaL3JDd0JKVFFVaEp6Y2dXV01QZ3pLdUc3d0ov?=
 =?utf-8?B?Y0l2S2poRVFsb2RNQ0xLWVVtMkdqOHlCSDR5NWF4VmlXalpUK2N4akVVbDdO?=
 =?utf-8?B?Zk9FVzdzWlpKYTNZcUkwV29VTjJYTXo2b21jdG96bDFOTGIzL1NjNm1oTHFz?=
 =?utf-8?B?dUh6V1IzekZmMWovaVg0Y1ZPbGNFNWJzbVZRYzBrWEhrWk1OMmJnbE9ENlhu?=
 =?utf-8?B?RVNlcWtsa2tWRmpWSTJiQlFmNEc0c1JpR0luTmdlY1NXalgvU2V4YkdBSUVW?=
 =?utf-8?B?dlN4anZMbDBBUjB2djI0ZHp5UVE0d0JjdjJjRWZaQXZHeVZzQWNyNVBjaWtq?=
 =?utf-8?B?RnAwQXBsWmZTNE5mTWlta1BGMVJ1VFZkM2hZcjZUS2YwZ2Q0bktjTkJuNndL?=
 =?utf-8?B?bWphcndJblB1dHVaTnZ5c3NRc2dSaGhxVjhEY05kdzZESDNsNkN3UjFQQzRE?=
 =?utf-8?B?SkVZa3RZa2h3TlNwSnFoUVU3Vm1DWTlxMkdJZ0ltTmhjQmFKMVVDWWl6NnBH?=
 =?utf-8?B?alNlSGc5VjBqTmpWVE9UZXRRRXBsc010S0JwcVlJQWhUMnRHSkRaZGRFckhq?=
 =?utf-8?B?K3BSaDRLYW5sMHgrdENyd3V6SlExdlgxZ1JwanozaU45TnJFaDFyQjlrTU55?=
 =?utf-8?B?eU5CZy9zd0Jhb1VQelN2SUtZT2JweWxLSFprYVlaQS8zQ0F3c28zZ1kyRjdZ?=
 =?utf-8?B?OVUzY0RwbjFjMENRZUc5amN6QWk4MG1GM3BZSzNGZ2h4NTZJaFFaTU00UndZ?=
 =?utf-8?B?S1ZPamJ6bzdXaWpXWVQyd1Y1elRURjEwT21pem5xZnVZVjkwalNXTk9aSkUz?=
 =?utf-8?B?MTIvd0QyeGZiKzVKQlBrejhzRlVWclF6T0ZRY1Iza1MwQzk4bVZhV3lxdVZW?=
 =?utf-8?B?VGtaeVVkWUFOR3YrVlA4aUhYcFRITFpBNlBhWnZ0OVgzaDUwNit6bmExdXpy?=
 =?utf-8?B?MTVia3VYQUhGTHNIVU1idk92Sk5sTk9pTVIyalZ4UzN2VVgxc3NDc1FudXp0?=
 =?utf-8?B?U3V1TjFaS2FhMEg0MlFlVHZ3aVo2UXR1elFJWmVKZXArMWxNZVZXbmtra1N6?=
 =?utf-8?B?dEJMd2xaYmdsZWNlM0JGQUlCb1J1alVuWldEVlF0ZlR5dnhTMlQzNDFkSWdp?=
 =?utf-8?Q?hW8g/hhcW8fk+X06fqEScPY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e22f4cd-8940-4b91-0c80-08d9d03ef0d7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 11:31:40.1028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZbTHzYgeGMXdO5lBB6dd5O+9ygjWT9CkJp0xcd216W0zdtlvIHJ2wpTT9rlfJmhQNZuzdgqaWarcGTZF7ohJwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2897
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10217 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201050075
X-Proofpoint-GUID: 2DHcqpvj951g971j8RHGIccA6EZetJrN
X-Proofpoint-ORIG-GUID: 2DHcqpvj951g971j8RHGIccA6EZetJrN
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 05/01/2022 02:56, David Sterba wrote:
> On Sat, Dec 11, 2021 at 02:15:29AM +0800, Anand Jain wrote:
>> Identifying and removing the stale device from the fs_uuids list is done
>> by the function btrfs_free_stale_devices().
>> btrfs_free_stale_devices() in turn depends on the function
>> device_path_matched() to check if the device repeats in more than one
>> btrfs_device structure.
>>
>> The matching of the device happens by its path, the device path. However,
>> when dm mapper is in use, the dm device paths are nothing but a link to
>> the actual block device, which leads to the device_path_matched() failing
>> to match.
>>
>> Fix this by matching the dev_t as provided by lookup_bdev() instead of
>> plain strcmp() the device paths.
>>
>> Reported-by: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>
>> v2: Fix
>>       sparse: warning: incorrect type in argument 1 (different address spaces)
>>       For using device->name->str
>>
>>      Fix Josef suggestion to pass dev_t instead of device-path in the
>>       patch 2/2.
>>
>>   fs/btrfs/volumes.c | 41 ++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 36 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 1b02c03a882c..559fdb0c4a0e 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -534,15 +534,46 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
>>   	return ret;
>>   }
>>   
>> -static bool device_path_matched(const char *path, struct btrfs_device *device)
>> +/*
>> + * Check if the device in the 'path' matches with the device in the given
>> + * struct btrfs_device '*device'.
>> + * Returns:
>> + *	0	If it is the same device.
>> + *	1	If it is not the same device.
>> + *	-errno	For error.
>> + */
>> +static int device_matched(struct btrfs_device *device, const char *path)
>>   {
>> -	int found;
>> +	char *device_name;
>> +	dev_t dev_old;
>> +	dev_t dev_new;
>> +	int ret;
>> +
>> +	device_name = kzalloc(BTRFS_PATH_NAME_MAX, GFP_KERNEL);
>> +	if (!device_name)
>> +		return -ENOMEM;
>>   
>>   	rcu_read_lock();
>> -	found = strcmp(rcu_str_deref(device->name), path);
>> +	ret = sprintf(device_name, "%s", rcu_str_deref(device->name));
> 
> I wonder if the temporary allocation could be avoided, as it's the
> exactly same path of the device, so it could be passed to lookup_bdev.

  Yeah, I tried but to no avail. Unless I drop the rcu read lock and
  use the str directly as below.

  lookup_bdev(device->name->str, &dev_old);

  We do skip rcu access for device->name at a few locations.

  Also, pls note lookup_bdev() can't be called within rcu_read_lock(),
  (calling sleep function warning).


>>   	rcu_read_unlock();
>> +	if (!ret) {
>> +		kfree(device_name);
>> +		return -EINVAL;
>> +	}
>>   
>> -	return found == 0;
>> +	ret = lookup_bdev(device_name, &dev_old);
>> +	kfree(device_name);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = lookup_bdev(path, &dev_new);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (dev_old == dev_new)
>> +		return 0;
>> +
>> +	return 1;
>>   }
>>   
>>   /*
>> @@ -577,7 +608,7 @@ static int btrfs_free_stale_devices(const char *path,
>>   				continue;
>>   			if (path && !device->name)
>>   				continue;
>> -			if (path && !device_path_matched(path, device))
>> +			if (path && device_matched(device, path) != 0)
> 
> You've changed the fuction to return errors but it's not checked,
> besides the memory allocation failure, the lookup functions could fail
> for various reasons so I don't think it's safe to ignore the errors.

IMO there isn't much that the parent function should do even if the
device_matched() returns an error for the reasons you stated.

Mainly because btrfs_free_stale_devices() OR btrfs_forget_devices()
is used as a cleanup ops in the primary task functions such as
btrfs_scan_one_device() and btrfs_init_new_device(). Even if we don't
remove the stale there is no harm.

Further btrfs_forget_devices() is called from btrfs_control_ioctl()
which is a userland call for forget devices. So as we traverse the
device list, if a device lookup fails IMO, it is ok to skip to the next
device in the list and return the status of the device match.

Even more, IMO we should save the dev_t in the struct btrfs_device,
upon which the device_matched() will go away altogether. This change
is outside of the bug that we intended to fix here. I will clean that
up separately.

Thanks, Anand

>>   				continue;
>>   			if (fs_devices->opened) {
>>   				/* for an already deleted device return 0 */
>> -- 
>> 2.33.1
