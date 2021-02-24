Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC59323553
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Feb 2021 02:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhBXBaX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Feb 2021 20:30:23 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58796 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbhBXBVZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Feb 2021 20:21:25 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11O1If6k030244;
        Wed, 24 Feb 2021 01:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=z1G3G2IOb8ZT6d2mEtrX2p2cOHdjEe41BPnb10Vdgh8=;
 b=kSbxWiJEhXSGLLBCKcqnm5ki4G1Hc9Ft1A7Wavdv+Y/kLoNOJtRlm1tmgTIYdRcXA8Nk
 Tqhqk+zPirLj2+S+8UH64oTq5mDrhSakVuXXa/drvgNWghema1/hUowjfEHgH2OAMkTZ
 8uVBmC/KPnrWhfQBJrJpzu0nSIQvFizOv70pDu/GYm2Nh4TxSFu9e1LDfsQSqd6p9s2V
 YTj9bZE6Cz9FujWTECNpc31s7MEa8HnD1h1wxj9qVs0k54mNTdxvcqOGgQS45Ut2t1YN
 mrhJPxvuW+58rbVjrj/OlbLWqToKqrMul+yt0rXk0GUqEm8wGr6aVYuXElJidctxdKHp Hw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36vr623pj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 01:20:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11O1KRh2166448;
        Wed, 24 Feb 2021 01:20:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by aserp3030.oracle.com with ESMTP id 36v9m5anf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 01:20:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZIa71mdiVz0GgchqBz1dui+xIytR6ZxI8tq2kvE4xRhlgPKpvQYhZjC4RiFqNJ8PH/vvWMr/CV8HkGwvD6Z50aDFXaWjLWzo3PeeOIRSnWB8pbXWj4C10XPufk5cq1fp5mYJYMHTvoyzWUzFbHVdof0OnY22sZsG0G+Qr+l1ebqHRy+pbXvo+SsKX7hWFkj6alHy95Jpc8H5GmgkxI6gFE1AvJf08enNFOpI8AgHPni6gMTXuqi2EsIPn8IUepDHrX8Rv8j562coCGzhggGxGHfbSArxHLnm7J41hyvX9qoX5jIYB/E8XNHuvUbP/nhUg76dzZ3Csh8KY4dSPnUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1G3G2IOb8ZT6d2mEtrX2p2cOHdjEe41BPnb10Vdgh8=;
 b=RXixfoxkb+JxjZ6arxBNXwpCnDMdxDvZyYLgn9w6JchgbDT+t4k0jMhOzacpV6vXOYnydVVuPTl1pVSqS8dp/13vdJvU4KEyl/8DsZXvJ9I9syf7OZNxJ4C5m1KAbKyAF+Uq236L5B8EKVBGlz9z7TnN3B4rkjRcXT4BjK4tIw8Usq3pUvPGYpqC7PTDEmQTqyu4qQWXuhdtL0OGnqgGjpVLOP52IqeOiA3/LQMZFzJ7Ze05vAoWzX/lfv7AA8m3ji93oy4HEfiK+6goS1Otn2wA3GiIqFHGdPr8VZagix3JxjTympeR7QDHNycq/yKZ2FPEE9RQu0KtSSyvuHA+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1G3G2IOb8ZT6d2mEtrX2p2cOHdjEe41BPnb10Vdgh8=;
 b=nO3YO0jI+uBdkzVKc0jtEyb23OM4tc68rxzi2p+rLZs9nhqNlkQ3Z6q7c9ni3M2G0LQxvCTeZlUF1LdXBkFEOY+t1mH0CcLF4XZ2yIujh5g+MmRyrBtzFt+QXBP3xmj+AWITKRqZxgJ3B2g2EYda9wmovDmp51Os2tuu9NAe/BQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4352.namprd10.prod.outlook.com (2603:10b6:208:1de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Wed, 24 Feb
 2021 01:20:13 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125%8]) with mapi id 15.20.3890.019; Wed, 24 Feb 2021
 01:20:12 +0000
