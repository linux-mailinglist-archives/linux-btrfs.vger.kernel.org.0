Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAC159F864
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Aug 2022 13:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbiHXLJn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Aug 2022 07:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbiHXLJm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Aug 2022 07:09:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7131379618
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 04:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661339375;
        bh=mb83P0oNrQNZipqh3ME6psxH+7gySbes0TxvRNOI1IA=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=UdGW+vd1FOHyvcU6aAESPPAzhv+cVlnxhKpwUd2u5/KJCEf3ojAopuKxy5TCtuAmk
         NajmTIAAUrKE01lRvM2mXRMtfRh20QqWc6Dm/osMUpNxwrBEWpvEuPptZ2O8l/qHwq
         0VyHuw8U4UrS4mLOwqM+mvrXwTUcSOcJ9Fqxq2bk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2wGi-1oRuio2yPU-003Q1a; Wed, 24
 Aug 2022 13:09:35 +0200
Message-ID: <4127c8bd-babd-ca91-2757-901dfd535ed2@gmx.com>
Date:   Wed, 24 Aug 2022 19:09:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Goffredo Baroncelli <kreijack@libero.it>
References: <8032f0bba42927fb4d87909060e03a647bb60c32.1660200417.git.wqu@suse.com>
 <20220823171006.GG13489@twin.jikos.cz>
 <0770b696-6753-925c-24a5-fc9813f4c995@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2] btrfs: check the superblock to ensure the fs is not
 modified at thaw time
In-Reply-To: <0770b696-6753-925c-24a5-fc9813f4c995@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v6HZEw8XqeVzvgaObwMTnCXg4nwzSX3D/P4mXSWJf5GXoxTzcR2
 AKSakAyKX47vA3Hw0YJzp33zNnifRV75QJVuhfKegvn1t0siIWkP5s6N2fYE/zXX3ojzuPF
 36LV12QGmIgeAwpTY18EA8g5PtFoiTpB4D2ShpP6poUJKfe04PRqn2uVqsO+72kaOyx9DW7
 0xOFXs27K0FyEXY0n8afg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SBZfaENrVfc=:ZtwMYvTeJwBNDOVIesFkdq
 y2I3h2rXcOLT5MYp5rNhQKFyYoV3fjLIucXjNVFOjWaN3X3QhWE/haqI3JVKVMxB3xZAKWjZL
 EzFx69yYEyfN/Ui1K6Efgq7RFSwFzFz31GGwNzigf7JLu6cvYCS+D6Au08BKdT3++MhM6Mfux
 9mnkIq8F8UHxL/w5cGypPQNe3CMh1DttNvkOoMzhx0Ju+WBa2yLdHCiV3STPixNjW9TfrNaoR
 thPOEydHy7j8ZwEXJKJitZhnFD4r68pyWC2/ek/X2KIe8COuGxgJtg27OjeUjAwBSe6QjNmVe
 06KBYLOsxq8bMRmDwLd1wwxlA0kvZSTpIPQEBO7F8skbm2KAf/qTlatSsCN7knFXU94eFiRGC
 8nrRJI4BoHljWs+TGVpD1NeF5VHdQpuqhedlChDq4sqPgUAB1Sm18+mx10GltgGQ13YKRwaO4
 JiNGaZ1gAelpCwt2iAbjaMv2oe9PJJiR/r1NVpppSk7hlaVQS73pr+MLb+FiXbrukOIz6htQ6
 n6TlVKtQFDC2UmNaxbTL4WJxKrt7pHpTPJRXwoWlkwOB/f4tTI+y8gkp8s4trtxiyg0dqBK6s
 qM/LpQw+ee4yZMYWDIK9vzDO4Jvo5Yn/aslbMpFqzqlkGBAgv9aK3vxtvvqCZNS7f859VfFVu
 8ovX3bcmActCYIIZOrCSrTBOu4/ux5RVT59meJNjUY2VK+HuPlZzg4yE0UsKtVM+BejH9FtNZ
 5tQmIQSHVa6KJ8ujeZhahRJW245Tbf4zIVfAwqnCc/lclD2rCSdTcbyXOWni2/cZEB30A2N88
 27jEKzdsnyR29R5DHBpekSUcuJm1g1KSI0yiCgPviIPenO/RPn0nCGoYzjUa7U/5UFHDzoQCC
 16XBPU+IZ40HlsTXPTiMKdyjiA76JEuOQOiHl9x1AHM2JyTamH2luTAriMZKyv8s6Vshph/4M
 VHbJ/RGhVyHLRmAI6Wbzz7TURj0saPJc7+cmzgvqU+2GU+tSlmjpPqMZWtOSUTDSedZ6CQqP4
 ewrq2xL57WfGU817aiTbZW2pxTbjFwbI+ZamUJKBnOqSbmra7jho7Ro8FOE3pLxXf5pYKmUU7
 aBvOHvFgt1x46O+D8XgvayB9pjTa72FrrWTprLFge62wxOETDtXbXYU5g==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/24 07:11, Qu Wenruo wrote:
>
>
> On 2022/8/24 01:10, David Sterba wrote:
>> On Thu, Aug 11, 2022 at 02:47:08PM +0800, Qu Wenruo wrote:
>>> [BACKGROUND]
>>> There is an incident report that, one user hibernated the system, with
>>> one btrfs on removable device still mounted.
>>>
>>> Then by some incident, the btrfs got mounted and modified by another
>>> system/OS, then back to the hibernated system.
>>>
>>> After resuming from the hibernation, new write happened into the
>>> victim btrfs.
>>>
>>> Now the fs is completely broken, since the underlying btrfs is no long=
er
>>> the same one before the hibernation, and the user lost their data due =
to
>>> various transid mismatch.
>>>
>>> [REPRODUCER]
>>> We can emulate the situation using the following small script:
>>>
>>> =C2=A0 truncate -s 1G $dev
>>> =C2=A0 mkfs.btrfs -f $dev
>>> =C2=A0 mount $dev $mnt
>>> =C2=A0 fsstress -w -d $mnt -n 500
>>> =C2=A0 sync
>>> =C2=A0 xfs_freeze -f $mnt
>>> =C2=A0 cp $dev $dev.backup
>>>
>>> =C2=A0 # There is no way to mount the same cloned fs on the same syste=
m,
>>> =C2=A0 # as the conflicting fsid will be rejected by btrfs.
>>> =C2=A0 # Thus here we have to wipe the fs using a different btrfs.
>>> =C2=A0 mkfs.btrfs -f $dev.backup
>>>
>>> =C2=A0 dd if=3D$dev.backup of=3D$dev bs=3D1M
>>> =C2=A0 xfs_freeze -u $mnt
>>> =C2=A0 fsstress -w -d $mnt -n 20
>>> =C2=A0 umount $mnt
>>> =C2=A0 btrfs check $dev
>>>
>>> The final fsck will fail due to some tree blocks has incorrect fsid.
>>>
>>> This is enough to emulate the problem hit by the unfortunate user.
>>>
>>> [ENHANCEMENT]
>>> Although such case should not be that common, it can still happen from
>>> time to time.
>>>
>>> >From the view of btrfs, we can detect any unexpected super block
>>> change,
>>> and if there is any unexpected change, we just mark the fs RO, and tha=
w
>>> the fs.
>>>
>>> By this we can limit the damage to minimal, and I hope no one would lo=
se
>>> their data by this anymore.
>>>
>>> Suggested-by: Goffredo Baroncelli <kreijack@libero.it>
>>> Link:
>>> https://lore.kernel.org/linux-btrfs/83bf3b4b-7f4c-387a-b286-9251e3991e=
34@bluemole.com/
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> Changelog:
>>> v2:
>>> - Remove one unrelated debug pr_info()
>>> - Slightly re-word some comments
>>> - Add suggested-by tag
>>> ---
>>> =C2=A0 fs/btrfs/disk-io.c |=C2=A0 9 +++++--
>>> =C2=A0 fs/btrfs/disk-io.h |=C2=A0 2 +-
>>> =C2=A0 fs/btrfs/super.c=C2=A0=C2=A0 | 58 +++++++++++++++++++++++++++++=
+++++++++++++++++
>>> =C2=A0 fs/btrfs/volumes.c |=C2=A0 2 +-
>>> =C2=A0 4 files changed, 67 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>> index 6268dafeeb2d..7d99c42bdc51 100644
>>> --- a/fs/btrfs/disk-io.c
>>> +++ b/fs/btrfs/disk-io.c
>>> @@ -3849,7 +3849,7 @@ static void btrfs_end_super_write(struct bio *bi=
o)
>>> =C2=A0 }
>>>
>>> =C2=A0 struct btrfs_super_block *btrfs_read_dev_one_super(struct
>>> block_device *bdev,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 int copy_num)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 int copy_num, bool drop_cache)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_super_block *super;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *page;
>>> @@ -3867,6 +3867,11 @@ struct btrfs_super_block
>>> *btrfs_read_dev_one_super(struct block_device *bdev,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bytenr + BTRFS_SUPER_INFO_SIZE >=3D=
 bdev_nr_bytes(bdev))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ERR_PTR(=
-EINVAL);
>>>
>>> +=C2=A0=C2=A0=C2=A0 if (drop_cache)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 truncate_inode_pages_range=
(bdev->bd_inode->i_mapping,
>>
>> This will delete the range and replace by implicit zeros,

Nope, the implicit zeros are there if we're truncating sub-sector.

I'm not sure what's the sector size used by block layer (depending on
device? Thus 4K or 512B?).
But here I intentionally use range [round_down(bytenr, PAGE_SIZE),
round_up(bytenr + 4K, PAGE_SIZE)) to drop the page cache.

Unless we have some sepecial block layer code using unit larger than
PAGE_SIZE, we're ensured to drop the full page range, and leaving no
page filled with zero.

By this, no user space can read out zero from the page cache of the
device, but always read from disk.

Sure, this may need extra comments, and if you have more correct call
schema to only drop page cache of a certain range, then I'm pretty happy
to follow.

But I searched `mm.h` for quite some time, and didn't find a better one
than truncate_inode_pages_range().
The other alternative is truncate_inode_pages(), which drops all page
cache, thus needs no the page alignement thing.
I can go that way if you prefer.


>> but don't we
>> want to force reading the superblock form disk instead? Otherwise the
>> zeros can be read by something in userspace until the next superblock
>> write.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 round_down(bytenr, PAGE_SIZE),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 round_up(bytenr + BTRFS_SUPER_INFO_SIZE,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PAGE_SIZE) - 1);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page =3D read_cache_page_gfp(mapping, b=
ytenr >> PAGE_SHIFT,
>>> GFP_NOFS);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(page))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ERR_CAST=
(page);
>>> @@ -3898,7 +3903,7 @@ struct btrfs_super_block
>>> *btrfs_read_dev_super(struct block_device *bdev)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * later supers, using BTRFS_SUPER=
_MIRROR_MAX instead
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < 1; i++) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 super =3D btrfs_read_dev_o=
ne_super(bdev, i);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 super =3D btrfs_read_dev_o=
ne_super(bdev, i, false);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(supe=
r))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 continue;
>>>
>>> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
>>> index 47ad8e0a2d33..d0946f502f62 100644
>>> --- a/fs/btrfs/disk-io.h
>>> +++ b/fs/btrfs/disk-io.h
>>> @@ -49,7 +49,7 @@ void __cold close_ctree(struct btrfs_fs_info
>>> *fs_info);
>>> =C2=A0 int write_all_supers(struct btrfs_fs_info *fs_info, int max_mir=
rors);
>>> =C2=A0 struct btrfs_super_block *btrfs_read_dev_super(struct block_dev=
ice
>>> *bdev);
>>> =C2=A0 struct btrfs_super_block *btrfs_read_dev_one_super(struct
>>> block_device *bdev,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 int copy_num);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 int copy_num, bool drop_cache);
>>> =C2=A0 int btrfs_commit_super(struct btrfs_fs_info *fs_info);
>>> =C2=A0 struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree=
_root,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_key=
 *key);
