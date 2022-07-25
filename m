Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E6158039E
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 19:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbiGYRlY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 13:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiGYRlX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 13:41:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB741A399
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 10:41:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1A9B51FFA9;
        Mon, 25 Jul 2022 17:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658770880;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MEz5bN2bPmJBE3jBcfh8M/gojpuAn8iJ2g3bwDRx+Jg=;
        b=LagTQ40FlouTEmsJaQ+sFReVdhmNs/c2wedyD9Oap+Vj21M9GvJSpfg/SnaTi5pi/WX0mZ
        C9UKOGMbG481QnHjQZinPTQuOWyqnyvVoSLZCdK8vCwY9B2WADmRlYzLfDyvunHRCX4QQP
        BBMqeIuhsxXp0K85Txu7G5hnwO8CotA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658770880;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MEz5bN2bPmJBE3jBcfh8M/gojpuAn8iJ2g3bwDRx+Jg=;
        b=HECJliYPxBUgdPQ458Da7CBoQlJwATc1OKAwnUifWuvr1NI8O8yc9GXXb/qJgxGVcMivY3
        D3+3Eq+ZbA394oCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1BC613ABB;
        Mon, 25 Jul 2022 17:41:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CCclNr/V3mIkaAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 25 Jul 2022 17:41:19 +0000
Date:   Mon, 25 Jul 2022 19:36:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: error writing primary super block on zoned btrfs
Message-ID: <20220725173622.GC13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20220718054944.GA22359@lst.de>
 <YtVSBLTuRCED9mYb@casper.infradead.org>
 <PH0PR04MB74161E9598C27B8CEA10F53F9B8F9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220719151345.GA21932@lst.de>
 <20220719213241.GS13489@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719213241.GS13489@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 19, 2022 at 11:32:41PM +0200, David Sterba wrote:
> On Tue, Jul 19, 2022 at 05:13:45PM +0200, Christoph Hellwig wrote:
> > On Tue, Jul 19, 2022 at 07:53:45AM +0000, Johannes Thumshirn wrote:
> > > Ha but zoned btrfs uses two zones as a ringbuffer for its super-block, could
> > > it be, that we're accumulating too many page references somewhere? And then it
> > > behaves like having millions of filesystems mounted?
> > 
> > That fact the superblock moves for zoned devices probably has
> > something to do with it.  But the whole code leaves me really puzzling.
> > 
> > Why does wait_dev_supers even do a find_get_page vs just stashing
> > three page pointers away in the btrfs_device structure?
> 
> The superblock used to be written written using buffer heads, the
> current code is direct transformation of the buffer head API to bios, so
> it's still using page cache.
> 
> I've sent a patchset to write it with separate pages, but this breaks
> userspace as the reads are from page cache. This should be done by
> direct io, also I'll need more time to test it properly, the
> kernel/userspace interactions were missed initially.

I have wip (tests pass) that does the own page write, waiting using a
completion and own bio, ie. avoiding page cache. The super block read
side however uses page cache in several places. When a device is not
part of a mounted filesystem thre's no difference, no concurrent writers
and readers, but for zoned mode it is a problem in one cases, when both
zones are full and the older needs to be determined by reading the
superblock.

This happens on a mounted filesystem and it's read and write so it needs
to be converted to own page read too so I can't merge the write part
as-is. Maybe there's a middle ground, but otherwise the page cache based
read requires restructuring as it's done accross several functions.
