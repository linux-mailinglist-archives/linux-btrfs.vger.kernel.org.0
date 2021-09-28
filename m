Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C38C41A9E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Sep 2021 09:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbhI1HkG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 03:40:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20856 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239254AbhI1HkG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 03:40:06 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18S6wMnV003183;
        Tue, 28 Sep 2021 07:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HJQkzgI8W2ebojc/uut2eFS4dLH5yM7s3WOPyxK0gxE=;
 b=q3MXaBiZSHZsAcqDx88hDTfv81xohSpyXcf558+5xB+dVA9Lh3RgdP2CBB8sXwmZYkmX
 uL6poBsv714UbhgWjUM/E5lyOXuG5Xd1K89co/Eu/LqqwJP3meKabGfVymtTMWfVpiVc
 z7Nc04O/v+X2Or9hDjTZM6qcAIOeyK50H5YbNaHBhBRrVAzv5auN8aP6iXnnYXjGYvAY
 sbR2kY2ZZcooOjhSNe2y7vMbp7nWjMm8rKDAMp0aR4IwLtZ+GTOHql0RHj/0KmpVxC6h
 tWLOMbO4beo0tm07qiZpmwtyA0C9h5+r1e/l6Wrd/P6lXAf+IOPP3sF9+HhY3cn3UdcY GA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bbejef10v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 07:38:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18S7aO9o080606;
        Tue, 28 Sep 2021 07:38:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by userp3020.oracle.com with ESMTP id 3badhs9g48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 07:38:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fah0fImtTpTvJxwRp8ERxwFKj7c98tIV/dHnYgX84Td+NZpm3EBas6GJOfkORmF6dGooTJly4n4gChvGjnpuuUrRkK6hXcLyEo12xSZdvtB1XcvP3rAjJt6kt1q2F5OyiDOVSsMPT3KNs3+K4EKqypLC3rnAoW6w7Pocy5LUZyXna77eGYgU0/ryKKi6b3+xhEHYNOWnffrLErpvE8OUsDNmh5ccNRqn837HM94Q//9hNmHJqYDd1ggDuC86ofoBOWHn6bE57b8FvXv/5poJf7AebRyvwWUqUEjAraccOp6ojeaUl96BAlKiWFjpnP7z8lVxwxp0sDMI8l0qa1AUqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HJQkzgI8W2ebojc/uut2eFS4dLH5yM7s3WOPyxK0gxE=;
 b=QGsklI2BCEPBkzHh1XPK8VK559HDgieNfAZQ/oOFjS3RsJ+pq2fMBVnWTEbMrGTVZ0vMb99/TMBm1Qagvx9XzWTK8jJDpaj0GtMFTLnPSyf67qHkZxmjLTnARuN1s9h0E+4bJstkWNmHEnii9uuOGsB251QiuybWAZGwH0lObJ7ShPhjkKeT8mMQUA6lyG1tfe9W/DHqTIdT/ScKT/qWao8zNtDHDT2fP7IaHkmrPrfqigpJLB14f4lSUuGYFxH/+VK3WXVSHNVgVVkvLzMJec79QlWcafyWZ2C8Dsq83kyjqPOA/ai3Sfxn8jwVdXYMrq0UVXFh9OkqvN+WkcC+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJQkzgI8W2ebojc/uut2eFS4dLH5yM7s3WOPyxK0gxE=;
 b=j5IeZMjFw5IGWoQTkCxrHtSSS446mfugH3mwEMbB3zN7wYb/36kXvzm+L00wKYyKELaVG/ghEx+RY7qBpYIFukvdsvdaEgMQj15b2xT9CHdxsGWEmKPK4IijwjYH5TN6E1AWooB+8GBq1004iyNM2WlqIPY+irZk2LepLzSWt8k=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Tue, 28 Sep
 2021 07:38:20 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 07:38:18 +0000
Subject: Re: [PATCH v3 3/5] btrfs: add a BTRFS_FS_ERROR helper
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1632765815.git.josef@toxicpanda.com>
 <4790be90bba87904294617bec93c5dfe586bbd58.1632765815.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <71976bb8-748c-d82f-1fb5-df30493ced6f@oracle.com>
