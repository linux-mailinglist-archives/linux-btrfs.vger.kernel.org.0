Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDC179F04F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 19:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjIMRTk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 13:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjIMRTk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 13:19:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E363698
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Sep 2023 10:19:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A0309218EB;
        Wed, 13 Sep 2023 17:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694625574;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qMuZdyVwaXbTQVEBlbMhop1VsNdTOlSRWW/rt8fCqW0=;
        b=Afd0vcUOCgm+zNyK869M4dr8C1dp0wx7G27STGrxeI0dRozuRL7DcX1M7w06ZbsEmqmu4G
        AqY3z4ZOnm1SDZJh85+Oy3b1blN9KOkwdcFGzwCwdUwa+iZfNUBW5xgerhysx0XlJLwoql
        mPQZc1G5UY9q1FeIPeapTwTRLHrFHXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694625574;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qMuZdyVwaXbTQVEBlbMhop1VsNdTOlSRWW/rt8fCqW0=;
        b=bDp1cV2aP/yR/AB3FyeuaALGMtpV5/NKyBK58qHxhA5eaS9mzOWmoOtylB1psFJ/FVgPmx
        Jbl9UUMGK/ZzX7Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 806C113440;
        Wed, 13 Sep 2023 17:19:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PMWSHibvAWW5NgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 13 Sep 2023 17:19:34 +0000
Date:   Wed, 13 Sep 2023 19:19:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Lee Trager <lee@trager.us>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Allow online resize to use "min" shortcut
Message-ID: <20230913171932.GV20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230825010542.4158944-1-lee@trager.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825010542.4158944-1-lee@trager.us>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 24, 2023 at 06:05:42PM -0700, Lee Trager wrote:
> btrfs already supports online resize and has a "max" shortcut to expand to
> all available space on the disk. This creates a "min" shortcut which shrinks
> the filesystem to allocated space.
> Signed-off-by: Lee Trager <lee@trager.us>

Added to misc-next, thanks.