Subject: Re: 5.11.0: open ctree failed: devide total_bytes should be at most X
 but found Y
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Steven Davies <btrfs-list@steev.me.uk>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <34d881ab-7484-6074-7c0b-b5c8d9e46379@steev.me.uk>
 <PH0PR04MB7416AA577A3ED39E4C5833819B809@PH0PR04MB7416.namprd04.prod.outlook.com>
 <PH0PR04MB74167CACC7802BA85638105F9B809@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210223143020.GW1993@twin.jikos.cz>
 <457bf37240392e63a84c7e1546f7d47a@steev.me.uk>
 <PH0PR04MB741625481C6DAC65BB52857E9B809@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <d75bcf2d-dbee-ed1f-5602-23ed7d5597b0@oracle.com>
Date:   Wed, 24 Feb 2021 09:20:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <PH0PR04MB741625481C6DAC65BB52857E9B809@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2406:3003:2006:2288:f531:6ae1:a422:5681]
X-ClientProxiedBy: SG2PR06CA0096.apcprd06.prod.outlook.com
 (2603:1096:3:14::22) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:f531:6ae1:a422:5681] (2406:3003:2006:2288:f531:6ae1:a422:5681) by SG2PR06CA0096.apcprd06.prod.outlook.com (2603:1096:3:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Wed, 24 Feb 2021 01:20:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48dc66ad-7cc8-4d23-ecbf-08d8d8625560
X-MS-TrafficTypeDiagnostic: MN2PR10MB4352:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4352295D9EF4D58BD2BA7742E59F9@MN2PR10MB4352.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dM1B/sXreB2fCfC9aFBbUXjXcjrOIrmC/BFdDQfRY6C0eU417oL9XcFBIEyevJ/TMdoblky1lfwCFbs+U6qBYgqRxQuoTVWryluDWGHWy2twx7ir53bUzD31x8LUZ4Rm/H8aVkauKQYBl+7nfmj5jugttZMZbGZJeHfMDKholCI1bmN2eLe3xrHgON4PW6r1er4m/LgOZb6cg/5CUPB8Ro1Yvof9X+AUeg0r1kJ+khE+FoKWAYa5jIIsLtaiNmafvw+DvTRav1Bh3jLMfDMTIAKoE5qj8dB1C4tCxWAxHQlDRU7pEY6MN8MNZfGfpnGxJP8SCtl3KhwkjzbfFhQ2TNSvBJIUrjFmTzzinZHSJrIhkrRMnz72bqKY2jmk76imyFnZX2WXn3wnviQKfQoITPU46EhoBRm4eRu3rGhH2xz0JxuD8DC3IxLQTt6hcLGxqRdVFHbaedxDqaW/fl+JDdVZzOcL4alAZ5pw23A62xsG0x7HTvqNxiZnsxtDF019H7+jnnza2m+k3UCqDmckEIBQUg5wTZlY0kLMNA8hE45SbLH0yCHHwEURZ90DtOYZ1nkyr/1B8uyH+U7otCdjzDQbQPr34/nmo2RbI9y4F2g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(136003)(376002)(346002)(110136005)(44832011)(2616005)(83380400001)(6666004)(31686004)(53546011)(66946007)(478600001)(16526019)(316002)(186003)(5660300002)(6486002)(66476007)(66556008)(2906002)(86362001)(8676002)(31696002)(36756003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eTJQczdYVmQ0N2xucjcwc2JjZkFSUUhIb0ZFakQ0VTFMUWI4OVBLUHJDOVc5?=
 =?utf-8?B?ZEJpengyZWc2eHNpd2NSOHNsQ1VnMUMwUEZPRThuUFRBcFZtOHFXeEFybVVT?=
 =?utf-8?B?dE16Q2lwZnJzWVJZcTVvdHIwdHZ3cTdLU0dSQWt5TThMOUwyODQzQnNhOW5E?=
 =?utf-8?B?YUhJZ1lwRXFUNVZlZENOU0c0NFZGQk1zVnhEN3QxMm1HODYwbGU0b3U0UjU0?=
 =?utf-8?B?MlZwRXRoZVNvWmZ1MmdTWG1Bc3BiUzFRbzcrMHA3am1QQzZDaXdsbEtoYjJ6?=
 =?utf-8?B?WXZBbUZZQzBiTFkzVUNBUU1SVnRvZ2xnaVpTMkJJZnlvbTA1V2tDRFhFald0?=
 =?utf-8?B?dTFqeGZKWE9RNjhRNnI0eUx3WE9OZit3MWRabUJLRmVPN0VvQjIzSER3MHM3?=
 =?utf-8?B?Z05sNW5ZQmpQZDlQejQ4cEppOVpWN2ZQcWhMM0pwNE0yVXNMK3d4a3VlK0I3?=
 =?utf-8?B?MjlScWRzanFUanFBaThvbWtoTENhUkhJSzJtTTdYcGM4cHp2NGJyZTNkQjlC?=
 =?utf-8?B?em9aSjFtZTUyMFloUzZJd0VQL2piYmJqSGxhRGl0VHZ3QXVpY2dmczh5REJ0?=
 =?utf-8?B?SGVabFNQZGcyQ0k3Zmo0c0taQUxaRXZnRXJhN2tad1VMVGVUa1lSd1JpUEFE?=
 =?utf-8?B?TmI0K0Z0dy8xUGFnbHVMdkkxV2NYZ2VvdGk5Ky9CMnBTTTVTOHh1cUlUalZ1?=
 =?utf-8?B?YXpnS3VZZXV2Z2I2c2hPTk5MZGZQZHV4dlB5OUI3UWJzdXJseUt0ZStENXoz?=
 =?utf-8?B?YjhvbGp4N3BzN0hNc3lNM3RIRlBsMWF0Vm84N2lObTZYbWtsRHF1S3A1VGxW?=
 =?utf-8?B?d3o1Y2VyVG9qQXVGZndkWXlkVi9JNDdKZ0ZqSDVJU29tb3BCZXEwYjBwTEFv?=
 =?utf-8?B?aUoydERPSmhrRWtvdCtCWSt6N3NUcEp6aStJZk5Pb1BNZHJXbmFEdlZYbWI0?=
 =?utf-8?B?L1hnQWdXWWlKU0xzSDJlR29ub1VLcHJPcEZFZFJoQUdiTld0QnRBWGhHZ1Ri?=
 =?utf-8?B?Y1dFT0gybTdWOW0yTUhQcUMwWFVmdFFMTU1HZ2NnZEdIOE5tQnl0YTd5Ulhy?=
 =?utf-8?B?QlFSQ1RaL2tFN0FnczhuQnNzVkhzWk5UL29VTng1Z2NDRCtOcEpLVXdtL00r?=
 =?utf-8?B?cFZsUGtLVzlwWjk1RzNzeE93TkIvK1k5L0VrZ0x2ZUFYdW8zanFsVmpmV3Vu?=
 =?utf-8?B?empNWURrZk5kQ3FrbDFnYllXQ3JGcnlDSW1vbzEvSFJkcTBTK0w1YlZHSmVE?=
 =?utf-8?B?djVLY3pqVW13ekJWWXRMVWViM3pCekhSVmp5SlFobTZxM3pJSnJFU05ydExV?=
 =?utf-8?B?UUtySm44QzZhdTFPTkJzQkJ6VDhtU2h2RG5nYlRwRWovTmxSUGdQWHVxZ2I3?=
 =?utf-8?B?a1NucndNeXIrMmNsTjYya1V2NGxZTmNzdGNBNXdjQUxHdU9ySGFlL1J4d3FE?=
 =?utf-8?B?dmloOWpYa1NBUjh2VDRNK3RMN3czbGhzMm9sRytUS2ZmSUQrYXNlK2JYc1hq?=
 =?utf-8?B?dlUva3QyeFpscW5xeGwydC9RSERSbVJKN2szY2pMUmRGczNPS3hTdER2c2Jj?=
 =?utf-8?B?V2lJLzVhdW1DdmdSL3BDdG5TZk40TGkxWU9PVTJmb002Z0tIQjlMMDB4VnZh?=
 =?utf-8?B?bVZ4bDRsY2NFVyt2ZWZzOHZBVUtHVkI5WVlUYTR4ejFkRllOVDR2dmFBNjI1?=
 =?utf-8?B?SnorTzNyNktRd2hsckd3T2p4L2ltZFBIUng0aU9LcmRPcDZXNG9KeThHQTg3?=
 =?utf-8?B?andOWkQxNDdxd0k2SUNFWXY0NlBMeGN2NzNuTzRDSDFPUWk5YVgzSFQyNXNN?=
 =?utf-8?B?MXFFTXdwMm1LYVp1VmF3enFLN2drQ1NLT0RNWDRsV2ZLd3dZNHhtUDJEbnJL?=
 =?utf-8?Q?Mus4/zCiSLeuW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48dc66ad-7cc8-4d23-ecbf-08d8d8625560
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 01:20:12.5756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cV7i4ziszmjcFvwQwZ9fryaKm3yWigha2A9Szyw/pR5yNQiR4ZAQSUttwyhd83BW5FP3t+jpaQMp0bhfVnKI+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4352
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240007
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1011 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240007
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 24/02/2021 01:35, Johannes Thumshirn wrote:
> On 23/02/2021 18:20, Steven Davies wrote:
>> On 2021-02-23 14:30, David Sterba wrote:
>>> On Tue, Feb 23, 2021 at 09:43:04AM +0000, Johannes Thumshirn wrote:
>>>> On 23/02/2021 10:13, Johannes Thumshirn wrote:
>>>>> On 22/02/2021 21:07, Steven Davies wrote:
>>>>>
>>>>> [+CC Anand ]
>>>>>
>>>>>> Booted my system with kernel 5.11.0 vanilla with the first time and received this:
>>>>>>
>>>>>> BTRFS info (device nvme0n1p2): has skinny extents
>>>>>> BTRFS error (device nvme0n1p2): device total_bytes should be at most 964757028864 but found
>>>>>> 964770336768
>>>>>> BTRFS error (device nvme0n1p2): failed to read chunk tree: -22
>>>>>>
>>>>>> Booting with 5.10.12 has no issues.
>>>>>>
>>>>>> # btrfs filesystem usage /
>>>>>> Overall:
>>>>>>       Device size:                 898.51GiB
>>>>>>       Device allocated:            620.06GiB
>>>>>>       Device unallocated:          278.45GiB
>>>>>>       Device missing:                  0.00B
>>>>>>       Used:                        616.58GiB
>>>>>>       Free (estimated):            279.94GiB      (min: 140.72GiB)
>>>>>>       Data ratio:                       1.00
>>>>>>       Metadata ratio:                   2.00
>>>>>>       Global reserve:              512.00MiB      (used: 0.00B)
>>>>>>
>>>>>> Data,single: Size:568.00GiB, Used:566.51GiB (99.74%)
>>>>>>      /dev/nvme0n1p2        568.00GiB
>>>>>>
>>>>>> Metadata,DUP: Size:26.00GiB, Used:25.03GiB (96.29%)
>>>>>>      /dev/nvme0n1p2         52.00GiB
>>>>>>
>>>>>> System,DUP: Size:32.00MiB, Used:80.00KiB (0.24%)
>>>>>>      /dev/nvme0n1p2         64.00MiB
>>>>>>
>>>>>> Unallocated:
>>>>>>      /dev/nvme0n1p2        278.45GiB
>>>>>>
>>>>>> # parted -l
>>>>>> Model: Sabrent Rocket Q (nvme)
>>>>>> Disk /dev/nvme0n1: 1000GB
>>>>>> Sector size (logical/physical): 512B/512B
>>>>>> Partition Table: gpt
>>>>>> Disk Flags:
>>>>>>
>>>>>> Number  Start   End     Size    File system     Name  Flags
>>>>>>    1      1049kB  1075MB  1074MB  fat32                 boot, esp
>>>>>>    2      1075MB  966GB   965GB   btrfs
>>>>>>    3      966GB   1000GB  34.4GB  linux-swap(v1)        swap
>>>>>>
>>>>>> What has changed in 5.11 which might cause this?
>>>>>>
>>>>>>
>>>>>
>>>>> This line:
>>>>>> BTRFS info (device nvme0n1p2): has skinny extents
>>>>>> BTRFS error (device nvme0n1p2): device total_bytes should be at most 964757028864 but found
>>>>>> 964770336768
>>>>>> BTRFS error (device nvme0n1p2): failed to read chunk tree: -22
>>>>>
>>>>> comes from 3a160a933111 ("btrfs: drop never met disk total bytes check in verify_one_dev_extent")
>>>>> which went into v5.11-rc1.
>>>>>
>>>>> IIUIC the device item's total_bytes and the block device inode's size are off by 12M, so the check
>>>>> introduced in the above commit refuses to mount the FS.
>>>>>
>>>>> Anand any idea?
>>>>
>>>> OK this is getting interesting:
>>>> btrfs-porgs sets the device's total_bytes at mkfs time and obtains it
>>>> from ioctl(..., BLKGETSIZE64, ...);
>>>>
>>>> BLKGETSIZE64 does:
>>>> return put_u64(argp, i_size_read(bdev->bd_inode));
>>>>
>>>> The new check in read_one_dev() does:
>>>>
>>>>                 u64 max_total_bytes =
>>>> i_size_read(device->bdev->bd_inode);
>>>>
>>>>                 if (device->total_bytes > max_total_bytes) {
>>>>                         btrfs_err(fs_info,
>>>>                         "device total_bytes should be at most %llu but
>>>> found %llu",
>>>>                                   max_total_bytes,
>>>> device->total_bytes);
>>>>                         return -EINVAL;
>>>>
>>>>
>>>> So the bdev inode's i_size must have changed between mkfs and mount.
>>


>> That's likely, this is my development/testing machine and I've changed
>> partitions (and btrfs RAID levels) around more than once since mkfs
>> time. I can't remember if or how I've modified the fs to take account of
>> this.
>>

  What you say matches with the kernel logs.

>>>> Steven, can you please run:
>>>> blockdev --getsize64 /dev/nvme0n1p2
>>
>> # blockdev --getsize64 /dev/nvme0n1p2
>> 964757028864


  Size at the time of mkfs is 964770336768. Now it is 964757028864.


>>
>>>
>>> The kernel side verifies that the physical device size is not smaller
>>> than the size recorded in the device item, so that makes sense. I was a
>>> bit doubtful about the check but it can detect real problems or point
>>> out some weirdness.
>>
>> Agreed. It's useful, but somewhat painful when it refuses to mount a
>> root device after reboot.
>>
>>> The 12M delta is not big, but I'd expect that for a physical device it
>>> should not change. Another possibility would be some kind of rounding
>>> to
>>> a reasonable number, like 16M.
>>
>> Is there a simple way to fix this partition so that btrfs and the
>> partition table agree on its size?
>>
> 
> Unless someone's yelling at me that this is a bad advice (David, Anand?),


> I'd go for:
> btrfs filesystem resize max /

  I was thinking about the same step when I was reading above.

> I've personally never shrinked a device but looking at the code it will
> write the blockdevice's inode i_size to the device extents, and possibly
> relocate data.


  Shrink works. I have tested it before.
  I hope shrink helps here too. Please let us know.

Thanks, Anand

> 
> Hope I didn't give a bad advice,
> Johannes
> 
