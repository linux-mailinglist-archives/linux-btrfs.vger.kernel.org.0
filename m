Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D8D44AB15
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 10:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245119AbhKIKCF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 05:02:05 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:17014 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245116AbhKIKCE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Nov 2021 05:02:04 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A99sgwE015319;
        Tue, 9 Nov 2021 09:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=TpBD8JBCuEme9ZKus/6Qs00T6/n6R1H5j3SbdW5pWL8=;
 b=phR6HFJTJMCNGiEkv/9mdR9g7g8isaZ4vpEyLlYpKRX6ilVdgKYHYKRlQSP4YIWTPYsN
 a8GyWlkN5xynxjv7iPkF0z7enf8Tx8ha9oaSZtUg+MP4HEeHk82bwRVLzRhnFdgI07ht
 ss/jskZICwdAtts/9dofsWq3AuU2gZq+7F7Xl5VWXo9Y82LNv2k/uVJk/B4YVV1vDoQ0
 Mvp0PUswV+T0EBzD8rfP9msiZchzyplKU0ewMx+yHW36ZO03nniFQgiV+ql456oc6w7z
 Gxfmzc6kWobfizAs2tUzMmgex7Tw9jZG+pq1wTYgxKOqNKeQ6PIhfY5MhHfVef4eFGhg Kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6usnhraa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 09:59:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A99uFNm131370;
        Tue, 9 Nov 2021 09:59:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by aserp3020.oracle.com with ESMTP id 3c5hh3caut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 09:59:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFBYZOdaroKSI2qqI10cBzxA6NqRX8/mxJVCPhmhRLvDekD5/qvyt4TID85pWZ5yNhh//D2BhpnLMdbJxQ1q87GhqjXsCKkqAEXwK5ahebJNxUuE/lgJyaCAiSNu176bQP3vxn8Nltcu+hkU61s7Q1TZjfCSAyY6FuXiLz8YjT23DY+Ko5M5k7kAsSGAKRq9Qr1xQh5B2ebxUEDkdBaWFbtA/LBaDqU2pxAMQH9XpJJPSrNjhF4jZdALVVCk75xlLNBHl+mJflCeU5bAVH4RUwxbrIfXFaQ0zk/8dzdkw94lj9AVsX2LJtKR/NzfCIz74KeOZfyhT9LewFxYE3Xqbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpBD8JBCuEme9ZKus/6Qs00T6/n6R1H5j3SbdW5pWL8=;
 b=G4YbiaVVvwxJj+8WQ34IRqmNOuStpYFI5Ij+9rpOOSduDOo/TCwjfLJEau/PEYaYyExSa+aHgw14HRelsmAYIqX9KYouJMXj4yg9iBJF8rRDQYNubJ0RP9ArjHC+LKm9Gn5t6XBmgE5Xvmbhj8GhavyZOXcOj2bQ5w7T3cc+yal4JiBLcZzNBu046i52urUwDqa0vqkgpCFmCAz/Uod83UV9c+iNvqok1vRmRMp/1ECr5gXUGZOGPUMeBYg9WX3iWI8XORHVD9/caiqeyL3+FuyhmfjVcxevc7LN6kHAtnx8W8bUTyFwAwTt4eBx4Xxrcpo+//mzkk/MN9Mn4E2lwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpBD8JBCuEme9ZKus/6Qs00T6/n6R1H5j3SbdW5pWL8=;
 b=u+nz0Xx9BleWRxEcyJ51Slwh2u1dSSrTrSzUCscpFJKpaa3X88D5ybU8b0WMxdVo65lPA4g0MarNpo1mrFsq344YeMlfMVi1j3RD+iVe5JOJzdf5C6no6x3QdHG/RQxu42bfjfX7VQUhYLR9ZJNg8grvB5X0yzIlFxW3fACPSew=
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3427.namprd10.prod.outlook.com (2603:10b6:208:7e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Tue, 9 Nov
 2021 09:59:12 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038%5]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 09:59:12 +0000
