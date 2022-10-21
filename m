Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD066070C4
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 09:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiJUHOt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Oct 2022 03:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiJUHOr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Oct 2022 03:14:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E1441518
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Oct 2022 00:14:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1C00722AE3;
        Fri, 21 Oct 2022 07:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666336480;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eCOzKG87ZibaKsMpNpDX6D0kJGyIOxO/dzM1QOruyqw=;
        b=bExFSYhkbtLslvyoAJTj2m/2v867e7pbQIju7XRg4tTroCBI67z4abmhdkScRT0u/FRtSC
        eQpuGHQNSbomC8IwMyOc/9PW37M4jdcXCZ/xXt5cRr79ujWILIp1+rUSRKTFhxpw/PQG3X
        trn7r5057eADx2GD4pLYiYa8j3GWWEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666336480;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eCOzKG87ZibaKsMpNpDX6D0kJGyIOxO/dzM1QOruyqw=;
        b=sqLFwiW0fS9aWkRVidMq1IsYrO+CO6CTUEXGEEIlChemNAKOyNEP3urdkcSFM73Wzel7KB
        IYkPFPQ4DrX5FwBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E70E713A0E;
        Fri, 21 Oct 2022 07:14:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IOllN99GUmNNKwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 21 Oct 2022 07:14:39 +0000
Date:   Fri, 21 Oct 2022 09:14:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3 09/15] btrfs: add a BTRFS_FS_NEED_TRANS_COMMIT flag
Message-ID: <20221021071428.GP13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1666190849.git.josef@toxicpanda.com>
 <9c3c50c6a36b7d56e3bc9bb883f5f0209d0dbcd8.1666190849.git.josef@toxicpanda.com>
 <2a07e1a8-8015-ff19-ba55-61fa2da16bdb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a07e1a8-8015-ff19-ba55-61fa2da16bdb@oracle.com>
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

On Fri, Oct 21, 2022 at 02:03:24PM +0800, Anand Jain wrote:
> On 19/10/2022 22:50, Josef Bacik wrote:
> > Currently we are only using fs_info->pending_changes to indicate that we
> > need a transaction commit.  The original users for this were removed
> > years ago, so this is the only remaining reason to have this field.  Add
> > a flag so we can remove this code.
> > 
> > Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Why did we miss my rb though some of the patches have no code-change, 
> for example this patch.

I'll add it for final merge.
