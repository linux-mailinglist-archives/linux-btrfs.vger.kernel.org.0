Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2739A4BE1EF
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Feb 2022 18:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiBUQml (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Feb 2022 11:42:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381065AbiBUQmc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Feb 2022 11:42:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CF015A29;
        Mon, 21 Feb 2022 08:41:57 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 32CE31F38E;
        Mon, 21 Feb 2022 16:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645461716;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=63OIUUWVRi7zDz7jhlALynEfvto/B2lOfcLNN/pBnCk=;
        b=tfoszk1TQuRmiaUhb3ZS0cKZsacOwFAKHL/bEpMzt0P1n9gpZULkRdsB07v6J2NLd53rv+
        ryWIvlaCbtkyHfpruJ/mTctDHHm9kg2FSpB3HwlTAuNZGjFTj6jyZV2/5voCEG/C7rRA/g
        n/l90+Cj/2zexGnczvpg5DPnP/F0vKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645461716;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=63OIUUWVRi7zDz7jhlALynEfvto/B2lOfcLNN/pBnCk=;
        b=KWca5eHSKxCbyM8qiMFPEg/Fmk5Bb4+K9SrvcuY9Rh91JavN5UZHLj3h70+aAJxPzlJT//
        N9LBSWWUFMFfttAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2A065A3B83;
        Mon, 21 Feb 2022 16:41:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B8E0EDA823; Mon, 21 Feb 2022 17:38:08 +0100 (CET)
Date:   Mon, 21 Feb 2022 17:38:08 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs: add fs state details to error messages.
Message-ID: <20220221163808.GI12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <084c136c6bb2d20ca0e91af7ded48306d52bb910.1645210326.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <084c136c6bb2d20ca0e91af7ded48306d52bb910.1645210326.git.sweettea-kernel@dorminy.me>
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

On Fri, Feb 18, 2022 at 02:04:29PM -0500, Sweet Tea Dorminy wrote:
> When a filesystem goes read-only due to an error, multiple errors tend
> to be reported, some of which are knock-on failures. Logging some
> fs_states, if any, in btrfs_handle_fs_error() and btrfs_printk()
> helps distinguish the first error from subsequent messages which may
> only exist due to an error state.
> 
> Under the new format, most initial errors will look like:
> `BTRFS: error (device loop0) in ...`
> while subsequent errors will begin with:
> `error (device loop0: state E) in ...`
> 
> An initial transaction abort error will look like
> `error (device loop0: state X) in ...`
> and subsequent messages will contain
> `(device loop0: state EX) in ...`

I think there should be also BTRFS_FS_STATE_LOG_CLEANUP_ERROR, and the
letter maybe more hinting of the error:

E - generic error
A - transaction abort
L - log related errors

> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
> v2:
>   - Changed btrfs_state_to_string() for clarity
>   - Removed superfluous whitespace change
> 
> v1:
>   - https://lore.kernel.org/linux-btrfs/20220212191042.94954-1-sweettea-kernel@dorminy.me/
> 
>  fs/btrfs/super.c | 53 ++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 45 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 4d947ba32da9..42429d68950d 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -66,6 +66,37 @@ static struct file_system_type btrfs_root_fs_type;
>  
>  static int btrfs_remount(struct super_block *sb, int *flags, char *data);
>  
> +#define STATE_STRING_PREFACE ": state "
> +#define MAX_STATE_CHARS 2
> +
> +static void btrfs_state_to_string(const struct btrfs_fs_info *info, char *buf)
> +{
> +	unsigned int states_printed = 0;
> +	char *curr = buf;
> +
> +	memcpy(curr, STATE_STRING_PREFACE, sizeof(STATE_STRING_PREFACE));
> +	curr += sizeof(STATE_STRING_PREFACE) - 1;
> +
> +	/* If more states are reported, update MAX_STATE_CHARS also */
> +	if (test_bit(BTRFS_FS_STATE_ERROR, &info->fs_state)) {
> +		*curr++ = 'E';
> +		states_printed++;
> +	}
> +
> +	if (test_bit(BTRFS_FS_STATE_TRANS_ABORTED, &info->fs_state)) {
> +		*curr++ = 'X';
> +		states_printed++;
> +	}
> +

So if we have more than 2 it may make sense to create a table and not to
opencode it like that and then use the constants (MAX_STATE_CHARS)
everywhere. For first implementation it's probably ok to have it like
three ifs.

> +	/* If no states were printed, reset the buffer */
> +	if (!states_printed)
> +		curr = buf;
> +
> +	WARN_ON_ONCE(states_printed > MAX_STATE_CHARS);
> +
> +	*curr++ = '\0';
> +}
> +
>  /*
>   * Generally the error codes correspond to their respective errors, but there
>   * are a few special cases.
> @@ -128,6 +159,7 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
>  {
>  	struct super_block *sb = fs_info->sb;
>  #ifdef CONFIG_PRINTK
> +	char statestr[sizeof(STATE_STRING_PREFACE) + MAX_STATE_CHARS];

A size defintion like that could be also predefined.

>  	const char *errstr;
>  #endif
>  
> @@ -140,6 +172,7 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
>  
>  #ifdef CONFIG_PRINTK
>  	errstr = btrfs_decode_error(errno);
> +	btrfs_state_to_string(fs_info, statestr);
>  	if (fmt) {
>  		struct va_format vaf;
>  		va_list args;
> @@ -148,12 +181,12 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
>  		vaf.fmt = fmt;
>  		vaf.va = &args;
>  
> -		pr_crit("BTRFS: error (device %s) in %s:%d: errno=%d %s (%pV)\n",
> -			sb->s_id, function, line, errno, errstr, &vaf);
> +		pr_crit("BTRFS: error (device %s%s) in %s:%d: errno=%d %s (%pV)\n",
> +			sb->s_id, statestr, function, line, errno, errstr, &vaf);
>  		va_end(args);
>  	} else {
> -		pr_crit("BTRFS: error (device %s) in %s:%d: errno=%d %s\n",
> -			sb->s_id, function, line, errno, errstr);
> +		pr_crit("BTRFS: error (device %s%s) in %s:%d: errno=%d %s\n",
> +			sb->s_id, statestr, function, line, errno, errstr);
>  	}
>  #endif
>  
> @@ -240,11 +273,15 @@ void __cold btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, .
>  	vaf.va = &args;
>  
>  	if (__ratelimit(ratelimit)) {
> -		if (fs_info)
> -			printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
> -				fs_info->sb->s_id, &vaf);
> -		else
> +		if (fs_info) {
> +			char statestr[sizeof(STATE_STRING_PREFACE) + MAX_STATE_CHARS];
> +
> +			btrfs_state_to_string(fs_info, statestr);
> +			printk("%sBTRFS %s (device %s%s): %pV\n", lvl, type,
> +				fs_info->sb->s_id, statestr, &vaf);
> +		} else {
>  			printk("%sBTRFS %s: %pV\n", lvl, type, &vaf);
> +		}
>  	}
>  
>  	va_end(args);
> -- 
> 2.35.1
