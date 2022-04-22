Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD6850C15E
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Apr 2022 00:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiDVWBn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Apr 2022 18:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiDVWBm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Apr 2022 18:01:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44E21DA401
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Apr 2022 13:44:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 17A5321600;
        Fri, 22 Apr 2022 20:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650659810;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hyy4/nEF7XOt5cDK+W5I6PX2Ok6Jp5p4YRj+6Hq4upk=;
        b=osBoKcahDcZneim1Y0HPOYoLMwf6GI/1s65KDdiHeCCaUANPzhNCK5s9/gb9Xzj5PGncAp
        9jYz8K7h8Y020MuXtLP5oHMkXkHbAZBMkToaUq8VFHpSf979v+YXuETn47Rai5PfOLCasG
        URrClBXBT913fhZyTBi99WdBWvwksaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650659810;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hyy4/nEF7XOt5cDK+W5I6PX2Ok6Jp5p4YRj+6Hq4upk=;
        b=uLMe9ykyjxu9IV2AwpzWYVbq11xDQRKhf7p+/FFxk3YNgHVaTxlUv33wDL71GdUvLe433P
        gFxwFGqLMTUbC0Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA70D131BD;
        Fri, 22 Apr 2022 20:36:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5PM7OOERY2IDAgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 22 Apr 2022 20:36:49 +0000
Date:   Fri, 22 Apr 2022 22:32:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Gabriel Niebler <gniebler@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH v2] btrfs: Turn fs_info member buffer_radix into XArray
Message-ID: <20220422203244.GK18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Gabriel Niebler <gniebler@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20220421154538.413-1-gniebler@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220421154538.413-1-gniebler@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 21, 2022 at 05:45:38PM +0200, Gabriel Niebler wrote:
> … named 'extent_buffers'. Also adjust all usages of this object to use the
> XArray API, which greatly simplifies the code as it takes care of locking
> and is generally easier to use and understand, providing notionally
> simpler array semantics.
> 
> Also perform some light refactoring.
> 
> Signed-off-by: Gabriel Niebler <gniebler@suse.com>

I've added the patch to for-next, seems that it survived one night test
round, so it seems to be fine. I'll move it to misc-next next week,
Nikolay was interested in reviewing the xarray patches.
