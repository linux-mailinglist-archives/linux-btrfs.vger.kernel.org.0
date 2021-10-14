Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D299B42D825
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 13:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhJNL1B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 07:27:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57858 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbhJNL1A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 07:27:00 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 976D31F782;
        Thu, 14 Oct 2021 11:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634210694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yD42rsW9vO2hSIs/anehSGLFt1dMusiYlfJ68OJJzuc=;
        b=sDiF3gHPONcMUwdImjyb/QGFdDgcD0O+U5HoZCvhELo7igLb16IiNugF+NDOh625bO9BOv
        kFThk8LCAzap66ZSmSenmgBZqOQHXi6vA6VC2zYCb/Ep5t0uhEjIuD4xkhDbTrAIjuBs9e
        PO2JLQQrbtgALjVJyCeFSeUk/nID/QI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C05313D82;
        Thu, 14 Oct 2021 11:24:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +1LwE4YTaGF1HAAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 14 Oct 2021 11:24:54 +0000
Subject: Re: [PATCH] btrfs: stop storing the block device name in
 btrfsic_dev_state
To:     Christoph Hellwig <hch@lst.de>, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <20211014090550.1231755-1-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <13bb9f16-df1b-6c43-a95a-11cc435f95b6@suse.com>
Date:   Thu, 14 Oct 2021 14:24:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211014090550.1231755-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14.10.21 г. 12:05, Christoph Hellwig wrote:
> Just use the %pg format specifier in all the debug printks previously
> using it.  Note that both bdevname and the %pg specifier never print
> a pathname, so the kbasename call wasn't needed to start with.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviwed-by: Nikolay Borisov <nborisov@use.com>
