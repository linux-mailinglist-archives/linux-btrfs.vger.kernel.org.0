Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C15D41452C6
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 11:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgAVKlE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jan 2020 05:41:04 -0500
Received: from mout.gmx.net ([212.227.17.22]:34581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbgAVKlE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jan 2020 05:41:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579689656;
        bh=SVykXu7ziElIQhWqpnD6TYze9FxG2lnSIqGY3RYRbRs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=izLCspTGK2BWSnMwiESgGWKF3C9dtdxVafQrOUbvU91z0hGMw57rFYlnsXw+7RFpD
         KfbJST7N5c1HpaXyrxPZX8A3C451FuKLz0aW+m8EQwgadRSQGFXUhv7PlPrufkx322
         d6g8eQz2RvPyO72n3tplM+sYOv/6qMh7yeO0KrTE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8hVB-1iyuOt2vgH-004niz; Wed, 22
 Jan 2020 11:40:55 +0100
Subject: Re: [PATCH RFC] btrfs: scrub: Mandatory RO block group for device
 replace
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
References: <20200122083628.16331-1-wqu@suse.com>
 <CAL3q7H7tk6JdVpjz9xne7S4JBL8DZTKp04nTrhLTHjKeSyUtqw@mail.gmail.com>
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
Message-ID: <6877fa2e-7ccc-2ff0-2ea0-458ea9cb8432@gmx.com>
Date:   Wed, 22 Jan 2020 18:40:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7tk6JdVpjz9xne7S4JBL8DZTKp04nTrhLTHjKeSyUtqw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZGdlphLBydKKfXjI9Y7YoFuBxZc2TFX8t"
X-Provags-ID: V03:K1:9+crOyyFynWkhlvz3awqTHS9fCacD7p1JC9wBolBNZjmi6mzAwy
 zIwTkNtPpB/ltxLyV/3gce6MkXFQF91IAfIRC0Lx21MybinL/2IMFhG227WN9MUKzeb0lic
 htMu4Un2ikRG4KNnM2m0rszkjVqR2SKuadB6iP6+BvkLuc8VpSeamCIyyy4Ok+jMo1oTfxP
 Pef6GVUYdIIzeyfQYBiBg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7Kkfk7nYngg=:jzrSjWZaDuHH37aGvjUUvX
 b4EqhIb6uU2SfUpYhTE77FcYCdxAmhSMOsn6hz0wK+6Wf4ofGj0MB/0O/I6XXoFyFMLtV29wy
 /u8NKnN5UrbdaFBc/rqW0AJEiVl+80Cve9y5ndjQ5owj962o9NxRdrNTr3HshaJ9eZYRSNFTr
 Jhvxm94Yx949hF2isridEcD4bbtsIPS9W5r4NFxHL1YIeXNGSBDXYBmW4aksn6FIhgc8HBudz
 YcMFThb4SXuXBRaYgxTBHnHFJOT3V1oYnn23o2EKfA47B8gRv8kyZQxt7iu/OXDPC1ZKoABd5
 wPvg18cxYec9ixWrMSY3I4OfwD+4g3WkH+FWa7w8Fk8tV2Oa5SUPB+acQVEV14Od0c9/M7oLM
 0aJRGyCuregslA35AW8IWhEpcKwi3O5zhdfWz0vD5li6rkcddG+r9VViOFvK12DUakmqMkOew
 TgXMXthLZVoCnviIfg6FydGmxaRm+5j+zAxEdxSYMkLFY8g0fmtiorMSkPV9ntGFoOxjGthRK
 fbTqe0LSZY/gfyyaL7LHj4/4+uuwf6VuM66JvPqd8n/C6ZSZLVVFjVfPCWMbOGLFvr5A72mlL
 zV2WS1XPdwigJs6FKGnWVQaWN89qtwqZc/fEMGCX/6AMXo8jgRrrOCw7JU2RtQ+xe7XKI3wix
 K2ltZZPgqi1EmhKOJyW0D8Z0NC3Zr9NK2cJi32jM5ZtyNaslAdPn+jIitr132JOISNy9nxZEM
 omogwj8Lpjr6yJa3SY+u239ya646XTiZKJV1L86eJD6Kih5Gt+VTqvqy52ekbzjUYss8TxxF6
 PDwJinKOe7DdVYuKBgA7FPY0V0SPjlw+qsdX5Bo4YACQXrhQyJgW842C3vhplwYCqS+VE9IZh
 +7m7QmdJZHD9loBpA/CQ3adPrJSH1sHQR5k0VPy02xRQh8GmMvXvqpsq1gZiqLy0WIMaq0Cqt
 HZ6enoGcqUkkXs2WSYwokq8opJmeQibHHPsORdkxSzPIe3A6ZxS1+EQCpK2O0xeqetfAJg5Q+
 6TQ1Rc/Yml/4RjWRsZKjzfxRhsI+RTOM+9q14ST/xt+BT8SV2bn2bq7WVn3FYOXNwW6/KpRmq
 rwvnCveRvz5k/GRjasyzncoGPboOZI2SPiJYyrvlntP+MD9EgdUdhowFFoijNBKsC8X4ztVVQ
 vNzoe7ZKu2Trx/8Tw6/Akfyi7Aqu9EZyb5B/h4UeNVaE+Qonb/eyhuBvQOyybUYqirjoIwnWC
 K2RH0an1G9Ffy2aP/
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZGdlphLBydKKfXjI9Y7YoFuBxZc2TFX8t
Content-Type: multipart/mixed; boundary="NThDZHwV4NWacOCJaGBxZL7OqkUvq0dUS"

--NThDZHwV4NWacOCJaGBxZL7OqkUvq0dUS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/22 =E4=B8=8B=E5=8D=886:05, Filipe Manana wrote:
> On Wed, Jan 22, 2020 at 8:37 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> btrfs/06[45] btrfs/071 could fail by finding csum error.
>> The reproducibility is not high, around 1/20~1/100, needs to run them =
in
>> loops.
>>
>> And the profile doesn't make much difference, SINGLE/SINGLE can also
>> reproduce the problem.
>>
>> The bug is observable after commit b12de52896c0 ("btrfs: scrub: Don't
>> check free space before marking a block group RO")
>>
>> [CAUSE]
>> Device replace reuses scrub code to iterate existing extents.
>>
>> It adds scrub_write_block_to_dev_replace() to scrub_block_complete(), =
so
>> that scrub read can write the verified data to target device.
>>
>> Device replace also utilizes "write duplication" to write new data to
>> both source and target device.
>>
>> However those two write can conflict and may lead to data corruption:
>> - Scrub writes old data from commit root
>>   Both extent location and csum are fetched from commit root, which
>>   is not always the up-to-date data.
>>
>> - Write duplication is always duplicating latest data
>>
>> This means there could be a race, that "write duplication" writes the
>> latest data to disk, then scrub write back the old data, causing data
>> corruption.
>=20
> Worth mentioning this is for nocow writes only then.
> Given that the test cases that fail use fsstress and don't use nocow
> files or -o nodatacow, the only possible case is writes into prealloc
> extents.
> Write duplication writes the new data and then extent iteration writes
> zeroes (or whatever is on disk) after that.

Thank you very much for the mentioning of prealloc extents, that's
exactly the missing piece!

My original assumption in fact has a hole, extents in commit tree won't
get re-allocated as they will get pinned down, and until next trans
won't be re-used.
So the explaination should only work for nodatacow case, and I could not
find a good explanation until now.

And if it's prealloc extent, then it's indeed a different story.

>=20
>>
>> In theory, this should only affects data, not metadata.
>> Metadata write back only happens when committing transaction, thus it'=
s
>> always after scrub writes.
>=20
> No, not only when committing transaction.
> It can happen under memory pressure, tree extents can be written
> before. In fact, if you remember the 5.2 corruption and deadlock, the
> deadlock case happened precisely when writeback of the btree inode was
> triggered before a transaction commit.
>=20
>>
>> [FIX]
>> Make dev-replace to require mandatory RO for target block group.
>>
>> And to be extra safe, for dev-replace, wait for all exiting writes to
>> finish before scrubbing the chunk.
>>
>> This patch will mostly revert commit 76a8efa171bf ("btrfs: Continue re=
place
>> when set_block_ro failed").
>> ENOSPC for dev-replace is still much better than data corruption.
>>
>> Reported-by: Filipe Manana <fdmanana@suse.com>
>> Fixes: 76a8efa171bf ("btrfs: Continue replace when set_block_ro failed=
")
>> Fixes: b12de52896c0 ("btrfs: scrub: Don't check free space before mark=
ing a block group RO")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Not concretely confirmed, mostly through guess, thus it has RFC tag.
>=20
> Well, it's better to confirm...
> IIRC, correctly, dev-replace does not skip copies for prealloc
> extents, it copies what is on disk.

That's true, it doesn't do backref walk to determine if it's
preallocated or regular.
It just gather csum, copy pages from disk, verify if there is csum, then
copy the pages back.

So prealloc indeed looks like a very valid cause, and it can be verified
just by disabling prealloc in fsstress.

Thanks again for pointing out the missing piece.
Qu

> If that's the case, then this is correct. However if it's smart and
> skips copying prealloc extents (which is pointless), then the problem
> must have other technical explanation.
>=20
>>
>> My first guess is race at the dev-replace starting point, but related
>> code is in fact very safe.
>> ---
>>  fs/btrfs/scrub.c | 35 ++++++++++++++++++++++++++++++++---
>>  1 file changed, 32 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index 21de630b0730..69e76a4d1258 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -3472,6 +3472,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sct=
x,
>>         struct btrfs_path *path;
>>         struct btrfs_fs_info *fs_info =3D sctx->fs_info;
>>         struct btrfs_root *root =3D fs_info->dev_root;
>> +       bool is_dev_replace =3D sctx->is_dev_replace;
>=20
> Not needed, just use sctx->is_dev_replace like everywhere else.
>=20
> Thanks.
>=20
>>         u64 length;
>>         u64 chunk_offset;
>>         int ret =3D 0;
>> @@ -3577,17 +3578,35 @@ int scrub_enumerate_chunks(struct scrub_ctx *s=
ctx,
>>                  * This can easily boost the amount of SYSTEM chunks i=
f cleaner
>>                  * thread can't be triggered fast enough, and use up a=
ll space
>>                  * of btrfs_super_block::sys_chunk_array
>> +                *
>> +                *
>> +                * On the other hand, try our best to mark block group=
 RO for
>> +                * dev-replace case.
>> +                *
>> +                * Dev-replace has two types of write:
>> +                * - Write duplication
>> +                *   New write will be written to both target and sour=
ce device
>> +                *   The content is always the *newest* data.
>> +                * - Scrub write for dev-replace
>> +                *   Scrub will write the verified data for dev-replac=
e.
>> +                *   The data and its csum are all from *commit* root,=
 which
>> +                *   is not the newest version.
>> +                *
>> +                * If scrub write happens after write duplication, we =
would
>> +                * cause data corruption.
>> +                * So we need to try our best to mark block group RO, =
and exit
>> +                * out if we don't have enough space.
>>                  */
>> -               ret =3D btrfs_inc_block_group_ro(cache, false);
>> +               ret =3D btrfs_inc_block_group_ro(cache, is_dev_replace=
);
>>                 scrub_pause_off(fs_info);
>>
>>                 if (ret =3D=3D 0) {
>>                         ro_set =3D 1;
>> -               } else if (ret =3D=3D -ENOSPC) {
>> +               } else if (ret =3D=3D -ENOSPC && !is_dev_replace) {
>>                         /*
>>                          * btrfs_inc_block_group_ro return -ENOSPC whe=
n it
>>                          * failed in creating new chunk for metadata.
>> -                        * It is not a problem for scrub/replace, beca=
use
>> +                        * It is not a problem for scrub, because
>>                          * metadata are always cowed, and our scrub pa=
used
>>                          * commit_transactions.
>>                          */
>> @@ -3605,6 +3624,16 @@ int scrub_enumerate_chunks(struct scrub_ctx *sc=
tx,
>>                 dev_replace->item_needs_writeback =3D 1;
>>                 up_write(&dev_replace->rwsem);
>>
>> +               /*
>> +                * Also wait for any exitings writes to prevent race b=
etween
>> +                * write duplication and scrub writes.
>> +                */
>> +               if (is_dev_replace) {
>> +                       btrfs_wait_block_group_reservations(cache);
>> +                       btrfs_wait_nocow_writers(cache);
>> +                       btrfs_wait_ordered_roots(fs_info, U64_MAX,
>> +                                       cache->start, cache->length);
>> +               }
>>                 ret =3D scrub_chunk(sctx, scrub_dev, chunk_offset, len=
gth,
>>                                   found_key.offset, cache);
>>
>> --
>> 2.25.0
>>
>=20
>=20


--NThDZHwV4NWacOCJaGBxZL7OqkUvq0dUS--

--ZGdlphLBydKKfXjI9Y7YoFuBxZc2TFX8t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4oJrEACgkQwj2R86El
/qiWjQgAjTD7bYmyFNM9KwhmBoj1xyMLylXNw8GigFMY07UYFfkw+2p3sYzMJOf3
fYgIxJpRm0CRu74YfJJBtbeHBnbRPqWqFLghZ1lt/6WXmzfHS1nia8evRbjenBfl
hrkBnezVC/3wQNMMm56BYsiwolLBrsaWQ8TybhWjn/KBw+xs126NbiszM7fEz6Am
0gKfrEEB2nl5MxlkT5xVYCV37G2IASQVX0HG26GsCup4x1kodccZ0CVB33IclCvy
QhsYAI0zgS/EjhWKnE2A/ySY4IxnwHN30Qlkp2j7T95KWm0si7OIC7Nk/ZHnwuUA
KdIql5qAmMqeQfNNCH6OM+1KEf8Y7w==
=6Saj
-----END PGP SIGNATURE-----

--ZGdlphLBydKKfXjI9Y7YoFuBxZc2TFX8t--
