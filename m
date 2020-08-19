Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB203249920
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Aug 2020 11:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgHSJQQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 05:16:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:51491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726782AbgHSJQN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 05:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597828566;
        bh=aBt/A4qX32hHukSPXgVaK27XDREASjVq+Ajkmumvyz4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LhROUrprb53hKZLstHou4G4+/Q2i7Mn23NMrGAzKmr0TWXAyzJBlezqxRrIslZNXX
         81Eh7f+triyhSeECvVLMU4O3YRslMtqUDmG8Au7btWPhSxfIh6pyytmzsG2DSDI32K
         mJzCglSgEfYGum/ADixOwmJhCe01p4I/K+ymuxb4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MplXz-1kR85g05dt-00qCQI; Wed, 19
 Aug 2020 11:16:05 +0200
Subject: Re: [PATCH] btrfs: switch btrfs_buffered_write() to page-by-page pace
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20200819055344.50784-1-wqu@suse.com>
 <CAL3q7H4XU3i2S5Kr5jbPuATM2yFx9Bq1Cs6mmZZdCrMZm9QTuQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <21e69cad-9200-5590-a296-302ab2f09e27@gmx.com>
Date:   Wed, 19 Aug 2020 17:16:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H4XU3i2S5Kr5jbPuATM2yFx9Bq1Cs6mmZZdCrMZm9QTuQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tB9cx8TDR84laRWVWfAAeNkjbhdgPEucr"
X-Provags-ID: V03:K1:1BADFgi6x6bsKN3S8cOh/5C4aVeLron19ber6nkE4OtLSHqp1o1
 CQTKlvffaKgVAMN5OGQ/0S/yVFOp1Wi6MMen03+sEvBPnyPbwYMeuz3/lRrgo48XiapokX7
 DV4DFB8mdM1eCAqtDG6NcDHok/4SfB4MjZII295LfOXJAiWG4Y2/cmc2KtCcZHuvJMLBqaJ
 5bXgwwe92CJoo6AHOgLNA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cJqr/rHJnwQ=:IiZ1Ci6VzTIPKaqkuNAa9D
 It4QQSvSOD4Y3aZY51a4tRCSqomhGu0FhcOp8SdLlcJeHwEoz2USABv7kAN2XQNMQrNYE7cA3
 vGCb5jRsYmQrgfhxFp2x3DCMLGhBjdCsR0frJMY9sMUih82uO9Za4lyLGAa+nuoN7VHQjtkO2
 OtsM2lLgO7ezrQbXBMa70kkG3jVfaCF1SYrc3rZqVkcECWJriWEfzrJQwfmAGWe4sV9n6mTAm
 mf91uCJ3sOgT66Nqt4zwirdvhSC0sJDCFHwobxpVqkCfZ0BIeC+4Ycdq1bhJ5UBg1ZaqtndoB
 ESW9VrlWvmGlCSdq3Olw7L14T5GJcY4iuWt1tYsCkfmqKgmOAveEb5+rfcACGcDy7nBRUkkx3
 GPqUxq2S4BrTFa4dj4hOfyXcbrSifkGP/Z8cPWadjNwxHM6HYn1+mH5LnybUJny0paXmb3Cw4
 Cy0bAwK3vj/+/q56xg3lvtrCZLSGAk1HmCkdQKYSeMir0NzDx6QOhtiXQpM/emRLF/SViPQ0k
 cTL7TmF8l91Jb4UkTXqnySEh4dJFViWkykNORd1+TUrdvuFru2++DFO+o+W+TOo1hSpuiBmUM
 4IAsczJ1RFyK4tRvM1qyoCdQmqcKPLZA3kERkwrDkFJvIwpESHImo7O1iYa+Fy3KGO2KU7v7Y
 o8VWV1iPLZbXE/zGgFWTtO700/ndx9DUlDc/VEWicnVt7UMPiNC5rO6GBduT2PuWFVwzUrHuh
 lHUxqxv+H7esXH5FAX0C52ZcNHpFJNwgh1iUxCDVCjshwYM0aZzXmPWxYPmOkOG3Cy2g9CS1R
 5l/kqhm6K4g25fkUpefSgileG6epzWPjFSN90ZPOFmfXX+xhUVv8NwsGCykjTQztRcTkr8DmD
 dEBxJwQxAaawmKP2uI6naAp6XgP3tgmZqjyPYASOutY4Bagt7KJCXGJQyAnHSFTgzLOcvuU0j
 UIcA2YOIyOy1hgBVZgSuQ9FO/QMJudXmYDU0UuoxlQVcaaj3DnevjDG9gB3NmHtOhEWP16W/Y
 4Uy8PQPM90aUBPvkaaWetIRCQLwoN/yMFCxe+1r+oFZSUkxxKk/9BijbJG6j919ugdFns8Txc
 mm1eVxDN6mFu7KUBNr5+0P5iVlo4cWt5mI8ETv9KcdIE0jXrhXdQjpnjYBZF/d4eOhwitctap
 Pax8yng8Mt58pKgVaB1yTg8hUyyQaGVq4OmV3e9wmOXWD9DdpjGmBOZJEyBlsszbeYfpLTvjS
 LhKqN5xVowbtVKKMqT5HbGu3Y2I0xI/AEW/qgcA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tB9cx8TDR84laRWVWfAAeNkjbhdgPEucr
