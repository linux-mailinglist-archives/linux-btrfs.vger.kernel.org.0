Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F2A70E5EE
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 21:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbjEWTsi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 15:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjEWTsh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 15:48:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B33E5
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 12:48:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 249021F8C2;
        Tue, 23 May 2023 19:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684871315;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VWA6JTtYgOr9ZfKt7NWHZBwlD/8D/jh+SW+tTn9z4uU=;
        b=iauN83cpVGar+sUBsz/+s58L2GuiDZA8F0E6bAvQLzNC7GA0on0aXWD0niIyoT2IMfeH+g
        UZGUADz9OzM6qg3GJ7xpeShU6eiyMt+C30qBgIHczrueT5Doek/mfCWtFivuewKYtM9/UY
        7Vwb95gmblxVdP1M5RQJojCveaQW23w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684871315;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VWA6JTtYgOr9ZfKt7NWHZBwlD/8D/jh+SW+tTn9z4uU=;
        b=yzpCsEMQgFqw6yfNeaOm3bWW19h7CqDp7AQgga8jDdYqZyuy9OR5onpxR7fkMmPRENS5fO
        KQyPupYfMf8RFnDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 029F013A10;
        Tue, 23 May 2023 19:48:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3/hpO5IYbWRhZwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 23 May 2023 19:48:34 +0000
Date:   Tue, 23 May 2023 21:42:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: simplify extent_buffer reading and writing v4
Message-ID: <20230523194228.GB32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230503152441.1141019-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503152441.1141019-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 03, 2023 at 05:24:20PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> currently reading and writing of extent_buffers is very complicated as it
> tries to work in a page oriented way.  Switch as much as possible to work
> based on the extent_buffer object to simplify the code.
> 
> I suspect in the long run switching to dedicated object based writeback
> and reclaim similar to the XFS buffer cache would be a good idea, but as
> that involves pretty big behavior changes that's better left for a
> separate series.
> 
> Changes since v3:
>  - rebased to the latest misc-next tree
>  - remove a spurious ClearPageError call

I've moved the patches to misc-next, with some minor updates or fixups.
The comments I sent are more like for changelog updates, please have a
look. Thanks.
