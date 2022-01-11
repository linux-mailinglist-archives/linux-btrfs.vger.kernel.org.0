Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7481048A830
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 08:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348430AbiAKHNE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jan 2022 02:13:04 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33366 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348429AbiAKHNB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jan 2022 02:13:01 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 605922113D;
        Tue, 11 Jan 2022 07:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641885179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gy11le73Tmr1SHVLo4ce+HPcYOYzYH3hjs8xnX77Hc0=;
        b=forgQBRwCphDlhiq8rSlH+36alWojLC/OFVgDa+XRaDetYHsrebE02giVKfjKb1lb/KlTY
        27gWqRX9AtYO499M8TGCnWQfcH7YR3H4ekgd2pcUVo52DEnAXSn1X64OygH5gsMU0Ik1ti
        PP6DZtMV3BTZ48xUnd3VB3N41C1J+4E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD18D13A8D;
        Tue, 11 Jan 2022 07:12:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PqrqMvot3WFEcQAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 11 Jan 2022 07:12:58 +0000
Subject: Re: [PATCH] fs/btrfs: remove redundant ret variable
To:     cgel.zte@gmail.com, clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220111015716.649468-1-chi.minghao@zte.com.cn>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <19bfc920-7931-998e-a83d-f6cb141fe688@suse.com>
Date:   Tue, 11 Jan 2022 09:12:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220111015716.649468-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.01.22 г. 3:57, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value from fs_path_add_path() directly instead
> of taking this in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

<snip>
