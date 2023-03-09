Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9766B2C30
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 18:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjCIRkp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 12:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCIRkm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 12:40:42 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491ECFAAF3
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 09:40:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E895B201EC;
        Thu,  9 Mar 2023 17:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678383638;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5QaCz6HDD23eb5N+EZCgz4QILlsykPK2+vdSH8WKCdI=;
        b=eUxnelKpKZAvsRzXbOe1Xm5OGPKcCRbofdMsJtQn8/vdT4inb/MYU1DA1aGQ+bjTU9m8k5
        rE9OxXl+xO36SdaCElOgE7rI4D8sbeCCTY8Ud78c1qrRNyYzB5QMhVkkrrJZ3LAuDMc8RZ
        Lr63DvctuHC7xOSg2/4tVwHO4R7xu8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678383638;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5QaCz6HDD23eb5N+EZCgz4QILlsykPK2+vdSH8WKCdI=;
        b=WJ/7VxhyAS2QDPB7InVZMtzK59EOU5sjUjBNgaQP3JnZA1ohDLTFViQKtHVmXJGwNnkyW/
        RCogCgfQ1UnBAKCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C27DB13A10;
        Thu,  9 Mar 2023 17:40:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id c8anLhYaCmS1IQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 09 Mar 2023 17:40:38 +0000
Date:   Thu, 9 Mar 2023 18:34:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: improve type safety by passing struct btrfs_bio where possible v2
Message-ID: <20230309173434.GH10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230307163945.31770-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307163945.31770-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 07, 2023 at 05:39:35PM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> much of the btrfs I/O path work on a struct btrfs_bio but passes pointers
> to the bio embedded into that around.  This series improves type safety
> by always passing the actual btrfs_bio instead.
> 
> Changes since v1:
>  - fix commit message and commit typos

Added to misc-next, thanks.
