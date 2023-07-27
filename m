Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DD6765932
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jul 2023 18:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjG0Qv3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 12:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjG0Qv1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 12:51:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F6D30CF
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 09:51:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 023B21F74A;
        Thu, 27 Jul 2023 16:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690476683;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9U75TTryBHhESqNsIFcHsQYK/wq8YeMolU/M8Jo5FwI=;
        b=T8yFiLTh2fG08Js3QvlV6Z13vtLxn8VyRn6nLD0vyGbDd2wc3W9fNdxLh5Qo3ykvBe+nBH
        2M+oMGWzqqsF2nZciqzyfHyB/LxHJPj8fZ2+lp/d0Vlb3oN0Imn4FkJGcqE3h7kOnykYJi
        ms4HkoRHLfZIFPpKvTCM8wxe4ih/CgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690476683;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9U75TTryBHhESqNsIFcHsQYK/wq8YeMolU/M8Jo5FwI=;
        b=feodLKr+xOuH5r1PKlWh7JWYsWwkWooW50qxWSCQaG0+vk3KhiWNROiydrSgmXpCs+n2mS
        Ywmg1fzcdSPcbgAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3F51138E5;
        Thu, 27 Jul 2023 16:51:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uj8XLoqgwmTtVwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 27 Jul 2023 16:51:22 +0000
Date:   Thu, 27 Jul 2023 18:45:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: update more items to .gitignore
Message-ID: <20230727164500.GF17922@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <fd419c2ceaa48c6cf2c14dc9841eed42217002d0.1690274546.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd419c2ceaa48c6cf2c14dc9841eed42217002d0.1690274546.git.anand.jain@oracle.com>
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

On Tue, Jul 25, 2023 at 04:45:55PM +0800, Anand Jain wrote:
> We still have some files after cleanup that Git identifies. Add them to
> the .gitignore to ignore them.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to devel, thanks.
