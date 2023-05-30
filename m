Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DED716CF0
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 20:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjE3S5d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 14:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjE3S5c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 14:57:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB7DF9
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 11:57:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BF0911F37F;
        Tue, 30 May 2023 18:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685473049;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FXeG5L/VRJoNAiIfX6XFq8udedTvR1V6hZ5Lg50rbjY=;
        b=fkHlpUXF1wMQTPSXGKO9vloGdjRcp1Z7NdZ1FP+oE0BSFJ3R4yaRX02pzJw3QgDwjd4TAT
        5MgXXdq9ZeiNYn6yJ/YAOemJr6wJR/aa5SfcNIGSGthLynf15Kwn85xeFPJighj7uzb3Oy
        x064h0C3fWL1VeTKLWnoHcOJqkhCfp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685473049;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FXeG5L/VRJoNAiIfX6XFq8udedTvR1V6hZ5Lg50rbjY=;
        b=chnUfUF4WFrWmV1EBfEQsfZineuKxWbZRBGUUbW06yDe5Z/AzgqBG0uNaW4xxtiQ7vxdXh
        0gWUWbbq28eJc5AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9EADE13597;
        Tue, 30 May 2023 18:57:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z3oBJhlHdmSQeQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 30 May 2023 18:57:29 +0000
Date:   Tue, 30 May 2023 20:51:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add back cgroup writeback support for metadata
Message-ID: <20230530185118.GC32581@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230530053936.104984-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530053936.104984-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 30, 2023 at 07:39:36AM +0200, Christoph Hellwig wrote:
> Commit c211fd861077 ("btrfs: don't use btrfs_bio_ctrl for extent buffer
> writing") removed support for cgroup association for metadata writeback.
> While cgroup interaction with metadata is somewhat questionable and not
> done by other file systems, any kind of change to this behaviour should
> not happen silently and under the hood, so bring it back.
> 
> Fixes: c211fd861077 ("btrfs: don't use btrfs_bio_ctrl for extent buffer writing")

Folded to the patch, thanks.
