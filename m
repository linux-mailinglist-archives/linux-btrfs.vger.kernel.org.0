Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3906077658C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 18:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjHIQuc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 12:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjHIQuA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 12:50:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C1526B7
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 09:49:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 264C721880;
        Wed,  9 Aug 2023 16:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691599784;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yn1Z3dF+VWVJoRAL/6xWIUpbk6CUim+5M30uFCXuFHU=;
        b=JK1zKzJcuHQnXlNw/pOuhF3+8628m1sHWNqIKvetGK3qorxTmXIhwwGTe5bswSylGOWp6/
        Ajav2eC7F45ZrwXRShqS+CHQNTc35PGjHLWkj9UyLaewsFUKv/iaO7JqH8PpoaG+DjJIbP
        zDnF2yoVqNUkN9zX1sVjLpnPwMMXBSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691599784;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yn1Z3dF+VWVJoRAL/6xWIUpbk6CUim+5M30uFCXuFHU=;
        b=MzBKsL3FQA6+oKcnjIdMD3LZH6oDgtJS75sRFGCJz2N3SXGuHJXWnBdVxeFDrDn9X4g6ID
        PpzW1DE4W5TrgLCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 080D2133B5;
        Wed,  9 Aug 2023 16:49:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zLQxAKjD02TqbQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 09 Aug 2023 16:49:44 +0000
Date:   Wed, 9 Aug 2023 18:49:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, hch@infradead.org,
        josef@toxicpanda.com, dsterba@suse.cz
Subject: Re: [PATCH v3 08/10] btrfs: zoned: no longer count fresh BG region
 as zone unusable
Message-ID: <ZNPDppIyQX14YHDU@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, hch@infradead.org,
        josef@toxicpanda.com
References: <cover.1691424260.git.naohiro.aota@wdc.com>
 <ca8d3f4a50133240b380bc58a205dfe24dcff06a.1691424260.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca8d3f4a50133240b380bc58a205dfe24dcff06a.1691424260.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 08, 2023 at 01:12:38AM +0900, Naohiro Aota wrote:
> Now that we switched to write time activation, we no longer need to (and
> must not) count the fresh region as zone unusable. This commit is similar
> to revert commit fc22cf8eba79 ("btrfs: zoned: count fresh BG region as zone
> unusable").

The commit id should be fa2068d7e922b434eba guessing by the subject, I
don't have fc22cf8eba79.
