Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A30765F52
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 00:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjG0WYs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 18:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjG0WYr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 18:24:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3F42D4D
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690496682; x=1691101482; i=quwenruo.btrfs@gmx.com;
 bh=S5RVf6HZpUVJ1bpZ8+LttVZDhDAvKMyU1cqjA5EGjyw=;
 h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
 b=QZlDdfGsCd22LBzzjzi3+dlP5NLfWmB+cV0kcgubNfxTcWMskpNhlmYylGc4CaldYlPokNV
 Xs5tuOyqdybejKhSgyw6LBf27gQNtkXTOjQHitFoXzxfBTmEJ5Slbfhb57CHVTpaoK2din62N
 bXXqScEIoU+k6EGagMtRiMVbi43Ag+44au0XG5yM9bfou9Ue71NboIZPYu3l/DnKoTmLWup/z
 op9r1yl4NFBDiNMNXN7L3/TXQzB5Znl03Arbg/+2Vh0JK3wBn6X/g4Hadcy1x1Dl8UF0lidvu
 xrVkkNSEKPOZ15LVFh+8Ig3rRTgrTaKGr+pCirWGKqeDU0wpbLFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8XPt-1plbbs2IiH-014WoG; Fri, 28
 Jul 2023 00:24:42 +0200
Message-ID: <60fc4f77-7992-1f27-a2e3-98570a48253d@gmx.com>
Date:   Fri, 28 Jul 2023 06:24:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1690249862.git.wqu@suse.com>
 <46e2952cfe5b76733f5c2b22f11832f062be6200.1690249862.git.wqu@suse.com>
 <20230727141840.GC17922@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH RFC 1/2] btrfs: map uncontinuous extent buffer pages into
 virtual address space
In-Reply-To: <20230727141840.GC17922@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q72oQWYQwJ2avgGnk5BZ6wxRaGW/OHbVjAi1a+BeJo6IdmiCGTx
 BujJ1nqy1yKTWMmdOnHbMAXURf8qa6iLQsCOeBfYiE0VxZ5dSKDgU4TCGG56rWGMIg7vQ8B
 tpNhsGL63tuL+4txUBWFMYPmkyeIEk66E5toSJxG/oNImeLOwYobxmbto9AX7tJczhZzlXg
 1i+yTTyUdPwcOGPpKxaew==
UI-OutboundReport: notjunk:1;M01:P0:b7U+v51iIVA=;HTiIfhvKhdqhT8U3ygX6QZMB9lw
 oMIChK1/gSF92JzjGkdECoMFWJKyjGGhmlEi+gmaOp777WFdcdpDqSno0hxZzirDwJye1ooga
 hnhgAQlfBIKag1TodZTUH9Uk8+YGA+IyqTOJAMfTKOKLjcHr0wQh9UzuV+CHbYYOhW8/CGYlV
 EOpVr0xxLIm5CfH6Zh0EYkJ2pEpgYsSV+TZ9MUI8dQf5l+1g12xkgcRfM4USKkFKuySLt49q3
 NYND41hPg1sGGdCPsmoypornIQWPenA+1+kFr/ixXhHmmVoNt6waN51DjQbwXpG/PKNDrEOfZ
 XsorbJcd07K9HhjF8E718LXSYIPA88K9xXdQhkKsERC8BHgXuIxUnGUw9kg/3K4RvzSuZcZqF
 s4p8xwcwQXHSZqTHbCkLjw4R4LgXUoDWkgaMlTgjnD8IZ/qzNfFydscNLdpCpNVMqBm0vKwTn
 I3oZH4UlLCvUTI1ih/W5AdcC0SVaNnYUq39qcUah5NLTdIGBaLEhhKUUsQkjSV6UCn0dy6Ss6
 5ur1azETNVjS+r/DBLky352ZeMQcE3sWdmZgXwKyfXpsjbMgt2UwE5SxFgrV9aFPaH1Xo9XLQ
 Iv9lVNvFDoqaZBQ0TGlZ87VkfGZAgqXzhQ32MKpGJqbM1QxeFCNBqTprlhzFhSpvwCRGu5OjD
 89ZNU8bioLLK3zWpCu/OqTXmbCRj+0GebdkHSwIVxIYT6F0LMz2Dt0pkVwWjrezNNwU/YRIfL
 gqWEBmvSy8oeTMoC4jWjjF8S03hHj1rm4p7rWqOLQ6ZVWXmFLG5OPo3eJRHax8PLPa0ioSsM6
 eEm7+DJR8Auv9cARgjaxVvNE3h48Vu6z8NH4GwmoAK9K9lqgPLoGBNuK2ehnZOL6ltwmD8Cj/
 9DaiibJ9rDc5/xLpMCHhRvDNrZ3nrxsADY8cLLlepn+W59xgH8Z8oh/BFEnYrLEd2+P792vwp
 EkBoISJnaiUEI4BhoCRrL2yChng=
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



