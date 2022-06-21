Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A0B5538A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 19:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353007AbiFURO7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 13:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbiFURO6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 13:14:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A99928E3B
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 10:14:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B4F451F461;
        Tue, 21 Jun 2022 17:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655831695;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I8z/77PVhhUOzBW4ZU3j3UEkwRIA1RVUWZG1hapkd10=;
        b=gfLyhu0dnO+jq5U1/CbBZ2bnerMlSvZxZpb6BbpnKlB4bnyYbIRkDs1DdFsbU8l+cOW9qT
        SsfU33ap76XIlkNvEkitEfN9ejJjoj6VUElUmcan9cB5lM2grIiNyIoTedwcDK4JbDSaqA
        qZEsuXkzOqIEbaYYZQBsuQZYxo+SFHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655831695;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I8z/77PVhhUOzBW4ZU3j3UEkwRIA1RVUWZG1hapkd10=;
        b=UGIIutM1GO75V6rC1w5CFDnxk0P4bHvubEG39IeKhHwga/m6zy37x5BWHaRRywB9XRfE1H
        d7qUNzomjPyX8KCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9619513638;
        Tue, 21 Jun 2022 17:14:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4BaKI4/8sWInIwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Jun 2022 17:14:55 +0000
Date:   Tue, 21 Jun 2022 19:10:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RESEND PATCH 1/3] btrfs: wrap rdonly check into
 btrfs_fs_is_rdonly
Message-ID: <20220621171018.GD20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1654216941.git.anand.jain@oracle.com>
 <0bd3d3777e34a5322fb4d3ec315df4090ee43399.1654216941.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bd3d3777e34a5322fb4d3ec315df4090ee43399.1654216941.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 03, 2022 at 07:12:09AM +0530, Anand Jain wrote:
> As of now, the BTRFS_FS_OPEN flag is true if the filesystem open is complete
> and as well as it is used for the affirmation if the filesystem read-write
> able.
> 
> In preparatory to take out the rw affirm part in the above flag, first
> consolidate the check for filesystem rdonly into the function
> btrfs_fs_is_rdonly(). It makes migration to the new definition of the
> flag BTRFS_FS_OPEN cleaner.
> 
> Here I introduce a new function btrfs_fs_is_rdonly(), it consolidates the
> current two ways we check for the filesystem in rdonly.
> 
> At all places we use the check
>    sb_rdonly(fs_info->sb)
> however in the funtion btrfs_need_cleaner_sleep() we use the
>    test_bit(BTRFS_FS_STATE_RO....).
> 
> As per the comment of btrfs_need_cleaner_sleep(), it needs to use
> BTRFS_FS_STATE_RO state for the atomicity purpose.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> Change log reworded.
> The same patch was marked as RFC before. To know if there is any better way to 
> clean up. Now I think there isn't. Removed 
> 
>  fs/btrfs/block-group.c  |  2 +-
>  fs/btrfs/ctree.h        | 13 +++++++++++--
>  fs/btrfs/dev-replace.c  |  2 +-
>  fs/btrfs/disk-io.c      | 11 ++++++-----
>  fs/btrfs/extent_io.c    |  4 ++--
>  fs/btrfs/inode.c        |  2 +-
>  fs/btrfs/ioctl.c        |  2 +-
>  fs/btrfs/super.c        | 12 ++++++------
>  fs/btrfs/sysfs.c        |  4 ++--
>  fs/btrfs/tree-checker.c |  2 +-
>  fs/btrfs/volumes.c      |  4 ++--
>  11 files changed, 34 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index ede389f2602d..8f73dc120290 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2597,7 +2597,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
>  	 * In that case we should not start a new transaction on read-only fs.
>  	 * Thus here we skip all chunk allocations.
>  	 */
> -	if (sb_rdonly(fs_info->sb)) {
> +	if (btrfs_fs_is_rdonly(fs_info)) {
>  		mutex_lock(&fs_info->ro_block_group_mutex);
>  		ret = inc_block_group_ro(cache, 0);
>  		mutex_unlock(&fs_info->ro_block_group_mutex);
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 777d0b1a0b1e..171dd25def8b 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3119,6 +3119,16 @@ static inline int btrfs_fs_closing(struct btrfs_fs_info *fs_info)
>  	return 0;
>  }
>  
> +static inline bool btrfs_fs_is_rdonly(const struct btrfs_fs_info *fs_info)
> +{
> +	bool rdonly = sb_rdonly(fs_info->sb);
> +	bool fs_rdonly = test_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state);
> +
> +	BUG_ON(rdonly != fs_rdonly);

I think this is wrong, this would mandate that sb_rdonly is always equal
to the state of BTRFS_FS_STATE_RO bit, but this is not always true and
was the reason why the separate bit was added in commit

a0a1db70df5f ("btrfs: fix race between RO remount and the cleaner task")
> +
> +	return rdonly;
> +}
> +
>  /*
>   * If we remount the fs to be R/O or umount the fs, the cleaner needn't do
>   * anything except sleeping. This function is used to check the status of
> @@ -3129,8 +3139,7 @@ static inline int btrfs_fs_closing(struct btrfs_fs_info *fs_info)
>   */
>  static inline int btrfs_need_cleaner_sleep(struct btrfs_fs_info *fs_info)
>  {
> -	return test_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state) ||
> -		btrfs_fs_closing(fs_info);
> +	return btrfs_fs_is_rdonly(fs_info) || btrfs_fs_closing(fs_info);

So here you would effectively switch it from testing
BTRFS_FS_STATE_RO to sb_rdonly and obscuring it by a helper.

According to a0a1db70df5f the status can get out of sync and can lead to
a crash, so the BUG_ON can be triggered and thus it's not even an
assertion.

It could be possible to return true from btrfs_fs_is_rdonly if either of
the flags is set, but this may break in other place than the cleaner.
