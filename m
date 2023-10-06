Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA227BBA6D
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Oct 2023 16:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjJFOhu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 10:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjJFOhu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 10:37:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8290CC6
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Oct 2023 07:37:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 37E641F895;
        Fri,  6 Oct 2023 14:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696603067;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4CSwBNjpZ1vI8Xh0FhR7bnxGu2zUWnObkohOoD/ZX/w=;
        b=eZs2d6CNx2vwI1kkh/P1ZqMp+j5feS7+RYVLQ+Ia9v0E5/lMYPZK16Dm8Vw3HxCybSZ8ov
        lpeK3s6LUrl3NEHUXMnq1QV3DGVpl0wsq3+YU+u5uhxNFiCy54z5fKchcJpkQ+WSQqoBqw
        5lXkNVhCF88cyLDwFldRAZejlWyyVXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696603067;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4CSwBNjpZ1vI8Xh0FhR7bnxGu2zUWnObkohOoD/ZX/w=;
        b=32KIiVe3STmrhqc495qbRjr200gKxCdgKm9DS6ga5pYCj/b+IBCFXneav2EVpG+Y+H7lQB
        EAXi4YDxfSanKqAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2005913586;
        Fri,  6 Oct 2023 14:37:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7oj6BrsbIGU/YwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 06 Oct 2023 14:37:47 +0000
Date:   Fri, 6 Oct 2023 16:31:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove pointless empty log context list check
 when syncing log
Message-ID: <20231006143103.GE28758@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f238738e93b197f7125509e5727a8ae93abbac54.1696504114.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f238738e93b197f7125509e5727a8ae93abbac54.1696504114.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 05, 2023 at 12:11:09PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When syncing the log, if we get an error when updating the log root, we
> check first tif he log root tree context is in a log context list, and if
> so it deletes from the log root tree context from the list. This check
> however is pointless because at this moment the context is always in a
> list, he have just added it to a context list. The check became pointless
> after commit a93e01682e28 ("btrfs: remove no longer needed use of
> log_writers for the log root tree"). So remove this now pointless empty
> list check.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
