Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8D81FFDAE
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 00:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbgFRWFt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jun 2020 18:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731635AbgFRWFs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jun 2020 18:05:48 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB634C06174E
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Jun 2020 15:05:47 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s88so3364611pjb.5
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Jun 2020 15:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=lJNU/xxU/8zM18BzxpyeFpV6xYeeE/qLYB3sAQbxF6k=;
        b=WGvGD5RS/xNkMniMz0s+t4B4wYnCdBqCEeLshWApJaEojLeGcRXs7XD4hpr9Blmkb9
         pNhgjy383/YD2AA7sWtzEoB8i9d8w3aiXfpGE+hOCoDHeUeYWiTz+u2WYIzGXMjgPing
         RbYErIzU2FbH/jG00eEwv5lnZVonZ/YKg7hyPM6vjr0YMwnwo7B7iApQUJFQNmAF4TjK
         /lnTUgqCDqxBmdlHChzQenOQeNKDFWEajYdi8fpWoyOUhIzrOjiaLOH5LMlf4y2mN3mN
         QjikPDgfd3u8Jq3nQLLnm3rmQsC1+AhtxHFqnu7XmA0L0Qr+JHbYCd5iMzddfCVJYKmj
         8mMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lJNU/xxU/8zM18BzxpyeFpV6xYeeE/qLYB3sAQbxF6k=;
        b=icfK51M7SJJm6XZipTX78dhUWWjaT1cLRnT9+GLbi+v6WdiMX52VMFdqZeMboJJC85
         AeI4o+TjGcUkoXEFYv84BFyeF7YCATYnW6z4c5XfiyaCGQ/+uPukDU8dfEsfqkh/JRR2
         iugWgxspWX7hl2GShbCOie363XZr+hWKMK3mOqhR/nHlued7mRJqFHr8jgtAzqZccIPT
         Lf6PcGhoTLkAqkN8+Q31GFGTVkqNjYYw2I6eze2/bY7hZ1cOwJDV62Tt2qGXELOStdaA
         Dbhuk0UFlE8V0tTaMVELtvhzHOZ6zhO01AOAmeuvwHk1JsSd6vdUpbXz4yjHiySy9tx4
         +oPQ==
X-Gm-Message-State: AOAM532FWylZM8XX/Qalip5kXoh9/A3YUYoJgn/9Q86wykVx02EqfKWc
        PRGhCRxtXXsJha5zgZgKYJC7pc1y
X-Google-Smtp-Source: ABdhPJwiJ9JSQdB+nMlhUXHCXYWQQjtnCiE8m0iCPgZUm70GOV8pegcClsObpQd1+tzYhmMhUmXlhQ==
X-Received: by 2002:a17:902:c111:: with SMTP id 17mr5001575pli.319.1592517947271;
        Thu, 18 Jun 2020 15:05:47 -0700 (PDT)
Received: from [192.168.178.53] ([61.68.239.179])
        by smtp.gmail.com with ESMTPSA id q1sm3991114pfk.132.2020.06.18.15.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 15:05:46 -0700 (PDT)
Subject: Re: btrfs-dedupe broken and unsupported but in official wiki
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <16bc2efa-8e88-319f-e90e-cf8536460860@gmail.com>
 <20200618204317.GM10769@hungrycats.org>
From:   DanglingPointer <danglingpointerexception@gmail.com>
Message-ID: <65eeb90a-e983-2ae8-14ad-79bcd2960851@gmail.com>
Date:   Fri, 19 Jun 2020 08:05:44 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200618204317.GM10769@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For a large portion of desktop users that are not developers and are 
rustlang illiterate and programming illiterate; they would not now 
whether this tool or that tool or any tool would be safe, or unsafe, or 
have concurrent race conditions, or know the meaning of immutable or mutex.

Think of this scenario; average Joe Bloggs user buys new computer 
without MS Windows.  With the software savings, Joe purchases more 
disks. He then chooses openSuse Leap for his first foray into Linux.
All he cares about are his music files, photos, and videos being safe.  
Joe runs a Cafe down the street and uses the music, photos, and videos 
in various screens at his cafe for the atmosphere.
Times are tough and he's running out of space so he doesn't want the 
accumulate media files duplicated all around the place wasting space to 
conserve storage.

If the official wikis have broken 3rd party tools, then it makes the 
whole adoption process less easy, less friendly, very cryptic, more 
chaotic; and give the impression that btrfs is a mess and not ready (and 
Linux as a whole).  He would not know or have the time to go through the 
code of each deduplication program tool option to figure out if one type 
or the other type is better just like Zygo Blaxell did who can read 
code.  Even if he wanted to, he doesn't know how to nor has the time to 
do it.  He says good-bye to openSuse and buys Windows.

So I do agree with waxhead.  It would be preferable if there were an 
official btrfs deduplication command from btrfs-progs instead of relying 
on 3rd parties.  Joe Bloggs example above can read a web-page 
instructions saying "run this command... and then this command..."; but 
he will not have the knowledge, nor comprehension nor time to go through 
code.

Thanks David Sterba for removing the items and updating the wiki!

On 19/6/20 6:43 am, Zygo Blaxell wrote:
> The point about lack of maintenance with changing Rust dependencies is
> fair, but "data loss" is a strong and unsupported statement.  Can you
> explain how data loss could occur in even a badly (assume not maliciously)
> broken version of btrfs-dedupe?
>
> As far as I can tell, the btrfs-dedupe code uses only non-data-mutating
> btrfs kernel interfaces for manipulating extents (fiemap, defrag,
> and file_extent_same/deduperange).  None of these should cause data
> loss (excluding kernel bugs).
>
> btrfs-dedupe can be trivially tricked into opening files that it did
> not intend to (it has no protection against symlink injection and other
> TOCCTOU attacks), but it doesn't seem to be able to alter the content
> of files once it opens them.
>
> File descriptors pointing to user files are opened O_RDWR, but they are
> kept in the scope of the dedupe function and their life-cycle is properly
> managed in Rust, so btrfs-dedupe won't mutate files by writing to the
> wrong fd (e.g. accidentally close stderr and reopen it to a user file)
> unless someone adds some seriously buggy code (see "assume not malicious"
> above).
>
> The unsafe C ioctl interfaces are unlikely to change in data-losing ways,
> or they'll break all existing userspace tools that use them.  They are
> also well encapsulated in the rust-btrfs module.
>
> The errors reported on github seem to be problems with incompatible
> changes in the runtime libraries btrfs-dedupe depends on, and also some
> reports of what look like pre-existing bugs in the fiemap code that are
> blamed on new kernel versions without evidence.  Data-losing breaking
> changes in any of the ioctls btrfs-dedupe uses are extremely unlikely.
> Those issues may cause btrfs-dedupe to do useless unnecessary work,
> or fail to do useful necessary work, but could not cause data loss by
> any mechanism I can find.
>
> Contrast with bedup:  bedup uses data-mutating kernel interfaces
> (clone_range) for dedupe that have no effective protection against
> concurrent data modification.  There is ineffective protection implemented
> in bedup (looking in /proc/*/fd for concurrent users of the files) which
> may or may not be broken in kernel 5.0, but it's ineffective either way.
> The case for data loss in bedup is trivial.  The branch with a patch to
> fix it is now 7 years old, so it's fair to say bedup is unmaintained too
> (github forks notwithstanding, they didn't fix these issues).
>
