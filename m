Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CB64C2CF1
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 14:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbiBXN0c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 08:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiBXN0c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 08:26:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF1215B3FE;
        Thu, 24 Feb 2022 05:26:01 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 625F8212BE;
        Thu, 24 Feb 2022 13:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645709160;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yJlK5ujeFz45Ymry2OtkURFYaywUnISwHUMuFfLs3y8=;
        b=QyAZC3JZssy+GcwXULtKx6hz5dLZM10ezQnTF+x+DC8+apBie8ahtihAxQet8p+lEnaukk
        EoA5FCCHfJ0iO1RKMfNYLBi3MoNzTHA/V4zv4pY80FbqSZLuL2i4WWskP1p3iF5Cyqik53
        p726ubiwxzU6vwG+vLinM48iBELE9L0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645709160;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yJlK5ujeFz45Ymry2OtkURFYaywUnISwHUMuFfLs3y8=;
        b=8mdsY++ZKa7KimYyKQukP0IAyc40vPsn/dmMFUd/0Soc0EPJxzh5pdO60s62QHpDY1L7zI
        eWpjHRipLAkYzBCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 58174A3B89;
        Thu, 24 Feb 2022 13:25:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BE31CDA818; Thu, 24 Feb 2022 14:22:10 +0100 (CET)
Date:   Thu, 24 Feb 2022 14:22:10 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4] btrfs: add fs state details to error messages.
Message-ID: <20220224132210.GS12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <a059920460fe13f773fd9a2e870ceb9a8e3a105a.1645644489.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a059920460fe13f773fd9a2e870ceb9a8e3a105a.1645644489.git.sweettea-kernel@dorminy.me>
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

On Wed, Feb 23, 2022 at 02:38:06PM -0500, Sweet Tea Dorminy wrote:
> When a filesystem goes read-only due to an error, multiple errors tend
> to be reported, some of which are knock-on failures. Logging fs_states,
> in btrfs_handle_fs_error() and btrfs_printk() helps distinguish the
> first error from subsequent messages which may only exist due to an
> error state.
> 
> Under the new format, most initial errors will look like:
> `BTRFS: error (device loop0) in ...`
> while subsequent errors will begin with:
> `error (device loop0: state E) in ...`
> 
> An initial transaction abort error will look like
> `error (device loop0: state A) in ...`
> and subsequent messages will contain
> `(device loop0: state EA) in ...`
> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Added to misc-next with some minor updates, thanks.

> ---
> v4:
>   - Adjusted state translation table to contain chars instead of
>     strings.
> 
> v3:
>   - Reworked btrfs_state_to_string to use an array mapping all states
>     to various error chars, or nothing, explicitly. Added error logging
>     for more states, as requested.
>   - Consolidated buffer length definition
>   - ttps://lore.kernel.org/linux-btrfs/8a2a73ab4b48a4e73d24cf7f10cc0fe245d50a84.1645562216.git.sweettea-kernel@dorminy.me/
> 
> v2: 
>   - Changed btrfs_state_to_string() for clarity
>   - Removed superfluous whitespace change
>   - https://lore.kernel.org/linux-btrfs/084c136c6bb2d20ca0e91af7ded48306d52bb910.1645210326.git.sweettea-kernel@dorminy.me/
> 
> v1:
>   - https://lore.kernel.org/linux-btrfs/20220212191042.94954-1-sweettea-kernel@dorminy.me/
> 
>  fs/btrfs/ctree.h |  2 ++
>  fs/btrfs/super.c | 62 +++++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 56 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 8992e0096163..3db337cd015a 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -148,6 +148,8 @@ enum {
>  
>  	/* Indicates there was an error cleaning up a log tree. */
>  	BTRFS_FS_STATE_LOG_CLEANUP_ERROR,
> +
> +	BTRFS_FS_STATE_COUNT,
>  };
>  
>  #define BTRFS_BACKREF_REV_MAX		256
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 4d947ba32da9..7ef6a3e494d0 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -66,6 +66,46 @@ static struct file_system_type btrfs_root_fs_type;
>  
>  static int btrfs_remount(struct super_block *sb, int *flags, char *data);
>  
> +#define STATE_STRING_PREFACE ": state "
> +#define STATE_STRING_BUF_LEN \
> +	(sizeof(STATE_STRING_PREFACE) + BTRFS_FS_STATE_COUNT)
> +
> +/* Characters to print to indicate error conditions. RO is not an error. */
> +static const char fs_state_chars[] = {
> +	[BTRFS_FS_STATE_ERROR]			= 'E',
> +	[BTRFS_FS_STATE_REMOUNTING]		= 'M',
> +	[BTRFS_FS_STATE_RO]			= 0,
> +	[BTRFS_FS_STATE_TRANS_ABORTED]		= 'A',
> +	[BTRFS_FS_STATE_DEV_REPLACING]		= 'P',
> +	[BTRFS_FS_STATE_DUMMY_FS_INFO]		= 0,
> +	[BTRFS_FS_STATE_NO_CSUMS]		= 0,

I've added 'C' for this, as it's an interesting state (data checksums
not verified) and renamed the device replace to 'R'.

> +	[BTRFS_FS_STATE_LOG_CLEANUP_ERROR]	= 'L',
> +};
> +
> +static void btrfs_state_to_string(const struct btrfs_fs_info *info, char *buf)
> +{
> +	unsigned int bit;
> +	unsigned int states_printed = 0;

This could be a simple bool indicator.

> +	char *curr = buf;
> +
> +	memcpy(curr, STATE_STRING_PREFACE, sizeof(STATE_STRING_PREFACE));
> +	curr += sizeof(STATE_STRING_PREFACE) - 1;
> +
> +	for_each_set_bit(bit, &info->fs_state, sizeof(info->fs_state)) {
> +		WARN_ON_ONCE(bit >= BTRFS_FS_STATE_COUNT);
> +		if ((bit < BTRFS_FS_STATE_COUNT) && fs_state_chars[bit]) {
> +			*curr++ = fs_state_chars[bit];
> +			states_printed++;
> +		}
> +	}
> +
> +	/* If no states were printed, reset the buffer */
> +	if (!states_printed)
> +		curr = buf;
> +
> +	*curr++ = '\0';
> +}
