Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EA03FB84A
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 16:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbhH3O3j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 10:29:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47680 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237445AbhH3O3i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 10:29:38 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 96E8622096;
        Mon, 30 Aug 2021 14:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630333723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vgJMcVdpmONaB3cVaRoAG2QQphpCV64IYb5574ybOU8=;
        b=g/o3kmLatlEQtTHgYm0PmRHqsWaoHo5neVhtPoAE+ohi2qlippJDwcZV2/J7Mj+Mhi0NHB
        RbK4s4QvuMBHh8SI7qoL8nsSYTFelslWv3vI66oVrFHUISpJJkzTEfq6nZN8li3Ny57Nxe
        g+VcOH2MxW6TAmp+A+pNqMI9lCsC/dY=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6353513990;
        Mon, 30 Aug 2021 14:28:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 3ON5FRvrLGE9BgAAGKfGzw
        (envelope-from <nborisov@suse.com>); Mon, 30 Aug 2021 14:28:43 +0000
Subject: Re: [PATCH v2 3/4] btrfs: introduce btrfs_subpage_bitmap_info
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210817093852.48126-1-wqu@suse.com>
 <20210817093852.48126-4-wqu@suse.com>
 <7b9c1c27-1938-4702-e6b2-db5a840f7a84@suse.com>
 <20210823164540.GG5047@twin.jikos.cz>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <7f090871-17c5-cad2-b30a-807ff8509d1d@suse.com>
Date:   Mon, 30 Aug 2021 17:28:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210823164540.GG5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 23.08.21 г. 19:45, David Sterba wrote:
> On Tue, Aug 17, 2021 at 01:11:43PM +0300, Nikolay Borisov wrote:
>>> +/*
>>> + * Extra info for subpapge bitmap.
>>> + *
>>> + * For subpage we pack all uptodate/error/dirty/writeback/ordered
>>> + * bitmaps into one larger bitmap.
>>> + *
>>> + * This structure records how they are organized in such bitmap:
>>> + *
>>> + * /- uptodate_offset	/- error_offset	/- dirty_offset
>>> + * |			|		|
>>> + * v			v		v
>>> + * |u|u|u|u|........|u|u|e|e|.......|e|e| ...	|o|o|
>>
>> nit: the 'e' that the dirty offset is pointing to should be a 'd', I'm
>> sure David can fix this while merging.
> 
> I don't see any 'e' under the dirty offset arrow, there's just 'o' and
> the arrow points to end of |e|e| and continues with ...
> 

What I wanted to say is that every arrow beneat the respective type -
uptodate/error/dirty should point to a letter corresponding to the first
letter of the respective word. I.e the dirty offset points into ...
whilst the |o|o| at the end likely mean "other" but is confusing i.e
dirty offset should be pointing to a |d| box.
