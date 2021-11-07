Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFE0447252
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Nov 2021 10:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbhKGJRR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Nov 2021 04:17:17 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51892 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbhKGJRR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Nov 2021 04:17:17 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CE75B1FD3B;
        Sun,  7 Nov 2021 09:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636276473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hUR6UJ+qzWtoeLa87p7Pl78oOMpHpRiiWUB9EJk5w3M=;
        b=Dok/skxKTb0e2/MyOx1emwdgTE8x6S1RmIoka+fJVlEJ/RAvEclrFN3w6WSHBT9NjrfJwU
        ItstCPPuPhHHckJpU3P6b49O2y82GPSjN6HWrVmMC5AXciZgle4R9eLiWU9ymEf3SxlSpK
        HP5b6DWKEFI7z+7m8T/qMZzvQzKD34g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8ED581345F;
        Sun,  7 Nov 2021 09:14:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MKsBIPmYh2GbaQAAMHmgww
        (envelope-from <nborisov@suse.com>); Sun, 07 Nov 2021 09:14:33 +0000
Subject: Re: [PATCH] common/btrfs: source module file and remove duplicates
To:     Luis Chamberlain <mcgrof@kernel.org>, fstests@vger.kernel.org,
        fdmanana@gmail.com
Cc:     linux-btrfs@vger.kernel.org
References: <20211105155947.2828825-1-mcgrof@kernel.org>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <7af1044a-0f1e-da8c-853a-9eefb71f1c68@suse.com>
Date:   Sun, 7 Nov 2021 11:14:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211105155947.2828825-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5.11.21 г. 17:59, Luis Chamberlain wrote:
> btrfs/249 fails with:
> 
> QA output created by 249
> ./common/btrfs: line 425: _require_loadable_fs_module: command not found
> ./common/btrfs: line 432: _reload_fs_module: command not found
> ERROR: not a btrfs filesystem: /media/scratch
> 
> This is because the test is failing to source common/module.
> Fix this by sourcing common/module in the btrfs common file.
> 
> While it it remove duplication of sourcing this file from other
> tests in btrfs so that this is only done once in one place.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
