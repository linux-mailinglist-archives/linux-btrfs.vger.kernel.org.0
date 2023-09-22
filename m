Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB07C7AB20C
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 14:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbjIVMVg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 08:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjIVMVf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 08:21:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AC192;
        Fri, 22 Sep 2023 05:21:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 259D621B15;
        Fri, 22 Sep 2023 12:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695385288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3LGMPBoIWAWB5ngDZRlQWYO+9y+tDw1exhS/hsC/g7o=;
        b=rT4PW29i1NWHGl7XAwre92Xz7U03WDGsQ5UhzwN+GClwwcnm7CQJ7B9uCPlVwlA4EcWlTE
        r2GGiOzTO/bC1aQ5DWLtAzh2zZgMgDQFq+BoCm3tkU6UOrZw2E/l+pPYGQIKVd9rBhnq2U
        p0ummrcHh5Gvlc4p6QhnDNBrYbsEx+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695385288;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3LGMPBoIWAWB5ngDZRlQWYO+9y+tDw1exhS/hsC/g7o=;
        b=82q1izXSigQ1juU5gRdgU9jCzGYwKG7gE/xdcTHSK6gxsk9lHtf6khfG18AFR+aY+Etb+R
        3SP5LsuYmCWD3+Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7F9013478;
        Fri, 22 Sep 2023 12:21:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bWU0N8eGDWWKOgAAMHmgww
        (envelope-from <ddiss@suse.de>); Fri, 22 Sep 2023 12:21:27 +0000
Date:   Fri, 22 Sep 2023 14:21:26 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] generic: test new directory entries are returned
 after rewinding directory
Message-ID: <20230922142126.6e8500cc@echidna.fritz.box>
In-Reply-To: <603deada0f5b9ddff2446dae87a96cb05d566c2c.1695309198.git.fdmanana@suse.com>
References: <1888d81c5fad8204dd4948d36291d24f00354b22.1694705838.git.fdmanana@suse.com>
        <603deada0f5b9ddff2446dae87a96cb05d566c2c.1695309198.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good.
Reviewed-by: David Disseldorp <ddiss@suse.de>

