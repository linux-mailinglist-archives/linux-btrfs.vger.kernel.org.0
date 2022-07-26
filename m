Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDF1581BC4
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 23:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiGZVoa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 17:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiGZVo2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 17:44:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D982622537
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 14:44:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 95C6A20012;
        Tue, 26 Jul 2022 21:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658871866;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x8lDJb5EUJHwWsn81U0cOTBOu7BX8cGnAp/3IabPJtE=;
        b=i5mi30v5/29AYSmMt4eXOzugR5BhwHaj46ZbRuqrVerbIT+VeZTd04iOBOf4pJMzmTwvgO
        j8fVYGmL3MQRcCp/VjdAezuBTkItD0lHY3GLuoj6wvbux0dh+Q37H4tNI9Aq6MtotzG/CX
        KYJzWHFczvGjMmZfHbxLuD9kGE+zaew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658871866;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x8lDJb5EUJHwWsn81U0cOTBOu7BX8cGnAp/3IabPJtE=;
        b=6EHE72dggiEocSlx0yzdXAkzO2OEJDqU2aEY9RyfC9oGvsuMqW8ASVYbS5algo/0s1BaSH
        fs8VuV0eqFto6tBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 64AEC13322;
        Tue, 26 Jul 2022 21:44:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KwqBFzpg4GINWgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 26 Jul 2022 21:44:26 +0000
Date:   Tue, 26 Jul 2022 23:39:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 2/4] btrfs: make __btrfs_dump_space_info() output
 better formatted
Message-ID: <20220726213928.GP13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1658207325.git.wqu@suse.com>
 <dc40ddc78b7173d757065dcdde910bcf593d3a5c.1658207325.git.wqu@suse.com>
 <a5321725-1667-fd6f-2bfd-8ddb7b78d038@dorminy.me>
 <20220719213804.GT13489@twin.jikos.cz>
 <3cfc9569-ff22-c04d-f7d0-fea1396ba4b5@gmx.com>
 <20220726181353.GJ13489@twin.jikos.cz>
 <YuBUTX1i63o7Uo1O@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuBUTX1i63o7Uo1O@zen>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 26, 2022 at 01:53:33PM -0700, Boris Burkov wrote:
> > Yes we shold care about readability but kernel printk output lines can
> > be interleaved, single line is much easier to grep for and all the
> > values are from one event. The format where it's a series of "key=value"
> > is common and I think we're used to it from tracepoints too. There are
> > lines that do not put "=" between keys and values we could unify that
> > eventually.
> 
> Agreed that a long line is OK, and preferable to full on splitting.
> 
> What about making some btrfs printing macros that use KERN_CONT? I think
> that would do what Qu wants without splitting the lines or being bad for
> ratelimiting.

IIRC I've read some discussions about KERN_CONT suggesting not to use
it, I'll ask what's the status.
