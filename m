Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD0A655D42
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Dec 2022 13:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiLYM6P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Dec 2022 07:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYM6N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Dec 2022 07:58:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC89C267E;
        Sun, 25 Dec 2022 04:58:11 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgvvT-1odxIm1P9J-00hNVB; Sun, 25
 Dec 2022 13:58:06 +0100
Message-ID: <3873483f-c396-817f-cc97-263b6c1371e3@gmx.com>
Date:   Sun, 25 Dec 2022 20:58:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To:     Zorro Lang <zlang@redhat.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20221223025642.33496-1-wqu@suse.com>
 <20221225115146.t2y4adfguq2qtg74@zlang-mailbox>
 <8f58bb60-edb7-5bb8-ac6e-01df06593d95@suse.com>
 <20221225125049.nczymsopzbzrwfbm@zlang-mailbox>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs/154: migrate to python3
In-Reply-To: <20221225125049.nczymsopzbzrwfbm@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9Ybzr+oimglmL18tNLV8Q34dcyr8wlulK412aOa7uzeCF1AyyJw
 WSDPFRaMkJGLFjjPEBDPxeyPLEh/dKJwI36gA5qucYExIivgzKAaVTO8R+qx/9L+H4bZNq4
 XG7SKr3DW5PWk7HRRcw5BhZOq3cCycSwbfM882Vd0MN5afkLmfPzchSNQsneNI68q4GTm1J
 UDsz1FBVMyHHZ3OBovUDQ==
UI-OutboundReport: notjunk:1;M01:P0:/okOovcnT1M=;IJXNktL6zbPmBuQMay20pIGW2WP
 /iGHa3LYYBvFQtN5FPHekGOIsdkm5FUy6OvCEX2hW3Ovx25AZEQ4v2RNVhNUgaESruQyFSVjl
 YVDzpuE0qhNLIgGzBv8cSkudJMRpvG3pAJz9KwJvo0ddhihEQfD7Mr4SgrCQ+CamHCrEp+T8D
 ebM4JpLMULTAN1Jfm/UaNQ0r2gfgbnb6QigfYohoQLFx9WRa1gn9GZWexX9TI/DEx9OtD+L6J
 Dw/8M8Uo5GvjYZ/Y8DlwkJXMHOBuoh1Jza8epB8JZZCschGRJ+GPfsWppvxy6TyiCMbrsFNVn
 Pq8HTauRybkhrg24ZGlT6RJIbgAg6e0I3j10+Ts09k59uWt6A/a1qO1SqMhJRlLqOx40XAYa/
 BVnyQuVFtE+au+XzXLvCgAZk9F1QLK38addEZy4E2yx/JHvKhbyekkyopXESZAfnEWVt4Xlbe
 WL8x5osg343v+OZru2e3Ehv8Ji26K4qSqEbp6zp6nI9VoIGvgt4Zo9L2J1vClZw4u92teOlTY
 MtG6Tha4Q9aHTY5U56OQGlXgJv2XYSoRv5RRXYkpZkd2ZHYrw6HMnkBw58fZhXUuLGz3TeVhU
 nAt2suqA9pmaIkzNUjXuJYntg0SW0Cwxno2PjSISf7GTyrVUMJ3GufmZ5qKhhWfHvxhAa6usq
 6N44VkpiAyYTVggc4rb5TNntNGLT5KjI5IBN8zNQP25/wA40DgNroWY4QKawx5Ky5siTYf5T/
 co95Q0KKfDVA5M33KA1FGWlq6+N9tSIoMxaFJJ8vno45d+tM/yoabtJpyY1bQBQ1kvsFs/NV0
 WYnNODKoQ0IFEAxlqgieMAyYXEKB5+iACQbFEqAymv7y9Gi4h7juqhtbIlqHC6BRnBjyjqW7O
 BsuSEAEBAi/aOA45bDwSrDeYSrUN2v3Sd3M9xV8KxekX1P3/PFZQhOGGflguotnUlruZ597MG
 Fwxy002WiitZLdO59oSzglVvmGo=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/25 20:50, Zorro Lang wrote:
