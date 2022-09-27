Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E924E5EC23F
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Sep 2022 14:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiI0MQx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Sep 2022 08:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiI0MQp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Sep 2022 08:16:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CA8CDCC8
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Sep 2022 05:16:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AE0541FA91;
        Tue, 27 Sep 2022 12:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664281000;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yIalqP+MG1AtJirAcpeoU9uvPBdejGLM32wJEDM9bCI=;
        b=uA3/X/PgWEWsioS3fONZDiGyEPMYafkiRvWpSMrjtlzKLtC8Iq6FiS5wa0EJV8ds6NJ+I0
        Hhkc0dQslEcDBjkamxml3hsJ4vh9WiCV5TKbzOgbA2rSWgEZ72yNlZYN1g2nfJJs0PG7iM
        l1jFA/+aCdV7k06EgsDmbQdE+79s5ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664281000;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yIalqP+MG1AtJirAcpeoU9uvPBdejGLM32wJEDM9bCI=;
        b=sIUMYNzLY/SQK/lNwkfC+VRvIQPHMIdQam/pjvkqnU/sqT1YMkJ+EXuwoJ1Xv4vTkwqBD5
        13I65GrCZGnlYJBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A947139B3;
        Tue, 27 Sep 2022 12:16:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KecBHajpMmP/AgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 27 Sep 2022 12:16:40 +0000
Date:   Tue, 27 Sep 2022 14:11:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Stefan Roesch <shr@fb.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org, axboe@kernel.dk,
        josef@toxicpanda.com, dan.carpenter@oracle.com, dsterba@suse.cz,
        fdmanana@kernel.org
Subject: Re: [PATCH v1] btrfs: fix for refcount leak in btrfs_do_write_iter()
Message-ID: <20220927121105.GB13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20220926163150.1535808-1-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926163150.1535808-1-shr@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 26, 2022 at 09:31:50AM -0700, Stefan Roesch wrote:
> The patch "btrfs: enable nowait async buffered writes" introduced a
> potential leak in btrfs_do_write_iter() that the count for sync_writers
> is increased, but not decreased.
> 
> This commit addresses this problem.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Stefan Roesch <shr@fb.com>

Folded to the patch, thanks.
