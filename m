Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D226AE4A6
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Mar 2023 16:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjCGP2D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Mar 2023 10:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjCGP1h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Mar 2023 10:27:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0BB3E62E
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Mar 2023 07:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678202667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49sjefw2FKulo5Vz5tQGPSxZQZKzbcJ05HQTQwuGmNA=;
        b=X19IFJGPk3l+C5Psr1I72T67Yxcr8Mvfksd21xHlQLwgW2mVq/MTmI2SRHpuGMUmX5IFza
        0Xm2fpBlMqCfDu1XPPfDtIECBGjovTndEn1EEkGVeCbIfNjaxOrQdfbxGaSvYG008JAFpq
        g92anXcJmRDu+fC8yRPfHQqVtsXjjn0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-UJH0YnOtOe6QHug4yLUELg-1; Tue, 07 Mar 2023 10:24:05 -0500
X-MC-Unique: UJH0YnOtOe6QHug4yLUELg-1
Received: by mail-pl1-f199.google.com with SMTP id p10-20020a170902e74a00b0019ec1acba17so3860784plf.0
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Mar 2023 07:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678202643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49sjefw2FKulo5Vz5tQGPSxZQZKzbcJ05HQTQwuGmNA=;
        b=2rhobOsKQFuK19b4i/kv4thPJ2MHiWUdfbE+6EEf3gwCz5oJdB1fq6RGHIT0zM7sZy
         NhP4BFRgCv2JA1M+8J6O0b7VaeQ2YRjLDslwZISKRh20WXlG8t27s9/2MtcZHrpCuP1v
         gZ0pXAdM4gUaewXz6507r2Qmhxr2Al9yjsUS5RwqwnKo3DjTYUZkQsDU+pAFJ8JOC4LN
         gKiSNoH60c9Cif6nlHi+UGkx8LxCe65sSSAsz+rMMjZlMCw8TclOQdxBes28H4PzA9T7
         CJEshVmY+9FWgwoiZIymA9DwgVfd2lbQaTJOio6F3lOzWFCbwlKUELqq1Y5h9J5TINhg
         jLbA==
X-Gm-Message-State: AO0yUKW51VwHkz1q6B7rPO2mSCGU7Btitn3ogF4tTihyK7vk0tBCYWeB
        +BRROXfJ3eYvAVUeKxQf94Ek4Hj0tbozsZOMw27ktQN1Ef9NZp2JjlqWjlhUxFvPj/52SC3itow
        AifdZQQ4I/74CY2/FB6SkUMPlfQV1IgsF7pXxItw=
X-Received: by 2002:a17:902:f812:b0:19a:f153:b73e with SMTP id ix18-20020a170902f81200b0019af153b73emr5668633plb.4.1678202642957;
        Tue, 07 Mar 2023 07:24:02 -0800 (PST)
X-Google-Smtp-Source: AK7set9SWy5O05m3x1Ey9TSLMznr1jfUxFnvxAX39KEBXqqmaUx44UhyFFrhNGEtwClSqvzd8jjgUVc0X6h/fPAWheE=
X-Received: by 2002:a17:902:f812:b0:19a:f153:b73e with SMTP id
 ix18-20020a170902f81200b0019af153b73emr5668618plb.4.1678202642668; Tue, 07
 Mar 2023 07:24:02 -0800 (PST)
MIME-Version: 1.0
References: <20230307143410.28031-1-hch@lst.de>
In-Reply-To: <20230307143410.28031-1-hch@lst.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 7 Mar 2023 16:23:50 +0100
Message-ID: <CAHc6FU4G5S+5S+1OdatY3apQvmDcvzOQSPPPQdQZTwMNjSq5tw@mail.gmail.com>
Subject: Re: [Cluster-devel] return an ERR_PTR from __filemap_get_folio v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, linux-xfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 7, 2023 at 4:07=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
> __filemap_get_folio and its wrappers can return NULL for three different
> conditions, which in some cases requires the caller to reverse engineer
> the decision making.  This is fixed by returning an ERR_PTR instead of
> NULL and thus transporting the reason for the failure.  But to make
> that work we first need to ensure that no xa_value special case is
> returned and thus return the FGP_ENTRY flag.  It turns out that flag
> is barely used and can usually be deal with in a better way.

Thanks for working on this cleanup; looking good at a first glance.

Andreas

