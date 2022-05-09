Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DFE52058A
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 21:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240675AbiEIUAD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 16:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240657AbiEIUAC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 16:00:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBEA4ECF2
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 12:56:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2E87821C78;
        Mon,  9 May 2022 19:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652126166;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zs8nfwznrUM8IplTTKBMrYpIXHcKeVO43yWF8zqk2y8=;
        b=2ObFB5S4gYSRqMhJk8YV+Gp0tOBUM2nuD+nPxqZQ+LO/HMWolG/OgUQ7czq+Ysc259ZyTG
        vk4CMsiWJDoGxOS9fWQA44R8egytKx+4Jgrlm2yVzAufu2OGseUcKHoi3kd7wqDZd+Zr3i
        9chi52N/SCp4B/NQPbUKRfsOpa0hyio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652126166;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zs8nfwznrUM8IplTTKBMrYpIXHcKeVO43yWF8zqk2y8=;
        b=Mqk7n8WVXtdHZIsg3QCj1y50FCZCJweAc5cVhZEbsfAXql5pMY0Td69y3CnuIUOA6uUm5O
        SkzgkLoIrjUoz2CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CA63132C0;
        Mon,  9 May 2022 19:56:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9aUfAtZxeWK4CQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 09 May 2022 19:56:06 +0000
Date:   Mon, 9 May 2022 21:51:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Gabriel Niebler <gniebler@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Subject: Re: [PATCH v6] btrfs: Turn delayed_nodes_tree into an XArray
Message-ID: <20220509195151.GG18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Gabriel Niebler <gniebler@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
References: <20220426094304.7952-1-gniebler@suse.com>
 <8878c000-a9f2-477f-8996-08381d1fecc5@suse.com>
 <d50ad9d1-f0a3-e51d-2c57-5f052c3f25c1@suse.com>
 <3de4b25a-9528-a2c5-336e-ac33f1a2692c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3de4b25a-9528-a2c5-336e-ac33f1a2692c@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 05, 2022 at 09:35:53AM +0200, Gabriel Niebler wrote:
> Should I resend with the small changes outlined below, or will the patch 
> be accepted and the diff folded into it on the maintainer's side?

No need to resend, the fixup has been applied.
