Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA5D532F67
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 19:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239919AbiEXRH3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 13:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239892AbiEXRHI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 13:07:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C369F819B2
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 10:06:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2B034219CB;
        Tue, 24 May 2022 17:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653412016;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zZfsoYgreX0EvHhJnhMOhMw+eWuSG0jcP8kLAox0YXQ=;
        b=Y0t3/t/C4F6k/e5l3bAeEdNhZSCmqTKy+6K2Z99egRuf5cmhXuwX2CW6sK0QP0nIyHoUK6
        j7Q6UhCXUQvhFmhT7btLcERkZBxqMx8Xz1+CbNeFicbd4DggsAnSKICtwiL0PHNoYIq5gW
        XQISezsd/UUPjSsX2y1QDfmMb0XbOQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653412016;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zZfsoYgreX0EvHhJnhMOhMw+eWuSG0jcP8kLAox0YXQ=;
        b=eyfjClqmHpcwFq675Saa0VheqxWEXrr3hde9Z3UK2s0EzTP3LQVf9izVIqYzgWAmUqWI78
        7QakYNeZsqhwsJDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1159A13AE3;
        Tue, 24 May 2022 17:06:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZGNNA7AQjWK0aQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 24 May 2022 17:06:56 +0000
Date:   Tue, 24 May 2022 19:02:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Message-ID: <20220524170234.GW18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <f6679e0b681f9b1a74dfccbe05dcb5b6eb0878f6.1653372729.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6679e0b681f9b1a74dfccbe05dcb5b6eb0878f6.1653372729.git.wqu@suse.com>
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

On Tue, May 24, 2022 at 02:13:47PM +0800, Qu Wenruo wrote:
> This is the draft version of the on-disk format for RAID56J journal.
> 
> The overall idea is, we have the following elements:
> 
> 1) A fixed header
>    Recording things like if the journal is clean or dirty, and how many
>    entries it has.
> 
> 2) One or at most 127 entries
>    Each entry will point to a range of data in the per-device reserved
>    range.
> 
> 3) Data in the remaining reserved space
> 
> The write time and recovery workflow is embedded into the on-disk
> format.
> 
> Unfortunately we will not have any optimization for the RAID56J, every
> write will be journaled, no exception.
> 
> Furthermore due to current write behavior of RAID56, we always submit a
> full 64K stripe no matter what, we have every limited size for the data
> part (at most 15 64K stripe).
> 
> So far, I don't believe we will have a fast RAID56J at all.

Well, that does not sound encouraging. One option discussed in the past
how to fix the write hole was to always do full RMW cycle. Having a "not
fast journal at all" would require a format change and have probably a
comparable performance drop.
