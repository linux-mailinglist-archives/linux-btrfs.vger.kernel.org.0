Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE9BC55650
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2019 19:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfFYRtz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jun 2019 13:49:55 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:39987 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfFYRtz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jun 2019 13:49:55 -0400
Received: by mail-qt1-f177.google.com with SMTP id a15so19370335qtn.7
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2019 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=C+tEv4f+P0I1zkRPGjYOHFAUDQZprhrDBVoUtAIlSQw=;
        b=ux6M+0mQCNmRun12Uyw2cAXBzs9flrZBnsSuw4qqlhtxVB3Zu3uJGaM+WmoS0r2TUt
         2jIkZrqiXub3t0vZoCn+vTx4U+IaCo3eX3qAeYBzr9VSyHKWyphXeWHaYupkotWFHzii
         IOyP9M7MimO7cCcCg9WFNCBGoctHpXPAoO7QbURNvKiBG7vtwnSEpnc0X/jpiYGjhFnu
         wEOM/VNbQT5rY98IDldAAEy6KFPIjBsym5zqWf1omMUHO62J+YHH+0pefzdNootLpeDv
         OktMnoR4HpNaaCyTZA3bXMd9xGyNntLA3Wkw9yRp10TI4bOCZJkC/iqsz3RU2josH55a
         oYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C+tEv4f+P0I1zkRPGjYOHFAUDQZprhrDBVoUtAIlSQw=;
        b=L/ECH59ufgY0+Om4iOSEneZ63SQM62adMnhIvSJOMuLbKqcDECqe5ecD62//UVshWq
         +MdO0AM6kRYH9H/gjNwLTngC+IknqENipavhIqjOD5h1K8c2U0Wwv9FKm0D0BkyBS2Dy
         1pw61gk42tDkZnBQT8nY0zo699rz/AF+3rjUXGvaIEY/5F1AVZWDWiLJXSlUUBeIGnWC
         +aU5Tx0uWRl1tjmafDMCSKJjuDdGa6p9oVqeFI/8xukk+9E+9ELPqvBx37yvRVrZQm+K
         3/eATXAk9EqvdOhxv6Z+HPQI4wMj5PjnYGLZv/YzHnq1izzgSclbWnLUXB/3mBm+QgKW
         WdEA==
X-Gm-Message-State: APjAAAUVj/WvgvN48aiLNp6OYcoc7yg7xh9s5A0PP1jwMSLZWPu/mrv2
        orfpftzxiieUTLgNSbxh8N8+7E5Ixrg=
X-Google-Smtp-Source: APXvYqxcjxH8cI+6rtOf51t0s3pwpr6i7mHciKKyd34fL6IVWPM7hiPFeisoRN7pEHUqtioq5newOA==
X-Received: by 2002:ac8:29c9:: with SMTP id 9mr110013901qtt.196.1561484993603;
        Tue, 25 Jun 2019 10:49:53 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id c18sm7700677qkm.78.2019.06.25.10.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 10:49:53 -0700 (PDT)
Subject: Re: CoW overhead from old extents?
To:     Roman Mamedov <rm@romanrm.net>, linux-btrfs@vger.kernel.org
References: <20190625154155.7b660feb@natsu>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <8170849a-cfc9-272b-1bf7-983c5241150c@gmail.com>
Date:   Tue, 25 Jun 2019 13:49:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190625154155.7b660feb@natsu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-06-25 06:41, Roman Mamedov wrote:
> Hello,
> 
> I have a number of VM images in sparse NOCOW files, with:
> 
>    # du -B M -sc *
>    ...
>    46030M	total
> 
> and:
> 
>    # du -B M -sc --apparent-size *
>    ...
>    96257M	total
> 
> But despite there being nothing else on the filesystem and no snapshots,
> 
>    # df -B M .
> 
>    ... 1M-blocks   Used Available Use% ...
>    ...   710192M 69024M   640102M  10% ...
> 
> The filesystem itself is:
> 
>    Data, RAID0: total=70.00GiB, used=67.38GiB
>    System, RAID0: total=64.00MiB, used=16.00KiB
>    Metadata, RAID0: total=1.00GiB, used=7.03MiB
>    GlobalReserve, single: total=16.00MiB, used=0.00B
> 
> So there's about 23 GB of overhead to store only 46 GB of data.
> 
> I vaguely remember the reason is something along the lines of the need to keep
> around old extents, which are split in the middle when CoWed, but the entire
> old extent must be also kept in place, until overwritten fully.
Essentially yes.
> 
> These NOCOW files are being snapshotted for backup purposes, and the snapshot
> is getting removed usually within 30 minutes (while the VMs are active and
> writing to their files), so it was not pure NOCOW 100% of the time.
> 
> Main question is, can we have this recorded/explained in the wiki in precise
> terms (perhaps in Gotchas), or is there maybe already a description of this
> issue on it somewhere? I looked through briefly just now, and couldn't find
> anything similar. Only remember this being explained once on the mailing list
> a few years ago. (Anyone has a link?)
I don't have a link, though I think I may have been one of the people 
who explained it back then.  It could indeed be better explained 
somewhere, though I think it probably isn't based on the reasoning that 
it should never get as bad as you are seeing here.
> 
> Also, any way to mitigate this and regain space? Short of shutting down the
> VMs, copying their images into new files and deleting old ones. Balance,
> defragment or "fallocate -d" (for the non-running ones) do not seem to help.
If you can attach and detach disks from the VM's while they're running 
and are using some kind of volume management inside the VM itself (LVM, 
BTRFS, ZFS, etc).

The general procedure for this is as follows:

1. Create a new (empty) disk image the same size as the one you want to 
copy.
2. Attach the new disk image to the VM which has the disk to be copied.
3. Use whatever volume management tools you have inside the VM itself to 
move things to the new disk (pvmove, btrfs replace, etc).
4. Once the data is completely moved, detach the old disk image.
5. Optionally archive the old disk image (just in case), and then remove 
it from the disk.

If it weren't NOCOW files we were talking about, you could actually 
force the extents to be rewritten 'in-place' (from a userspace 
perspective) by using the `-c` switch for defrag to change their 
compression state and then change it back.
> 
> What's unfortunate is that "fstrim -v" only reports ~640 GB as having been
> trimmed, which means the overhead part will be not freed by TRIM if this was
> on top of thin-provisioned storage either.
> 
Because it can't get rid of that overhead without rewriting the whole 
file, otherwise it would be getting freed in the first place.
