Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACDD4840C4
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jan 2022 12:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiADLZj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 06:25:39 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31100 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231163AbiADLZi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Jan 2022 06:25:38 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2047tpk7029856;
        Tue, 4 Jan 2022 11:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rm3rqV0BWgtetubSZKPmzOkJRGxjKgq0FB8dRF7FNnc=;
 b=JPF5gdin2Nk0Pnhkm9CecRRh0S6vIdagYX+m1EDUxEPowB2WUMDPdUKAIMzAQhSOyBu+
 AxQQ62IWXspe3wWtryp0cFbEdho2WI+xAXWjKFItBsCUmA5HwKMoDdI9luiYGXeRqQ02
 5RNEA/kLFk0dx/jPxbpdyNHf3K21GYFQ8VAhyMOnRnR+OgSxgsEn0HdRIb7zHp2YakEe
 /qktyRBjUelBomIaaMfrx41krHtRCsVm7V6axsNW8BuuprBcZTTyU2FLhg8V5et9OOeR
 NZIUYzvZz43ts0tKInaTW07D80U4MvPc+brKo/pns70D6KT2uovkeYGxRHIALVEJQ3+x Bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc8q7s862-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jan 2022 11:25:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 204BBaaU158564;
        Tue, 4 Jan 2022 11:25:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by aserp3020.oracle.com with ESMTP id 3daes3jwrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jan 2022 11:25:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMpGQPUnw9ZuoBKeYX38j9ds+v8bHmJsq6p4P0JdUiApAljyfaeLgohYDczOu6kUft7gy9bCjdCp8s4uFC2N0S7ZVdE1NhkniXRpa4OW75UAtdHIE2LNtP2OaLQz8S5FZV8EeNsyReH/Zj13HKsh/It1/WNFO6h0DU4FRaMYxAIQRm1K0p/Ecand20MzfmV2x9G8DJAFPgQaHJBbsviKQ9RLNSbpLXTKSfjhQRsb+0mbNp63WRPMl+jHggCs2J9H420OP/c4afDu4LSTgdO2EZupgnWqyiAhD3KEjWwqjhSeuIPiFn8q31Phk7bSmZoCv5VHrUtcV0LFeKujs0g8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rm3rqV0BWgtetubSZKPmzOkJRGxjKgq0FB8dRF7FNnc=;
 b=IPgIpzvuzLoDIBgHJGHD+LX+Bllu9yhrQNao3crQ7hbgPy2RlnVunA8rPS4X4woiTh0vSG3mXnHxQTzlHMWL+Cv/yAI0wI/5fj8Ly48h8Yfy7Pna44OwAtoy0EyY/SZMzX38r6zyOhkVp2LJ/RQ/zyvXcmQ1ZZPVkhnrpMGFspFedg8+/ij7C5YMdn2/dci/OGrpanhguXG2+96QPN0fIm5luYcs0VrQ9epOob5zGmgF5ElxXSuRfNAK5rZzKj3XmfSXAUQnCH8NLbznqhHuUGvXYSAv2srhqQ7OGblkgwEgJnnXRfGoch4QeYQrb3aSkwMIK8rYZ966giE61mI67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rm3rqV0BWgtetubSZKPmzOkJRGxjKgq0FB8dRF7FNnc=;
 b=j6jOMz5+1c1A9zACIxfFaIg+5l+GE27i/GzcxtrgOkqmrZkoRrxsnC/Hblyq6+AVyI9e3H8qNDyLjI9u0cu1dtwOOx9jrpGdt3GNgxAtfgxvYn+ZQmg2REvnWfTJivdkT7JqWvNehT51t82KqLMAjtCqvgyHlVoANO5P2c5GUa0=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5092.namprd10.prod.outlook.com (2603:10b6:208:326::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Tue, 4 Jan
 2022 11:25:28 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 11:25:28 +0000
Message-ID: <765bf2fb-8af0-9459-b759-7a8d39d872c5@oracle.com>
Date:   Tue, 4 Jan 2022 19:25:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2] btrfs/254: test cleaning up of the stale device
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        josef@toxicpanda.com
References: <61c0bd3a345d8cb64f1117da58c63c2cd08a8a2c.1639156699.git.anand.jain@oracle.com>
 <Yb87dkizAxoqC+1c@desktop> <6a78d167-3f7c-1f9e-49d4-399203c52232@oracle.com>
