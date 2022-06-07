Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2362D5403AD
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 18:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbiFGQ0w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 12:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiFGQ0v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 12:26:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4765E17B
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 09:26:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 81C261F9A8;
        Tue,  7 Jun 2022 16:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654619208;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zlVUn9puPu1Ke+QkZexswB9awqV+8/OR1VDt0VYdgvg=;
        b=WRtdObBlAksSvq3IbP1Cs03ncbqgnnGspc/U4Ymc9X1FJo2f5h93XxhCQJKOH1nz6WL25y
        RyN2nlMzuDhLncirSptW4t0ioIvnpPxzXCWkJ5f8qDzgBH0V49lgktiTc6QxEpsSEKj09t
        taMBnet+fJobWrlbJCD61C9W3ZCB4jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654619208;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zlVUn9puPu1Ke+QkZexswB9awqV+8/OR1VDt0VYdgvg=;
        b=QadqRzEJNFkQc4Z7OW5O9oEvTphk1/Itok5/86xIqh4zaNlUfYb0Y/CBaN9oQo1reaJKKQ
        yXEDa+AVpBmj2LAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65DF413638;
        Tue,  7 Jun 2022 16:26:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id InfcF0h8n2JieQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 07 Jun 2022 16:26:48 +0000
Date:   Tue, 7 Jun 2022 18:22:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] btrfs: zoned: fix critical section of relocation
 inode writeback
Message-ID: <20220607162219.GO20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1654585425.git.naohiro.aota@wdc.com>
 <668df7d610ddae48ffd260ae08f433cc3b3d7ecd.1654585425.git.naohiro.aota@wdc.com>
 <20220607085237.kykjgin3jmlofhlo@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607085237.kykjgin3jmlofhlo@naota-xeon>
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

On Tue, Jun 07, 2022 at 08:52:37AM +0000, Naohiro Aota wrote:
> Sorry. I forgot to rebase the series, and this patch looks conflict with
> the commit "btrfs: merge end_write_bio and flush_write_bio." We need to
> place btrfs_zoned_data_reloc_unlock() after submit_write_bio().

No problem, the cleanup patches tend to collide with fixes, also I'm
going to send the zoned fixes during some rc, so the original version
will be applied and the cleanup updated eventually.
