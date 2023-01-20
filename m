Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7A3675D28
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jan 2023 19:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjATSzb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Jan 2023 13:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjATSza (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Jan 2023 13:55:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E3C518FB
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Jan 2023 10:55:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A00ED337CD;
        Fri, 20 Jan 2023 18:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674240928;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rsOOsuZp1nNbO6aOM5J3YnoEuqqVh5aedU76KUMgK8A=;
        b=xU66ILRifEkybTFf8vk96SSCDTdyHJo9duwkQi9RvrYReRGhp71pRinGYic6JMFMuxMIeS
        YnLJee0RQDW9H9DlHO0TUgZS4mRc50e7/v574MbG+ILblloC0m81atE9B+yNuxZEaBePxs
        SBoNsb7M7LkEUOSqs4kmiFR3dtS+ppQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674240928;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rsOOsuZp1nNbO6aOM5J3YnoEuqqVh5aedU76KUMgK8A=;
        b=fq59CXwqldsggV+EFBZvoGI1SYCpJgYB/XTFppOYymBWNfUl7AMm42hOtE46dktsmDnS6b
        jAlBA538Kglq2nCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8372E1390C;
        Fri, 20 Jan 2023 18:55:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4mciH6DjymN6bwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 20 Jan 2023 18:55:28 +0000
Date:   Fri, 20 Jan 2023 19:49:48 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: question about copy_file_range() between btrfs filesystem.
Message-ID: <20230120184948.GN11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230111164513.85BA.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111164513.85BA.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 11, 2023 at 04:45:14PM +0800, Wang Yugui wrote:
> Hi,
> 
> question about copy_file_range() between btrfs filesystem.
> 
> test progam:
> 	attachment file(copy directly from 'man copy_file_range')
> 
> test result:
> kernel: 6.1.4
> 1)in/out files in single btrfs subvol: OK
> 
> 2)in/out files in single btrfs filesystem, but different subvols: OK
> 
> 3)in/out files in different btrfs filesystems: ERROR Invalid cross-device link
>    but as a compare, in/out files in different nfs filesystems(in same server): OK.
> Question: 
> Should we support copy_file_range() between btrfs filesystem?

I think NFS has some fallback if the source and target files are not on
the same underlying filesystem. There's and article about the semantics
of copy_file_range https://lwn.net/Articles/846403/ .
