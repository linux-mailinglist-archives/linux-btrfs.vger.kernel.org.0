Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D736D8B01
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Apr 2023 01:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjDEXPF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 19:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjDEXPD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 19:15:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE626A45
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 16:14:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0AE9E227FF;
        Wed,  5 Apr 2023 23:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680736498;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GZI2GdJBr5+JmslL6wZ2VTbNjyxOYgWR87Hjx4p4l9U=;
        b=WpT2eVVSsPZ6Z3wDlzrzBzQ2L5ZKRtx/XZ92s51ig7ozd7oMcNBv1W0FBTJA3fF3mS3azW
        xS70KRuVmLnWWeYlSfvMpr3xpaTLw6P5ynACrXJoo5s+uovurOf+cmKuBgU8RsrIpOrL1M
        tgBnr6DMaln/zm4wxrVTyHhW10Hjrgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680736498;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GZI2GdJBr5+JmslL6wZ2VTbNjyxOYgWR87Hjx4p4l9U=;
        b=vrDCTNQk6dqaZwnMqgI6U6YKtrxRs55wYlJtefYtZe2GYgves1VDfquL83hiEKD4IBW9mk
        3AZmbWYjYX+AkcCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D40B313A31;
        Wed,  5 Apr 2023 23:14:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id edvHMvEALmRZeAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 05 Apr 2023 23:14:57 +0000
Date:   Thu, 6 Apr 2023 01:14:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: don't offload CRCs generation to helpers if it is fast
Message-ID: <20230405231455.GO19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230329001308.1275299-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329001308.1275299-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 29, 2023 at 09:13:04AM +0900, Christoph Hellwig wrote:
> Hi all,
> 
> based on various observations from me and Chris, we really should never
> offload CRCs generation to helpers if it is hardware accelerated.
> 
> This series implements that and also tidies up various lose ends around
> that.

I've picked patch 1 as it's a standalone fix and should go to stable
trees, the rest is in for-next and still queued for 6.4.
