Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3456162BDC7
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Nov 2022 13:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238879AbiKPM2c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Nov 2022 07:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbiKPM2Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Nov 2022 07:28:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4674B6464;
        Wed, 16 Nov 2022 04:25:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F171E1F917;
        Wed, 16 Nov 2022 12:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668601506;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t364W5skI1j7pC0w2AvM+QLo/wdtr/H5Ea49+U8AtMc=;
        b=VrJh+encNcOBAIl3/cjFZK9Nocs0SXz/AOGoRvqvdmM1mWu1WK7/VOZszqpXeTNKWf2EsQ
        zNt3gJhvrgihspuRdUuBVkUUvpiY18odfvRJdL6prEVSLjlGDcNTKpIclBiOK9O0c6GHPR
        I+gcLso5Qbj2Eq90+rbRHXL4ZF4nM9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668601506;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t364W5skI1j7pC0w2AvM+QLo/wdtr/H5Ea49+U8AtMc=;
        b=bxHtpW1dOm4kIsRe4Tr0SSD09ophd578bUhdYwWBQIPIp6nVSbTG/DGqQsyTz4rmY7CUkV
        1xzoOU46gtgs0mCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF69213480;
        Wed, 16 Nov 2022 12:25:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v5LxKaLWdGOiFgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 16 Nov 2022 12:25:06 +0000
Date:   Wed, 16 Nov 2022 13:24:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     ChenXiaoSong <chenxiaosong2@huawei.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangxiaoxu5@huawei.com, yanaijie@huawei.com, wqu@suse.com
Subject: Re: [PATCH v4 1/3] btrfs: add might_sleep() to some places in
 update_qgroup_limit_item()
Message-ID: <20221116122440.GN5824@suse.cz>
Reply-To: dsterba@suse.cz
References: <20221115171709.3774614-1-chenxiaosong2@huawei.com>
 <20221115171709.3774614-2-chenxiaosong2@huawei.com>
 <9b47b291-b1a0-ac0c-2049-b7de6545c26b@gmx.com>
 <e058c1b9-7f57-11da-6ad1-6387604813c5@huawei.com>
 <3918175e-dddd-2a55-32c4-c07de78ff4cb@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3918175e-dddd-2a55-32c4-c07de78ff4cb@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 16, 2022 at 04:43:50PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/11/16 16:09, ChenXiaoSong wrote:
> > 在 2022/11/16 6:48, Qu Wenruo 写道:
> >> Looks good.
> >>
> >> We may want to add more in other locations, but this is really a good 
> >> start.
> >>
> >> Reviewed-by: Qu Wenruo <wqu@suse.com>
> >>
> >> Thanks,
> >> Qu
> > 
> > If I just add might_sleep() in btrfs_alloc_path() and 
> > btrfs_search_slot(), is it reasonable?
> 
> Adding it to btrfs_search_slot() is definitely correct.
> 
> But why for btrfs_alloc_path()? Wouldn't kmem_cache_zalloc() itself 
> already do the might_sleep_if() somewhere?
> 
> I just looked the call chain, and indeed it is doing the check already:
> 
> btrfs_alloc_path()
> |- kmem_cache_zalloc()
>     |- kmem_cache_alloc()
>        |- __kmem_cache_alloc_lru()
>           |- slab_alloc()
>              |- slab_alloc_node()
>                 |- slab_pre_alloc_hook()
>                    |- might_alloc()
>                       |- might_sleep_if()

The call chaing is unconditional so the check will always happen but the
condition itself in might_sleep_if does not recognize GFP_NOFS:

 34 static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
 35 {
 36         return !!(gfp_flags & __GFP_DIRECT_RECLAIM);
 37 }

#define GFP_NOFS        (__GFP_RECLAIM | __GFP_IO)

And I think the qgroup limit was exactly a spin lock over btrfs_path_alloc so
it did not help. An might_sleep() inside btrfs_path_alloc() is a very minimal
but reliable check we could add, the paths are used in many places so it would
increase the coverage.