In-Reply-To: <6a78d167-3f7c-1f9e-49d4-399203c52232@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47caea31-e1a3-48ad-275a-08d9cf74e8b2
X-MS-TrafficTypeDiagnostic: BLAPR10MB5092:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB509200196232CB1968019012E54A9@BLAPR10MB5092.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +nPQqm54jHYof0ppc9vfmf6tLhZo6r4I/nfOf9IOwbgHPBP/TxVZ+QLPE9wqjQuAgDz3Q6ptAIjCGZzfjeNY2M4er+ZfDI2zUcN9NlundGHnAoLWW7aNZXlxSfWEbAEbKAaVpqVLLZg8HZQu6KQlsC1bRAuf575lJJRAzMDwfZH0iIpuf9QzP5s1RpKo1oFcubxdURQYT8sHsawUHPB7qc0siCOJ3p1/oMlpTtrMjZpI+WmqD4OvKgI4ocaGQjmZeZr+bbrUrvylJqaAUsAt0gy1kXDKlcXrBiRbWSh4mk7jYHxteVfqV+V9/8qzqHD1q7tnKDh8JDPy3YuGt2B6Eo6HVWyEztAs+yXw62WC985hfLsXPaTlrBAcYGaciFk1rnwLYt/GLNI2RZ9LVB9A6+a6a4ecjwh7IJi3NuyIwl1pg+nf1m4TuVh9WD/IxA4neQaPSkFeHUg4BnkI+86kWEzuqXva8Qx1vfUvgLFKG+yOWgAMBTcEanub5wBnIuCKR/OGiupvWjPa4yVhJaBURNQXcQD0yHwB1t9B6FrdTv7cfq8EV/ch5R0CKoDM7xDzp8B38gG7k8qJPdQ6wII5tOjWmBRW0vuFaCqNDw2ed/SSoq+hkLdfPHgbnW2f/fkzl9/rnz1dMjld0O9bGNjQRO8/y5Fej3HjSeJYzZ72U5sh93xCh9RayJoGgCdokLDho+ZRlDLApJZ5/EwN5+6RvoymGtY98Yd4on8ogyeDhXIBNteiFAcN0u7dm/4D6F9hnOpwCsbzykHthDPpQXqfbziVQoGWf9o/cFUkq+4/b5wTu4vJ8bu3piPdD3tIw9Md
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66946007)(6666004)(2616005)(5660300002)(38100700002)(66476007)(186003)(966005)(6506007)(53546011)(508600001)(66556008)(2906002)(8676002)(31686004)(4326008)(6512007)(36756003)(316002)(31696002)(86362001)(44832011)(26005)(83380400001)(8936002)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1lnMjQ1Vm9tTVBCWTNjY0F4V0NqbHN2OTBGTU40UGVQajRVQXJUUDBvUDBK?=
 =?utf-8?B?YVZYSlFjU21oOWo5UEF2QzJZRS9vSFdubnlTcXVpZWNwb1lwcTZ6dFA5cWNW?=
 =?utf-8?B?WXVrYTFKaEVkR0JtY1FYRkw4WkU1Z2ZWaVhkN2o5VERxSi9Uc0FURk9DRlJF?=
 =?utf-8?B?MlIxUWZuOERZRENydkxsalIrREQ0Y0crbzZ4RjJ3UkNjOU9oTklvRXFFdDAr?=
 =?utf-8?B?RUhkRGYyT0VYZUw3Unk2OUdpditEMlJvOXVPSHJsNjRJek00bi9BOTJFWFk0?=
 =?utf-8?B?dGVaVk04RGdIVHRmN0YvQXhWNy9welUvZGxmR2FWbjgydUJMV2kvc0IrakNj?=
 =?utf-8?B?SXdUU1Y2TStRKzFQajk5QlZ3cGdLeWhOb3B0K0creHB4eU9wN1p0RlBveGYx?=
 =?utf-8?B?cEtEYmhTbEY4VkxRKzZ5Sk95dXA5K1pwemd5elpNeHNOaEtidmsxZUpQbTV4?=
 =?utf-8?B?dDQrOUFMblRFRmN4dkx6aXpkNCtoRUd1bWwyNEdzMjlQR1d1QUlVRllxYVEw?=
 =?utf-8?B?clZGQ2ZVbHlmZkVFSENmbkhpUkdpSjg0RmEvRmpZckozSERXblVDUHh2dEFD?=
 =?utf-8?B?bGh6QlZaZ09aMnVrN0JhZ1hjeENra0tlT25LSkIrSG05aU10TjI0SGczTHZD?=
 =?utf-8?B?VzI4bzFPd3EyZFpFZ3Vyc3h0bEJWbDdrckF3dGxEQ0c3R25KbnRvYTFEQmYz?=
 =?utf-8?B?RjNNRG5BQTZvSGU1VWZLUGk3bE5Fc29uVC96dGNPRW5iaUZMcmpZd3pvYlZR?=
 =?utf-8?B?K1V3QkdGUDh3VVJkcko2bW9oWlhqdnBSTHBwL3dpemxKTEtJNy9lQ1J6ano4?=
 =?utf-8?B?VzJ1M3NORjBUWG5Lc0JEWnlmVTQ1QkNBVmRFZEF6RllDUER0MTZhbDhub3JX?=
 =?utf-8?B?RVBabUdINFVvM2ZFR1daNis0a3lUbjB1QXJDenVSTW1qVUxFa0g4TklyRTF5?=
 =?utf-8?B?aEhyd0dDYnVkZDBQRCtrWmdJYzRmL0RPWFB6VStZWVdKSGJjb2Rldjg3aUht?=
 =?utf-8?B?WEdCNEpmQitYb0NpcERRYWl4anlYbHg3R3ByeU9GSi9aMlRLUXhJUFErQTVq?=
 =?utf-8?B?cWxYaTY4RFkrMXoybUxGbzYra1NNYlAyWlRqaG9POUFaQzBoTnB4MCt0ZWJa?=
 =?utf-8?B?Z2xoTStPWCtFNlBMUDhXSkduVDJBYXJsVXVaekxLc014UUJrN2hzSG02aHRV?=
 =?utf-8?B?bkg1endmZjU5Vm1FQzB5S0dHSWgxSlVOLzNwNGRsS290UUcrQ1A3NURZc1ZO?=
 =?utf-8?B?N2pYdi9wblVBbjJtQXhlUkRvOHZMb1IrWk5CQ1Y3Q0hiOFd5eWJPL0owTXZS?=
 =?utf-8?B?cUpmczd3a25XbXJJR3RBSzZFSXR5N1VSaDhpUXNEb05ucWJ6SW53N1Q4ZkhY?=
 =?utf-8?B?aFhTNU02eVhzYmNxZGN2UWRyQVRXOVQ4T3JjRXh4TStUNU9oNHlzTVk5RHdU?=
 =?utf-8?B?dEQrUmkwQitUay9JUnE4c2tmb0lPOERaRWFVckFxMEdaS0dSODlwYXNGQ013?=
 =?utf-8?B?MWJxZXd5ZzhvbU1sMUoxUW5kcjlIVnZML3hrQ0M3eXhzWjRSY1N1d25iREk1?=
 =?utf-8?B?MDJjTXI3V0d5enBDOEZ5Z1BPV1FQbUVCRTNOeVBRTDRPSDFTVEVjSlByZndr?=
 =?utf-8?B?V0NtQ3RwbFYyNjdtRGpNeGtFcDYrZUYxNng4U1JrU0hRUmtFQWlTVHdYT0pv?=
 =?utf-8?B?U2dxd3BmQjgyYkw4ZUUxYnoyNW1ZcUt4WkZFNkVjVmVCQzR0WUFUd1RxNHY1?=
 =?utf-8?B?bWx1c3QwWGl2NU4xK1dJR0JoZGoweVh1dDZhdVRqYWNSdmhOSTI5YU5YaEpU?=
 =?utf-8?B?aTVNMERtNW9sTU1PMlVtN25QOFkyQ3RWeFhIRVZwcUhRbnU5bDVDVm1lSHNJ?=
 =?utf-8?B?RENBZW1NMUxuS2QwMy8yd3NvVk42SGFubHN3Y2ZVM1B5dmJQNGtLazB4V1N1?=
 =?utf-8?B?YW9TSGZXcjFTOWp5NVBtUDk4amVnNGIvUHdZK3lGaVZrVDcwcmcwNHdMMlNY?=
 =?utf-8?B?dHk3S3ZDMkJUY2I5cmVDU1orbHlzZGUzZnhZTUw3dTArUkQ3NkhOSW84STN1?=
 =?utf-8?B?OXN1V3pOYkpNdVdTY3ZQcG1yT0Q3eVlxZUFVRytWaXgvNUdSWXczaVUxNmkv?=
 =?utf-8?B?bjQ5L1RCMHBVVFArMXFTa3dlM3o3bkdkUU8rT2NzdTNmd2pVR2FhNlUwRGVj?=
 =?utf-8?Q?cgtlAnaOh4x8ee1xGOmOM8w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47caea31-e1a3-48ad-275a-08d9cf74e8b2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 11:25:28.0843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8gxNPTy4XmLaRQ4uZns15JdtPZ329O4zjsF0+HV26DnuRBB1sMUxR9XY3WwYL17rl5aIezg13VRVYTLwAHFAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5092
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10216 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201040076
X-Proofpoint-GUID: 1uiGqGvNAGGW-fIOdxFawIBwl7D9TKNr
X-Proofpoint-ORIG-GUID: 1uiGqGvNAGGW-fIOdxFawIBwl7D9TKNr
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Gentle ping? More below.

