Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5F96E54CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 00:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjDQWvn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 18:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjDQWvm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 18:51:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336093C32
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 15:51:38 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M42nY-1poXh92N2u-0001A2; Tue, 18
 Apr 2023 00:51:36 +0200
Message-ID: <2bde7099-2659-0028-b3bc-b7144833fd65@gmx.com>
Date:   Tue, 18 Apr 2023 06:51:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] btrfs-progs: logical-resolve: fix the subvolume path
 resolution
To:     Torstein Eide <torsteine@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230417094810.42214-1-wqu@suse.com>
 <CAL5DHTGrj93FwEZziUsyZiGQyHZh3G1z6FKi1twP+G5TCY740g@mail.gmail.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL5DHTGrj93FwEZziUsyZiGQyHZh3G1z6FKi1twP+G5TCY740g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:fHAD4Ul9zyNJDayrA2u3IAO7iUWVoQBk08b8WTZMOC9CDgPvm9E
 Gh3jElvma4F9gU9AFla6aNSzhCm4dh3S9czhrlxCRGbFgTpfDSBus3YxozjKKXFO6iUFjxT
 9AlVqAWCM3CiofqCZecXagNttdkF2cvBbS2mSh2KUMSIYws0gSREkdQIQWsFVH/3fLW12Nm
 a5yAicmVGoLCGGfGwlO8A==
UI-OutboundReport: notjunk:1;M01:P0:HzF7RFncgyw=;y+VBKtd8rPmaDcsBuvRvwFm8uR9
 WDi6Ndqh4NRzSNvKaEWLnCQznYlSuHVeXm7LcCtbNCpyQb44cW8DRN9z2HLO6mpw5cvLzzX93
 ooYRI489ricT89oReyG1Bm9i6Icmv1dHLCqYEpOZIyYVSQWsaGhH6dZ97Q0XF3D40ft0CMAIt
 qo8A/voJGHOJJsAVA1v7pIsYHb0pQR9mxizxdEr5iPrISPH+u8U/NTEhL7tzoRzk0ffEHZRgE
 0/sDSGAb4reMuYdjil5v/sCWWGgKblrvJdIY/5neEyfmjmeWM14b9zsRhBITnmWh7iQ/NiKFL
 F+KTISWdPIfq/qL2M0gkI3HmmYgbeaL6fa8SD6h1ZTqfxp00lwEkfmE/NeXRKcAXauUP797V2
 bIMs9o4oea+N7DHFE3osE/OnnEByAnf9npC7yGQ1v9QdyVgME/JRuK2gVR6TbHX4swat9bGNk
 tIz+jR7+uRyv1/sjjQwOVzVsxjQDw+PjZ2GwYuZYuwe/rNWSRRW4mxaM7aeU3KRVD9qzwiXa6
 eiHH+BQQWJm7mHcJd2jXL+SoPIcbgenfb/uSFXI3wpCrSWiJOgrnvAAp2ResDI2NpfkxyNTTx
 fM6H3S8Bqsq+EvYEvWWokIaq8nmkHMtsct3GXEJfPJsDNg3zwr8BwPJdHXh+xuv082guu0IwH
 FYjx9pIimW0N7oQ07YedcpvGKs1oBTABBRgiiaCBUdmsc6SVs4eo+IOFtdynBCt2v8AhbHMY/
 mgnXqf1zZq7ULvMNJDH5+gUVhsrp+DxY5qxfBwnv88rm2ijZ4j6Pdw5J/59aikBlcnHJx939/
 QaITdsvsml7sIhoxNrN5ZUaG55Xs1lk5jQzTyXKL7OUg+14VhBnb9e/pewcN0KbUyPf7BQr5k
 bqOfDQKWwO/hBSvQJIexO9YzcPLLNXzuL2BPSzeDvlY2uuyfucUEyTo18SP1wd8b6OFpXO4k+
 ehi6y4hKZOxlBkX/4VAobqRdCS8=
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        LOTS_OF_MONEY,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/18 05:17, Torstein Eide wrote:
> I made btrfs-progs, with `devel` branch and the patch.
> 
> Running the `btrfs inspect logical-resolve` against the top level
> subvol works, like the example you showed.
> # ${btrfs_prog_path}/btrfs inspect logical-resolve 13631488 $mnt
> ````
> $mnt/subv1/file
> ````
> 
> But if running against the a mount subvol it gives useless error:
> # mount:
> ````
> /dev/loop20 on /mnt/subtest type btrfs (...,subvol=/subv1)
> ````
> # ${btrfs_prog_path}/btrfs inspect logical-resolve 13631488 subtest
> ````
> ERROR: cannot access 'subtest/subv1': No such file or directory
> ````

