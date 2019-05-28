Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5241A2C80C
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2019 15:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfE1NpJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 May 2019 09:45:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:54538 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727090AbfE1NpJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 May 2019 09:45:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 49975AFE0;
        Tue, 28 May 2019 13:45:07 +0000 (UTC)
Subject: Re: [PATCH] fstests: generic/260: Make it handle btrfs more
 gracefully
To:     Qu Wenruo <wqu@suse.de>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190528081859.6203-1-wqu@suse.com>
 <5b41fcb4-ab2d-65b7-f43c-b67919347b0c@suse.com>
 <55e9ff7c-88b3-6762-0e2b-b61fd38d95d4@suse.de>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <79c284b4-2fc6-e8b0-66c3-49215ca70267@suse.com>
Date:   Tue, 28 May 2019 16:45:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <55e9ff7c-88b3-6762-0e2b-b61fd38d95d4@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28.05.19 г. 16:24 ч., Qu Wenruo wrote:
> 
> 
> On 2019/5/28 下午8:48, Nikolay Borisov wrote:
>>
>>
>> On 28.05.19 г. 11:18 ч., Qu Wenruo wrote:
>>> If a filesystem doesn't map its logical address space (normally the
>>> bytenr/blocknr returned by fiemap) directly to its devices(s), the
>>> following assumptions used in the test case is no longer true:
>>> - trim range start beyond the end of fs should fail
>>> - trim range start beyond the end of fs with len set should fail
>>>
>>> Under the following example, even with just one device, btrfs can still
>>> trim the fs correctly while breaking above assumption:
>>>
>>> 0		1G		1.25G
>>> |---------------|///////////////|-----------------| <- btrfs logical
>>> 		   |				       address space
>>>         ------------  mapped as SINGLE
>>>         |
>>> 0	V	256M
>>> |///////////////|			<- device address space
>>>
>>> Thus trim range start=1G len=256M will cause btrfs to trim the 256M
>>> block group, thus return correct result.
>>>
>>> Furthermore, there is no definitely behavior for whether a fs should
>>> trim the unmapped space.
>>> Btrfs currently will always trim the unmapped space, but the behavior
>>> can change as large trim can be very expensive.
>>>
>>> Despite the change to skip certain tests for btrfs, still run the
>>> following tests for btrfs:
>>> - trim start=U64_MAX with lenght set
>>>   This will expose a bug that btrfs doesn't check overflow of the range.
>>>   This bug will be fixed soon.
>>>
>>> - trim beyond the end of the fs
>>>   This will expose a bug where btrfs could send trim command beyond the
>>>   end of its device.
>>>   This bug is a regression, can be fixed by reverting c2d1b3aae336 ("btrfs:
>>>   Honour FITRIM range constraints during free space trim")
>>>
>>> With proper fixes for btrfs, this test case should pass on btrfs, ext4,
>>> xfs.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>  common/rc             | 11 +++++++
>>>  tests/generic/260     | 75 ++++++++++++++++++++++++++++---------------
>>>  tests/generic/260.out |  9 +-----
>>>  3 files changed, 62 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/common/rc b/common/rc
>>> index 17b89d5d..d7a5898f 100644
>>> --- a/common/rc
>>> +++ b/common/rc
>>> @@ -4005,6 +4005,17 @@ _require_fibmap()
>>>  	rm -f $file
>>>  }
>>>  
>>> +# Check if the logical address (returned by fiemap) of a fs is 1:1 mapped to
>>> +# its underlying fs
>>
>> "underlying device" ?
> 
> What's the proper expression?
> 
> I mean the block device on which the fs lies above.

I got confused by the "of a fs is 1:1 mapped to its underlying fs" this
seems to have tautology and I gathered you meant if the extents as
returned by fiemap of a fs are 1:1 mapped to the underlying device that
the fs sits on ?


<snip>

