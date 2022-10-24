Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765BC60AE93
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Oct 2022 17:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiJXPIx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 11:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbiJXPIX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 11:08:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47E641526
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 06:44:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DD9DB21CA0;
        Mon, 24 Oct 2022 13:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666618588;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z5AGpEGNAdNpPvNGlqGcP135hPkUWbbQVZ+ZYWCXmjc=;
        b=wqZeQrIDju5K6WLXiAT/+EpzqzHOKrnyf8DhwadoZ6m7fOLcieBaeDNMOV+XZ+dOHA3k0n
        VqvB8yUHL+R1KkSwCeNgDYG/yLorPoEjDcq3Uu1DMJDRFyt5lgSAZDJMM1+j1q3VlG5n7E
        60ZZ9SVHlRiS1nuEXQx7EDVui+RKrJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666618588;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z5AGpEGNAdNpPvNGlqGcP135hPkUWbbQVZ+ZYWCXmjc=;
        b=3EXT+g+ecHHCEYIQA6chSf1gCfhNa/Kn451toMj7a5wSWowgUS7dixXEqevC4qaYlAT0Bg
        60qkmp/Vh7evJqCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5C5213357;
        Mon, 24 Oct 2022 13:36:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id r4hUL9yUVmNcAgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 24 Oct 2022 13:36:28 +0000
Date:   Mon, 24 Oct 2022 15:36:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: add helper to exit_btrfs_fs
Message-ID: <20221024133615.GA5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <fb7c86d19039270ace7c3ecb6d2cb96cf0406808.1666191132.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb7c86d19039270ace7c3ecb6d2cb96cf0406808.1666191132.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 19, 2022 at 09:51:42PM +0530, Anand Jain wrote:
> The module exit function exit_btrfs_fs() is duplicating a section of code
> in init_btrfs_fs(). So add a helper function to remove the duplicate code.
> Also, remove the comment about the function's .text section, which
> doesn't make sense.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2:
> Use __always_inline in the helper function, inline regardless, helps ensure
> same sections as the parent function.

This should have been mentioned in the changelog as it's explaining why
the __always_inline is there to avoid the section mismatches. Updated
and added to misc-next, thanks.
