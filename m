Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46A860F746
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 14:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbiJ0Maz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 08:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbiJ0Mav (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 08:30:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4104F1BF;
        Thu, 27 Oct 2022 05:30:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 70A851F894;
        Thu, 27 Oct 2022 12:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666873847;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oZtW6t7qpMz2Q3EC1RBI6cmBWiP4lX9451/oMgLPiJU=;
        b=rv/nIuFO1Fs5yVeG1jNQcXmR0iEf8REDZc9NGJW4hN2Ap5fHG408/qaBXrfbuC/UO6bWhZ
        T1M6MeOD6RzSXYklRZKlVcbKXowpY/OLhYj84fXkRcExvGE3vl0Hwh+wuqbhSCTR726Llj
        lOlSSWB0WZCxKzxUuy7PQuY4ae6oJ7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666873847;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oZtW6t7qpMz2Q3EC1RBI6cmBWiP4lX9451/oMgLPiJU=;
        b=vQ4RqDVcnBLYGPnJzlnfSI/Ab90eVLtfMlRh4fLQX0vrvH39Sw1j9qSZnzufquHpcVnEnX
        bd4scyc+onsSLaAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3DFD0134CA;
        Thu, 27 Oct 2022 12:30:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ycs2Dvd5WmMwSQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 27 Oct 2022 12:30:47 +0000
Date:   Thu, 27 Oct 2022 14:30:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH 2/2] btrfs: Fix kernel-doc
Message-ID: <20221027123032.GT5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221027062014.54543-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027062014.54543-1-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 27, 2022 at 02:20:13PM +0800, Jiapeng Chong wrote:
> No functional modification involved.
> 
> fs/btrfs/ordered-data.c:169: warning: expecting prototype for Add an ordered extent to the per(). Prototype was for btrfs_add_ordered_extent() instead.

Thanks, I've sent patch that fixes all the kdoc formatting so we don't
get any more warnings.
