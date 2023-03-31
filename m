Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC626D26C4
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Mar 2023 19:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjCaRhl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Mar 2023 13:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjCaRhk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Mar 2023 13:37:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3521EA1F
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Mar 2023 10:37:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 107B41FE2E;
        Fri, 31 Mar 2023 17:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680284258;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lfL6HgQGS+xxA5Eltd5A7866gUInB6pLTF4Cl/2o2ms=;
        b=Pkq02AV6RANKfN2i9brviVUOx2UJOyC/agMsPBeuSt7fjnkuoZ/Hfa36HqTvlGBrTnBYOd
        bkrOQQ71cYqjHBUzRhEt/tzrB4iB8kuMeJlgDKxNmVJFLl9o9xDKOkCqpMbyQSp0XqC2Xw
        seaE1eTXE2soQJF9HrZoBrn/r6wiueY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680284258;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lfL6HgQGS+xxA5Eltd5A7866gUInB6pLTF4Cl/2o2ms=;
        b=QdSA213cDM6qdKp+g3xfEqRLpKrj6/haVFxHUbpXHf2SNLUgQagLGEqGmDSYsrfX7+/n8L
        GS7YNgbWU8nZvQDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9636133B6;
        Fri, 31 Mar 2023 17:37:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ibo4NGEaJ2THRQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 31 Mar 2023 17:37:37 +0000
Date:   Fri, 31 Mar 2023 19:31:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: don't offload CRCs generation to helpers if it is fast
Message-ID: <20230331173122.GY10580@twin.jikos.cz>
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

Added to for-next, thanks.
