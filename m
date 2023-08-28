Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767A778B4E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 17:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjH1Pzb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 11:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjH1PzY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 11:55:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AAB1A5
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 08:55:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 369682189D;
        Mon, 28 Aug 2023 15:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693238116;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BlvVkm7naqqPqYOnIXJkMoUcG0IvCxUZYRmzUY5uBCc=;
        b=le/tBACYGI4xTZ4RFVNerCPLySqh8ce730axr8R6iZsAtGksl5/fIferqR6Y4tqqwO5k2/
        b+piMA+POMeyzBMWoAmGHkz0z3fsWzWTu8o/Ty/lbEE6PJBk/Kk4i5W8O5FiRwIMTCwHCg
        D5a3/dGx4aeKdveuEgsXDh57oZxSIec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693238116;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BlvVkm7naqqPqYOnIXJkMoUcG0IvCxUZYRmzUY5uBCc=;
        b=8Q5+xQUxI4Z7wHT8dMO0oL7LUKb2oLrZqAWQkGFoY43dnBgFDPN9NQD6mLLWjDC+SmqkT1
        ki56S3KPLtFGs2Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1655913A11;
        Mon, 28 Aug 2023 15:55:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dMC8BGTD7GROEgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 28 Aug 2023 15:55:16 +0000
Date:   Mon, 28 Aug 2023 17:48:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: tests: misc-test prefix error messages
Message-ID: <20230828154840.GF14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <baf62c9b8a2fb1410a80dbf023b14261e02692d2.1692861044.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baf62c9b8a2fb1410a80dbf023b14261e02692d2.1692861044.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 24, 2023 at 03:14:12PM +0800, Anand Jain wrote:
> Add appropriate prefix to the error messages for easier traceback.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to devel with updated changelog, thanks.
