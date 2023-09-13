Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB7579E6C1
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 13:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240193AbjIMLaP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 07:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240129AbjIMLaN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 07:30:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35F419AF;
        Wed, 13 Sep 2023 04:30:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 99A4F1F390;
        Wed, 13 Sep 2023 11:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694604608;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bqo0LMzZdAxqn5nqemfUNx3l7LfnmUF9NaJushiU/Rc=;
        b=2BO6RbHWmysyd1EC8mYK9fXZSCzYK7OiUhk4ChVGLGJItm3OSvafRQMiosEPynAbANzCQc
        nQf8vHPLlbz5LjXTAORbk8TRgv8dBxU7cAJ5jvXbYjxDIIkfqjd4ivPd1i0Y1i4+602A8v
        aiam10YaBtoTvvhUixpuC14BjrRsYcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694604608;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bqo0LMzZdAxqn5nqemfUNx3l7LfnmUF9NaJushiU/Rc=;
        b=pFWT22stwK94WXrjmUIwzgXUQgWosGBqJBEP5GNpI54UVyx8z2C9WZZm9CQ9PsHMgUV1fH
        1Fn27wDu+5ersKCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63B4913582;
        Wed, 13 Sep 2023 11:30:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k0x8F0CdAWUqBwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 13 Sep 2023 11:30:08 +0000
Date:   Wed, 13 Sep 2023 13:30:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] btrfs: Remove some unused functions
Message-ID: <20230913113006.GI20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230913094327.98852-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913094327.98852-1-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 13, 2023 at 05:43:27PM +0800, Jiapeng Chong wrote:
> These functions are defined in the qgroup.c file, but not called
> elsewhere, so delete these unused functions.
> 
> fs/btrfs/qgroup.c:149:19: warning: unused function 'qgroup_to_aux'.
> fs/btrfs/qgroup.c:154:36: warning: unused function 'unode_aux_to_qgroup'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6566
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Added to misc-next with some wording adjusments and reference to the
patch that removed the last use, thanks.
