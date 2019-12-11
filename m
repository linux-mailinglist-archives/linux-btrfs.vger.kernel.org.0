Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88B3B11B87D
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 17:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbfLKQVm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 11:21:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfLKQVl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 11:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AxXuRP6SlO9EYVZsfKYGZTNvOdQRf3h3gzU4Dl8Nq0c=; b=g70pc2kei6mVg+B+h8YjfbGsg
        mKZeb9t1jKfZKM8HyZWZkFBrKwtlXP8G4ceGlsVyVyzF9AO00JejYenmo4XxrsHfPrw/FSXvisxwb
        bRiYSzfAhuRtD8shFf9H0KixFRC5QCTuik++EKIAO9xodk1ljCFZEYfSAZb6bS2dBWrmjAosXs3cQ
        JoYQU3cmJJn1We/+FfugqqzCOVtaKCZnlJa7NDbLXbRkG2tRTu1twvygzBaq10Y/rldyBVDHHr4RK
        AMMG5jNnzRd16N026VBWH2/TrzhTMgPf1g8Yr1lMDQjJMaql49Ap7FzgjsZhfXmL4BXjMoTpfXX1r
        UrGFDzjhA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if4k7-0006LN-OM; Wed, 11 Dec 2019 16:21:39 +0000
Subject: Re: linux-next: Tree for Dec 6 (objtool, lots in btrfs)
To:     dsterba@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
References: <20191206135406.563336e7@canb.auug.org.au>
 <cd4091e4-1c04-a880-f239-00bc053f46a2@infradead.org>
 <20191211134929.GL3929@twin.jikos.cz>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c751bc1a-505c-5050-3c4c-c83be81b4e48@infradead.org>
Date:   Wed, 11 Dec 2019 08:21:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211134929.GL3929@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[oops, forgot to add Josh and PeterZ]

On 12/11/19 5:49 AM, David Sterba wrote:
> On Fri, Dec 06, 2019 at 08:17:30AM -0800, Randy Dunlap wrote:
>> On 12/5/19 6:54 PM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Please do not add any material for v5.6 to your linux-next included
>>> trees until after v5.5-rc1 has been released.
>>>
>>> Changes since 20191204:
>>>
>>
>> on x86_64:
>>
>> fs/btrfs/ctree.o: warning: objtool: btrfs_search_slot()+0x2d4: unreachable instruction
> 
> Can somebody enlighten me what is one supposed to do to address the
> warnings? Function names reported in the list contain our ASSERT macro
> that conditionally calls BUG() that I believe is what could cause the
> unreachable instructions but I don't see how.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/btrfs/ctree.h#n3113
> 
> __cold
> static inline void assfail(const char *expr, const char *file, int line)
> {
> 	if (IS_ENABLED(CONFIG_BTRFS_ASSERT)) {
> 		pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
> 		BUG();
> 	}
> }
> 
> #define ASSERT(expr)	\
> 	(likely(expr) ? (void)0 : assfail(#expr, __FILE__, __LINE__))
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
