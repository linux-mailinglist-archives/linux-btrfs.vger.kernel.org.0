Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E382551726C
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 May 2022 17:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbiEBPZi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 11:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239120AbiEBPYl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 11:24:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2957312AD4
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 08:21:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DC6B41F38D;
        Mon,  2 May 2022 15:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651504869;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/GXHi8jypVYO9ZyjGjZM2emOa80+DlWuSxudPbgCivE=;
        b=tzOw/jOV+yHEbxVSUKfTkAg5IGfm8A7YOaSlBczYnfei408h9C1yeOxN5i6fORxIjLqaKm
        o+H6xXA2wCXuY9s75F7I0O32TQP4kA5HGiZU2O6yCWzNSE2ptZL+Lrsw3Cf69nwoNcTaoo
        rA2wBpfDtoVmBah6Pz5qBVNp4kqGPt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651504869;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/GXHi8jypVYO9ZyjGjZM2emOa80+DlWuSxudPbgCivE=;
        b=QwnRCYgBwfIXFap1BjV5MYvQ9Y31M/qj2RXN073FXK5hmUKcS1yISRJJKGXq13h3OjnOlv
        2v8pWslrdM2jTTDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE645133E5;
        Mon,  2 May 2022 15:21:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HPibKeX2b2IyTAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 May 2022 15:21:09 +0000
Date:   Mon, 2 May 2022 17:16:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 7/9] btrfs: rename io_failure_record::bio_flags to
 compress_type
Message-ID: <20220502151659.GK18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1651255990.git.dsterba@suse.com>
 <54b867c85b5891611c1a8f5a412abb06bbe5db61.1651255990.git.dsterba@suse.com>
 <PH0PR04MB74162830148A045DDBF6FB199BFE9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB74162830148A045DDBF6FB199BFE9@PH0PR04MB7416.namprd04.prod.outlook.com>
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

On Sun, May 01, 2022 at 08:22:41PM +0000, Johannes Thumshirn wrote:
> On 29/04/2022 11:32, David Sterba wrote:
> > diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> > index fdbfe801dbe2..1fa40ab561df 100644
> > --- a/fs/btrfs/extent_io.h
> > +++ b/fs/btrfs/extent_io.h
> > @@ -266,7 +266,7 @@ struct io_failure_record {
> >  	u64 start;
> >  	u64 len;
> >  	u64 logical;
> > -	unsigned long bio_flags;
> > +	unsigned int compress_type;
> >  	int this_mirror;
> >  	int failed_mirror;
> >  };
> 
> 
> Why 'unsigned int' and not 'enum btrfs_compression_type'?

Good point I'll change it, though it's not used almost anywhere else.
