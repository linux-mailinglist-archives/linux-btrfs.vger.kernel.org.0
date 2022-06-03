Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF3553CD8A
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 18:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbiFCQvd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jun 2022 12:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343717AbiFCQvc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jun 2022 12:51:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A401A51E74
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Jun 2022 09:51:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 64F141F8D9;
        Fri,  3 Jun 2022 16:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654275090;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YIplXfFSz389qxq4EkSuv5/RTEf3ukqTDDZ2DB1JTME=;
        b=HjLggtBuN8FPvprjyjpbUFVokCNX/h7ZI8HXlQrpTGikCPHpZERqjVIh5m8M5hpSg3CVg3
        kVSDQI/eL8NWEYbc05VPflN8+JzQDDqNBC2lDJ0X628w6Ao1fJFDAjCunuDbjpaP+hBUHv
        N1D+NYqtt7Zg8ST79U9y9LiBBSEpv2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654275090;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YIplXfFSz389qxq4EkSuv5/RTEf3ukqTDDZ2DB1JTME=;
        b=fxOSSDQELopY7fIypuoyy/BhD7QCBR46A74qFnGVNytBWy7XEJhaD1ncXVRS+s6uYbFXdh
        0X2xSgiEc9NByNAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3573513AA2;
        Fri,  3 Jun 2022 16:51:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2moWDBI8mmKNTAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 03 Jun 2022 16:51:30 +0000
Date:   Fri, 3 Jun 2022 18:47:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: cleanup btrfs bio handling, part 2 v4
Message-ID: <20220603164703.GY20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220526073642.1773373-1-hch@lst.de>
 <20220601192929.GQ20633@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601192929.GQ20633@twin.jikos.cz>
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

On Wed, Jun 01, 2022 at 09:29:29PM +0200, David Sterba wrote:
> On Thu, May 26, 2022 at 09:36:32AM +0200, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series removes the need to allocate a separate object for I/O
> > completions for all read and some write I/Os, and reduced the memory
> > usage of the low-level bios cloned by btrfs_map_bio by using plain bios
> > instead of the much larger btrfs_bio.
> > 
> > Changes since v3:
> >  - rebased to the latest for-next tree
> >  - move "btrfs: don't double-defer bio completions for compressed reads"
> >    back to where it was before in the patch order
> 
> This is a prerequisite for the raid-repair patches so I've added it to
> for-next.

Moved to misc-next, thanks.
