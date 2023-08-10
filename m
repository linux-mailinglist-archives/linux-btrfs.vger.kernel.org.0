Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0547777EE3
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Aug 2023 19:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbjHJROG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Aug 2023 13:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjHJROF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Aug 2023 13:14:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA0326B2
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Aug 2023 10:14:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BDE311F74D;
        Thu, 10 Aug 2023 17:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691687643;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vNBbU1B7wyS0D9BwOEzo7fgh6xAiQ91OCP+aSZdLp8A=;
        b=fcuA+TRhv3t9+/npcUtaYjNbX3YoxqTV5BGrxIt+axkwcX8tYtRKaeyeEqJdOo98YQNJ3k
        9GYJakbL1lQemiUgIrVfZsJR6kDEGPiFbS9zEs/4A8uxhd/Au0k0NoS4Ck6ezHq6fiPiRe
        ldZ9YJuwfiLxKkRPaaLxAIxdhq/INrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691687643;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vNBbU1B7wyS0D9BwOEzo7fgh6xAiQ91OCP+aSZdLp8A=;
        b=Mj6gVL/xQDhXNWqRoM1ygBKlz5N5f3nMGBMckFWWVnOJ0R0Nuk3I6tdIb6HJwlTsrrdyql
        mQOfKVZuyYRV1dCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9970F138E2;
        Thu, 10 Aug 2023 17:14:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2hKKJNsa1WTSTAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 10 Aug 2023 17:14:03 +0000
Date:   Thu, 10 Aug 2023 19:07:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 6/6] btrfs: clone relocation checksums in
 btrfs_alloc_ordered_extent
Message-ID: <20230810170738.GJ2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230724142243.5742-1-hch@lst.de>
 <20230724142243.5742-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724142243.5742-7-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 07:22:43AM -0700, Christoph Hellwig wrote:
> Error handling for btrfs_reloc_clone_csums is a royal pain.  That is
> not because btrfs_reloc_clone_csums does something particularly nasty:
> the only failure can come from looking up the csums in the csum tree -
> instead it is because btrfs_reloc_clone_csums is called after
> btrfs_alloc_ordered_extent because it adds those founds csums to the
> list in the ordred extent, and cleaning up after an ordered extent
> has been added to the lookup data structures is very cumbersome.
> 
> Fix this by calling btrfs_reloc_clone_csums in
> btrfs_alloc_ordered_extent after allocting the ordered extents, but
> before making it reachable by the wider word and thus bypassing the
> complex ordered extent removal path entirely.

Please rephrase the changelog and fix the typos. Relocation code is
difficult and nobody wants to break it so there are things to fix but
instead of venting I'd rather see a more concise description that helps
to understand the problem and solution. We don't have much code
documentation and the efforts put into writing good changelogs for such
areas of code is worthwhile. Thanks.
