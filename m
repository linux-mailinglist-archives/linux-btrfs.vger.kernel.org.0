Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECCC54C9F1
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 15:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352387AbiFONg7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 09:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351808AbiFONg6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 09:36:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D17369DD;
        Wed, 15 Jun 2022 06:36:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E90701F8D4;
        Wed, 15 Jun 2022 13:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655300216;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=chlBcacfv6bDY7l9ADHEqVc0e2MMXp3Bc7SWxZo9lOw=;
        b=qG1a3bJ0rpAB27MsxPCkGdch35hSj6iNBr5c0hoi9DFBJfjLdL+sBrPLSGV0WWXGt3SkN1
        IlgZAepRPquKFQSjkVnBgwjgfLsFqY8H8OnyxZ+MAj0t6s5CK5svYLv7VpRMqhjGge+xLA
        NqJ7tjgY5bsm5aoiakQT4bPrhwinWz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655300216;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=chlBcacfv6bDY7l9ADHEqVc0e2MMXp3Bc7SWxZo9lOw=;
        b=Tjphs/8pNqlDTkMTnuIL7gBZXnuK8rvaj8fb/ly6sHd42M/N20junSgmyyzJfj2P+uEywV
        rEBYjrUVncefjCBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99E4913A35;
        Wed, 15 Jun 2022 13:36:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0Gn1IXjgqWJgKAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 15 Jun 2022 13:36:56 +0000
Date:   Wed, 15 Jun 2022 15:32:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>, dsterba@suse.cz,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Filipe Manana <fdmanana@kernel.org>
Subject: Re: [PATCH] btrfs: Replace kmap() with kmap_local_page() in zstd.c
Message-ID: <20220615133222.GZ20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, Nick Terrell <terrelln@fb.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Filipe Manana <fdmanana@kernel.org>
References: <20220611135203.27992-1-fmdefrancesco@gmail.com>
 <1936552.usQuhbGJ8B@opensuse>
 <20220614142521.GN20633@twin.jikos.cz>
 <8952566.CDJkKcVGEf@opensuse>
 <YqjAVq+1PIpVIr0p@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YqjAVq+1PIpVIr0p@iweiny-desk3>
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

On Tue, Jun 14, 2022 at 10:07:34AM -0700, Ira Weiny wrote:
> On Tue, Jun 14, 2022 at 06:28:48PM +0200, Fabio M. De Francesco wrote:
> > On martedì 14 giugno 2022 16:25:21 CEST David Sterba wrote:
> > > On Tue, Jun 14, 2022 at 01:22:50AM +0200, Fabio M. De Francesco wrote:
> > > > On lunedì 13 giugno 2022 20:39:13 CEST David Sterba wrote:
> > > > > On Sat, Jun 11, 2022 at 03:52:03PM +0200, Fabio M. De Francesco 
> > > 
> 
> [snip]
> 
> > > > A better solution is changing the prototype of __kunmap_local(); I
> > > > suppose that Andrew won't object, but who knows?
> > > > 
> > > > (+Cc Andrew Morton).
> > > > 
> > > > I was waiting for your comments. At now I've done about 15 conversions 
> > > > across the kernel but it's the first time I had to pass a pointer to 
> > const 
> > > > void to kunmap_local(). Therefore, I was not sure if changing the API 
> > were 
> > > > better suited (however I have already discussed this with Ira).
> > > 
> > > IMHO it should be fixed in the API.
> > > 
> > I agree with you in full.
> > 
> > At the same time when you sent this email I submitted a patch to change 
> > kunmap_local() and kunmap_atomic().
> > 
> > After Andrew takes them I'll send v2 of this patch to zstd.c without those 
> > unnecessary casts.
> 
> David,
> 
> Would you be willing to take this through your tree as a pre-patch to the kmap
> changes in btrfs?
> 
> That would be easier for Fabio and probably you and Andrew in the long run.

Yes, no problem if the patch has an ack. I could probably send all the
kmap conversions after tests so it does not need to wait until the next
cycle.
