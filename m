Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785E16F49B2
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 20:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbjEBSb1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 14:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjEBSb0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 14:31:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67938172E
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 11:31:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1C342219A0;
        Tue,  2 May 2023 18:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683052277;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b6QmUOPDi97MIrzwNVS3SEnPzFoRSijgpeCwqLHxXjI=;
        b=nd+YL4bNqJVCNeN23V3crTx9CUSLwydVDiGnlOdBIOC0VX3SBJquP+nElbyTK28CMUWU/o
        FL82nSFDPcpkd7qzEfa5Re8Wdk5o+38MDDN7zF/gcXW+opf+hwfF+cmBR+8lI5IKPAFDwi
        Cy7hUpHeaykBWJnwccHm4So2YaZYIcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683052277;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b6QmUOPDi97MIrzwNVS3SEnPzFoRSijgpeCwqLHxXjI=;
        b=vW51Hw1P47uXZcP8pRXi+vn13qxBSRWo/Tixcidj1wIGxQBkaAFzKYQN1bRFQ8ttKfIu96
        AhdTafePeKAdqDAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2887139C3;
        Tue,  2 May 2023 18:31:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m8GNNvRWUWTiewAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 May 2023 18:31:16 +0000
Date:   Tue, 2 May 2023 20:25:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: add the ability to enable fst for
 btrfstune
Message-ID: <20230502182521.GM8111@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1682988988.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1682988988.git.wqu@suse.com>
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

On Tue, May 02, 2023 at 09:01:43AM +0800, Qu Wenruo wrote:
> At the beginning of free space tree feature, it's enabled by
> "space_cache=v2" mount option.
> 
> However this introduced some problems:
> 
> - Lack of proper v1 cache clearing in the past
>   In the past we didn't properly clear v1 cache before enabling v2.
> 
> - More and more complex v2 cache dependency
>   Extent tree v2 and bgt all depend on v2 cache, but we have some
>   mount options like clear_cache can screw this up.
> 
> Instead introducing some mount options to tinkering the filesystem
> features (either compat_ro or incompat), we should always go through
> btrfstune to enable new features (just like what we did in bgt).
> 
> This allows us to move the heavy lifting and proper checks into
> btrfs-progs.
> 
> Although it's already late, it's still better than never, thus this
> patchset introduce the --convert-to-free-space-tree feature to
> btrfstune.
> 
> Unlike bgt, v1 cache is going to fade out soon, thus no rollback
> functionality provided.

Agreed.

> I hope we can deprecate the "space_cache=" mount option soon.

Yes, that would be desirable as the mount option wouldn't make much
sense and it's a mkfs-feature so we don't need to reflect that in mount
options that should be for the run time.

We can drop the space_cache from showing among options once we get rid
of the v1 code. There's no scheduled version for that but it could be
done if somebody wants. We have the conversion working and with the
btrfstune also available it should be complete.

> 
> Qu Wenruo (3):
>   btrfs-progs: make check/clear-cache.c to be separate from check/main.c

Right now we have the --clear-space-cache as an option for 'btrfs check'
but it will also make less sense over time. For such one-shot options
it's better to move it to the 'rescue' group. With a separate
clear-cache.c it's going to be easier.  The existing 'check' option need
to stay for compatibility.

>   btrfs-progs: tune: add --convert-to-free-space-tree option
>   btrfs-progs: misc-tests: add test case to verify btrfstune
>     --convert-to-free-space-tree option

Added to devel, thanks.
