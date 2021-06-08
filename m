Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE50539F0C2
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jun 2021 10:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhFHIZ3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Jun 2021 04:25:29 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45632 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhFHIZ1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Jun 2021 04:25:27 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1588FoTb114978;
        Tue, 8 Jun 2021 08:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=1gAAbN8zyHo6SIZ6IbTZs+Hs7mwAhLiHCx0Fqf8tkbc=;
 b=XnytfFrMzZrHsk5hpmWWyDYfp0K2lRze5hr1Nlkgsevgj1IRiM1b0N4uSDdFLTVbI5fN
 a1rVfpvwJ9eD+HsuJc/96FK7xNvKZpEN/UU/k64D9o0e+EGu6NtScVFWzLYZOSQWN8/D
 YzY5dU4CoICztbciHIurjpLnMI5K7x+mhlvzm1C6Va2cZao9oqTJbLI2wWa+vobPXIGu
 iRHIl3w6ck6g10VppfrlW/eaSnmABF/yyntK878YjaprGXH5AJdvN/gJzpD4ESxYar3E
 oEYHqyA6tcK/qdmGhhSjYirx7ks4S9VIwgrOo4upZGlSHlqdNM1a5ynWHqBWUCW0EGbm gQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38yxscd8kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 08:23:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1588F0Jc110697;
        Tue, 8 Jun 2021 08:23:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3020.oracle.com with ESMTP id 390k1qteaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 08:23:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=astV+55353Gw+i0IUmVv+x57yLWuSD9lw4j2ramV5E9ZWqC84LYZzMMn9BGs90jktqyHNBxA3ilLvOvVYeKa7Z2qDHibm4+3Nhw2FWkKuw3DKveKMpT2p4g5AJ+79hJaGc4NnUHomTsCQHsFitiIn0h2sr5pQkUuyjVhmRHSFHU0xl+nO9Rdrftmx9DUjO7U80moYdS21DuGGjGNA+HZR09+8rXi959O24lytlhAXLnSzq3XuEvS1j42Kzy5EdHstpjBzOgaLdx91h/PLui73cilbCD8HkTNiObVswaECVvToFX7bSMh7vJZCU5+uDZ2BSnGH4fCOVa9iv5YRWTzHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gAAbN8zyHo6SIZ6IbTZs+Hs7mwAhLiHCx0Fqf8tkbc=;
 b=fRn6esfv7jqotYZCgHZ7vYhx5BFByVESkVtoVLXVpVof7tGmKc7rYwufwpZHqZVvoIl+vobj1O1cyIek/jZjS8cgdhjnDazbvOoxOmEf8ImK5A693rtfes6lvjjUcArLFpTnurIh8azv9cEDHXO0SVh0taFMxn1OBTB637dPVQmYYE/FtAyPFNLRP5ARBowmQi38Xabk9f0su+A3ccHIX+tXWHu1IkdbgBuoTQV7a1OP1QxM/MLrd0mGtDs1WbhKcUewU5HTceLb7xESDAsFSZk/coa6tzsBhsS2H8Cv16CYj8NXl2B8AjmCo1wRqws5SiiIw147/fntRACQURm2gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gAAbN8zyHo6SIZ6IbTZs+Hs7mwAhLiHCx0Fqf8tkbc=;
 b=HswIi4xXwZDkaWojgaaz//mzHTs+qc6jrRt1bRfpWFmM+8GUHIdp1m7cmPNTlEKZFtWmUhbxYPMsDYdJpaCaedZ7jgBKlEybfpmXtP7G9V1KyBts4H9VYybskkkoJw0WzI6263yZ5gUr2+hzrXNX9HdHM1RELuSLwlihJvzZmfw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4929.namprd10.prod.outlook.com (2603:10b6:208:324::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Tue, 8 Jun
 2021 08:23:28 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%7]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 08:23:27 +0000
