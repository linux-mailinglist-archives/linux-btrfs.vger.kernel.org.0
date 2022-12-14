Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7796964CF33
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Dec 2022 19:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiLNSME (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Dec 2022 13:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238587AbiLNSLu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Dec 2022 13:11:50 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5839644C
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Dec 2022 10:11:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6888820195;
        Wed, 14 Dec 2022 18:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671041507;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zUWI9IBUzBtbWogqB9l8NWbHZLVwAQEi6OX84YYl2wQ=;
        b=wigHAOb8cUY9u67mlEn3sCEtlvkcV0snT5E+FKUy78cxKhdP4Is50wQjyq9M6Lcn4klnyT
        zDrWLiXv0kRq/YZ61GCbr44gX1J5NdreZSrL3PGriy1pLe4Y8qU6uvOb57kPCKWkLOLDXW
        ANbXSSGoMbyi7/NOmiDkEOYstK/9z9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671041507;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zUWI9IBUzBtbWogqB9l8NWbHZLVwAQEi6OX84YYl2wQ=;
        b=MH66PnYzQDCyw8EbhsLE538D1LoQNxlUZNr2tjxk794EwnJh7rPQdrwfqAB1UcVoC3gT5C
        IN5RHj1ge4PrXmAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4201B138F6;
        Wed, 14 Dec 2022 18:11:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5gAqD+MRmmPJIQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 14 Dec 2022 18:11:47 +0000
Date:   Wed, 14 Dec 2022 19:11:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: remove level argument from btrfs_set_block_flags
Message-ID: <20221214181104.GG10499@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <720307086390595732e0265afc5ffb2da80f632f.1670272901.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <720307086390595732e0265afc5ffb2da80f632f.1670272901.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 05, 2022 at 03:41:47PM -0500, Josef Bacik wrote:
> We just pass in btrfs_header_level(eb) for the level, and we're passing
> in the eb already, so simply get the level from the eb inside of
> btrfs_set_block_flags.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
