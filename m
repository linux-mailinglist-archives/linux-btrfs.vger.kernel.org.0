Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B33A65BF37
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jan 2023 12:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237419AbjACLpi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Jan 2023 06:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjACLpP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Jan 2023 06:45:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73695F7C
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Jan 2023 03:45:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8FC4C61479;
        Tue,  3 Jan 2023 11:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672746312;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z0LNSCbdefk+zfmObrDFFoVnicfrOJm7G2en87ZB2W8=;
        b=gcX+pMuv1Y/7Z2AhjWj0D05lZs740mx6+7Mi/QqnU81aezgB6F0qeFhCF96EVotrrsxZXq
        CwmwV4m0W57PTZqFzFGkvgRLENMMD5TJCMaZJrKrDXweZq3Y8/SLuMGecWRmcuhrKY2xeH
        HUV2z1Xis4gwVuZIq9jStezCQxwjD4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672746312;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z0LNSCbdefk+zfmObrDFFoVnicfrOJm7G2en87ZB2W8=;
        b=TbAxxraQOoaYSlEk1oT+dajCs0hA+OQlZyMkoP2JHBU5DkfcLbwFORySuAiETaHif48HYh
        +5aPmU62ob7TysCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67B3C1390C;
        Tue,  3 Jan 2023 11:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FppXGEgVtGP8bQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 03 Jan 2023 11:45:12 +0000
Date:   Tue, 3 Jan 2023 12:39:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Neal Gompa <ngompa@fedoraproject.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Subject: Re: btrfs-progs 6.1 broke the build for multiple applications
Message-ID: <20230103113941.GN11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAEg-Je8L7jieKdoWoZBuBZ6RdXwvwrx04AB0fOZF1fr5Pb-o1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEg-Je8L7jieKdoWoZBuBZ6RdXwvwrx04AB0fOZF1fr5Pb-o1g@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 02, 2023 at 07:11:57PM -0500, Neal Gompa wrote:
> Hey all,
> 
> It looks like btrfs-progs v6.1 broke the build for multiple
> applications in Fedora.
> 
> Notably, it broke:
> 
> * btrfs-assistant
> * buildah
> * cri-o
> * podman
> * skopeo
> * containerd
> * moby/docker
> * snapper
> * source-to-image
> 
> The bug report is here: https://bugzilla.redhat.com/2157606
> 
> It looks like this change broke everything:
> https://github.com/kdave/btrfs-progs/commit/03451430de7cd2fad18b0f01745545758bc975a5

On no that's bad, I'm going to do a bugfix release today.
