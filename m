Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E9F543EE1
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 23:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiFHVyq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 17:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiFHVyp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 17:54:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D273B011
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 14:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654725275;
        bh=8wefNPxmauePi1OG6JQk6xGmTZTBtrzoxfQ+bJJqN2A=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=PitBm+yK5y4vQscaHjg6lca0vd2exPgBjKDuzULKr7H0kMZ6Q0gdB6W7Aft9Y2OHi
         hmGR7GbJvIE2UsdQR/r8/97tFAZ3/mJ1cQT1+/cBI0FwImLcn6cEMWBK8hjSsWeRo4
         9qPmd2CulBBrFsaNSKsHqIBVcn+MQDVU4Pa+t4R8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZktj-1oDim530Ip-00WpeN; Wed, 08
 Jun 2022 23:54:35 +0200
Message-ID: <4919754e-045d-9061-27dd-dea61e9e4cef@gmx.com>
Date:   Thu, 9 Jun 2022 05:54:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] btrfs: don't trust any cached sector in
 __raid56_parity_recover()
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <53f7bace2ac75d88ace42dd811d48b7912647301.1654672140.git.wqu@suse.com>
 <20220608094751.GA3603651@falcondesktop>
 <b4a9889a-2c9d-8f74-985b-f0b7b176a1fa@suse.com>
 <CAL3q7H6emgApw9saZ3k7Eb7PDx46=-nLKTRBcYvqXCQ3d=0BVQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL3q7H6emgApw9saZ3k7Eb7PDx46=-nLKTRBcYvqXCQ3d=0BVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1duoMAG+5aBy9KdhDrMz2foVoc3bgzkgO3k4NAlYdsbUf/qGw2K
 fe2FZ8OD7uQ3N+e3XY0MDqqEP0lV6CoZnOr934YqPDTx07zqVtah4rCL2WLtCJy56Nmo+Uw
 lndEceCiHtTAkDxyubPSHwbmDI4znPRTpjJVY+clf3vhP4EvouYN9aVvH4L+MPdsXX/zJfq
 d+1xrSlGTOqnBkoW/gS0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cmE9VLez57U=:g1nXmc690aW+At79FRYTYC
 RfG9T6qJB+Hpw0rFEvIy2fQ5W/loo0f2V0Fy24U3LRCkeaBp7nub7HzMb9QL3qXDHoUZm5H0k
 btqy58sd0cZp4JgLJUNKsMNFiMAwHTAOVtZosY+kN3Cur14trksn058PZmzyMJyDlZettjp1q
 795KgERbC9UNjVP4T5EC2d48o+vmjrAnbXfYqNhU4BYqFVo/g/seOiDi1zwZyULDsvWohOcAy
 JjYmE652CjldC9r38899QOu+FGSarA/H0C03yEo218DzSE7+3en+3qwbcotmzK8yUHDUCg/L9
 v/IXsm5j7aHKXqC0KcN69rq7gTHzxkn7Ez5pkW/WGtnkPTpkhjt8Ra1c7dANWafpf6RhTXczJ
 VSRt4XZh61dlEBPN09S/++RKi2w1FzxH9RNxp4m37eNPXGfeW8eFTIL3wsPZYIF7uNgVAZWDq
 wIcRgkHNlQjZaeGDTcp1dV7Iz1IvAgqWpS1gjXv6ix0xcfMrLfJMfu5epLYXTd8ISC+3frBti
 eBBnZR5V432sdRcfN/pMDX9DlyB54aW1rj0OtxOEHf8HlFM51G736AsPP0cPctc6NhQOkfLcQ
 BN1hKc6gYgAL+Hso8Ptjt542aM5u7J0o6mP5fMEeniz0ruqVkrOp1hN1c6AQDusdi7NH/n4ci
 Gmkp1q02eF1HK2UScb9/4mV0AELG94pUWccqyi3+eyCPfvkuvLQPEniQLUY4aYFPbzso7RSZX
 7ZbXGuNtDHXZieKTmw7fz21/3+A9AaeluHjLwghrbcQ5tRzxZirSZMP/iyF7hnGjeKV0Mv0fT
 rnGF47FEWSXqC1B+9GfnaBqqVA3QRnWC+9ydbJDgquaQ7ug18TZoegWpzk+SLnEygnC1xmD/K
 LJ1lhBnjHYw4VoRkOz3jAzbCW2WGKs2N0VBFNM+8Xp7m8uF9FXrkZaPRqc4QE3hW93JubQH2k
 5LE3SjEFTiXD2ep3s7W8esMTczcckTSl721frcdjbmNeoicB1FS1nuFU7t/cGxJxazxs2FLcK
 Rc/fvEFW1ZRZh7a6LHgHS2P1P8khJMzHiMUL+WnJpbFszWjLfZeYWFJ8vbg8VCVnFfjdH1Mdw
 vCCWkTHmEyt/BWhK5K3SwJKwsUKpm9bU0x88hBIsQpYCr6jUN4uOuMGhA==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/8 21:31, Filipe Manana wrote:
