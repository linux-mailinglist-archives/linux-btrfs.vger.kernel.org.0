Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7833E730A0B
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 23:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbjFNV4r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jun 2023 17:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbjFNV4q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jun 2023 17:56:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8222683
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jun 2023 14:56:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D826A22282;
        Wed, 14 Jun 2023 21:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686779803;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CWLeMscmG7V1f0AFmxnFA4Yd86JkzOs9jsc5cD3piFY=;
        b=BvzExYr0BMIWKvSOCAGkgX8mSw1XdcZ0WIZie967CwIl8AnX6NvVKoB44Qm/1NEZZJZCgb
        ggdIsWIR68Q/2pNl9K1lRIP+XOfpOz1fXWR8ImSvy7OuRK4m6hfBgtkGKDEmexXleLAe8R
        Zy63QRHLIdTzfGGlynzarQaCAXiUSFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686779803;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CWLeMscmG7V1f0AFmxnFA4Yd86JkzOs9jsc5cD3piFY=;
        b=Q2AvOk7EyDruQe9kKAymhhO0HxWjeAAeXNp6lHpFBauKv3K9L5pgLfHqPt8Qbp2lQr44MI
        QlwVFsFG/dXf9QAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C14CF1391E;
        Wed, 14 Jun 2023 21:56:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bX1OLps3imSDOwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 14 Jun 2023 21:56:43 +0000
Date:   Wed, 14 Jun 2023 23:50:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: do not BUG_ON after failure to migrate space
 during truncation
Message-ID: <20230614215023.GQ13486@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ef45ecc23ffac44258794dfebaedd30e2db27a45.1686672418.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef45ecc23ffac44258794dfebaedd30e2db27a45.1686672418.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 13, 2023 at 05:07:54PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During truncation we reserve 2 metadata units when starting a transaction
> (reserved space goes to fs_info->trans_block_rsv) and then attempt to
> migrate 1 unit (min_size bytes) from fs_info->trans_block_rsv into the
> local block reserve. If we ever fail we trigger a BUG_ON(), which should
> never happen, because we reserved 2 units. However if we happen to fail
> for some reason, we don't need to be so dire and hit a BUG_ON(), we can
> just error out the truncation and, since this is highly unexpected,
> surround the error check with WARN_ON(), to get an informative stack
> trace and tag the branh as 'unlikely'. Also make the 'min_size' variable
> const, since it's not supposed to ever change and any accidental change
> could possibly make the space migration not so unlikely to fail.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
