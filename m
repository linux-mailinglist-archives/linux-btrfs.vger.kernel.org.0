Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4D059EBB1
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 21:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbiHWS7k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 14:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiHWS7J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 14:59:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AD3B81C0
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 10:28:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 287A31F974;
        Tue, 23 Aug 2022 17:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661275575;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QiUEoOgYsjy8/BZuJbEmr0J2jqhT6ktKn0fo8QurDxc=;
        b=hbFzJvUw1ZfXns4HOk+8DDSsBVKGX/2LtSxF4gueMee2ztLkV3xuIvpKCCacfZeDZMGdQd
        aNUobWmpHc5uKRNyW9ry/EbxbQ2j9a3f6xoYGSKaLEDKBhuPtl3XghJFl1+Q0kSRPttX1w
        frZF08iEm4qvPzfPDCz8EO4/LFJPoSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661275575;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QiUEoOgYsjy8/BZuJbEmr0J2jqhT6ktKn0fo8QurDxc=;
        b=nEnU3Eegi+naMUHfl9fq8qQ0nqS7PukRPQjDkzR+v3RVx5ecqbrMdpUesdW7/C8AWFq3lf
        iBaOjJi7ZdIH7bBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D89BA13A89;
        Tue, 23 Aug 2022 17:26:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u8WNM7YNBWN4SgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 23 Aug 2022 17:26:14 +0000
Date:   Tue, 23 Aug 2022 19:21:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, hch@lst.de, dsterba@suse.com
Subject: Re: [PATCH] btrfs: use blk_opf_t for opf
Message-ID: <20220823172100.GI13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, hch@lst.de, dsterba@suse.com
References: <c60c370689f63591795394d2c05a4678ebb622b0.1660889735.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c60c370689f63591795394d2c05a4678ebb622b0.1660889735.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 19, 2022 at 03:46:21PM +0800, Anand Jain wrote:
> Commit bf9486d6dd23 ("fs/btrfs: Use the enum req_op and blk_opf_t
> types") is now integrated. We can use blk_opf_t instead of older unsigned int
> for opf.
> 
> Please roll this into the patch
>   [PATCH 03/11] btrfs: pass the operation to btrfs_bio_alloc

Folded to the patch, thanks.
