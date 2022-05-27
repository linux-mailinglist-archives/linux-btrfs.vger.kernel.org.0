Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3DD5364A0
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 17:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352891AbiE0PZC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 11:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353600AbiE0PZA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 11:25:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B0358E46
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 08:24:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F23611F855;
        Fri, 27 May 2022 15:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653665098;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6JEyenUTHOWgOrA/B7V8E7fydq4GD5TxdBpz/hnTmh4=;
        b=gW5YimPdIwxTjC6nON+MjR547F76eMY4uHcxHdpFEu+PhVYvGmh0tVAYzcS6nSLdS2GWJ+
        Cz8A+fRpybln8GLs8lbnf46V8m9XH/O8RAAXjbxig9+e/0WdxJ6K1eEu1ltswXDvTwXenj
        W4kBsyvS8MymAG46srfr/3CgrKhENOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653665098;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6JEyenUTHOWgOrA/B7V8E7fydq4GD5TxdBpz/hnTmh4=;
        b=6CPkEBDNe6GilziXkYPm9at2QeJkXe1IPsgOBbIjYMGbrGlksB2bej6K7RkHe3AwsEOCH7
        xqpIStTs+SMl8uDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF7B613A84;
        Fri, 27 May 2022 15:24:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id URrrLUntkGLffAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 27 May 2022 15:24:57 +0000
Date:   Fri, 27 May 2022 17:20:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: misc btrfs cleanups
Message-ID: <20220527152034.GF20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220522114754.173685-1-hch@lst.de>
 <20220525202012.GF22722@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525202012.GF22722@twin.jikos.cz>
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

On Wed, May 25, 2022 at 10:20:12PM +0200, David Sterba wrote:
> On Sun, May 22, 2022 at 01:47:46PM +0200, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series has a bunch of random cleanups and factored out helpers split
> > from the read repair series.
> 
> Thanks, I went through it, did some coding style fixups. Now it's under
> tests and I'll move it to misc-next after that so the repair changes can
> be based on that.

Moved to misc-next.
