Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11D7714F20
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 19:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjE2R6Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 13:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2R6X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 13:58:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAEBD9
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 10:58:22 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3F20B21A60;
        Mon, 29 May 2023 17:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685383101;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=707RuoLRN2qQCbHFaf8fmW06pKrRQa15mng3KLLbbtg=;
        b=vb+Go8WG2KGThLcorNoKLjNTGRdsj72I54z7T4StMVvXVH2TC7g1Z6R/5wrM9cWlxg+oo8
        HUKv3hFdpuB8QD/OUtNmIA7cPnBUOa1SNQRE1ArCInUdIiSrElI+utBN0cflsqPBl1cp5S
        ceuMcwaEx10g4FIL+z9IFiqBH9Lz+Ak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685383101;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=707RuoLRN2qQCbHFaf8fmW06pKrRQa15mng3KLLbbtg=;
        b=iPTjpGYpOjwQPc9I2n2S2KT7aalcQFbXwQMrTwbAVygeSFQbDYBnLSz/rgSWmuDoZ9ZRKZ
        90MfRWV8797hcsDA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1AFA813508;
        Mon, 29 May 2023 17:58:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id TIRcBb3ndGSqJwAAGKfGzw
        (envelope-from <dsterba@suse.cz>); Mon, 29 May 2023 17:58:21 +0000
Date:   Mon, 29 May 2023 19:52:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/16] btrfs: stop setting PageError in the data I/O path
Message-ID: <20230529175210.GL575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230523081322.331337-1-hch@lst.de>
 <20230523081322.331337-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523081322.331337-9-hch@lst.de>
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

On Tue, May 23, 2023 at 10:13:14AM +0200, Christoph Hellwig wrote:
> PageError is not used by the VFS/MM and deprecated.

Is there some reference other than code? I remember LSF/MM talks about
writeback, reducing page flags but I can't find anything that would say
that PageError is not used anymore. For such core changes in the
neighboring subysystems I kind of rely on lwn.net, hearsay or accidental
notice on fsdevel.

Removing the Error bit handling looks overall good but I'd also need to
refresh my understanding of the interactions with writeback.
