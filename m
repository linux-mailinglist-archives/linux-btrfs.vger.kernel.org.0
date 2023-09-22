Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB417AB49E
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 17:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjIVPSv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 11:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbjIVPSt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 11:18:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90DC1A3;
        Fri, 22 Sep 2023 08:18:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A8AC11FF1F;
        Fri, 22 Sep 2023 15:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695395917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qn8lIN/sqGnW3hNAcQMzFMZ3Cywk6q++rP9dDkSEQFM=;
        b=JFVRFqLMY+kZqmao2NME8QY/yDRRxdO1kK2sWDNpaaxKCf8cFyqKMfOfDyp5Sov9HhXthO
        YOA+exhdjxOr3NtK369rXCHBmieReqDVKGn6ece82vVhkIO3nFDjU0Zbjfi+cJnhvbqfAu
        P1oSD6O9+yIraDrNXrkJUdkp6JgCWu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695395917;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qn8lIN/sqGnW3hNAcQMzFMZ3Cywk6q++rP9dDkSEQFM=;
        b=5jIwua/DP+cvFKlSctL7btSHtutdZV7xB7CI2OBPZ3QHbh2nkdlgDrkQyx619HqbNE2sG5
        i11Tet58BzJonUDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C67613597;
        Fri, 22 Sep 2023 15:18:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cZeCHE2wDWW/GAAAMHmgww
        (envelope-from <ddiss@suse.de>); Fri, 22 Sep 2023 15:18:37 +0000
Date:   Fri, 22 Sep 2023 17:18:35 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: use full subcommand name at
 _btrfs_get_subvolid()
Message-ID: <20230922171835.4fb6fc0c@echidna.fritz.box>
In-Reply-To: <c0ebb36f51f97acb3612ec5376a68441b5e62ac6.1695383055.git.fdmanana@suse.com>
References: <c0ebb36f51f97acb3612ec5376a68441b5e62ac6.1695383055.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 22 Sep 2023 12:45:01 +0100, fdmanana@kernel.org wrote:

> From: Filipe Manana <fdmanana@suse.com>
> 
> Avoid using the shortcut "sub" for the "subvolume" command, as this is the
> standard practice because such shortcuts are not guaranteed to exist in
> every btrfs-progs release (they may come and go). Also make the variables
> local.

Hmm, having them come and go would likely break quite a few user
scripts...

> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  common/btrfs | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index c9903a41..62cee209 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -6,10 +6,10 @@
>  
>  _btrfs_get_subvolid()
>  {
> -	mnt=$1
> -	name=$2
> +	local mnt=$1
> +	local name=$2
>  
> -	$BTRFS_UTIL_PROG sub list $mnt | grep -E "\s$name$" | $AWK_PROG '{ print $2 }'
> +	$BTRFS_UTIL_PROG subvolume list $mnt | grep -E "\s$name$" | $AWK_PROG '{ print $2 }'

My grep+awk OCD would say that this should be:
$BTRFS_UTIL_PROG subvolume list $mnt | $AWK_PROG -v name="$name" '$9 == name { print $2 }'

Looks fine as is though.
Reviewed-by: David Disseldorp <ddiss@suse.de>

