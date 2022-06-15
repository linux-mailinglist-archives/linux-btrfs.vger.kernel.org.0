Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1678F54C9DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 15:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347421AbiFONcj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 09:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiFONcd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 09:32:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E9CE8D;
        Wed, 15 Jun 2022 06:32:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 53C1221BE5;
        Wed, 15 Jun 2022 13:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655299948;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S/tGbpsZILsyT+4JiLY1z0j09F2IF5Ha2IdUcm9f6Go=;
        b=lD+X+LL1FqMRYhO8fVEadn2UF+Vir0hKKoCW928nMS7EHwh7snjGaXa6UhPt8SgHK5BskQ
        RRo2rPMTef8Ub570KCOuFK33q+o8feTLLDeHtFblpDGvdjYA93tQidsPLmQXNeP2p/NaPj
        dUnwXEg6Fl40dO3NqANcNU9XEeDxfTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655299948;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S/tGbpsZILsyT+4JiLY1z0j09F2IF5Ha2IdUcm9f6Go=;
        b=8wjB1b8Fn492B9OYxkfzewXGMgZIKva33go1IP7d9FAgW78ZNSrmIiCp8nJ+QbdVC2wQ6j
        z4WwX4bBoj6ZV1Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 34E5713A35;
        Wed, 15 Jun 2022 13:32:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q+jlC2zfqWJ5JgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 15 Jun 2022 13:32:28 +0000
Date:   Wed, 15 Jun 2022 15:27:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Replace kmap() with kmap_local_page() in zstd.c
Message-ID: <20220615132754.GX20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220611135203.27992-1-fmdefrancesco@gmail.com>
 <1936552.usQuhbGJ8B@opensuse>
 <20220614142521.GN20633@twin.jikos.cz>
 <8952566.CDJkKcVGEf@opensuse>
 <YqjAVq+1PIpVIr0p@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YqjAVq+1PIpVIr0p@iweiny-desk3>
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

On Tue, Jun 14, 2022 at 10:07:34AM -0700, Ira Weiny wrote:
> On Tue, Jun 14, 2022 at 06:28:48PM +0200, Fabio M. De Francesco wrote:
> > On martedì 14 giugno 2022 16:25:21 CEST David Sterba wrote:
> > > On Tue, Jun 14, 2022 at 01:22:50AM +0200, Fabio M. De Francesco wrote:
> > > > On lunedì 13 giugno 2022 20:39:13 CEST David Sterba wrote:
> > > > > On Sat, Jun 11, 2022 at 03:52:03PM +0200, Fabio M. De Francesco 
> 
> > > > A better solution is changing the prototype of __kunmap_local(); I
> > > > suppose that Andrew won't object, but who knows?
> > > > 
> > > > (+Cc Andrew Morton).
> > > > 
> > > > I was waiting for your comments. At now I've done about 15 conversions 
> > > > across the kernel but it's the first time I had to pass a pointer to 
> > const 
> > > > void to kunmap_local(). Therefore, I was not sure if changing the API 
> > were 
> > > > better suited (however I have already discussed this with Ira).
> > > 
> > > IMHO it should be fixed in the API.
> > > 
> > I agree with you in full.
> > 
> > At the same time when you sent this email I submitted a patch to change 
> > kunmap_local() and kunmap_atomic().
> > 
> > After Andrew takes them I'll send v2 of this patch to zstd.c without those 
> > unnecessary casts.
> 
> David,
> 
> Would you be willing to take this through your tree as a pre-patch to the kmap
> changes in btrfs?
> 
> That would be easier for Fabio and probably you and Andrew in the long run.

Yes, no problem. I could probably send all the kmap conversions after
tests so it does not need to wait until the next cycle.
