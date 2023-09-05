Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A48E792589
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 18:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbjIEQDL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354722AbjIENuw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 09:50:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0A31A7
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 06:50:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F0FF01FE06;
        Tue,  5 Sep 2023 13:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693921845;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=le7+7klQLwaz+uVKcVRhD0jfka86v28w5zO3LxpMa+8=;
        b=u4geV6DEtyd60ZPGmD21Z9C2N4+jO73FdCWMWl4nLXzY36ahe40bVayUtH9kncJ69Sj/YG
        46RFQDhw25SM+eUUV+KYOBh14d9gt0zvNXMljs+J8q/Zj76vX1NSOauddqZuG1oI9a/y6d
        KzB89iktV/BQ7TPyFTyEZDRDgFszbYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693921845;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=le7+7klQLwaz+uVKcVRhD0jfka86v28w5zO3LxpMa+8=;
        b=A/gr2aPeFP/b/5Jyi4a49VbTEHSJcbWSWD3NiI6g6rcGLB7o7E7Z7UodJMjybgEfhPEKW9
        rGW5FDK4LmKH/oDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3F0A13499;
        Tue,  5 Sep 2023 13:50:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3XsBMzUy92SoQgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 05 Sep 2023 13:50:45 +0000
Date:   Tue, 5 Sep 2023 15:44:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 12/12] btrfs: remove extraneous includes from ctree.h
Message-ID: <20230905134406.GA14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1692994620.git.josef@toxicpanda.com>
 <15d63abd06cb64b7edc83d033e65ca00a2bae3ba.1692994620.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15d63abd06cb64b7edc83d033e65ca00a2bae3ba.1692994620.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 25, 2023 at 04:19:30PM -0400, Josef Bacik wrote:
> We don't need any of these includes in the ctree.h header file for the
> header file itself, remove them to clean up ctree.h a little bit.

While the include reduction is nice, we still don't have the includes
for everything ctree.h uses, e.g. spinlock_t, mutex, pid_t, rb_tree and
maybe more. It's not critical as long as it compiles and we have the
includes entangled too much so incremental updates work better. The tool
include-what-you-use can print the recommendeations for adding and
removing includes but it can get confused by direct includes by command
line -include. I did a pass for btrfs-progs, desiable for kernel too.
