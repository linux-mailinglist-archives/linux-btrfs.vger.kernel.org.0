Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19894E5759
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 18:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343505AbiCWRXZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 13:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238674AbiCWRXZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 13:23:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C7271ECF
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 10:21:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 50CBB210F3;
        Wed, 23 Mar 2022 17:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648056114;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dg/aBK6efhjZxiPYzgXddnq+PkplkkjvSSnMfqO25Nk=;
        b=3KJrBtYbbQ1Wwz8UXuTrjEE1IY6+GnyCAGoYUdWLXkiPauA7rJwnumZNoLFCymp8XD6EAb
        i0IfUFaZqXj2d2Yw7upFhHugvNnsXyHBiTVROkQsgo/x2X8tVFKswy/JlE2uDfXS394ll2
        mSKLdsY4uyjxOKVVbaxMvavZ29yfZ8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648056114;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dg/aBK6efhjZxiPYzgXddnq+PkplkkjvSSnMfqO25Nk=;
        b=4bClNwGbrEVtwwcRXXa+dsXNgzU70ZPxgsuNeStmU0TBwFhHL6aqAVthyTrd+qLFtwCl/T
        BI7PJ4G/SJl4u0Cg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 47DAAA3B83;
        Wed, 23 Mar 2022 17:21:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0CD51DA7FB; Wed, 23 Mar 2022 18:18:00 +0100 (CET)
Date:   Wed, 23 Mar 2022 18:17:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: add check and repair ability for super
 num devices mismatch
Message-ID: <20220323171759.GB2237@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1646009185.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1646009185.git.wqu@suse.com>
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

On Mon, Feb 28, 2022 at 08:50:06AM +0800, Qu Wenruo wrote:
> The patchset can be fetched from github:
> https://github.com/adam900710/btrfs-progs/tree/super_num_devs
> 
> The 2nd patch contains a compressed raw image, thus it may be a little
> too large for the mail list.

The compressed size is 22K, that's fine. I've recompressed it with 'xz
--best -e' and it shaved a few hundred bytes but that was just out of
curiosity.
