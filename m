Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEC05F5671
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Oct 2022 16:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJEOby (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Oct 2022 10:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiJEObw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Oct 2022 10:31:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F938726BC
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Oct 2022 07:31:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3BABD1F88F;
        Wed,  5 Oct 2022 14:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664980309;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1cJOsTWsgsQPJtAACW1JwFruNg8P85D73h4/5jSTkTw=;
        b=Fne5pDOVJI0OexR1chvh5agt1E/pkmiF+Rcb600DW7WDiccUBnqgn/PIyQ80oF0BnIccIp
        8Dqk4MprorcGxSbAReDAoHfZM67CCrggsVXpqulySfT6kIjtmg1i39JkXefHCnUXz6oAv/
        JxOZs+kmTyoVju0aoULNTTLKIxadH3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664980309;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1cJOsTWsgsQPJtAACW1JwFruNg8P85D73h4/5jSTkTw=;
        b=fzpARIn3WygVYDV/Yd2oyc+wudyugR+nlv3TYmRyXFEaQysM+Edof2az5HEianhh+/vNvr
        MGXJefi3D08hExDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D46F13ABD;
        Wed,  5 Oct 2022 14:31:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9UswBlWVPWMNJwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 05 Oct 2022 14:31:49 +0000
Date:   Wed, 5 Oct 2022 16:31:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: properly initialized extent generation
 for __btrfs_record_file_extent()
Message-ID: <20221005143146.GL13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1664869157.git.wqu@suse.com>
 <c06aff30ab435f40f77f56fd8c049a00161cb90c.1664869157.git.wqu@suse.com>
 <ce51e303-1a66-5dc9-60d0-2aac6d0a52c4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce51e303-1a66-5dc9-60d0-2aac6d0a52c4@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 05, 2022 at 05:39:24PM +0800, Anand Jain wrote:
> On 04/10/2022 15:43, Qu Wenruo wrote:
> > [BUG]
> > When using mkfs.btrfs --rootdir option, the data extents generated will
> > has 0 as their generation in extent tree:
> > 
> >    # mkdir /tmp/rootdir
> >    # xfs_io -f -c "pwrite 0 16k" /tmp/rootdir
> 
> This should be:
> 
>   # xfs_io -f -c "pwrite 0 16k" /tmp/rootdir/foobar

Updated, thanks.