>>
>> this check is rather ugly, instead if you return 0 on success (i.e it's
>> directly mapped) it can be rewritten simply as:
>>
>> if is_fs_direct_mapped; then
>>
>> which is a lot cleaner than the $() fuckery
> 
> I tried that before reverting back to the echo one.
> 
> The biggest concern is, "return 0" is completely OK for regular
> functions which does some work.
> But for bool return, especially for case like this _is_xxx function,
> return 0 for true is really confusing.
> 
> Or this is just the preferred way in bash?

This is the the unix convention - 0 indicates success,
http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html

And https://www.tldp.org/LDP/abs/html/exit-status.html re. exit statuses.

> 
>>
>>> +	echo "[+] Start beyond the end of fs (should fail)" >> $seqres.full
>>> +	$FSTRIM_PROG -o $beyond_eofs $SCRATCH_MNT >> $seqres.full 2>&1
>>> +	[ $? -eq 0 ] && status=1
>>> +
>>> +	echo "[+] Start beyond the end of fs with len set (should fail)" >> $seqres.full
>>> +	$FSTRIM_PROG -o $beyond_eofs -l1M $SCRATCH_MNT >> $seqres.full 2>&1
>>> +	[ $? -eq 0 ] && status=1
>>> +
>>> +	# indirectly mapped fs may use this special value to trim their
>>> +	# unmapped space, so don't do this for indirectly mapped fs.
>>> +	echo "[+] Start = 2^64-1 (should fail)" >> $seqres.full
>>> +	$FSTRIM_PROG -o $max_64bit $SCRATCH_MNT 2>&1 >> $seqres.full 2>&1
>>> +	[ $? -eq 0 ] && status=1
>>> +fi
>>>  
>>> -echo "[+] Start = 2^64-1 and len is set (should fail)"
>>> -out=$($FSTRIM_PROG -o $max_64bit -l1M $SCRATCH_MNT 2>&1)
>>> +# This should fail due to overflow no matter how the fs is implemented
>>> +echo "[+] Start = 2^64-1 and len is set (should fail)" >> $seqres.full
>>> +$FSTRIM_PROG -o $max_64bit -l1M $SCRATCH_MNT >> $seqres.full 2>&1
>>>  [ $? -eq 0 ] && status=1
>>> -echo $out | _filter_scratch
>>>  
>>>  _scratch_unmount
>>>  _scratch_mkfs >/dev/null 2>&1
>>> @@ -86,10 +97,12 @@ _scratch_unmount
>>>  _scratch_mkfs >/dev/null 2>&1
>>>  _scratch_mount
>>>  
>>> +echo "[+] Trim an empty fs" >> $seqres.full
>>>  # This is a bit fuzzy, but since the file system is fresh
>>>  # there should be at least (fssize/2) free space to trim.
>>>  # This is supposed to catch wrong FITRIM argument handling
>>>  bytes=$($FSTRIM_PROG -v -o10M $SCRATCH_MNT | _filter_fstrim)
>>> +echo "$bytes trimed" >> $seqres.full
>>
>> Does it bring any value printing those strings in seqres.full given the
>> output of the executed command won't be there. I think not.
> 
> When something went wrong, like no bytes get trimmed but still return 0,
> then this is definitely valuable.
> 
> BTW, there are cases btrfs trimmed just 0 bytes. And it's the same command.
> To me, this can't be more valuable.
> 
> In fact, I even considered to check $bytes to make the btrfs failure
> more explicit.

Fair enough but perhaps you can make

echo -n "Trim an empty fs" >> $seqres.full

exec commands

