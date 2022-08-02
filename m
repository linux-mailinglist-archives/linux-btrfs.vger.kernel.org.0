Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943EB5880F3
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 19:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbiHBRXM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 13:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbiHBRXJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 13:23:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CCB48E95
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 10:23:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 81DD037D57;
        Tue,  2 Aug 2022 17:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659460966;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uDbWbSJLx1as6EoIlqbQM60QbENiBwuDq1auG3Ro0xI=;
        b=uQQSVHHId3eUaL9SlAVNMR+hYtR/bP8h4hkn8kheR6ZSkZpJDU/kRriCovA53eYml3ya1j
        p/2+G/J0XSTjrUrEk/7+B8bg4pSAhSmZ2d7YiydAAJetwFXvc5w+do+5/+mOMXcM+mYSG/
        Tgbcus3hYYxZeVAwO+t/3q3E+7hYBkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659460966;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uDbWbSJLx1as6EoIlqbQM60QbENiBwuDq1auG3Ro0xI=;
        b=V+bIPHf8c2LSnbMH3JGUHK4TLU1O2dGzwsRy+OiSSmIR1nQN/P+0S09xzMzHtzEYdJs0Vk
        GPG4U8KhoFSwC/Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60FB013A8E;
        Tue,  2 Aug 2022 17:22:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mRmSFmZd6WLRPQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 Aug 2022 17:22:46 +0000
Date:   Tue, 2 Aug 2022 19:17:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix infinite loop with dio faulting
Message-ID: <20220802171744.GU13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <27a36e2b4cf30de8f7a04e718ba47bb9e98ddb85.1658419807.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27a36e2b4cf30de8f7a04e718ba47bb9e98ddb85.1658419807.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 21, 2022 at 12:10:14PM -0400, Josef Bacik wrote:
> Filipe removed the check for the case where we are constantly trying to
> fault in the buffer from user space for DIO reads.  He left it for
> writes, but for reads you can end up in this infinite loop trying to
> fault in a page that won't fault in.  This is the patch I applied ontop
> of his patch, without this I was able to get generic/475 to get stuck
> infinite looping.
> 
> This patch is currently staged so we can probably just fold this into
> his actual patch.

Folded to the patch, thanks.
