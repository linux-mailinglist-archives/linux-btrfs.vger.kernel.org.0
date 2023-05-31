Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1B0718F22
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 01:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjEaXsy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 19:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjEaXsx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 19:48:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EB5137
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 16:48:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DBF4F1FD71;
        Wed, 31 May 2023 23:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685576927;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=olNyyiJcyoUT39A5s1e0Aie79jGWnkKHZeUX6zAHEZs=;
        b=pTD0RiE7rU/+DrHD1fBsmwavR1yC5gKEqpPWeeEVpLfijs+AAKMftoKqfJJTpb3YlfuvH4
        tMr8v4bbwZB02fChinNXKD/XDqHqcwX9VugONcsAeBen56HC/NEWjIUcjl87quB13cL1/M
        Hsy7MV0yUJmrFkR4iewpAluNMtrm5lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685576927;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=olNyyiJcyoUT39A5s1e0Aie79jGWnkKHZeUX6zAHEZs=;
        b=ccWNQ7SlX4G7EsnEw9XHNBNWh/f96e11/PX6DZe0Eo7GPNfPiPMUS4f+dUh3GU24YncPg/
        OHtsgYge4rWkHcBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B778A13488;
        Wed, 31 May 2023 23:48:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z6zIK9/cd2SfJAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 31 May 2023 23:48:47 +0000
Date:   Thu, 1 Jun 2023 01:42:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: add CHANGING_FSID_V2 to print-tree
Message-ID: <20230531234236.GH32581@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8e152cd504552e92680290cd34bf30bfef0cc1aa.1685440589.git.anand.jain@oracle.com>
 <f9d3d5feee3ddd2ddf8484396b6e0642b7ff5f91.1685519856.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9d3d5feee3ddd2ddf8484396b6e0642b7ff5f91.1685519856.git.anand.jain@oracle.com>
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

On Wed, May 31, 2023 at 04:06:14PM +0800, Anand Jain wrote:
> Add the DEF_SUPER_FLAG_ENTRY for CHANGING_FSID_V2 to our btrfs-progs'
> print-tree.c and to the BTRFS_SUPER_FLAG_SUPP, so the dump-super prints
> the flag name instead of unknown.
> 
> Before:
> flags			0x1000000001
> 			( WRITTEN |
> 			  unknown flag: 0x1000000000 )
> 
> After:
> flags			0x1000000001
> 			( WRITTEN |
> 			  CHANGING_FSID_V2 )
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: Include CHANGING_FSID_V2 in BTRFS_SUPER_FLAG_SUPP now in this patch.
>     Update change log.

Replaced in devel, thanks.
