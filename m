Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85C032C7BA
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2019 15:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfE1NYZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 May 2019 09:24:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:46918 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726924AbfE1NYZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 May 2019 09:24:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CEFEFAF8A;
        Tue, 28 May 2019 13:24:22 +0000 (UTC)
Subject: Re: [PATCH] fstests: generic/260: Make it handle btrfs more
 gracefully
To:     Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190528081859.6203-1-wqu@suse.com>
 <5b41fcb4-ab2d-65b7-f43c-b67919347b0c@suse.com>
From:   Qu Wenruo <wqu@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=wqu@suse.de; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0F1F1IFdlbnJ1byA8d3F1QHN1c2UuZGU+iQFUBBMBCAA+AhsDBQsJCAcCBhUICQoLAgQW
 AgMBAh4BAheAFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlnVgp0FCQlmAm4ACgkQwj2R86El
 /qilmgf/cUq9kFQo577ku5gc6rFpVg68ublBwjYpwjw0b//xo+Wo1wm+RRbUGs+djSZAqw12
 D4F3r0mBTI7abUCNWAbFkYZSAIFVi0DMkjypIVS7PSaEt04rM9VBTToE+YqU6WENeJ57R2p2
 +hI0wZrBwxObdsdaOtxWtsp3bmhIbdqxSKrtXuRawy4KnQYcLuGzOce9okdlbAE0W3KHm1gQ
 oNAe6FX8nC9qo14m8LqEbThYH+qj4iCMlN8HIfbSx4F3e7nHZ+UAMW+E/lnMRkIB9Df+JyVd
 /NlXzIjZAggcWsqpx6D4wyAuexKWkiGQeUeArUNihAwXjmyqWPGmjVyIh+oC6LkBDQRZ1YGv
 AQgAqlPrYeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4K
 Xk/kHw5hieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T
 7RZwB69uVSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9
 fNN8e9c0MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD
 /dt76Kp/o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgB
 CAAmFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlnVga8CGwwFCQPCZwAACgkQwj2R86El/qgN
 8Qf+M0vM2Idwm5txZZSs+/kSgcPxEwYmxUinnUJGyc0ZWYQXPl0cBetZon9El0naijGzNWvf
 HxIPB+ZFehk6Otgc78p1a3/xck/s1myFRLrmbbTJNoFiyL25ljcq0J8z5Zp4yuABL2RiLdaZ
 Pt/jfwjBHwGR+QKp6dD2qMrUWf9b7TFzYDMZXzZ2/eoIgtyjEelNBPrIgOFe24iKMjaGjd97
 fJuRcBMHdhUAxvXQF1oRtd83JvYJ5OtwTd8MgkEfl+fo7HwWkuHbzc70L4fFKv2BowqFdaHy
 mId1ijGPGr46tuZ5a4cw/zbaPYx6fJ4sK9tSv/6V1QPNUdqml6hm6pfs6A==
