Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25A2509148
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 22:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382035AbiDTUSz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 16:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351156AbiDTUSy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 16:18:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B265F3EB80
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 13:16:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6152B210EB;
        Wed, 20 Apr 2022 20:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650485762;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oodgelz5/r2lntTF6+ojZyHiuON2dxRPLLbE4VueZ6Y=;
        b=0D4PB8WxLKstZ7E1tgqeITWNm6pcZlADXdy1u+u9qU3yVpyNCxBkbdu43y1RjkGavIHnUz
        5vTcxWxu1OZW2ppDkFgdtsHDy0gHupFSuuQiN1d1TMIU8OL/DsoD3xlNIBnOu/mkHRgSon
        013/e5l4/Y5+Qkbd4Bywwh/qaGpcDK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650485762;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oodgelz5/r2lntTF6+ojZyHiuON2dxRPLLbE4VueZ6Y=;
        b=cOjZYopZKwlvv+MOccKFeQn3yEIBQT6yPz67i4Po4ZQIGllKQVIvmUOS+vuPLmZwi2wgDb
        yHRInmrGwrzBHNBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C0CD13AD5;
        Wed, 20 Apr 2022 20:16:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +S6iDQJqYGK1GwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 20 Apr 2022 20:16:02 +0000
Date:   Wed, 20 Apr 2022 22:11:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 00/18] btrfs: split bio at btrfs_map_bio() time
Message-ID: <20220420201158.GJ1513@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1647248613.git.wqu@suse.com>
 <Yjnu7yWxAforTGQF@infradead.org>
 <96e622b1-fffb-34ae-6055-49bd7a4ea23b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96e622b1-fffb-34ae-6055-49bd7a4ea23b@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 23, 2022 at 07:45:31AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/3/22 23:44, Christoph Hellwig wrote:
> > I spent some time looking over this series and I think while it has
> > some nice cleanups, it also goes fundamentally in the wrong direction.
> 
> Well, at least I got some review, that's always a good news.

So this whole series will be dropped and replaced by Christoph's
patches, however if there's anything useful left please send it
separately later on. Thanks.
