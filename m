Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6B96F0E95
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Apr 2023 00:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344255AbjD0Wwk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 18:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjD0Wwj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 18:52:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAE0CA
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 15:52:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 98DDA21B0F;
        Thu, 27 Apr 2023 22:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682635957;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pDjV2Cy0iQhWzZZmaCpa130A979z2sfJGaFbXVa/43g=;
        b=RzubU0B8nHMW29jrRfgzugMkdTDiDEfVZtkP5+fz1swdlP5xFBO3uRLaauoAKctTlE3UaE
        geCl0Z6UehOeYPj0BBDSc1yCBzJYiz+tX+02vZbf/MwND9LSEQf8lXWimE9VHDpT1tSsDM
        uFTpeuw98/PhCG0pR6Y4DxC58G/sn/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682635957;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pDjV2Cy0iQhWzZZmaCpa130A979z2sfJGaFbXVa/43g=;
        b=EZlsv17Ch65nrPZuJdY/aj2Rjb75Yxe0RDpLapCOUwbC50QJovXInrqejquDPrFHN79CVr
        P9NczzDuxOERdjBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 81D38138F9;
        Thu, 27 Apr 2023 22:52:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f9c5HrX8SmT+fwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 27 Apr 2023 22:52:37 +0000
Date:   Fri, 28 Apr 2023 00:52:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: fix extent state leaks after device replace
Message-ID: <20230427225223.GG19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1682528751.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1682528751.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 26, 2023 at 06:12:59PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This fixes a recent regression (on its way to Linus' tree) that results in
> leaking extent state records in the allocation io tree of a device used as
> a source device for a device replace. Also unexport btrfs_free_device().
> 
> Filipe Manana (2):
>   btrfs: fix leak of source device allocation state after device replace
>   btrfs: make btrfs_free_device() static

Added to misc-next, thanks.
