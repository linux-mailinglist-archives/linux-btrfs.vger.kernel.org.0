Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4635C5F3F23
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Oct 2022 11:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiJDJEM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Oct 2022 05:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJDJEK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Oct 2022 05:04:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F6E356D7
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Oct 2022 02:04:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4404A219C2;
        Tue,  4 Oct 2022 09:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664874248;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BObiFHlhN8HvKfjc2vGGP/JLWM2EciamI/w2keEUijI=;
        b=Eol7nED25ZOTAqmf7k/K5s/ijmq3hJq7qPgZYaLeBXpQblwvqEnDjYB/M45IafMXCJ0Rt3
        Kdg7PcGEr8YvK4DJOF2eHkj8RQUbhENE0IHNImbDWKuPHopCG787hWv3YkUuH4RXVzBs42
        lqfLrNafJCRKuTxJ9cJJgMFybncMQVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664874248;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BObiFHlhN8HvKfjc2vGGP/JLWM2EciamI/w2keEUijI=;
        b=u2C3VyaQzpbv/UaE73KtGNJ5od2WwJfDU6ERlAItOsTVL7dDrh907cMDRUPC7//0Yw13tE
        iTXl0NZOqLzoLDDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26821139D2;
        Tue,  4 Oct 2022 09:04:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uPBVCAj3O2OQYQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 04 Oct 2022 09:04:08 +0000
Date:   Tue, 4 Oct 2022 11:04:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: mkfs: --rootdir related fixes
Message-ID: <20221004090406.GJ13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1664869157.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1664869157.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 04, 2022 at 03:43:37PM +0800, Qu Wenruo wrote:
> I don't know if it's recent kernel tmpfs change or something else, but
> I'm consistently get ino number smaller than 256 from my /tmp directory.
> 
> This behavior change exposed a new problem in mkfs.btrfs --rootdir, that
> if some ino number (in the source directory, not in btrfs) is smaller
> than 256, it can screw up the backref code.
> 
> As backref code is utilizing @owner to determine if a backref is data or
> metadata.
> 
> And inode number smaller than 256 will make backref code to treat a data
> backref as tree backref, and cause corruption.
> 
> Thankfully this should not happen that easily, only when --rootdir
> points to a newly created fs.
> 
> Qu Wenruo (2):
>   btrfs-progs: properly initialized extent generation for
>     __btrfs_record_file_extent()
>   btrfs-progs: avoid fs corruption if rootdir contains ino smaller than
>     BTRFS_FIRST_FREE_OBJECTID

Added to devel, thanks.
