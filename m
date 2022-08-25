Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED94D5A0524
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Aug 2022 02:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiHYATn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Aug 2022 20:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHYATm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Aug 2022 20:19:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89FD8A1E0
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 17:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661386774;
        bh=gFlKGvV5DWcjvcg5rXIeY0jNaw29x+L7wqieY991F+E=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=QNM8Y7AE4p22D2UM1f456kKLAjWfAXN5s3zHM/88eh021OlbgvCMRZX+98XikHRqu
         /Kou/2e78Q7p7sxN7AJxMMmv/c3s8lE+JUkRrAHfv48rrys8pa7J8PRAH2pBw8Ojdb
         /uDwM3Ek75FlM17mhYevZiGN8oI7uW9inkyVZ1DY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MlNp7-1pAIB62ran-00lln6; Thu, 25
 Aug 2022 02:19:34 +0200
Message-ID: <c550b374-5c74-c2dd-6f1f-7270f31d1800@gmx.com>
Date:   Thu, 25 Aug 2022 08:19:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3] btrfs: check the superblock to ensure the fs is not
 modified at thaw time
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Goffredo Baroncelli <kreijack@libero.it>
References: <e0a051edb23223036ebe21a01dd5d9ab63e54cc9.1661343122.git.wqu@suse.com>
 <7a0a875d-c3de-2f65-65c0-9750b6e1d9c1@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <7a0a875d-c3de-2f65-65c0-9750b6e1d9c1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wS4+ieQeJ0BzzfAFH2ZSzfcyi71DPu0ICpIc0dJ62RUcUWHRu4q
 rggTHISP+JOBHzWcm0aylH4PExPiR4Jkam2PKYI2zHrfkFuyYhL0DlQUhUFb1Bb/f0hnh5G
 5TPSTU7k7ef6dkE8YJoHEbJBa9XfCDNtJpPzN98QO6tdsmd5YtiSmPWeqsjbGYscgbIRyV6
 DFmcLUu1GGzJi9v9PlQfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G6a9VcDynSw=:KVOibudnHT7KlvY71nsr7X
 DyzrVdWQZBxDmYexYec7h3/01cteCy6NivpVXSusl8xCWsec3q55Hlkqzj/Xrzr3CpEbPBBSu
 qhgzV4jKjPagQ3+I/glBvw9FMWF/WuQCm68gnZ3rXBYeIoZNlghwo79ODYXWTfjXs3r2XjqcO
 89S2kVjlB+A8l+4Y87pwxCGEmIQtFS9YtECV92gNe3+HL9fSeS61yzyptvvCzDMfz9rp9fLyt
 yfOAJsoo/Vb1DvG015DFaLR7Oy/3Z2SJWVrsUhr+UL2Nquo6cwgOYPpQel5InzUQdV09CPj7+
 +5ofzzl7Zg+9ivt19VXQ5J1EG+rJ7evlNF4CKmLPqeJD1v7F9Nrq99ThVjqiKN1VpSrJJ94fR
 V41N7fqybWPToqA8X/ANvV/5iPJ+yISAMxdn/M52COxvJ6++BTOIzT6SM53uMBaa8U65k8UsH
 jvjbE0hEyBdARRlGj9Z5UdDhGWnTaPDE8fFGWrRvJZYH3o6jxIZZq3R//RpoYwRPKSdG67ZNm
 SolIDDVBkoFUHWzbhPfD4G+BHZVBctvWhExVAFhUXFU7YcenrSV1/AbD2mMkE961H3UAXpikK
 U/HclvMAe48RsjQ+iuEyrVdL9ITpdbTmsVGd8YIaddu72i6eStae7mxSIc8qISukL8X1kFm+0
 emOzipEFKoactfLBy5OJFv6cT1A6UNA7xtBLIkXyRzgkQ9+/FIPRpjuwAPsJ8f3EBa0+ZtCsy
 01wMkPi8FebaMzm9TDbSyVrjEPcF97Dx14raEa8SQqDTrpEcCIJlUnNAZhFCv50EcIQSQT0ls
 f5kUWV5+ORqK06gDmTYdSm4PE63fNu9ompnW76lVLDCTtTMaI+nqfdteJ/ZpTGpjmooxRJqVy
 QTZpRSIxhlkKJ4xnsO2rRtYbSJQWFTwXtgK2oVhKhpXOiwXSik99Z2wVRIhHWB7MacP2F2qKm
 WbQIR6vol5ERBlcjgmuuXjVJjf220afFfhewepCUUiMjDWS3eGLbi43lw4MnWaqAvdt1rdT8f
 uFzaIvptYdB/w6/fnjW9FMUS5VFYcvKOm975qw6uVGeLtIxgxDZRRT3j1Zxl/pziZz16gMHqA
 h3PGJYWlLnGQ6Qk5s2A9eaDgZy5EC7lI+2hJstVk8k1NSOEnPieU/lv6g==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/25 07:55, Anand Jain wrote:
