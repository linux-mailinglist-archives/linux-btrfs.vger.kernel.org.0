Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F904BBA8A
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 15:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbiBROVH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 09:21:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiBROVG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 09:21:06 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BF5D1D6A
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 06:20:49 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 03EEE219A8;
        Fri, 18 Feb 2022 14:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645194048;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S5UXMYM+qW3iOnvMHCpI93j4VqBsvURVbux0JHKZUz0=;
        b=hq8b51zSANOCi3RQmBwWB/7uEioKthMWTtPTghay9csqSrLbhmrJuUOVbYR/Qiuh6+X0Un
        Eqsb6PELxihNHfmwzo6iAVEIXGXsYEdcmMC1x7U1qWDUWZK5ulTNJ4vZ4QOTOibjLfhzXd
        HtYjD4+Ny++cnY+LJ3YWm6VTmZNZXOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645194048;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S5UXMYM+qW3iOnvMHCpI93j4VqBsvURVbux0JHKZUz0=;
        b=FZHytzWXP4L7R17qT88UkO6pVLrGQIAFQJ5TfGhjbEU6K+HJBuQf5+bIebXqd7jGquLWyX
        K/m+lsddpcZ+3NDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F23ECA3B8F;
        Fri, 18 Feb 2022 14:20:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5F4E6DA829; Fri, 18 Feb 2022 15:17:02 +0100 (CET)
Date:   Fri, 18 Feb 2022 15:17:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anthony Iliopoulos <ailiop@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: add zoned_profile_supported function stub
Message-ID: <20220218141702.GU12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anthony Iliopoulos <ailiop@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220215171213.5173-1-ailiop@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215171213.5173-1-ailiop@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 15, 2022 at 06:12:12PM +0100, Anthony Iliopoulos wrote:
> The zoned_profile_supported function is only defined if BTRFS_ZONED is
> defined, and thus compilation breaks when progs are configured without
> zoned block device support. Add the stub function so that progs can be
> compiled without zoned support.
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>

Thanks, this has been fixed in 5.16.2.
