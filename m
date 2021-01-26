Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC281304514
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jan 2021 18:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbhAZRWU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 12:22:20 -0500
Received: from mout.gmx.net ([212.227.15.15]:60547 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732465AbhAZHHk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 02:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611644762;
        bh=4+YaCvYqSa19dhNUQTeiL6NCrErGlRqJr/RFe7huypI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Ev2s4MhBC5wN8L2uSgGJMt8uB6w2DeAF8YHVybGHcIvP05UAhWr/quyH+nWon/x0S
         f8GWhY8rr4vTiDDhBmOhmd0oiXPSMpfcpdguVmqA7ErZYJ5jDVTh3OAthyyx31Im30
         3CDcs+h06Yr5YrwOtoCNfu3PqIV1VQMp8Pvaj++8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYvcA-1lZ6xC1DkW-00UqBd; Tue, 26
 Jan 2021 08:06:02 +0100
Subject: Re: [PATCH v4 16/18] btrfs: introduce btrfs_subpage for data inodes
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-17-wqu@suse.com>
 <886e0c40-67e6-9700-1373-b29de2e3be95@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <f8b931b1-d6bd-2b1d-0f00-74dcc5775dbe@gmx.com>
Date:   Tue, 26 Jan 2021 15:05:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <886e0c40-67e6-9700-1373-b29de2e3be95@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cvVfyh1RwwNirSbdp8usPwF5XqZXDY348XykD3FXKuwTgiSNrY/
 kMNgv/DSUqLIqmkhr82Q9HtfBAH3shA2ROqKyFkYvX1/rDsxpTCgXVvLiMt3OnG5O3Z6xX+
 sTb9zpipq9DuSE3s86igKoc34AxZEcfplDK9Zldwg5Ox6+q0obowOOGGddpDtrHSckgmXGm
 R7hQ0mBrfDOZ1tA8P8eHg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cq6bBJqkCDM=:3J0wEpEZdW1fwHlCcR9g2/
 j/AGrA/NFJe6TmJVdRBcR6xlT2BgKyKAt31utYuU6oFLi+6KhNEHiv9Ifk0Hc62pYxZUfxoch
 7QeWb1YJbqedB3oa9ChyWyHxqzFeLhI/Pz3//2juqe+BSACfr9Ly1bIyCxyCed9uIPl+R/LGE
 tp+uh/WKLuzT3KnG45MxDp4XrVk3ipbmOyoeXgnz2mT/RBItb98i4bPOskMyRcVkhFp9x68Nj
 pYBfFGW2mYKcrdObSQY/zsfl7tswcHn8eFk4WtSLDvlFo+Ux8eyIQEbzDQueCv6rainsEp8A5
 aYxGeOnM7p797Xr971Gg3Gv91JelWd6KIrRejpctiY8hrLmrG1HBNqTWuDzCMwcUXxjO4KAyJ
 DqiRJmP0ynzKwng412cWN648Hu9EH916nA2IPrU6ktswjKTpkph85m2uJYH93OZmGtpbWXWcx
 YAFnA54FV6xUf/N/j7vAYyUnnXg97Xzm+BkHU337e1W5HuaZ1humYPuVtxRX0KTQL1/SniBdB
 7lkkvpgArflhWrZpDnTXIeeQ7BnoXiaLbn0tut6ddV+M2gEDL9h4u3ICcZnCry+kvp3Y95KBB
 uU5itAdbWw+3SccNMwnDSL9UOqDIA7F2M66B18AuxOWQKAdlQYZfoMc6f7ZFEGflUC6artiYJ
 L7uTzGFAsUHsWjNxJnsx8ISWc8FTg2h1Q16B496xmMml+WEb+kzdI4MICyiYHks3I2QXF+A15
 yLjGacVar/zjOfIQ5wDVpeZ0noM1JZbqU0kvKmOxtQsFl7jVnt2d5L2jQoL1rzQWaTLFZbDhv
 MPNrubIRMSF431Jfs4j/OpPoQ7BQkt6nz7GPI9nJ7km+sGyShkdY9RO6hQxCuzHVZDxnVa1/W
 I5CvS0a31lfs+cTWgWXg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/20 =E4=B8=8B=E5=8D=8811:28, Josef Bacik wrote:
> On 1/16/21 2:15 AM, Qu Wenruo wrote:
>> To support subpage sector size, data also need extra info to make sure
>> which sectors in a page are uptodate/dirty/...
>>
>> This patch will make pages for data inodes to get btrfs_subpage
>> structure attached, and detached when the page is freed.
>>
>> This patch also slightly changes the timing when
>> set_page_extent_mapped() to make sure:
>>
>> - We have page->mapping set
>> =C2=A0=C2=A0 page->mapping->host is used to grab btrfs_fs_info, thus we=
 can only
>> =C2=A0=C2=A0 call this function after page is mapped to an inode.
>>
>> =C2=A0=C2=A0 One call site attaches pages to inode manually, thus we ha=
ve to modify
>> =C2=A0=C2=A0 the timing of set_page_extent_mapped() a little.
>>
>> - As soon as possible, before other operations
>> =C2=A0=C2=A0 Since memory allocation can fail, we have to do extra erro=
r handling.
>> =C2=A0=C2=A0 Calling set_page_extent_mapped() as soon as possible can s=
imply the
>> =C2=A0=C2=A0 error handling for several call sites.
>>
>> The idea is pretty much the same as iomap_page, but with more bitmaps
>> for btrfs specific cases.
>>
>> Currently the plan is to switch iomap if iomap can provide sector
>> aligned write back (only write back dirty sectors, but not the full
>> page, data balance require this feature).
>>
>> So we will stick to btrfs specific bitmap for now.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/compression.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++++++=
--
>> =C2=A0 fs/btrfs/extent_io.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 46 +++++++++++++++++++++++++++++++++----
>> =C2=A0 fs/btrfs/extent_io.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 3 ++-
>> =C2=A0 fs/btrfs/file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 24 ++++++++-----------
>> =C2=A0 fs/btrfs/free-space-cache.c | 15 +++++++++---
>> =C2=A0 fs/btrfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 12 ++++++----
>> =C2=A0 fs/btrfs/ioctl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++-
>> =C2=A0 fs/btrfs/reflink.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 5 +++-
>> =C2=A0 fs/btrfs/relocation.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 +=
+++++++--
>> =C2=A0 9 files changed, 99 insertions(+), 33 deletions(-)
>>
>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>> index 5ae3fa0386b7..6d203acfdeb3 100644
>> --- a/fs/btrfs/compression.c
>> +++ b/fs/btrfs/compression.c
>> @@ -542,13 +542,19 @@ static noinline int add_ra_bio_pages(struct
>> inode *inode,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto next;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end =3D last_offset + PAGE_=
SIZE - 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * at this =
point, we have a locked page in the page cache
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * for thes=
e bytes in the file.=C2=A0 But, we have to make
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * sure the=
y map to this compressed extent on disk.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_page_extent_mapped(page=
);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D set_page_extent_map=
ped(page);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unl=
ock_page(page);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 put=
_page(page);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end =3D last_offset + PAGE_=
SIZE - 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock_extent(tree=
, last_offset, end);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read_lock(&em_tr=
ee->lock);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 em =3D lookup_ex=
tent_mapping(em_tree, last_offset,
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 35fbef15d84e..4bce03fed205 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -3194,10 +3194,39 @@ static int attach_extent_buffer_page(struct
>> extent_buffer *eb,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> -void set_page_extent_mapped(struct page *page)
>> +int __must_check set_page_extent_mapped(struct page *page)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_fs_info *fs_info;
>> +
>> +=C2=A0=C2=A0=C2=A0 ASSERT(page->mapping);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (PagePrivate(page))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 fs_info =3D btrfs_sb(page->mapping->host->i_sb);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (fs_info->sectorsize < PAGE_SIZE)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return btrfs_attach_subpage=
(fs_info, page);
>> +
>> +=C2=A0=C2=A0=C2=A0 attach_page_private(page, (void *)EXTENT_PAGE_PRIVA=
TE);
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +
>> +}
>> +
>> +void clear_page_extent_mapped(struct page *page)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_fs_info *fs_info;
>> +
>> +=C2=A0=C2=A0=C2=A0 ASSERT(page->mapping);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!PagePrivate(page))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attach_page_private(page, (=
void *)EXTENT_PAGE_PRIVATE);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>> +=C2=A0=C2=A0=C2=A0 fs_info =3D btrfs_sb(page->mapping->host->i_sb);
>> +=C2=A0=C2=A0=C2=A0 if (fs_info->sectorsize < PAGE_SIZE)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return btrfs_detach_subpage=
(fs_info, page);
>> +
>> +=C2=A0=C2=A0=C2=A0 detach_page_private(page);
>> =C2=A0 }
>> =C2=A0 static struct extent_map *
>> @@ -3254,7 +3283,12 @@ int btrfs_do_readpage(struct page *page, struct
>> extent_map **em_cached,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long this_bio_flag =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_io_tree *tree =3D &BTRFS_I=
(inode)->io_tree;
>> -=C2=A0=C2=A0=C2=A0 set_page_extent_mapped(page);
>> +=C2=A0=C2=A0=C2=A0 ret =3D set_page_extent_mapped(page);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unlock_extent(tree, start, =
end);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SetPageError(page);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!PageUptodate(page)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cleancache_g=
et_page(page) =3D=3D 0) {
>> @@ -3694,7 +3728,11 @@ static int __extent_writepage(struct page
>> *page, struct writeback_control *wbc,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flush_dcache_pag=
e(page);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 set_page_extent_mapped(page);
>> +=C2=A0=C2=A0=C2=A0 ret =3D set_page_extent_mapped(page);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SetPageError(page);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto done;
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!epd->extent_locked) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D writepag=
e_delalloc(BTRFS_I(inode), page, wbc, start,
>> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
>> index bedf761a0300..357a3380cd42 100644
>> --- a/fs/btrfs/extent_io.h
>> +++ b/fs/btrfs/extent_io.h
>> @@ -178,7 +178,8 @@ int btree_write_cache_pages(struct address_space
>> *mapping,
>> =C2=A0 void extent_readahead(struct readahead_control *rac);
>> =C2=A0 int extent_fiemap(struct btrfs_inode *inode, struct
>> fiemap_extent_info *fieinfo,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 =
start, u64 len);
>> -void set_page_extent_mapped(struct page *page);
>> +int __must_check set_page_extent_mapped(struct page *page);
>> +void clear_page_extent_mapped(struct page *page);
>> =C2=A0 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info
>> *fs_info,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 =
start, u64 owner_root, int level);
>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>> index d81ae1f518f2..63b290210eaa 100644
>> --- a/fs/btrfs/file.c
>> +++ b/fs/btrfs/file.c
>> @@ -1369,6 +1369,12 @@ static noinline int prepare_pages(struct inode
>> *inode, struct page **pages,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto fail;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D set_page_extent_map=
ped(pages[i]);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fai=
li =3D i;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o fail;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (i =3D=3D 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 err =3D prepare_uptodate_page(inode, pages[i], pos,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 force_uptodate);
>> @@ -1453,23 +1459,11 @@ lock_and_cleanup_extent_if_need(struct
>> btrfs_inode *inode, struct page **pages,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * It's possible the pages are dirty right now=
, but we don't want
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * to clean them yet because copy_from_user ma=
y catch a page fault
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * and we might have to fall back to one page =
at a time.=C2=A0 If that
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * happens, we'll unlock these pages and we'd =
have a window where
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * reclaim could sneak in and drop the once-di=
rty page on the floor
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * without writing it.
>> -=C2=A0=C2=A0=C2=A0=C2=A0 *
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * We have the pages locked and the extent ran=
ge locked, so there's
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * no way someone can start IO on any dirty pa=
ges in this range.
>> -=C2=A0=C2=A0=C2=A0=C2=A0 *
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * We'll call btrfs_dirty_pages() later on, an=
d that will flip
>> around
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * delalloc bits and dirty the pages as requir=
ed.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * We should be called after prepare_pages() w=
hich should have
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * locked all pages in the range.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < num_pages; i++) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_page_extent_mapped(page=
s[i]);
>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < num_pages; i++)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON(!PageLoc=
ked(pages[i]));
>> -=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
>> index fd6ddd6b8165..379bef967e1d 100644
>> --- a/fs/btrfs/free-space-cache.c
>> +++ b/fs/btrfs/free-space-cache.c
>> @@ -431,11 +431,22 @@ static int io_ctl_prepare_pages(struct
>> btrfs_io_ctl *io_ctl, bool uptodate)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < io_ctl->num_pages; i++=
) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page =3D find_or=
_create_page(inode->i_mapping, i, mask);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!page) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 io_ctl_drop_pages(io_ctl);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return -ENOMEM;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D set_page_extent_map=
ped(page);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unl=
ock_page(page);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 put=
_page(page);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io_=
ctl_drop_pages(io_ctl);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn -ENOMEM;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> If we're going to declare ret here we might as well
>
> return ret;
>
> otherwise we could just lose the error if we add some other error in the
> future.
>
> <snip>
>
>> @@ -8345,7 +8347,9 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vm=
f)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait_on_page_writeback(page);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock_extent_bits(io_tree, page_start, pa=
ge_end, &cached_state);
>> -=C2=A0=C2=A0=C2=A0 set_page_extent_mapped(page);
>> +=C2=A0=C2=A0=C2=A0 ret2 =3D set_page_extent_mapped(page);
>> +=C2=A0=C2=A0=C2=A0 if (ret2 < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_unlock;
>
> We lose the error in this case, you need
>
> if (ret2 < 0) {
>  =C2=A0=C2=A0=C2=A0=C2=A0ret =3D vmf_error(ret2);
>  =C2=A0=C2=A0=C2=A0=C2=A0goto out_unlock;
> }
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * we can't set the delalloc bits i=
f there are pending ordered
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 7f2935ea8d3a..50a9d784bdc2 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -1314,6 +1314,10 @@ static int cluster_pages_for_defrag(struct
>> inode *inode,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!page)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D set_page_extent_map=
ped(page);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>> +
>
> You are leaving a page locked and leaving it referenced here, you need
>
> if (ret < 0) {
>  =C2=A0=C2=A0=C2=A0=C2=A0unlock_page(page);
>  =C2=A0=C2=A0=C2=A0=C2=A0put_page(page);
>  =C2=A0=C2=A0=C2=A0=C2=A0break;
> }

Awesome review!

My gut feeling is telling me something may go wrong for such change, but
I didn't check it more carefully...

Thank you very much to catch such error branch bugs,
Qu

>
> thanks,
>
> Josef
