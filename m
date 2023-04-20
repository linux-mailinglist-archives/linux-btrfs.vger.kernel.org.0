Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FE86E95CB
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Apr 2023 15:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjDTNYp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Apr 2023 09:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDTNYn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Apr 2023 09:24:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333294683
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Apr 2023 06:24:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D79061FE3F;
        Thu, 20 Apr 2023 13:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681997080;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q9QXPR9GFfKV30UllxvZSoaysP4eg+MdEfvf6Dv5Fmk=;
        b=2Li1z74UQ6oV3LW0JOaP3XUZStX+lN3VlimbgHaWZBGF4pKY4qNNqyDbqgBBvhYwf9mKbn
        SvNOU5DbBofBXly5OzQNDewSwBC28QnDNhMyKqAx5Z/f0H6VNOaWQNKiSmvTCTTX0FAcoc
        ZPgqxq+QfGve+JI6lqEEw90/FL5TcWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681997080;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q9QXPR9GFfKV30UllxvZSoaysP4eg+MdEfvf6Dv5Fmk=;
        b=V4CW6Zkf0um7NAPe5HeaV0PJ+Iv3qWBBVvjrWAiJMbfeBCoLUn/Or0K9qSWqLLSRxqeTM/
        obz6Gkoub9mxGsCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A660E13584;
        Thu, 20 Apr 2023 13:24:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4z65Jxg9QWQ+GAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 20 Apr 2023 13:24:40 +0000
Date:   Thu, 20 Apr 2023 15:24:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naota@elisp.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: fix bitops api misuse
Message-ID: <20230420131743.GW19619@suse.cz>
Reply-To: dsterba@suse.cz
References: <fc21b3d5ddf062b746bc55425672969f897d685d.1681801005.git.naohiro.aota@wdc.com>
 <20230418232456.GT19619@twin.jikos.cz>
 <rr25zuiruz5p3gtnlojmezwzkkd4vdp6zqcarskgq7ecancv4g@xpj4jx6f5ouv>
 <ghiglpjvgkvtdwpkl2h73b6gqlyfh6cl3m4b3uv3rhv5tmhyxq@2esoibq7emjk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ghiglpjvgkvtdwpkl2h73b6gqlyfh6cl3m4b3uv3rhv5tmhyxq@2esoibq7emjk>
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

On Thu, Apr 20, 2023 at 01:14:30PM +0900, Naohiro Aota wrote:
> On Thu, Apr 20, 2023 at 12:58:14PM +0900, Naohiro Aota wrote:
> > On Wed, Apr 19, 2023 at 01:24:56AM +0200, David Sterba wrote:
> > > On Tue, Apr 18, 2023 at 05:45:24PM +0900, Naohiro Aota wrote:
> > > > From: Naohiro Aota <naohiro.aota@wdc.com>
> > > > 
> > > > find_next_bit and find_next_zero_bit take @size as the second parameter and
> > > > @offset as the third parameter. They are specified opposite in
> > > > btrfs_ensure_empty_zones(). Thanks to the later loop, it never failed to
> > > > detect the empty zones. Fix them and (maybe) return the result a bit
> > > > faster.
> > > > 
> > > > Fixes: 1cd6121f2a38 ("btrfs: zoned: implement zoned chunk allocator")
> > > > CC: stable@vger.kernel.org # 5.15+
> > > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > > > ---
> > > >  fs/btrfs/zoned.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > > > index 2b160fda7301..55bde1336d81 100644
> > > > --- a/fs/btrfs/zoned.c
> > > > +++ b/fs/btrfs/zoned.c
> > > > @@ -1171,12 +1171,12 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
> > > >  		return -ERANGE;
> > > >  
> > > >  	/* All the zones are conventional */
> > > > -	if (find_next_bit(zinfo->seq_zones, begin, end) == end)
> > > > +	if (find_next_bit(zinfo->seq_zones, end, begin) == end)
> > > 
> > > End is defined as "end = (start + size) >> shift", and the 2nd parameter
> > > of find_next_bit is supposed to be 'size'. Shouldn't it be "size >>
> > > shift"?
> > 
> > Not so. The argument "size" represents the size of the allocation range,
> > which is to be confirmed as empty. OTOH, find_next_bit()'s "size" (the 2nd
> > parameter) represents the size of an entire bitmap, not the number of bits to
> > be tested.
> 
> BTW, I found the same logic is implemented in subpage.c as
> bitmap_test_range_all_{set,zero}. So, it might worth moving them to
> somewhere (misc.h?) and use them here.

Good idea, please send it as a separate patch. Thanks.
