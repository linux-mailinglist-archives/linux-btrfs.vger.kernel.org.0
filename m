Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5DC59A6F4
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Aug 2022 22:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351530AbiHSUPU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Aug 2022 16:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350921AbiHSUPK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Aug 2022 16:15:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AC3106528
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Aug 2022 13:15:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0B2DD20092;
        Fri, 19 Aug 2022 20:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660940099;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sjlsiXuwjnlSm+CqCv5kYXZEDGs4UOh8C23txiattUo=;
        b=TCP/djLDIBqEWnfTozr6+xwhxAD0auW0M5pLGYmGZYOeuvMFRcxpnfFg/PoNnEA2Q6BAWq
        0oFh14vQzwDMSJOLAjudeRY5Nnl8O7Au2juSjUVyXt+/ilwMS6Puuv7baNzSr7sykyTZin
        EqPFYjzCagegWy4J71jCoeTRyCQvIME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660940099;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sjlsiXuwjnlSm+CqCv5kYXZEDGs4UOh8C23txiattUo=;
        b=zjH0WPPkB/3YMNhae8jcuUbcoyVJV+d2b3Hq0/q/wlG4NOTmi5ielgLu+V4tluj3CzySnu
        yuwPvUgE3kQiQbDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D264C13AE9;
        Fri, 19 Aug 2022 20:14:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J9N+MkLv/2JHZgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 19 Aug 2022 20:14:58 +0000
Date:   Fri, 19 Aug 2022 22:09:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: take the correct ctl lock when removing free
 space cache
Message-ID: <20220819200946.GR13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <409ff4f5a9365bec56c6a6dc77190b7a3b3645e6.1660938272.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409ff4f5a9365bec56c6a6dc77190b7a3b3645e6.1660938272.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 19, 2022 at 03:44:41PM -0400, Josef Bacik wrote:
> This is a fixup for
> 
> btrfs: call __btrfs_remove_free_space_cache_locked on cache load failure
> 
> I was taking the wrong ctl lock, this can be folded into that patch.

Folded and for-next updated.
