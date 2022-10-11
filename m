Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA2E5FB2B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 14:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiJKMyy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 08:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiJKMyt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 08:54:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A4C3F33D
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 05:54:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CE9B620149;
        Tue, 11 Oct 2022 12:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665492886;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CLgdl4ZJrkla5M9LW4uIoCjfTH0pJrrASJZVx9qTqs4=;
        b=ON8B+N92/WxIDFIIf17Alf2dQL/zpl2WiV8PzL0IUNVD7lLHkaFgrAo6bSAMae+tpUaaH3
        Yq3XkpfclI/r2autV+JqnaXzHOmkOpQBTzFMCrWZRsxnC78KGbSrOe8e/nWx+RFTnzw+fD
        ljPFfS6sD74s9pkOwUOqYCdmPe80Yic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665492886;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CLgdl4ZJrkla5M9LW4uIoCjfTH0pJrrASJZVx9qTqs4=;
        b=ksYF1nP1Y4eelN5zDvv8jIDJnKhdPS2cJfKIykUoi/yAnZ6WLB6IQ0YiAKfsi7jZIweipD
        V7gZ9hqvp/lqTOCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0CFF13AAC;
        Tue, 11 Oct 2022 12:54:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TTgqKpZnRWP7XAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 11 Oct 2022 12:54:46 +0000
Date:   Tue, 11 Oct 2022 14:54:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/19] btrfs: fixes, cleanups and optimizations around
 fiemap
Message-ID: <20221011125440.GR13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1665490018.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1665490018.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 11, 2022 at 01:16:50PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The first 3 patches are bug fixes, the first two fixing bugs in backref
> walking that have been around since 2013 and 2017, respectively, while the
> third one fixes a bug introduced in this merge window.
> 
> The remaining are performance optimizations in the fiemap code path, as
> well as some cleanups and refactorings to support them. Results and tests
> are found in the changelogs of individual patches (06/19, 16/19, 18/19
> and 19/19).
> 
> V2: Add one more patch to fix a long standing bug (since 2013) regarding
>     delayed data references during backref walking. Made it first patch
>     in the series since later patches touched the surrounding code and
>     it should backported to stable releases.

Thanks, meanwhile v1 was in misc-next and got lightly tested so now
replaced by v2 and first three patches queued for 6.1.
