Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14366A15B1
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Feb 2023 04:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjBXD7T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Feb 2023 22:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBXD7S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Feb 2023 22:59:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1C246177
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Feb 2023 19:59:16 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31O1mlXo004724;
        Fri, 24 Feb 2023 03:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=NF68zIKWUpSczz80hc6VxxSmMGdrft8mNzLEWu1I7Xs=;
 b=AnZQ+26wxofymElM4YiNrCiOtNaAVcdLg3xyZjPgjyUnh5v1majsxfkX7O/jKvK2Dvhf
 +MIWGAmluowVgrU1Vt6CkkXhjm10CvcAGMb+bGXAT+v6Fwin/BkXhVfRJtrxuSblUlXX
 oJc4/bY28eSz5V65MsNrGzVtmTCMeXoX9MEF+LDfyBShj8n5N73+dIlkCDrlRy0p8oeP
 9QM1WPKbHsXJx2uTaESCBqhOapAqMRd6sIbAsUTQM4asM9irzJeK6LoCvkd4Cq4pmMvJ
 lJIm3cMM+ugl8G0TfqhuHDy+8OGd5tbDv4YeYMpkmmMdP3eZylIaXvcQ16nWBBVh/+up Bw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn3dv6qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 03:59:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31O3ALMI013399;
        Fri, 24 Feb 2023 03:59:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4fjq5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 03:59:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUTzU55/6s/KJtz1PIV0/P1eei3GDbNG+BrAhYGoOiuWlZG+qkkbN9HGaKai8Kevn9QjM1OHxKBDa8qo/rFqW9PPsCdkZ97X3gHKCz/7jCtUxvzoveEQtmfkdk+Qug+ULirSRRutRn9xoeI08Kw2ysnCbP1RsP0lGnPuow9CzcNv76MqTbrIuBzaOZb0iiBcylBl+GBxw0slylZIz2Vbd0cejn4RSMtlZclO+4EgrivOgmY5KsPg5dAALOKm1637y/31fJbhkliM7sVrvMZZ59b1DrGY8d/s0qkYEew1o7vdfRnF00k3MeEYw11KZ3VDhnxNTsA08zra2B78d/a7Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NF68zIKWUpSczz80hc6VxxSmMGdrft8mNzLEWu1I7Xs=;
 b=N7EgfNBkvFiUNbWlB9V2/u0PDQy1bqYHdUGV+ctHgK3TslDtboZMf1EjC7pNAYHgIAToeqEV9uN5xXC1u39zDEN+308iKoXlIp+QI4CQM1tQ8Mc7DUkhY+Jh7hDPgGSexIFipQpXYVdRBdjolVAk4sXQAOZ3kV/Pp4ffpFuZnEbb7EpqJ35Nswp8LQLQZZhQXnNIEAuAtRvikFSdnmHk6br7P/w30XpSqnwELZ/7KGGfinbOaZUqVCaNYMvPkRzvDB2Bu5O0NlLlQLs1jvmdB1m0m9q/BP+axSlJ8BFpAwgLK1d1jn71x4QXMHXO+jPE0v3SnvNYgqg+JJJcXUsAYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NF68zIKWUpSczz80hc6VxxSmMGdrft8mNzLEWu1I7Xs=;
 b=XWtyrt4HWPjT/457ooISnQzNCIKV8kTe5LrtXyCrAqur6L0PxiaWyfuYwWrRhcS3QD1WycFmnda0V3bObmYXrHMRt9DHcLjcde3k5lHyRZyxc1tUOgpYYKLtQnT/AB6px03u2NpPrktfeEiqT/Lp8XptQXc7Sqoc0Nf7Dxj9wjA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW5PR10MB5667.namprd10.prod.outlook.com (2603:10b6:303:19c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.7; Fri, 24 Feb
 2023 03:59:10 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6156.007; Fri, 24 Feb 2023
 03:59:10 +0000
Message-ID: <c8dfba01-a78d-b450-3452-931dce4305f1@oracle.com>
Date:   Fri, 24 Feb 2023 11:59:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] btrfs: ioctl: allow dev info ioctl to return fsid of a
 device
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <c3e2ff2f10b0da711a619745495bb8e8c80c1ad0.1676116309.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <c3e2ff2f10b0da711a619745495bb8e8c80c1ad0.1676116309.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW5PR10MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: 068d4287-2f77-45bd-516b-08db161b7bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 00Ke+kS/2Yi31CQ4qk18dHjOhBQr9n5jMi5luuck0Kvb3whZDLqPwMQx++OuRSQJ/IsIuEHgmK4nhsccjQOE+4g5DkHyq4LlyROjitI38KRv5GYu2f3vKHiIoE74/gT3TB/P2o1nl6YGqwPAhHn5u8HYLlo13ec4bUWd9fSu7R326/7nBL9E63hebClAm3Mwa+D6F91sJZaJiD0ggOsu47qgCemMpgNWBD7iP5spJ6Ok9o01Iq7iZrdobQsWdo2euFiYPoApgB0hN+R72qHi0ReDSbCZjfAiCAa4MjAoiOpHGlVMb+OVRG90Rt6E24tQn3H/XsT2ScAqFjM8icQzEhMBlUPvw385eGk7EoiGpGeNtXPeZP6s+DbnFkO4ddQV2P3fcDg9US3H7rg4wejxLlj2vdU/o1zTl3YgZQ60+SP30DQvsVXzaJnodd49oGeYtQhsJFAkQe4wuot8dNR8BRtZfdRp/2bT6abtFRZRuMRPk8rH0fb7xlZvLua8BoXNemlL18LjDQ0Zx0V8Szo85Jzs3Jg7xudOo3j/OK1fJlUR0fnB1JHgPZ/xpE1aWkmzSDsJ1C66F5cF/5ujdiHo+OTlBJQl3Wth5VjN7O6ktQ8/ordVdUZ6yB2TvhVk1yNYhi+SOmuEuYd0y4tTYK7mN3k8SeUUBcPbbCNWc+KQvzmP5qt8IxEZIoEHU9jYDkUlH+Tx57LJncEL/xh+KLkH42Iml9uU6hXZR8LVTXXwCUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199018)(2616005)(6486002)(316002)(36756003)(86362001)(31696002)(31686004)(186003)(26005)(66946007)(66556008)(2906002)(44832011)(4744005)(8676002)(66476007)(41300700001)(6506007)(6512007)(478600001)(6666004)(5660300002)(8936002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHBSSGo1WStHbExvc1hpWDJUMCtJczlIeU5abjJkVlpHK1lQUGRCai84VXFI?=
 =?utf-8?B?MTBZV3MvODdsSzl2MitYaGRyQkZxZ3hmK3o2K0loM3pBS3BVWkxOdE1aczB4?=
 =?utf-8?B?WWp4L3VSb21WQ2MzOTlsTDNqTnh0Qk00OGFNQm4vbGhMQWF3ajZVWHNtY1li?=
 =?utf-8?B?QXV2bndGcnhhUlpSWk1QR0NDQzZhTjBOVldrR0puRGt5WkFkOTIwQ1d3S1BH?=
 =?utf-8?B?WFdXOC8rNHRqT1dPUTNtRmZkWVpVaWxBMEhrdWU2eUxvRXozRVBOUXN3TjRu?=
 =?utf-8?B?QU16cGpsd2FkTlphOUV4R1kxNXNGNFJMWWplYm9LZS9TTk14Z3hGejZUSzIw?=
 =?utf-8?B?a2Z6ckFWYWxXbHBveW4vQ0c0em9KbjAwUjFRNHlFWlRaNTZ4bGZHaGtHaERE?=
 =?utf-8?B?OEs2V3g4MVRndUx3cDlzSkJyZkt3K2Y3cVNJQ3F1ZmFvZmdidFdNdFVTZyta?=
 =?utf-8?B?d3ZwT1FHbW9GQU9oamlSU1Y0NlQyaFVXdEg1SCtRNTF4VXNtMTJZVVJRRnJF?=
 =?utf-8?B?clI0SG1MMUxVb1hDalNkNEx4UnVIN1dZTzQ0TGNhNFlxT0lqOSt4VUVkbUNa?=
 =?utf-8?B?L1F0VHNaZHhNSDJTYnVVYUZYODFab3d2YUlUSEtLNE1USER6OXJtUFpsaFZV?=
 =?utf-8?B?MlphVDJEWXJFTzFweEVSZnpmaXR6S3NIbTZ5UTk5aVNqWWw1TjZmZ0xjWlIy?=
 =?utf-8?B?QmkvdWdoQTlFRW5SZUMzb05jTjFUZkNtMnI1UCsvcEY0dGJ6V2Y0b1JER2x0?=
 =?utf-8?B?R1NKQXlXNXRCd2JzZWZZamdRYklwbVV2b0dCdUc0anpMNDlBM1lvc1Ava2RT?=
 =?utf-8?B?azhQUkdBaUxLSEd6RUxRckxxM0hndlNnQTRpTE9CWmo0N254Yng0akJGK1FV?=
 =?utf-8?B?bFJTMnlLaGh0UzBwUHRUWDZHQjZYTEVaNmRjQWIvdkY5aXgvM1pEeVNBZUVr?=
 =?utf-8?B?NVJMRC9UUkdiYVovRkN1QXhVU0xONy9McjJpcHVieFNpclorQW1HODZ6STNp?=
 =?utf-8?B?R2l0VUpHNlVXaThjaCtEK1BBbXU2VXg1N05TMlV4T09GRVBjZTVaMWlLU0xm?=
 =?utf-8?B?Mk9TNlRacGhVOU9KcSt5QW9xNnZiN3ZxdytmczllVmNrS1VxbzlUM00zT0F5?=
 =?utf-8?B?cVZ6UXVpMzNJZkNHaU5ENnBTMk4xYWFDVFN3Z3czeFZqTFZxbGpjVzJFallW?=
 =?utf-8?B?bjdQTndrWUtaQ2RUMlArT0RnYnFJU3F1UFZ4eVFFSERGWGx2K1pyOEZEa3ll?=
 =?utf-8?B?QUkzZ0dJUjlWMjBzc0JkQkJDQ0N6V0gyVGkvMGtvMkJiOXIwNllCOEhTUlhN?=
 =?utf-8?B?NDRSVWNhQnpyRkxrYXdBaFZzckhESU5YcWc2cWl0TXVhWENBWUUyOWoyMmxh?=
 =?utf-8?B?d3M4MUQrMCtkblljTVV6UEE5blZMTmdCVjUyRDFNcUY3NVBpOU1LV2s2di9X?=
 =?utf-8?B?c05Bc211L3V4a0RJNTUyb3hpdWg3cHRjSUFITUJKSXZKVlArdWdvcGo0c1B0?=
 =?utf-8?B?T1dpOFppaGMxcGZkdVRpVE5BRDRLNnV0SHpoUEV1cnlLNlJ2SXJUM2lkL29u?=
 =?utf-8?B?c1hoejErR3pQMDdrR2E5SzZrY2FzZGM3ZXY0WEd5bXN5MGRHdkQ4YzZwdnk0?=
 =?utf-8?B?T2wwME4yRmsyUDJuM2NRTkMxSjl3bnRuUEV4Q21MclVQeFBwaUF5b3BHcnBm?=
 =?utf-8?B?U0k3WGNObkcvUlpXOUY5UDQzQStSV2JmSGtnRUpma2NUa3hYUEIwYzh6Q1NV?=
 =?utf-8?B?clFRL2MwNEFjamR1Y3RwamtRWWlFTkg2bnJpbFNVVktvVm93SGM3TlluTm1Y?=
 =?utf-8?B?QysrWHNrcTJLcUJoVjI4bmNZSThQTHpmZTJkSW9sY0NoSkVrYjBIRG9XSVd1?=
 =?utf-8?B?Q2xsRU9yVWFPNDBKR0srK29qUW0yN3gxWWRhSXNLNGg1QU1ZNGY5UW9zSVhD?=
 =?utf-8?B?YldtZG1sNE8yTkFDYW1kTWp3ckVNcktVeEVHMk1oNVJ4SjV1OXVxUmlYVC82?=
 =?utf-8?B?WXZzVWF4VmZqUEtZdUxOWHhVTXZFb1JsVTh4Z2dJdFhIbGVuTDk3WXpQajRT?=
 =?utf-8?B?a3RRTkRTNW9oZzU4eXk3NklXekx0a3dwMTZuSDVXekhGaW00QnJkeEs3Y05O?=
 =?utf-8?Q?GqoEE5mliI7TlD1ui7ZYdGd3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dqDxH0UUBha8+D2RNCQSOFsXxq8cBwBKmCn0Lf4y0uu8LmtezCLTmpM8OQF7bVR5lcM9kFn0mozhldN2R1Rx1GTZCKI5Io0a0CXS3JgeXSnAMGozert947R/mmCT7SUeiBaUp9Idfw1btpG1VnQsY1Zib1LgAEP1jzhO8BmXs2ieM60ZyFJBRgJ0H5QgHYofR1LTqaEPNqXaCaGiG9mVboTEdjVZL0w5Zr4NstEkdLihizcqWyAv1GgktCW+23XER03IZVz9rbo1QeacUNTMCYYiVQBe4+7fDuubTGhp8ONJ12Q4tEYD1lZPy9OVuO3pbakjZ7Jxk+fR3zZLFUL7S6xiflbvb0Q8+MykWFOleh8Q+IKUAJv6FBjfe2CFJ29vftHyK4J8jFmrX/Q1M4jbx63XZkRvFylZyE0/RE3yBYbg8cd3+FwIxXS3yPrZkmevjnA8kWCttfJSGmg/hD13puSOxR5T2jDDFWqbaz72eUxchVc3bqvSKB/AzGEzh7IfCE5v7jf99eKl/1rPq5KEZe8gWFpxYjoUHSCEei9khPIDB6BN9UtIrLxVCHvvbYrg6OJwupvXlk5ZOhoQea1TrvU+t42ffn46m3LFAZ/1SmXDLRVn1r4lq2qzhFsTYjyKMLcEU+k2aw9jiOEbRKEkyE8W+PBzg/jfSboygnRMU20/jF6BUPWHU+uZtAIZg4lemlmfDOz8eWOJpXeFZVWF1NDTDJn4bHqn0wWOiX/Tpz04+mE2HrI5Z+WVcqvZfPONYY0lHlj0bOSQll10PCk5CAyiFqBq6mEd2A9OoTqe/NQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 068d4287-2f77-45bd-516b-08db161b7bcf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 03:59:10.2981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnZXHhyoC38jzep6oDZwLWMRf4eO3bQ0RT/E9fuf2Eby9x8dcrNEpCdH29ykp5leJnPlOP47qcXdFE6iw4qxrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5667
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_15,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302240029
X-Proofpoint-GUID: c3C21Ll-cibTX5XSRrehSdzYKi7O3r2L
X-Proofpoint-ORIG-GUID: c3C21Ll-cibTX5XSRrehSdzYKi7O3r2L
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> Signed-off-by: Qu Wenruo <wqu@suse.com>

I was uncertain whether we needed this patch, as the sysfs already
provides fsid. Nevertheless, it looks good

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Small nit below.


> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index b4f0f9531119..cbb22dbdd108 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -245,7 +245,18 @@ struct btrfs_ioctl_dev_info_args {
>   	__u8 uuid[BTRFS_UUID_SIZE];		/* in/out */
>   	__u64 bytes_used;			/* out */
>   	__u64 total_bytes;			/* out */
> -	__u64 unused[379];			/* pad to 4k */
> +	/*
> +	 * Optional, out.
> +	 *
> +	 * Showing the fsid of the device, allowing user space
> +	 * to check if this device is a seed one.
> +	 *
> +	 * Introduced in v6.4, thus user space still needs to

                          ^ v6.3
It looks like this will go into v6.3, so it should be fixed while merging.

