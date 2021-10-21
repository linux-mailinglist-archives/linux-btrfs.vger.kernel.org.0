Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE95435D6A
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 10:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhJUI6T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 04:58:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30616 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230269AbhJUI6S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 04:58:18 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19L7Tq3a016734;
        Thu, 21 Oct 2021 08:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kXjsGEoGCHvniNmdMjF2NGq8Kn/OBlgksSahQqIyqMM=;
 b=o4gFlVRPC8f1qGkQd/3tp0PPg0veu60J0+VWLWDkq8S3CJL0IZiH+mqGODwQ4DpsqenB
 al3tES+9qCrVZ5boDIpwBsEtIX+jjIIUUzfji67p2aw5Z80BOvs2qdQ4CEZDBUhSM50R
 DslNhvE+korCFCd4LLFv7SUcqP0avdfarSABGkmqyhXTrrTL7H1ynPngjmaABt+EZKNi
 8LbI3/6fCgbT76ouU0lzpfkUT/oz8KbwCaFRlW/ZjWVo0n44eM6Qw1ZADRpE9v9nZMm7
 0mmWcSZgbrddGmOqcJwLpu+4xWobnltv9mR4sU5EXLeccnf6i6/1rwmitGHcbcCK25KA gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkwj52ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 08:55:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19L8ou3T124799;
        Thu, 21 Oct 2021 08:55:53 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by aserp3030.oracle.com with ESMTP id 3bqmshsfqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 08:55:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtWmpJ/YBGxXJJN9xlbif3KgW40sbDbVonh25vi/fBRFSWwc6/rRF5iN8MeuyAsG6t5BH5469GgLNUI9zs6aICaDTfA/AuDK71zKAow5513LZk2d95BGKfGhcdTSf+ddSDi0Cp7d9s8e77VTyv7qwSnen4Kt/pVfWCcRV3WMn+kdHhIL/4pRrzQuP1bhxvF8zMiQONk3jrmnRQh5vqYSyuoobA6S1zxbeu49w1hqLGUj/ERmQXI3JdspCoH2NaEMKk9B82OJflDxfqz9BAtkR4dv08TCqoOJMERFJd2Gg/afYdzfC99ft+1GUnhirm+I51jX8wd6tGS92TvG3btezg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXjsGEoGCHvniNmdMjF2NGq8Kn/OBlgksSahQqIyqMM=;
 b=DKdcm7RjPFn9WiXvh3hk8sBW2N4Oh6NWDT0pKRe5H7c9D3i/qyzdWocHcfIZC9eNRZbhp43vfJJiiYuvIoGCs0kdVrMTnKuKo3aInk+gv0Dcm6lptu59fr3oj4aE+uhoT7vAb1RxAKDNSiYcK/qNiZuvOY/UYFZrIBEpFqnGn2zwD+k6gXb6LQeDegI0Eqh5xjnvdFLDjUsJDGZQTqAMOM6olmqKKSOBtL4YZ/IKgptAJwCQduEadFYum1lo1WYIuWP/6HD0GNGSvZhcKk4c4ZiHNuykxxnK4vI97vTuYkYTwiV5m0TOHm7+YM4Uaq3flP8r0p2mj/pmLIyKdX8HOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXjsGEoGCHvniNmdMjF2NGq8Kn/OBlgksSahQqIyqMM=;
 b=OngF1RTWFWMvFZtJctaKrVJUpHyiPqICx82GNM1t+Q426Q4UA5ITm7zQ7cEDL24M8lguszr/P6LGZVRwmKARNl3w1HKOajIFddu3/KdMI+Waj3Rr1OkvO1QuM0So1crh9+dUqytBJk7Voh+/fnpwC2au++UYSN9OjhKkm7/knP0=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4239.namprd10.prod.outlook.com (2603:10b6:208:1d5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 08:55:52 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 08:55:52 +0000
Message-ID: <616b83ff-8320-185e-1c8b-a8a0ebe77e8f@oracle.com>
Date:   Thu, 21 Oct 2021 16:55:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] btrfs: sysfs add devinfo/fsid to retrieve fsid from
 the device
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <cover.1634598572.git.anand.jain@oracle.com>
 <7df68f272490c55349b44a33dd7ac19ccf87560f.1634598572.git.anand.jain@oracle.com>
 <20211020185929.GC30611@twin.jikos.cz>
 <12503a1b-a28f-cc26-f07d-0914d6952207@oracle.com>
