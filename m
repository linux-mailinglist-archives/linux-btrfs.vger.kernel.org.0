Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C33E3E4D2A
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Aug 2021 21:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbhHITig (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 15:38:36 -0400
Received: from smtp-32.italiaonline.it ([213.209.10.32]:58993 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232334AbhHITie (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Aug 2021 15:38:34 -0400
X-Greylist: delayed 494 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Aug 2021 15:38:34 EDT
Received: from venice.bhome ([78.14.51.162])
        by smtp-32.iol.local with ESMTPA
        id DAyDmeiNCPvRTDAyDmQIru; Mon, 09 Aug 2021 21:29:57 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1628537397; bh=LnZW1w6cHPeA1K5XITjhPzQiLTk1tEKTPF2DbkHzUIo=;
        h=From;
        b=hqREgUKny4Z8Gg8MRfkymNcZoBMBTQQILtyVE5fXFC4iqfehVVD3xVbhLpDGpTDVm
         4Rg8bu07lFOAmvgUWcpzRzfLoROA9II5rvHcjOcVBao0jdR2H+80s6NUxnS2LZoM/v
         1mGLsYi20O3bqJvo+Um+2CZ2iivhSA8MHdqPC4fp8ImqtJ43fNGX5HRyFO+4j5gPbj
         2Nmh34AjuBiEXWbbSlYkelMviXQdm2aVBqbY0qKpTKVhp7CklliJcRkA3QHl+X09ju
         GfrCHYe0w+TF5yNEWeyQ9cUTU+k7XSzpCXHpZwcuX3SZRd7vC3g78iPNW3pFfa3920
         EfkGrNPlE0hvw==
X-CNFS-Analysis: v=2.4 cv=NqgUz+RJ c=1 sm=1 tr=0 ts=61118235 cx=a_exe
 a=Ti6mTMNpdsGjMP8CvYbp9A==:117 a=Ti6mTMNpdsGjMP8CvYbp9A==:17
 a=IkcTkHD0fZMA:10 a=CngwRIvfAAAA:8 a=jzo5RBZyaXkscuvRem0A:9 a=QEXdDO2ut3YA:10
 a=4_miDDMz0JLoEzr4jVLQ:22
Reply-To: kreijack@inwind.it
Subject: Re: why is the same mount point repeatedly mounted in nested manner?
To:     Dave T <davestechshop@gmail.com>, devel@roosoft.ltd.uk,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc:     Phillip Susi <phill@thesusis.net>, kilobyte@angband.pl
References: <CAGdWbB59ULVxpNnq5Og0SCri+qyz_cwDLFTLr5N7iVT9gb0w1A@mail.gmail.com>
 <c906060a-9dbc-e5d1-8e85-832408249b4d@casa-di-locascio.net>
 <CAGdWbB5Z=ARmsU66k7O3Hp=RcMTr-wV5Z880FvMdqN=m3c8Epw@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <6f133a41-dbd6-ce42-b6aa-ae4e621ce816@libero.it>
Date:   Mon, 9 Aug 2021 21:29:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAGdWbB5Z=ARmsU66k7O3Hp=RcMTr-wV5Z880FvMdqN=m3c8Epw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfIVVzFDcOflsmRGOCR/mC+MgpUKTXuSlfmEMmR3ZmFL48KXHXe1zr4fsvMRnSpXhMqb82JyP9sN8/TjUWz7vG7YZuipkBuhDvhLdSfqNpvqwk3Oz8X/v
 8djkIg2fT4c/L6w28q2rQmEmoV6WkqHAqkvWls8XzWindribV39LZX/T2U7gs00nCoUQTl1K5PimLyhN1qqgL0BDc/V0tA1O7Y8F1fqmUB0Y1V9N4wQlCiwS
 +l0t5WPWGDh6s7LRW+yc/cq75vcAcpxEPMxD/NQiR0SGRKcf9EWzEE4k9wltm/X4iOTDHRYwat9ieaLKgGKMtg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/8/21 9:48 PM, Dave T wrote:
> On Sun, Aug 8, 2021 at 8:10 AM <devel@roosoft.ltd.uk> wrote:
>>
>> On 05/08/2021 17:46, Dave T wrote:
[...]
>>
>> Try mounting the subvolume with it's subvolume ID. System only generates
>> unit files from the fstab it does not follow them , so if you are vague
>> in your fstab the systemd unit files will also be vague.
> 
> Thank you for the tip. I appreciate your interest in my issue.
> However, I don't fully understand what to change.

I think that Alexander is suggesting to add something like ',subvolid=5' to the line of fstab where /mnt/btrtop/root is mounted.

I add that if it is a systemd bug, it would help to look at the .mount files generated by systemd:

$ sudo ls /run/systemd/generator/*.mount
....

Can you share the content of the  systemd units where you ask to mount '/mnt/btrtop/root' ? It could help the diagnose.

And finally, what happens if you mount/unmount from command line (e.g. manually) /mnt/btrtop/root ?

BR

> Here are the relevant lines from my fstab. I added line numbers
> because the lines will get wrapped in email.  I don't see what part of
> this is vague:
> 
> 1. # cat /etc/fstab
> 2. UUID=28D099A-9D92-487C-8113-A231CAD0EEF2  /     btrfs
> rw,noatime,nodiratime,compress=lzo,space_cache,subvol=/@btrtop/snapshot
> 0 0
> 3. UUID=28D099A-9D92-487C-8113-A231CAD0EEF2  /mnt/btrtop/root  btrfs
> noauto,nofail,rw,noatime,nodiratime,compress=lzo,space_cache    0 0
> 4. /var/cache/pacman       /srv/nfs/var/cache/pacman       none  bind  0 0

I don't know if it matters, but why you set as 'none' the filesystem type ? However according to askubuntu/stackoverflow it seem the right thing to do...

> 
> The path /var/cache/pacman is not a subvolume, but it resides on btrfs
> subvolume @btrtop/snapshot. @btrtop/snapshot is normally mounted at
> "/" but for btrfs tasks, it is also mounted at /mnt/btrtop/root. This
> additional mount operation seems to be causing these nested mounts of
> my bind mount for  /srv/nfs/var/cache/pacman .
> 
> P.S. I cannot test without using systemd. (I'm not even sure I
> remember how to use a non-systemd distro anymore!)
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
