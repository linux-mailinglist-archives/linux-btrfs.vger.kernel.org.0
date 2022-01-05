Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7391484D0B
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 05:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbiAEETj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 23:19:39 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:15216 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230332AbiAEETi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Jan 2022 23:19:38 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204NiCgc021535;
        Wed, 5 Jan 2022 04:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=iZZeGgjFopBuXJaw378DBxdFMb4+qTBtW5oTql7iXvw=;
 b=cXE03c6zDLhi6V210K4CaDaL9Roe33mWIn9loVBApLSyEwuJZhi13W+CO+Cxbv8CsMyU
 iGE8877onb0r/loxx4JWhPhjuWlTutD2qAO3/iCv0kxRYV+TL110ZJsGjlluIhLAzZkp
 8W2OgnHh82de/KRw4l5pF8GnpyqijnHCBTh8L3DPggLHK+2IxjyxphMFP3PmdjCSiR/5
 cimw0jxn8WW5TZ+gKs3FPbI1dPojNcB8LF4W5+LlyJsSguj3IGAkKCFx6lCQQiqUHUVj
 Jg8ReKxw8Cv/dKEDSJwMYgwBUMo7feokTTwknaBesn5wwx9UqGrCGOnAA+1Zxw8Fdoc2 Aw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc40fkt5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 04:19:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2054G6jq022232;
        Wed, 5 Jan 2022 04:19:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by aserp3030.oracle.com with ESMTP id 3dad0edab9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 04:19:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y19+RUwDeWX4em6WcMJkFEE5utn31rcFxJiuAR5rljOiJWT6s+6vpVPZ0DVoWXBA0TlXkUuPM07v0zSlEJk/M9M3sc/YYmAzWJAeLFqlAgGTIpG8xSgqAyP7t1CKIMG8sLB2+YgN/CW4RhpD5tEFsirLjjfpzgcz9pD/spxrRSUsxenzNDpszHBCLuLtZa1+xSqmzVascGl+sYvDNGzBYOdeZFEHX+j+xDAnBdeIBXvWpDUAoZ0eUiXRFyZJc8m2Z0Adb2Upq88hw9J2dFqw8niWDcn52JL/Eb/jZIjNPFvJ+cUI7BT8tXN2AG6p2qhkO20afRtLFuP+5Sonj8yh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZZeGgjFopBuXJaw378DBxdFMb4+qTBtW5oTql7iXvw=;
 b=Om3L5SZ7p4HoLxGz1lIlI+2tsJaqXXh6pSzNEu55rT1rvz0EJ87W5lI4yzGP1m/Kau+NMZ1Gttivx+sk4ZOwKH734ir5gsVwGkH8ZPVAc1ErfUEQZRsRoQfNGTSayLUkWwkKx/D/BhNUly9RKuKXxneSqYc8YQTyVa/2iSXwb1hT6MnoHtJMKS59HGEDvAFi39+jWmUo+4d5kfT+C7C7j3Xr2w+dLjyV0Owp0Qvwl1F/8sKk4QeAZdvRaiR8hWFcf9Iq4i0703ktEnuZNy00VK6Pj26S9no/vonesJh2ObrrS8Hx4MCUhlhFtZW6imhETclQ1Rkxl86YwPucsSLBEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZZeGgjFopBuXJaw378DBxdFMb4+qTBtW5oTql7iXvw=;
 b=K7HCq/7PRva6dpvWrurhCpkZogndi+SXnlmPMo1eQM1EX4bCKMN9kPH/dJNzSqbek4GFa8/fbDjckMWYP8W9zNppdZ1BkLgdGQ8Q3Ytd+sbNw+wtSEsjqeNkeV4gO65YXmzTK2FTIcPKV1r5x4rgGs+fmI4pbVukDS7vnQkiYWY=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5137.namprd10.prod.outlook.com (2603:10b6:208:306::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 04:19:31 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 04:19:31 +0000
Message-ID: <d7d823c3-30ce-e6ff-7599-1f404a82d4ff@oracle.com>
Date:   Wed, 5 Jan 2022 12:19:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2] btrfs/254: test cleaning up of the stale device
Content-Language: en-US
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        josef@toxicpanda.com
References: <61c0bd3a345d8cb64f1117da58c63c2cd08a8a2c.1639156699.git.anand.jain@oracle.com>
 <Yb87dkizAxoqC+1c@desktop> <6a78d167-3f7c-1f9e-49d4-399203c52232@oracle.com>
 <765bf2fb-8af0-9459-b759-7a8d39d872c5@oracle.com> <YdRvu1guqLdmm4/5@desktop>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <YdRvu1guqLdmm4/5@desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d05e396f-e3d9-4eff-8ffd-08d9d0029217
