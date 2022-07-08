Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEE256BA14
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jul 2022 14:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbiGHMvi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 08:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiGHMvh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 08:51:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4562B1A3AD
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 05:51:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E114A2204B;
        Fri,  8 Jul 2022 12:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657284692;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U/dYNwkO0kqn2m4eizYDYv1eqao4KmHNxCLq1LB5//Y=;
        b=QiosXEYXqb9iIvtTe8dgwwFtIXm3CdzFt5U49TusiD/1JvW4JH4KtGeqd90Tk7DnlavALy
        Q9/4P7I/etMGaMA/hEyk5S/mLkc31hlB9IzeQeFJMzYDCx7X8WApJHSzCUI5EZ5wrXkyFd
        gHmaoDGJOfH6qJoxtp6Xa1wwg5k3QkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657284692;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U/dYNwkO0kqn2m4eizYDYv1eqao4KmHNxCLq1LB5//Y=;
        b=PbJAGSw6+jTqPhN90LcvTsq778NvTRHzLkkuf3py1ycNORF9X+3quwG8KntMVFeg0j48V7
        ibf0+slRXSJx8sDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AABAF13A80;
        Fri,  8 Jul 2022 12:51:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mryqKFQoyGLNKQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 08 Jul 2022 12:51:32 +0000
Date:   Fri, 8 Jul 2022 14:46:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, naohiro.aota@wdc.com
Subject: Re: [PATCH] btrfs: fix a memory leak in read_zone_info
Message-ID: <20220708124645.GT15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Anand Jain <anand.jain@oracle.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        naohiro.aota@wdc.com
References: <20220630160319.2550384-1-hch@lst.de>
 <ebf7b037-2c08-8232-6b61-8a97ee22a1ea@oracle.com>
 <20220707172240.GK15169@twin.jikos.cz>
 <20220707173403.GA29410@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707173403.GA29410@lst.de>
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

On Thu, Jul 07, 2022 at 07:34:03PM +0200, Christoph Hellwig wrote:
> On Thu, Jul 07, 2022 at 07:22:41PM +0200, David Sterba wrote:
> > Actually yes, it should be here as well, otherwise this would leak.
> > RAID56 + zoned combination is rejected much earlier so this would not
> > happen in practice.
> 
> A version with that fixed is already out on the list, just pick that
> one up instead.

Right, I did not notice it.
