Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B954D508B3D
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 16:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244629AbiDTO4C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 10:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbiDTO4B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 10:56:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2759E1CFD1
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 07:53:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D9D841F380;
        Wed, 20 Apr 2022 14:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650466393;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BS2Uc8fwjLSjTobj23WobLJ8aDIjgi3KDRidYvzLScY=;
        b=wMsGig870N69gyAsRCyvZGvbrZw1SQtFTj51snPa0ds7O87A2MCyivU2/17m/AIMa+zh+O
        8L+tzL23o6iQ8UarNtupotBNAvuQ2HFs+1Q+UvwLlSdHAohPib55QaGZrOkljDqwofiX66
        FGB+23OGmBxyn7r/eLn9BfjecX0o3vo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650466393;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BS2Uc8fwjLSjTobj23WobLJ8aDIjgi3KDRidYvzLScY=;
        b=FlWwLb6leob3XVVzDePPk1Xub0VkzAU/Q8yhMVM8XxMH57PMp8n84y3syw3r3KBEmWavck
        gKEMPAdr9I56LaAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A3A3213A30;
        Wed, 20 Apr 2022 14:53:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q8XxJlkeYGL3JQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 20 Apr 2022 14:53:13 +0000
Date:   Wed, 20 Apr 2022 16:49:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chung-Chiang Cheng <cccheng@synology.com>
Cc:     dsterba@suse.com, fdmanana@kernel.org, josef@toxicpanda.com,
        clm@fb.com, linux-btrfs@vger.kernel.org, shepjeng@gmail.com,
        kernel@cccheng.net
Subject: Re: [PATCH 1/2] btrfs: export a helper for compression hard check
Message-ID: <20220420144909.GD1513@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Chung-Chiang Cheng <cccheng@synology.com>, dsterba@suse.com,
        fdmanana@kernel.org, josef@toxicpanda.com, clm@fb.com,
        linux-btrfs@vger.kernel.org, shepjeng@gmail.com, kernel@cccheng.net
References: <20220415080406.234967-1-cccheng@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415080406.234967-1-cccheng@synology.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 15, 2022 at 04:04:05PM +0800, Chung-Chiang Cheng wrote:
> inode_can_compress will be used outside of inode.c to check the
> availability of setting compression flag by xattr. This patch moves
> this function as an internal helper and renames it to
> btrfs_inode_can_compress.
> 
> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>

Patches 1 and 2 added to misc-next, thanks.