X-MS-TrafficTypeDiagnostic: BLAPR10MB5137:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB51374A6D92758EB7D2B01EF3E54B9@BLAPR10MB5137.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BASeloGEW/XDYmzAazgHtPlQLM4SXPXo3K5giM9wGxtrt5QKx0aXdPZ70uf5arkw1ik6ycVN3QhRziZwG44kFL2qFjBLT6bRIvulemgueLClg2B5OwMWCcv6uqKrg0UE5ZvMMK9YEoiIQ3ybMrXEN0zIQfYzkKQJBBUzCZYcp61EsGb/3EZ+dcHUwKppQEl5VaE4ifYFIr2X4yWQqxICp4ZOgQAenX0BmX9pdKTIhcfzVBnolbpM4ztxeQlAVogWw0RYl1LWGbPfvJ8HZ3OX/I3i+IcnF3OHjIJwTLqU5wmtWeeBVQmnyntTHz8Bldmc9uN42QXy44DT6Evdz82/BpliZmFnGuiBjjYuSseHZHk8aCyDmYg33eKssQZFuYOhrqUeEncmo8FgJMkbYC/UrcmHVAOS/qMB2rQn7GvkOOXPi5V9k5ZKxlw4tdaPxrMUQ+DzVGYEQNhLivoDNTMHmEXR3vIZhBag9G1Tnbfx0iQK9iiDK3ZTwuNsQPs6tjXs3otkMfEJaoZ2wzsWOnlwVd85IfKKi3fffHvvqLsSZHCFxa5FNQqZIzPfnRyAxJdBBHP/Xsy9CyA0cfPpT1VoNCGYAzAz5BrwqEftH+Oa52Do+FpyDdCqslGi1HBf05eqWgLy71FKbArR5sXK4e+ZMrCbbDvR812ER0gXEDM5H2R0BjfDcdzky4tcq1ovyId739CD1UnjSyxP9ODvbP8CC+28fIsdJQkT6PHDah2SsALJQX/e8QydT7JcgJGf1Iy6ihgd6on5mXG0zGgmwEojid9ILFY8w/2o3HeJ8sZeerYh0K4j7svADhKXMrINHJkV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(186003)(6916009)(6512007)(5660300002)(83380400001)(31686004)(8936002)(44832011)(8676002)(2616005)(31696002)(36756003)(6486002)(86362001)(2906002)(6506007)(4326008)(6666004)(966005)(66476007)(38100700002)(66946007)(53546011)(66556008)(316002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUI5ZXh6VVQ3V1FEbHpGd1JFT1k2OWhQZG5nUHZ1eXRCY1ZFYmJFTVh1cTg4?=
 =?utf-8?B?UldNdTNEdnNOem42LzhHVkcyQnNmN0ZmOFRxTE9QelFLdG4vSlZ4bFZHcStx?=
 =?utf-8?B?VGJrRVVwM1ZyMTNiMEYxQW5iU0NCS1JSZEpCcHJhTGxsV1ZTamdYRE0wSS9D?=
 =?utf-8?B?ajN3T3k2Vko4b0VHNXZCNVh4enV1T2lWckNhdDM1d1IyUWNTcy9RNWt4U0sv?=
 =?utf-8?B?dWFaeVAxby9XS1cwbm1OZEFCMllVS3VqYlVlTnVDbG1JYzZtL1JUMGNoajJS?=
 =?utf-8?B?a1dQVmp2TExJbFdESDRxRlBBY2Z2NEpDUkFYYnhVMTdPbXVzQmpyRFJ5dS9h?=
 =?utf-8?B?MmVESHRwRDlxR0dCelpCN2lkUmI1WkIybGVrQXcxa252N1pQTDZNc1k3OFJr?=
 =?utf-8?B?ejR3a3pWZ3R4VnF1QnR6Yy9hS1VOWER0cFBXeXZpV1B1b2RlSkdxdjF3K1Y3?=
 =?utf-8?B?N0F3RERzL01mbThqeUt4RUo4VzdSSGRza3hDeWllaXg2SjZaVHRZVFd0ZllV?=
 =?utf-8?B?L0xQS3FXNmsvbk9pY29CZXJiOEVtZzNMSmRCUlIwTGRjeHlBeFRWbUtRU3Nr?=
 =?utf-8?B?eEtUdW82UjArSDcrSGJORmNURGpUWXk4ZWFEUzBjWUZJN3QzVS9udFdXYlky?=
 =?utf-8?B?dzhwQU12Z0R6ZjRqY01NdmRrby9PbzRWUzQ5Y1VxOVQ2UlpUaUJFaWNHZE4z?=
 =?utf-8?B?a255UGw0VnJNU1haQUcvTDZXcEY2UTR0Ry9yUyt2anNCaWtxVW93SE5jRGF3?=
 =?utf-8?B?UFM5RHV2djl2VWNIYWFuREEvaTAyeFRUazlmdXlaM0ZSVlhXZWRTdDZ5YnZO?=
 =?utf-8?B?THNMcUR4Rm95UmpKNi9FYUprTEZQbWVPQWM3R1pOYXoyOTZEWEFGNjZKU1h1?=
 =?utf-8?B?TjFhRHgrN0FCZTZGdW8wS3h6aDdGWFppeDJXR0V5SUU3cjN4UVI0ME5yL3VK?=
 =?utf-8?B?YkNNRG54bGxzbWZ5aGVGaFBRYm1VMm5HRGl3WTllUjJOSXdvQ2RNK2hsUG9K?=
 =?utf-8?B?R1NNZ2RiU0xXWnczNVU5YVFIOGkzeitsZnl6NCtuS00vY1ZxdW5HeXphWUFx?=
 =?utf-8?B?MnpkaFdDWllzNnpta05sY056ZVVFUVpWMU1qT1VyRm56dVlvallNSmRRV0ha?=
 =?utf-8?B?VnAzd3pjV1NKK05ESjJuVWRJWDFiNTdrRVFKOWFZbENKaTdVSUs3Qms0SUFJ?=
 =?utf-8?B?V0o1VkI1cWFqcnFCVzJhM0xiTnRHOTVCV0xuY3lTempWU2pqNTBTSnFEQ0g1?=
 =?utf-8?B?WUp1VE10aElDSlJBeGhBZnowUmtad2V6OUVGT3Z5SkhMZGt0Rk12QnBhc005?=
 =?utf-8?B?Z1RyZXoxa0ZUNmFQN0p1ajY0MmkrdkRKSHhlUEZEckJLM0p1V1RvUzdzMHRU?=
 =?utf-8?B?TG8yZDhsR0FuZnNYYmRpWVREZVFxK0JCMlpKNHlyaXdmTnlacUtmZ2tvbmFI?=
 =?utf-8?B?WENTWGtpQnZqc3hsS09ESmlpdlRzY0djeVpUa1RnNGdGR1ppNEJSYm1NczVl?=
 =?utf-8?B?OEZ6NkJSYVVyTERRSWZpQW5OUno0dnM0OXVPalFOaWZuclVja05CQUJaWm9y?=
 =?utf-8?B?YUVDblRybC9TNEJtclFubmNOcDBURGIvUWRQN3FRajVzVUFDMWZ2YjUrT1R2?=
 =?utf-8?B?U1FzeVJ2eERwVjd0NVFwRzBCN3pYZndpV0o3cmpTYlNjRjRuSENGS2dSWEM1?=
 =?utf-8?B?M0duaVJzbnJvelZXK2dsUEdtM040ZnBDQXdkTVdiNnpNR3ZVSWRzOHlFYk9i?=
 =?utf-8?B?aXpjYnFaek9aU25iZlU1Q1RkYU96cm9zaHcxMWxncnlJWjNYUWhMMGJqUk1F?=
 =?utf-8?B?Zk9nckVrUWMrQWtWY0dpVkNOZEhwVS9NNFFTU1ZhUDhyeXNUeHArSjJINmVq?=
 =?utf-8?B?ckgwNGpCdGVFbTljTmdxcmJmY0RyMXFVU3dUVmRjVVk0UTlyYm5VcS9ra0gr?=
 =?utf-8?B?VEtvRWRZeUJlL3BSaFAySVFQQkh4ZmI4c3liWGFJQTh0Qk9LQU1ENXozSXpI?=
 =?utf-8?B?YlBFdlRCSmJIa0IxTTgySUxBcElKMGs2U2o0WnM3Z0hkTGdGQXczWFhqOFRI?=
 =?utf-8?B?VzZDK0NXWFg2U2c5dTBtQW9aMTdCRHRzenEzU3VTemJuOFYveE8wVE9JMlJJ?=
 =?utf-8?B?M1daMFQ5dTROaEJmc0J5YlVFb0JxQXMrSW1qQjNDN2t0R0Q2V3FqZENaYTZE?=
 =?utf-8?Q?QuVaqvwoilyqseLZamV6Y+c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05e396f-e3d9-4eff-8ffd-08d9d0029217
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 04:19:31.4489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzf2Kj4QVqR1GF0VjQjTVtvcVStjzBYCiQWZQ3iAf/Gk/Bx5pBUtxdMIJi2XZSQJhlwZOyFF/HhRdm/wX2T/VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5137
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10217 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201050027
X-Proofpoint-ORIG-GUID: Vhub9aB-7jBzUIGdXpiS0R6AloWL5CJb
X-Proofpoint-GUID: Vhub9aB-7jBzUIGdXpiS0R6AloWL5CJb
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 05/01/2022 00:03, Eryu Guan wrote:
> On Tue, Jan 04, 2022 at 07:25:20PM +0800, Anand Jain wrote:
>>
>> Gentle ping? More below.
> 
> It's already been merged in last update.

  Ah.  I forgot to refresh my ws. Thanks.

>> On 20/12/2021 19:06, Anand Jain wrote:
>>>
>>>
>>> On 19/12/2021 22:02, Eryu Guan wrote:
>>>> On Sat, Dec 11, 2021 at 02:14:41AM +0800, Anand Jain wrote:
>>>>> Recreating a new filesystem or adding a device to a mounted the
>>>>> filesystem
>>>>> should remove the device entries under its previous fsid even when
>>>>> confused with different device paths to the same device.
>>>>>
>>>>> Fixed by the kernel patch (in the ml):
>>>>>     btrfs: harden identification of the stale device
>>>>>
>>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>>
>>>> I was testing with v5.16-rc2 kernel, which should not contain the kernel
>>>> fix, but test still passed for me, I was testing with three loop devices
>>>> as SCRATCH_DEV_POOL, and all default mkfs & mount options
>>>>
>>>> SECTION       -- btrfs
>>>> RECREATING    -- btrfs on /dev/mapper/testvg-lv1
>>>> FSTYP         -- btrfs
>>>> PLATFORM      -- Linux/x86_64 fedoravm 5.16.0-rc2 #22 SMP PREEMPT
>>>> Mon Nov 29 00:54:26 CST 2021
>>>> MKFS_OPTIONS  -- /dev/loop0
>>>> MOUNT_OPTIONS -- /dev/loop0 /mnt/scratch
>>>> btrfs/254 5s ...  5s
>>>> Ran: btrfs/254
>>>> Passed all 1 tests
>>>>
>>>> Anything wrong with my setup?
>>>>
>>>> And if tested with lv devices as SCRATCH_DEV_POOL
>>>>
>>>> SCRATCH_DEV_POOL="/dev/mapper/testvg-lv2 /dev/mapper/testvg-lv3
>>>> /dev/mapper/testvg-lv4 /dev/mapper/testvg-lv5
>>>> /dev/mapper/testvg-lv6"
>>>>
>>>> I got the following test failure
>>>>
>>>>    QA output created by 254
>>>> +ERROR: cannot unregister device '/dev/mapper/254-test': No such
>>>> file or directory
>>>>    Label: none  uuid: <UUID>
>>>>           Total devices <NUM> FS bytes used <SIZE>
>>>>           devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>>>>
>>>> Maybe we should use _require_scratch_nolvm as well?
>>>>
>>>
>>
>>> The test case is inconsistent because the systemd-udev block device scan
>>> interferes with the test script. There is no way to disable the
>>> systemd-udev scan (that I could find).
>>>
>>> The same inconsistency (due to race with systemd-udev scan) would
>>> persist with/without lvm.
>>>
>>> So when the race fails, the test case is successful to reproduce the
>>> issue. As you saw in the 2nd iteration.
>>
>>
>> There isn't any approach to stop the test case from racing with the device
>> scan, so reproducing the issue is inconsistent. As we have had some success
>> so IMO this test case can still integrate, it will help to verify the kernel
> 
> Agreed.
> 
>> fix on some systems.
>>
>> More below.
>>
>>>
>>> Any suggestions?
>>>
>>> Thanks, Anand
>>>
>>>
>>>>> ---
>>>>> v2: Add kernel patch title in the test case
>>>>>       Redirect device add output to /dev/null (avoids tirm message)
>>>>>       Use the lv path for mkfs and the dm path for the device add
>>>>>        so that now path used in udev scan should match with what
>>>>>        we already have in the kernel memory.
>>>>>
>>>>> -       _mkfs_dev $uuid -draid1 -mraid1 $dmdev $scratch_dev2
>>>>> +       _mkfs_dev $uuid -draid1 -mraid1 $lvdev $scratch_dev2
>>>>>           # Add device should free the device under $uuid in the kernel.
>>>>> -       $BTRFS_UTIL_PROG device add -f $lvdev $seq_mnt > /dev/null 2>&1
>>>>> +       $BTRFS_UTIL_PROG device add -f $dmdev $seq_mnt > /dev/null 2>&1
>>>>>
>>>>>
>>>>>    tests/btrfs/254     | 113 ++++++++++++++++++++++++++++++++++++++++++++
>>>>>    tests/btrfs/254.out |   6 +++
>>>>>    2 files changed, 119 insertions(+)
>>>>>    create mode 100755 tests/btrfs/254
>>>>>    create mode 100644 tests/btrfs/254.out
>>>>>
>>>>> diff --git a/tests/btrfs/254 b/tests/btrfs/254
>>>>> new file mode 100755
>>>>> index 000000000000..b70b9d165897
>>>>> --- /dev/null
>>>>> +++ b/tests/btrfs/254
>>>>> @@ -0,0 +1,113 @@
>>>>> +#! /bin/bash
>>>>> +# SPDX-License-Identifier: GPL-2.0
>>>>> +# Copyright (c) 2021 Anand Jain. All Rights Reserved.
>>>>> +# Copyright (c) 2021 Oracle. All Rights Reserved.
>>>>> +#
>>>>> +# FS QA Test No. 254
>>>>> +#
>>>>> +# Test if the kernel can free the stale device entries.
>>>>> +#
>>>>> +# Tests bug fixed by the kernel patch:
>>>>> +#    btrfs: harden identification of the stale device
>>>>> +#
>>>>> +. ./common/preamble
>>>>> +_begin_fstest auto quick
>>>>> +
>>>>> +# Override the default cleanup function.
>>>>> +node=$seq-test
>>>>> +cleanup_dmdev()
>>>>> +{
>>>>> +    _dmsetup_remove $node
>>>>> +}
>>>>> +
>>>>> +_cleanup()
>>>>> +{
>>>>> +    cd /
>>>>> +    rm -f $tmp.*
>>>>> +    rm -rf $seq_mnt > /dev/null 2>&1
>>>>> +    cleanup_dmdev
>>>>
>>>> Should wipefs in cleanup as well, otherwise test fails with non-unique
>>>> UUID
>>>>
>>>> -Label: none  uuid: <UUID>
>>>> -       Total devices <NUM> FS bytes used <SIZE>
>>>> -       devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>>>> -       *** Some devices missing
>>
>>>> +ERROR: non-unique UUID: 12345678-1234-1234-1234-123456789abc
>>
>>
>>   We don't need non-unique UUID. I have fixed this in v3.
> 
> Then would you please help patch the existing test?

  Yep. I am sending a new patch for that.

> And we should add 'volume' group as well?

  It can be in the volume group, so added.

Thanks, Anand

> Thanks,
> Eryu
> 
>>
>> Thanks,
>> Anand
>>
>>
>>>> +btrfs-progs v5.4
>>>> +See http://btrfs.wiki.kernel.org for more information.
>>>>
>>>> Thanks,
>>>> Eryu
>>>>
>>>>> +}
>>>>> +
>>>>> +# Import common functions.
>>>>> +. ./common/filter
>>>>> +. ./common/filter.btrfs
>>>>> +
>>>>> +# real QA test starts here
>>>>> +_supported_fs btrfs
>>>>> +_require_scratch_dev_pool 3
>>>>> +_require_block_device $SCRATCH_DEV
>>>>> +_require_dm_target linear
>>>>> +_require_btrfs_forget_or_module_loadable
>>>>> +_require_scratch_nocheck
>>>>> +_require_command "$WIPEFS_PROG" wipefs
>>>>> +
>>>>> +_scratch_dev_pool_get 3
>>>>> +
>>>>> +setup_dmdev()
>>>>> +{
>>>>> +    # Some small size.
>>>>> +    size=$((1024 * 1024 * 1024))
>>>>> +    size_in_sector=$((size / 512))
>>>>> +
>>>>> +    table="0 $size_in_sector linear $SCRATCH_DEV 0"
>>>>> +    _dmsetup_create $node --table "$table" || \
>>>>> +        _fail "setup dm device failed"
>>>>> +}
>>>>> +
>>>>> +# Use a known it is much easier to debug.
>>>>> +uuid="--uuid 12345678-1234-1234-1234-123456789abc"
>>>>> +lvdev=/dev/mapper/$node
>>>>> +
>>>>> +seq_mnt=$TEST_DIR/$seq.mnt
>>>>> +mkdir -p $seq_mnt
>>>>> +
>>>>> +test_forget()
>>>>> +{
>>>>> +    setup_dmdev
>>>>> +    dmdev=$(realpath $lvdev)
>>>>> +
>>>>> +    _mkfs_dev $uuid $dmdev
>>>>> +
>>>>> +    # Check if we can un-scan using the mapper device path.
>>>>> +    $BTRFS_UTIL_PROG device scan --forget $lvdev
>>>>> +
>>>>> +    # Cleanup
>>>>> +    $WIPEFS_PROG -a $lvdev > /dev/null 2>&1
>>>>> +    $BTRFS_UTIL_PROG device scan --forget
>>>>> +
>>>>> +    cleanup_dmdev
>>>>> +}
>>>>> +
>>>>> +test_add_device()
>>>>> +{
>>>>> +    setup_dmdev
>>>>> +    dmdev=$(realpath $lvdev)
>>>>> +    scratch_dev2=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
>>>>> +    scratch_dev3=$(echo $SCRATCH_DEV_POOL | awk '{print $3}')
>>>>> +
>>>>> +    _mkfs_dev $scratch_dev3
>>>>> +    _mount $scratch_dev3 $seq_mnt
>>>>> +
>>>>> +    _mkfs_dev $uuid -draid1 -mraid1 $lvdev $scratch_dev2
>>>>> +
>>>>> +    # Add device should free the device under $uuid in the kernel.
>>>>> +    $BTRFS_UTIL_PROG device add -f $dmdev $seq_mnt > /dev/null 2>&1
>>>>> +
>>>>> +    _mount -o degraded $scratch_dev2 $SCRATCH_MNT
>>>>> +
>>>>> +    # Check if the missing device is shown.
>>>>> +    $BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
>>>>> +                    _filter_btrfs_filesystem_show
>>>>> +
>>>>> +    $UMOUNT_PROG $seq_mnt
>>>>> +    _scratch_unmount
>>>>> +    cleanup_dmdev
>>>>> +}
>>>>> +
>>>>> +test_forget
>>>>> +test_add_device
>>>>> +
>>>>> +_scratch_dev_pool_put
>>>>> +
>>>>> +status=0
>>>>> +exit
>>>>> diff --git a/tests/btrfs/254.out b/tests/btrfs/254.out
>>>>> new file mode 100644
>>>>> index 000000000000..20819cf5140c
>>>>> --- /dev/null
>>>>> +++ b/tests/btrfs/254.out
>>>>> @@ -0,0 +1,6 @@
>>>>> +QA output created by 254
>>>>> +Label: none  uuid: <UUID>
>>>>> +    Total devices <NUM> FS bytes used <SIZE>
>>>>> +    devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>>>>> +    *** Some devices missing
>>>>> +
>>>>> -- 
>>>>> 2.27.0
