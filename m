Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FF25533D4
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 15:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiFUNjy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 09:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351704AbiFUNjj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 09:39:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5DAB6E
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 06:39:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B787821C90;
        Tue, 21 Jun 2022 13:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655818752;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4lFAjYh/Ut/kaea3vmA6xhGdRrZJMQGdf2tKBPCYzP0=;
        b=qKhXdC/vIWWRNjNcbuARwLwNU+Xs5ZGTlSO4l3M3BT0dVlv2aSjtqtgzydn/+GLigbGeoh
        su5W9jB4qS6eB080jKEJVUln2vxuyQwCOgyxqUEIPVsUc/nAkIV4MTgBwMEaate75JcHQ2
        PaImtzmCSf71Z6IahE09rSGHcbc8iBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655818752;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4lFAjYh/Ut/kaea3vmA6xhGdRrZJMQGdf2tKBPCYzP0=;
        b=qqpuGIdkjkmJn3X13UkwTFaET2eD85ovkuxnvMHDfq3cdIhuEjmhhwZZCoNkRBgUC1xlmF
        UMt64s36UVpkf2DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 872CD13A88;
        Tue, 21 Jun 2022 13:39:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XwvSHwDKsWIlMwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Jun 2022 13:39:12 +0000
Date:   Tue, 21 Jun 2022 15:34:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: don't limit direct reads to a single sector
Message-ID: <20220621133435.GY20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <20220621062627.2637632-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621062627.2637632-1-hch@lst.de>
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

On Tue, Jun 21, 2022 at 08:26:27AM +0200, Christoph Hellwig wrote:
> Btrfs currently limits direct I/O reads to a single sector, which goes
> back to commit c329861da406 ("Btrfs: don't allocate a separate csums
> array for direct reads") from Josef.  That commit changes the direct I/O
> code to ".. use the private part of the io_tree for our csums.", but ten
> years later that isn't how checksums for direct reads work, instead they
> use a csums allocation on a per-btrfs_dio_private basis (which have their
> own performance problem for small I/O, but that will be addressed later).
> 
> There is no fundamental limit in btrfs itself to limit the I/O size
> except for the size of the checksum array that scales linearly with
> the number of sectors in an I/O.  Pick a somewhat arbitrary limit of
> 256 limits, which matches what the buffered reads typically see as
> the upper limit as the limit for direct I/O as well.
> 
> This significantly improves direct read performance.  For example a fio
> run doing 1 MiB aio reads with a queue depth of 1 roughly triples the
> throughput:
> 
> Baseline:
> 
> READ: bw=65.3MiB/s (68.5MB/s), 65.3MiB/s-65.3MiB/s (68.5MB/s-68.5MB/s), io=19.1GiB (20.6GB), run=300013-300013msec
> 
> With this patch:
> 
> READ: bw=196MiB/s (206MB/s), 196MiB/s-196MiB/s (206MB/s-206MB/s), io=57.5GiB (61.7GB), run=300006-300006msc
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Added to misc-next, thanks. I've renamed the constant to
BTRFS_MAX_BIO_SECTORS and updated the subject per Nikolay's suggestion.
