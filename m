Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A41659ED3E
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 22:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbiHWUS7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 16:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiHWUSn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 16:18:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BAC5F72
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 12:43:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1AB5B1F8AC;
        Tue, 23 Aug 2022 19:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661283801;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rJAxKXA5uR7+oHWPqPcCTh0qszdOzUZ+wYwAdZMfUFo=;
        b=A8EpMsK+HLMtxlzwWtpCmk9O1ePGaxj9u8IA8Avlvr/X6YMFjJaYReOOWmIQ9/Oe2AltnB
        f4oCXouwxgK04otkDGeR+fY/DiAEcKYpdooMqH1cdEnrqFoOqW9QiJkAeisIz0cGJ6xagf
        5fK1XImp2/v9e0gteu+A0Kp/xW9tPIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661283801;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rJAxKXA5uR7+oHWPqPcCTh0qszdOzUZ+wYwAdZMfUFo=;
        b=t0QBGFO3k0+Ks9lGryjMMYDJxn+/ch7oK4CzVPGHs9rJFOl8AFl9AZ74YybCeeP+si8CDY
        2PmUhsSC0UBiyTAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED2B113A89;
        Tue, 23 Aug 2022 19:43:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b9a5ONgtBWNpdgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 23 Aug 2022 19:43:20 +0000
Date:   Tue, 23 Aug 2022 21:38:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: xfstests is rather unhappy on current for-next
Message-ID: <20220823193806.GL13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <YwT+GsTRLUwXKJ2w@infradead.org>
 <YwUEWy9ixBdEztCK@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwUEWy9ixBdEztCK@infradead.org>
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

On Tue, Aug 23, 2022 at 09:46:19AM -0700, Christoph Hellwig wrote:
> On Tue, Aug 23, 2022 at 09:19:38AM -0700, Christoph Hellwig wrote:
> > default options on x86-64 with a five-device spare pool gets
> > unhappy in the kobject code when running btrfs/017, and the
> > xfstest run then hangs:
> 
> I've bisect this to:
> 
> [80e96a54dd6993d6de0dc81285c02c709487808a] btrfs: sysfs: introduce
> qgroup global attribute groups

Thanks, patchset removed from for-next.
