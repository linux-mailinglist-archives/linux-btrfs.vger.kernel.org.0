Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE863D8313
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 00:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhG0Wfi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 18:35:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12656 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232198AbhG0Wfh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 18:35:37 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16RMHgWj025862;
        Tue, 27 Jul 2021 22:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=grGNbbnJeG+rI/qwNbrf1/qvIzhdHA2ChZF6yEioRXs=;
 b=lXDwVEk7qEie+FmXguKKIpItHpbH1yUCwI/udwBPGoWH5iJ0yCrJrdPuOxEZDsAVco+X
 Stgz4ygdDYcvyP3T7MqdGgT9qm+E0RkBBSj9fO1QAyre62nj8GJG15v6eQhuR591AEZK
 Wt8hrlxarTJMq9elZXVSBrOLNapWX0PGQRN2LeMuL/YBNWfQ91KThxvxTa22iQexIBUr
 sBqi/Gcb3uvdYIHQZhLE0zJtKg8RFRvLhqXs7U3i9v/LlMfoVB/ob6JF0Zlvle5Z0BaA
 AIZAK0v+ZUZkzLAu7C9YGttEqX/nFR9nZIkkPgtdTbrjF3cQbvnLG16LF9a96Yyy+SAa uQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=grGNbbnJeG+rI/qwNbrf1/qvIzhdHA2ChZF6yEioRXs=;
 b=mTo99hhslnntN13LDIBjicI6aGwf2m3+RGu7+7YKBOT7DQQzIm7CGed2HI8efnX4577u
 NnUijcen72pgFq+5fB0C8144GA6TJ6D+ap1jzb2UxjXtW7dyo7vguqla8+u2sylV3en2
 fZqC6Ys2RK11BQfKkUYPaUJsYCu67C9+1UZ+t50HzOlpUx24zQGWJ50N3JGqyKHkBnay
 km3YKb1+AJ0632xaWb2oiBEQBxILvrczRDrT9dWJgp17RctCRbrtsXRTidaP04jZCfAB
 /5+BAUvNIOQUvn34LxP2exYF6SwoTaLEo4h7ptIm2k+1PN9eJRK5xqpyMQ2icGCywa7Q rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a234w333c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 22:35:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16RMYkfc068988;
        Tue, 27 Jul 2021 22:35:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by userp3020.oracle.com with ESMTP id 3a234wcgm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 22:35:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlFfrfx395XOJgWAL/F+2B8gLkI9Eu30LlCc2RilWaKxs+1Exe2RhLpzDdfc/hXPk3FvehhbSTSpsfef6KZo8gdgEufz2/+pgV/VSUgIhHQOKeh6MOJAXtHTiAkCl3rmjx6GRFKxf+Co29ndnNL+d4lnSUR9U6ktWu8ARa1kd+V4Z6Xw/a6LEr3bBVYXOgHXT4ToZ/dIt2N6OSjDb3fQulCYEQpD0gxq0i01g+rS607M33yboyd5d5Vs9p2gFk5JhKoOqkREvdox+pro6vvL5pb22CiyQsP214VI+1EdGk0hGgrgMdLn/uzyvV4Ea1GZK5VhFSH2VtL9VSimH3qF5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grGNbbnJeG+rI/qwNbrf1/qvIzhdHA2ChZF6yEioRXs=;
 b=AUpgAqE49ntN2lWwFE6/vLwP3MYRy1/xu2Higr76H674JznUz5EadUCoF3VnoezYCGgxwPQIVFAex8pHPYucIjbNVUCZvxLsuHW3kJdQrIrfhdICizV0zkx7fplILEkd6gM51agwQHDE0eRGEouUNAomT2/vb2enIOe+1fXEo1nwp19arsnIes9NAfWwt5007A8tGmIpqh8bdMpu1Gg1OA1HTp3jcZyM6muEZE8E8zRAEh60KAtLgSwrRGqIUbdY/2qikAz+hEVAhbaCsGksrgX9kUeOfJQbMhAwoPssI+uuiih5Xy8cIYz8jNs/xl5LTE4p7H2gO2TJqojB67cFiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grGNbbnJeG+rI/qwNbrf1/qvIzhdHA2ChZF6yEioRXs=;
 b=XSw0lnBOBLaBDIECDxaXp451vCgyDTFOEz6Gcvsr7/nMg0NV9acxs9YVYzBFgaUTraI4b6qpmlXW/4BEjKjIoP8VU96/nwmb0rzocfE84hkGxQq+dG1vsRgXCymUD6h7JeX+a/qkGqhZg2dcbWUYNVjzXxf6AFXZWPI8OWQOrsg=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4351.namprd10.prod.outlook.com (2603:10b6:208:1d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 27 Jul
 2021 22:35:32 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4373.018; Tue, 27 Jul 2021
 22:35:32 +0000
Subject: Re: [PATCH 1/6] btrfs: do not check for ->num_devices == 0 in
 rm_device
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1627414703.git.josef@toxicpanda.com>
 <00156ba3c68ac186cf4895fd9e62b50a504c550f.1627414703.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <8bb67a56-b79d-abb5-2a4e-597d38a373ab@oracle.com>
Date:   Wed, 28 Jul 2021 06:35:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <00156ba3c68ac186cf4895fd9e62b50a504c550f.1627414703.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0044.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::13)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2P153CA0044.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.1 via Frontend Transport; Tue, 27 Jul 2021 22:35:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b1c999d-1c76-44ba-c372-08d9514ed7e9
X-MS-TrafficTypeDiagnostic: MN2PR10MB4351:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4351C7F04FF7F62A4BF0ACF2E5E99@MN2PR10MB4351.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGA4ZxWqiTfkKVYb7vKzwHDsw4GU/9udxzHWNUwa9axF7EbyDaZTI+CekHIyaRHlcT5LmRUDhIxFbFVa+qGlTJIQbG/FVUDYtfO6n59OES7gvnPJzFGemvAPsknZl5HRRzSiepq16KImXJIy5cUbkHUTXUFBeD8Qe0T4/LSA/djbT2uf3jr3muYwj/1QSVHVm8zxlzKV8Bqdz53sew9epz9l4hbX0ojf8Tj+2DxMuYpsNXEVfXkVCXezyS7rZrU4L6cc0ZaNn4VvEJTL13nmwrJH31sUp7UfFnxILjWLLhlxgNW1dll9FMuDiVMgD/arf+kgiXNkPXtKRJIZWZT1KZR4cSQRPV2L8hs7kiNcgfI4uSi0VUwrczaB1SFlwOFYY1RQCY0jL34/v0Eo6TuxAVqiTY5BX8bq7F8cDOfVQFxDn3Ca4rpeVH18aQiILEUXYAhEeKtkNf23omxNds+wA88IzAQRpKB0WsfdhLjUfHTHwqEK/298DMvxXiXdXJglBcjvzlqj0QN7fyBMcx0RJ1UWOwZn5LzCd0M42IENWghZOjyPRM70JqeYRNSA/lLBlBZXLbQpdqOaep43r5wyj7m7uMDbeJt4Xd4STh63HCiInxvc6U6V5KjNaHH5rudGdkpGGH0QfDID/STQ5U4Kgk3IbdbTBlhL4drV1PlxRBiH0i7e8tuGhDKj8XOwNvVNF5aBOVPvXs2w38d3pR/OWgJxXeBB0WnrhQEAYgWcN64=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(6666004)(31686004)(66476007)(86362001)(31696002)(53546011)(8936002)(316002)(26005)(66946007)(36756003)(16576012)(2906002)(83380400001)(44832011)(5660300002)(38100700002)(508600001)(186003)(2616005)(956004)(6486002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WC9xV01ObGFUa0ZjRGJjSWN1NSsxRXVJVWRrZXE5dXV2RzNaZnc1N2VMRmZU?=
 =?utf-8?B?Rm5uMG5NcWpoa3o5VTJBTTExZjdhVGpBaHVHVXRrR0oxRXRMYnhUSnZOYTlo?=
 =?utf-8?B?RnZNV0ZtQVRhNEQ3Mk82eWRzbkplbjdtV0ZQY2tIZnpiR1lCK3RySlhWTmdG?=
 =?utf-8?B?SDNHdHhFd0lGbjhwZWJUaG9mR1lmWGZkdkhyb0h5NXo5SncyZFpkajh5Q21z?=
 =?utf-8?B?cEt3OGdlNjh4T2FKeHA1a2ZXVkFCT1lzS2Z6d3BvZzBEZCt0WkEvVm1UOHBy?=
 =?utf-8?B?MjV1Wk92dGtUR1dlVzNlMnEvVitkUWZpSUlMNVlKS3RzQjlZK3I1N0pTVkw0?=
 =?utf-8?B?aE1yY05PWTZOZFM5dUZDcnZ5RHpuN2FFQ092R0grRjFEWXRYeFJQNHhZYUJ6?=
 =?utf-8?B?U0NCQWN0RDg0NUJaSURQY2xLNVFMN3huTW4rdndidUVwem15d3pMVFU0QXVI?=
 =?utf-8?B?RitzK0tzaXJ1NEkwOXhKV0ZOTDlKVHJzbmdnNVpicFVEUk02SHd4ZWd2aWJq?=
 =?utf-8?B?cTN3N2F4NFFOL1VkZ0o2N3AvWjdCMnE1bTZpZjZqc0cvN2lkZlo2KzBHa2hw?=
 =?utf-8?B?RlUva3A3Q0dNR1kwbW9kcy9QN0JIVDNlbVc3VVlTTDY3QzY4QU1sRU52bHho?=
 =?utf-8?B?RmZWMUI5Ykt5NGxKWjg1ZG1UZ1pBUE0vcWRZVWxGZkhTc1V5YjJSVnBibHNN?=
 =?utf-8?B?UlZVQTJjRW1ud2NKaGNvRnFHNVlOMTY2VEJpZ0NJSEZYQjBicVBYSFhlU244?=
 =?utf-8?B?Ukw5L0FKcjZMczBmVUF6SHh6Q3BTZUNld1NiSndkUWZ1MTdLZzNOZHpua3dJ?=
 =?utf-8?B?RFhpSnR4TTdnN2U2NW5lQ3J2ZDRkTlZ6aXhidk40OXBmZU12VEk4VDVUaEJB?=
 =?utf-8?B?RWxWYWZOYjFGdzZlK0NzeW82VStPZk9JV2xGV0s3K1VGbDBycElXV1NoNERG?=
 =?utf-8?B?S0ZTejA3Z3NYeFdpOTRmRXEzQXBiZ0EzaDZaL0RjMnVYelk4UlRwMSt4WExJ?=
 =?utf-8?B?dVhKL245a3dodmtkeU9QdXdLYktzcllxbndRNFR3WjZjRDczREMxRjRXV1pS?=
 =?utf-8?B?UXpSYVB1L0wwb2Y3eTdOdWhRNktRcFZkM0hLdzVtWExGbGt4cERaM1RaaG10?=
 =?utf-8?B?Z0xoQmRudDREczQyTEgwWkllU05UMmVlcXVZZFBrc3lKVWs1Wm5wQ3BYNG5B?=
 =?utf-8?B?cTdSQWIvQlVlYi9Jd3ZMa2IyZ2Q2R1k3ZGJXT3hPZmNRZ1hQMEZpeWtTR3cw?=
 =?utf-8?B?dUFsUnRjRzhhZTJxZlMrRVBBMlN3cVZZUUlGaUo0NlE1STd3YzM0MVpxYlk5?=
 =?utf-8?B?NEFUYnRLZW12Q0RPclVGbFo2aFRzcFZUNUdzZmM5ZEVxMzV4S0Iydk5PR2FD?=
 =?utf-8?B?ajV5SUpya1lxWUxPdndJQW4xUk1Hakp6anh3UnkzQkNTTmw1U0NLU0pqTVhO?=
 =?utf-8?B?WTY1MTdDSk9MRS83M2p5MThsMkFUL3lQUUUwbzVENG1Db0dSbzM0VnFoT1NV?=
 =?utf-8?B?bkdzL2liMEdkcUJCcUxxV0s1QjV3dENJTGFiZTJNQ2Q0MGl2R3VSSjExV05E?=
 =?utf-8?B?MmQzdjQyUHEzUGMxMUVGUFgvdytZZllxWXZkWEFIdksrT1B3eHk5bDhqYk9G?=
 =?utf-8?B?SnVpK25ZWTZueEtqRTQ2NWtSby8yNCsrYjJCbHZzTmZPSnFudFFrNlhoMXdK?=
 =?utf-8?B?SHR2bTJITTQ2ZXJ2Qk1jZkhvWnhSaU1xdi8yNXVvb091MDMwNmR5MEVxS3Zu?=
 =?utf-8?Q?qkJQhr6taO4G0cpgGh5d5sK1bOxj9Ykk/UUfqlY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1c999d-1c76-44ba-c372-08d9514ed7e9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 22:35:32.3208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGtRH54H+T8JD39k5NJHkYnw0Mo5Wx1YrQtFvYlvM2KuuXITLZeL3OFL1C075RI0HnN0fbJxEEG6UP26dpW6qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4351
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10058 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270130
X-Proofpoint-ORIG-GUID: _bVxlAGpGfXdk-kdUVW7wuwASPXcZw-E
X-Proofpoint-GUID: _bVxlAGpGfXdk-kdUVW7wuwASPXcZw-E
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/07/2021 03:47, Josef Bacik wrote:
> We're specifically prohibited from removing the last device in a file
> system, so this check is meaningless and the code can be deleted.

Josef, That's not true when removing a seed device from the sprouted 
filesystem.

> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/volumes.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 86846d6e58d0..373be4e54f28 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2199,13 +2199,6 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
>   	btrfs_close_bdev(device);
>   	synchronize_rcu();
>   	btrfs_free_device(device);
> -
> -	if (cur_devices->open_devices == 0) {
> -		list_del_init(&cur_devices->seed_list);
> -		close_fs_devices(cur_devices);
> -		free_fs_devices(cur_devices);
> -	}
> -

  Here the cur_devices will point to the seed devices, and generally, it 
is the last opened devices in its fs_devices structure.

  Comments about it is a few lines above from this.

2157 /*
2158 * In normal cases the cur_devices == fs_devices. But in case
2159 * of deleting a seed device, the cur_devices should point to
2160 * its own fs_devices listed under the fs_devices->seed.
2161 */

Thanks, Anand

>   out:
>   	mutex_unlock(&uuid_mutex);
>   	return ret;
> 

