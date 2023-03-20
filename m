Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E2F6C1AE2
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Mar 2023 17:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjCTQFn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 12:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbjCTQFP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 12:05:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807353AB9
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 08:54:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A1E0D1F8A3;
        Mon, 20 Mar 2023 15:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679327652;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/YXyz9ty6UDbY+xgDhefjc3WA0yb68cGFXQY6c7q/bw=;
        b=HY2XqoKfom9BDykkcSIGFb4bSZJzwXIXZ3U29/C6/PQn+98zwC6a4CLh9df3vFDhN6Q07V
        UtN6G8MJ4w7Xru/lMo++hffp48sJAApZcrb6u6evisid3nHZTKMxKpavxzNEXDvntyAUXe
        rNSxH+8wnISnD8bHHu9EQEL41MR09ac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679327652;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/YXyz9ty6UDbY+xgDhefjc3WA0yb68cGFXQY6c7q/bw=;
        b=DVfJyJXYlYkHR4sUHa/8IcXd4zxgqhy73IJNp94bZtn3Azgd7uNlW9+erw6XFTPMima4EO
        j0yb15+tz8u2H3BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F75C13416;
        Mon, 20 Mar 2023 15:54:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m3gXHqSBGGTwVgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 20 Mar 2023 15:54:12 +0000
Date:   Mon, 20 Mar 2023 16:48:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs-progs: filesystem-usage: handle missing seed
 device properly
Message-ID: <20230320154802.GG10580@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1676115988.git.wqu@suse.com>
 <0695352140625cd66a86e8a12365271def5db39b.1676115988.git.wqu@suse.com>
 <20230316152544.GY10580@twin.jikos.cz>
 <ee689112-30de-89b3-51fc-cc6bc33716fb@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee689112-30de-89b3-51fc-cc6bc33716fb@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 18, 2023 at 08:00:18AM +0800, Qu Wenruo wrote:
> Hi David,
> 
> Mind to drop the series?
> 
> Although the series is to solve the btrfs/249 failure, Anand's patch is 
> already merged.
> 
> Furthermore the situation of btrfs/249 is very niche, it involves RAID1 
> as seed, which should be rare or even non-exist in real world.
> 
> Thus I don't think the fallback for such a niche usage is really worthy 
> anymore.

The multi-device seeding should work, though I agree it's a niche use
case. A fallback code should be there either in full or with a warning
that some combination is not supported or could be problematic.
