Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AAC58EA3E
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 12:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiHJKIj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 06:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiHJKI2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 06:08:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB3274344;
        Wed, 10 Aug 2022 03:08:27 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A8hsMr031947;
        Wed, 10 Aug 2022 10:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=AUmcREAEpPw8/785ciiX/pI71EhvHAOs9nIaI5ZN2XE=;
 b=D5cdZSYw8uVUgCJ/yrGHJHIxoavqNfzs+ZVUoGMz1nQfC61dAddlX8EFuUCRStTSzYzy
 ilr2I/yw0h5oXeVxAfY1Sl8pBxKLmYpgpqlTi7qCV5YdOSbZh1nRDO1eb9SKpcF92i0g
 ELowxFOUlZD2uUl0aD07EmAY6nxRjK9hE16b/RA/BLaFKqKdeA4L3gQKbq9zPNixKlG0
 /R+rhmWDr2vqixmsZuOM1mqpiSGsgisImWWkwi/zYx5Ic5/oA2EodQFsNQzChLCXEbTR
 7tj2uv4f6RW6ElD8uCvMGdryb7XXpw2IrgmD/xO2AMKIqg8iDK9YaO4XW3doCv1L6mFB jQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqdsek9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 10:08:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27A9Ks6k015453;
        Wed, 10 Aug 2022 10:08:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqj0eth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 10:08:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRu9am4OcnEBG8PQ8MiMhsxXnK6nIIQlYzRx8Gmt+JfrZiWAZ7scgpHi2bKPQdbdlWS8XCdz8gAVbE/J6014UpUIj1pTovATsvEzEVsOYE4kO+DOpcWa1gqEGp63mmZZ136MouEAoV+dXNnLA+tYDPv2pyWyT8xWetaixosQLjTbnHoM/Jfd/Bo6dlPYOhf1cBg5hEQYw7GzTF7hHgHK4lKY0C0xFYs+ue1M7Emyrd/sxP5kg47AfWcLHMfM4qwlG8bnsm9URn2XEL0yjsZfPjEqmEtANNQyv0rAVi9RSiCTrpibdXCXUFPLcqQZCsswCTeb52k1CP4ZE138Flt5Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUmcREAEpPw8/785ciiX/pI71EhvHAOs9nIaI5ZN2XE=;
 b=ALdTEKx+qSForOM7JMRv4pm1KdG7MP3kuf8qKEG+6OAhAPtB4/AtNBMHOrGvcGxmj+jwCWSIvhwX91vMNSnB0ce+Q2T43mkVKejJmgN+ifz1rCpbXqu0PEErB9vSirSJJnP+N5hNpHW5Wk1DH3tRNr9uZre7X0xKKaectAm9RO78Vs8tFRlWv5S+xCRQEWh5OaU6Y5VZOH9kohBxjncZhdoB49m3ydZ2GNIXBt6/ZHouFmURfuo5hh/2ClnIEMsbBPXdU50WhOaccxkiDDiy2L3YwmBCRS+Av/4q/ryvAjstH4dSTbDZa/kn6npIHI3FzCXdGrmpTUzBGVPtnmJJSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUmcREAEpPw8/785ciiX/pI71EhvHAOs9nIaI5ZN2XE=;
 b=BPYhsZS7Xvs9iwmgCpOHYyDHRqxY1Vy+mn01IWzINJ7dXKQS40Up6lkWk+qUbbI7DpzrEldkr6tZniZdplPrhZLCuMvv9QeGj+tNEgeZS0tYvuQNQ/sJrUW+8aog5iarTUrDjyKLf8weHl6NkdgqUQ/cbUh+rdsZJL4Issg7LW4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB3565.namprd10.prod.outlook.com (2603:10b6:208:112::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 10 Aug
 2022 10:08:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%8]) with mapi id 15.20.5504.021; Wed, 10 Aug 2022
 10:08:04 +0000
