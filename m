Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C5859C91A
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 21:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbiHVTlc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 15:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237596AbiHVTlb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 15:41:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BB148CB3
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 12:41:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1215A37270;
        Mon, 22 Aug 2022 19:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661197289;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rDqWayvFq3VV8AH9JNA2Ycz/su7tJoUWcotVgE+5QFk=;
        b=zPJfDF4lZeT9MM+qqT9kIM8rwUwCXLifBTKPiTsJ/ZG8daQwQBB3r/w253fwhRbgPp8uxx
        gQGW/uiZmg0dIHFndqYpjcZxJT8rgh5cBisdpxVVU+9AA/F5eZRlrNJ3v/JctpF8Lmx2tj
        GFIOo2Z2SmIOoX2ksXlZq25O0kEm28U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661197289;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rDqWayvFq3VV8AH9JNA2Ycz/su7tJoUWcotVgE+5QFk=;
        b=pkCzidsYehWoAwhoKlgb3rTbJo4vqcSLmN7WZnY2XqW0WZ0F9TzQUyUhY3LYHzmkEk8v5s
        cUXGClqGo6fF2QDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6D341332D;
        Mon, 22 Aug 2022 19:41:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IB9nN+jbA2PCcAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 22 Aug 2022 19:41:28 +0000
Date:   Mon, 22 Aug 2022 21:36:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] fix issues during suspended replace operation
Message-ID: <20220822193615.GE13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1660299977.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1660299977.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 12, 2022 at 06:32:17PM +0800, Anand Jain wrote:
> While trying to reproduce the issue reported in the ML. Found few
> issues as in the individual independent patches below.
> 
> Anand Jain (2):
>   btrfs: fix assert during replace-cancel of suspended replace-operation
>   btrfs: add info when mount fails due to stale replace target

Added to misc-next, thanks.
