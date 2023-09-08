Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4212797FE0
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 02:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjIHAxP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 20:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjIHAxO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 20:53:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2C61BCD
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 17:53:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 43B1F2184E;
        Fri,  8 Sep 2023 00:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694134389;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xlFDBj6gJTNvxFZ7EnkvI7Hs/70hlI8VAdrUfKPK0+0=;
        b=TdtvOfD+aFFdTTpEO1a6NmUBafX23bwjas2curgSQ8me/NehCvdzVSyLjaqgwk+tDf4RfP
        7vmGN5tcEER73lwou2YHdZgnnMLdvor2Q6TjO517rn/fYJ6Jb+izXLv+njltJZ/TxGDJKW
        BFeE+diDDnRqjJe8tJaqzPAAi0W7maA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694134389;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xlFDBj6gJTNvxFZ7EnkvI7Hs/70hlI8VAdrUfKPK0+0=;
        b=JSICWGibjaF+EpP43K8U3q82R0RNiuwQqKcL9K38OnEFykuSPDPan/i1wMjQNWrZQ7s/cp
        /sE09u0xvc/DgVCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1867413588;
        Fri,  8 Sep 2023 00:53:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Kc8cBXVw+mQGcAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 08 Sep 2023 00:53:09 +0000
Date:   Fri, 8 Sep 2023 02:46:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/10] btrfs: reduce size of struct btrfs_ref
Message-ID: <20230908004636.GU3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1694126893.git.dsterba@suse.com>
 <c9b508651bafb53e98b9f194271d4b7b2d309cba.1694126893.git.dsterba@suse.com>
 <d2f53cb0-7e09-4211-bc21-e2a4fc195dfa@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2f53cb0-7e09-4211-bc21-e2a4fc195dfa@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 08:06:04AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/9/8 07:09, David Sterba wrote:
> > We can reduce two members' size that in turn reduce size of struct
> > btrfs_ref from 64 to 56 bytes. As the structure is often used as a local
> > variable several functions reduce their stack usage.
> >
> > - make enum btrfs_ref_type packed, there are only 4 values
> >
> > - switch action and its values to a packed enum
> >
> > Final structure layout:
> >
> > struct btrfs_ref {
> >          enum btrfs_ref_type        type;                 /*     0     1 */
> >          enum btrfs_delayed_ref_action action;            /*     1     1 */
> 
> Considering both type and action have only 4 values, we can further pack
> them into a single u8.
> 
> Although this means we can not directly use enum type, but u8 type instead.

I consider byte as good enough for enums or bounded types, unless
there's a really good reason to do some ultra packing like in case we
could drop a gap of like 5-7 bytes due to alignment. In case of
btrfs_ref it does not help. With explict bit width this does not reduce
the size (still 56 bytes) and only increase code size:

 struct btrfs_ref {
-       enum btrfs_ref_type        type;                 /*     0     1 */
-       enum btrfs_delayed_ref_action action;            /*     1     1 */
-       bool                       skip_qgroup;          /*     2     1 */
+       enum btrfs_ref_type        type:2;               /*     0: 0  1 */
+       enum btrfs_delayed_ref_action action:3;          /*     0: 2  1 */
+       bool                       skip_qgroup:1;        /*     0: 5  1 */
 
-       /* XXX 5 bytes hole, try to pack */
+       /* XXX 2 bits hole, try to pack */
+       /* XXX 7 bytes hole, try to pack */
 
        u64                        bytenr;               /*     8     8 */
        u64                        len;                  /*    16     8 */
@@ -3116,7 +3117,8 @@ struct btrfs_ref {
        };                                               /*    32    24 */
 
        /* size: 56, cachelines: 1, members: 7 */
-       /* sum members: 51, holes: 1, sum holes: 5 */
+       /* sum members: 48, holes: 1, sum holes: 7 */
+       /* sum bitfield members: 6 bits, bit holes: 1, sum bit holes: 2 bits */
        /* last cacheline: 56 bytes */
 };

Code increase:

   text    data     bss     dec     hex filename
1268477   29813   16088 1314378  140e4a pre/btrfs.ko
1268915   29813   16088 1314816  141000 post/btrfs.ko

DELTA: +438

which means the simple byte comparisons are turned into a few
instructions that first need to mask off the other values, eg.
from btrfs_inc_extent_ref():

test   %al,%al		->		mov    %eax,%edx
					and    $0x3,%edx

so it needs more registers and may prevent some optimizations.