Subject: Re: [PATCH v9] btrfs: consolidate device_list_mutex in prepare_sprout
 to its parent
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <8afc1ed3ef688557bbb0dfae1e23d47e53cb645f.1634813005.git.anand.jain@oracle.com>
 <20211108193650.GL28560@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <8525b9a0-2a0c-533a-baf5-aeee8568bdf0@oracle.com>
Date:   Tue, 9 Nov 2021 17:59:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20211108193650.GL28560@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.137] (39.109.140.76) by SI2PR01CA0001.apcprd01.prod.exchangelabs.com (2603:1096:4:191::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 09:59:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f4775ec-41a8-42bc-9e9c-08d9a36794a0
X-MS-TrafficTypeDiagnostic: BL0PR10MB3427:
X-Microsoft-Antispam-PRVS: <BL0PR10MB3427D6EB75B90DC78F2516C3E5929@BL0PR10MB3427.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:483;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jL5x7A5DUtMQ/3PeNpA0LT+7/ebJcAtiW5CYnizZhYhIvisn8cY/OaKQI2gp0RtLBKHIb4fLnOxcMw1y55w81SHrHhBzk/bNKAozSlvxYf+ZnpLzncn805SgTL3Kmtq37kZUNktQxeaEQYIQ2VJMEeLz9sEy3/io8uPdta5BWXGWtfTcjZjhNM9KejstVw78EiTTbM0uT11hZ2EFemUk5eHED2J/pSBsncGUSOlPuAO2LZDSxc/cjjJn77MYi6JukZ92xicMea/lAsPSsh9KMyXuN6q0ZYQDCAzhJchHFFKWYNiuGwEeLUV41ftu5ba3d/TKvR0ihvowjPntuDJwPRB80NM86fezAn0stkdIyt2AjuP/TSaX0W93+KBqsHXF+Gmd/NzfDEVlFHB3Hdj/xkOzliFa0KmnIu25NsveyeJgFefJLlY9WHTkvLaVlZdeYi4sqCHBa4eA1hZKV0qaFUF27h+2ZHHPFtsKgVGiyhpnLw7hgxe0IM9SOcnSOpQDpVaoEOB5OT/jv3GIB3bymi+v4iJ0U45TNRUQ6FU0xcbxy4Z6itAQvNfRpiR9rcc/gd8pjD6B0DxFByNQRSnfu3VNqknc7IKKzpEI8S6NkO+e5dihSAqHvE5Xy7AK3OZH1Yyc3xranKKjQw7HA5NGzIca44NNtpfp5WJ+Vdf4LEpGIiqIiD4Zwnpen3DN16t41KUBkmFszmPCv4AeK1RQaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(31696002)(8936002)(83380400001)(66556008)(38100700002)(16576012)(66946007)(53546011)(2616005)(66476007)(8676002)(316002)(956004)(2906002)(5660300002)(186003)(6486002)(6666004)(86362001)(31686004)(508600001)(36756003)(44832011)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHlMd3VCVGVLbC9EZVdpT2ZXUHBaYm9iamRSeldkMUhjOWRLMi9CQWhvT0lS?=
 =?utf-8?B?ZjlmUnVIZXhxTHBUU0t4VFhOUzFlZUkwOWs2SUQ1NVNrSE84cVhjSFNJY3Y0?=
 =?utf-8?B?M3ZLZFNvd3pGdTh2ZHUzVFlHeDE4cjh2UUVrUVRBcDNtU3Q0MWZzS1NMWGIr?=
 =?utf-8?B?eG14Wk11bVF6c0FkSWhLNlpMY21POGpoMjMvRnhiN2Njb2g4VTIvRWE1RTh5?=
 =?utf-8?B?VUp0WWsraDJVSXVvQ0poK3Y1MnJyRExEOE1YVVFUUkw3YUI2eXZja1JmL1Vk?=
 =?utf-8?B?UUNESnVsU0hBNFFlUXJKend3TzZWelZTV29xUzdUSmJ4MUhjOStuN2lWZGVv?=
 =?utf-8?B?SlNKT0ZaMjJPQ1Z0NXYrR0l0M1lQdVhTUFY1M3ExOWtSeklUTHk2Z2p3SUJV?=
 =?utf-8?B?alIzekFKekpHeEY0T296YXprRGM5Rnhvb0lQR3lESnB3eFg3Um9oMnBla2pQ?=
 =?utf-8?B?cnBNcXgzOURsTUFDdmlGRUtrSWZ4Zi9TTWpiZXFDNHh6L3lEeWkxR2tUOTFW?=
 =?utf-8?B?WXpGR0FiTkkzTGVRd3RacVAyZHpycWE1cGI1NXBFTmhKeDNNVjlZNDc4VmFo?=
 =?utf-8?B?NjdPWG1qYmZPSzUwU0lhY1phZ1A5QXIrMisrNms3QWFvaXNwbGRiODRBZ1p6?=
 =?utf-8?B?UndVaTFQVk5iZmhSTVR0VXYyb2I4NDc4REg4ZXVVZVpkTmRSdG1ZRXlmU1lH?=
 =?utf-8?B?WmZhNkZISEpBdjVQd1JUT283Y0Q4RG5rcmVERGloeHRGZWNJY3UrQ1Y1eWg3?=
 =?utf-8?B?b2VZdTBnZkJVWmhnVUtkQmtpUHE5WEVSdVdROE9LWFUxalYxZ1o4RlpNTS9S?=
 =?utf-8?B?dmtsMERESUtxaFhRdWpPUkFsRFN2TWxWeHpGUEE5STRzMGYwbEJHelozbEFE?=
 =?utf-8?B?djIvaUVjbm5CL0Fsa2pBR3Zoa01UQjVCbmRRVkgxMDN4cmxVNU8rNTdrTmhL?=
 =?utf-8?B?Z3RZaUlvZ045Ry9oZjVtOUVLZ1hXSTUrb2h3bmM5WFgzLzQrWnEvWElLL3Va?=
 =?utf-8?B?d0hCZ2FzenhtMWs1SkpoOXk1RGtaRE14dnR0WHgxTnhPdHdzTjljeXhMVmdm?=
 =?utf-8?B?NFFrbmpNVTVPeGhiY09tZ0hSejlWWnZlVUpadUdUMWlHYzlyZHNXRm9XanFI?=
 =?utf-8?B?dExPM1RNTXA0SjcxbmJ6RmxBeWZLQ0dUc2lxOE9ZZWVGOFlzcjl0TFc5REg1?=
 =?utf-8?B?VGRVRU1na2ZLc3ZMa0F1TTg4V3Z3N3NJTDY4NkxJcFVRdzdyNzY1d2ZIS1NH?=
 =?utf-8?B?ak1UK04yM2pHMjVxNytuNUcraEFvdTFpMEQwbmZ1VE8rYXVtWThRbTQ5ekZS?=
 =?utf-8?B?L3JOcjZCUXhPRitJaHRhd2N3U1ZuN2krblc5MC9iMGE3RkhFRE43Q01VY1Vk?=
 =?utf-8?B?TXdoQ1JVZUNrNlRVZXIrMSs1TUZWZXpVZDd4eWNxRDZldzl2NmdlWHBYYmcx?=
 =?utf-8?B?ak5JVXVzKzJwMTlaTGZoNzUyZU1HSWNBbnh1UzB2b2tWc1cyQ0ZRMHBpdmNO?=
 =?utf-8?B?ajV5czBmUEhvMDVHaWlHRWV1RnovVlJ6ZGNqUGZrakUrblRyRVVXRjhTS2Vy?=
 =?utf-8?B?bFIyWldFeHlGUkhNcjlCTnJLOXlWN2dmaE1wWkRaTkp3VGZDb21tVUdGY2tY?=
 =?utf-8?B?Z1kyVlVYN0FHUE5PTm5ZLzNJOGp0cG5HZVRxQUZOZEovNEIwbTg3TCtGYkYz?=
 =?utf-8?B?Sm1GTkM0SEwxc1NvNGprOHBwYXZUTFcwTFNUVUttcEFqRFFIMDA5QXZIMkh3?=
 =?utf-8?B?MXhaQ2QvNkpIdnNhSXVBb09lSmxocGM5SFprRnp6WjdPczhTMnV4OTZhTVo5?=
 =?utf-8?B?VS9TNnZNY1hkMi9OWlpGOVE3UVN0emNydVEzNDdBSUZzN0RLTjRzRWt1cnlo?=
 =?utf-8?B?S0t5UDN0K3NFN0IyZHdMbjhET1ZXeTJZL3JaY1ZpanpUYzBJMGxCbVNodmJz?=
 =?utf-8?B?emtoME43RnA2R2g2Z2lkQVdSbldJZjU5ODY5L3hqbzNXY2Q2MFlvOVVCcVI3?=
 =?utf-8?B?bzZUd3orT1ZpL2JEUW95ZGFvVXFWY1MvdEUrMVVQWURBNUx1bXZ6N0FMRU9w?=
 =?utf-8?B?MksxQitod1pFK0NhWTVwTHhlNWhxdldxaXZZaFNHbnVGa3ByS2JhbVNNa2pD?=
 =?utf-8?B?b0UzdDMrV2NrdkJFVHlaQVI0MVdGaHU1YTFja1AvamlmcExWaFkycFFzK1Qv?=
 =?utf-8?Q?R/10w9ZcXLXbYigAG8s30QY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4775ec-41a8-42bc-9e9c-08d9a36794a0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 09:59:12.0985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ppkcADHa7wF6MXbBzgaSsFaRZjNz6NpC94f5tJY3WZmDBA/jmL8wYp/zsak5g9oKxO/cagHn1KNg0441OZlbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3427
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10162 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111090060
X-Proofpoint-ORIG-GUID: 7IN5_0wzCbMbafwphDjFqxLnQQLN2_Ve
X-Proofpoint-GUID: 7IN5_0wzCbMbafwphDjFqxLnQQLN2_Ve
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/11/21 3:36 am, David Sterba wrote:
> On Thu, Oct 21, 2021 at 06:49:57PM +0800, Anand Jain wrote:
>> @@ -2662,18 +2688,25 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>   
>>   	if (seeding_dev) {
>>   		btrfs_clear_sb_rdonly(sb);
>> -		ret = btrfs_prepare_sprout(fs_info);
>> -		if (ret) {
>> -			btrfs_abort_transaction(trans, ret);
>> +
>> +		/* GFP_KERNEL alloc should not be under device_list_mutex */
>> +		seed_devices = btrfs_init_sprout(fs_info);
>> +		if (IS_ERR(seed_devices)) {
>> +			btrfs_abort_transaction(trans, (int)PTR_ERR(seed_devices));
> 
> Shouldn't this do
> 
> 			ret = PTR_ERR(seed_devices)
> 			btrfs_abort_transaction(trans, ret);
> 			goto error_trans;
> 

  You are right. We need it. I sent v10 with this change. Thanks.

-Anand


> The ret value would otherwise remain unchanged, from some previous use
> which at this point would be 0. >
>>   			goto error_trans;
>>   		}
>> +	}
>> +
>> +	mutex_lock(&fs_devices->device_list_mutex);
>> +	if (seeding_dev) {
>> +		btrfs_setup_sprout(fs_info, seed_devices);
>> +
>>   		btrfs_assign_next_active_device(fs_info->fs_devices->latest_dev,
>>   						device);
>>   	}
>>   
>>   	device->fs_devices = fs_devices;
>>   
>> -	mutex_lock(&fs_devices->device_list_mutex);
>>   	mutex_lock(&fs_info->chunk_mutex);
>>   	list_add_rcu(&device->dev_list, &fs_devices->devices);
>>   	list_add(&device->dev_alloc_list, &fs_devices->alloc_list);

