Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2532B4149
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Nov 2020 11:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgKPKlm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Nov 2020 05:41:42 -0500
Received: from smtp.radex.nl ([178.250.146.7]:59358 "EHLO radex-web.radex.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729143AbgKPKll (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Nov 2020 05:41:41 -0500
Received: from [192.168.1.158] (cust-178-250-146-69.breedbanddelft.nl [178.250.146.69])
        by radex-web.radex.nl (Postfix) with ESMTPS id 64C6624071;
        Mon, 16 Nov 2020 11:41:38 +0100 (CET)
From:   Ferry Toth <fntoth@gmail.com>
Subject: Re: Fwd: Read time tree block corruption detected
To:     Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Tyler Richmond <t.d.richmond@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <e2c8eaaf-6adb-374f-4005-a1edcbcb8f79@gmx.com>
 <CAJheHN1U4j1KsD96oFuCVwP+6RVP6V6oAZP-aGOTtfm7tDL3BA@mail.gmail.com>
 <CAJheHN3pTj-6dOQZVKqA_r38F+WVNrjVO6-Z_hFeq96uTNK5zw@mail.gmail.com>
 <1f26ff53-f7c7-c497-b69f-8a3e5d8ce959@gmx.com>
 <b7383762-4a86-fdb9-12f3-89470808f4e6@gmail.com>
 <0d6a0602-897a-b170-f1a2-007cff1f23fb@gmx.com>
 <134e61b5-ecf7-bc1a-e16b-c95b14876e6e@gmail.com>
 <5b757c2b-6dbf-cbec-6c66-e4b14897f53c@gmx.com>
 <838490cf-fc40-0008-88bb-eeede1e8d873@gmail.com>
 <50e0ef4d-061e-d02d-9dbf-61f83dfa7b3e@suse.com>
 <117797ff-c28b-c755-da17-fb7ce3169f0f@gmail.com>
 <51578ec7-f2e5-a09a-520e-f0577300d5ce@gmx.com>
 <ca811ad9-5ae4-602e-98a4-5d4d6c860a1c@gmail.com>
 <0acac733-233c-0c71-b9bc-c4bee1c724ba@suse.com>
 <4dd24fde-6d7f-202f-5d2f-b4478d797a93@gmail.com>
 <fcd272a5-a437-e918-8102-3813a608574c@gmx.com>
 <a26dc3fa-f68a-31fd-dbf8-692892df6019@gmail.com>
 <d57d7430-c0c5-315e-9d74-08d4b38696aa@suse.com>
Message-ID: <1afa30fd-518e-f93e-24ae-e0cd87ce6885@gmail.com>
Date:   Mon, 16 Nov 2020 11:41:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <d57d7430-c0c5-315e-9d74-08d4b38696aa@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Op 07-11-2020 om 14:28 schreef Qu Wenruo:
> On 2020/11/7 下午9:19, Ferry Toth wrote:
>> Hi
>>
>> Op 07-11-2020 om 12:35 schreef Qu Wenruo:
>>> On 2020/11/7 下午7:18, Ferry Toth wrote:
>>>> Op 06-11-2020 om 11:32 schreef Qu Wenruo:
>>>>> On 2020/11/6 下午6:30, Ferry Toth wrote:
>>>>>> Hi
>>>>>>
>>>>>> Op 06-11-2020 om 11:24 schreef Qu Wenruo:
>>>>>>> On 2020/11/6 下午6:09, Ferry Toth wrote:
>>>>>>>> Hi Qu
>>>>>>>>
>>>>>>>> Op 06-11-2020 om 00:40 schreef Qu Wenruo:
>>>>>>>>> On 2020/11/6 上午7:37, Ferry Toth wrote:
>>>>>>>>>> Hi
>>>>>>>>>>
>>>>>>>>>> Op 06-11-2020 om 00:32 schreef Qu Wenruo:
>>>>>>>>>>> On 2020/11/6 上午7:12, Ferry Toth wrote:
>>>>>>>>>>>> Hi,
>>>>>>>>>>>>
>>>>>>>>>>>> Op 06-11-2020 om 00:00 schreef Qu Wenruo:
>>>>>>>>>>>>> On 2020/11/6 上午4:08, Ferry Toth wrote:
>>>>>>>>>>>>>> I am in a similar spot, during updating my distro (Kubuntu),
>>>>>>>>>>>>>> I am
>>>>>>>>>>>>>> unable
>>>>>>>>>>>>>> to update a certain package. I know which file it is:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> ~$ ls -l /usr/share/doc/libatk1.0-data
>>>>>>>>>>>>>> ls: kan geen toegang krijgen tot
>>>>>>>>>>>>>> '/usr/share/doc/libatk1.0-data':
>>>>>>>>>>>>>> Invoer-/uitvoerfout
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> This creates the following in journal:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> kernel: BTRFS critical (device sda2): corrupt leaf: root=294
>>>>>>>>>>>>>> block=1169152675840 slot=1 ino=915987, invalid inode
>>>>>>>>>>>>>> generation: has
>>>>>>>>>>>>>> 18446744073709551492 expect [0, 5851353]
>>>>>>>>>>>>>> kernel: BTRFS error (device sda2): block=1169152675840 read
>>>>>>>>>>>>>> time
>>>>>>>>>>>>>> tree
>>>>>>>>>>>>>> block corruption detected
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Now, the problem: this file is on my rootfs, which is
>>>>>>>>>>>>>> mounted. apt
>>>>>>>>>>>>>> (distribution updated) installed all packages but can't
>>>>>>>>>>>>>> continue
>>>>>>>>>>>>>> configuring, because libatk is a dependancy. I can't delete
>>>>>>>>>>>>>> the
>>>>>>>>>>>>>> file
>>>>>>>>>>>>>> because of the I/O error. And btrfs check complains (I tried
>>>>>>>>>>>>>> running RO)
>>>>>>>>>>>>>> because the file system is mounted.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> But, on the sunny side, the file system is not RO.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Is there any way to forcefully remove the file? Or do you
>>>>>>>>>>>>>> have a
>>>>>>>>>>>>>> recommendation how to proceed?
>>>>>>>>>>>>> Newer kernel will reject to even read the item, thus will
>>>>>>>>>>>>> not be
>>>>>>>>>>>>> able to
>>>>>>>>>>>>> remove it.
>>>>>>>>>>>> That's already the case. (input / output error)
>>>>>>>>>>>>> I guess you have to use some distro ISO to fix the fs.
>>>>>>>>>>>> And then? btrfs check --repair the disk offline?
>>>>>>>>>>> Yep.
>>>>>>>>>>>
>>>>>>>>>>> You would want the latest btrfs-progs though.
>>>>>>>>>> Groovy has 5.7. Would that be good enough? Otherwise will be
>>>>>>>>>> difficult
>>>>>>>>>> to build on/for live usb image.
>>>>>>>>> For your particular case, the fix are already in btrfs-progs v5.4.
>>>>>>>>>
>>>>>>>>> Although newer is always better, just in case you have extent item
>>>>>>>>> generation corruption, you may want v5.4.1.
>>>>>>>>>
>>>>>>>>> So your v5.7 should be good enough.
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Qu
>>>>>>>> I made a live usb and performed:
>>>>>>>>
>>>>>>>> btrfs check --repair /dev/sda2
>>>>>>>>
>>>>>>>> It found errors and fixed them. However, it did not fix the corrupt
>>>>>>>> leaf. The file is actually a directory:
>>>>>>>>
>>>>>>>> ~$ stat /usr/share/doc/libatk1.0-data
>>>>>>>> stat: cannot statx '/usr/share/doc/libatk1.0-data':
>>>>>>>> Invoer-/uitvoerfout
>>>>>>>>
>>>>>>>> in journal:
>>>>>>>>
>>>>>>>> BTRFS critical (device sda2): corrupt leaf: root=294
>>>>>>>> block=1169152675840
>>>>>>>> slot=1 ino=915987, invalid inode generation: has
>>>>>>>> 18446744073709551492
>>>>>>>> expect [0, 5852829]
>>>>>>>> BTRFS error (device sda2): block=1169152675840 read time tree block
>>>>>>>> corruption detected
>>>>>>>>
>>>>>>>> So how do I repair this? Am I doing something wrong?
>>>>>>> Please provide the following dump:
>>>>>>> btrfs ins dump-tree -b 1169152675840 /dev/sda2
>>>>>>>
>>>>>>> Feel free to remove the filenames in the dump.
>>>>>> sudo btrfs ins dump-tree -b 1169152675840 /dev/sda2
>>>>>> btrfs-progs v5.3-rc1
>>>>>> leaf 1169152675840 items 36 free space 966 generation 5431733 owner
>>>>>> 294
>>>>>> leaf 1169152675840 flags 0x1(WRITTEN) backref revision 1
>>>>>> fs uuid 27155120-9ef8-47fb-b248-eaac2b7c8375
>>>>>> chunk uuid 5704f1ba-08fd-4f6b-9117-0e080b4e9ef0
>>>>>>            item 0 key (915986 DIR_INDEX 2) itemoff 3957 itemsize 38
>>>>>>                    location key (915987 INODE_ITEM 0) type FILE
>>>>>>                    transid 7782235549259005952 data_len 0 name_len 8
>>>>>>                    name: smb.conf
>>>>>>            item 1 key (915987 INODE_ITEM 0) itemoff 3797 itemsize 160
>>>>>>                    generation 1 transid 18446744073709551492 size 12464
>>>>>> nbytes 16384
>>>>> Yeah, corrupted transid.
>>>>>
>>>>> The v5.6 kernel doesn't get the fix backported...
>>>>>
>>>>> Now you have to use either the out-of-tree branch, or David's devel
>>>>> branch to build a btrfs-progs which is able to repair the transid
>>>>> error.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>> Just be to be clear, I tried to repair with the Kubuntu Groovy Live usb,
>>>> which has linux 5.8 and btrfs-progs 5.7.
>>>>
>>>> I didn't fix the above transid, above was taken after booting normally
>>>> again (linux 5.8), unfortunately with btrfs-progs v5.3-rc1 (that I built
>>>> a year ago). See the other post for the result with btrfs-progs 5.7.
>>>>
>>>>
>>> As I said already, you need either the devel branch to do the fix.
>>> Current release btrfs-progs hasn't the repair ability merged.
>>>
>> Ah, I understood wrong. I thought 5.7 was enough.
>>
>> So, I need to build the latest and greatest and install on live usb. Or
>> I need to wait for a future live usb with this incorporated.
>>
> It's strongly recommended to build right now.
>
> As you may already find, the btrfs-progs release cycle is normally
> behind schedule, thus you may need to wait way longer than you thought...
>
> BTW, after repairing, it's recommended to use newer enought (v5.8 should
> be enough) kernel to mount the repaired fs, to verify the transid error
> get fixed.
>
> Thanks,
> Qu
>
Just in case others stumble upon the same situation here is a brief 
summary of the problem and what I did to fix it:

