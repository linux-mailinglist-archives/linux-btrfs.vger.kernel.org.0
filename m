Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0FD36F8EE
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Apr 2021 13:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhD3LHz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Apr 2021 07:07:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36156 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhD3LHy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Apr 2021 07:07:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13UB47tl095613;
        Fri, 30 Apr 2021 11:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Dj2wdphxOhwaEisr1aA2L6pQ9VbhzZ0KR6kdmbD1XQc=;
 b=r1Wc5c8pw1sKXQErCCwK5F93CIY2copxYM/8TDLEVCNx1C1Y/5c3WMh2WaziZCIxwoIY
 8/o0bS3l83WjXOq1bV0FEaZj8RcqKRyu4v+eTB7fefptL20zddlcr6/I7D7j+lgbdPsh
 43poZC3WNe9+y29y2I+Pcff95Hj1Ol/+TQAWlavYfbE3cWpxoVACIez1Bqj4uxf9m57K
 oF9R+ncEt59lQwxbvtE4PsFLpUV6FQeOfX8JBGJJmGV1QryUvogGfI/r/brY2gUikaMp
 ydt0OcRLHdO5t8uMneeNHlsw9arH3xxNFUYCJaqlRJl4SEEWg/mucDqaeikYTifJ8Spj 8w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 385aeq7c72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 11:07:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13UB4nSK095896;
        Fri, 30 Apr 2021 11:07:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by userp3020.oracle.com with ESMTP id 384w3xnpc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 11:07:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLxuueI+Ap8xrMdHRQVJJHIko2BGzjzjHcwL6CV/flTq5S+MCLVLZ3vq5Y5Wcrj5EbgC0UPZGj/zTK5Q5lrDyH1XEcRPDQrL81ieHrJ/isuuypvgRHbJ8in6KXwxjE2ZP5qFiiUw23t27JdYKAlM54nnrmSy/OSxN307AEYvsMAKJOZul1NiB4NN5oNPxM8gqWfguFYtUVG2Vi7sIDzEYrQyxf7cpD+7IFUGazzqKtkTzs+gqxDP0Kx9tAWtHwpGAoWwBbsdVleY8XSyMmgFoAxTjbIdBPrRJSV0+8qqGowBSH80bLLhpYkFGELZylS337TlmZ1Bsa965BwZRH7ndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dj2wdphxOhwaEisr1aA2L6pQ9VbhzZ0KR6kdmbD1XQc=;
 b=i3fl1Qei/TYMCMLtoR3dcQ8z47ACz0S0gFwNuROIKmBsIfCC/N621m0aM090nCKx+rUxEQFkC9xaKWJvZrzw/N9WO0LfGzefjA6saQTe+THhs3i1txbsIv6pqlDbmu1dBIFPb4UXYx/Kja4Wb2ADiIPXLXBz4SKxnVbTNvJUHPRkSiqf98y2anmkBiJ5rIFpTmy6vgZPjydW8CKxly6la1MGnrjhN6SHnwOYGnRwl5pPzPy7/Dikg0GFuyPFlG4j/xlN+jf8ARvaH+L3pLAiCscgDC74o9y7oGn+r65IXH1fKk3jgQA32KA9wNgMXP7g1fBB1b0pdgG7ues7s07zgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dj2wdphxOhwaEisr1aA2L6pQ9VbhzZ0KR6kdmbD1XQc=;
 b=JLfYI08qFXE8nsVNcpIioT0aEtEi5S4crJ1KS8IShpMKnBf1AELZAN61gEwtUg5fzCYkiZoxFFDrRUXuvCumMg7dmcstYxNHLa9C/kLi/GdlkQgYrb3M3VXqvwrz3XSFMlIdkyOOOj02gRc5a0pXrrUfLpKSyTu8Sr6YunnHo5U=
Authentication-Results: colorremedies.com; dkim=none (message not signed)
 header.d=none;colorremedies.com; dmarc=none action=none
 header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3792.namprd10.prod.outlook.com (2603:10b6:208:1bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Fri, 30 Apr
 2021 11:07:01 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%9]) with mapi id 15.20.4087.035; Fri, 30 Apr 2021
 11:07:01 +0000
