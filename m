Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4200A7B715A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Oct 2023 20:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjJCSxv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Oct 2023 14:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjJCSxu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Oct 2023 14:53:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3CDAB
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Oct 2023 11:53:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6DD371F894;
        Tue,  3 Oct 2023 18:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696359226;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PVRedc3M6a6GIVvYYCTMQoApgk/3c9hcMIM+AK/B4+s=;
        b=RfIAJEJqqcJeECSknhvefwDj9AiVbLY/v56EGA30j2lACi32IEIVJM/0cUZmlFGAe5LS81
        AzuEV8dzSELWoQlo2uLQRKfMjd2q8bapF3TKSXKfk+QKSf9Q21/af4xgGKJaaN8UjvE/HW
        wxRBVUnQUa5tgf70V/8IWVOcir7Vl5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696359226;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PVRedc3M6a6GIVvYYCTMQoApgk/3c9hcMIM+AK/B4+s=;
        b=1orPoCJG1SVuPAqq4lo254YpRg/p+mtov7JoK3G9qu8waS9O2KEWjuQ2L3p90pceTCY/oR
        zmiN6oJ2LAomn4DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 47C81139F9;
        Tue,  3 Oct 2023 18:53:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QncHEDpjHGVQRwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 03 Oct 2023 18:53:46 +0000
Date:   Tue, 3 Oct 2023 20:47:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 2/3] btrfs: increase ->free_chunk_space in
 btrfs_grow_device
Message-ID: <20231003184704.GA13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695836511.git.josef@toxicpanda.com>
 <c94cdbf63118d14cfc0f95827cd67d8be1bae068.1695836511.git.josef@toxicpanda.com>
 <20230929163035.GH13697@twin.jikos.cz>
 <20231002204418.GA852064@perftesting>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002204418.GA852064@perftesting>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 02, 2023 at 04:44:18PM -0400, Josef Bacik wrote:
> On Fri, Sep 29, 2023 at 06:30:35PM +0200, David Sterba wrote:
> > On Wed, Sep 27, 2023 at 01:47:00PM -0400, Josef Bacik wrote:
> > > My overcommit patch exposed a bug with btrfs/177.  The problem here is
> > 
> > Which patch is that?
> > 
> 
> Sorry the V1 version of this series.  Thanks,

Ok thanks, I've added a link to the changelog.
