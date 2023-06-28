Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B655741B1C
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 23:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjF1VsZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 17:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF1VsY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 17:48:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732121FF7
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 14:48:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 295D221847;
        Wed, 28 Jun 2023 21:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687988902;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KRa6bOJr0pBzde1De/1A0qMkd8ODHNgIrx/jORY569A=;
        b=wRC5lWQ4KZtx6tzmRx/PhorVu7Frc4ydfL4H63Ka5wkg6QG1JYZTxDIK0yYLoGErbaDcT0
        hfE+cT9ckgZCOHyumJCb/H12MqnK9jVxzs6dxmq94XAsV4KYw4dR2qwDRtZs0AzeHHlUM4
        j45DbApi5EYXHLIIWfKxC9/o1eG63ME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687988902;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KRa6bOJr0pBzde1De/1A0qMkd8ODHNgIrx/jORY569A=;
        b=8fY3U2qCupGwhYVIsQxUOGiXof9J4AqE6iLG7FTA9y+6teHgkNZPhKhatM50n+DzEy7CCF
        kHYY2t2cPUIGBaAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0399F138EF;
        Wed, 28 Jun 2023 21:48:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yASJO6WqnGQ+XwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 28 Jun 2023 21:48:21 +0000
Date:   Wed, 28 Jun 2023 23:41:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs-progs: dump-super: fix read beyond device size
Message-ID: <20230628214153.GF16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1687854248.git.anand.jain@oracle.com>
 <6e8980b7306716ed8a71dc50868169ae96424e79.1687854248.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e8980b7306716ed8a71dc50868169ae96424e79.1687854248.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 27, 2023 at 04:53:15PM +0800, Anand Jain wrote:
> @@ -33,8 +34,27 @@ static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
>  		int force)
>  {
>  	struct btrfs_super_block sb;
> +	struct stat st;
>  	u64 ret;
>  
> +	if (fstat(fd, &st)) {
> +		error("error = '%m', errno = %d", errno);
> +		return 1;
> +	}
> +
> +	if (S_ISBLK(st.st_mode) || S_ISREG(st.st_mode)) {
> +		off_t last_byte;
> +
> +		last_byte = lseek(fd, 0, SEEK_END);
> +		if (last_byte == -1) {
> +			error("error = '%m', errno = %d", errno);

Such error messages are not useful, there should be a description of the
problem with %m for the error text. I've updated it.

> +			return 1;
> +		}
> +
> +		if (sb_bytenr > last_byte)
> +			return 0;
> +	}
> +
>  	ret = sbread(fd, &sb, sb_bytenr);
>  	if (ret != BTRFS_SUPER_INFO_SIZE) {
>  		/* check if the disk if too short for further superblock */
> @@ -54,6 +74,7 @@ static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
>  		return 1;
>  	}
>  	btrfs_print_superblock(&sb, full);
> +	putchar('\n');
>  	return 0;
>  }
