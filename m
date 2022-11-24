Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF929638063
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Nov 2022 22:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiKXVAQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Nov 2022 16:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKXVAP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Nov 2022 16:00:15 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656608CFE5
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Nov 2022 13:00:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9A0F621A9A;
        Thu, 24 Nov 2022 21:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669323610;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FQ/NG7OnZYe4shr2pn1kgvPFi+0JZjobbxWGe2LxKpo=;
        b=s4hX087zG0zPtkqUmkUuj4WSZBbNtKadTl9ycBaPhK8cR2Wd2jGJSbm1cfmdNRNB+KeHre
        LktzXJOgdi05CUhwKgz1VkRUc+YkhdDOwEJGw/bi5DlSx8oQ2k062XEncKPFw0KiknGqyZ
        v+gn09ALQR3kFJi3XidXjPr8Tyv74XY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669323610;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FQ/NG7OnZYe4shr2pn1kgvPFi+0JZjobbxWGe2LxKpo=;
        b=ZhAx5luzNJrLtVEHF41vN4VLlc/XYfqHFXiAKQO/9G96fk/7g1QZMdEPnc6JeTsP9WYyCg
        lZ1538p9LeGDBHCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B33913B4F;
        Thu, 24 Nov 2022 21:00:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SUFHHVrbf2MvAgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 24 Nov 2022 21:00:10 +0000
Date:   Thu, 24 Nov 2022 21:59:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 01/29] btrfs-progs: turn on more compiler warnings and
 use -Wall
Message-ID: <20221124205939.GO5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1669242804.git.josef@toxicpanda.com>
 <ce81309292ac0b5d445e4d7e2b269fc3d0e85d32.1669242804.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce81309292ac0b5d445e4d7e2b269fc3d0e85d32.1669242804.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 23, 2022 at 05:37:09PM -0500, Josef Bacik wrote:
> In converting some of our helpers to take new args I would miss some
> locations because we don't stop on any warning, and I would miss the
> warning in the scrollback.  Fix this by stopping compiling on any error
> and turn on the fancy compiler checks.

Werror depends on the compiler version and for example centos7 warns on
{ 0 } and this breaks the build. I think it could be more annoying than
helpful. You can always use EXTRA_CFLAGS=-Werror if you're concerned
about missing warnings but I'd rather not make it default. Perhaps it
could be default once all reference builds are warning free.
