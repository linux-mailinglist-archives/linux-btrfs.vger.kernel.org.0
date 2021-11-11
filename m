Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F50E44D888
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 15:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbhKKOtd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 09:49:33 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44272 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhKKOtc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 09:49:32 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8919F21B2A;
        Thu, 11 Nov 2021 14:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636642002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+EKnv5Z4xNgl7kvT72gj9aK5FohO4a0EIaPN+thGsIo=;
        b=VfEiYPIUcl9jQds6fihd/KTvTwrUQ+NwGJyjtkjurGEMS2n52zTTnpldQUlF1IhB8vn7pp
        7I5HJvOH69n1WgLl17eioZ3v8tAAfx6xKVIxOiV5I21lF3c0o1sxM2M1dNncrtetlD8Awx
        5so9+IJJWaMMwJwlNdk3uw8ZErBTBLs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 287AD13DB4;
        Thu, 11 Nov 2021 14:46:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xgwOO9EsjWFyZQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 11 Nov 2021 14:46:41 +0000
Subject: Re: [PATCH v3 4/7] btrfs: make BTRFS_RESERVE_FLUSH_EVICT use the
 global rsv stealing code
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636470628.git.josef@toxicpanda.com>
 <c73af8ce621bbc638b565320e53ab9c51a529fef.1636470628.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <cc4e5e7f-015f-6550-c609-c391e3920710@suse.com>
Date:   Thu, 11 Nov 2021 16:46:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <c73af8ce621bbc638b565320e53ab9c51a529fef.1636470628.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.11.21 г. 17:12, Josef Bacik wrote:
> I forgot to convert this over when I introduced the global reserve
> stealing code to the space flushing code.  Evict was simply trying to
> make its reservation and then if it failed it would steal from the
> global rsv, which is racey because it's outside of the normal ticketing
> code.
> 
> Fix this by setting ticket->steal if we are BTRFS_RESERVE_FLUSH_EVICT,
> and then make the priority flushing path do the steal for us.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
