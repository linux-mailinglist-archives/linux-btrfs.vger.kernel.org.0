Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C8E70E71D
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 23:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbjEWVFv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 17:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjEWVFu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 17:05:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA011AE
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 14:05:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 32F452270B;
        Tue, 23 May 2023 21:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684875925;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Qz1skPXh58V8WS+KlBNfRqGQWV+LggyrBY9qcMWC2M=;
        b=dCRvY+we8vT+BPsEJmgqpWVsbHt0z/EanDQZIoxj8LlsDQ+YUz1AWc/d9zVnXxfut4uUDV
        YXAmv1RDW3ZuirCWQz1IYETZmn5GnzSPxEKd7lssglt4qCT3YXdArpjcCtaQD5xO4buEFD
        tnh9d+XeW5exIEVqJEnlFvvsgpBiHD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684875925;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Qz1skPXh58V8WS+KlBNfRqGQWV+LggyrBY9qcMWC2M=;
        b=nCPCvF6n1Y5mjG7idlEhqAxlj1bRydsz407p+5x5yKOhTHlafvDc4C8c6O92Pf2gGg1OlT
        edbWTxPHM2y3o0AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D027313588;
        Tue, 23 May 2023 21:05:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vlENMpQqbWRUAQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 23 May 2023 21:05:24 +0000
Date:   Tue, 23 May 2023 22:59:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/9] btrfs: reduce struct btrfs_fs_devices size relocate
 fsid_change
Message-ID: <20230523205917.GC32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1684826246.git.anand.jain@oracle.com>
 <844fa765ab173b8dd24549f145534f41d412d3ea.1684826247.git.anand.jain@oracle.com>
 <ZGzpgG8o5pv5+hNL@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGzpgG8o5pv5+hNL@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 23, 2023 at 09:27:44AM -0700, Christoph Hellwig wrote:
> On Tue, May 23, 2023 at 06:03:15PM +0800, Anand Jain wrote:
> > By relocating the bool fsid_change near other bool declarations in the
> > struct btrfs_fs_devices, approximately 6 bytes is saved.
> > 
> >    before: 512 bytes
> >    after: 496 bytes
> > 
> > Furthermore, adding comments.
> 
> I like the better backing.  But what looks access to fsid_change
> and the other bools?  For sub-word members atomicy guarantees are
> very limited, so they'd better all use the same lock.

Do you have an example where the reordered structure would become
problematic? The fs_devices locking is non-standard, the structures are
accessed from module context or from filesystem context. There's the
uuid_mutex as a big lock for fs_devices, and for access of the
individual devices is device_list_mutex.

It's possible that there's something wrong still but after a quick look
I don't see anything obvious. Because of the complex locking there are
no optimizations like unlocked access to bool members.
