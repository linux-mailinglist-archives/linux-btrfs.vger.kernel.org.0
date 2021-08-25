Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F295A3F6CDE
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Aug 2021 03:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbhHYBBb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 21:01:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40420 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234058AbhHYBBa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 21:01:30 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17OLQcms015021;
        Wed, 25 Aug 2021 01:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=aTkfSjF9q8+UziXV1JYRKpa9u7G1vE4TaoGUrJ+ul/M=;
 b=sBXYx+0C/uGCtXf9mGokqzVxNo07Q7ShKyMjY4PIv6LBup0bvAIz8+LMGCQ8ua+DxCwt
 otpIlzt/KMGT0JgIpeMathXRnJbgvOhCO3poCUcs26SBvsjcAcfwXOdLpY3WHSz4+DEW
 6+9TUomlFU82plp7M0ITOvGjgA1TosQ75LZIOlUv2UufAtNTT3A4OJrBgPnArPlVQG7y
 +tzcf+blrVpt8+gCC4esK0wLCxEeFP5+Cw5QeeMLyFiJmDnppaxwAp4szMuHolhzqQZR
 jDTeK09FqyUtR2oN16i4evHbhbkG6sIJ7R6oTAh5w1A2kmJJ0Hcg1EukTQbZs2eJuDRk lQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=aTkfSjF9q8+UziXV1JYRKpa9u7G1vE4TaoGUrJ+ul/M=;
 b=s++kpQu4ZBdUpO3+dj6/QdjNXPkAKff65eKxsVg7eUqE3njcSxxJCfWzGjYIbBw56a5l
 kJz+5FqtVWXp1kNVQQs9UGI4x6jb6pVMQJC5NzW0yfksnQkwLITJoEUmDn+nHGmyfz3N
 J9lcZXiERH+OHpRopF4332WpPzPvDPibh6IZuOPc4gjb7ZmDJAxUso4t0qHjHCogPtT+
 OWHgtHeclARhgquucWOt0CvjEt8+asVrZWNNjrrV1zW4jbAcemGmUrd9J0aPBpY2WSkk
 gnHQOBlGEMMFH9CZtXr0COyCSwsGVfOoVaFrlXzKAXToBjfM5ZW1Z1/YGBmvl89nRbs4 vA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amwh6j3uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 01:00:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17P0xYEX002294;
        Wed, 25 Aug 2021 01:00:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by userp3030.oracle.com with ESMTP id 3ajpkyap8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 01:00:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDWRjmxK7vcQ9P8Kveyms2F42tfNz5E/0FKwAVZybrA3ZBluoT/TlYzWjOgOevnsU41q2se65hwf5xxnAt9hG/HRWh83TsznkMpWmGSmmVrayAjSxAqIkyuDkUfTHoSWTVXI7w8Wv4+RB9sIFsJRTkEPehtgCMlYUts2Zq62IZCbbDn2u6/TptGsEOzy4CtMxYoK2Ig0wTJ3axDf+OZP8BWuozsM4QMgI5Eh0W+rAPKQuMYlJ69uT2TVEgV9+dQgWkouOd8pF2sozoQ622qWf9xpTpG9FXWzWDdu0mREXoNCWFTPUNHlV9f0170uyN6X14JVkYYGAphuyf9MG66PiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTkfSjF9q8+UziXV1JYRKpa9u7G1vE4TaoGUrJ+ul/M=;
 b=hJ9brl/ANdSZqImq9rAxtLw+je5so3D4IyWFTWSbZJYVC5mQI8em0hdi+l3yegJ4oRhT5YZ4jk1TnEbyk3PN14mJ8VPnsSU8TnWipDsNRSgo5+/GHFNCwmKRE7Sk+u20hR8PdOmoC7SE2w82jKztQvH8RGAfikMGCXR+PJkQiTmVjNRmwIq7fcxDJ1fqYHUKEKmGqIemLP1MU+BwzN9YFZHg+dHKQX8w9U+GzZOoivDLSnKRU9ajG70WM3krTNGC380hZNn/stycGJTC/U9mFVyWemc1NDdUFxTwOvoscR2fpMrZl98J+u7zelSKq+gD9Oh3sOhjor4oUjhczlVffQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTkfSjF9q8+UziXV1JYRKpa9u7G1vE4TaoGUrJ+ul/M=;
 b=x56MWz0au8W/2WhmTDlIABlQnl9DohZe/O0ViaMwMApVZt/+Chx6dhkBzGLwCQr7GIvcfa1dEEDH50Rjfuoz5Mhk2IjuQ8R59UsXRdJHqiTMRbTu8XD7/Krt85sVLliuDSxqUVo/N92DVdbq5zZVgnBKHgmwyIQkKILhJRcjDOc=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5186.namprd10.prod.outlook.com (2603:10b6:208:321::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 01:00:39 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 01:00:39 +0000
Subject: Re: [PATCH v2 5/7] btrfs: delay blkdev_put until after the device
 remove
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1627419595.git.josef@toxicpanda.com>
 <e6af22a1b116e908d26359b55c0d6e2d50fe3105.1627419595.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <b40a4fb9-d610-d6a7-9446-c4f023c207e4@oracle.com>
Date:   Wed, 25 Aug 2021 09:00:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <e6af22a1b116e908d26359b55c0d6e2d50fe3105.1627419595.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0096.apcprd06.prod.outlook.com
 (2603:1096:3:14::22) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR06CA0096.apcprd06.prod.outlook.com (2603:1096:3:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 01:00:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c444b5db-2051-440f-a01b-08d96763c11f
X-MS-TrafficTypeDiagnostic: BLAPR10MB5186:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5186DFA27ED42F8CCDCCDD10E5C69@BLAPR10MB5186.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OGlSPaF1KMtxXHYmREEWNE57yw8UZ3tpH79pSFM6nJMhbcS0ihfpIDFU2+1VoYj4L6uh1ZzoveAHDP2LLR1Hz+9ZSuUBjdf0CduOJ7KGq0IaNjke1J9VIHFrr8umh1+cms7pXKnINNngT0DXEpWyySTqH05ShzdTYhCQGHM1AxgsnVepGPd2rWeh8gRWVCJmng3zaWE2jR1jH/QxNVQGcDfRblA8sz8MSLd83qMiAwhbcHoaHF5HRD9HaJObbkKoFaaVg6A4LW2bGrIXh+wmMEWSUzHTp1TaMh2rXqr7taDVnmYn5kN06dTCHbWjO8tIk2pvX6Zx4SWS8G6sUu61x0w11z/r7y3Kgh5agampowvMUL1bN3LLzusLrmgliRdQ1E/pWTrDkNZ+d1edjSL9iLYWLaYs63NlS1pOD2NmkXQ0R/CY0oAIdBBi02xcFex2DUjccsvAVsEt9Qlvf4tlWe+clWC49SRJs66oC/N7Sky7RBetjQfvn3+kjjPElHyqqTnvtm+dpjSqRn3R3dA3VYNc86zuy/dYa04rr0W/OJDcBG317LPN8txTxh9XoezcqqErqStdBc+FoJuav2uJb3vf6AvQxN4GglBtwYzYfXz0NJDAQbGwPiNt66RFWbzPgW8cQ0owKweRh+oykWmJ4a0ockZicah4oXdGYaenPeVryBOemIQU8lvJEdBsekpgZtvxgAdWpeO9ZhvjqZ1manx9IYOwfH+ebZGuzTgRYrQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(366004)(136003)(346002)(66556008)(186003)(53546011)(66946007)(31696002)(8936002)(66476007)(5660300002)(38100700002)(2906002)(8676002)(86362001)(31686004)(16576012)(478600001)(6666004)(956004)(36756003)(2616005)(6486002)(316002)(26005)(44832011)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTVITmFSV1ZLWGFMTEtTVHFBbmJRbWFrYnBrbXFlZWdqMHRsYnIxenRFdE5R?=
 =?utf-8?B?TUZMc0toL1dpSkZYUlR5SXU0NDI2NXRFT29QTFFsZGxFMkc5QTNCdUpRZXRP?=
 =?utf-8?B?VVBmelVhZU9QOXR1UlBjYzhXMmtwUi9lZjN0K3UwWktDYnVaQWZpTDgwdHRR?=
 =?utf-8?B?ZkRHZ1pCdnBWUDJHS1hndW9zZVhzamlsYlpqN25HRUdzbnlqMWpjQnNrVWQ0?=
 =?utf-8?B?bmhHTU9RL3dCWTQ5OHRTY2dUMzJxVUZ1b2l0UWdHVjVIbmdTTDMrZG1ScFo2?=
 =?utf-8?B?VkFyQ1Y5dEdBRy9XMENjY2JBdWw3OUJBNk9BYXZxZUZvT2g4MVN3SGxLcnpJ?=
 =?utf-8?B?SkpENG94RFhoUmxJRVZya1ordWlsSVRmcFBqOWxZdUJ2V3dzMEdaZCtMaWZJ?=
 =?utf-8?B?MGpJK0s4TWFvUjJJRHZOQ1dpWEV3VHg0TXNlb3ZyMnRkYmtDelpDRE5pTHEz?=
 =?utf-8?B?QmhoUGVBTHZGVmtrYVJOTk9SKzVwSFNXZzBxRnAxVVVtWGI4OFo1VFBsN2Uy?=
 =?utf-8?B?TERWS3JmYmhTeGxjQzlTM1hnQWlSazlUdTQ3VGF1Qm5EUnVSbnRwMm1YcmU2?=
 =?utf-8?B?SWE4NUtWLzVXaWIxM3l6VDk0SXJ6OWFYc2RoRkdyWFN3WmpGOGJWMUQ2Q0pY?=
 =?utf-8?B?NHlsV3IvM2ZUWUZ4Y0p2WUNScllMYmRhOHRGdHJuZDBPajcwdmovSXcrS2s3?=
 =?utf-8?B?c3BUU0FXaEFkL2Q3YmRvbjM5NmNyQk9GWkcxM2lNRTZlMEtqVTlKRUdCenZh?=
 =?utf-8?B?d0YrM09Ebkp0OFB4ODRtczI5emFiTGFIT2NjNFJ2bm9zY1Z5Ym5rWUtvbGdj?=
 =?utf-8?B?RjNvMG9TelFQZ056Q04wYmJlQUpZOGRVWmx1b0FnUkdoQXdpQWkxa05vR21q?=
 =?utf-8?B?MjArOWxBK09NWGJ2cU90WTkwTzZHT3BDMnlpbW5KclhGb3dRc2RnVnlwU1NQ?=
 =?utf-8?B?L3pJTlZMWXEvdHRPODZvK3Vpc0tBblpSTDlqRTMxZmFXSUc4MlNzQmxMK2w0?=
 =?utf-8?B?KzIvYTFxc2xtNkVINXorbGxVK1pJM040MnF1RzcxcUV4cXRJb0JFSjQ0dFNU?=
 =?utf-8?B?cmhFNjMvUEt2R2FGYkdQYjJiSGk4enA4ZXF4UVNyekNvdEFrQWVaZnc0ZG4r?=
 =?utf-8?B?ZFlvSlRwSGZ5dW40cUI5SVlQVlVqZkVtOXBNT3JDMGM5NFhjSmVRNC9tZStj?=
 =?utf-8?B?LzdLV3FxTnEzd3ZiZzBPUk9JVlpzNVlWNEFxb0tVQmlVV1ozOFcvZFYyUjM0?=
 =?utf-8?B?T1NYWm5lRTUwbW1VTUkzR1hDa1NaRmxQWllib2tzSXZ6NXpjNW1kQkhoNnRk?=
 =?utf-8?B?cEZkalF1ZFJ6UUFyTTJtVGNLOHZUT0RSTjdtcUV5TG5TR1dkOEhxVG5XYTJB?=
 =?utf-8?B?MUZlZXJwcGxrbUVjNkV0eDhHREtBYysrLytycWlhWktBd3B3Zi9hSGdOclB6?=
 =?utf-8?B?ZFVoaXFzMTNxd2I0MGhnNmg5TTZ0S0ttc2tlZHlCQXJMWkVxWG5sSStxdkto?=
 =?utf-8?B?L2gwQVFuQnZtYW1EYzRiWThqaFRCT3VQak5oVVJlSlYrbzZaOE5aU0VkWENL?=
 =?utf-8?B?SDd6RmdaM3RSdTd6ZDBaaXBkdTNiUGsxWEY1SXJuWGZRODdsVEFlRXl5VmlW?=
 =?utf-8?B?K3NVc0I5S05nM0VVdzlDK1N5SDFENmpsTTZURTQrT1ZHcXJmY3dEajZZWDhK?=
 =?utf-8?B?V0YzZ0hlcytNM3N1ckk2S2NXaHZ5aGJNbGx3ckdFUjFqaHowUWR5c2hNU3Zo?=
 =?utf-8?Q?Gtuii3gIbJA/ic/VaweCaixcD4XncLflRwRlgCb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c444b5db-2051-440f-a01b-08d96763c11f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 01:00:39.1055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +y7Ugv8y/XBCR15IftD4LiUq6qVdmT4+ax63Vp6Ngvp3JndtuksFzxLtt1061LoH40eUimXbqIyl7Kccv3DHgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5186
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108250004
X-Proofpoint-ORIG-GUID: FY6dpAKGaCbiUmgO15ZcVhYwZ528rNkR
X-Proofpoint-GUID: FY6dpAKGaCbiUmgO15ZcVhYwZ528rNkR
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/07/2021 05:01, Josef Bacik wrote:
> When removing the device we call blkdev_put() on the device once we've
> removed it, and because we have an EXCL open we need to take the
> ->open_mutex on the block device to clean it up.  Unfortunately during
> device remove we are holding the sb writers lock, which results in the
> following lockdep splat
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.14.0-rc2+ #407 Not tainted
> ------------------------------------------------------
> losetup/11595 is trying to acquire lock:
> ffff973ac35dd138 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+0x67/0x5e0
> 
> but task is already holding lock:
> ffff973ac9812c68 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x660 [loop]
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #4 (&lo->lo_mutex){+.+.}-{3:3}:
>         __mutex_lock+0x7d/0x750
>         lo_open+0x28/0x60 [loop]
>         blkdev_get_whole+0x25/0xf0
>         blkdev_get_by_dev.part.0+0x168/0x3c0
>         blkdev_open+0xd2/0xe0
>         do_dentry_open+0x161/0x390
>         path_openat+0x3cc/0xa20
>         do_filp_open+0x96/0x120
>         do_sys_openat2+0x7b/0x130
>         __x64_sys_openat+0x46/0x70
>         do_syscall_64+0x38/0x90
>         entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #3 (&disk->open_mutex){+.+.}-{3:3}:
>         __mutex_lock+0x7d/0x750
>         blkdev_put+0x3a/0x220
>         btrfs_rm_device.cold+0x62/0xe5
>         btrfs_ioctl+0x2a31/0x2e70
>         __x64_sys_ioctl+0x80/0xb0
>         do_syscall_64+0x38/0x90
>         entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #2 (sb_writers#12){.+.+}-{0:0}:
>         lo_write_bvec+0xc2/0x240 [loop]
>         loop_process_work+0x238/0xd00 [loop]
>         process_one_work+0x26b/0x560
>         worker_thread+0x55/0x3c0
>         kthread+0x140/0x160
>         ret_from_fork+0x1f/0x30
> 
> -> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
>         process_one_work+0x245/0x560
>         worker_thread+0x55/0x3c0
>         kthread+0x140/0x160
>         ret_from_fork+0x1f/0x30
> 
> -> #0 ((wq_completion)loop0){+.+.}-{0:0}:
>         __lock_acquire+0x10ea/0x1d90
>         lock_acquire+0xb5/0x2b0
>         flush_workqueue+0x91/0x5e0
>         drain_workqueue+0xa0/0x110
>         destroy_workqueue+0x36/0x250
>         __loop_clr_fd+0x9a/0x660 [loop]
>         block_ioctl+0x3f/0x50
>         __x64_sys_ioctl+0x80/0xb0
>         do_syscall_64+0x38/0x90
>         entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> other info that might help us debug this:
> 
> Chain exists of:
>    (wq_completion)loop0 --> &disk->open_mutex --> &lo->lo_mutex
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(&lo->lo_mutex);
>                                 lock(&disk->open_mutex);
>                                 lock(&lo->lo_mutex);
>    lock((wq_completion)loop0);
> 
>   *** DEADLOCK ***
> 
> 1 lock held by losetup/11595:
>   #0: ffff973ac9812c68 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x660 [loop]
> 
> stack backtrace:
> CPU: 0 PID: 11595 Comm: losetup Not tainted 5.14.0-rc2+ #407
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
> Call Trace:
>   dump_stack_lvl+0x57/0x72
>   check_noncircular+0xcf/0xf0
>   ? stack_trace_save+0x3b/0x50
>   __lock_acquire+0x10ea/0x1d90
>   lock_acquire+0xb5/0x2b0
>   ? flush_workqueue+0x67/0x5e0
>   ? lockdep_init_map_type+0x47/0x220
>   flush_workqueue+0x91/0x5e0
>   ? flush_workqueue+0x67/0x5e0
>   ? verify_cpu+0xf0/0x100
>   drain_workqueue+0xa0/0x110
>   destroy_workqueue+0x36/0x250
>   __loop_clr_fd+0x9a/0x660 [loop]
>   ? blkdev_ioctl+0x8d/0x2a0
>   block_ioctl+0x3f/0x50
>   __x64_sys_ioctl+0x80/0xb0
>   do_syscall_64+0x38/0x90
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7fc21255d4cb
> 
> So instead save the bdev and do the put once we've dropped the sb
> writers lock in order to avoid the lockdep recursion.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/ioctl.c   | 17 ++++++++++++++---
>   fs/btrfs/volumes.c | 19 +++++++++++++++----
>   fs/btrfs/volumes.h |  3 ++-
>   3 files changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 0ba98e08a029..fabbfdfa56f5 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3205,6 +3205,8 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
>   	struct inode *inode = file_inode(file);
>   	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>   	struct btrfs_ioctl_vol_args_v2 *vol_args;
> +	struct block_device *bdev = NULL;
> +	fmode_t mode;
>   	int ret;
>   	bool cancel = false;
>   
> @@ -3237,9 +3239,11 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
>   	/* Exclusive operation is now claimed */
>   
>   	if (vol_args->flags & BTRFS_DEVICE_SPEC_BY_ID)
> -		ret = btrfs_rm_device(fs_info, NULL, vol_args->devid);
> +		ret = btrfs_rm_device(fs_info, NULL, vol_args->devid, &bdev,
> +				      &mode);
>   	else
> -		ret = btrfs_rm_device(fs_info, vol_args->name, 0);
> +		ret = btrfs_rm_device(fs_info, vol_args->name, 0, &bdev,
> +				      &mode);
>   
>   	btrfs_exclop_finish(fs_info);
>   
> @@ -3255,6 +3259,8 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
>   	kfree(vol_args);
>   err_drop:
>   	mnt_drop_write_file(file);
> +	if (bdev)
> +		blkdev_put(bdev, mode);
>   	return ret;
>   }
>   
> @@ -3263,6 +3269,8 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
>   	struct inode *inode = file_inode(file);
>   	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>   	struct btrfs_ioctl_vol_args *vol_args;
> +	struct block_device *bdev = NULL;
> +	fmode_t mode;
>   	int ret;
>   	bool cancel;
>   
> @@ -3284,7 +3292,8 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
>   	ret = exclop_start_or_cancel_reloc(fs_info, BTRFS_EXCLOP_DEV_REMOVE,
>   					   cancel);
>   	if (ret == 0) {
> -		ret = btrfs_rm_device(fs_info, vol_args->name, 0);
> +		ret = btrfs_rm_device(fs_info, vol_args->name, 0, &bdev,
> +				      &mode);
>   		if (!ret)
>   			btrfs_info(fs_info, "disk deleted %s", vol_args->name);
>   		btrfs_exclop_finish(fs_info);
> @@ -3294,6 +3303,8 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
>   out_drop_write:
>   	mnt_drop_write_file(file);
>   
> +	if (bdev)
> +		blkdev_put(bdev, mode);
>   	return ret;
>   }
>   
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 3ab6c78e6eb2..f622e93a6ff1 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2076,7 +2076,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
>   }
>   
>   int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
> -		    u64 devid)
> +		    u64 devid, struct block_device **bdev, fmode_t *mode)
>   {
>   	struct btrfs_device *device;
>   	struct btrfs_fs_devices *cur_devices;
> @@ -2186,15 +2186,26 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
>   	mutex_unlock(&fs_devices->device_list_mutex);
>   
>   	/*
> -	 * at this point, the device is zero sized and detached from
> +	 * At this point, the device is zero sized and detached from
>   	 * the devices list.  All that's left is to zero out the old
>   	 * supers and free the device.
> +	 *
> +	 * We cannot call btrfs_close_bdev() here because we're holding the sb
> +	 * write lock, and blkdev_put() will pull in the ->open_mutex on the
> +	 * block device and it's dependencies.  Instead just flush the device
> +	 * and let the caller do the final blkdev_put.
>   	 */
> -	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state))
> +	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
>   		btrfs_scratch_superblocks(fs_info, device->bdev,
>   					  device->name->str);
> +		if (device->bdev) {
> +			sync_blockdev(device->bdev);
> +			invalidate_bdev(device->bdev);
> +		}
> +	}
>   
> -	btrfs_close_bdev(device);
> +	*bdev = device->bdev;
> +	*mode = device->mode;
>   	synchronize_rcu();
>   	btrfs_free_device(device);
>   
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 70c749eee3ad..cc70e54cb901 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -472,7 +472,8 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
>   					const u8 *uuid);
>   void btrfs_free_device(struct btrfs_device *device);
>   int btrfs_rm_device(struct btrfs_fs_info *fs_info,
> -		    const char *device_path, u64 devid);
> +		    const char *device_path, u64 devid,
> +		    struct block_device **bdev, fmode_t *mode);
>   void __exit btrfs_cleanup_fs_uuids(void);
>   int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len);
>   int btrfs_grow_device(struct btrfs_trans_handle *trans,
> 


LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.
