Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDE65123BB
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 22:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbiD0URm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 16:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236643AbiD0URf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 16:17:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F106A8A7E4
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 13:11:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A0B611F37F;
        Wed, 27 Apr 2022 20:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651090304;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x5OzTWgCJjq9vK8aFdVPTBJoUTgfnys401nt+jw1ZyA=;
        b=dMcu1MrFdaiUpxVDXNClc4Bym71ppwsKHSq5a5kwm2GkpAn1uh/HEFhd4BhVxbm01LHyyt
        bi/OGnTwseSwn9sTL7Ea35MVs5oYiU+OwLeX5uwDrSNiRLkIqmBDsJt2qFuSSa3PMFMXqR
        TkgPF+SzOHvMRMvO+/XR4s1fw0iXcNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651090304;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x5OzTWgCJjq9vK8aFdVPTBJoUTgfnys401nt+jw1ZyA=;
        b=zJBsooG62UFj0h6XYc8e0vKUnBpDfnrY+Lq4ZsPcRbFNiqQH7618S8veLcGSgfKl+9VXTy
        vcHjdg3xECRGLoBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 817971323E;
        Wed, 27 Apr 2022 20:11:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nNWuHoCjaWKXfgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 27 Apr 2022 20:11:44 +0000
Date:   Wed, 27 Apr 2022 22:07:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Gabriel Niebler <gniebler@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH] btrfs: Turn fs_roots_radix in btrfs_fs_info into an
 XArray
Message-ID: <20220427200736.GA18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Gabriel Niebler <gniebler@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20220426214525.14192-1-gniebler@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220426214525.14192-1-gniebler@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 26, 2022 at 11:45:25PM +0200, Gabriel Niebler wrote:
> … rename it to simply fs_roots and adjust all usages of this object to use
> the XArray API, because it is notionally easier to use and unserstand, as
> it provides array semantics, and also takes care of locking for us,
> further simplifying the code.
> 
> Also do some refactoring, esp. where the API change requires largely
> rewriting some functions, anyway.
> 
> Signed-off-by: Gabriel Niebler <gniebler@suse.com>

I've lightly reviewed the patch so I can put add it for testing though
I'll keep the review open for Nikolay.

Otherwise, this is the last conversion of radix_tree_root, thanks.
There's no use of the radix_tree_* API anymore.