> On Sun, Dec 25, 2022 at 08:11:02PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/12/25 19:51, Zorro Lang wrote:
>>> On Fri, Dec 23, 2022 at 10:56:42AM +0800, Qu Wenruo wrote:
>>>> Test case btrfs/154 is still using python2 script, which is already EOL.
>>>> Some rolling distros like Archlinux is no longer providing python2
>>>> package anymore.
>>>>
>>>> This means btrfs/154 will be harder and harder to run.
>>>>
>>>> To fix the problem, migreate the python script to python3, this involves
>>>> the following changes:
>>>>
>>>> - Change common/config to use python3
>>>> - Strong type conversion between string and bytes
>>>>     This means, anything involved in the forged bytes has to be bytes.
>>>>
>>>>     And there is no safe way to convert forged bytes into string, unlike
>>>>     python2.
>>>>     I guess that's why the author went python2 in the first place.
>>>>
>>>>     Thankfully os.rename() still accepts forged bytes.
>>>>
>>>> - Use bytes specific checks for invalid chars.
>>>>
>>>> The updated script can still cause the needed conflicts, can be verified
>>>> through "btrfs ins dump-tree" command.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>    common/config                   |  2 +-
>>>>    src/btrfs_crc32c_forged_name.py | 22 ++++++++++++++++------
>>>>    tests/btrfs/154                 |  4 ++--
>>>>    3 files changed, 19 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/common/config b/common/config
>>>> index b2802e5e..e2aba5a9 100644
>>>> --- a/common/config
>>>> +++ b/common/config
>>>> @@ -212,7 +212,7 @@ export NFS4_SETFACL_PROG="$(type -P nfs4_setfacl)"
>>>>    export NFS4_GETFACL_PROG="$(type -P nfs4_getfacl)"
>>>>    export UBIUPDATEVOL_PROG="$(type -P ubiupdatevol)"
>>>>    export THIN_CHECK_PROG="$(type -P thin_check)"
>>>> -export PYTHON2_PROG="$(type -P python2)"
>>>> +export PYTHON3_PROG="$(type -P python3)"
>>>
>>> How about:
>>>
>>> export PYTHON_PROG="$(type -P python)"
>>> export PYTHON2_PROG="$(type -P python2)"
>>> export PYTHON3_PROG="$(type -P python3)"
>>>
>>> maybe someone still need python2, or maybe someone doesn't care the version.
>>
>> Even for distros which completely get rid of python2 and make python3
>> default, there is still python3.
>> And python is just a softlink to python3, which further links to the real
>> python
>>
>>   $ type -P python2
>>   $ type -P python3
>>   /usr/bin/python3
>>   $ type -P python
>>   /usr/bin/python
>>
>>   $ ls -alh /usr/bin/python
>>   lrwxrwxrwx 1 root root 7 Nov  1 22:18 /usr/bin/python -> python3
>>   $ ls -alh /usr/bin/python3
>>   lrwxrwxrwx 1 root root 10 Nov  1 22:18 /usr/bin/python3 -> python3.10
>>
>> Secondly, for this particular case, we must distinguish python2 and python3,
>> especially due to the strong requirement for string encoding.
>>
>>
>> So to your PYTHON_PROG usage, no, it's not good at all, it's going to be
>> distro dependent and will be a disaster if some one is using PYTHON_PROG.
>>
>> For PYTHON2_PROG, there is no usage of it any more, thus I see now reason to
>> define it.
> 
> OK, due to only btrfs/154 uses this PYTHON?_PROG thing now, we can talk about
> that later. This patch looks good to me.

In fact, I'd prefer to use C to do the CRC32C hash conflicts, especially 
considering how hard it is already in python3 to parse any invalid bytes.

(And some other weird behaviors, like using hard coded filename name 
lengh 89, which later converts to hex string and has to get rid of 
invalid chars like \0 and \/)

But that would be another (small) project to go.
Until then, let's keep the single (and bad example) python3.

