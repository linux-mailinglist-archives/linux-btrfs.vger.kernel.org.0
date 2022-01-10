Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0181F48971E
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 12:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244545AbiAJLOO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 06:14:14 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41536 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244519AbiAJLNs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 06:13:48 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F20161F395;
        Mon, 10 Jan 2022 11:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641813226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7fqJo8XOKPUbLAbkz7/X1QQT6cmFGw0IArLF6YcCuuU=;
        b=dXGdZgOWJU/0vzUFfwlAKR2KhFtT2TN+m99bSjQgrm8SiaHZugphEwAeEKBfckd66G7IZT
        mxYFfwvP11pY7n+WEr9/vCXo6aFoQIN+mE+J1+5c4XsAS5P8QxB44OOjVLRu1s/l3Rfj8S
        8l76UrklifLTH/gRux+uDduIDS+sB4Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C6C9513D2A;
        Mon, 10 Jan 2022 11:13:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3ppsLeoU3GGqaQAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 10 Jan 2022 11:13:46 +0000
Subject: Re: [PATCH] btrfs-progs: Don't crash when processing a clone request
 during received
To:     linux-btrfs@vger.kernel.org
Cc:     Chris Muprhy <lists@colorremedies.com>
References: <20220110111201.1824108-1-nborisov@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <751714dd-57e2-9ee3-2180-1614eab2c3fe@suse.com>
Date:   Mon, 10 Jan 2022 13:13:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220110111201.1824108-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.01.22 г. 13:12, Nikolay Borisov wrote:
> If subvol_uuid_search can't find the clone root then 'si' would either
> be NULL or contain an errno. The behavior of this function was
> changed as a result of commit
> ac5954ee36a5 ("btrfs-progs: merge subvol_uuid_search helpers"). Before
> this commit subvol_uuid_search() was a wrapper around subvol_uuid_search2
> and it guaranteed to either return well-fromed 'si' or NULL. This was
> sufficient for the check after the out label in process_clone.
> 
> Properly handle this new semantic by changing the simple null check to
> IS_ERR_OR_NULL which covers all possible return value of
> subvol_uuid_search.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Reported-by: Chris Muprhy <lists@colorremedies.com>
> Link: https://lore.kernel.org/linux-btrfs/CAJCQCtT-k3WbCSTvrvWLZQ7gLOUtTbXfOiKsGZxkPVb1g2srWg@mail.gmail.com/


Qu pointed me to
https://patchwork.kernel.org/project/linux-btrfs/patch/20220102015016.48470-1-davispuh@gmail.com/


which is essentially the same patch. So you can drop this.
