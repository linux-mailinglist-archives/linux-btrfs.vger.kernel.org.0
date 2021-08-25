Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFB23F6CA6
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Aug 2021 02:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbhHYAgm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 20:36:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16770 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231552AbhHYAgl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 20:36:41 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17ONRGBc025089;
        Wed, 25 Aug 2021 00:35:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=li/5aZiU0IJwud/hUOJJiW/hoQ0KG+DovISZyPjW8iE=;
 b=FFnU82O0WElcOshb6bQZSSfFSa91q6bG/MzRi6Y+vsg4mdWVOcfyhLf6o74aqjlc+2hl
 5CM4oU/iMFbJMNyUauVaSZyU1yNj0ZJQjJWtk1y/nYduYzakrGdoHJaEQ8YilXgG5IbA
 mOvGPshrHo4+HdUoOKAXJFMOVnHUAYVf/1uCPn2eifu4LxuHoHQ827xOH5EORmkBlxDY
 9N08/OiWOYVxGF1ydqhtVeq1mo2k+iWBV3lF1WdmRiOyxvb+Yg2wNN8TjqYBoSt2c0O6
 5l77v931dzXqKh3cBr3mJ4WtwY6Nf0oH5dYsvpkycMKADsObYhYynDxbo7i0nEktEQDf ew== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=li/5aZiU0IJwud/hUOJJiW/hoQ0KG+DovISZyPjW8iE=;
 b=NPEL7ej2EJfBnlY94BkRsYTTplUsIrKZ0uU3+27LvR7OW5DHD8+ZoNqJrMhD2CC+7uzg
 6yRYo/1qSp/CQn5V7Ex56ubBI2gkbU/yukQ1cBAz4rn6qmtLxmApnund6pUgxFEZ9Eki
 D17DQ2bmLOUChEudRZgWj/rKP/uCdod2M7Ecm8m5oD3Gr3/jh+K8DJrYTkupdiuLyjSa
 vP5U2hxYsGot2BpArgtZYF2nbXb0n96H+8AozGgdmiNupIkhMg0G4oREPqmMz49KmVLw
 MfS0o57G4XOIK+ZGs4IIYt++tSYu/DM/p+eHcx1cJTywP8oFgXq4WdeNB0J2and0JzHo 3Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amu7vtj1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 00:35:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17P0ZZjI144582;
        Wed, 25 Aug 2021 00:35:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by userp3030.oracle.com with ESMTP id 3ajpky9vnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 00:35:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngB5x6hO2Cb4TspgtzkS0+3sdB4OxDXoK1movl/KkH7zzSLcJKiWu4j5S4ebflQtOGof2mLZJfdNdmpnnAiVnOGDtJNFLA7d0ZHjvAVDzhMk8RsXo6C+5CrouJCtoyUkg6L0fE4xpvvLfoujbbFuDgOyNA67ZdWohNWh2ITP7AOYsqFUDyYsdoTEvJ03Qir/OHL5Y6t6F/8LrG8JgTguHLE3KAklVZZzgIiVEU6V+Cw9tqdhe1S99jvo2SGO+mcmAWWkygww29/eZ4QepARaKq7vgsqDLKg4zMQ3ObFPxZnQrLBg45V/2lD2M2lwD2rPob0NIUQgQ363olI6qC3KyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=li/5aZiU0IJwud/hUOJJiW/hoQ0KG+DovISZyPjW8iE=;
 b=grFsCeQ4jm30Xr4X41WmGhx4ww/1RtFxnvAtLbqk6fTpbx9kqll6gGz/GJ7rWwQXQ9MNBZDRUCeo7dZRwkpxH//SNvCvQ6qesuUUUj9JTYLs23mWGKlpTcLy1ltI6dnaeNdAWlPdlNGxbxAHq4tcCS3Fn0wJ3xJzAF65fmFoaRoqLqLXUjz5SaNPBzZbvEwxgNOjtP63pcehzX4Rib5Y9XG48hDOPBWJsiHhuveqyNeVWdwfvBcNqU3S+tkUhHwtqxAH6+pwi3qXaQ4lUmUc85Bh3x6RDSauhXVtlD0Udx7CcYwyJv+3TvqiNNO/mZoJvm9vq5onfhauumS2tfpZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=li/5aZiU0IJwud/hUOJJiW/hoQ0KG+DovISZyPjW8iE=;
 b=U2kl31bii7g94ZVLLgP+XQKWRBNNN4UZI2iGT9EWy1EERRvwtZcN7FH5QoEtLfRzGPhXzJFcZvjJ9pnN3VvG8Ly1cyZnmLfPtdvrDxsgfGQZuFtOQI4f4eAF7cL+Cl//2LlhCNemrbSVk0VzjAnCIHkKCdPzREtD9OP0BRVMnsc=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5186.namprd10.prod.outlook.com (2603:10b6:208:321::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 00:35:49 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 00:35:49 +0000
