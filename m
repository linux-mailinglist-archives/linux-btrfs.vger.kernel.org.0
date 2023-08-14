Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8914377BB79
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 16:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjHNOZ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 10:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjHNOZJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 10:25:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED72EE4A
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 07:25:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9F36F21984;
        Mon, 14 Aug 2023 14:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692023103;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dEmrjdy2rJ8xQxdfpwwpgzHRZIwJ5vEM0rQyR9tBzoI=;
        b=IMyvNsAhcCaK5jxv25dqI+4WaP3xxd9JabjvlOn8+CX7oxtI0oUy+nT56bAcW6sZ3YOcVN
        83Js2vGGBgxUJdDMVjli7YlqL6LdfrKD5ADePgWCecfHyxL305FUV8Oe7Z+mXFrH1EjMre
        sIJ6MQKS/il3Mqh2pic8Cp3luZF3A6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692023103;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dEmrjdy2rJ8xQxdfpwwpgzHRZIwJ5vEM0rQyR9tBzoI=;
        b=Nf7IU0pLkce8wNudn+ZsEArOXLSTdPOxldKZTttxk0nF13kk7CpFShsGD+NirwPoFEjEAv
        t2riy9LcMXbXE/DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 81C84138EE;
        Mon, 14 Aug 2023 14:25:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +QW3Hj852mSHeAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 14 Aug 2023 14:25:03 +0000
Date:   Mon, 14 Aug 2023 16:18:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix infinite directory reads
Message-ID: <20230814141836.GD2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <c9ceb0e15d92d0634600603b38965d9b6d986b6d.1691923900.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9ceb0e15d92d0634600603b38965d9b6d986b6d.1691923900.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_SOFTFAIL,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 13, 2023 at 12:34:08PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The readdir implementation currently processes always up to the last index
> it finds. This however can result in an infinite loop if the directory has
> a large number of entries such that they won't all fit in the given buffer
> passed to the readdir callback, that is, dir_emit() returns a non-zero
> value. Because in that case readdir() will be called again and if in the
> meanwhile new directory entries were added and we still can't put all the
> remaining entries in the buffer, we keep repeating this over and over.
> 
> The following C program and test script reproduce the problem:
> 
>   $ cat /mnt/readdir_prog.c
>   #include <sys/types.h>
>   #include <dirent.h>
>   #include <stdio.h>
> 
>   int main(int argc, char *argv[])
>   {
>     DIR *dir = opendir(".");
>     struct dirent *dd;
> 
>     while ((dd = readdir(dir))) {
>       printf("%s\n", dd->d_name);
>       rename(dd->d_name, "TEMPFILE");
>       rename("TEMPFILE", dd->d_name);
>     }
>     closedir(dir);
>   }
> 
>   $ gcc -o /mnt/readdir_prog /mnt/readdir_prog.c
> 
>   $ cat test.sh
>   #!/bin/bash
> 
>   DEV=/dev/sdi
>   MNT=/mnt/sdi
> 
>   mkfs.btrfs -f $DEV &> /dev/null
>   #mkfs.xfs -f $DEV &> /dev/null
>   #mkfs.ext4 -F $DEV &> /dev/null
> 
>   mount $DEV $MNT
> 
>   mkdir $MNT/testdir
>   for ((i = 1; i <= 2000; i++)); do
>       echo -n > $MNT/testdir/file_$i
>   done
> 
>   cd $MNT/testdir
>   /mnt/readdir_prog
> 
>   cd /mnt
> 
>   umount $MNT
> 
> This behaviour is surprising to applications and it's unlike ext4, xfs,
> tmpfs, vfat and other filesystems, which always finish. In this case where
> new entries were added due to renames, some file names may be reported
> more than once, but this varies according to each filesystem - for example
> ext4 never reported the same file more than once while xfs reports the
> first 13 file names twice.
> 
> So change our readdir implementation to track the last index number when
> opendir() is called and then make readdir() never process beyond that
> index number. This gives the same behaviour as ext4.
> 
> Reported-by: Rob Landley <rob@landley.net>
> Link: https://lore.kernel.org/linux-btrfs/2c8c55ec-04c6-e0dc-9c5c-8c7924778c35@landley.net/
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217681
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
