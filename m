Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B55742A49
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 18:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjF2QJT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 12:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjF2QJR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 12:09:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7115A9E
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 09:09:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 095AA1F8C2;
        Thu, 29 Jun 2023 16:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688054952;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zD9vIVEvMPw3r4dG0UetLFqvr9LbpUBrChz+K7wNWC8=;
        b=l+4pD1dwcW4xlTTIunOI4MZDqXTldcq8lSbsI9/YqHmnJdSSAvDxhH7BSAIfB6vAJzJTWb
        YbXzP9qrDtFhgoUpw7J8LBu7ae3W70LrXIyRLbOgTrjFiwSi4ocaHE87rEbdp0UfPgwlJE
        j8VqOZ6hS9hLNcjnIn9XQeFmG0QrIcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688054952;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zD9vIVEvMPw3r4dG0UetLFqvr9LbpUBrChz+K7wNWC8=;
        b=IIV8ZJB63WOZYehWxMexKkl+6YVJro2v1C3s7freLfyFf3OXgJnS+xbmGDhwj0Ju5tc5rm
        dvbY97XLSTRX7qBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8EC013905;
        Thu, 29 Jun 2023 16:09:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RmwrM6esnWSQSQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 29 Jun 2023 16:09:11 +0000
Date:   Thu, 29 Jun 2023 18:02:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add comments for btrfs_map_block()
Message-ID: <20230629160243.GP16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4564c119bf29d7646033a292c208ffcab6589414.1687851190.git.wqu@suse.com>
 <ZJsJRMQx3oNSaEOk@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJsJRMQx3oNSaEOk@infradead.org>
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

On Tue, Jun 27, 2023 at 09:07:32AM -0700, Christoph Hellwig wrote:
> On Tue, Jun 27, 2023 at 03:34:31PM +0800, Qu Wenruo wrote:
> > + * @mirror_num_ret:	(Mandatory) returned mirror number if the original
> > + *			value is 0.
> 
> This one is optional.
> 
> > + *
> > + * @need_raid_map:	(Deprecated) whether the map wants a full stripe map
> > + *			(including all data and P/Q stripes) for RAID56.
> > + *			Should always be 1 except for legacy call sites.
> > + */
> 
> Saying deprecated for a paramter to function with just a few callers
> feels weird.  For this patch I'd just stick to a functional description.

Agreed, I've updated the comment to refer to integrity checker instead
of 'deprecated'.
