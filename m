Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43BB674306
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 20:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjASTmG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 14:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjASTmC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 14:42:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1622C9373F
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 11:42:00 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B80ED5D232;
        Thu, 19 Jan 2023 19:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674157318;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oIh1zmCdVFs0DEtRrIYUjJKZkkDfsBKk1Vqdt+ENKCM=;
        b=r9m7ZfQePX9Lb/BPiDpVnHMWL0ZL5nZ7DVIccCDofoB30qusouJmFOpzuNJWd/KZC8R6BY
        t4+njEW847aEr1DCX4CgdAlR2RcoaoJsBUkWyRMySUsGRKZeLvKas616Q32U5IGie4XAP7
        t5KWMCGS/mGxcPBe+SnauudiSCdWT/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674157318;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oIh1zmCdVFs0DEtRrIYUjJKZkkDfsBKk1Vqdt+ENKCM=;
        b=ioiGZlK5kjtKzNg2WRrz2AVCdDfvDqyFKz1PxaYi1F6x96tpx1s/UFyiiqf1QHTq1yK2Fl
        5iEGUrX9fJ8IrGAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 942BB134F5;
        Thu, 19 Jan 2023 19:41:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8z+fIgadyWPBRQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 19 Jan 2023 19:41:58 +0000
Date:   Thu, 19 Jan 2023 20:36:19 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: some speedup with fiemap when leaves are
 shared
Message-ID: <20230119193619.GL11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1673954069.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673954069.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 17, 2023 at 11:21:37AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Add a couple assertions for the fiemap code that checks if extents are
> shared and speedup the extent sharedness check when we already know the
> current leaf is shared. More details on the changelogs.
> 
> Filipe Manana (2):
>   btrfs: assert commit root semaphore is held when accessing backref cache
>   btrfs: skip backref walking during fiemap if we know the leaf is shared

Added to misc-next, thanks.
