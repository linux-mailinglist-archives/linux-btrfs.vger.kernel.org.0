Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF69325CD4
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Feb 2021 06:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhBZFCF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Feb 2021 00:02:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45486 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhBZFCE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Feb 2021 00:02:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11Q50lm2186773;
        Fri, 26 Feb 2021 05:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=s+xW/eCxM6sYyQcRonspqCnaziwxqLG4R/LKrIRcHRA=;
 b=xyVg/ddO02ENL3Vj5nU+i0NU6E9HKhAwgSt4VFBYfroLm1ruWpXRG4nqmIN9NrIU7KoB
 81whjX5lzgM94U8gzxe71dVyitLPPzI4qyI5Wb5KNCMYZtZJmU4ABnlWCf2q20RSpY4p
 3a0nJq9AjRQ9ldChRrlDC2ltB4kMsva8+WnfF6cA4PDJCgK/RYjr06OUdnFAR5/H/sjH
 9C1Jq9srUAiyF1awiR/xP4ECIK95nLgMHoajb3vg0DbhJeVhkugY/WAIk6pU1rRsk6xC
 iOYhJI2KAvO2V6tX8pmZU0B+c6X+wUPvS5tDN+nTROpLg1+JuchqSOWuNLTHs1PNpvRW SQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36xqkf880m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 05:01:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11Q50heO152099;
        Fri, 26 Feb 2021 05:01:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by aserp3030.oracle.com with ESMTP id 36v9m86jer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 05:01:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWu3ghxhigpZ1vOv9nbYmKtSrE+s5QbC/zKH3FvwgPwk9X3XjNTlGwK3c+d/iid5ZBVA/iPpI/WrhAZ3NURHfzPtMpusB9ArePTNtG9GnA6ebiwiHTEYZdKu9a3u0y1eSczCGV6PyQ1I+d7R278P9qx+/85IcMdmb6Qv6EVoRMhPfaH0sGVd1gIGSwZpVjDz4QCmk8gdjK/HOlNxnnmyNhz4mDReNJ6EFhaSYAwDYQbFdmDpCQCGX4I4cPiRwLmYz2QH3uAmVoMrI+cmfJs1sb92wyaOzKxFBTtd+kw6KYUH9MzNLyA4tc/W/8ZojvcB3LQR/XS8Zju4dJFW1I1PqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+xW/eCxM6sYyQcRonspqCnaziwxqLG4R/LKrIRcHRA=;
 b=i1cKziUSkWQ0MEMLUcXRBxeLWfg3VH4Wc3mxMD7WuTy0zBfPkG34GFPfgesLhsGq6zzw+CjJ4HLL7KtfIVPQ0bGgs59WSSawn0Y5kx9Pp7dNu4c6sRXkdZe2jg1pKLK1rTYwo/fd5rECLdJAvoaAsBACAxuOhUpf3ecXtx7MIhp6qcfOjxVknBuTiOVNS1BPJFhC1V0uDEJ2VkURzaMEPwHeahuyBJLv8RoXwheshBaP+awjMRtNvYJl1atz1rtROhacUb1M4GArGRsSTY1/RwH1S9vNU25lvhn9tk8sluf64ITH84zeKxxR9Z/b+ranuzDxT/S9ckzlSGM0jIFFVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+xW/eCxM6sYyQcRonspqCnaziwxqLG4R/LKrIRcHRA=;
 b=B8MIQElivzGnVcKVGPe2jWJ6o7eUqkzxgJajJSkF2GZOBk7IJU6ombfiIx5dGf8qaizOE7k+o2fT0yjFpd5xtgLCRe/a6EikD5UAhdyYI+Y2S/XGyb8WvVHCzCIRB6B7tv3aInNLag4L5lDi5QmMoz0iQqKqftFOj6cfRGPR9r0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2961.namprd10.prod.outlook.com (2603:10b6:208:33::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 26 Feb
 2021 05:01:15 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125%8]) with mapi id 15.20.3890.022; Fri, 26 Feb 2021
 05:01:14 +0000
