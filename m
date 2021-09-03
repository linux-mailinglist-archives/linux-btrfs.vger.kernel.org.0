Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076343FF906
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 05:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345947AbhICDJh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 23:09:37 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:16956 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345711AbhICDJg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Sep 2021 23:09:36 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 182Msaf2020819;
        Fri, 3 Sep 2021 03:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/29XI0080T6Ck9cy+J4EQzakTsgabGiQ+GkiniI1Cl0=;
 b=eT4/oiOPTbu/AEdb1XGD7r73VdRJfuLajYVVlKi1XqUrntkXQu5QNYEHb2WMjeWtLlY3
 Vqo24kmteoDA9ItHSR4uzT+IF5D4yEGBXCqgN5WElqwkpMd1pX44mg5KObt8qVtFCAdZ
 VvYaTrlOfoZlVcihhHHANcngqxcm7oPu2JYzC6hS9Rf57ekEaxar4HU5plLqzYbVgcyL
 +18hMjiJ7qcmQaZ2L0MlM6veuY+9Dy5bEwVI6gIkkzMrAs47KS0V2Pymmto7gotkhpn8
 JL5cEwhTWNYqMljoecGLg++PsL+0TqbL5T0lmBt9gK8YAwuSibqR1GzUYPJIpsOj5Qk7 bw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=/29XI0080T6Ck9cy+J4EQzakTsgabGiQ+GkiniI1Cl0=;
 b=lZM7yVR1IBwh2oWExdccIKVtoTQXsCFr+Sno3jUN/SJ/Jt9kNYd2Lp5nekmL9A7Rr5Wp
 IJ5CJb6GpaBXjObaoX9ZWmtV6OGETwyUwPeW8y0Do0zbWgw1bfR348dzbKNGoKkFRvsP
 6ecqtGnbEUJB0k/6nXYpOi0STwjNxRWSGwmGBB1UC2Zllfbk2k7a27IgotKQ5Gy11w/k
 M3dJdRbqA+1DEoyMN0wP/K7UcRNMmAoi61jpr7HjGmt6ZEfX33EVSvcu069kQTxgm20B
 ozIxAgoQIJou9mkYh0woKjHQUlB9tE6J3SMBQaf8dFLImST7gFN9wk+be5FWJzAJq4Wa LQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw0mky0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 03:08:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18335wwx131560;
        Fri, 3 Sep 2021 03:08:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by userp3020.oracle.com with ESMTP id 3ate00w23s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 03:08:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5TEt6/f4p7IK2wQ7QGKw/N6ClHiOXHF0vlAL2i+8xMAaf22AWfAorAi21YMzwwHSKU8DRWsPaxGpE1ytoiUDZBznm1e4jln/vTMWpVbpXEtbZ6Y7pYJecJXtjwmXwmNANJKK6ixwkBgAbSmvlULuZsv+wZH/24HzPJziN1l+BcfbIp5fVPh9iT2ljll7Mpy/lipCdZSX4WMX0UFq+x/3j+grDJNCwgCK+ustrVsOEVyRlhGHwOdXtqUi5ADW+gksdJO361/bxDm6GHfsOw2RlEAcsCIg53eI5wNwcaBdSlIpoRQCerUKXi6LTpBDAzK07CsM083xssUiHapS3nttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/29XI0080T6Ck9cy+J4EQzakTsgabGiQ+GkiniI1Cl0=;
 b=gMAzIFJQvdjsE8kWcIdNOAm6ojQcz4Wkpscxo4vskyRa4gVWwJJGbN/mxzIuPUAdEVmINh70DmJg/WP8TwUTOUXpcuvjzIL6Rrly/TF7UZfMk+SKioA6jspCmI9f+Tj1okb+8uwt0DIE4F5ZmP7vRtgulZaxxVM0p0DsR3Hcgx0gOWKMDW5qbLQ5vJJHOJcM0DDsiJQY4PgqZpLiP8FRJpu/5N8+6NC5ByCVzo+jHMn1G9bB6jdHYMb4saO+bOeyGwPLZg7f1hWsH+P92nzhYvgfxvfFD5b1BEg9xP3r+tV2Q+V1wYUMyqumK6WeQsIfx/bAYuMjtGYj95aFzRAU+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/29XI0080T6Ck9cy+J4EQzakTsgabGiQ+GkiniI1Cl0=;
 b=M47DsD5K73i3Zpfq2lyQdBK1FYH1hdI00szfz6qPArolKXdCHdM1iJcNite/vbqX1MkfYRLKhEjEdS/0FLf5dnuVpRJbEKkig+Z3oroaq5q4cx8wYDaOByckn0bLHWKDMmG7VDRcY7yZ6tQ6PixkoICZ3aQFZtXpZo94VORx2DY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3838.namprd10.prod.outlook.com (2603:10b6:208:1b8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Fri, 3 Sep
 2021 03:08:27 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%6]) with mapi id 15.20.4478.020; Fri, 3 Sep 2021
 03:08:27 +0000
