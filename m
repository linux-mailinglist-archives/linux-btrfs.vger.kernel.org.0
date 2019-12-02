Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 686AC10F3A8
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 00:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfLBX7K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 18:59:10 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37598 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfLBX7K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Dec 2019 18:59:10 -0500
Received: by mail-pl1-f193.google.com with SMTP id bb5so794171plb.4
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Dec 2019 15:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wRac3QS+z2Q/PPX1u1xed8cLNAe7tiS4GbPpEzsn5Fk=;
        b=DVQ0sUXZpqnxnJ+Khitgq+g9eQPQBTswo/ewTRS1SbBhonIb0QRxBDMwLbw4SHndNq
         kLx9SqB9UyRFmQIWIOVsh0D0N/rWM5n8TgCAkgSZ/9s8FmhkGsgbcrEap3O5H3RtljED
         l+zP0ySxpHgZy/YgFc+jk9/cpJncmKxcy8sDHiMv0lUM9kxVPqShPgvIbrMW9wktHTKu
         mOrHMz+SRKxz+2K3XgLHlVi2GX5FPA9xMSLy8Uy+j2mR8q+p1xG2wK4P6CrtVkIQYT5q
         Q8os3Ek5hfsZBA6sk+z8oS8JJDMINOIBjhwaZWZ6wk9iJK+xQnSVBwNmS+RPDMlq8KeN
         Xgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wRac3QS+z2Q/PPX1u1xed8cLNAe7tiS4GbPpEzsn5Fk=;
        b=E39P9TXF3SXf//Eip6a5Nr0fFdlCc5JcoiVGeUAkxQzE5xB3crxKXXNTWO4C2B4aRK
         hm2gHfxwFH3ing0wg/aQHEdPyfM8Ey6PLu+vo/82xiQI34RChYGB1le7HXoWO9SLRWkb
         bifjTDj9vEjatR1n0NIwofW5ZIyR1X4NiC/JpqFPRG5hqslHwHPn0+DK7L7Af9P7nSGT
         cVftQhoegVusjCMEzdgFR8dr9XKZlzoMvbNMw/YyBypDan3Df+uxcRwnHjcZAbTUr2S3
         oXYe6YmXuiLyvr9IGIBzJbH+FUSbTp4QUrhSC+clluz6uc90Ce699V6+SyRX/qCIbnkQ
         nCfQ==
X-Gm-Message-State: APjAAAWrs6KO8t2OHTn41PGp7XskKwkDa9rPBmnJF3l4mMQPRaJJDEA2
        HUGGRZ126Ur4aNyMBZtCJ0R7G6amLYc=
X-Google-Smtp-Source: APXvYqzg91WUCrorJAv2SxCRP62AnolJj8Ovs086aW1bFVCRrdI4pMqn64hnrVsg/59lmvkengdCVg==
X-Received: by 2002:a17:90a:bc41:: with SMTP id t1mr2099845pjv.89.1575331148942;
        Mon, 02 Dec 2019 15:59:08 -0800 (PST)
Received: from [192.168.1.145] ([39.109.145.141])
        by smtp.gmail.com with ESMTPSA id i4sm464136pjd.19.2019.12.02.15.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 15:59:07 -0800 (PST)
From:   Anand Jain <anandsuveer@gmail.com>
X-Google-Original-From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v2] btrfs: fix warn_on for send from readonly mount
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20191202094450.1377-1-anand.jain@oracle.com>
 <1575296676-16470-1-git-send-email-anand.jain@oracle.com>
 <CAL3q7H6n3Cwi6WobN1FY5ZZyhwGFLGvXbV5-Sp2q4=xGn6ZBLw@mail.gmail.com>
