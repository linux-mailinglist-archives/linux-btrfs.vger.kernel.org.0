Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090F34045FE
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Sep 2021 09:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350467AbhIIHNS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Sep 2021 03:13:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37588 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbhIIHNR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Sep 2021 03:13:17 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7E5E4222EC;
        Thu,  9 Sep 2021 07:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631171527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t6Mc15zooISgbs9gKn71DA0Cx5FRTgIFZ0+lP1Wpevg=;
        b=YphwtosszfKnATpuv3WrgkbfDszf/LZsCwF1PYfC8BHNAUEBdOFgz3kA4OLdwKShVp1uSh
        Q3p1RDE+HVPosaKH/hf/gyIKggKABCBIUZJuriMTku0oyADX/hHBrqZXfZpnxrjC6CAkQc
        6CygRLJqtVgk6rmA73vnXL1dG5edk6k=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 52B3E13A61;
        Thu,  9 Sep 2021 07:12:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id w1ezEcezOWFAZAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 09 Sep 2021 07:12:07 +0000
Subject: Re: Corruption suspiciously soon after upgrade to 5.14.1; filesystem
 less than 5 weeks old
To:     Sam Edwards <cfsworks@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAH5Ym4h9ffTSx_EuBOvfkCkagf5QHLOM1wBzBukAACCVwNxj0g@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <f40b07a3-9f64-84f0-5c91-1c7fdfe5640a@suse.com>
Date:   Thu, 9 Sep 2021 10:12:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAH5Ym4h9ffTSx_EuBOvfkCkagf5QHLOM1wBzBukAACCVwNxj0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.09.21 г. 3:47, Sam Edwards wrote:
> My primary hypothesis is that there's some write bug in Linux 5.14.1.
> I installed some package updates right before btrfs detected the
> problem, and most of the files in the `btrfs check` output look like
> they were created as part of those updates.

SO what was the last workload that got run on this server. The
btrfs-progs log suggests the last 2 transactions have been lost
expecting 66655 vs finding 66653. Also looking at the missing file names
it suggests you were fiddling with some windows development software? I
can see a mix of .dll.so files and also a bunch of just .dll files. SO
what was the last thing you installed on that machine? Are you using
dual boot by any chance on the same disk?
