Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817363940DB
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 May 2021 12:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbhE1K3C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 May 2021 06:29:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:57463 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235972AbhE1K3A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 May 2021 06:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622197643;
        bh=uKf8HKX6qaicfkdSZPRKvN3UHP49AoY0MKQYcn7PMwM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RyvNwCFhjbLLsJiXMY+zpNG3zYaDKodsIYCxleaYWlzOSA0rheTC5wIeh2i+9tfWT
         y10ox2RJ/1dIdjb8cZXHgKe2mPoRbRcTqAf0k8X4gRRrsD+dxSjqbTRzPJhzgzpMt/
         OFmlPB9mFSOaWofMlRr7sUZ6yY50IN66bAz3b/MA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MkYbu-1l8KY83mCU-00m2Mj; Fri, 28
 May 2021 12:27:23 +0200
Subject: Re: [PATCH 4/7] btrfs: defrag: introduce a helper to defrag a
 continuous range
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210528022821.81386-1-wqu@suse.com>
 <20210528022821.81386-5-wqu@suse.com>
 <CAL3q7H55XRQ5zr3g-brs=eS_kMOb6orsCPYDP7Jr0JxJ45hNOw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <265b2797-393a-3e3d-aa04-c3d6a70b4303@gmx.com>
Date:   Fri, 28 May 2021 18:27:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAL3q7H55XRQ5zr3g-brs=eS_kMOb6orsCPYDP7Jr0JxJ45hNOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4xhxQuedILU1CLHxi5aISWsOuNpXJ+46JeIeayCyi4Dsx88703s
 zIoC175d+mOmJGc0SIrxh7VT4QNg0If4zyn0yxLNyCFAjnwCXIaWlzpfVEkCOfI0qbJ+iBV
 plPChT1RIbLf6UigvM4v/Gxhiqc0an62BEzqfahSoQqufvhOGUpQRN9S13MzycRS01O0eXo
 9fMMxw93TyuynqhHLzBag==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+mmb+uOpMKc=:ooT24KAEvHoAmVMRRTAVz1
 y8S3BKgiOpoUTmJkOzHllj7phumM/0en5Rn0urb4i/5DzC0WwQRaf01Y19Ki5/qpx0y3z9Qiz
 AWLLM3KVBI4D/pRmL469U5MPh6QkQa6/be/0mvX12beSp4qymnPpJkdbEwRMz2bk2eNMyR7j3
 Qq/0cmncq44WdBUXPYtuCjABmO9Ixoa+I5A5tEnJ8biokh81RySKTc8ufhHM+JufGJJE214GH
 9HemeyyMnMJDSsbjSzpxghJOGDl3ebTpNZUP/hC5sPyJqY7ndU6xL9rOEYv8OP1Q8CHGhSRg/
 z8XRZsV404FJ4+FbVIMZL5yzIXEnhr8WoYXCnv0vudPPR7cU4Ph3mVUuLA7FIZuacrzpwPbSS
 nWpBK3tHRFskFRfZ90xj0uy3t9DG3aHLiVrQRzxJLmBf+FSZAtwBMmkggqRAY6ypr9hmfrRq6
 H4+W5j2PMI1lyzd8TOF7jJwXwrRZqwTqgwCUt1KYS9KzCPbeNts4sYp1QSk3+BeQ4tTupp7MN
 7jU0x5b05sFdcyJYIhN/9yXwL8FxS5jAH3JAXRjLYvQ1whvJW3cahwSGRkPXHyT9ME/H6hpYS
 B4vuLDqyLgqMG2NQnVqM42SkyvjuhCQeZDFj6xGIRKr3wZ2nKqfpMSuSfI+bECIgfaePfNzMv
 OlbaSUfTXvdZrMpQgXnMML1jRIjy06he7I/n5591iOVtrJ/2UXtn5ncFaQxlMP+yphsQ0Tpq2
 KRtp1qWk2YTRTDyi7o1xSXY2VnE0kb/ZqWAbTUENmH9qyPuzbHW1Qae+BjOPUqzl3+3kIJ5kD
 3NMhaO7LI3KZJ3oOek3gAveCdze4MKUwYSEHs4hafFrPZ4ub/l0Vyp8WdOIeax2DpuJdOsZy0
 9C5pqJYTIBM0wX0/l/oiHomYseVZ/I9mr2ljRlXlx+ehWcBj9IrcXESwGzVjIDUl+MQq60Clr
 Xy7zg8m/H2/C1L+083fs4rGtY2Zqj9lEklM9CqmFvz4EIM0Od+9vfzNBuSWSz+49UAdkDup4A
 u+6V1kMiGGp2iUOe3rMuUqkR/6/B/Rl2pDfYq7jg+hWS4tzlUmtIJWPUc8vjWKoF1Cd/IY4/+
 YZEeJR1vvwYtEC8GH2aurv8zKmmc9q8GSIsEYCR2D5Uq4cvLSnDfQZiJyYz1MTArWW7ksu2ZU
 dlJPDCKzGA2/MwDgqvbUwyM7Z3IRfSe26Fhz88MIlocMlTTCnD75ko041V4RwH9E3XzzHr6Ly
 T8I2zLi+9sku9O9gC
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/28 =E4=B8=8B=E5=8D=885:07, Filipe Manana wrote:
> On Fri, May 28, 2021 at 7:00 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Intrudouce a helper, defrag_one_target(), to defrag one continuous rang=
e
>> by:
>>
>> - Lock and read the page
>> - Set the extent range defrag
>> - Set the involved page range dirty
>>
>> There is a special note here, since the target range may be a hole now,
>> we use btrfs_set_extent_delalloc() with EXTENT_DEFRAG as @extra_bits,
>> other than set_extent_defrag().
>>
>> This would properly add EXTENT_DELALLOC_NEW bit to make inode nbytes
>> updated properly, and still handle regular extents without any problem.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/ioctl.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++=
+
>>   1 file changed, 76 insertions(+)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 1e57293a05f2..cd7650bcc70c 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -1486,6 +1486,82 @@ static int defrag_collect_targets(struct btrfs_i=
node *inode,
>>          return ret;
>>   }
>>
>> +#define CLUSTER_SIZE   (SZ_256K)
>> +static int defrag_one_target(struct btrfs_inode *inode,
>> +                            struct file_ra_state *ra, u64 start, u32 l=
en)
>> +{
>> +       struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>> +       struct extent_changeset *data_reserved =3D NULL;
>> +       struct extent_state *cached_state =3D NULL;
>> +       struct page **pages;
>> +       const u32 sectorsize =3D inode->root->fs_info->sectorsize;
>> +       unsigned long last_index =3D (start + len - 1) >> PAGE_SHIFT;
>> +       unsigned long start_index =3D start >> PAGE_SHIFT;
>> +       unsigned int nr_pages =3D last_index - start_index + 1;
>> +       int ret =3D 0;
>> +       int i;
>> +
>> +       ASSERT(nr_pages <=3D CLUSTER_SIZE / PAGE_SIZE);
>> +       ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(len, sectors=
ize));
>> +
>> +       pages =3D kzalloc(sizeof(struct page *) * nr_pages, GFP_NOFS);
>> +       if (!pages)
>> +               return -ENOMEM;
>> +
>> +       /* Kick in readahead */
>> +       if (ra)
>> +               page_cache_sync_readahead(inode->vfs_inode.i_mapping, r=
a, NULL,
>> +                                         start_index, nr_pages);
>> +
>> +       /* Prepare all pages */
>> +       for (i =3D 0; i < nr_pages; i++) {
>> +               pages[i] =3D defrag_prepare_one_page(inode, start_index=
 + i);
>> +               if (IS_ERR(pages[i])) {
>> +                       ret =3D PTR_ERR(pages[i]);
>> +                       pages[i] =3D NULL;
>> +                       goto free_pages;
>> +               }
>> +       }
>> +       ret =3D btrfs_delalloc_reserve_space(inode, &data_reserved, sta=
rt, len);
>> +       if (ret < 0)
>> +               goto free_pages;
>> +
>> +       /* Lock the extent bits and update the extent bits*/
>> +       lock_extent_bits(&inode->io_tree, start, start + len - 1,
>> +                        &cached_state);
>> +       clear_extent_bit(&inode->io_tree, start, start + len - 1,
>> +                        EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTEN=
T_DEFRAG,
>> +                        0, 0, &cached_state);
>> +
>> +       /*
>> +        * Since the target list is gathered without inode nor extent l=
ock, we
>> +        * may get a range which is now a hole.
>
> You are undoing what was done by commit
> 7f458a3873ae94efe1f37c8b96c97e7298769e98.
> In case there's a hole this results in allocating extents and filling
> them with zeroes, doing unnecessary IO and using disk space.
> Please add back the logic to skip defrag if it's now a hole.

OK, let me try to reuse the defrag_collect_targets() inside the lock to
exclude the holes.

Thanks,
Qu

>
> Thanks.
>
>> +        * In that case, we have to set it with DELALLOC_NEW as if we'r=
e
>> +        * writing a new data, or inode nbytes will mismatch.
>> +        */
>> +       ret =3D btrfs_set_extent_delalloc(inode, start, start + len - 1=
,
>> +                                       EXTENT_DEFRAG, &cached_state);
>> +       /* Update the page status */
>> +       for (i =3D 0; i < nr_pages; i++) {
>> +               ClearPageChecked(pages[i]);
>> +               btrfs_page_clamp_set_dirty(fs_info, pages[i], start, le=
n);
>> +       }
>> +       unlock_extent_cached(&inode->io_tree, start, start + len - 1,
>> +                            &cached_state);
>> +       btrfs_delalloc_release_extents(inode, len);
>> +       extent_changeset_free(data_reserved);
>> +
>> +free_pages:
>> +       for (i =3D 0; i < nr_pages; i++) {
>> +               if (pages[i]) {
>> +                       unlock_page(pages[i]);
>> +                       put_page(pages[i]);
>> +               }
>> +       }
>> +       kfree(pages);
>> +       return ret;
>> +}
>> +
>>   /*
>>    * Btrfs entrace for defrag.
>>    *
>> --
>> 2.31.1
>>
>
>
