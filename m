Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D02E6FD2EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 01:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjEIXDl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 19:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjEIXDk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 19:03:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627161BFE
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 16:03:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1D7E421BE5;
        Tue,  9 May 2023 23:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683673417;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jPPVBRj9XYMjVGK5g1HPo0jH1dCTCy3MIGqaaRepYi4=;
        b=c76bIGEynu8/VxghNlJMFsn/39Vj7Q494cfIyIXuNBxi1sGGWDJbV7sutNlBPKDKMjFvv4
        4fmJQnt7j29433zq3kyQlGOWE4S5tZ0gP+Bvj1YAACobAgmoH9WLbqAevB/jKZqmSbEJyQ
        i8rnm0WESlLRhlCbJ6GIoSJyD1Otd1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683673417;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jPPVBRj9XYMjVGK5g1HPo0jH1dCTCy3MIGqaaRepYi4=;
        b=Xk3Ayp/9otvQKM9CZ9AtZiugZ19bEjsK0pIoiLvn+thmWO1DxfZlUTRq7XH2R2Rw/KMtPa
        8rOHQ+PWMcpplEAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DDB93139B3;
        Tue,  9 May 2023 23:03:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fu1HNUjRWmStAQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 09 May 2023 23:03:36 +0000
Date:   Wed, 10 May 2023 00:57:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        naohiro.aota@wdc.com
Subject: Re: [PATCH 3/3] btrfs: don't hold an extra reference for redirtied
 buffers
Message-ID: <20230509225737.GK32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230508145839.43725-1-hch@lst.de>
 <20230508145839.43725-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508145839.43725-4-hch@lst.de>
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

On Mon, May 08, 2023 at 07:58:39AM -0700, Christoph Hellwig wrote:
> When btrfs_redirty_list_add redirties a buffer, it also acquires
> an extra reference that is released on transaction commit.  But
> this is not required as buffers that are dirty or under writeback
> are never freed (look for calls to extent_buffer_under_io())).
> 
> Remove the extra reference and the infrastructure used to drop it
> again.

I vaguely remember that the redirty list was need for zoned to avoid
some write pattern that disrupts the ordering, added in d3575156f662
("btrfs: zoned: redirty released extent buffers").

I'd appreciate more eyes on this patch, with the indirections and
writeback involved it's not clear to me that we don't need the list at
all. Pointing to extent_buffer_under_io() is a good start but the state
transitions of eb are complex so a more concrete example how it works
should be in the changelog.

For testing I'll add the series to misc-next, changelog update can be
done later.  Thanks.
