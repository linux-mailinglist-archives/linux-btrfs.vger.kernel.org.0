Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5462B7CCC76
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Oct 2023 21:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjJQTl0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Oct 2023 15:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbjJQTlZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Oct 2023 15:41:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E463C4
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Oct 2023 12:41:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8724821116;
        Tue, 17 Oct 2023 19:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697571682;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vmb/hwsBZz5ePK3cfocqpOVwmseZrqZgoy167kq6slM=;
        b=bMc0MaMJjDulthN+bp7DfCSVxNVdv6S0oseZ3P9swXSSstWteB9QEw9NxNdSzWeNgB46hx
        yDJLF/PnpJlERg03WPzuAwTQ92daOtHTAfyoGfsGasHhrzmR6E0u4sTpJ/Tp2X/hftPpaO
        cFHhsHu0kP56W0UXazqg4CBpJb7l2Ic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697571682;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vmb/hwsBZz5ePK3cfocqpOVwmseZrqZgoy167kq6slM=;
        b=V4CQVf4Z3bV643U07xGKVDfkpJm1IqJfFtKNsYowzpgIbCgu3rjDK3vk3s44EMazFQiXaU
        7XdXU0twXFGL5HDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 652A713597;
        Tue, 17 Oct 2023 19:41:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XcB5F2LjLmUsOAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 17 Oct 2023 19:41:22 +0000
Date:   Tue, 17 Oct 2023 21:34:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, Johannes.Thumshirn@wdc.com
Subject: Re: [PATCH] btrfs: zoned: drop no longer valid write pointer check
Message-ID: <20231017193432.GB2211@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <c3b77b1b1b0c33ad8e51d055b97dde3d1874669e.1697527349.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3b77b1b1b0c33ad8e51d055b97dde3d1874669e.1697527349.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.27
X-Spamd-Result: default: False [-5.27 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-1.47)[91.44%]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 17, 2023 at 04:23:22PM +0900, Naohiro Aota wrote:
> There is a check of the write pointer vs the zone size to reject an invalid
> write pointer. However, as of now, we have RAID0/RAID10 on the zoned
> mode, we can have a block group whose size is larger than the zone size.
> 
> As an equivalent check against the block group's zone_capacity is already
> there, we can just drop this invalid check.
> 
> Fixes: 568220fa9657 ("btrfs: zoned: support RAID0/1/10 on top of raid stripe tree")
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to misc-next, thanks.