Subject: Re: [PATCH RFC V5 2/2] btrfs: consolidate device_list_mutex in
 prepare_sprout to its parent
To:     Nikolay Borisov <nborisov@suse.com>, dsterba@suse.com
Cc:     l@damenly.su, linux-btrfs@vger.kernel.org
References: <cover.1630370459.git.anand.jain@oracle.com>
 <f00bad4ba0e8fd7f0c46c21118537fd49fd3c359.1630370459.git.anand.jain@oracle.com>
 <ca0f8867-74ff-9130-f69f-0f7972540be0@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <4f4e36cc-d377-abde-2df3-759f85867482@oracle.com>
Date:   Fri, 3 Sep 2021 11:08:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <ca0f8867-74ff-9130-f69f-0f7972540be0@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:54::13) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.109] (39.109.186.25) by SG2PR02CA0049.apcprd02.prod.outlook.com (2603:1096:4:54::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Fri, 3 Sep 2021 03:08:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5692399d-0695-4c29-11c5-08d96e881950
X-MS-TrafficTypeDiagnostic: MN2PR10MB3838:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3838ECA7BD6291424A81FC6CE5CF9@MN2PR10MB3838.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cYdny00g0bgp4gAgfJQQgddPv+cnNuzpdBuqKcXmQkdKvWSL7c/sMBxjlUa9cCQk7tOu7+K1AWCJAaAigaDSoknoGkRoQ45WA/WGRrYfIQy8ZXl31JzG4Cgh9MP50YSqpshfw3dAB5eFt3kudjSjRREtWnB3fiwqh2fC5hLTcbq8pKoOnnsJtqK3G0J47cMgBSo8PGYuNCE21dEs3uaK1x3QxihDjTF9FRxeOogqIVkXoDrQrDV9wRW28EOTsy8GXk3CI9WdstfBp3iPiHmT1Rtdsi+1byFXyeXlLrfTFR1eAlFhmh1k6ubwJgwTDvLaAMaJ0FlyMbaywQP//+AuyG5IFXJ1Tjt4EPvQjE3JEuISqSyP3oS7BmZnucbMjKTQe2kNxNxDIbuB4e2I/cn+n+yiZhYaUyO/4znwe5N/JnIGsQxKH8fpHHFvL0RI1zhmJzr8ZOGPcN36pXXCwW2xw6zkRR49LWFYfzfGFlaL2qQ9cc7ua3fO6VX5Q2F1jtHNDDSnqbJfgvuoM1zMHdcZB1H2vwGhl3g70O1PnF2sawKRfu3kRZv2elbOgfK0Uh5Ukqi0v3OcXVRRM7GZfJfTRQIfH5DGkyZfFKMpd8d6HwDSoELZyH4tEjk67OnmthiMSLLnpnnqcD//EoLBuBpJu0pkWh4SvdLVR0OD8CTjcF2Qyhbt0aonYmC08WBgzjmItQ6Fe65Q4qCh48nS4qGY6hjGUJ6vgtpinrN+4uXlkKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(44832011)(5660300002)(31696002)(956004)(8936002)(86362001)(2616005)(38100700002)(8676002)(316002)(36756003)(4326008)(16576012)(66556008)(66476007)(31686004)(66946007)(508600001)(53546011)(186003)(26005)(83380400001)(6486002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dS9URWZoNFFXZFV1RU1sTzd1dE8yZG1KSjhjM3J3SEx3ZnJYdTVSeld0T0FD?=
 =?utf-8?B?VDl6elBJV1VqTjE1SHFyVmtIaElua3ZDM1k1NW11T1FlbzVSL0xNeVVnRTBz?=
 =?utf-8?B?Ykd4Z3Z0T2JyMmpsV24wWnJjSkdHMkMvbmkzNGQvbm9KTG5CMDhoMjVLYTVx?=
 =?utf-8?B?NkIrQ1BWSUlzVjZvcWFtcTB5Y0MxODhlY21NNjkxWW5zTWtsRlZnY09RelBi?=
 =?utf-8?B?VitOTWRnSXFYVG9pM2JLcG03Njl3d3o1UkhoTStjcVlocFVCbFlmazRUKzhY?=
 =?utf-8?B?R3hPRG5NVnlLYTBmWUdsb2pHUTFxZmJaMmFuRnVUZjFISzRPK1ErZmNIK3Uy?=
 =?utf-8?B?YmZkSFh0TlBKYWo0SGxSbGxxYkFidjZVNnVQa2Ztb2d5REdBKy8xT1Q3VmhC?=
 =?utf-8?B?Rmh1WGduMEhjTW5kdmVMQytENk1wWGdvVUdWTS9GQWZmQlVjamJkWG1acXNk?=
 =?utf-8?B?cUNGd29ZZFlVSmRieEdaMjNkcW50WlBzSFN6WU11WUNmS0Exb3F0M29XT2cv?=
 =?utf-8?B?aXJTMm5wRVRLS1ZFSFVXdXJFVlNrZjhTTnVEQ2x6QzhsNFE0Wi9qaEtTUWE2?=
 =?utf-8?B?eXBMN3FhbDdBY3JYdllZb0o0MnFtdzJ0dHBuQWtCQmdCN2lGZG1CYzY3ZURR?=
 =?utf-8?B?aUVVeDVmVFNXMlQwVDNSYTJTYmlUb0ZXMVpWWGtPU2MwRGorby9WWVZnWENr?=
 =?utf-8?B?TTRQYUVaWlNManJsS09VWkpVNHlQVzJiak5wdHVWaFhoSmJNZWl4YnJXaVlR?=
 =?utf-8?B?VGVpOUxrYUtIOHc4cHdpUnhpbzJ3dUJmSkRYUEZiaStEZmxPM0l5YjN4aXlr?=
 =?utf-8?B?K2xNNmhienE5QXRIcHFsQ3JSbHE4cUNIQ1hZdHRYWG92dkRKdVV6RGl6SkVo?=
 =?utf-8?B?cTBsUFNnZW9iaVFQZFd3dDVxM3ZBUFJTRXczSU40aGFTYzFuaGpMalBicCtt?=
 =?utf-8?B?L2lpb3RyZjBOVFA4ZWlpYlEvRlNpMEVPQkFRY0cwd0p5dmQ0aXI1TkhjRW14?=
 =?utf-8?B?K0xSR0FzMHhaNjBJZEFRdlBud0F4eVdwRjVNelRYVjlNb1VZT2llVVd0bmdF?=
 =?utf-8?B?TERPcDVSZ2pKUEx3VFZzdHAydG9jZ01kN3NsU1RxTURKUWJ2ek9HWDdVTjR5?=
 =?utf-8?B?Mm1UR0w0RmlCSjhGMWFTMmpXSGVRZ2xDMkFhb0hiMXNqQnRsYWdXUHYzei92?=
 =?utf-8?B?QllLeUV3dEw0UUlQQUZoQ1lqMnJObTJza280QVJhbTZTWUZJMU9rQXpSYmxu?=
 =?utf-8?B?T2M1VDdQaTNzZFFZVi9pVnlxL1NJLy8wZGFuZ1RURWk4V1IzRjJPcWhHcmF4?=
 =?utf-8?B?Wnh2VE9vZEtQMjcxNmFxQ0thallHQlMyV21Sa2tLVkdCM1lSZ3kzTmlPUnM0?=
 =?utf-8?B?Qkl0UWxDU0VyRDUwaWhSbkRPZkxYM0xpMVJRTXM4Q2pTVTMvN1djK0hKYVlV?=
 =?utf-8?B?L251cHRXZFlSZERYMFBqOW04YTVpK3krWGpFamdidDRpUFg3Vk9MWS9Tb2la?=
 =?utf-8?B?STVENnJ5M0c2NnFUc2VpN0NPQXVMcFhsSnpNU1ducWpRMUNHL3k5RFZyanVv?=
 =?utf-8?B?YlQ5SHVKd2kveUxxbTkzc1d6UjFjYnhZSjg5Nkd1WXdNbnBJTjNaS3dGTlgw?=
 =?utf-8?B?RXZiV01jTTdDWW5zdlJBWWNZTGlYeVdnV1pvYlFCVUMzWVZNVzh6azd6OXVY?=
 =?utf-8?B?djBIYTVRRXUzdFNta25Xb08xSFliRjJFcERmdGdmZ1hTTlM4b3VsT1ZoUnZI?=
 =?utf-8?Q?HQ305aC/v+6hy/cOAPsYhbOJEKyIh+JKJ2hp7lm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5692399d-0695-4c29-11c5-08d96e881950
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 03:08:26.9558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EaBY5B0JiT8rOsJpRSyhAELETwNR70cvrYqREHQ0sawegUg3Zvm1+8NqMbrN8h2iGGoOtUZe/kN6xo4rKxZag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3838
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10095 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109030017
X-Proofpoint-GUID: kR8K36vifLgpkllygrGOLHnZeBRDLC4y
X-Proofpoint-ORIG-GUID: kR8K36vifLgpkllygrGOLHnZeBRDLC4y
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 31/08/2021 21:03, Nikolay Borisov wrote:
> 
> 
> On 31.08.21 г. 4:21, Anand Jain wrote:
>> btrfs_prepare_sprout() moves seed devices into its own struct fs_devices,
>> so that its parent function btrfs_init_new_device() can add the new sprout
>> device to fs_info->fs_devices.
>>
>> Both btrfs_prepare_sprout() and btrfs_init_new_device() needs
>> device_list_mutex. But they are holding it sequentially, thus creates a
>> small window to an opportunity to race. Close this opportunity and hold
>> device_list_mutex common to both btrfs_init_new_device() and
>> btrfs_prepare_sprout().
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> That's a moot point, what's important is that btrfs_prepare_sprout
> leaves the fs_devices in a consistent state and btrfs_init_new_device
> also takes the lock when it's about to modify the devices list, so
> that's fine as well. While the patch itself won't do any harm I think
> it's irrelevant.


  This patch is for the cleanup of the device_list_mutex.

Thanks, Anand
