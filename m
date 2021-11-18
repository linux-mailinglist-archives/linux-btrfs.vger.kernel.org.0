Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592F5455EC7
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 15:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhKRPAU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 10:00:20 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:50842 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhKRPAU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 10:00:20 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1AB641FD29;
        Thu, 18 Nov 2021 14:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637247439;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5tLa2ZYwec2LLuaqYa0mTMBBzK9Jnt6S0Mmh/4zcgoY=;
        b=DK7iX/lJXbxx81vK3CKI80EwFstwUVLw8zlSg1nQwF9WOvr114zkjOQgdc0FkAwojWd51F
        kpW9h93mvL68CJdmYKOr0vZHJlhgueUwaXFHyGxbWNhGQmSmyvP5WKiMkM1UFqWBRJneNA
        BdgRAF3A244KK1yO6366AVlClRw06RA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637247439;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5tLa2ZYwec2LLuaqYa0mTMBBzK9Jnt6S0Mmh/4zcgoY=;
        b=sZdZjpd2HnNfo1nU/QbJ6rxsoyunqU+dMo42pYGYN1soV81EmgXbRhdR1lUS7T4H2ksTfh
        hiLK9PQKOJD5cBDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 10934A3B85;
        Thu, 18 Nov 2021 14:57:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 95700DA735; Thu, 18 Nov 2021 15:57:14 +0100 (CET)
Date:   Thu, 18 Nov 2021 15:57:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v12 01/17] fs: export rw_verify_area()
Message-ID: <20211118145714.GG28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1637179348.git.osandov@fb.com>
 <11bc0fc15490afc6ce15c405cca3e16582f2f0ec.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11bc0fc15490afc6ce15c405cca3e16582f2f0ec.1637179348.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 17, 2021 at 12:19:11PM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> I'm adding Btrfs ioctls to read and write compressed data, and rather
> than duplicating the checks in rw_verify_area(), let's just export it.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3244,6 +3244,7 @@ extern loff_t fixed_size_llseek(struct file *file, loff_t offset,
>  		int whence, loff_t size);
>  extern loff_t no_seek_end_llseek_size(struct file *, loff_t, int, loff_t);
>  extern loff_t no_seek_end_llseek(struct file *, loff_t, int);
> +extern int rw_verify_area(int, struct file *, const loff_t *, size_t);

Do you have an ack from VFS people for exporting a function from
fs/interna.h to the normal fs.h?

>  extern int generic_file_open(struct inode * inode, struct file * filp);
>  extern int nonseekable_open(struct inode * inode, struct file * filp);
>  extern int stream_open(struct inode * inode, struct file * filp);
> -- 
> 2.34.0