Message-ID: <55e9ff7c-88b3-6762-0e2b-b61fd38d95d4@suse.de>
Date:   Tue, 28 May 2019 21:24:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5b41fcb4-ab2d-65b7-f43c-b67919347b0c@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/5/28 下午8:48, Nikolay Borisov wrote:
> 
> 
> On 28.05.19 г. 11:18 ч., Qu Wenruo wrote:
>> If a filesystem doesn't map its logical address space (normally the
>> bytenr/blocknr returned by fiemap) directly to its devices(s), the
>> following assumptions used in the test case is no longer true:
>> - trim range start beyond the end of fs should fail
>> - trim range start beyond the end of fs with len set should fail
>>
>> Under the following example, even with just one device, btrfs can still
>> trim the fs correctly while breaking above assumption:
>>
>> 0		1G		1.25G
>> |---------------|///////////////|-----------------| <- btrfs logical
>> 		   |				       address space
>>         ------------  mapped as SINGLE
>>         |
>> 0	V	256M
>> |///////////////|			<- device address space
>>
>> Thus trim range start=1G len=256M will cause btrfs to trim the 256M
>> block group, thus return correct result.
>>
>> Furthermore, there is no definitely behavior for whether a fs should
>> trim the unmapped space.
>> Btrfs currently will always trim the unmapped space, but the behavior
>> can change as large trim can be very expensive.
>>
>> Despite the change to skip certain tests for btrfs, still run the
>> following tests for btrfs:
>> - trim start=U64_MAX with lenght set
>>   This will expose a bug that btrfs doesn't check overflow of the range.
>>   This bug will be fixed soon.
>>
>> - trim beyond the end of the fs
>>   This will expose a bug where btrfs could send trim command beyond the
>>   end of its device.
>>   This bug is a regression, can be fixed by reverting c2d1b3aae336 ("btrfs:
>>   Honour FITRIM range constraints during free space trim")
>>
>> With proper fixes for btrfs, this test case should pass on btrfs, ext4,
>> xfs.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  common/rc             | 11 +++++++
>>  tests/generic/260     | 75 ++++++++++++++++++++++++++++---------------
>>  tests/generic/260.out |  9 +-----
>>  3 files changed, 62 insertions(+), 33 deletions(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 17b89d5d..d7a5898f 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -4005,6 +4005,17 @@ _require_fibmap()
>>  	rm -f $file
>>  }
>>  
>> +# Check if the logical address (returned by fiemap) of a fs is 1:1 mapped to
>> +# its underlying fs
> 
> "underlying device" ?

What's the proper expression?

I mean the block device on which the fs lies above.

> 
>> +_is_fs_direct_mapped()
>> +{
>> +	if [ "$FSTYP" == "btrfs" ]; then
>> +		echo "0"
>> +	else
>> +		echo "1"
>> +	fi
>> +}
> 
> Instead of using echo just return 0 or 1 then see below
> 
>> +
>>  _try_wipe_scratch_devs()
>>  {
>>  	test -x "$WIPEFS_PROG" || return 0
>> diff --git a/tests/generic/260 b/tests/generic/260
>> index 9e652dee..452f88c1 100755
>> --- a/tests/generic/260
>> +++ b/tests/generic/260
>> @@ -27,40 +27,51 @@ _supported_fs generic
>>  _supported_os Linux
>>  _require_math
>>  
>> +rm -f $seqres.full
>> +
>>  _require_scratch
>>  _scratch_mkfs >/dev/null 2>&1
>>  _scratch_mount
>>  
>>  _require_batched_discard $SCRATCH_MNT
>>  
>> +
>>  fssize=$($DF_PROG -k | grep "$SCRATCH_MNT" | grep "$SCRATCH_DEV"  | awk '{print $3}')
>>  
>>  beyond_eofs=$(_math "$fssize*2048")
>>  max_64bit=$(_math "2^64 - 1")
>>  
>> -# All these tests should return EINVAL
>> -# since the start is beyond the end of
>> -# the file system
>> -
>> -echo "[+] Start beyond the end of fs (should fail)"
>> -out=$($FSTRIM_PROG -o $beyond_eofs $SCRATCH_MNT 2>&1)
>> -[ $? -eq 0 ] && status=1
>> -echo $out | _filter_scratch
>> -
>> -echo "[+] Start beyond the end of fs with len set (should fail)"
>> -out=$($FSTRIM_PROG -o $beyond_eofs -l1M $SCRATCH_MNT 2>&1)
>> -[ $? -eq 0 ] && status=1
>> -echo $out | _filter_scratch
>> -
>> -echo "[+] Start = 2^64-1 (should fail)"
>> -out=$($FSTRIM_PROG -o $max_64bit $SCRATCH_MNT 2>&1)
>> -[ $? -eq 0 ] && status=1
>> -echo $out | _filter_scratch
>> +# For filesystem with direct mapping, all these tests should return EINVAL
>> +# since the start is beyond the end of the file system
>> +#
>> +# Skip these tests if the filesystem has its own address space mapping,
>> +# as it's implementation dependent.
>> +# E.g btrfs can map its physical address of (devid=1, physical=1M, len=1M)
>> +# and (devid=2, physical=2M, len=1M) combined as RAID1, and mapped to its
>> +# address space (logical=1G, len=1M), thus making trim beyond the end of
>> +# fs (device) meaningless.
>> +
>> +echo "[+] Optional trim range test (fs dependent)"
>> +if [ $(_is_fs_direct_mapped) -eq 1 ]; then
> 
> this check is rather ugly, instead if you return 0 on success (i.e it's
> directly mapped) it can be rewritten simply as:
> 
> if is_fs_direct_mapped; then
> 
> which is a lot cleaner than the $() fuckery

I tried that before reverting back to the echo one.

The biggest concern is, "return 0" is completely OK for regular
functions which does some work.
But for bool return, especially for case like this _is_xxx function,
return 0 for true is really confusing.

Or this is just the preferred way in bash?

> 
>> +	echo "[+] Start beyond the end of fs (should fail)" >> $seqres.full
>> +	$FSTRIM_PROG -o $beyond_eofs $SCRATCH_MNT >> $seqres.full 2>&1
>> +	[ $? -eq 0 ] && status=1
>> +
>> +	echo "[+] Start beyond the end of fs with len set (should fail)" >> $seqres.full
>> +	$FSTRIM_PROG -o $beyond_eofs -l1M $SCRATCH_MNT >> $seqres.full 2>&1
>> +	[ $? -eq 0 ] && status=1
>> +
>> +	# indirectly mapped fs may use this special value to trim their
>> +	# unmapped space, so don't do this for indirectly mapped fs.
>> +	echo "[+] Start = 2^64-1 (should fail)" >> $seqres.full
>> +	$FSTRIM_PROG -o $max_64bit $SCRATCH_MNT 2>&1 >> $seqres.full 2>&1
>> +	[ $? -eq 0 ] && status=1
>> +fi
>>  
>> -echo "[+] Start = 2^64-1 and len is set (should fail)"
>> -out=$($FSTRIM_PROG -o $max_64bit -l1M $SCRATCH_MNT 2>&1)
>> +# This should fail due to overflow no matter how the fs is implemented
>> +echo "[+] Start = 2^64-1 and len is set (should fail)" >> $seqres.full
>> +$FSTRIM_PROG -o $max_64bit -l1M $SCRATCH_MNT >> $seqres.full 2>&1
>>  [ $? -eq 0 ] && status=1
>> -echo $out | _filter_scratch
>>  
>>  _scratch_unmount
>>  _scratch_mkfs >/dev/null 2>&1
>> @@ -86,10 +97,12 @@ _scratch_unmount
>>  _scratch_mkfs >/dev/null 2>&1
>>  _scratch_mount
>>  
>> +echo "[+] Trim an empty fs" >> $seqres.full
>>  # This is a bit fuzzy, but since the file system is fresh
>>  # there should be at least (fssize/2) free space to trim.
>>  # This is supposed to catch wrong FITRIM argument handling
>>  bytes=$($FSTRIM_PROG -v -o10M $SCRATCH_MNT | _filter_fstrim)
>> +echo "$bytes trimed" >> $seqres.full
> 
> Does it bring any value printing those strings in seqres.full given the
> output of the executed command won't be there. I think not.

When something went wrong, like no bytes get trimmed but still return 0,
then this is definitely valuable.

BTW, there are cases btrfs trimmed just 0 bytes. And it's the same command.
To me, this can't be more valuable.

In fact, I even considered to check $bytes to make the btrfs failure
more explicit.

Thanks,
Qu

> 
>>  
>>  if [ $bytes -gt $(_math "$fssize*1024") ]; then
>>  	status=1
>> @@ -101,7 +114,7 @@ fi
>>  # It is because btrfs does not have not-yet-used parts of the device
>>  # mapped and since we got here right after the mkfs, there is not
>>  # enough free extents in the root tree.
>> -if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ]; then
>> +if [ $bytes -le $(_math "$fssize*512") ] && [ $(_is_fs_direct_mapped) -eq 1 ]; then
> 
> same thing here - make is_fs_direct_mapped plain 'return 0/1' and check
> its ret val directly.
> 
>>  	status=1
>>  	echo "After the full fs discard $bytes bytes were discarded"\
>>  	     "however the file system is $(_math "$fssize*1024") bytes long."
>> @@ -141,14 +154,24 @@ esac
>>  _scratch_unmount
>>  _scratch_mkfs >/dev/null 2>&1
>>  _scratch_mount
>> +
>> +echo "[+] Try to trim beyond the end of the fs" >> $seqres.full
>>  # It should fail since $start is beyond the end of file system
>> -$FSTRIM_PROG -o$start -l10M $SCRATCH_MNT &> /dev/null
>> -if [ $? -eq 0 ]; then
>> +$FSTRIM_PROG -o$start -l10M $SCRATCH_MNT >> $seqres.full 2>&1
>> +ret=$?
>> +if [ $ret -eq 0 ] && [ $(_is_fs_direct_mapped) -eq 1 ]; then
>>  	status=1
>>  	echo "It seems that fs logic handling start"\
>>  	     "argument overflows"
>>  fi
>>  
>> +# For indirectly mapped fs, it shouldn't fail.
>> +# Btrfs will fail due to a bug in boundary check
>> +if [ $ret -ne 0 ] && [ $(_is_fs_direct_mapped) -eq 0 ]; then
>> +	status=1
>> +	echo "Unexpected error happened during trim"
>> +fi
>> +
>>  _scratch_unmount
>>  _scratch_mkfs >/dev/null 2>&1
>>  _scratch_mount
>> @@ -160,8 +183,10 @@ _scratch_mount
>>  # It is because btrfs does not have not-yet-used parts of the device
>>  # mapped and since we got here right after the mkfs, there is not
>>  # enough free extents in the root tree.
>> +echo "[+] Try to trim the fs with large enough len" >> $seqres.full
>>  bytes=$($FSTRIM_PROG -v -l$len $SCRATCH_MNT | _filter_fstrim)
>> -if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ]; then
>> +echo "$bytes trimed" >> $seqres.full
>> +if [ $bytes -le $(_math "$fssize*512") ] && [ $(_is_fs_direct_mapped) == 1 ]; then
>>  	status=1
>>  	echo "It seems that fs logic handling len argument overflows"
>>  fi
>> diff --git a/tests/generic/260.out b/tests/generic/260.out
>> index a16c4f74..f4ee2f72 100644
>> --- a/tests/generic/260.out
>> +++ b/tests/generic/260.out
>> @@ -1,12 +1,5 @@
>>  QA output created by 260
>> -[+] Start beyond the end of fs (should fail)
>> -fstrim: SCRATCH_MNT: FITRIM ioctl failed: Invalid argument
>> -[+] Start beyond the end of fs with len set (should fail)
>> -fstrim: SCRATCH_MNT: FITRIM ioctl failed: Invalid argument
>> -[+] Start = 2^64-1 (should fail)
>> -fstrim: SCRATCH_MNT: FITRIM ioctl failed: Invalid argument
>> -[+] Start = 2^64-1 and len is set (should fail)
>> -fstrim: SCRATCH_MNT: FITRIM ioctl failed: Invalid argument
>> +[+] Optional trim range test (fs dependent)
>>  [+] Default length (should succeed)
>>  [+] Default length with start set (should succeed)
>>  [+] Length beyond the end of fs (should succeed)
>>
