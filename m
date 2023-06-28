Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816D5741AA9
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 23:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjF1VWX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 17:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjF1VVr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 17:21:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCE43584
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 14:16:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C5B8F21860;
        Wed, 28 Jun 2023 21:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687987017;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yK9VuRE5cla+EkV/Ik5XV40bpTG0fs1if5Q3nk/LNzw=;
        b=QXAYKLwh/SVPIH76gu82hc6ANk4+KFCGb/ewJZhoq6Q8t+xt9wYFAt6NsqkV3FpdJib7gc
        Jt1+28zYD7Q7Wk1qDq51Fm/WZihG1qPBg2rUt4MziQrIAlk1YPxTlEuuxkrLHG1i7swiqv
        LAgsuM+0wCYo6Ywf3pY6l+YaZUkdomY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687987017;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yK9VuRE5cla+EkV/Ik5XV40bpTG0fs1if5Q3nk/LNzw=;
        b=JMKNgLdM/ZCrdzBnJhL0IqAcs3m/Q+Z3XVt+0Z+HgWoBilPbbHfZor7HYvk9A0w/jXWb/d
        mZATJns2+3itHvAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACE9E138EF;
        Wed, 28 Jun 2023 21:16:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6nVOKUmjnGRTUwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 28 Jun 2023 21:16:57 +0000
Date:   Wed, 28 Jun 2023 23:10:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2 v2] btrfs-progs: tests: fix no acl support
Message-ID: <20230628211029.GE16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1687419918.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687419918.git.anand.jain@oracle.com>
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

On Thu, Jun 22, 2023 at 04:18:10PM +0800, Anand Jain wrote:
> v2:
>  Works on David's comments regarding function names.
>  Also use /proc/config.gz to verify ACL support and
>  merging individual test case fixes into a single patch.
> 
> 
> Btrfs ACL support is a compiling time optional feature, instead of
> failing the test cases, let them say notrun. This set fixes it.
> 
> Patch 1/2 is preparatory adds helper to check for btrfs acl support.
> Patches 2/2 are actual fixes.
> 
> Thanks.
> 
> Anand Jain (2):
>   btrfs-progs: tests: add helper check_kernel_support_acl
>   btrfs-progs: tests: check for btrfs ACL support

Added to devel, thanks. I'll queue the kernel part for 6.6.
