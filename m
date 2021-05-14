Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C35B38089F
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 13:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhENLiH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 07:38:07 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42722 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhENLiG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 07:38:06 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EBZNoM098183;
        Fri, 14 May 2021 11:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=MME3YlbYbyCDSYbbX1qbJqyvWXhDLLRA25bZ/Q/Vgd4=;
 b=BVpBwLUwS7b0q4vImOywk7+15DmNFd2At6qbyBdbMhdlHhsc45iVEbt7pKU0RRVSNqMA
 4juAu+4PeaphpSOgUD0/d9ygNqcU2qNzR9lp+qDtcraAyGAyxV2Mhd17gMHeh/smB2Vz
 jMDtrpThAS6pTqGCy5tmGBWCyC4cVLMTttyJ/KuHlCEGMWCh5e3Sko0/MLlk3jUY9bHG
 CVhXoFlk6DmVpxIW/Exa9eG8hqqT5uJ//ceJszPcnE28eIzP4ll0ek/89zo+WkgIjlim
 11D6RkklM4HuSXju67oqoQW1CH52Zztqjm4Vo7Nj24aySeg+0hDA+WWr2PiauHcejYw6 3w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 38gpnem3me-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 11:36:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EBZxUE002208;
        Fri, 14 May 2021 11:36:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by aserp3030.oracle.com with ESMTP id 38gppq13ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 11:36:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULaiENTJjZ7aile80EochjVnkmhl8vyArIUE52UMN3UYGWhpxVfGJwj6gvWWimrJ65y0Lj5nYQuAbeFpBxbL5GdfovxymKwWrvFLxXtYlw94rflRizbISmHqGCXa/Nhxc6TJF/1zxdXqk0YWcT5/c0d+31Gi3RML06ZUlBZ3WzQPOh1mZFRY8EHGpWvYZKh10pXksWD0d8Ubb+T6FLeJDTdpiaVqX4tO15Y9+mO0oEDVEfiyXshTrSUq+SaYBreXsQo+32rkwfCW8oQIktXNDp0fylhlwz8aS1YBtej9hLXR2uoxiNxk/DY6Xpo9tO1cVBzGiPWznt7KM/M0H6DA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MME3YlbYbyCDSYbbX1qbJqyvWXhDLLRA25bZ/Q/Vgd4=;
 b=B7Gtbdm7FwfhLR1YiLbYKFHrVx5TqEk/h0snQ9DNauNGYGRimyfYcjY48e3b+nGMNsX2Ln8dqhes2eiZhH/sDrDvM/5cd9ky73eyAYwsZaw0YfX9RpeMH/MDEDxkTAxX8JuUnIHD3FzXj+opaN1/FVGao9Mn5xESzlue1ntOI5SjVbKLw0j22857l3+Xtl1kblTQipvFxwCmkgK34xyjOKJwekJhgG/eXv0uxq8iYv3Ad2BC1K9AHVMch/EDPJLRm+3oznmH3c2bbL1R0/GM1YYkOEXmJnk/7ACd8KrQWNIbLqLZwWfR+KBFSOj+lJPr/aeKYASq7IAHtdLvXTQuRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MME3YlbYbyCDSYbbX1qbJqyvWXhDLLRA25bZ/Q/Vgd4=;
 b=jWCAXXvz1nGAr9AypHxOJgEbPDdao2EGIo4/pfCuat0pnResDKLA15dEoGJGLNqUnxJLIJju8lBXVQ0SU8Q3I6e2IXtYOcirvo+7bU87xkuy23FZ02AJO5luXG4aQO58/Gp5MmOY5CqXKgLpB8Oq5OynB0INOMpBm2+XRTln+K0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5202.namprd10.prod.outlook.com (2603:10b6:208:306::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 14 May
 2021 11:36:51 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%9]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 11:36:50 +0000
