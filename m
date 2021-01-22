Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801C42FFC62
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 06:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbhAVFxV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 00:53:21 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:59052 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbhAVFxN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 00:53:13 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10M5ftjR041717;
        Fri, 22 Jan 2021 05:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=eRWcjbsHh6QZ/C6/MXPkvjlx2V14dOxYXXL4scZoVYM=;
 b=EpmComCjO9l0vK8zkjYf42bqWSzZxHdmfCDZY18IeB/Y1lVwOmTDPW3J4+PgzM4KxsIT
 noAdZE2WF7GV0PhONn3ea/IVvG59s0bxVg3/tzAp+XjqPE0Vxyo3VG/KjxJjutLUOYP3
 y/029C4PUbKc2pXPDqy2WK0sUW0PwOx4jhV6pKc4SewkyYMHG0aiNiIvCDmlU8DWL1l+
 MacItw5K8fH0GoUzdxI/fnKB2qAhlVgHhz3cIT9lLVFQvZ3fm68S1mXI7ozlEjXf4l59
 ex3CrkKxcmDW+XV5CpmEAb5MpPYZAYWFwCwVpzJ0BZA1+4ICV+YU4nySWuG/joEsJvmd LQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 3668qrjgnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 05:52:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10M5Ytq8116210;
        Fri, 22 Jan 2021 05:52:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3020.oracle.com with ESMTP id 3668r0dc5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 05:52:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGcA2BupYMKVWQV1GAFv2ZNkvxp0lq2fxs6o4Brmf5oiUaM6OD6MXXLrFrSc/LJbhHCIBl4dCPeZzq4q/QuoV+32THNZPFiWipvdj9Z33R8EgpWnFU1lKJIvDbTBA6f/KzfqC8kmq0GqHlaF6NJ1upgXir56mPX3IctWxVFoaILJXJOnHc80ce5EtXEr0i3FmZ5iglKU9seyfhgDZGq0NQyLiqV2o/WAFti+jNfvZWwWCmxAQDqAETVnu45+TDOooSaQtLQG65FUMAtXxj1BC8tVOauMyHxstmNF7bbGbkBM0wjiaH1VUrViGjA4l2YVHPLCmSkBpp7CItrL1EVdyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRWcjbsHh6QZ/C6/MXPkvjlx2V14dOxYXXL4scZoVYM=;
 b=NSRSgrkOaKDKbOoFs8amBl9JNV5WnAkyzHZ0N2hsLq6Ir8fuNV2bsQMNoW0n81w19GjKyUxLYwGXngTREGMZ5HGuRpJhbrGo1p9P9Dp7CDNCq613oeS4ySACfeljh+DT2x7rUvV0dLilJaNQ56K7gIoCyt92qKxj7tx5mEogJ194FoFURUudChAh+HXhI9g1cInksa7NxkfCg+6Qvv4J8aiKCWOeugQjNrhsoD1qxGF9k7YGwYkYDas6croP+Nk8Z+06f0ZPtx2hzSW9t3XYjY08Cu4X9azjT2DecXYTjieuw7VPmfXsu6W0r+vR3em68KaRFVXwfcxT9B8DZnu6rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRWcjbsHh6QZ/C6/MXPkvjlx2V14dOxYXXL4scZoVYM=;
 b=NWSOp9dU/5oWmG4vP7vKItMdLXI3OJFMuoXYQ/qjFRF1RNzmTvUYhiironMdIg0KDC2F0mjXxLS4szklJuHWlQ5U0GDLVGWrSZ5AReZ209abAKOuVVmb0bGeHtJ0qdUDQ5fCNB6WX0yv+C1N1ZA1LBq5+a1KGll2addN4KFVOnQ=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN6PR1001MB2338.namprd10.prod.outlook.com (2603:10b6:405:2b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Fri, 22 Jan
 2021 05:52:21 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3784.012; Fri, 22 Jan 2021
 05:52:21 +0000
Subject: Re: [PATCH v4 0/3, full-cover-letter] btrfs: read_policy types
 latency, device and round-robin
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com
References: <cover.1611114341.git.anand.jain@oracle.com>
 <20210120123437.OVx7ybGaVfmOdZxtpp43qcB_ORHQQs5OzPSzr3ZUGbo@z>
Message-ID: <35c2e0bc-79e3-082b-e1f2-b55739ef5b70@oracle.com>
Date:   Fri, 22 Jan 2021 13:52:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <20210120123437.OVx7ybGaVfmOdZxtpp43qcB_ORHQQs5OzPSzr3ZUGbo@z>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR03CA0114.apcprd03.prod.outlook.com
 (2603:1096:4:91::18) To BN6PR10MB1683.namprd10.prod.outlook.com
 (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR03CA0114.apcprd03.prod.outlook.com (2603:1096:4:91::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.6 via Frontend Transport; Fri, 22 Jan 2021 05:52:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d87008cf-8e76-46d9-f4fd-08d8be99e233
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2338:
X-Microsoft-Antispam-PRVS: <BN6PR1001MB233814F0E2BFFAAD52BBFCA9E5A09@BN6PR1001MB2338.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CB5rzl3cWpGCxgefpGMwVPrTFt5ypS2YYuuzpV4arjkiw+lyLEWKHxZy+zv0AKGlpmVyjzy4gISVWrgKbO9aiMpxIAY6mipCkkAVz3fhvkeoM2slFYpAIhnv3InLjGhrn43e2e+BVTqPtP7W5xdgNT5IdpX1/9BeButdaPk/+W592m7nMZoDltWaauhi0ibHDG635onlQ9IoG5+erT9EHW9XW5NnaQoleNmybCEU+mlgAkwuNKABrA8FcrIjhRx/GIJnt9reypMHNh55mCU8INng/qQAaVWdQvt83yXctmKgxdZWjXYeVTb1pcwG8c+iWmHK/+J8GjK8jeYu9VuQoY/cRzXcJVV9u/QBfFX2PRPWccGtunkGLBhnWEKXJk6RkatKxHCk5mfQweKDcVMdDhrIJfLL8B3dluH/QTKMOeptp/uiKG4UwE/Y0Ol0h2aqcvfvdHM7CySr8QY+iKAiU/MsA/tgkLw5xr6uusRq9KktqOFyesEEjZbVRME/56rAlzKjrgh4H4Yc8DjrJDHYw+46HaHqY6zwqrXAeJgCInhqmKaxRFocgwAuggiRzCu/ixNprxhx6SAT2+Iki2BTOVGALs/2X/RaPegLz5oSy1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(39860400002)(376002)(31686004)(44832011)(53546011)(83380400001)(8676002)(5660300002)(19627235002)(86362001)(2906002)(6486002)(2616005)(508600001)(4326008)(66476007)(66946007)(36756003)(66556008)(316002)(956004)(16576012)(30864003)(6916009)(186003)(26005)(6666004)(8936002)(31696002)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OEp0NHorVXIwSDcyb3BHUUkrUzJUZDlvZHNBL3pGdERHckszZ2pZZklBSWtB?=
 =?utf-8?B?aW5HSm9FdTVVQUZKelNkS3V4WkJiRHlEZmdVMExzZzk4MUhQbU5kMEQ3Wk1x?=
 =?utf-8?B?VG9wbHhQWCtWMmxhc2R5ZVMrQnlka21Ic0JMdXNKL1ZqUDBjdmxDaUxUTkpy?=
 =?utf-8?B?eGl2cVFlb1d1SkJTQWRTM3NtckhNZjJhS2JvMEo3K1hheHIrcjFmZFlxZVlN?=
 =?utf-8?B?NFJYdlJtM2t0aXNRM1RtWWE2cFh0Y1YvSW9tbzNiMkp2ODlWWlZZRHA2R3Zo?=
 =?utf-8?B?REoxRU5IL0ozT1NINzVFQ0tkQlFUSldHZ2FWTDVGMGtUNklaTE1qeTJVUm9Z?=
 =?utf-8?B?MlhoWTVrcGR5QmdkRW02SGFnVDE3WGtXV2JreTVHemtoT3NjM3AySnBYdXli?=
 =?utf-8?B?NnhDMHkzUXI5UVRQY3ZXYXdFN1p5ZE1lMTlBMlJnWmliZWVXcUQreWJocFN3?=
 =?utf-8?B?K0Exc1I2RjFHTVlzbkRWRVpwRCtqOWFEMkNWTFRQMHRSOXF0MnFtTnAvY3k1?=
 =?utf-8?B?a2xXZXBTTHI5UnVvWXRpS1BXWUNXQjlOSmswa0xhVDVsOCs4enVweTk2RkRN?=
 =?utf-8?B?T3JZS1VnaENWaU5YZmlyN1c5VUhuQ0U5d2dtRGhiQ1RLODFvNWh0ZGk3Wnpq?=
 =?utf-8?B?NzgyWTNnUVpyekNMYk9sbW5CeEsvd0g5dDYzZzJjVk55NVVibVVENUZ6eS93?=
 =?utf-8?B?dkdnTm5nbzBRZVRaSUxET0tSV1Avcng1cCtqNWIxcnVEZkE5VmlRSU14TlZB?=
 =?utf-8?B?NmY4dWs4OHRhNm90STMzYTJKa2wzS2twaldmenlLVW1OM08vMjV5ejcrVHUy?=
 =?utf-8?B?aWVuWlp5Q05iNkhkS1ZPT2UxOXRDS3ZoVloxeGozUXJ2ZzB3Z0FJTEtDNGNR?=
 =?utf-8?B?WGprczdCUFIyNGNZL2Z3K2JabW5PazE4MFpMYmttNkRpMDdRdXQ5ODN1Uy9Y?=
 =?utf-8?B?RDlVQ0x2cE9hdXYwNExRRlJCSHV5cWhSWE80MU5Zb3Z1cUhLaFFVZFZPK3pP?=
 =?utf-8?B?VmQzQjgwSHRZVXpTc2xrTWFnc0pJT0JOMm5hWmp4dVozWkgvUWRVdmdjQTBp?=
 =?utf-8?B?SkpMaEp4ZXdFUzNCZ3dYQ050M290TGFzdzJ2d1ErMG1waGZJNE1ZQ01uTEti?=
 =?utf-8?B?N3BOcTYvbVcrbHAzUnI0Wis3b0lTUGcxZjViY0hicGdzOWZuWHhDREl4amYv?=
 =?utf-8?B?MmFpTjM5bDVmcHYrSy9VV2k5TmtodUVqamJHVlVZaXRtUGlsTFMvL3htR2Va?=
 =?utf-8?B?N3lZMmM1RElIbm9FSEVCa1MvYkNyS0xSMG5EK0g4SzEyMEt0Z3NkNGRyaHp1?=
 =?utf-8?Q?Mkn7ZNMUBmp42xwi2smYVf9FPHP8gu12C+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87008cf-8e76-46d9-f4fd-08d8be99e233
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 05:52:20.8894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aROCeSN670NTk5WmvWAKEqV0JsI+vDgTS4EA3NWO4r3rJUT3mjxaRZwHsT/RHHrZZiuf21So0ffkecnuxwp5hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2338
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9871 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220030
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9871 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220030
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[Oops. A part of the cover letter is missing again. The cover-letter
  file has it all. I am not sure why it happened.
  Here below, I am just sending it by email].

v4:
Add rb from Josef in patch 1 and 3.
In patch 1/3, use fs_info instead of device->fs_devices->fs_info.
Drop round-robin policy because my workload (fio random) shows no
performance gains due to fewer merges at the block layer.

v3:
The block layer commit 0d02129e76ed (block: merge struct block_device
and struct hd_struct) has changed the first argument in the function
part_stat_read_all() in 5.11-rc1. So trickle down its changes in the 
patch 1/4.

v2:
Fixes as per review comments, as in the individual patches.

rfc->v1:
Drop the tracing patch.
Drop the factor associated with the inflight commands (because there
were too many unnecessary switches).
Few C styles fix.

-----

This patchset adds read policy types latency, device, and round-robin,
for the mirrored raid profiles such as raid1, raid1c3, raid1c4, and 
raid10. The default read policy remains as PID, as of now.

Read policy types:
Latency:

Latency policy routes the read IO based on the historical average
wait time experienced by the read IOs on the individual device.

Device:

With the device policy along with the read_preferred flag, you can
set the device for reading manually. Useful to test mirrors in a
deterministic way and helps advance system administrations.

Round-robin (RFC patch, removed in v4):

Alternates striped device in a round-robin loop for reading. To achieve
this first we put the stripes in an array, sort it by devid and pick the
next device.

Test scripts:
=============

I have included a few scripts which were useful for testing.

-------------------8<--------------------------------
Set latency policy on the btrfs mounted at /mnt

Usage example:
   $ readpolicyset /mnt latency

$ cat readpolicyset
#!/bin/bash

: ${1?"arg1 <mnt> missing"}
: ${2?"arg2 <pid|latency|device|roundrobin> missing"}

mnt=$1
policy=$2
[ $policy == "device" ] && { : ${3?"arg3 <devid> missing"}; }
devid=$3

uuid=$(btrfs fi show -m /btrfs | grep uuid | awk '{print $4}')
p=/sys/fs/btrfs/$uuid/read_policy
q=/sys/fs/btrfs/$uuid/devinfo

[ $policy == "device" ] && { echo 1 > ${q}/$devid/read_preferred || exit 
$?; }

echo $policy > $p
exit $?

-------------------8<--------------------------------

Read policy type from the btrfs mounted at /mnt

Usage example:
   $ readpolicy /mnt

$ cat readpolicy
#!/bin/bash

: ${1?"arg1 <mnt> missing"}
mnt=$1

uuid=$(btrfs fi show -m /btrfs | grep uuid | awk '{print $4}')
p=/sys/fs/btrfs/$uuid/read_policy
q=/sys/fs/btrfs/$uuid/devinfo

policy=$(cat $p)
echo -n "$policy ( "

for i in $(find $q -type f -name read_preferred | xargs cat)
do
	echo -n "$i"
done
echo ")"
-------------------8<--------------------------------

Show the number of read IO per devices for the give command.

Usage example:
    $ readstat /mnt fioread

$ cat readstat
#!/bin/bash

: ${1?"arg1 <mnt> is missing"}
: ${2?"arg2 <cmd-to-run> is missing"}

mnt=$1; shift
mountpoint -q $mnt || { echo "ERROR: $mnt is not mounted"; exit 1; }

declare -A devread

for dev in $(btrfs filesystem show -m $mnt | grep devid |awk '{print $8}')
do
	prefix=$(echo $dev | rev | cut -d"/" -f1 | rev)
	sysfs_path=$(find /sys | grep $prefix/stat$)

	devread[$sysfs_path]=$(cat $sysfs_path | awk '{print $1}')
done

"$@" | grep "READ: bw"

echo
echo
for sysfs_path in ${!devread[@]}
do
	dev=$(echo $sysfs_path | rev | cut -d"/" -f2 | rev)
	new=$(cat $sysfs_path | awk '{print $1}')
	old=${devread[$sysfs_path]}
	echo "$dev $((new - old))"
done
-------------------8<--------------------------------

Run fio read command

Usage example:
     $ touch /mnt/largefile
     $ fioread /mnt/largefile 500m

$ cat fioread
#!/bin/bash

: ${1?"arg1 </mnt/file> is missing"}
: ${2?"arg2 <1Gi|50Gi> is missing"}

tf=$1
sz=$2
mnt=$(stat -c '%m' $tf)

fio \
--filename=$tf \
--directory=$mnt \
--filesize=$sz \
--size=$sz \
--rw=randread \
--bs=64k \
--ioengine=libaio \
--direct=1 \
--numjobs=32 \
--group_reporting \
--thread \
--name iops-test-job
-------------------8<--------------------------------


Testing on guest VM
~~~~~~~~~~~~~~~~~~~

The test results from my VM with 2 devices of type sata and 2 devices of
type virtio, are below. Performance results are for raid1c4, raid10, and
raid1 are as below.

The workload is fio read 32 threads, 500m random reads.

Fio is passed to the script called readstat, which returns the number of
read IOs per device sent during the fio.

Supporting fio logs are below. And readstat shows the number of read IOs
to the devices (excluding the merges).

raid1c4
=======

pid
----

$ readpolicyset /btrfs pid && readpolicy /btrfs && dropcache && readstat 
/btrfs fioread /btrfs/largefile 500m

[pid] latency device roundrobin ( 0000)
  READ: bw=87.0MiB/s (91.2MB/s), 87.0MiB/s-87.0MiB/s 
(91.2MB/s-91.2MB/s), io=15.6GiB (16.8GB), run=183884-183884msec

vdb 64060
vdc 64053
sdb 64072
sda 64054


latency
-------

(All devices are non-rotational, but sda and sdb are of type sata and 
vdb and vdc are of type virtio).

$ readpolicyset /btrfs latency && readpolicy /btrfs && dropcache && 
readstat /btrfs fioread /btrfs/largefile 500m

pid [latency] device roundrobin ( 0000)
  READ: bw=87.1MiB/s (91.3MB/s), 87.1MiB/s-87.1MiB/s 
(91.3MB/s-91.3MB/s), io=15.6GiB (16.8GB), run=183774-183774msec

vdb 255844
vdc 559
sdb 0
sda 93


roundrobin
----------

$ readpolicyset /btrfs roundrobin && readpolicy /btrfs && dropcache && 
readstat /btrfs fioread /btrfs/largefile 500m

pid latency device [roundrobin] ( 0000)
  READ: bw=51.0MiB/s (54.5MB/s), 51.0MiB/s-51.0MiB/s 
(54.5MB/s-54.5MB/s), io=15.6GiB (16.8GB), run=307755-307755msec

vdb 866859
vdc 866651
sdb 864139
sda 865533


raid10
======

pid
---

$ readpolicyset /btrfs pid && readpolicy /btrfs && dropcache && readstat 
/btrfs fioread /btrfs/largefile 500m

[pid] latency device roundrobin ( 0000)
  READ: bw=85.2MiB/s (89.3MB/s), 85.2MiB/s-85.2MiB/s 
(89.3MB/s-89.3MB/s), io=15.6GiB (16.8GB), run=187864-187864msec


sdf 64053
sde 64036
sdd 64043
sdc 64038


latency
-------

$ readpolicyset /btrfs latency && readpolicy /btrfs && dropcache && 
readstat /btrfs fioread /btrfs/largefile 500m

pid [latency] device roundrobin ( 0000)
  READ: bw=85.4MiB/s (89.5MB/s), 85.4MiB/s-85.4MiB/s 
(89.5MB/s-89.5MB/s), io=15.6GiB (16.8GB), run=187370-187370msec


sdf 117494
sde 10748
sdd 125247
sdc 2921

roundrobin
----------

$ readpolicyset /btrfs roundrobin && readpolicy /btrfs && dropcache && 
readstat /btrfs fioread /btrfs/largefile 500m

pid latency device [roundrobin] ( 0000)
  READ: bw=55.4MiB/s (58.1MB/s), 55.4MiB/s-55.4MiB/s 
(58.1MB/s-58.1MB/s), io=15.6GiB (16.8GB), run=288701-288701msec

sdf 617593
sde 617381
sdd 618486
sdc 618633


raid1
=====

pid
----

$ readpolicyset /btrfs pid && readpolicy /btrfs && dropcache && readstat 
/btrfs fioread /btrfs/largefile 500m

[pid] latency device roundrobin ( 00)
  READ: bw=78.8MiB/s (82.6MB/s), 78.8MiB/s-78.8MiB/s 
(82.6MB/s-82.6MB/s), io=15.6GiB (16.8GB), run=203158-203158msec

sdb 128087
sda 128090


latency
--------

$ readpolicyset /btrfs latency && readpolicy /btrfs && dropcache && 
readstat /btrfs fioread /btrfs/largefile 500m

pid [latency] device roundrobin ( 00)
  READ: bw=86.5MiB/s (90.7MB/s), 86.5MiB/s-86.5MiB/s 
(90.7MB/s-90.7MB/s), io=15.6GiB (16.8GB), run=185023-185023msec

sdb 567
sda 255942


device
-------

(From the latency test results (above) we know sda is providing low 
latency read
IO. So set sda as read preferred device.)

$ readpolicyset /btrfs device 1 && readpolicy /btrfs && dropcache && 
readstat /btrfs fioread /btrfs/largefile 500m

pid latency [device] roundrobin ( 10)
  READ: bw=88.2MiB/s (92.5MB/s), 88.2MiB/s-88.2MiB/s 
(92.5MB/s-92.5MB/s), io=15.6GiB (16.8GB), run=181374-181374msec

sdb 0
sda 256191


roundrobin
-----------

$ readpolicyset /btrfs roundrobin && readpolicy /btrfs && dropcache && 
readstat /btrfs fioread /btrfs/largefile 500m

pid latency device [roundrobin] ( 00)
  READ: bw=54.1MiB/s (56.7MB/s), 54.1MiB/s-54.1MiB/s 
(56.7MB/s-56.7MB/s), io=15.6GiB (16.8GB), run=295693-295693msec

sdb 1252584
sda 1254258


Testing on real hardware:
~~~~~~~~~~~~~~~~~~~~~~~~

raid1 Read 500m
-----------------------------------------------------
             |nvme+ssd  nvme+ssd   all-nvme  all-nvme
             |random    sequential random    sequential
------------+------------------------------------------
pid         | 744MiB/s  809MiB/s  2225MiB/s 2155MiB/s
latency     |2072MiB/s 2008MiB/s  1999MiB/s 1961MiB/s
device(nvme)|2187MiB/s 2063MiB/s  2125MiB/s 2080MiB/s
roundrobin  | 527MiB/s  519MiB/s  2137MiB/s 1876MiB/s


raid10 Read 500m
-----------------------------------------------------
             | nvme+ssd  nvme+ssd  all-nvme  all-nvme
             | random    seq       random    seq
------------+-----------------------------------------
pid         | 1282MiB/s 1427MiB/s 2152MiB/s 1969MiB/s
latency     | 2073MiB/s 1871MiB/s 1975MiB/s 1984MiB/s
device(nvme)| 2447MiB/s 1873MiB/s 2184MiB/s 2015MiB/s
roundrobin  | 1117MiB/s 1076MiB/s 2020MiB/s 2030MiB/s


raid1c3 Read 500m
-----------------------------------------------------
             | nvme+ssd  nvme+ssd  all-nvme  all-nvme
             | random    seq       random    seq
------------+-----------------------------------------
pid         |  973MiB/s  955MiB/s 2144MiB/s 1962MiB/s
latency     | 2005MiB/s 1924MiB/s 2083MiB/s 1980MiB/s
device(nvme)| 2021MiB/s 2034MiB/s 1920MiB/s 2132MiB/s
roundrobin  |  707MiB/s  701MiB/s 1760MiB/s 1990MiB/s


raid1c4 Read 500m
-----------------------------------------------------
             | nvme+ssd  nvme+ssd  all-nvme  all-nvme
             | random    seq       random    seq
------------+----------------------------------------
pid         | 1204MiB/s 1221MiB/s 2065MiB/s 1878MiB/s
latency     | 1990MiB/s 1920MiB/s 1945MiB/s 1865MiB/s
device(nvme)| 2109MiB/s 1935MiB/s 2153MiB/s 1991MiB/s
roundrobin  |  887MiB/s  865MiB/s 1948MiB/s 1796MiB/s


Observations:
=============

1.
As our chunk allocation is based on the device's available size
at that time. So stripe 0 may be circulating among the devices.
So a single-threaded process running with a constant PID, may balance
the read IO among devices. But it is not guaranteed to work in all the
cases, and it might not work very well in the case of raid1c3/4. Further,
PID provides terrible performance if the devices are heterogeneous in
terms of either type, speed, or size.

2.
Latency provides performance equal to PID if all devices are of same
type. Latency needs iostat be enabled and includes cost of calculating
the avg. wait time. So if you factor in a similar cost of calculating the
avg. wait time in case of PID policy (using the debug code [2]) then the
Latency performance is better than PID. This proves that read IO
distribution as per latency is working, but there is a cost to it. And
moreover, latency works for any type of devices.

3.
Round robin is worst (unless there is a bug in my patch). The total
number of new IOs issued is almost double when compared with the PID and
Latency read_policy, that's because there were fewer number of IO merges
in the block layer due to constant switching of devices in the btrfs.

4.
4.
Device read_policy is useful in testing and provides advanced sysadmin
capabilities. When known how to use, the policy could help avert
performance degradation due to csum/IO errors at production.

Thanks, Anand

------------------
[2] Debug patch to factor the cost of calculating the latency per IO.

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d3023879bdf6..72ec633e9063 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5665,6 +5665,12 @@ static int find_live_mirror(struct btrfs_fs_info 
*fs_info,
  fs_info->fs_devices->read_policy = BTRFS_READ_POLICY_PID;
  fallthrough;
  case BTRFS_READ_POLICY_PID:
+ /*
+ * Just to factor in the cost of calculating the avg wait using
+ * iostat, call btrfs_find_best_stripe() here for the PID policy
+ * and drop its results on the floor.
+ */
+ btrfs_find_best_stripe(fs_info, map, first, num_stripes, log,
+ logsz);
  preferred_mirror = first + current->pid % num_stripes;
  scnprintf(log, logsz,
  "first %d num_stripe %d %s (%d) preferred %d",
-------------------------



On 20/1/21 8:34 pm, Anand Jain wrote:
> [Only some parts of the cover-letter went through, tying again.].
> 
> v4:
> Add rb from Josef in patch 1 and 3.
> In patch 1/3, use fs_info instead of device->fs_devices->fs_info.
> Drop round-robin policy because my workload (fio random) shows no performance
>   gains due to fewer merges at the block layer.
> 
> v3:
> The block layer commit 0d02129e76ed (block: merge struct block_device and
> struct hd_struct) has changed the first argument in the function
> part_stat_read_all() in 5.11-rc1. So trickle down its changes in the patch 1/4.
> 
> v2:
> Fixes as per review comments, as in the individual patches.
> 
> rfc->v1:
> Drop the tracing patch.
> Drop the factor associated with the inflight commands (because there
> were too many unnecessary switches).
> Few C styles fix.
> 
> -----
> 
> This patchset adds read policy types latency, device, and round-robin, for the
> mirrored raid profiles such as raid1, raid1c3, raid1c4, and raid10. The default
> read policy remains as PID, as of now.
> 
> Read policy types:
> Latency:
> 
> Latency policy routes the read IO based on the historical average
> wait time experienced by the read IOs on the individual device.
> 
> Device:
> 
> With the device policy along with the read_preferred flag, you can
> set the device for reading manually. Useful to test mirrors in a
> deterministic way and helps advance system administrations.
> 
> Round-robin (RFC patch):
> 
> Alternates striped device in a round-robin loop for reading. To achieve
> this first we put the stripes in an array, sort it by devid and pick the
> next device.
> 
> Test scripts:
> =============
> 
> I have included a few scripts which were useful for testing.
> 
> -------------------8<--------------------------------
> Set latency policy on the btrfs mounted at /mnt
> 
> Usage example:
>    $ readpolicyset /mnt latency
> 
> Anand Jain (3):
>    btrfs: add read_policy latency
>    btrfs: introduce new device-state read_preferred
>    btrfs: introduce new read_policy device
> 
>   fs/btrfs/sysfs.c   | 57 ++++++++++++++++++++++++++++++++++++++++++-
>   fs/btrfs/volumes.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/volumes.h |  5 ++++
>   3 files changed, 121 insertions(+), 1 deletion(-)
> 