>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>> index 4c7089b1681b..913b951981a9 100644
>>> --- a/fs/btrfs/super.c
>>> +++ b/fs/btrfs/super.c
>>> @@ -2548,11 +2548,69 @@ static int btrfs_freeze(struct super_block *sb=
)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return btrfs_commit_transaction(trans);
>>> =C2=A0 }
>>>
>>> +static int check_dev_super(struct btrfs_device *dev)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct btrfs_fs_info *fs_info =3D dev->fs_info;
>>> +=C2=A0=C2=A0=C2=A0 struct btrfs_super_block *sb;
>>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* This should be called with fs still frozen. */
>>> +=C2=A0=C2=A0=C2=A0 ASSERT(test_bit(BTRFS_FS_FROZEN, &fs_info->flags))=
;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* Missing dev,=C2=A0 no need to check. */
>>> +=C2=A0=C2=A0=C2=A0 if (!dev->bdev)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* Only need to check the primary super block. */
>>> +=C2=A0=C2=A0=C2=A0 sb =3D btrfs_read_dev_one_super(dev->bdev, 0, true=
);
>>
>> Inside that there magic number and offset is verified as it's the
>> minimal what must be correct.
>>
>>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(sb))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(sb);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (memcmp(sb->fsid, dev->fs_devices->fsid, BTRFS_=
FSID_SIZE)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_err(fs_info, "fsid d=
oesn't match, has %pU expect %pU",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 sb->fsid, dev->fs_devices->fsid);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EUCLEAN;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (btrfs_super_generation(sb) !=3D fs_info->last_=
trans_committed) {
>>
>> That's last generation and fsid but how about everything else? Also the
>> checksum should be validated. We have extensive check in
>> super.c:validate_super, why haven't you used that?
>
> Because I don't think that's needed at thawn time.
>
> Last transid and fsid is enough to ensure:
>
> 1) It's still the same btrfs
>
> 2) It's not modified halfway
>
> Unless there is some way to modify the fs without COWing the metadata,
> the fsid + transid check should be enough.