> On Wed, Jun 8, 2022 at 11:06 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> On 2022/6/8 17:47, Filipe Manana wrote:
>>> On Wed, Jun 08, 2022 at 03:09:20PM +0800, Qu Wenruo wrote:
>>>> [BUG]
>>>> There is a small workload which is a shorter version extracted from
>>>> btrfs/125:
>>>>
>>>>     mkfs.btrfs -f -m raid5 -d raid5 -b 1G $dev1 $dev2 $dev3
>>>>     mount $dev1 $mnt
>>>>     xfs_io -f -c "pwrite -S 0xee 0 1M" $mnt/file1
>>>>     sync
>>>>     umount $mnt
>>>>     btrfs dev scan -u $dev3
>>>>     mount -o degraded $dev1 $mnt
>>>>     xfs_io -f -c "pwrite -S 0xff 0 128M" $mnt/file2
>>>>     umount $mnt
>>>>     btrfs dev scan
>>>>     mount $dev1 $mnt
>>>>     btrfs balance start --full-balance $mnt
>>>>     umount $mnt
>>>>
>>>> In fact, after upstream commit d4e28d9b5f04 ("btrfs: raid56: make
>>>> steal_rbio() subpage compatible") above script will always pass, just
>>>> like btrfs/125.
>>>
>>> For me it still fails, very often.
>>> Both before and after that commit.
>>>
>>>>
>>>> But after a bug fix/optimization named "btrfs: update
>>>> stripe_sectors::uptodate in steal_rbio", above test case and btrfs/12=
5
>>>> will always fail (just like the old behavior before upstream d4e28d9b=
5f04).
>>>
>>> And I'm running a branch without that patch, which is just misc-next f=
rom
>>> about 2 weeks ago:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/log=
/?h=3Dtest_branch
>>
>> My bad, the whole situation is more complex.
>>
>> The recent RAID56 is a hell of fixes and regressions.
>>
>> Firstly, there are 2 conditions need to be met:
>>
>> 1) No cached sector usage for recovery path
>>      Patch "btrfs: raid56: make steal_rbio() subpage compatible"
>>      incidentally make it possible.
>>
>>      But later patch "btrfs: update stripe_sectors::uptodate in
>>      steal_rbio" will revert it.
>>
>> 2) No full P/Q stripe write for partial write
>>      This is done by patch "btrfs: only write the sectors in the vertic=
al
>>      stripe which has data stripes".
>>
>>
>> So in misc-next tree, the window is super small, just between patch
>> "btrfs: only write the sectors in the vertical stripe which has data
>> stripes" and "btrfs: update stripe_sectors::uptodate in steal_rbio".
>>
>> Which there is only one commit between them.
>>
>> To properly test that case, I have uploaded my branch for testing:
>> https://github.com/adam900710/linux/tree/testing
>
> With that branch, it seems to work, it ran 108 times here and it never f=
ailed.
> So only the changelog needs to be updated to mention all the patches tha=
t
> are needed.