Message-ID: <35bfb0be-1f46-a2d1-fed1-dd582aedf4a2@oracle.com>
Date:   Wed, 10 Aug 2022 18:07:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] Fix btrfs_find_device for btrfs/249
To:     "Flint.Wang" <hmsjwzb@zoho.com>
Cc:     nborisov@suse.com, strongbox8@zoho.com, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220810071817.4435-1-hmsjwzb@zoho.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220810071817.4435-1-hmsjwzb@zoho.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7dd4e3a-f29f-40ef-98ce-08da7ab836fa
X-MS-TrafficTypeDiagnostic: MN2PR10MB3565:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o1lglciHYAURFIeUGrumQQ4fjqc9b0RzarJW2aqkZ8dnApIpK3zIDYgb3FSrWna2TV2x7Zi2VxRO5uqYrBF9bGLMv2ztMXB5xN76Ac4/yMIpL9OQ3C86tgK82FBRGWHzWLEtfRR/2iQo0af1L+mwYQlTDXR+SXmZfczHIcxG5T5AxK+aAq7lH4HuZS4uGgEuncbbke2wFnueFXzhKV9oSTigIVKpakQTrFn9xCjni29rhdynUMuxYQR7CePZVyr3w79GPPyFRX++k1gJC6xl7/yzepiRdnBgY2kRIyZNS6GoVVC1m5fTMBNYAblUNMO0qmzaY4ARih1gidtff6YOfjEdFNPjGRAVk9SzQoI1SK7uZtINyuII1Xo3P+LxUJharoVe92nFg9F6zB4W7QqKzfnPbkhZoM7TLgy+K+vA2NuyBenWz1bbNXrdAMuyBBxZnNT3i+QQpk6ZN2W/+clIKUBZ1//6gWvcH9VPsqvmexYMNOhYKYloa9sW0t0MP1V8vEt9ybtVzH3AbzLser2U4iEHST3xG8BrVAfdx07qmg4HCAsbJdlzDC9HGLHHqHELL1MF1FvZacaTYW9f0yTx7Lyfk13isLwnSYf+nOSS6rDV/D6QEcPKz86ch8BH8B5xKXpXuT2DBgwjkd/nfew94OgCGEwZZewQlCH+eL/lBANjAuTsCb919DVv7kTrKGOVik4WAeLYvu8G71SjRMWQT7rt5TwtDNJa7hsENe8BlRBLHdobZXTymj/TpIFAM47nfa35goCvGkoEXAX6PTE6MeLRCpOelgko7lfGkS7Vcgww3ibBHzQrqorV6FYF6d1VEWGYbDZWhpRNrs21YGqFlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(136003)(366004)(396003)(6486002)(38100700002)(44832011)(30864003)(5660300002)(8936002)(186003)(53546011)(6506007)(6512007)(86362001)(31696002)(83380400001)(478600001)(26005)(6666004)(2906002)(316002)(2616005)(31686004)(66946007)(36756003)(4326008)(8676002)(66556008)(41300700001)(66476007)(6916009)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnVEQWxIWDk2bWhQNEZKSVRtaU02Q3diU0hsQzYzeFY0cjRWVDU3WEJsWHRX?=
 =?utf-8?B?Q2haU0haeGNSSTRJYnBQL3JvVXVLMldNNGhFVVp1S3cxQmxjbWhEZ0ZKT3pF?=
 =?utf-8?B?QUIwMTlaUm1OdW9HMDNzdDVEa3dMVGFwemd6NE5nQ2pCTWNQVDJ6UFhLblZm?=
 =?utf-8?B?TzNtNWlVUHhnUVdhclVvNlo2SzEwMkY3eFJUaFN4OUFHU2lnVmZpS0QwYTZZ?=
 =?utf-8?B?bjBJdkxZQ1dtWE5YUWQ3ZDVDS1QzOE1NdUNNVkoxZUhZRnFiQzFncFdJTCtR?=
 =?utf-8?B?NzE2SHRtZXhCblQ1NHNLNHpvTDFVVkdEVzdYc1FnY1hnYmFmNzZDcjE0NTZJ?=
 =?utf-8?B?aDNIdU5iNGRkYXdXaXBzdWQ2bUF4Q0hWRmxBUnUwYVpUWHNneVJWcHl3QVox?=
 =?utf-8?B?ekZmOUdRK0JiUDZ0VnBBTXJIcE40UTR1QVMxUGhURTZIbmRRSHRBMG5ndzBk?=
 =?utf-8?B?UU5GS0JrZFF3UU5ZaVAzYk1uRzZ1UFpuMFl6TjVDTWZ4MmhxaUd2Vm1nUXUy?=
 =?utf-8?B?MVRoWW1hT21lL3FLTklDYXZuZGtLTVluMjI4UitKZnVoVEQ3RXBnaTJwNUN6?=
 =?utf-8?B?WUkyaVYrUUtyOXFKZzBWUlBxcUQra0JtUUlObERVLzYxTjlSMkxsME9FZXox?=
 =?utf-8?B?R25UMFYxY3EyU0dzZnVsQjN1dWlZN3kwMlplVzNmNXNyb0w0ZFJWTzllN3Zj?=
 =?utf-8?B?UDRmQzNsQ0lxRkhNN09Ybmp6bzVDQkJPOWJMeVB6MzRidlJJdHZXMCtKMkt2?=
 =?utf-8?B?bzRLbnlkdmMzRkdGYkNFL0dTUE9EOVd1RnphazdUdURybnVrU3pZNEtZbmpC?=
 =?utf-8?B?a1AxTm1ma3BOYlliUFRtMXRLWS9VRWpkMlg2QWplYzNKU3NCZHlVd3J0RG94?=
 =?utf-8?B?cnQ3OVN3T3U4aGxvOFRqb3FqZWRBeDAyV29qL3Q3c0ZsVUpieGVZb2xGb1Ey?=
 =?utf-8?B?QmRUWDU0NVUycTMxQmRFTVZldzFwSjdjRS93ZWg3M0t3RzNnSHhoV1c0ZDZR?=
 =?utf-8?B?ckV2NHVvdjBTK1Y3QnovY1ZYays2L3dKNHRzSEtYVlIvOWlIVkFtcTE5SWZI?=
 =?utf-8?B?cGRPL1d3bjFyK1NqREhtTE9XcmM4bSsrSWlVcVBBcEVGYitkSmVTR1M2VjUw?=
 =?utf-8?B?T0gyVUF1OTE0NHdBUml6dzVTYzhnN3J1TnVlbzcvTTNYTTVJMlBLK2RwdTZj?=
 =?utf-8?B?WlkvS1RldUNoenY4T0RwZEhXbjl3MW5HOW1VMHhnRVN4aHpNOVRhK2Qyello?=
 =?utf-8?B?WUt2VzZZNG5CYlR6OUJRUWloUHlhcnNmbXdZWXZtZGRRQlZ0aW9HU0h5cklR?=
 =?utf-8?B?dzJDanZONFFQVkJTRHA5VXphS1JEWWRQbXh2QjZETEtmMmI1UUhUWVpxdnMv?=
 =?utf-8?B?Mk1zVDRBTHBWai90cjV4RU5LbGZ6S21TNlJYNkx2enREeFY2ZG40Z0FyUUJj?=
 =?utf-8?B?cHM1aEhPZ1h6bnBHMDZmcm12aThYa0J5VEFnT3cxZXUrbW04ZDdnUEFrY3Rl?=
 =?utf-8?B?aGlIZjRqWXlrL2RCT0VpbEpYM3hBRHBhUFJ2Mk5yN0lCZFU2VXVtaVJIK2tx?=
 =?utf-8?B?OVBHR3U1VS9zYVh6Q2N5QVBXR3lJL21pdEJyQWNiMmhVckdVQWxVYjVzQitl?=
 =?utf-8?B?L2tqZ205bGVXeFAxUForckgzdjhYckQ2dDM0b3Y5ZUZXQy8zUlhWeU1BT3FQ?=
 =?utf-8?B?ZGdYaVFveFpjUUFUTmZOZlhwaW05Z2FjV0Q2aU1pQ2ZlYWFjRllUczAyVTBZ?=
 =?utf-8?B?YXNQVzdMcSswWUlqWEFEVE4wWHg0bkN3UXZ4N0U0M3B0R1lSYTBMSW11Umlp?=
 =?utf-8?B?bFl5YTBxVkdHdHBCMjliY1VPVm5lbEx6T3hmRFd2WHhRUlg2NXpPeHRqRjJi?=
 =?utf-8?B?STVUdDN6WmlWVjNqdFJiRDNrS1JNWnpsVDNVUHpXbnk3dlM1elA5L1hYZ3J2?=
 =?utf-8?B?ajQ3aVFQbGNsRnpFN0ZZaThqV0N4R3JxSlhhN2liS2FZbDVjNFZ2SjkvR2M4?=
 =?utf-8?B?VWxMaUhKOGtYZUJhQnBsSG40bDJVYitJRitHdHlKS0plL0lhZ3dveWE3Qkw1?=
 =?utf-8?B?a2ZCQzlJdlljVU01SExVZjdWaGQ5b2huaUlhQjZ5YkJISnJDQ0hjUTM2MGFm?=
 =?utf-8?Q?/FIoIiV12fdtdYpvOlrMXcx0q?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7dd4e3a-f29f-40ef-98ce-08da7ab836fa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 10:08:04.4278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4T8ER4woltS+LdqWeMtVby6b9SLPKlfQcHzu5OQDdMcQo3QzujkCRYmY2tdTPEwo0AY4sPt52skgILCzgHUqlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3565
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100031
X-Proofpoint-GUID: aYz5Y6ynqAXsvppibju6PhZeSU4ISeSP
X-Proofpoint-ORIG-GUID: aYz5Y6ynqAXsvppibju6PhZeSU4ISeSP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/08/2022 15:18, Flint.Wang wrote:
> testcase btrfs249 failed.

  Without the progs patch below, it should fail/ not run.

  btrfs-progs: read fsid from the sysfs in device_is_seed

  AFAIK the above btrfs-progs patch in the ML is unintegrated. I am not 
