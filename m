Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DF42D96A4
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 11:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgLNKw2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 05:52:28 -0500
Received: from mout.gmx.net ([212.227.15.18]:38469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbgLNKwT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 05:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607943043;
        bh=Q3x3kHguAUU2TigoLxSE7dtLuH17+AyRIY6LYkihcVc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=aR6+u23LDyZzyjrH/xVOHk46Y7ltPjOPML+BV2vcpGEGeGGFktLCdP6O8Nlm36sSg
         9VgfGkVYcxFjtcSZp2xBhjCr0Ssy8QggzfzEwZwCA0gU9iCGy5E4sJGwRX2shtPZd6
         WxNazAlTeOHLkLkNTHOPfXolduz0Cx8ulmngOQ80=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYvY2-1kbY3O2xhg-00UvdX; Mon, 14
 Dec 2020 11:50:43 +0100
Subject: Re: [PATCH v2 15/18] btrfs: disk-io: introduce subpage metadata
 validation check
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-16-wqu@suse.com>
 <a0ff059f-b1d1-29fa-6d0d-2d37a5c5a5e3@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <0741b6ef-106e-8a12-b6c4-267a3ee57b67@gmx.com>
Date:   Mon, 14 Dec 2020 18:50:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <a0ff059f-b1d1-29fa-6d0d-2d37a5c5a5e3@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j3tQXpMAMbGx5mDgUwhbb22V0vnNk6ukI6h3/HtaHFZW5oxwFtg
 0zfoY9U5GsZNjnRQvZfenYYK3jMKTZ5hSzw454KjYYR/Ef7isa0g108ywtozPGyT3finGuL
 RMRvMNfR3d/NYL0pANfsZ4l8DrM1VPvuaM3V6WpoXTLBAybXyiUcJEJXjJWqza8z111U320
 8z2sKSJOWf8m73wJsM8Vw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JjqNQcRokUQ=:she/7gECLDUxwHADAm0IVN
 vkQbwnLosIR+C7Okk5ivTNa3jSRBNva3HjFEEBYg2nmXRMjCnWsNiO9YsdM3A00uDpcFF4Fwm
 RFsmbZaPB7nEhIGbduDFNjieZFUNvKOpPbMwWFVFRrVYI+DaB4hhoBRYeaNPrZQboG6NFEeng
 +taZfRujNGGAStNYkw3B8QQNWryBqjPwJ8DY7oBwem+9Py9xAb6D5iuLlG/zXRH6QsjbROLux
 Ma8e9oysD2J7MwzCbMImFbAIPwO3LvP8BQV/hG9wWtQ+LaEa28o8lEQshux2NOffNqo0pVuV8
 HSKiHhAdFTmfIZQQyefM3O16DjuADT629I0oPC66sKjpjkEgxODBepLiagUfjwzJp8ctaPMGW
 x5MkVguS62QXb4CpBEJmhT+YrOA42G1dR1yqPRaWHO925Cm/8DIdMgz80DV02YrF/DhR0q6UE
 3+iijbA6+ynZXAc7Y7CA/Rb90nKCj6A555svFrnUJaDU2GTlYGs4d5CFvQz+jxiHq8TA0qWMX
 zykec5L9MXB+WTpYJo3Jdsm+FU+u4QGnMIR6LXJwIeZtoDWjHCJq0n/jGEtubpz6dxYekb7pm
 skbb4kQ/nHPe6AEHaxkUQtHxaxZwTBK38tylSgD3ue9leC9sYY2iRdWioVXuaC6ZGrrFqYtIj
 T/5abCX8fFlb0kZjQ4yxRtUlveHAXQT/IZxSTjPlFt5zpCpNjoIOPe7u0ZUvwc/dJmAebXUR1
 UzukPp009cTHELGZR/e3Ut/Wh1CuwVUpGHn1AvUYjht4Az5PAZD3dukg4ik+xoZWPIURZ4r0o
 pupC/4pH2SlH5f0g1FBdRBsAUpVsI8JGs/3le6fu9dfdh8GJUJtiem/lQ4QZIHQmHycu9ICa1
 9q6zEMA2NZUX1JmdllJw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/14 =E4=B8=8B=E5=8D=886:21, Nikolay Borisov wrote:
>
>
> On 10.12.20 =D0=B3. 8:39 =D1=87., Qu Wenruo wrote:
>> For subpage metadata validation check, there are some difference:
>> - Read must finish in one bvec
>>    Since we're just reading one subpage range in one page, it should
>>    never be split into two bios nor two bvecs.
>>
>> - How to grab the existing eb
>>    Instead of grabbing eb using page->private, we have to go search rad=
ix
>>    tree as we don't have any direct pointer at hand.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/disk-io.c | 82 +++++++++++++++++++++++++++++++++++++++++++++=
+
>>   1 file changed, 82 insertions(+)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index b6c03a8b0c72..adda76895058 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -591,6 +591,84 @@ static int validate_extent_buffer(struct extent_bu=
ffer *eb)
>>   	return ret;
>>   }
>>
>> +static int validate_subpage_buffer(struct page *page, u64 start, u64 e=
nd,
>> +				   int mirror)
>> +{
>> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(page->mapping->host->i_sb)=
;
>> +	struct extent_buffer *eb;
>> +	int reads_done;
>> +	int ret =3D 0;
>> +
>> +	if (!IS_ALIGNED(start, fs_info->sectorsize) ||
>
> That's guaranteed by the allocator.
>
>> +	    !IS_ALIGNED(end - start + 1, fs_info->sectorsize) ||
> That's guaranteed by the fact that  nodesize is a multiple of sectorsize=
.
>
>> +	    !IS_ALIGNED(end - start + 1, fs_info->nodesize)) {
>
> And that's also guaranteed that the size of an eb is always a nodesize.
> Also aren't those checks already performed by the tree-checker during
> write? Just remove this as it adds noise.
>
>> +		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));> +		btrfs_err(fs_info, "inv=
alid tree read bytenr");
>> +		return -EUCLEAN;
>> +	}
>> +
>> +	/*
>> +	 * We don't allow bio merge for subpage metadata read, so we should
>> +	 * only get one eb for each endio hook.
>> +	 */
>> +	ASSERT(end =3D=3D start + fs_info->nodesize - 1);
>> +	ASSERT(PagePrivate(page));
>> +
>> +	rcu_read_lock();
>> +	eb =3D radix_tree_lookup(&fs_info->buffer_radix,
>> +			       start / fs_info->sectorsize);
>
> This division op likely produces the kernel robot's warning. It could be
> written to use >> fs_info->sectorsize_bits. Furthermore this usage of
> radix tree + rcu without acquiring the refs is unsafe as per my
> explanation of, essentially, identical issue in patch 12 and our offline
> chat about it.

