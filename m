Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20CD6F4821
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 18:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjEBQRi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 12:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbjEBQRh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 12:17:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9360610F;
        Tue,  2 May 2023 09:17:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4DB2C1F8AA;
        Tue,  2 May 2023 16:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683044254;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g6KTKbqX3sWDdrjAvv9lOrddrK/sGrPHCnlc+jGiqxY=;
        b=kqcZZK4XpCd6CTzx46jJlu9OIlpAp9/VoiSiuEzUevI5m8CBFOkl8kSg+zhcXAQ8nJ2u8h
        nWheARBHHHHB641X8exLeM0ujrNts5m6BTRlsrf8pQh4jaMFhZYF2KmlB45wj98I6jjPU0
        iPmBeNegHvainHdcO5+AgNLCAS+4aHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683044254;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g6KTKbqX3sWDdrjAvv9lOrddrK/sGrPHCnlc+jGiqxY=;
        b=7rn91GjvtQ8TuFcV2RpSUA+ktOZZjbnJXk8tgq247OE0rN6MrQIfOhxlbuuevkBeyvoc4K
        pdUDJePeXrFGOZDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1417B139C3;
        Tue,  2 May 2023 16:17:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 51/bA543UWQfPAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 May 2023 16:17:34 +0000
Date:   Tue, 2 May 2023 18:11:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nur Hussein <hussein@unixcat.org>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Avoid potential integer overflow when
 left-shifting 32-bit int
Message-ID: <20230502161138.GK8111@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230406192406.2300379-1-hussein@unixcat.org>
 <353b44f3-fb95-ac43-53ba-0d3b45fff574@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <353b44f3-fb95-ac43-53ba-0d3b45fff574@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 07, 2023 at 08:35:40AM +0800, Qu Wenruo wrote:
> On 2023/4/7 03:24, Nur Hussein wrote:
> > In scrub_stripe(), the 32-bit signed value returned by the
> > nr_data_stripes(map) function call should be cast to u64
> > before being shifted left by BTRFS_STRIPE_LEN_SHIFT (16),
> > as a cautionary measure to avoid potential overflows. We
> > then assign it to a u64 value anyway, so a cast before a
> > shift seems prudent.
> 
> I'd say it's a little overkilled.
> 
> For nr_data_stripes(), it's at most hundreds of stripes (which is 
> already insane).
> Even with 16 bits left shift, we need to get 2 ** 16 stripes to overflow 
> 32bits.

I don't like adding casts unless really necessary. That the values won't
overflow is what we know because there are other constraints.

In this case I'd rather switch the return type of nr_data_stripes to u32
as the return value from the helper is used for shifts by
BTRFS_STRIPE_LEN_SHIFT in several places.

For the struct map_lookup we should use u32 for all values that simply
count something and there's no semantic value for -1 (like uninitialzed
or invalid). I did a quick grep and the values are assigned from
unsigned types in most if not all cases.
