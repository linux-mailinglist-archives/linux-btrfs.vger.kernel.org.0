Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FB64BE4E1
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Feb 2022 18:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380091AbiBUQTj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Feb 2022 11:19:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377666AbiBUQTi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Feb 2022 11:19:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235A919C21
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Feb 2022 08:19:15 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CFB1221101;
        Mon, 21 Feb 2022 16:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645460353;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JA4841oAk+ffXieXOXzVXiz+XyxTOf4VyPyqMKdPyds=;
        b=stRi7PfeMiCMjEE/fgNRR4tGLPDh6UeP2RPqfk1L1Kh8bCZshSMAGK1yMsqmfnu/BwDTbn
        uEDfxrAgF2t40agaHq9UMHCwv5lFa33W36srM6wtaSfNY1ZYQqHveVyaO+A1yUSOQ4izM3
        Ybo3Fia6W7kPYGU9tvDmzt9KwIWC7YE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645460353;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JA4841oAk+ffXieXOXzVXiz+XyxTOf4VyPyqMKdPyds=;
        b=zOh1h0RB6RoH/buljUCmInxI8+Je6/tvsLq+BvojE4Erh6XaiAAatGbw3LABYnVS5y/PNY
        G14MnOdPn3H4BaAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C9200A3B87;
        Mon, 21 Feb 2022 16:19:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 89976DA823; Mon, 21 Feb 2022 17:15:26 +0100 (CET)
Date:   Mon, 21 Feb 2022 17:15:26 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7] btrfs: a fix for fsync and a few improvements to the
 full fsync path
Message-ID: <20220221161526.GG12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1645098951.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1645098951.git.fdmanana@suse.com>
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

On Thu, Feb 17, 2022 at 12:12:01PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This fixes a bug (first patch) with preallocated extents beyond eof being
> lost after a full fsync and a power failure. The rest is mostly some
> improvements to the full fsync code path (less IO, use less memory for
> logging checksums, etc), and silence smatch about a possible dereference
> of an uninitialized pointer. More details in the changelogs.
> 
> Filipe Manana (7):
>   btrfs: fix lost prealloc extents beyond eof after full fsync
>   btrfs: stop copying old file extents when doing a full fsync
>   btrfs: hold on to less memory when logging checksums during full fsync
>   btrfs: voluntarily relinquish cpu when doing a full fsync
>   btrfs: reset last_reflink_trans after fsyncing inode
>   btrfs: fix unexpected error path when reflinking an inline extent
>   btrfs: deal with unexpected extent type during reflinking

Added to misc-next, thanks.
