Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75013FB6B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 15:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbhH3NF4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 09:05:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:31274 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230119AbhH3NFz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 09:05:55 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17UBNgwx021710;
        Mon, 30 Aug 2021 13:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kWbHLIzRaujqhGHYcCALO6NzRUGfzUy+3SYYUa3gzro=;
 b=1JFyFxFtwd1QLGT/hPfDj0SNteO1cjSxlJSxcTMrmRRuvED56NpD7BeQ/cZ96vYBiJuq
 jH3qpMnZsZl3YL9ZPgggSZpnsYlm3xu1Z6C5IVJ32SR73ndCSzkQ6INIOPwN/4f/Z2xb
 qI3YIHNK6syJYWdXNUKTOMpLIo29jFzWfiZFt6BwycgaHQzHr7K9/MHHOvO7jSrSQhIy
 vatdWeflHNpooeu8Ks6oEMFOl07JENFZIs9F22BKqsYIGWFduXgW+coGrVu+MVhJV8SN
 X8yx2snDkG8gnHBT8ucnyXNc06d7jBIVIXkMb9gjCm6Qa+7RSSwJwlyy36nykxq47ThU 1A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=kWbHLIzRaujqhGHYcCALO6NzRUGfzUy+3SYYUa3gzro=;
 b=XC1eKOO9kbIV6lFweLG9pn2tS5YGKu61bccfh65dT9VKJqQ3tgJBWUUC+NR3JwjG19MI
 NClcJnnLknWCUG5HRfJgMzdFx51TVK3NUFuvP2n2ATJkfisd5+CMjeVrC1G6FzocvOnL
 GklNiRsH4VmRFguhQZXrFwECykL/EsOfK/5OP34KMFit20oIf+Q3LHXr2f95SqBCXsOc
 0DYnlojOqySE6IakkdGpDxDqR74kYAavWCw5ipM1IHcNu5zYZTRZfaf91i8xlp2dwDz2
 rBSVKWt7AVkaZfZUFilV8Tj8ILU5k26SDcBQ+pOKzsTVg4+cZIZPj2Dip70gLe1Cc68Q aQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arbxxhg63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 13:05:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17UCuAKh016753;
        Mon, 30 Aug 2021 13:05:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by userp3030.oracle.com with ESMTP id 3arpf29quk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 13:04:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpXom0P3X+0CpTjmdCZQDx/H2LLD3xz1SLX/3E7DyobhpEc1b5p584FUOss+2xrIzkY4XYtiDMnYu1tTP5v0XWJ96Pf46AYtxhYph6Xi8qsUSkYxIW/j0SE79NbD4bhiRMHp2CTtfMjOztVSYyORm6cCfQCxKMfu1F5TrLe/5ipVMN8RrDnDcdCigSHxjkXha0ISQxT7u7pgQxjLXi7XyYMMje4mOV/5Y4lZmc9b87Qt9C9S9q/vKskXrfq8c/cL+UkDPJhZDDEktlGZOaUXM//t7diFzQrFH6Zdn/a1WpvL+klDATpSIpR/xcpwY59zH9hWdUMMFb8UV5aanYSa2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWbHLIzRaujqhGHYcCALO6NzRUGfzUy+3SYYUa3gzro=;
 b=jZ1Ac25e0V98oZY+06aQP7j2VeWy2XDGJEKB4d6CIXVMO9VlgrIU19v/OEg0xgeXS48AbQVyBxiEwGPn9XWwi8WA++K7JvS4UZYqd+y9DkkOzAQBqJvc6TpUANsB5AKKqjN8QASW5zyQ2kwRTmTR84a4r6M7WPOJmQNyVRBvXrgPzAdqoMKTqxsNNWYRyPq94xZRTvdLe4KswWiddOkVadviE6r2HYZD2mIVPWvtSO/R0j/+38orjW2gwi4vkzCcj8+pSmQtqV4WRDFUwEFN3sDZIDP9FEvX8MlKb3fmOQrcyWsI778bPpfbSVSe7gF82WB1XZp6bA6+MsKIyuss0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWbHLIzRaujqhGHYcCALO6NzRUGfzUy+3SYYUa3gzro=;
 b=VdOHHy4N0POnsBBvmC6aGcbGhNywS5VWVaPbiRx7DEmWFDB2+UnWs4Z7ttVp8bRT+uo1e2HgZn/D56rahBsIA0/DWRDOuxT4wUkDPhj3k4cbRLGo3gUEiob40dtMBKuWmSDC+cqbm0mXHG+sHWkYtAkNi3iXlsjrtQrvPjkSrz8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4125.namprd10.prod.outlook.com (2603:10b6:208:1df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.24; Mon, 30 Aug
 2021 13:04:57 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Mon, 30 Aug 2021
 13:04:57 +0000
Subject: Re: btrfs mount takes too long time
To:     Jingyun He <jingyun.ho@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAHQ7scVGPAwEGQOq3Kmn75GJzyzSQ9qrBBZrHFu+4YWQhGE0Lw@mail.gmail.com>
 <ce0a558f-0fab-4d52-f2d1-1faf4fb1777c@oracle.com>
 <CAHQ7scVkHp8Lcfxx2QZXv2ghkW-nYpiFGntyZa0Toz2hU3S-tQ@mail.gmail.com>
 <b0feb23e-4a18-efd7-eeaf-832ef0cf6860@oracle.com>
 <CAHQ7scUiNLVD_4---ArBet-0DqzfmmH5Y9JgQY0grYrUv8yhiQ@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c2d2a244-f77c-e0a4-d266-db011fc4154b@oracle.com>
Date:   Mon, 30 Aug 2021 21:04:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAHQ7scUiNLVD_4---ArBet-0DqzfmmH5Y9JgQY0grYrUv8yhiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::30)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SGAP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 13:04:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22ce5505-5ede-4d45-9f8b-08d96bb6c440
X-MS-TrafficTypeDiagnostic: MN2PR10MB4125:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4125647C0AA5422F37C7D23BE5CB9@MN2PR10MB4125.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KW5z0ibt6D6cXCiyqQo0wKXtgis9O1K0W1EQpapb28lHo9VrtkVWwK84lp1RMySP3wXR7LRTYVEht2neEzViEADe4EK5ueL754pMye7SyClbLhWyAP7DxpPcF3URlmznbllpu5UKvFtn9t6UnUa2kT0lBBXopFjidfvxpsUij4fRG746Rgw9tTlOuQ7kMDJp620KUXXNrehrFJycewjRywXRdqQH+8wNWojiYQ2i2qa/Dg41RtDwePW6aX06k9izE96a5RlK8eGKfUxYg90dkzylezUANksfdgG4XEiIkR6ZEnGCdnayDJ6v3KgskQ27Jz5jXhLteGbj2zlWuQPY5JIf0OEdiseP18AsIwicWXyW/S5i9Gm6ltgUpamd8e2D/LlMQJHla735NvcFGp6RUmtoXqDu1L1ZfSn+d7T6q4rA5CedrqKGHl1FTyLz1KVIdGmGkWTb9TO2XNqEDVBAGRmTUg747/5hDb9Ina1AYzYo0uLDD5muLhUtm0BhdkHNgoGjjdi09EMmtigOPBkEG/A7HtQbhNhtXrtV6U/c09BJfLuZFi0WLtLop9ChLmC6iuHEebzilHb8i2Xr6LgxnsfwHA4Ix142UyJet6uc2OvWFZTHUfWgpPLL2molq/EnkSVfn89gQd1nT4DPIoOOEhQ81w5tVjaUQg8GEIIKp51vgTY5K+5KooEHXkxqBxKgXxmpg3nR0INuGA2/VYTn8grSvrY8DNinIAQVuOhO6x+mpnyHJD1Z6iyvT6m20IIHcXodRKOiKonVDI4lXJzlGytpIPbfn5vg/zr2HmowozkR298A+y78vHxUIUIJpRqY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(366004)(39860400002)(136003)(186003)(8936002)(8676002)(44832011)(36756003)(956004)(83380400001)(86362001)(478600001)(66556008)(53546011)(6666004)(6916009)(66946007)(26005)(5660300002)(31696002)(16576012)(66476007)(316002)(2906002)(38100700002)(966005)(4326008)(2616005)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dURTU0hrRU1zdmJ6amVVVUZkbWFQNGw2TlRvTU9PZk1JU2w3UTF6aDRXNm5U?=
 =?utf-8?B?YU1hWDM1bmZESU5HK1IxYUFXTWdYWFZOWVhBZUJDY2o0UkZRQ0tKWnA0aDBC?=
 =?utf-8?B?RjJKZm54S1RTWVdnWXMrQ1d1Wno2eGRIaHJTL2VvbHNSTnZGYXpIbHJFQzZ0?=
 =?utf-8?B?emMycmZmclJzQk1kTGs0S1pmUkFjQUpDZUJOS2d1NjQ1eGI4V1FKaVRVVEtZ?=
 =?utf-8?B?ckVudXlJblV2MmJicjl0bDlyNFdnUFJQL2FkN21xQTFyZDVXOERvMjlXdXQz?=
 =?utf-8?B?ODEwdDE1WlFSVTBrd3plNlhtZ2hHNXhra0VvU3pWVFRpTUx6MjFzam90TCt6?=
 =?utf-8?B?TjV0TUI2WU80b2UzVHYwTVRTR0MzUGplSGVmTWNpRC9DUXl3czcyQ2l1Zy9j?=
 =?utf-8?B?R2QwdXZtY1hTdFFkemdBenFHMHBGTmgzQzNoMDVZTU9Hd04ra0Q2UGlGeUc5?=
 =?utf-8?B?VTNzZGJJRXo3MG51bFBNS1k3aUxKM1IraHlNcXdsZ1BQNHBBTzByL3dydTh0?=
 =?utf-8?B?Q0JBejRsVHlZbDQrWHFxNWcrN042UndBc2N3YUhUWjBJckt3QTdkeEpZS1dP?=
 =?utf-8?B?L0tJSHlwWHNWYmZmLytyK09hU2pZNkMrY0JVQUZxdDkyQzdtUWg1Q04xUHVt?=
 =?utf-8?B?REJRR1c0L1MvY3RobWpleXpFQnFzT3Eyc29XSU5OUGU3TXZlaFhPWFJ6WWdB?=
 =?utf-8?B?Zzhma2MzK21nbWtOTGp0cEFocDJPejgvZ1RoRFVVNTR3Q1M3VjZrMkVSYlh0?=
 =?utf-8?B?dDVPUU5IZ3QwMjh2ZW9aaTdrOEQ4c3JZcUJjZS9lMnNHOVBYZzM4VWM4V0U2?=
 =?utf-8?B?SHFoUndjSVlIT2VEekdNLzdqcG9FNmRMTzFQR2RrcWRHWjJRK1VBc1ROWlRG?=
 =?utf-8?B?YmoxKzhXRkticFcwL1dNNHIrWG8waFpEVm05bXhsR29iVEF6K1llMjdHc0V5?=
 =?utf-8?B?Kzk3WUxwNXBrdmNTUUhPRUF4T1p5QXVIT3dLd3BGQ2IzTlFRcWpxK0h2YW1M?=
 =?utf-8?B?cXBzY0x4Ri9MdUpEVlZIbUJFTWRiR3RraUtCMmJKZG85M3ovRTBmbUhybStZ?=
 =?utf-8?B?WVREVUNEcWw5N1dqS0svSkhMRmx3MzdVVTNWcm5oS0IybFMxaGtSc3h4ZjJF?=
 =?utf-8?B?aHVDQXgvdFBGRlp6MXdPNFRMUElNVzhndlJNdVFObEpUZ2M5MDMrM0gzaFYw?=
 =?utf-8?B?VlRuT2RESkNvOEJRdkkyODZxdFhKZVUweFNERlhRa1lNa1I3Z0FMY245K3Q2?=
 =?utf-8?B?WmpKZ2VxaVcvUVlBQTYwNE45YTBZdzhxbE9UUFhZZkk2ZUhhdHBXVTJPUXZO?=
 =?utf-8?B?ckZLMUhXUjNPMlE5Wjh1NzRvaU5qWUxVdStEcTZyQVdudHZhVTV5N3F6Y2dx?=
 =?utf-8?B?c1JFbDdJbGhHZStXOXNuZzRRRkx1bjlkcFh5YTRUcyt3Ull6Rm5nZS9VREFx?=
 =?utf-8?B?VEwxS0tXUWxOZStXYmFxU0Y4MldaWGxzeVBjUHMveW9jTzVSbGNyYURrUTlG?=
 =?utf-8?B?ZHJ2ZURQMGkvdXVscE50MGRWUEJXenZkTlQyZVM1MmxBQitCZVpDUzJVYTVx?=
 =?utf-8?B?V1NBdnpWTjZvMVF2L1ltVExQdjAvemw3ekNyUWlhZjFmNWdRckdjZzBJSkdX?=
 =?utf-8?B?YmVpcmNTZWNEWSs0MTMxWVZkQTlGUGlqSDZORHlXWmhUUVd4Q20vWi9RUGZ2?=
 =?utf-8?B?M0JvdzN5UUMvNDRiMjdUVUtGdkVhMkhQVTAvZyt0anNJTUU2Y01EVno5eWxZ?=
 =?utf-8?Q?Q0+QYmRtERsnYOrBRjyGstPqadlvpbZS3POPmlc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ce5505-5ede-4d45-9f8b-08d96bb6c440
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 13:04:57.2287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKE7ITpFLoqYH0IgU3jqyLlM5J+ZGCKwqTA5XN2GK/RKj7w/PUlD3RygMrU72yBjsxPukXl/k5kmizaV0I9Zbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4125
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10091 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108300093
X-Proofpoint-ORIG-GUID: AilLOUj_8CdZMrH0onxOmrs3YuElwFP7
X-Proofpoint-GUID: AilLOUj_8CdZMrH0onxOmrs3YuElwFP7
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

