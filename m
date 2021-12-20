Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCA047A835
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Dec 2021 12:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhLTLGt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Dec 2021 06:06:49 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42684 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229887AbhLTLGt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Dec 2021 06:06:49 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BKB2FKS009187;
        Mon, 20 Dec 2021 11:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IrDB7hHTrhGBHoG8xkbARWUgy9zdhfGg/79obqNGvak=;
 b=Pzk8FHR5+sKc84lUdOGqMU/8a1xuiOPa4A1cjTTOzpkfbXuGoYXFXeRTQcLwwcaAjgxg
 blYUu+UNLXiohstc4oJ8nv/HSekB7RKgHhmMLVMZO6pZiTgTHGSpXPofCvGJnhWGYOpd
 COOPWTv7XYsGQ5VWx7Lv1aAyAzzrCBr1yjyUmCAN27QQUAc6LX2j01g5JlZHcvTyVqnX
 fMYM1wwAfaBZ0ZutjQV3wLN3CqcUOyn1xXQ9MyksEgBlzdsdlkBMnpBTfxACIcLsFnwm
 TLaN8eOqGCTKQT0deaH7Ngh1YNAMgunebui4PmDmORbMKbl1SsBnSR9JidEcySiAVO/Y 7w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d2rkug08y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Dec 2021 11:06:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BKB0MZa157593;
        Mon, 20 Dec 2021 11:06:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3020.oracle.com with ESMTP id 3d193kgjrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Dec 2021 11:06:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnJnDf0WpbMIIFNrDS0u/7l1KSaA9FoLqajMgrrUdC7qp/kwHyVYtmL78N76Udu7Rc+HZ5tBUEsamzvL98g2G6LhOCz7gYpUmy7gbrfjlXks8UnX3xGHdjJJuWloYJQ3FsF+PvSo7v9lcMljTMHXk7d/t45SxtFWSmiBzvCk6lIMtJTfBBfJS93aj064yDPhMHK/LzPwvEnrHkov3CNRhLwq7vQHCWccOFcLLk+thSBAHq7NHpeU1Bj9STZAxa2qIvKbOqW9Ng/s9IHTEsSlmfnOYP11b/JWiUA8Ko8DFR0nY+89pXs7f2/yYGCVVaQCQVyVX/V4rJx0glBVNw0axA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrDB7hHTrhGBHoG8xkbARWUgy9zdhfGg/79obqNGvak=;
 b=gTKH5M5nbM3+PGsG/ZozLZrMIUfAlopQhxerzZgxEhYPhvnXGLboqm1QJgZ7s0NKR+SYz04MEpBu9iBYdBsMay+g3yc6hXq+1kQgTEzgIic/HBI/L3DYb5KtdOcdh/130gQ9D1wU9LCyDGbFYX1Fh9Q1liBhTtpbmQaTliedxk7xlnCKDkhQrmcYYpb/bN8ic2cEvqb6NQmMnhZtXuSykyZujSsDbyxggwSPxd109awRN9N3NlC//bAQ+yZBN03BglDUuv/50knco081kSsCntf23XAhURgGnyt/lY63SMWalio8g03LTzOagi8DDcxkQKtiiUFOy4pnoYLg2cbrgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrDB7hHTrhGBHoG8xkbARWUgy9zdhfGg/79obqNGvak=;
 b=a61/hmaEAhepuL34dOe5XQXznTUPIj4QJhebs5CuIyyBJUp4WRo6yFuan4RMXWLc8ii08jvHKmHO4Dhe9PeLYqSR4Xud7E40t8L6ececkArA3VOTtgcX0hNOUMsxSwykWRFU1wINlKG9v5lUJ1CYmUK6mkk4KT8RBTzGGHdjKug=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4142.namprd10.prod.outlook.com (2603:10b6:208:1d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Mon, 20 Dec
 2021 11:06:41 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 11:06:41 +0000
Message-ID: <6a78d167-3f7c-1f9e-49d4-399203c52232@oracle.com>
Date:   Mon, 20 Dec 2021 19:06:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] btrfs/254: test cleaning up of the stale device
Content-Language: en-US
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        josef@toxicpanda.com
References: <61c0bd3a345d8cb64f1117da58c63c2cd08a8a2c.1639156699.git.anand.jain@oracle.com>
 <Yb87dkizAxoqC+1c@desktop>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <Yb87dkizAxoqC+1c@desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10130068-4b81-496f-b26d-08d9c3a8ccfb
