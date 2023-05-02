Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EC36F45CA
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 16:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbjEBOKU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 10:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjEBOKT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 10:10:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4721BF0
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 07:10:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DDA94221F5;
        Tue,  2 May 2023 14:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683036616;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ktdPZ7/POd1YYuFIfLDJZGTRxKP/WjjOaEu1cKgUNM=;
        b=PVn7rioToRFBphASDxnNUJBnsqu5pjPPWM7ECjcCultHcR8oTyJ0d1rAM+D24RcgchpW11
        5h2862NQtoWgOGUhWgCCQIA1x9xM9iTWEg3rkhJesn0NO4O6dhfoxOzSRu5NRca/9v0qz8
        Dr3iRCOKhhJW0LnLc5kuPu22FcgJ+PY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683036616;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ktdPZ7/POd1YYuFIfLDJZGTRxKP/WjjOaEu1cKgUNM=;
        b=JN24QeiNV6u8F3j6xn6GGI7dunCV29Her7v+q01DlHSXvDxhWCjJ+LNCSQ/Af2nHFtYlNv
        mb9Cd7zOo5AQE8Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC9EC139C3;
        Tue,  2 May 2023 14:10:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id g1FlLcgZUWSydAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 May 2023 14:10:16 +0000
Date:   Tue, 2 May 2023 16:04:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: tests/nullb fix kernel support check
Message-ID: <20230502140421.GE8111@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <fe9a6082f152726145233e31e011f71ea4719217.1683027204.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe9a6082f152726145233e31e011f71ea4719217.1683027204.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 02, 2023 at 07:39:34PM +0800, Anand Jain wrote:
> I have a setup where null_blk is not a module but is built-in, so to check
> if the kernel supports null_blk, use 'modinfo -n'.
> 
> Also fix a comment.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to devel, thanks. I've applied the same patch to nullb.git too.
