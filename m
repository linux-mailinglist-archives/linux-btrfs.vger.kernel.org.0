Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0024452E5
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 13:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhKDMYm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 08:24:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45364 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhKDMYl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 08:24:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C368C1FD33;
        Thu,  4 Nov 2021 12:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636028522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YHkhzzTam4kuGgKdBdXKa0wDTK9FK0VMECMdRqvnCKw=;
        b=D2+W1HF1cTc2nMXcz8zY65TZSkEgPt2RFGSoPRokjEXLSbM5fn/0anjgP2h1mRX0/oNDng
        k3Lp65zqX9f3u0qVJVGezklGbh+gjxx+jtqmlpMYHiStgBsnKnYez/SWuL7sdF/tA/e6xT
        6oVIWNJtTlriyqur+WsSs5XYuOoeRa8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E11F13BD4;
        Thu,  4 Nov 2021 12:22:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xgLnI2rQg2H6BwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 04 Nov 2021 12:22:02 +0000
Subject: Re: Moby/Docker gradually exhausts disk space on BTRFS
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtS7YqzmWGta7uCAv-cOMuhiFG1M-idrO4_VotWi_Tpu7g@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <1f6eacb5-5e60-8f4b-e993-38f1917d4cc2@suse.com>
Date:   Thu, 4 Nov 2021 14:22:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtS7YqzmWGta7uCAv-cOMuhiFG1M-idrO4_VotWi_Tpu7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2.11.21 г. 20:44, Chris Murphy wrote:
> Docker gradually exhausts disk space on BTRFS #27653
> https://github.com/moby/moby/issues/27653
> 
> This bug goes back to 2016 and could really use some attention to
> figure out what's going on. I'm not sure even whose bug it is. It
> could be docker itself, or the btrfs "graph" driver that docker uses,
> or if it's a (btrfs) kernel bug.
> 
> It could be there's more than one bug.

I don't think there is a bug rather  people not being aware of how
docker does pruning. Just deleting a container doesn't free up the space
so if you never run prune -a space taken by images won't be freed up. I
did a bunch of tests today with starting a container, stopping, deleting
it, pruning images and everything works as expected.

> 
> 
