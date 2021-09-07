Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90572402A99
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 16:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbhIGOTa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 10:19:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52916 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237377AbhIGOT3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 10:19:29 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C13C01FFF5;
        Tue,  7 Sep 2021 14:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631024302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1q8/tTiCt7HCdwMm97i/USbP8oeU4+nq8IN4PZNV7l4=;
        b=NMeCdTmK65Gf/c95GsyzD99jq25lj3R+OIfezTjV6YdBUNQEOwlFdkTbFmTSNH+Wh1sLPw
        TAHGSDm9v9iEETl8L03JF468vOSIxMmRyNnohgdm8bjwoVv9M03kLM9r1+5LsOBr8N4zKE
        ORE+jasNyXa7FqowqlZFoOfunJt9i90=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 939F413A45;
        Tue,  7 Sep 2021 14:18:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id axLVIK50N2FFCAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Tue, 07 Sep 2021 14:18:22 +0000
Subject: Re: [PATCH 1/2] btrfs-progs: fi show: Print missing device for a
 mounted file system
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20210902100643.1075385-1-nborisov@suse.com>
 <20210907135041.GO3379@twin.jikos.cz>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <3dc01a8c-4b87-c37b-7c61-4dca76a92783@suse.com>
Date:   Tue, 7 Sep 2021 17:18:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210907135041.GO3379@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7.09.21 г. 16:50, David Sterba wrote:
> There was a discussion regarding the output, so what's the last version?
> The path is not always available, so how does the output look like in
> that case? I'd vote against the *** markers and rather establish some
> parseable format, like
> 
>  	devid    2 size 0 used 0 MISSING (last: /dev/loop1)
> 
> The path is optional so it would bebetter to put it at the end.

I'm fine with this format, will send updated patches.
