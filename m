Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2033470FEFD
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 22:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjEXULM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 16:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjEXULK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 16:11:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4426A180
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 13:11:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CD5C921B9A;
        Wed, 24 May 2023 20:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684959067;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zc9cZsQeIzv0pmlFugjKyzy27mTqHBKlqPgQoC/PvwI=;
        b=J8riZasPX4mYS9IkepZt8yLkZObW9hlFMYWDLUR/xAWYKbAhlOTk55NCMyqIan5d1mfAbK
        S7zXPyAyNRKKdGrO5EVjuCT6HjUMQ42+BVL4GxpVZXGUPoHimsNea5p0NCODPjKEhJvFqT
        FUaUiT3PBW4L0iT1MS84Io3ryR/k+74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684959067;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zc9cZsQeIzv0pmlFugjKyzy27mTqHBKlqPgQoC/PvwI=;
        b=I47xA1dEPrRnBKXLpbJPloQzLHKTmAaIOOc5iUqueQtZP/G+0872gxxkOpZ7p9YzI6t21X
        4SPfZvYs8lDSa+Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B504C133E6;
        Wed, 24 May 2023 20:11:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZoRuK1tvbmTuNgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 24 May 2023 20:11:07 +0000
Date:   Wed, 24 May 2023 22:05:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/9] btrfs: reduce struct btrfs_fs_devices size
 relocate fsid_change
Message-ID: <20230524200500.GC30909@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1684928629.git.anand.jain@oracle.com>
 <7587a86c31528295d77a707f5c1d795eaec4fe06.1684928629.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7587a86c31528295d77a707f5c1d795eaec4fe06.1684928629.git.anand.jain@oracle.com>
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

On Wed, May 24, 2023 at 08:02:35PM +0800, Anand Jain wrote:
> Pack bool fsid_change and bool seeding with other bool declarations in the
> struct btrfs_fs_devices, approximately 6 bytes is saved.
> 
>    before: 512 bytes
>    after: 496 bytes

I checked the difference on a release build and it's even better, 16
bytes, depends on the optional config features in some of the embedded
structures.

--- pre/btrfs.ko.pahole 2023-05-24 21:54:47.326166521 +0200
+++ post/btrfs.ko.pahole        2023-05-24 21:54:47.754166522 +0200
@@ -1700,49 +1700,39 @@ struct btrfs_free_space_op {
...
 
-       /* size: 344, cachelines: 6, members: 27 */
-       /* sum members: 328, holes: 3, sum holes: 16 */
-       /* last cacheline: 24 bytes */
+       /* size: 328, cachelines: 6, members: 27 */
+       /* last cacheline: 8 bytes */
