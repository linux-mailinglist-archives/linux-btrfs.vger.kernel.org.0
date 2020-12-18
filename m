Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945D82DDC76
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Dec 2020 01:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbgLRAup (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 19:50:45 -0500
Received: from mout.gmx.net ([212.227.17.20]:34605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbgLRAuo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 19:50:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608252551;
        bh=sjFP26ZKgLmeyFmnJivz6XkQsdqnMZ0uv4dCVk86Y/A=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fnEvtoh7HB36P660n2r5Tu4+aE/MGPE725Xl5xhb88YUM24VEjwhrsBOk/46TYhxI
         3nj2STLoqkYLtMEL0CkkOF07sHYLcYn4iq8gXxPhIEQHPViL4/KKG0JIiXZmGrjugw
         Ff9enZSP4HaJn/HvjCwTwUFH01w/kmq/3+eWG4Ns=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mel3t-1kHY5C0AtB-00alrw; Fri, 18
 Dec 2020 01:49:11 +0100
Subject: Re: [PATCH v2 07/18] btrfs: extent_io: make
 grab_extent_buffer_from_page() to handle subpage case
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-8-wqu@suse.com>
 <1c8ed0da-be1f-740c-ee91-232a6640dc2e@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <1076be3c-398c-8e26-4415-88de422d9ac1@gmx.com>
Date:   Fri, 18 Dec 2020 08:49:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <1c8ed0da-be1f-740c-ee91-232a6640dc2e@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WcE54v2JSsRV2RiaaSXnPzluI94NCJle7xd3SeCcmivQ0nams0i
 hBAJXrynJtZhXmECmMAE2ieAURc7tskdeoX1sxHn63cAx8skcauzSBCSFbWKpyuoV3xbE3Q
 lpBKBktXSuEofzBPSZ0Zs2b7PQncSmWfYtDXvPZ/RcuQGgGUFLs84zQZDdz37R8OwJx/quw
 ZVPhW6DV7SScyeWBjjHKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sc9rXK7IxB0=:yIIk/uuMmgpodNIp3LC+df
 NuX03Lx6jXWLPF2aHtPabv+xUOQ1/JnWJG/cvtdZh2AM72uxluIHM9Y5j4EEi4iTjmbUtkHkm
 kkTxgd1qXSUfiaafMZo3E6Pu63ShCIZUqtEF+OX3IUPsDbO0x5HT1De3KpkW18O8KLuP8EcCA
 nGlH48OcNkGmowSc7F/g73oWm5P2LFflT96B5s/uMdfA6SEUnfqIxgK+LI4mbJ8ARx2WoN1oz
 TnzitmhbWx+E7neILBZjC4kto3shPjky/n8Gq5/3aTiasF290NjIvJCXmJoDX1V0hL9BdSftb
 vbbLg+f3PQqJ79WyzfqYwb54PAMRL0XgTB3rkeRxbcTVjL4XL357RSHCtWfj4TwBSVTKzpGT9
 TL+mSoccsaKWXDKvJlblBc3ZxgFlJv5wI9zCaa/jgzdTpcxqmXunCZEyHJY1gaaNwq25b9SdC
 uyj0gfErQ6sAEscwWcQjM+dk+LykbfRS8GQQn/LkQHAsy6SPdvJBKILLgrug4U63xKYnW4bja
 08rtc2x1SbN2fW0kFRdMDqZVhWJYr5UWP1fKmZfG60pKNNyf1pm06kPbefT5Qm4iNnt3EjyQt
 BFfqVrHlvnZ05dk1avt41tbhCARtpkM5ySlAj7k6bpivR5R23qfjeloigG6paZzPqjF7lOODc
 ymwAbYqXUE6xl5/7lGEYGokIs84yiurFXhwDxzgDP9Oz/j44ngNImU1Qfs0O/KeP7H/c0Q4XV
 ku8HRohClpPfuevhNkCczqL8KMsgx7ZEbe5Fwzz2a9pZPbp1POxNe9OSxKk/v7dnqdE6xSp2J
 ywp/YkX41KsG54T9dwJ2uWUT5iTCZGbNG9ZMCvtRvyOxYmK6cdqr/YuRQ974rX9LCEHUkbo8C
 PBGtJCIB8kaK20kQ95NA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/18 =E4=B8=8A=E5=8D=8812:02, Josef Bacik wrote:
> On 12/10/20 1:38 AM, Qu Wenruo wrote:
>> For subpage case, grab_extent_buffer_from_page() can't really get an
>> extent buffer just from btrfs_subpage.
>>
>> Although we have btrfs_subpage::tree_block_bitmap, which can be used to
>> grab the bytenr of an existing extent buffer, and can then go radix tre=
e
>> search to grab that existing eb.
>>
>> However we are still doing radix tree insert check in
>> alloc_extent_buffer(), thus we don't really need to do the extra hassle=
,
>> just let alloc_extent_buffer() to handle existing eb in radix tree.
>>
>> So for grab_extent_buffer_from_page(), just always return NULL for
>> subpage case.
>
> This is fundamentally flawed.=C2=A0 The extent buffer radix tree look up=
 is
> done _after_ the pages are init'ed.=C2=A0 This is why there's that
> complicated dance of checking for existing extent buffers attached to to
> a page, because we can race at the initialization stage and attach an EB
> to a page before it's in the radix tree.=C2=A0 What you'll end up doing =
here
> is overwriting your existing subpage stuff anytime there's a race, and
> it'll end very badly.=C2=A0 Thanks,

We have page lock preventing two eb getting the same page.

And btrfs_attach_subpage() won't overwrite the existing page::private,
thus it's safe.

Thanks,
Qu
>
> Josef
