Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3594A2D88
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Jan 2022 10:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238478AbiA2JxG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Jan 2022 04:53:06 -0500
Received: from smtp-34.italiaonline.it ([213.209.10.34]:45813 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241982AbiA2JxE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Jan 2022 04:53:04 -0500
Received: from [192.168.1.27] ([78.14.151.50])
        by smtp-34.iol.local with ESMTPA
        id DkPlnH6G04gIpDkPlnYlVZ; Sat, 29 Jan 2022 10:53:02 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1643449982; bh=NqLVAFJXbIy9aHjBUcIbMppaoMTxNcbVmYiQX0owtxw=;
        h=From;
        b=iUFp6nQcG3cslc1yWOez7+tiVsP55fkeAPTNVgX3fF2mrQcr1ES5O1/P+rjiDyFQQ
         uFUsaLs/B7Y//Q8hvGfmmqNe7NWNkBbIOVNjo++UFGqh8I2ILKxq6Rp3wGsPmMWOYv
         uM5++od3Xki9er4ho1SuVoNVePSeJuf0udbU0wRXEKrJaiYQ0MqOiXJ5r9Ue/4nf7v
         p0c5VQBH97bV9kQuG9bjCg/OkNKvGJPfzBQ4Enb+/QlXuifsFeLRbHUhh63tLG1Oho
         PEn361D/XFGzVR/Rf9zDyWPwpqlLIfT/rydCrqXnnIbSURGbTKBBrM8LJWdWmEzRXc
         YkMtC51AA63yg==
X-CNFS-Analysis: v=2.4 cv=d4QwdTvE c=1 sm=1 tr=0 ts=61f50e7e cx=a_exe
 a=d4nNsk+SGr75ik5id+62uA==:117 a=d4nNsk+SGr75ik5id+62uA==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=LK9_5ug4E2jYap8r4NoA:9 a=QEXdDO2ut3YA:10
Message-ID: <042e75ab-ded2-009a-d9fc-95887c26d4d2@libero.it>
Date:   Sat, 29 Jan 2022 10:53:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: kreijack@inwind.it
Subject: Re: No space left errors on shutdown with systemd-homed /home dir
Content-Language: en-US
To:     Chris Murphy <lists@colorremedies.com>, Boris Burkov <boris@bur.io>
Cc:     "Apostolos B." <barz621@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        systemd Mailing List <systemd-devel@lists.freedesktop.org>
References: <9bdd0eb6-4a4f-e168-0fb0-77f4d753ec19@gmail.com>
 <YfHCLhpkS+t8a8CG@zen> <4263e65e-f585-e7f6-b1aa-04885c0ed662@gmail.com>
 <YfHXFfHMeqx4MowJ@zen>
 <CAJCQCtR5ngU8oF6apChzBgFgX1W-9CVcF9kjvgStbkcAq_TsHQ@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <CAJCQCtR5ngU8oF6apChzBgFgX1W-9CVcF9kjvgStbkcAq_TsHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJoLdzOd8A6MHPkYMVqPYmaHbBc8HM7+lYzQzCxfx11z8IVGLwBB7nNosrLraIHVHr+nxy5jbp3u8ZQwo7hUxNXjtl+aVDj5ziX6ICXKaNN2SJkZVSiX
 yqIJDBNExOWDf2BfWmqjbZ6BdZS3C3jqviRm4nChlKhZg7kD1MvbebbMhCcGaLEbYB0v5tNWtCcJzF3UVz0r3bAU+PtaKyiNcUdKTJ67SDwUvE8trrLNlaAs
 AddI9lRXDb2fsYNRO9p5fuKX5v6L11OhhrMOCvNy3EhRXf56Uewp1DQFPcmOS+rUZOnzZc+TY8LsqgZPR2Aqz+O15a8XoPrY5TgVzjihcTE=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/01/2022 21.48, Chris Murphy wrote:
> On Wed, Jan 26, 2022 at 4:19 PM Boris Burkov <boris@bur.io> wrote:
[...]
> 
> systemd-homed by default uses btrfs on LUKS on loop mount, with a
> backing file. On login, it grows the user home file system with some
> percentage (I think 80%) of the free space of the underlying file
> system. And on logout, it does both fstrim and shrinks the fs. I don't
> know why it does both, it seems adequate to do only fstrim on logout
> to return unused blocks to the underlying file system; and to do an fs
> resize on login to either grow or shrink the user home file system.
> 
> But also, we don't really have a great estimator of the minimum size a
> file system can be. `btrfs inspect-internal min-dev-size` is pretty
> broken right now.
> https://github.com/kdave/btrfs-progs/issues/271

I tried the test case, but was unable to get a wrong value. However
I think that this is due to the fact that btrfs improved the bg reclaiming.

However tweaking the test case, I was able to trigger the problem (I
reduced the filesize from 1GB to 256MB, so when some files are
removed a BG is empty filled)



> 
> I'm not sure if systemd folks would use libbtrfsutil facility to
> determine the minimum device shrink size? But also even the kernel
> doesn't have a very good idea of how small a file system can be
> shrunk. Right now it basically has to just start trying, and does it
> one block group at a time.

I think that for the systemd uses cases (singled device FS), a simpler
approach would be:

     fstatfs(fd, &sfs)
     needed = sfs.f_blocks - sfs.f_bavail;
     needed *= sfs.f_bsize

     needed = roundup_64(needed, 3*(1024*1024*1024))

Comparing the original systemd-homed code, I made the following changes
- 1) f_bfree is replaced by f_bavail (which seem to be more consistent to the disk usage; to me it seems to consider also the metadata chunk allocation)
- 2) the needing value is rounded up of 3GB in order to consider a further 1 data chunk and 2 metadata chunk (DUP))

Comments ?

> 
> Adding systemd-devel@
> 
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
