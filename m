Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B5A5F7B9D
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 18:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiJGQir (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 12:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiJGQiq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 12:38:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DC19DF8D
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 09:38:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9E66F21941;
        Fri,  7 Oct 2022 16:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665160724;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Aq2egrX0s1GBztIChTEthXt6ClA/5m8aAz0WhrZ2S04=;
        b=g4EnOBBeZi51lHrKyMqvZaNTSd+cOetoet9TQps8wgh2R2dDzsl+IV476QbziwhSGZI1+8
        uN6AJ9PvpEiVzUXRuQ7BvQsLVEcSAUjxHLhQ9A/ulqUsmK0Euza/9AvQsBxWFhejCzf6DG
        J3whR/fF3EGJ6g6DFfeV2GWakRtyzZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665160724;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Aq2egrX0s1GBztIChTEthXt6ClA/5m8aAz0WhrZ2S04=;
        b=5LkN0B1A4iivwesdpheNZWq/E2/zfvyizJRuYt0T0h7wA+2MvY1+BmqXlYw3Br5Gg0ALeN
        ydWU6u8pB66b5bAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C07713A3D;
        Fri,  7 Oct 2022 16:38:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RQHyGBRWQGNtSAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 07 Oct 2022 16:38:44 +0000
Date:   Fri, 7 Oct 2022 18:38:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Hao Peng <flyingpenghao@gmail.com>
Cc:     "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: adjust error jump position
Message-ID: <20221007163841.GT13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAPm50aK090Ebkg4aVqzBxaN1W-=_z9ZU7KxppmURhWeczJb2Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPm50aK090Ebkg4aVqzBxaN1W-=_z9ZU7KxppmURhWeczJb2Ag@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 23, 2022 at 10:58:12PM +0800, Hao Peng wrote:
> From: Peng Hao <flyingpeng@tencent.com>
> 
> Since 'em' has been set to NULL, you can jump directly to out_err.
> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>

So this patch also does not apply and git am complains that the patch is
corrupted. Can you please you're generating the patches correctly?
