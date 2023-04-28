Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED806F1B73
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Apr 2023 17:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346412AbjD1PZU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Apr 2023 11:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346416AbjD1PZG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Apr 2023 11:25:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882326185
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Apr 2023 08:24:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C60A81FE3A;
        Fri, 28 Apr 2023 15:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682695488;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0PT5jKADSXzT7phEGusn6QsBpUrSFaw/BdRK46IhT/o=;
        b=A4LnqzRwufPJ+hqCk2qYkrS7SdAgJEh7Nfyan9VFDvUTtpTXh86Mx/5Yq/6tM4ZCfOV8an
        3RENwklR5Ed54MC8wiCUbU3rNcuQUvbuwrZ/AAtoqSlRVICE6GOKAg2dkz1XAlImkN7Vym
        DZd6o7Pn0JA+LHTDjoFnQSzbR6FRZ+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682695488;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0PT5jKADSXzT7phEGusn6QsBpUrSFaw/BdRK46IhT/o=;
        b=rvzBEkF7qui2jST1CYcjWdDMLneZe9fkoUurYbTtgxhFvraXfMyFHNEopT+075ROjJRIX7
        9lylVZIL4PzHIVCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93297138FA;
        Fri, 28 Apr 2023 15:24:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wQYRI0DlS2SJWwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 28 Apr 2023 15:24:48 +0000
Date:   Fri, 28 Apr 2023 17:18:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naota@elisp.net>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH v2] btrfs: export bitmap_test_range_all_{set,zero}
Message-ID: <20230428151855.GB2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <327d53937163049c1b80a34bda2edb570b42aa78.1682435691.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <327d53937163049c1b80a34bda2edb570b42aa78.1682435691.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 26, 2023 at 12:19:40AM +0900, Naohiro Aota wrote:
> bitmap_test_range_all_{set,zero} defined in subpage.c are useful for other
> components. Move them to misc.h and use them in zoned.c. Also, as
> find_next{,_zero}_bit take/return "unsigned long" instead of "unsigned
> int", convert the type to "unsigned long".
> 
> While at it, also rewrite the "if (...) return true; else return false;"
> pattern.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to misc-next, thanks.

> ---
>  fs/btrfs/misc.h    | 20 ++++++++++++++++++++
>  fs/btrfs/subpage.c | 22 ----------------------
>  fs/btrfs/zoned.c   | 12 ++++++------
>  3 files changed, 26 insertions(+), 28 deletions(-)
> 
> - v2
>   - Reformat the code
>   - Rewrite the return condition
>   - Fix conversion in btrfs_find_allocatable_zones()
> 
> diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
> index 768583a440e1..c83366638fbd 100644
> --- a/fs/btrfs/misc.h
> +++ b/fs/btrfs/misc.h
> @@ -143,4 +143,24 @@ static inline struct rb_node *rb_simple_insert(struct rb_root *root, u64 bytenr,
>  	return NULL;
>  }
>  
> +static inline bool bitmap_test_range_all_set(unsigned long *addr,
> +					     unsigned long start,
> +					     unsigned long nbits)
> +{
> +	unsigned long found_zero;
> +
> +	found_zero = find_next_zero_bit(addr, start + nbits, start);
> +	return (found_zero == start + nbits);

Simplifying the condition like that is OK.
