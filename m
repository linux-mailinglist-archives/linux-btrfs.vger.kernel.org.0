Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2ADF77F1C3
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 10:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbjHQIFT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 04:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348711AbjHQIEq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 04:04:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5F32D76
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 01:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1692259475; x=1692864275; i=quwenruo.btrfs@gmx.com;
 bh=lki8eaRzTnU/EFB6VTDFOyCl54WjCBkgg+R8v17IjhY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=XzPgaW4pbEO2NR7ivxNxMydOJ4jH/S+25q/d8eohcUCBB1lnFwMGiaFnQCZk3TfdUb1kms3
 WE0xaKOAXfg0CZIFOiyqX5+3uUbgqqqbGv0eqyQGdDPbd2KKiR+hTk0eHQ/vOOi8qiACJiPhZ
 3Q9/p+Ph44FI1D8qzPVt0k5Qzjikj1KqjgSluIiyNp13lHxqOdQXa8pvPnMnO1ZO0an03lQyt
 OTBX4VTM/15mVxVwWQBam0H6NaM7L4KnY8qerfpLVqmquG3Q5JR4zqdyHJA32GVNuoa8LMRI9
 pO78tMTdG9uo/N8pMIwZa1ahaNhWvWmzcKM1QiUGi28fWLZPSrIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6Daq-1qPwHi41kG-006hBH; Thu, 17
 Aug 2023 10:04:35 +0200
Message-ID: <b0cf94d1-d32b-4171-924e-17357aa03146@gmx.com>
Date:   Thu, 17 Aug 2023 16:04:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: retry flushing for del_balance_item() if the
 transaction is interrupted
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <77ec19769e75c704cb260b98b41e33340a51c40c.1692181669.git.wqu@suse.com>
 <ZNzE6CFOzu9kDG+G@debian0.Home>
 <d34414eb-8ad1-4e9c-bb4d-6167ace2e480@gmx.com>
 <CAL3q7H5g1E8ZWqtAA6Ltb+_aWAqOm6iR57ojnGCyskZZrFDMuQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <CAL3q7H5g1E8ZWqtAA6Ltb+_aWAqOm6iR57ojnGCyskZZrFDMuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LBnBeeBOIcqBuQsYojmQXndNetM2n1uoR2RaAStYwG7mPn1qhLg
 4LevDsZXKE8mPO2eNMdj4nGljSJPmHg3km/TEn260kCQxvfHU+En0hL9HzG2iHRPDLCtdVG
 AKkCtngPoSYThRmLWgPzvwkEH5Dw/iKme36c/13Fh1qnSDsJY1aaIE5F5AlvMKtgyRfNc+W
 JCv7eQ5Vh1rbP5YSLU02g==
UI-OutboundReport: notjunk:1;M01:P0:L4K2UgHLFvs=;+hOgqO1ckc3EAXcSKl32MKc9jGQ
 46wjQsRzrQhGaFKVLXmQSenaqItWbIXept36tR8upQLJp2eR6bjQ5g7bXEK1wq30MRwEuOvAo
 sOAULwMvrccQGUj/T/HcUPLu+lhyewQssq9wuUbh8ZuxQX6WfOe8xHO5r4Xc0C4jn7eW/lz6W
 I9ckfZKipMe9X2RT/YEPfGDe2VkCz5WIyPko9SDIR8S6g93zfRO5Elwlb6ECEbdIhBxz9EEhG
 kqFl9H8tvCycgK383Oa+fHU2pzod23wRCzU8gktB9xBgGX/qEQdvigE+Igjb23p38SS8fHlNi
 bgnRvLOWwF/M8/oP0w0RFwDXXCNmpMNUA6TZemqhV2OONezd/nreio6qikbMd/WJytzEGF+5x
 ImrkmJGKvldxXSA5Ap1/avBrcHLPfImyJkMbJ2IX38hCElVcbnjM1+4muOE3571fd5Q/xgCUo
 dPlrhB6YC7uTFVrLaQrJH8jbWKowiuzGSv3FXNvzY1SVLyo1w/gXXpyJoI7VBQ/UARIx/rOFs
 wDqDqaAOaY5hb+Smusl0yQYy06jt1QPtcBQoFzSm/Q87QrdLPxuMYBrDIRDpk5nq+wv55rgnC
 gnLiEDm9NqKoc+kmo7qjily891HWrSMxoqzdcXyecqq+C1/DU+iQj3GfA9LYWSsE1rG6mSr2u
 TkIRghKagiLvnK+tuDTbx9eB8L+6+MsirPsR9W4t6bLj+UDmnMhn6Fnrvj5EGOYb9uoKyyojz
 C0B3D957z8YVqoxrYB64Yw40LmcAxO6hhZHilircMg3hLdCqlaWXN9nwdMMF0ubdNdoNHPCzp
 K+uar3/sR4Vl5R1k6O4te4k44VbM2YYXIuHW8zQGMnWFvYH7yqP3NFCDARNF9kHUlzVPs+JL6
 8NWCUfQRn8F/MsV3qOJezYL+ItRRIGH07zE1nsFdPMYnpjhcGxF1qbl6uzchacyXXuMvjDCi8
 zevn5PHMecQBhWj04CIALJu15BI=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/17 15:39, Filipe Manana wrote:
> On Wed, Aug 16, 2023 at 10:54=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.c=
om> wrote:
[...]
>>>
>>> My only concern is if this can turn into an infinite loop due to a hig=
h enough rate of
>>> signals being sent to the process...
>>
>> Yep, that's indeed a concern.
>>
>> The other solution is to introduce a flag to disallow signal for the
>> ticket system (aka non-killable wait), which can get rid of the frequen=
t
>> signal problems.
>>
>> In fact, we may not want certain reclaim to be interrupted at all,
>> especially for BTRFS_RESERVE_FLUSH_ALL_STEAL, which are only utilized
>> for very critical operations like unlink and other deletion operations.
>
> We shouldn't need to call
> btrfs_start_transaction_fallback_global_rsv() because we don't need to
> reserve space.
> A join transaction would be enough, because:
>
> 1) We pass 0 items to the start transaction call;
>
> 2) More importantly, we are updating the root tree and the root tree
> uses the global block reserve, see btrfs_init_root_block_rsv().
>
> So the start transaction call should not be reserving any space
> because "num_items =3D=3D 0" and "flush !=3D BTRFS_RESERVE_FLUSH_ALL".

My bad, this is caused by the difference between SLE and the upstream.

For upstream, we go BTRFS_RESERVE_FLUSH_ALL_STEAL for this call site
(btrfs_start_transaction_fallback_global_rsv()), but for the SLE kernel
it's just a plain btrfs_start_transaction() which is going to need to do
block rsv.

I should just backport the patch changing the start transaction helper.

And indeed your analyse is correct, for upstream kernel we won't flush
for btrfs_start_transaction_fallback_global_rsv(), thus we don't need to
handle it at all.

> Are you sure the -EINTR is coming from the
> btrfs_start_transaction_fallback_global_rsv() and not from the
> btrfs_search_slot() call at del_balance_item() for example?

Just to fill my curiosity, I checked the tree read code which waits
using UNINTERRUPTIBLE, but it's no longer relevant anymore...

Thanks for pointing out the hole!
Qu

>
> Nothing in the partial log you pasted can tell the -EINTR comes from
> btrfs_start_transaction_fallback_global_rsv(), which would be very
> surprising
> because it's not reserving any space for those reasons mentioned above.
>
>>
>>>
>>> Instead of this I would make reset_balance_state() just print a warnin=
g, and not
>>> call btrfs_handle_fs_error()  and then change insert_balance_item() to=
 not fail in
>>> case the item already exists - instead just overwrite it.
>>
>> This means, if a unlucky interruption happened, the left balance item
>> can cause us to resume a balance on the next mount, which can be
>> unexpected for the end user.
>
> Yes, but maybe not much work is done unless after that some block
> groups got fragmented enough to trigger the stored balance filters in
> the item.
> The worst case is without filters, where all block groups are always rel=
ocated.
> Not ideal, yes.
>
> But having had a closer look, my concern is that I don't see how
> btrfs_start_transaction_fallback_global_rsv() can return -EINTR, and I
> suspect
> it comes from somewhere else.
>
> Thanks.
>
>>
>> Thanks,
>> Qu
>>>
>>> Thanks.
>>>
>>>
>>>>       if (IS_ERR(trans)) {
>>>>               btrfs_free_path(path);
>>>>               return PTR_ERR(trans);
>>>> @@ -3594,7 +3602,7 @@ static void reset_balance_state(struct btrfs_fs=
_info *fs_info)
>>>>       kfree(bctl);
>>>>       ret =3D del_balance_item(fs_info);
>>>>       if (ret)
>>>> -            btrfs_handle_fs_error(fs_info, ret, NULL);
>>>> +            btrfs_handle_fs_error(fs_info, ret, "failed to delete ba=
lance item");
>>>>    }
>>>>
>>>>    /*
>>>> --
>>>> 2.41.0
>>>>