Thanks,
Qu
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
>>
>> Thanks,
>> Qu
>>>
>>> Thanks,
>>> Zorro
>>>
>>>>    export SQLITE3_PROG="$(type -P sqlite3)"
>>>>    export TIMEOUT_PROG="$(type -P timeout)"
>>>>    export SETCAP_PROG="$(type -P setcap)"
>>>> diff --git a/src/btrfs_crc32c_forged_name.py b/src/btrfs_crc32c_forged_name.py
>>>> index 6c08fcb7..d29bbb70 100755
>>>> --- a/src/btrfs_crc32c_forged_name.py
>>>> +++ b/src/btrfs_crc32c_forged_name.py
>>>> @@ -59,9 +59,10 @@ class CRC32(object):
>>>>        # deduce the 4 bytes we need to insert
>>>>        for c in struct.pack('<L',fwd_crc)[::-1]:
>>>>          bkd_crc = ((bkd_crc << 8) & 0xffffffff) ^ self.reverse[bkd_crc >> 24]
>>>> -      bkd_crc ^= ord(c)
>>>> +      bkd_crc ^= c
>>>> -    res = s[:pos] + struct.pack('<L', bkd_crc) + s[pos:]
>>>> +    res = bytes(s[:pos], 'ascii') + struct.pack('<L', bkd_crc) + \
>>>> +          bytes(s[pos:], 'ascii')
>>>>        return res
>>>>      def parse_args(self):
>>>> @@ -72,6 +73,12 @@ class CRC32(object):
>>>>                            help="number of forged names to create")
>>>>        return parser.parse_args()
>>>> +def has_invalid_chars(result: bytes):
>>>> +    for i in result:
>>>> +        if i == 0 or i == int.from_bytes(b'/', byteorder="little"):
>>>> +            return True
>>>> +    return False
>>>> +
>>>>    if __name__=='__main__':
>>>>      crc = CRC32()
>>>> @@ -80,12 +87,15 @@ if __name__=='__main__':
>>>>      args = crc.parse_args()
>>>>      dirpath=args.dir
>>>>      while count < args.count :
>>>> -    origname = os.urandom (89).encode ("hex")[:-1].strip ("\x00")
>>>> +    origname = os.urandom (89).hex()[:-1].strip ("\x00")
>>>>        forgename = crc.forge(wanted_crc, origname, 4)
>>>> -    if ("/" not in forgename) and ("\x00" not in forgename):
>>>> +    if not has_invalid_chars(forgename):
>>>>          srcpath=dirpath + '/' + str(count)
>>>> -      dstpath=dirpath + '/' + forgename
>>>> -      file (srcpath, 'a').close()
>>>> +      # We have to convert all strings to bytes to concatenate the forged
>>>> +      # name (bytes).
>>>> +      # Thankfully os.rename() can accept bytes directly.
>>>> +      dstpath=bytes(dirpath, "ascii") + bytes('/', "ascii") + forgename
>>>> +      open(srcpath, mode="a").close()
>>>>          os.rename(srcpath, dstpath)
>>>>          os.system('btrfs fi sync %s' % (dirpath))
>>>>          count+=1;
>>>> diff --git a/tests/btrfs/154 b/tests/btrfs/154
>>>> index 240c504c..6be2d5f6 100755
>>>> --- a/tests/btrfs/154
>>>> +++ b/tests/btrfs/154
>>>> @@ -21,7 +21,7 @@ _begin_fstest auto quick
>>>>    _supported_fs btrfs
>>>>    _require_scratch
>>>> -_require_command $PYTHON2_PROG python2
>>>> +_require_command $PYTHON3_PROG python3
>>>>    # Currently in btrfs the node/leaf size can not be smaller than the page
>>>>    # size (but it can be greater than the page size). So use the largest
>>>> @@ -42,7 +42,7 @@ _scratch_mount
>>>>    #    ...
>>>>    #
>>>> -$PYTHON2_PROG $here/src/btrfs_crc32c_forged_name.py -d $SCRATCH_MNT -c 310
>>>> +$PYTHON3_PROG $here/src/btrfs_crc32c_forged_name.py -d $SCRATCH_MNT -c 310
>>>>    echo "Silence is golden"
>>>>    # success, all done
>>>> -- 
>>>> 2.39.0
>>>>
>>>
>>
> 
