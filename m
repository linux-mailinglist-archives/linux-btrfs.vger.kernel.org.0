Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036F775F266
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 12:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjGXKNp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 06:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjGXKM5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 06:12:57 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B2F5FD1
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 03:05:17 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-77dcff76e35so49396839f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 03:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690193093; x=1690797893;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=am2eIoStEhYj6reS+R983QZxh6h3W0xYr71gNNToCQ8=;
        b=BeX1VwtxoiicjL+nYWC0EcSzOhCPVRlZDAMvoW4W0Ja6+qCHyo4b8l6ffQjrJalCKe
         3STheu1M0+XFFx6o+XO6CiJi8N4f+bhsqBc9z45swpf9UtQ/4WVRehcaic5IIpC6n9Ij
         te6iwZA5U6HeDSScF+y+lewu2Dx0+L+VqgkT/DZohweILkuaANkdiw+aGUIkshY7BgJi
         RxhP1vw+z9tkhwmfLq9CsO8YIzwuD+Pd34Y1o7vSDc3guHM4s9Ayz0lhEPUdP0eSTEZw
         noOO2gUJ3jHN1sQmfLSvYxhyXMMirrOw3NSs8fuAQ7t7S3NEnVtatenjpkydF6ScOZnb
         SNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690193093; x=1690797893;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=am2eIoStEhYj6reS+R983QZxh6h3W0xYr71gNNToCQ8=;
        b=OIvDZaM7PgEtOIvyMsz08HtGHvmssZZTWtNKUsqlqm+tMLsvg8+AgyEkfifkxOP+f2
         88tbvvIJljAsRWRX1Ajic0DlFW/enkG0hMvdZvaeQksgWg0C7OPkFrFG2AKQRoQ9aLrt
         E8B0tHbE9tc0RxjI5wv724zIp/LgF0h++qhU0/N3mGR3piI9Glk2iABwHjOcrf1F71eC
         qhZJccC5WeEGNcjUHmFYgSEcrvsBW6d3CM9QwcLJ/Y4Wv8doBO9C4MvKtKrP+FiWdJZB
         dmPrK3gL6TT1a58+LqF0dBZE1ZiTOfvqNfmSgQ31lGaXYNdbeWveS922mCT2yKPiDERE
         ISkg==
X-Gm-Message-State: ABy/qLYjBxPxMjfjG/HFFI9FdQoXR1IfGl7d5liD0Kl9tK3vCbQ5Gyvm
        A7DEdB8UqLKkRe1PDlaqopbyM9QbDbDXDJfwF6k=
X-Google-Smtp-Source: APBJJlEtnCzvJ6I1rkWEELadVXHfZtUE/plpWIuGp/MFKpOvTS509ssN84iHDxA1POdeL3+D21rKQg==
X-Received: by 2002:a05:6a20:8e04:b0:137:3941:17b3 with SMTP id y4-20020a056a208e0400b00137394117b3mr14532126pzj.6.1690192601020;
        Mon, 24 Jul 2023 02:56:41 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id y1-20020aa78541000000b00682aac1e2b8sm7356787pfn.60.2023.07.24.02.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 02:56:40 -0700 (PDT)
Message-ID: <7b4eb3fa-1ebd-de07-1a16-9533b069a66e@bytedance.com>
Date:   Mon, 24 Jul 2023 17:56:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 05/47] binder: dynamically allocate the android-binder
 shrinker
Content-Language: en-US
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-6-zhengqi.arch@bytedance.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230724094354.90817-6-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


This patch depends on the patch: 
https://lore.kernel.org/lkml/20230625154937.64316-1-qi.zheng@linux.dev/

