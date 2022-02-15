Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22E54B7307
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Feb 2022 17:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239580AbiBOPIm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Feb 2022 10:08:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbiBOPIg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Feb 2022 10:08:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A5C13DD1;
        Tue, 15 Feb 2022 07:08:25 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 81ABC1F37B;
        Tue, 15 Feb 2022 15:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644937704;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zhk4/91C3e+YkYM2+SRpLRxG7ckMTOQFQbSvDNdYTWI=;
        b=ahsWbwnqI3Ks6ZwsQMJ5yMtJHyPAJac6xHzarwIXMAfx8NE3hbFeDmwEbHba/kH4GqTaAI
        gydGXK8DQdfAszLOxPr0hwrcHfvi3bbEF0Ys2JmP1KpKipuP0W4YYzC/e71bsIzCi2IS8f
        I5FJVG8k5iUqtN3XGp9o0saoNJw1bEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644937704;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zhk4/91C3e+YkYM2+SRpLRxG7ckMTOQFQbSvDNdYTWI=;
        b=BGfnFGql/hHNMUShGbRHEbx8VcamIY7ndr5NlGBTfSSsdp3TmIBS9omh63kAsqTH8uPb+7
        fkWnWNlN6wibxuDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 71723A3B89;
        Tue, 15 Feb 2022 15:08:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7C465DA818; Tue, 15 Feb 2022 16:04:39 +0100 (CET)
Date:   Tue, 15 Feb 2022 16:04:38 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: add fs state details to error messages.
Message-ID: <20220215150438.GN12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220212191042.94954-1-sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212191042.94954-1-sweettea-kernel@dorminy.me>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 12, 2022 at 02:10:42PM -0500, Sweet Tea Dorminy wrote:
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
> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
>  fs/btrfs/super.c | 49 +++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 40 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 33cfc9e27451..d0e81eb48eac 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -66,6 +66,31 @@ static struct file_system_type btrfs_root_fs_type;
>  
>  static int btrfs_remount(struct super_block *sb, int *flags, char *data);
>  
> +#define STATE_STRING_PREFACE ": state "
> +#define MAX_STATE_CHARS 2
> +
> +static void btrfs_state_to_string(const struct btrfs_fs_info *info, char *buf)
> +{
> +	unsigned long state = info->fs_state;
> +	char *curr = buf;
> +
> +	memcpy(curr, STATE_STRING_PREFACE, sizeof(STATE_STRING_PREFACE));
> +	curr += sizeof(STATE_STRING_PREFACE) - 1;
> +
> +	/* If more states are reported, update MAX_STATE_CHARS also */
> +	if (test_and_clear_bit(BTRFS_FS_STATE_ERROR, &state))

The state is supposed to be sticky, so can't be cleared. Also as I read
the suggested change, the "state: " should be visible for all messages
that are printed after the filesystem state changes.

> +		*curr++ = 'E';
> +
> +	if (test_and_clear_bit(BTRFS_FS_STATE_TRANS_ABORTED, &state))
> +		*curr++ = 'X';
> +
> +	/* If no states were printed, reset the buffer */
> +	if (state == info->fs_state)
> +		curr = buf;
> +
> +	*curr++ = '\0';
> +}
> +
>  /*
>   * Generally the error codes correspond to their respective errors, but there
>   * are a few special cases.
> @@ -128,6 +153,7 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
>  {
>  	struct super_block *sb = fs_info->sb;
>  #ifdef CONFIG_PRINTK
> +	char statestr[sizeof(STATE_STRING_PREFACE) + MAX_STATE_CHARS];
>  	const char *errstr;
>  #endif
>  
> @@ -136,10 +162,11 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
>  	 * under SB_RDONLY, then it is safe here.
>  	 */
>  	if (errno == -EROFS && sb_rdonly(sb))
> -  		return;
> +		return;

Unnecessary change.

>  
>  #ifdef CONFIG_PRINTK
>  	errstr = btrfs_decode_error(errno);
> +	btrfs_state_to_string(fs_info, statestr);
>  	if (fmt) {
>  		struct va_format vaf;
>  		va_list args;
> @@ -148,12 +175,12 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
>  		vaf.fmt = fmt;
>  		vaf.va = &args;
>  
> -		pr_crit("BTRFS: error (device %s) in %s:%d: errno=%d %s (%pV)\n",
> -			sb->s_id, function, line, errno, errstr, &vaf);
> +		pr_crit("BTRFS: error (device %s%s) in %s:%d: errno=%d %s (%pV)\n",
> +			sb->s_id, statestr, function, line, errno, errstr, &vaf);

Alternatively the state message can be built into the message itself so
it does not require the extra array.


		pr_crit("btrfs: error(device %s%s%s%s) ...",
			sb->s_id,
			statebits ? ", state" : "",
			test_bit(FS_ERRROR) ? "E" : "",
			test_bit(TRANS_ABORT) ? "T" : "", ...);

This is the idea, final code can use some wrappers around the bit
constatnts.


>  		va_end(args);
>  	} else {
> -		pr_crit("BTRFS: error (device %s) in %s:%d: errno=%d %s\n",
> -			sb->s_id, function, line, errno, errstr);
> +		pr_crit("BTRFS: error (device %s%s) in %s:%d: errno=%d %s\n",
> +			sb->s_id, statestr, function, line, errno, errstr);

Filling the temporary array makes sense as it's used twice, however I'm
not sure if the 'else' branch is ever executed.