On 2023/7/27 22:18, David Sterba wrote:
> On Tue, Jul 25, 2023 at 10:57:21AM +0800, Qu Wenruo wrote:
>> Currently btrfs implements its extent buffer read-write using various
>> helpers doing cross-page handling for the pages array.
>>
>> However other filesystems like XFS is mapping the pages into kernel
>> virtual address space, greatly simplify the access.
>>
>> This patch would learn from XFS and map the pages into virtual address
>> space, if and only if the pages are not physically continuous.
>> (Note, a single page counts as physically continuous.)
>>
>> For now we only do the map, but not yet really utilize the mapped
>> address.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_io.c | 70 +++++++++++++++++++++++++++++++++++++++++++=
+
>>   fs/btrfs/extent_io.h |  7 +++++
>>   2 files changed, 77 insertions(+)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 4144c649718e..f40d48f641c0 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/pagevec.h>
>>   #include <linux/prefetch.h>
>>   #include <linux/fsverity.h>
>> +#include <linux/vmalloc.h>
>>   #include "misc.h"
>>   #include "extent_io.h"
>>   #include "extent-io-tree.h"
>> @@ -3206,6 +3207,8 @@ static void btrfs_release_extent_buffer_pages(str=
uct extent_buffer *eb)
>>   	ASSERT(!extent_buffer_under_io(eb));
>>
>>   	num_pages =3D num_extent_pages(eb);
>> +	if (eb->vaddr)
>> +		vm_unmap_ram(eb->vaddr, num_pages);
>>   	for (i =3D 0; i < num_pages; i++) {
>>   		struct page *page =3D eb->pages[i];
>>
>> @@ -3255,6 +3258,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(c=
onst struct extent_buffer *src)
>>   {
>>   	int i;
>>   	struct extent_buffer *new;
>> +	bool pages_contig =3D true;
>>   	int num_pages =3D num_extent_pages(src);
>>   	int ret;
>>
>> @@ -3279,6 +3283,9 @@ struct extent_buffer *btrfs_clone_extent_buffer(c=
onst struct extent_buffer *src)
>>   		int ret;
>>   		struct page *p =3D new->pages[i];
>>
>> +		if (i && p !=3D new->pages[i - 1] + 1)
>> +			pages_contig =3D false;
>> +
>>   		ret =3D attach_extent_buffer_page(new, p, NULL);
>>   		if (ret < 0) {
>>   			btrfs_release_extent_buffer(new);
>> @@ -3286,6 +3293,23 @@ struct extent_buffer *btrfs_clone_extent_buffer(=
const struct extent_buffer *src)
>>   		}
>>   		WARN_ON(PageDirty(p));
>>   	}
>> +	if (!pages_contig) {
>> +		unsigned int nofs_flag;
>> +		int retried =3D 0;
>> +
>> +		nofs_flag =3D memalloc_nofs_save();
>> +		do {
>> +			new->vaddr =3D vm_map_ram(new->pages, num_pages, -1);
>> +			if (new->vaddr)
>> +				break;
>> +			vm_unmap_aliases();
>> +		} while ((retried++) <=3D 1);
>> +		memalloc_nofs_restore(nofs_flag);
>> +		if (!new->vaddr) {
>> +			btrfs_release_extent_buffer(new);
>> +			return NULL;
>> +		}
>> +	}
>>   	copy_extent_buffer_full(new, src);
>>   	set_extent_buffer_uptodate(new);
>>
>> @@ -3296,6 +3320,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer=
(struct btrfs_fs_info *fs_info,
>>   						  u64 start, unsigned long len)
>>   {
>>   	struct extent_buffer *eb;
>> +	bool pages_contig =3D true;
>>   	int num_pages;
>>   	int i;
>>   	int ret;
>> @@ -3312,11 +3337,29 @@ struct extent_buffer *__alloc_dummy_extent_buff=
er(struct btrfs_fs_info *fs_info,
>>   	for (i =3D 0; i < num_pages; i++) {
>>   		struct page *p =3D eb->pages[i];
>>
>> +		if (i && p !=3D eb->pages[i - 1] + 1)
>> +			pages_contig =3D false;
>
> Chances that allocated pages in eb->pages will be contiguous decrease
> over time basically to zero, because even one page out of order will
> ruin it.

I doubt this assumption.

Shouldn't things like THP requires physically contiguous pages?
Thus if your assumption is correct, then THP would not work for long
running servers at all, which doesn't look correct to me.

> This means we can assume that virtual mapping will have to be
> used almost every time.
>
> The virtual mapping can also fail and we have no fallback and there are
> two more places when allocating extent buffer can fail.

Yes, it can indeed fail, but it's only when the virtual address space is
full. This is more of a problem for 32bit systems.

Although my counter argument is, XFS is doing this for a long time, and
even XFS has much smaller metadata compared to btrfs, it doesn't has a
known problem of hitting such failure.

>
> There's alloc_pages(gfp, order) that can try to allocate contiguous
> pages of a given order, and we have nodesize always matching power of
> two so we could use it.

Should this lead to problems of exhausted contiguous pages (if that's
really true)?

> Although this also forces alignment to the same
> order, which we don't need, and adds to the failure modes.

We're migrating to reject non-nodesize aligned tree block in the long run.

I have submitted a patch to warn about such tree blocks already:
https://patchwork.kernel.org/project/linux-btrfs/patch/fee2c7df3d0a2e91e9b=
5e07a04242fcf28ade6bf.1690178924.git.wqu@suse.com/

Since btrfs has a similar (but less strict, just checks cross-stripe
boundary) checks a long time ago, and we haven't received such warning
for a while, I believe we can gradually move to reject such tree blocks.

Thanks,
Qu
