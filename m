Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B2756A5BF
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 16:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbiGGOpE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 10:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbiGGOpD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 10:45:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C5626115
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 07:45:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D24851FDE9;
        Thu,  7 Jul 2022 14:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657205101;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eE2znir9Xqfn9Xe4Hv4HcvZAWEixlRS/AB69Zl2r694=;
        b=xqsUbbBp66GwiWIAfC5vbJ5czy20eitB40+MP2eFFcoThpelTWaUHQbLnAPqArH+2ZJpR9
        SDJk19s7pg9fR1wrny7sg8kgukW4Vpsss9jC83BSC69Hygjs4v57vl0hPhKMVKufQcLwtl
        intdIGw0LBNU1YlGYiwhTZVP4GOxRpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657205101;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eE2znir9Xqfn9Xe4Hv4HcvZAWEixlRS/AB69Zl2r694=;
        b=bpNEmTAdCER7a3lmC2kpQnWTTO2GtS6xlnnOqsGeT/54udBT1GU4sV4v0nrFmFyrEOkSvj
        g+gWNDxLkfBX71Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94ACE13461;
        Thu,  7 Jul 2022 14:45:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y3BjI23xxmJ6OAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Jul 2022 14:45:01 +0000
Date:   Thu, 7 Jul 2022 16:40:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com
Subject: Re: [btrfs]  638ab1768a:  aim7.jobs-per-min 6.2% improvement
Message-ID: <20220707144015.GD15169@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        kernel test robot <oliver.sang@intel.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com
References: <YsGZXV7qW6bedSlc@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsGZXV7qW6bedSlc@xsang-OptiPlex-9020>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 03, 2022 at 09:27:57PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed a 6.2% improvement of aim7.jobs-per-min due to commit:
> 
> 
> commit: 638ab1768a6abb9b1280783e93a3de9a95f23af8 ("btrfs: remove redundant check in up check_setget_bounds")
> https://github.com/kdave/btrfs-devel.git dev/send-v2-my-wip

Though it's on some development branch, the patch has been added to
misc-next as well and the perf improvement is on par with the estimate
5% for metadata heavy workloads. Thanks.