X-MS-TrafficTypeDiagnostic: MN2PR10MB4142:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4142C1D6AF543A7FA37B4108E57B9@MN2PR10MB4142.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2mKemMAVVeIykyYRtjmBtdCYnDrKGWvYhT6KXhlWlAMq+X0xzmH3Tfl/DCBhhYZ1vA7W+OgwwzU0Zt0ugozsSeNjN4jL1tee7/SnbCUnvvX943Jz9YI8THsW1sMPSn2tXi/8Tlz8/jblmlq2EAgG0gRFV8UAxi0aURPc8bAx63Po/pRG3qn1097BI85yp5ActyHbyzx83gEInIIMixvVubo2KFTVVA8KFHERdd6+bAxzcM86UfTUxSLXqU79h4Z/9ly7Ongr0f+dGce5vNsmsk4GyfP8l9v2/eQO3laV4u5Zyuou8LvzFKN8pa49WfZJzFzXCqZ4O3BFXc+7qNjOQWcRqXKg/eyFhtf8T0rwZOR+XCIq4/vKrftP5TOkQgek7hd2mnTdWrWIZ9dlNdPw0+FKlP+S1FQXRaBQpPA/I0QvCgRLXzstTsEap5zLg/U6cw72hvzx2bSU3jZk6IqGqolWEagEzb5+x1RhdaU5SU1la2XvM/gfynhspFkmvGMIfGSBTNXXftAOXd0N8eg5WWhg5tZw7Jgv8SWY2xYwAjD1uNYW+ZLqfVjJWwBMUys2XutLOzkNeA881tyWk6dVL81Rkt+qpKcpo0c71Zh2D9WbuxWNCSfCBf8o25WpCqEMnW5cpnHVS5zZGARXN77Nb4YP/UdoSA5R/EAfS3eyW/sVcLl8MZuIog4zFHd6I2xU1UE8VSHTo03bFVsjKnza9J3QZZ3vQ2EPTvyiNJP021/S83kolRLvZMxhEpVat+pBV794eZ3y3T3ujldj1PUgh5gTlpTV6BPa5fiApPAS4IGyyR1GFZkZK+L4Qjjqq89E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(6512007)(316002)(4326008)(8936002)(186003)(2616005)(2906002)(966005)(31696002)(83380400001)(26005)(36756003)(6666004)(5660300002)(66556008)(66476007)(6486002)(38100700002)(31686004)(86362001)(6916009)(66946007)(6506007)(8676002)(53546011)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U29KRy9DaTNHaE5ORlBuejZVOU5vdHpKblBOc3d1V01yN3F5KzVQN1JPSWJV?=
 =?utf-8?B?MW5MRWFCdDk3QnBLakloZGdlZ1ZVYTdnc1piRVJDNmZtbG5XZzB3cGhOckMx?=
 =?utf-8?B?TjA2R0QxYy8xMnZRZHZmR3hQbzhCUlZudHFiR1NpQ2gvdHZYWlpGU2NKSVN2?=
 =?utf-8?B?V1JLVUVZazhHVlVGUUpVZzJsd2ZKL011T21BSFU0RkN3Sk5hUFI2bllLa0Iw?=
 =?utf-8?B?bmJnWVNEL2FFeEFKYU1yeUZ0R3hwT2IwRlo3b2FuZFNyTDNKbVlHdlc0N1NY?=
 =?utf-8?B?YVc0cFQyRitkOVRVSUo4S2hQcE9Fb0hkTm1UT2tJcVFWTGNOWE1hdS90Y1E4?=
 =?utf-8?B?b3JjU0ZFcTd5ZjBkdmE5UnFnT0JMaG5MWmIwUmRvQWVqUDVEM2VlbU5FTC9D?=
 =?utf-8?B?Z3ZaK0hsYStZeWNKWjhyQm9sU0lZTis3TUVwSi9ESGwya1QyeVh4cHNMNUN4?=
 =?utf-8?B?YlBSa3VIT01mVEpLMm0yOXNqWkMySzVKeStkQzF6M3RoSGVUVWpudU82WnFk?=
 =?utf-8?B?KzNEZGhwVkdHaXVnd0NsSFRlK2xrUi93dnFNSjRoU1BWUmx6dTJzZ1p3WXls?=
 =?utf-8?B?QnkvL0sxRFlqbGV4bGRuNkwvZHpSMGYzblo3enBkeXNNbTRKMzg4YkdNS2pn?=
 =?utf-8?B?ZExxeXdjMWVoaXY5YURNb0Q4eFMvVk82UjkrT3Zkc1hJd0g3OERZbWV3ZkR4?=
 =?utf-8?B?MS8velQ4aXZEVlZmeEJXQ1QwdzAzR2RTT3ZQRDFvVWxSR3RxMExhMlRiS1Yy?=
 =?utf-8?B?eXFhQkRRRUV0LzNaT29XeTlNV3V2WlRaYWxLOWZKTERsdlNhL0tybkpBWEtZ?=
 =?utf-8?B?eEFLc2s1TzF2YWtlMzFtQTVseUlwbHBXajhVUzNCQnBWNVJScHQ0SmMyL1JH?=
 =?utf-8?B?R2pDTkxBOGprUi9RV3BSY3lDQnEvQVljZzNGSVIzbDdWd1BoclUvWHNFeTdK?=
 =?utf-8?B?YmtGS3NXWUpGQVZ6cjRXdEhQODlVNVZLRmlsTzd1OTdoa0U4WkhtM3NYZGlV?=
 =?utf-8?B?M015UERNZEVCUTNaSmN4TTM5cXNCQzZoQTE1VXRaay9iaGVlRGlZTjMwTXNU?=
 =?utf-8?B?Qk1IMW5SUmc4a2hhOHowd0NsUkxXeC92U3J2bHVYUEVvVm9hZURaakFreFE2?=
 =?utf-8?B?ajArcENRZG92OENNRTdGTzlCa3VDZDVpd2Z4TDBtbGU1QUR2NWVqQkQyRWJN?=
 =?utf-8?B?dStrenZkTDZoaThXS0haTWxhWlZ1OHArQm5kWkZUSlA4dG1oY29TaXR2QWVR?=
 =?utf-8?B?TmFyM2ZSeXVvMGgxWVhJdk1VY1NmSTlzYlZaMjNnNXFiOW9hcElrMzFGQWZP?=
 =?utf-8?B?d0Rjdnk0Mk8xeVl4OUErcW8xTFlFZzFaVnV2RVdSY3hKVGZaS1I4dC93ODl0?=
 =?utf-8?B?ZTY2YzNRanVBOVdzYldBSXVDMHlCK0xZU01oREw5RW8rajhYTjlnL09JakJS?=
 =?utf-8?B?dDlPSFhNTzhBaE9vQkhBV0FVekNmQk9ORUtrR0swQ3VlMTh5NnZmS0FnZUxR?=
 =?utf-8?B?VWFCNjBGSmRmRnFYcktvYnJoY2JaeFl6Wi8weStyaVc0NW5sVnFIdnU4WlNT?=
 =?utf-8?B?VDc3VWJZQnNJNEx1U1Rzak43MmliSHhFUjhFV29mMVpQczMxYUFiaU1nSmU3?=
 =?utf-8?B?Zk4wU2p1bVFlbllaRW1rd1A4allJTm5IejM3bjI1VnB0M1dueGUxcmFFWXFq?=
 =?utf-8?B?UCtRd0lKT2NnZzh4YkFRYlZyaGYwY2VabnBtdzI0Rk5oemhGMjNmMmR2OStm?=
 =?utf-8?B?V3NzQXFQVWtQSEIrbEJ6TWlJand5NDdQOGR3NnBkbVFCeFhKaC9qcFdSdU9r?=
 =?utf-8?B?bXdWallHakxHM0dTZld3alBCYkd2aWo0MGRQMVFLRmlJUDRLcWtuWDB6NHVP?=
 =?utf-8?B?ZGthL3lrazVrdFVIK1g1blNaZldvUjEreFV3UVg1NkIzUHdvbkQ0STBLNkdi?=
 =?utf-8?B?ckxpalZGOW5TME90ZVlHR1BManhNNWNSajRNVzFFckc1S0cxTmZwSUtqcUJW?=
 =?utf-8?B?Yk9YdDBVUUVUOU9YOG42ckZmL2FQeHNybGRJUGtyU2UxTy9KWWFiNUxvQmFI?=
 =?utf-8?B?Y05EamxPMWlFbzNKRFRyczJWV3JaZVRhNStsRHJPUzV6UnlramQ4QVpWWTBU?=
 =?utf-8?B?dUV6NXR4MDJQbTVIZHlyemlQR01MU0ZVVzhuQS9RUzdvb3NuMWJ5VW1kVDV6?=
 =?utf-8?Q?S8oTYrIA21A/Ht2oOJCS4aU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10130068-4b81-496f-b26d-08d9c3a8ccfb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 11:06:41.4354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /vR3KbEOD/7XwZ7OrAj0OXXmSAzwcJXUMxgU2zQV3AkPcMLhD+IlufO/EORHB7CUmCNQPyKc0HJjRphR58xvAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4142
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10203 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112200064
X-Proofpoint-ORIG-GUID: h7oHGslKq2MjJzNtrQuxkdvvolFUv9K2
X-Proofpoint-GUID: h7oHGslKq2MjJzNtrQuxkdvvolFUv9K2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 19/12/2021 22:02, Eryu Guan wrote:
> On Sat, Dec 11, 2021 at 02:14:41AM +0800, Anand Jain wrote:
>> Recreating a new filesystem or adding a device to a mounted the filesystem
>> should remove the device entries under its previous fsid even when
>> confused with different device paths to the same device.
>>
>> Fixed by the kernel patch (in the ml):
>>    btrfs: harden identification of the stale device
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> I was testing with v5.16-rc2 kernel, which should not contain the kernel
> fix, but test still passed for me, I was testing with three loop devices
> as SCRATCH_DEV_POOL, and all default mkfs & mount options
> 
> SECTION       -- btrfs
> RECREATING    -- btrfs on /dev/mapper/testvg-lv1
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 fedoravm 5.16.0-rc2 #22 SMP PREEMPT Mon Nov 29 00:54:26 CST 2021
> MKFS_OPTIONS  -- /dev/loop0
> MOUNT_OPTIONS -- /dev/loop0 /mnt/scratch
>                                                                      
> btrfs/254 5s ...  5s
> Ran: btrfs/254
> Passed all 1 tests
> 
> Anything wrong with my setup?
> 
> And if tested with lv devices as SCRATCH_DEV_POOL
> 
> SCRATCH_DEV_POOL="/dev/mapper/testvg-lv2 /dev/mapper/testvg-lv3 /dev/mapper/testvg-lv4 /dev/mapper/testvg-lv5 /dev/mapper/testvg-lv6"
> 
> I got the following test failure
> 
>   QA output created by 254
> +ERROR: cannot unregister device '/dev/mapper/254-test': No such file or directory
>   Label: none  uuid: <UUID>
>          Total devices <NUM> FS bytes used <SIZE>
>          devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> 
> Maybe we should use _require_scratch_nolvm as well?
> 