echo "$bytes trimmed". That way  there is going to be a single line
only. Anyway this is a nit so feel free to ignore.
> 
> Thanks,
> Qu
> 
>>
>>>  
>>>  if [ $bytes -gt $(_math "$fssize*1024") ]; then
>>>  	status=1
>>> @@ -101,7 +114,7 @@ fi
>>>  # It is because btrfs does not have not-yet-used parts of the device
>>>  # mapped and since we got here right after the mkfs, there is not
>>>  # enough free extents in the root tree.
>>> -if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ]; then
>>> +if [ $bytes -le $(_math "$fssize*512") ] && [ $(_is_fs_direct_mapped) -eq 1 ]; then
>>
>> same thing here - make is_fs_direct_mapped plain 'return 0/1' and check
>> its ret val directly.
>>
>>>  	status=1
>>>  	echo "After the full fs discard $bytes bytes were discarded"\
>>>  	     "however the file system is $(_math "$fssize*1024") bytes long."
>>> @@ -141,14 +154,24 @@ esac
>>>  _scratch_unmount
>>>  _scratch_mkfs >/dev/null 2>&1
>>>  _scratch_mount
>>> +
>>> +echo "[+] Try to trim beyond the end of the fs" >> $seqres.full
>>>  # It should fail since $start is beyond the end of file system
>>> -$FSTRIM_PROG -o$start -l10M $SCRATCH_MNT &> /dev/null
>>> -if [ $? -eq 0 ]; then
>>> +$FSTRIM_PROG -o$start -l10M $SCRATCH_MNT >> $seqres.full 2>&1
>>> +ret=$?
>>> +if [ $ret -eq 0 ] && [ $(_is_fs_direct_mapped) -eq 1 ]; then
>>>  	status=1
>>>  	echo "It seems that fs logic handling start"\
>>>  	     "argument overflows"
>>>  fi
>>>  
>>> +# For indirectly mapped fs, it shouldn't fail.
>>> +# Btrfs will fail due to a bug in boundary check
>>> +if [ $ret -ne 0 ] && [ $(_is_fs_direct_mapped) -eq 0 ]; then
>>> +	status=1
>>> +	echo "Unexpected error happened during trim"
>>> +fi
>>> +
>>>  _scratch_unmount
>>>  _scratch_mkfs >/dev/null 2>&1
>>>  _scratch_mount
>>> @@ -160,8 +183,10 @@ _scratch_mount
>>>  # It is because btrfs does not have not-yet-used parts of the device
>>>  # mapped and since we got here right after the mkfs, there is not
>>>  # enough free extents in the root tree.
>>> +echo "[+] Try to trim the fs with large enough len" >> $seqres.full
>>>  bytes=$($FSTRIM_PROG -v -l$len $SCRATCH_MNT | _filter_fstrim)
>>> -if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ]; then
>>> +echo "$bytes trimed" >> $seqres.full
>>> +if [ $bytes -le $(_math "$fssize*512") ] && [ $(_is_fs_direct_mapped) == 1 ]; then
>>>  	status=1
>>>  	echo "It seems that fs logic handling len argument overflows"
>>>  fi
>>> diff --git a/tests/generic/260.out b/tests/generic/260.out
>>> index a16c4f74..f4ee2f72 100644
>>> --- a/tests/generic/260.out
>>> +++ b/tests/generic/260.out
>>> @@ -1,12 +1,5 @@
>>>  QA output created by 260
>>> -[+] Start beyond the end of fs (should fail)
>>> -fstrim: SCRATCH_MNT: FITRIM ioctl failed: Invalid argument
>>> -[+] Start beyond the end of fs with len set (should fail)
>>> -fstrim: SCRATCH_MNT: FITRIM ioctl failed: Invalid argument
>>> -[+] Start = 2^64-1 (should fail)
>>> -fstrim: SCRATCH_MNT: FITRIM ioctl failed: Invalid argument
>>> -[+] Start = 2^64-1 and len is set (should fail)
>>> -fstrim: SCRATCH_MNT: FITRIM ioctl failed: Invalid argument
>>> +[+] Optional trim range test (fs dependent)
>>>  [+] Default length (should succeed)
>>>  [+] Default length with start set (should succeed)
>>>  [+] Length beyond the end of fs (should succeed)
>>>
