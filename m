Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9246F7DCBD5
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Oct 2023 12:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343734AbjJaL3h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Oct 2023 07:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjJaL3g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Oct 2023 07:29:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4CD91
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Oct 2023 04:29:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4AF0F21858;
        Tue, 31 Oct 2023 11:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698751772;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NpLltQkcNveShG8zKODztwYUPtboMhImXBjZGxpD1ac=;
        b=NmnPYFWTqBLicsW7uROp2RX7yOgb6nd9DCmAVZfWwxlPrgkqEp/wNLYcWL35wb3dOTpFnd
        78T0Ysot93+/Uqf1w+OxrTDK08m/YfPn9OttH/7oPKRTEH+7EYG92joOTy4wJ2TrUI+Im2
        FoFRazHeOw74KTv7ybBJ8woDYdBLEbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698751772;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NpLltQkcNveShG8zKODztwYUPtboMhImXBjZGxpD1ac=;
        b=cEQD5waiI3zkg9dhG9u/ZPFhkuHuArbcIYQXfCQsHzZ8tfaT6ze3g/m2AMj3gXaU+8rv0f
        TlcIftCdk7upFEBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2155D138EF;
        Tue, 31 Oct 2023 11:29:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EIYiBxzlQGXTKgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 31 Oct 2023 11:29:32 +0000
Date:   Tue, 31 Oct 2023 12:22:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [kdave-btrfs-devel:dev/guilherme/temp-fsid-v4] [btrfs]
 479361d32b: xfstests.btrfs.185.fail
Message-ID: <20231031112234.GA11264@suse.cz>
Reply-To: dsterba@suse.cz
References: <202310311425.c2e34aef-oliver.sang@intel.com>
 <f291309a-71d3-484b-a876-99382a61363d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f291309a-71d3-484b-a876-99382a61363d@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 31, 2023 at 05:23:18PM +0800, Anand Jain wrote:
> Thanks for the report.
> 
> >      +cloned device scan should fail
> 
> Your fstests is missing the following commit:
>     1348ed0e256a ("fstests: btrfs/185 update for single device pseudo 
> device-scan")
> Pls upgrade.

Yes for the fstests upgrade, but the tested branch is some old snapshot
of the temp_fsid feature, I don't even have the branch anywhere.
