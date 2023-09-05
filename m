Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF44179261E
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 18:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbjIEQCs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354577AbjIEMow (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 08:44:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810A91A8
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 05:44:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 45AC521A2B;
        Tue,  5 Sep 2023 12:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693917887;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pclcf5YMxqGqWtC+ZtOaxI8viwqNG/pCVU/u0+6GjkU=;
        b=oSN7j5Pu+wPPcCoWcTjG9/8yfHHDtP0g3Rnq7EON1As8Pj0IQjZVC30eaNJSM1KfT1b8EX
        ap4U7TJqD06Y74VMHQ8XhYrbkuU24mXT6LCn2H1S1nRLK4u5kNm384/Zss6a8157iVhKoZ
        UlIGxRQ6kBXYJGI3bNLylHTW4EfpNAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693917887;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pclcf5YMxqGqWtC+ZtOaxI8viwqNG/pCVU/u0+6GjkU=;
        b=2R9PIVKqu9w7W+tvBIh3jhmJPhCGdnLVZkc0JNNJUsQTp0OL9nUvp2+nKcfDmzNjgu4LkD
        xhuetI3tzTEvpAAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C03A13911;
        Tue,  5 Sep 2023 12:44:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yOSlCb8i92QCHgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 05 Sep 2023 12:44:47 +0000
Date:   Tue, 5 Sep 2023 14:38:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs: updates to error path for delayed dir
 index insertion failure
Message-ID: <20230905123807.GV14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1693209858.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1693209858.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 28, 2023 at 09:06:41AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Some updates to the error path for delayed dir index insertion failure,
> motivated by a recent syzbot report:
> 
>   https://lore.kernel.org/linux-btrfs/00000000000036e1290603e097e0@google.com/
> 
> Details in the changelogs.
> 
> v2: Fixed error path in patch 2 to release delayed item before unlocking
>     the delayed node. Added patch 3 to prevent such mistakes in the future.
> 
> Filipe Manana (3):
>   btrfs: improve error message after failure to add delayed dir index item
>   btrfs: remove BUG() after failure to insert delayed dir index item
>   btrfs: assert delayed node locked when removing delayed item

Added to misc-next, thanks.