Message-ID: <3527299a-e707-e1c3-926a-1195f592f954@oracle.com>
Date:   Tue, 3 Dec 2019 07:59:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H6n3Cwi6WobN1FY5ZZyhwGFLGvXbV5-Sp2q4=xGn6ZBLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/2/19 11:42 PM, Filipe Manana wrote:
> On Mon, Dec 2, 2019 at 2:26 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> We log warning if root::orphan_cleanup_state is not set to
>> ORPHAN_CLEANUP_DONE in btrfs_ioctl_send(). However if the filesystem is
>> mounted as readonly we skip the orphan items cleanup during the lookup
>> and root::orphan_cleanup_state remains at the init state 0 instead of
>> ORPHAN_CLEANUP_DONE (2).
>>
>> WARNING: CPU: 0 PID: 2616 at /Volumes/ws/btrfs-devel/fs/btrfs/send.c:7090 btrfs_ioctl_send+0xb2f/0x18c0 [btrfs]
>> ::
>> RIP: 0010:btrfs_ioctl_send+0xb2f/0x18c0 [btrfs]
>> ::
>> Call Trace:
>> ::
>> _btrfs_ioctl_send+0x7b/0x110 [btrfs]
>> btrfs_ioctl+0x150a/0x2b00 [btrfs]
>> ::
>> do_vfs_ioctl+0xa9/0x620
>> ? __fget+0xac/0xe0
>> ksys_ioctl+0x60/0x90
>> __x64_sys_ioctl+0x16/0x20
>> do_syscall_64+0x49/0x130
>> entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> Reproducer:
>>    mkfs.btrfs -fq /dev/sdb && mount /dev/sdb /btrfs
>>    btrfs subvolume create /btrfs/sv1
>>    btrfs subvolume snapshot -r /btrfs/sv1 /btrfs/ss1
>>    umount /btrfs && mount -o ro /dev/sdb /btrfs
>>    btrfs send /btrfs/ss1 -f /tmp/f
>>
>> Fix this by removing the warn_on completely because:
>>
>> 1) Having orphan items means we could have files to delete (link count
>> of 0) and dealing with such cases could make send fail for several
>> reasons.
>>     If this happens, it's not longer a problem since the following
>> commit:
>>     46b2f4590aab71d31088a265c86026b1e96c9de4
>>     Btrfs: fix send failure when root has deleted files still open
> 
> The convention for mentioning commits is
> first_12_or_slighly_more_hash_characters ("subject").
> scripts/checkpatch.pl warns about it, and given this has been around
> for years, you should already be familiar with it.
> 
>>
>> 2) Orphan items used to indicate previously unfinished truncations, in
>> which case it would lead to send creating corrupt files at the
>> destination (i_size incorrect and the file filled with zeroes between
>> real i_size and stale i_size).
>>     We no longer need to create orphans for truncations since commit:
>>     f7e9e8fc792fe2f823ff7d64d23f4363b3f2203a
>>     Btrfs: stop creating orphan items for truncate
> 
> And I didn't expect you to literally copy-paste what I wrote before.
> For a changelog we want something better written, organized and more
> detailed then an informal e-mail reply, like this:
> 
> "
> The warning exists because having orphanized inodes could confuse send
> and cause it to fail or produce incorrect streams.
> The two cases that would cause problems were:
> 
> 1) Inodes that were unlinked - these are orphanized and remain with a
> link count of 0, having no references (names).
>     These caused send operations to fail because it expected to always
> find at least one path for an inode.
>     This is no longe a problem since send is now able to deal with such
> inodes since
>     commit 46b2f4590aab ("Btrfs: fix send failure when root has deleted
> files still open") and treats them as having
>     been completely removed (the state after a orphan cleanup is performed).
> 
> 2) Inodes that were in the process of being truncated. These resulted
> in send not knowing about the truncation
>      and potentially issue write operations full of zeroes for the
> range from the new file size to the old file size.
>      This is no longer a problem because we no longer create orphan
> items for truncations since
>      commit  f7e9e8fc792f ("Btrfs: stop creating orphan items for truncate")..
> 
> In other words the warning was there to provide a clue in case
> something went wrong. Instead of being a warning
> against the root's "->orphan_cleanup_state" value, it could have been
> more accurate by checking if there were actually
> any orphan items, and then issue a warning only if any exists, but
> that would be more expensive to check.
> Since orphanized inodes no longer cause problems for send, just remove
> the warning.
> "

  Ah. Generally your commits has the best change logs. Its very hard
  to either match or satisfy your level. ;-). But I am trying and not
  there yet.

Thanks. Anand

>>
>> Reported-by: Christoph Anton Mitterer <calestyo@scientia.net>
>> Suggested-by: Filipe Manana <fdmanana@gmail.com>
> 
> Also s/@gmail.com/@suse.com/ (preferable).
> 
> Thanks.
> 
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v2:
>>   Remove WARN_ON() completely.
>>
>>   fs/btrfs/send.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
>> index ae2db5eb1549..091e5bc8c7ea 100644
>> --- a/fs/btrfs/send.c
>> +++ b/fs/btrfs/send.c
>> @@ -7084,12 +7084,6 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
>>          spin_unlock(&send_root->root_item_lock);
>>
>>          /*
>> -        * This is done when we lookup the root, it should already be complete
>> -        * by the time we get here.
>> -        */
>> -       WARN_ON(send_root->orphan_cleanup_state != ORPHAN_CLEANUP_DONE);
>> -
>> -       /*
>>           * Userspace tools do the checks and warn the user if it's
>>           * not RO.
>>           */
>> --
>> 1.8.3.1
>>
> 
> 

