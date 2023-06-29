Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE28742AB6
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 18:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjF2QfB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 12:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjF2Qe5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 12:34:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D3D30DD
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 09:34:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0093C1FD66;
        Thu, 29 Jun 2023 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688056495;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e6NuvfIlrs8zjb5NXokNWY2T9a/qHypIgHN1VEdtWHQ=;
        b=RtssOCZxKzmhQpr89BbkpYKd1FP+xJO4h4gyru7l3SFh3kRhJUZ7cpIB//BW8/jXUfttc9
        +4f7bOk0jjZL/LhK9vTcNq5qr5sUYopEWEeihuAsrCxE/PSvXLfJuphDdzJtyDNPl4u72h
        EB5JpQr7tRQyeLHZV5ila573Ty7qrZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688056495;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e6NuvfIlrs8zjb5NXokNWY2T9a/qHypIgHN1VEdtWHQ=;
        b=pzx6h1y5Gl53WgTw4UpOXLKHf3PIrpQGlPgNvd8yDAqaJXRysxw+3VGiI9kOi4sg8gvpBR
        1ytT3J2bZLYDv5DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CAA3213905;
        Thu, 29 Jun 2023 16:34:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iembMK6ynWTqVgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 29 Jun 2023 16:34:54 +0000
Date:   Thu, 29 Jun 2023 18:28:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs_map_block tidyups
Message-ID: <20230629162826.GR16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230627061324.85216-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627061324.85216-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 27, 2023 at 08:13:22AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> Dan reported a static type checker complained about the num_mirror_ret
> output argument in btrfs_map_block, so the first patch cleans that up.
> The second one simplifies a conditional right next to it.

Added to misc-next, thanks.
