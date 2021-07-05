Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EC93BBAC3
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 12:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhGEKH1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jul 2021 06:07:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44256 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230421AbhGEKH0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Jul 2021 06:07:26 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 165A2fn0022137;
        Mon, 5 Jul 2021 10:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=EDM4+gWU9VEKz93bqtwhk4y16dimGjkDajGV6elZSdY=;
 b=nSi9uhtZ/lGAvgElA3VPBu3m/V32o2QHGaYbvkuZqFUGEh+JlkFO3UjcRcynLdBUWZKS
 zLCqWULscNE5siFVrlFkWXLrP8ikZ2xr6ftQ7e1c8QSbKppVZLEj8fr8G8IevKcnDOgK
 Beoby9E1HbEp2k+USILg6Fsm8mo7ie981kusakOZQUdl8bQmJjlMTQRUYDGR/mtcbw46
 oGBUqF3//xZA699i2lEZTed4S3QDZJ43uLLpqhdyifGLcLQwi+8lMq5s/dCfHvFwDC7X
 ega4jPI/2JSEEkPgys+1aHTiaFMIYSlNX8KsLJ+GY+YGCSMEGlW4aZFXU/+sxsKJJQp9 Ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39jep1jatm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 10:04:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 165A00Kw161991;
        Mon, 5 Jul 2021 10:04:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3030.oracle.com with ESMTP id 39jd0y6sjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 10:04:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZXGM5l4GCd/1HSXDFXvzApPt7WbzIQdgIH3xECPycHgMzdWnhsP0KLXrNpdrQeGuDzgMBFLfGFVrl1OZeyFACsStnCf3Lj476fJakVTOrlki4nCnZJw4sC4E/2MC/Kw1YuuqAPO0p0y/OLHhIrjvMfO34bei1KC86KgJG6i7a2oTv0Fwt2XtPi66QxEPqcWBApUwncWg7jp2Xos/wMKMzFwxYpZAWX8zM3fJIKSc1RK+kir9ytHI7gXtCBFFruJEWoZlwNVFXIPo1fKlFk47YnmkdbsFrOdpzdRNrQZUvt8d5BZZ4bTtxGZjzO03ou18bvg9X/0rE+B39dK5BbVNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDM4+gWU9VEKz93bqtwhk4y16dimGjkDajGV6elZSdY=;
 b=CL8I6JmN2+A2kH0ihTbPD+wBgo8XaSQEc7Xa2ONExI3WxoZJ1d9afQCajAgDml9MqBHPNnMY5PmxpxSI6xD7YQ/F4GhS+QKEL1xnCDQnLMKK/jPbwVDH+DSJr3EDROhttI9q1p4NS5LeaMmjeZd654ACS6IvUVUQDwTYOqE1qc19lef48k56Ya46FQvWPwgODgXJOGxWw97FNwFnt2kjJdNkAqliNFDlx1mV/Sq/FxEXMqEuKnHNvyIOu0qU5ztZvgl6uDubvulXUGHNjCtqpJK+da9f1ylUnJr/2hfXqfPQC98FJksrrG4hht6wRQwGrFY5IQXthDkZvgXdu2apiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDM4+gWU9VEKz93bqtwhk4y16dimGjkDajGV6elZSdY=;
 b=qyS0NzKBK/HunqgNraRp8I0HPuolnXZ2YkoCmQSchSLI50SZMidzN/GNTLcWhZV/a2JkoH2YEhQoPuLKqMLhNUYYnRr2YngapN0T6/EEKAgr70rZmA8QNpel0O1Hf78pIl4pJVw0vN9NjVgr0uAnKd6uh6hR9fIs1Rs0qlBNl94=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4980.namprd10.prod.outlook.com (2603:10b6:208:334::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Mon, 5 Jul
 2021 10:04:45 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 10:04:45 +0000
Subject: Re: [PATCH] btrfs/242: test case to fstrim on a degraded filesystem
To:     fdmanana@gmail.com
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <a70c9f6b4e45d9bcdc5c2f19182f89ef8e22c074.1625237782.git.anand.jain@oracle.com>
 <CAL3q7H5xdS5EXCN2QP0DXQr1_uxCGqK719J5c0EBFH28hYKj+A@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <fdb77ace-94e1-7be0-17d4-db6f6830adf7@oracle.com>
Date:   Mon, 5 Jul 2021 18:04:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CAL3q7H5xdS5EXCN2QP0DXQr1_uxCGqK719J5c0EBFH28hYKj+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR06CA0182.apcprd06.prod.outlook.com (2603:1096:4:1::14)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR06CA0182.apcprd06.prod.outlook.com (2603:1096:4:1::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Mon, 5 Jul 2021 10:04:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55848623-f670-4419-3b26-08d93f9c5065
X-MS-TrafficTypeDiagnostic: BLAPR10MB4980:
X-Microsoft-Antispam-PRVS: <BLAPR10MB498099F60F17FB61955DB502E51C9@BLAPR10MB4980.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GK6Zqbt1+1t6uDsrvG0uM64uCGOAeni6YHMB6ZEuwzHo9MSCaZH8qxShFqUVWDH8zh9mCD7PiIsKFcz/LnKbJYHa8OzT+ZVrEBdvmk+PNNOQMhZ+m9A8fXKpejxiKv88bQCMthIuCF6jgl2afGHN7mA+ekjP8uZ6WaT6JzMwOM03xBkspuHXoq8nekiRJgZ6DZv31FxiT29ajPsH12GsiWUkYHIKssIU9MowThLsnCx/lMHorkk6nZkr5MFgVxwDvtcEwxz3s+grfI5cPv0vlJ/DYl17YukOSaEYdb4ByaoY7+nxy13qs+5zQWpzCWlURZqqmpCkCryETA3mWzc99aacS+W7jes4BIWhUadsmf83fnDqOFg2KaaIP/LR2FnywKsOeUeXllygGoZ7zF5q5MCBamonMcPXgxAZUAehGDMdktqWfJzwRLAp1FzMbFVNBvqWko/xOLDWQIgou6PO5sFcBPVoZeYI4n1gEGunW96PFT9+FE47t22Iyp/wYUgF9H0pF+m1lkdem43LBcEhp7mGVArkSox87K0I1XAM0TLwlsuJdsqC4Ivy0d9ytBrTSe5d9jAV/I+8BhvsAyCfaJqwACyvKOH5FFaW9Cqn9VpWh4+Yn6+DpjkUxfCRY8wR4De7bjjiLpY/7/ynHg1KoYImHxrWPqMTd6VU/4FNJXGc00raqZ0ReOgD8KMVVFsXyZgDg0kaMIPzA8gatXsCpSqDL6eSgfKyKXmd13N8qtk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(376002)(136003)(366004)(478600001)(2906002)(16526019)(53546011)(86362001)(316002)(38100700002)(36756003)(31696002)(31686004)(5660300002)(66946007)(26005)(66476007)(4326008)(8676002)(66556008)(16576012)(8936002)(6486002)(956004)(6916009)(54906003)(186003)(6666004)(2616005)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K25MamhFMW5HQXpBMThoRndwR2Q4MUhWVlNVTlA4bEduR29BL3FlUXNObW51?=
 =?utf-8?B?ZFBzMXQxaWE5Z05Yajlya1l2bFM1Z1JzcDVtcC9uVFJjaTB5WFFBWS9CNkdU?=
 =?utf-8?B?aU1mTldSWHZQclVxVHoxdHhHOENZeXZIa0NHR2lyZFdoRDJzbTdFek5wTVBW?=
 =?utf-8?B?aTBwc3dHbzhwb1JTbU4vTkJIM0djSldzaXpGZ2lCWkt0TXgxS0dpbW1VY0hD?=
 =?utf-8?B?cEt6Q0ZObExVQnRmZWZab0VnM0JxdTR0U3BlbG1kaVpWck5zcDFTeGlFN2RW?=
 =?utf-8?B?L3VUNEhvUFhGOXNuUFFuR1dyV1dpTCtQODZzekx2U0J6UW9qbndrbEIzVWU2?=
 =?utf-8?B?WXU0SkJZWHpvcDB2YStqdklVT0tLTnBHcnE5bGlCMEppY2dZRklKVWFzc0tQ?=
 =?utf-8?B?SEhpN3dabUx6bEN6VmVqTUh1QlRnUXkrbTZveFRUL2VISlJjOEtwdjdFQlo5?=
 =?utf-8?B?aGo4RzRVTGt1QTJKUjF0Nk9La0NicmJhRkVyTHA4MXhtL055T2lLd292dVdI?=
 =?utf-8?B?Q1AyN2s1SVhhcGtxejVMaUVyYUV3TDMyQi9SZ2V6Y2o5cElWQ2kwdWNFaFJH?=
 =?utf-8?B?MDEzTkhLUGJkdWNDRGZzMjNmNU1XYWYxTUNlbUJuZU1LMmIyb1hRckFlZUpZ?=
 =?utf-8?B?QmdNUERJcnhiRHBUb2g2OXlReURsSmlBYWk0ZFY1ZlFuekdaUU9OWVRqMzF3?=
 =?utf-8?B?VDlVM09id1lmcFkxUWNnZXN6Q2JLMC9ZWHhFZ05GSlpXMmIxZTRPRlhsaFB1?=
 =?utf-8?B?djUyKzV3S0V3cnhwZU1WdHoxWUpWN0FiMHpjdTNLVEdiN1I0cmdDK3MvVXNF?=
 =?utf-8?B?aC91TERnZFNwMDVUZmNLcWYvNVdFQkFnV1Ayc1lXUTQxbnoxSWxzT2srNkRs?=
 =?utf-8?B?cDU4NEF6NWtWbWxTbzN2aGRkU2Y4akt4dk9PbTJOdytUdDhVWXJPSWpmY2pV?=
 =?utf-8?B?ODhKc0duZHVzTVdZakFmdzRFVzA5cVBIa25lZm5PTWZkYjdhclJxbUtFR2JL?=
 =?utf-8?B?VHBCeGVmcVR1WHhjd3lHTG5yMXlDY0gyQURLNlQvcGkySkNHWk9ac29EQzY5?=
 =?utf-8?B?TnlpNE1YaDgvNTBRczJnVXd0ODBXWUZ4c3lvL3pJYjlnU3BGMGhEYU9SaGI2?=
 =?utf-8?B?WUU1UzhodjhGL25zOUpvMWhnL3JaRkxnSXhaQ1YrZFdhZkJSKzlkVlF5ZzJo?=
 =?utf-8?B?MDNQRGx5Z05LUTNPbmZpYlgyVUNvQi9mOEZDNWpob3hRZkNBcmJ3VmRwQ3Vp?=
 =?utf-8?B?NEtMYVg2WUxUSkYxVFVDeGV6ZlFGcTlrLzYyV0duQ2EyZWJwOXZzSDZKVHFC?=
 =?utf-8?B?ZXg2RzVvMms1V09RazdiN0hmU21rRWo0VU53eENyelVZQXdFODhjUnVjeldQ?=
 =?utf-8?B?RFVmcVk2eGJCUWk5K1RSWDBsekM5bUduSGpWRzVjVUkzZzJ3d3pRb2dEWDNt?=
 =?utf-8?B?WlMzSUZoVDBIUG9zUmpGZzJ4VUtoRzRFb1lJaitNWHVsS1hIQk9WRGdEZTdD?=
 =?utf-8?B?N3hzVnhxeDVDb2xYczEwK3A1dGVYbFZzRVkweUErd3FUQXU4b1VYeWJhekYv?=
 =?utf-8?B?ODR1aWVMb2xDTmZmMmw2R3QvLzBWVkd4VUxodVFaNGQzMEdlVDl6U3RMZW5H?=
 =?utf-8?B?UW9YdEdGWUd6OXJVYXJEb01CY2lHMnJyNUVqa1lrVEkyRHRBRGl4YzlsNjhj?=
 =?utf-8?B?V1U4SUhGYUFLV0dQWGp5QUhSK2w1dmtXb2dycWpuQ0FBdWZmZEZ1dVJQRTlX?=
 =?utf-8?Q?KDdh60C0TuKQgm41qaYWKNygKBUlmj2GnmQf2Go?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55848623-f670-4419-3b26-08d93f9c5065
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 10:04:44.7966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRkST4TmI4JOaeass8AhSvLTeJ44bhVlhcrDfM7PwAMTGu6tyd0r5cx1fBrbBzlWleW7DtIi+NbgCv5FZZbgZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4980
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10035 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107050053
X-Proofpoint-GUID: SMG8NcNw5npguj7ea0BSb5o3bXAmSRqt
X-Proofpoint-ORIG-GUID: SMG8NcNw5npguj7ea0BSb5o3bXAmSRqt
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/07/2021 16:50, Filipe Manana wrote:
> On Sun, Jul 4, 2021 at 12:24 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> Create a degraded btrfs filesystem and run fstrim on it.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   tests/btrfs/242     | 49 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/242.out |  2 ++
>>   2 files changed, 51 insertions(+)
>>   create mode 100755 tests/btrfs/242
>>   create mode 100644 tests/btrfs/242.out
>>
>> diff --git a/tests/btrfs/242 b/tests/btrfs/242
>> new file mode 100755
>> index 000000000000..e946ee6ac7c2
>> --- /dev/null
>> +++ b/tests/btrfs/242
>> @@ -0,0 +1,49 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2021 Oracle. All Rights Reserved.
>> +#
>> +# FS QA Test 242
>> +#
>> +# Test that fstrim can run on the degraded filesystem
>> +#   Kernel requires fix for the null pointer deref in btrfs_trim_fs()
>> +#     [patch] btrfs: check for missing device in btrfs_trim_fs
>> +
>> +
>> +. ./common/preamble
>> +_begin_fstest auto quick replace trim
> 
> Also, this does not belong to the 'replace' group (again copied from
> btrfs/223 it seems).

  Oh no. Will fix it. Thanks.

- Anand

> 
> Thanks.
> 
>> +
>> +# Import common functions.
>> +. ./common/filter
>> +
>> +# real QA test starts here
>> +_supported_fs btrfs
>> +_require_btrfs_forget_or_module_loadable
>> +_require_scratch_dev_pool 2
>> +#_require_command "$WIPEFS_PROG" wipefs
>> +
>> +_scratch_dev_pool_get 2
>> +dev1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{ print $1 }')
>> +
>> +_scratch_pool_mkfs "-m raid1 -d raid1"
>> +_scratch_mount
>> +_require_batched_discard $SCRATCH_MNT
>> +
>> +# Add a test file with some data.
>> +$XFS_IO_PROG -f -c "pwrite -S 0xab 0 10M" $SCRATCH_MNT/foo > /dev/null
>> +
>> +# Unmount the filesystem.
>> +_scratch_unmount
>> +
>> +# Mount the filesystem in degraded mode
>> +_btrfs_forget_or_module_reload
>> +_mount -o degraded $dev1 $SCRATCH_MNT
>> +
>> +# Run fstrim
>> +$FSTRIM_PROG $SCRATCH_MNT
>> +
>> +_scratch_dev_pool_put
>> +
>> +echo Silence is golden
>> +
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/242.out b/tests/btrfs/242.out
>> new file mode 100644
>> index 000000000000..a46d77702f23
>> --- /dev/null
>> +++ b/tests/btrfs/242.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 242
>> +Silence is golden
>> --
>> 2.27.0
>>
> 
> 

