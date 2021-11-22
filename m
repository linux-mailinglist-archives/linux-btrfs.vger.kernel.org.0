Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9884589BF
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 08:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbhKVH1q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 02:27:46 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52056 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238743AbhKVH1p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 02:27:45 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BDE162114E;
        Mon, 22 Nov 2021 07:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637565878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+aRnBq+XmrHaTREKyj+mznFdPyKDjhzM4vPSPjWXqFo=;
        b=J/nrGGcD+RADO03yoY1kmUGeyMZPJn0+acAtOX33FYMeokik7mth21omHuhhEtZrnDcCAq
        lsmc1+JfU5h+gjF8UNNs3Pi9sf+viX2GauPePaJO22lJeY5EcUGJuxuTyNyUog+Fgc2W/m
        W7sShV8fGVqgwYfGwwnwqK1kOYaz9Qc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95C0213A96;
        Mon, 22 Nov 2021 07:24:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tt9gIrZFm2EfHAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 22 Nov 2021 07:24:38 +0000
Subject: Re: read time tree block corruption detected
To:     x8062 <ericleaf@126.com>, linux-btrfs@vger.kernel.org
References: <56d93523.27d4.17d461bc3c6.Coremail.ericleaf@126.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <aed20fe5-4e7d-9f0f-ee39-1b584d8572f0@suse.com>
Date:   Mon, 22 Nov 2021 09:24:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <56d93523.27d4.17d461bc3c6.Coremail.ericleaf@126.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22.11.21 §Ô. 7:26, x8062 wrote:
> Hello,
>  I got periodic warns in my linux console. in dmesg it is the following pasted text.
> At https://btrfs.wiki.kernel.org/index.php/Tree-checker I learned it may be a error, so i send the message. Hopefully it could help, Thanks in advance!
> 
> [  513.900852] BTRFS critical (device sdb3): corrupt leaf: root=381 block=71928348672 slot=74 ino=2394634 file_offset=0, invalid ram_bytes for uncompressed inline extent, have 393 expect 131465
> 


You have faulty ram, since 393 has the 17th bit set to 0 whilst has it
set to 1. So your ram is clearly corrupting bits. I advise you run a
memtest tool and look for possibly changing the faulty ram module.
