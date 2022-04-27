Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11F55123E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 22:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbiD0Ubx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 16:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236186AbiD0Ubw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 16:31:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA25B1A84
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 13:28:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 72384210E8;
        Wed, 27 Apr 2022 20:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651091318;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZC8nLpsGMhm9gfOXBUniT3MQ/ubs/UpJKXrlTaQUBLE=;
        b=WaJrPufGH4orCbce+Dlbufq0eHVTiTslxoXV1PpHQ85bj4JoskFzVQP3GLdDX0qr44FgDr
        +4O4c3Ng3Fv0tlfGeiQFOygyvbTJjz9kgpKDvPvtH7Pc1phi4d0YiFhDgmGmnOk1TUJBU/
        xibfKLFVVZ2/0mWjKrcBCUCFWKyoZKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651091318;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZC8nLpsGMhm9gfOXBUniT3MQ/ubs/UpJKXrlTaQUBLE=;
        b=Su2hDkAGhT8yKq/7dli68PWu39EQjFqo4wIO4hWUD1LkgpOYpCG/lUCQjVFKaJzkqUaif+
        LbR1ldgOkC0/GcAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E1791323E;
        Wed, 27 Apr 2022 20:28:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6LoiDnanaWK0BQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 27 Apr 2022 20:28:38 +0000
Date:   Wed, 27 Apr 2022 22:24:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org,
        Dave Sterba <DSterba@suse.com>
Subject: Re: [PATCH] btrfs: Derive compression type from extent map during
 reads
Message-ID: <20220427202430.GB18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org,
        Dave Sterba <DSterba@suse.com>
References: <20220426134734.dxxdrf2hutbmimtc@fiona>
 <7deead89-3be0-2ac2-cbb2-05171911cbe4@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7deead89-3be0-2ac2-cbb2-05171911cbe4@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 27, 2022 at 12:06:37PM +0300, Nikolay Borisov wrote:
> 
> 
> On 26.04.22 г. 16:47 ч., Goldwyn Rodrigues wrote:
> > Derive the compression type from extent map as opposed to the bio flags
> > passed. This makes it more precise and not reliant on function
> > parameters.
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> This patch also makes extent_compress_type unused so it can be removed. 
> Also extent_set_compress_type also becomes redundant and can be removed.

I have a cleanup patch removing extent_set_compress_type so I'll rebase
it on top of that patch.
