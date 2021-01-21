Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929B22FDE7D
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 02:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbhAUBAw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 20:00:52 -0500
Received: from mout.gmx.net ([212.227.15.18]:52183 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387716AbhAUAqz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 19:46:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611189919;
        bh=N2kdwjwHu8M2PnS2XMdWIgWMJpAmkBHRlmgSITpLHjY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=XkYRZWVfKREFdbthE5GCtnTCnop7EAk9bdsHBPkqGHCTEYmSWx6PEL/MztikUc3P6
         q+4tdskgyaWnAh1f8KIvPAhz1fk4mYHBxBeQcFWG2KIWvbBE4+eGrbCLtAU/CAjeVP
         9QrUWY8aIH9Cft6AYEe+XYJ5lAVv78YrEhIFy8c8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N49lD-1m25VO0ZHt-0102tx; Thu, 21
 Jan 2021 01:45:19 +0100
Subject: Re: [PATCH v4 06/18] btrfs: support subpage for extent buffer page
 release
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-7-wqu@suse.com>
 <deac0208-7c23-f51b-7ff0-c661feba9806@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <f9c46ab1-6797-c639-3d88-c59543e44b19@gmx.com>
Date:   Thu, 21 Jan 2021 08:45:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <deac0208-7c23-f51b-7ff0-c661feba9806@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YBtvKlrJX/8W0mOflto7LWg/8liqv6kLjVtyORuU64JvNzO91nx
 KxJSbjxQlqhfeAK0Dk43mZg7mBO0WVC5qmf3nzy2CtOGsgkz/NPIbQqB/Vdko0wRLeD5hQz
 CWTigXFljeJgNKVXyuEU6bP+XsdkcyJba7CEwnv12dsUqRDiXGFbqXoAaLiHvGJysgkuPGR
 hNGN0tE7EVqhXICi/k0rQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xo6MPUOKtfM=:ZdU/duQP4yQI0KTR8CWAlu
 lMYI2RPe/EUgjlbmdqYUxPJ4trHbG3SovmL3Cp9THlE/qLvSSq3Hefd5L0SUW9R5LRRK9vRBT
 ZqaeCP7bqZK2cQLlBdLpvgKolRBoUQxZhxMELiRDglr5BtCMRebVOOd5jvplT5zq3neSOmnio
 pGkXi6y0H6ENdrTUHxHue3WfTXULhldukgrUorGT0a6+GIP3Tu+oS8m+7K3gKgBP0o5hq1yAI
 SxdtwzT4EKLVWIyK7YwYMR8BaJu7atszcSkUw/7oh6dfk53xQlcqD2BVmdoqWj4PK0vCzHM62
 jAUUz3H8scvonmC3qELxf4GHydvlPvs5b6TBP/DZisosg4eKKvg6+u6sqsJdIkO04K6ytKYrv
 ALH1pNOfB2g1fMDJeqpCHK/ev3DXbpWTYJ80P7ZY9MgKo4n/LBrgD50eJOOodFOy38erK/097
 Gq8mERuS6+fSkEntKfJiELSbG/6IH2Ge+5pElEQsd77ICsDRD7q1BtY6ZlnzxJvTs2DN8MtKH
 cgfUfxSPN02lIr7DcL3BS5qDuDt5HJodTud5pf3nqbKhKMUI2uod+4Ifrwq1MXNMhwekuVdAt
 rLxiICUw8XKMnsyXggjUyuoQ/ffIpXknS0Ib9wEU4o3NgCK5nJw177m+8Skn34myqIwrQ+vYZ
 gi/V/UWBcNZtAWN2jORY9E6ztWQH4rbK67xJ1qpSFXOrqYE2MHrrRO3h2LhTGIPkk8J0FuLK7
 oKuWKQPHSB1a4KMMfYXKoN+Zs8m5qg4AXF/EbmRp7IlDIKaX9HHA5XfRHTsKlz6OlgsiBn4DR
 bBzrizp8jTJjyDyQTsrKBwH1rknKXHIIAksQl1ZsSXiVmUCPgI2E6la8JXLJEQxejPaggsHl3
 Eofi1BSEJj6VQi75zESA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/20 =E4=B8=8B=E5=8D=8810:44, Josef Bacik wrote:
> On 1/16/21 2:15 AM, Qu Wenruo wrote:
>> In btrfs_release_extent_buffer_pages(), we need to add extra handling
>> for subpage.
>>
>> To do so, introduce a new helper, detach_extent_buffer_page(), to do
>> different handling for regular and subpage cases.
>>
>> For subpage case, the new trick is about when to detach the page
>> private.
>>
>> For unammped (dummy or cloned) ebs, we can detach the page private
>> immediately as the page can only be attached to one unmapped eb.
>>
>> For mapped ebs, we have to ensure there are no eb in the page range
>> before we delete it, as page->private is shared between all ebs in the
>> same page.
>>
>> But there is a subpage specific race, where we can race with extent
>> buffer allocation, and clear the page private while new eb is still
>> being utilized, like this:
>>
>> =C2=A0=C2=A0 Extent buffer A is the new extent buffer which will be all=
ocated,
>> =C2=A0=C2=A0 while extent buffer B is the last existing extent buffer o=
f the page.
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T1 (eb A)=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 T2 (eb B)
>> =C2=A0=C2=A0 -------------------------------+--------------------------=
----
>> =C2=A0=C2=A0 alloc_extent_buffer()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | btrfs_release_extent_buffer_pages()
>> =C2=A0=C2=A0 |- p =3D find_or_create_page()=C2=A0=C2=A0 | |
>> =C2=A0=C2=A0 |- attach_extent_buffer_page() | |
>> =C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | |- detach_extent_buffer_page()
>> =C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 |- if (!page_r=
ange_has_eb())
>> =C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 |=C2=A0 No new=
 eb in the page range yet
>> =C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 |=C2=A0 As new=
 eb A hasn't yet been
>> =C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 |=C2=A0 insert=
ed into radix tree.
>> =C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 |- btrfs_detac=
h_subpage()
>> =C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |- detach_page_private();
>> =C2=A0=C2=A0 |- radix_tree_insert()=C2=A0=C2=A0=C2=A0=C2=A0 |
>>
>> =C2=A0=C2=A0 Then we have a metadata eb whose page has no private bit.
>>
>> To avoid such race, we introduce a subpage metadata specific member,
>> btrfs_subpage::under_alloc.
>>
>> In alloc_extent_buffer() we set that bit with the critical section of
>> private_lock.
>> So that page_range_has_eb() will return true for
>> detach_extent_buffer_page(), and not to detach page private.
>>
>> New helpers are introduced to do the start/end work:
>> - btrfs_page_start_meta_alloc()
>> - btrfs_page_end_meta_alloc()
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> This is overly complicated, why not just have subpage->refs or
> ->attached as eb's are attached to the subpage?=C2=A0 Then we only detac=
h the
> subpage on the last eb that's referencing that page.=C2=A0 This is much =
more
> straightforward and avoids a whole other radix tree lookup on release.
> Thanks,

That's great!

Although we still need to go radix tree lookup, as even we know how many
ebs are referring this page, we still need to get the exact bytenr of them=
.

But the idea still looks awesome. I'll go this direction in next version.

Thanks,
Qu

>
> Josef