- On upgrading from Kubuntu 20.04 to 20.10 certain package could not be 
upgraded because they failed to stat. Eventually the upgrade aborts with 
some packages not configured and some dependencies not installed.

- After rebooting this is still the case. Fortunately the failing files 
were under /usr/share/doc and the dependencies not essential to boot. It 
was possible to rename /usr/share/doc to /usr/share/dog then cp that to 
/usr/share/doc. That was sufficient to continue configuration and finish 
the upgrade.

- rm -rf /usr/share/dog of course still fails on the broken directories

- Kubuntu 20.10 kernel is linux 5.8 but btrfs-prog is v5.7 and did not 
fix the problem

- Built btrfs-progs v5.9 from 
git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git and 
booting Kubuntu 20.10 from USB stick then running btrfs-progs v5.9 fixes 
it with below log.

- Thanks Qu for the help!

Ferry

log

---

kubuntu@kubuntu:~$ sudo ./btrfs check /dev/sda2
Opening filesystem to check...
Checking filesystem on /dev/sda2
UUID: 27155120-9ef8-47fb-b248-eaac2b7c8375
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
root 294 inode 915975 errors 100000, invalid inode generation or transid
root 294 inode 915976 errors 100000, invalid inode generation or transid
root 294 inode 915977 errors 100000, invalid inode generation or transid
root 294 inode 915978 errors 100000, invalid inode generation or transid
root 294 inode 915979 errors 100000, invalid inode generation or transid
root 294 inode 915980 errors 100000, invalid inode generation or transid
root 294 inode 915982 errors 100000, invalid inode generation or transid
root 294 inode 915984 errors 100000, invalid inode generation or transid
root 294 inode 915985 errors 100000, invalid inode generation or transid
root 294 inode 915987 errors 100000, invalid inode generation or transid
root 294 inode 1962496 errors 100000, invalid inode generation or transid
root 294 inode 1962499 errors 100000, invalid inode generation or transid
root 294 inode 1962500 errors 100000, invalid inode generation or transid
root 294 inode 1962501 errors 100000, invalid inode generation or transid
root 294 inode 1962502 errors 100000, invalid inode generation or transid
root 294 inode 1962503 errors 100000, invalid inode generation or transid
root 294 inode 1962504 errors 100000, invalid inode generation or transid
root 294 inode 1962505 errors 100000, invalid inode generation or transid
root 294 inode 1962506 errors 100000, invalid inode generation or transid
root 294 inode 1962507 errors 100000, invalid inode generation or transid
root 294 inode 1962508 errors 100000, invalid inode generation or transid
root 294 inode 1962509 errors 100000, invalid inode generation or transid
root 294 inode 1962510 errors 100000, invalid inode generation or transid
root 294 inode 1962511 errors 100000, invalid inode generation or transid
root 294 inode 1962512 errors 100000, invalid inode generation or transid
root 294 inode 1962513 errors 100000, invalid inode generation or transid
root 294 inode 1962514 errors 100000, invalid inode generation or transid
root 294 inode 1962515 errors 100000, invalid inode generation or transid
root 294 inode 1962516 errors 100000, invalid inode generation or transid
root 294 inode 1962517 errors 100000, invalid inode generation or transid
root 294 inode 1962518 errors 100000, invalid inode generation or transid
root 294 inode 1962519 errors 100000, invalid inode generation or transid
root 294 inode 1962520 errors 100000, invalid inode generation or transid
root 294 inode 1962521 errors 100000, invalid inode generation or transid
root 294 inode 1962522 errors 100000, invalid inode generation or transid
root 294 inode 1962523 errors 100000, invalid inode generation or transid
root 294 inode 1962524 errors 100000, invalid inode generation or transid
root 294 inode 1962525 errors 100000, invalid inode generation or transid
root 294 inode 1962526 errors 100000, invalid inode generation or transid
root 294 inode 1962527 errors 100000, invalid inode generation or transid
root 294 inode 1962528 errors 100000, invalid inode generation or transid
root 294 inode 1962529 errors 100000, invalid inode generation or transid
root 294 inode 1962530 errors 100000, invalid inode generation or transid
root 294 inode 1962531 errors 100000, invalid inode generation or transid
root 294 inode 1962532 errors 100000, invalid inode generation or transid
root 294 inode 1962533 errors 100000, invalid inode generation or transid
root 294 inode 1962534 errors 100000, invalid inode generation or transid
root 294 inode 1962535 errors 100000, invalid inode generation or transid
root 294 inode 1962536 errors 100000, invalid inode generation or transid
root 294 inode 1962537 errors 100000, invalid inode generation or transid
root 294 inode 1962538 errors 100000, invalid inode generation or transid
root 294 inode 1962539 errors 100000, invalid inode generation or transid
root 294 inode 1962540 errors 100000, invalid inode generation or transid
root 294 inode 1962541 errors 100000, invalid inode generation or transid
root 294 inode 1962542 errors 100000, invalid inode generation or transid
root 294 inode 1962543 errors 100000, invalid inode generation or transid
root 294 inode 1962544 errors 100000, invalid inode generation or transid
root 294 inode 1962545 errors 100000, invalid inode generation or transid
root 294 inode 1962546 errors 100000, invalid inode generation or transid
root 294 inode 1962547 errors 100000, invalid inode generation or transid
root 294 inode 1962548 errors 100000, invalid inode generation or transid
root 294 inode 1962549 errors 100000, invalid inode generation or transid
root 294 inode 1962550 errors 100000, invalid inode generation or transid
root 294 inode 1962551 errors 100000, invalid inode generation or transid
root 294 inode 1962552 errors 100000, invalid inode generation or transid
root 294 inode 1962553 errors 100000, invalid inode generation or transid
root 294 inode 1962554 errors 100000, invalid inode generation or transid
root 294 inode 1962555 errors 100000, invalid inode generation or transid
root 294 inode 1962556 errors 100000, invalid inode generation or transid
root 294 inode 1962557 errors 100000, invalid inode generation or transid
root 294 inode 1962558 errors 100000, invalid inode generation or transid
root 294 inode 1962559 errors 100000, invalid inode generation or transid
root 294 inode 1962560 errors 100000, invalid inode generation or transid
root 294 inode 1962561 errors 100000, invalid inode generation or transid
root 294 inode 1962562 errors 100000, invalid inode generation or transid
root 294 inode 1962563 errors 100000, invalid inode generation or transid
root 294 inode 1962564 errors 100000, invalid inode generation or transid
root 294 inode 1962565 errors 100000, invalid inode generation or transid
root 294 inode 1962566 errors 100000, invalid inode generation or transid
root 294 inode 1962567 errors 100000, invalid inode generation or transid
root 294 inode 1962568 errors 100000, invalid inode generation or transid
root 294 inode 1962569 errors 100000, invalid inode generation or transid
root 294 inode 1962570 errors 100000, invalid inode generation or transid
root 294 inode 1962571 errors 100000, invalid inode generation or transid
root 294 inode 1962572 errors 100000, invalid inode generation or transid
root 294 inode 1962573 errors 100000, invalid inode generation or transid
root 294 inode 1962574 errors 100000, invalid inode generation or transid
root 294 inode 1962575 errors 100000, invalid inode generation or transid
root 294 inode 1962576 errors 100000, invalid inode generation or transid
root 294 inode 1962577 errors 100000, invalid inode generation or transid
root 294 inode 1962578 errors 100000, invalid inode generation or transid
root 294 inode 1962579 errors 100000, invalid inode generation or transid
root 294 inode 1962580 errors 100000, invalid inode generation or transid
root 294 inode 1962581 errors 100000, invalid inode generation or transid
root 294 inode 1962582 errors 100000, invalid inode generation or transid
root 294 inode 1962583 errors 100000, invalid inode generation or transid
root 294 inode 1962584 errors 100000, invalid inode generation or transid
root 294 inode 1962585 errors 100000, invalid inode generation or transid
root 294 inode 1962586 errors 100000, invalid inode generation or transid
ERROR: errors found in fs roots
found 444725678080 bytes used, error(s) found
total csum bytes: 272354940
total tree bytes: 1862316032
total fs tree bytes: 1250484224
total extent tree bytes: 277397504
btree space waste bytes: 401028956
file data blocks allocated: 16021691621376
  referenced 394733535232


