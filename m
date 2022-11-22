Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE494634098
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Nov 2022 16:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbiKVPwz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Nov 2022 10:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbiKVPws (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Nov 2022 10:52:48 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0DCB854;
        Tue, 22 Nov 2022 07:52:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DDE9A1F86C;
        Tue, 22 Nov 2022 15:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669132365;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jOw4W8GJQAfba4Gl75PFIqR6yUcnSiTb0cnPPH4IqEo=;
        b=dU6rCfz81V/ZTtLlq5TSfNE338urj5f3ezv3pCwa8+XeTmdhNqxGENAIa8AyIJg0uQ50uN
        298y/GacpMOMq7xA2dnMUkMjMN2Kf/nFUrFIZ4thruPBOY3SJXkDamrjlrpj7W8+RRM+U6
        8PQX1F053DZt0cBhBjOTcv3/9YWq4IE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669132365;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jOw4W8GJQAfba4Gl75PFIqR6yUcnSiTb0cnPPH4IqEo=;
        b=wF4zwCaimH24n1jK1HXf3wizXD/+XsO6yC/79qPPgeT4blMTuPHkGnY8xaSO8f2Q0frlCX
        1ItuFn+DEnlf59BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1B6013B01;
        Tue, 22 Nov 2022 15:52:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V85YKk3wfGMSJQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 22 Nov 2022 15:52:45 +0000
Date:   Tue, 22 Nov 2022 16:52:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH v3] btrfs: Replace strncpy() with strscpy()
Message-ID: <20221122155215.GG5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221121185427.GB5824@twin.jikos.cz>
 <20221122145108.3710710-1-artem.chernyshev@red-soft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122145108.3710710-1-artem.chernyshev@red-soft.ru>
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

On Tue, Nov 22, 2022 at 05:51:08PM +0300, Artem Chernyshev wrote:
> Using strncpy() on NUL-terminated strings are deprecated.
> To avoid possible forming of non-terminated string
> strscpy() could be used.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 475f63874d73 ("btrfs: new ioctls for scrub")
> Fixes: 606686eeac45 ("Btrfs: use rcu to protect device->name")
> Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>

Added to misc-next with minor adjustments, thanks.