Subject: Re: [PATCH] btrfs: fix unmountable seed device after fstrim
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>
References: <c7715d09a67f212e0ecb5fea2d598513912092f4.1619443900.git.anand.jain@oracle.com>
 <CAL3q7H5EZFoOCz_WBOwn8vnhFouCrqV1S9pMJ+KpGYbERJZRyg@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <f5302804-db0e-8275-d3f0-b38a56add372@oracle.com>
Date:   Fri, 30 Apr 2021 19:06:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <CAL3q7H5EZFoOCz_WBOwn8vnhFouCrqV1S9pMJ+KpGYbERJZRyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.28 via Frontend Transport; Fri, 30 Apr 2021 11:06:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7f0d3b8-92f8-4d06-97bf-08d90bc8141f
X-MS-TrafficTypeDiagnostic: MN2PR10MB3792:
X-Microsoft-Antispam-PRVS: <MN2PR10MB379240AECE98C9BB2C6DB66BE55E9@MN2PR10MB3792.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eiOev+eo7eLCSu0zyGGTo7T0PAqCHh6UST9zqj4UShpKn0ey5eQ9xaVudpAX8Odjj5mAI8iyQvisCm5ob/KXzo8mFv0dGL2/FtiwYpj9LGJp9atbq+gd51jGRS08kApvbXMyIUtstYNrChWDIL/bFL3NOvhseVkYHi+5pBrEO1ZLE3MQS93RLay4zVm/Q9dHRD8eZsIH0K3GUerYqmPb2RsiSRGl4FHLyQcrM7Z2WlxicVS+t2OWYPiuCuV/PMDA6H8FMg3mL7Ej7S5ByptxqJ7Qrdw1h7tciEKcBzK1736W0CmK+CqG/UM1fE6Zi25TEDkEgcPbGbe6uJpRvvfaPq5Bfnv604ACQPkS64APX4ccZJoJSQAjG1PGvKXHhfd1jj8Wyecnl7D6BRgaLqXHL/pDNShea5PnxRqShb55LuSzOG0bXtZdlfCmcHdO7yfgguqM/dsfKh88gK8Zr8ONjNdJMsIlDiwGnBTm4jwQpZZJ6iiBI0DWRUvY17ssdyOJ4uRu3ZihWJiZzh2rKWDLL3sGVMqOcvYNhgI54oogNswkuI7RQtSfbiRShDE1autVf0bBQKenQAxmzSYjgB+Cd2B4VThREEimMzvhKZl/8M+WIJWZvhmvaNmpP1PlKerQ4bTXOFT2BEApFPVRTHgBAMNR3a7Jc67N9PV97z12nXYI30/MfhQGXxKiUTuZH9Zb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(396003)(346002)(376002)(83380400001)(36756003)(316002)(16576012)(44832011)(66946007)(5660300002)(66556008)(66476007)(6486002)(2906002)(38100700002)(478600001)(54906003)(2616005)(6916009)(31696002)(956004)(53546011)(186003)(16526019)(6666004)(31686004)(86362001)(4326008)(8936002)(26005)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TjZLVVJDWTNZbUdGZzVXWk9PdjNrOVViZU9ZbFlkQ0VyTTBqWXJrdGVpTlFn?=
 =?utf-8?B?SitNcWttZG9Qcm5GdG41ZkhDSjN5dmlOcTZoQmZiV0NTNk84OTM4L0dRcGYz?=
 =?utf-8?B?a3pjdkdCUnJGcXN0VUdwK3Q3OXovdTUxblB6bEZwM3A1VGlSSHpta1crL1VP?=
 =?utf-8?B?RjI3cEtDTXE2dEtwcUlFMGJUYnk2bWtvdFVGeFpUemtDMG9RRUtUc3RIZHVE?=
 =?utf-8?B?QkpzT3luUmxnZG95eUdSL2hORXhLS0NHOTFiME1wN044NUcrUzRaZW5UMmgr?=
 =?utf-8?B?UmtkdUZUb0paQlpwVjdTRzRkWXhLcTViR0NLMHlyMW5CY1dQeXVnWStpaEZI?=
 =?utf-8?B?RHc3MkRyL2didjF3L0ozWUcwQ2Z3YzhMd3ZDekVQblZETXJCOG1SU3FhSnEv?=
 =?utf-8?B?ZktTajQwWWFDbTdaZU5reUtSOUVpOTcyZklzcFpkNXFlS24vSmluODB6VlBo?=
 =?utf-8?B?OXFBcit5a0grb0JLNVlzU0kwa3RtN3R6OS96TTZqazMwYy9QemJCSXQvZWor?=
 =?utf-8?B?VmpnTnpRa1JCNm53V1E2NmMzdzA3dEhmK1lOam9pUmR2cmxhOGNncmlvL3FC?=
 =?utf-8?B?QzlCMUZEQ29mb1NVbThLWnV5NlNtb3dydlR6UHVUM3JuenJvS3dMeEt3R05N?=
 =?utf-8?B?MHhyaE8rRFEzQ1RBR09iSm90WVltYUV4bXduaVhSd041RG1VMThOQmFTN2Rt?=
 =?utf-8?B?SzFmQVR2c2xCdmxTay9oQzRoTWtiS2UxMzQzYlBFQzZNSmJ4a2d0VUlDV0p0?=
 =?utf-8?B?dFZkRXFERnIxaUtvSWZ2M21xblFhaDdkam5ac2JONmxldytFNWIybytndHBL?=
 =?utf-8?B?YXJUTVM3MTlFWXZQcEhGTXVHc3gzMWRCelJhbUpjK1kxRStqakhreGtqdnZs?=
 =?utf-8?B?eHNENjBTNnRwRkJrZ0VxTlB4RnNiMTFpTWhRNTJuRGtqaWFZSEZWdHkxaVc2?=
 =?utf-8?B?Y2QxUFFYMFdSdU5FczJzbHhHWXhBeEtpZlpOdFA1aXZzRm1ud0R0Wi9ZcmZP?=
 =?utf-8?B?dzh1RWRWekdPL0psM0puN3EwTmVSMHhUdEZNNHdOd3Y1bU5mOTRHcXRwZ1Jw?=
 =?utf-8?B?T1VBcjJTUnNGczlkSVMvcTY4aHFiWjlsZDVXUlJDWmh1cllqT0l0ZUt1U21V?=
 =?utf-8?B?RzMzS3FwSWtlSW5CWjhmc0lkcGV3aWFoZGd1T2R5K0ZzZjJaWE9FclgwaGp1?=
 =?utf-8?B?QjJJNHVDbm5NZWRuVzQ0NUorTGYrQzhHYTNBN0xLaEFjSlBtNHZobHNDcEpX?=
 =?utf-8?B?UUtOVElUMm96U3ZnWm0zSjFlTlY5ZnI1ZFFPMWUwUkpQSFFibGZ0aGk1azRz?=
 =?utf-8?B?UGlVQmg2MWJtN3p4cHpJd0dpZi9oNlhlOGdmdll0bU1Mc2tHa0o1aERZVVdB?=
 =?utf-8?B?dkJDZ3BpcWw5UmgzeWN4TXh0L1duOHFvcXhzYnJvQkpTdzFQR0VzeTFHb2Jz?=
 =?utf-8?B?Tml1ZEFQNmd3TU0zSjdNRkYxMlRHbU4wTXIvcWVKMTl2MmRCVEZwK1QrZ3Fu?=
 =?utf-8?B?L053YStGSklOTzFqcW4rbENXTjNJeHhSTVg3WjUwU0xtV1hEMGtad3UvRmtC?=
 =?utf-8?B?enZua1Zzc3hyMnN1WG5oVWRBcVJOL0VlYlo3RkJ0MW5IVWRzb0xJSTNLOGFv?=
 =?utf-8?B?NjhqYXRNM2tqZWtDWTkxbmE3a2dEL09kR1JSSFBsQ25GVXQ4dy83OTlYVlI0?=
 =?utf-8?B?V200VzZ3QUJvQnFJUCtGSTdsc3cxRW14eXhEOGZqQVhWeDEreFFMNWZ1c1R5?=
 =?utf-8?Q?wXdgwBXWYXiF1R6lUyIyk/S/qr6mE7H5c0NsSEa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f0d3b8-92f8-4d06-97bf-08d90bc8141f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 11:07:01.0327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Bnf5OAC2zXhYGp2tGCusIfW73zRFiPZAXyOqSM83REpe2bcAALis+I3oHLca3krIv40BlWSSlKFVv5F2WpuLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3792
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104300080
X-Proofpoint-ORIG-GUID: dRAFNutBtmAOG3VppPtDEjim_eSgw5fS
X-Proofpoint-GUID: dRAFNutBtmAOG3VppPtDEjim_eSgw5fS
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104300080
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30/4/21 6:11 pm, Filipe Manana wrote:
> On Fri, Apr 30, 2021 at 10:14 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> The following test case reproduces an issue of wrongly freeing the in-use
>> block on the readonly seed device when fstrim is called on the rw sprout
>> device. As shown below.
>>
>> create a seed device and add a sprout device to it
>>          mkfs.btrfs -fq -dsingle -msingle /dev/loop0
>>          btrfstune -S 1 /dev/loop0
>>          mount /dev/loop0 /btrfs
>>          btrfs dev add -f /dev/loop1 /btrfs
>>
>>    BTRFS info (device loop0): relocating block group 290455552 flags system
>>    BTRFS info (device loop0): relocating block group 1048576 flags system
>>    BTRFS info (device loop0): disk added /dev/loop1
>>
>>          umount /btrfs
>> mount the sprout device and run fstrim
>>          mount /dev/loop1 /btrfs
>>          fstrim /btrfs
>>          umount /btrfs
>>
>> now try to mount the seed device, and it fails...
>>          mount /dev/loop0 /btrfs
>>
>>    mount: /btrfs: wrong fs type, bad option, bad superblock on /dev/loop0, missing codepage or helper program, or other error.
>>
>>    BTRFS error (device loop0): bad tree block start, want 5292032 have 0
>>    BTRFS warning (device loop0): couldn't read-tree root
>>    BTRFS error (device loop0): open_ctree failed
>>
>> Block 5292032 is missing on the readonly seed device.
>>
>>  From the dump-tree of the seed device taken before the fstrim. Block
>> 5292032 belonged to the block group starting at 5242880
>>
>> <snip>
>>   item 3 key (5242880 BLOCK_GROUP_ITEM 8388608) itemoff 16169 itemsize 24
>>          block group used 114688 chunk_objectid 256 flags METADATA
>> <snip>
>>
>>  From the dump-tree of the sprout device (taken before the fstrim).
>> fstrim used the block-group 5242880 to find the free space to free.
>>
>> <snip>
>>
>>   item 1 key (5242880 BLOCK_GROUP_ITEM 8388608) itemoff 16226 itemsize 24
>>          block group used 32768 chunk_objectid 256 flags METADATA
>> <snip>
>>
>>
>> bpf tracing the fstrim command finds the missing block 5292032 within the
>> range of the discarded blocks...
>>
>>    kprobe:btrfs_discard_extent {
>>      printf("free start %llu end %llu num_bytes %llu\n", arg1, arg1+arg2, arg2);
>>    }
>>
>> btrfs_discard_extent(..., start, num_bytes, ...):
>>
>>   free start 5259264 end 5406720 num_bytes 147456
>> <snip>
>>
>> Fix this by avoiding the discard command to the readonly seed device.
> 
> Quite hard to read the changelog.
> 
> It could be better organized, indentation is screwed up in many
> places, shell command lines should have some prefix like $ or # to
> make it clear what is a command and what is the output of a command,
> missing full collons at the end of sentences, sentences not starting
> with a capital letter, etc.

   OK. Let me try to fix it.

> 
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> Reported-by: Chris Murphy <lists@colorremedies.com>
>> ---
>>
>> A xfstests case to follow.
>>
>>   fs/btrfs/extent-tree.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index 7a28314189b4..0d19bd213715 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -1340,12 +1340,19 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
>>                  stripe = bbio->stripes;
>>                  for (i = 0; i < bbio->num_stripes; i++, stripe++) {
>>                          u64 bytes;
>> +                       struct btrfs_device *device = stripe->dev;
>>
>> -                       if (!stripe->dev->bdev) {
>> +                       if (!device->bdev) {
>>                                  ASSERT(btrfs_test_opt(fs_info, DEGRADED));
>>                                  continue;
>>                          }
>>
>> +                       /*
>> +                        * Skip sending discard command to a non-writeable device.
>> +                        */
>> +                       if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state))
>> +                               continue;
> 
> With such an obvious and easy to read conditional, the comment is
> completely unnecessary, it doesn't add any value.
> 
  Will remove.

> Other than that, the fix itself looks good.
> 

Thanks

> Thanks.
> 
>> +
>>                          ret = do_discard_extent(stripe, &bytes);
>>                          if (!ret) {
>>                                  discarded_bytes += bytes;
>> --
>> 2.29.2
>>
> 
> 
