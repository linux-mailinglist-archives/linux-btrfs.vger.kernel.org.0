Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621A350EC41
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Apr 2022 00:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiDYWuI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 18:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiDYWuH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 18:50:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0BA113CA0
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 15:47:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 457761F385;
        Mon, 25 Apr 2022 22:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650926820;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1YxWau0EwmEDMyKF1awhkiQTXmH3WZRZ0f/KrdYlNYM=;
        b=kwmWv8YLU2mxjfTo6+9lvYwVUBbuWrvfD+kqyi3CjMzyxtsKJ2PO5tZxFCD/+W8t0HMGgT
        tS9vrNcYklkizeUUQ1nEx2nGpghi+4Jo2TQPxj8N8A5OTtUcr5E2K5Ia/fHVnJOhDnnh+7
        Z/C5Wp+rF0oWOSZi0DzakIRZacipFVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650926820;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1YxWau0EwmEDMyKF1awhkiQTXmH3WZRZ0f/KrdYlNYM=;
        b=VmCDzszYyIN//4KyyKztCKk3jnOxmq9Kmj/x9w4HvL4Xnafbz68fz3tjTcaH0jlwAOhOaQ
        QYFsWaZ8nPY5uqDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23FEF13AE1;
        Mon, 25 Apr 2022 22:47:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JjbtB+QkZ2JAVQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 25 Apr 2022 22:47:00 +0000
Date:   Tue, 26 Apr 2022 00:42:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: fsck-tests: check warning for seed and
 sprouted filesystems
Message-ID: <20220425224253.GU18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1650180472.git.wqu@suse.com>
 <c1c97aca3ca89edfb23788858d186a50ed80d488.1650180472.git.wqu@suse.com>
 <20220425170408.GR18596@twin.jikos.cz>
 <57d6192b-e1fd-bd14-d869-d03559c34eb1@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57d6192b-e1fd-bd14-d869-d03559c34eb1@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 26, 2022 at 06:44:04AM +0800, Qu Wenruo wrote:
> > This won't work as intended, there's a helper _mktemp_dir that creates a
> > temporary directory, otherwise --tmpdir is interpreted as the direcotry
> > name.
> 
> My bad, it should be mktemp without the "_" prefix, just like what we
> did in all the run* helpers.
> 
> And I'm not expected to create a directory, thus I don't need to
> _mktemp_dir.

Right, I figured it later and dropped the _dir name and verified it
works.
