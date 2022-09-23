Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EFC5E78D5
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Sep 2022 12:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiIWK4K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Sep 2022 06:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiIWKz2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Sep 2022 06:55:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6439DE6DE2
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 03:53:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EDC6F1F947;
        Fri, 23 Sep 2022 10:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663930419;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kwZ7eLB9qF7CN+G0fybd/hp+0OyBIBx1li+GpYCiVJo=;
        b=YSg/Hz3nePK1LVwm/+pf0BGcpjfIFujlqi6IwQjlMDAwwGFFLrUfoaQgb8rSJLfKGbl9mz
        wAItx9oXhjs7fGTh8QXojf4zUbolj/Lbe1lkjtlSZ0ZnL0Yh+35eOBqzfxgol8KQTEExzv
        8lixtuRy1p9As2T+1Egqc+LT6OWqoE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663930419;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kwZ7eLB9qF7CN+G0fybd/hp+0OyBIBx1li+GpYCiVJo=;
        b=SaDcegeAY3b5erZCrqqeVw7yNDTKIeMJCQE0zfmA8y3iJyesAPpEO4ZBdZapP/kNmlGFaV
        UTPmlj79vOJyRPDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D20AA13AA5;
        Fri, 23 Sep 2022 10:53:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vUFXMjOQLWMySgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 23 Sep 2022 10:53:39 +0000
Date:   Fri, 23 Sep 2022 12:48:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fixup btrfs: relax block-group-tree feature dependency
 checks
Message-ID: <20220923104807.GR32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20220923113120.DC30.409509F4@e16-tech.com>
 <20220923072607.24584-1-wangyugui@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923072607.24584-1-wangyugui@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 23, 2022 at 03:26:07PM +0800, Wang Yugui wrote:
> btrfs misc-next broken fstest btrfs/056.
> 
> dmesg output of fstests btrfs/056 failure.
> [  658.119910] BTRFS error (device dm-0): cannot replay dirty log with unsupported compat_ro features (0x3), try rescue=nologreplay
> 
> there are 2 problems.
> 1) this error should not happen.
> 2) the message 'unsupported compat_ro features (0xXX)' should only output the unsupported part of compat_ro.
> 
> so fixup a4c79f3f1c2a (btrfs: relax block-group-tree feature dependency checks).
> 
> please fold it in because the orig patch is still in misc-next.

Thank you, folded to the patch.
