Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72EC6535F2
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Dec 2022 19:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiLUSNx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Dec 2022 13:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLUSNv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Dec 2022 13:13:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68A3C47
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Dec 2022 10:13:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3018C20CDF;
        Wed, 21 Dec 2022 18:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671646429;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jVJbeKpx2ya735/me8IQlbuQzInRCEWzBjBUUd/qWYI=;
        b=j7v+FeK8rmlPQpWVZOMBtiyiwlPaFUfLddTWCFPdN+588nyTGANLGRl72pqB0zcHkw8bIt
        pUxJpBJG9IRiibzQxrjkGBaoTphBVjZl94r9mjfTMTtg18tA2jI2smLw4dUD6bbB69UQ8C
        hWPXOa5WvD77Fkw6HRovi8uMwWgNbO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671646429;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jVJbeKpx2ya735/me8IQlbuQzInRCEWzBjBUUd/qWYI=;
        b=zJRZ1bAzwSIRKWNWqAqyzPWVP2RsdPVUMeAV4fZfPi+py72q4kCFcO/xZOXh46vJvQYxQK
        WEQPVxb7voD/vpDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 03C5113913;
        Wed, 21 Dec 2022 18:13:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Whi6OtxMo2O5dwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 21 Dec 2022 18:13:48 +0000
Date:   Wed, 21 Dec 2022 19:08:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 6/8] btrfs: extract out zone cache usage into it's own
 helper
Message-ID: <20221221180825.GA2415@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1671221596.git.josef@toxicpanda.com>
 <af6c527cbd8bdc782e50bd33996ee83acc3a16fb.1671221596.git.josef@toxicpanda.com>
 <20221219070514.tgfqoiethziuwfdq@naota-xeon>
 <20221220192456.GR10499@twin.jikos.cz>
 <20221221164744.tzgzjviq6ykrwjyh@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221164744.tzgzjviq6ykrwjyh@naota-xeon>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 21, 2022 at 04:47:45PM +0000, Naohiro Aota wrote:
> Sure, how about this then?

That looks good, added to misc-next, thanks.