Date:   Tue, 28 Sep 2021 15:38:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <4790be90bba87904294617bec93c5dfe586bbd58.1632765815.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:3:17::33) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR02CA0021.apcprd02.prod.outlook.com (2603:1096:3:17::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 07:38:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79680bac-87e7-45e7-c017-08d98252f05a
X-MS-TrafficTypeDiagnostic: MN2PR10MB4128:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4128426C529D7114AD2846E8E5A89@MN2PR10MB4128.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gOZ24+d/7s0E6nq2QL7E5DY/GCcx3zo1Af42RsZqo64ed2AdEFBrDdPQtuHkwql0TTsMoR6GvN7m5bFTHp6cyl4pw+wzUvVBbFPLzrTvCMpVuFmh3WwXDkZ4oT7Qlo9BsozQQ4VpiZg9oSF7Dpv1IbbCh9FnAc/uHp2bxzzPqyOVa8HdZIyE3d2ye8SEHJOwFS800WX2TlJ9StApBUzp8h01PNZDaSeI//XusLb0odxHH8CDfghnLUbEcWoeihpj0Uw5nAY5o1e9qpf5Hm+Zcfllo/ypSms1MseeIchjahfZuvw32Nu9Qx9jWlLEqYR7ndSoQdLXPLL29T/vmoN71uTgcYxV6GgQHO4Q1LW2FX88Hbgt1Zpi8urgydmN72TbYj+6UpXdHuHSl5njFU3YEG4mvbCYZsbEVvE6b6rbUrNFF8uvTlBp2GXc0T3F5noneWX29jbXm2MjDL+nG1L6sWZ/yrXfLn6pWQgx9+EnTp4TfHbhNyBefG+lFGKM2ToI0c8ZmY36qKtXuYYXJ8q5YhVUKH17/vWhb4cLwivEWL1W9En0SUQz4gVxO4ju3QNHgXejKsyLqcCf+O6l+oTLbu5jH9LOOWqsJpvh+qCaVa0mmAnZByc18VCV3emSH3uI9WwLoxFkm0m/ADYGR8t34I9vSBRXkv6KMhzwtru/du/US27QlA/THg+B34013VSbfxCf113MZlpALhaXztrA2e+ForTkQ3237F6qGgZFNQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(31696002)(186003)(2906002)(86362001)(6486002)(6666004)(38100700002)(8936002)(53546011)(26005)(2616005)(36756003)(956004)(31686004)(508600001)(5660300002)(66556008)(66476007)(66946007)(44832011)(16576012)(83380400001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXF3SXhmT0V6SjQydjcySzNzRSs4M0YxSDFVWDJ0Nk5Sb3l3akhTVVgzbzJ2?=
 =?utf-8?B?YnZEd0FrQSttZE1CMXFkVDRMSCtBRXoreDJQcWNaN3N0aGF5WFNiYjFsWWVw?=
 =?utf-8?B?OW9ka0ZtSHVZTkdqOHZLc3FHdHVwd0FjNk5MSlRvbnVqTDgzMW5VOVNnWUZw?=
 =?utf-8?B?UVBCU3U5dWRkRW9RVFNldWdxTGg3WWtFMkZmaS9YTnNQVjdnNkhWZTZSQmY1?=
 =?utf-8?B?U3ZBOGhpam5nZVh6NHZXVk43OGQ2Rk5KMEN3NnQ4azhWSmpHUno0VldTVHBl?=
 =?utf-8?B?NU9oMzJBbXBuTmpVOGZXMGFnZkprM2txNlM0eXFXeUJtTlNtQnlwNFA1Z3B1?=
 =?utf-8?B?T2xTc203c0RjRlVEWVFoZHpQbFV5TDJ4UVZRRDM1YUYycE5mUEZxcUpDM1RX?=
 =?utf-8?B?RTdMRkhZZmpORXFraE9lN0hZWXh1K2J5eEVDOU5FYlUrUE5sRDdvUm5oNkZV?=
 =?utf-8?B?OFBtbitXc1RjWjN2OVpnc3I5NXdtSW9IRGkwdHRVQ1NkY1BQd0lncmRYRnhT?=
 =?utf-8?B?b293NTh2QVIyWExrNlVSTzlUQXNVQVNrSWV5NnRBKzYxUVBCNU5hRTZlUG1o?=
 =?utf-8?B?ODdqcUhtSjE1VjlHTkR5U0Y4WFpKTXFMaFJndS9ac3I0T1cyYVdPcHkrQzBj?=
 =?utf-8?B?U2FnTUNhdkpFek15dFR0c3hWOGIzQ3JsVjRTaWZQeUpNY0tpTCt5QnJLQ0Qy?=
 =?utf-8?B?SkQrRzQ3aEx6akJJcTJDRHdJT2VPd0s0Y2p1TlB5ZDBTdEFoQ2YrVVhRUnJ6?=
 =?utf-8?B?YUZHOFRnU2pUbnI0cFRTMjZXN3ZtUXZ6S080VXdnZ2NTUDRvUTJsRE5lOVFq?=
 =?utf-8?B?MnNnaUhTOHAzcWU4S3ErZFpBT0J3by9CMVBpYXVGQU94UDRqQTlxd0RHcktF?=
 =?utf-8?B?Z0hlR3dja0FEOUMzTDFZYzNsLzh2cTBqOGNXMHhQQm53MTZ3Y290RlpWSmE3?=
 =?utf-8?B?VWtNd1BLU2gyNnoybytpMDdtMXczV2RDMmlRb2E3K3JkVzd1VUtMYjI4eFdZ?=
 =?utf-8?B?ZjNEYXpYejdEN1dnaDloZjJFUzgyeXN2anFqZml2elNVa21ObERvMWFGWFgz?=
 =?utf-8?B?UElCMElIT1JLWWo3aWxHMHByMWtzQ2ZNOXNnVWltK1BWY2gvKzFXbm8wa0hr?=
 =?utf-8?B?WE5zVjAxZktEMjk1MUpPZllGQllyMnVkZGVYeWkzZXY4K25YamdETWJzV2M4?=
 =?utf-8?B?S3g1L2lOKzR6Vzh3eXJkK3NRejhHeitkTWk4YWVPV1VDQzdSRVQ5U29wcDlO?=
 =?utf-8?B?WTJ6K0tJSVlmM3h0K05kSmtiWXRxSUoxMkVIbHVyWlRkR1N5L0VFd0NPcDg5?=
 =?utf-8?B?eGgvL0RUMGU3NVpFdTZPTGtZSGFXYnE1RmlOMWNKZ2ZHYU9lU1E4T1VZeUh0?=
 =?utf-8?B?L2xyYkllWWZYcVFvTFh5WGFWeVVBelJXWjNMQmxxWmo5bXpNR2ZPbHJQNXQx?=
 =?utf-8?B?YWJsRGMvQld2THNjTGdCV0xvY3NES1JpaDFLY2o1cXZRNnhrQ1ZoYmFRbjI0?=
 =?utf-8?B?WDFYdzFSdFB2N2t3NTJtcVNlYkFMNzRFMkZPRFdrMGY0ZEsyVzJ1aU9iQ0x5?=
 =?utf-8?B?UmhBR1VMSEY3bHNwZ1czdWxGczhPUlU5MVdlTk9EZ3VidXlFeHY5VXVVVjBl?=
 =?utf-8?B?bmQrbWhpYWZwenZDNGJOZGR4MXpUTURMYUJ2Ukx5QnJCYUJtWlAreFJwRFp5?=
 =?utf-8?B?YlQwZmVKS1I5b2R3aWhveFVsOEZObTN1V2dpeDhzOTV3UnJMR29OS1V4TGhH?=
 =?utf-8?Q?A2Q4WtEYmY+eV6c548JZoHuP6JpUjgggr8UBwqs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79680bac-87e7-45e7-c017-08d98252f05a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 07:38:18.2448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /OFMO+z+3HMdK7yzPj/N4Zgbw8mLwmMc8sjndAL1cxb9wEpTM1Iq7jNnPWEMWeiSieUwu3KwpZAEzfGkJz0cRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4128
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10120 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109280043
X-Proofpoint-GUID: 0WE6RjsqF9HrNeHzo12hYfMhKLHgIBl0
X-Proofpoint-ORIG-GUID: 0WE6RjsqF9HrNeHzo12hYfMhKLHgIBl0
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/09/2021 02:05, Josef Bacik wrote:
> We have a few flags that are inconsistently used to describe the fs in
> different states of failure.  As of
> 
> 	btrfs: always abort the transaction if we abort a trans handle
> 

> we will always set BTRFS_FS_STATE_ERROR if we abort, so we don't have to
> check both ABORTED and ERROR to see if things have gone wrong.

>  Add a
> helper to check BTRFS_FS_STATE_HELPER and then convert all checkers of
         Nit:                ERROR  ^^^

> FS_STATE_ERROR to use the helper.


> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

LGTM. So additionally, this patch will add compiler optimize unlikely()
at most of the places which are good IMO.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> ---
>   fs/btrfs/ctree.h       |  3 +++
>   fs/btrfs/disk-io.c     |  8 +++-----
>   fs/btrfs/extent_io.c   |  2 +-
>   fs/btrfs/file.c        |  2 +-
>   fs/btrfs/inode.c       |  6 +++---
>   fs/btrfs/scrub.c       |  2 +-
>   fs/btrfs/super.c       |  2 +-
>   fs/btrfs/transaction.c | 11 +++++------
>   fs/btrfs/tree-log.c    |  2 +-
>   9 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 522ded06fd85..53f15decb523 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3576,6 +3576,9 @@ do {								\
>   			  (errno), fmt, ##args);		\
>   } while (0)
>   
> +#define BTRFS_FS_ERROR(fs_info)	(unlikely(test_bit(BTRFS_FS_STATE_ERROR, \
> +						   &(fs_info)->fs_state)))
> +
>   __printf(5, 6)
>   __cold
>   void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 37637539c5ab..1ae30b29f2b5 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1954,8 +1954,7 @@ static int transaction_kthread(void *arg)
>   		wake_up_process(fs_info->cleaner_kthread);
>   		mutex_unlock(&fs_info->transaction_kthread_mutex);
>   
> -		if (unlikely(test_bit(BTRFS_FS_STATE_ERROR,
> -				      &fs_info->fs_state)))
> +		if (BTRFS_FS_ERROR(fs_info))
>   			btrfs_cleanup_transaction(fs_info);
>   		if (!kthread_should_stop() &&
>   				(!btrfs_transaction_blocked(fs_info) ||
> @@ -4232,7 +4231,7 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
>   		drop_ref = true;
>   	spin_unlock(&fs_info->fs_roots_radix_lock);
>   
> -	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
> +	if (BTRFS_FS_ERROR(fs_info)) {
>   		ASSERT(root->log_root == NULL);
>   		if (root->reloc_root) {
>   			btrfs_put_root(root->reloc_root);
> @@ -4383,8 +4382,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
>   			btrfs_err(fs_info, "commit super ret %d", ret);
>   	}
>   
> -	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state) ||
> -	    test_bit(BTRFS_FS_STATE_TRANS_ABORTED, &fs_info->fs_state))
> +	if (BTRFS_FS_ERROR(fs_info))
>   		btrfs_error_commit_super(fs_info);
>   
>   	kthread_stop(fs_info->transaction_kthread);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index c56973f7daae..f6f004d673a0 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4876,7 +4876,7 @@ int btree_write_cache_pages(struct address_space *mapping,
>   	 *   extent io tree. Thus we don't want to submit such wild eb
>   	 *   if the fs already has error.
>   	 */
> -	if (!test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
> +	if (!BTRFS_FS_ERROR(fs_info)) {
>   		ret = flush_write_bio(&epd);
>   	} else {
>   		ret = -EROFS;
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 7ff577005d0f..fdceab28587e 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2013,7 +2013,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
>   	 * have opened a file as writable, we have to stop this write operation
>   	 * to ensure consistency.
>   	 */
> -	if (test_bit(BTRFS_FS_STATE_ERROR, &inode->root->fs_info->fs_state))
> +	if (BTRFS_FS_ERROR(inode->root->fs_info))
>   		return -EROFS;
>   
>   	if (!(iocb->ki_flags & IOCB_DIRECT) &&
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 03a843b9659b..26d155e72152 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4368,7 +4368,7 @@ static void btrfs_prune_dentries(struct btrfs_root *root)
>   	struct inode *inode;
>   	u64 objectid = 0;
>   
> -	if (!test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
> +	if (!BTRFS_FS_ERROR(fs_info))
>   		WARN_ON(btrfs_root_refs(&root->root_item) != 0);
>   
>   	spin_lock(&root->inode_lock);
> @@ -9981,7 +9981,7 @@ int btrfs_start_delalloc_snapshot(struct btrfs_root *root, bool in_reclaim_conte
>   	};
>   	struct btrfs_fs_info *fs_info = root->fs_info;
>   
> -	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
> +	if (BTRFS_FS_ERROR(fs_info))
>   		return -EROFS;
>   
>   	return start_delalloc_inodes(root, &wbc, true, in_reclaim_context);
> @@ -10000,7 +10000,7 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
>   	struct list_head splice;
>   	int ret;
>   
> -	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
> +	if (BTRFS_FS_ERROR(fs_info))
>   		return -EROFS;
>   
>   	INIT_LIST_HEAD(&splice);
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index bd3cd7427391..b1c26a90243b 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -3955,7 +3955,7 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>   	int	ret;
>   	struct btrfs_fs_info *fs_info = sctx->fs_info;
>   
> -	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
> +	if (BTRFS_FS_ERROR(fs_info))
>   		return -EROFS;
>   
>   	/* Seed devices of a new filesystem has their own generation. */
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 7f91d62c2225..a1c54a2c787c 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2006,7 +2006,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>   		if (ret)
>   			goto restore;
>   	} else {
> -		if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
> +		if (BTRFS_FS_ERROR(fs_info)) {
>   			btrfs_err(fs_info,
>   				"Remounting read-write after error is not allowed");
>   			ret = -EINVAL;
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 14b9fdc8aaa9..1c3a1189c0bd 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -283,7 +283,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
>   	spin_lock(&fs_info->trans_lock);
>   loop:
>   	/* The file system has been taken offline. No new transactions. */
> -	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
> +	if (BTRFS_FS_ERROR(fs_info)) {
>   		spin_unlock(&fs_info->trans_lock);
>   		return -EROFS;
>   	}
> @@ -331,7 +331,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
>   		 */
>   		kfree(cur_trans);
>   		goto loop;
> -	} else if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
> +	} else if (BTRFS_FS_ERROR(fs_info)) {
>   		spin_unlock(&fs_info->trans_lock);
>   		kfree(cur_trans);
>   		return -EROFS;
> @@ -579,7 +579,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
>   	bool do_chunk_alloc = false;
>   	int ret;
>   
> -	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
> +	if (BTRFS_FS_ERROR(fs_info))
>   		return ERR_PTR(-EROFS);
>   
>   	if (current->journal_info) {
> @@ -991,8 +991,7 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
>   	if (throttle)
>   		btrfs_run_delayed_iputs(info);
>   
> -	if (TRANS_ABORTED(trans) ||
> -	    test_bit(BTRFS_FS_STATE_ERROR, &info->fs_state)) {
> +	if (TRANS_ABORTED(trans) || BTRFS_FS_ERROR(info)) {
>   		wake_up_process(info->transaction_kthread);
>   		if (TRANS_ABORTED(trans))
>   			err = trans->aborted;
> @@ -2155,7 +2154,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   		 * abort to prevent writing a new superblock that reflects a
>   		 * corrupt state (pointing to trees with unwritten nodes/leafs).
>   		 */
> -		if (test_bit(BTRFS_FS_STATE_TRANS_ABORTED, &fs_info->fs_state)) {
> +		if (BTRFS_FS_ERROR(fs_info)) {
>   			ret = -EROFS;
>   			goto cleanup_transaction;
>   		}
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 720723611875..9e5937685896 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -3335,7 +3335,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
>   	 * writing the super here would result in transid mismatches.  If there
>   	 * is an error here just bail.
>   	 */
> -	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
> +	if (BTRFS_FS_ERROR(fs_info)) {
>   		ret = -EIO;
>   		btrfs_set_log_full_commit(trans);
>   		btrfs_abort_transaction(trans, ret);
> 

