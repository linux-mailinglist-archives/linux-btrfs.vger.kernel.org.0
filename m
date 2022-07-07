Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE5656A99A
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 19:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbiGGR1c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 13:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbiGGR1a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 13:27:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198F85A2EB
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 10:27:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C5DC321C72;
        Thu,  7 Jul 2022 17:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657214847;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qK952+Je7FEDyA1UwY/YLXFSJtuD29s7IJkp++41JRg=;
        b=d4PysC2bCWcqlIS7DK71Jnxt0m5lAzKCf10dMQZ0eG7h1GwWbZI8pS1McOeO1EzjLg5Nqc
        QVB0ceRNoqxSrODrQOLeEo1iDyVyV6v1gimfb7dtvioOT57tI5Md2n/u+hoDqeLE6Q8m/4
        yvikPwgxjE5FpTEQjEc0hMtqtwslkfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657214847;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qK952+Je7FEDyA1UwY/YLXFSJtuD29s7IJkp++41JRg=;
        b=jpzJNhhrUJ7S52Fww0eZssT9Sim27Z4M8hVQ4Pn2R0xliqebrRi/ozjeUtJyCXOutL3B16
        kZ3ypJ4J3h8b9ODA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 874DF13461;
        Thu,  7 Jul 2022 17:27:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ev34H38Xx2LXewAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Jul 2022 17:27:27 +0000
Date:   Thu, 7 Jul 2022 19:22:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org, naohiro.aota@wdc.com
Subject: Re: [PATCH] btrfs: fix a memory leak in read_zone_info
Message-ID: <20220707172240.GK15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org, naohiro.aota@wdc.com
References: <20220630160319.2550384-1-hch@lst.de>
 <ebf7b037-2c08-8232-6b61-8a97ee22a1ea@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebf7b037-2c08-8232-6b61-8a97ee22a1ea@oracle.com>
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

On Sun, Jul 03, 2022 at 09:41:07AM +0800, Anand Jain wrote:
> On 01/07/2022 00:03, Christoph Hellwig wrote:
> > Don't leak the bioc on normal completion.
> > 
> > Fixes: 7db1c5d14dcd ("btrfs: zoned: support dev-replace in zoned filesystems")
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >   fs/btrfs/zoned.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > index 7a0f8fa448006..e92bd5582cab3 100644
> > --- a/fs/btrfs/zoned.c
> > +++ b/fs/btrfs/zoned.c
> > @@ -1759,7 +1759,7 @@ static int read_zone_info(struct btrfs_fs_info *fs_info, u64 logical,
> >   		break;
> >   	}
> >   	memalloc_nofs_restore(nofs_flag);
> > -
> > +	btrfs_put_bioc(bioc);
> >   	return ret;
> >   }
> >   
> 
> Why not call put also during return -EINVAL a few lines above?
> 
>   if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK)
> 	 return -EINVAL;

Actually yes, it should be here as well, otherwise this would leak.
RAID56 + zoned combination is rejected much earlier so this would not
happen in practice.
