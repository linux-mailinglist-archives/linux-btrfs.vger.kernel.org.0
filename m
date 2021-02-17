Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B87A31E1F5
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Feb 2021 23:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhBQWTo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 17:19:44 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:38545 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232065AbhBQWTn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 17:19:43 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 7AA52F7C;
        Wed, 17 Feb 2021 17:18:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 17 Feb 2021 17:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=Xkmcn/YK1XE7dXtCirqg8NTNeZi
        WK7C7C9zg7EZ3lGc=; b=ulpk7YXxpbP3UOuY27NgG77rw7y2ujg0Uki5PQNWRi2
        q1jRiM+o/kwfO+drRkgyjUT1CaqjRG064k8JDaLbBX1ReGip6iBnwT3yB6IqLiwI
        Ax4kBJi6OCUIntFY+Z1EoiemLiBaM0QMi9JKbbC2dWOaiaru8zXVD1p9qKgSazOw
        dU0RqxoXUIszunG2lgm5YbO7/5nyEEn3wTGcN6B/ukwHk3JfYi37TvPpKI/+mDFQ
        kvBmkruf7i6hLlv5B1qKBBB+crMefJ+yrNLRpLnPOO9htvj6CI4sLs3K5aWV2gln
        oPmSxQUukGawpuPG7nquPt1O8k1rp8rHYVSu6307BSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Xkmcn/
        YK1XE7dXtCirqg8NTNeZiWK7C7C9zg7EZ3lGc=; b=I/pbI5MPuo999OxInEZQJH
        XECgspOU1/FQty2xdgxhDEsPBjd4wboTnoMkj59nL4DDRMd2G9JqaCfe+TVdtZ3a
        /VEpRJiEmx+dTF6ufZjYuUHkLltfNJ8wTLTq1ebkzSX8pDMv+NCZF1o/6RFcX/jm
        KUSyKquDtzceXspNIcgMkl11XCAPgIQU2PKTAkquSQ0K6SidGKWjefd4DjFa+SXy
        j3vJkI1FCbhpHAXlV1FiiHuxUsm3Cj2L+4gQ2llljbvfZKr9zcyrL8e0I6doVvXw
        kSdbjLdiRK511KafEWhs68Rjb3oU6alGWqpJLOcfB9CspzElFnGfzGomdPhOc5qw
        ==
X-ME-Sender: <xms:T5YtYBNPF3TQelFIvSmK0AU1vKWZJ6XEO0FCkUSZts51RSJ7cm1YNQ>
    <xme:T5YtYD4-8SaURHGXji_NyDdRLb41O-5f7UDZSmVHW9flKomro7G6lms7q7RNkkJRN
    LIFSA2w4TzkIp4SY7Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrjedvgddufeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehttd
    ertddtredvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepueeghfdvffegvdeugfffueefgeektdeuhfdttd
    evvefgkeelleekieeukeelleetnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfk
    phepudeifedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:T5YtYNIp8Bj7vDu4-tAn3G6w4Cx4RXlD7Gs0qpssvQ1tsq4Yw8asGQ>
    <xmx:T5YtYFdnF89Ut_gHYuYEmhkKjOFluHJ_Ob4ePKHdNIAIc7MnWZvrgw>
    <xmx:T5YtYIczAvmT0b16nLDckpIT-dX3OzDssRI_2NH-nOrXxMZzWqQALg>
    <xmx:UJYtYPKMbrv5rE0S6E2bgfgWL8sbbkXbLSG2BaBSaLGyOpygh44Adg>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4307724005C;
        Wed, 17 Feb 2021 17:18:55 -0500 (EST)
Date:   Wed, 17 Feb 2021 14:18:52 -0800
From:   Boris Burkov <boris@bur.io>
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org, nborisov@suse.com, dsterba@suse.cz
Subject: Re: [PATCH RFC] btrfs-progs: check: continue to check space cache if
 sb cache_generation is 0