And a new problem is, would I need to push all of those patches to
stable kernels?
Especially there is a patch that doesn't make sense for stable (part of
subpage support for RAID56)

Although all the involved patches are not completely solving the
destructive RMW, it greatly reduces the damage to the vertical stripe.
Thus it may still make sense for stable kernels.

Thanks,
Qu
>
> Thanks.
>
>>
>> It passed btrfs/125 16/16 times.
>>
>>>
>>> This is still all due to the fundamental flaw we have with partial str=
ipe
>>> writes I pointed out long ago:
>>>
>>> https://lore.kernel.org/linux-btrfs/CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKx=
u62VfLpAcmgsinBFw@mail.gmail.com/
>>
>> Yes, that's completely correct.
>>
>> But for our metadata case, there is a small save.
>>
>> We will never write data back to good copy with metadata directly, due
>> to forced metadata COW.
>>
>> With my latest patch (and above mentioned patches), in previous partial
>> writes, we won't write P/Q out of the vertical stripes.
>> So all untouched DATA and P are still safe on-disk. (Patch "btrfs: only
>> write the sectors in the vertical stripe which has data stripes")
>>
>> So if our DATA1 and P is correct, only DATA2 is stale, then when readin=
g
>> DATA2, metadata validation failed, then we go recovery.
>> And recovery won't trust any cached sector (this patch), we will read
>> every sector from disk. In this case, we read DATA1 and P, and rebuild
>> DATA2 correctly.
>>
>> Considering I missed condition 2) and the full roller coaster history, =
I
>> need to rework the commit message at least.
>>
>>
>> This is not yet perfect, for example, if the metadata on DATA1 stripe
>> get removed in transaction A. Then in transaction A+1 we can do partial
>> write for DATA1, and cause the destructive RMW, removing the only chanc=
e
>> of recovery DATA2.
>>
>> Thankfully, the above fix is already good enough for btrfs/125 (mostly
>> due to the lack of operation before doing balance, and metadata is the
>> first two chunks).
>>
>> Thanks,
>> Qu
>>>
>>> Running it again:
>>>
>>> root 10:18:07 /home/fdmanana/git/hub/xfstests (for-next)> ./check btrf=
s/125
>>> FSTYP         -- btrfs
>>> PLATFORM      -- Linux/x86_64 debian9 5.18.0-btrfs-next-119 #1 SMP PRE=
EMPT_DYNAMIC Sat May 28 20:28:23 WEST 2022
>>> MKFS_OPTIONS  -- /dev/sdb
>>> MOUNT_OPTIONS -- /dev/sdb /home/fdmanana/btrfs-tests/scratch_1
>>>
>>> btrfs/125 5s ... - output mismatch (see /home/fdmanana/git/hub/xfstest=
s/results//btrfs/125.out.bad)
>>>       --- tests/btrfs/125.out  2020-06-10 19:29:03.818519162 +0100
>>>       +++ /home/fdmanana/git/hub/xfstests/results//btrfs/125.out.bad  =
 2022-06-08 10:18:13.521948910 +0100
>>>       @@ -3,5 +3,15 @@
>>>        Write data with degraded mount
>>>
>>>        Mount normal and balance
>>>       +ERROR: error during balancing '/home/fdmanana/btrfs-tests/scrat=
ch_1': Input/output error
>>>       +There may be more info in syslog - try dmesg | tail
>>>       +md5sum: /home/fdmanana/btrfs-tests/scratch_1/tf2: Input/output =
error
>>>
>>>       ...
>>>       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/125.ou=
t /home/fdmanana/git/hub/xfstests/results//btrfs/125.out.bad'  to see the =
entire diff)
>>> Ran: btrfs/125
>>> Failures: btrfs/125
>>> Failed 1 of 1 tests
>>>
>>> root 10:18:17 /home/fdmanana/git/hub/xfstests (for-next)> dmesg
>>> [777880.530807] run fstests btrfs/125 at 2022-06-08 10:18:09
>>> [777881.341004] BTRFS: device fsid fc182050-867d-42b3-8b70-7a717d5d8c1=
0 devid 1 transid 6 /dev/sdb scanned by mkfs.btrfs (3174370)
>>> [777881.343023] BTRFS: device fsid fc182050-867d-42b3-8b70-7a717d5d8c1=
0 devid 2 transid 6 /dev/sdd scanned by mkfs.btrfs (3174370)
>>> [777881.343156] BTRFS: device fsid fc182050-867d-42b3-8b70-7a717d5d8c1=
0 devid 3 transid 6 /dev/sde scanned by mkfs.btrfs (3174370)
>>> [777881.360352] BTRFS info (device sdb): flagging fs with big metadata=
 feature
