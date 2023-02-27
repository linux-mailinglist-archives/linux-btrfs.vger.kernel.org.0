Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB40F6A4A3D
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 19:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjB0Srh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 13:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjB0Srg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 13:47:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C61F23336
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 10:47:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 37171218FC;
        Mon, 27 Feb 2023 18:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677523652;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6n4eNFlIpm4FIreAEG6LqmwRAsFaFPXeaXV6LAW1UoE=;
        b=wz3cytqI4bVCa97PZi3TJPtCmWAEXAkR3yx8d23jYlUtsQsfIZG1Q0OUvFRR+bZ4F6qbPF
        abdbUdEYmrhy9k3pYpskRcgxKfpTHlF1HcE729kkYd0fb6+GYIMcqIZvYTui82siRGSjCN
        hwuJSFnRU9FFLU4T46Ehy4oe8QvhUC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677523652;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6n4eNFlIpm4FIreAEG6LqmwRAsFaFPXeaXV6LAW1UoE=;
        b=42kO+qOEQ7/tXdxrt0nX7SNC22tujenKFPqREj0nqGKpBZSvcJ4XP5zsQADL5bcCFHOkjU
        Wp3jXdy9N3LWd0Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C16813A43;
        Mon, 27 Feb 2023 18:47:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Cyr0AcT6/GPvAgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 27 Feb 2023 18:47:32 +0000
Date:   Mon, 27 Feb 2023 19:41:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com
Subject: Re: [PATCH] btrfs: move all btree initialization into
 btrfs_init_btree_inode
Message-ID: <20230227184133.GF10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230219181022.3499088-1-hch@lst.de>
 <02026707-320e-5c2d-b35e-23290dfc36cc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02026707-320e-5c2d-b35e-23290dfc36cc@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 27, 2023 at 03:35:53PM +0800, Anand Jain wrote:
> On 2/20/23 02:10, Christoph Hellwig wrote:
> >   
> 
> Dave,
> 
>   This patch is causing a regression, as reported here:
> 
>  
> https://patchwork.kernel.org/project/linux-btrfs/patch/2de92bdcebd36e4119467797dedae8a9d97a9df3.1677314616.git.wqu@suse.com/
> 
>   There are many child functions in open_ctree() that rely on the default
>   value of @err, which is -EINVAL, to return an error instead of ret.
>   The issue is that @err is being overwritten by the return value of
>   btrfs_init_btree_inode() in this patch.
> 
>   To fix this issue, please fold the following diff into the patch.

Thanks. open_ctree has mixed the original and newish style of error
variables. In some btrfs functions but more widely seen in other VFS
code the error value is set once and the errors only go to return, while
what I think we should unify is the error set right before goto or
inherited from the call itself. It's a few lines more but the exact
error value is at the place where it happens and not somewhere in the
function and possibly changed on any line between. Feel free to clean up
open_ctree().