Subject: Re: [PATCH v2 4/7] btrfs: update the bdev time directly when closing
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1627419595.git.josef@toxicpanda.com>
 <7a02499fac5a53031b333ce58d84089c8ce9e329.1627419595.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <b72b608c-4dec-3d46-3d35-816bcd87203f@oracle.com>
Date:   Wed, 25 Aug 2021 08:35:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <7a02499fac5a53031b333ce58d84089c8ce9e329.1627419595.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR0401CA0020.apcprd04.prod.outlook.com
 (2603:1096:3:1::30) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR0401CA0020.apcprd04.prod.outlook.com (2603:1096:3:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 00:35:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94b3e4f7-5a55-476d-c6e3-08d9676048ee
X-MS-TrafficTypeDiagnostic: BLAPR10MB5186:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5186EC97CE4D2A4F7CCC9F29E5C69@BLAPR10MB5186.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L0xSqMvisOrakkQojuEImnCrEZWvsPdDDzZ5SC1I/iHoflvVJlW1tt91s3KfPpF1ot67CtPmdIYStHRloq2/qve/xBLRxHPWKKXeMcB2e5kV5EQZZHAE01nRhpHO+NT9LCt6xwwC1FIRpCexkOj8l17I/MG4vqJzEvxFrTGG0+8Ha8uib4n5DILc1ogQgdw7nSJTl4AV+7AjfbMbHMtPW2pQY8iW8abD08r593Zt3DI2HQ5wHKa/PvoGX6Ui8QF6LwjilmnmiRXfo4c2NeQ6oz6z9EcdWu6hs7tumFLkmx5ELZO3z36KNG3FmiKQfuX2ZiUfRPi17qMcr4p+TTuQDq7+pNIGzRf0/VyJgAJ6m4e1lK0+2G0NefkIR2FtR6BxfNtlPYp0V44xAG8DiZsB4DiawT8Tt/2ZfjytgYOKXHDqJnEmtfsj/WmOZmx5MUPU51CftmRhKzlPCJs5cO+ZqTJuiYY+qaQbuNGx7oCPOFaYfDrIaP59wvRIPtA6L9DS44nOOlo3ruE/6Q2eZudJQHKpvAPxUqrgXrfPwvG2aOBD2T/05e0a7VbrjyVtRkMHaSdO4hBK+Jx9K51LvxJvECVuTbpCwTlsRwCEv+IPJoA9OsU/OuTR6F4T4eJoqIogEKPKXoaQa2CAljmQo2XX3xaryBKehXBrFn5jSa+CVqvIrLnAFoRmBcYkuNXIgt3XT8Is0CIYPitzawi5qPGCG67VvszWzl1GTqCuf507soI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(346002)(366004)(136003)(66556008)(186003)(53546011)(66946007)(31696002)(8936002)(66476007)(5660300002)(2906002)(38100700002)(8676002)(86362001)(31686004)(478600001)(6666004)(956004)(36756003)(2616005)(6486002)(316002)(26005)(44832011)(83380400001)(16576012)(15650500001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVMzdmNNa2xrQWV6YlJWbVJZalZEeGdwY1BZV3VMTUJLWWFpcSthKzJGakJr?=
 =?utf-8?B?cTY4MXlCTU96cUwzbjQ4NTRlY0szSFJsd0pNRUtGZlRkUStIZkhSZUpiOUpo?=
 =?utf-8?B?NitxTXYyeEQra2NwWDVVSU1FSmdKdTdYaFlNb00xMGdNaXY5QnBTeGhVYzlM?=
 =?utf-8?B?VE1WNStTOCtEczBhRmNXc3JmblNhZmQ4T3pLNisybWxXdnd6bVYyWDRaem1Y?=
 =?utf-8?B?YVBHOHgydTZ5a1J3SkFkbGkxVHdBcFZQd1VJYWppTUN0OEFZY0JvVy9qbEt0?=
 =?utf-8?B?cHRVUCtZR3NNOE91Y1IyYnNIUzQydUY0T3dtd1pMUWpEVGpibVh3OXpmQVJh?=
 =?utf-8?B?VXNUSFdoTThGTUZBNXljWTdrVkVKcElOWWNSaVdDSHlyWk5ES29VbUxRNXlF?=
 =?utf-8?B?ZjF3ZWNuWGtmUHFWdVJOQnlNYTFWYTVHZ0VvY2FzWFlBOUJSRit1NldaVCtF?=
 =?utf-8?B?dVJIVjNjS1JNK2I0a2FsenFyTkk4S09oQVpGZmNGNWtEVjE5NkR4ZG44RDNr?=
 =?utf-8?B?YW42UFRIK3o1MFN4MzBTZ0s5cWVJWjZNV01ONjBTdUU0UHNKLzZEcFc2TVYz?=
 =?utf-8?B?QzV0LzlwQ0NjeElBNVdYY3VsL2E4VEd5UU1BVDlRQnRJdnBueXBubjlKdEsz?=
 =?utf-8?B?dmV5RFdHbDNZNitoMVpPTVQwWFJoRDhVTnpycHE1VTZUNUZTd2FvV2xRS3Rl?=
 =?utf-8?B?NVluVkd3TjdPVTNZbmtQMjVXajZLV2thcUFNYlRObzg4aWI4WHVQRG5yeVVs?=
 =?utf-8?B?NVI1ak1aZDAveDVObGU0SG8vMCs1ejU3M3RveDBlWHZOb0lRWkxEdFdsZXlX?=
 =?utf-8?B?bUdPZnM0UUJHVmREZkhCWlh6NFhjUU12cDRTa0pFWWZ1bG4ybEQ3bUFKRWlk?=
 =?utf-8?B?SWdaNzJyaGpSR2o2M1Q5eEpFeDRISjVNRFJvdzZPS3hENEkvMTN5Q01Bd3pj?=
 =?utf-8?B?Zy9neWJ4OW4vU2NXS2xrUXcwMVJndGtOZDN5YmU4UGswK1QrK1o1d25lOVY1?=
 =?utf-8?B?WVZyeFkxWWFreCtGNWR3VWxBaCttN3QvZHdsYTJZRjZJWVk3Q2lOTjh5U3Nu?=
 =?utf-8?B?NVN3M3dkMDBhK1NOUW1kSllvekg5Y2VkVzh1WDZobG9HRGhvNitMS2RFRndV?=
 =?utf-8?B?THRkUCt1dXRreG11N3hLLzQ1UEY3STVKMXFYbEY0dzFpYklOSEhKQWRVUFdL?=
 =?utf-8?B?cHNuTnMrQkdKT2NuUmFLdFN1MkV2ZFNlbTNFTFUycUJCOW9oZmxVaU5SdE9Q?=
 =?utf-8?B?TWxBYnlZR0xkd0RZL2lzemRIeDdGdU4wRThtbkg2VlNzN3hhM0R0WU9aUmVH?=
 =?utf-8?B?Y2JURWpGR0VRMGRSc1Y2dzNHcnBwYVcvNVR4bVdGdFRRRVlEQnNBOXFWdUR4?=
 =?utf-8?B?WnJGSmtEWXpMVzBGVjNoejBCK2tjK1pSZERXcEFVUk9raVdFRkF4Z1RiNk1K?=
 =?utf-8?B?cGpRYmsxYldSVWlUSHk4cnY2dXNwNTdPMDVnVit3ZFduamtjeXk1YSs2eXdv?=
 =?utf-8?B?ZzljNU9IdExJOU5MRkptUU1rdGRzcTFBSytKMDNWNnlJaXBZcHZmZmJ3Z2h4?=
 =?utf-8?B?ZXF1QzdUZHpUMkoyRHA2OVFSeXEzVDRQVWpjbWxiaVFJQnZaemhzZUd6enM1?=
 =?utf-8?B?LzI2RE9tQU5LTFNpamdKbUgydXMvdkcvL2x1Si8wRVIvcEZUSjIzdzMxbVRr?=
 =?utf-8?B?SnpKdmtGd1UyM25OOXV3cGszc1NQNGwvWUQ1emc5a3pGN0hUbGM4eHhqZ0Jn?=
 =?utf-8?Q?tCPlIJXuyBx8OneUsBWymgwDQgZ6hbAheNdVDSV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b3e4f7-5a55-476d-c6e3-08d9676048ee
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 00:35:49.2653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdA+NEcS3YhOpQGkoPLxe77F7J9WtfYWjbkCdMkPf2rL4tqaOL5GNEa5LcpCDGkiLcmmSHLyWO5vs/jx7CA3FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5186
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108250001
X-Proofpoint-GUID: 5i5eUwJPFc4EQ_L7Q1uHN6rzVWvMar1d
X-Proofpoint-ORIG-GUID: 5i5eUwJPFc4EQ_L7Q1uHN6rzVWvMar1d
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/07/2021 05:01, Josef Bacik wrote:
> We update the ctime/mtime of a block device when we remove it so that
> blkid knows the device changed.  However we do this by re-opening the
> block device and calling filp_update_time.  This is more correct because
> it'll call the inode->i_op->update_time if it exists, but the block dev
> inodes do not do this.  Instead call generic_update_time() on the
> bd_inode in order to avoid the blkdev_open path and get rid of the
> following lockdep splat
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.14.0-rc2+ #406 Not tainted
> ------------------------------------------------------
> losetup/11596 is trying to acquire lock:
> ffff939640d2f538 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+0x67/0x5e0
> 
> but task is already holding lock:
> ffff939655510c68 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x660 [loop]
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
>         blkdev_get_by_dev.part.0+0x56/0x3c0
>         blkdev_open+0xd2/0xe0
>         do_dentry_open+0x161/0x390
>         path_openat+0x3cc/0xa20
>         do_filp_open+0x96/0x120
>         file_open_name+0xc7/0x170
>         filp_open+0x2c/0x50
>         btrfs_scratch_superblocks.part.0+0x10f/0x170
>         btrfs_rm_device.cold+0xe8/0xed
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
> 1 lock held by losetup/11596:
>   #0: ffff939655510c68 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x660 [loop]
> 
> stack backtrace:
> CPU: 1 PID: 11596 Comm: losetup Not tainted 5.14.0-rc2+ #406
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
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/volumes.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index bf2449cdb2ab..3ab6c78e6eb2 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1882,15 +1882,17 @@ static int btrfs_add_dev_item(struct btrfs_trans_handle *trans,
>    * Function to update ctime/mtime for a given device path.
>    * Mainly used for ctime/mtime based probe like libblkid.
>    */
> -static void update_dev_time(const char *path_name)
> +static void update_dev_time(struct block_device *bdev)
>   {
> -	struct file *filp;
> +	struct inode *inode = bdev->bd_inode;
> +	struct timespec64 now;
>   
> -	filp = filp_open(path_name, O_RDWR, 0);
> -	if (IS_ERR(filp))
> +	/* Shouldn't happen but just in case. */
> +	if (!inode)
>   		return;
> -	file_update_time(filp);
> -	filp_close(filp, NULL);
> +
> +	now = current_time(inode);
> +	generic_update_time(inode, &now, S_MTIME|S_CTIME);


  Oh. We could use that.

>   }
>   
>   static int btrfs_rm_dev_item(struct btrfs_device *device)
> @@ -2070,7 +2072,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
>   	btrfs_kobject_uevent(bdev, KOBJ_CHANGE);
>   
>   	/* Update ctime/mtime for device path for libblkid */
> -	update_dev_time(device_path);
> +	update_dev_time(bdev);
>   }
>   
>   int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
> @@ -2711,7 +2713,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   	btrfs_forget_devices(device_path);
>   
>   	/* Update ctime/mtime for blkid or udev */
> -	update_dev_time(device_path);
> +	update_dev_time(bdev);
>   
>   	return ret;
>   
> 

  Reviewed-by: Anand Jain <anand.jain@oracle.com>

