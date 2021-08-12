Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B051F3EA60F
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 15:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbhHLNz2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 09:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237815AbhHLNzY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 09:55:24 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7574DC0617A8
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Aug 2021 06:54:58 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id f91so3144351qva.9
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Aug 2021 06:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ll3gJ2kWTJ1Ddm5xPCWd0fQRm1CZSo4h409/G1+k1XQ=;
        b=G9AudWhNticUyEE9OKaig1qZDgxUdA6TrvuNS7xs+5+AQeYm/JbQW1Ao7qjJ7Ameve
         qgU9tiTbZRdTTAsTu79ZSiztZOpLCuYzinoWn4GUKcaMwbWr3v50V0BKfypAH4KHUQ4Q
         yHAAgBkaFGVMkx3I33q5cihVmSomx2oFde6OyO289Svuj0DaqLU+tmHgDrTrAciuhXKg
         80VpoF/x7IkUNklk/WZTHWhyiDdTdbZfpIwbX5sEwwbOY8xs5+1yBa7ZpHt9vhB76n81
         vgB8NTNdeXnZqXAVgprUSJ0XzJMdOy2MYznfLAeiuodzOU716rl+K2VvxH9XdMW6LBIj
         Bh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ll3gJ2kWTJ1Ddm5xPCWd0fQRm1CZSo4h409/G1+k1XQ=;
        b=tHZqyU/JQ6qiXzOuAS3rlu53fMBWQ4dky1nqfOW/jx5kFqpevsq8w6ogFN9XWcFuXC
         MGTkhddm4k/+IYRPATj+cFe5JnWtr5DabAsIMmOMLf+4WEzHYijDcW1uxc+fBnUihSwx
         bxomFSI1KdLheQX3ffjg7rTgwY/AVbBjjgd12r/fU6qX/koyulmrKsmNE8xGWG+gCaqe
         wiUG8dg7TeBmhniRFcidfBxT2oZAt+xO9g3dR/cblJDTtLKEx1iv5V3SK354CyEwo+bQ
         JPdA4R3KgcIS7h/Di127T0PkQqJY6TGfIQ7EHdiTQawahJ7eaVdsFxiGFDPPIdIGzNRN
         XGLA==
X-Gm-Message-State: AOAM530YIunyi9qRlTq6rWpsF/AElSCtTV3eWIAlSQb22IMcOe0YTLww
        mYgKJImGZTv2qgfEq4zWrj3r9tVX311o6A==
X-Google-Smtp-Source: ABdhPJyHTHpSJyITjiOPCkH+9qLxvHn7fErOIMq6FjPyWkOIoMB/2n9TOv/bIlPVFumWYV5hVYA5ZQ==
X-Received: by 2002:a0c:8525:: with SMTP id n34mr3997200qva.19.1628776496865;
        Thu, 12 Aug 2021 06:54:56 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::110c? ([2620:10d:c091:480::1:4885])
        by smtp.gmail.com with ESMTPSA id bl26sm1317894qkb.34.2021.08.12.06.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 06:54:56 -0700 (PDT)
Subject: Re: [PATCH/RFC 0/4] Attempt to make progress with btrfs dev number
 strangeness.
To:     NeilBrown <neilb@suse.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <162848123483.25823.15844774651164477866.stgit@noble.brown>
 <e6496956-0df3-6232-eecb-5209b28ca790@toxicpanda.com>
 <162872000356.22261.854151210687377005@noble.neil.brown.name>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6571d3fb-34ea-0f22-4fbe-995e5568e044@toxicpanda.com>
Date:   Thu, 12 Aug 2021 09:54:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <162872000356.22261.854151210687377005@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/11/21 6:13 PM, NeilBrown wrote:
> On Wed, 11 Aug 2021, Josef Bacik wrote:
>>
>> I think this is a step in the right direction, but I want to figure out a way to
>> accomplish this without magical mount points that users must be aware of.
> 
> magic mount *options* ???
> 
>>
>> I think the stat() st_dev ship as sailed, we're stuck with that.  However
>> Christoph does have a valid point where it breaks the various info spit out by
>> /proc.  You've done a good job with the treeid here, but it still makes it
>> impossible for somebody to map the st_dev back to the correct mount.
> 
> The ship might have sailed, but it is not water tight.  And as the world
> it round, it can still come back to bite us from behind.
> Anything can be transitioned away from, whether it is devfs or 32-bit
> time or giving different device numbers to different file-trees.
> 
> The linkage between device number and and filesystem is quite strong.
> We could modified all of /proc and /sys/ and audit and whatever else to
> report the fake device number, but we cannot get the fake device number
> into the mount table (without making the mount table unmanageablely
> large).
> And if subtrees aren't in the mount-table for the NFS server, I don't
> think they should be in the mount-table of the NFS client.  So we cannot
> export them to NFS.
> 
> I understand your dislike for mount options.  An alternative with
> different costs and benefits would be to introduce a new filesystem type
> - btrfs2 or maybe betrfs.  This would provide numdevs=1 semantics and do
> whatever we decided was best with inode numbers.  How much would you
> hate that?
> 

