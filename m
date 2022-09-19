Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDA25BD658
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 23:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiISV1s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 17:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiISV1r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 17:27:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206E84D26B
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:27:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BD26C22038;
        Mon, 19 Sep 2022 21:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663622863;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0WH34vFQXptjOf8gVtvuplCKLwef1zS/Qj6raD0/Ok8=;
        b=zQ8RLF6YSDmYWccaDNIz5uKlMQUrd4MCrLwHj1N4B7+H9mJAOxdjsV4Ke+kfD51AHOfPs7
        tOEmj/dSB2TmZU5s8ijDB6PxgVXuPruCFdye7gwh2EuPUPUtCg8MlTlxJNb0iOD52UIXe3
        roLh60J2WGR+8HB8DkQe/W5Gejg1NLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663622863;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0WH34vFQXptjOf8gVtvuplCKLwef1zS/Qj6raD0/Ok8=;
        b=iug8C2jbKuoEGZ6N+HVXKho+2iaaqv7QIGr1jIOkaBGDZPFGD1d7mGeOQ9P6e3L9JDNCrx
        R7oJjiqifRViyWAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 988BE13A96;
        Mon, 19 Sep 2022 21:27:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5oJ1I8/eKGMSfwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 19 Sep 2022 21:27:43 +0000
Date:   Mon, 19 Sep 2022 23:22:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 07/15] btrfs: move btrfs_swapfile_pin into volumes.h
Message-ID: <20220919212212.GV32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663196541.git.josef@toxicpanda.com>
 <be6105cf39b5ff328622fb4b7003beac385f4f28.1663196541.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be6105cf39b5ff328622fb4b7003beac385f4f28.1663196541.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 14, 2022 at 07:04:43PM -0400, Josef Bacik wrote:
> This isn't a great spot for this, but one of the swapfile helper
> functions is in volumes.c, so move the struct to volumes.h.  In the
> future when we have better separation of code there will be a more
> natural spot for this.

Some if the swapfile is in inode and it shares several callbacks for the
inode ops so that's probably the right place but to move things out of
ctree.h it can be in volumes.h as we don't have inode.h yet.
