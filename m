Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDF5632C65
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Nov 2022 19:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiKUSzB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Nov 2022 13:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiKUSzA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Nov 2022 13:55:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E5259852;
        Mon, 21 Nov 2022 10:54:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B4C371F8AC;
        Mon, 21 Nov 2022 18:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669056897;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4itxnHUeIo+zAzyPBIzPhTF80YfBWHURiYwFLUXm1CA=;
        b=mye5zEoQegcavSPNxsnfdcpGob1Q8iaqte8Ss6xRl5fJ5KB5PKoEU/HbPCs2ES36kVCsI5
        hIQZCSkkE9nCeZ7HghD6SeLAh1xryQerk1/63ZzhlbyWYCy/1WA+dinvhv0QIUQV3yHsay
        IINm0r1/2vxTHnXbhFRnWqYpqCo8lQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669056897;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4itxnHUeIo+zAzyPBIzPhTF80YfBWHURiYwFLUXm1CA=;
        b=BYuCHgkq0pwotw6uAl1nEjrmxw68QrphG24lbsff3E6/pn4OPWcrY6mRu6XoUed23Jha6h
        +PaQwgwLcA/aeWBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 570B31377F;
        Mon, 21 Nov 2022 18:54:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zxlIFIHJe2MqLQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 21 Nov 2022 18:54:57 +0000
Date:   Mon, 21 Nov 2022 19:54:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] btrfs: rcu_string: Replace strncpy() with strscpy()
Message-ID: <20221121185427.GB5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221119081329.2213244-1-artem.chernyshev@red-soft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119081329.2213244-1-artem.chernyshev@red-soft.ru>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 19, 2022 at 11:13:29AM +0300, Artem Chernyshev wrote:
> Using strncpy() on NUL-terminated strings are deprecated.
> To avoid possible forming of non-terminated string
> strscpy() could be used.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 606686eeac45 ("Btrfs: use rcu to protect device->name")
> Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>

Added to misc-next, thanks. There's one last strncpy in
btrfs_ioctl_dev_info if you also want to convert it. The rest is strcpy
from static strings.
