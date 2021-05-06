Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7996C3753F2
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 May 2021 14:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhEFMjr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 May 2021 08:39:47 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:42805 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229777AbhEFMjq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 May 2021 08:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1620304727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wDSnS3cKhKD6zzOR/3m0+o053x9Czs2EdoyMwIFSpiU=;
        b=TFD2xrZlsIdcu7VlWiZbz2cC8ZeFn/Tv6QZacVjHFnm0nz/cibgH/zY/YgwnayB/ANh86c
        MHEXl0+s64IwKmYm5Ap7mP+SHqeu/HrpPElNLkw2HrkW4JHV3SOoGwHr1Pa9vpdZ8vj4rJ
        rVMEjKbLu9domJjHM51U6Sx68XPSBpg=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2058.outbound.protection.outlook.com [104.47.10.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-15-ecVOje7sOUmsg1NT9t3KIg-1; Thu, 06 May 2021 14:38:46 +0200
X-MC-Unique: ecVOje7sOUmsg1NT9t3KIg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuxOokPEa7+Hmcm2lgn9aivDZQXTgrU7d+P6a/uj1e5Pcg0+2j3oeF3gYuNUgMlV4ouAQvPLeov3tLBHmnxJgv4xUtricGRPQfUmauzM5hYFLBVfPE1Cisvz+0m4PTLhceyWY038rIjCz62Lqd+6Ew6Erpp0SfM4dVSh8IAOY7hcL+0/yMpvFidKw4POAjVN1JR6odkYHpIn6E+4jMrEOtbHAzrS5R/X43LqKI1+ddNq/OHI3qh+LCwD0rN20M0qDDBG3NtH1bjDFoMv/lYfJF6ud71PxFiiVvv8i3e7QlmJExF7QkPyCGShdYmmDOBrfbXC+qrH3JPmxDqJDQ7Ifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=On2biStyiiVo32qK3h3k06MbuyGppg5x91cohQddNqs=;
 b=YhR/AIvQZceSUq8DPTZ+oiXhS/Wo5Fe8hGDTVbxP/pPJh4k1kAugtPLU5HSwpYeLnivyLeJ7AiDNBtSoZ3rDYaqOfq+1NxKCUhJVgLObErBh36OA5s6CQ2xjXStctdeHL5t09IgSP2lalwx//o6z0YwhxU2jKtSbr/Y6ett89qikSkV0byRMNNzASUNAN+31p5NTmNgFYnJvWxcIqlrshwZo1d6thr0g6b9EBDv4gy3iDNm9yAaJcpMKh8H+5qKpOCaSXjXtamWFaLwaxGWgWeeTuNFNM9XRs39jM20ZGTnKUJUN+H+1cq72dp1ewU8pw+g+lCfLIQFB4mKp9le95A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB7656.eurprd04.prod.outlook.com (2603:10a6:20b:29b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Thu, 6 May
 2021 12:38:44 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7%7]) with mapi id 15.20.4108.027; Thu, 6 May 2021
 12:38:44 +0000
To:     fdmanana@gmail.com
CC:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210506070458.168945-1-wqu@suse.com>
 <CAL3q7H7TY9c=dzcJw62-nZh-fSieb3gQyqjdXLv+-rMVmQ+ZJg@mail.gmail.com>
 <1b3c38fa-122e-47ad-5d83-f45064de714b@suse.com>
 <CAL3q7H4j+VbBFaf=-MgPDC6hKgqZ+V-SoF4nmnTxxYqpsDcWiQ@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH RFC] btrfs: temporary disable inline extent creation for
 fallocate and reflink