Another relic I forgot in the long update history, nice find.

>
>> +	rcu_read_unlock();
>> +
>> +	/*
>> +	 * When we are reading one tree block, eb must have been
>> +	 * inserted into the radix tree. If not something is wrong.
>> +	 */
>> +	if (!eb) {
>> +		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>> +		btrfs_err(fs_info,
>> +			"can't find extent buffer for bytenr %llu",
>> +			start);
>> +		return -EUCLEAN;
>> +	}
>
> That's impossible to execute and such a failure will result in a crash
> so just remove this code.
>
>> +	/*
>> +	 * The pending IO might have been the only thing that kept
>> +	 * this buffer in memory.  Make sure we have a ref for all
>> +	 * this other checks
>> +	 */
>> +	atomic_inc(&eb->refs);
>> +
>> +	reads_done =3D atomic_dec_and_test(&eb->io_pages);
>> +	/* Subpage read must finish in page read */
>> +	ASSERT(reads_done);
>
> Just ASSERT(atomic_dec_and_test(&eb->io_pages)). Again, for subpage I
> think that's a bit much since it only has 1 page so it's guaranteed that
> it will always be true.

IIRC ASSERT() won't execute whatever in it for non debug build.
Thus ASSERT(atomic_*) would cause non-debug kernel not to decrease the
io_pages and hangs the system.

Exactly the pitfall I'm thinking of.

Thanks,
Qu

>> +
>> +	eb->read_mirror =3D mirror;
>> +	if (test_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags)) {
>> +		ret =3D -EIO;
>> +		goto err;
>> +	}
>> +	ret =3D validate_extent_buffer(eb);
>> +	if (ret < 0)
>> +		goto err;
>> +
>> +	if (test_and_clear_bit(EXTENT_BUFFER_READAHEAD, &eb->bflags))
>> +		btree_readahead_hook(eb, ret);
>> +
>> +	set_extent_buffer_uptodate(eb);
>> +
>> +	free_extent_buffer(eb);
>> +	return ret;
>> +err:
>> +	/*
>> +	 * our io error hook is going to dec the io pages
>> +	 * again, we have to make sure it has something to
>> +	 * decrement
>> +	 */
>
> That comment is slightly ambiguous - it's not the io error hook that
> does the decrement but end_bio_extent_readpage. Just rewrite the comment
> to :
>
> "end_bio_extent_readpage decrements io_pages in case of error, make sure
> it has ...."
>
>> +	atomic_inc(&eb->io_pages);
>> +	clear_extent_buffer_uptodate(eb);
>> +	free_extent_buffer(eb);
>> +	return ret;
>> +}
>> +
>>   int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio,
>>   				   struct page *page, u64 start, u64 end,
>>   				   int mirror)
>> @@ -600,6 +678,10 @@ int btrfs_validate_metadata_buffer(struct btrfs_io=
_bio *io_bio,
>>   	int reads_done;
>>
>>   	ASSERT(page->private);
>> +
>> +	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
>> +		return validate_subpage_buffer(page, start, end, mirror);
>
> nit: validate_metadata_buffer is called in only once place so I'm
> wondering won't it make it more readable if this check is lifted to its
> sole caller so that when reading end_bio_extent_readpage it's apparent
> what's going on. Though it's apparent that the nesting in the caller
> will get somewhat unwieldy so won't be pressing hard for this.
>> +
>>   	eb =3D (struct extent_buffer *)page->private;
>>
>>
>>
