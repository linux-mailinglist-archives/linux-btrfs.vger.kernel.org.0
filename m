Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA0A634253
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Nov 2022 18:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiKVRRq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Nov 2022 12:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiKVRRp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Nov 2022 12:17:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FB758022
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Nov 2022 09:17:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EE0BE1F45E;
        Tue, 22 Nov 2022 17:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669137462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t8sz76t9yGiHPeSr169d8G/4mseF0x5aBfva5Daeo2Q=;
        b=oSJO+6/znxGlx1fcvkIIC2HaSXJZ5q6FFKtdCEWeBLqTxTDpFjmdzNOOPnvrxXZ9sKoM4G
        Jzg1y+bbljpk5LF5TwqiTEbPmdJhFAEb/flwUZDTHlp9HE2ISIjn98EoqmFxjpaWqDdGqA
        NyoKdU7tQdm9yrU2bNVR4eNxnwlztrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669137462;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t8sz76t9yGiHPeSr169d8G/4mseF0x5aBfva5Daeo2Q=;
        b=7x5ikYThM4S/Xf3Wj6+m9XSzflN3U0vuGe7kcB0vi+4BHcuP+itoGWZl5nGI9oyI/pz9XG
        U9jPTpXaTxYwttBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A670313B01;
        Tue, 22 Nov 2022 17:17:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id diL+IDYEfWPDUgAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Tue, 22 Nov 2022 17:17:42 +0000
Date:   Tue, 22 Nov 2022 11:17:41 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/16] btrfs: check for range correctness while locking
 or setting extent bits
Message-ID: <20221122171741.gzhjijznbffo6eg2@fiona>
References: <cover.1668530684.git.rgoldwyn@suse.com>
 <07534e31d822b5c08609c72e5a2e8054604765d9.1668530684.git.rgoldwyn@suse.com>
 <563d005f-613e-5f15-4f84-82f170050635@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <563d005f-613e-5f15-4f84-82f170050635@wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11:09 17/11, Johannes Thumshirn wrote:
> On 15.11.22 19:02, Goldwyn Rodrigues wrote:
> > +	if (unlikely(start > end))
> > +		return 0;
> 
> I wonder if returning 0 really is the best value here,
> instead of -EINVAL or similar?

or ERANGE to be more precise?

> 
> Also does unlikely really provide any benefit here?

It is more to tell the compiler that this scenario is unlikely and would
move the instructions during optimizing branch prediction.

-- 
Goldwyn
