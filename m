Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487F54F9D32
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 20:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbiDHSu7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 14:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbiDHSu6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 14:50:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950731C7E9D;
        Fri,  8 Apr 2022 11:48:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3F142210EF;
        Fri,  8 Apr 2022 18:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649443733;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rNReIfAGeus5Vto4N+wZUUGUeFj6AQ7Aj/5V+na+520=;
        b=m1S+LWBpFXdSFeUXBG6HVVbc7p1NapziMGAzaDWMNT0iwUV0MekpJXuX1S/vdaUulXMHZh
        Q6NX0la1j7fBSAs24pfx5ShIesxh3nXtZrGWn/WRYUSjpDZWPcBPvtgm/6E+gv3N0NMQdc
        eFQl+GlGn+aiqA1Mlt0s8E0aaWAWhoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649443733;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rNReIfAGeus5Vto4N+wZUUGUeFj6AQ7Aj/5V+na+520=;
        b=tlQQY436byyl4INEuQNnGOB4sEwVb0WU3HCjIuwMvLooh7qHcCywDBiqRrkR1La4IGKc/j
        YgMpdoRbI62UNsAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 33FD6A3B89;
        Fri,  8 Apr 2022 18:48:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 41229DA832; Fri,  8 Apr 2022 20:44:50 +0200 (CEST)
Date:   Fri, 8 Apr 2022 20:44:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Schspa Shi <schspa@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        terrelln@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: zstd: use spin_lock in timer function
Message-ID: <20220408184449.GB15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Schspa Shi <schspa@gmail.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, terrelln@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220408181523.92322-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408181523.92322-1-schspa@gmail.com>
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

On Sat, Apr 09, 2022 at 02:15:23AM +0800, Schspa Shi wrote:
> timer callback was running on bh, and there is no need to disable bh again.

Why do you think so? There was a specific fix fee13fe96529 ("btrfs:
correct zstd workspace manager lock to use spin_lock_bh()") that
actually added the _bh, so either you need to explain why exactly it's
not needed anymore and verify that the reported lockdep warning from the
fix does not happen.