>>> [777881.360356] BTRFS info (device sdb): using free space tree
>>> [777881.360357] BTRFS info (device sdb): has skinny extents
>>> [777881.365900] BTRFS info (device sdb): checking UUID tree
>>> [777881.459545] BTRFS: device fsid fc182050-867d-42b3-8b70-7a717d5d8c1=
0 devid 2 transid 8 /dev/sdd scanned by mount (3174418)
>>> [777881.459637] BTRFS: device fsid fc182050-867d-42b3-8b70-7a717d5d8c1=
0 devid 1 transid 8 /dev/sdb scanned by mount (3174418)
>>> [777881.460202] BTRFS info (device sdb): flagging fs with big metadata=
 feature
>>> [777881.460204] BTRFS info (device sdb): allowing degraded mounts
>>> [777881.460206] BTRFS info (device sdb): using free space tree
>>> [777881.460206] BTRFS info (device sdb): has skinny extents
>>> [777881.466293] BTRFS warning (device sdb): devid 3 uuid a9540970-da42=
-44f8-9e62-30e6fdf013af is missing
>>> [777881.466568] BTRFS warning (device sdb): devid 3 uuid a9540970-da42=
-44f8-9e62-30e6fdf013af is missing
>>> [777881.923840] BTRFS: device fsid 57e10060-7318-4cd3-8e2d-4c3e481b1da=
b devid 1 transid 16797 /dev/sda scanned by btrfs (3174443)
>>> [777881.939421] BTRFS info (device sdb): flagging fs with big metadata=
 feature
>>> [777881.939425] BTRFS info (device sdb): using free space tree
>>> [777881.939426] BTRFS info (device sdb): has skinny extents
>>> [777881.959199] BTRFS info (device sdb): balance: start -d -m -s
>>> [777881.959348] BTRFS info (device sdb): relocating block group 754581=
504 flags data|raid5
>>> [777882.352088] verify_parent_transid: 787 callbacks suppressed
>>> [777882.352092] BTRFS error (device sdb): parent transid verify failed=
 on 38993920 wanted 9 found 5
>>> [777882.352327] BTRFS error (device sdb): parent transid verify failed=
 on 38993920 wanted 9 found 5
>>> [777882.352481] BTRFS error (device sdb): parent transid verify failed=
 on 38993920 wanted 9 found 5
>>> [777882.352692] BTRFS error (device sdb): parent transid verify failed=
 on 38993920 wanted 9 found 5
>>> [777882.352844] BTRFS error (device sdb): parent transid verify failed=
 on 38993920 wanted 9 found 5
>>> [777882.353066] BTRFS error (device sdb): parent transid verify failed=
 on 38993920 wanted 9 found 5
>>> [777882.353241] BTRFS error (device sdb): parent transid verify failed=
 on 38993920 wanted 9 found 5
>>> [777882.353567] BTRFS error (device sdb): parent transid verify failed=
 on 38993920 wanted 9 found 5
>>> [777882.353760] BTRFS error (device sdb): parent transid verify failed=
 on 38993920 wanted 9 found 5
>>> [777882.353982] BTRFS error (device sdb): parent transid verify failed=
 on 38993920 wanted 9 found 5
