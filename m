Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3727B0962
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 17:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjI0PxB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 11:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjI0Pwt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 11:52:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB23198
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 08:39:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D95C1218D5;
        Wed, 27 Sep 2023 15:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695829138;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yIQ1+iYxPz1Y97iCsR+1tJYFgDbvQ54Cer89S69y6NQ=;
        b=b500jzEKFQGDNUMAkwblTo2WBY1RgGFltKu/NDrdgmGcWQ7N6n2FzjhA2/SFr1MvekWBvu
        1AqX5Yc9ZloQG33XajCTeqW/0Jdul/a6DVc9FhCHRuTIqaVAHmV2P143oA07ShKu8Hyxu7
        uTXrvzBvlxgmCGd0Qn59qt4M9lyEhzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695829138;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yIQ1+iYxPz1Y97iCsR+1tJYFgDbvQ54Cer89S69y6NQ=;
        b=lBUN5P76y6DQpYXzA+TwPxBcg6GZM98J778d4518bCL+wZ4rMCFruX7hY/afdudIYyujIU
        LotPM7NM39qMdEDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA3BD13479;
        Wed, 27 Sep 2023 15:38:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8ZaLKJJMFGXKbQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 27 Sep 2023 15:38:58 +0000
Date:   Wed, 27 Sep 2023 17:32:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH] btrfs: reject unknown mount options early
Message-ID: <20230927153219.GY13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5c33940976b7f970836d8c796f92330e5072ffdc.1695777187.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c33940976b7f970836d8c796f92330e5072ffdc.1695777187.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 27, 2023 at 10:43:15AM +0930, Qu Wenruo wrote:
> [BUG]
> The following script would allow invalid mount options to be specified
> (although such invalid options would just be ignored):
> 
>  # mkfs.btrfs -f $dev
>  # mount $dev $mnt1		<<< Successful mount expected
>  # mount $dev $mnt2 -o junk	<<< Failed mount expected
>  # echo $?
>  0
> 
> [CAUSE]
> For the 2nd mount, since the fs is already mounted, we won't go through
> open_ctree() thus no btrfs_parse_options(), but only through
> btrfs_parse_subvol_options().
> 
> However we do not treat unrecognized options from valid but irrelevant
> options, thus those invalid options would just be ignored by
> btrfs_parse_subvol_options().
> 
> [FIX]
> Add the handling for Opt_error to handle invalid options and error out,
> while still ignore other valid options inside
> btrfs_parse_subvol_options().
> 
> Reported-by: Anand Jain <anand.jain@oracle.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
