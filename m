Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9BE6F4376
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 14:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbjEBMOF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 08:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjEBMOE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 08:14:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C59D6192
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 05:13:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 28BC61F8BE;
        Tue,  2 May 2023 12:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683029571;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NGNZVFB7aFl0nAiNpHZmMOIzHQHG7XA9DplHmDZPw4A=;
        b=HRaJs9zIt4Ik7nSBEhAdT4/6DKOQtyRkTnkcXAgN2SS7BNs1ob02WyV4UME4WKwh+ysgv/
        dh8tuSlPOh+bPcU3rvd7EfkU8sSjH0d/GHIK7amX2AYJVp5/l+g8JHcKxgUYnCkYeNwrMx
        L1LTbSxQuhj3pOR8kkU+dvOII7IIt1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683029571;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NGNZVFB7aFl0nAiNpHZmMOIzHQHG7XA9DplHmDZPw4A=;
        b=+hr6AfCZ/H7q7CAth6bCPd0QLcCIfQBQo6o6oh0ElHLzWbymv/R1qwPvEJtUfeD4cOlP9s
        GCyMBlBtiov15NAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 11387139C3;
        Tue,  2 May 2023 12:12:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hwWSA0P+UGQ/MQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 May 2023 12:12:51 +0000
Date:   Tue, 2 May 2023 14:06:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: doc: fix the indent on the
 ORPHAN_OBJECTID
Message-ID: <20230502120655.GB8111@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230501232938.10544-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501232938.10544-1-wqu@suse.com>
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

On Tue, May 02, 2023 at 07:29:37AM +0800, Qu Wenruo wrote:
> When compiling the documents, we have the following warning:
> 
>   ~/btrfs-progs/Documentation/dev/On-disk-format.rst:369: WARNING: Bullet list ends without a blank line; unexpected unindent.
> 
> It's caused by a mismatched indent, just fix it.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Patches added to devel, thanks.