open_ctree() took 228254398 us. And 98% of it that is 225418272 us
was taken by btrfs_read_block_groups().

-------------------
  1) $ 225418272 us | } /* btrfs_read_block_groups [btrfs] */
  1) * 16934.96 us | btrfs_check_rw_degradable [btrfs]();
  0) 0.967 us | btrfs_apply_pending_changes [btrfs]();
  0) 0.239 us | btrfs_read_qgroup_config [btrfs]();
  0) * 21017.34 us | btrfs_get_root_ref [btrfs]();
  0) + 15.717 us | btrfs_start_pre_rw_mount [btrfs]();
  0) 0.865 us | btrfs_discard_resume [btrfs]();
  0) $ 228254398 us | } /* open_ctree [btrfs] */
-------------------

Now we need to run the same thing on btrfs_read_block_groups(),
could you please run.. [1] (no need of the time).

[1]
   $ umount /btrfs;
   $./ftracegraph btrfs_read_block_groups 2 "*:mod:btrfs" "mount 
/dev/vg/scratch0 /btrfs"

Thanks, Anand


On 30/08/2021 14:44, Jingyun He wrote:
> Hi, Anand,
> I have attached the new result.
> Kindly check.
> 
> Thank you.
> 
> On Mon, Aug 30, 2021 at 9:27 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>>
>> Our open_ctree() took around ~223secs (~3.7mins)
>>
>>    1) $ 223375750 us |  } /* open_ctree [btrfs] */
>>
>> Unfortunately, the default trace buffer per CPU (4K) wasn't sufficient
>> and, the trace-buffer rolled over.
>> So we still don't know how long we spent in btrfs_read_block_groups().
>> Sorry for my mistake we should go 1 step at a time and, we have to do
>> this until we narrow it down to a specific function.
>>
>> Could you please run with the depth = 2 (instead of 3) and use the time
>> command prefix. Also, pull a new ftracegraph as I have updated it to
>> display a proper time output.
>>
>> $ ftracegraph open_ctree 2 "*:mod:btrfs" "time mount /dev/vg/scratch0
>> /btrfs"
>>
>> Thanks, Anand
>>
>> On 29/08/2021 17:42, Jingyun He wrote:
>>> Hi, Anand
>>>
>>> I have attached the file.
>>> Could you kindly check this?
>>>
>>> Thank you.
>>>
>>> On Sun, Aug 29, 2021 at 7:47 AM Anand Jain <anand.jain@oracle.com> wrote:
>>>>
>>>> On 28/08/2021 19:58, Jingyun He wrote:
>>>>> Hello, all
>>>>> I'm new to btrfs, I have a HM-SMR 14TB disk, I have formatted it to
>>>>> btrfs to store the files.
>>>>>
>>>>> When the device is almost full, it needs about 5 mins to mount the device.
>>>>>
>>>>> Is it normal? is there any mount option that I can use to reduce the mount time?
>>>>>
>>>>
>>>>
>>>>     We need to figure out the function taking a longer time (maybe it is
>>>>     read-block-groups). I have similar reports on the non zoned device
>>>>     as well (with a few TB full of data). But there is no good data yet
>>>>     to analyse.
>>>>
>>>>     Could you please collect the trace data from the ftracegraph
>>>>     from here [1] (It needs trace-cmd).
>>>>
>>>>     [1] https://github.com/asj/btrfstrace.git
>>>>
>>>>     Run it as in the example below:
>>>>
>>>>     umount /btrfs;
>>>>
>>>>     ./ftracegraph open_ctree 3 "*:mod:btrfs" "mount /dev/vg/scratch0 /btrfs"
>>>>
>>>>     cat /tmp/ftracegraph.out
>>>>
>>>>
>>>> Thanks, Anand
>>>>
>>>>
>>>>
>>>>> Thank you.
>>>>>
>>>>
