Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6BC5E8A86
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Sep 2022 11:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbiIXJLh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Sep 2022 05:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbiIXJLf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Sep 2022 05:11:35 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B6210D66E
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Sep 2022 02:11:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id jm5so2109982plb.13
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Sep 2022 02:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=i+DbZ92rhFWH/0UDN/zG8OtvV+E4X59I6BjaPOZbEQQ=;
        b=E5bOhboA/+6BWRDx1UWFFrMvOXvKoaBtGsWYlDmuj8X7rAkhnZpWRHTQ3LNDz7+mZj
         DgCRrEBR3MyfN1vHwttkAVt9C+sNXNl8rbk7MHBer0lal296QvNAuoGU6ltJiVjNpwJw
         ZbeC7n9zGD6mKw33TGHmgsxJslMQNugj0HBL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=i+DbZ92rhFWH/0UDN/zG8OtvV+E4X59I6BjaPOZbEQQ=;
        b=YcEn/VturLHQyz68b3LGUrUzEnYeQHIE54oiBELGYAOr70X/4USAt32KnYgIbyiNAB
         eUzhkrS+mC8QTaQQlIjbl/C0+JAyFWhIwfO2rrPuIl6ghIsre8hlaMpkj5+HYUNbuATo
         BN7KIHEsUfzNuW9I6pami471T4l0Ww+9+kByiVIJrwPCR3MXw31QkHJ05RSF4No7sO6I
         TDqe3940VZnNZaSU4r3n5ulji4WDWpzhnmcrF2HYEM0wxeKvN6nlJHTuwvo24jmaP5al
         BCJBjiQKdIVjLuluTwL8CrQWHoLFCcgm9hBnQoaULTvDaMvJ/Le+Le8QyoHSd0JiOBbB
         XZ4g==
X-Gm-Message-State: ACrzQf3efEFzclJyHshPGOtUp2SJTEv429VQqkOaNxQb7i4J6JgF8/XJ
        YavfzY1qobdD2ayy/sgLEhv9/Q==
X-Google-Smtp-Source: AMsMyM7r8bq+DxJ2Zg4nmPe+hShYURXJSZpppn8rw6aZz5OkkmasnCi/hTE7Baskd4vD2R6zimHrAA==
X-Received: by 2002:a17:902:d4c9:b0:178:6d7b:c36f with SMTP id o9-20020a170902d4c900b001786d7bc36fmr12510856plg.19.1664010691458;
        Sat, 24 Sep 2022 02:11:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b13-20020aa7950d000000b005546fe4b127sm5590232pfp.78.2022.09.24.02.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 02:11:30 -0700 (PDT)
Date:   Sat, 24 Sep 2022 02:11:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Rientjes <rientjes@google.com>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Elder <elder@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Yonghong Song <yhs@fb.com>, Marco Elver <elver@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, dev@openvswitch.org,
        x86@kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 03/16] skbuff: Proactively round up to kmalloc bucket
 size
Message-ID: <202209240208.84F847F3B@keescook>
References: <20220923202822.2667581-1-keescook@chromium.org>
 <20220923202822.2667581-4-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923202822.2667581-4-keescook@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 23, 2022 at 01:28:09PM -0700, Kees Cook wrote:
> Instead of discovering the kmalloc bucket size _after_ allocation, round
> up proactively so the allocation is explicitly made for the full size,
> allowing the compiler to correctly reason about the resulting size of
> the buffer through the existing __alloc_size() hint.
> 
> This will allow for kernels built with CONFIG_UBSAN_BOUNDS or the
> coming dynamic bounds checking under CONFIG_FORTIFY_SOURCE to gain
> back the __alloc_size() hints that were temporarily reverted in commit
> 93dd04ab0b2b ("slab: remove __alloc_size attribute from __kmalloc_track_caller")
> 
> Additionally tries to normalize size variables to u32 from int. Most
> interfaces are using "int", but notably __alloc_skb uses unsigned int.
> 
> Also fix some reverse Christmas tree and comments while touching nearby
> code.

Something in this patch is breaking things -- I've refactored it again
to avoid overwriting the incoming size argument, and instead add a
dedicated outgoing size variable. Here's what will be v3 ...

