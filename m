Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92030779401
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 18:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbjHKQLp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 12:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbjHKQLo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 12:11:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1A2100
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 09:11:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8C0F91F895;
        Fri, 11 Aug 2023 16:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691770299;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahHbU1nsczpNCOoRWL5V0gd6B9evNi4xojBybnxfJ5k=;
        b=VckQnR9UPc8vwbQ3sfZptHeA7zkHeXjMHqilS6OGyrvnHtAvX83W3uFGrrRLeV9/5lFbjf
        6QCxxqDK5JFPJRlMe2nfWjoM6oIxinLTlmPCVSFMwSTI5Jc82JlrfK1rzpYOWg8zmFUh4Z
        WCXZ7ZfwaDKdlcXmp7GSy1UGV6wauUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691770299;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahHbU1nsczpNCOoRWL5V0gd6B9evNi4xojBybnxfJ5k=;
        b=RcGlFALUfWHwXKqmw9dObsBibf/lggKw4VNKkB5h9Ta4IFe9n1X9mU/QTibjfdwbb3jTOM
        PZlup6uzcwUBJfCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E449138E2;
        Fri, 11 Aug 2023 16:11:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cMPSFbtd1mTeQwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Aug 2023 16:11:39 +0000
Date:   Fri, 11 Aug 2023 18:05:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Lee Trager <lee@trager.us>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Copy dir permission and time when creating a stub
 subvolume
Message-ID: <20230811160514.GW2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230811014435.1963948-1-lee@trager.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230811014435.1963948-1-lee@trager.us>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_SOFTFAIL,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 10, 2023 at 06:44:35PM -0700, Lee Trager wrote:
> btrfs supports creating nested subvolumes however snapshots are not recursive.
> When a snapshot is taken of a volume which contains a subvolume the subvolume
> is replaced with a stub subvolume which has the same name and uses inode
> number 2[1]. The stub subvolume kept the directory name but did not set the
> time or permissions of the stub subvolume. This resulted in all time information
> being the current time and ownership defaulting to root. When subvolumes and
> snapshots are created using unshare this results in a snapshot directory the
> user created but has no permissions for.
> 
> Test case:
> [vmuser@archvm ~]# sudo -i
> [root@archvm ~]# mkdir -p /mnt/btrfs/test
> [root@archvm ~]# chown vmuser:users /mnt/btrfs/test/
> [root@archvm ~]# exit
> logout
> [vmuser@archvm ~]$ cd /mnt/btrfs/test
> [vmuser@archvm test]$ unshare --user --keep-caps --map-auto --map-root-user
> [root@archvm test]# btrfs subvolume create subvolume
> Create subvolume './subvolume'
> [root@archvm test]# btrfs subvolume create subvolume/subsubvolume
> Create subvolume 'subvolume/subsubvolume'
> [root@archvm test]# btrfs subvolume snapshot subvolume snapshot
> Create a snapshot of 'subvolume' in './snapshot'
> [root@archvm test]# exit
> logout
> [vmuser@archvm test]$ tree -ug
> [vmuser   users   ]  .
> ├── [vmuser   users   ]  snapshot
> │   └── [vmuser   users   ]  subsubvolume  <-- Without patch perm is root:root
> └── [vmuser   users   ]  subvolume
>     └── [vmuser   users   ]  subsubvolume
> 
> 5 directories, 0 files
> 
> [1] https://btrfs.readthedocs.io/en/latest/btrfs-subvolume.html#nested-subvolumes
> Signed-off-by: Lee Trager <lee@trager.us>
> ---
>  fs/btrfs/inode.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 6a68d5a3ed20..7a288cd6f815 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5592,11 +5592,11 @@ struct inode *btrfs_iget(struct super_block *s, u64 ino, struct btrfs_root *root
>  	return btrfs_iget_path(s, ino, root, NULL);
>  }
>  
> -static struct inode *new_simple_dir(struct super_block *s,
> +static struct inode *new_simple_dir(struct inode *dir,
>  				    struct btrfs_key *key,
>  				    struct btrfs_root *root)
>  {
> -	struct inode *inode = new_inode(s);
> +	struct inode *inode = new_inode(dir->i_sb);
>  
>  	if (!inode)
>  		return ERR_PTR(-ENOMEM);
> @@ -5615,9 +5615,11 @@ static struct inode *new_simple_dir(struct super_block *s,
>  	inode->i_fop = &simple_dir_operations;
>  	inode->i_mode = S_IFDIR | S_IRUGO | S_IWUSR | S_IXUGO;
>  	inode->i_mtime = current_time(inode);
> -	inode->i_atime = inode->i_mtime;
> -	inode->i_ctime = inode->i_mtime;
> +	inode->i_atime = dir->i_atime;
> +	inode->i_ctime = dir->i_ctime;
>  	BTRFS_I(inode)->i_otime = inode->i_mtime;
> +	inode->i_uid = dir->i_uid;
> +	inode->i_gid = dir->i_gid;

The uid and git are subject to namespaces so it's usually read as
i_uid_read/i_gid_read. Howvever in this case it's 1:1 copy (and not
passing arguments or storing to something else than another inode), so I
guess it's correct.

Added to misc-next, thanks.
