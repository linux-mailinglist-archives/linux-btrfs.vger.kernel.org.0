Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4809D741B20
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 23:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjF1Vsj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 17:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjF1Vsd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 17:48:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024721FF7
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 14:48:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A2C8321847;
        Wed, 28 Jun 2023 21:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687988911;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fVrhgBteD7znJtWTq3O5wRRmTzunjEjzcEvptbQkOXo=;
        b=hqRMM1TK8NzlYzyrR/wSEtpkoCmvc6FXzIHHHgmL1lbPw4WEC9/VzZmJKcy0IBN64/2Lrs
        CBDMXL4s6djQH9CmyayWtreIg0LiCGYggZdoiN7iUkg8qVNbx47fTD5ipFCriSzXN6I5XG
        /NAb93C/YS/2L32GL2FN0AMBRdleXeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687988911;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fVrhgBteD7znJtWTq3O5wRRmTzunjEjzcEvptbQkOXo=;
        b=sD5nPIchEaEskE6+QBhPfXp0oQgZ/kg7V7n3HJs5U0ysrCRNzXigAVqgzIBkzDEi9e5A0F
        Z1HUXAifjD8WKUAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 801AD138EF;
        Wed, 28 Jun 2023 21:48:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GOoBHq+qnGRSXwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 28 Jun 2023 21:48:31 +0000
Date:   Wed, 28 Jun 2023 23:42:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3 v2] btrfs-progs: dump-super: fix dump-super on aarch64
Message-ID: <20230628214203.GG16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1687854248.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687854248.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 27, 2023 at 04:53:12PM +0800, Anand Jain wrote:
> v2: Skip sbreads() for sb bytenr greater the device size.
> 
> The command "btrfs inspect dump-super -a" is failing on aarch64 systems.
> The following set of patches resolves the issue. Patch 1/3 is enhancing
> the error log it helped debug the issue. Patch 2/3 preparatory. Patch
> 3/3 provides the fix.
> 
> Anand Jain (3):
>   btrfs-progs: dump-super: improve error log
>   btrfs-progs: dump_super: drop the label out and variable ret
>   btrfs-progs: dump-super: fix read beyond device size

Added to devel, thanks.
