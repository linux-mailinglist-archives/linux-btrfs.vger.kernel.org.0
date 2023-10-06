Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068FF7BBBE1
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Oct 2023 17:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjJFPkZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 11:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjJFPkY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 11:40:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BAF9E
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Oct 2023 08:40:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4C4281F896;
        Fri,  6 Oct 2023 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696606822;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mmHO/oK6NrODW49IKV+59hSq0kZX+7cb8Lg3wI2VaqA=;
        b=zEhh0ENNNtl+thERXuc51SV01n6j2fwXcFP3zhr07CIKYhepKRLqCNXsZdPKMcndiHitcl
        hgyuR8V6uX+a6Z1QBzsJQaPb8dWeXdMCcaNkB5sBFX0oJwN2XHAhisOoAbDGIsUpiLT2ly
        Tm4btRBT76zzaNNBpaymEnMi0ta76tM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696606822;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mmHO/oK6NrODW49IKV+59hSq0kZX+7cb8Lg3wI2VaqA=;
        b=8/3EIAqaQ5bpAHTrOFop/OK+Fg4NKgR4n1XMcoqw5CTrOY4czRs5MPwxXP7DH0IFk7plUc
        NDUbzO/zMXXBzbDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30E5B13A2E;
        Fri,  6 Oct 2023 15:40:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8zUbC2YqIGXmBQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 06 Oct 2023 15:40:22 +0000
Date:   Fri, 6 Oct 2023 17:33:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: dump-tree: allow using '-' for tree ids
Message-ID: <20231006153338.GJ28758@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a59a24349345a83c7594ea0340278061ce35a912.1696398970.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a59a24349345a83c7594ea0340278061ce35a912.1696398970.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 04, 2023 at 04:26:14PM +1030, Qu Wenruo wrote:
> Currently for multi-word tree names, we only allow '_' to connect the
> two words, like "block_group".
> 
> Meanwhile for mkfs features, we go '-' to connect two words, like
> "block-group-tree".
> This makes users to use different separators for different commands.
> 
> This patch would allow using both '-' and '_' for tree ids.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
