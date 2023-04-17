Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B786E5541
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 01:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjDQXeR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 19:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjDQXeN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 19:34:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AF64C1C;
        Mon, 17 Apr 2023 16:34:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 250B61F8AE;
        Mon, 17 Apr 2023 23:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681774444;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=leTQL18F1Tn2ybzMbvoVO+R6xEzsqFDUeQlVzIbDOTg=;
        b=I/dTBagnPt5dvYY8IN+XEdaKVuAcq1XnqegniPo4wSRgHotkAmBgmh2XlN5HYBXy00JtQ+
        efEzemBcqwHFFmPUC61RmZX/KCvBSko9j2pSliPxUIYBeU+UOKRdQpXlwvAy940LOLhNNZ
        ZEDDlW1dlh/lePpRhPUwOMlyWGI2H0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681774444;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=leTQL18F1Tn2ybzMbvoVO+R6xEzsqFDUeQlVzIbDOTg=;
        b=vcGbpc6uunKg/9hLcHU96HOVIcM/9nSncirZ8AIEw7Wmr2FM3eG15axCdVfRVkAepJsVlF
        cN+7Z19xl1CNr5Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DFF4713319;
        Mon, 17 Apr 2023 23:34:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CsbZNWvXPWQRGAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 17 Apr 2023 23:34:03 +0000
Date:   Tue, 18 Apr 2023 01:33:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     xiaoshoukui <xiaoshoukui@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoshoukui <xiaoshoukui@ruijie.com.cn>
Subject: Re: [PATCH v2] btrfs: ioctl: ASSERT in btrfs_exclop_balance should
 also check for NONE and BALANCE PAUSED status.
Message-ID: <20230417233355.GQ19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230413095507.10620-1-xiaoshoukui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413095507.10620-1-xiaoshoukui@gmail.com>
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

On Thu, Apr 13, 2023 at 05:55:07AM -0400, xiaoshoukui wrote:
> Cocurrently issue add device requests, btrfs_exclop_balance in
> btrfs_ioctl_add_dev can race to btrfs_exclop_finish or itself.
> 
> Link: https://lore.kernel.org/linux-btrfs/20230324031611.98986-1-xiaoshoukui@gmail.com/

I've combined both patches into one and updated the changelog.
> 
> ---

If you write the above --- then 'git am' drops the rest until the diff,
this part is meant for version-to-version changelog as you did it but it
also has information that should have been in the changelog.

Added to misc-next, thanks.