Content-Type: multipart/mixed; boundary="cV3eoaz1NU1QX0AXcp8xAJc2zUjhIcg1Q"

--cV3eoaz1NU1QX0AXcp8xAJc2zUjhIcg1Q
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/19 =E4=B8=8B=E5=8D=885:09, Filipe Manana wrote:
> On Wed, Aug 19, 2020 at 6:55 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Before this patch, btrfs_buffered_write() do page copy in a 8 pages
>> batch.
>>
>> While for EXT4, it uses generic_perform_write() which does page by pag=
e
>> copy.
>>
>> This 8 pages batch behavior makes a lot of things more complex:
>> - More complex error handling
>>   Now we need to handle all errors for half written case.
>>
>> - More complex advance check
>>   Since for 8 pages, we need to consider cases like 4 pages copied.
>>   This makes we need to release reserved space for the untouched 4
>>   pages.
>>
>> - More wrappers for multi-pages operations
>>   The most obvious one is btrfs_copy_from_user(), which introduces way=

>>   more complexity than we need.
>>
>> This patch will change the behavior by going to the page-by-page pace,=

>> each time we only reserve space for one page, do one page copy.
>>
>> There are still a lot of complexity remained, mostly for short copy,
>> non-uptodate page and extent locking.
>> But that's more or less the same as the generic_perform_write().
>>
>> The performance is the same for 4K block size buffered write, but has =
an
>> obvious impact when using multiple pages siuzed block size:
>>
>> The test involves writing a 128MiB file, which is smaller than 1/8th o=
f
>> the system memory.
>>                 Speed (MiB/sec)         Ops (ops/sec)
>> Unpatched:      931.498                 14903.9756
>> Patched:        447.606                 7161.6806
>>
>> In fact, if we account the execution time of btrfs_buffered_write(),
>> meta/data rsv and later page dirty takes way more time than memory cop=
y:
>>
>> Patched:
>>  nr_runs          =3D 32768
>>  total_prepare_ns =3D 66908022
>>  total_copy_ns    =3D 75532103
>>  total_cleanup_ns =3D 135749090
>>
>> Unpatched:
>>  nr_runs          =3D 2176
>>  total_prepare_ns =3D 7425773
>>  total_copy_ns    =3D 87780898
>>  total_cleanup_ns =3D 37704811
>>
>> The patched behavior is now similar to EXT4, the buffered write remain=

>> mostly unchanged for from 4K blocksize and larger.
>>
>> On the other hand, XFS uses iomap, which supports multi-page reserve a=
nd
>> copy, leading to similar performance of unpatched btrfs.
>>
>> It looks like that we'd better go iomap routine other than the
>> generic_perform_write().
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Reason for RFC:
>>
>> The performance drop is enough for this patch to be discarded.
>=20
> More than enough, a nearly 50% drop of performance for a very common op=
eration.
> I can't even understand why you bothered proposing it.

Well, at least for blocksize <=3D 4K, it's still the same performance, bu=
t
with a much cleaner code base.