Weird, in my test env, it failed with a clear error message:

# mount /dev/test/scratch1  -o subvolid=256 /mnt/btrfs/
# ./btrfs ins log 13631488 /mnt/btrfs/
ERROR: mount point "/mnt/btrfs/" is not the top-level subvolume


> 
> Note to self:
> #How to build btrfs-progs
> ````
> apt install make autoconf automake autotools-dev autoconf automake
> build-essential e2fslibs-dev libblkid-dev zlib1g-dev libzstd-dev
> libudev-dev python3.8 python3.8-dev liblzo2-dev libbtrfsutil-dev
> make install_python
> ./autogen.sh && ./configure --disable-documentation
> --prefix=/home/torstein/btrfs-progs/BIN
> ````
> 
> 
> man. 17. apr. 2023 kl. 11:48 skrev Qu Wenruo <wqu@suse.com>:
>>
>> [BUG]
>> There is a bug report that "btrfs inspect logical-resolve" can not even
>> handle any file inside non-top-level subvolumes:
>>
>>   # mkfs.btrfs $dev
>>   # mount $dev $mnt
>>   # btrfs subvol create $mnt/subv1
>>   # xfs_io -f -c "pwrite 0 16k" $mnt/subv1/file
>>   # sync
>>   # btrfs inspect logical-resolve 13631488 $mnt
>>   inode 257 subvol subv1 could not be accessed: not mounted
>>
>> This means the command "btrfs inspect logical-resolve" is almost useless
>> for resolving logical bytenr to files.
>>
>> [CAUSE]
>> "btrfs inspect logical-resolve" firstly resolve the logical bytenr to
>> root/ino pairs, then call btrfs_subvolid_resolve() to resolve the path
>> to the subvolume.
>>
>> Then to handle cases where the subvolume is already mounted somewhere
>> else, we call find_mount_fsroot().
>>
>> But if that target subvolume is not yet mounted, we just error out, even
>> if the @path is the top-level subvolume, and we have already know the
>> path to the subvolume.
>>
>> [FIX]
>> Instead of doing unnecessary subvolume mount point check, just require
>> the @path to be the mount point of the top-level subvolume.
>>
>> So that we can access all subvolumes without mounting each one.
>>
>> Now the command works as expected:
>>
>>   # ./btrfs inspect logical-resolve 13631488 $mnt
>>   /mnt/btrfs/subv1/file
>>
>> And since we're changing the behavior of "logical-resolve" (to a more
>> user-friendly one), we have to update the test case misc/042 to reflect
>> that.
>>
>> Reported-by: Torstein Eide <torsteine@gmail.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   Documentation/btrfs-inspect-internal.rst      |  3 ++
>>   cmds/inspect.c                                | 54 ++++++++-----------
>>   .../test.sh                                   | 25 ---------
>>   3 files changed, 24 insertions(+), 58 deletions(-)
>>
>> diff --git a/Documentation/btrfs-inspect-internal.rst b/Documentation/btrfs-inspect-internal.rst
>> index 4265fab6..69da468a 100644
>> --- a/Documentation/btrfs-inspect-internal.rst
>> +++ b/Documentation/btrfs-inspect-internal.rst
>> @@ -149,6 +149,9 @@ logical-resolve [-Pvo] [-s <bufsize>] <logical> <path>
>>
>>           resolve paths to all files at given *logical* address in the linear filesystem space
>>
>> +        User should make sure *path* is the mount point of the top-level
>> +        subvolume (subvolid 5).
>> +
>>           ``Options``
>>
>>           -P
>> diff --git a/cmds/inspect.c b/cmds/inspect.c
>> index 20f433b9..dc0e587f 100644
>> --- a/cmds/inspect.c
>> +++ b/cmds/inspect.c
>> @@ -158,6 +158,9 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
>>          int ret;
>>          int fd;
>>          int i;
>> +       const char *top_subvol = "/";
>> +       const char *top_subvolid = "5";
>> +       char *mounted = NULL;
>>          bool getpath = true;
>>          int bytes_left;
>>          struct btrfs_ioctl_logical_ino_args loi = { 0 };
>> @@ -216,6 +219,23 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
>>                  goto out;
>>          }
>>
>> +       /*
>> +        * For logical-resolve, we want the mount point to be top level
>> +        * subvolume (5), so that we can access all subvolumes.
>> +        */
>> +       ret = find_mount_fsroot(top_subvol, top_subvolid, &mounted);
>> +       if (ret) {
>> +               error("failed to parse mountinfo");
>> +               goto out;
>> +       }
>> +       if (!mounted) {
>> +               ret = -ENOENT;
>> +               error("mount point \"%s\" is not the top-level subvolume",
>> +                     argv[optind + 1]);
>> +               goto out;
>> +       }
>> +       free(mounted);
>> +
>>          ret = ioctl(fd, request, &loi);
>>          if (ret < 0) {
>>                  error("logical ino ioctl: %m");
>> @@ -258,39 +278,7 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
>>                                  path_fd = fd;
>>                                  strncpy(mount_path, full_path, PATH_MAX);
>>                          } else {
>> -                               char *mounted = NULL;
>> -                               char subvol[PATH_MAX];
>> -                               char subvolid[PATH_MAX];
>> -
>> -                               /*
>> -                                * btrfs_subvolid_resolve returns the full
>> -                                * path to the subvolume pointed by root, but the
>> -                                * subvolume can be mounted in a directory name
>> -                                * different from the subvolume name. In this
>> -                                * case we need to find the correct mount point
>> -                                * using same subvolume path and subvol id found
>> -                                * before.
>> -                                */
>> -
>> -                               snprintf(subvol, PATH_MAX, "/%s", name);
>> -                               snprintf(subvolid, PATH_MAX, "%llu", root);
>> -
>> -                               ret = find_mount_fsroot(subvol, subvolid, &mounted);
>> -
>> -                               if (ret) {
>> -                                       error("failed to parse mountinfo");
>> -                                       goto out;
>> -                               }
>> -
>> -                               if (!mounted) {
>> -                                       printf(
>> -                       "inode %llu subvol %s could not be accessed: not mounted\n",
>> -                                               inum, name);
>> -                                       continue;
>> -                               }
>> -
>> -                               strncpy(mount_path, mounted, PATH_MAX);
>> -                               free(mounted);
>> +                               snprintf(mount_path, PATH_MAX, "%s%s", full_path, name);
>>
>>                                  path_fd = btrfs_open_dir(mount_path, &dirs, 1);
>>                                  if (path_fd < 0) {
>> diff --git a/tests/misc-tests/042-inspect-internal-logical-resolve/test.sh b/tests/misc-tests/042-inspect-internal-logical-resolve/test.sh
>> index 2ba7331e..d20d5f74 100755
>> --- a/tests/misc-tests/042-inspect-internal-logical-resolve/test.sh
>> +++ b/tests/misc-tests/042-inspect-internal-logical-resolve/test.sh
>> @@ -51,34 +51,9 @@ run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot "$TEST_MNT/@/vol1/subvol1
>>
>>   run_check "$TOP/btrfs" filesystem sync "$TEST_MNT"
>>
>> -run_check_umount_test_dev
>> -
>> -run_check $SUDO_HELPER mount -o subvol=/@/vol1 "$TEST_DEV" "$TEST_MNT"
>> -# Create a bind mount to vol1. logical-resolve should avoid bind mounts,
>> -# otherwise the test will fail
>> -run_check $SUDO_HELPER mkdir -p "$TEST_MNT/dir"
>> -run_check mkdir -p mnt2
>> -run_check $SUDO_HELPER mount --bind "$TEST_MNT/dir" mnt2
>> -# Create another bind mount to confuse logical-resolve even more.
>> -# logical-resolve can return the original mount or mnt3, both are valid
>> -run_check mkdir -p mnt3
>> -run_check $SUDO_HELPER mount --bind "$TEST_MNT" mnt3
>> -
>>   for offset in $("$TOP/btrfs" inspect-internal dump-tree -t "$vol1id" "$TEST_DEV" |
>>                  awk '/disk byte/ { print $5 }'); do
>>          check_logical_offset_filename "$offset"
>>   done
>>
>> -run_check_umount_test_dev mnt3
>> -run_check rmdir -- mnt3
>> -run_check_umount_test_dev mnt2
>> -run_check rmdir -- mnt2
>> -run_check_umount_test_dev
>> -
>> -run_check $SUDO_HELPER mount -o subvol="/@/vol1/subvol1" "$TEST_DEV" "$TEST_MNT"
>> -for offset in $("$TOP/btrfs" inspect-internal dump-tree -t "$subvol1id" "$TEST_DEV" |
>> -               awk '/disk byte/ { print $5 }'); do
>> -       check_logical_offset_filename "$offset"
>> -done
>> -
>>   run_check_umount_test_dev
>> --
>> 2.39.0
>>
