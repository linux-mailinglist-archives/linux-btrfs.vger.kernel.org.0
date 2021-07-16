Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE943CB7DB
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jul 2021 15:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbhGPNbG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 09:31:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:56703 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239391AbhGPNbF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 09:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626442088;
        bh=7830gd1Ne4xy8P4uRVhHZ4LLOyXZ3roOSnzgE88iRGQ=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=XT+b+SYnHJ6YLNEmY36EwEocVJdu+tgpBeXwfzwk/Igt09uhx5YMOIzOdqp9WStxm
         jMcUnLA9vzTf6BI1mxYLgveIYH8AAkfdBEN3s29Sa4Qi0AHWTBpC+H7yiQ+RI8fjKx
         CfvZoP7MyE/TBMJKVWdVmulBmENgInTcRPsa8234=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRmfi-1lgpeH3HHW-00TDMf; Fri, 16
 Jul 2021 15:28:08 +0200
To:     Dave T <davestechshop@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGdWbB6qxBtVc1XtSF_wOR3NyR9nGpr5_Nc5RCLGT5NK=C4iRA@mail.gmail.com>
 <3be8bba9-60cd-2cce-a05d-6c24b8895f3f@gmx.com>
 <CAGdWbB44nH7dgdP3qO_bFYZwbkrW37OwFEVTE2Bn+rn4d7zWiQ@mail.gmail.com>
 <43e7dc04-c862-fff1-45af-fd779206d71c@gmx.com>
 <CAGdWbB7Q98tSbPgHUBF+yjqYRBPZ-a42hd=xLwMZUMO46gfd0A@mail.gmail.com>
 <CAGdWbB47rKnLoSBZ7Ez+inkeKRgE+SbOAp5QEpB=VWfM_5AmRA@mail.gmail.com>
 <520a696d-d747-ef86-4560-0ec25897e0e1@suse.com>
 <CAGdWbB6CrFc319fwRwmkd=zrVE4jabF0GTpqZd5Jjzx2RcAo9Q@mail.gmail.com>
 <e4cc8998-fc9e-4ef3-3a49-0f6d98960a75@gmx.com>
 <CAGdWbB6Y0p3dc6+00eTnf1XSS1rUMbPUckQabi6VJQXdjRt2jg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: bad file extent, some csum missing - how to check that restored
 volumes are error-free?
Message-ID: <88005f9b-d596-f2f9-21f0-97fc7be4c662@gmx.com>
Date:   Fri, 16 Jul 2021 21:28:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAGdWbB6Y0p3dc6+00eTnf1XSS1rUMbPUckQabi6VJQXdjRt2jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wmNIshKC4oDMHIjoTdMnACQQYvAt9f0/JTHS6DOJT8ZMqr63dnd
 BhwrDuUtS0WNEKsLpzAjKXU8KYTeZpMVOV6OzUaVAFyPP0TeecH2+QP4qNz6Z7dL3kp6zjQ
 EzfDcFAcESOaCY759fmc9j57u1K6aRcEQPlUnvpPQbBoGczAlEA76y9Y5OfoTw82ubvKwMb
 4oKhYOKhAgdzD8c15zT8g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ji5JiPRuArw=:GA+2ZHqxoDuf31kL+2TuG4
 5ZKlKcV/8TQGsvChsN1OHghGwnCUYdHeFoLtXwIjH88F50ijkzu2gzmf4yxQV2N6ryRztxcqU
 gsJKbxRWRWCwmZu2v7QQRl0NmixdtQGZsoTa5I9LSF5NjyJoYt8kg4ZbroKBQK7xItUTIOoEb
 wReXJBK4L++KC5iaFsdJBdQWZIEA8lVrEUiwsp4DQjBh1b5EiHZ3x/ub9m7/jnZzhDJZ1lVuz
 c078HQ+6paNfqleqjlhYsClq1A8lXx8Ujy0S9pARrHrFBUd+X1O3S+2swRx+tRdiytBctb+GP
 SHE1CvTYd1aQdF8Arg9qUkRbSDuAhfnDHlNgXfX3JT4ACJf3f+QapH1sJWjEsNercPkZ5vu8T
 5Hne+F2iMAGeFvCrc68w1agkra4/FJW77f+R8sc7QqwctGBjbRCDNsyMjUz5JEpKlmZ97SasZ
 beoruVqdfBL7HjgYwp0yBXUn1ImVB0WG26NpBoh6p2mXxWWI29kK4PwnZBDq7cE3WB6z8vqPF
 nauBBeqiIjvk3hZDyqGEVOD25xWpEgEPhDX7Q36YmABYR09RQMpY/IWUghBNHuAMjWcgxgxfM
 13UNBqsKs2dDv1VpP3lFj2svZX/CPodlXNw55Q98mFjy0Zr5OR2qUt1J+J3pdfD0hfJHdapWz
 vJYJLIPwpJsgvJqbM7CexU0SJm5Uj7kvU5tIY3j3bzYqYX8ktkUg0TWDOPBpE0KIbcE3WRkLr
 NlMs/8ScYK8dj2QyN+7eHijfo7MecwXvwTZTMJmeh5hi4fCnbrrfMV/qfGUx5NaNpAAeGhvnI
 wGhGA8WXUrBlwW3w9f+0gkKGfn682jUgsXXZ2l8GfaGXoEzBm6J1I5RnBIku5nSeX6paIgIyv
 TfE6WIGB0fSsWhimSmy85xDxY9HDl9+z0/agkfWVlnZ0F5b0RqhX1N0F+EDRVAe/ZP7NzRljf
 ILeT087E5X7ctK71ehD0wNbOmWeC094vUOKdFpZak8FqSbHVhGVMqSWQduCi17MBYMHb8bTpj
 rAp/i4heZXmjk+JLI4skKfaVNnh1u3Gd3c7YSJ8N8xA81FnGNejU4wEW0l57YjyrxYdXJQUkI
 5K5uJz7gaUQnTbkhQOGmxveFKQQL9+HAnLSk+ZeYkQQDBVr8PfDo2bwPA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/16 =E4=B8=8B=E5=8D=889:15, Dave T wrote:
