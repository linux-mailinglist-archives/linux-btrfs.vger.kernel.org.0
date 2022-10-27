Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F9C60F9F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 16:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbiJ0OCW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 10:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbiJ0OCV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 10:02:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C9317F646
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 07:02:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BF88521BAB;
        Thu, 27 Oct 2022 14:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666879338;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NX6lnI8RCKyBzWxX0jPAc4vOjRkzTbu/3xGb1feq3L0=;
        b=YmH95Ci4EWOkj7dGkrTz0eAKGz6JbARGynfNIV1cbsQwwiC5hmp8JzbQxEH7Yqq7yKTBDL
        ZVhAptLgZhxLOPn4GBwefuyazUHynV0O54ihwaKE6QzosqAjqTR1vjsSwXYRE0fFUP9PMU
        FqnU8cTKQtdJ06FjI/bfSWUNPlmtOuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666879338;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NX6lnI8RCKyBzWxX0jPAc4vOjRkzTbu/3xGb1feq3L0=;
        b=chRy8hPO6O1yUVukAGDMUOQHQQzQ+uvEYpO1GEXzFyo+Zb3MauvBopQAenxgflmrjvsAQ+
        JAMgoKVtf/l7DKBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9975513357;
        Thu, 27 Oct 2022 14:02:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id foSqJGqPWmMKAgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 27 Oct 2022 14:02:18 +0000
Date:   Thu, 27 Oct 2022 16:02:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     kernel test robot <lkp@intel.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 26/26] btrfs: move orphan prototypes into orphan.h
Message-ID: <20221027140203.GV5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <839fac08903cd0fea21bb8dacb2506332bae03c7.1666811039.git.josef@toxicpanda.com>
 <202210270425.wQZsi08p-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210270425.wQZsi08p-lkp@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 27, 2022 at 04:52:06AM +0800, kernel test robot wrote:
> 
> All warnings (new ones prefixed by >>):
> 
> >> fs/btrfs/orphan.c:9:5: warning: no previous prototype for 'btrfs_insert_orphan_item' [-Wmissing-prototypes]
>        9 | int btrfs_insert_orphan_item(struct btrfs_trans_handle *trans,
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~
> >> fs/btrfs/orphan.c:30:5: warning: no previous prototype for 'btrfs_del_orphan_item' [-Wmissing-prototypes]
>       30 | int btrfs_del_orphan_item(struct btrfs_trans_handle *trans,
>          |     ^~~~~~~~~~~~~~~~~~~~~

Missing #include "orphan.h" in orphan.c, fixed.
