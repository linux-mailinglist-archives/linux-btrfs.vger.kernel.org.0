Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78346589DA6
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 16:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239432AbiHDOjU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Aug 2022 10:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239686AbiHDOjR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Aug 2022 10:39:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B389E33E27
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Aug 2022 07:39:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6685A5BD62;
        Thu,  4 Aug 2022 14:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659623954;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nGiCi6Hdxd7b4DZ7ipuy9E46wQ2qGsYK5taqLWrd42w=;
        b=YDu97LaewFwusBsRqb7Im1aRzZU4jraRPcfDGnCKOqis3aQxzLXme5dcMXD2S2jzS/gWRn
        A/KBJR77r87b/zUZ4LA9rtUml/iNu6zMJ5ipi6BertrC1JGFaT9ZfD6FHVhU0gvEe2qkt1
        kyeQzEcNCgaCKvqQbvSViH/prLFV+jA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659623954;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nGiCi6Hdxd7b4DZ7ipuy9E46wQ2qGsYK5taqLWrd42w=;
        b=E0/9AkwSH4Y/uYmY9uuYIVq06LSeCafdkDnqY3D5bVEdgXJfIcQgSG7YMOIZdWhLeITZox
        QRUc+OIZ90iALACw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B67A13A94;
        Thu,  4 Aug 2022 14:39:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pq9qERLa62L0egAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 04 Aug 2022 14:39:14 +0000
Date:   Thu, 4 Aug 2022 16:34:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: use sysfs_streq for string matching
Message-ID: <20220804143411.GQ13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220802134628.3464-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802134628.3464-1-dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 02, 2022 at 03:46:28PM +0200, David Sterba wrote:
> We have own string matching helper that duplicates what sysfs_streq
> does, with a slight difference that it skips initial whitespace. So far
> this is used for the drive allocation policy. The initial whitespace
> of written sysfs values should be rather discouraged and we should use a
> standard helper.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Added to misc-next.
