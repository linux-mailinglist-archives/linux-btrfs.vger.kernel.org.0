Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2752178B511
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 18:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjH1QFN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 12:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjH1QEl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 12:04:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC42913D
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 09:04:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9F80E1F893;
        Mon, 28 Aug 2023 16:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693238673;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z/PTwb9ilnncHVxdUBv1B/19/wsq3HLWuD+jcEIa+xE=;
        b=NDqgn+UuOox+GMGCNTnpriY+U3uLGx/JvRnx74O3tSEx5bYjZbv0FpI89ZlVX2u6jYF2x+
        ZIaeQpvrK1QGeEEjdNUueZA9U/tWJQlK9LYIOv/xSEu73k3I17glvqoHZaGBjL1out/EMn
        MKOxiaxjTeAVjBE2XfpnnAv8JJtriMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693238673;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z/PTwb9ilnncHVxdUBv1B/19/wsq3HLWuD+jcEIa+xE=;
        b=zw5d2p1i40EccSxgenQord7aj3V4ajT9iIpzJ/E28qDM4v7Hfkd9DPZHfDpaWoFzS5pPsY
        NfmFjN8VIvv3T9Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86B4113A11;
        Mon, 28 Aug 2023 16:04:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AEwZIJHF7GSuFgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 28 Aug 2023 16:04:33 +0000
Date:   Mon, 28 Aug 2023 17:57:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: tune: do not allow multiple features in
 different groups to be executed in one go
Message-ID: <20230828155758.GG14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5e887659a71a834e82690ba28af1c50a4ae6fa48.1692789062.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e887659a71a834e82690ba28af1c50a4ae6fa48.1692789062.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 23, 2023 at 07:11:05PM +0800, Qu Wenruo wrote:
> [PROBLEM]
> Btrfstune allows mulitple different options to be executed in one go,
> some options are completely fine, like no-holes along with extref, but
> with more and more options, we need more exclusive checks.
> 
> In fact a lot of new options are already not following the old
> success/total checks.

Yeah the options for btrfstune have become too complicated, the original
ideas was to set them one by one. This will be resolved once the actions
are factored to own commands of a new command group, until then it makes
sense to check the compatibility. Added to devel, thanks.
