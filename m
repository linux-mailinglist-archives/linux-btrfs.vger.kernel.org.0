Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6244468F88F
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 21:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjBHUF4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 15:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjBHUFz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 15:05:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43175113D3
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 12:05:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EB046345B9;
        Wed,  8 Feb 2023 20:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675886752;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tC7vXniiKAUtMYKHURPh4uQDl1lzZBiXv4Bvz1mfLeI=;
        b=BoMT6gCdCzVr+/3GXmuO1aScOAhehC4GxyARChc5RmMH8iUAuXvp3ibfsjE9iobU85gW6E
        sMg287LxiuUsmOb4YYB+Lwxlqbr7FY3evIhp1W8K8dO/TQAmc/gourxrwAeope4UCr/Rk5
        T9EMYgKd2l2ucOdaq+IP0fLmdjFyj+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675886752;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tC7vXniiKAUtMYKHURPh4uQDl1lzZBiXv4Bvz1mfLeI=;
        b=hRCXV149aIZqeZsQY44JXFl+LEXNuZQnqHEKrQcSF4B9NBjTrIWCj3fW9601DHpo39soZk
        14N6a5AT32mH08Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFAAE13425;
        Wed,  8 Feb 2023 20:05:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9m/iLaAA5GP7KAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 08 Feb 2023 20:05:52 +0000
Date:   Wed, 8 Feb 2023 21:00:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: small raid56 cleanups v3
Message-ID: <20230208200003.GJ28288@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230111062335.1023353-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111062335.1023353-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 11, 2023 at 07:23:24AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series has a few trivial code cleanups for the raid56 code while
> I looked at it for another project.
> 
> Changes since v2:
>  - lots of reshuffling based on feedback from qu
> 
> Changes since v1:
>  - cleanup more of the work handlers
>  - cleanup cleaning up unused bios
> 
> Diffstat:
>  raid56.c |  324 ++++++++++++++++++++++-----------------------------------------
>  1 file changed, 114 insertions(+), 210 deletions(-)

Added to misc-next, with some subject adjustments, thanks.
