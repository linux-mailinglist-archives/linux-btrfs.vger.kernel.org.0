Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6BA489073
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 07:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbiAJG6M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 01:58:12 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:12428 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232399AbiAJG6L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 01:58:11 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20A0qrYJ007008;
        Mon, 10 Jan 2022 06:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : references : cc : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=K448PCps9AVFajE9YpVwlO73LWN+/OeJ529D2cAZTnQ=;
 b=w2ZccigFqnVBFvPyLZkrWZaqseVk0xU3ANkNbMN/tkLODYWV1zGCe1Hbl0QkXnAwMoxY
 eI4mTCF/pFlcEDMHwPbWgZsIZ0VA/PO4WZtK0j2dPPqTlBqOvHwY0sUo2eTRiBl8bCxW
 0spwQU1WwyHXuzw+vY1zmsBICt5tLl4OKUfeEKlz63xOCfSDuEtqtHs2m870ZlnpTJci
 b60JI56EYG+8yMBfa4Inc7isflVYFYrYjCUhoT1bnhjFEFZgJXzcH9FgnOZMirG58bvV
 TkhpWnvCxnuFjL6SyJlRf3ndx35y09Y+kUCkNeBp+fW2a12E6G/P90O6tiYfwqTBDkO+ NA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3df1d2tb37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 06:58:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20A6uNsm116597;
        Mon, 10 Jan 2022 06:58:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by aserp3030.oracle.com with ESMTP id 3df0nc6gnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 06:58:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGGEPam0LTKSVee/UCNdbiH0A5UcqasPfJjacHQpj3ce67IJrDNnyypWZRZsjLh9VTNjkxononT2oUiIpVMmS9JwH2xoxlwT5xzVTpEc5Ik3Aw/PPiD82UlFXsOqe4P9EBf+2HeUMC1u/j3WcD429rj8LntWcOISdR6ctgZHnaqIV/wYXZFuVPNJFG6iH+Lw/SU5k54KpkJ5mGEG5zwlALLWaPCdo7MOXcfZVYsm4wAruEc8+WLDQeD5F0KV4RxVhoGa223Eq5cnmauuPOUAHfRWroHagAP3Qp3Bje//GEObQbrJWVyAAhOMdWT8iT1Pnkb7xFYIg3liRg50zA33Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K448PCps9AVFajE9YpVwlO73LWN+/OeJ529D2cAZTnQ=;
 b=aHehNzYVkQzcGPOufmGsKQyDYNq9IX+QyVE0XFs5W2KUcu+vRAwv5gsaIhIuCt+WlHSthSbOw4zg8CM5nO7AIZNmMUzOXV5omNMIh6YCPilEbMTLLipgkU7AE38w3msBE91tmBTnVhPuMba0Lbfd2NlwaOAS8leOU1URHRtgXL1236/L807ieceAMlWMrk5IVmNIyyADsNHiTWYvo+dtXhsfyCJyniVdsVzVN+1YTdZJauh1VfLWeNT37zYYiQFWfNGPhkqD5VYLFuj5SVYtS3lkPEVh5CKBO+ebTkYqmNTX3gWXtzQZtJ9JmedFrq4AS1bK20VnDVbwJAVF1sW9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K448PCps9AVFajE9YpVwlO73LWN+/OeJ529D2cAZTnQ=;
 b=vuI4xbaalPBgBtd53eIOoXENkVQvCb2UayEP1nvYX17yXSo5lCNiPFJve7iYqXMY5+iYLX4NJxANB2Ii88CiabSl21MQDLApyZ8a2NokuVU0nk+F/87oddjqBjqZbm8v3tYY+iw/syknXkAvJ3lqbW22pg81PovWpzSvkJYTD0M=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5171.namprd10.prod.outlook.com (2603:10b6:208:325::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 06:58:02 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 06:58:02 +0000
Message-ID: <2e510d67-fe48-0981-de3c-4b5819a4b88f@oracle.com>
Date:   Mon, 10 Jan 2022 14:57:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v3 2/4] btrfs: redeclare btrfs_stale_devices arg1 to dev_t
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <cover.1641535030.git.anand.jain@oracle.com>
 <513f904de2c8c7a5268424cc6a525cfbeea0e39e.1641535030.git.anand.jain@oracle.com>
 <20220107161638.GM14046@twin.jikos.cz>
