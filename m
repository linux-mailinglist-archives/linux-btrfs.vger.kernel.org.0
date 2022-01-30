Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4164A3554
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Jan 2022 10:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354450AbiA3J1d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Jan 2022 04:27:33 -0500
Received: from smtp-32.italiaonline.it ([213.209.10.32]:35693 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234034AbiA3J1d (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Jan 2022 04:27:33 -0500
Received: from [192.168.1.27] ([78.14.151.50])
        by smtp-32.iol.local with ESMTPA
        id E6UcnzoHj7xUJE6UcnF9Q5; Sun, 30 Jan 2022 10:27:31 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1643534851; bh=l2qr0Ot+iQOtUxPoHprVFDCZMYw6DpkXjXEuPhpKVGA=;
        h=From;
        b=u0ITDkgv5sLTgi2sq3w3nXjjVpr3cRB9M/aJb6vWMuY05mvCcfasj+wULRj1n+pIh
         jRAiJjMKhCKKRb68RWEYoGEtQ0goQaKIyiU5iNK2Tvvdoc61gMVUqrIisQDr+rsM1G
         BYFWd59HWzZTZuZWPu8WoYNgS6JE4kshDq99LgCmSTXyG6KNwceAVfr7BZ2G1iRCNr
         8aqki2miKbdA8rdFul77MCywjnjiZramrcErKLK4hs9ORtqeuxZmlT6uGMieokCxNb
         psYbUTJSHc7W2YTRb0QqSon4uPMUnthYCPwpscZPI15ZtGQsI6GlEE0JXMaxEW0/6d
         o/nFkqPSPO0cg==
X-CNFS-Analysis: v=2.4 cv=cLAlDnSN c=1 sm=1 tr=0 ts=61f65a03 cx=a_exe
 a=d4nNsk+SGr75ik5id+62uA==:117 a=d4nNsk+SGr75ik5id+62uA==:17
 a=IkcTkHD0fZMA:10 a=QILv0SivDTG5BuEJCEUA:9 a=QEXdDO2ut3YA:10
Message-ID: <295c62ca-1864-270f-c1b1-3e5cb8fc58dd@inwind.it>
Date:   Sun, 30 Jan 2022 10:27:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: kreijack@inwind.it
Subject: Re: No space left errors on shutdown with systemd-homed /home dir
Content-Language: en-US
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Boris Burkov <boris@bur.io>, "Apostolos B." <barz621@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        systemd Mailing List <systemd-devel@lists.freedesktop.org>
References: <9bdd0eb6-4a4f-e168-0fb0-77f4d753ec19@gmail.com>
 <YfHCLhpkS+t8a8CG@zen> <4263e65e-f585-e7f6-b1aa-04885c0ed662@gmail.com>
 <YfHXFfHMeqx4MowJ@zen>
 <CAJCQCtR5ngU8oF6apChzBgFgX1W-9CVcF9kjvgStbkcAq_TsHQ@mail.gmail.com>
 <042e75ab-ded2-009a-d9fc-95887c26d4d2@libero.it>
 <CAJCQCtQv327wHwsT+j+mq3Fvt2fJwyC7SqFcj_+Ph80OuLKTAw@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <CAJCQCtQv327wHwsT+j+mq3Fvt2fJwyC7SqFcj_+Ph80OuLKTAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPWN7QxykSe3RNk5zpVs+ZnF5i27KvN9SjXaHRNFDJpi4ioQjmdnjb0Y81wqcCywGc9ya3QVgJS8/gRpwEneG08pfu7/1WDJMq8F7br7I8dsJJoUfCi0
 SZGcR4oYlUuN2A0hOlVDVzdoJJWEj7P4NFNgb8XpZlm/BomiGGuu5idc5WOMQAMgpYZiSiUaBmH/mnq0oH74kh0VqUzwucYU11Xa8SeoXnmySL+pYSuMkXsN
 3UbDd8nbgrBIHJY1TL6kAlMQVi4nE8xAkkhz4Sg3AO0HwiBmBRF3W3GTfgTsswIuCeBYoegKvWMfEGgqfCuutW0S4bfijf3+S39+rXViEoY=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/01/2022 19.01, Chris Murphy wrote:
> On Sat, Jan 29, 2022 at 2:53 AM Goffredo Baroncelli <kreijack@libero.it> wrote:
>>
>> I think that for the systemd uses cases (singled device FS), a simpler
>> approach would be:
>>
>>       fstatfs(fd, &sfs)
>>       needed = sfs.f_blocks - sfs.f_bavail;
>>       needed *= sfs.f_bsize
>>
>>       needed = roundup_64(needed, 3*(1024*1024*1024))
>>
>> Comparing the original systemd-homed code, I made the following changes
>> - 1) f_bfree is replaced by f_bavail (which seem to be more consistent to the disk usage; to me it seems to consider also the metadata chunk allocation)
>> - 2) the needing value is rounded up of 3GB in order to consider a further 1 data chunk and 2 metadata chunk (DUP))
>>
>> Comments ?
> 
> I'm still wondering if such a significant shrink is even indicated, in
> lieu of trim. Isn't it sufficient to just trim on logout, thus
> returning unused blocks to the underlying filesystem? 

I agree with you. In Fedora 35, and the default is ext4+luks+trim
which provides the same results. However I remember that in the past the default
was btrfs+luks+shrunk. I think that something is changed i.

However, I want to provide do the systemd folks a suggestion ho change the code.
Even a warning like: "it doesn't work that because this, please drop it"
would be sufficient.

> And then do an
> fs resize (shrink or grow) as needed on login, so that the user home
> shows ~80% of the free space in the underlying file system?
> 
> homework-luks.c:3407:                                /* Before we
> shrink, let's trim the file system, so that we need less space on disk
> during the shrinking */
> 
> 
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