Message-ID: <20210217221852.GA1689899@devbig008.ftw2.facebook.com>
References: <20210215092011.6079-1-l@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215092011.6079-1-l@damenly.su>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 15, 2021 at 05:20:11PM +0800, Su Yue wrote:
> User reported that test fsck-tests/037-freespacetree-repair fails:
>  # TEST=037\* ./fsck-tests.sh
>     [TEST/fsck]   037-freespacetree-repair
> btrfs check should have detected corruption
> test failed for case 037-freespacetree-repair
> 
> The test tries to corrupt FST, call btrfs check readonly then repair FST
> using btrfs check. Above case failed at the second readonly check steup.
> Test log said "cache and super generation don't match, space cache will
> be invalidated" which is printed by validate_free_space_cache().
> If cache_generation of the superblock is not -1ULL,
> validate_free_space_cache() requires that cache_generation must equal
> to the superblock's generation. Otherwise, it skips the check of space
> cache(v1, v2) like the above case where the sb cache_generation is 0.
> 
> Since kernel commit 948462294577 ("btrfs: keep sb cache_generation
> consistent with space_cache"), sb cache_generation will be set to be 0
> once space cache v1 is disabled(nospace_cache/space_cache=v2).
> 
> Fix it by adding the condition if sb cache_generation is 0 in
> validate_free_space_cache() as it's valid now since the kernel commit
> mentioned above.

Sorry that I didn't notice the fsck issue.
The fix looks good to me.

> 
> Link: https://github.com/kdave/btrfs-progs/issues/338
> Signed-off-by: Su Yue <l@damenly.su>
Reviewed-by: Boris Burkov <boris@bur.io>
> 
> ---
> Hi, while reading free space cache v1 related code, I am (still)
> confused about the value meanings of cache_generation in sb.
> 
> For outdated space cache v1, cache_gen < sb gen.
> For valid space cache v1, cache_gen == sb gen.
> AS for values 0 and (u64)-1, many places use (u64)-1 to represent
> cleared v1 caches. The only three places setting cache_gen to 0 are
> 1)  above kernel commit 948462294577.
> 2)  kernel btrfs_parse_options() while mounting zoned device.
> 3)  progs image/main.c:1147 while restoring image.
> 
> I'm wondering whether loosing check condition in this patch is correct
> or not. So make it RFC. Thanks.

I did some archaeology on this, because when I wrote the patch that
broke this, I was sure that 0 meant "no space cache" and couldn't
actually answer your question without digging in.

I believe that the situation is as follows:

In the kernel code, super_cache_gen == 0 <-> no space cache. This has
been true since the introduction of the field in
'0af3d00bad38 Btrfs: create special free space cache inode'.
Another interesting kernel patch to note is:
'73bc187680f9 Btrfs: introduce mount option no_space_cache'
which explicitly mentions the check against super_cache_gen==0.

However, in btrfs-progs, as you have correctly pointed out, (u64)-1 is
the sentinel value of interest. The reason is that in the original
free-space-cache mkfs patch:
'e2a6859d9325 Btrfs-progs: update super fields for space cache'
-1 is used intentionally as a non-zero value to make space cache the
default setting. Quoting the patch:
"It also makes us set it to -1 on mkfs so any new filesystem will get
the space cache stuff turned on"
This was incompatible with the original check code which would fail on
freshly mkfs'd fses, which was fixed in:
b4f4473e8a888 'Btrfs-progs: don't output baffling message when checking
a fresh fs'

So tl;dr:
in the kernel: 0 means no cache, only became consistent with
nospace_cache recently, which broke fsck
in progs: 0 still means no cache, -1 is a sentinel in mkfs to force the
first transaction to set it to the real generation value. -1 was added
to the fsck for fresh fses, but the 0 case never came up until now.

Thanks for looking into this and sending a fix,
Boris
> ---
>  check/main.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/check/main.c b/check/main.c
> index c7c5408bea19..a652e445de90 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -9951,7 +9951,12 @@ static int validate_free_space_cache(struct btrfs_root *root)
>  {
>  	int ret;
>  
> +	/*
> +	 * If cache generation is between 0 and -1ULL, sb generation must equal to
> +	 *   sb cache generation or the v1 space caches are outdated.
> +	 */
>  	if (btrfs_super_cache_generation(gfs_info->super_copy) != -1ULL &&
> +	    btrfs_super_cache_generation(gfs_info->super_copy) != 0 &&
>  	    btrfs_super_generation(gfs_info->super_copy) !=
>  	    btrfs_super_cache_generation(gfs_info->super_copy)) {
>  		printf(
> -- 
> 2.30.0
> 
