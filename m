Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AC05AABC0
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 11:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbiIBJt5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 05:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbiIBJts (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 05:49:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705982F2;
        Fri,  2 Sep 2022 02:49:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3FBDE342EB;
        Fri,  2 Sep 2022 09:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662112184;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lmwlFwwsi5q4Nc/M0e28I3Vhn1BiDjq+Yf2XdS1hGjI=;
        b=Uavy29kBX+v4xKIvq0EnryNAXmkf7WaqaWJ+b13K+C02+Z56nze5o6sDYYzBWgz9EpYjNO
        VIxrfs4bYAHPJxUuZh6FMln9MYapOxTdUeK3b16kWRn7N+OOduu1KdVyVVOXl9/Ndyr9Y5
        QB2PcVqlcFHMqkXDPkWf5R6K8QSZKHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662112184;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lmwlFwwsi5q4Nc/M0e28I3Vhn1BiDjq+Yf2XdS1hGjI=;
        b=q/98rliO6/+9FDbQ/468A5Uh3iSIt+IcD8DDD6h98ZcrY73cMEjUj/4TvbA7Ju0xadbiyw
        VxLAJAVXhtMhBxDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1503213328;
        Fri,  2 Sep 2022 09:49:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fHhaBLjREWOlHAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 02 Sep 2022 09:49:44 +0000
Date:   Fri, 2 Sep 2022 11:44:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fdmanana@kernel.org, Christoph Hellwig <hch@lst.de>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: remove 'seek' group from btrfs/007
Message-ID: <20220902094424.GQ13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Zorro Lang <zlang@redhat.com>,
        fdmanana@kernel.org, Christoph Hellwig <hch@lst.de>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
References: <bc7149309a8eca5999f22477a838602023094cb8.1662048451.git.fdmanana@suse.com>
 <20220902020030.oho6ssdrdzjy66pw@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902020030.oho6ssdrdzjy66pw@zlang-mailbox>
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

On Fri, Sep 02, 2022 at 10:00:30AM +0800, Zorro Lang wrote:
> On Thu, Sep 01, 2022 at 05:12:25PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > btrfs/007 does not test lseek, it tests send/receive and lseek is not
> > exercised anywhere in this test. So just remove it from the 'seek' group.
> > 
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> 
> This 'seek' group is brought in by below commit:
> 
>   commit 6fd9210bc97710f81e5a7646a2abfd11af0f0c28
>   Author: Christoph Hellwig <hch@lst.de>
>   Date:   Mon Feb 18 10:05:03 2019 +0100
> 
>       fstests: add a seek group
> 
> So I'd like to let Christoph help to double check it.

It's quite obvious from the test itself that it tests only send/receive,
which is mentioned in the changelog. The commit adding the seek group
does not provide any rationale so it's hard to argue but as it stands
now the 'seek' group should not be there.
