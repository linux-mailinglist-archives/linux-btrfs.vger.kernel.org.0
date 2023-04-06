Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C846DA057
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Apr 2023 20:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240153AbjDFSwq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Apr 2023 14:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjDFSwp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Apr 2023 14:52:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6211988
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Apr 2023 11:52:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B19FB21C34;
        Thu,  6 Apr 2023 18:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680807162;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NMHRF1iCrrTHkRhUUWjTwfikiPDE5upBWwjJCiVB6jY=;
        b=dn7+hXbxEuu69RfeqPRjdvUCcphYy41+PofUgBOJbDU3fH1v2E4v93jxbQFSXk1X3saWAr
        yOneRcoCcDFSjqwyv3ErWXpL2VXnGvgMUXSCZa4ygGBgRCc3T8xOpYwxEJcS2o9eSa0mtT
        mZZgBoLAxeXDpF/DlPlMQncHc9WPhtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680807162;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NMHRF1iCrrTHkRhUUWjTwfikiPDE5upBWwjJCiVB6jY=;
        b=AkGlSf7WlAIz8r/1GMcfKWfc6bD2JbIcuW7e3lwapZdvDXp6zLOqbhljtMmPaxM75xSADs
        hRmhs1yE8U/YvKCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91B4A1351F;
        Thu,  6 Apr 2023 18:52:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OVLYIvoUL2RSOgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 06 Apr 2023 18:52:42 +0000
Date:   Thu, 6 Apr 2023 20:52:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: some fsync updates when logging directories
Message-ID: <20230406185238.GY19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1680716778.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1680716778.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 05, 2023 at 06:51:28PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Two optimizations for directory logging, more details on the changelogs.
> 
> Filipe Manana (2):
>   btrfs: avoid iterating over all indexes when logging directory
>   btrfs: use log root when iterating over index keys when logging directory

Added to misc-next, thanks.