> On 8/24/22 20:16, Qu Wenruo wrote:
>> [BACKGROUND]
>> There is an incident report that, one user hibernated the system, with
>> one btrfs on removable device still mounted.
>>
>> Then by some incident, the btrfs got mounted and modified by another
>> system/OS, then back to the hibernated system.
>>
>> After resuming from the hibernation, new write happened into the
>> victim btrfs.
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
>> =C2=A0 truncate -s 1G $dev
>> =C2=A0 mkfs.btrfs -f $dev
>> =C2=A0 mount $dev $mnt
>> =C2=A0 fsstress -w -d $mnt -n 500
>> =C2=A0 sync
>> =C2=A0 xfs_freeze -f $mnt
>> =C2=A0 cp $dev $dev.backup
>>
>> =C2=A0 # There is no way to mount the same cloned fs on the same system=
,
>> =C2=A0 # as the conflicting fsid will be rejected by btrfs.
>> =C2=A0 # Thus here we have to wipe the fs using a different btrfs.
>> =C2=A0 mkfs.btrfs -f $dev.backup
>>
>> =C2=A0 dd if=3D$dev.backup of=3D$dev bs=3D1M
>> =C2=A0 xfs_freeze -u $mnt
>> =C2=A0 fsstress -w -d $mnt -n 20
>> =C2=A0 umount $mnt
>> =C2=A0 btrfs check $dev
>>
>> The final fsck will fail due to some tree blocks has incorrect fsid.
>>
>> This is enough to emulate the problem hit by the unfortunate user.
>>
>> [ENHANCEMENT]
>> Although such case should not be that common, it can still happen from
>> time to time.
>>
>> =C2=A0From the view of btrfs, we can detect any unexpected super block =
change,
>> and if there is any unexpected change, we just mark the fs read-only, a=
nd
>> thaw the fs.
>>
>> By this we can limit the damage to minimal, and I hope no one would los=
e
>> their data by this anymore.
>>
>> Suggested-by: Goffredo Baroncelli <kreijack@libero.it>
>> Link:
>> https://lore.kernel.org/linux-btrfs/83bf3b4b-7f4c-387a-b286-9251e3991e3=
4@bluemole.com/
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>
> A nit below.
>
>> ---
>> Changelog:
>> v3:
>> - Use invalidate_inode_pages2_range() to avoid tricky page alignment
>> =C2=A0=C2=A0 Previously I use truncate_inode_pages_range() with page al=
igned range.
>> =C2=A0=C2=A0 But this can be confusing since truncate_inode_pages_ragen=
() can
>> =C2=A0=C2=A0 fill unaligned range with zero. (thus I intentionally alig=
n the
>> =C2=A0=C2=A0 range).
>>
>> =C2=A0=C2=A0 Since we're only interesting dropping the page cache, use
>> =C2=A0=C2=A0 invalidate_inode_pages2_range() should be better.
>>
>> - Export btrfs_validate_super() to do full super block check at thaw
>> =C2=A0=C2=A0 time
>> =C2=A0=C2=A0 This brings all the checks, and since freeze/thaw should b=
e a cold
>> =C2=A0=C2=A0 path, the extra check shouldn't bother us much.
>>
>> - Add an extra comment on why we don't need to hold device_list_mutex.
>>
>> v2:
>> - Remove one unrelated debug pr_info()
>> - Slightly re-word some comments
>> - Add suggested-by tag
>> ---
>> =C2=A0 fs/btrfs/disk-io.c | 25 ++++++++++++++-----
>> =C2=A0 fs/btrfs/disk-io.h |=C2=A0 4 +++-
>> =C2=A0 fs/btrfs/super.c=C2=A0=C2=A0 | 60 ++++++++++++++++++++++++++++++=
++++++++++++++++
>> =C2=A0 fs/btrfs/volumes.c |=C2=A0 2 +-
>> =C2=A0 4 files changed, 83 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index e67614afcf4f..bc94feba2fe3 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -2600,8 +2600,8 @@ static int btrfs_read_roots(struct btrfs_fs_info
>> *fs_info)
>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1, 2=C2=
=A0=C2=A0=C2=A0 2nd and 3rd backup copy
>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 -1=C2=A0=C2=A0=C2=A0 skip bytenr check
>> =C2=A0=C2=A0 */
>> -static int validate_super(struct btrfs_fs_info *fs_info,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct btrfs_super_block *sb, int mirror_num)
>> +int btrfs_validate_super(struct btrfs_fs_info *fs_info,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct btrfs_super_block *sb, int mirror_num)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 nodesize =3D btrfs_super_nodesize(sb=
);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 sectorsize =3D btrfs_super_sectorsiz=
e(sb);
>> @@ -2785,7 +2785,7 @@ static int validate_super(struct btrfs_fs_info
>> *fs_info,
>> =C2=A0=C2=A0 */
>> =C2=A0 static int btrfs_validate_mount_super(struct btrfs_fs_info *fs_i=
nfo)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 return validate_super(fs_info, fs_info->super_copy,=
 0);
>> +=C2=A0=C2=A0=C2=A0 return btrfs_validate_super(fs_info, fs_info->super=
_copy, 0);
>> =C2=A0 }
>> =C2=A0 /*
>> @@ -2799,7 +2799,7 @@ static int btrfs_validate_write_super(struct
>> btrfs_fs_info *fs_info,
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> -=C2=A0=C2=A0=C2=A0 ret =3D validate_super(fs_info, sb, -1);
>> +=C2=A0=C2=A0=C2=A0 ret =3D btrfs_validate_super(fs_info, sb, -1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!btrfs_supported_super_csum(btrfs_su=
per_csum_type(sb))) {
>> @@ -3847,7 +3847,7 @@ static void btrfs_end_super_write(struct bio *bio=
)
>> =C2=A0 }
>> =C2=A0 struct btrfs_super_block *btrfs_read_dev_one_super(struct
>> block_device *bdev,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 int copy_num)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 int copy_num, bool drop_cache)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_super_block *super;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *page;
>> @@ -3865,6 +3865,19 @@ struct btrfs_super_block
>> *btrfs_read_dev_one_super(struct block_device *bdev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bytenr + BTRFS_SUPER_INFO_SIZE >=3D =
bdev_nr_bytes(bdev))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ERR_PTR(-=
EINVAL);
>> +=C2=A0=C2=A0=C2=A0 if (drop_cache) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* This should only be call=
ed with the primary sb. */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT(copy_num =3D=3D 0);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Drop the page of th=
e primary superblock, so later
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * read will always re=
ad from the device.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 invalidate_inode_pages2_ran=
ge(mapping,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bytenr >> PAGE_SHIFT,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page =3D read_cache_page_gfp(mapping, by=
tenr >> PAGE_SHIFT,
>> GFP_NOFS);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(page))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ERR_CAST(=
page);
>> @@ -3896,7 +3909,7 @@ struct btrfs_super_block
>> *btrfs_read_dev_super(struct block_device *bdev)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * later supers, using BTRFS_SUPER_=
MIRROR_MAX instead
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < 1; i++) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 super =3D btrfs_read_dev_on=
e_super(bdev, i);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 super =3D btrfs_read_dev_on=
e_super(bdev, i, false);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(super=
))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 continue;
>> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
>> index 47ad8e0a2d33..aef981de672c 100644
>> --- a/fs/btrfs/disk-io.h
>> +++ b/fs/btrfs/disk-io.h
>> @@ -46,10 +46,12 @@ int __cold open_ctree(struct super_block *sb,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct btrfs_fs_devices *fs_devices,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 char *options);
>> =C2=A0 void __cold close_ctree(struct btrfs_fs_info *fs_info);
>> +int btrfs_validate_super(struct btrfs_fs_info *fs_info,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct btrfs_super_block *sb, int mirror_num);
>> =C2=A0 int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirr=
ors);
>> =C2=A0 struct btrfs_super_block *btrfs_read_dev_super(struct block_devi=
ce
>> *bdev);
>> =C2=A0 struct btrfs_super_block *btrfs_read_dev_one_super(struct
>> block_device *bdev,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 int copy_num);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 int copy_num, bool drop_cache);
>> =C2=A0 int btrfs_commit_super(struct btrfs_fs_info *fs_info);
>> =C2=A0 struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_=
root,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_key=
 *key);
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index f1c6ca59299e..0857265ea8d8 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -2553,11 +2553,71 @@ static int btrfs_freeze(struct super_block *sb)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return btrfs_commit_transaction(trans);
>> =C2=A0 }
>> +static int check_dev_super(struct btrfs_device *dev)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_fs_info *fs_info =3D dev->fs_info;
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_super_block *sb;
>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* This should be called with fs still frozen. */
>> +=C2=A0=C2=A0=C2=A0 ASSERT(test_bit(BTRFS_FS_FROZEN, &fs_info->flags));
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Missing dev,=C2=A0 no need to check. */
>> +=C2=A0=C2=A0=C2=A0 if (!dev->bdev)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Only need to check the primary super block. */
>> +=C2=A0=C2=A0=C2=A0 sb =3D btrfs_read_dev_one_super(dev->bdev, 0, true)=
;
>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(sb))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(sb);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Btrfs_validate_super() includes fsid check again=
st
>> super->fsid. */
>> +=C2=A0=C2=A0=C2=A0 ret =3D btrfs_validate_super(fs_info, sb, 0);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (btrfs_super_generation(sb) !=3D fs_info->last_t=
rans_committed) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_err(fs_info, "transid=
 mismatch, has %llu expect %llu",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btr=
fs_super_generation(sb),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_=
info->last_trans_committed);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EUCLEAN;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> +=C2=A0=C2=A0=C2=A0 }
>> +out:
>> +=C2=A0=C2=A0=C2=A0 btrfs_release_disk_super(sb);
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> =C2=A0 static int btrfs_unfreeze(struct super_block *sb)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_fs_info *fs_info =3D btrfs_=
sb(sb);
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_device *device;
>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Make sure the fs is not changed by accident=
 (like hibernation
>> then
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * modified by other OS).
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If we found anything wrong, we mark the fs =
error immediately.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * And since the fs is frozen, no one can modi=
fy the fs yet, thus
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * we don't need to hold device_list_mutex.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 list_for_each_entry(device, &fs_info->fs_devices->d=
evices,
>> dev_list) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D check_dev_super(dev=
ice);
>
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btr=
fs_handle_fs_error(fs_info, ret,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "super block on devid %llu got modified unexpectedly=
",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 device->devid);
>
> We may fail to read the sb if the page does not get brought uptodate,
> read_cache_page_gfp() returns -EIO.
>
> check_dev_super()
>  =C2=A0btrfs_read_dev_one_super()
>  =C2=A0 read_cache_page_gfp()
>
>
> But, the above error log is misleading.

In that case, I'd say there is still something weird there.

By whatever reason, if we can not read a valid super block, even it's
-EIO, it's worthy reporting at thaw time.

Thanks,
Qu
>
> -Anand
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clear_bit(BTRFS_FS_FROZEN, &fs_info->fla=
gs);
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * We still return 0, to allow VFS layer to un=
freeze the fs even
>> above
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * checks failed. Since the fs is either fine =
or RO, we're safe to
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * continue, without causing further damage.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 95a2eaf8a958..5b2cafafce2e 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -2017,7 +2017,7 @@ void btrfs_scratch_superblocks(struct
>> btrfs_fs_info *fs_info,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *pag=
e;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disk_super =3D btrfs_read_d=
ev_one_super(bdev, copy_num);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disk_super =3D btrfs_read_d=
ev_one_super(bdev, copy_num, false);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(disk_=
super))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 continue;
>