Message-ID: <3a4ddc37-d260-f132-ac73-6a7f57df9ea5@suse.com>
Date:   Thu, 6 May 2021 20:38:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <CAL3q7H4j+VbBFaf=-MgPDC6hKgqZ+V-SoF4nmnTxxYqpsDcWiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [45.77.180.217]
X-ClientProxiedBy: TYAPR01CA0082.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::22) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (45.77.180.217) by TYAPR01CA0082.jpnprd01.prod.outlook.com (2603:1096:404:2c::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 12:38:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 733b9341-8961-44b7-3e98-08d9108be2dd
X-MS-TrafficTypeDiagnostic: AS8PR04MB7656:
X-Microsoft-Antispam-PRVS: <AS8PR04MB7656147A4355FAA224BB49B3D6589@AS8PR04MB7656.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: apSPYN7R9UpapZSJXEWkaenn9aR4pa6k0a/iysV8zT+li/0R+edQpBd51hR4fu5WVrwS+dgZvxKhKzjW3NdoqX3MjbvPl6at1BC2iqC7MxY33PuF4XARYJpBWgUuJfkEbILv3TW17BYrjT4YrMb0U4YNnqrvP9jFCiNXWYl2/NqM2XOsrOwZ5LtjePx+b27MNSjuNgJc7GJzMg8pXd31JgxLSIPHaUk9sQ1sjz6Lg4q1pit7HR3tHVrCbV6G+mRP00rAdUzVY3wXJHMNfvV+IF/P1NbiZ0vkqGrHLfAidNipiDsyhAcBVWR+Z8VAstzYVswWMVuv3rVF3v9BcWF25ByCEyHaxCyayGTUwBJPYHuEF3vDmYF9giEwTY2ZkHiuHgQaEQjGE/48YHlFkpeVtg9+HR0Qp5tGmhUIPWrlABXOPtzalhIpLuq31T2O86+LckZV3HZu/xZ8HsUxRpLW7/NoHI+JaDodMeVTWqQmjji7qwiauEDlAaLIRcMOCL8hleXAIMdIxjtpX+lBCuLDWi7DkWbl6JMKM0KkZcI0dt3x8wZgVoUBUs1kwZU+zV/fGw0Cyiq8E7Zfji6f9U7h4SAEjkhzrG++Ax1yrEuUCx9Hz8TSdkyJeE+m2HGkFvx3wyZEJ7GHfGVu0jQTkATQLAUJzgtsYANtU0IVzTyRqmot6f4j8XglSXIKbPdPk8BZ7oMVCWQdxv7nTtbvXie+UYBLoMJ8TmI4fKghahdydHVBVkMqFk/1EdjTHX7S/ZfXJFIs51Rid5ad6Ym7ZbFn+/i2zIFkrN8f07Nq+1hmeA1J5Tmq13nfqg/cAau8yKDY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(376002)(366004)(346002)(136003)(396003)(66556008)(956004)(2616005)(31686004)(66946007)(66476007)(8676002)(5660300002)(966005)(4326008)(38350700002)(83380400001)(38100700002)(52116002)(6486002)(30864003)(478600001)(16576012)(6666004)(8936002)(55236004)(53546011)(186003)(16526019)(2906002)(86362001)(6706004)(31696002)(6916009)(26005)(36756003)(316002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lUTCPby//nJsnGSDJUXjlxz575deJog2i+ofkYZRDR0zgUSjiT4QYLRvWJP6?=
 =?us-ascii?Q?gg4R5liL0wTgTQcLBocsXPdojmj8LnbWP8Ptw+291UPgeiqpryAEU9incWF2?=
 =?us-ascii?Q?5pMQVRftKDwkO5OrfcoGEyB6pOPkD31fbSMZwDMGZc3DR9IQuYDiodoVLmav?=
 =?us-ascii?Q?CQz0IXIpoOjACApT1dIRh0VROqoXK0c5eFc+P2OcpTj+QTrehAmtWtCxw6vc?=
 =?us-ascii?Q?I0GV19QnXAYqPRNch8gbPX1Or+VbBrhjQAjWCbdZbhhv0Pf9ucjoTJR4WVXS?=
 =?us-ascii?Q?j0DDRYogVg4E8qlFVQzg/7gMigBTkp/PDyJIg89tBBms5aFzE3a5fnEg3l+o?=
 =?us-ascii?Q?VjbHiF6gIyIv0Iy9XNcoq6/D+y/O+1sL0uXOr7RqhhHOpJdLfuvnydQ28BBq?=
 =?us-ascii?Q?eGBzMQwBHAUjNGE+HVbnsALBJlrgEr9X0g/46msTAi5yffLIpID370JscBwh?=
 =?us-ascii?Q?iDxgzAyo0G903jMZYwlbpGfcjCu1pMehJpzZ9Awke5K3JvaHJbzIDE7qkPEq?=
 =?us-ascii?Q?97gUVPMW3wN5RKvOTrGPDlcMzrAAhslny1+HhknPWm/pK8ZZE+Wy7O4gfky3?=
 =?us-ascii?Q?AD7ZsIbeqnWoYAk3/I4i6RMizrOZNwG5SRvO+r4boirckbVf9U47Sz+xQcc8?=
 =?us-ascii?Q?uAXWISliJJVFfZLrRyB78Exee3UVgpcnKbQzTiRn5mscnocvy8XcPJu8d6ja?=
 =?us-ascii?Q?QWD8Es5kkMGywvx+m+wwN5C4f8v5TAyHnR2u0k04dPykf8/UYZCj7svUbH4P?=
 =?us-ascii?Q?JM0RXLSti+t7UDOZZe3ZOop9iXuGPa1U9Xmy3TcPNCjdbuFTgI8yVgA8mWZH?=
 =?us-ascii?Q?MaCf2FnNMTo9yVBOOHFZlbYfqvu2d3PdsjUIj0WvPfx0TEGWBwHrSeQxQ3QK?=
 =?us-ascii?Q?5LaLc/xwmmwiinprIwkSXz3Hf8Q1MyOQnKYskEP6eQaYGOetGHWBpWlhg/So?=
 =?us-ascii?Q?AZ/DncA47s2iwKTMqWoashOhQJUNC41uePoG12iZX/T7+vIcUsz6svAluwrP?=
 =?us-ascii?Q?UP0zDweOpvZ08llx5dpCD1bJ52gI/1fQ/LN1ig1CGK3s64lBcz7sV/J1ivM5?=
 =?us-ascii?Q?L9ox5ehjF4M5ZOkn6ojD3GuhoUUdIt037ytGnIrZniGvQgxaxOevXDTgr0iV?=
 =?us-ascii?Q?oCwmw/R6Vr9vpIKInHoy9XEHM1r4pm1k6fpEYDE+Yswaq2du7Zj4fDbqy26K?=
 =?us-ascii?Q?HWPqHTuWqF8Znx8MEhqLZdP+7bLbibUu57m6cTXF2aAKvYlagl+3+g1g7BSo?=
 =?us-ascii?Q?e33iSoepD6dMTHfUCWH6cpDdniMJt9q+21XtIBN7i8Vprx/mxhjpvFZks3F6?=
 =?us-ascii?Q?fiZbY8ish19ZHrOxZZM2drSQ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733b9341-8961-44b7-3e98-08d9108be2dd
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 12:38:44.5470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5f/e/JIyK9nz7gLaJfHs0K7Ghn4hr7bO9qn8VcWu1oxTFMSpp8rdqtqyIHYW+faB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7656
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/6 =E4=B8=8B=E5=8D=887:25, Filipe Manana wrote:
> On Thu, May 6, 2021 at 11:55 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> On 2021/5/6 =E4=B8=8B=E5=8D=886:07, Filipe Manana wrote:
>>> On Thu, May 6, 2021 at 8:07 AM Qu Wenruo <wqu@suse.com> wrote:
>>>>
>>>> Previously we disable inline extent creation completely for subpage
>>>> case, due to the fact that writeback for subpage still happens for ful=
l
>>>> page.
>>>>
>>>> This makes btrfs_wait_ordered_range() trigger writeback for larger
>>>> range, thus can writeback the first sector even we don't want.
>>>>
>>>> But the truth is, even for regular sectorsize, we still have a race
>>>> window there operations where fallocate and reflink can cause inline
>>>> extent being created.
>>>
>>> Yes, but why is it a problem for when sectorsize =3D=3D page size?
>>
>> Well, it doesn't affect the on-disk data, but purely break the on-disk
>> data schema.
>=20
> Hum, I don't understand, breaks how?
> I think just because it does not corresponds to a developer's
> expectation, does not necessarily mean it is broken, unless it causes
> a bug.
>=20
>>
>> We don't really expect inline extent with regular extent, right?
>=20
> Hard to tell. There are cases like the fallocate example where that happe=
ns,
> and for compression cases where we get an inline extent representing
> one full page/sector of data.
> I don't think it was ever written in stone if such cases are expected
> or unexpected (and why).
>=20
> We discussed this in the past:
>=20
> https://lore.kernel.org/linux-btrfs/20180302052254.7059-3-wqu@suse.com/
>=20
> It's hard to tell if it was ever intended or not, the reality is that
> it's possible and that there are filesystems out there with such
> cases.
> I think what matters is if such cases lead to any problem affecting
> users (corruptions, crashes, deadlocks, leaks, etc).

OK, then I don't even need to bother the case.

Just discard the btrfs-progs patches, remove the inline disable patch=20
for subpage and call it a day, which is also fine to me, at least for now.

[...]
>>>
>>> Again, the change log should mention why it is a problem, how it affect=
s users?
>>
>> It doesn't affect the end user, just like the a log bugs exposed by
>> tree-checker, like the inode transid/generation problems.
>=20
> I don't understand. You say it doesn't affect users but the tree
> checker complains? I interpret that as affecting users.

I mean, before the tree-checker introduced the inode generation/transid=20
check, end users won't even know garbage inode generation/transid is in=20
their old fs.

Until the tree-checker get strict on these values, we begin to notice=20
the problem, and consider it a bug.

>=20
> Now, how does a mix of inline and regular extents cause inode
> transid/generation problems?

The inode transid/generation is just an example, to show there are cases=20
where it doesn't affect users and we still want to fix it.

> If that's the only problem you are aware of, then it should be
> explained how/why it happens in the changelog (and therefore why
> disabling inline extents fixes the bug).
>=20
>>
>> But shouldn't we still follow the on-disk data schema that, if we have
>> regular extents, then there shouldn't be an inline extent.
>>
>>> Some data corruption, reads returning wrong data, some crash, something=
 else?
>>
>> Just a scheme breakage, kernel can handle mixed types without problem.
>=20
> As mentioned before, I'm not sure if it breaks expectations or not.
> Certainly it's not very common, and maybe it was not expected at all
> before fallocate and compression were introduced - I suppose only who
> came up with the idea of inline extents and who added the first
> implementations of fallocate and compression might tell.

Then why not make it determined now?

Yes, I get your point, this doesn't make much difference except to bring=20
some peace to paranoid guys like me.
And the fix won't be simple, it would definitely be more complex than=20
just temporarily disabling inline for a certain operations.

But shouldn't things like this get determined before we further delay=20
the solution?

>=20
> So unless such a combination really causes a bug to be triggered, I'm
> not sure it's a good idea to have fsck report them as
> inconsistencies/errors.
[...]
>> Personally I prefer to consider as schema breakage as a bug, even it
>> doesn't cause any problem to end user.
>=20
> I think the definition of a bug is a glitch that results in incorrect
> behaviour/result in the software (i.e. affects users).
> As mentioned earlier, it's not clear to me if such cases were ever
> unexpected or not.
>=20
>>
>> That's why I'm enhancing tree-checker to detect things that are invalid
>> even it doesn't break anything.
>>
>> But I kinda get your point, it's definitely not a high priority thing,
>> unlike real data corruption.
>=20
> Yeah, I'm reluctant to add code if it doesn't fix any bug or if it's
> not needed for some feature or other change.
>=20
> Though I'm curious about the inode transid/generation mismatch, I
> don't see how the mix of inline and regular extents can lead to that.

Forget that, it's just an example to show that we could have old=20
behaviors that breaks developers' expectation, but no obvious data=20
corruption, and we still consider it a bug.

I guess we need to get an agreement among the developers on what's the=20
expectation for inline extent, before doing any "fix".

Thanks,
Qu

>=20
> Thanks.
>=20
>>
>>>
>>>>
>>>> I have also tried other solutions like switching the timing of
>>>> btrfs_cont_expand() and btrfs_wait_ordered_range(), to make
>>>> btrfs_wait_ordered_range() happens before btrfs_cont_expand().
>>>>
>>>> So that we will writeback the first sector for subpage as inline, then
>>>> btrfs_cont_expand() will re-dirty the first sector.
>>>>
>>>> This would solve the problem for subpage, but not the race window.
>>>>
>>>> Another idea is to enlarge inode size first, but that would greatly
>>>> change the error path, may cause new regressions.
>>>
>>> I think I would prefer it that way. I don't see why it would change
>>> the error paths so much.
>>> Instead of clearing the bit, it would be just assigning the old i_isize=
 value.
>>
>> What would happen if one is calling btrfs_setsize() to resize the inode
>> during fallocate call?
>> Wouldn't we restore some out-of-data isize then?
>> btrfs_setsize() doesn't hold inode lock, thus it can sneak in.
>>
>> If there is something else ensuring we're the only one modifying isize,
>> I'm more happy to go this direction.
>>
>> Thanks,
>> Qu
>>
>>>
>>> But I don't have a strong preference.
>>>
>>>>
>>>> I'm all ears for advice on this problem.
>>>> ---
>>>>    fs/btrfs/ctree.h         | 10 ++++++++++
>>>>    fs/btrfs/delayed-inode.c |  3 ++-
>>>>    fs/btrfs/file.c          | 19 +++++++++++++++++++
>>>>    fs/btrfs/inode.c         | 21 ++++-----------------
>>>>    fs/btrfs/reflink.c       | 14 ++++++++++++--
>>>>    fs/btrfs/root-tree.c     |  3 ++-
>>>>    fs/btrfs/tree-log.c      |  3 ++-
>>>>    7 files changed, 51 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>>>> index 7bb4212b90d3..7c74d57ad8fc 100644
>>>> --- a/fs/btrfs/ctree.h
>>>> +++ b/fs/btrfs/ctree.h
>>>> @@ -1488,6 +1488,16 @@ do {                                           =
                        \
>>>>    #define BTRFS_INODE_DIRSYNC            (1 << 10)
>>>>    #define BTRFS_INODE_COMPRESS           (1 << 11)
>>>>
>>>> +/*
>>>> + * Runtime bit to temporary disable inline extent creation.
>>>> + * To prevent the first sector get written back as inline before the =
isize
>>>> + * get enlarged.
>>>> + *
>>>> + * This flag is for runtime only, won't reach disk, thus is not inclu=
ded
>>>> + * in BTRFS_INODE_FLAG_MASK.
>>>> + */
>>>> +#define BTRFS_INODE_NOINLINE           (1 << 30)
>>>> +
>>>>    #define BTRFS_INODE_ROOT_ITEM_INIT     (1 << 31)
>>>>
>>>>    #define BTRFS_INODE_FLAG_MASK                                      =
    \
>>>> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
>>>> index 1a88f6214ebc..64d931da083d 100644
>>>> --- a/fs/btrfs/delayed-inode.c
>>>> +++ b/fs/btrfs/delayed-inode.c
>>>> @@ -1717,7 +1717,8 @@ static void fill_stack_inode_item(struct btrfs_t=
rans_handle *trans,
>>>>                                          inode_peek_iversion(inode));
>>>>           btrfs_set_stack_inode_transid(inode_item, trans->transid);
>>>>           btrfs_set_stack_inode_rdev(inode_item, inode->i_rdev);
>>>> -       btrfs_set_stack_inode_flags(inode_item, BTRFS_I(inode)->flags)=
;
>>>> +       btrfs_set_stack_inode_flags(inode_item,
>>>> +                       BTRFS_I(inode)->flags & BTRFS_INODE_FLAG_MASK)=
;
>>>
>>> If it's a runtime flag, not meant to be persisted, then it should be
>>> set in btrfs_inode->runtime flags and not on btrfs_inode->flags,
>>> which not only makes it more clear, but avoids doing this sort of bit
>>> manipulation.
>>>
>>>>           btrfs_set_stack_inode_block_group(inode_item, 0);
>>>>
>>>>           btrfs_set_stack_timespec_sec(&inode_item->atime,
>>>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>>>> index 70a36852b680..a3559ce93780 100644
>>>> --- a/fs/btrfs/file.c
>>>> +++ b/fs/btrfs/file.c
>>>> @@ -3357,6 +3357,24 @@ static long btrfs_fallocate(struct file *file, =
int mode,
>>>>                           goto out;
>>>>           }
>>>>
>>>> +       /*
>>>> +        * Disable inline extent creation until we enlarged the inode =
size.
>>>
>>> until we enlarged -> until we increase (or update)
>>>
>>>> +        *
>>>> +        * Since the inode size is only increased after we allocated a=
ll
>>>
>>> So this is a bit confusing to read. You'll want to mention that happens=
 only
>>> for fallocate and cloning.
>>>
>>> As I read it, if I had little or no knowledge of the code, I would
>>> interpret that that happens for all cases.
>>> But those two cases, fallocate and cloning, are the exceptions to the
>>> rule, which is we update the i_size and then fill in the file extent
>>> items (like in the write path).
>>>
>>>> +        * extents, there are several cases to writeback the first sec=
tor,
>>>> +        * which can be inlined, leaving inline extent mixed with regu=
lar
>>>> +        * extents:
>>>> +        *
>>>> +        * - btrfs_wait_ordered_range() call for subpage case
>>>> +        *   The writeback happens for the full page, thus can writeba=
ck
>>>> +        *   the first sector of an inode.
>>>> +        *
>>>> +        * - Memory pressure
>>>> +        *
>>>> +        * So here we temporarily disable inline extent creation for t=
he inode.
>>>
>>> Same as commented before, I would like to know why is it a problem,
>>> how does it affect correctness, if there's some corruption, crash, or
>>> something else affecting users.
>>>
>>>> +        */
>>>> +       BTRFS_I(inode)->flags |=3D BTRFS_INODE_NOINLINE;
>>>> +
>>>>           /*
>>>>            * TODO: Move these two operations after we have checked
>>>>            * accurate reserved space, or fallocate can still fail but
>>>> @@ -3501,6 +3519,7 @@ static long btrfs_fallocate(struct file *file, i=
nt mode,
>>>>           unlock_extent_cached(&BTRFS_I(inode)->io_tree, alloc_start, =
locked_end,
>>>>                                &cached_state);
>>>>    out:
>>>> +       BTRFS_I(inode)->flags &=3D ~BTRFS_INODE_NOINLINE;
>>>>           btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
>>>>           /* Let go of our reservation. */
>>>>           if (ret !=3D 0 && !(mode & FALLOC_FL_ZERO_RANGE))
>>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>>> index 4fc6e6766234..59972cb2efce 100644
>>>> --- a/fs/btrfs/inode.c
>>>> +++ b/fs/btrfs/inode.c
>>>> @@ -666,11 +666,7 @@ static noinline int compress_file_range(struct as=
ync_chunk *async_chunk)
>>>>                   }
>>>>           }
>>>>    cont:
>>>> -       /*
>>>> -        * Check cow_file_range() for why we don't even try to create
>>>> -        * inline extent for subpage case.
>>>> -        */
>>>> -       if (start =3D=3D 0 && fs_info->sectorsize =3D=3D PAGE_SIZE) {
>>>> +       if (start =3D=3D 0 && !(BTRFS_I(inode)->flags & BTRFS_INODE_NO=
INLINE)) {
>>>>                   /* lets try to make an inline extent */
>>>>                   if (ret || total_in < actual_end) {
>>>>                           /* we didn't compress the entire range, try
>>>> @@ -1068,17 +1064,7 @@ static noinline int cow_file_range(struct btrfs=
_inode *inode,
>>>>
>>>>           inode_should_defrag(inode, start, end, num_bytes, SZ_64K);
>>>>
>>>> -       /*
>>>> -        * Due to the page size limit, for subpage we can only trigger=
 the
>>>> -        * writeback for the dirty sectors of page, that means data wr=
iteback
>>>> -        * is doing more writeback than what we want.
>>>> -        *
>>>> -        * This is especially unexpected for some call sites like fall=
ocate,
>>>> -        * where we only increase isize after everything is done.
>>>> -        * This means we can trigger inline extent even we didn't want=
.
>>>> -        * So here we skip inline extent creation completely.
>>>> -        */
>>>> -       if (start =3D=3D 0 && fs_info->sectorsize =3D=3D PAGE_SIZE) {
>>>> +       if (start =3D=3D 0 && !(inode->flags & BTRFS_INODE_NOINLINE)) =
{
>>>>                   /* lets try to make an inline extent */
>>>>                   ret =3D cow_file_range_inline(inode, start, end, 0,
>>>>                                               BTRFS_COMPRESS_NONE, NUL=
L);
>>>> @@ -3789,7 +3775,8 @@ static void fill_inode_item(struct btrfs_trans_h=
andle *trans,
>>>>           btrfs_set_token_inode_sequence(&token, item, inode_peek_iver=
sion(inode));
>>>>           btrfs_set_token_inode_transid(&token, item, trans->transid);
>>>>           btrfs_set_token_inode_rdev(&token, item, inode->i_rdev);
>>>> -       btrfs_set_token_inode_flags(&token, item, BTRFS_I(inode)->flag=
s);
>>>> +       btrfs_set_token_inode_flags(&token, item,
>>>> +                       BTRFS_I(inode)->flags & BTRFS_INODE_FLAG_MASK)=
;
>>>>           btrfs_set_token_inode_block_group(&token, item, 0);
>>>>    }
>>>>
>>>> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
>>>> index e5680c03ead4..48f8bdd185de 100644
>>>> --- a/fs/btrfs/reflink.c
>>>> +++ b/fs/btrfs/reflink.c
>>>> @@ -701,12 +701,19 @@ static noinline int btrfs_clone_files(struct fil=
e *file, struct file *file_src,
>>>>           if (off + len =3D=3D src->i_size)
>>>>                   len =3D ALIGN(src->i_size, bs) - off;
>>>>
>>>> +       /*
>>>> +        * Temporarily disable inline extent creation, check btrfs_fal=
locate()
>>>> +        * for details
>>>> +        */
>>>> +       BTRFS_I(inode)->flags |=3D BTRFS_INODE_NOINLINE;
>>>>           if (destoff > inode->i_size) {
>>>>                   const u64 wb_start =3D ALIGN_DOWN(inode->i_size, bs)=
;
>>>>
>>>>                   ret =3D btrfs_cont_expand(BTRFS_I(inode), inode->i_s=
ize, destoff);
>>>> -               if (ret)
>>>> +               if (ret) {
>>>> +                       BTRFS_I(inode)->flags &=3D ~BTRFS_INODE_NOINLI=
NE;
>>>>                           return ret;
>>>> +               }
>>>>                   /*
>>>>                    * We may have truncated the last block if the inode=
's size is
>>>>                    * not sector size aligned, so we need to wait for w=
riteback to
>>>> @@ -718,8 +725,10 @@ static noinline int btrfs_clone_files(struct file=
 *file, struct file *file_src,
>>>>                    */
>>>>                   ret =3D btrfs_wait_ordered_range(inode, wb_start,
>>>>                                                  destoff - wb_start);
>>>> -               if (ret)
>>>> +               if (ret) {
>>>> +                       BTRFS_I(inode)->flags &=3D ~BTRFS_INODE_NOINLI=
NE;
>>>>                           return ret;
>>>> +               }
>>>>           }
>>>>
>>>>           /*
>>>> @@ -745,6 +754,7 @@ static noinline int btrfs_clone_files(struct file =
*file, struct file *file_src,
>>>>                                   round_down(destoff, PAGE_SIZE),
>>>>                                   round_up(destoff + len, PAGE_SIZE) -=
 1);
>>>>
>>>> +       BTRFS_I(inode)->flags &=3D ~BTRFS_INODE_NOINLINE;
>>>>           return ret;
>>>>    }
>>>>
>>>> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
>>>> index 702dc5441f03..5ce3a1dfaf3f 100644
>>>> --- a/fs/btrfs/root-tree.c
>>>> +++ b/fs/btrfs/root-tree.c
>>>> @@ -447,7 +447,8 @@ void btrfs_check_and_init_root_item(struct btrfs_r=
oot_item *root_item)
>>>>
>>>>           if (!(inode_flags & BTRFS_INODE_ROOT_ITEM_INIT)) {
>>>>                   inode_flags |=3D BTRFS_INODE_ROOT_ITEM_INIT;
>>>> -               btrfs_set_stack_inode_flags(&root_item->inode, inode_f=
lags);
>>>> +               btrfs_set_stack_inode_flags(&root_item->inode,
>>>> +                               inode_flags & BTRFS_INODE_FLAG_MASK);
>>>
>>> Same as before, using btrfs_inode->runtime_flags would eliminate the
>>> need for this.
>>>
>>>>                   btrfs_set_root_flags(root_item, 0);
>>>>                   btrfs_set_root_limit(root_item, 0);
>>>>           }
>>>> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
>>>> index c1353b84ae54..f7e6abfc89c0 100644
>>>> --- a/fs/btrfs/tree-log.c
>>>> +++ b/fs/btrfs/tree-log.c
>>>> @@ -3943,7 +3943,8 @@ static void fill_inode_item(struct btrfs_trans_h=
andle *trans,
>>>>           btrfs_set_token_inode_sequence(&token, item, inode_peek_iver=
sion(inode));
>>>>           btrfs_set_token_inode_transid(&token, item, trans->transid);
>>>>           btrfs_set_token_inode_rdev(&token, item, inode->i_rdev);
>>>> -       btrfs_set_token_inode_flags(&token, item, BTRFS_I(inode)->flag=
s);
>>>> +       btrfs_set_token_inode_flags(&token, item,
>>>> +                       BTRFS_I(inode)->flags & BTRFS_INODE_FLAG_MASK)=
;
>>>
>>> Same as before, using btrfs_inode->runtime_flags would eliminate the
>>> need for this.
>>>
>>> Thanks.
>>>
>>>>           btrfs_set_token_inode_block_group(&token, item, 0);
>>>>    }
>>>>
>>>> --
>>>> 2.31.1
>>>>
>>>
>>>
>>
>=20
>=20

