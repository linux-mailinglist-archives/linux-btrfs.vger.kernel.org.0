Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B46E728063
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 14:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjFHMsi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 08:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbjFHMsg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 08:48:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F5226B1
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 05:48:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6F64A21A44;
        Thu,  8 Jun 2023 12:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686228514;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BmpFc73dcDUTCcRUEDy9YGuyZSFKzQrhYG2/zSq4UEs=;
        b=DJlibI37GJucla8COmhRPVZL84lvM1IpMySxffMce3vH22HkKNzpfkQqe3Nybl+sqHK8iI
        Al9x3C0y+ygHoeYKL3xHO//uT91nj+MJnDoZED1ISquXXjrKYfFNFf1WcMa0s8iwSUXmC/
        NdGjcfH1r2wCtn8RwSc2lvqKhVdDYto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686228514;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BmpFc73dcDUTCcRUEDy9YGuyZSFKzQrhYG2/zSq4UEs=;
        b=+pkszsj7kJa2VqgbyMKJAs7qo8CIhMkQ+Q86anyOd5d8yXMog9t7leqn1q8RSsm7ofwAT+
        /Uior/D7+ZqDwaCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4393F13480;
        Thu,  8 Jun 2023 12:48:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EuO1DyLOgWRKSgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 08 Jun 2023 12:48:34 +0000
Date:   Thu, 8 Jun 2023 14:42:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/7] btrfs-progs: btrfs_scan_one_device: drop local
 variable ret
Message-ID: <20230608124218.GH28933@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1686202417.git.anand.jain@oracle.com>
 <718713677855382e44cb57d1ad590063ca20d8f7.1686202417.git.anand.jain@oracle.com>
 <d7bd5351-f8be-525a-8c54-d320982c4ba0@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7bd5351-f8be-525a-8c54-d320982c4ba0@gmx.com>
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

On Thu, Jun 08, 2023 at 02:22:35PM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/6/8 14:01, Anand Jain wrote:
> > Local variable int ret is unnecessary, drop it.
> >
> > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> I'm not sure if this change is really necessary.
> 
> To me it's more nature to go "ret = what_ever();" then handling @ret.
> And compiler is definitely clever enough for those optimization.

Yeah we do

	ret = function(...)
	if (ret < 0)
		...

almost everywhere. I find it clear, there's something happening is
on a separate line and the condtion check should have as little side
effects as possible.
