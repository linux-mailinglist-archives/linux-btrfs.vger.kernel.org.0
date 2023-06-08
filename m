Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9370972807E
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 14:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbjFHMxG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 08:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbjFHMxE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 08:53:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038C32D53;
        Thu,  8 Jun 2023 05:53:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8BCCD1FDCA;
        Thu,  8 Jun 2023 12:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686228781;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPHubNd3f4LvIUOL4xlFGBEM6B8nD1gJK4q0E01tl0s=;
        b=Te2moAQDad/Iq+YvfUOlr/O7BJK/IkovQcWqm+TfQkSsKbO6AOVcO0Paqyjh+92pJM51Iy
        To/etdyccNOWX8LPQfLggUItpJmHX35bB3kWOsf3BfVV4c5eWH5eTFwRhyiXnvwcnqLd5u
        Le+TNyhjVVEmPwleoVgqX5LqQS2PItc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686228781;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPHubNd3f4LvIUOL4xlFGBEM6B8nD1gJK4q0E01tl0s=;
        b=TAdbOVq+p5nbyyPlDBo6ilZtoKbBAg9RGeJuJnGRcEKSz/seGJnYKcpMn+KReIesxGhRbD
        aJSRso0xW2/gX2DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5FF7113480;
        Thu,  8 Jun 2023 12:53:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FkWdFi3PgWSTTAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 08 Jun 2023 12:53:01 +0000
Date:   Thu, 8 Jun 2023 14:46:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Ou Shixiong <oushixiong@kylinos.cn>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: initialize variable explicitly
Message-ID: <20230608124645.GJ28933@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230608024901.221232-1-oushixiong@kylinos.cn>
 <230384e8-55dc-579d-64e8-0c0263b72673@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <230384e8-55dc-579d-64e8-0c0263b72673@gmx.com>
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

On Thu, Jun 08, 2023 at 01:18:20PM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/6/8 10:49, Ou Shixiong wrote:
> >
> > Fix error of
> > error: ‘ret’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
> >
> > Signed-off-by: Ou Shixiong <oushixiong@kylinos.cn>
> 
> Not again.
> 
> Please explain how @ret can be uninitialized, and your toolchain version.
> 
> To me, this looks like a false alert, and it's possible your toolchain
> is out of date or lacks certain backports.

Yeah, for obvious false altert warnings at least we need to know the
compiler, version and architecture.
