Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E616F4BF0
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 23:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjEBVQU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 17:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjEBVQR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 17:16:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150D210E3
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 14:16:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C1A241F88B;
        Tue,  2 May 2023 21:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683062174;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DIb6Sip+O9s6fgZyHZNG3WMTU6vUpzlo6RClvqC26Tg=;
        b=mgO+wBQu9rRFAslVyefKycIeLhdvApWPXalgpLji7B7f3yPcplbs4L1Qlb0t29NDjWnFSG
        msvrcWfRmJjytqYdNbjvY6UxdeJJ6mawQ3KSTpBnvL9LF5GrFpy86EPCJUtDrH79WmZI3a
        KClxn5ys6COjyDbiM+e2OmaVP+4aj+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683062174;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DIb6Sip+O9s6fgZyHZNG3WMTU6vUpzlo6RClvqC26Tg=;
        b=y3lgTR4zEefj1r92PUs7VrFjC7ZGggDt4aP8N+fRdx/iyUybvrDfnevLqys/2c4wcmiqy/
        qu+p3fnj4xwZQVCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9945F139C3;
        Tue,  2 May 2023 21:16:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eriHJJ59UWRzRQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 May 2023 21:16:14 +0000
Date:   Tue, 2 May 2023 23:10:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/8] btrfs-progs: sync uapi/btrfs.h into btrfs-progs
Message-ID: <20230502211019.GQ8111@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1681938911.git.josef@toxicpanda.com>
 <93f8af4b6a6164504f0aeb1221d57c59673f6df5.1681938911.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93f8af4b6a6164504f0aeb1221d57c59673f6df5.1681938911.git.josef@toxicpanda.com>
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

On Wed, Apr 19, 2023 at 05:17:12PM -0400, Josef Bacik wrote:
> We want to keep this file locally as we want to be uptodate with
> upstream, so we can build btrfs-progs regardless of which kernel is
> currently installed.  Sync this with the upstream version and put it in
> kernel-shared/uapi to maintain some semblance of where this file comes
> from.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  include/ioctl.h => kernel-shared/uapi/btrfs.h | 566 ++++++++++--------

When files are moved it's good to do a

$ git grep ioctl.h
Makefile:ioctl-test.o: tests/ioctl-test.c include/ioctl.h include/kerncompat.h kernel-shared/ctree.h
Makefile:ioctl-test-32.o: tests/ioctl-test.c include/ioctl.h include/kerncompat.h kernel-shared/ctree.h
Makefile:ioctl-test-64.o: tests/ioctl-test.c include/ioctl.h include/kerncompat.h kernel-shared/ctree.h

to see if there's something using it which is not built by default. In
this case library-test, the ioctl test, so path updated in Makefile.