sure why.

Thanks, Anand


> [How to reproduce]
> mkfs.btrfs -f -d raid1 -m raid1 /dev/sdb /dev/sdc
> btrfstune -S 1 /dev/sdb
> wipefs -a /dev/sdb
> mount -o degraded /dev/sdc /mnt/scratch
> btrfs device add -f /dev/sdd /mnt/scratch
> btrfs filesystem usage /mnt/scratch
> 
> [Root cause]
> mkfs.btrfs -f -d raid1 -m raid1 /dev/sdb /dev/sdc
> btrfstune -S 1 /dev/sdb
> wipefs -a /dev/sdb
> mount -o degraded /dev/sdc /mnt/scratch
> 
> In the above commands, btrfstune command set the sdb and sdc to seeding device.
> After that you wipe the filesystem on sdb. After mount, you will find the status of sdb is missing.
> 
> btrfs device add -f /dev/sdd /mnt/scratch:
> This command will invoke btrfs_setup_sprout to do the job.
> It put the devices on fs_devices->devices to seed_devices list.
> So only sdd is on the fs_devices->devices list. sdb(missing), sdc on the seed_devices list.
> But when we look into the btrfs_find_devices function, it find devices both in devices list and seed_devices list.
> 
> btrfs filesystem usage /mnt/scratch
> This command use ioctl to get device info. The assertion is triggered because it finds the number of devices is inconsistent.
> 
> [My fix solution]
> 1. Add noseed argument to btrfs_find_device. It force the function only look into devices list.
> 2. Add a new ioctl request(BTRFS_IOC_DEV_INFO_NOSEED) in case some application may depend the original ioctl behavior on BTRFS_IOC_DEV_INFO
> 3. Modify load_device_info and load_chunk_and_device_info in btrfs-prog for appropriate ioctl call.
> 
> After the change, btrfs249 passed.
> 
> Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
> ---
>   fs/btrfs/dev-replace.c     |  8 ++++----
>   fs/btrfs/ioctl.c           | 10 ++++++----
>   fs/btrfs/scrub.c           |  4 ++--
>   fs/btrfs/volumes.c         | 22 ++++++++++++----------
>   fs/btrfs/volumes.h         |  5 ++++-
>   include/uapi/linux/btrfs.h |  2 ++
>   6 files changed, 30 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index f43196a893ca3..49d3c587c2948 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -101,7 +101,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
>   		 * We don't have a replace item or it's corrupted.  If there is
>   		 * a replace target, fail the mount.
>   		 */
> -		if (btrfs_find_device(fs_info->fs_devices, &args)) {
> +		if (btrfs_find_device(fs_info->fs_devices, &args, false)) {
>   			btrfs_err(fs_info,
>   			"found replace target device without a valid replace item");
>   			ret = -EUCLEAN;
> @@ -163,7 +163,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
>   		 * We don't have an active replace item but if there is a
>   		 * replace target, fail the mount.
>   		 */
> -		if (btrfs_find_device(fs_info->fs_devices, &args)) {
> +		if (btrfs_find_device(fs_info->fs_devices, &args, false)) {
>   			btrfs_err(fs_info,
>   			"replace devid present without an active replace item");
>   			ret = -EUCLEAN;
> @@ -174,9 +174,9 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
>   		break;
>   	case BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED:
>   	case BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED:
> -		dev_replace->tgtdev = btrfs_find_device(fs_info->fs_devices, &args);
> +		dev_replace->tgtdev = btrfs_find_device(fs_info->fs_devices, &args, false);
>   		args.devid = src_devid;
> -		dev_replace->srcdev = btrfs_find_device(fs_info->fs_devices, &args);
> +		dev_replace->srcdev = btrfs_find_device(fs_info->fs_devices, &args, false);
>   
>   		/*
>   		 * allow 'btrfs dev replace_cancel' if src/tgt device is
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index fe0cc816b4eba..bdf1578839c99 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2039,7 +2039,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
>   	}
>   
>   	args.devid = devid;
> -	device = btrfs_find_device(fs_info->fs_devices, &args);
> +	device = btrfs_find_device(fs_info->fs_devices, &args, false);
>   	if (!device) {
>   		btrfs_info(fs_info, "resizer unable to find device %llu",
>   			   devid);
> @@ -3721,7 +3721,7 @@ static long btrfs_ioctl_fs_info(struct btrfs_fs_info *fs_info,
>   }
>   
>   static long btrfs_ioctl_dev_info(struct btrfs_fs_info *fs_info,
> -				 void __user *arg)
> +				 void __user *arg, bool noseed)
>   {
>   	BTRFS_DEV_LOOKUP_ARGS(args);
>   	struct btrfs_ioctl_dev_info_args *di_args;
> @@ -3737,7 +3737,7 @@ static long btrfs_ioctl_dev_info(struct btrfs_fs_info *fs_info,
>   		args.uuid = di_args->uuid;
>   
>   	rcu_read_lock();
> -	dev = btrfs_find_device(fs_info->fs_devices, &args);
> +	dev = btrfs_find_device(fs_info->fs_devices, &args, noseed);
>   	if (!dev) {
>   		ret = -ENODEV;
>   		goto out;
> @@ -5468,7 +5468,7 @@ long btrfs_ioctl(struct file *file, unsigned int
>   	case BTRFS_IOC_FS_INFO:
>   		return btrfs_ioctl_fs_info(fs_info, argp);
>   	case BTRFS_IOC_DEV_INFO:
> -		return btrfs_ioctl_dev_info(fs_info, argp);
> +		return btrfs_ioctl_dev_info(fs_info, argp, false);
>   	case BTRFS_IOC_TREE_SEARCH:
>   		return btrfs_ioctl_tree_search(inode, argp);
>   	case BTRFS_IOC_TREE_SEARCH_V2:
> @@ -5570,6 +5570,8 @@ long btrfs_ioctl(struct file *file, unsigned int
>   	case BTRFS_IOC_ENCODED_WRITE_32:
>   		return btrfs_ioctl_encoded_write(file, argp, true);
>   #endif
> +	case BTRFS_IOC_DEV_INFO_NOSEED:
> +		return btrfs_ioctl_dev_info(fs_info, argp, true);
>   	}
>   
>   	return -ENOTTY;
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 3afe5fa50a631..4b734d76776ca 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -4143,7 +4143,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
>   		goto out_free_ctx;
>   
>   	mutex_lock(&fs_info->fs_devices->device_list_mutex);
> -	dev = btrfs_find_device(fs_info->fs_devices, &args);
> +	dev = btrfs_find_device(fs_info->fs_devices, &args, false);
>   	if (!dev || (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) &&
>   		     !is_dev_replace)) {
>   		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
> @@ -4321,7 +4321,7 @@ int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
>   	struct scrub_ctx *sctx = NULL;
>   
>   	mutex_lock(&fs_info->fs_devices->device_list_mutex);
> -	dev = btrfs_find_device(fs_info->fs_devices, &args);
> +	dev = btrfs_find_device(fs_info->fs_devices, &args, false);
>   	if (dev)
>   		sctx = dev->scrub_ctx;
>   	if (sctx)
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 272901514b0c1..1abd75e90cd9e 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -808,7 +808,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   		};
>   
>   		mutex_lock(&fs_devices->device_list_mutex);
> -		device = btrfs_find_device(fs_devices, &args);
> +		device = btrfs_find_device(fs_devices, &args, false);
>   
>   		/*
>   		 * If this disk has been pulled into an fs devices created by
> @@ -2075,7 +2075,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>   	if (ret)
>   		return ret;
>   
> -	device = btrfs_find_device(fs_info->fs_devices, args);
> +	device = btrfs_find_device(fs_info->fs_devices, args, false);
>   	if (!device) {
>   		if (args->missing)
>   			ret = BTRFS_ERROR_DEV_MISSING_NOT_FOUND;
> @@ -2381,7 +2381,7 @@ struct btrfs_device *btrfs_find_device_by_devspec(
>   
>   	if (devid) {
>   		args.devid = devid;
> -		device = btrfs_find_device(fs_info->fs_devices, &args);
> +		device = btrfs_find_device(fs_info->fs_devices, &args, false);
>   		if (!device)
>   			return ERR_PTR(-ENOENT);
>   		return device;
> @@ -2390,7 +2390,7 @@ struct btrfs_device *btrfs_find_device_by_devspec(
>   	ret = btrfs_get_dev_args_from_path(fs_info, &args, device_path);
>   	if (ret)
>   		return ERR_PTR(ret);
> -	device = btrfs_find_device(fs_info->fs_devices, &args);
> +	device = btrfs_find_device(fs_info->fs_devices, &args, false);
>   	btrfs_put_dev_args_from_path(&args);
>   	if (!device)
>   		return ERR_PTR(-ENOENT);
> @@ -2551,7 +2551,7 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
>   				   BTRFS_FSID_SIZE);
>   		args.uuid = dev_uuid;
>   		args.fsid = fs_uuid;
> -		device = btrfs_find_device(fs_info->fs_devices, &args);
> +		device = btrfs_find_device(fs_info->fs_devices, &args, false);
>   		BUG_ON(!device); /* Logic error */
>   
>   		if (device->fs_devices->seeding) {
> @@ -6821,7 +6821,7 @@ static bool dev_args_match_device(const struct btrfs_dev_lookup_args *args,
>    * only devid is used.
>    */
>   struct btrfs_device *btrfs_find_device(const struct btrfs_fs_devices *fs_devices,
> -				       const struct btrfs_dev_lookup_args *args)
> +				       const struct btrfs_dev_lookup_args *args, bool noseed)
>   {
>   	struct btrfs_device *device;
>   	struct btrfs_fs_devices *seed_devs;
> @@ -6832,6 +6832,8 @@ struct btrfs_device *btrfs_find_device(const struct btrfs_fs_devices *fs_devices
>   				return device;
>   		}
>   	}
> +	if (noseed)
> +		return NULL;
>   
>   	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list) {
>   		if (!dev_args_match_fs_devices(args, seed_devs))
> @@ -7095,7 +7097,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
>   				   btrfs_stripe_dev_uuid_nr(chunk, i),
>   				   BTRFS_UUID_SIZE);
>   		args.uuid = uuid;
> -		map->stripes[i].dev = btrfs_find_device(fs_info->fs_devices, &args);
> +		map->stripes[i].dev = btrfs_find_device(fs_info->fs_devices, &args, false);
>   		if (!map->stripes[i].dev) {
>   			map->stripes[i].dev = handle_missing_device(fs_info,
>   								    devid, uuid);
> @@ -7226,7 +7228,7 @@ static int read_one_dev(struct extent_buffer *leaf,
>   			return PTR_ERR(fs_devices);
>   	}
>   
> -	device = btrfs_find_device(fs_info->fs_devices, &args);
> +	device = btrfs_find_device(fs_info->fs_devices, &args, false);
>   	if (!device) {
>   		if (!btrfs_test_opt(fs_info, DEGRADED)) {
>   			btrfs_report_missing_device(fs_info, devid,
> @@ -7884,7 +7886,7 @@ int btrfs_get_dev_stats(struct btrfs_fs_info *fs_info,
>   
>   	mutex_lock(&fs_devices->device_list_mutex);
>   	args.devid = stats->devid;
> -	dev = btrfs_find_device(fs_info->fs_devices, &args);
> +	dev = btrfs_find_device(fs_info->fs_devices, &args, false);
>   	mutex_unlock(&fs_devices->device_list_mutex);
>   
>   	if (!dev) {
> @@ -8026,7 +8028,7 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
>   	}
>   
>   	/* Make sure no dev extent is beyond device boundary */
> -	dev = btrfs_find_device(fs_info->fs_devices, &args);
> +	dev = btrfs_find_device(fs_info->fs_devices, &args, false);
>   	if (!dev) {
>   		btrfs_err(fs_info, "failed to find devid %llu", devid);
>   		ret = -EUCLEAN;
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 5639961b3626f..4b6bcc777f752 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -609,7 +609,10 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len);
>   int btrfs_grow_device(struct btrfs_trans_handle *trans,
>   		      struct btrfs_device *device, u64 new_size);
>   struct btrfs_device *btrfs_find_device(const struct btrfs_fs_devices *fs_devices,
> -				       const struct btrfs_dev_lookup_args *args);
> +				       const struct btrfs_dev_lookup_args *args,
> +				       bool noseed);
> +struct btrfs_device *btrfs_find_device_noseed(const struct btrfs_fs_devices *fs_devices,
> +					      const struct btrfs_dev_lookup_args *args);
>   int btrfs_shrink_device(struct btrfs_device *device, u64 new_size);
>   int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *path);
>   int btrfs_balance(struct btrfs_fs_info *fs_info,
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index 7ada84e4a3ed1..880b565479a12 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -1078,6 +1078,8 @@ enum btrfs_err_code {
>   				       struct btrfs_ioctl_scrub_args)
>   #define BTRFS_IOC_DEV_INFO _IOWR(BTRFS_IOCTL_MAGIC, 30, \
>   				 struct btrfs_ioctl_dev_info_args)
> +#define BTRFS_IOC_DEV_INFO_NOSEED _IOR(BTRFS_IOCTL_MAGIC, 30, \
> +				       struct btrfs_ioctl_dev_info_args)
>   #define BTRFS_IOC_FS_INFO _IOR(BTRFS_IOCTL_MAGIC, 31, \
>   			       struct btrfs_ioctl_fs_info_args)
>   #define BTRFS_IOC_BALANCE_V2 _IOWR(BTRFS_IOCTL_MAGIC, 32, \
