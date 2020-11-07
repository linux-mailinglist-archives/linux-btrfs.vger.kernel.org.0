Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8102AA496
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Nov 2020 12:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgKGLSK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Nov 2020 06:18:10 -0500
Received: from smtp.radex.nl ([178.250.146.7]:59254 "EHLO radex-web.radex.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbgKGLSK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 7 Nov 2020 06:18:10 -0500
Received: from [10.8.0.6] (cust-178-250-146-69.breedbanddelft.nl [178.250.146.69])
        by radex-web.radex.nl (Postfix) with ESMTPS id E15022406A;
        Sat,  7 Nov 2020 12:18:04 +0100 (CET)
Subject: Re: Fwd: Read time tree block corruption detected
To:     Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Tyler Richmond <t.d.richmond@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <CAJheHN0NmgVoGF+AsnUNQkQnEJ46JCmpg4o5nwAkqi+VoGMjfw@mail.gmail.com>
 <e04680b4-f4c0-254f-24ba-f2053e4ad8b3@gmx.com>
 <CAJheHN0THhKcqKY3cGtJqUGaub=E0tuCmi6wuNeCGBxyAHmecQ@mail.gmail.com>
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
From:   Ferry Toth <fntoth@gmail.com>
Message-ID: <4dd24fde-6d7f-202f-5d2f-b4478d797a93@gmail.com>
Date:   Sat, 7 Nov 2020 12:18:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <0acac733-233c-0c71-b9bc-c4bee1c724ba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Op 06-11-2020 om 11:32 schreef Qu Wenruo:
> 
> 
> On 2020/11/6 下午6:30, Ferry Toth wrote:
>> Hi
>>
>> Op 06-11-2020 om 11:24 schreef Qu Wenruo:
>>>
>>> On 2020/11/6 下午6:09, Ferry Toth wrote:
>>>> Hi Qu
>>>>
>>>> Op 06-11-2020 om 00:40 schreef Qu Wenruo:
>>>>> On 2020/11/6 上午7:37, Ferry Toth wrote:
>>>>>> Hi
>>>>>>
>>>>>> Op 06-11-2020 om 00:32 schreef Qu Wenruo:
>>>>>>> On 2020/11/6 上午7:12, Ferry Toth wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> Op 06-11-2020 om 00:00 schreef Qu Wenruo:
>>>>>>>>> On 2020/11/6 上午4:08, Ferry Toth wrote:
>>>>>>>>>> I am in a similar spot, during updating my distro (Kubuntu), I am
>>>>>>>>>> unable
>>>>>>>>>> to update a certain package. I know which file it is:
>>>>>>>>>>
>>>>>>>>>> ~$ ls -l /usr/share/doc/libatk1.0-data
>>>>>>>>>> ls: kan geen toegang krijgen tot '/usr/share/doc/libatk1.0-data':
>>>>>>>>>> Invoer-/uitvoerfout
>>>>>>>>>>
>>>>>>>>>> This creates the following in journal:
>>>>>>>>>>
>>>>>>>>>> kernel: BTRFS critical (device sda2): corrupt leaf: root=294
>>>>>>>>>> block=1169152675840 slot=1 ino=915987, invalid inode
>>>>>>>>>> generation: has
>>>>>>>>>> 18446744073709551492 expect [0, 5851353]
>>>>>>>>>> kernel: BTRFS error (device sda2): block=1169152675840 read time
>>>>>>>>>> tree
>>>>>>>>>> block corruption detected
>>>>>>>>>>
>>>>>>>>>> Now, the problem: this file is on my rootfs, which is mounted. apt
>>>>>>>>>> (distribution updated) installed all packages but can't continue
>>>>>>>>>> configuring, because libatk is a dependancy. I can't delete the
>>>>>>>>>> file
>>>>>>>>>> because of the I/O error. And btrfs check complains (I tried
>>>>>>>>>> running RO)
>>>>>>>>>> because the file system is mounted.
>>>>>>>>>>
>>>>>>>>>> But, on the sunny side, the file system is not RO.
>>>>>>>>>>
>>>>>>>>>> Is there any way to forcefully remove the file? Or do you have a
>>>>>>>>>> recommendation how to proceed?
>>>>>>>>> Newer kernel will reject to even read the item, thus will not be
>>>>>>>>> able to
>>>>>>>>> remove it.
>>>>>>>> That's already the case. (input / output error)
>>>>>>>>> I guess you have to use some distro ISO to fix the fs.
>>>>>>>> And then? btrfs check --repair the disk offline?
>>>>>>> Yep.
>>>>>>>
>>>>>>> You would want the latest btrfs-progs though.
>>>>>> Groovy has 5.7. Would that be good enough? Otherwise will be difficult
>>>>>> to build on/for live usb image.
>>>>> For your particular case, the fix are already in btrfs-progs v5.4.
>>>>>
>>>>> Although newer is always better, just in case you have extent item
>>>>> generation corruption, you may want v5.4.1.
>>>>>
>>>>> So your v5.7 should be good enough.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>> I made a live usb and performed:
>>>>
>>>> btrfs check --repair /dev/sda2
>>>>
>>>> It found errors and fixed them. However, it did not fix the corrupt
>>>> leaf. The file is actually a directory:
>>>>
>>>> ~$ stat /usr/share/doc/libatk1.0-data
>>>> stat: cannot statx '/usr/share/doc/libatk1.0-data': Invoer-/uitvoerfout
>>>>
>>>> in journal:
>>>>
>>>> BTRFS critical (device sda2): corrupt leaf: root=294 block=1169152675840
>>>> slot=1 ino=915987, invalid inode generation: has 18446744073709551492
>>>> expect [0, 5852829]
>>>> BTRFS error (device sda2): block=1169152675840 read time tree block
>>>> corruption detected
>>>>
>>>> So how do I repair this? Am I doing something wrong?
>>> Please provide the following dump:
>>> btrfs ins dump-tree -b 1169152675840 /dev/sda2
>>>
>>> Feel free to remove the filenames in the dump.
>> sudo btrfs ins dump-tree -b 1169152675840 /dev/sda2
>> btrfs-progs v5.3-rc1
>> leaf 1169152675840 items 36 free space 966 generation 5431733 owner 294
>> leaf 1169152675840 flags 0x1(WRITTEN) backref revision 1
>> fs uuid 27155120-9ef8-47fb-b248-eaac2b7c8375
>> chunk uuid 5704f1ba-08fd-4f6b-9117-0e080b4e9ef0
>>          item 0 key (915986 DIR_INDEX 2) itemoff 3957 itemsize 38
>>                  location key (915987 INODE_ITEM 0) type FILE
>>                  transid 7782235549259005952 data_len 0 name_len 8
>>                  name: smb.conf
>>          item 1 key (915987 INODE_ITEM 0) itemoff 3797 itemsize 160
>>                  generation 1 transid 18446744073709551492 size 12464
>> nbytes 16384
> Yeah, corrupted transid.
> 
> The v5.6 kernel doesn't get the fix backported...
> 
> Now you have to use either the out-of-tree branch, or David's devel
> branch to build a btrfs-progs which is able to repair the transid error.
> 
> Thanks,
> Qu
> 
Just be to be clear, I tried to repair with the Kubuntu Groovy Live usb, 
which has linux 5.8 and btrfs-progs 5.7.

I didn't fix the above transid, above was taken after booting normally 
again (linux 5.8), unfortunately with btrfs-progs v5.3-rc1 (that I built 
a year ago). See the other post for the result with btrfs-progs 5.7.


