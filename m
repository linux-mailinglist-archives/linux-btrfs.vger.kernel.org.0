Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8827472C82A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 16:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbjFLOXQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 10:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238302AbjFLOXD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 10:23:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E73F3C12
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 07:20:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 10CAD22847;
        Mon, 12 Jun 2023 14:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686579607;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n/tE+R8nE76ahtK0HTxf/AhfZOmJAkRqUdccvCxBWDI=;
        b=Q5G302gScH8TEQ56MbXOE+FCIHn/dC8rIaihJgGo2qXRga4iuExm8KYPoOexZN7ABjhWbK
        gNEN0d1PJVkeLVR25guUpVcFpwbnzL9K4jR0A+m1aMiD1oHgu7DMILH710njZRdRNptohG
        O2w7awE4f0KvWaT1H0j42y3HAHyNXYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686579607;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n/tE+R8nE76ahtK0HTxf/AhfZOmJAkRqUdccvCxBWDI=;
        b=rYn4i1sBclHnrEdNQceZFxjnSys3EIk8TOKWSVPFibYDYj7GBVQm5WjykdzRqoe2efPaeZ
        sOnkQecThrLRGOBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DACAD1357F;
        Mon, 12 Jun 2023 14:20:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aV2WNJYph2R+HAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 12 Jun 2023 14:20:06 +0000
Date:   Mon, 12 Jun 2023 16:13:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        johannes.thumshirn@wdc.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: record orig_physical only for the original bio
Message-ID: <20230612141348.GB13486@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230609052704.329148-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609052704.329148-1-hch@lst.de>
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

On Fri, Jun 09, 2023 at 07:27:04AM +0200, Christoph Hellwig wrote:
> btrfs_submit_dev_bio is also called for clone bios that aren't embeeded
> into a btrfs_bio structure, but commit 177b0eb2c180 ("btrfs: optimize the
> logical to physical mapping for zoned writes") added code to assign
> btrfs_bio.orig_physical in it.  This is harmless right now as only the
> single data profile can be used on zoned devices, but will blow up when
> the RAID stripe tree is added.  Move it out into the single I/O specific
> branch in the caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This is another fixup to the patch ("btrfs: optimize the
logical to physical mapping for zoned writes") but as this is harmless I
haven't folded it to it but rather reordered right after it. It's better
to have the change explained separately. Added to misc-next, thanks.
