Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F002E54EA3E
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 21:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378325AbiFPThv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 15:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiFPThu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 15:37:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302482AE0C;
        Thu, 16 Jun 2022 12:37:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CB3D91FA18;
        Thu, 16 Jun 2022 19:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655408267;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=01cTbq+h2IymvC6NFpX7j8ot9JunhL9DOIgBhtE7F/E=;
        b=GDIZffdGZrX5o0krQOrtj4OUp10k/hQCM37Djc+JDSuvelmZUJ4YephnohAHdfGoipZRJZ
        rEqzvSaAuWrwG5xkmRTguREKS99v5d3LnaeEEm7nkdY7x49U3srTo9sN5WZRTKs6SE9OwP
        7bkOWe3qy5CioDKUdz4xA/6Dbr8O47E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655408267;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=01cTbq+h2IymvC6NFpX7j8ot9JunhL9DOIgBhtE7F/E=;
        b=pzsyo1OikFK8hUze6rvrAHBEQyH2R20Gx7YjN7C8sqWLkJLQPJDhfHQwXEj/jKhTZXOMsK
        H2aAQCsclwmiaaDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97F131344E;
        Thu, 16 Jun 2022 19:37:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cZr1I4uGq2LpFwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 16 Jun 2022 19:37:47 +0000
Date:   Thu, 16 Jun 2022 21:33:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ioannis Angelakopoulos <iangelak@fb.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix 64-bit divisions in btrfs_commit_stats_show()
 on 32-bit
Message-ID: <20220616193313.GE20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ioannis Angelakopoulos <iangelak@fb.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220616080814.1805417-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616080814.1805417-1-geert@linux-m68k.org>
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

On Thu, Jun 16, 2022 at 10:08:14AM +0200, Geert Uytterhoeven wrote:
> On 32-bit (e.g. m68k):
> 
>     ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!
> 
> Fix this by using div_u64() instead.
> 
> Reported-by: noreply@ellerman.id.au
> Fixes: e665ec2ab6e1ae36 ("btrfs: Expose the BTRFS commit stats through sysfs")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Folded to the patch, thanks.