On 20/12/2021 19:06, Anand Jain wrote:
> 
> 
> On 19/12/2021 22:02, Eryu Guan wrote:
>> On Sat, Dec 11, 2021 at 02:14:41AM +0800, Anand Jain wrote:
>>> Recreating a new filesystem or adding a device to a mounted the 
>>> filesystem
>>> should remove the device entries under its previous fsid even when
>>> confused with different device paths to the same device.
>>>
>>> Fixed by the kernel patch (in the ml):
>>>    btrfs: harden identification of the stale device
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>
>> I was testing with v5.16-rc2 kernel, which should not contain the kernel
>> fix, but test still passed for me, I was testing with three loop devices
>> as SCRATCH_DEV_POOL, and all default mkfs & mount options
>>
>> SECTION       -- btrfs
>> RECREATING    -- btrfs on /dev/mapper/testvg-lv1
>> FSTYP         -- btrfs
>> PLATFORM      -- Linux/x86_64 fedoravm 5.16.0-rc2 #22 SMP PREEMPT Mon 
>> Nov 29 00:54:26 CST 2021
>> MKFS_OPTIONS  -- /dev/loop0
>> MOUNT_OPTIONS -- /dev/loop0 /mnt/scratch
>> btrfs/254 5s ...  5s
>> Ran: btrfs/254
>> Passed all 1 tests
>>
>> Anything wrong with my setup?
>>
>> And if tested with lv devices as SCRATCH_DEV_POOL
>>
>> SCRATCH_DEV_POOL="/dev/mapper/testvg-lv2 /dev/mapper/testvg-lv3 
>> /dev/mapper/testvg-lv4 /dev/mapper/testvg-lv5 /dev/mapper/testvg-lv6"
>>
>> I got the following test failure
>>
>>   QA output created by 254
>> +ERROR: cannot unregister device '/dev/mapper/254-test': No such file 
>> or directory
>>   Label: none  uuid: <UUID>
>>          Total devices <NUM> FS bytes used <SIZE>
>>          devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>>
>> Maybe we should use _require_scratch_nolvm as well?
>>
> 

