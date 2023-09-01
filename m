Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4A878FE3D
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Sep 2023 15:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjIANXe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Sep 2023 09:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjIANXe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Sep 2023 09:23:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714B8CC5
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Sep 2023 06:23:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2F153215EF;
        Fri,  1 Sep 2023 13:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693574608;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EYaICdOtxcQqxkgg73RTuUyGtIjHfhVU+wLT78C4aa0=;
        b=kjgkoUuoRwvOtQ8SF7cH0hOoW1xtBaCXGOlMC1DqWv/DLdaPzp51ucCh63NOtMY4H7Ma+q
        jn0PVsP/zDMLXUXBiy3PVLXaAJvY+qndJxOp4fbFL0uZWug838ZXn2IzKi+wxibvOKHJHJ
        mfFdldl7rSB+L0xSjsWpisvaFLFxC0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693574608;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EYaICdOtxcQqxkgg73RTuUyGtIjHfhVU+wLT78C4aa0=;
        b=1SuuNE+jwUEuXeGsHCPfQzxZfT8jKxErqN5nFB442XrC2QNN/UXcGkDqUUrSUxcfgbFeQx
        h665mDTFQt7AnXAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 139A313582;
        Fri,  1 Sep 2023 13:23:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O+L8A9Dl8WQdPwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 01 Sep 2023 13:23:28 +0000
Date:   Fri, 1 Sep 2023 15:16:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH v2 5/6] btrfs: qgroup: use qgroup_iterator facility to
 replace @tmp ulist of qgroup_update_refcnt()
Message-ID: <20230901131650.GL14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1693441298.git.wqu@suse.com>
 <ce02f493bf56e540679db37393a9ca243b20c012.1693441298.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce02f493bf56e540679db37393a9ca243b20c012.1693441298.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Please don't put the @ in the variable references in the subjects.

On Thu, Aug 31, 2023 at 08:30:36AM +0800, Qu Wenruo wrote:
> For function qgroup_update_refcnt(), we use @tmp list to iterate all the
> involved qgroups of a subvolume.
> 
> It's a perfect match for qgroup_iterator facility, as that @tmp ulist
> has a very limited lifespan (just inside the while() loop).
> 
> By migrating to qgroup_iterator, we can get rid of the GFP_ATOMIC memory
> allocation and no more error handling needed.
> 
> Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
