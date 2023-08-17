Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAFA77FEDD
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 22:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354807AbjHQUJV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 16:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354809AbjHQUI6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 16:08:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029D230DF
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 13:08:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B9A651F461;
        Thu, 17 Aug 2023 20:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692302935;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/VelttwYq8T3mCh4eNfhx3NMn0gAHbG6auEE6G86tDM=;
        b=PbIfsKnI/B7J/+mr8comqaPCERl227beKhdXxeY2KKS3+UETSdxAG8F1d6uXgEB+EjWuJq
        GoHv1sROCJJIJmD3eIsxEsdGkvwWTBVWZLxkKOjfzk0C93mY3gkvr35olTM77DhRqHWny6
        4ZR5llwGuwmi5DdLCDwhvYU94glUPC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692302935;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/VelttwYq8T3mCh4eNfhx3NMn0gAHbG6auEE6G86tDM=;
        b=EWv8h/K+pS8HjqNUB2HxxpuMh2Omqzf1B14QhtWmV2dMQPDwpuU+dO3Qv0eaOHEtzFBQVx
        mkvbQIGVRzmm18Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99BD91392B;
        Thu, 17 Aug 2023 20:08:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o5WuJFd+3mSIWAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 17 Aug 2023 20:08:55 +0000
Date:   Thu, 17 Aug 2023 22:02:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Heiss <christoph@c8h4.io>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 7/7] btrfs-progs: subvol show: implement json format
 output
Message-ID: <20230817200226.GW2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230813094555.106052-1-christoph@c8h4.io>
 <20230813094555.106052-8-christoph@c8h4.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813094555.106052-8-christoph@c8h4.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 13, 2023 at 11:45:02AM +0200, Christoph Heiss wrote:
> Implements JSON-formatted output for the `subvolume list` command using
> the `--format json` global option, much like it is implemented for other
> commands.
> 
> Signed-off-by: Christoph Heiss <christoph@c8h4.io>
> ---
>  cmds/subvolume.c | 108 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 98 insertions(+), 10 deletions(-)
> 
> diff --git a/cmds/subvolume.c b/cmds/subvolume.c
> index f7076655..1f513a4a 100644
> --- a/cmds/subvolume.c
> +++ b/cmds/subvolume.c
> @@ -1375,6 +1375,64 @@ static void print_subvolume_show_quota_text(const struct btrfs_util_subvolume_in
>  			pretty_size_mode(stats->info.exclusive, unit_mode));
>  }
>  
> +static void print_subvolume_show_json(struct format_ctx *fctx,
> +				      const struct btrfs_util_subvolume_info *subvol,
> +				      const char *subvol_path, const char *subvol_name)
> +{
> +	fmt_print(fctx, "name", subvol_name);
> +
> +	if (!uuid_is_null(subvol->uuid))
> +		fmt_print(fctx, "uuid", subvol->uuid);

Regarding the "more is better" approach, no conditionals for similar
data.

> +	if (!uuid_is_null(subvol->parent_uuid))
> +		fmt_print(fctx, "parent_uuid", subvol->parent_uuid);
> +	if (!uuid_is_null(subvol->received_uuid))
> +		fmt_print(fctx, "received_uuid", subvol->received_uuid);
> +
> +	fmt_print(fctx, "otime", subvol->otime);
> +	fmt_print(fctx, "ID", subvol->id);
> +	fmt_print(fctx, "gen", subvol->generation);
> +	fmt_print(fctx, "cgen", subvol->otransid);
> +	fmt_print(fctx, "parent", subvol->parent_id);
> +	fmt_print(fctx, "top level", subvol->parent_id);
> +
> +	fmt_print_start_group(fctx, "flags", JSON_TYPE_ARRAY);
> +	if (subvol->flags & BTRFS_ROOT_SUBVOL_RDONLY)
> +		fmt_print(fctx, "flag-list-item", "readonly");
> +	fmt_print_end_group(fctx, "flags");
> +
> +	if (subvol->stransid)
> +		fmt_print(fctx, "stransid", subvol->stransid);
> +
> +	if (subvol->stime.tv_sec)
> +		fmt_print(fctx, "stime", subvol->stime);
> +
> +	if (subvol->rtransid)
> +		fmt_print(fctx, "rtransid", subvol->rtransid);
> +
> +	if (subvol->rtime.tv_sec)
> +		fmt_print(fctx, "rtime", subvol->rtime);
> +}
