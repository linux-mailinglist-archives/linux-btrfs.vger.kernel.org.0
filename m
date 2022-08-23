Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155B859EF91
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Aug 2022 01:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiHWXL7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 19:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiHWXL5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 19:11:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D94564EA
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 16:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661296312;
        bh=DSogDnGBUnb+OIv4Te98XmzTaIBfr3YfIj2fFr6IHm8=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=TwEr96CdDWrS7eXAU2j3iGCTdcZVM7qV24LtD3nA+Vx16eoNAnJ6V1qk2gjGFaals
         wCvGyaHKSulpmvNZMDMBGTpGZ/wsERdCwMDlczfgLW4x9n8EvYMvMaoqTYg+OgLYnU
         9m+0mWqVz2+SyGDIUyl21wj18ZM3fJ+vWA7/zKhM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtwYu-1pIa5r1AZo-00uMIC; Wed, 24
 Aug 2022 01:11:51 +0200
Message-ID: <0770b696-6753-925c-24a5-fc9813f4c995@gmx.com>
Date:   Wed, 24 Aug 2022 07:11:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] btrfs: check the superblock to ensure the fs is not
 modified at thaw time
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Goffredo Baroncelli <kreijack@libero.it>
References: <8032f0bba42927fb4d87909060e03a647bb60c32.1660200417.git.wqu@suse.com>
 <20220823171006.GG13489@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220823171006.GG13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OhEBpv02KyntQTY4cd0MIk4nNvA6Wv+h6nvxH2M0rVd7Jamv7Us
 UuBJCRMYD6F05KK7NG6qC9yF93LaJxde+Rq8ln+5Y6VYgJT0frFQkpsQMZvvsVd3z1aYaJz
 BXXoR4ygr7qXUKrZsiROL3sZb/aw2oJHc7zPbnq0lQqziGSDIfF5IfwCOIIncdY+aatvGd+
 jcx2hVjImnWmY4hNCgMMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lpmt2In0pYc=:hV/Z+1o2+bOcyeESi+blRN
 LNrvy1EqV+psJrohVQxrlm3hyzjCznKyVpb7ffuytHyzKpy9c69/18OuCjjsMPBdOVxlxoT5D
 SheSaZDkpAYR0USsswuuYQ0oybIHeZ/EfKBT5WeH+6ioXfh70LgaMGmDg1OC5ABo/8OXid/Xs
 E5y7Fk8jRAgIsyi9L1H8No36ggXn16Gnq7EAATcXsyTKRLIU56Pf2Ne9djELKVOIU3dyNYnjU
 YJ0LjOfeELSLsu/1N5VyTnrVjZptD1vjixQY4Ega38QW3tzmIel95dyA39yojzPLifYsjsCwT
 9WgyCFTe9cIBjq1IX+0+xdOfH36Nhs+SDuOMLFukVYJFdCFA4tZJnd27LgFY66evgRl+Utv9h
 gpeXqC0i0DL+JBzHgsrVk2wk++vR0gRom/T9dm0nmIC/yqs7Af7ZkgfUfeS6EY1w05AfKwUM4
 u4joge3CNMZ/2aefCqLn3AlAmUUE8n2kyZOMZgSLfgaZcYN6etW76mAOXSZNnkEjAskaYS6z2
 +uyA1C32v2yyg5V7uk3Sc8RRZWEKfiiv2o4GDMYc6jjRpMhofH2nG2F+2BOWaugjlCye/ruup
 VBJ84jv/HGo7tsWvPdbDLvm9J/+INtbquf99LIieJ7sh0yTDO2wAFtBxgF9h4SW++CzI5Lb2G
 XFkZtvp85W9fOKJZ7bosQBOZtOcQhjaPzQSxkY8GBOwuTKHWUaRAocD8E6voAivf+mFu4r5DY
 twZk8eyzsIID3MW0p91MAjCA6iyl3jYwWHZOLqNmYwwScGcNDeqGWQJoy0FSmiV5OAIIpLAfv
 Z7UahzA22QrKDDMyDTOM6mW58/GsylsTCsUx6a9ejq00Pt84tw3QfV0bEw4f2yKJ6P+a4KdjC
 M+qIyYkGPe6jt2o7wRC+axr4qFomwnCo6p/k6zgS4h3ZIDXj8UgNiGSyl0EGYbLjy6EYNx4rz
 e5jVu4sdoTeGK35GJ1rXOLzaeo3ptUxtQTejqUiEp6ukkkbuZhNRj8MdPnoOAE2sQGFt0ZLE5
 zkNVd53Zz8HQUC/L9ZpruOf7DSh4+dAHontGWAJVzg0sH93YeTxzotIA3oGYU4LxEk88MvGIA
 7G/FsqNcPephUALHQWksMNSSaxvGRTWf7b20/k/Z/cu25+OFDe9GL5mAQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/24 01:10, David Sterba wrote:
