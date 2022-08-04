Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E2A589DE3
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 16:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240029AbiHDOvc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Aug 2022 10:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbiHDOvb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Aug 2022 10:51:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542612613B
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Aug 2022 07:51:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 10C3C5BD8C;
        Thu,  4 Aug 2022 14:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659624689;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tn+p6myGYv9StOeHVBm6V5R8zB5lh7FBXZ35arKRxAA=;
        b=Hqg+6r1GYEABucWAWAKoV45mfZRj0ttQcz7mwXM2qr3SHwhbWPYY6MvsgopVSAcYKAvWKv
        0n4BJECQqC+BuR22OJ9qRykSCXoxYcPu/qA4+2/wSZDbaCUPy4JMnhmzxqfwUUt4+lUBaI
        dR7dglz/qSs32QQN3WbL2onTKB03KaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659624689;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tn+p6myGYv9StOeHVBm6V5R8zB5lh7FBXZ35arKRxAA=;
        b=fxAWN3qijf9tNCCYESdGIRs98HCsk3U9OyAoAqRpb5DFThxrSCyP88/gabsC9ai0cwt6li
        DQjZijCUj4LHQ8Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E47BA13A94;
        Thu,  4 Aug 2022 14:51:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PG/HNvDc62LlfwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 04 Aug 2022 14:51:28 +0000
Date:   Thu, 4 Aug 2022 16:46:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: check for overlapping extent items in tree checker
Message-ID: <20220804144626.GR13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <0a9f7ca2717c0378acf77d71a0d1b680d4d5d6b9.1659551313.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a9f7ca2717c0378acf77d71a0d1b680d4d5d6b9.1659551313.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 03, 2022 at 02:28:47PM -0400, Josef Bacik wrote:
> We're seeing a weird problem in production where we have overlapping
> extent items in the extent tree.  It's unclear where these are coming
> from, and in debugging we realized there's no check in the tree checker
> for this sort of problem.  Add a check to the tree-checker to make sure
> that the extents do not overlap each other.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