X-Mozilla-News-Host: news://nntp.lore.kernel.org
Content-Language: en-US
Cc:     josef@toxicpanda.com, nborisov@suse.com, l@damenly.su
In-Reply-To: <20220107161638.GM14046@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR0601CA0013.apcprd06.prod.outlook.com (2603:1096:3::23)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 302e9d93-2347-4a34-2483-08d9d4068b04
X-MS-TrafficTypeDiagnostic: BLAPR10MB5171:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5171974F77153FB2854DD8D8E5509@BLAPR10MB5171.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JdEaHGh0lOE+MIjRLw/lU76TXG3AMCqbYS7edZcIIGJD45H78bazzRaPgCABKUshL6XG1ufK/IlivLcqU62QNadG+AhlyMTZ9+15PZ0BUhfgYyZH2FTj6yEfnMncy64s+9jM8UDa7yh/JgKUyEPaYn8rT2spGVMiseMuZ5InFocUKPXD9+J5RHPPybWA2rofcjVuK++/efy/22xmQp1MXH6INlWGhXPQQqDgN33zlrD8fempsWYCubMSFQjgcf4ANfHlgDkjrqCQQKKaXtJQj/uL1vf9ch9qJg3cCmuyB2DPwwKolZPWaoFogqnrUFE8vkJ2O1Pxs95kYZRyDlcmICgv64OU28e7d1vgjmJW2ByW2285WcGIgtf5Z7Gnu6CWs0QWeqlT8y/0UcKe2j135lm+rYBV2OeTD0NlJDs/s/ULXPEQ0r7IDJLN/1RT/mDRpdiY7BDrCGd0mqg2z1Ficv29HpYQJNhYBkMMEMSK039iiKeSbu0yxSQKDljq2kH7zCa2G4yYI4ehPERs5aHjTo4PijN5F/AJqdwOD+SkmfXtiE21GJzfEP6VcP5YRSglK2tRmt8sLJHirnSb5yeHtYQ6nFl5PszlPmPUcY4nctUMGlIWyCiTI5QIyW3T8PYdiK2myyWcwUyGfGcy2tQpXF2cvJzhPQMXF3odXxeVyTDvCbFwfL3TMM55WR5ZPLX2AcVwBsafHKK4Z1um0ZmCaRRcoTNRJD+exUaqjpwJ9YY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(36756003)(5660300002)(6512007)(2616005)(2906002)(44832011)(31696002)(6506007)(8936002)(186003)(508600001)(26005)(8676002)(316002)(66556008)(66476007)(53546011)(66946007)(6666004)(6486002)(83380400001)(86362001)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enRKYU9BQkFWQUNJZG85RTRRWmFnMlhjblY0cTlPYkRRK0liU25YQ3NxRkZD?=
 =?utf-8?B?STJRSlN5YUtzRnZpakFCMDNTMTFWMW5pQkVqVHBSRysrb1IwSTVacXBIR3p2?=
 =?utf-8?B?dFEyTEZvT0xQL1lKcmFnaE1hZXJDalJUMlVDL1lVWlNROXFrSm1rQ2JhM2J2?=
 =?utf-8?B?S3VtaFoyTklDZUs0L1lDOHJMZFlUSW9LSmpGdTdEOU9Ua21ESUw5VitBRVdX?=
 =?utf-8?B?YS9sYTBsWUN5MlFGenFOL0tNQjZEN0tQRnVHNndIWnVPS1NhMyswV3pSVmlk?=
 =?utf-8?B?RCs0Tk5IL2ZkbERzQjY1Q2JudlE4NzY0ekkvQTJOdGRKaUlBbEprUHJkSk5N?=
 =?utf-8?B?Rmx0dFpwbzVZNGpkY3NLY0dwL2Q0YU1yZWFTYnpZWmhZZTJ0QXdrOXJET1hZ?=
 =?utf-8?B?cHVKenk3c1E0NjVuMmxhdEtZc3JSOFRIakR2R0VsbzBVdGxTbmlRckViT3Uv?=
 =?utf-8?B?YzN3cEwxVWQ2bnlmK1RSbXpSeU5iVXVWTEw3UGNCc1czaXErb2pjTjQxT2dK?=
 =?utf-8?B?bU4xUHJwNzR0SlJRL0R2SlErYnhBcWR3SmtrVVliaVljVDVqKzJmdGdiNGdy?=
 =?utf-8?B?bEowM1RNRnVJOVhtZVFhOTI4QWNCK0VoemxkcW1tRmpuWUtZSXVPbm1iYnFl?=
 =?utf-8?B?TFVDbDdBOXc3bFFaRWhlWDFTVkdQK01md1VWN0dIcE83Rlh2TWp1OFlrYXRU?=
 =?utf-8?B?VTNhTWN6dGNCOFB2REl4ZXlDV0Y1akI5ZTgwQnZWVjl2VG1YYU5oVDZ6VWFz?=
 =?utf-8?B?L1lXRVpqb2pwVEZiM1lST3ZYSGNNTUpwME41VkdySjFYUTVjVUJjc2RvNjhj?=
 =?utf-8?B?OUZUa3UxbFMxajV5SktWQU1ORHFKVU5DZ0UrZzJkb2pnTVd3REJjbGRMN0dS?=
 =?utf-8?B?Wm9BcWgwYlZWK0NPcEFmWnVKVWZ6YzJWcWhxazhFVHRZMEd4ZXoyd3RBckc4?=
 =?utf-8?B?YW44S3FVNGpObi84U1BSUnJiem1sRVFmQTNla1J0N3BvdmZaQzlCc2J0MUxE?=
 =?utf-8?B?eFBLZ1JtbHBHbEE2RGtscEdWdU1EQ24vaHRKUnBOczhYTGdwQ0RMVTljTUVm?=
 =?utf-8?B?eVUydE9rMUh6aWl5QjkwTFo1b2g3NFd2c1NtOVpmY29HMmhVNlVHMTY0TzFw?=
 =?utf-8?B?Tk9xZEljMFo4QnVuSEdjL3pjRURZdHR0eGFxeXZkZytuTFJSM2xuQmY0djdt?=
 =?utf-8?B?dnMzYk9pT244K1JsTERrOEdYTHE2eVZPcS9ZYTRndmxyRmFGcDMrZTJDRE1S?=
 =?utf-8?B?cWpvblN5Z2NzQVZYbWxWMUx2WlhBTHlHZytKNVRlbzVneU5UQXpPa1RsZjRE?=
 =?utf-8?B?Qnlvd1V2L1RWeEt3QzBhRS96KzMzekxFM01yK2dDZ0l0RU1hZjN1eEw5K1pM?=
 =?utf-8?B?K0VONER5SVprUjBDTjIvOEpCRTZWeWhCNFVrQVJ1a0dnZ2h5OE1ZMmlONFFW?=
 =?utf-8?B?b1hGclcrM1d1bUh5K1NPSzh4dlpQQTQrQ1RVWG4xMWF2TXBQWGN6ZzBRL0Vv?=
 =?utf-8?B?T0s2UE5VN1VTTXFLaVdnRWtyWk9xS0dNVE5ZQ3lWVGN3dnd3N3J2WHphWSs4?=
 =?utf-8?B?ekxHMnZrU3l2aFFvR1RmUEFTVDJLSjJLeTN5K05pbHNSR0lHMHp2UzZ2RnJG?=
 =?utf-8?B?OXdqYVRSdndJaXVrS2d1TThpZlRlajZNN2VZcVA2VXFWVERpcDhOVURXVTBi?=
 =?utf-8?B?eVkwK2ZmVi9GQ2ZDeVhFOTVpUTBtR2VydlNMMStzaFV5YzZDVlY1N21ZR2ZC?=
 =?utf-8?B?Z0VRYVJmQSttcmVxcjdHZi9yYWFRZC9tQ2NmRHo4S3ZDbVBuSkMxQ0pIZE1K?=
 =?utf-8?B?S2JCZitxckNCMjhZVmNmbG5kQ0p5elpwaUMwaWY1alpuL2xSTTcxV01mK0V1?=
 =?utf-8?B?czhNK3NPYnFhUlFFT2o4VUc1OWpSaUxpYzJFUVpwYXNIMGoxUUxKaGtwc0Ev?=
 =?utf-8?B?T3lrbWlIWHArNzUzODZIQlQ0c1VTN0gwTHNNL0Y4emxvZSswME9ycjE5NktL?=
 =?utf-8?B?bzB5ZkhlQ3ZWbkhFaGNSdnR4RGlBR2RGQkFRSTVzQUM5VjBBNCtmd3lVQTRm?=
 =?utf-8?B?QlJBSm82dkNWQWkwSUoxamwyQ2hTblcyYXRzZVRtSW14Q2s0UkNxSkhOWnBB?=
 =?utf-8?B?OXFpcDExUmJWVEFjQjBHdGFMZU9KNWpRS2hJY0NKZUZlL2Q5YitxbUl6cGlY?=
 =?utf-8?Q?LOYv98eYc6Z1uKL0pEobjCo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302e9d93-2347-4a34-2483-08d9d4068b04
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 06:58:01.9800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRSi7Vy/oqIbF18xo463pdN/qwhsyDTYbgNaF2DO41TsmXRHlMy1NGGU57EwcqdBRKoDzkD/bbB2mip1yzdALg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5171
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10222 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100047
X-Proofpoint-GUID: CPLRnC46eNwHhJJIAUQJ_h5a7Ccyp856
X-Proofpoint-ORIG-GUID: CPLRnC46eNwHhJJIAUQJ_h5a7Ccyp856
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08/01/2022 00:16, David Sterba wrote:
> On Fri, Jan 07, 2022 at 09:04:14PM +0800, Anand Jain wrote:
>> After the commit cb57afa39796 ("btrfs: harden identification of the stale
> 
> Please drop the commit id when referencing patches that haven't been in
> released branch, the subject should be sufficient.

Got it.

>> @@ -2405,7 +2406,12 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>>   		mutex_unlock(&uuid_mutex);
>>   		break;
>>   	case BTRFS_IOC_FORGET_DEV:
>> -		ret = btrfs_forget_devices(vol->name);
>> +		if (strlen(vol->name)) {
> 
> The full strlen() is not necessary, just check the first byte.

Yep. Will update.


>> @@ -1427,8 +1422,12 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
>>   
>>   	device = device_list_add(path, disk_super, &new_device_added);
>>   	if (!IS_ERR(device)) {
>> -		if (new_device_added)
>> -			btrfs_free_stale_devices(path, device);
>> +		if (new_device_added) {
>> +			dev_t devt;
>> +
>> +			if (!lookup_bdev(path, &devt))
> 
> This reads like some negative condition, while what we expect is "if the
> device exists and can be looked up" and not "if we can't look up the
> device". Please write it like (lookup_bdev(...) == 0), and maybe add a
> comment why we can ignore errors.
> 

Ah. That's much easier to read. Changed in v4.


>> +				btrfs_free_stale_devices(devt, device);
>> +		}
>>   	}
>>   
>>   	btrfs_release_disk_super(disk_super);
>> @@ -2659,6 +2658,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>   	int ret = 0;
>>   	bool seeding_dev = false;
>>   	bool locked = false;
>> +	dev_t devt;
>>   
>>   	if (sb_rdonly(sb) && !fs_devices->seeding)
>>   		return -EROFS;
>> @@ -2853,7 +2853,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>   	 * We can ignore the return value as it typically returns -EINVAL and
>>   	 * only succeeds if the device was an alien.
>>   	 */
>> -	btrfs_forget_devices(device_path);
>> +	if (!lookup_bdev(device_path, &devt))
> 
> Same here.
> 
Ok, I fixed it in v4. However, patch 4/4 removes it.

Thanks, Anand

