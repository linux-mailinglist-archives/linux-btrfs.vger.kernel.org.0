Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A715D5351E7
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 18:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345463AbiEZQPO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 12:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240675AbiEZQPL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 12:15:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69C96A056
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 09:15:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 328901F8CB;
        Thu, 26 May 2022 16:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653581709;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=31BJfVyvlu20Gtk4zJPEKiNQGYXg9ttwh0osyYG/sH0=;
        b=v79d6BDIqUf/eGULtZ5vI9wkdsSfvmvryR8o72QbHIGZQ7Ccp+cID2mRt0gIpBRGdDZhxe
        Nw31R1Zn9kBNo7WeuuFjPqNfSwLx3KBSf6IdieFJyI/kwwj3A717x4zoE9ZcjduvD9rv1j
        cjAwG9CXSgYkXhjxnijRUDZo3p39mVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653581709;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=31BJfVyvlu20Gtk4zJPEKiNQGYXg9ttwh0osyYG/sH0=;
        b=pQDPR12b7b0vbIZWQmG3hwxs9oTJ/K33Ihy2TTYErKWBXTM+MT39CSTyhPQ12mn/CKdeXF
        wVmcblr+oZmUuUBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED91213AE3;
        Thu, 26 May 2022 16:15:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F4/XOIynj2KxIwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 26 May 2022 16:15:08 +0000
Date:   Thu, 26 May 2022 18:10:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     kreijack@inwind.it
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, waxhead@dirtcellar.net,
        Christoph Hellwig <hch@infradead.org>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Message-ID: <20220526161045.GH22722@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, kreijack@inwind.it,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, waxhead@dirtcellar.net,
        Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <f6679e0b681f9b1a74dfccbe05dcb5b6eb0878f6.1653372729.git.wqu@suse.com>
 <20220524170234.GW18596@twin.jikos.cz>
 <Yo3wRJO/h+Cx47bw@infradead.org>
 <bd6ac4d4-41bf-f662-e7c0-7841895554a6@gmx.com>
 <Yo32VXWO81PlccWH@infradead.org>
 <b8cbcac2-7e8b-e0fd-67a9-8a782e0afe23@gmx.com>
 <9d1e2fc6-9ee6-68f8-bda8-8dd7e59e74e5@dirtcellar.net>
 <50cb070b-2e2e-1987-3726-1e67eaf060cf@gmx.com>
 <4fde1fb7-b6ea-c6e5-7c04-f6c19e031354@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fde1fb7-b6ea-c6e5-7c04-f6c19e031354@libero.it>
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

On Thu, May 26, 2022 at 05:30:16PM +0200, Goffredo Baroncelli wrote:
> On 26/05/2022 11.26, Qu Wenruo wrote:
> [...]
> > 
> > Deprecation needs time, and RAID56J is not a drop-in replacement
> > unfortunately, it needs on-disk format change, and is new RAID profiles.
> > 
> IIRC, the original idea was to dedicate a separate disk to the journal.

And was rejected as it would be the single point of failure for drive
setup that must survive failure of 1 or 2 devices.
