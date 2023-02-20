Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AF869D455
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 20:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjBTTsp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 14:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjBTTso (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 14:48:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610E11C330
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 11:48:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1EA11209EE;
        Mon, 20 Feb 2023 19:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676922522;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MVKRdG9c7c04U1I2Qx9ulP9mXGg/EpqZgZr5+KGI3CQ=;
        b=GGTtqix7NDCZcCf0h2VW2Gq9JiM/nELPAsOELbpHDsGWR8Wb5XNr+hAnUG05cc1LehwOCo
        IgDfOzGfyYaP2b+o/tfcPf/wgXvEY/bODqcThpsSQP7a11bb38xoMFdxTn5XJvg1uG2QrS
        PIlDt6xFeZkfNSasLBxNJTni32R4HWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676922522;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MVKRdG9c7c04U1I2Qx9ulP9mXGg/EpqZgZr5+KGI3CQ=;
        b=sRhe5Qkpf+SFd5l1A0HkESr+UaJkAzVUr+zA1ii3J+z6SjtOkWoVQZVMHFx2OvNiTfeCkW
        2TYlEDwYVmj5e6Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02AC8134BA;
        Mon, 20 Feb 2023 19:48:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id af1oO5nO82P1TQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 20 Feb 2023 19:48:41 +0000
Date:   Mon, 20 Feb 2023 20:42:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 2/2] btrfs: fix size class loading logic
Message-ID: <20230220194246.GD10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1676494550.git.boris@bur.io>
 <19e54cb085684ba1825709ba0b4e3040950895e6.1676494550.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19e54cb085684ba1825709ba0b4e3040950895e6.1676494550.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 15, 2023 at 12:59:50PM -0800, Boris Burkov wrote:
> This is another incremental patch fixing bugs in:

We can do incremental changes only until a week before the merge window
opens, which is today. The patch applies cleanly so I can take it
separately, with some changelog editing. Please check if everything is
right once it appears in misc-next, thanks.
