Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E00754434
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 23:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjGNVfi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jul 2023 17:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjGNVfg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jul 2023 17:35:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C6C3585
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 14:35:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F1D5F1F45B;
        Fri, 14 Jul 2023 21:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689370532;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gJtn6IZQXQKpMWBD5MZBWHUFoe3ywS0GTUjqHaX0C64=;
        b=ASrwwzoAFh/HwLvS6tyYdpbK2HyakmRpJtWMCxEF2Dm0R46drVQmFTeDs7gHr2Kg+18IPC
        opGnTDmZPijMOGK1CLXsn+xBbtON0KswuS2n6/oajmcNospYH9NYQcBpljZxyrZuPpinDz
        Aa+x0qNjfzlO6C4BQ+EIRMf1vCAL280=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689370532;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gJtn6IZQXQKpMWBD5MZBWHUFoe3ywS0GTUjqHaX0C64=;
        b=9b8t2w7CXo4SBqSDiK6+IvRxSZzxsuUlAgKSJLhyEKzmVrP2+mRApnQkfqcEThD+Fmxfnj
        ZkkHiXnVWfLjHAAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0A3013A15;
        Fri, 14 Jul 2023 21:35:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gg4zMqS/sWRoSwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 14 Jul 2023 21:35:32 +0000
Date:   Fri, 14 Jul 2023 23:28:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/10] btrfs-progs: common: add --device option helpers
Message-ID: <20230714212855.GJ20457@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1687943122.git.anand.jain@oracle.com>
 <b369f8c90aabf121c53533ff60004b14cb19ec7b.1687943122.git.anand.jain@oracle.com>
 <20230713184101.GA30916@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713184101.GA30916@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 13, 2023 at 08:41:01PM +0200, David Sterba wrote:
> On Wed, Jun 28, 2023 at 07:56:08PM +0800, Anand Jain wrote:
> > +bool array_append(char **dest, char *src, int *cnt)
> > +{
> > +	char *this_tok = strtok(src, ",");
> > +	int ret_cnt = *cnt;
> > +
> > +	while(this_tok != NULL) {
> > +		ret_cnt++;
> > +		dest = realloc(dest, sizeof(char *) * ret_cnt);
> > +		if (!dest)
> > +			return false;
> > +
> > +		dest[ret_cnt - 1] = strdup(this_tok);
> > +		*cnt = ret_cnt;
> > +
> > +		this_tok = strtok(NULL, ",");
> > +	}
> > +
> > +	return true;
> > +}
> > +
> > +void free_array(char **prt, int cnt)
> > +{
> > +	if (!prt)
> > +		return;
> > +
> > +	for (int i = 0; i < cnt; i++)
> > +		free(prt[i]);
> > +
> > +	free(prt);
> > +}
> 
> Looks like this is an extensible pointer array, we could use that in
> more places where there are repeated parameters and we need to track all
> the values (not just the last one).
> 
> Then this should be in a structure and the usage side will do only
> something like ptr_array_append(&array, newvalue), and not that all
> places will have to track the base double pointer, count and has to
> handle allocation failures. This should be wrapped into an API.

I did a quick search for reallocs, that usually mean there's an
extensible array and there are too many, so I get you wanted add one more
and be done. But now it looks like a proper structure should be used.
I'll try to implement something.
