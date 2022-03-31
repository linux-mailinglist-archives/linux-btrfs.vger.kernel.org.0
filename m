Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD2F4EE045
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Mar 2022 20:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbiCaSUl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Mar 2022 14:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiCaSUj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Mar 2022 14:20:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2522DDE
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Mar 2022 11:18:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DA827210EB;
        Thu, 31 Mar 2022 18:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648750726;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ttTyFyXEku3I0kO/s4gIMdAQtm5jsfW8C8DA/vluAcI=;
        b=ltyZUkadsysBS9e0daY2f82OrHUOAHEJcJYrVZbDlUFBMfGvYyVXr8oLta+c05GGR/DRgA
        U45blTi+0JsE1b4yx8VQZYRfQcDrAVwnFAHe9OXSP2S5rYTR0Yu45cVZS5TXeARg7FbCYS
        SD7R3NNxCpSHvM2nejq+4tmwGe5DW9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648750726;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ttTyFyXEku3I0kO/s4gIMdAQtm5jsfW8C8DA/vluAcI=;
        b=t4ubt9Z4nk9dgTTd0L4JY3DB5eAtk7dUSsZgsIZa6ewo06vVuu/2BsAUt76nfnO4jAaE/P
        fBWDaBAAdus4MDDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D17F4A3B83;
        Thu, 31 Mar 2022 18:18:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1E593DA7F3; Thu, 31 Mar 2022 20:14:47 +0200 (CEST)
Date:   Thu, 31 Mar 2022 20:14:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: some refactor and cleanup for NOCOW write
 paths
Message-ID: <20220331181447.GG15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1648650280.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1648650280.git.fdmanana@suse.com>
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

On Wed, Mar 30, 2022 at 03:31:05PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This refactors some duplicated NOCOW checks into a single helper function,
> plus it removes some no longer needed logic. This came out some in progress
> work on the NOCOW paths, but has it's fairly indepedent of that work, it
> is being sent out in a separate patchset.
> 
> Filipe Manana (2):
>   btrfs: move common NOCOW checks against a file extent into a helper
>   btrfs: do not test for free space inode during NOCOW check against
>     file extent

Added to misc-next, thanks.
