Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB5331060A
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 08:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhBEHpi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Feb 2021 02:45:38 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46290 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbhBEHpb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Feb 2021 02:45:31 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1157d29f134853;
        Fri, 5 Feb 2021 07:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=mMidxL1z5wgmvpHP2tRHBkn6wJ06P6kujtMXymqBER4=;
 b=XgUT+yjNSXxnysn4VFhJD3buy8Zb0Me15yNCP5ljj95G4igllIRj2bxg1sYjbo9DyMPb
 z46m/lpz3eO8FmEvc/QC9omdRnAyLS9K4AFC2ItfUIPM8p11vw4242TzUtA8wv61/VSH
 nEtl3CJvOeP5SOi/gEy4cFiZB7YjJsvqkRBcnQyX2o2ELITXdEiGUe4ZtdA9G/TND62+
 MDCmFp0NPkiD0ii5P1D5VD8E9awyak/Dp3lP/uG9DuJT21ntbf7YKPkgRPiAqVuZxokc
 dHh+p/6c10vaZKLbbamJpECJo+blrOmyx5H2rhaYmzPHqemdu3AdPtpO24ej6Zscw9yQ TQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36cydm8pb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 07:44:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1157ihOm101479;
        Fri, 5 Feb 2021 07:44:44 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by userp3030.oracle.com with ESMTP id 36dhd2j2kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 07:44:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAIHtMueehvaCvbzhF1p1WLYC45TCwkWd4Df3junOfqQ77qmrYurO3s1VLHLEcVKv+7w43NJxfoBbDq0YovktTPwPjs8u5G2qOuo8Jl5sMBHQjfgYfAdzBZkRKB1cZtn5MYYQ+DZN9Qq9WyDTOs/5aXyGyU+1wx+8uFiLkiZSQRlL4liYF9EzT0LXyEjdW1UvUY5JEZsBy14cCIKjKF4oF1svCqT8vRw4KYDo02G0oVm+d+6leIYuGAL93bFaJHRkdoMkzdmwScnjEci7+RdSqpXvxoo1v4wxRHGgLfnwaL7DG5bP9586i5wRChsMJKtdyRIX93n9RAlTUVNSuPH3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMidxL1z5wgmvpHP2tRHBkn6wJ06P6kujtMXymqBER4=;
 b=RgESuIZff4wy5r0JwEfIjGBaA1+/8qUMK2fg1dE9QMB08DOlBxZYY68TNfd3S19qckSgV0xHwO+28E9kuZB16VxnHIi5A8Zh8ZRWouZR/pLByQq17YYTHgcZPMEqDU4f+COljJmaQhwHa9lI/7Keq4GhzCYVVh6Q5MO9kPRqr2z0qHC6C261flcXDr1ShiFYjG+M9TKmant5wP3/o+8yx8quPZpYdMYAE7INGnOm6nHQfFOCHOrH0sHbdFWifuuocowPJ1h4bU5zjDZtXGDgr9Rxcq1kXEof9FKCHb5TqmJWnAi2geCtz/pas5Forhuf3gK5Hcx1wCc72MmVKIVz9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMidxL1z5wgmvpHP2tRHBkn6wJ06P6kujtMXymqBER4=;
 b=OagwySGi/Y60DuHo7Yi26hsHdRY5LZdkolj2Sk9IYi03ngsjAv3OMRRNkCYa6/XsgzB1zJVPVGinAMZ3RjgDr0iASeYge/NsAx3f9RHEMvJmNVardUgAwgS+SwOH9CJJwd6ZpWsJljAOi/7yWj8PdGCmDqkKWEe3bYoH/Z+CBF0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN8PR10MB3620.namprd10.prod.outlook.com (2603:10b6:408:be::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 5 Feb
 2021 07:44:41 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3805.033; Fri, 5 Feb 2021
 07:44:41 +0000
Subject: Re: [PATCH 2/4] btrfs: fix race between writes to swap files and
 scrub
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <cover.1612350698.git.fdmanana@suse.com>
 <0da379a02fdabaf9ca295a34f7de287b5d5465f7.1612350698.git.fdmanana@suse.com>
 <169460c5-8e7b-2d0a-119f-87ef403e070f@oracle.com>
 <CAL3q7H5OOyZHja4hG8cmMOjcsOQSUKvMms9kZHG28i4GqNkOjA@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <d563cfa9-5cf2-b408-0a7f-cdb597ebc9cc@oracle.com>
Date:   Fri, 5 Feb 2021 15:44:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <CAL3q7H5OOyZHja4hG8cmMOjcsOQSUKvMms9kZHG28i4GqNkOjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:5425:9056:4f2f:9d91]
X-ClientProxiedBy: SG2PR06CA0149.apcprd06.prod.outlook.com
 (2603:1096:1:1f::27) To BN6PR10MB1683.namprd10.prod.outlook.com
 (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:5425:9056:4f2f:9d91] (2406:3003:2006:2288:5425:9056:4f2f:9d91) by SG2PR06CA0149.apcprd06.prod.outlook.com (2603:1096:1:1f::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Fri, 5 Feb 2021 07:44:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcc31ca1-d767-4800-7049-08d8c9a9e59c
X-MS-TrafficTypeDiagnostic: BN8PR10MB3620:
X-Microsoft-Antispam-PRVS: <BN8PR10MB36208840DBD6A4CCA1E201ADE5B29@BN8PR10MB3620.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gVCZTqJH50AT9mgtq+e+YzWoX0Dgh+Gf8WJ2LaxU2ZGQjOZj8Gt+wU8iUKMPDh0Fr2B+m7h/Wp/i4UWfy85RRcuOb96b3y0qW8kDeAiFhe2nIFuGXGnwTRdHDMdah0JMWPFI81LsmkhpZOak4FKOvd0cRpyVAdZFGLpqtr46uJdMhA8HckiPR9Hqmf3QYyuNkcVat0UAMCBJYNi23lX6HY5LTCPyJgeyguzXaj/IG0EqEz/gJ/PVT7N8snkL1ymGP3ehiagXgg12EISqOjfDmro749TWSzGiTIZMv7ezP5VN5j5GLT9mwRJdUrdfpdEQPWs6FpYFBSuQv34L5+dVXn+vlHrnLk4amh6kkOvJRgjE5wwGeBDcWOBGn94lvoRRY84MCSZkw8OWnub91iA1/WAzeK8k8KAIeHti9bLcFarb9mIej846BeynSi/eTYwqfw8eoVrTLQw8HTWJNE8lEovcgq/xOu6KEe42I6g1byXtMFEVhHpHN+fpFUKxRio35x4LixFsC+fNjM1dMxZizpYaHOOKc/oziyrXALPVT7HE/crRLuY3o08eHGamgj8/ex058HEazcb+gZ+32W1wp7c2khQPEy8RoCOP6E4wbZw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(396003)(136003)(39860400002)(6486002)(36756003)(8676002)(478600001)(66556008)(316002)(83380400001)(66476007)(66946007)(6666004)(53546011)(5660300002)(2906002)(6916009)(86362001)(4326008)(44832011)(31686004)(8936002)(186003)(31696002)(2616005)(16526019)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y2V5NTZmWXpnNFNiaThvNjBNS2lFVkxEcU55a1lndElxeHdseUIrNnZadmFq?=
 =?utf-8?B?YVNtU28xY2VrVWtmQmc4a2krdFZkdVVVOUU5SEVDZDhkT0tjU2VRaTVBQytz?=
 =?utf-8?B?VHFLeGpqMjk2ZXp0dlpSZG9kV3ExZXZPVjlKVXp4L0haQWNHMElUeXpzTjlV?=
 =?utf-8?B?eUN0Z2tKQnpXRGdNSHA1WGNDa3FuZWlDRUIvYktSS0JhbW16YjJsZGhhU0I4?=
 =?utf-8?B?VDRZSk44VDlPeW81VWkwSzhKb0xhakhWUnJ4UXBLQUM2Q21pL3NXY1lXN2Ux?=
 =?utf-8?B?UEVrNTE3QXlpUVZIT1VIakdzYmtsVlgxbTNjaU5VcnJ2Zi9VU1JPNDZPa3po?=
 =?utf-8?B?VTBJRUl4YzJ6eXZIVHhOdHgvY0tXb25Tem82VC9BcXE3cGlxbStPMnhVYWJV?=
 =?utf-8?B?bXJBVFg5bjU1RDBaRElHYXFOT2xTVUduOTQxeWhvS1JnZXk0SytVUUlWK0Yr?=
 =?utf-8?B?cmJxUFBPUVoveWVtUWFWWGg0WVV6RmNtaWcrN2NMcWNoaEZoaXpIT0VaRWxu?=
 =?utf-8?B?Q2RPSVF1ay9KTVRDaUxxSzBXNTVrTXh5NGptUDZGS3dJSk1pMVVQOW0zUmxY?=
 =?utf-8?B?MmhUK1NhUERvMUFWWC9qSXYwMENmL0VJMW9VL1YwemdZRWZraG9MTkJxSFBa?=
 =?utf-8?B?MWw0OWtXUEx3U01JN2RuWkNMalJKNHptSUswNXVrOXlKMTNieS81dERpYTFU?=
 =?utf-8?B?cC8zV0JybkdpOW9RK3BmRUl0LzFwZGtYV0NldmdJbi9zWS9rOWpFUGdaNHRP?=
 =?utf-8?B?d3NySUFSNGJYOE5YNUVqaUh6dkRaYXExL21MdDBnaDVKcmpnd0wzZDU3TkYr?=
 =?utf-8?B?SHdrY2pTR3Npc3JJUktrdWRjOStQSlJEaTdlcXdnQXRuejA1VGhXMTNaWmYr?=
 =?utf-8?B?Wkwxb1lFZzBDajdMWk4vdVRXQSsrTXRlempqZDBhczJuTGNwSlRmdGRuQVZG?=
 =?utf-8?B?U05DcGtIejJLUXZEcTA4QjQ2UUJyejNxWlh3QlAvOWxrRStOdE1oRHRVZ0hR?=
 =?utf-8?B?MkdkcGZITnFteDdoa1JoVUp4L05tM3JRakp2TndQMFpFb2NickRnRWd3clZs?=
 =?utf-8?B?VFFrOWR6bEM1anVMQ3RQRDJQb3JHakFRSWo4YTZlZCszbDVDaXZ6dDlOQ0xG?=
 =?utf-8?B?MUlEdCtoc0pPOEJ4dFMzaWdVdDhzVjNhVk9BKzB6Uk9aUDIyRzg5NDhFWm9M?=
 =?utf-8?B?NU9CenJOYmpwODVqT2xEajBBaWhDa1V4MjZWOTdlRkVkWnIzbE9rbW9BRGRS?=
 =?utf-8?B?OXc3N2ZkQkk5aUc0WXNmWmczRjh6RTFPQUlra0FGa1krQmdkTmVOb1FsQlZJ?=
 =?utf-8?B?SVRYbjhXSlRqNzBUQ1dQZGhZNVJZSFFTSG54UXkzdUZvZ3NRN0lkZVJtYjUw?=
 =?utf-8?B?TkJxS0czZWpPaEFmOWk3USsvZlE4eUY2YW4rNzhuTVM5NHhxU0Q1WFUwKy82?=
 =?utf-8?B?emZBaFN5Y3Y4cDFLeFNiVTA5TmtJdGpSL09lb3dFUEtaTEMvS0FjRnR2bHFM?=
 =?utf-8?B?U0Q3M0hrU1RreTEzQVdOZzU2b1JySmFHV1RXM3NwMjhwYXNOM3BjM3pYTFVr?=
 =?utf-8?B?ZHBUKzQ2TWN6OWNtUE1TbmdETk9zcVFqejR4TnJnZ01seTVrb3hBSTM4NFZa?=
 =?utf-8?B?ZU5leklOL0hiT1VzeE5Ec21PT3MvMzNYaGNydXd3eGFIZy9KdVlkR3IvSEVG?=
 =?utf-8?B?TGtQYm9RVElnNkh1bHZCemlQZ1VVNy94YmFpdVB4ZjMvMXlpN3BnWWQ1NkNa?=
 =?utf-8?B?V1dxam11R0dVM2J6dWdRRGo1aS81TklvbXFBcktwQUlhdVY0cGZORzM0SnR4?=
 =?utf-8?B?bE5RNStFMFhkSm9LN3V2cHhCMVZ2eVYzN2I3YkV2QU9YS3ZoN09LSzd1VnFY?=
 =?utf-8?Q?Foq0uad1lofjZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc31ca1-d767-4800-7049-08d8c9a9e59c
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 07:44:41.5014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FKoaLP80Y00fWaw8HYh58kCOoQx9laaAb42TZhAqGJ4avQ6qfs4oH0i0M17ZQCC8yiLWnxl/TKbr07hvkqnAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3620
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050050
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050049
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/4/2021 6:11 PM, Filipe Manana wrote:
> On Thu, Feb 4, 2021 at 8:48 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> On 2/3/2021 7:17 PM, fdmanana@kernel.org wrote:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> When we active a swap file, at btrfs_swap_activate(), we acquire the
>>> exclusive operation lock to prevent the physical location of the swap
>>> file extents to be changed by operations such as balance and device
>>> replace/resize/remove. We also call there can_nocow_extent() which,
>>> among other things, checks if the block group of a swap file extent is
>>> currently RO, and if it is we can not use the extent, since a write
>>> into it would result in COWing the extent.
>>>
>>> However we have no protection against a scrub operation running after we
>>> activate the swap file, which can result in the swap file extents to be
>>> COWed while the scrub is running and operating on the respective block
>>> group, because scrub turns a block group into RO before it processes it
>>> and then back again to RW mode after processing it. That means an attempt
>>> to write into a swap file extent while scrub is processing the respective
>>> block group, will result in COWing the extent, changing its physical
>>> location on disk.
>>>
>>> Fix this by making sure that block groups that have extents that are used
>>> by active swap files can not be turned into RO mode, therefore making it
>>> not possible for a scrub to turn them into RO mode.
>>
>>> When a scrub finds a
>>> block group that can not be turned to RO due to the existence of extents
>>> used by swap files, it proceeds to the next block group and logs a warning
>>> message that mentions the block group was skipped due to active swap
>>> files - this is the same approach we currently use for balance.
>>
>>    It is better if this info is documented in the scrub man-page. IMO.
>>
>>> This ends up removing the need to call btrfs_extent_readonly() from
>>> can_nocow_extent(), as btrfs_swap_activate() now checks if a block group
>>> is RO through the new function btrfs_inc_block_group_swap_extents().
>>>


>>> The only other caller of can_nocow_extent() is the direct IO write path,

There is a third caller. check_can_nocow() also calls 
can_nocow_extent(), which I missed before. Any idea where does it get to 
know that extent is RO in the threads using check_can_nocow()? I have to 
back out the RB for this reason for now.


>>> btrfs_get_blocks_direct_write(), but that already checks if a block group
>>> is RO through the call to btrfs_inc_nocow_writers().

>>> In fact, after this
>>> change we end up optimizing the direct IO write path, since we no longer
>>> iterate the block groups rbtree twice, once with btrfs_extent_readonly(),
>>> through can_nocow_extent(), and once again with btrfs_inc_nocow_writers().
>>> This can save time and reduce contention on the lock that protects the
>>> rbtree (specially because it is a spinlock and not a read/write lock) on
>>> very large filesystems, with several thousands of allocated block groups.
>>>
>>> Fixes: ed46ff3d42378 ("Btrfs: support swap files")
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>
>>    I am not sure about the optimization of direct IO part, but as such
>>    changes looks good.

Clarifying about the optimization part (for both buffered and direct IO) 
- After patch 1, and patch 2, now we check on the RO extents after the 
functions btrfs_cross_ref_exist(), and csum_exist_in_range(), both of 
them have search_slot, whereas, before patch 1, and patch 2, we used to 
fail early (if the extent is RO) and avoided the search_slot, so I am 
not sure if there is optimization.

Thanks, Anand
