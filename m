Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D36779E9F7
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 15:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241002AbjIMNps (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 09:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbjIMNpr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 09:45:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE4919B1
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Sep 2023 06:45:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 46E061F390;
        Wed, 13 Sep 2023 13:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694612742;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PMoS5SoDCeo+ASCh6LrPWo6hiKFsnrQx7XCek9g9fQY=;
        b=gjh5URJWEnygdfnM8NgklTrpKBhkxrSaiWTkASb6KEw0d7iin+2CnxaAsMHXBTv4Qmh+3d
        ACSrsFRyy/PXFA7VgvAx48vCtoRK3X8XpBfC+KH80SWb+htMsRlMroaVla9yilBpf72A9s
        ynFepsfM+FiptpEt2kv6bkfut08syzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694612742;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PMoS5SoDCeo+ASCh6LrPWo6hiKFsnrQx7XCek9g9fQY=;
        b=u8Ee6G96EuT8mhhJXbr6f4V6igzDEfDdUJMi7vByHqnhiE087+CAS2u+SVvmiMJPbz5vVA
        QobO3RtXaQXUEXAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F15E13582;
        Wed, 13 Sep 2023 13:45:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7geECga9AWVpTgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 13 Sep 2023 13:45:42 +0000
Date:   Wed, 13 Sep 2023 15:45:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: some updates to btrfs_mark_buffer_dirty()
Message-ID: <20230913134540.GJ20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1694519543.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694519543.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 12, 2023 at 01:04:28PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A few updates to btrfs_mark_buffer_dirty(), with the most important one
> to not allow a transaction to commit when we know there's some corruption
> due to marking an extent buffer as dirty when its generation does not
> match the current transaction's generation. More details on the change
> logs of each patch.
> 
> Filipe Manana (3):
>   btrfs: abort transaction on generation mismatch when marking eb as dirty
>   btrfs: use btrfs_crit at btrfs_mark_buffer_dirty()
>   btrfs: mark transaction id check as unlikely at btrfs_mark_buffer_dirty()

Added to misc-next, thanks.