> On Thu, Aug 11, 2022 at 02:47:08PM +0800, Qu Wenruo wrote:
>> [BACKGROUND]
>> There is an incident report that, one user hibernated the system, with
>> one btrfs on removable device still mounted.
>>
>> Then by some incident, the btrfs got mounted and modified by another
>> system/OS, then back to the hibernated system.
>>
>> After resuming from the hibernation, new write happened into the victim=
 btrfs.
>>
>> Now the fs is completely broken, since the underlying btrfs is no longe=
r
>> the same one before the hibernation, and the user lost their data due t=
o
>> various transid mismatch.
>>
>> [REPRODUCER]
>> We can emulate the situation using the following small script:
>>
>>   truncate -s 1G $dev
>>   mkfs.btrfs -f $dev
>>   mount $dev $mnt
>>   fsstress -w -d $mnt -n 500
>>   sync
>>   xfs_freeze -f $mnt
>>   cp $dev $dev.backup
>>
>>   # There is no way to mount the same cloned fs on the same system,
>>   # as the conflicting fsid will be rejected by btrfs.
>>   # Thus here we have to wipe the fs using a different btrfs.
>>   mkfs.btrfs -f $dev.backup
>>
>>   dd if=3D$dev.backup of=3D$dev bs=3D1M
>>   xfs_freeze -u $mnt
>>   fsstress -w -d $mnt -n 20
>>   umount $mnt
>>   btrfs check $dev
>>
>> The final fsck will fail due to some tree blocks has incorrect fsid.
>>
>> This is enough to emulate the problem hit by the unfortunate user.
>>
>> [ENHANCEMENT]
>> Although such case should not be that common, it can still happen from
>> time to time.
>>
>> >From the view of btrfs, we can detect any unexpected super block chang=
e,
>> and if there is any unexpected change, we just mark the fs RO, and thaw
>> the fs.
>>
>> By this we can limit the damage to minimal, and I hope no one would los=
e
>> their data by this anymore.
>>
>> Suggested-by: Goffredo Baroncelli <kreijack@libero.it>
>> Link: https://lore.kernel.org/linux-btrfs/83bf3b4b-7f4c-387a-b286-9251e=
3991e34@bluemole.com/
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Remove one unrelated debug pr_info()
>> - Slightly re-word some comments
>> - Add suggested-by tag
>> ---
>>   fs/btrfs/disk-io.c |  9 +++++--
>>   fs/btrfs/disk-io.h |  2 +-
>>   fs/btrfs/super.c   | 58 +++++++++++++++++++++++++++++++++++++++++++++=
+
>>   fs/btrfs/volumes.c |  2 +-
>>   4 files changed, 67 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 6268dafeeb2d..7d99c42bdc51 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -3849,7 +3849,7 @@ static void btrfs_end_super_write(struct bio *bio=
)
>>   }
>>
>>   struct btrfs_super_block *btrfs_read_dev_one_super(struct block_devic=
e *bdev,
>> -						   int copy_num)
>> +						   int copy_num, bool drop_cache)
>>   {
>>   	struct btrfs_super_block *super;
>>   	struct page *page;
>> @@ -3867,6 +3867,11 @@ struct btrfs_super_block *btrfs_read_dev_one_sup=
er(struct block_device *bdev,
>>   	if (bytenr + BTRFS_SUPER_INFO_SIZE >=3D bdev_nr_bytes(bdev))
>>   		return ERR_PTR(-EINVAL);
>>
>> +	if (drop_cache)
>> +		truncate_inode_pages_range(bdev->bd_inode->i_mapping,
>
> This will delete the range and replace by implicit zeros, but don't we
> want to force reading the superblock form disk instead? Otherwise the
> zeros can be read by something in userspace until the next superblock
> write.
>
>> +				round_down(bytenr, PAGE_SIZE),
>> +				round_up(bytenr + BTRFS_SUPER_INFO_SIZE,
>> +					 PAGE_SIZE) - 1);
>>   	page =3D read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS=
);
>>   	if (IS_ERR(page))
>>   		return ERR_CAST(page);
>> @@ -3898,7 +3903,7 @@ struct btrfs_super_block *btrfs_read_dev_super(st=
ruct block_device *bdev)
>>   	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
>>   	 */
>>   	for (i =3D 0; i < 1; i++) {
>> -		super =3D btrfs_read_dev_one_super(bdev, i);
>> +		super =3D btrfs_read_dev_one_super(bdev, i, false);
>>   		if (IS_ERR(super))
>>   			continue;
>>
>> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
>> index 47ad8e0a2d33..d0946f502f62 100644
>> --- a/fs/btrfs/disk-io.h
>> +++ b/fs/btrfs/disk-io.h
>> @@ -49,7 +49,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info=
);
>>   int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
>>   struct btrfs_super_block *btrfs_read_dev_super(struct block_device *b=
dev);
>>   struct btrfs_super_block *btrfs_read_dev_one_super(struct block_devic=
e *bdev,
>> -						   int copy_num);
>> +						   int copy_num, bool drop_cache);
>>   int btrfs_commit_super(struct btrfs_fs_info *fs_info);
>>   struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
>>   					struct btrfs_key *key);
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index 4c7089b1681b..913b951981a9 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -2548,11 +2548,69 @@ static int btrfs_freeze(struct super_block *sb)
>>   	return btrfs_commit_transaction(trans);
>>   }
>>
>> +static int check_dev_super(struct btrfs_device *dev)
>> +{
>> +	struct btrfs_fs_info *fs_info =3D dev->fs_info;
>> +	struct btrfs_super_block *sb;
>> +	int ret =3D 0;
>> +
>> +	/* This should be called with fs still frozen. */
>> +	ASSERT(test_bit(BTRFS_FS_FROZEN, &fs_info->flags));
>> +
>> +	/* Missing dev,  no need to check. */
>> +	if (!dev->bdev)
>> +		return 0;
>> +
>> +	/* Only need to check the primary super block. */
>> +	sb =3D btrfs_read_dev_one_super(dev->bdev, 0, true);
>
> Inside that there magic number and offset is verified as it's the
> minimal what must be correct.
>
>> +	if (IS_ERR(sb))
>> +		return PTR_ERR(sb);
>> +
>> +	if (memcmp(sb->fsid, dev->fs_devices->fsid, BTRFS_FSID_SIZE)) {
>> +		btrfs_err(fs_info, "fsid doesn't match, has %pU expect %pU",
>> +			  sb->fsid, dev->fs_devices->fsid);
>> +		ret =3D -EUCLEAN;
>> +		goto out;
>> +	}
>> +
>> +	if (btrfs_super_generation(sb) !=3D fs_info->last_trans_committed) {
>
> That's last generation and fsid but how about everything else? Also the
> checksum should be validated. We have extensive check in
> super.c:validate_super, why haven't you used that?

Because I don't think that's needed at thawn time.

Last transid and fsid is enough to ensure:

1) It's still the same btrfs

2) It's not modified halfway

