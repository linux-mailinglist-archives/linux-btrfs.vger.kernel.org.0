Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D08D7AD9BB
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Sep 2023 16:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjIYOHs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Sep 2023 10:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjIYOHr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Sep 2023 10:07:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BB8107;
        Mon, 25 Sep 2023 07:07:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 208531F74A;
        Mon, 25 Sep 2023 14:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695650860;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AMw7FBB5qe0mlRxK2wqXnJTRx2GbUv3nRb0DDPszrUs=;
        b=cMhfXC/zh+hKnDx32Sy1DZ4ilJbAbJN6CVlKqzJn0fC0TVEfeDVXKnSnTs8sfmJn8nPxie
        1q40KO+6vP7zuk+yjI9rhpOUvBi7waLokEfOtDhQq+TAPmntQAsLfds+ZxOxKxj5NRiHvL
        J7p1fevLtAy4yaCyAxEqUPgJZRu/ujk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695650860;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AMw7FBB5qe0mlRxK2wqXnJTRx2GbUv3nRb0DDPszrUs=;
        b=0EzjpAvhUdMJ6O/5rhFrzBNPPPSSLPJYq0xAuYHVTu1wGrdHyIsxZ54Piasnfvczmcfw5T
        6tqkR7Tbi3A8sOBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBB081358F;
        Mon, 25 Sep 2023 14:07:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sGrrNCuUEWU5JwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 25 Sep 2023 14:07:39 +0000
Date:   Mon, 25 Sep 2023 16:01:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fdmanana@kernel.org, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: use full subcommand name at _btrfs_get_subvolid()
Message-ID: <20230925140102.GN13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <c0ebb36f51f97acb3612ec5376a68441b5e62ac6.1695383055.git.fdmanana@suse.com>
 <20230922171835.4fb6fc0c@echidna.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922171835.4fb6fc0c@echidna.fritz.box>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 22, 2023 at 05:18:35PM +0200, David Disseldorp wrote:
> On Fri, 22 Sep 2023 12:45:01 +0100, fdmanana@kernel.org wrote:
> 
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > Avoid using the shortcut "sub" for the "subvolume" command, as this is the
> > standard practice because such shortcuts are not guaranteed to exist in
> > every btrfs-progs release (they may come and go). Also make the variables
> > local.
> 
> Hmm, having them come and go would likely break quite a few user
> scripts...

The help text of 'btrfs' says at the end:

"For an overview of a given command use 'btrfs command --help'
 or 'btrfs [command...] --help --full' to print all available options.
 Any command name can be shortened as far as it stays unambiguous,
 however it is recommended to use full command names in scripts.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

 All command groups have their manual page named 'btrfs-<group>'."


The commands will not disappear but new commands may be added and the
prefix would become ambiguous. The short versions are accepted for
manual command typing convenience, scripts should use the full length.
