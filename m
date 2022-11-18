Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6048D62F6CF
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Nov 2022 15:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242053AbiKROHy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Nov 2022 09:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiKROHx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Nov 2022 09:07:53 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830CE5DBBB
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Nov 2022 06:07:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 36DA61FAAF;
        Fri, 18 Nov 2022 14:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668780471;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YhDbH3jRNBWjbw8HCh9dE3SN2EFdFOjB9WxfupJFrTg=;
        b=mhxaRC66N4aXhweJjrbPyBOZzvJeKvNEgVOkT0DJr2FlT4mWmdDia1YDqrtnakO8I6fq7f
        vC7K7OiSzItEPcEssB9WUuAJWsPubeR7Zr9hJsuUIsLl17kNyENzEd4GVqIAh8lmpBEXk8
        ryHQxTkbnXIggRcoq06KVpSFeoSfcik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668780471;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YhDbH3jRNBWjbw8HCh9dE3SN2EFdFOjB9WxfupJFrTg=;
        b=UVUGqjpZOozzfSm+d9+7SJ6cVS774E+DYBI8FNAjVOgzG0Hqfhn7oPkX+0Lu+6tBzgKbQB
        nDg3YBUxnp8Rm5AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 019941345B;
        Fri, 18 Nov 2022 14:07:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LnHcOraRd2MXPgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 18 Nov 2022 14:07:50 +0000
Date:   Fri, 18 Nov 2022 15:07:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: move struct btrfs_tree_parent_check out of
 disk-io.h
Message-ID: <20221118140722.GO5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221115094407.1626250-1-hch@lst.de>
 <20221115094407.1626250-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115094407.1626250-2-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 10:44:04AM +0100, Christoph Hellwig wrote:
> Move struct btrfs_tree_parent_check out of disk-io.h so that volumes.h
> an various .c files don't have to include disk-io.h just for it.

Splitting that from disk-io.h makes sense but why creating a new file
that has just the one structure? We have the tree-checker.h that seems
like a place for various checks so I'll move it there.
