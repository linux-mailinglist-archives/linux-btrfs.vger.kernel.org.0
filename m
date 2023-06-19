Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D50C735D8B
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jun 2023 20:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjFSSmR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jun 2023 14:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFSSmQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jun 2023 14:42:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A14FC
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jun 2023 11:42:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 263EC211C2;
        Mon, 19 Jun 2023 18:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687200131;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uz6lAOdCQ2N2gTr/jwwl321sH/3tOB8vo9zmMI6SBtc=;
        b=l6Jf1A8fv7L+6NoA60ZIYGcEtkMgfYwn9JPVFLApxa74syiiBRl/WLM4XQJZ1ae+nfdERe
        MWMcQ3hPcQX7dK3XgS+eMZeuc5KI/mNyz88Ualrvfhr6FSIn/5pD02MN5VZ4CPCxWN0Ngg
        hSaXjNDvpgCpOoQEGQjwUPCm+wf8UMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687200131;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uz6lAOdCQ2N2gTr/jwwl321sH/3tOB8vo9zmMI6SBtc=;
        b=AI3mLf8hS2z0k5WXq92TagU1wHXelvJYttkD6WNYJOy1MT99VhUISWqjCJhBD+Rb3YBNSH
        iTdm1eld/dvVaZCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0AC9F138E8;
        Mon, 19 Jun 2023 18:42:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cbTTAYOhkGR7FQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 19 Jun 2023 18:42:11 +0000
Date:   Mon, 19 Jun 2023 20:35:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: some fixes around quota disable, free space
 tree disable and relocation
Message-ID: <20230619183548.GF16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1687185583.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687185583.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 19, 2023 at 05:21:46PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> These fix some bugs related to quota disable and free space tree disable,
> as well as a race between quota disable and relocation that makes
> relocation fail with -ENOENT. More details on the change logs.
> 
> Filipe Manana (4):
>   btrfs: fix race when deleting quota root from the dirty cow roots list
>   btrfs: fix race when deleting free space root from the dirty cow roots list
>   btrfs: add comment to struct btrfs_fs_info::dirty_cowonly_roots
>   btrfs: fix race between quota disable and relocation

Added to misc-next, thanks.
