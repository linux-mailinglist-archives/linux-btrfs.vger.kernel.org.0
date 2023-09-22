Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E7D7AB573
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 18:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjIVQDw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 12:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjIVQDv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 12:03:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE9899;
        Fri, 22 Sep 2023 09:03:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B86C51FF37;
        Fri, 22 Sep 2023 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695398623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X8RxdkJ1f3GC/Mfkg3bDudPHmZhEkyhgPou98/1cj/o=;
        b=Nw8oKo1HOCZ1DVTjiywH5buZb7YdcuNalJR8G7B3wCt+SpIwPxW7SpoF8gpo8OlAfABMwF
        7zYoHYp3wwqRbuS+NGi/jNU5yZKqoyv3OevdowN/lPR2Dh8sc9wJSgJkARJX2wRvn1z0Na
        pPVNUZ4EXtGKWgbofht2qHcvdhtJMUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695398623;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X8RxdkJ1f3GC/Mfkg3bDudPHmZhEkyhgPou98/1cj/o=;
        b=Xk3JlDW1a0x+FVT9R6/i0Xqnhve+lNTyGWNCKcDQKonBg8ztFjlUfQHR1wA1/O9BznQTaL
        B717xvJQQZ+iejAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C33713478;
        Fri, 22 Sep 2023 16:03:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id REb6G9+6DWX/LQAAMHmgww
        (envelope-from <ddiss@suse.de>); Fri, 22 Sep 2023 16:03:43 +0000
Date:   Fri, 22 Sep 2023 18:03:42 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/287: filter snapshot IDs to avoid failures when
 using some features
Message-ID: <20230922180342.25270acd@echidna.fritz.box>
In-Reply-To: <99982dd613b5bb2d693b0491af873e1e7291dd4b.1695383059.git.fdmanana@suse.com>
References: <99982dd613b5bb2d693b0491af873e1e7291dd4b.1695383059.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Reviewed-by: David Disseldorp <ddiss@suse.de>
