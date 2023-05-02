Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0018D6F4781
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 17:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjEBPk2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 11:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbjEBPk0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 11:40:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89F1E7
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 08:40:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9BDAC215EF;
        Tue,  2 May 2023 15:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683042023;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aXh7a5v0wdUnBH1PNV1GRhG+0mmnZhF4NzfBEM5iuN4=;
        b=xm/eMpgssYkas5Vibvs+bFqBs95isfDNPTc1PJtjsGNo8iIy7o6diYGEskGCm/Hkk0P5zs
        aeVKss40pdsbfYPsIdp8mul7B/Mi8WhTWB+teCxiKPge8hu/yLi/QiwAAF2nmKrH6kZ838
        7tYrMc0bQBap3UdkKsADZdqfAj1gcCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683042023;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aXh7a5v0wdUnBH1PNV1GRhG+0mmnZhF4NzfBEM5iuN4=;
        b=HcsAab/Aih+DioXYieENmVXVrsUlTwvcpwjxW/XjYOOqPx/AGosrMtXU5D9PuraCvbotG5
        GoPjdHU7KJNkS/BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 79A35134FB;
        Tue,  2 May 2023 15:40:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BwvSHOcuUWTmJwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 May 2023 15:40:23 +0000
Date:   Tue, 2 May 2023 17:34:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: small improvement to leaf dump
Message-ID: <20230502153428.GG8111@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1682597619.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1682597619.git.wqu@suse.com>
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

On Thu, Apr 27, 2023 at 08:16:26PM +0800, Qu Wenruo wrote:
> The first patch is just constify the tree dump infrastructure, exposed
> during the development.
> 
> The second patch is the main dish, inspired by a report that turns out
> to be bitflip in extent tree.
> However the leaf dump in dmesg is pretty large (100+ slots), needs to
> manually search the leaf using the bytenr from the error messages.
> 
> Thus if we can output the slot number, it would be much easier to locate
> the problem, just like what we did in tree-checker.
> 
> Qu Wenruo (2):
>   btrfs: print-tree: accept const extent buffer pointer
>   btrfs: improve leaf dump and error handling

Added to misc-next, thanks.
