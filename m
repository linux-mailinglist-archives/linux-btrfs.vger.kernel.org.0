Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565CA5601CF
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jun 2022 16:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiF2OAp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jun 2022 10:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiF2OAo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jun 2022 10:00:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF55722BFF
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 07:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656511238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f2HMdeTsOpHm9sZRS+HCad5LxmPJ37585281uvtRfvs=;
        b=HzR639FCYFo8Vr79+LEMzuMEMKEZWHfMbmRJGQmTNRTWE/bx7RjrnLOghvlhYGLE3n5qTu
        87ZYny/qnRAWSo7SPyANljUZfcIke0hzvK/1Ru8JSrInrrvfDjNlaJdErY02okwoK0zaca
        1ptfvBmsegy9ErQxZ5EpvCuWMUmC3Yg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-Zbltr29UM86L6g3gttFOcQ-1; Wed, 29 Jun 2022 10:00:37 -0400
X-MC-Unique: Zbltr29UM86L6g3gttFOcQ-1
Received: by mail-qk1-f197.google.com with SMTP id i124-20020a37b882000000b006af41a43f76so7064103qkf.6
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 07:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f2HMdeTsOpHm9sZRS+HCad5LxmPJ37585281uvtRfvs=;
        b=l2p95Ptc9zkO3mV/d55Ovc3emWtWemBhyBctJaqUFv/7dcGbLAn5SfE7QWSoGr1YSq
         wNhm2cmefrkhjW7MGzpFAaiqBNyl9ajs8fMjaQD6ADRKiyVg1HRNHqEgD50U7ho5njnt
         QYvwedd75AB4AzgBn+uvAy1q1E4EZuZHXvCqeKnXr6LLSPvGdmCL2zU9kVtG/xuMrfJN
         MtDWb/K3OCHWUpzM1uFEywSRC8ZzJiqWMc/gjHGTafb4RHPMKW4Vh9idUJe062u4JRFs
         qAf9PiYD3KwG43z16N1q02HMUxteW7yGz0+B1bpT4nQEGQLIwVPh246DQodCNWY7792z
         TU4w==
X-Gm-Message-State: AJIora/AcFhBpo0QX2kFxQF3asR5xXihr/RDvH76YYxkdxXfXpGjpmjG
        UvRIsBPPA28vR13MGK1MlcF29QaH3xzWG1SbeY+39H/tfJDs0/YtLWIEnVcP9Svib5e2s2EyMVo
        6lvia+eHUTAspwt5z/EKd3popPbYrvJmJMlwzx/x13ri+LjuRIc2DgqyubTmiCXSqi7YMkLI=
X-Received: by 2002:ad4:5dcd:0:b0:470:3909:fc4c with SMTP id m13-20020ad45dcd000000b004703909fc4cmr7813784qvh.87.1656511236465;
        Wed, 29 Jun 2022 07:00:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1usOyu3yMvnn48j1MkfYcDc0UP82OtqIkoCk8Oh1Fv3Z1mDYB9br3YBTwqnSGSmp5o3MeyG5A==
X-Received: by 2002:ad4:5dcd:0:b0:470:3909:fc4c with SMTP id m13-20020ad45dcd000000b004703909fc4cmr7813740qvh.87.1656511236032;
        Wed, 29 Jun 2022 07:00:36 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f30-20020ac840de000000b00315110b47bcsm10853878qtm.22.2022.06.29.07.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:00:35 -0700 (PDT)
Date:   Wed, 29 Jun 2022 22:00:30 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     linux-btrfs@vger.kernel.org
Cc:     fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: btrfs read repair: more tests
Message-ID: <20220629140030.gby6u6gih2dxfs7v@zlang-mailbox>
References: <20220622045844.3219390-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622045844.3219390-1-hch@lst.de>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 22, 2022 at 06:58:40AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds a few more btrfs read repair tests.  Still all for user
> data as I haven't managed to successfully inject corruption into metadata
> yet.

This patchset is good to me (from fstests side). If there's not more review
points or objections from btrfs list, I'll merge it. Welcome more review.

Thanks,
Zorro

> 

