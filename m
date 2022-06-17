Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DD254F944
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 16:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382598AbiFQOg1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 10:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382594AbiFQOg0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 10:36:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB84E56211
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 07:36:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 985051F86A;
        Fri, 17 Jun 2022 14:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655476583;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vRcEMM3wHHBXVvQgY8J4KGQcFEe+9hwmPFpVljsJbcU=;
        b=nqJUTsNbiOuS7MrCVuxhRd4LqYxTYty0W/mpocHUunjRunfnoKIA878xxKdaE4KJFNhnKT
        QJJTxfwskeEXPab+Zw4h1C0mDgMjYIN46smdX5PC0e5zmBihUcW4BQABIeomcZ9EmR0PH+
        dPwAAKKjIt/3FFhVideOcNongPb9R8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655476583;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vRcEMM3wHHBXVvQgY8J4KGQcFEe+9hwmPFpVljsJbcU=;
        b=NItpdBSzQIjm1CR1yfWhGXwZaAFe4cHoi572LemKYRzO9qosDJmHszqHzqIfSwP1L9zqIO
        J6ICBKE5eRYS57DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B1491348E;
        Fri, 17 Jun 2022 14:36:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rD3SGGeRrGJEMwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 17 Jun 2022 14:36:23 +0000
Date:   Fri, 17 Jun 2022 16:31:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, nborisov@suse.com
Subject: Re: [PATCH] btrfs: don't limit direct reads to a single sector
Message-ID: <20220617143148.GM20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, nborisov@suse.com
References: <20220616080224.953968-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616080224.953968-1-hch@lst.de>
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

On Thu, Jun 16, 2022 at 10:02:24AM +0200, Christoph Hellwig wrote:
> Btrfs currently limits direct I/O reads to a single sector, which goes
> back to commit c329861da406 ("Btrfs: don't allocate a separate csums
> array for direct reads") from Josef.  That commit changes the direct I/O
> code to ".. use the private part of the io_tree for our csums.", but ten
> years later that isn't how checksums for direct reads work, instead they
> use a csums allocation on a per-btrfs_dio_private basis (which have their
> own performane problem for small I/O, but that will be addressed later).
> 
> Lift this limit to improve performance for large direct reads.  For
> example a fio run doing 1 MiB aio reads with a queue depth of 1 roughly
> tripples the throughput:
> 
> Baseline:
> 
> READ: bw=65.3MiB/s (68.5MB/s), 65.3MiB/s-65.3MiB/s (68.5MB/s-68.5MB/s), io=19.1GiB (20.6GB), run=300013-300013msec
> 
> With this patch:
> 
> READ: bw=196MiB/s (206MB/s), 196MiB/s-196MiB/s (206MB/s-206MB/s), io=57.5GiB (61.7GB), run=300006-300006msc

Nice catch, thanks.

Nikolay, you did some experiments with larger dio, but IIRC it was on
the bio layer. This looks like a fix for the same issue but I'm not
sure.
