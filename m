Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101755E9163
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Sep 2022 09:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiIYHRx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Sep 2022 03:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiIYHRw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Sep 2022 03:17:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF69832EC2
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Sep 2022 00:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664090270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FnuW0+nquE7jeCs1wGd25t/HgD5sAtMc07QK9kih2sQ=;
        b=SZBL0yllgncMHQJjYqneGvfhQm2AeybNL8PYw1Bfent43/fRlxWvUxkC/D/nmTltqWC4Ni
        22qTmVCLexiT0Ag0Ho1YAYPfMzOY+P42y+y33CKftoPcY/OThEMaUdzmmOltw3hbApVM83
        asdnwLDr1xKa8tvz4sXNyRRhsXEeWiE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-265-53HslU__PbaxPEhFAk3Osw-1; Sun, 25 Sep 2022 03:17:48 -0400
X-MC-Unique: 53HslU__PbaxPEhFAk3Osw-1
Received: by mail-qt1-f197.google.com with SMTP id fe14-20020a05622a4d4e00b0035cc376b1d5so2700571qtb.4
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Sep 2022 00:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=FnuW0+nquE7jeCs1wGd25t/HgD5sAtMc07QK9kih2sQ=;
        b=XIk/21K8aOW+T4AdHqvEoPBg8UOa+Qco5za+N08f3Jqzo4d8+9BMtKOb/WKNxpvBd4
         iZlJmYnGMAw9Nap21uK4hl0Ex6YQ6EFFBPnrV8nlbKNOmG/EnMJfK7kQUxL/3+/DEA9B
         WwVoZg07VjVaob25TNfeABFgOvZ5y8ZBPQ4D/lQkFnANevz/OE8H41JMW0LnTFBIaFTV
         kjDhwlYw8GVxw7eyKc5xqdQRmsuc6lQDgPXRlkbHlTAqDS5eA/MrlUDJNIWPjxN0WaCo
         aP4/8hMwyWdh1J7lR04qvFrGMg8a/4Fu0A/rHnkafO4FL7JseuPmbpdBwbCpCg4ARlHD
         X0Hw==
X-Gm-Message-State: ACrzQf3BllEU2jN1OaxIRLrXDic9WFy1ZE/KFRKukxm+0s3hxIME8MPl
        Sl57FtaaPGXPw3OGpd+QAVY+EyX7YF0ffjIHrqa6YOnrF228LSFCNhP7JHW69au2kRlbTep6Xm0
        6bDpri24jB0zcBC+dQ8xYT1k=
X-Received: by 2002:a05:620a:c8f:b0:6cb:e329:b5b9 with SMTP id q15-20020a05620a0c8f00b006cbe329b5b9mr10667196qki.95.1664090268097;
        Sun, 25 Sep 2022 00:17:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4u6YF4dJIrwAN1QRZGgvTOpwH6qKYsc23O//LxYiiudu83+P6fv+LpA21i63RBBqqlayo//g==
X-Received: by 2002:a05:620a:c8f:b0:6cb:e329:b5b9 with SMTP id q15-20020a05620a0c8f00b006cbe329b5b9mr10667159qki.95.1664090267816;
        Sun, 25 Sep 2022 00:17:47 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-96.dyn.eolo.it. [146.241.97.96])
        by smtp.gmail.com with ESMTPSA id bp30-20020a05620a459e00b006c479acd82fsm10375465qkb.7.2022.09.25.00.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 00:17:47 -0700 (PDT)
Message-ID: <e340d993bce8e1b2742fba52ac6383771cfaddae.camel@redhat.com>
Subject: Re: [PATCH v2 04/16] skbuff: Phase out ksize() fallback for
 frag_size
From:   Paolo Abeni <pabeni@redhat.com>
To:     Kees Cook <keescook@chromium.org>, Vlastimil Babka <vbabka@suse.cz>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alex Elder <elder@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
Date:   Sun, 25 Sep 2022 09:17:40 +0200
In-Reply-To: <20220923202822.2667581-5-keescook@chromium.org>
References: <20220923202822.2667581-1-keescook@chromium.org>
         <20220923202822.2667581-5-keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 2022-09-23 at 13:28 -0700, Kees Cook wrote:
> All callers of APIs that allowed a 0-sized frag_size appear to be
> passing actual size information already

AFAICS, not yet:

drivers/net/ethernet/qlogic/qed/qed_ll2.c:
	skb = build_skb(buffer->data, 0); // -> __build_skb(..., 0) 
		// ->  __build_skb_around()

drivers/net/ethernet/broadcom/bnx2.c:
	skb = build_skb(data, 0);

I guess some more drivers have calls leading to 

	__build_skb_around(...,  0)

there are several call path to checks...


> , so this use of ksize() can
> be removed. However, just in case there is something still depending
> on this behavior, issue a WARN and fall back to as before to ksize()
> which means we'll also potentially get KASAN warnings.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  net/core/skbuff.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 0b30fbdbd0d0..84ca89c781cd 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -195,7 +195,11 @@ static void __build_skb_around(struct sk_buff *skb, void *data,
>  			       unsigned int frag_size)
>  {
>  	struct skb_shared_info *shinfo;
> -	unsigned int size = frag_size ? : ksize(data);
> +	unsigned int size = frag_size;
> +
> +	/* All callers should be setting frag size now? */
> +	if (WARN_ON_ONCE(size == 0))
> +		size = ksize(data);

At some point in the future, I guess we could even drop this check,
right?

Thanks!

Paolo

