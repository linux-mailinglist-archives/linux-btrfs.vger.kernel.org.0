Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43AC2B5298
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Nov 2020 21:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732853AbgKPUbs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Nov 2020 15:31:48 -0500
Received: from smtp-33.italiaonline.it ([213.209.10.33]:32961 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726545AbgKPUbs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Nov 2020 15:31:48 -0500
Received: from venice.bhome ([78.12.13.253])
        by smtp-33.iol.local with ESMTPA
        id elA9kuKcW3OuqelA9kKTot; Mon, 16 Nov 2020 21:31:46 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1605558706; bh=OJ/UFXWi0YVkobcsi6yYtolkWsMOztrpxt5uFRs9dr4=;
        h=From;
        b=VhSZ2u1ktJba6EZtHrHntk24xCLix7BPhhHXBqwknSbGlTqOQ2tG7vPs8wU55ikb6
         iZKGuy9KnUqPrHXYGbec+pz8+osACrD8E1jD3OQomyTKMS3H3YyGOKxNp7qx27ward
         zOPN2oOfdq9QanEF2hfuYFwstk8GzQlmsj4LqjsZfhjKIarlCgOelEc3y4sE6QJdBG
         SX/rdJFAziBbKfoHIUNRSMoCX8mrK39r7E/bxTJFYEijqMha+sW8GXMgmYKPkjndmL
         qYRIFHIa/jqK4XNgzwAaxxPx3Hyp7blymjgbHsm10sEvwYoLzhw/ns7DJ6YQB8l6dJ
         W8Qe3ZrqhsYPw==
X-CNFS-Analysis: v=2.4 cv=QsqbYX+d c=1 sm=1 tr=0 ts=5fb2e1b2
 a=/wH+qUy177TbbkLmURH56g==:117 a=/wH+qUy177TbbkLmURH56g==:17
 a=IkcTkHD0fZMA:10 a=53bSS9-dAAAA:8 a=YnUW0e-6AAAA:8 a=wg26W9nZXxhoUgM8xtYA:9
 a=QEXdDO2ut3YA:10 a=hvwp6Qn3CI4-pKiLlCxl:22 a=eZiiwcSiWTUpXJe4K-to:22
Reply-To: kreijack@inwind.it
Subject: Re: bizare bug in "btrfs subvolume show"
To:     Lawrence D'Anna <larry@elder-gods.org>,
        Roman Mamedov <rm@romanrm.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Meghan Gwyer <mgwyer@gmail.com>
References: <61E331A6-9DA8-4A7C-905E-4B5A17526020@elder-gods.org>
 <8EFE06A3-9CC4-4A6A-850F-C7C57DC27942@elder-gods.org>
 <20201115145323.1628d710@natsu>
 <C20FAB48-98B0-49AE-B804-FC720E31C5B0@elder-gods.org>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <e954d760-28c1-9491-cd60-8e7dfc626ca4@libero.it>
Date:   Mon, 16 Nov 2020 21:31:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <C20FAB48-98B0-49AE-B804-FC720E31C5B0@elder-gods.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfL8PqHej/ZhM1MqzTdl5nzG/ghDPxAmBO37IPmPqi6KM4WBTKMe+SAzDs4ybr1lp5FWWPqHacS2XflA+vuHpXjddyfNvMZ8+wBA9Hw31lMefuxacao1c
 qGdeTv9N7Smmjkw5IO1z1MgmHnmh1oGrheDfJhGq146pr+Rml7ZDuf6aTY0qraC75VVCNY3CfJsoh38uViUVsnnqtQpRk9z5aFFr+meAgLCD8eyeainRdFW9
 jOKQHjnXehVPtCh52UIkBB3jHJiXRjiquJ/jFOSLPTA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/16/20 3:09 AM, Lawrence D'Anna wrote:
> 
> 
>> On Nov 15, 2020, at 1:53 AM, Roman Mamedov <rm@romanrm.net> wrote:
>>
>> This still sounds very puzzling, as to how output redirection could affect
>> things. Perhaps you could run "btrfs sub show" with "strace"? Both with and
>> without the redirect to see exactly what was the call sequence, parameters and
>> return values, to compare and find where the difference starts.
>>
>>
> 
> The first meaningful difference occurs at this ioctl:
> 
> --- /dev/fd/63	2020-11-15 18:06:23.000000000 -0800
> +++ /dev/fd/62	2020-11-15 18:06:23.000000000 -0800
> @@ -1,84 +1,84 @@
>   ioctl(3, BTRFS_IOC_TREE_SEARCH, {key={tree_id=BTRFS_ROOT_TREE_OBJECTID,
>   min_objectid=BTRFS_FS_TREE_OBJECTID, max_objectid=BTRFS_FS_TREE_OBJECTID,
>   min_offset=7274, max_offset=UINT64_MAX, min_transid=0, max_transid=UINT64_MAX,
>   min_type=BTRFS_ROOT_REF_KEY, max_type=BTRFS_ROOT_REF_KEY, nr_items=4096}} =>
>   {key={nr_items=53}, buf=[{transid=56320, objectid=BTRFS_FS_TREE_OBJECTID,
>   offset=7274, type=BTRFS_ROOT_REF_KEY, len=43}, {transid=56570,
>   objectid=BTRFS_FS_TREE_OBJECTID, offset=7275, type=BTRFS_ROOT_REF_KEY, len=43},
>   {transid=56570, objectid=BTRFS_FS_TREE_OBJECTID, offset=7276,
>   type=BTRFS_ROOT_REF_KEY, len=43}, {transid=56570,
>   objectid=BTRFS_FS_TREE_OBJECTID, offset=7277, type=BTRFS_ROOT_REF_KEY, len=43},
[...]
> -{transid=56570, objectid=BTRFS_FS_TREE_OBJECTID, offset=7290,
> +{transid=56570, objectid=BTRFS_FS_TREE_OBJECTID, offset=7168,
>   type=BTRFS_ROOT_REF_KEY, len=43}, {transid=56570,
>   objectid=BTRFS_FS_TREE_OBJECTID, offset=7291, type=BTRFS_ROOT_REF_KEY, len=43},
[...]
> 
> A little while later they diverge again when the good side does a BTRFS_IOC_TREE_SEARCH for
> 7290, and the bad side does it for 7168, which fails.
> 
> Full traces are at https://odin.elder-gods.org/btrfs-bug/a  and https://odin.elder-gods.org/btrfs-bug/b
> If you’d like to see them
> 

Definitely it is a strange behavior. The value 7168 should be the wrong one because it is out of order.
Are you sure that this behavior depends *only* by the redirect ?
If you ran "btrfs subvol show /data/" several time, you always get the same (good) value ?
And if you do it with a redirect, you always got the wrong one ?

You have a raid10 profile, so an explanation is that sometime you read from the good drive (where there is the value 7290) and sometime from the bad one (where there is the value 7168).
However this should be impossible because
1) the metadata is protected by a corruption by the checksum (may be the checksum is different in each mirror ?)
2) and it should be not strictly related to the redirection. The mirror from which the kernel reads is decided on the value 'pid % 2'.

BR

> 
> 
> 
> 
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
