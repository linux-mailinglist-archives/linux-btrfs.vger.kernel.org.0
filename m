Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B627469D424
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 20:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjBTThb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 14:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjBTTh3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 14:37:29 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FF818147
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 11:37:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 790CF338CA;
        Mon, 20 Feb 2023 19:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676921846;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kJv+Eh6VnlY61Kt84Q4PAiOdUvfkx9CfhHGbpndffIc=;
        b=AA1onfgLBVBeW09wuugAqk2rJ13MxY8o+MccRU4iVmmKQ3sNTJvo/mrtQL02yfjnNPgeHO
        mENAzz6lBLTvxMH1Hnw95Otdr4rzzwZjqRo97LFRHcRMZbEAkheHxI81rZazqTGOb9/Q3/
        mgQEadBUEI+gNkVw2uiyauxn82TTD/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676921846;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kJv+Eh6VnlY61Kt84Q4PAiOdUvfkx9CfhHGbpndffIc=;
        b=uaAOICWwb9UJ3AfgEzkjFaYLkDT1x99qQEOE9tcrLDtdqDickJc0thJWoqyd4/miFUl9ow
        rdxqKeEMfSs4S9DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 52BCE134BA;
        Mon, 20 Feb 2023 19:37:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NjpgE/bL82NZSQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 20 Feb 2023 19:37:26 +0000
Date:   Mon, 20 Feb 2023 20:31:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] btrfs: remove btrfs_csum_ptr
Message-ID: <20230220193130.GB10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5a3df9c70dc6e6ec3f6ee6222090c4217e2ed368.1676026165.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a3df9c70dc6e6ec3f6ee6222090c4217e2ed368.1676026165.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 10, 2023 at 02:50:08AM -0800, Johannes Thumshirn wrote:
> Remove btrfs_csum_ptr() and fold it into it's only caller.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Added to misc-next, thanks.