A lot more ;).

>>
>> I think we aren't going to solve that problem, at least not with stat().  I
>> think with statx() spitting out treeid we have given userspace a way to
>> differentiate subvolumes, and so we should fix statx() to spit out the the super
>> block device, that way new userspace things can do their appropriate lookup if
>> they so choose.
> 
> I don't think we should normalize having multiple devnums per filesystem
> by encoding it in statx().  It *would* make sense to add a btrfs ioctl
> which reports the real device number of a file.  Tools that really need
> to work with btrfs could use that, but it would always be obvious that
> it was an exception.

That's not what I'm saying.  I'm saying that stat() continues to behave the way 
it currently does, for legacy users.

And then for statx() it returns the correct devnum like any other file system, 
with the augmentation of the treeid so that future userspace programs can use 
the treeid to decide if they want to wander into a subvolume.

This way moving forward we have a way to map back to a mount point because 
statx() will return the actual devnum for the mountpoint, and then we can use 
the treeid to be smart about when we wander into a subvolume.

And if we're going to add a treeid, I would actually like to add a parent_treeid 
as well so we could tell if we're a snapshot or just a normal subvolume.

> 
>>
>> This leaves the problem of nfsd.  Can you just integrate this new treeid into
>> nfsd, and use that to either change the ino within nfsd itself, or do something
>> similar to what your first patchset did and generate a fsid based on the treeid?
> 
> I would only want nfsd to change the inode number.  I no longer think it
> is acceptable for nfsd to report different device number (as I mention
> above).
> I would want the new inode number to be explicitly provided by the
> filesystem.  Whether that is a new export_operation or a new field in
> 'struct kstat' doesn't really bother me.  I'd *prefer* it to be st_ino,
> but I can live without that.
>

Right, I'm not saying nfsd has to propagate our dev_t thing, I'm saying that you 
could accomplish the same behavior without the mount options.  We add either a 
new SB_I_HAS_TREEID or FS_HAS_TREEID, depending on if you prefer to tag the sb 
or the fs_type, and then NFS does the inode number magic transformation 
automatically and we are good to go.

> On the topic of inode numbers....  I've recently learned that btrfs
> never reuses inode (objectid) numbers (except possibly after an
> unmount).  Equally it doesn't re-use subvol numbers.  How much does this
> contribute to the 64 bits not being enough for subtree+inode?
> 
> It would be nice if we could be comfortable limiting the objectid number
> to 40 bits and the root.objectid (filetree) number to 24 bits, and
> combine them into a 64bit inode number.
> 
> If we added a inode number reuse scheme that was suitably performant,
> would that make this possible?  That would remove the need for a treeid,
> and allow us to use project-id to identify subtrees.
> 

We had a resuse scheme, we deprecated and deleted it.  I don't want to 
arbitrarily limit objectid's to work around this issue.

>>
>> Mount options are messy, and are just going to lead to distro's turning them on
>> without understanding what's going on and then we have to support them forever.
>>    I want to get this fixed in a way that we all hate the least with as little
>> opportunity for confused users to make bad decisions.  Thanks,
> 
> Hence my question: how much do you hate creating a new filesystem type
> to fix the problems?
> 

I'm still not convinced we can't solve this without adding new options or 
fstypes.  I think flags to indicate that we're special and to use a treeid that 
we stuff into the inode would be a reasonable solution.  That being said I'm a 
little sleep deprived so I could be missing why my plan is a bad one, so I'm 
willing to be convinced that mount options are the solution to this, but I want 
to make sure we're damned certain that's the best way forward.  Thanks,

Josef
