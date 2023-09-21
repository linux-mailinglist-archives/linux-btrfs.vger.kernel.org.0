Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD7C7A96F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Sep 2023 19:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjIURKr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 13:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjIURJX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 13:09:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F066C7280
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Sep 2023 10:05:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4DC681F460;
        Thu, 21 Sep 2023 16:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695314834;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O8V7mHc8IrcXYXf11NPbIduvlDjbXiRa4A9aFf6YEJM=;
        b=pLHgJYnAb9yLTnDkun0IZZpQPwHRIfsWllLC5Au82vM1qfrZPM5D1p8zTNgfx4Ql8yZLEd
        uHjyEIaMvuIoCHaryQ2Cu0vOo00fDfjO4oJ8r5kuAi8gAS5qXXrNQSQ2JhdoJWVcVQFvy1
        QbYSjFe4TFGont4RfE2p7j0advCw9os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695314834;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O8V7mHc8IrcXYXf11NPbIduvlDjbXiRa4A9aFf6YEJM=;
        b=hsxjDIoWUKVAFNCDddV2m53cuq5kQtCSwwY6dgKJwSl6droITg3VKJBO+RjxHYO7nSbAc8
        /Nswasd98qJm+RCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2857413513;
        Thu, 21 Sep 2023 16:47:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MaYZCZJzDGXNIwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 21 Sep 2023 16:47:14 +0000
Date:   Thu, 21 Sep 2023 18:40:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix RAID10 writing
Message-ID: <20230921164039.GA5906@suse.cz>
Reply-To: dsterba@suse.cz
References: <a2cecda31933ba147591d3b8017e09acf9605681.1695293696.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2cecda31933ba147591d3b8017e09acf9605681.1695293696.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 21, 2023 at 03:55:43AM -0700, Johannes Thumshirn wrote:
> Fix out of bounds write uncovered by fsstress testing RAID10.
> 
> Fixes: 341908a5aaa0 ("btrfs: add support for inserting raid stripe extents")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Commit updated, thanks.