In-Reply-To: <12503a1b-a28f-cc26-f07d-0914d6952207@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0136.apcprd03.prod.outlook.com (2603:1096:4:c8::9)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR03CA0136.apcprd03.prod.outlook.com (2603:1096:4:c8::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.13 via Frontend Transport; Thu, 21 Oct 2021 08:55:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b17edd5d-661e-492b-f56f-08d99470954b
X-MS-TrafficTypeDiagnostic: MN2PR10MB4239:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4239C6848173701F575478C2E5BF9@MN2PR10MB4239.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GRu/9BXGa4Jn/snsdF50Q3yMZZZxjv0FFE7BHxLEcz4mX1HIErfsiBgZrBJwTHkPPcSsAGGapH/kAYMzruL2T/QYNdddjcOcS1W5CiBOj/pp4xtmzNOb9+6gSIYRENpwd4r4EQHF60pcecsc829rCB4zQj8luEJC68cFyrrAwl8cJYctapSWorA3yYKVlQHyfI+7d+4oW0cGgF6dvhKVAunwxLcDnM/IEwbrAVxMBqU4S9yZApxg5o4p2h67w/YQ2XsiFqV/vaG6km/bgl7h+xlWlSa5RFqDbdvyPkU36QHM2sImFP5fgvD9YPGSBwnqZvhRxm9pSoletC7QaOEALdrJD/8bkKcDV56HWgMw2j7kmhQDhVdoZYZ07JgtdcnjP7H674UkzM24cksrCPgv+YQ1OnWkSkLHHJ81k0tQa+jGyXdmI5ySvk5+RjsV767I5RCJKrxcAlxNAL1sKX7sVgIv/GYfaeuLgsMZawdbsr7EY1FRt+Q+kcVGd7Tzp1h+bjKBdn22ykeNR5+QGFkmck1YB6YaK2Th3cLtPv0c/Gb9iAxCuxJs1N/6ysOnqeaypdsR3wwIc3y45y+UXvlncMSuRYgaiVxLWIr9nnsiH7xTXOdGfXDTXIKNDmE0PtqNPeyayZEFj7buHtaAXVrO+bVVqd0CmiJnzRHOm9G1SfnZq2QpN7IYKGw1aRTaa6LE3xJgtiI0g7R4I2EZhFrFa878b/90+uj0OFev444b5wk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(508600001)(66556008)(6916009)(83380400001)(66476007)(53546011)(66946007)(4326008)(6486002)(956004)(2906002)(6666004)(26005)(16576012)(5660300002)(8936002)(186003)(44832011)(31686004)(36756003)(2616005)(86362001)(8676002)(316002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3RHMGp4c1g3cnFqNkZOMjI3VkFoMUJMdnYwVGJaUnRRSTR2WjJTczhkTlVt?=
 =?utf-8?B?NEdXSG85NVlqTjN2OVovN1k3N2pwYnl5WElHZ0hldS9rTE51YjlESitNeklh?=
 =?utf-8?B?cVZ5MDBESlRxQ3FPZC9OUVVhdzJudW85NGJtM2hpRllJT05TQVNWN3VMNjVh?=
 =?utf-8?B?dkZtNG1ZZ05sUk9zN1B3dm1INE1qVnIrVm9mYlBDcWFLOE80V01FSFhUVlMz?=
 =?utf-8?B?MFhjOW84bUhqc1p4VmpTZU8zTGxkRU9RVkh6R1ZSMzdGb1FYV0lBUVQxazkr?=
 =?utf-8?B?c2twU0JoZmZHL1F3Nm9EQllnM2t2UisxMEF0MVFTTFI0cVdvUWVVVktnMWZ5?=
 =?utf-8?B?MUxMeGwwemdrMy9XRGMvVlNjSTk4dW5Ld29KWmZsUEZOWkp6NHF4Ty9QNTg2?=
 =?utf-8?B?eWlpbm1MbFVSNDZWVU5GVzdEVVJHWTNJVVVqYWlENm5LaE9WQUhLVjVoWUpU?=
 =?utf-8?B?cGpFL09aZHJxQzBGN1V1ZXgxdmFOSDlZM1RCdGdZY0pEYk10RkJsaitZSTYw?=
 =?utf-8?B?c3hvQ3prMkVNWElUdFZVSm1EdW9tRGpTQWlyRFdpUUp0Rkg4SytiRDZOMUVH?=
 =?utf-8?B?WHhZZFd2aTMxNEdBaFlVcGdKbFpPVkNMQ2pNQnFpL0NyUXp5MTZWLzlhUjZa?=
 =?utf-8?B?OW5vbGlIcGdHTkROUWdpWHRHMUNLN2VOM3YvWlFIdTRlNlFiRy8zclhLUFkw?=
 =?utf-8?B?NHF3ZEtVWG1GTjlidlhLSkkxM3dDcExVVjlzTGhYMEg5UFV1dmh3TzlrOTB2?=
 =?utf-8?B?cUhwNU1oSGZ4cVZHNVpFaGtRTVF3UFNZbHpQdkNMR0hYL0taR2F2dVFmWFNv?=
 =?utf-8?B?OGpYQWdBZjkwSTA5ZE9BMHErRFE4NXpRWUNPWUpDZVp4KzhPS1FCY1ZnRy84?=
 =?utf-8?B?TXE2OUEzcDRNWVkxT21rajVTYU1zVHFoQjhveFVDeGlIdXpqTHJPNE1CNkhO?=
 =?utf-8?B?bWtSK2VrMFhWOHdBUUVqUG4yakJIcWZEZHpqbnJRVDRKWGpsZTlMUUlZdTJr?=
 =?utf-8?B?d3VMZGNLK2c0RlAydnVsVUZjdnB3U2JlRnpXMVBrT2RSK3A5TVVNdFJwL2JN?=
 =?utf-8?B?L0FQZk1LbWFNZ2tCcDFRdkpZMUdrNGRBNEduTXJjSHNvc0lBTVFMa3NqL2lG?=
 =?utf-8?B?aTNWRUVNeXd1R2dRaXRnMEhaTTQ3RUpzOWFpcjg2b1grdDZIN3BGUm5JMy9v?=
 =?utf-8?B?UkEyMUFGSlArYkduT2R4U28ycGZieWxsUGViTGM2MVNmSWZlU2RuMElKMjNh?=
 =?utf-8?B?MnZLcExiaU1lbkhubGR2eEViY2xWYkZFRHFxNWRmcTBOZllyVVdDU0FMd0Z0?=
 =?utf-8?B?S0czY0tyMEM2Vm5FOWM4ampXcEhLbUxNb1MweTRxNjZCZ0lOR3F0eUlQeU5s?=
 =?utf-8?B?Z0wrVWNWK0NzbE1RU0pxWmp3cjc2M1dFV211V0hGbjhNSTUzY1dxUDdYRmhJ?=
 =?utf-8?B?VlN0TVlNNHFiRlUvUm5LS1J5TFJ0OFRuRkVUdGpvcUM3U3FrVWsrNmkrdHRE?=
 =?utf-8?B?Mm5rbFlVNUN1cHZ3L2h3dGpSNnpvQkdmRnB5bnlSa0Uyc2RGb3V4ZElLajZz?=
 =?utf-8?B?WEJubTJwaTlIMHd3V0tDd3pDZC9GQ0NPV2JOOUYrdVNPcDg0NzN0bXdMOEsr?=
 =?utf-8?B?S25ISnh5UmNvQ1RVWUdzSzJsM0ZpZm5MTUhsc1JwRFdRZGZLczVDOXdER3ZF?=
 =?utf-8?B?TzlVQ0Y3MGF0eHMzMm8rTnR1TDBPZjE5MThpYkZvaEV4STl0eldpUUpPTGRm?=
 =?utf-8?B?MnQ0dldZd0ZQMlIwSWRQVGd2NzBvNUZQVHpUbk1wZ2p2Tzg0ZnNENGJqbC9B?=
 =?utf-8?B?OFBCVjN1bCtZWUQrdnpnSVJUT0dyaDlHKzR6Yis1VFdvTGVyR0FWdjlKeFZ4?=
 =?utf-8?B?TVllMFVEY3ZGTExaRVBpZzd0eDVPQUxqQndMNUFuUDVGV0NNaFpLUGZBK3N2?=
 =?utf-8?Q?baptljqrISk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17edd5d-661e-492b-f56f-08d99470954b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 08:55:51.9970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anand.jain@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4239
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210043
X-Proofpoint-ORIG-GUID: rjDnKrTW_PmI-kLL_g1aWRUQe4FQOn6r
X-Proofpoint-GUID: rjDnKrTW_PmI-kLL_g1aWRUQe4FQOn6r
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21/10/2021 12:03, Anand Jain wrote:
> On 21/10/2021 02:59, David Sterba wrote:
>> On Tue, Oct 19, 2021 at 08:22:10AM +0800, Anand Jain wrote:
>>> In the case of the seed device, the fsid can be different from the 
>>> mounted
>>> sprout fsid.  The userland has to read the device superblock to know the
>>> fsid but, that idea fails if the device is missing. So add a sysfs
>>> interface devinfo/<devid>/fsid to show the fsid of the device.
>>>
>>> For example:
>>>   $ cd /sys/fs/btrfs/b10b02a5-f9de-4276-b9e8-2bfd09a578a8
>>>
>>>   $ cat devinfo/1/fsid
>>>   c44d771f-639d-4df3-99ec-5bc7ad2af93b
>>>   $ cat  devinfo/3/fsid
>>>   b10b02a5-f9de-4276-b9e8-2bfd09a578a8
>>
>> How do you create such setup? I can't reproduce it.
>>
>> The simplest seeding:
>>
>>    mkfs.btrfs /dev/sdx
>>    btrfstune -S 1 /dev/sdx
>>    mount /dev/sdx mnt
>>    ... the device has the same FSID as is the sysfs directory name
>>
>> With a new device and removed the seeding one:
>>
>>    btrfs device add /dev/sdy mnt
> 
> At this step, we generate a new fsid for the writeable FS. Let's call
> it sprout-fsid. (If you check the sys-fs fsid, you will have two fsid
> here).
> 
> Also, at this step,
> the
>      fs_info->fs_devices->fsid
> changes from seed-fsid to the sprout-fsid.
> So, we should make the <mnt> also a writeable without the need to call
> 'remount,rw' explicitly IMO. What do you think?
> 

More importantly, the fs_info->super_copy is of sprout device.
So there isn't any reason that we should maintain the new
sprout fs as readonly after the device add.


>>    mount -o remount,rw mnt
>>    btrfs device delete /dev/sdx mnt
>>    ... both devices have the same fsid as well 
> 
> 
> Thanks, Anand
> 
> 
> 
> 
