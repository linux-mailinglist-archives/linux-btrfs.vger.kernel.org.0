Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AD3629B58
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 15:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbiKOOAD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 09:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiKOOAC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 09:00:02 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506A627B33
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 05:59:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DC43722CE6;
        Tue, 15 Nov 2022 13:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668520794;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MH5+ackDOV1BauPfVoTxNgW/ch3j8cBlrSiwFCwinBI=;
        b=KpaDqU16pEEefvSQXQ8YXEkspD/py275DzYUK6R+yrejzZELsfLKnMykr4djkrGO8LbXXz
        OKcZScRINwtiHxOVikQmZ+lsXJVo+f6jiZtcqNYdO8c1cRLmHS01pTM+MQ29mQmjMw7R9J
        sr9+oy6PKBoJ1s1uXvnQwwEN7prTAGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668520794;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MH5+ackDOV1BauPfVoTxNgW/ch3j8cBlrSiwFCwinBI=;
        b=cf4YVPkyHokut40J4mAFJkKG09EwghUuryyyGeogHxiZ8x/f2uYF2A/qaU/mjq/8x1M4A9
        VfHl4rSHFxBmW4Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A19EE13273;
        Tue, 15 Nov 2022 13:59:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NSlvJlqbc2NkcgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 15 Nov 2022 13:59:54 +0000
Date:   Tue, 15 Nov 2022 14:59:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        naohiro.aota@wdc.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: fix missing endianess conversion in
 sb_write_pointer
Message-ID: <20221115135928.GI5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221115093944.1625659-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115093944.1625659-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 10:39:44AM +0100, Christoph Hellwig wrote:
> generation is an on-disk __le64 value, so use btrfs_super_generation to
> convert it to host endian before comparing it.
> 
> Fixes: 12659251ca5d ("btrfs: implement log-structured superblock for ZONED mode")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Added to misc-next, thanks.
