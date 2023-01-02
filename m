Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F34F65B410
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jan 2023 16:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbjABPUP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Jan 2023 10:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbjABPUB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Jan 2023 10:20:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC9E9FEC
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Jan 2023 07:19:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6071A5C26F;
        Mon,  2 Jan 2023 15:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672672787;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CdSNnXElOsp7ZU0fj6tHASxp8ClZvJjOtzXlaXbKlMk=;
        b=wfqqWGXQmX3ujopmhc6t/EnJIECJEOCuQV6v8LEBVs/Fl6Ni/HqS14yWZ4N++/inYwT+aZ
        w2RytnZ6Q0+l1cPlGULFLsZMxl/9Im0NV4FVriMcUziNyFBMp/ogic5qXUCLQRbe8wD37L
        EeLu0Z7obIFcH1Nz24QYqVsUWqHdiBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672672787;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CdSNnXElOsp7ZU0fj6tHASxp8ClZvJjOtzXlaXbKlMk=;
        b=5XeHCFM8UYTkIW/NxB+sl42uYLS8kvGkESqZM5W2f9/dPS/2T89ICrQWhYwbfjFyIwOstP
        ANIIhBHKcG/An9DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3AB5A13427;
        Mon,  2 Jan 2023 15:19:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8SJjDRP2smPfZAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Jan 2023 15:19:47 +0000
Date:   Mon, 2 Jan 2023 16:14:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: Re: [PATCH 2/2] btrfs: fix the false alert on bad tree level
Message-ID: <20230102151417.GH11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1672190127.git.wqu@suse.com>
 <21f5e59776ba70104bea88c1c190e2b9bd17ca14.1672190127.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21f5e59776ba70104bea88c1c190e2b9bd17ca14.1672190127.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 29, 2022 at 07:32:24AM +0800, Qu Wenruo wrote:
> 
> By this, we should be able to pass the needed info for metadata endio
> verification, and fix the false alert.
> 
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Link: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

This is probably a copy&paste mistake, I've replaced it with the mail
thread link.
