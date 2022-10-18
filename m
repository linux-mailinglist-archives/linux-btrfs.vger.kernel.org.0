Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5A9602DC0
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 16:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJROBi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 10:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiJROBg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 10:01:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8F14F6B3
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 07:01:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AA91833E82;
        Tue, 18 Oct 2022 14:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666101694;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cL1dXvkAMwWGQ7OZyKc6fB3Gmh2mxwble665cmpzu8Y=;
        b=ty3CaS9SnbT9PT7ivNK/sCokqKHWYdl/q/M729wR2xJ1Z7g9I5rnFc6Zdr0oHvcgjaKLBB
        3wsV7pCYvxzUpR3fsE50O2W1KHZdGtEhxvdxUwtoo9IyIhvJ04lNfpkdwayEHBT2Ph3NRA
        YxEtRZDWO/zAY2NDhA6z5k9DzepIl9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666101694;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cL1dXvkAMwWGQ7OZyKc6fB3Gmh2mxwble665cmpzu8Y=;
        b=XSe+7woEahAx4t3uDVxTexkEk81WjlSn13YWRsC9Qbsk0gQvmQNbrSXbdX8vZgelF8dyUH
        gZdO7/Fl96WTeWCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C36C13480;
        Tue, 18 Oct 2022 14:01:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zCRJHb6xTmNNMAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 18 Oct 2022 14:01:34 +0000
Date:   Tue, 18 Oct 2022 16:01:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz,
        Wang Yugui <wangyugui@e16-tech.com>
Subject: Re: [PATCH] btrfs-progs: cmds: resize: fix check_resize_args()
 return value
Message-ID: <20221018140124.GY13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221016092927.200916-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221016092927.200916-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Oct 16, 2022 at 09:29:27AM +0000, Sidong Yang wrote:
> check_resize_args() function checks user argument amount and should
> returns it's validity. But now the code returns only zero. This patch
> make it correct to return ret. It also needs to set to zero after
> checking argument length.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Added to devel, thanks.
