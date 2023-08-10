Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A10A777B04
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Aug 2023 16:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbjHJOnN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Aug 2023 10:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbjHJOnN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Aug 2023 10:43:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007C8268D
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Aug 2023 07:43:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A851B21864;
        Thu, 10 Aug 2023 14:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691678590;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cz5SY37dp/r0pPLIWmtoYJw7jRM5KdqUT1+YqerI8Pg=;
        b=pMkPje56RIrjuv1HGmtZTgIr/7Zt30r4eZr+xkK0ph1HjbyQpYI5bkEINhPDC5K/tfcYmF
        RKgm1RCAmV5pWUNOFo/GyU49Wm9qx6YltakkF2gwdODY9LNGNq5Ri64gCuYmiEEPMf0vJx
        Dh8e3BseZ3d5/mue78DTuB/AFAHZXcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691678590;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cz5SY37dp/r0pPLIWmtoYJw7jRM5KdqUT1+YqerI8Pg=;
        b=4JIbQcw+4JghiU0nlfSSNroo9iI5r2K+Og6JNSkHoc4okAKTlekYQG4R7k7mvcxHeMyQJO
        WT4TsgZF7GZaFCCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A8DB138E0;
        Thu, 10 Aug 2023 14:43:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ypQrHX731GRTDAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 10 Aug 2023 14:43:10 +0000
Date:   Thu, 10 Aug 2023 16:36:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH v3 00/10] btrfs: zoned: write-time activation of metadata
 block group
Message-ID: <20230810143645.GE2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1691424260.git.naohiro.aota@wdc.com>
 <20230810133458.GB2621164@perftesting>
 <v5fdkjdl3j5fndg6ujsoegwv2e7bnay6v6tcs26nsjgqbalde4@g2hmta5ed3vo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v5fdkjdl3j5fndg6ujsoegwv2e7bnay6v6tcs26nsjgqbalde4@g2hmta5ed3vo>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 10, 2023 at 02:34:11PM +0000, Naohiro Aota wrote:
> > seem like legitimate failures.  btrfs/220 needs to be updated since zoned
> > doesn't do discard=async, but you can do that whenever, I'm less worried about
> > that.  The rest should be investigated at some point, though not as a
> > prerequisite for merging this series.  Thanks,
> 
> I checked the CI log. Yes, btrfs/220 is due to discards=async.
> 
> * known to fail
> - btrfs/237: we need to tweak the test for ZNS (zone capacity != zone size)
> - btrfs/239: somehow, tree-log is behaving differently on zoned mode... I
>   	     have no idea why it fail. But, I think it is still a valid status...
> 
> * need to modify test?
> - generic/574: not sure fsverity works with zoned mode. Need to check.

The compatibility matrix at https://btrfs.readthedocs.io/en/latest/Status.html#zoned-mode
does not mention fsverity, so somebody has to test it and add the entry.