Subject: Re: [report] lockdep warning when mounting seed device
To:     Su Yue <l@damenly.su>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <tuq0pxpx.fsf@damenly.su>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <50ff53e3-6e6f-bc6d-31dc-ac376ed944ce@oracle.com>
Date:   Fri, 26 Feb 2021 13:01:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <tuq0pxpx.fsf@damenly.su>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR06CA0088.apcprd06.prod.outlook.com
 (2603:1096:3:14::14) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.102] (39.109.186.25) by SG2PR06CA0088.apcprd06.prod.outlook.com (2603:1096:3:14::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 05:01:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0514bd2-42fb-48fc-019b-08d8da138afd
X-MS-TrafficTypeDiagnostic: BL0PR10MB2961:
X-Microsoft-Antispam-PRVS: <BL0PR10MB2961EAFF0D8ABDFA074C6172E59D9@BL0PR10MB2961.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EkjcQhn8/JRUrFyZMu2baoJP1mw7oC/Anfi0UsCfG39XMzH3qfM2alnunm2zPF8bsPvblrMEBLBKHPcQpd5Yodc0lUCKth2PMMf4YNrscHPbxLIK7/1KAVawqyrKI6p184vrcLZ1GID1/PYqxMzYrj2G2jvaISplIi+mC++swSFgoOD1C0fhnSy1HzahUJFP4byV1QJAgV/V/hDrn8zi2AscbfQLC4ov5gYAohQdq2tOxHpASI7YzLZLgaC/zbB7ffeO+z/82xp9RlsqU666pl0kp7UOoBfc3i/vVcsgcKI/9Xh1aZgL+KoAlkUyfSWYZKdW5LCjWcqGu/A5jFZy8ChefT6VyDkB1q4uA6wKTZlIN11/0Y7Y/3Ljdol4XvkPAcDNskatrJEjJcGuisRz/CWZmW572dFymMImLkTjN91cS7hLFw6WNJxw8cQi8LZ8+zSWwQp6ljgovgkjnVPOPs7FWUoeIvb2SOoE5qF3PucFcA1lUPVFZFwN6NRCaUtXcmzajSqEIB36X75ESsgfiL/aJmD1iUsznkCdrtFwJJKStuxi9uSBQt4whw40kpohyzRAf9M5V1ywzj2ONRwZ0xwkpeHduGoCzQzpYr4+iRMqgpn7t0cJaj/ro/l/E36UXekyUp/fXwHjSOdpIDfj8WR0PXyLWSpeaYS0S8pkhMHe4Hk7NwjHSH8Ap2lzTjgHfWHZSemJTCM/oYjnAJ22rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(396003)(376002)(39860400002)(6486002)(316002)(83380400001)(31696002)(86362001)(2906002)(31686004)(16576012)(110136005)(8676002)(966005)(956004)(66556008)(66946007)(26005)(16526019)(53546011)(6666004)(2616005)(8936002)(5660300002)(186003)(36756003)(44832011)(66476007)(478600001)(781001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?L2FjMlhMbTE4SkJRWnQxWXY0YUlkUzBVZ2hmU0F1WEttMEVlT3lPOHNYSno2?=
 =?utf-8?B?RUh6SDRBQ1hGS0hUaUpQckZlOE9YU1F5UFNMYnIzaGhFUTRLNUcxeS9MVUlF?=
 =?utf-8?B?Y2t4UVNxb0ZtVklza1lxd2lUYWhUM0RlR09qcnIwS2FSa3BTNHBCTTJjOE96?=
 =?utf-8?B?RVR4ZzRvaEFPYjcyUlkrVGdQYkRMc2lzUldUbjd6cWdDM0trREFWSGJCd0xD?=
 =?utf-8?B?RndmUk9OK3pqeUV2bWZjL2hqZzhQUFoyTld6RTVQM0JiM2hZSGlqaFRHUG1I?=
 =?utf-8?B?WDd4YVk3K3Byb0tPNktoZEtNNzNEcFdGaW9IU25TZDFXaU1ZUFh6ZHgvS3ps?=
 =?utf-8?B?RXVqQW5jY2RheXRVOWhpZHFRdTV4N0F5dmpKcjdSWkQzVzUrSVpDYTJ1N09l?=
 =?utf-8?B?MmViMjFzR3BROTZhMWhsOGF2UHVEd0cvY3VISHBnZk92dVhYeUVNdHkyS1Bs?=
 =?utf-8?B?RnlWNGFEQVRQMmhUWmsvT0dXYnBRUnM0MTZ0dXRvMFBYTnErTTV4RFVmMHZi?=
 =?utf-8?B?RzdrK0haREM4TTlROVpRaEFiWVJxK0VNSnUzUGVhMzBLRTJsa2NnQmtuaVRH?=
 =?utf-8?B?cG9JeURrdWRvSDU5UFNyVEhHMmRKZXZ5V1U2d3dOYmdyQkxHTGVJQ21CQldv?=
 =?utf-8?B?bGhMU29IbEVNRVVwenl0Q211ZHZuYjM5SS9ydGYybXBvaTVFVituQzZLcmVw?=
 =?utf-8?B?cXVhZ25nOForTFFsVHNaV2Q3OElJRnpjak9SM0h4SmEyeEZtMkRCczkwWHdt?=
 =?utf-8?B?VkFTU0pJbVdBVHNLOXF6dXNjelhvWGZuNWErY3BSVDdzVU1tU0RWOGdRaWRJ?=
 =?utf-8?B?S0c0MUFWdnlKZFJ2SXVtNW9UL25iQTNMeExpcFV6ejd1bDllK0hmL1E0d0hC?=
 =?utf-8?B?YnkrUjliWmloZHNxcVplcnNNS29OVEU2d2EvSUlIcngxUFNrK2JZck1Tc1U3?=
 =?utf-8?B?RHgzd3FlSTZ6UDR3azRVcFNFMFd5RXBHVUJYOWpmakpTRU5mRTM4WlkrcUR1?=
 =?utf-8?B?aUZqWURoVk9DWW9FcFkrc0hGVHh6OUFXQ3BDMm5qQmJ6Q3hMeVZpeEF3akFJ?=
 =?utf-8?B?dEVCVUpxL0YxcTBydWhLRmFJbXdCMEdveUdLWU9jT05MM1RoVjJGR2svT2FC?=
 =?utf-8?B?WURUdDZIN2Nzck1KQ2FWUXFOZFp2cVErbWhjTDk2NDRram40SEdjV1Q3NFBw?=
 =?utf-8?B?RVB2MUJmTHFDUzRLYS81V0dpOXNSMk9OZ3loNkJTTVNMWnpINEN3SHY5SjQy?=
 =?utf-8?B?UDdGSFRhYitFaHFsMzRDclZvTWo5bzdQUXRpcnFqUXZHZHRVUTVUdHVHZHJr?=
 =?utf-8?B?a1ZyMnFzaDhFbnpLRm5jVGFjVGZsU3RhdGYxVUF4RHB0OVN4ZUZkVnJSOG93?=
 =?utf-8?B?SVFobzJ5M2hrRkY5d04reHBFNEFaYlRqcWVXdDI2MWVoK3hCYjJCQmwxQ3Zq?=
 =?utf-8?B?dU9ZaTAvTnZpWVlHckJ2N0syekNSQXlJNk5xVVVBdlRsU3dXRDF0UDB1ekxz?=
 =?utf-8?B?a2hJRTJRc0hjNWU2Vjh6RXlmbjBoYzBubnRvTkFXUUpBVjNISkFldzFnbmxo?=
 =?utf-8?B?clRHVHREaU5BZHV6QldFVmYwcThpRHpWYkdlRHVQRktCQm1Md0FFNnJyMVBV?=
 =?utf-8?B?WGh2d2Y1TWJZc3IzWFdQR2xrNDJ1YURvTlJmMkN5WGVncE4xTUcxUXRRMXN0?=
 =?utf-8?B?Q3QwMUR3Skp5RGRNeW4wN3RzNmJZd2Nrc0RVbkkzTWovbk9SNlJQSVE4SjJZ?=
 =?utf-8?Q?/il6Aql3dkAOu/3N3uRK3jm3nMRP9ivua2N5ZRL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0514bd2-42fb-48fc-019b-08d8da138afd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 05:01:14.7729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXX26339KerZ+hgw62kiSIVHaDvCoJtOdaJ8fi3TFQXdzWD9xodjGuBriCFTer4R80B3RCxPxiunUEj0iCa1dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2961
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260036
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1011
 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102260036
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org





On 25/02/2021 12:39, Su Yue wrote:
> 
> While playing with seed device(misc/next and v5.11), lockdep complains 
> the following:
> 
> To reproduce:
> 
> dev1=/dev/sdb1
> dev2=/dev/sdb2
> 
> umount /mnt
> 
> mkfs.btrfs -f $dev1
> 
> btrfstune -S 1 $dev1
> 
> mount $dev1 /mnt
> 
> btrfs device add $dev2 /mnt/ -f
> 
> umount /mnt
> 
> mount $dev2 /mnt
> 
> umount /mnt
> 
> 

In my understanding the commit 01d01caf19ff7c537527d352d169c4368375c0a1
  (btrfs: move the chunk_mutex in btrfs_read_chunk_tree
  fixed this bug in 5.9.
Could you please try this [1] patch,
[1] 
https://patchwork.kernel.org/project/linux-btrfs/patch/20200717100525.320697-1-anand.jain@oracle.com/
Patch [1] still relevant as the device_list_mutex in clone_fs_devices() 
is redundant. We could remove it as well.


Thanks, Anand

> Warning:
> 
> [  104.348749] BTRFS: device fsid 9a34d68b-fd18-470c-8cfc-44916c364c76 
> devid 1 transid 5 /dev/sdb1 scanned by mkfs.btrfs (627)
> [  104.377243] BTRFS info (device sdb1): disk space caching is enabled
> [  104.378091] BTRFS info (device sdb1): has skinny extents
> [  104.378800] BTRFS info (device sdb1): flagging fs with big metadata 
> feature
> [  104.512522] BTRFS info (device sdb1): relocating block group 
> 567279616 flags system|dup
> [  104.535912] BTRFS info (device sdb1): relocating block group 22020096 
> flags system|dup
> [  104.571307] BTRFS info (device sdb1): disk added /dev/sdb2
> [  104.602831] BTRFS info (device sdb2): disk space caching is enabled
> [  104.603692] BTRFS info (device sdb2): has skinny extents
> 
> [  104.606389] ======================================================
> [  104.607212] WARNING: possible circular locking dependency detected
> [  104.608025] 5.11.0-rc7-custom+ #55 Tainted: G           O
> [  104.608790] ------------------------------------------------------
> [  104.609599] mount/670 is trying to acquire lock:
> [  104.610207] ffffa2274d7158e8 
> (&fs_devs->device_list_mutex){+.+.}-{3:3}, at: 
> clone_fs_devices+0x4f/0x160 [btrfs]
> [  104.611585]
>                but task is already holding lock:
> [  104.612334] ffffa22750e32f20 (btrfs-chunk-00){++++}-{3:3}, at: 
> __btrfs_tree_read_lock+0x2d/0x110 [btrfs]
> [  104.651264]
>                which lock already depends on the new lock.
> 
> [  104.708041]
>                the existing dependency chain (in reverse order) 
>                is:
> [  104.743619]
>                -> #1 (btrfs-chunk-00){++++}-{3:3}:
> [  104.777693]        down_read_nested+0x4b/0x140
> [  104.794386]        __btrfs_tree_read_lock+0x2d/0x110 [btrfs]
> [  104.811338]        btrfs_read_lock_root_node+0x36/0x50 [btrfs]
> [  104.828574]        btrfs_search_slot+0x473/0x900 [btrfs]
> [  104.845543]        btrfs_update_device+0x71/0x1a0 [btrfs]
> [  104.862164]        btrfs_finish_chunk_alloc+0x121/0x490 [btrfs]
> [  104.878474] btrfs_create_pending_block_groups+0x151/0x2c0 [btrfs]
> [  104.894725]        btrfs_commit_transaction+0x82/0xb30 [btrfs]
> [  104.910808]        btrfs_init_new_device+0x1015/0x14d0 [btrfs]
> [  104.926879]        btrfs_ioctl+0x1ff/0x2fc0 [btrfs]
> [  104.942996]        __x64_sys_ioctl+0x91/0xc0
> [  104.958874]        do_syscall_64+0x38/0x50
> [  104.974554]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  104.990108]
>                -> #0 (&fs_devs->device_list_mutex){+.+.}-{3:3}:
> [  105.020508]        __lock_acquire+0x11e0/0x1ea0
> [  105.035759]        lock_acquire+0xd8/0x3c0
> [  105.050434]        __mutex_lock+0x8f/0x870
> [  105.064614]        mutex_lock_nested+0x1b/0x20
> [  105.078641]        clone_fs_devices+0x4f/0x160 [btrfs]
> [  105.092984]        btrfs_read_chunk_tree+0x30e/0x7f0 [btrfs]
> [  105.107031]        open_ctree+0xb40/0x176a [btrfs]
> [  105.120673]        btrfs_mount_root.cold+0x12/0xeb [btrfs]
> [  105.134564]        legacy_get_tree+0x34/0x60
> [  105.148347]        vfs_get_tree+0x2d/0xc0
> [  105.162053]        vfs_kern_mount.part.0+0x78/0xc0
> [  105.176072]        vfs_kern_mount+0x13/0x20
> [  105.189844]        btrfs_mount+0x11f/0x3c0 [btrfs]
> [  105.203396]        legacy_get_tree+0x34/0x60
> [  105.217129]        vfs_get_tree+0x2d/0xc0
> [  105.230536]        path_mount+0x48c/0xd30
> [  105.243915]        __x64_sys_mount+0x108/0x140
> [  105.257030]        do_syscall_64+0x38/0x50
> [  105.270084]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  105.283382]
>                other info that might help us debug this:
> 
> [  105.321699]  Possible unsafe locking scenario:
> 
> [  105.347053]        CPU0                    CPU1
> [  105.359640]        ----                    ----
> [  105.372004]   lock(btrfs-chunk-00);
> [  105.384023] lock(&fs_devs->device_list_mutex);
> [  105.396858] lock(btrfs-chunk-00);
> [  105.409215]   lock(&fs_devs->device_list_mutex);
> [  105.421625]
>                 *** DEADLOCK ***
> 
> [  105.457447] 3 locks held by mount/670:
> [  105.469302]  #0: ffffa2270932e0e8 
> (&type->s_umount_key#54/1){+.+.}-{3:3}, at: alloc_super+0xdf/0x3c0
> [  105.494413]  #1: ffffffffc0bdfdd0 (uuid_mutex){+.+.}-{3:3}, at: 
> btrfs_read_chunk_tree+0x5c/0x7f0 [btrfs]
> [  105.521072]  #2: ffffa22750e32f20 (btrfs-chunk-00){++++}-{3:3}, at: 
> __btrfs_tree_read_lock+0x2d/0x110 [btrfs]
> [  105.549753]
>                stack backtrace:
> [  105.578187] CPU: 6 PID: 670 Comm: mount Tainted: G           O 
> 5.11.0-rc7-custom+ #55
> [  105.607477] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
> BIOS ArchLinux 1.14.0-1 04/01/2014
> [  105.638608] Call Trace:
> [  105.653967]  dump_stack+0x90/0xb8
> [  105.669419]  print_circular_bug.cold+0x13d/0x142
> [  105.684814]  check_noncircular+0xf2/0x110
> [  105.700322]  ? check_path.constprop.0+0x26/0x40
> [  105.715821]  __lock_acquire+0x11e0/0x1ea0
> [  105.731388]  ? __this_cpu_preempt_check+0x13/0x20
> [  105.747097]  ? lockdep_unlock+0x33/0xd0
> [  105.763012]  lock_acquire+0xd8/0x3c0
> [  105.779043]  ? clone_fs_devices+0x4f/0x160 [btrfs]
> [  105.795343]  __mutex_lock+0x8f/0x870
> [  105.811251]  ? clone_fs_devices+0x4f/0x160 [btrfs]
> [  105.827385]  ? lockdep_init_map_waits+0x51/0x250
> [  105.843343]  ? clone_fs_devices+0x4f/0x160 [btrfs]
> [  105.859264]  ? debug_mutex_init+0x36/0x50
> [  105.875378]  ? __mutex_init+0x62/0x70
> [  105.891493]  mutex_lock_nested+0x1b/0x20
> [  105.907847]  clone_fs_devices+0x4f/0x160 [btrfs]
> [  105.923756]  ? btrfs_get_64+0x63/0x110 [btrfs]
> [  105.939389]  btrfs_read_chunk_tree+0x30e/0x7f0 [btrfs]
> [  105.954580]  open_ctree+0xb40/0x176a [btrfs]
> [  105.969477]  ? bdi_register_va+0x1b/0x20
> [  105.983674]  ? super_setup_bdi_name+0x79/0xd0
> [  105.997611]  btrfs_mount_root.cold+0x12/0xeb [btrfs]
> [  106.011564]  ? __kmalloc_track_caller+0x217/0x3b0
> [  106.026013]  legacy_get_tree+0x34/0x60
> [  106.040045]  vfs_get_tree+0x2d/0xc0
> [  106.053904]  vfs_kern_mount.part.0+0x78/0xc0
> [  106.067296]  vfs_kern_mount+0x13/0x20
> [  106.080125]  btrfs_mount+0x11f/0x3c0 [btrfs]
> [  106.093144]  ? kfree+0x5ff/0x670
> [  106.106064]  ? __kmalloc_track_caller+0x217/0x3b0
> [  106.119249]  legacy_get_tree+0x34/0x60
> [  106.132216]  vfs_get_tree+0x2d/0xc0
> [  106.145225]  path_mount+0x48c/0xd30
> [  106.157899]  __x64_sys_mount+0x108/0x140
> [  106.170654]  do_syscall_64+0x38/0x50
> [  106.183208]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  106.196111] RIP: 0033:0x7fafa8869ebe
> [  106.208994] Code: 48 8b 0d b5 0f 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 
> 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 
> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 82 0f 0c 00 f7 d8 64 89 01 48
> [  106.250073] RSP: 002b:00007ffc04365b98 EFLAGS: 00000246 ORIG_RAX: 
> 00000000000000a5
> [  106.278571] RAX: ffffffffffffffda RBX: 00007fafa8994264 RCX: 
> 00007fafa8869ebe
> [  106.294048] RDX: 0000556726a02e00 RSI: 00005567269fc690 RDI: 
> 00005567269fc670
> [  106.309646] RBP: 00005567269fc440 R08: 0000000000000000 R09: 
> 00007fafa892ba60
> [  106.325336] R10: 0000000000000000 R11: 0000000000000246 R12: 
> 0000000000000000
> [  106.340847] R13: 00005567269fc670 R14: 0000556726a02e00 R15: 
> 00005567269fc440
> [  106.357929] BTRFS info (device sdb2): checking UUID tree
