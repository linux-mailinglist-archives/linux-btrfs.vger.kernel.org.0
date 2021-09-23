Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6D1415792
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 06:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhIWEfI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 00:35:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36604 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229504AbhIWEfH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 00:35:07 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18N3WpGE019179;
        Thu, 23 Sep 2021 04:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mKvGNglq2oe0gh3tLqpem3dzAZZmMavBSIAD9s6gsMI=;
 b=NZWRJPXXhBEFqMbKEp1nGR7pPsWBKWEuDWaqe9nGFk4ML7upgYJh6Xht9ZJR8sQc7I1n
 JB+7Wap8fSMVZpzgt2mkxZSDnku0EYFg7A5gxjawIkQMGU0hIiFF2ynSRVAFAIn8Jhh2
 RtWb2Zoi7JiNOIxI6ujXc10/beSzAQftRsexAky4349Jr2i78XEj0tmijSzy+InNAoyT
 fbHql8gv/6h5Cyi6vno//htF7zZMaJDhGyWPmjBTfNc+NUN/dyCi+XBvyzMg/JciI6+A
 f4lEGTL2jF0YoTc4TjjaKKXvVOg15QX10u+7xGv3/L8it/B7jAhaSt977bcZ3R9iWZ+c rA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4rgf5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 04:33:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18N4U7dL012057;
        Thu, 23 Sep 2021 04:33:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by userp3020.oracle.com with ESMTP id 3b7q5x7b14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 04:33:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWHyAnFrS9i8Q1Gj6LlsMZBvZppyEu4GMOMzWtT0wINtwKgOZ/WWgMnc7CWeBhWvYPJaCIFFUVEGJlLPxoLAQ/aVkDMD+bnjHBIwR61OitQUQWQZKlyHETKNBjaPWrSYNQ9i1vuaC3+cXHrvt5MI4TDUbiM5IH+mkhNFnhR3/88dz5xJLa9NUdplMw7Wur3p1nc0RFdWr0LmDiuM+GIXTH72CQiNs8kC/Eq5Uz4c/ONf5YPaCgCscQ7BRSqpD0Htmj+iBGr1S4WfZ5KFa/zwjqDlcr6yk1QYazzQKqlGENZ5Z+PAhgtYnGyagZk6r/p7bLuD7E21XWtIFER+vTou8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=mKvGNglq2oe0gh3tLqpem3dzAZZmMavBSIAD9s6gsMI=;
 b=en2QAoQAl9l+QoIHEU44G6E7WEjZ1kU5TNdfbWcBVqkzUkwmORk75fq2k61NgpdINbhLdItLEfxe9oYPSEEM85sN0HqO3tnBWvlO/peqiOWP6Visiz/w0YfrOUQuA69ucGrGfuuK8MLIWj81KdW7LCzZD9h5a26nktdLi2n57r/d5DsPtbVv9Fn48WxnkvsYYpanDbwr4YZ/rzn+Hk37ZiiXp7NDKE9LXOsIOGk5hDBtgvw7O0sBGcM/ZH4kkJ47bXUb3cluhIpHzTl/+zJhBIeSMXEvCsde5hNOLIeC9QrerdQXx3SUaR7gTgcXj23rBNcOwycNtOCyvtyBN0feMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKvGNglq2oe0gh3tLqpem3dzAZZmMavBSIAD9s6gsMI=;
 b=AIyAmy9e1l4xpMJENtoXD5ivwGhiEbUAgcrbjP2cLgNQlhAGGU0YjvvfhmQt+NnWFcZOS+FtPYAopF9tqcJbsu0iNKXkIjoXK7+r5vLIy/EFTOb0IeduU2w+MMjWn8GwDhZV+GA9YbQCXdE58ykr8EGh5ZE8JcfKEo+bIq7RwJ4=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4303.namprd10.prod.outlook.com (2603:10b6:208:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 23 Sep
 2021 04:33:25 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4500.018; Thu, 23 Sep 2021
 04:33:24 +0000
Subject: Re: [PATCH v2 2/7] btrfs: do not take the uuid_mutex in
 btrfs_rm_device
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
References: <cover.1627419595.git.josef@toxicpanda.com>
 <4f7529acd33594df9b0b06f7011d8cd4d195fc29.1627419595.git.josef@toxicpanda.com>
 <17f703ef-81b2-2a28-6ad7-b94e2944be0b@oracle.com>
 <20210920082638.GY9286@twin.jikos.cz>
 <31cf3228-b666-d165-2d4d-b3f12bed3b6b@oracle.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, dsterba@suse.cz,
        kernel-team@fb.com
Message-ID: <921c8858-b49e-3a42-b48e-c7f7c4cb5b85@oracle.com>
Date:   Thu, 23 Sep 2021 12:33:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <31cf3228-b666-d165-2d4d-b3f12bed3b6b@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0119.apcprd02.prod.outlook.com
 (2603:1096:4:92::35) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR02CA0119.apcprd02.prod.outlook.com (2603:1096:4:92::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 04:33:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1abe4170-0dbe-49c9-dd75-08d97e4b481f
X-MS-TrafficTypeDiagnostic: MN2PR10MB4303:
X-Microsoft-Antispam-PRVS: <MN2PR10MB43031AF6EE4F46E4381677BAE5A39@MN2PR10MB4303.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NmB+DUmq0mGfUwOaZPYeqwQRVP+93xZ0VbwVanjLW9w6nJ6mTYCCiQqEp9+HJp3I5MlSwJk8KQ2FyeoXqXe11VIgnXc3eqEeyFUc9WWDZWzG4lmCyod/U5sUyOOYoLicf1RwYmmdX4xVWgxAHUkR5eJ6ytm4zQwRVIKxihb4Nb1l6YbocNKDDdk+QQZ6OLIj/8tvmxLPXT/aeS/4SNi/Y4JJvPIjmgadXwGOanEo+NdNPYgy5E4qjfrWCKZNFI94YJvD7xcg+H75FLp28Scy4tM/n0x2UairYBao80Ekoz4enbIWeEeq07bvoiZBFcaizdn/hXT76TJXmhBb6TlPW749DmtXXBTLh0SgI+SaPihv/GWS8ZgpLIE+EveHAzjU2OtYPrz3A9uTjM5edPR7tk6hA8OAshrIDRuOZJ9Dq3oPSB5iCov9Qd6TIdgJ528n/JV6gMwJjBmbQZJDjrcDPSqus4Irkp0a3O4ENUs1hE1eT9+cWckHPsOOLu2VNvyKeaTe0/T1CMMRfYRoH+xHfJ4PuA7pjy23whaZU1L+6ihOKH0NNAd9MyGKxBSDKiaFPcSbbmx9Hlp6cUwftA7jXklnle9ocpT+st+8w3ZeQp/ARJWMcPoKpHHrGEhGJmuVeK5aFkgq8H34S+gk7kPB4+Q9Zc4EfXeanSP2tit1xmifo4qL/MxENNO7fCeIHDWAKNG4/8xRCM5lwPMaAd7NnV6KG4on8xkQvMZ2W5m4eH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(44832011)(31686004)(6486002)(36756003)(4326008)(53546011)(5660300002)(6916009)(316002)(16576012)(54906003)(66946007)(66476007)(2906002)(26005)(508600001)(83380400001)(956004)(2616005)(186003)(8676002)(31696002)(86362001)(8936002)(38100700002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0J4L2I4UTVneWMzd1dFL0pheXh1UkRKd2FnVWppSHdpN1ltZ0pMeFltbzFU?=
 =?utf-8?B?NFIwQTJ6T3RIUmRhTjhrZDltdlU5OEw3ek1JVTZxU3RySWp3Vmpwb21iK0Iw?=
 =?utf-8?B?TU5CWTZjNUF2Vnp6UnUvd1ZkU0k1dlhOWGN1L2lIM1hkRTB6Y2NnQlhvcGhB?=
 =?utf-8?B?SXhITnIzTWFsSTJlR3lDOHR3UDMvaTJFY0VXZzF3VkhseVM4T1E5eEp3K0dh?=
 =?utf-8?B?RnpsZTNyckFsdzRvMU4zYkRRSzFFOWh6SzdES3F3NEVYcUwyTWQvdFM4Ui9L?=
 =?utf-8?B?NldDdDE0V2wvS2w1OXlCdnpNcFYvd1lXb2JZODUrNmlvQnFZM0hTdUp2UzRo?=
 =?utf-8?B?eDRMSXM1aVU3MHcvN3FZYTFySzYwNkhRd3I0dTFQVE43SEppUVV6YnNyWStG?=
 =?utf-8?B?NXh1UHlQNmxueEsvL1RhREM1K29WVTZ6a2hNZVIzUU9mb1d4WlFZRDZYM05L?=
 =?utf-8?B?S0k5OHh1azY0bWJOY3FCQWFJMG8xTjdDV0xvRzAxd29kc0YrdzU3YVhadDdD?=
 =?utf-8?B?cjdDM01WQytIaFg3cDVBZ1MzM1R3YzNOaWhTQkMzdGFtdkdMUkE0Q3MwT3px?=
 =?utf-8?B?OHNiUHlqaEM3YUZqM0xMKzFnTnNtN2JSREt0cy90azlCeGQ1d1lZdEVUdDhX?=
 =?utf-8?B?U0srVXJSUERPdDYydEdVVytjajNjdVhoSEtUTE9uMzZvWi9zMXVab3hyNDBy?=
 =?utf-8?B?WFhicEVSeXFSRTJYV1Ezd2FycmdZYitHNWtFWnY3SDZLNHlLOEJ6UWRGVUhH?=
 =?utf-8?B?SENWTU9uVWV6aHYzQjNMdVNEMld1SXA5aVhjcDlSZU1hd2d1UUcrM2VCV3Nx?=
 =?utf-8?B?cHZYZ2RvSHhCTkR1Ykt6WXRKTlg2Ykp1WjJiNHpUbm1uOG1Mb0NZbnphdm5y?=
 =?utf-8?B?V3U5c25pU2V4em15bU1UNVFOdzNUWGhLMVlQYk9vaU9UVlhuRDVFZGRERmh6?=
 =?utf-8?B?emNhdEFqc1dzTzUxa0pwek1ncDF0ZDdxU3ErM2ZhcWtZOFN2VTR6NEMvcjdw?=
 =?utf-8?B?UVVjZEFnZXRoTnA5MlhnU1JnNm56S2dSaHdPQUYyamFCT3NFL2hYSEJWZkdn?=
 =?utf-8?B?WHVIaEUwNit2d3dqWkNQZzBmWXJva2ttUXNvaXFmQUtUaWg4b09adDlHN3Bk?=
 =?utf-8?B?bEJOVUhFcVBVN2s2WTlJeXc0TmdOVyt5STJsdEg4SlRUN3liWDZZR3cwTmk2?=
 =?utf-8?B?ekx3Y2oyeHRua1RMV0N2TURSdDYxbm82ZDlFWmZ4eVQxRGlsaGJsTzhwZ0Zx?=
 =?utf-8?B?VDJaQ1JrSUxpbUZsOU9HQzRBL2o0Vzh5MDRQc1NHdUFyYjA1TUJNV2JjdGFD?=
 =?utf-8?B?UHl5KzlxRnBWTHVDNnV6bUxnMFB1ZUZhK1dDc1ZpbWE1aGdmQnZ1RkRUdmNk?=
 =?utf-8?B?Uy9sVkZuQjd2UXBtVEQwK0ZETnpwN3pxem90VmFWQkUyMDhpRjh6QVZrUWVS?=
 =?utf-8?B?dUp6NXY1SGU3eC9Mbml6bjBaMWhub3ZZcFhzaGI0Sm9jVVk2bWVSS0NzVkVh?=
 =?utf-8?B?VXR6bS9BN0RSZzY5TTc2TGZqQjV6bUcvdnk3bUMwNm9HdTdheTdMb1BxSHdI?=
 =?utf-8?B?SE5tbi9nZ3RIdURLcW9WLysxbVFSZGxZVStlald6bnllMUs0bXQ5dkQwVjFj?=
 =?utf-8?B?cE9FT3RBeU1vbktjTzZmbHhuS3g2dG9nRXQ1M3FNeTdhcGtrSUJrcjhQY3hT?=
 =?utf-8?B?K2U3NDI2Qjd3KzVXU2tVYW1WdnVkU0ZhZG5JdzVFcjEyNmRNNmVKSXBIbGZw?=
 =?utf-8?Q?2z3iMLtc0jOEimULu9Ni4B2kqMf5M2uu9VEJYlQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abe4170-0dbe-49c9-dd75-08d97e4b481f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 04:33:24.8306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwW0XJo7mLHS+t2A7WyS0P2YPAzPN1mO3mpq8n/A6OD6FEq/cSI1zR0A3cuaJFyFXyODAJvuNREy6xlDOj2crA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4303
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10115 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=862 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109200000
 definitions=main-2109230026
X-Proofpoint-GUID: VvSgn_u-7X8zqXDAnWSsHupgDG8eAyC0
X-Proofpoint-ORIG-GUID: VvSgn_u-7X8zqXDAnWSsHupgDG8eAyC0
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 20/09/2021 17:41, Anand Jain wrote:
> 
> 
> On 20/09/2021 16:26, David Sterba wrote:
>> On Mon, Sep 20, 2021 at 03:45:14PM +0800, Anand Jain wrote:
>>>
>>> This patch is causing btrfs/225 to fail [here].
>>>
>>> ------
>>> static void close_fs_devices(struct btrfs_fs_devices *fs_devices)
>>> {
>>>           struct btrfs_device *device, *tmp;
>>>
>>>           lockdep_assert_held(&uuid_mutex);  <--- here
>>> -------
>>>
>>> as this patch removed mutex_lock(&uuid_mutex) in btrfs_rm_device().
>>>
>>>
>>> commit 425c6ed6486f (btrfs: do not hold device_list_mutex when closing
>>> devices) added lockdep_assert_held(&uuid_mutex) in close_fs_devices().
>>>
>>>
>>> But mutex_lock(&uuid_mutex) in btrfs_rm_device() is not essential as we
>>> discussed/proved earlier.
>>>
>>> Remove lockdep_assert_held(&uuid_mutex) in close_fs_devices() is a
>>> better choice.
>>
>> This is the other patch that's still not in misc-next. I merged the
>> branch partially and in a different order so that causes the lockdep
>> warning. I can remove the patch "btrfs: do not take the uuid_mutex in
>> btrfs_rm_device" from misc-next for now and merge the whole series in
>> the order as sent but there were comments so I'm waiting for an update.
> 
> Ha ha. I think you are confused, even I was. The problem assert is at 
> close_fs_devices() not clone_fs_devices() (as in 7/7). They are 
> similarly named.
> 
> A variant of 7/7 is already merged.
> c124706900c2 btrfs: fix lockdep warning while mounting sprout fs

  Oops it is patch 1/7 that is not merged. So David meant that.


