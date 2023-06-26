Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8723E73DADF
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jun 2023 11:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjFZJLB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jun 2023 05:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFZJKY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jun 2023 05:10:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DFA1987;
        Mon, 26 Jun 2023 02:08:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B5FC5218A9;
        Mon, 26 Jun 2023 09:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687770511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Z3BwE/rMDL9sl3DkNyM9QjJJyC1nTbjXqZGpksBHdg=;
        b=fIxurrjVGHc9FD+2RG8txljxmBG0FCedwfMRjrWFQF0XuNa6PvTHpuqyMejsKh3Jua2X3T
        1teV9cakJLPxVhN44pJPXqiHReBUvn1frqAJYgTQ7bIEmJi6B8H7/wXCr+8D9ZTcBnxPNb
        cVq2OKK1WJJ50SDOojjWGvaeeKsuRag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687770511;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Z3BwE/rMDL9sl3DkNyM9QjJJyC1nTbjXqZGpksBHdg=;
        b=ARm8Qvwb/bPr8l1xrJHBZ03gy8VE98uMY4fCjbzU92aP5nupTlX2lMJYqVCJwjLfhUHkBy
        WctuSYBphMJVZkCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E1F513483;
        Mon, 26 Jun 2023 09:08:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Qo0oGo9VmWTbZQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 26 Jun 2023 09:08:31 +0000
Message-ID: <2126cc69-b779-565b-98c7-4fbb0bf9f557@suse.cz>
Date:   Mon, 26 Jun 2023 11:08:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm/vmalloc: do not output a spurious warning when huge
 vmalloc() fails
To:     Lorenzo Stoakes <lstoakes@gmail.com>, Forza <forza@tnonline.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, a1bert@atlas.cz,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Song Liu <song@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20230605201107.83298-1-lstoakes@gmail.com>
 <cd47d6ac-69ce-0315-dd45-2cb9dce57f36@suse.cz>
 <f6b42d95-09f1-48d6-8274-e6145febb31d@lucifer.local>
 <2a6fa9d6-53b8-93cd-16c8-309ce2b8e3ac@suse.cz>
 <20230607093316.cdf60df195915fa9d38067ea@linux-foundation.org>
 <11b893e.86425ef4.188f33688b8@tnonline.net>
 <e3ce1745-0a3e-4c9d-955e-2a0ce20422cf@lucifer.local>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <e3ce1745-0a3e-4c9d-955e-2a0ce20422cf@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/25/23 17:59, Lorenzo Stoakes wrote:
> On Sun, Jun 25, 2023 at 05:40:17PM +0200, Forza wrote:
>>
>>
>> ---- From: Andrew Morton <akpm@linux-foundation.org> -- Sent: 2023-06-07 - 18:33 ----
>>
>> > On Wed, 7 Jun 2023 10:58:40 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
>> >
>> >> I would really suggest moving the fix to
>> >> mm-hotfixes instead of mm-unstable, and
>> >>
>> >> Fixes: 80b1d8fdfad1 ("mm: vmalloc: correct use of __GFP_NOWARN mask in __vmalloc_area_node()")
>> >> Cc: <stable@vger.kernel.org>
>> >
>> > I've made those changes.
>>
>> Did the chabge go into 6.3 stable? I saw these issues with kernels 6.3.0-6 3.7. I now updated to 6.3.9 and have had no more warnings since.
> 
> Yeah, got the notification from Greg's script that it landed in 6.3 stable.

It did, but was not yet released. 6.3.9 from Wed Jun 21 doesn't have it yet,
so it's interesting the warnings are gone already.

>>

