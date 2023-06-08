Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D247278CF
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 09:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbjFHH3F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 03:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbjFHH27 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 03:28:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AED271B
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 00:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686209326; x=1686814126; i=quwenruo.btrfs@gmx.com;
 bh=vkzqbzGGp1V2OtmW/KgDsRy0nfjKp3T/FaWX7gvfEfY=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=CJnEUJL1OIQNjsfxuiEyoSx2hIXfLdqqdHT6j23OEvyB6WTki/LP8S63wcm7Gz54wUyu/PY
 c92xf3NGw+qTId7VOrW5uNzRlCUK3uoIhCelV+p6BROmcjbHbVk0V6Hd9IWNZ7KBA10L+7A6k
 2ANTr68y/Fgn7uV7Jn0nCm9EbBVfvrgU/TMZU3UMb6x21lgdD3WmvzYy6XN6U6cfVqcxh3Ahv
 mfCGJiTLrMPqQDj+g8HnrEwPVEmdxzbr+sqUiSiFIGXjcSSQYx/PT/uuuroxt+46Kn8HjQo8N
 O1kkoEtu800AswSza4vQXKYXlZDQyYIT6IwWgOwyi0319wXsUA7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhlGq-1pcFAr1DYe-00dmrP; Thu, 08
 Jun 2023 09:28:46 +0200
Message-ID: <32ad876d-b923-edc0-fa74-30ea52e75a89@gmx.com>
Date:   Thu, 8 Jun 2023 15:28:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/7] btrfs-progs: rename struct open_ctree_flags to
 open_ctree_args
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1686202417.git.anand.jain@oracle.com>
 <d6b012af9307b8ff71a3715e2e3d5cc58fafbee4.1686202417.git.anand.jain@oracle.com>
 <ed6225ca-2580-de48-4d2e-bf637ead2993@gmx.com>
 <c657c159-aff1-5cd6-cd10-b5ab271bb80d@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <c657c159-aff1-5cd6-cd10-b5ab271bb80d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FxlbdhMAs6JrX6wQnnQHwPAdUT5UmeH4rsmYyR2rMosZVLlcUD6
 svBusiTLAyYBqS03yc35KAPwK7bvLNYn9Z/TjGNmMMKMatkfzdeBpa03jmkJVfGWzjj1HPt
 kivUjfGwgiIbLXuwI09/9cQ0fiIRdUPWrzm2tFJJERBEipZrm8Zkg2cGNKyUVf8bC6roF8H
 tEMvE2i9TRc4bUEg9u8RA==
UI-OutboundReport: notjunk:1;M01:P0:qCOIJag2f8k=;0BKIt2rxhTwi7fqK/OYk6KkSNy7
 Lpg9FAbR9gSgt8CH0J5/VEG04GhpXHP4UFywFrUT0JuRDBYykiJhyH3cjAr9c2+ceszVYtmLI
 Dj+OvFRGNcgJpzPU3dTVrc2SLawaxT+mk3na0YPeUQZ0DgwSogrUIEXKpkdVwvrUyVVH36uRp
 b5toqntHBkTPbZG9eJnzLSQiaTaT6mPfIW2dkuS0bYiUzIErzomw2gcqlpCNT+4MynIeXnl8C
 0SJs6+LOyXx0AAnC0uEF9ll18BABTYlZ6CXZb2Xm4aAqngppcYBYQBLpTDOHUJ2QTCKYuJJfe
 F71cr8UpSRirUNs6EIpLJjqhusbmR1HU2liefweUXKqXO9xSHRlYNNJvxrnU8i0xSaWWWlQDS
 PMS6SubBsJLz8MbrtllmOXP9RrwE9lMLA7H5OnfZIuEHU7BssI0gV8NZOVeQm+NQgfntxCnzJ
 B8SbPFmlooyS1ECvcI6Z/Gx0n2DDbJa9mD84B03+7DF8DFIoR6fBHtke6N+4xjgNsx4LAr3Xw
 Sch/XDHegzdeMS3j5OIdwllFGnMKHCov6/W3iVwMONMOK4BoGD0H5JhMS6wxQiZXwZK8yE3Sp
 WUq/kF1554D8E8Hy6D0edjGFtAE8Rc6pxr4oSmEtJq4K+LvcsDDEqB0sUMr2i2XJ1LufksUN9
 LZM6SHbF+zP/RUCTTmt4UWWWzgaai82VrxUtkpH0aoDNglzf+0WVinrElqE34L/lzDxQBsRzq
 3Tixk5BWBscK9Jbdeu6BB8HspEVjityw4cstCbhrQTGlCVBnVzR4hySNvJANWZgl+1xhppWpm
 WhU2CwHhexaN0Lu3xp9ImeEp6gjHvczVRdGzyqunURRw2DudyyuERaX+P+bcGWq2LuKQsMYsL
 7oHV1/HTteUrJV2vS+hzVz1cf0SmUxHQt1ryOsIbeF10K/I4ruXe/3+z5S/YAMlB7rj7YGP2g
 9KsmAZ14UsGfhYBTmYwJEihFZU0=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/8 15:10, Anand Jain wrote:
>
>
> On 08/06/2023 14:14, Qu Wenruo wrote:
>>
>>
>> On 2023/6/8 14:01, Anand Jain wrote:
>>> The struct open_ctree_flags currently holds arguments for
>>> open_ctree_fs_info(), it can be confusing when mixed with a local
>>> variable
>>> named open_ctree_flags as below in the function cmd_inspect_dump_tree(=
).
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0cmd_inspect_dump_tree()
>>> =C2=A0=C2=A0=C2=A0=C2=A0::
>>> =C2=A0=C2=A0=C2=A0=C2=A0struct open_ctree_flags ocf =3D { 0 };
>>> =C2=A0=C2=A0=C2=A0=C2=A0::
>>> =C2=A0=C2=A0=C2=A0=C2=A0unsigned open_ctree_flags;
>>>
>>> So rename struct open_ctree_flags to struct open_ctree_args.
>>
>> I don't think this is a big deal.
>>
>> Any LSP server and compiler can handle it correct.
>>
>> Furthermore the rename would make a lot of @ocf variables loses its
>> meaning. (The patch doesn't rename it to oca).
>>
>> To me, the better solution would be remove local variable
>> open_ctree_flags completely, and do all the flags setting using
>> ocf.flags instead.
> s/open_ctree_flags/open_ctree_args makes sense as this struct is
> not just about the flags.
>
> struct open_ctree_args {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *filename;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 sb_bytenr;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 root_tree_bytenr;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 chunk_tree_bytenr;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned flags;
> };

OK, then you may want to also rename @ocf to @oca.

And since we're already here, removing @open_ctree_flags also makes
sense, as we can directly use oca.flags.

Thanks,
Qu
>
>
> PS:
> We also have
> enum btrfs_open_ctree_flags {
> ::
> }
>
> Thanks, Anand