Subject: Re: [PATCH v4 00/30] btrfs: add data write support for subpage
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210531085106.259490-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <55ba3489-98de-3a69-8912-3a32e73ffca4@oracle.com>
Date:   Tue, 8 Jun 2021 16:23:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210531085106.259490-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG3P274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::18)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG3P274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Tue, 8 Jun 2021 08:23:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7dd3664-639a-48ee-cbc3-08d92a56b127
X-MS-TrafficTypeDiagnostic: BLAPR10MB4929:
X-Microsoft-Antispam-PRVS: <BLAPR10MB49293B7CB0E6F2EA0FBCEB4FE5379@BLAPR10MB4929.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DTmZst+Y9xkuZCycujW1PtDLXaP7ROMcLuy2cOg8cchOEP9H018LM5S+Mk5p7+bEL22ZK56IQbn0MtjrWs0sIvtQ/aSHgyyhXMmD1zFdG95OLye1V0qeLvLW1VqGTTBK/DdXO66grKJlN98MI7TAvRnpQ9Kj52j0CFSf/1wKtffn68608qLEOE05vhUm0e33j4MVrUlNPvdFtGggtPJ2YueZJzFREWAAK7OYoo3uX2BmxrlMjrbOtbUr+nI8MSr32AwaY+u0UFjxs4Is1PIEGJ9BHDuT4maj8OEDwaiVDT2GBYqDH9iir3UV3OjXf5u0Riv6YN3zEMI4q6bo66WJ7YU7lQsKfgvMLKH8SO3JsMDHepqTJPURroGxS+oxBkS+ZXovVjdyNgQzNdeFU6XAnzFv43LWuJUw7TOgTNVGYSkKLZHng0Vr/Apdtb7zSRh5PHiZ8T5oO4bizLVy+gSdngawOXVP+n/ZAMlRhZU0xpFBai1jKiW3+QYSqL2UKOnB1ftnFC5ze3wpr0psO1fiEIEPHFQeppGTJ4Jwea97cxD+01oFvf/vEulzjTWKA8Ik5XvwrcglSdYWeCL7KkPIJCBn071kCVufMMjKGg6Lgh/aXLk6ube3AwBGBn194vJ6YxHYqNNYjkp45U1Uf6Ry8tAAfY3gxUmc3DbR4lYEoRikJ3T9hdlTqemfXOmRcSkg2DZsatnjR+ksOoTMj8SjkuzbYmZKKcfZDei8hpaXY9XUyitpqp5wAGNc5EmMFBzmX+tRbzSEvdCBtLf8y/Yy9CcDAUn/lrElSz53TKDeXB7s2VEf2LkfHcrcFvQXvVgBWz8yMdG/rPgypNE+77cBltqBXWabKjq2PcNomZ34pMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(136003)(376002)(366004)(53546011)(5660300002)(36756003)(2906002)(966005)(31686004)(478600001)(66556008)(6486002)(66476007)(83380400001)(26005)(66946007)(186003)(16526019)(956004)(31696002)(2616005)(86362001)(44832011)(38100700002)(6666004)(8936002)(316002)(8676002)(16576012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MklVWFo4MmtRRUdsK1hzUVJWZW1MVFJKM2Ntd2VmejdBOUJDcHlXOXdKRzZ2?=
 =?utf-8?B?YUNXYnZjNE9BTWlTaTk3UW5QQ3drcThTRUMzblFXaTAydHRzbDNuRDVWdGpO?=
 =?utf-8?B?SmJ1NkY2MTlGZlhKaGhsMUtjVE91dzQ2Q3FSdzZFU2g3QXUwOWlZLzdEc2hP?=
 =?utf-8?B?NG04YXZZVGlGODBUbysrY0FEMlN0Y000Mm1kSU5oMEhBMDVyYS9nRzVqc25E?=
 =?utf-8?B?aEluTFpHam1CMU9WMDVUakFQN010enN5RTIrSGVPaU5wc1k0Y1BqZEVGdmh4?=
 =?utf-8?B?R3ZIWHNUR045Z1FCQVJrTjUrV2l0NTlxR1FKMkhHc3E2bFJjb1FTbGg3cmhU?=
 =?utf-8?B?dktyUUpIZEdsNXdXTS91V3QvU2JSM0FoWkNMTXVPL083RWs1SEZiK0RlNWsy?=
 =?utf-8?B?TEgzZHFtSDZHVGxXa3hBOC8xTWkvcHVpQmZyclZwRmhQaXpKQm1lQmtvdFpO?=
 =?utf-8?B?NnpIeEoxNHNrZDNxZUlIUGppNGwxY0NUZjdGaUIzWDBvb1pLSUgrSmpPVmtR?=
 =?utf-8?B?WFhaTWdYV3RuOXhCaWkwTFNHUXV5S29UY0xKbWNiVnFGUGFoSjlxSU9QbkVV?=
 =?utf-8?B?RkFiWitGdHYwYlhYNnpyakJsWG9kRHF5RzBURG0zWUlDVlJkR2FCVWRhb0ta?=
 =?utf-8?B?dEsvWDhoVkFxUGg2VkxyMVBFVkkraERYWnNRV3IvdVBqQUk2WXkwZnlUalh0?=
 =?utf-8?B?N2RuR3lIdG9jS05GUEFFOEJKUDBSbmgvOE15cGZHZ2tHWWVpZXhxVGduWCtt?=
 =?utf-8?B?cThNZ0xqNFc2TzcyeVd1T2t0UHRBajE0by9zU3l2UkJ6SlRPOFppVnlvUTQw?=
 =?utf-8?B?L3M1cXVFVFRrWllEelA0MWlKRjZQcHBDcUI1TmYzOEVUZ3pCVWlWRTNqREZp?=
 =?utf-8?B?RGh3ZGdrajh5RVUrdGVwaStYUWdRQjY0VFNGdklMRGtUYU54K1dabGY1Tk9Z?=
 =?utf-8?B?V3NlKzFKUkMrZ1VXbUMxdUlYUk14R2ZSTmRIcTBBNk1MTTMwTlhFUkRiLzJS?=
 =?utf-8?B?TWdtVTQ5OGc4KzMvVVJIdEdwdDN6dWhqd0l6YUZ3RWZJRDl2cTZwWWFqT1Vm?=
 =?utf-8?B?RXIyUGorb255VXZ2OUFhck5ybWk3YUZ1dXd1cDhBN3V5eHlTS0V5TUpDKzZV?=
 =?utf-8?B?SklSOVpzc2VTQ25ZVE41S2V2OEFrb2xQYjVGMmgxZ0syM0tOcXJRU09YUUJO?=
 =?utf-8?B?eU1UeFVjY3poZXg1REJXWnRIV2hTZldqeUJMQXMxTzlIczRLQ2EwaEZNcHlX?=
 =?utf-8?B?akYwNjI2RlhKc2p2M21HSEdyeUY4TGZPMDFCZVk5UDUzajZ6bnNKTEY5L1Yz?=
 =?utf-8?B?TkxPWnFyK3JpVTk3c3ZRa2ZrYmZIZEhwbDdCK3RkTFdnSU1TcXlPdDZmb2VW?=
 =?utf-8?B?aElkd1pxL3FFYzBMaFZ4ajdIYVdMd3pKcjgzL0hNUDFPNnVKU2lKZTRndXQ5?=
 =?utf-8?B?UGYyY3JiVnhrNGNEY1hmWHJNTUFOR0JUT1JQNk9HYnpSZ0N3eVBCZmpObWtZ?=
 =?utf-8?B?U3p6bW9NYVBQZzVUQnE4VEw1ZEFWTkF0MEtFZW9qdVhoaEFVNm5uVkpwZmY4?=
 =?utf-8?B?T3VvYzV3OWtKSWVOMUZ0dXp6U1AzWDYybWU2cFdxYThyTXhVU3lQTVlMVml1?=
 =?utf-8?B?NFBvc1ZJT3VLcVEzZGQzcVJzSVZKSXlTUnR0ZlBoTjlTYmJMYy9SakdicGE2?=
 =?utf-8?B?cGo3U3NoNWpXa1FwUUR5ZW81bzNYTDZUc0M4dHE0SjBSRWVQU3hyL1d4MXF4?=
 =?utf-8?Q?QLyjmIeXOtugNaWC7vXtkcIINHDMNWrmoqJyImN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7dd3664-639a-48ee-cbc3-08d92a56b127
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 08:23:27.8868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /RVSZHO/3B1GMKS5/DFYEwpHJ2s6uWPhixauc0fGkpZMkEJDgNNEcKDpKbQVQ4//QnytoCZRU2mIChin32kY6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4929
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10008 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106080055
X-Proofpoint-ORIG-GUID: Qjnr1gQYgh1yBQ4Ylb9B5pRAmD_niLEf
X-Proofpoint-GUID: Qjnr1gQYgh1yBQ4Ylb9B5pRAmD_niLEf
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10008 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106080055
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 31/5/21 4:50 pm, Qu Wenruo wrote:
> This huge patchset can be fetched from github:
> https://github.com/adam900710/linux/tree/subpage
> 
> === Current stage ===
> The tests on x86 pass without new failure, and generic test group on
> arm64 with 64K page size passes except known failure and defrag group.
> 
> For btrfs test group, all pass except compression/raid56/defrag.
> 
> For anyone who is interested in testing, please apply this patch for
> btrfs-progs before testing.
> https://patchwork.kernel.org/project/linux-btrfs/patch/20210420073036.243715-1-wqu@suse.com/
> Or there will be too many false alerts.
> 
> === Limitation ===
> There are several limitations introduced just for subpage:
> - No compressed write support
>    Read is no problem, but compression write path has more things left to
>    be modified.
>    Thus for current patchset, no matter what inode attribute or mount
>    option is, no new compressed extent can be created for subpage case.
> 
> - No inline extent will be created
>    This is mostly due to the fact that filemap_fdatawrite_range() will
>    trigger more write than the range specified.
>    In fallocate calls, this behavior can make us to writeback which can
>    be inlined, before we enlarge the isize, causing inline extent being
>    created along with regular extents.
> 
> - No support for RAID56
>    There are still too many hardcoded PAGE_SIZE in raid56 code.
>    Considering it's already considered unsafe due to its write-hole
>    problem, disabling RAID56 for subpage looks sane to me.
> 
> - No defrag support for subpage
>    The support for subpage defrag has already an initial version
>    submitted to the mail list.
>    Thus the correct support won't be included in this patchset.
> 

I am confused about what supports as of now?
  /sys/fs/btrfs/features/supported_sectorsizes
list just the pagesize.

Thanks, Anand


> === Patchset structure ===
> 
> Patch 01~19:	Make data write path to be subpage compatible
> Patch 20~21:	Make data relocation path to be subpage compatible
> Patch 22~29:	Various fixes for subpage corner cases
> Patch 30:	Enable subpage data write
> 
> === Changelog ===
> v2:
> - Rebased to latest misc-next
>    Now metadata write patches are removed from the series, as they are
>    already merged into misc-next.
> 
> - Added new Reviewed-by/Tested-by/Reported-by tags
> 
> - Use separate endio functions to subpage metadata write path
> 
> - Re-order the patches, to make refactors at the top of the series
>    One refactor, the submit_extent_page() one, should benefit 4K page
>    size more than 64K page size, thus it's worthy to be merged early
> 
> - New bug fixes exposed by Ritesh Harjani on Power
> 
> - Reject RAID56 completely
>    Exposed by btrfs test group, which caused BUG_ON() for various sites.
>    Considering RAID56 is already not considered safe, it's better to
>    reject them completely for now.
> 
> - Fix subpage scrub repair failure
>    Caused by hardcoded PAGE_SIZE
> 
> - Fix free space cache inode size
>    Same cause as scrub repair failure
> 
> v3:
> - Rebased to remove write path prepration patches
> 
> - Properly enable btrfs defrag
>    Previsouly, btrfs defrag is in fact just disabled.
>    This makes tons of tests in btrfs/defrag to fail.
> 
> - More bug fixes for rare race/crashes
>    * Fix relocation false alert on csum mismatch
>    * Fix relocation data corruption
>    * Fix a rare case of false ASSERT()
>      The fix already get merged into the prepration patches, thus no
>      longer in this patchset though.
>    
>    Mostly reported by Ritesh from IBM.
> 
> v4:
> - Disable subpage defrag completely
>    As full page defrag can race with fsstress in btrfs/062, causing
>    strange ordered extent bugs.
>    The full subpage defrag will be submitted as an indepdent patchset.
> 
> Qu Wenruo (30):
>    btrfs: pass bytenr directly to __process_pages_contig()
>    btrfs: refactor the page status update into process_one_page()
>    btrfs: provide btrfs_page_clamp_*() helpers
>    btrfs: only require sector size alignment for
>      end_bio_extent_writepage()
>    btrfs: make btrfs_dirty_pages() to be subpage compatible
>    btrfs: make __process_pages_contig() to handle subpage
>      dirty/error/writeback status
>    btrfs: make end_bio_extent_writepage() to be subpage compatible
>    btrfs: make process_one_page() to handle subpage locking
>    btrfs: introduce helpers for subpage ordered status
>    btrfs: make page Ordered bit to be subpage compatible
>    btrfs: update locked page dirty/writeback/error bits in
>      __process_pages_contig
>    btrfs: prevent extent_clear_unlock_delalloc() to unlock page not
>      locked by __process_pages_contig()
>    btrfs: make btrfs_set_range_writeback() subpage compatible
>    btrfs: make __extent_writepage_io() only submit dirty range for
>      subpage
>    btrfs: make btrfs_truncate_block() to be subpage compatible
>    btrfs: make btrfs_page_mkwrite() to be subpage compatible
>    btrfs: reflink: make copy_inline_to_page() to be subpage compatible
>    btrfs: fix the filemap_range_has_page() call in
>      btrfs_punch_hole_lock_range()
>    btrfs: don't clear page extent mapped if we're not invalidating the
>      full page
>    btrfs: extract relocation page read and dirty part into its own
>      function
>    btrfs: make relocate_one_page() to handle subpage case
>    btrfs: fix wild subpage writeback which does not have ordered extent.
>    btrfs: disable inline extent creation for subpage
>    btrfs: allow submit_extent_page() to do bio split for subpage
>    btrfs: reject raid5/6 fs for subpage
>    btrfs: fix a crash caused by race between prepare_pages() and
>      btrfs_releasepage()
>    btrfs: fix a use-after-free bug in writeback subpage helper
>    btrfs: fix a subpage false alert for relocating partial preallocated
>      data extents
>    btrfs: fix a subpage relocation data corruption
>    btrfs: allow read-write for 4K sectorsize on 64K page size systems
> 
>   fs/btrfs/ctree.h        |   2 +-
>   fs/btrfs/disk-io.c      |  13 +-
>   fs/btrfs/extent_io.c    | 563 ++++++++++++++++++++++++++++------------
>   fs/btrfs/file.c         |  32 ++-
>   fs/btrfs/inode.c        | 147 +++++++++--
>   fs/btrfs/ioctl.c        |   6 +
>   fs/btrfs/ordered-data.c |   5 +-
>   fs/btrfs/reflink.c      |  14 +-
>   fs/btrfs/relocation.c   | 287 ++++++++++++--------
>   fs/btrfs/subpage.c      | 156 ++++++++++-
>   fs/btrfs/subpage.h      |  31 +++
>   fs/btrfs/super.c        |   7 -
>   fs/btrfs/sysfs.c        |   5 +
>   fs/btrfs/volumes.c      |   8 +
>   14 files changed, 949 insertions(+), 327 deletions(-)
> 

