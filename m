Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9BD415A60
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 10:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240074AbhIWIyo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 04:54:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54508 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240013AbhIWIyn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 04:54:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C9FDF2233F;
        Thu, 23 Sep 2021 08:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632387191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oPte1GIJbemRIHV1PY1ApbwjSvUBye7q5gPh5sQDcl0=;
        b=S/XW+b7H/w8etsbECIoW++VJXHKctGzbzBsxn4e/Tby3ggY8L1ZPD5fNdJBGI2ZKG76sAu
        8uYp3QC2AMi7oLLbxsnK5aYvNva5I3I0H0nTocrJXYkWgoC255JIf/s7NZ+8/3Zj2DBQPR
        KvFbosa+8mdw24/G5yFK6gZ/zTtbkFI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 975D113DCA;
        Thu, 23 Sep 2021 08:53:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8Ru+IXdATGGAKgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 23 Sep 2021 08:53:11 +0000
Subject: Re: [PATCH 2/2] btrfs: remove btrfs_raid_bio::fs_info member
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210923060009.53821-1-wqu@suse.com>
 <20210923060009.53821-2-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <bd85e5e2-4118-34ce-c080-ae0b04bd6fea@suse.com>
Date:   Thu, 23 Sep 2021 11:53:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923060009.53821-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 23.09.21 г. 9:00, Qu Wenruo wrote:
> We can grab fs_info reliably from btrfs_raid_bio::bioc, as the bioc is
> always passed into alloc_rbio(), and only get released when the raid bio
> is released.
> 
> This patch will remove btrfs_raid_bio::fs_info member, and cleanup all
> the @fs_info parameters for alloc_rbio() callers.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
