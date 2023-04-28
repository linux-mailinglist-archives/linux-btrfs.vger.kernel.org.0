Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5EF6F1A41
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Apr 2023 16:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjD1OMI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Apr 2023 10:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjD1OMH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Apr 2023 10:12:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152FE83
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Apr 2023 07:12:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BCEE1200B4;
        Fri, 28 Apr 2023 14:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682691123;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4RSFePDUuso2V8irO/D4NoeMrMKuV5+jvJPdgH3Xu3g=;
        b=bBVvDf7hefiQkLcu9fTr9GJJz7ewmI/pSaLDWE9laZmotHePTagYqwQ4e/soscTfoWeZ8K
        hrx8Qvn+VFzqkrQYSd/Bc5Kq7ivkqMIki2sWRDNC3AQ3UyHOsewQw+8JRimzkymd01bM07
        Q8fuMFJVjKJqdRANd/uLSB4wX55mLco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682691123;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4RSFePDUuso2V8irO/D4NoeMrMKuV5+jvJPdgH3Xu3g=;
        b=uMq1U567qiCj7a8dw9edBkvUkfSp3AAEuTlMK0PObqkwFyIX1apjNQfVwxTGXob5j/WLsM
        dFHZqBRMB9YT6IDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 998371390E;
        Fri, 28 Apr 2023 14:12:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eoqzJDPUS2QQNQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 28 Apr 2023 14:12:03 +0000
Date:   Fri, 28 Apr 2023 16:06:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Forza <forza@tnonline.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: /sys/devices/virtual/bdi/btrfs-* entries
Message-ID: <20230428140610.GA2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <75de58ce-0c16-9fd0-dd64-a8d4a7214aa8@tnonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75de58ce-0c16-9fd0-dd64-a8d4a7214aa8@tnonline.net>
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

On Fri, Apr 28, 2023 at 12:08:24PM +0200, Forza wrote:
> Hi,
> 
> How do I find out to what Btrfs filesystem the entries in 
> /sys/devices/virtual/bdi belong to?

Each filesystem has a symlink to the BDI /sys/fs/btrfs/FSID/bdi, the
linked path is e.g. "bdi -> ../../../devices/virtual/bdi/btrfs-2/".
