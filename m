Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2205714EE2
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 19:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjE2RTd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 13:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE2RTc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 13:19:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C982BB5
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 10:19:29 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8052521A09;
        Mon, 29 May 2023 17:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685380768;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eq6RRt88zRxTKuaKMgt1sTb3lMLgKVC5LTWOjpYBYDQ=;
        b=uRRnTqC3SwDwMShXP2Tgwoh6JUk9ELkdzSyUWLhp2V1Gdr4pEDlkAk7/chhMa7rR825W2M
        VCrt4W/mqlTQGDvtN+KF8wmaJL9d1wVxsds34KwO0qrItgFF3wlHFrlTGtSgpT41PL6EYG
        qB/lFNX5Q98af+OVwq5lagtMSAS54Ak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685380768;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eq6RRt88zRxTKuaKMgt1sTb3lMLgKVC5LTWOjpYBYDQ=;
        b=3cg+3dBm3Dbx51NZzGa4m9HVZr2kGMyUeuBngqJ1nkQxpWJ2LesDousVwzkAs4HoH68UMs
        cjjgipF1rrbksBAQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5A967134BC;
        Mon, 29 May 2023 17:19:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id HZ+hFKDedGT7HQAAGKfGzw
        (envelope-from <dsterba@suse.cz>); Mon, 29 May 2023 17:19:28 +0000
Date:   Mon, 29 May 2023 19:13:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/16] btrfs: fix range_end calculation in
 extent_write_locked_range
Message-ID: <20230529171318.GI575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230523081322.331337-1-hch@lst.de>
 <20230523081322.331337-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523081322.331337-2-hch@lst.de>
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

On Tue, May 23, 2023 at 10:13:07AM +0200, Christoph Hellwig wrote:
> The range_end field in struct writeback_control is inclusive, just like
> the end parameter passed to extent_write_locked_range.

There should also be analysis what are the effects and how severe the
bug is. The code is from 2008 so if it's really bad we would have seen
something already.
