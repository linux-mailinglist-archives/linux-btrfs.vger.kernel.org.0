Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B776662EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 19:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbjAKSm6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 13:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjAKSmx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 13:42:53 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287A838BF;
        Wed, 11 Jan 2023 10:42:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9E1655081;
        Wed, 11 Jan 2023 18:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673462570;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QxmUf2+9cDOXZP0jBM/Z48GvGgXrC9U1Dgigw1k3OFU=;
        b=FozIo1BZ4W3t490SCIztNcfQDTVCTihQUxjha7p4SHm09cfX5d89mB3COuFtnjOFxyN3qy
        0dboDvZAOYuxdFmV3HShcjsIIe2DP1mnHVh32WfhlpWLwVTCtFQ3Awr1hH5tiqOM3KPsN3
        cCOwVhJ2qhBoTfryD8De+CX5G6bbhD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673462570;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QxmUf2+9cDOXZP0jBM/Z48GvGgXrC9U1Dgigw1k3OFU=;
        b=fpZQmR5EsshGdQzgBpZ8JGPK4xtcgntvI1UDglEZyIUa4OAM+n6YbwZMtDSTsptxZQfWMW
        l0xpiv3SOjkop6Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60AE11358A;
        Wed, 11 Jan 2023 18:42:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aGRCFioDv2MoGQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 11 Jan 2023 18:42:50 +0000
Date:   Wed, 11 Jan 2023 19:37:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     zys.zljxml@gmail.com
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yushan Zhou <katrinzhou@tencent.com>
Subject: Re: [PATCH v3] btrfs: use PAGE_{ALIGN, ALIGNED, ALIGN_DOWN} macro
Message-ID: <20230111183715.GH11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230103051137.4085572-1-zys.zljxml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103051137.4085572-1-zys.zljxml@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 03, 2023 at 01:11:37PM +0800, zys.zljxml@gmail.com wrote:
> From: Yushan Zhou <katrinzhou@tencent.com>
> 
> The header file linux/mm.h provides PAGE_ALIGN, PAGE_ALIGNED,
> PAGE_ALIGN_DOWN macros. Use these macros to make code more
> concise.
> 
> Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>

Added to misc-next, thanks.