> The test case is inconsistent because the systemd-udev block device scan 
> interferes with the test script. There is no way to disable the 
> systemd-udev scan (that I could find).
> 
> The same inconsistency (due to race with systemd-udev scan) would 
> persist with/without lvm.
> 
> So when the race fails, the test case is successful to reproduce the 
> issue. As you saw in the 2nd iteration.


There isn't any approach to stop the test case from racing with the 
device scan, so reproducing the issue is inconsistent. As we have had 
some success so IMO this test case can still integrate, it will help to 
verify the kernel fix on some systems.

More below.

> 
> Any suggestions?
> 
> Thanks, Anand
> 
> 
>>> ---
>>> v2: Add kernel patch title in the test case
>>>      Redirect device add output to /dev/null (avoids tirm message)
>>>      Use the lv path for mkfs and the dm path for the device add
>>>       so that now path used in udev scan should match with what
>>>       we already have in the kernel memory.
>>>
>>> -       _mkfs_dev $uuid -draid1 -mraid1 $dmdev $scratch_dev2
>>> +       _mkfs_dev $uuid -draid1 -mraid1 $lvdev $scratch_dev2
>>>          # Add device should free the device under $uuid in the kernel.
>>> -       $BTRFS_UTIL_PROG device add -f $lvdev $seq_mnt > /dev/null 2>&1
>>> +       $BTRFS_UTIL_PROG device add -f $dmdev $seq_mnt > /dev/null 2>&1
>>>
>>>
>>>   tests/btrfs/254     | 113 ++++++++++++++++++++++++++++++++++++++++++++
>>>   tests/btrfs/254.out |   6 +++
>>>   2 files changed, 119 insertions(+)
>>>   create mode 100755 tests/btrfs/254
>>>   create mode 100644 tests/btrfs/254.out
>>>
>>> diff --git a/tests/btrfs/254 b/tests/btrfs/254
>>> new file mode 100755
>>> index 000000000000..b70b9d165897
>>> --- /dev/null
>>> +++ b/tests/btrfs/254
>>> @@ -0,0 +1,113 @@
>>> +#! /bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# Copyright (c) 2021 Anand Jain. All Rights Reserved.
>>> +# Copyright (c) 2021 Oracle. All Rights Reserved.
>>> +#
>>> +# FS QA Test No. 254
>>> +#
>>> +# Test if the kernel can free the stale device entries.
>>> +#
>>> +# Tests bug fixed by the kernel patch:
>>> +#    btrfs: harden identification of the stale device
>>> +#
>>> +. ./common/preamble
>>> +_begin_fstest auto quick
>>> +
>>> +# Override the default cleanup function.
>>> +node=$seq-test
>>> +cleanup_dmdev()
>>> +{
>>> +    _dmsetup_remove $node
>>> +}
>>> +
>>> +_cleanup()
>>> +{
>>> +    cd /
>>> +    rm -f $tmp.*
>>> +    rm -rf $seq_mnt > /dev/null 2>&1
>>> +    cleanup_dmdev
>>
>> Should wipefs in cleanup as well, otherwise test fails with non-unique
>> UUID
>>
>> -Label: none  uuid: <UUID>
>> -       Total devices <NUM> FS bytes used <SIZE>
>> -       devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>> -       *** Some devices missing

>> +ERROR: non-unique UUID: 12345678-1234-1234-1234-123456789abc


  We don't need non-unique UUID. I have fixed this in v3.

Thanks,
Anand


>> +btrfs-progs v5.4
>> +See http://btrfs.wiki.kernel.org for more information.
>>
>> Thanks,
>> Eryu
>>
>>> +}
>>> +
>>> +# Import common functions.
>>> +. ./common/filter
>>> +. ./common/filter.btrfs
>>> +
>>> +# real QA test starts here
>>> +_supported_fs btrfs
>>> +_require_scratch_dev_pool 3
>>> +_require_block_device $SCRATCH_DEV
>>> +_require_dm_target linear
>>> +_require_btrfs_forget_or_module_loadable
>>> +_require_scratch_nocheck
>>> +_require_command "$WIPEFS_PROG" wipefs
>>> +
>>> +_scratch_dev_pool_get 3
>>> +
>>> +setup_dmdev()
>>> +{
>>> +    # Some small size.
>>> +    size=$((1024 * 1024 * 1024))
>>> +    size_in_sector=$((size / 512))
>>> +
>>> +    table="0 $size_in_sector linear $SCRATCH_DEV 0"
>>> +    _dmsetup_create $node --table "$table" || \
>>> +        _fail "setup dm device failed"
>>> +}
>>> +
>>> +# Use a known it is much easier to debug.
>>> +uuid="--uuid 12345678-1234-1234-1234-123456789abc"
>>> +lvdev=/dev/mapper/$node
>>> +
>>> +seq_mnt=$TEST_DIR/$seq.mnt
>>> +mkdir -p $seq_mnt
>>> +
>>> +test_forget()
>>> +{
>>> +    setup_dmdev
>>> +    dmdev=$(realpath $lvdev)
>>> +
>>> +    _mkfs_dev $uuid $dmdev
>>> +
>>> +    # Check if we can un-scan using the mapper device path.
>>> +    $BTRFS_UTIL_PROG device scan --forget $lvdev
>>> +
>>> +    # Cleanup
>>> +    $WIPEFS_PROG -a $lvdev > /dev/null 2>&1
>>> +    $BTRFS_UTIL_PROG device scan --forget
>>> +
>>> +    cleanup_dmdev
>>> +}
>>> +
>>> +test_add_device()
>>> +{
>>> +    setup_dmdev
>>> +    dmdev=$(realpath $lvdev)
>>> +    scratch_dev2=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
>>> +    scratch_dev3=$(echo $SCRATCH_DEV_POOL | awk '{print $3}')
>>> +
>>> +    _mkfs_dev $scratch_dev3
>>> +    _mount $scratch_dev3 $seq_mnt
>>> +
>>> +    _mkfs_dev $uuid -draid1 -mraid1 $lvdev $scratch_dev2
>>> +
>>> +    # Add device should free the device under $uuid in the kernel.
>>> +    $BTRFS_UTIL_PROG device add -f $dmdev $seq_mnt > /dev/null 2>&1
>>> +
>>> +    _mount -o degraded $scratch_dev2 $SCRATCH_MNT
>>> +
>>> +    # Check if the missing device is shown.
>>> +    $BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
>>> +                    _filter_btrfs_filesystem_show
>>> +
>>> +    $UMOUNT_PROG $seq_mnt
>>> +    _scratch_unmount
>>> +    cleanup_dmdev
>>> +}
>>> +
>>> +test_forget
>>> +test_add_device
>>> +
>>> +_scratch_dev_pool_put
>>> +
>>> +status=0
>>> +exit
>>> diff --git a/tests/btrfs/254.out b/tests/btrfs/254.out
>>> new file mode 100644
>>> index 000000000000..20819cf5140c
>>> --- /dev/null
>>> +++ b/tests/btrfs/254.out
>>> @@ -0,0 +1,6 @@
>>> +QA output created by 254
>>> +Label: none  uuid: <UUID>
>>> +    Total devices <NUM> FS bytes used <SIZE>
>>> +    devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>>> +    *** Some devices missing
>>> +
>>> -- 
>>> 2.27.0
