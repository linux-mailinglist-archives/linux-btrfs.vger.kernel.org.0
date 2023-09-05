Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F003079261B
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 18:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbjIEQCl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354648AbjIENOh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 09:14:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F3C19B
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 06:14:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 579851FDB7;
        Tue,  5 Sep 2023 13:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693919673;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lZdyApm4NCfAd2y2ZP6AcGFl3ykg+9jafSOukwOOrP0=;
        b=hWkkvGvPLF3dZAwIY4w/Ek54+ldeTNjgpH1H7MUDVpOdjYDX/F+9WBeBL0OTjohD4Ej0Lu
        VkGd8E6CjyTnoIR3sjImwn1h2PeiuGNSAqi3bYrcjto/yojhGab4lcHJpeRzV2YAop/ek1
        cY5KZAPgb4VR4KzcmTon3pcizioKq9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693919673;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lZdyApm4NCfAd2y2ZP6AcGFl3ykg+9jafSOukwOOrP0=;
        b=PZHD8sD8GlDjuTwlOYg2hE5l45+vNN/jH1QlFaiVtstQ2IVXXND/G9zYpQ84kZ/B7ff7r+
        7g6/msNvg/oGOBBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 379B313499;
        Tue,  5 Sep 2023 13:14:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VyHJDLkp92TxLgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 05 Sep 2023 13:14:33 +0000
Date:   Tue, 5 Sep 2023 15:07:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/5] btrfs: qgroup: use qgroup_iterator facility to
 replace @tmp ulist of qgroup_update_refcnt()
Message-ID: <20230905130753.GY14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1693391268.git.wqu@suse.com>
 <e6d30c5f77867f20ca19244e5c37881188855d6e.1693391268.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6d30c5f77867f20ca19244e5c37881188855d6e.1693391268.git.wqu@suse.com>
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

Regarding style guidelines, the subject should not be overly long, like
in this patch, "btrfs: qgroup: use qgroup_iterator in qgroup_update_refcnt"
would work too.
