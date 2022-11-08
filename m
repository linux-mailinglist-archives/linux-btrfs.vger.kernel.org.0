Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5325562186F
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Nov 2022 16:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbiKHPhE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Nov 2022 10:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiKHPg6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Nov 2022 10:36:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845CD57B6C
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Nov 2022 07:36:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2EE791F461;
        Tue,  8 Nov 2022 15:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667921816;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XUHcevO3/HXO5j0h88xzr9fOFd3uh2lyc9KW2X3QSVw=;
        b=Zrw7L++msVrw9hr0m2E+jXHda0omT6EVBeTw25TsImp7mMC8HmK+7t3OqC0f6wuV2sXBYv
        YvYG5DVeudXSu9XOd4CvoRuoTG0fjr+pAyJYjHr7+FPl9tel2i9vuOwR9Ck6IMUQcqtESQ
        NlL3KOkSkRf5O+RBzPtFcpmNYYGhJqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667921816;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XUHcevO3/HXO5j0h88xzr9fOFd3uh2lyc9KW2X3QSVw=;
        b=ZfVJAZ4szoDY4A+kJOYr9fJ9axIGk/Ypk6Rb3gbn98BCkvgiI5xBh0A6V4V/6iHxNAl5lA
        4REQRBBKWJ7sUODw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14387139F1;
        Tue,  8 Nov 2022 15:36:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gN37A5h3amPEXAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 08 Nov 2022 15:36:56 +0000
Date:   Tue, 8 Nov 2022 16:36:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: move device->name rcu alloc and assign to
 btrfs_alloc_device()
Message-ID: <20221108153633.GB5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <558d3ae7ad53788c05810ae452cece7036316fb2.1667831845.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <558d3ae7ad53788c05810ae452cece7036316fb2.1667831845.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 07, 2022 at 11:07:17PM +0800, Anand Jain wrote:
> There is a repeating code section in the parent function after calling
> btrfs_alloc_device(), as below.
> 
>               name = rcu_string_strdup(path, GFP_...);
>                if (!name) {
>                        btrfs_free_device(device);
>                        return ERR_PTR(-ENOMEM);
>                }
>                rcu_assign_pointer(device->name, name);
> 
> Except in add_missing_dev() for obvious reasons.
> 
> This patch consolidates that repeating code into the btrfs_alloc_device()
> itself so that the parent function doesn't have to duplicate code.
> This consolidation also helps to review issues regarding rcu lock
> violation with device->name.
> 
> Parent function device_list_add() and add_missing_dev() uses GFP_NOFS for
> the alloc, whereas the rest of the parent function uses GFP_KERNEL, so
> bring the NOFS alloc context using memalloc_nofs_save() in the function
> device_list_add() and add_missing_dev() is already doing it.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to misc-next, thanks.
