Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B9B304663
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jan 2021 19:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbhAZRWj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 12:22:39 -0500
Received: from mout.gmx.net ([212.227.17.22]:46103 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389546AbhAZHjs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 02:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611646697;
        bh=QDbc/dzm7WHxKBZSg1ISc2DT4KDEwi2oHU2J58qb/b4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=OLF162ueC0ZYQYtcmXJ9V97YXz2zWIUbTinZJescPIZoU+D2fmyaVOV8cDqwz+4jY
         zckrrktyOV5qnntk/OobkNutlq+I82AcmHZaY/oRTSp1zbPbYeQZDq6Z7+Qv2gLQ+N
         uPKLERPr2BDMiH0u9pkFh0fV0cVIEftqyx6DEaik=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ml6m4-1litsP0A28-00lVj7; Tue, 26
 Jan 2021 08:29:25 +0100
Subject: Re: [PATCH v4 04/18] btrfs: make attach_extent_buffer_page() to
 handle subpage case
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-5-wqu@suse.com>
 <5a6223fc-9937-3bd6-ecd0-d6c5939f59a7@toxicpanda.com>
 <20210119223518.GS6430@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <3ec1e4e4-c154-309d-5a75-cba85a20fd9c@gmx.com>
Date:   Tue, 26 Jan 2021 15:29:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210119223518.GS6430@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:65vkYkl2nXCYLqFDJx3yiVwWUOO37DafInPaidSBCBZpVRM/HjL
 b6e5Gzqbn92LZJocHxn3Lkd9ixRq8MBcZfE/sV9uRuf7J33CpWh45Qb8XyMDPXrd8BVuuKZ
 896pSPL2NGtMhtLqPNjKAZlfB5SVma7966tuMLIu1Qwkm9BfJNMw/75tdR5oMUCnBpvIpTo
 itDkPEN+mazB+I/pjQDBA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CGUITqtW8xY=:s8h7+Ax7nychQvOeYufvJ8
 jjNf6ZL0dcpK/iyXIEmfVjORfID8wcHU/3GcG8JoDVXywPiEG+LigdhNsSNE/zwn2EC3h1cJL
 1gdv5H49qWxBiyknty2rSlQ2g5sYLnDLWLjlRTgTMaOlJghG63JpK91CBPouTB6naXSyIeVjX
 ULk95J2G3cWuJOGHhaJPViT8LCzUQABbdJym4dyXC45ELTnEvRCRvmeeKni4c5SNWFMsCi/jf
 1qzVB1bXq8uz162AtwucEh4JxdX7IxUwoqXRmWNQp8U5TQYhis5BbTz08rBOjdEpeuZzg8RsG
 DHVy01bffVfDmmbKXsm5c8ZPpCKn9jN80pzwaDyTPjVTuW8WH6VBpg+vG6uJ0wPrL2IFCuYB1
 6hjkgCFI2XtrpeI0hUAuw/MCMiHgoRzepjtGvoy2VwwNCmUiJ+aI7nsKOP5zzIDBaMtx/XB0i
 YD9nfTqFLi+soOH6TkrfzlLlDAm7qm6E0pQyJeveRXxUfFOstLwCwQnqKUOkwN/dB7Eme7u8S
 skf+UT/8LsLcl4/CXJ0WUtXmyWY+I3chjMWT3TT65tbq0+t9RCW0qCrNbXMGbpRDu+hh0zzUp
 U2bsQz/TsPCas4h76NjcVa4zRSZESJshCAGTDPrkSAvo29AvnbBV1ZlAZGnAb7rI8bZXB859N
 Ru75NxLOZkMNlggZQ1gpt1Ngm3/GEXoQFP0xrjdMXOlUxuM2nJTLa9ae0LJkuzr0/jHrzvsZ2
 qzuwhb1a8bOa0Sl9KZeEmQRZu7kBsKiwLsEJ4xIjUsXOS57MzglkzmLB6uy0exEXASr8Qw06a
 W7UFfu6OGc87lgRRISr4S0/cWdXgf2livju0XL9R+qj56Rq5JD4jHYs72RjtrZpvjlnjFvHFj
 JeJZntYKEhM8Y3R05+Aw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/20 =E4=B8=8A=E5=8D=886:35, David Sterba wrote:
> On Tue, Jan 19, 2021 at 04:54:28PM -0500, Josef Bacik wrote:
>> On 1/16/21 2:15 AM, Qu Wenruo wrote:
>>> +/* For rare cases where we need to pre-allocate a btrfs_subpage struc=
ture */
>>> +static inline int btrfs_alloc_subpage(struct btrfs_fs_info *fs_info,
>>> +				      struct btrfs_subpage **ret)
>>> +{
>>> +	if (fs_info->sectorsize =3D=3D PAGE_SIZE)
>>> +		return 0;
>>> +
>>> +	*ret =3D kzalloc(sizeof(struct btrfs_subpage), GFP_NOFS);
>>> +	if (!*ret)
>>> +		return -ENOMEM;
>>> +	return 0;
>>> +}
>>
>> We're allocating these for every metadata page, that deserves a dedicat=
ed
>> kmem_cache.  Thanks,
>
> I'm not opposed to that idea but for the first implementation I'm ok
> with using the default slabs. As the subpage support depends on the
> filesystem, creating the cache unconditionally would waste resources and
> creating it on demand would need some care. Either way I'd rather see it
> in a separate patch.
>
Well, too late for me to see this comment...

As I have already converted to kmem cache.

But the good news is, the latest version has extra refactor on memory
allocation/freeing, now we just need to change two lines to change how
we allocate memory for subpage.
(Although still need to remove the cache allocation code).

Will convert it back to default slab, but will also keep the refactor
there to make it easier for later convert to kmem_cache.

So don't be too surprised to see function like in next version.

   btrfs_free_subpage(struct btrfs_subpage *subpage)
   {
	kfree(subpage);
   }

Thanks,
Qu
