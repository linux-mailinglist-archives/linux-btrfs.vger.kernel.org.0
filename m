Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DC8728071
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 14:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbjFHMuX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 08:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbjFHMuW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 08:50:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B34272E
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 05:50:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B534721A44;
        Thu,  8 Jun 2023 12:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686228604;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HCfvf3McKzmOywuyv+M8IW2Z7N8EnuvJyIr6RZdVGrQ=;
        b=CZktdg0w/RMwliEQ+gG2GhWHzJ7nldzJGbd1QcvZTrMCHjRwkkNSn2e8j8icMQPbmxEbuk
        fyILxdA63BTAYk9pUpO4zfJmEk9k5iuwasQiePBs/mxEcOetm16mEr/ByB6ZZelAe0l4/t
        2V6BObB1r0LIiWash0VJZAuIG2MU4Co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686228604;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HCfvf3McKzmOywuyv+M8IW2Z7N8EnuvJyIr6RZdVGrQ=;
        b=dRVEATQmqs9DIvX2V1CGd43sdKj6RyYrepzt4P+ydwP9TfoZiBm8FMnFoo99pSDC5bSajD
        0xiw/bArQqdoJFAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 957D513480;
        Thu,  8 Jun 2023 12:50:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2GebI3zOgWQdSwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 08 Jun 2023 12:50:04 +0000
Date:   Thu, 8 Jun 2023 14:43:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 6/7] btrfs-progs: factor out btrfs_scan_stdin_devices
Message-ID: <20230608124348.GI28933@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1686202417.git.anand.jain@oracle.com>
 <3c660a0d48f5e8d50fb932dee473fc1d86c0838e.1686202417.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c660a0d48f5e8d50fb932dee473fc1d86c0838e.1686202417.git.anand.jain@oracle.com>
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

On Thu, Jun 08, 2023 at 02:01:03PM +0800, Anand Jain wrote:
> To prepare for handling command line given devices factor out
> btrfs_scan_stdin_devices().

I find using 'stdin' in this context confusion, the tool is not
taking the devices from stdin, but command line arguments. You can use
'argv' for that.
