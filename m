Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFCF4859DE
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 21:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243920AbiAEUOt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 15:14:49 -0500
Received: from smtp-33.italiaonline.it ([213.209.10.33]:37766 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243957AbiAEUOP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jan 2022 15:14:15 -0500
Received: from [192.168.1.27] ([84.220.25.125])
        by smtp-33.iol.local with ESMTPA
        id 5CfjntnTJ06Tn5CfknLZOK; Wed, 05 Jan 2022 21:14:12 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1641413652; bh=yHEojmocK9TWBc4FHtjuB7R8kFVmZk4wfht12bEQpyg=;
        h=From;
        b=iHgmbIO+0BFJs042TWbfzh0K0Gnbxh2gfDT6T/+Z3UKCvN4IId+Dj9qDAEwIBVge+
         KwtGdtifh3qznRd8gdg1asl0kPaJBTeURLfvWxET3l49ZsUCrtjC7fk1kWW7TpwLK6
         LjT0ZoXayCLGU3k4TyTRUaWTkwwRmaa5evOMvVr5xvXn48pWLns4UnH0RvpU3FASJo
         0xPdU0qxRQIuAYe40ehLEAEg1oEivrRqB6FfdL4PgREXEQTID7NNh2fRXnjZ1kqfKv
         FXsy0rfsBjm7cEyOVDULRPkrZ8lIhdvg+Fs1T62tj4om+xwkb1KKMVzUnih0DH2OKP
         60w5oZejrtGKA==
X-CNFS-Analysis: v=2.4 cv=YqbK+6UX c=1 sm=1 tr=0 ts=61d5fc14 cx=a_exe
 a=hx1hjU+azB0cnDRRU3Lo+Q==:117 a=hx1hjU+azB0cnDRRU3Lo+Q==:17
 a=IkcTkHD0fZMA:10 a=WIu3bSBCG8wpN1xyVY8A:9 a=QEXdDO2ut3YA:10
Message-ID: <bbdea835-79ce-cebc-fadc-115d8bff7162@inwind.it>
Date:   Wed, 5 Jan 2022 21:14:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH][TRIVIAL] btrfs-progs: Allow autodetect_object_types() to
 handle the link.
Content-Language: en-US
From:   Goffredo Baroncelli <kreijack@inwind.it>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org
References: <f4345fcac83ba226efdadcd4610861e434f8a73e.1641389199.git.kreijack@inwind.it>
 <YdXaZP27ALM6KJ9G@zen> <d4132584-faef-713e-aa7f-542257de3cfd@libero.it>
 <YdXsD+oQ8Z3DNYtG@zen> <9a261326-716b-69b6-9e95-bd5e1942e6bd@inwind.it>
In-Reply-To: <9a261326-716b-69b6-9e95-bd5e1942e6bd@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKXRxCBwjiWw33chMAzI53wlT39wsPl8FZb7L1Ekg6QA14fLKelbjfzSttW/Ba9beuFLCmUsT5PG9sHN4RVw6GNShP+MQRanMToHW/ofcz3P9Kn4GbyT
 cu4b5EhxDIWIldA02zptEJpYJYIyszZ6hMajU96k66vlvwjUSMpARtUodwzQjuNq7TNF1J5ER3GPf9ApkQi+GuVrJdPWRsU8rSGN7j1SZCMdYLwSkCeOkBgV
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,
On 05/01/2022 20.14, Goffredo Baroncelli wrote:
> On 05/01/2022 20.05, Boris Burkov wrote:
>> On Wed, Jan 05, 2022 at 07:23:33PM +0100, Goffredo Baroncelli wrote:
>>> On 05/01/2022 18.50, Boris Burkov wrote:
>>>> On Wed, Jan 05, 2022 at 02:32:58PM +0100, Goffredo Baroncelli wrote:
>>>>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>> [...]
>>>>
>>>> I took a look at the original lstat and it doesn't seem super strongly
>>>> motivated. It is used to detect a subvolume object (ino==256) so I don't
>>>> see why we would hate to have property get/set work on a symlink to a
>>>> subvol.
>>>
>>> It is not so simple: think about a case where the symlink points to a
>>> subvolume of *another* filesystem.
>>>
>>> Now, "btrfs prop get" returns the property (e.g. the label) of the *underlining*
>>> filesystem. If we change statl to stat, it still return the property of the
>>> underlining filesystem, thinking that it is a subvolume (of a foreign filesystem).
>>>
>>> If fact I added an exception of that rule, because if we pass a block device, we
>>> don't consider the underling filesystem, but the filesystem contained in the block
>>> device. But there is a precedence in get/set label.
>>>
>>> Anyway, symlink created some confusion, and I bet that in btrfs there are areas
>>> with incoherence around symlink between the pointed object and the underling
>>> filesystem.
>>
>> Good point. I agree that btrfs (the tool) is not the most rigorous with
>> symlinks. In this very function, we check if it is a btrfs object by
>> opening the file without O_NOFOLLOW, but then we do this lstat.
>>
>> I'm not exactly sure what you are alluding to regarding the precedent set
>> by label, but I tested links and labels and it seems to exhibit the link
>> following behavior.
>>
>> mkfs.btrfs -f /dev/loop0
>> mkfs.btrfs -f -L LOOP /dev/loop1
>> mount /dev/loop0 /mnt/0
>> mount /dev/loop1 /mnt/1
>> ln -s /mnt/1 /mnt/0/lnk
>> btrfs property get /mnt/0 label
>> label=
>> btrfs property get /mnt/1 label
>> label=LOOP
>> btrfs property get /mnt/0/lnk label
>> label=LOOP
>> btrfs property get /mnt/0/lnk ro
>> ERROR: object is not compatible with property: ro
>>
>> So it looks like root detection follows links but subvol detection does
>> not. Without testing, but judging by the code, I think inode follows
>> symlinks too. So with all that said, I think the most consistent is to
>> make subvol follow the symlink, unless you have a really confusing
>> unexpected behavior in mind with links out to another btrfs that I am
>> failing to see.
> 
> Hi Boris,
> 
> you are right. I didn't consider that open(path) follows the symlink too.
> So I will update the patch  changing statl() to stat() and removing the
> 2nd stat invocation.

Only now I noticed that the code behind set/get_label works only with
"regular" file or "block" device.
This may be a more cleaner solution to avoid this kind of ambiguity.

Of course we can add exception where required.

BR
G.Baroncelli

> BR
> G.Baroncelli
> 
>> Thanks,
>> Boris
>>
>>>
>>> BR
>>> G.Baroncelli
>>>
>>> -- 
>>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
>>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> 
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
