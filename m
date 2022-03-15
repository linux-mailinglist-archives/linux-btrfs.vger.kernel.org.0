Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FD24D9A3D
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 12:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238857AbiCOLUx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 07:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238026AbiCOLUx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 07:20:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885644F9C5
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 04:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647343174;
        bh=p4kbrEnfDTZhXty47Uoo2rxvY57o00QmK6tjCDFoBHw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=L5BSww9DFeqwA/5BXjAvax4NK8suMXFJu2H5tjzDQz5oW8rnaT95b0659lC8iJtEm
         hUnzY6EfqglAudakXcIvvW7le3Q/N4ErUsfJt2opnDkoUewvO1SbsgI/xafpbhnbnw
         MYMI5zQhzhcZRGPtdVZyvFYtFDH2SFLaySpDAbkU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8GMk-1o7hLh0WIK-0148h1; Tue, 15
 Mar 2022 12:19:33 +0100
Message-ID: <e66102ff-d122-34fc-41dd-0dff11916046@gmx.com>
Date:   Tue, 15 Mar 2022 19:19:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: avoid defragging extents whose next extents are
 not targets
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <795e3dee8c4789f845e5e14bfc02c992b86fa2d9.1647306224.git.wqu@suse.com>
 <YjB1YO95Vycuhlzo@debian9.Home>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YjB1YO95Vycuhlzo@debian9.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2EWHdx1rfokqk1AKDCNDldPrtdY31hdDe1qt+zzuZkB8Q+eSS4F
 OkENDDAQf9tNhKfwB3ZxcPnVk3lAh4b5OkuPj2OPJC5lXmVJ/UbYwHoyZiK/AW05Nb5DqF+
 mRKSn3xD89EmBbGGpm8dOdoMeyzVVCNEBzalgMjqpPwbFrJAuyrYLAqiDDo5/95/GoxrkQo
 GCWxzsoQ41OSpgnymeMUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vF8gsqceEF4=:hckx4srXoPZzIoVA2pp8VN
 MZ5pmeDlctGbAzbQ5lMmxvTTdXWTbcFhHLnOB4U40N66XI5LjrDHBrySSEXpm6D4aIYp29VaV
 sdb21ZpBl358cNBJcGeif+ZQ6x6x2wwSeQDOa9VngQaRx2Lm7zpJnLcFPzdPD1Jpgq9VaKtNN
 hb6vroLY6uLxczGJvPEgWSZp9ERg8b3P3V9YEvkxPDCxqnECH0C42JbakInKuwkFYDPs/YP0F
 ieSmmvIymBBzsLKUg1uav3nuPkAGA3TY5tX1D9FZ4qeBH7IcxAOn8//N1dg9Lln0YgNlb8W3Y
 rqgQ8RQrCZyaCpAlQ7jtM0YdmDbN0JUxKrK+t5Gy1oQoSticG+iUfrUUUNboZFv71bHU27wWA
 J1HwNjlAg96eXBMi1YHIeMNkvPe5Z869qGxAwomT4vz97PpNC1mdxjO/rbHCrAbwYg2KqjKyw
 biZAUXJDn15Zzwosn7tqDinS+mePpMdFFlKRKMSUqOpQVl2G/+nzAYgLGOtmMrO66z1XD7Aox
 /7/bOquBu3VnTJqSn/2/a6GHt2MbjA02oHdlk5M1BL35waRjpQg2lIRSGULDMJEgQgAWWL0bm
 6jx7f1COC8CN+S6ERGWuHLEiybYuXBXIXMnUKtsU/YrLB+QpzcV2uGn0dJnoW1PVoR1atjsA+
 fjQEJ4Lw/C3B57kW+AkiJeRiCrWt5i/SKUOoIn249ROkhcE5RgNh+TXnsqbSgv5KREqvsaiL1
 Bv1vAaczZSNFdRJqliPC0fpB8v/c+kkE0zIHHqNvqTQIFf4V0nksYYsW7JLItyN04YyrARu+l
 K4p8PeuhIUVs5psz91wIssP8/O4UreeVvxushSYOh9FtBK4GVPnTJqeocLD84gMZZGPJY+GHk
 3BsxNuD9Jr1VyqKXLCe8cKKPSfcq1Ad21SGT6txS2TFH3cFQLj10f26Y+4IcRhtLPfbNRM/yn
 XfL5jmPLVbdDSvxOwRnLmFhEGxXI04OGm/gKQ1UrNQUTlsz11qHiOSy2/PmW4InH8kO5+sO7o
 0nTIC5iKtmycJcx6QV7C3r9eindZicI3M0o3jInFOo5j2gHWPK84iF2vjpwmsRqm3TEw8R7P/
 ICUrQoLw5JF+Qk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/15 19:15, Filipe Manana wrote:
> On Tue, Mar 15, 2022 at 09:07:52AM +0800, Qu Wenruo wrote:
>> [BUG]
>> There is a report that autodefrag is defragging single sector, which
>> is completely waste of IO, and no help for defragging:
>>
>>     btrfs-cleaner-808     defrag_one_locked_range: root=3D256 ino=3D651=
122 start=3D0 len=3D4096
>>
>> [CAUSE]
>> In defrag_collect_targets(), we check if the current range (A) can be m=
erged
>> with next one (B).
>>
>> If mergeable, we will add range A into target for defrag.
>>
>> However there is a catch for autodefrag, when checking mergebility agai=
nst
>> range B, we intentionally pass 0 as @newer_than, hoping to get a
>> higher chance to merge with the next extent.
>>
>> But in next iteartion, range B will looked up by defrag_lookup_extent()=
,
>> with non-zero @newer_than.
>>
>> And if range B is not really newer, it will rejected directly, causing
>> only range A being defragged, while we expect to defrag both range A an=
d
>> B.
>>
>> [FIX]
>> Since the root cause is the difference in check condition of
>> defrag_check_next_extent() and defrag_collect_targets(), we fix it by:
>>
>> 1. Pass @newer_than to defrag_check_next_extent()
>> 2. Pass @extent_thresh to defrag_check_next_extent()
>>
>> This makes the check between defrag_collect_targets() and
>> defrag_check_next_extent() more consistent.
>>
>> While there is still some minor difference, the remaining checks are
>> focus on runtime flags like writeback/delalloc, which are mostly
>> transient and safe to be checked only in defrag_collect_targets().
>>
>> Issue: 423#issuecomment-1066981856
>
> Where is the issue exactly? It's the first time I'm seeing an Issue tag
> for kernel patches. Is this a github issue? If so, which repo? There are
> several repos we use for btrfs:
>
> https://github.com/btrfs/linux
> https://github.com/kdave/btrfs-devel

It's the btrfs/linux repo.

So I guess the proper way to link this is using Link: tag instead.

The full URL for it:
https://github.com/btrfs/linux/issues/423#issuecomment-1066981856

> https://github.com/kdave/btrfs-progs
> https://github.com/btrfs/fstests
> etc
>
> Can't we use a Link tag with an URL? That removes any doubts where the
> issue is and makes it easier to look at it.
>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Doesn't this miss a Fixes tag and a CC stable tag for 5.16?

Oh, forgot to add that.

Will update the commit message for both the proper Link: and Cc: tag.

Thanks,
Qu
>
> This is fixing code added in 5.16, and given that users are reporting
> autodefrag causing disruptive amounts of IO, I don't see why it doesn't
> have a CC tag for stable.
>
> The change itself looks good. Thanks.
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
>> ---
>>   fs/btrfs/ioctl.c | 21 +++++++++++++++------
>>   1 file changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 3d3d6e2f110a..7d7520a2e281 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -1189,7 +1189,7 @@ static u32 get_extent_max_capacity(const struct e=
xtent_map *em)
>>   }
>>
>>   static bool defrag_check_next_extent(struct inode *inode, struct exte=
nt_map *em,
>> -				     bool locked)
>> +				     u32 extent_thresh, u64 newer_than, bool locked)
>>   {
>>   	struct extent_map *next;
>>   	bool ret =3D false;
>> @@ -1199,11 +1199,13 @@ static bool defrag_check_next_extent(struct ino=
de *inode, struct extent_map *em,
>>   		return false;
>>
>>   	/*
>> -	 * We want to check if the next extent can be merged with the current
>> -	 * one, which can be an extent created in a past generation, so we pa=
ss
>> -	 * a minimum generation of 0 to defrag_lookup_extent().
>> +	 * Here we need to pass @newer_then when checking the next extent, or
>> +	 * we will hit a case we mark current extent for defrag, but the next
>> +	 * one will not be a target.
>> +	 * This will just cause extra IO without really reducing the fragment=
s.
>>   	 */
>> -	next =3D defrag_lookup_extent(inode, em->start + em->len, 0, locked);
>> +	next =3D defrag_lookup_extent(inode, em->start + em->len, newer_than,
>> +				    locked);
>>   	/* No more em or hole */
>>   	if (!next || next->block_start >=3D EXTENT_MAP_LAST_BYTE)
>>   		goto out;
>> @@ -1215,6 +1217,13 @@ static bool defrag_check_next_extent(struct inod=
e *inode, struct extent_map *em,
>>   	 */
>>   	if (next->len >=3D get_extent_max_capacity(em))
>>   		goto out;
>> +	/* Skip older extent */
>> +	if (next->generation < newer_than)
>> +		goto out;
>> +	/* Also check extent size */
>> +	if (next->len >=3D extent_thresh)
>> +		goto out;
>> +
>>   	ret =3D true;
>>   out:
>>   	free_extent_map(next);
>> @@ -1420,7 +1429,7 @@ static int defrag_collect_targets(struct btrfs_in=
ode *inode,
>>   			goto next;
>>
>>   		next_mergeable =3D defrag_check_next_extent(&inode->vfs_inode, em,
>> -							  locked);
>> +						extent_thresh, newer_than, locked);
>>   		if (!next_mergeable) {
>>   			struct defrag_target_range *last;
>>
>> --
>> 2.35.1
>>
