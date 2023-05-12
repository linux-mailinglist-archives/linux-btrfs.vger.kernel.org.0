Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE40970026F
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 May 2023 10:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbjELIYJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 May 2023 04:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239702AbjELIYH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 May 2023 04:24:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CBB40CD;
        Fri, 12 May 2023 01:24:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6167A2041F;
        Fri, 12 May 2023 08:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683879845;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vV07uXNMEj6WjHkpgam2bBmyW9XUPev2ClTdp3hRFtE=;
        b=xpse7BMQIQVzPwXx/ywRg7Uk51b0lEfVMMyxQhnFHiLdXf95+wMb7V1krSNHcC1wnYlXWI
        1hblL+E3lJ8wwG4L1u2+nD1v/69iC+bCPV62qdmvuaSDkNKaiZQPhZg8UcYyls4kLkD98G
        1s/Cxly5w91DcJiGxgkeOtVPHbN6sW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683879845;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vV07uXNMEj6WjHkpgam2bBmyW9XUPev2ClTdp3hRFtE=;
        b=XDadI6EEFozz//mdJYlwJ8ihf11fjupo5j/srx/24eIBRqfb7hh1D76bDrlQqUAUF+GukZ
        Kuc/ihH7yB9XkBBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30E3B13466;
        Fri, 12 May 2023 08:24:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MY04C6X3XWSHIAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 12 May 2023 08:24:05 +0000
Date:   Fri, 12 May 2023 10:18:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] btrfs: delete a stray tab in can_finish_ordered_extent()
Message-ID: <20230512081804.GD32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a145fa32-2095-455f-a9a1-d06d9e785e55@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a145fa32-2095-455f-a9a1-d06d9e785e55@kili.mountain>
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

On Fri, May 12, 2023 at 10:55:56AM +0300, Dan Carpenter wrote:
> This line was indented one tab too far.

Thanks, fixed.
