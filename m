Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D55508B4A
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 16:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379840AbiDTO65 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 10:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbiDTO65 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 10:58:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D7839BA5
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 07:56:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 04E142112B;
        Wed, 20 Apr 2022 14:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650466568;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mR8u2DGiZeO11JZhattsm/0g92WMtHyNhIaJUZi+8TM=;
        b=YNP32ls8oN3U7IXeCSqvCD2cHCXZmBuio4VFvB1e98xhdOTji0QKUNx2jYpcZzbCxXlOs3
        dnth9rFZB95oi0P6TGYJOy11Z6UPzRj62g7EHxZg/ZqlXzibXI9UAa/S3fwzoTHF3NlEUq
        lU8uLgMhco8vlpFtXhxg4RrFHDmlOHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650466568;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mR8u2DGiZeO11JZhattsm/0g92WMtHyNhIaJUZi+8TM=;
        b=1+0M57iTcgH1oCRoyZWRDwa1qVAapKRlQGt396QCTeZ9ohKE2y/X/p6o9C+ErP4RGDZKqq
        OkCepDxgYXFMDDCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC77513A30;
        Wed, 20 Apr 2022 14:56:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ocDpNAcfYGJsJwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 20 Apr 2022 14:56:07 +0000
Date:   Wed, 20 Apr 2022 16:52:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Improve error reporting in
 lookup_inline_extent_backref
Message-ID: <20220420145203.GE1513@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220420115401.186147-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420115401.186147-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 20, 2022 at 02:54:00PM +0300, Nikolay Borisov wrote:
> When iterating the backrefs in an extent item if the ptr to the
> 'current' backref record goes beyond the extent item a warning is
> generated and -ENOENT is returned. However what's more appropriate to
> debug such cases would be to return EUCLEAN and also print the in-memory
> state of the offending leaf.

Agreed, EUCLEAN makese sense. Added to misc-next, thanks.
