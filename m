Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDCD7BE681
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 18:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377617AbjJIQf0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 12:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377299AbjJIQfY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 12:35:24 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC55199;
        Mon,  9 Oct 2023 09:35:22 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59f6492b415so40738947b3.0;
        Mon, 09 Oct 2023 09:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696869322; x=1697474122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RsC4B5mELowhLCBdNvaIf+LwPDrz+keu3BL55c6ZynM=;
        b=ExJqmyPw90udlhP9ASCiGzsxkcH1bmj/pFkmFimTNIWolKEOyNgnO/qXv0eV8+4R7z
         iqyUl0kMrGbZTYcKpIpF2g4heBKnctCerXdpJxAv8pjL494Ot2gkpHQViTCeZt86tzE9
         W4hN9db0w+WEJqet2eJSXwiT9Tjd65XtUkV1mRKRSDle/mRWSf913iGF3Rn3Yvi+exJp
         qip12KbjRfgwYzRYk2lqYO+TatV89d2eds7K85kBTUUA+YcDtN399zBxcMrWIbuUioi5
         KFhyVw03c4xGGOA5WL1icXbnIauewBLB4zy2LIQNlAXZQAlnDSsJcrQeYntJUnmjOWUg
         YeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696869322; x=1697474122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsC4B5mELowhLCBdNvaIf+LwPDrz+keu3BL55c6ZynM=;
        b=irDJwMC+muHoPJ4CKoWycFO9hnMoyOqEyVj4gDY7VkEGSJsf8c5xgs8l74R1AXGA3c
         vYT3zL1pWKuNIfLdoxsNyyKH0vKSdaUThADTgmAuuaOHPmKkqRogF+RlpB4m4nriCyab
         8/62Z//8MpIJuAsKC5RKXJE3xVNWOwpIPrUToR7TGTMwgoTse7u1eBs2zVJNwHQnGewI
         SWb4Xi1PvEjuwu0sJguetHVVB4BT9+beZ6HXfiyqBpbbqj/Tx7sZsN5yqQ5A9Xrnv54n
         U9Mc91SFhvnormMfrxoW+HUun5cH00QT1BFEFlTv6w7pQ6eLhdv/QSnjlQcKiG9ozqfK
         7qyQ==
X-Gm-Message-State: AOJu0YygAEwQd6Mq8M5bdikXutV1oggZzFDj2+gs8+lf7EYzUEg1NHDo
        dX4axM0iylMf5Kal1HLNP4U=
X-Google-Smtp-Source: AGHT+IFsvzJ6MeZI8r2v1L+4g/jHEVPfPdzddzGB/p3atEyZSUf9/4/r7GGX68WKl3pdJXGPfRRxWA==
X-Received: by 2002:a81:a1c2:0:b0:5a4:dde3:6db5 with SMTP id y185-20020a81a1c2000000b005a4dde36db5mr8226753ywg.10.1696869321805;
        Mon, 09 Oct 2023 09:35:21 -0700 (PDT)
Received: from localhost ([2607:fb90:be22:da0:a050:8c3a:c782:514b])
        by smtp.gmail.com with ESMTPSA id s7-20020a817707000000b005707fb5110bsm3798669ywc.58.2023.10.09.09.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:35:21 -0700 (PDT)
Date:   Mon, 9 Oct 2023 09:35:20 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Potapenko <glider@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-btrfs@vger.kernel.org,
        dm-devel@redhat.com, ntfs3@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/14] s390/cio: rename bitmap_size() ->
 idset_bitmap_size()
Message-ID: <ZSQryML6+uySSQ55@yury-ThinkPad>
References: <20231009151026.66145-1-aleksander.lobakin@intel.com>
 <20231009151026.66145-6-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009151026.66145-6-aleksander.lobakin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 09, 2023 at 05:10:17PM +0200, Alexander Lobakin wrote:
> bitmap_size() is a pretty generic name and one may want to use it for
> a generic bitmap API function. At the same time, its logic is not
> "generic", i.e. it's not just `nbits -> size of bitmap in bytes`
> converter as it would be expected from its name.
> Add the prefix 'idset_' used throughout the file where the function
> resides.

At the first glance, this custom implementation just duplicates the
generic one that you introduce in the following patch. If so, why
don't you switch idset to just use generic bitmap_size()?

> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
> idset_new() really wants its vmalloc() + memset() pair to be replaced
> with vzalloc().
> ---
>  drivers/s390/cio/idset.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/cio/idset.c b/drivers/s390/cio/idset.c
> index 45f9c0736be4..0a1105a483bf 100644
> --- a/drivers/s390/cio/idset.c
> +++ b/drivers/s390/cio/idset.c
> @@ -16,7 +16,7 @@ struct idset {
>  	unsigned long bitmap[];
>  };
>  
> -static inline unsigned long bitmap_size(int num_ssid, int num_id)
> +static inline unsigned long idset_bitmap_size(int num_ssid, int num_id)
>  {
>  	return BITS_TO_LONGS(num_ssid * num_id) * sizeof(unsigned long);
>  }
> @@ -25,11 +25,12 @@ static struct idset *idset_new(int num_ssid, int num_id)
>  {
>  	struct idset *set;
>  
> -	set = vmalloc(sizeof(struct idset) + bitmap_size(num_ssid, num_id));
> +	set = vmalloc(sizeof(struct idset) +
> +		      idset_bitmap_size(num_ssid, num_id));
>  	if (set) {
>  		set->num_ssid = num_ssid;
>  		set->num_id = num_id;
> -		memset(set->bitmap, 0, bitmap_size(num_ssid, num_id));
> +		memset(set->bitmap, 0, idset_bitmap_size(num_ssid, num_id));
>  	}
>  	return set;
>  }
> @@ -41,7 +42,8 @@ void idset_free(struct idset *set)
>  
>  void idset_fill(struct idset *set)
>  {
> -	memset(set->bitmap, 0xff, bitmap_size(set->num_ssid, set->num_id));
> +	memset(set->bitmap, 0xff,
> +	       idset_bitmap_size(set->num_ssid, set->num_id));
>  }
>  
>  static inline void idset_add(struct idset *set, int ssid, int id)
> -- 
> 2.41.0
