Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC7640673D
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Sep 2021 08:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhIJGey (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Sep 2021 02:34:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41584 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhIJGex (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Sep 2021 02:34:53 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 70BA6223E5;
        Fri, 10 Sep 2021 06:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631255622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W+t4kFI55mpQilrTkrfHoQ8CDg/Cdaistb0Cp/iASOw=;
        b=pWpYCob0PrMFcB+E+Lu1ZNSvCZ/R7VKM7kuekfAUO5e6ymiEXy9AJV79USMu9pLWdzgn/Z
        pYzD3dP82wPana6g7nWiBMeIZlgdTWNEUbdOsfcEdlgnwJoZMEs/parLPueQMwWAgrT1U2
        76grI7BDzdqxdtoy1XvNHXoHK8Wycq0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4053513D12;
        Fri, 10 Sep 2021 06:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uUWlDEb8OmEYHgAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 10 Sep 2021 06:33:42 +0000
Subject: Re: [PATCH 2/2] btrfs-progs: doc: add extra note on flipping
 read-only on received subvolumes
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210910060335.38617-1-wqu@suse.com>
 <20210910060335.38617-3-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <9ad982a7-2a40-5f52-1d88-cca79d9d411f@suse.com>
Date:   Fri, 10 Sep 2021 09:33:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210910060335.38617-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.09.21 г. 9:03, Qu Wenruo wrote:
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  Documentation/btrfs-property.asciidoc | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/btrfs-property.asciidoc b/Documentation/btrfs-property.asciidoc
> index 4796083378e4..8949ea22edae 100644
> --- a/Documentation/btrfs-property.asciidoc
> +++ b/Documentation/btrfs-property.asciidoc
> @@ -42,6 +42,12 @@ the following:
>  
>  ro::::
>  read-only flag of subvolume: true or false
> ++
> +NOTE: For recevied subvolumes, flipping from read-only to read-write will
> +either remove the recevied UUID and prevent future incremental receive
> +(on newer kernels), or cause future data corruption and recevie failure
> +(on older kernels).

Hang on a minute, flipping RO->RW won't cause corruption by itself. So
flipping will just break incremental sends which is completely fine.

> +
>  label::::
>  label of the filesystem. For an unmounted filesystem, provide a path to a block
>  device as object. For a mounted filesystem, specify a mount point.
> 