Anyway, will go the iomap direction, as iomap seems to have extra method
to ensure:
- The iov_iter is always readable
  So that we won't need to bother shorter in-page copy, thus no need to
  bother the copied =3D=3D 0 case.

- The needed operation done before real page copy
  I'm wondering what is the proper way to interact with page and extent
  lock.
  If we can first lock the extent io tree, then try to get the pages
  locked, we can then remove one "goto again" call, and make it easier
  to integrate with iomap.

Thanks,
Qu

>=20
> Thanks.
>=20
>> ---
>>  fs/btrfs/file.c | 293 ++++++++++++-----------------------------------=
-
>>  1 file changed, 72 insertions(+), 221 deletions(-)
>>
>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>> index bbfc8819cf28..be595da9bc05 100644
>> --- a/fs/btrfs/file.c
>> +++ b/fs/btrfs/file.c
>> @@ -379,60 +379,6 @@ int btrfs_run_defrag_inodes(struct btrfs_fs_info =
*fs_info)
>>         return 0;
>>  }
>>
>> -/* simple helper to fault in pages and copy.  This should go away
>> - * and be replaced with calls into generic code.
>> - */
>> -static noinline int btrfs_copy_from_user(loff_t pos, size_t write_byt=
es,
>> -                                        struct page **prepared_pages,=

>> -                                        struct iov_iter *i)
>> -{
>> -       size_t copied =3D 0;
>> -       size_t total_copied =3D 0;
>> -       int pg =3D 0;
>> -       int offset =3D offset_in_page(pos);
>> -
>> -       while (write_bytes > 0) {
>> -               size_t count =3D min_t(size_t,
>> -                                    PAGE_SIZE - offset, write_bytes);=

>> -               struct page *page =3D prepared_pages[pg];
>> -               /*
>> -                * Copy data from userspace to the current page
>> -                */
>> -               copied =3D iov_iter_copy_from_user_atomic(page, i, off=
set, count);
>> -
>> -               /* Flush processor's dcache for this page */
>> -               flush_dcache_page(page);
>> -
>> -               /*
>> -                * if we get a partial write, we can end up with
>> -                * partially up to date pages.  These add
>> -                * a lot of complexity, so make sure they don't
>> -                * happen by forcing this copy to be retried.
>> -                *
>> -                * The rest of the btrfs_file_write code will fall
>> -                * back to page at a time copies after we return 0.
>> -                */
>> -               if (!PageUptodate(page) && copied < count)
>> -                       copied =3D 0;
>> -
>> -               iov_iter_advance(i, copied);
>> -               write_bytes -=3D copied;
>> -               total_copied +=3D copied;
>> -
>> -               /* Return to btrfs_file_write_iter to fault page */
>> -               if (unlikely(copied =3D=3D 0))
>> -                       break;
>> -
>> -               if (copied < PAGE_SIZE - offset) {
>> -                       offset +=3D copied;
>> -               } else {
>> -                       pg++;
>> -                       offset =3D 0;
>> -               }
>> -       }
>> -       return total_copied;
>> -}
>> -
>>  /*
>>   * unlocks pages after btrfs_file_write is done with them
>>   */
>> @@ -443,8 +389,8 @@ static void btrfs_drop_pages(struct page **pages, =
size_t num_pages)
>>                 /* page checked is some magic around finding pages tha=
t
>>                  * have been modified without going through btrfs_set_=
page_dirty
>>                  * clear it here. There should be no need to mark the =
pages
>> -                * accessed as prepare_pages should have marked them a=
ccessed
>> -                * in prepare_pages via find_or_create_page()
>> +                * accessed as prepare_pages() should have marked them=
 accessed
>> +                * in prepare_pages() via find_or_create_page()
>>                  */
>>                 ClearPageChecked(pages[i]);
>>                 unlock_page(pages[i]);
>> @@ -1400,58 +1346,6 @@ static int prepare_uptodate_page(struct inode *=
inode,
>>         return 0;
>>  }
>>
>> -/*
>> - * this just gets pages into the page cache and locks them down.
>> - */
>> -static noinline int prepare_pages(struct inode *inode, struct page **=
pages,
>> -                                 size_t num_pages, loff_t pos,
>> -                                 size_t write_bytes, bool force_uptod=
ate)
>> -{
>> -       int i;
>> -       unsigned long index =3D pos >> PAGE_SHIFT;
>> -       gfp_t mask =3D btrfs_alloc_write_mask(inode->i_mapping);
>> -       int err =3D 0;
>> -       int faili;
>> -
>> -       for (i =3D 0; i < num_pages; i++) {
>> -again:
>> -               pages[i] =3D find_or_create_page(inode->i_mapping, ind=
ex + i,
>> -                                              mask | __GFP_WRITE);
>> -               if (!pages[i]) {
>> -                       faili =3D i - 1;
>> -                       err =3D -ENOMEM;
>> -                       goto fail;
>> -               }
>> -
>> -               if (i =3D=3D 0)
>> -                       err =3D prepare_uptodate_page(inode, pages[i],=
 pos,
>> -                                                   force_uptodate);
>> -               if (!err && i =3D=3D num_pages - 1)
>> -                       err =3D prepare_uptodate_page(inode, pages[i],=

>> -                                                   pos + write_bytes,=
 false);
>> -               if (err) {
>> -                       put_page(pages[i]);
>> -                       if (err =3D=3D -EAGAIN) {
>> -                               err =3D 0;
>> -                               goto again;
>> -                       }
>> -                       faili =3D i - 1;
>> -                       goto fail;
>> -               }
>> -               wait_on_page_writeback(pages[i]);
>> -       }
>> -
>> -       return 0;
>> -fail:
>> -       while (faili >=3D 0) {
>> -               unlock_page(pages[faili]);
>> -               put_page(pages[faili]);
>> -               faili--;
>> -       }
>> -       return err;
>> -
>> -}
>> -
>>  /*
>>   * This function locks the extent and properly waits for data=3Dorder=
ed extents
>>   * to finish before allowing the pages to be modified if need.
>> @@ -1619,6 +1513,38 @@ void btrfs_check_nocow_unlock(struct btrfs_inod=
e *inode)
>>         btrfs_drew_write_unlock(&inode->root->snapshot_lock);
>>  }
>>
>> +static int prepare_one_page(struct inode *inode, struct page **page_r=
et,
>> +                           loff_t pos, size_t write_bytes, bool force=
_uptodate)
>> +{
>> +       gfp_t mask =3D btrfs_alloc_write_mask(inode->i_mapping) | __GF=
P_WRITE;
>> +       struct page *page;
>> +       int ret;
>> +
>> +again:
>> +       page =3D find_or_create_page(inode->i_mapping, pos >> PAGE_SHI=
FT, mask);
>> +       if (!page)
>> +               return -ENOMEM;
>> +
>> +       /*
>> +        * We need the page uptodate for the following cases:
>> +        * - Write range only covers part of the page
>> +        * - We got a short copy on non-uptodate page in previous run
>> +        */
>> +       if ((!(offset_in_page(pos) =3D=3D 0 && write_bytes =3D=3D PAGE=
_SIZE) ||
>> +            force_uptodate) && !PageUptodate(page)) {
>> +               ret =3D prepare_uptodate_page(inode, page, pos, true);=

>> +               if (ret) {
>> +                       put_page(page);
>> +                       if (ret =3D=3D -EAGAIN)
>> +                               goto again;
>> +                       return ret;
>> +               }
>> +               wait_on_page_writeback(page);
>> +       }
>> +       *page_ret =3D page;
>> +       return 0;
>> +}
>> +
>>  static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>>                                                struct iov_iter *i)
>>  {
>> @@ -1626,45 +1552,26 @@ static noinline ssize_t btrfs_buffered_write(s=
truct kiocb *iocb,
>>         loff_t pos =3D iocb->ki_pos;
>>         struct inode *inode =3D file_inode(file);
>>         struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>> -       struct page **pages =3D NULL;
>> +       struct page *page =3D NULL;
>>         struct extent_changeset *data_reserved =3D NULL;
>> -       u64 release_bytes =3D 0;
>>         u64 lockstart;
>>         u64 lockend;
>>         size_t num_written =3D 0;
>> -       int nrptrs;
>>         int ret =3D 0;
>>         bool only_release_metadata =3D false;
>>         bool force_page_uptodate =3D false;
>>
>> -       nrptrs =3D min(DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE),
>> -                       PAGE_SIZE / (sizeof(struct page *)));
>> -       nrptrs =3D min(nrptrs, current->nr_dirtied_pause - current->nr=
_dirtied);
>> -       nrptrs =3D max(nrptrs, 8);
>> -       pages =3D kmalloc_array(nrptrs, sizeof(struct page *), GFP_KER=
NEL);
>> -       if (!pages)
>> -               return -ENOMEM;
>> -
>>         while (iov_iter_count(i) > 0) {
>>                 struct extent_state *cached_state =3D NULL;
>>                 size_t offset =3D offset_in_page(pos);
>> -               size_t sector_offset;
>>                 size_t write_bytes =3D min(iov_iter_count(i),
>> -                                        nrptrs * (size_t)PAGE_SIZE -
>> -                                        offset);
>> -               size_t num_pages =3D DIV_ROUND_UP(write_bytes + offset=
,
>> -                                               PAGE_SIZE);
>> -               size_t reserve_bytes;
>> -               size_t dirty_pages;
>> +                                        PAGE_SIZE - offset);
>> +               size_t reserve_bytes =3D PAGE_SIZE;
>>                 size_t copied;
>> -               size_t dirty_sectors;
>> -               size_t num_sectors;
>>                 int extents_locked;
>>
>> -               WARN_ON(num_pages > nrptrs);
>> -
>>                 /*
>> -                * Fault pages before locking them in prepare_pages
>> +                * Fault pages before locking them in prepare_page()
>>                  * to avoid recursive lock
>>                  */
>>                 if (unlikely(iov_iter_fault_in_readable(i, write_bytes=
))) {
>> @@ -1673,37 +1580,27 @@ static noinline ssize_t btrfs_buffered_write(s=
truct kiocb *iocb,
>>                 }
>>
>>                 only_release_metadata =3D false;
>> -               sector_offset =3D pos & (fs_info->sectorsize - 1);
>> -               reserve_bytes =3D round_up(write_bytes + sector_offset=
,
>> -                               fs_info->sectorsize);
>>
>>                 extent_changeset_release(data_reserved);
>>                 ret =3D btrfs_check_data_free_space(BTRFS_I(inode),
>>                                                   &data_reserved, pos,=

>>                                                   write_bytes);
>>                 if (ret < 0) {
>> +                       size_t tmp =3D write_bytes;
>>                         if (btrfs_check_nocow_lock(BTRFS_I(inode), pos=
,
>> -                                                  &write_bytes) > 0) =
{
>> +                                                  &tmp) > 0) {
>> +                               ASSERT(tmp =3D=3D write_bytes);
>>                                 /*
>>                                  * For nodata cow case, no need to res=
erve
>>                                  * data space.
>>                                  */
>>                                 only_release_metadata =3D true;
>> -                               /*
>> -                                * our prealloc extent may be smaller =
than
>> -                                * write_bytes, so scale down.
>> -                                */
>> -                               num_pages =3D DIV_ROUND_UP(write_bytes=
 + offset,
>> -                                                        PAGE_SIZE);
>> -                               reserve_bytes =3D round_up(write_bytes=
 +
>> -                                                        sector_offset=
,
>> -                                                        fs_info->sect=
orsize);
>> +                               reserve_bytes =3D 0;
>>                         } else {
>>                                 break;
>>                         }
>>                 }
>>
>> -               WARN_ON(reserve_bytes =3D=3D 0);
>>                 ret =3D btrfs_delalloc_reserve_metadata(BTRFS_I(inode)=
,
>>                                 reserve_bytes);
>>                 if (ret) {
>> @@ -1716,16 +1613,9 @@ static noinline ssize_t btrfs_buffered_write(st=
ruct kiocb *iocb,
>>                         break;
>>                 }
>>
>> -               release_bytes =3D reserve_bytes;
>>  again:
>> -               /*
>> -                * This is going to setup the pages array with the num=
ber of
>> -                * pages we want, so we don't really need to worry abo=
ut the
>> -                * contents of pages from loop to loop
>> -                */
>> -               ret =3D prepare_pages(inode, pages, num_pages,
>> -                                   pos, write_bytes,
>> -                                   force_page_uptodate);
>> +               ret =3D prepare_one_page(inode, &page, pos, write_byte=
s,
>> +                                      force_page_uptodate);
>>                 if (ret) {
>>                         btrfs_delalloc_release_extents(BTRFS_I(inode),=

>>                                                        reserve_bytes);=

>> @@ -1733,9 +1623,8 @@ static noinline ssize_t btrfs_buffered_write(str=
uct kiocb *iocb,
>>                 }
>>
>>                 extents_locked =3D lock_and_cleanup_extent_if_need(
>> -                               BTRFS_I(inode), pages,
>> -                               num_pages, pos, write_bytes, &lockstar=
t,
>> -                               &lockend, &cached_state);
>> +                               BTRFS_I(inode), &page, 1, pos, write_b=
ytes,
>> +                               &lockstart, &lockend, &cached_state);
>>                 if (extents_locked < 0) {
>>                         if (extents_locked =3D=3D -EAGAIN)
>>                                 goto again;
>> @@ -1745,57 +1634,38 @@ static noinline ssize_t btrfs_buffered_write(s=
truct kiocb *iocb,
>>                         break;
>>                 }
>>
>> -               copied =3D btrfs_copy_from_user(pos, write_bytes, page=
s, i);
>> -
>> -               num_sectors =3D BTRFS_BYTES_TO_BLKS(fs_info, reserve_b=
ytes);
>> -               dirty_sectors =3D round_up(copied + sector_offset,
>> -                                       fs_info->sectorsize);
>> -               dirty_sectors =3D BTRFS_BYTES_TO_BLKS(fs_info, dirty_s=
ectors);
>> -
>> -               /*
>> -                * if we have trouble faulting in the pages, fall
>> -                * back to one page at a time
>> -                */
>> -               if (copied < write_bytes)
>> -                       nrptrs =3D 1;
>> +               copied =3D iov_iter_copy_from_user_atomic(page, i, off=
set,
>> +                                                       write_bytes);
>> +               flush_dcache_page(page);
>>
>> -               if (copied =3D=3D 0) {
>> +               if (!PageUptodate(page) && copied < write_bytes) {
>> +                       /*
>> +                        * Short write on non-uptodate page, we must r=
etry and
>> +                        * force the page uptodate in next run.
>> +                        */
>> +                       copied =3D 0;
>>                         force_page_uptodate =3D true;
>> -                       dirty_sectors =3D 0;
>> -                       dirty_pages =3D 0;
>>                 } else {
>> +                       /* Next run doesn't need forced uptodate */
>>                         force_page_uptodate =3D false;
>> -                       dirty_pages =3D DIV_ROUND_UP(copied + offset,
>> -                                                  PAGE_SIZE);
>>                 }
>>
>> -               if (num_sectors > dirty_sectors) {
>> -                       /* release everything except the sectors we di=
rtied */
>> -                       release_bytes -=3D dirty_sectors <<
>> -                                               fs_info->sb->s_blocksi=
ze_bits;
>> -                       if (only_release_metadata) {
>> -                               btrfs_delalloc_release_metadata(BTRFS_=
I(inode),
>> -                                                       release_bytes,=
 true);
>> -                       } else {
>> -                               u64 __pos;
>> +               iov_iter_advance(i, copied);
>>
>> -                               __pos =3D round_down(pos,
>> -                                                  fs_info->sectorsize=
) +
>> -                                       (dirty_pages << PAGE_SHIFT);
>> +               if (copied > 0) {
>> +                       ret =3D btrfs_dirty_pages(BTRFS_I(inode), &pag=
e, 1, pos,
>> +                                               copied, &cached_state)=
;
>> +               } else {
>> +                       /* No bytes copied, need to free reserved spac=
e */
>> +                       if (only_release_metadata)
>> +                               btrfs_delalloc_release_metadata(BTRFS_=
I(inode),
>> +                                               reserve_bytes, true);
>> +                       else
>>                                 btrfs_delalloc_release_space(BTRFS_I(i=
node),
>> -                                               data_reserved, __pos,
>> -                                               release_bytes, true);
>> -                       }
>> +                                               data_reserved, pos, wr=
ite_bytes,
>> +                                               true);
>>                 }
>>
>> -               release_bytes =3D round_up(copied + sector_offset,
>> -                                       fs_info->sectorsize);
>> -
>> -               if (copied > 0)
>> -                       ret =3D btrfs_dirty_pages(BTRFS_I(inode), page=
s,
>> -                                               dirty_pages, pos, copi=
ed,
>> -                                               &cached_state);
>> -
>>                 /*
>>                  * If we have not locked the extent range, because the=
 range's
>>                  * start offset is >=3D i_size, we might still have a =
non-NULL
>> @@ -1811,26 +1681,22 @@ static noinline ssize_t btrfs_buffered_write(s=
truct kiocb *iocb,
>>
>>                 btrfs_delalloc_release_extents(BTRFS_I(inode), reserve=
_bytes);
>>                 if (ret) {
>> -                       btrfs_drop_pages(pages, num_pages);
>> +                       btrfs_drop_pages(&page, 1);
>>                         break;
>>                 }
>>
>> -               release_bytes =3D 0;
>> -               if (only_release_metadata)
>> +               if (only_release_metadata) {
>>                         btrfs_check_nocow_unlock(BTRFS_I(inode));
>> -
>> -               if (only_release_metadata && copied > 0) {
>>                         lockstart =3D round_down(pos,
>>                                                fs_info->sectorsize);
>> -                       lockend =3D round_up(pos + copied,
>> -                                          fs_info->sectorsize) - 1;
>> +                       lockend =3D lockstart + PAGE_SIZE - 1;
>>
>>                         set_extent_bit(&BTRFS_I(inode)->io_tree, locks=
tart,
>>                                        lockend, EXTENT_NORESERVE, NULL=
,
>>                                        NULL, GFP_NOFS);
>>                 }
>>
>> -               btrfs_drop_pages(pages, num_pages);
>> +               btrfs_drop_pages(&page, 1);
>>
>>                 cond_resched();
>>
>> @@ -1840,21 +1706,6 @@ static noinline ssize_t btrfs_buffered_write(st=
ruct kiocb *iocb,
>>                 num_written +=3D copied;
>>         }
>>
>> -       kfree(pages);
>> -
>> -       if (release_bytes) {
>> -               if (only_release_metadata) {
>> -                       btrfs_check_nocow_unlock(BTRFS_I(inode));
>> -                       btrfs_delalloc_release_metadata(BTRFS_I(inode)=
,
>> -                                       release_bytes, true);
>> -               } else {
>> -                       btrfs_delalloc_release_space(BTRFS_I(inode),
>> -                                       data_reserved,
>> -                                       round_down(pos, fs_info->secto=
rsize),
>> -                                       release_bytes, true);
>> -               }
>> -       }
>> -
>>         extent_changeset_free(data_reserved);
>>         return num_written ? num_written : ret;
>>  }
>> --
>> 2.28.0
>>
>=20
>=20


--cV3eoaz1NU1QX0AXcp8xAJc2zUjhIcg1Q--

--tB9cx8TDR84laRWVWfAAeNkjbhdgPEucr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl887dAACgkQwj2R86El
/qg/9gf/fcSJzv++H1J6UXffE1Gt5LCrrVx2sL1vx0gBe2PEpoX3ZL+02pWOEGi/
B07W8tieUuEIYzVrQhIXWas5eK44WALVm596Npt+z01p/HKoia4SFhXV8GkVwqbj
A8c4+H0Pa5h33gTaqe6fs/rjKF5E46T8byAax3bF4180jQ64cMWhQghucbI5pb57
/LFHNrxs9sIwX140BkR1ZvPGfJ3sOcOEm57rHcpSXNl4RtmpOIqZ2NU0uh276Yes
0VcT8A6Y6IPGugar1bAbneuP1AI08rhBrAukRK7NZQB6IBjJkMH3zM1SaG8Xjdb4
6p9iB7yeHpReBy8NX1tK0Rxqz4f/LQ==
=xrsw
-----END PGP SIGNATURE-----

--tB9cx8TDR84laRWVWfAAeNkjbhdgPEucr--
