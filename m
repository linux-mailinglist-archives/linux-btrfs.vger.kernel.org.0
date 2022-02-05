Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DB94AA791
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Feb 2022 09:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbiBEIRe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 5 Feb 2022 03:17:34 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:37771 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbiBEIRe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Feb 2022 03:17:34 -0500
Received: from [192.168.177.41] ([94.31.101.241]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M9Ib1-1nATMa3ocp-006RP0; Sat, 05 Feb 2022 09:17:32 +0100
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Qu Wenruo" <wqu@suse.com>, "Qu Wenruo" <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
Subject: Re[2]: root 5 inode xy errors 200, dir isize wrong and root 5 inode xx errors
 1, no inode item
Date:   Sat, 05 Feb 2022 08:17:31 +0000
Message-Id: <ema04b2580-8e25-435c-9fd5-763bfb3e58cd@envy>
In-Reply-To: <a48e1e53-1c48-ae01-6646-f5d7872af8be@suse.com>
References: <em7a21a1a2-4ce2-46d5-aaf1-09e334b754d8@envy>
 <b29bcb81-883d-f024-d1a1-fe685e228d4b@gmx.com>
 <em596e7e6e-2b32-4c1e-b568-736fa23fd402@envy>
 <a48e1e53-1c48-ae01-6646-f5d7872af8be@suse.com>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/8.2.1659.0
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:IZdTlMUp1YFRVXJyeT+qNR3AtaGtA+hf1YdUkjXezY6A+nChkpM
 W6TdXYaoCQ6AWMM+IUOpFZvdsbVzIjhmbrtblv05rFWGlClMZQQ/foUHEeox2Rp3yfQ/O1A
 /nGmKA0TLePkbCawXqzIa67zBCeCJZj1yS/p3uxGVMoeIwKQaRv2oJZE3cMve3+LGLTV9an
 yqWKPLEoL6bgC7tJqrDQw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZOv3Mzrp0CI=:gRkmNbuLuG5pVrn2NeKpnN
 +JQnNALtNA67Gr/rU9HD1C8ssenkCEIkrsnlncolX5pVOsdvO+3UQx5hyoopM8b7e4By9MIRO
 jVzxtuzjH7ZPmnSiMkgalnHdhH8KPjMyUDJP4LPauc71bTs0BVT9Xk3YHiTywZongUBYQ44EZ
 seUfp55Sw9qBCGVlHSSIaA1j1B27yR0Vuks0WOtwY1tfBosrDm93WexjnKEiZbKfnKEBd3srK
 R77HNBUTMZMp23xj6JABu/9NwEu+j/lg8DIqWgqYfv0PshvaVN5/6K3Lh+gIS6ueiv8FTj/rD
 tkiN2j9OwHdkB2DOrD3lQeNYzOtqxODHpJu6CWDDb9AisDR+BKPp19oJFp5CyC1IyizLHmh/q
 j5XJlzLH6AqNfHxfgQ/a3eukF4P/yJWaepXlXFDnyeD6h2Ybwx4P9d8Nu3yffkzK035hOD+7j
 8bixqe44btxI1awwhypi6ZXWbXFiP5C5TiPX6RyMMJzRJJzT5HVifNhV6TM0O8nNZRTBrNwob
 mkrIOfoLvfCPtcCddD8FXoNs22vd0UWP+J9IZvjqk1Ru/xH+11lO/kIZ3nKTWuXaxQzI2LiGf
 B0S6JBYa0bQ5tc4zVY/rHps97ptM4cPhsd3HGDL8JmI7jn1C5EuIhMoNDDJugbvt0rzsi7mMM
 mSQyCJIU1IxqROECbMXlAigPkPwXrG2PpPEbvl3QlN4Fht+DjFj8os61JpwcVeDO+aVl4DGew
 A8YPQkOS/CBabvZK
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Qu,

thanks for your reply.

>>I guess it is not normal, that it btrfs check is now running since hours... iotop is showing no disk read going on.
>
>OK, new bugs in lowmem mode.
Well, I let it run over night, and at last it finished. It was super 
slow though. Must have been more than 5h.

btrfs check --mode=lowmem --readonly /dev/sdd2
Opening filesystem to check...
Checking filesystem on /dev/sdd2
UUID: c217331c-cf0c-49ae-86c7-48a67d1c346b
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
ERROR: root 5 INODE_ITEM[59544488] index 199 name global.stat filetype 1 
missing
ERROR: root 5 INODE_ITEM[59544493] index 200 name global.tmp filetype 1 
missing
ERROR: root 5 INODE_ITEM[59544494] index 202 name db_0.stat filetype 1 
missing
ERROR: root 5 INODE_ITEM[59544493] index 203 name global.stat filetype 1 
missing
ERROR: root 5 INODE_ITEM[59544495] index 204 name global.tmp filetype 1 
missing
ERROR: root 5 DIR INODE [79886] size 0 not equal to 51
ERROR: errors found in fs roots
found 62801883136 bytes used, error(s) found
total csum bytes: 43658820
total tree bytes: 664485888
total fs tree bytes: 329400320
total extent tree bytes: 240205824
btree space waste bytes: 119009827
file data blocks allocated: 4766311215104
referenced 60116828160

>You can safely kill it, as it's really read-only.
>
>
>For the errors reported, they can all be handled by --repair, but please keep in mind that, those offending files may be deleted or moved to 'lost+found' directory in root 5.
>

I did and it seemed to work:
btrfs check --repair  /dev/sdd2
enabling repair mode
Opening filesystem to check...
Checking filesystem on /dev/sdd2
UUID: c217331c-cf0c-49ae-86c7-48a67d1c346b
[1/7] checking root items
Fixed 0 roots.
[2/7] checking extents
No device size related problem found
[3/7] checking free space cache
cache and super generation don't match, space cache will be invalidated
[4/7] checking fs roots
Deleting bad dir index [79886,96,199] root 5
Deleting bad dir index [79886,96,200] root 5
Deleting bad dir index [79886,96,203] root 5
Deleting bad dir index [79886,96,202] root 5
Deleting bad dir index [79886,96,204] root 5
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 62801883136 bytes used, no error found
total csum bytes: 43658820
total tree bytes: 664485888
total fs tree bytes: 329400320
total extent tree bytes: 240205824
btree space waste bytes: 119009827
file data blocks allocated: 4766311215104
  referenced 60116828160
root@homeserver:/home/henfri# btrfs check --readonly  /dev/sdd2
Opening filesystem to check...
Checking filesystem on /dev/sdd2
UUID: c217331c-cf0c-49ae-86c7-48a67d1c346b
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
cache and super generation don't match, space cache will be invalidated
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 62801899520 bytes used, no error found
total csum bytes: 43658820
total tree bytes: 664502272
total fs tree bytes: 329400320
total extent tree bytes: 240222208
btree space waste bytes: 119026345
file data blocks allocated: 4766311215104
  referenced 60116828160

Best regards,
Hendrik


>
>Thanks,
>Qu
>>
>>Best regards,
>>Hendrik
>>
>>------ Originalnachricht ------
>>Von: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
>>An: "Hendrik Friedel" <hendrik@friedels.name>; linux-btrfs@vger.kernel.org
>>Gesendet: 04.02.2022 14:47:45
>>Betreff: Re: root 5 inode xy errors 200, dir isize wrong and root 5 inode xx errors 1, no inode item
>>
>>>
>>>
>>>On 2022/2/4 21:30, Hendrik Friedel wrote:
>>>>Hello,
>>>>
>>>>I found some files for which ls -l gave me odd output (??????) instead
>>>>of mtime etc.
>>>
>>>And have you checked your dmesg to see anything wrong?
>>>
>>>My guess is, tree-checker reports something wrong.
>>>
>>>>
>>>>So I ran btrfs scrub without errors and then btrfs check with these errors:
>>>>[1/7] checking root items
>>>>[2/7] checking extents
>>>>[3/7] checking free space cache
>>>>[4/7] checking fs roots
>>>>root 5 inode 79886 errors 200, dir isize wrong
>>>
>>>This is pretty easy to fix, --repair can handle.
>>>
>>>But I guess it's mostly due to the offending dir items.
>>>
>>>>root 5 inode 59544488 errors 1, no inode item
>>>>          unresolved ref dir 79886 index 199 namelen 11 name global.stat
>>>
>>>No inode item is a weird one, it means the inode 59544488 doesn't have
>>>its inode item at all.
>>>
>>>
>>>>filetype 1 errors 5, no dir item, no inode ref
>>>>root 5 inode 59544493 errors 1, no inode item
>>>
>>>On the other hand, there are some other dir refs which doesn't have dir
>>>item.
>>>
>>>From the inode numbers, it doesn't look like an obvious bitflip:
>>>
>>>59544488 = 0x38c93a8
>>>59544493 = 0x38c93ad
>>>59544494 = 0x38c93ae
>>>59544495 = 0x38c93af
>>>
>>>And, mind to run "btrfs check --mode=lowmem --readonly" to get a better
>>>user readable output?
>>>
>>>Thanks,
>>>Qu
>>>
>>>>          unresolved ref dir 79886 index 200 namelen 10 name global.tmp
>>>>filetype 1 errors 5, no dir item, no inode ref
>>>>          unresolved ref dir 79886 index 203 namelen 11 name global.stat
>>>>filetype 1 errors 5, no dir item, no inode ref
>>>>root 5 inode 59544494 errors 1, no inode item
>>>>          unresolved ref dir 79886 index 202 namelen 9 name db_0.stat
>>>>filetype 1 errors 5, no dir item, no inode ref
>>>>root 5 inode 59544495 errors 1, no inode item
>>>>          unresolved ref dir 79886 index 204 namelen 10 name global.tmp
>>>>filetype 1 errors 5, no dir item, no inode ref
>>>>ERROR: errors found in fs roots
>>>>found 62813446144 bytes used, error(s) found
>>>>total csum bytes: 43669376
>>>>total tree bytes: 665501696
>>>>total fs tree bytes: 329498624
>>>>total extent tree bytes: 240975872
>>>>btree space waste bytes: 119919077
>>>>file data blocks allocated: 4766364479488
>>>>   referenced 60131446784
>>>>
>>>>How do I fix these?
>>>>I am runing linux 5.13.9 (about to update to 5.16.5).
>>>>
>>>>Best regards,
>>>>Hendrik
>>>>
>>
>

