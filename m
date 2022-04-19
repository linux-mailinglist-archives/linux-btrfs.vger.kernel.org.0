Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722B9506D3A
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 15:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352099AbiDSNNs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 09:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347234AbiDSNNq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 09:13:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73D53122E;
        Tue, 19 Apr 2022 06:11:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A224B21118;
        Tue, 19 Apr 2022 13:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650373862;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b/3K0pRlotaEfeU4+3K4eR5b2A9Pz6oNCQOD+UvB+zk=;
        b=Mwrfi3PuJtG3lF8zpNdohOuLyeCfFp0GdoKSmNwoxeFSgYwqo4zURKNJzPEVbz6voetTPp
        3yJkioCD3xtKVzBGaG4/gxc7sXRIO+IZp7sPtdwF7xDe8694fLmmBUVGEMcpnknsnSTk3R
        8Rpx29y+aqnwcAqss4uxns5R4MGMiHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650373862;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b/3K0pRlotaEfeU4+3K4eR5b2A9Pz6oNCQOD+UvB+zk=;
        b=YNXpRNTTh2slhKeGK8LbdSeunWutxGvrv/T/jdT76Q6855uZJBZ+0jj151T8EGr7laxjQu
        noHeFvTDSKLuxABg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65ADB139BE;
        Tue, 19 Apr 2022 13:11:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +voeGOa0XmJ8fwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 19 Apr 2022 13:11:02 +0000
Date:   Tue, 19 Apr 2022 15:06:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-doc@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, Schspa Shi <schspa@gmail.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: zstd: remove extraneous asterix at the head of
 zstd_reclaim_timer_fn() comment
Message-ID: <20220419130659.GD2348@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Bagas Sanjaya <bagasdotme@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-doc@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
        Schspa Shi <schspa@gmail.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220418125934.566647-1-bagasdotme@gmail.com>
 <Yl2Dx+jefYs1Un+8@localhost.localdomain>
 <b5b42b49-9d0c-c745-f355-89900b53f6e1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5b42b49-9d0c-c745-f355-89900b53f6e1@gmail.com>
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

On Tue, Apr 19, 2022 at 12:19:44PM +0700, Bagas Sanjaya wrote:
> On 4/18/22 22:29, Josef Bacik wrote:
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > 
> > Thanks,
> > 
> > Josef
> 
> Thanks for the review. Should I send v2 with your Reviewed-by
> tag?

No, and please don't send fixes for the kdoc formats, the script does
not have the same preferences as we who actually have to read the code.
The kdoc format is convenient for more thnigs than just generating
public documentation.
