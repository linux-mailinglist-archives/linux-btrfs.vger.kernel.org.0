Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A47456BA16
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jul 2022 14:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237613AbiGHMvu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 08:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiGHMvs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 08:51:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D402418375
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 05:51:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 892F81FFE5;
        Fri,  8 Jul 2022 12:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657284705;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KnGqOctfjXWTZEapvZ6YBcDHaoif9mjLC5yzMMKosSw=;
        b=ppxdSE4PHFwgivyu6dR68C8BfUJOZnjQRJjYa0rZUOW8iu2oMYQZhPeEv9z/6LSllYS/0N
        b/A/a7SinoX+j0/q7dvKIoStUF6YbEftrVf9+uC1azC0FkswZ8ZL3br4HAcLOI1QDzGO80
        QCpsu50XffvCLZHfA9h1v9b7EwiEqgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657284705;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KnGqOctfjXWTZEapvZ6YBcDHaoif9mjLC5yzMMKosSw=;
        b=0klT8ekDOUjudR4jNroZp/ng4vN2f/04DFMZNG2JWky9KPdrdRVUtnxslHaV2YBDUuZPoy
        zCufQ/t3Q8HvtgBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D15F13A80;
        Fri,  8 Jul 2022 12:51:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QLi3FWEoyGLiKQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 08 Jul 2022 12:51:45 +0000
Date:   Fri, 8 Jul 2022 14:46:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        naohiro.aota@wdc.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix a memory leak in read_zone_info
Message-ID: <20220708124658.GU15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        naohiro.aota@wdc.com, linux-btrfs@vger.kernel.org
References: <20220704081022.27512-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704081022.27512-1-hch@lst.de>
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

On Mon, Jul 04, 2022 at 10:10:22AM +0200, Christoph Hellwig wrote:
> Don't leak the bioc on normal completion or when finding a parity
> raid extent.
> 
> Fixes: 7db1c5d14dcd ("btrfs: zoned: support dev-replace in zoned filesystems")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Added to misc-next, thanks.
