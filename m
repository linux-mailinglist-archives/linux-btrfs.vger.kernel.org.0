Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B49316FD7
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 20:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhBJTPQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 14:15:16 -0500
Received: from smtp-17.italiaonline.it ([213.209.10.17]:58970 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234553AbhBJTOz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 14:14:55 -0500
Received: from venice.bhome ([84.220.24.57])
        by smtp-17.iol.local with ESMTPA
        id 9uwDlrr9rlChf9uwDlAcHZ; Wed, 10 Feb 2021 20:14:09 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1612984449; bh=KsC6+/vz9L/CBbymlkOHjUkZH5hgZsom5viXs7WO5XI=;
        h=From;
        b=p4Y3sRR7uWdVxYCmbTY3AwSSrx4znCHk+KdyslX8/RkQqQl+JNvVlJ1WnUBdZrjmd
         GKrGqcbunMKA8XWEU6ID+BXRH1e4GDRdQFR4YBmcF2cVIFnyjnvCIVTN3TVf+M8NER
         RYCUR/Goif2G+XT6oTye9yoD0GQqsn/Ue/8caiPrGlQjmDQ6GIInkz7osDjLLTe4pL
         qONMkYoyTwedTHm17ql7Q4YLvQld0O5ESLlZ/HsuyBd+pfc+/kTI1s3r4LLoE9XDQd
         GTYPu+1TzyP+CEOKKZqBOgwS35P1/NGRkcKpJEdcCkODiDQoKb53II+jBjiRXH/ssY
         fg2INVEfo0pdQ==
X-CNFS-Analysis: v=2.4 cv=S6McfKgP c=1 sm=1 tr=0 ts=60243081 cx=a_exe
 a=uNKOaGSHjOz9mJiKWN0/1w==:117 a=uNKOaGSHjOz9mJiKWN0/1w==:17
 a=IkcTkHD0fZMA:10 a=GhQEx97vAAAA:20 a=fGO4tVQLAAAA:8 a=-NjwWTxFUZP9brkfLdAA:9
 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: is BTRFS_IOC_DEFRAG behavior optimal?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtSx=HcCRMiE0eganPWJVTB+b4zfb_mnd68L2VapGGKi7Q@mail.gmail.com>
 <3897f126-e977-d842-f91d-b48b74958f3d@libero.it>
 <CAJCQCtScUYMoMpw==HTbBB6s0BFnXuT=MvSuVJYEVBrA7-RbHA@mail.gmail.com>
 <839d9baa-8df5-7efd-94ee-b28f282ef9ec@inwind.it>
 <CAJCQCtSqESuYawuh6E8b6Xd=z4D13J2=v-6rn8+0mwuThXNtkg@mail.gmail.com>
 <7650c455-297a-f746-c59e-3104fdbf8896@inwind.it>
 <CAJCQCtR1fCSFYYbo7YvDPTmhALNvUyZB5C4zfMsUH-iU0xs6zQ@mail.gmail.com>
 <CAJCQCtSqvv6RRvtcbFBNEXTBbvNEAqE9twNtRE=4sF9+jcjh9A@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <4b01d738-5930-1100-03a4-6f1b7af445e5@inwind.it>
Date:   Wed, 10 Feb 2021 20:14:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSqvv6RRvtcbFBNEXTBbvNEAqE9twNtRE=4sF9+jcjh9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJ3WvdNJnXdjGvWg9FT1gbDontVIJuQg6fJJne+FZ2hVElSvYQVME8OiYjPVMOQ0DB8I5hxyIADCDt55caDAopHrfRTTu+2Az/Cc3LeIdiML5fCwsk9L
 pTqGtnuRa6M+S/cabo1TpJdTf8rxuT3kyH5US2WRQZ/0qaoCx6+FX3MsWnrDvtvgxr9ngtu2JmNahdd4TTpCaDb9Dxp4JLOE3b7GSlqkPA68lEnzKMSDNIFG
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Chris,

it seems that systemd-journald is more smart/complex than I thought:

1) systemd-journald set the "live" journal as NOCOW; *when* (see below) it
closes the files, it mark again these as COW then defrag [1]

2) looking at the code, I suspect that systemd-journald closes the
file asynchronously [2]. This means that looking at the "live" journal
is not sufficient. In fact:

/var/log/journal/e84907d099904117b355a99c98378dca$ sudo lsattr $(ls -rt *)
[...]
--------------------- user-1000@97aaac476dfc404f9f2a7f6744bbf2ac-000000000000bd4f-0005baed61106a18.journal
--------------------- system@3f2405cf9bcf42f0abe6de5bc702e394-000000000000bd64-0005baed659feff4.journal
--------------------- user-1000@97aaac476dfc404f9f2a7f6744bbf2ac-000000000000bd67-0005baed65a0901f.journal
---------------C----- system@3f2405cf9bcf42f0abe6de5bc702e394-000000000000cc63-0005bafed4f12f0a.journal
---------------C----- user-1000@97aaac476dfc404f9f2a7f6744bbf2ac-000000000000cc85-0005baff0ce27e49.journal
---------------C----- system@3f2405cf9bcf42f0abe6de5bc702e394-000000000000cd38-0005baffe9080b4d.journal
---------------C----- user-1000@97aaac476dfc404f9f2a7f6744bbf2ac-000000000000cd3b-0005baffe908f244.journal
---------------C----- user-1000.journal
---------------C----- system.journal

The output above means that the last 6 files are "pending" for a de-fragmentation. When these will be
"closed", the NOCOW flag will be removed and a defragmentation will start.

Now my journals have few (2 or 3 extents). But I saw cases where the extents
of the more recent files are hundreds, but after few "journalct --rotate" the older files become less
fragmented.

[1] https://github.com/systemd/systemd/blob/fee6441601c979165ebcbb35472036439f8dad5f/src/libsystemd/sd-journal/journal-file.c#L383
[2] https://github.com/systemd/systemd/blob/fee6441601c979165ebcbb35472036439f8dad5f/src/libsystemd/sd-journal/journal-file.c#L3687

On 2/10/21 7:37 AM, Chris Murphy wrote:
> This is an active (but idle) system.journal file. That is, it's open
> but not being written to. I did a sync right before this:
> 
> https://pastebin.com/jHh5tfpe
> 
> And then: btrfs fi defrag -l 8M system.journal
> 
> https://pastebin.com/Kq1GjJuh
> 
> Looks like most of it was a no op. So it seems btrfs in this case is
> not confused by so many small extent items, it know they are
> contiguous?
> 
> It doesn't answer the question what the "too small" threshold is for
> BTRFS_IOC_DEFRAG, which is what sd-journald is using, though.
> 
> Another sync, and then, 'journalctl --rotate' and the resulting
> archived file is now:
> 
> https://pastebin.com/aqac0dRj
> 
> These are not the same results between the two ioctls for the same
> file, and not the same result as what you get with -l 32M (which I do
> get if I use the default 32M). The BTRFS_IOC_DEFRAG interleaved result
> is peculiar, but I don't think we can say it's ineffective, it might
> be an intentional no op either because it's nodatacow or it sees that
> these many extents are mostly contiguous and not worth defragmenting
> (which would be good for keeping write amplification down).
> 
> So I don't know, maybe it's not wrong.
> 
> --
> Chris Murphy
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
