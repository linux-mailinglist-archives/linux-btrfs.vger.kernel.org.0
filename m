Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28044F7D47
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Apr 2022 12:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244548AbiDGKxx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Apr 2022 06:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244545AbiDGKxw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Apr 2022 06:53:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B0BE6164;
        Thu,  7 Apr 2022 03:51:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 98F1221117;
        Thu,  7 Apr 2022 10:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649328711;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l1Tzxv44rv0NjNRX4WlYNhE5cU//xGlEDNhpdKJU4PQ=;
        b=22WOQxpzIbLL/gHYhoRUeNZsZwNXDn8q7nXiDhJ9x5xh2epQ/bJTHWJU5YAcw+dpBOdJC0
        HWSutIPaFZBmZcv8PIpyJKClsQKZ4kGoT7xe/kYTQqnzvaodKaBAsbQgHiRVjX+VBAcC9F
        hnfjeINBtMi74UqV2J74zhHWIpoufNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649328711;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l1Tzxv44rv0NjNRX4WlYNhE5cU//xGlEDNhpdKJU4PQ=;
        b=1qasprG3GnuRkCPq23tnKm4YcOmWoOAZz7RmjrLzwIqVc5DKs+iNhlxrTA6xYzuH9voXam
        Xkd85YDfLqNmWvAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9FAD0A3B82;
        Thu,  7 Apr 2022 10:51:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 596A6DA80E; Thu,  7 Apr 2022 12:47:48 +0200 (CEST)
Date:   Thu, 7 Apr 2022 12:47:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     cgel.zte@gmail.com
Cc:     dsterba@suse.cz, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, lv.ruyi@zte.com.cn
Subject: Re: [PATCH] Btrfs: remove redundant judgment
Message-ID: <20220407104748.GD15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, cgel.zte@gmail.com, clm@fb.com,
        dsterba@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, lv.ruyi@zte.com.cn
References: <20220406130453.GB15609@suse.cz>
 <20220407015700.2489671-1-lv.ruyi@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407015700.2489671-1-lv.ruyi@zte.com.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 07, 2022 at 01:57:00AM +0000, cgel.zte@gmail.com wrote:
> < Ok, we can drop the check, have you looked if there are more similar
> < places to update?
> I found six by coccinelle, but they are in different paths.Should I
> send one patch or six?

As this is a simple change it can be in one patch, provided that it's
the same logic (dropping inode check before iput).

I've found only 2 instances with this coccinelle script:

@@
expression E;
@@

* if (E)
*       iput(E);
--

not sure where you found 6.
