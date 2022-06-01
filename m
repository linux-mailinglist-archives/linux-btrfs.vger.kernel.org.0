Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9E753A5F3
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 15:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353261AbiFANaP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 09:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242653AbiFANaO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 09:30:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A054FC46;
        Wed,  1 Jun 2022 06:30:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D0B1D1F8F6;
        Wed,  1 Jun 2022 13:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654090211;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AgVnwmFym81i9mNHrlcOn2tQIACC8qJ2aaxzi3vn4LM=;
        b=MKpNKstsCkvVMbEBKSDuOXwzWe06ZUv+Ic/6qv6Pz0dvYOGtW4cYRZCwwD+OsxZDXvtd3X
        dudW8phVh0/qUmvoLJ7mDTRJ6S6lQeT/amNCnFJYrEYtr+RS1Se5LIS5f2sALQJ7BZS/Au
        BwrtUQRgLD9eKiKCf9EDOIxAwkx2BWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654090211;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AgVnwmFym81i9mNHrlcOn2tQIACC8qJ2aaxzi3vn4LM=;
        b=cuWA+GkUy67eXQVSGNMWg8oSiRpc6x6bDccXfWIJbRVw27QD5uMXoJ/DihDWh1vQHeQw2/
        +0ekPW7WXmDjSXCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B3871330F;
        Wed,  1 Jun 2022 13:30:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MfLsJONpl2KwdQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 01 Jun 2022 13:30:11 +0000
Date:   Wed, 1 Jun 2022 15:25:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: Replace kmap() with kmap_local_page()
Message-ID: <20220601132545.GM20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Ira Weiny <ira.weiny@intel.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220531145335.13954-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531145335.13954-1-fmdefrancesco@gmail.com>
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

On Tue, May 31, 2022 at 04:53:32PM +0200, Fabio M. De Francesco wrote:
> This is the first series of patches aimed towards the conversion of Btrfs
> filesystem from the use of kmap() to kmap_local_page().

We've already had patches converting kmaps and you're changing the last
ones, so this is could be the last series, with two exceptions.

1) You've changed lzo.c and zlib. but the same kmap/kunmap pattern is
   used in zstd.c.

2) kmap_atomic in inode.c, so that's technically not kmap but it's said
   to be deprecated and also can be replaced by kmap_local_page. The
   context in check_compressed_csum is atomic (in end io) so the kmap
   hasn't been used there.

> tweed32:~ # btrfs check -p ~zoek/dev/btrfs.file

That won't verify if the kmap conversion is OK, it's a runtime thing
while 'check' verifies the data on device. Have you run any kind of
stress test with enabled compression before running the check?

> Opening filesystem to check...
> Checking filesystem on /home/zoek/dev/btrfs.file
> UUID: 897d65c5-1167-45b4-b811-2bfe74a320ca
> [1/7] checking root items                      (0:00:00 elapsed, 1774 items checked)
> [2/7] checking extents                         (0:00:00 elapsed, 135 items checked)
> [3/7] checking free space tree                 (0:00:00 elapsed, 4 items checked)
> [4/7] checking fs roots                        (0:00:00 elapsed, 104 items checked)
> [5/7] checking csums (without verifying data)  (0:00:00 elapsed, 205 items checked)
> [6/7] checking root refs                       (0:00:00 elapsed, 3 items checked)
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 47394816 bytes used, no error found
> total csum bytes: 44268
> total tree bytes: 2064384
> total fs tree bytes: 1720320
> total extent tree bytes: 180224
> btree space waste bytes: 465350
> file data blocks allocated: 45330432
>  referenced 45330432
> 
> Fabio M. De Francesco (3):
>   btrfs: Replace kmap() with kmap_local_page() in inode.c
>   btrfs: Replace kmap() with kmap_local_page() in lzo.c
>   btrfs: Replace kmap() with kmap_local_page() in zlib.c

Please send patches converting zstd.c and the remaining kmap_atomic
usage in inode.c, otherwise the 3 patches are now in misc-next, thanks.
