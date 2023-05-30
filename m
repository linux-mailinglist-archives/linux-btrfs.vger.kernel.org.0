Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE8C716649
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 17:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjE3PK7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 11:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjE3PKx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 11:10:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5623F7
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 08:10:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 70D532187A;
        Tue, 30 May 2023 15:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685459440;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rwpFLmTONTJ3uwIqT7FeGyTBACmzFOqMOTuewaZDNo4=;
        b=I6bl18NgnrTd1VdK52pthicKoZ8kOml19AUwo78faLekTuzxm/GE1lhY4yFRjs4eYsGIZZ
        39lTB4CJpL2LUHtS5bVVoyM4viEvfM4V879PkQljIsqTzlMM+fgk78mn+WHvKgrhXWS4o1
        4ubQx1NOzg9GHc2Ntz5itsYQsIdm6rE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685459440;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rwpFLmTONTJ3uwIqT7FeGyTBACmzFOqMOTuewaZDNo4=;
        b=Drd+H/6PAAm7SrwRr++e2LGyyeNzexilcWEEL24ysGqK6Qg+I+zLp+RY4sMJvkbkwIRmq0
        k9YPWHHG4bbLHuDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C0A613478;
        Tue, 30 May 2023 15:10:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f3zUEfARdmQyfwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 30 May 2023 15:10:40 +0000
Date:   Tue, 30 May 2023 17:04:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/11] btrfs: some delayed refs optimizations and cleanups
Message-ID: <20230530150429.GT575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1685363099.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1685363099.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 29, 2023 at 04:16:56PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This brings an optimization for delayed ref heads and several cleanups.
> These come out while doing some other work around delayed refs, but as
> these are independent of that other work, and trivial, I'm sending these
> out separately. More details on the changelogs.
> 
> Filipe Manana (11):
>   btrfs: reorder some members of struct btrfs_delayed_ref_head
>   btrfs: remove unused is_head field from struct btrfs_delayed_ref_node
>   btrfs: remove pointless in_tree field from struct btrfs_delayed_ref_node
>   btrfs: use a bool to track qgroup record insertion when adding ref head
>   btrfs: make insert_delayed_ref() return a bool instead of an int
>   btrfs: get rid of label and goto at insert_delayed_ref()
>   btrfs: assert correct lock is held at btrfs_select_ref_head()
>   btrfs: use bool type for delayed ref head fields that are used as booleans
>   btrfs: use a single switch statement when initializing delayed ref head
>   btrfs: remove unnecessary prototype declarations at disk-io.c

The above added to misc-next, thanks.

>   btrfs: make btrfs_destroy_delayed_refs() return void

Commented why not merged for now.
