Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0240564BC39
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 19:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbiLMSmN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 13:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbiLMSmA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 13:42:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77111097;
        Tue, 13 Dec 2022 10:41:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CF4BB1FDB4;
        Tue, 13 Dec 2022 18:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670956917;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+W2cKxBOJdZjf/2uoiAlpf5BlMTh6jYNUgsdvKaLvJw=;
        b=Px225xbk76wtn5wa1gA/2JRZ5gLecTajTPZ+KKa/1z4DJ/n3SDbL/hgOoJ4/XfVhcnCzuQ
        hnPw/Kcubh7vf+2oCRsPVjCpL/X6EYu1+Iegljab+VJCk9Fq1pJ4T5cEA0B2jIg+Xgh4IX
        L3bJFA0gPegM0h37iN2E1dWfVns4nTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670956917;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+W2cKxBOJdZjf/2uoiAlpf5BlMTh6jYNUgsdvKaLvJw=;
        b=JbLuqmK96nZI8Z86QUdWjAy0E4NT3nqmiYQS0ua2t1hTIlZdax8RHg7cbJ6SJPL1OlK45G
        tHSW3iRqrGQHbKBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95328138F9;
        Tue, 13 Dec 2022 18:41:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xIIII3XHmGMCegAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 13 Dec 2022 18:41:57 +0000
Date:   Tue, 13 Dec 2022 19:41:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix an error handling path in btrfs_rename()
Message-ID: <20221213184115.GE5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <943f0f360f221da954f5dd7f16e366d0e294ae72.1670876024.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <943f0f360f221da954f5dd7f16e366d0e294ae72.1670876024.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 12, 2022 at 09:14:17PM +0100, Christophe JAILLET wrote:
> If new_whiteout_inode() fails, some resources need to be freed.
> Add the missing goto to the error handling path.
> 
> Fixes: ab3c5c18e8fa ("btrfs: setup qstr from dentrys using fscrypt helper")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Added to misc-next, thanks.
