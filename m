Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A845D6D2621
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Mar 2023 18:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjCaQr5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Mar 2023 12:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjCaQrm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Mar 2023 12:47:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D926F24403
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Mar 2023 09:45:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7E9E521A8E;
        Fri, 31 Mar 2023 16:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680281131;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4KpK/EsQ54QdvVM9VxoP1DcCOWIA7S4CJhgDYbaiaHQ=;
        b=us2K7XpjDTPL+wqSfP2z1eO3cbPRqGtk8ZBrXzde+bqIamlYNSwZb0sPS1gidsdQ548Qpb
        yk4dlBsAhmvcKRlf4aFE3EKByWdMmMXolhVwEsrKvIAVpHpEnZewj5nZ0V98B5VW4sG2by
        HydO51hlbMmJzlu9vOKQ0k+9KtdZfN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680281131;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4KpK/EsQ54QdvVM9VxoP1DcCOWIA7S4CJhgDYbaiaHQ=;
        b=rsGt3Z9+tyYAfdZiTASUomtIHb/nKK/7Db5/GtYuYTHT/f4S2vpIWsdgae4VsmazyyE3tK
        5QPpIqAFkZkoXDCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4FE53134F7;
        Fri, 31 Mar 2023 16:45:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KyWnEisOJ2RcLwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 31 Mar 2023 16:45:31 +0000
Date:   Fri, 31 Mar 2023 18:39:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: simplify extent_buffer reading and writing v2
Message-ID: <20230331163915.GW10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230314061655.245340-1-hch@lst.de>
 <20230324010527.GA12152@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324010527.GA12152@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 24, 2023 at 02:05:27AM +0100, Christoph Hellwig wrote:
> On Tue, Mar 14, 2023 at 07:16:34AM +0100, Christoph Hellwig wrote:
> > Hi all,
> > 
> > currently reading and writing of extent_buffers is very complicated as it
> > tries to work in a page oriented way.  Switch as much as possible to work
> > based on the extent_buffer object to simplify the code.
> > 
> > I suspect in the long run switching to dedicated object based writeback
> > and reclaim similar to the XFS buffer cache would be a good idea, but as
> > that involves pretty big behavior changes that's better left for a
> > separate series.
> 
> Dave, and comment on where this stands?
> 
> With the series we don't need bbio->inode for metadata and could
> actually do the fs_info pointer Qu needs in a nice way.

V3 is out but I'll reply here: I don't want to touch yet another core
btrfs subsystem (extent buffer references) in the same development cycle
so I'll consider this again for 6.5 as 6.4 is nearing code freeze for
big changes. V1 of this patchset was sent in time but then loads of bio
patches and scrub work has started.
