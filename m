Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10A8628AE1
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 21:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbiKNUzf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 15:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbiKNUze (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 15:55:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CD4BC99;
        Mon, 14 Nov 2022 12:55:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1FF7C202D4;
        Mon, 14 Nov 2022 20:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668459332;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ar7Rs3mu749aifR7unXFY0zzj5m0E6hzLhuJrw5TDzo=;
        b=ptpItOUTEWyg9J3CK+83l4zGo3iQpR+/VmY4ax4Hajn0nzWwKDW3JOXCFnfYO0e7fa3q42
        lJUjAJH3OrOtgu0I9N7zQuBBpju+mrV+XXOPvbQIbCwyuY+2joJdDikSNuCkLm7E94ZXov
        3Y3qvybuUTdO9erXrMYewBO1eHa9dmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668459332;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ar7Rs3mu749aifR7unXFY0zzj5m0E6hzLhuJrw5TDzo=;
        b=zAJ0y9uFTKMO2P6RfUVjHQtF5vmn9qGSAF6RXWzozOgQxIilsBZwhrw9MvFDOrUXjzIDhH
        1Ek7AGfa8MB2zIDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E659313A92;
        Mon, 14 Nov 2022 20:55:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id idVIN0OrcmPSPgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 14 Nov 2022 20:55:31 +0000
Date:   Mon, 14 Nov 2022 21:55:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Li zeming <zeming@nfschina.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: volumes: Increase bioc pointer check
Message-ID: <20221114205506.GC5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221026013611.2900-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026013611.2900-1-zeming@nfschina.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 26, 2022 at 09:36:11AM +0800, Li zeming wrote:
> The __GFP_NOFAIL flag will cause memory to be allocated an infinite
> number of times until the allocation is successful, but it is best to
> use it only for very necessary code, and try not to use it.
> 
> The alloc_btrfs_io_context function looks a little closer to normal
> (excuse my analysis), but I think we can remove __GFP_NOFAIL from it and
> add a bioc pointer allocation check that returns NULL if the allocation
> fails.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>

I've reworded the subject and changelog and patch is now in misc-next,
thanks.
