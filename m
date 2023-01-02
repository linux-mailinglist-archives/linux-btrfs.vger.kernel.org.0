Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1862465B408
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jan 2023 16:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjABPTG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Jan 2023 10:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjABPTC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Jan 2023 10:19:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9381ED
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Jan 2023 07:19:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 96E1C5C25D;
        Mon,  2 Jan 2023 15:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672672740;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RWyDI7cpAD1q3zsr5HkONHix5Au/wP+kn2Fah/n52zA=;
        b=yxE+QvBF6sYXxUT428Byq9uGlpfWtxNFgtfMFgHUzbWyI/RWIktgIsJxwQmD6OMkccjQ6q
        fRfhKt/ABkS7bYGvpav9nKa4UMTvBlZz/fyBRfHTcTu97tPOYte97ByY59MoS901Lj1JuJ
        52kDFPqHzzp95m0UBbVBlQJ00+avJCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672672740;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RWyDI7cpAD1q3zsr5HkONHix5Au/wP+kn2Fah/n52zA=;
        b=eQAUD4QzmWN6OzSUE9VWqX1UIxbIwIftf9AWOgWYLNTET71XfPZ14YLfhJ6MGsKZkdUTAG
        1XzORfd0NE76BICA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DEA713427;
        Mon,  2 Jan 2023 15:19:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id olNNGeT1smN/ZAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Jan 2023 15:19:00 +0000
Date:   Mon, 2 Jan 2023 16:13:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: fixes for commit 947a629988f1 ("btrfs: move
 tree block parentness check into validate_extent_buffer()")
Message-ID: <20230102151330.GG11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1672190127.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1672190127.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 29, 2022 at 07:32:22AM +0800, Qu Wenruo wrote:
> There is a regression report from Mikhail that his btrfs RAID0 fs
> randomly flips to RO after commit 947a629988f1.
> 
> It turns out that, the offending commit can not handle tree blocks
> crossing stripe boundary.
> 
> Although tree blocks crossing stripe boundary is not an ideal situation,
> we should still be able to correctly handle it.
> 
> This patchset firstly adds the missing level mismatch error message,
> then fix the offending commit.
> 
> Qu Wenruo (2):
>   btrfs: add error message for metadata level mismatch
>   btrfs: fix the false alert on bad tree level

Thanks for tracking it down, patches added to misc-next.
