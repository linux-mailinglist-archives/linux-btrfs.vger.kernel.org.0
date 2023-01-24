Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E889A679FB9
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jan 2023 18:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbjAXRG5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Jan 2023 12:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbjAXRGZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Jan 2023 12:06:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D953CE383;
        Tue, 24 Jan 2023 09:05:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BCDF81FEAC;
        Tue, 24 Jan 2023 17:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674579903;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fd0YLnN8z/VnmscfwzAsfgcZxbqvvIWdMf5LIelQZzo=;
        b=IzhxSTsUUDR+eFsvEBAJHH+CkWGfZlUSRJ62Ovx4teLKFvG/zZHI692K5WX6uPHrZsfDl/
        ahGLYcZEYZndOkBbmuax3f8fmZBTnt9BHls7ie22obqQkfNvz7Dq+HaZhHPnawFm8zfwEH
        hSYkWCRYhYyG4RKeo/i35CisnW9WqAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674579903;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fd0YLnN8z/VnmscfwzAsfgcZxbqvvIWdMf5LIelQZzo=;
        b=MiDrl3GyZJRsPhm9e/r8I1C0hd3wbo9bBLFm7t8/B7cEFOQolX4+t7viSI6XNeQeZCyGaK
        91gQtqtxwja+Z1AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8118B139FB;
        Tue, 24 Jan 2023 17:05:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0/12Hr8P0GNcXQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 24 Jan 2023 17:05:03 +0000
Date:   Tue, 24 Jan 2023 17:59:21 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Alexander Potapenko <glider@google.com>
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ebiggers@kernel.org,
        syzbot+14d9e7602ebdf7ec0a60@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: zlib: zero-initialize zlib workspace
Message-ID: <20230124165921.GT11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230124113234.2070729-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124113234.2070729-1-glider@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 24, 2023 at 12:32:34PM +0100, Alexander Potapenko wrote:
> KMSAN reports uses of uninitialized memory in zlib's longest_match()
> called on memory originating from zlib_alloc_workspace().
> This issue is known by zlib maintainers and is claimed to be harmless,
> but to be on the safe side we'd better initialize the memory.
> 
> Link: https://zlib.net/zlib_faq.html#faq36
> Reported-by: syzbot+14d9e7602ebdf7ec0a60@syzkaller.appspotmail.com
> Signed-off-by: Alexander Potapenko <glider@google.com>

Added to misc-next, thanks.
