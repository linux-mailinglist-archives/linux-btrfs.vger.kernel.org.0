Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B172F7C8B4E
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Oct 2023 18:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjJMQaf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Oct 2023 12:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjJMQaX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Oct 2023 12:30:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E8319A
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Oct 2023 09:28:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6188B219FA;
        Fri, 13 Oct 2023 16:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697214501;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JxhHteeCARYCpLMO4jbrHnoONCy01+C1LOEwEtJEX+4=;
        b=1d/jT/KXnaP2Pi8UeHzFW4anKoP3PLQiUjjVeD5nFIzQGduuEOT4+UBzkXXzBu/9K3Gcav
        w01BuKI9DheYGVDxrcPMoWfaARlkWV9Ou23pU/kaoGMQ8KPvXtDzsNDRikJvWECJRhw9AG
        NsjDZ41V5bObGRpsX3LkpPCHpagwjqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697214501;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JxhHteeCARYCpLMO4jbrHnoONCy01+C1LOEwEtJEX+4=;
        b=0mq1psDTUGOcigk1woMdoGIKaU7cR4g5c4nh4X5JjBeOe5+/3TmuRqMRBaRqS6F95uyjOJ
        g5mjMDJubf+FCgAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3416A1358F;
        Fri, 13 Oct 2023 16:28:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VWQ+CyVwKWX7agAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 13 Oct 2023 16:28:21 +0000
Date:   Fri, 13 Oct 2023 18:21:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/2] btrfs-progs: make sure "mkfs --rootdir" copies
 all the attributes for the rootdir
Message-ID: <20231013162133.GS2211@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1697057301.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697057301.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.34
X-Spamd-Result: default: False [-5.34 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWO(0.00)[2];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-1.54)[92.02%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 12, 2023 at 07:19:24AM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v3:
> - Use 'stat()' instead pf 'lstate()' for the rootdir
>   This would follow a softlink for the rootdir.
> 
> v2:
> - Add more attributes to be copied for rootdir, including:
>   * mode
>   * uid
>   * gid
>   * timestamps
> 
> - Update the test case
>   * Use two loopback devices
>     One to store the source directory, so that we're ensured to have
>     xattr support.
>   * Add checks for all the uid/gid/mode attributes
> 
> We got a bug report that "mkfs.btrfs --rootdir" copies all the xattr but
> the xattr of the source directory.
> 
> It turns out that we only do the regular xattr/gid/uid/mode/timestamps
> copy for all the child inodes, not the source directory itself.
> 
> Fix it and create a test case for it.
> 
> Qu Wenruo (2):
>   btrfs-progs: mkfs/rootdir: copy missing attributes for the rootdir
>     inode
>   btrfs-progs: tests/mkfs: make sure rootdir inode got its attributes
>     copied

Added to devel with some fixups, thanks.