Unless there is some way to modify the fs without COWing the metadata,
the fsid + transid check should be enough.

Thanks,
Qu

>
>> +		btrfs_err(fs_info, "transid mismatch, has %llu expect %llu",
>> +			btrfs_super_generation(sb),
>> +			fs_info->last_trans_committed);
>> +		ret =3D -EUCLEAN;
>> +		goto out;
>> +	}
>> +out:
>> +	btrfs_release_disk_super(sb);
>> +	return ret;
>> +}
>> +
>>   static int btrfs_unfreeze(struct super_block *sb)
>>   {
>>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);
>> +	struct btrfs_device *device;
>> +	int ret =3D 0;
>>
>> +	/*
>> +	 * Make sure the fs is not changed by accident (like hibernation then
>> +	 * modified by other OS).
>> +	 * If we found anything wrong, we mark the fs error immediately.
>> +	 */
>> +	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) =
{
>> +		ret =3D check_dev_super(device);
>> +		if (ret < 0) {
>> +			btrfs_handle_fs_error(fs_info, ret,
>> +				"filesystem got modified unexpectedly");
>
> This should say something about thaw and on which device it got
> detected.
>
>> +			break;
>> +		}
>> +	}
>>   	clear_bit(BTRFS_FS_FROZEN, &fs_info->flags);
>> +
>> +	/*
>> +	 * We still return 0, to allow VFS layer to unfreeze the fs even abov=
e
>> +	 * checks failed. Since the fs is either fine or RO, we're safe to
>> +	 * continue, without causing further damage.
>> +	 */
>>   	return 0;
>>   }
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 8c64dda69404..a02066ae5812 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -2017,7 +2017,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_in=
fo *fs_info,
>>   		struct page *page;
>>   		int ret;
>>
>> -		disk_super =3D btrfs_read_dev_one_super(bdev, copy_num);
>> +		disk_super =3D btrfs_read_dev_one_super(bdev, copy_num, false);
>>   		if (IS_ERR(disk_super))
>>   			continue;
>>
>> --
>> 2.37.1