>>> [777882.455036] BTRFS info (device sdb): balance: ended with status: -=
5
>>> [777882.456202] BTRFS: error (device sdb: state A) in do_free_extent_a=
ccounting:2864: errno=3D-5 IO failure
>>>
>>>
>>>>
>>>> In my case, it fails due to tree block read failure, mostly on bytenr
>>>> 38993920:
>>>>
>>>>    BTRFS info (device dm-4): relocating block group 217710592 flags d=
ata|raid5
>>>>    BTRFS error (device dm-4): parent transid verify failed on 3899392=
0 wanted 9 found 7
>>>>    BTRFS error (device dm-4): parent transid verify failed on 3899392=
0 wanted 9 found 7
>>>>    ...
>>>>
>>>> [CAUSE]
>>>> With the recently added debug output, we can see all RAID56 operation=
s
>>>> related to full stripe 38928384:
>>>>
>>>>    23256.118349: raid56_read_partial: full_stripe=3D38928384 devid=3D=
2 type=3DDATA1 offset=3D0 opf=3D0x0 physical=3D9502720 len=3D65536
>>>>    23256.118547: raid56_read_partial: full_stripe=3D38928384 devid=3D=
3 type=3DDATA2 offset=3D16384 opf=3D0x0 physical=3D9519104 len=3D16384
>>>>    23256.118562: raid56_read_partial: full_stripe=3D38928384 devid=3D=
3 type=3DDATA2 offset=3D49152 opf=3D0x0 physical=3D9551872 len=3D16384
>>>>    23256.118704: raid56_write_stripe: full_stripe=3D38928384 devid=3D=
3 type=3DDATA2 offset=3D0 opf=3D0x1 physical=3D9502720 len=3D16384
>>>>    23256.118867: raid56_write_stripe: full_stripe=3D38928384 devid=3D=
3 type=3DDATA2 offset=3D32768 opf=3D0x1 physical=3D9535488 len=3D16384
>>>>    23256.118887: raid56_write_stripe: full_stripe=3D38928384 devid=3D=
1 type=3DPQ1 offset=3D0 opf=3D0x1 physical=3D30474240 len=3D16384
>>>>    23256.118902: raid56_write_stripe: full_stripe=3D38928384 devid=3D=
1 type=3DPQ1 offset=3D32768 opf=3D0x1 physical=3D30507008 len=3D16384
>>>>    23256.121894: raid56_write_stripe: full_stripe=3D38928384 devid=3D=
3 type=3DDATA2 offset=3D49152 opf=3D0x1 physical=3D9551872 len=3D16384
>>>>    23256.121907: raid56_write_stripe: full_stripe=3D38928384 devid=3D=
1 type=3DPQ1 offset=3D49152 opf=3D0x1 physical=3D30523392 len=3D16384
>>>>    23256.272185: raid56_parity_recover: full stripe=3D38928384 eb=3D3=
9010304 mirror=3D2
>>>>    23256.272335: raid56_parity_recover: full stripe=3D38928384 eb=3D3=
9010304 mirror=3D2
>>>>    23256.272446: raid56_parity_recover: full stripe=3D38928384 eb=3D3=
9010304 mirror=3D2
>>>>
>>>> Before we enter raid56_parity_recover(), we have triggered some metad=
ata
>>>> write for the full stripe 38928384, this leads to us to read all the
>>>> sectors from disk.
>>>>
>>>> However the test case itself intentionally uses degraded mount to cre=
ate
>>>> stale metadata.
>>>> Thus we read out the stale data and cached them.
>>>>
>>>> When we really need to recover certain range, aka in
>>>> raid56_parity_recover(), we will use the cached rbio, along with its
>>>> cached sectors.
>>>>
>>>> And since those sectors are already cached, we won't even bother to
>>>> re-read them.
>>>> This explains why we have no event raid56_scrub_read_recover()
>>>> triggered.
>>>>
>>>> Since we use the staled sectors to recover, and obviously this
>>>> will lead to incorrect data recovery.
>>>>
>>>> In our particular test case, it will always return the same incorrect
>>>> metadata, thus causing the same error message "parent transid verify
>>>> failed on 39010304 wanted 9 found 7" again and again.
>>>>
>>>> [FIX]
>>>> Commit d4e28d9b5f04 ("btrfs: raid56: make steal_rbio() subpage
>>>> compatible") has a bug that makes RAID56 to skip any cached sector, t=
hus
>>>> it incidentally fixed the failure of btrfs/125.
>>>
>>> As mentioned before, I still have the test failing very often even aft=
er
>>> that commit, and I don't see how that could ever fix the fundamental
>>> problem raid56 has with partial stripe writes.
>>>
>>> Thanks.
>>>
>>>>
>>>> But later patch "btrfs: update stripe_sectors::uptodate in steal_rbio=
",
>>>> reverted to the old trust-cache-unconditionally behavior, and
>>>> re-introduced the bug.
>>>>
>>>> In fact, we should still trust the cache for cases where everything i=
s
>>>> fine.
>>>>
>>>> What we really need is, trust nothing if we're recovery the full stri=
pe.
>>>>
>>>> So this patch will fix the behavior by not trust any cache in
>>>> __raid56_parity_recover(), to solve the problem while still keep the
>>>> cache useful.
>>>>
>>>> Now btrfs/125 and above test case can always pass, instead of the old
>>>> random failure behavior.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> I'm not sure how to push this patch.
>>>>
>>>> It's a bug fix for the very old trust-cache-unconditionally bug, but
>>>> since upstream d4e28d9b5f04 incidentally fixed it (by never trusting =
the
>>>> cache), and later "btrfs: update stripe_sectors::uptodate in steal_rb=
io"
>>>> is really re-introducing the bad old behavior.
>>>>
>>>> Thus I guess it may be a good idea to fold this small fix into "btrfs=
:
>>>> update stripe_sectors::uptodate in steal_rbio" ?
>>>> ---
>>>>    fs/btrfs/raid56.c | 13 ++++++-------
>>>>    1 file changed, 6 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
>>>> index c1f61d1708ee..be2f0ea81116 100644
>>>> --- a/fs/btrfs/raid56.c
>>>> +++ b/fs/btrfs/raid56.c
>>>> @@ -2125,9 +2125,12 @@ static int __raid56_parity_recover(struct btrf=
s_raid_bio *rbio)
>>>>       atomic_set(&rbio->error, 0);
>>>>
>>>>       /*
>>>> -     * read everything that hasn't failed.  Thanks to the
>>>> -     * stripe cache, it is possible that some or all of these
>>>> -     * pages are going to be uptodate.
>>>> +     * Read everything that hasn't failed. However this time we will
>>>> +     * not trust any cached sector.
>>>> +     * As we may read out some stale data but higher layer is not re=
ading
>>>> +     * that stale part.
>>>> +     *
>>>> +     * So here we always re-read everything in recovery path.
>>>>        */
>>>>       for (total_sector_nr =3D 0; total_sector_nr < rbio->nr_sectors;
>>>>            total_sector_nr++) {
>>>> @@ -2142,11 +2145,7 @@ static int __raid56_parity_recover(struct btrf=
s_raid_bio *rbio)
>>>>                       total_sector_nr +=3D rbio->stripe_nsectors - 1;
>>>>                       continue;
>>>>               }
>>>> -            /* The rmw code may have already read this page in. */
>>>>               sector =3D rbio_stripe_sector(rbio, stripe, sectornr);
>>>> -            if (sector->uptodate)
>>>> -                    continue;
>>>> -
>>>>               ret =3D rbio_add_io_sector(rbio, &bio_list, sector, str=
ipe,
>>>>                                        sectornr, rbio->stripe_len,
>>>>                                        REQ_OP_READ);
>>>> --
>>>> 2.36.1
>>>>
>>>
>>