After more consideration, the fs thawn path is far from hot, and my
usual tend is, check every byte of the on-disk data. (which is not
followed here)

So I agree we should do full check.

Will address them all in v3 update.

Thanks,
Qu

>
> Thanks,
> Qu
>
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_err(fs_info, "transi=
d mismatch, has %llu expect %llu",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt=
rfs_super_generation(sb),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs=
_info->last_trans_committed);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EUCLEAN;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +out:
>>> +=C2=A0=C2=A0=C2=A0 btrfs_release_disk_super(sb);
>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>> +}
>>> +
>>> =C2=A0 static int btrfs_unfreeze(struct super_block *sb)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_fs_info *fs_info =3D btrfs=
_sb(sb);
>>> +=C2=A0=C2=A0=C2=A0 struct btrfs_device *device;
>>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>>
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Make sure the fs is not changed by acciden=
t (like hibernation
>>> then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * modified by other OS).
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If we found anything wrong, we mark the fs=
 error immediately.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 list_for_each_entry(device, &fs_info->fs_devices->=
devices,
>>> dev_list) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D check_dev_super(de=
vice);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt=
rfs_handle_fs_error(fs_info, ret,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "filesystem got modified unexpectedly");
>>
>> This should say something about thaw and on which device it got
>> detected.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clear_bit(BTRFS_FS_FROZEN, &fs_info->fl=
ags);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * We still return 0, to allow VFS layer to u=
nfreeze the fs even
>>> above
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * checks failed. Since the fs is either fine=
 or RO, we're safe to
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * continue, without causing further damage.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 8c64dda69404..a02066ae5812 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -2017,7 +2017,7 @@ void btrfs_scratch_superblocks(struct
>>> btrfs_fs_info *fs_info,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *pa=
ge;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disk_super =3D btrfs_read_=
dev_one_super(bdev, copy_num);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disk_super =3D btrfs_read_=
dev_one_super(bdev, copy_num, false);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(disk=
_super))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 continue;
>>>
>>> --
>>> 2.37.1