Subject: Re: [PATCH] btrfs: release path before starting transaction when
 cloning inline extent
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <3ec5746e834bba2593b9f109a335743ac321b345.1620982607.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <b2d4303b-83a6-3a1c-acd9-393f2c76f638@oracle.com>
Date:   Fri, 14 May 2021 19:36:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <3ec5746e834bba2593b9f109a335743ac321b345.1620982607.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:a174:8492:d128:af21]
X-ClientProxiedBy: SG2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:54::17) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:a174:8492:d128:af21] (2406:3003:2006:2288:a174:8492:d128:af21) by SG2PR02CA0053.apcprd02.prod.outlook.com (2603:1096:4:54::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 14 May 2021 11:36:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8465c06-61c3-413a-23f5-08d916cc90ae
X-MS-TrafficTypeDiagnostic: BLAPR10MB5202:
X-Microsoft-Antispam-PRVS: <BLAPR10MB520269942C5463ADF111AB9BE5509@BLAPR10MB5202.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +u/6TmMCUewZ3yKcFzy/wOoQgIu9w22cERy1lJLDfnIKvtKDppke5gJdTn16wPY0wcQgP9VWw+r7Qq8NOLH3ejA2EhUiHNs5zRBGwPht2GHfUdUYN8LFV/1xqhPGd+dnDxKDNwSwzY4iIbIB3H3G1TQKVyjjS18c+p25Br+/ybpO/aKBsCNpRKTa5s/dJCVvck3pB/A3QVbrOEIr34NUPz+ougb514m1ae+PXHktfchVuQusTmUHcfpBfzGwYYdDwic0VV96n6D6h0Yk1/jN6n30jua2FCvQ9+t99nmOPxdCwnrkvKs68spvz37E8k+Bg+DoEfeCJX330ggBgZTiWJ3R3SZ+Wq04zyL895dRgUldKqgM2AwSfObpyFY7NPg3RzeoWlzIJSLodJodi6o0kGtxheQJVT0mGk0l09EfRnb8CgxjVkSiEmb5D56mpsrlC4dQhktl3JZW+kCBN65ucVTS02jNjjjA6SzwTdZDsPELmQ3QOlxsG7IecDfBSIO7ciF8mhwE0rzZYlDUfmzdZyPw5yUTfqM2GUSld+iE3QTz29b5rzmklERrkDHh5R5KnA+TTSXrI9lM2y+pKoCbZNef661RRwZ0Ob3GHIEa54ZQ76YCDTYdvj2AdzAl/3gQXijTxfAV6Ao778aOTWJ8MYZk0KMHW+YTDFfhiGTuHYgDrQdB2cyMFWo1fcQVDW1daQCmaiVBjh9NsaGq7O1AnQF4W/Gv7fp5caYRSrARakX9G8hkC7EnC0EJy+VywXgr/tTvNKWOUmVTMAnBlYtMgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(366004)(136003)(346002)(5660300002)(36756003)(86362001)(8676002)(316002)(31696002)(2616005)(83380400001)(8936002)(31686004)(478600001)(966005)(66476007)(6486002)(66556008)(44832011)(53546011)(66946007)(6666004)(38100700002)(2906002)(186003)(16526019)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QWFOSkVxQzMrZzlyMkxOK3N0NUtJSXVBell1VUVrUk9mK2NKNHVLUWRSQWIv?=
 =?utf-8?B?ZWlTVWVWOFdJbXlrUkN4YXlVQ2JLenQycnp3c0xzOUdRQlp5bzFubDFUZjJS?=
 =?utf-8?B?SUNKVURwa1k1YWZjYVlOM1RRWUVEUFlQbDlIYmJyUThHc1VOVnZacVpSRTNO?=
 =?utf-8?B?VVF0ZjUzaWJySUlWb05UT1JONUlpUmpybnRUSkR1azNYNG9iWTMzcHJBMlFr?=
 =?utf-8?B?VG5ydGUyYXhYSE0wcDlzVGxFUW1iNHBpMlhBOC9xM0owdVZkY013alRidmts?=
 =?utf-8?B?eDQ0NjhBb3VSYncyM3JVckYwSC9hNGRuci9qcnBkeTdlWTd5b0dVcldlOVk2?=
 =?utf-8?B?eFpacStLOWlKOTNnRG40TmlmTW5CVjF3R3BHc2hBR1NGRFVyZVYrOVdWLzhz?=
 =?utf-8?B?L29XSityc1ErZGNiOU0yeUhzUVM2VGs4SVRaVDR0cEhSUU1EODJVam54citT?=
 =?utf-8?B?RmpMQ1NDZWw4U015aUZmVERFelV3WUo1UlV2QUhoanUrZWQ3MlkxdjJDTFlO?=
 =?utf-8?B?YUQzVDJHUG5PcTNuRDBkajdDUFRPbUxzV1l6QXdkaEJVc1I0TkVRb0owbmkx?=
 =?utf-8?B?cUhXZTZuYzhjckxzMHVwUExvMHZHOFFBdmtpZDRHSkx2U2ZKQ05oR2FMQnBR?=
 =?utf-8?B?d3MwU2JXYUlqMHI1RWd6elJpOFpWdlI0dGdpWmNRUnp4RmVRejdVRHBsbFJX?=
 =?utf-8?B?L1I3NFhTMS9OMjhGU3h5WHh2dEpGQWdkcm5XRVlmeWxzWkNDUHpONENqWkR6?=
 =?utf-8?B?a2o4WVlodlBOQXA5M3VnUnY1ZStYcW5yQjFrOUxkZUdGOGhORG16cXlVR1dP?=
 =?utf-8?B?ekttdXBaSWdtNmJFWUgzUXFNQWx1c0QvUG4vZCtaT2RJYmQ4SWJEMEZLVk96?=
 =?utf-8?B?ejE3b3U4R3luaGwyOWJ2U29wSCt2L0xpbjIrd01mdG80ZUkzNWt5Q255MEVj?=
 =?utf-8?B?cStzZlNTcnpaaEN0TjJDQTB5dVFHK1lVeEFJK24rRlYrZm5GdzhCd3JETzRG?=
 =?utf-8?B?MktuSDJpTzgwK0xXd0M2TlRHam9kaUluNUNwMjRhOXRpQ0xjcWx0V2pDRVJa?=
 =?utf-8?B?WVg4MzVESzE1ZVdYMGY4SFpVVW9XQXg5SjhBdkttczIzbXVjK3F4djNGNUk1?=
 =?utf-8?B?NURhbWNlLy9RamVYRnl2bW1VZFNGUitjODlyOG9ETFlsdlFBSy9lRjVta0Z3?=
 =?utf-8?B?VjF4QytNVFFnMTRMY2JjdE9kdm1ZN0dvaENGMEk4Y3E2YVBNN1pKTGhoY2hh?=
 =?utf-8?B?SnE4YVB1MUFTTjViYjlzWU1JYlc2QnlWUFo1OVlqckgyNHMvb2Y4TmlGVVU5?=
 =?utf-8?B?UmFOVlVxWmNXSlk0Z0NxMzNGcTZqSWhuMUtjY2xqNWJtdUNZYWhBNFFWRzJJ?=
 =?utf-8?B?OCthOWpid2RlTUdBUjJOOGlLS3R2RS9PWlN1OGpPZ3ZMYnovMGQyNzQydmtM?=
 =?utf-8?B?WExBQU1XWkdEalRyL2MrZGVlK0FkcG5FWlBGbzM3OHhORUtTY0NPT1RvMGFP?=
 =?utf-8?B?RmlBRjZ3WG4yQkdFems4NXQxUmQ1Z1pOYS9DK0VnVVVZMWlSaFlkS0NCa3hq?=
 =?utf-8?B?dDlDdzgrWVNqOW1FNFJVcWpObS9EZVRyakcvbGFOM1BUbHpCS3ZmQ3FtM2Zl?=
 =?utf-8?B?UTQ4RW5FVVVIaVFoMUtieHR6R3lRK2ErMWZRSHFyTXhqenl5VFFnYk9GeDJh?=
 =?utf-8?B?czAwa2liUTJjbDI3UVN2bXRuT2ZIZ25jMUJKQUJHcjJyTVRBaWxlaXhxY285?=
 =?utf-8?B?WWxNUUsvVEFIbWh2eURjUUxpZ2ViYUFic2I4SHV2Sk9RUjBXcHVWd0NJYXhQ?=
 =?utf-8?B?UWlIVHh6WkN0R3F4MEhuMk9OYm10a3FBWHhZWXlpYmVnTlg5QUNzZU5tWlc2?=
 =?utf-8?Q?8ybutxzN75E1K?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8465c06-61c3-413a-23f5-08d916cc90ae
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 11:36:50.8924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqA1L9V7DAVJ8LmUJJb2G6Z7hEYBSCwgCIHq6AuJxaLSZcP3UxE7dNoCnh3n4FcVA3fjoNGP/Mr2iI8YivtJsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5202
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9983 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140090
X-Proofpoint-GUID: qdlgeVyb_W7QP1MGlyy6iz1XSYFwPgim
X-Proofpoint-ORIG-GUID: qdlgeVyb_W7QP1MGlyy6iz1XSYFwPgim
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9983 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105140090
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/05/2021 17:03, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When cloning an inline extent there are a few cases, such as when we have
> an implicit hole at file offset 0, where we start a transaction while
> holding a read lock on a leaf. Starting the transaction results in a call
> to sb_start_intwrite(), which results in doing a read lock on a percpu
> semaphore. Lockdep doesn't like this and complains about it:
> 
> [   46.580704] ======================================================
> [   46.580752] WARNING: possible circular locking dependency detected
> [   46.580799] 5.13.0-rc1 #28 Not tainted
> [   46.580832] ------------------------------------------------------
> [   46.580877] cloner/3835 is trying to acquire lock:
> [   46.580918] c00000001301d638 (sb_internal#2){.+.+}-{0:0}, at: clone_copy_inline_extent+0xe4/0x5a0
> [   46.581167]
> [   46.581167] but task is already holding lock:
> [   46.581217] c000000007fa2550 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x70/0x1d0
> [   46.581293]
> [   46.581293] which lock already depends on the new lock.
> [   46.581293]
> [   46.581351]
> [   46.581351] the existing dependency chain (in reverse order) is:
> [   46.581410]
> [   46.581410] -> #1 (btrfs-tree-00){++++}-{3:3}:
> [   46.581464]        down_read_nested+0x68/0x200
> [   46.581536]        __btrfs_tree_read_lock+0x70/0x1d0
> [   46.581577]        btrfs_read_lock_root_node+0x88/0x200
> [   46.581623]        btrfs_search_slot+0x298/0xb70
> [   46.581665]        btrfs_set_inode_index+0xfc/0x260
> [   46.581708]        btrfs_new_inode+0x26c/0x950
> [   46.581749]        btrfs_create+0xf4/0x2b0
> [   46.581782]        lookup_open.isra.57+0x55c/0x6a0
> [   46.581855]        path_openat+0x418/0xd20
> [   46.581888]        do_filp_open+0x9c/0x130
> [   46.581920]        do_sys_openat2+0x2ec/0x430
> [   46.581961]        do_sys_open+0x90/0xc0
> [   46.581993]        system_call_exception+0x3d4/0x410
> [   46.582037]        system_call_common+0xec/0x278
> [   46.582078]
> [   46.582078] -> #0 (sb_internal#2){.+.+}-{0:0}:
> [   46.582135]        __lock_acquire+0x1e90/0x2c50
> [   46.582176]        lock_acquire+0x2b4/0x5b0
> [   46.582263]        start_transaction+0x3cc/0x950
> [   46.582308]        clone_copy_inline_extent+0xe4/0x5a0
> [   46.582353]        btrfs_clone+0x5fc/0x880
> [   46.582388]        btrfs_clone_files+0xd8/0x1c0
> [   46.582434]        btrfs_remap_file_range+0x3d8/0x590
> [   46.582481]        do_clone_file_range+0x10c/0x270
> [   46.582558]        vfs_clone_file_range+0x1b0/0x310
> [   46.582605]        ioctl_file_clone+0x90/0x130
> [   46.582651]        do_vfs_ioctl+0x874/0x1ac0
> [   46.582697]        sys_ioctl+0x6c/0x120
> [   46.582733]        system_call_exception+0x3d4/0x410
> [   46.582777]        system_call_common+0xec/0x278
> [   46.582822]
> [   46.582822] other info that might help us debug this:
> [   46.582822]
> [   46.582888]  Possible unsafe locking scenario:
> [   46.582888]
> [   46.582942]        CPU0                    CPU1
> [   46.582984]        ----                    ----
> [   46.583028]   lock(btrfs-tree-00);
> [   46.583062]                                lock(sb_internal#2);
> [   46.583119]                                lock(btrfs-tree-00);
> [   46.583174]   lock(sb_internal#2);
> [   46.583212]
> [   46.583212]  *** DEADLOCK ***
> [   46.583212]
> [   46.583266] 6 locks held by cloner/3835:
> [   46.583299]  #0: c00000001301d448 (sb_writers#12){.+.+}-{0:0}, at: ioctl_file_clone+0x90/0x130
> [   46.583382]  #1: c00000000f6d3768 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: lock_two_nondirectories+0x58/0xc0
> [   46.583477]  #2: c00000000f6d72a8 (&sb->s_type->i_mutex_key#15/4){+.+.}-{3:3}, at: lock_two_nondirectories+0x9c/0xc0
> [   46.583574]  #3: c00000000f6d7138 (&ei->i_mmap_lock){+.+.}-{3:3}, at: btrfs_remap_file_range+0xd0/0x590
> [   46.583657]  #4: c00000000f6d35f8 (&ei->i_mmap_lock/1){+.+.}-{3:3}, at: btrfs_remap_file_range+0xe0/0x590
> [   46.583743]  #5: c000000007fa2550 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x70/0x1d0
> [   46.583828]
> [   46.583828] stack backtrace:
> [   46.583872] CPU: 1 PID: 3835 Comm: cloner Not tainted 5.13.0-rc1 #28
> [   46.583931] Call Trace:
> [   46.583955] [c0000000167c7200] [c000000000c1ee78] dump_stack+0xec/0x144 (unreliable)
> [   46.584052] [c0000000167c7240] [c000000000274058] print_circular_bug.isra.32+0x3a8/0x400
> [   46.584123] [c0000000167c72e0] [c0000000002741f4] check_noncircular+0x144/0x190
> [   46.584191] [c0000000167c73b0] [c000000000278fc0] __lock_acquire+0x1e90/0x2c50
> [   46.584259] [c0000000167c74f0] [c00000000027aa94] lock_acquire+0x2b4/0x5b0
> [   46.584317] [c0000000167c75e0] [c000000000a0d6cc] start_transaction+0x3cc/0x950
> [   46.584388] [c0000000167c7690] [c000000000af47a4] clone_copy_inline_extent+0xe4/0x5a0
> [   46.584457] [c0000000167c77c0] [c000000000af525c] btrfs_clone+0x5fc/0x880
> [   46.584514] [c0000000167c7990] [c000000000af5698] btrfs_clone_files+0xd8/0x1c0
> [   46.584583] [c0000000167c7a00] [c000000000af5b58] btrfs_remap_file_range+0x3d8/0x590
> [   46.584652] [c0000000167c7ae0] [c0000000005d81dc] do_clone_file_range+0x10c/0x270
> [   46.584722] [c0000000167c7b40] [c0000000005d84f0] vfs_clone_file_range+0x1b0/0x310
> [   46.584793] [c0000000167c7bb0] [c00000000058bf80] ioctl_file_clone+0x90/0x130
> [   46.584861] [c0000000167c7c10] [c00000000058c894] do_vfs_ioctl+0x874/0x1ac0
> [   46.584922] [c0000000167c7d10] [c00000000058db4c] sys_ioctl+0x6c/0x120
> [   46.584978] [c0000000167c7d60] [c0000000000364a4] system_call_exception+0x3d4/0x410
> [   46.585046] [c0000000167c7e10] [c00000000000d45c] system_call_common+0xec/0x278
> [   46.585114] --- interrupt: c00 at 0x7ffff7e22990
> [   46.585160] NIP:  00007ffff7e22990 LR: 00000001000010ec CTR: 0000000000000000
> [   46.585224] REGS: c0000000167c7e80 TRAP: 0c00   Not tainted  (5.13.0-rc1)
> [   46.585280] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 28000244  XER: 00000000
> [   46.585374] IRQMASK: 0
> [   46.585374] GPR00: 0000000000000036 00007fffffffdec0 00007ffff7f17100 0000000000000004
> [   46.585374] GPR04: 000000008020940d 00007fffffffdf40 0000000000000000 0000000000000000
> [   46.585374] GPR08: 0000000000000004 0000000000000000 0000000000000000 0000000000000000
> [   46.585374] GPR12: 0000000000000000 00007ffff7ffa940 0000000000000000 0000000000000000
> [   46.585374] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [   46.585374] GPR20: 0000000000000000 000000009123683e 00007fffffffdf40 0000000000000000
> [   46.585374] GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000004
> [   46.585374] GPR28: 0000000100030260 0000000100030280 0000000000000003 000000000000005f
> [   46.585919] NIP [00007ffff7e22990] 0x7ffff7e22990
> [   46.585964] LR [00000001000010ec] 0x1000010ec
> [   46.586010] --- interrupt: c00
> 
> This should be a false positive, as both locks are acquired in read mode.
> Nevertheless, we don't need to hold a leaf locked when we start the
> transaction, so just release the leaf (path) before starting it.
> 
> Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Link: https://lore.kernel.org/linux-btrfs/20210513214404.xks77p566fglzgum@riteshh-domain/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/reflink.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index f4ec06b53aa0..ae3fde71defb 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -291,6 +291,7 @@ static int clone_copy_inline_extent(struct inode *dst,
>   		 *
>   		 * 1 unit to update inode item
>   		 */
> +		btrfs_release_path(path);
>   		trans = btrfs_start_transaction(root, 1);
>   		if (IS_ERR(trans)) {
>   			ret = PTR_ERR(trans);
> 

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Nit.
It is better call btrfs_release_path() before the comments which belongs 
to the btrfs_start_transaction() as shown below.
No need to send a reroll. Maybe David could tweak it during the integration.

--------------
@@ -281,13 +281,13 @@ static int clone_copy_inline_extent(struct inode *dst,
         ret = btrfs_inode_set_file_extent_range(BTRFS_I(dst), 0, 
aligned_end);
  out:
         if (!ret && !trans) {
+               btrfs_release_path(path);
                 /*
                  * No transaction here means we copied the inline 
extent into a
                  * page of the destination inode.
                  *
                  * 1 unit to update inode item
                  */
-               btrfs_release_path(path);
                 trans = btrfs_start_transaction(root, 1);
                 if (IS_ERR(trans)) {
                         ret = PTR_ERR(trans);

--------------

Thanks, Anand
