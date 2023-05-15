Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BF3702B0B
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 May 2023 13:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241084AbjEOLGH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 May 2023 07:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240873AbjEOLGH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 May 2023 07:06:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E4F93
        for <linux-btrfs@vger.kernel.org>; Mon, 15 May 2023 04:06:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 72E3521BD4;
        Mon, 15 May 2023 11:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684148760;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dkRL1J9RDk6CkwOf8MKGqVdIV5z7pqPTaz5ZpGyKIDY=;
        b=vNzdIALyQgyfj758ypPrrrst7fhzzuaOzAxVMZfnkmGDTH8VomIJVTgSXea/hzc59xO2ii
        JPpL/VID/e0l8FHEEXf5ntBIv9qWpQr3AVNk/GRv0ZR3sK8lx7uUCtnjIDc1hCzwzGmN/r
        5p3YmhN60GEAbvlREaJ7kgFnPw+lnMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684148760;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dkRL1J9RDk6CkwOf8MKGqVdIV5z7pqPTaz5ZpGyKIDY=;
        b=bVv7FDax+0HPlssO1vxwMwm74K18FLglJzVoL3XzO1aVjAiAv1n7+x1HK5TzumjOL5oVCG
        43+TgVfm+bcj6ECw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EF5D13466;
        Mon, 15 May 2023 11:06:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q7R4EhgSYmTIfAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 15 May 2023 11:06:00 +0000
Date:   Mon, 15 May 2023 12:59:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Stefano Babic <sbabic@denx.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH] Makefile: add library for mkfs.btrfs
Message-ID: <20230515105958.GF32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230514114930.285147-1-sbabic@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230514114930.285147-1-sbabic@denx.de>
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

On Sun, May 14, 2023 at 01:49:30PM +0200, Stefano Babic wrote:
> Even if mkfs.btrfs can be executed from a shell, there are conditions
> (see the reasons for the creation of libbtrfsutil) to call a function
> inside own applicatiuon code (security, better control, etc.).
> 
> Create a libmkfsbtrfs library with min_mkfs as entry point and the same
> syntax like mkfs.btrfs. This can be linked to applications requiring to
> create the filesystem.
> 
> Signed-off-by: Stefano Babic <sbabic@denx.de>
> ---
> 
> This requires some explanation. Goal is to export mkfs.btrfs as library
> to let it be be called from an application. There are use cases in embedded systems
> where this is desired and the reasons are exactly the same
> that lead to libbtrfsutil. I can shell out mkfs.btrfs, but this is not
> the best option (security if shell is compromised, dependency that mkfs is available,
> having a self contained application, output format not parsable, etc.).
> 
> For all these reasons, a library that creates a btrfs filesystem is desired.
> The patch here just export mkfs.btrfs in the busybox way, that is exports mkfs_main(),
> and just builds a library. It does not touch existing code (Makefile).
> 
> Agree that this can be just used by other Open Source projects that are compliant with
> GPLv2, but this is exactly my use case :-).
> 
> I would like to know if such as extension can be accepted, even if I know
> this is not a topic for most Linux distributions.

The use case is reasonable, but creating a separate library is not a good
solution IMHO. There needs to be stable versione API, symbol versioning
for backward compatibility. If you already link against libbtrfsutil
then the mkfs should be provided there.

Do you need to create multi device filesystem? Compared to a single
device the API would be easier, the one device file descriptor and the
flags and numeric parameters like nodesize. The string interface in
argc/argv is flexible and extensible but not a real library API.

So for a single device we can extract the functions from mkfs and wrap
them to a single call. The libbtrfsutil code is sepate so it would need
a rewrite and it also has a different license, that's another thing to
consider.
