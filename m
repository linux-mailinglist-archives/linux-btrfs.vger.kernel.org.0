Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1265D5B5E48
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 18:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiILQbh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 12:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiILQbh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 12:31:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F375F1D0C6
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 09:31:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 80FA9339B6;
        Mon, 12 Sep 2022 16:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663000294;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dVvpELlcF5Q8U0Q+JsEEPEHXN1r8fI5Drp9e72DfRX8=;
        b=tcjWddiyhM23Z5zWdCzC5TtbcgWQWCeGb9SimvAyyPmCb/IdgMWq/J9hKDfuXztf26GyrJ
        KI9l5FQxl2pJqNZtTVCs8cIpCDngH8gpA32yqy1/gKnlEvpCGMEEqjbnvs9bhUeKYJ4/Ha
        78xwdRosBWAN2mbUHa82qN3CRtHJzDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663000294;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dVvpELlcF5Q8U0Q+JsEEPEHXN1r8fI5Drp9e72DfRX8=;
        b=ROoTUsPzIqWGGzFCd/OkOiWygAfa7DPG9txw1/QImoXm+8IThd6FOuce+BRjUpRO2t+VmI
        CdTs1BMSi2pVBYAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66094139C8;
        Mon, 12 Sep 2022 16:31:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YrrwF+ZeH2PidwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 12 Sep 2022 16:31:34 +0000
Date:   Mon, 12 Sep 2022 18:26:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE mismatch in
 kernel/btrfs-devel and btrfs-progs
Message-ID: <20220912162608.GI32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20220911233812.FFEF.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911233812.FFEF.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 11, 2022 at 11:38:15PM +0800, Wang Yugui wrote:
> Hi,
> 
> BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE mismatch in kernel/btrfs-devel and btrfs-progs	
> 
> kernel/btrfs-devel	misc-next
> include/uapi/linux/btrfs.h:297:#define BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE (1ULL << 3)
> 
> btrfs-progs
> ./kernel-shared/ctree.h:497:#define BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE    (1ULL << 5)
> 
> we need fix the version of btrfs-progs.

I forgot to update progs when I changed it in kernel, will be fixed,
thanks.
