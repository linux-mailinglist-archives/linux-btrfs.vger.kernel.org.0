Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D71860D169
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 18:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiJYQPM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Oct 2022 12:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiJYQPL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Oct 2022 12:15:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90632DFC8
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 09:15:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4958E1FA48;
        Tue, 25 Oct 2022 16:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666714508;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v0lLJALyxjygz1aNKTEm9L9lpxcwXepHhIiVTzhNq8U=;
        b=I2LfZWlhxhEorxAD6g7OrBJUvnygZG3REAX1G/qYH85VyNa67sWS79uU/BE1M43jdem6Nb
        5KzZsqMyLv2SS3O/5in3x8U/QtbE1siRTeim7syYYqwodSsj/F5KVNXvnAWBShOqvpNpzE
        miaW37A+inxLbnOZ2pQMvWr70Un0jTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666714508;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v0lLJALyxjygz1aNKTEm9L9lpxcwXepHhIiVTzhNq8U=;
        b=AVprsaCRjOLSlxUnk34+wVkQDVaeoz1bp4YsJKqIc69/p9qCYp+2zqXFi1pcVezGg+cK5D
        3MeLCbSh3d4jTADQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 18B22134CA;
        Tue, 25 Oct 2022 16:15:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lSWXBIwLWGNpFgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 25 Oct 2022 16:15:08 +0000
Date:   Tue, 25 Oct 2022 18:14:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: remove unused btrfs_cond_migrate_bytes
Message-ID: <20221025161453.GO5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f108ebbe38bbcec67c8551f35c68dc38d342addf.1666710777.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f108ebbe38bbcec67c8551f35c68dc38d342addf.1666710777.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 25, 2022 at 11:13:06AM -0400, Josef Bacik wrote:
> The last user of this was removed in 7f9fe6144076 ("btrfs: improve
> global reserve stealing logic"), drop this code as it's no longer called
> by anybody.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