The test case is inconsistent because the systemd-udev block device scan 
interferes with the test script. There is no way to disable the 
systemd-udev scan (that I could find).

The same inconsistency (due to race with systemd-udev scan) would 
persist with/without lvm.

So when the race fails, the test case is successful to reproduce the 
issue. As you saw in the 2nd iteration.

Any suggestions?

Thanks, Anand


>> ---
>> v2: Add kernel patch title in the test case
>>      Redirect device add output to /dev/null (avoids tirm message)
>>      Use the lv path for mkfs and the dm path for the device add
>>       so that now path used in udev scan should match with what
>>       we already have in the kernel memory.
>>
>> -       _mkfs_dev $uuid -draid1 -mraid1 $dmdev $scratch_dev2
>> +       _mkfs_dev $uuid -draid1 -mraid1 $lvdev $scratch_dev2
>>   
>>          # Add device should free the device under $uuid in the kernel.
>> -       $BTRFS_UTIL_PROG device add -f $lvdev $seq_mnt > /dev/null 2>&1
>> +       $BTRFS_UTIL_PROG device add -f $dmdev $seq_mnt > /dev/null 2>&1
>>
>>
>>   tests/btrfs/254     | 113 ++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/254.out |   6 +++
>>   2 files changed, 119 insertions(+)
>>   create mode 100755 tests/btrfs/254
>>   create mode 100644 tests/btrfs/254.out
>>
>> diff --git a/tests/btrfs/254 b/tests/btrfs/254
>> new file mode 100755
>> index 000000000000..b70b9d165897
>> --- /dev/null
>> +++ b/tests/btrfs/254
>> @@ -0,0 +1,113 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2021 Anand Jain. All Rights Reserved.
>> +# Copyright (c) 2021 Oracle. All Rights Reserved.
>> +#
>> +# FS QA Test No. 254
>> +#
>> +# Test if the kernel can free the stale device entries.
>> +#
>> +# Tests bug fixed by the kernel patch:
>> +#	btrfs: harden identification of the stale device
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick
>> +
>> +# Override the default cleanup function.
>> +node=$seq-test
>> +cleanup_dmdev()
>> +{
>> +	_dmsetup_remove $node
>> +}
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -f $tmp.*
>> +	rm -rf $seq_mnt > /dev/null 2>&1
>> +	cleanup_dmdev
> 
> Should wipefs in cleanup as well, otherwise test fails with non-unique
> UUID
> 
> -Label: none  uuid: <UUID>
> -       Total devices <NUM> FS bytes used <SIZE>
> -       devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> -       *** Some devices missing
> +ERROR: non-unique UUID: 12345678-1234-1234-1234-123456789abc
> +btrfs-progs v5.4
> +See http://btrfs.wiki.kernel.org for more information.
> 
> Thanks,
> Eryu
> 
>> +}
>> +
>> +# Import common functions.
>> +. ./common/filter
>> +. ./common/filter.btrfs
>> +
>> +# real QA test starts here
>> +_supported_fs btrfs
>> +_require_scratch_dev_pool 3
>> +_require_block_device $SCRATCH_DEV
>> +_require_dm_target linear
>> +_require_btrfs_forget_or_module_loadable
>> +_require_scratch_nocheck
>> +_require_command "$WIPEFS_PROG" wipefs
>> +
>> +_scratch_dev_pool_get 3
>> +
>> +setup_dmdev()
>> +{
>> +	# Some small size.
>> +	size=$((1024 * 1024 * 1024))
>> +	size_in_sector=$((size / 512))
>> +
>> +	table="0 $size_in_sector linear $SCRATCH_DEV 0"
>> +	_dmsetup_create $node --table "$table" || \
>> +		_fail "setup dm device failed"
>> +}
>> +
>> +# Use a known it is much easier to debug.
>> +uuid="--uuid 12345678-1234-1234-1234-123456789abc"
>> +lvdev=/dev/mapper/$node
>> +
>> +seq_mnt=$TEST_DIR/$seq.mnt
>> +mkdir -p $seq_mnt
>> +
>> +test_forget()
>> +{
>> +	setup_dmdev
>> +	dmdev=$(realpath $lvdev)
>> +
>> +	_mkfs_dev $uuid $dmdev
>> +
>> +	# Check if we can un-scan using the mapper device path.
>> +	$BTRFS_UTIL_PROG device scan --forget $lvdev
>> +
>> +	# Cleanup
>> +	$WIPEFS_PROG -a $lvdev > /dev/null 2>&1
>> +	$BTRFS_UTIL_PROG device scan --forget
>> +
>> +	cleanup_dmdev
>> +}
>> +
>> +test_add_device()
>> +{
>> +	setup_dmdev
>> +	dmdev=$(realpath $lvdev)
>> +	scratch_dev2=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
>> +	scratch_dev3=$(echo $SCRATCH_DEV_POOL | awk '{print $3}')
>> +
>> +	_mkfs_dev $scratch_dev3
>> +	_mount $scratch_dev3 $seq_mnt
>> +
>> +	_mkfs_dev $uuid -draid1 -mraid1 $lvdev $scratch_dev2
>> +
>> +	# Add device should free the device under $uuid in the kernel.
>> +	$BTRFS_UTIL_PROG device add -f $dmdev $seq_mnt > /dev/null 2>&1
>> +
>> +	_mount -o degraded $scratch_dev2 $SCRATCH_MNT
>> +
>> +	# Check if the missing device is shown.
>> +	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
>> +					_filter_btrfs_filesystem_show
>> +
>> +	$UMOUNT_PROG $seq_mnt
>> +	_scratch_unmount
>> +	cleanup_dmdev
>> +}
>> +
>> +test_forget
>> +test_add_device
>> +
>> +_scratch_dev_pool_put
>> +
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/254.out b/tests/btrfs/254.out
>> new file mode 100644
>> index 000000000000..20819cf5140c
>> --- /dev/null
>> +++ b/tests/btrfs/254.out
>> @@ -0,0 +1,6 @@
>> +QA output created by 254
>> +Label: none  uuid: <UUID>
>> +	Total devices <NUM> FS bytes used <SIZE>
>> +	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>> +	*** Some devices missing
>> +
>> -- 
>> 2.27.0