> On Thu, Jul 15, 2021 at 9:05 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>> I've been running arch + btrfs since 2014. I keep arch linux fully
>>> updated. I'm running new kernels and new btrfs progs. However, I
>>> created this filesystem around 2014.
>>
>> The change that don't allow allow compression if the inode has NODATASU=
M
>> option is introduced in commit 42c16da6d684 ("btrfs: inode: Don't
>> compress if NODATASUM or NODATACOW set"), which is from v5.2 in 2019.
>>
>> Thus such old fs indeed can be affected.
>>
>>>
>>> Is there an option to "update" my BTRFS filesystem? Is that even a thi=
ng?
>>
>> I don't think so, but please allow me to do more testing and then I may
>> craft a fix in btrfs-progs to allow btrfs-check to repair such problems=
.
>
> I hope that there is soon a way to run a btrfs-progs command to update
> an old filesystem to the current standards.
> Where can I send you a small donation to express my support for
> something like this?

No need, we're a open community and I have a day job (working on btrfs).

>
>>
>> If possible I would enhance kernel to handle such existing file extents
>> better so that what you really need is just run "pacman -Syu" as usual,
>> nothing to bother.
>
> This would indeed be a fantastic solution!
>
>> So I'm afraid there is something different involved for your read error=
 problem.
>
> I am less worried about this specific problem than about the general
> problem of having an old filesystem on a fully updated rolling release
> linux system. I was able to restore all my data to a new SSD and I am
> just testing this old SSD to give you feedback.
>
> However, I do have some general questions. As it stands currently,
> what exactly is an "old filesystem"? If I run "mkfs.btrfs" with linux
> kernel v5.1, is all data in that filesystem somehow affected even
> after I install newer kernels?

It's not about the mkfs, but the data write using older kernels.

You can even have mkfs from v5.12, then mount with v5.1, and write some
data, then you may have the file extents described above.

> Or are files created when running the
> newer kernel not affected? What about files copied?

If using newer kernel, btrfs won't create any compressed extents if the
inode has NODATASUM flag.

So your "files created when running the newer kernel not affected" part
is correct.

File copied counts as the same.

>
> If I do a btrfs send|receive from a fs originally created in 2014 but
> now I am running the latest arch linux kernel, what is the result?

Btrfs receive is just doing the file writes in user space.

Then the newer kernel will follow its new behavior, so received files
are all fine.

> Do
> my transferred files still have hallmarks of the 2014 filesystem they
> originally lived on?

Nope.

>
> Are there some checks I should do now on my other devices with btrfs
> filessystems originally created around 2014? (I have a lot of such
> devices because in 2014 I decided to run arch linux and btrfs
> everywhere.)

No need at least for the compressed file extents with NODATASUM inode
problem.

Kernel is able read it without problem.

Thus that's why I can't reproduce your original problem.

>
>> When the read error happens, is there really no extra kernel error mess=
age?
>
> I can do more testing and let you know. Can you suggest any tests you
> would like me to try?

1. Try to read the affected file:

- Mount the btrfs

- Read inode 262 in root 329 (just one example)
   You can use "find -inum 262" inside root 329 to locate the file.

   If you have a file you know you can't read, that would be the best
   case, just try to read that.

- Unmount the btrfs

- Attached the full dmesg.


2. Reproduce the Read-only fs problem.

- Find a way to reproduce the read-only fs problem
   If you don't have a reliable way to reproduce it, just ignore this
   part.

- Attach the full dmesg

Thanks,
Qu

> I could run "journalctl -f" in one window and do
> some file operations in another program, for example. But I am not a
> developer, so there may be limits on what I can do.
>
> Thank you.
> Dave
>
