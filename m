Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212004B1418
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 18:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245172AbiBJRXL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 12:23:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245168AbiBJRXK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 12:23:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF2BC2C
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 09:23:11 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BA8E321121;
        Thu, 10 Feb 2022 17:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644513789;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2kRCbwBHoYlE3Lpq5oYhPeHxFTFSXoEAofQK+SSOROI=;
        b=c/71D0fcIWfcdpntkHqecMkR7CTP+GAxrfbj46pZLP8zLoVSfmnNAiGpfq9aIcHqilHEGh
        K67JA/c5qNqbTke1K8qhcFR4FkhpwTF6Plqr2Kt7PjCqgK5Qw6AZXtE1i37d73DEmfD8eP
        U0JaVatcsFUutiEdSseRUuMfLz4S0/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644513789;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2kRCbwBHoYlE3Lpq5oYhPeHxFTFSXoEAofQK+SSOROI=;
        b=9qPPYU7Gu9iclONRNpNpb1FzTU8ikKX/1vxgWB8AtLE7J2VUxfQM3Z1b+d//BAOatx62NP
        U+SPiT4WhBt9DjAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B2138A3B95;
        Thu, 10 Feb 2022 17:23:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 48795DA9BA; Thu, 10 Feb 2022 18:19:28 +0100 (CET)
Date:   Thu, 10 Feb 2022 18:19:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: Remove duplicated check in adding qgroup
 rels
Message-ID: <20220210171928.GR12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20220206125248.940534-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206125248.940534-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 06, 2022 at 12:52:48PM +0000, Sidong Yang wrote:
> This patch removes duplicated check in adding qgroup relations.
> btrfs_add_qgroup_relations function add relations by calling
> add_relation_rb(). add_relation_rb() checks that member/parentid exists
> in current qgroup_tree. But it already checked before calling the
> function. It seems that we don't need to double check. This patch addes
> new function __add_relation_rb() that adds relations with btrfs_qgroup*
> not id and make old function use the new one. And it make
> btrfs_add_qgroup_relation() function work without double checks by
> calling the new function.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Added to misc-next, thanks. I've written the function comments so it's
clear that NULL is accepted for the pointer version.
