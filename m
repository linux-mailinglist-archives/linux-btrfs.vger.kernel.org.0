Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BB56FD285
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 00:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjEIWSh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 18:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbjEIWSf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 18:18:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C70D3A9D
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 15:18:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0E6551F38C;
        Tue,  9 May 2023 22:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683670699;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u8ENRriOW6SDB/Qcmrh9MmQu6u7kYA36kxz+YOTfTr8=;
        b=i+sKEjRkIDyTY3sqBbazcl9lwYXAGRskXUii3zPdSzfgJ8I2kzEtOqzOrUW2WsHjk6IbR/
        epU5Xn4JzwrSzAqfYcfKASuSuU43bBPWwiHCknjBJYiktEOmrGiGM2cR1aN2tq5JyzKcom
        M3GAcagLfzUwHagyWJdgoBCqcM0hrgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683670699;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u8ENRriOW6SDB/Qcmrh9MmQu6u7kYA36kxz+YOTfTr8=;
        b=J48DJSWrka8YjGujuaxMWn4j4EppECD9nIyBr4qixtXuovAupJLo5cJdZM/9n8du8UFF+9
        MPUAf0LQTJ95bVBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF48913581;
        Tue,  9 May 2023 22:18:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Kx/GNarGWmRnbwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 09 May 2023 22:18:18 +0000
Date:   Wed, 10 May 2023 00:12:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: zone finish data relocation BG with last IO
Message-ID: <20230509221219.GF32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1ccb7d4e3f582369edc1fb067bdd39d867049a0b.1683582405.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ccb7d4e3f582369edc1fb067bdd39d867049a0b.1683582405.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 08, 2023 at 10:14:20PM +0000, Naohiro Aota wrote:
> For data block groups, we zone finish a zone (or, just deactivate it) when
> seeing the last IO in btrfs_finish_ordered_io(). That is only called for
> IOs using ZONE_APPEND, but we use a regular WRITE command for data
> relocation IOs. Detect it and call btrfs_zone_finish_endio() properly.
> 
> Fixes: be1a1d7a5d24 ("btrfs: zoned: finish fully written block group")
> CC: stable@vger.kernel.org # 6.1+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to misc-next, thanks.
