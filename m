Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50B6459BFE
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 06:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbhKWF7h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Nov 2021 00:59:37 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44450 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhKWF7h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Nov 2021 00:59:37 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1A77D1FD5A;
        Tue, 23 Nov 2021 05:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637646989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wiE9MWuNPVe/4672OdmVu7RzDSjfGMTsGo5uyrwa/qY=;
        b=VghV41zJS9nn/VazEMB92SWnsn8m1xu+YctwiBkdpGWQ4ov1UdMiHROAn9ygnxMGdrC+Uh
        bHWWT0ez0KN90AFX9jflePOmGK5naz9y5q+dfT82jrjGp4eVfwNG1Kaevl3PG7gr/pYAwU
        ltI6sFleNyjbFSUEGN0pAoLa+N5AIMs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D16AA13CE1;
        Tue, 23 Nov 2021 05:56:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sb+pLIyCnGGMQgAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 23 Nov 2021 05:56:28 +0000
Subject: Re: read time tree block corruption detected
To:     x8062 <ericleaf@126.com>
Cc:     linux-btrfs@vger.kernel.org
References: <56d93523.27d4.17d461bc3c6.Coremail.ericleaf@126.com>
 <aed20fe5-4e7d-9f0f-ee39-1b584d8572f0@suse.com>
 <7f681c79.4eba.17d471d802e.Coremail.ericleaf@126.com>
 <fe1ce96b-e483-b698-f0f4-9eb8d9ad0634@suse.com>
 <46d6bc87.14b4.17d4aacd1dc.Coremail.ericleaf@126.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <c5abf17e-85bc-c9ed-2c97-c323dc19f3f9@suse.com>
Date:   Tue, 23 Nov 2021 07:56:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <46d6bc87.14b4.17d4aacd1dc.Coremail.ericleaf@126.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 23.11.21 §Ô. 4:42, x8062 wrote:
> At 2021-11-22 18:36:41, "Nikolay Borisov" <nborisov@suse.com> wrote:
>>
>>
>> On 22.11.21 §Ô. 12:07, x8062 wrote:
>>> At 2021-11-22 15:24:38, "Nikolay Borisov" <nborisov@suse.com> wrote:
>>>>
>>>>
>>>> On 22.11.21 §Ô. 7:26, x8062 wrote:
>>>>> Hello,
>>>>>  I got periodic warns in my linux console. in dmesg it is the following pasted text.
>>>>> At https://btrfs.wiki.kernel.org/index.php/Tree-checker I learned it may be a error, so i send the message. Hopefully it could help, Thanks in advance!
>>>>>
>>>>> [  513.900852] BTRFS critical (device sdb3): corrupt leaf: root=381 block=71928348672 slot=74 ino=2394634 file_offset=0, invalid ram_bytes for uncompressed inline extent, have 393 expect 131465
>>>>>
>>>>
>>>>
>>>> You have faulty ram, since 393 has the 17th bit set to 0 whilst has it
>>>> set to 1. So your ram is clearly corrupting bits. I advise you run a
>>>> memtest tool and look for possibly changing the faulty ram module.
>>>
>>> Thank you, can't believe the ram is not so stable.  I'll run a memtest later.
>>
>> Actually according to the output this is a read-time corruption. THis
>> means the corrupted data has already been written to disk, likely by an
>> older kernel that didn't have the tree cherk code. So running a memcheck
>> is still useful to prevent future corruption.
>>
>> As far as the corrupted files goes - well its data is corrupted. It can
>> technically be fixed, but you'd have to do it yourself. Or alternatively
>> go back on an older kernel i.e pre- 5.11 and try to copy that particular
>> file (inode 2394634).
>>
>>>
> I find some problems here.  I use the command "find . -inum 2394634" in the btrfs root dir,  but nothing printed.
> does "root=381" means the subvolume ID=381? but now I don't have such subvolume. I deleted some of the

Yes root is the id of the subvolume, if you have deleted it then the
corrupted inode should also be gone.


> subvolumes a few days ago. this is the current subvolume list(some of the dir name shortened)
> sudo btrfs subvol list .
> ID 263 gen 111732 top level 5 path 8007/a
> ID 354 gen 111729 top level 5 path 8007/b
> ID 622 gen 111757 top level 5 path f015
> ID 1174 gen 111758 top level 5 path cc
> ID 1326 gen 111757 top level 5 path 8007/c
> ID 1781 gen 111740 top level 5 path ip
> ID 1782 gen 111758 top level 5 path og
> ID 1856 gen 111586 top level 1782 path og/OG/DB/server
> ID 1858 gen 111757 top level 622 path V6/db
> ID 1875 gen 111742 top level 5 path sdk
> ID 1918 gen 111742 top level 5 path 8015
> ID 1942 gen 111745 top level 5 path ip6
> ID 2007 gen 111758 top level 5 path mnew
> ID 2114 gen 111751 top level 5 path dd
> ID 2116 gen 111760 top level 2117 path ds/trunk/20200616
> ID 2117 gen 111758 top level 5 path ds
> ID 2118 gen 111758 top level 2114 path dd/trunk/sourcecode
> ID 2119 gen 111751 top level 2114 path dd/b/1103
> ID 2120 gen 111761 top level 5 path tt
> 
