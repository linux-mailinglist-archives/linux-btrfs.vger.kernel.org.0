Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1784D735D2D
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jun 2023 19:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjFSRxR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jun 2023 13:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjFSRxP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jun 2023 13:53:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A36B7
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jun 2023 10:53:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2ADD61F86C;
        Mon, 19 Jun 2023 17:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687197188;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c/Uf9IOgbvRoiOgp/jLnybEsGAuzkaywlYJtt9rKrhs=;
        b=iBx5APAApdkNY75Xi6sRfCpcCO6mEpSZw2NTZhOWYejYlEAmNrbjEsv+73iszNET8gIygu
        ANErHEpRL7/Kow4PXTsHfwoZmJY6W500d+aanzTIWzLic3rvPeob6P042pmQtBouCteHeY
        xjILV20T+sSNIgso1DTivT8f44BukCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687197188;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c/Uf9IOgbvRoiOgp/jLnybEsGAuzkaywlYJtt9rKrhs=;
        b=LS9gBJgtPRswxGP2+yL64UQCoPS2Heu2+9xrrSsi9h0YSCxQ6tadxo5TvI39+dIbIYrZ2Q
        d7k3v6NcRIbMGEAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0757C139C2;
        Mon, 19 Jun 2023 17:53:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P1HxAASWkGTwfwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 19 Jun 2023 17:53:08 +0000
Date:   Mon, 19 Jun 2023 19:46:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: also show actual number of the outstanding extents
Message-ID: <20230619174645.GD16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2a166dcefbdc57e4ff6b4304e0bff1ead9b9cd8e.1687140789.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a166dcefbdc57e4ff6b4304e0bff1ead9b9cd8e.1687140789.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 19, 2023 at 11:15:31AM +0900, Naohiro Aota wrote:
> The btrfs_inode_mod_outstanding_extents trace event only shows the modified
> number to the number of outstanding extents. It would be helpful if we can
> see the resulting extent number as well.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to misc-next, thanks.