---
 net/core/skbuff.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 974bbbbe7138..9b5a9fb69d9d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -346,11 +346,12 @@ EXPORT_SYMBOL(napi_build_skb);
  * memory is free
  */
 static void *kmalloc_reserve(size_t size, gfp_t flags, int node,
-			     bool *pfmemalloc)
+			     bool *pfmemalloc, size_t *alloc_size)
 {
 	void *obj;
 	bool ret_pfmemalloc = false;
 
+	size = kmalloc_size_roundup(size);
 	/*
 	 * Try a regular allocation, when that fails and we're not entitled
 	 * to the reserves, fail.
@@ -369,6 +370,7 @@ static void *kmalloc_reserve(size_t size, gfp_t flags, int node,
 	if (pfmemalloc)
 		*pfmemalloc = ret_pfmemalloc;
 
+	*alloc_size = size;
 	return obj;
 }
 
@@ -400,7 +402,7 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 {
 	struct kmem_cache *cache;
 	struct sk_buff *skb;
-	unsigned int osize;
+	size_t alloc_size;
 	bool pfmemalloc;
 	u8 *data;
 
@@ -427,15 +429,15 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 	 */
 	size = SKB_DATA_ALIGN(size);
 	size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-	data = kmalloc_reserve(size, gfp_mask, node, &pfmemalloc);
-	if (unlikely(!data))
-		goto nodata;
-	/* kmalloc(size) might give us more room than requested.
+	/* kmalloc(size) might give us more room than requested, so
+	 * allocate the true bucket size up front.
 	 * Put skb_shared_info exactly at the end of allocated zone,
 	 * to allow max possible filling before reallocation.
 	 */
-	osize = ksize(data);
-	size = SKB_WITH_OVERHEAD(osize);
+	data = kmalloc_reserve(size, gfp_mask, node, &pfmemalloc, &alloc_size);
+	if (unlikely(!data))
+		goto nodata;
+	size = SKB_WITH_OVERHEAD(alloc_size);
 	prefetchw(data + size);
 
 	/*
@@ -444,7 +446,7 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 	 * the tail pointer in struct sk_buff!
 	 */
 	memset(skb, 0, offsetof(struct sk_buff, tail));
-	__build_skb_around(skb, data, osize);
+	__build_skb_around(skb, data, alloc_size);
 	skb->pfmemalloc = pfmemalloc;
 
 	if (flags & SKB_ALLOC_FCLONE) {
@@ -1709,6 +1711,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 {
 	int i, osize = skb_end_offset(skb);
 	int size = osize + nhead + ntail;
+	size_t alloc_size;
 	long off;
 	u8 *data;
 
@@ -1723,10 +1726,10 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	if (skb_pfmemalloc(skb))
 		gfp_mask |= __GFP_MEMALLOC;
 	data = kmalloc_reserve(size + SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
-			       gfp_mask, NUMA_NO_NODE, NULL);
+			       gfp_mask, NUMA_NO_NODE, NULL, &alloc_size);
 	if (!data)
 		goto nodata;
-	size = SKB_WITH_OVERHEAD(ksize(data));
+	size = SKB_WITH_OVERHEAD(alloc_size);
 
 	/* Copy only real data... and, alas, header. This should be
 	 * optimized for the cases when header is void.
@@ -6063,19 +6066,19 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 	int i;
 	int size = skb_end_offset(skb);
 	int new_hlen = headlen - off;
+	size_t alloc_size;
 	u8 *data;
 
 	size = SKB_DATA_ALIGN(size);
 
 	if (skb_pfmemalloc(skb))
 		gfp_mask |= __GFP_MEMALLOC;
-	data = kmalloc_reserve(size +
-			       SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
-			       gfp_mask, NUMA_NO_NODE, NULL);
+	data = kmalloc_reserve(size + SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
+			       gfp_mask, NUMA_NO_NODE, NULL, &alloc_size);
 	if (!data)
 		return -ENOMEM;
 
-	size = SKB_WITH_OVERHEAD(ksize(data));
+	size = SKB_WITH_OVERHEAD(alloc_size);
 
 	/* Copy real data, and all frags */
 	skb_copy_from_linear_data_offset(skb, off, data, new_hlen);
@@ -6184,18 +6187,18 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 	u8 *data;
 	const int nfrags = skb_shinfo(skb)->nr_frags;
 	struct skb_shared_info *shinfo;
+	size_t alloc_size;
 
 	size = SKB_DATA_ALIGN(size);
 
 	if (skb_pfmemalloc(skb))
 		gfp_mask |= __GFP_MEMALLOC;
-	data = kmalloc_reserve(size +
-			       SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
-			       gfp_mask, NUMA_NO_NODE, NULL);
+	data = kmalloc_reserve(size + SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
+			       gfp_mask, NUMA_NO_NODE, NULL, &alloc_size);
 	if (!data)
 		return -ENOMEM;
 
-	size = SKB_WITH_OVERHEAD(ksize(data));
+	size = SKB_WITH_OVERHEAD(alloc_size);
 
 	memcpy((struct skb_shared_info *)(data + size),
 	       skb_shinfo(skb), offsetof(struct skb_shared_info, frags[0]));
-- 
2.34.1


-- 
Kees Cook
